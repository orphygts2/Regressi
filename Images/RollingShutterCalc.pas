unit RollingShutterCalc;

interface

uses system.Types, vcl.graphics, windows, system.Classes, system.sysUtils,
     constreg, regutil, math, compile, maths;

const
   maxPoints = 5;
   maxVecteurVideo = 1024;
   pasCouleur = 16;
   resolutionCibleMin = 32;
   resolutionCibleMax = 6*pasCouleur;
   resolutionCible = 192;
   maxPixelCount = 32767;

type
  TCorrectionRS = class
      private
          FRSValue : double;
          FNbre : integer;
          FNPoints : integer;
          FHauteur,Flargeur : integer;
          FangleX : double;
          FEchelle : double;
          FSigneY : single;
          Farrondi : double;
          FincertXY : integer;
          FwithOrigine : boolean;
          FnomFichierVideo : string;
          FCorrigePosition : boolean;
          FCorrigeOrigineTemps : boolean;
          FTempsOrigine : double;
          procedure setEchelle(avalue : double);
          procedure setRSValue(avalue : double);
          procedure setTempsOrigine(avalue : double);
      public
      FX_RS, FY_RS : integer;
      XYc : array[0..maxPoints,0..MaxVecteurVideo] of TpointF;
      OrigineFixe : TpointF;
      XY : array[0..maxPoints,0..MaxVecteurVideo] of TpointF;
      Temps : array[0..MaxVecteurVideo] of double;
      TempsRS : array[0..maxPoints,0..MaxVecteurVideo] of double;  // Rolling Shutter
      procedure CalculRollingShutter(j0 : integer);
      procedure SauveData;
      procedure Reset;
      Function valeurXc(j,i : integer) : double;
      Function valeurYc(j,i : integer) : double;
      Function valeurTc(j,i : integer) : double;
      Function valeurX(j,i : integer) : double;
      Function valeurY(j,i : integer) : double;
      Function valeurT(i : integer) : double;
      Function StrX(j,i : integer) : String;
      Function StrY(j,i : integer) : String;
      Function StrT(i : integer) : String;
      procedure Interpole(jdebut,jfin,j0,index : integer);
      property RSvalue : double write setRSValue;
      property Nbre : integer write FNbre;
      property NPoints : integer write FNPoints;
      property hauteur : integer write FHauteur;
      property largeur : integer write FLargeur;
      property angleX : double write FangleX;
      property echelle : double write setEchelle;
      property incertXY : integer write FIncertXY;
      property signeY : single write FsigneY;
      property withOrigine : boolean write FwithOrigine;
      property corrigePosition : boolean write FcorrigePosition;
      property nomFichierVideo : string write FnomFichierVideo;
      property tOrigine : double read FTempsOrigine write setTempsOrigine;
      constructor create;
  end;
  tRGBTripleArray = array[0..maxPixelCount] of TRGBTriple;
  pRGBTripleArray = ^tRGBTripleArray;

var correctionRS : TCorrectionRS;

implementation

uses regmain, regdde;

const
   degreLissage = 2;
   ordre = degreLissage+1;
   puissMax = 2*degreLissage;

constructor TCorrectionRS.create;
begin
    FCorrigePosition := true;
    FCorrigeOrigineTemps := false;
    tOrigine := 0;
    FX_RS := 0;
    FY_RS := 1;
end;

procedure TCorrectionRS.reset;
begin
    FCorrigePosition := true;
    FCorrigeOrigineTemps := false;
    tOrigine := 0;
    FX_RS := 0;
    FY_RS := 1;
end;

procedure TCorrectionRS.interpole(jdebut,jfin,j0,index : integer);
var puissX,puissY : TvectorPuiss;
    Ax,Ay : Tmatrice;
    CoeffX,coeffY : TmatriceLigne;

procedure initXY;
var j : integer;
    locX,locY,locT,t : double;
    i : integer;
begin
    for i := 0 to puissMax do begin
        puissX[i] := 0;
        puissY[i] := 0;
    end;
    for i := 1 to ordre do begin
        Ax[i,ordre+1] := 0;
        Ay[i,ordre+1] := 0;
    end;
    for j := jdebut to jfin do begin
        t := tempsRS[index,j];
        locT := t;
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+locT;
            puissY[i] := puissY[i]+locT;
            locT := locT*t;
        end;
        locX := xy[index,j].x;
        locY := xy[index,j].y;
        for i := 1 to ordre do begin
            Ax[i,ordre+1] := Ax[i,ordre+1]+locX;
            Ay[i,ordre+1] := Ay[i,ordre+1]+locY;
            locX := locX*t;
            locY := locY*t;
        end;
        puissX[0] := puissX[0] + 1;
        puissY[0] := puissY[0] + 1;
    end;
    for i := 1 to ordre do
        for j := 1 to ordre do begin
            Ax[i,j] := PuissX[i+j-2];
            Ay[i,j] := PuissY[i+j-2];
        end;
end;

var t0 : double;
begin
    initXY;
    try
    maths.Resolution(Ax,ordre,Coeffx);
    maths.Resolution(Ay,ordre,Coeffy);
    t0 := tempsRS[1,j0];
    xyC[index,j0].x := coeffX[1]+t0*(coeffX[2]+coeffX[3]*t0);
    xyC[index,j0].y := coeffY[1]+t0*(coeffY[2]+coeffY[3]*t0);
    except
    xyC[index,j0] := xy[index,j0];
    end;
end; // Interpole

procedure TCorrectionRS.CalculRollingShutter(j0 : integer);
var i, j: integer;
begin
     if FRSValue=0 then begin
        for i := 0 to pred(FNbre) do
            for j := j0 to FNPoints do begin
                xyC[j,i] := xy[j,i];
                tempsRS[j,i] := temps[i]-temps[0];
            end;
     end
     else begin
         for i := 0 to pred(FNbre) do
            for j := j0 to FNPoints do
               tempsRS[j,i] := (temps[i]-temps[0])+
                   FY_RS*FRSValue*xy[j,i].y/Fhauteur+
                   FX_RS*FRSValue*xy[j,i].x/Flargeur; // 1000 ms
            for j := j0 to FNPoints do
                if j=1
                then begin // pour le 1, on garde le point et on change le temps
                    for i := 0 to pred(FNbre) do
                        xyC[1,i] := xy[1,i]; // passage Tpoint integer à TpointF single ?
                end
                else begin
                    interpole(0,2,0,j);
                    for i := 1 to (FNbre-2) do
                        interpole(i-1,i+1,i,j);
                    interpole(FNbre-3,FNbre-1,FNbre-1,j);
                end;
     end;
end;

function TCorrectionRS.valeurXc(j,i : integer) : double;
begin
    if j=0
       then result := xyC[0,i].x*cos(FangleX)-xyC[0,i].y*sin(-FangleX)
       else if FwithOrigine
          then result := (xyC[j,i].x-xyC[0,i].x)*cos(FangleX)-(xyC[j,i].y-xyC[0,i].y)*sin(-FangleX)
          else result := (xyC[j,i].x-origineFixe.x)*cos(FangleX)-(xyC[j,i].y-origineFixe.y)*sin(-FangleX);
    result := result * FEchelle;
end;

function TCorrectionRS.valeurYc(j,i : integer) : double;
begin
    if j=0
       then result := xyC[0,i].x*sin(-FangleX)+xyC[0,i].y*cos(FangleX)
       else if FwithOrigine
          then result := (xyC[j,i].x-xyC[0,i].x)*sin(-FangleX)+(xyC[j,i].y-xyC[0,i].y)*cos(FangleX)
          else result := (xyC[j,i].x-origineFixe.x)*sin(-FangleX)+(xyC[j,i].y-origineFixe.y)*cos(FangleX);
    result := result * FEchelle * FsigneY;
end;

function TCorrectionRS.valeurTc(j,i : integer) : double;
begin
    if FCorrigeOrigineTemps
       then result := temps[i]-tOrigine
       else result := temps[i]-temps[0];
    if FRSValue<>0 then result := result + FRSValue*(
            FY_RS*xy[j,i].y/Fhauteur+
            FX_RS*xy[j,i].x/Flargeur);
end;

function TCorrectionRS.valeurX(j,i : integer) : double;
begin
    if j=0
       then result := xy[0,i].x*cos(FangleX)-xy[0,i].y*sin(-FangleX)
       else if FwithOrigine
          then result := (xy[j,i].x-xy[0,i].x)*cos(FangleX)-(xy[j,i].y-xy[0,i].y)*sin(-FangleX)
          else result := (xy[j,i].x-origineFixe.x)*cos(FangleX)-(xy[j,i].y-origineFixe.y)*sin(-FangleX);
    result := result * FEchelle;
end;

function TCorrectionRS.valeurY(j,i : integer) : double;
begin
    if j=0
       then result := xy[0,i].x*sin(-FangleX)+xy[0,i].y*cos(FangleX)
       else if FwithOrigine
          then result := (xy[j,i].x-xy[0,i].x)*sin(-FangleX)+(xy[j,i].y-xy[0,i].y)*cos(FangleX)
          else result := (xy[j,i].x-origineFixe.x)*sin(-FangleX)+(xy[j,i].y-origineFixe.y)*cos(FangleX);
    result := result * FEchelle * FsigneY;
end;

function TCorrectionRS.valeurT(i : integer) : double;
begin
    if FCorrigeOrigineTemps
       then result := temps[i]-tOrigine
       else result := temps[i]-temps[0];
end;

Function TCorrectionRS.StrX(j,i : integer) : String;
begin
   result := floatToStrPoint(FArrondi*round(valeurX(j,i)/FArrondi))
end;

Function TCorrectionRS.StrY(j,i : integer) : String;
begin
   result := floatToStrPoint(FArrondi*round(valeurY(j,i)/FArrondi))
end;

Function TCorrectionRS.StrT(i : integer) : String;
begin
   result := floatToStrF(valeurT(i),ffFixed,5,3)
end;

procedure TCorrectionRS.setEchelle(avalue : double);
begin
       Fechelle := avalue;
       FArrondi := power(10,floor(log10(abs(FEchelle))));
end;

procedure TCorrectionRS.setTempsOrigine(avalue : double);
begin
    FTempsOrigine := aValue;
    FCorrigeOrigineTemps := true;
end;

procedure TCorrectionRS.setRSValue(avalue : double);
begin
    FRSValue := aValue/1000; // 1000 ms
end;

procedure TcorrectionRS.SauveData;
var j0 : integer;
    incertTemps,incertPos : string;

Procedure AjouteOptionGr;
var j : integer;
begin
     FormDDE.donnees.add(SymbReg2+intToStr(FNPoints)+' NOMX');
     if FNPoints=1
        then FormDDE.donnees.add('x')
        else for j := 1 to FNPoints do FormDDE.donnees.add('x'+intToStr(j));
     FormDDE.donnees.add(SymbReg2+intToStr(FNPoints)+' NOMY');
     if FNPoints=1
        then FormDDE.donnees.add('y')
        else for j := 1 to FNPoints do FormDDE.donnees.add('y'+intToStr(j));
     FormDDE.donnees.add(SymbReg2+'1 ORTHO');
     FormDDE.donnees.add('1');
     FormDDE.donnees.add(SymbReg2+'1 FICHIER');
     FormDDE.donnees.add(FnomFichierVideo);
end;

procedure SauveTemps;
var i,j : integer;
    ligne : String;
begin
       Ligne := '';
       for j := j0 to FNPoints do
           Ligne := Ligne+'t'+intToStr(j)+crTab+
                          'x'+intToStr(j)+crTab+
                          'y'+intToStr(j)+crTab;
       for j := j0 to FNPoints do
           Ligne := Ligne+'xC'+intToStr(j)+crTab+
                          'yC'+intToStr(j)+crTab;
       delete(ligne,length(ligne),1);
       FormDDE.donnees.add(Ligne);
       Ligne := '';
       for j := j0 to FNPoints do
           Ligne := Ligne+'s'+crTab+'m'+crTab+'m'+crTab;
       for j := j0 to FNPoints do
           Ligne := Ligne+'m'+intToStr(j)+crTab+
                          'm'+intToStr(j)+crTab;
       delete(ligne,length(ligne),1);
       FormDDE.donnees.add(ligne);
       Ligne := '';
       for j := j0 to FNPoints do
           Ligne := Ligne+'Temps corrigé'+crTab+stAbscisse+crTab+stOrdonnee+crTab;
       for j := j0 to FNPoints do
           Ligne := Ligne+'Abscisse corrigée'+crTab+'Ordonnée corrigée'+crTab;
       delete(ligne,length(ligne),1);
       FormDDE.donnees.add(ligne);
       for i := 0 to pred(FNbre) do begin
           ligne := '';
           for j := j0 to FNPoints do
               ligne := ligne+
                  floatToStrPoint(valeurTc(j,i))+crTab+
                  floatToStrPoint(valeurX(j,i))+crTab+
                  floatToStrPoint(valeurY(j,i))+crTab;
           for j := j0 to FNPoints do
               ligne := ligne+
                  floatToStrPoint(valeurXC(j,i))+crTab+
                  floatToStrPoint(valeurYC(j,i))+crTab;
           delete(ligne,length(ligne),1);
           FormDDE.donnees.add(ligne);
        end;
        if FIncertXY>0 then begin
              FormDDE.donnees.Add(symbReg2+IntToStr(FNbre)+' INCERT');
              for i := 0 to pred(FNbre) do begin
                 ligne := '';
                 for j := j0 to FNPoints do
                    ligne := ligne+incertTemps+crTab+IncertPos+crTab+IncertPos+crTab;
                 for j := j0 to FNPoints do
                    ligne := ligne+incertPos+crTab+incertPos+crTab;
                 delete(ligne,length(ligne),1);
                 FormDDE.donnees.Add(ligne);
             end;
        end;
end; // SauveTemps

procedure SauvePosition;
var i,j : integer;
    ligne : String;
begin
       Ligne := 't';
       if FNpoints=1
        then begin
           if FWithOrigine then
              Ligne := Ligne+crTab+'xO'+crTab+'yO';
           Ligne := Ligne+crTab+'x'+crTab+'y';
        end
        else for j := j0 to FNPoints do
           Ligne := Ligne+crTab+'x'+intToStr(j)+
                          crTab+'y'+intToStr(j);
       FormDDE.donnees.add(Ligne);
       Ligne := 's';
       for j := j0 to FNPoints do
           Ligne := Ligne+crTab+'m'+crTab+'m';
       FormDDE.donnees.add(Ligne);
       Ligne := stTemps;
       if FWithOrigine then
          Ligne := Ligne+crTab+'Abscisse origine/caméra'+crTab+'Ordonnée origine/caméra';
       for j := 1 to FNPoints do
          Ligne := Ligne+crTab+stAbscisse+crTab+stOrdonnee;
       FormDDE.donnees.add(Ligne);
       for i := 0 to pred(FNbre) do begin
           ligne := floatToStrPoint(valeurTc(1,i));
           for j := j0 to FNpoints do
               ligne := ligne+
                  crTab+floatToStrPoint(valeurXc(j,i))+
                  crTab+floatToStrPoint(valeurYc(j,i));
           FormDDE.donnees.add(ligne);
        end;
        if FIncertXY>0 then begin
              FormDDE.donnees.Add(symbReg2+IntToStr(FNbre)+' INCERT');
              for i := 0 to pred(FNbre) do begin
                 ligne := incertTemps;
                 for j := j0 to FNPoints do
                    ligne := ligne+crTab+incertPos+crTab+incertPos;
                 FormDDE.donnees.Add(ligne);
             end;
        end;
end; // SauvePosition

begin // SauveData
       FormDDE.donnees.Clear;
       FormDDE.donnees.add('');
       if FwithOrigine
          then j0 := 0
          else j0 := 1;
       calculRollingShutter(j0);
       incertTemps := floatToStrPoint((temps[1]-temps[0])/100);
       incertPos := floatToStrPoint(FIncertXY*abs(FEchelle));
       if FcorrigePosition or ((FNPoints=1) and not FwithOrigine)
           then sauvePosition
           else sauveTemps;
       AjouteOptionGr;
       if pageCourante=0
         then with FregressiMain do begin
             grandeursOpen;
             grapheOpen;
             if FormDDE.ImporteDonnees then begin
                ModifConfigAcq := SaveConfigAcq;
                FocusAcquisitionBtn.visible := true;
             end
         end
         else FormDDE.AjouteDonnees;
       modeAcquisition := acqVideo;
end; // SauveData

initialization
{$IFDEF Debug}
   ecritDebug('initialization rollingShutter');
{$ENDIF}
     correctionRS := TCorrectionRS.create;
finalization
     correctionRS.free;
end.
