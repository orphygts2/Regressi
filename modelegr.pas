unit modeleGr; // Modélisation graphique

interface

uses sysutils,classes,graphics,math,
     constreg,maths,regutil,fft,uniteker,
     compile,graphker,valeurs,statcalc;

type
    TgenreModeleGr = (mgAffine,mgParabolique,mgSinus,mgSinusAmorti,   // 0..3
                   mgEchelon,mgPuissance,mgSinusDiverge,mgRadio,  // 4..7
                   mgManuel,mgQualite,       // 8..9
                   mgPasseBas1,mgPasseHaut1,mgPasseBande,mgPasseBas2,mgPasseHaut2, // 10..14
                   mgHyperbolique,mgLineaire,mgSigmoide, //15..17
                   mgGauss,mgLorentz,  //18..19
                   mgAffineDouble,mgLogistique,mgDoubleExponentielle); // 20..22

(*
  Acide faible-Base forte
    pH(v)=if(v<ve,pB-log((ve-v)/(v+v0)),pB-log((v-ve)/(v+v0)))
  Acide fort-Base forte
    pH(v)=if(v<ve,pKa+log(v/(ve-v)),pB-log((ve-v)/(v+v0)))
  Filtre Coupe-bande
    G(f)=G0/abs(1+j*f/f0)
  Passe-bas ordre 2
    G(f)=G0/abs(1+j*2*m*f/f0-f*f/f0/f0)
  Passe-haut ordre 2
    G(f)=G0*f*f/f0/f0/abs(1+j*2*m*f/f0-f*f/f0/f0)
*)

    TmodeleGr = class
         Expression : TstringList;
         Genre : TgenreModeleGr;
         Graphe : TgrapheReg;
         Xi,Yi : array[1..4] of Integer;
         Xs,Ys : array[1..4] of double;
         modeleOK : boolean;
         parametreGr : TmatriceLigne;
         mondeGr : TindiceMonde;
         numeroModele : integer;
         nX,nY : string;
         nomParam : array[1..5] of string;
         couleur : Tcolor;
         tOrigine : double;
         Constructor Create;
         Destructor Destroy;override;
         Procedure Init(Agenre : TgenreModeleGr;Agraphe : TgrapheReg;
                        Numero,indiceCoord : integer);
         Procedure InitialiseParametre(var debut,fin : integer;var t0 : double;changeDebutDemande : boolean);
         Procedure AffecteTout;
         Procedure AffecteUnPoint(index : integer;X,Y : integer);
         Procedure GetParametres(var p : tableauParam);
         Procedure SetParametres(var p : tableauParam);
         Procedure GetParamGlb;
         Procedure SetParamGlb;
         Function GetIndex(x,y : integer) : integer;
         Procedure dessineUnPoint(index : integer);
         Procedure dessineTout;
         Function GetHint(index : integer) : string;
         Procedure store;
         Procedure load;
    end;

var
    modeleGraphique,modeleParametre : array[TcodeIntervalle] of TmodeleGr;

const
    indexPointMax : array[tgenreModeleGr] of integer =(2,3,2,3,1,2,3,1,0,3,
                         1,1,2,2,2,
                         2,1,2,2,2,4,2,2);

implementation

const
    NbreParamMagnum : array[tgenreModeleGr] of integer =(2,3,4,5,2,2,5,2,0,5,
                      2,2,3,3,3,
                      2,1,4,3,3,4,3,3);
    coeffPenteSig = 2;
    NomSinus : array[boolean] of string = ('sin','cos');

procedure TmodeleGr.Init(Agenre : TgenreModeleGr;Agraphe : TgrapheReg;
                         numero,indiceCoord : integer);
const UnTour : array[boolean] of string = ('2*'+piMin,'360');
   //   UnDemiTour : array[boolean] of string = (piMin,'180');

Function getNom(const NomDefaut : string) : string;
var index : integer;
begin
    result := NomDefaut;
    index :=  indexNom(NomDefaut);
// vérifier si une variable de même nom existe
    if (index<MaxGrandeurs) or
       (indexToParam(paramNormal,index)<>grandeurInconnue) or
       (indexToParam(paramGlb,index)<>grandeurInconnue)
        then begin
           result := result + intToStr(numero);
           index :=  indexNom(result);
           if (index<MaxGrandeurs) or
              (indexToParam(paramNormal,index)<>grandeurInconnue) or
              (indexToParam(paramGlb,index)<>grandeurInconnue)
            then result := result + intToStr(numero);
       end;     
end;

var expr,debutExp,exp1,exp2,exp3,expEch : string;
    j : integer;
begin
     graphe := Agraphe;
     if indiceCoord>graphe.NbreOrdonnee then indiceCoord := 1;
     genre := Agenre;
     numeroModele := numero;
     if (numeroModele<1) or (numeroModele<MaxIntervalles) then numeroModele := 1; 
     with graphe.Coordonnee[indiceCoord] do begin
          mondeGr := iMondeC;
          nX := nomX;
          nY := NomY;
     end;
//     debutExp := nY+'('+nX+')=';
     debutExp := nY+'=';
     expEch := '';
     for j := 1 to 3 do nomParam[j] := '';
     NomParam[5] := getNom(tau);
     NomParam[4] := getNom(phiMin);
     if genre in [mgPasseBas1,mgPasseHaut1,mgPasseBande,
                  mgPasseBas2,mgPasseHaut2]
          then begin
             NomParam[2] := getNom(nX+'0');
             NomParam[1] := getNom('G0');
          end
          else begin
             NomParam[1] := getNom('a');
             NomParam[2] := getNom('b');
          end;
     if genre in [mgPasseBas2,mgPasseHaut2,mgPasseBande]
          then begin
              exp2 := '('+nX+'/'+NomParam[2]+')^2';
              if ModeleFacteurQualite
                 then begin
                     NomParam[3] := 'Q';
                     exp3 := 'abs(1+j*'+nX+'/'+NomParam[2]+'/'+NomParam[3]+'-'+exp2+')';
                 end
                 else begin
                     NomParam[3] := 'm';
                     exp3 := 'abs(1+2*j*m*'+nX+'/'+NomParam[2]+'-'+exp2+')';
                 end;
          end
          else if genre=mgQualite
                 then NomParam[3] := getNom(omegaMin+'0')
                 else NomParam[3] := getNom('c');
     if genre in [mgPasseBas1,mgPasseHaut1]
        then exp1 := 'abs(1+j*'+nX+'/'+NomParam[2]+')';
     if genre=mgAffineDouble then begin
         NomParam[3] := getNom('a');
         NomParam[4] := getNom('b');
     end;
     case genre of
          mgLineaire : expr:=debutExp+NomParam[1]+'*'+nX; // a*x
          mgAffine,mgAffineDouble : expr:=debutExp+NomParam[1]+'*'+nX+'+'+NomParam[2];
            // a*x+b
          mgPuissance : expr:=debutExp+NomParam[1]+'*'+nX+'^'+NomParam[2];
            // a*x^b
          mgParabolique : expr:=debutExp+NomParam[1]+'+'+NomParam[2]+
              '*'+nX+'+'+NomParam[3]+'*'+nX+'^2';
            // a*x^2+b*x+c
          mgHyperbolique : begin // a*x/(b+x) = Vm.[S]/(KM+[S])
             NomParam[2] := 'KM';
             NomParam[1] := 'Vm';
             expr:=debutExp+'Vm*'+nX+'/(KM+'+nX+')';
          end;
          mgSinus,mgSinusAmorti,mgSinusDiverge : begin
              NomParam[3] := 'T';
              expr:=debutExp+NomParam[1]+'+'+NomParam[2]+'*'+
                  nomSinus[modeleCosinus]+'('+UnTour[angleEnDegre]+
                      '*'+nX+'/'+nomParam[3]+'+'+NomParam[4]+')';
              // c+y0*sin(2*pi*t/T+phi)
              if genre<>mgSinus then begin
                 expr:=expr+'*exp(';
                 if genre=mgSinusAmorti then expr:=expr+'-';
                 expr:=expr+nX+'/'+NomParam[5]+')'; // *exp(-t/tau)
              end;
          end;
          mgQualite : begin
              // c+y0*sin(w0*rac(1-k*k)*t+phi)*exp(-k*w0*t)
              // ne marche qu'en radian !
              Fvaleurs.passageEnRadian(true);
              NomParam[5] := NomParam[4]; // phi
              NomParam[4] := lambdaMin; // k
              expr:=debutExp+NomParam[1]+'+'+NomParam[2]+'*'+
                    nomSinus[modeleCosinus]+'('+NomParam[3]+'*'+nX+
                    '*sqrt(1-'+nomParam[4]+'^2)+'+nomParam[5]+')';
              expr:=expr+'*exp(-'+nomParam[4]+'*'+nomParam[3]+'*'+nX+')';
          end;
          mgSigmoide : begin
              NomParam[1] := nY+'min'; // Ymin
              NomParam[2] := nY+'max'; // Ymax
              NomParam[3] := nX+'0'; // Xdemi
              NomParam[4] := getNom('b'); // exposant              
              expr:=debutExp+NomParam[1]+'+('+NomParam[2]+'-'+NomParam[1]+')/(1+('+nX+
                 '/'+nomParam[3]+')^'+nomParam[4]+')';
          end;
          mgGauss : begin
              NomParam[3] := getNom(sigmaMin); // ecart type
              NomParam[2] := nX+'0'; // moyenne
              NomParam[1] := getNom('A'); // coeff multiplicateur
              expr:=debutExp+NomParam[1]+'*exp(-(('+nX+'-'+NomParam[2]+')/'+NomParam[3]+')^2/2)';
          end;
          mgLorentz : begin
              NomParam[3] := getNom(gammaMaj); // largeur
              NomParam[2] := nX+'0'; // moyenne
              NomParam[1] := getNom('A'); // coeff multiplicateur
              expr:=debutExp+NomParam[1]+'/(('+nX+'-'+NomParam[2]+')^2+('+NomParam[3]+'/2)^2)';
          end;
          mgEchelon : begin
               // a+b*exp(-t/tau)
                expEch := debutExp+NomParam[1]+'+'+nomParam[2]+'*exp(-'+nX+'/'+NomParam[5]+'))';
               // a*(1-exp(-t/tau))
                expr:=debutExp+NomParam[1]+'*(1-exp(-'+nX+'/'+NomParam[5]+'))';
          end;
          mgRadio : begin // a*exp(-t/tau)
             nomParam[2] := nomParam[5];
             expr:=debutExp+NomParam[1]+'*exp(-'+nX+'/'+NomParam[2]+')';
          end;
          mgPasseBas1 : if ModeleDecibel
             then expr:=debutExp+NomParam[1]+'-20*log('+exp1+')'
              // a-20*log(abs(1+j*w/w0))
             else expr:=debutExp+NomParam[1]+'/'+exp1;
              // a/abs(1+j*w/w0)
          mgPasseHaut1 : if ModeleDecibel
            then expr:=debutExp+NomParam[1]+'+20*log('+nX+'/'+NomParam[2]+')-20*log('+exp1+')'
              // a +20*log(w/w0) -20*log(abs(1+j*w/w0))
            else expr:=debutExp+NomParam[1]+'*'+nX+'/'+NomParam[2]+'/'+exp1;
              // a*w/w0/abs(1+j*w/w0)
          mgPasseBas2 : if ModeleDecibel
            then expr:=debutExp+NomParam[1]+'-20*log('+exp3+')'
              // a-20*log(abs(1+j*2m*w/w0-(w/w0)^2))
            else expr:=debutExp+NomParam[1]+'/'+exp3;
             // G0/abs(1+j*2*m*f/f0-(f/f0)^2)
          mgPasseHaut2 : if ModeleDecibel
            then expr:=debutExp+NomParam[1]+'+40*log('+nX+'/'+NomParam[2]+')-20*log('+exp3+')'
             // a +40*log(w/w0) -20*log(abs(1+j*2m*w/w0-(w/w0)^2)))
            else expr:=debutExp+NomParam[1]+'*'+exp2+'/'+exp3;
             // G0*(f/f0)^2/abs(1+j*2*m*f/f0-(f/f0)^2)
          mgPasseBande : if ModeleFacteurQualite
             then if ModeleDecibel
                  then expr:=debutExp+NomParam[1]+'-20*log(abs(1+j*('+
                          nX+'/'+NomParam[2]+'-'+NomParam[2]+'/'+nX+')*Q))'
                        { a -20*log(abs(1+j*(w/w0-w0/w)*Q)) }
                  else expr:=debutExp+NomParam[1]+'/abs(1+j*('+
                    nX+'/'+NomParam[2]+'-'+NomParam[2]+'/'+nX+')*Q)'
                // a/abs(1+j*(w/w0-w0/w)*Q)
             else if ModeleDecibel
                  then expr:=debutExp+NomParam[1]+'-20*log(abs(1+j*('+
                            nX+'/'+NomParam[2]+'-'+NomParam[2]+'/'+nX+')/2/m))'
               // a -20*log(abs(1+j*(w/w0-w0/w)/2m))
                  else expr:=debutExp+NomParam[1]+'/abs(1+j*('+
                    nX+'/'+NomParam[2]+'-'+NomParam[2]+'/'+nX+')/2/m)';
                 // a/abs(1+j*(w/w0-w0/w)/2m)
          mgLogistique : begin
             NomParam[1] := nY+'0';
             NomParam[2] := nX+'m';
             NomParam[3] := DeltaMin+nX;
             expr:=debutExp+NomParam[1]+'/(1+exp(('+NomParam[2]+'-'+nX+')/'+NomParam[3]+'))';
          end;
          mgDoubleExponentielle : begin
             NomParam[1] := nY+'0';
             NomParam[2] := tau+'1';
             NomParam[3] := tau+'2';
             expr:=debutExp+NomParam[1]+'*(1+'+
                  'exp(-'+nX+'/'+NomParam[2]+')*'+NomParam[2]+'/('+NomParam[3]+'-'+NomParam[2]+')+'+
                  'exp(-'+nX+'/'+NomParam[3]+')*'+NomParam[3]+'/('+NomParam[2]+'-'+NomParam[3]+'))';
          end;
     end;
     Expression.clear;
     Expression.Add(expr);
     if expEch<>'' then Expression.Add(expEch);
     debutExp := nY+'('+nX+'):=';
     case genre of
          mgSinus : ;
          mgAffineDouble : begin
             expr:=debutExp+NomParam[3]+'*'+nX+'+'+NomParam[4];
            // a'*x+b'
          end;
          mgSigmoide : ;
          mgGauss : ;
          mgLorentz : ;
          mgSinusAmorti : begin
             expr := debutExp+NomParam[1]+'+'+NomParam[2]+
                 '*exp(-'+nX+'/'+NomParam[5]+')';
             Expression.Add(expr);
             expr := debutExp+NomParam[1]+'-'+NomParam[2]+
                 '*exp(-'+nX+'/'+NomParam[5]+')';
             Expression.Add(expr);
          end;
          mgQualite : begin
             expr := debutExp+NomParam[1]+'+'+NomParam[2]+
                  '*exp(-'+nomParam[4]+'*'+nomParam[3]+'*'+nX+')';
             Expression.Add(expr);
             expr := debutExp+NomParam[1]+'-'+NomParam[2]+
                 '*exp(-'+nomParam[4]+'*'+nomParam[3]+'*'+nX+')';
             Expression.Add(expr);
          end;
          mgSinusDiverge : begin
             expr := debutExp+NomParam[1]+'+'+NomParam[2]+
                 '*exp('+nX+'/'+NomParam[5]+')';
             Expression.Add(expr);
             expr := debutExp+NomParam[1]+'-'+NomParam[2]+
                 '*exp('+nX+'/'+NomParam[5]+')';
             Expression.Add(expr);
          end;
          mgEchelon : begin
                expr := debutExp+NomParam[1]; // a asymptote infini
                Expression.Add(expr);
                expr := debutExp+NomParam[1]+'*'+nX+'/'+NomParam[5]; // a*t/tau
                Expression.Add(expr);
                expr := debutExp+NomParam[1]+'+'+NomParam[2]+'*(1-'+nX+'/'+NomParam[5]+')';
                Expression.Add(expr);
          end;
          mgRadio : begin
             expr := debutExp+NomParam[1]+'*(1-'+nX+'/'+NomParam[2]+')';
             Expression.Add(expr);
          end;
          mgPasseBas1 : begin
             expr:=debutExp+NomParam[1];
             Expression.Add(expr);
             if ModeleDecibel
               then expr:=debutExp+NomParam[1]+'-20*log('+nX+'/'+NomParam[2]+')'
               else expr:=debutExp+NomParam[1]+'*'+NomParam[2]+'/'+nX;
             Expression.Add(expr);
          end;
          mgPasseHaut1 : begin
             expr:=debutExp+NomParam[1];
             Expression.Add(expr);
             if ModeleDecibel
                then expr:=debutExp+NomParam[1]+'+20*log('+nX+'/'+NomParam[2]+')'
                else expr:=debutExp+NomParam[1]+'*'+nX+'/'+NomParam[2];
             Expression.Add(expr);
          end;
          mgPasseBas2 : begin
             expr:=debutExp+NomParam[1];
             Expression.Add(expr);
             if ModeleDecibel
               then expr:=debutExp+NomParam[1]+'-40*log('+nX+'/'+NomParam[2]+')'
               else expr:=debutExp+NomParam[1]+'*('+NomParam[2]+'/'+nX+')^2';
             Expression.Add(expr);
          end;
          mgPasseHaut2 : begin
             expr:=debutExp+NomParam[1];
             Expression.Add(expr);
             if modeleDecibel
                then expr:=debutExp+NomParam[1]+'+40*log('+nX+'/'+NomParam[2]+')'
                else expr:=debutExp+NomParam[1]+'*('+nX+'/'+NomParam[2]+')^2';
             Expression.Add(expr);
          end;
          mgPasseBande : if ModeleDecibel
             then begin
             expr:=''''+debutExp+NomParam[1]+'-20*log('+nX+'/'+NomParam[2]+
                 '*'+NomParam[3]+')';
             Expression.Add(expr);
             expr:=''''+debutExp+NomParam[1]+'+20*log('+nX+'/'+NomParam[2]+
                  '/'+NomParam[3]+')';
             Expression.Add(expr);
             end
             else begin
             expr:=''''+debutExp+NomParam[1]+'*'+NomParam[2]+'/'+nX+'/'+NomParam[3];
             Expression.Add(expr);
             expr:=''''+debutExp+NomParam[1]+'*'+nX+'/'+NomParam[2]+'/'+NomParam[3];
             Expression.Add(expr);
          end;
    end;
end;

Procedure TmodeleGr.InitialiseParametre(var debut,fin : integer;var t0 : double;changeDebutDemande : boolean);
var minX,maxX,minY,maxY : double;
    i,Nbre,milieu,posMaxY,posMinY : integer;
    valeurX,valeurY : Tvecteur;
    indexX,indexY : integer;

Procedure InitialiseAffineDouble;
var statLoc : TStatistiqueDeuxVar;

Procedure Resoudre(i1,i2 : integer;var xs1,xs2 : double);
var systeme : Tmatrice;
    x,y : double;
    i,j : integer;
begin
    for i := 1 to 2 do
        for j := 1 to 3 do systeme[i,j] := 0;
    systeme[1,1] := (i2-i1)+1;
    maxX := valeurX[i1];
    minX := maxX;
    for i := i1 to i2 do begin
        x := valeurX[i];
        y := valeurY[i];
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+y*x;
        if valeurX[i]>maxX
           then maxX := valeurX[i]
           else if valeurX[i]<minX then minX := valeurX[i];
    end;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,parametreGr);
    swap(parametreGr[1],parametreGr[2]);
// a*x+b au lieu de a+b*x !
    xs1 := minX+(maxX-minX)/10;
    xs2 := maxX-(maxX-minX)/10;
end;

var fin1,debut2 : integer;
begin
   modeleOK := nbre>11;
   if not modeleOK then exit;
   statLoc := TStatistiqueDeuxVar.create;
   try
   fin1 := debut+1;
   repeat
         inc(fin1,2);
         statLoc.Init(valeurX,valeurY,debut,fin1);
   until (fin1>milieu) or (abs(statLoc.correlation)<0.95);
   resoudre(debut,fin1,xs[1],xs[2]);
   debut2 := fin-1;
   repeat
         dec(debut2,2);
         statLoc.Init(valeurX,valeurY,debut2,fin);
   until (debut2<milieu) or (abs(statLoc.correlation)<0.95);
   resoudre(debut2,fin,xs[3],xs[4]);
   finally
     statLoc.Free;
   end;
end;

Procedure InitialiseAffine;
var systeme : Tmatrice;
    x,y : double;
    i,j : integer;
begin
    for i := 1 to 2 do
        for j := 1 to 3 do systeme[i,j] := 0;
    systeme[1,1] := Nbre;
    for i := debut to fin do begin
        x := valeurX[i];
        y := valeurY[i];
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+y*x;
    end;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,parametreGr);
    swap(parametreGr[1],parametreGr[2]);
// a*x+b au lieu de a+b*x !
    xs[1] := minX+(maxX-minX)/10/numeroModele;
    xs[2] := maxX-(maxX-minX)/10/numeroModele;
    xs[3] := 0; xs[4] := 0;
end;

Procedure InitialiseLineaire;
var a : double;
    i,N : integer;
begin
    A := 0;
    N := 0;
    for i := debut to fin do begin
        if valeurX[i]<>0 then  begin
           try
           a := a+valeurY[i]/valeurX[i];
           inc(N);
           except
           end;
        end;
    end;
    parametreGr[1] := a/N;
    xs[1] := minX+2*(maxX-minX)/3;
    ys[1] := parametreGr[1]*xs[1];
    if (ys[1]>maxY) or (ys[1]<minY) then begin
        ys[1] := minY+2*(maxY-minY)/3;
        xs[1] := ys[1]/parametreGr[1];
    end;
    xs[2] := 0;
    xs[3] := 0;
end;

Procedure InitialiseHyperbolique;
var systeme : Tmatrice;
    x,y,a,b : double;
    i,j : integer;
// y=a*x/(b+x) linéarisé en 1/y = b/a*(1/x)+1/a=a2*x+a1
begin
    for i := 1 to 2 do
        for j := 1 to 3 do systeme[i,j] := 0;
    systeme[1,1] := Nbre;
    for i := debut to fin do begin
        try
        x := 1/valeurX[i];
        y := 1/valeurY[i];
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+x*y;
        except
        continue
        end;
    end;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,parametreGr);
    a := 1/parametreGr[1];
    b := parametreGr[2]*a;
    parametreGr[1] := a;
    parametreGr[2] := b;
    xs[1] := minX+(maxX-minX)/10;
    xs[2] := maxX-(maxX-minX)/10;
    xs[3] := 0;
end;

Procedure InitialisePuissance;
var systeme : Tmatrice;
    x,y : double;
    i,j : integer;
begin
    for i := 1 to 2 do
        for j := 1 to 3 do systeme[i,j] := 0;
    systeme[1,1] := Nbre;
    for i := debut to fin do begin
        try
        x := ln(valeurX[i]);
        y := ln(valeurY[i]);
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+y*x;
        except
        continue
        end;
    end;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,parametreGr);
    parametreGr[1] := exp(parametreGr[1]);
    xs[1] := minX+(maxX-minX)/10;
    xs[2] := maxX-(maxX-minX)/10;
end;

Procedure InitialiseParabolique;
var systeme : Tmatrice;
    loc : double;
    i,k : integer;
    puissX : TvectorPuiss;
begin
    for k := 1 to 4 do puissX[k] := 0;
    puissX[0] := Nbre;
    for k := 1 to 3 do systeme[k,4] := 0;
    for i := debut to fin do begin
        loc := valeurX[i];
        for k := 1 to 4 do begin
            puissX[k] := puissX[k]+loc;
            loc := loc*valeurX[i];
        end;
        loc := valeurY[i];
        for k := 1 to 3 do begin
            systeme[k,4] := systeme[k,4]+loc;
            loc := loc*valeurX[i];
        end;
    end;
    for k := 1 to 3 do
         for i := 1 to 3 do
             systeme[k,i] := PuissX[k+i-2];
    Resolution(systeme,3,parametreGr);
    xs[1] := minX+(maxX-minX)/10;
    xs[2] := maxX-(maxX-minX)/10;
    xs[3] := (maxX+minX)/2;
end;

Procedure InitialiseSinus;
var i,idebut : integer;
    Lpente,zero : double;
    y0,a,Lperiode,phase : double;
begin
    case genre of
       mgSinus : y0 := (maxY+minY)/2; // décalage de zéro
       mgSinusAmorti,mgQualite : begin
          y0 := 0;
          for i := debut to fin do
              y0 := y0+valeurY[i];
          y0 := y0/Nbre;
       end;
       else y0 := 0;
    end;
    a := (maxY-minY)/2; // amplitude
    i := debut;
    repeat inc(i)
    until ((valeurY[pred(i)]-y0)*(valeurY[succ(i)]-y0)<=0) or (i>Milieu);
    Lpente := valeurY[succ(i)]-valeurY[pred(i)];
// Passage par zéro à iDebut
    modeleOK := i<=Milieu;
    if not modeleOK then exit;
    iDebut := i;
    repeat inc(i)
    until (i>(fin-4)) or (abs(valeurY[i]-y0)>(a/3));
// Hystérésis
    repeat inc(i);
       zero := (valeurY[pred(i)]-y0)*(valeurY[succ(i)]-y0);
    until (zero<=0) or (i>=(fin-1));
// Deuxième passage par zéro
    modeleOK := zero<0;
    if not modeleOK then exit;
    LPeriode := 2*(valeurX[i]-valeurX[iDebut]);
    phase := frac(valeurX[iDebut]/Lperiode); // phase en tour
    if Lpente<0 then phase := phase+0.5;
    if modeleCosinus then phase := phase + 0.25;
    if phase<0.5
       then phase := -2*pi*phase
       else phase := 2*pi*(1-phase); // -pi<phase<+pi
    phase := AngleUtilisateur(phase); // degré/radian
    ParametreGr[1] := y0;
    ParametreGr[2] := a;
    ParametreGr[3] := Lperiode;
    ParametreGr[4] := phase;
end;

Procedure InitialiseSigmoide;
var signe,ref : double;
    N : integer;
    systeme : Tmatrice;
    i,j : integer;
    x,y : double;
    resultat : TmatriceLigne;
begin
    i := debut;
    ref := valeurY[debut]+(valeurY[fin]-valeurY[debut])/2;
    signe := valeurY[fin]-valeurY[debut];
    while (i<fin) and ((valeurY[i]-ref)*signe<0) do inc(i);
    parametreGr[1] := valeurY[debut];
    parametreGr[2] := valeurY[fin];
    parametreGr[3] := valeurX[i];
    ys[1] := parametreGr[1];
    ys[2] := parametreGr[2];
    ys[3] := (parametreGr[1]+parametreGr[2])/2;
// la dérivée en x=x0 vaut -(ymax-ymin)*b/(4*x0)
// soit b=pente*4*x0/(ymin-ymax)
    for i := 1 to 2 do
        for j := 1 to 3 do systeme[i,j] := 0;
    N := Nbre div 3;
    j := 0;
    for i := debut+N to fin-N do begin
        x := valeurX[i];
        y := valeurY[i];
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+y*x;
        inc(j);
    end;
    systeme[1,1] := j;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,resultat);
    parametreGr[4] := resultat[2]*4*parametreGr[3]/((parametreGr[1]-parametreGr[2]));
    xs[1] := parametreGr[3]+resultat[2]*(ys[1]-ys[3])*coeffPenteSig;
    xs[2] := parametreGr[3]+resultat[2]*(ys[2]-ys[3])*coeffPenteSig;
end;

Procedure InitialiseLogistique;
var signe,ref : double;
    i,j : integer;
begin
    i := debut;
    ref := (valeurY[debut]+valeurY[fin])/2;
    signe := valeurY[fin]-valeurY[debut];
    while (i<fin) and ((valeurY[i]-ref)*signe<0) do inc(i);
    if signe>0 then parametreGr[1] := valeurY[fin] else parametreGr[1] := valeurY[debut];
    parametreGr[2] := valeurX[i];
    if signe>0
       then ref := 0.731*parametreGr[1] // e/(1+e)
       else ref := 0.269*parametreGr[1];
    while (i<fin) and ((valeurY[i]-ref)*signe<0) do inc(i);
    j := i;
    if signe>0
      then ref := 0.269*parametreGr[1] // 1/(1+e)
      else ref := 0.731*parametreGr[1];
    while (i>debut) and ((valeurY[i]-ref)*signe>0) do dec(i);
    parametreGr[3] := (valeurX[j]-valeurX[i])/2;
    ys[1] := parametreGr[1]/2;
    xs[1] := parametreGr[2];
    xs[2] := parametreGr[2]+parametreGr[3];
    ys[2] := parametreGr[1]*0.731;
end;

Procedure InitialiseDoubleExp;
var signe : double;
    N,i : integer;
    X,Y,Yder : Tvecteur;
    Lpente : double;
begin
    setLength(X,length(valeurX));
    setLength(Y,length(valeurY));
    setLength(Yder,length(valeurX));
    for i := debut to fin do begin
        X[i-debut] := valeurX[i];
        Y[i-debut] := valeurY[i];
    end;
    N := fin-debut+1;
    DeriveeSecondeGauss(X,Y,N,Yder,2,5);
    signe := Y[N-1]-Y[0];
    if signe>0 then parametreGr[1] := Y[N-1] else parametreGr[1] := Y[0];
    i := 0;
    while (i<N) and (Yder[i]*signe>0) do inc(i);
    Lpente :=  DeriveePonctuelle(X,Y,i,N,2,5);
    parametreGr[2] := Y[i]/Lpente;
    parametreGr[3] := (parametreGr[1]-Y[i])/Lpente;
    // faux mais en gros ...
    // valeur(inflexion) = kappa*(0,265-0,0135*(alpha-1))
    ys[1] := parametreGr[1];
    xs[1] := parametreGr[2];
    xs[2] := parametreGr[3];
    ys[2] := parametreGr[1];
end;

Procedure InitialiseSinusAmorti;
var i1,i2 : integer;
    xs2,dYavant,dYapres,phase,t2 : double;
begin
   initialiseSinus;
   if not modeleOK then exit;
   i1 := debut;
   repeat
      inc(i1);
      dYavant := valeurY[i1]-valeurY[pred(i1)];
      dYapres := valeurY[succ(i1)]-valeurY[i1];
   until (i1=fin-3) or (dYavant*dYapres<=0);
   i2 := i1;
   t2 := valeurX[i1]+parametreGr[3]/2;
   repeat
      inc(i2)
   until (i2=fin-2) or (valeurX[i2]>t2);
   repeat
      inc(i2);
      dYavant := valeurY[i2]-valeurY[pred(i2)];
      dYapres := valeurY[succ(i2)]-valeurY[i2];
   until (i2=fin-1) or (dYavant*dYapres<=0);
   parametreGr[5] := (valeurX[i2]-valeurX[i1])/ln(
           abs((valeurY[i1]-parametreGr[1])/(valeurY[i2]-parametreGr[1])));
 // 5=constante de temps
   if AngleEnDegre
      then xs2 := 180
      else xs2 := pi;
   xs2 := parametreGr[3]*(1/4-parametreGr[4]/2/xs2);
   parametreGr[2] := parametreGr[2]*exp(xs2/parametreGr[5]);
   if genre=mgQualite then begin
// Lperiode=3 phase=4 tau=5 donne pulsation=3 lambda=4 phase=5 //
      phase := parametreGr[4];
      parametreGr[3] := 2*pi/parametreGr[3];
// passage de période à pulsation : omega0=2pi/periode
      parametreGr[3] := AngleUtilisateur(parametreGr[3]); // degré/radian
      parametreGr[4] := 1/parametreGr[3]/parametreGr[5];
// passage de constante de temps au facteur d'amortissement 1/tau=lambda*omega0
      parametreGr[5] := phase;
   end;
end;

Procedure InitialiseSinusDiverge;
var zero : double;
    NbrePeriode,NbreParPeriode : integer;

Procedure MaxLocal(aDebut,aFin : integer;var t,m : double);
var i : integer;
    v : double;
begin
    m := abs(valeurY[adebut]-zero);
    t := valeurX[adebut];
    for i := succ(adebut) to afin do begin
        v := abs(valeurY[i]-zero);
        if v>m then begin
           m := v;
           t := valeurX[i];
        end;
    end;
end;

Procedure CherchePeriodeFFT;
var NbreFFT,i : integer;
    PeriodeFFT : double;
    F,Vphase,Vampl : Tvecteur;
    Xr,Xi,Xa : Tvecteur;
    Lperiode,phase : double;
    NbreMax : integer;
begin
    NbreMax := Puiss2Sup(fin);
    setLength(F,NbreMax+1);
    setLength(Xa,NbreMax+1);
    setLength(Vphase,NbreMax+1);
    setLength(Vampl,NbreMax+1);
    setLength(Xr,NbreMax+1);
    setLength(Xi,NbreMax+1);
    Fourier(Debut,Fin,NbreMax,NbreFFT,PeriodeFFT,
          valeurX,valeurY,F,Vampl,Vphase,
          Xr,Xi,Xa,c_spectre);
    SpectrePhase(Vphase,Xr,Xi,NbreFFT);
    i := getFondamental(NbreFFT,Xa);
    LPeriode := 1/F[i];
    Phase := Vphase[i];
    ParametreGr[3] := Lperiode;
    ParametreGr[4] := phase;
    F := nil;
    finalize(Vampl);
    finalize(Vphase);
    finalize(Xr);
    finalize(Xi);
end;

Procedure CherchePeriodeSinus;
var i,idebut : integer;
    Lpente,y0,ampl,Lperiode,phase : double;
begin
    y0 := 0;
    for i := debut to fin do
        y0 := y0+valeurY[i];
    y0 := y0/Nbre;
    ampl := (maxY-minY)/2;// amplitude
    i := fin;
    repeat dec(i)
    until ((valeurY[pred(i)]-y0)*(valeurY[succ(i)]-y0)<=0) or
           (i<=Milieu);
    modeleOK := i>Milieu;
    if not modeleOK then exit;
    iDebut := i;
    while (i<Nbre) and (abs(valeurY[i]-y0)<(ampl/2)) do dec(i);
//  Passage par maxi
    modeleOK := i>debut+3;
    if not modeleOK then exit;
    repeat dec(i)
    until ((valeurY[pred(i)]-y0)*(valeurY[succ(i)]-y0)<=0) or
           (i=debut);
    modeleOK := i>debut;
    if not modeleOK then exit;
    LPeriode := 2*abs(valeurX[i]-valeurX[idebut]);
    i := fin;
    repeat
      dec(i);
      zero := (y0-valeurY[pred(i)])*(y0-valeurY[succ(i)]);
      Lpente := valeurY[succ(i)]-valeurY[pred(i)];
    until ( (zero<0) and (Lpente>0) ) or (i=debut+2);
         // premier passage par zéro montant ou non trouvé 
    modeleOK := i>2;
    if not modeleOK then exit;
    phase := frac(valeurX[i]/Lperiode); // phase en tour
    phase := -2*pi*phase;// -2.pi<phase<0
    phase := AngleUtilisateur(phase);// degré/radian
    ParametreGr[1] := y0;
    ParametreGr[2] := ampl;
    ParametreGr[3] := Lperiode;
    ParametreGr[4] := phase;
    NbrePeriode := round((valeurX[fin]-valeurX[debut])/Lperiode);
    NbreParPeriode := Nbre div NbrePeriode;
    if NbreParPeriode<16 then CherchePeriodeFFT;
end;

var t1,v1,t2,v2 : double;
    N : integer;
begin
   CherchePeriodeSinus;
   if not modeleOK then exit;
   if NbrePeriode>12
      then begin
         N := Nbre div 6;
         MaxLocal(4*N,5*N,t1,v1);
 // Pas la fin saturation possible
 // On laisse de côté le milieu de 2N à 4N
         MaxLocal(N,2*N,t2,v2);
 // Pas le début bruit
      end
      else begin
         N := NbreParPeriode div 2;
         MaxLocal(milieu+N,fin-N,t1,v1);
    // Pas la fin saturation possible
         MaxLocal(debut+N,milieu-N,t2,v2);
         { Pas le début bruit }
      end;
   parametreGr[5] := (t2-t1)*ln(v2/v1);
   parametreGr[2] := v1*exp(-t1/parametreGr[5]);
end; // InitialiseSinusDiverge

(*
Procedure InitialiseEchelon;
var ref : double;
    i : integer;
    ecart : double;
begin
     if changeDebutDemande then begin // préacquisition éventuelle
        ecart := abs(valeurY[fin]-valeurY[debut])/(fin-debut);
        while (debut<fin-2) and (abs(valeurY[debut+1])<ecart) do inc(debut);
     end;
     if abs(valeurY[debut])>abs(valeurY[fin]) then begin
        modeleOK := false;
        exit;
     end;
     if abs(minY) > abs(maxY)
         then ParametreGr[1] := minY
         else ParametreGr[1] := maxY;
     i := debut;
     ref := abs(parametreGr[1]*(1-exp(-1)));
     repeat inc(i)
     until (i=fin) or (abs(valeurY[i])>ref);
     ParametreGr[2] := valeurX[i]-valeurX[debut];
end;  // InitialiseEchelon
*)

Procedure InitialiseEchelon;
var ref,init : double;
    i,i0,imax : integer;
    ecart : double;
begin
     if changeDebutDemande then begin // préacquisition éventuelle
        ecart := abs(valeurY[fin]-valeurY[debut])/(fin-debut)*5; // données sur 5 tau
        ref := valeurY[debut];
        i0 := debut;
        imax := (debut+fin) div 2;
        while (debut<imax) and (abs(valeurY[debut+1]-ref)<ecart) do inc(debut);
        if debut>i0 then dec(debut);
     end;
     if posMinY<posMaxy  // on monte
        then begin
           ParametreGr[1] := maxY;  //a t->infini
           ParametreGr[2] := minY-maxY;  // t=0 (a+b)
        end
        else begin
           ParametreGr[1] := minY;
           ParametreGr[2] := maxY-minY;
        end;
     i := debut;
     ref := ParametreGr[1]+parametreGr[2]*exp(-1);
     init := valeurY[i]-ref;
     repeat inc(i)
     until (i=fin) or ((valeurY[i]-ref)*init<0);
     ParametreGr[3] := valeurX[i]-valeurX[debut];
     if abs(ParametreGr[1]+ParametreGr[2])<(abs(ParametreGr[1])+abs(ParametreGr[2]))/64
     then begin // a=-b soit a*(1-exp(-t/tau))
        nomParam[2] := nomParam[5]; // tau
        ParametreGr[2] :=  ParametreGr[3] ;
        expression.Delete(1);
        expression.Delete(3);
     end
     else begin   // a+b*exp(-t/tau)
        nomParam[3] := nomParam[5]; // tau
        expression.Delete(0);
        expression.Delete(2);
     end;
     tOrigine := valeurX[debut];
end;  // InitialiseEchelon

Procedure InitialiseRadio;
const PrecisionSuffisante = 0.05;
var a,a0 : double;
    i : integer;
    changeDebut : boolean;
    precisionModele : double;
    sommeCarreY : double;
    J,ecart : double;
    sauveDebut : integer;
begin
     if abs(minY)> abs(maxY)
        then ParametreGr[1] := minY
        else ParametreGr[1] := maxY;
     a := abs(parametreGr[1]/exp(1));
     if changeDebutDemande then begin // préacquisition éventuelle
        sauveDebut := debut;
        while (debut<fin) and (abs(valeurY[debut])<a) do inc(debut);
        i := debut;
        repeat inc(i)
        until (i=fin) or (abs(valeurY[i])<a);
        ParametreGr[2] := valeurX[i]-valeurX[debut]; // tau
        SommeCarreY := 0;
        J := 0;
        a0 := ParametreGr[1]*exp(valeurX[debut]/ParametreGr[2]);
        for i := debut to fin do begin
            SommeCarreY := SommeCarreY + sqr(valeurY[i]);
            Ecart := a0*exp(-valeurX[i]/ParametreGr[2])-valeurY[i];
            J := J + sqr(ecart);
        end;
        PrecisionModele := sqrt(J/SommeCarreY);
        changeDebut := (debut>0) and (PrecisionModele<PrecisionSuffisante);
        if changeDebut then begin
           pages[pageCourante].debut[numeroModele] := debut;
           a0 := valeurX[debut];
           for i := 0 to pred(Pages[pageCourante].nmes) do
               Pages[pageCourante].valeurVar[indexX,i] :=
                   Pages[pageCourante].valeurVar[indexX,i]-a0;
        end
        else debut := sauveDebut;
     end;
     i := debut;
     repeat inc(i)
     until (i=fin) or (abs(valeurY[i])<a);
     ParametreGr[2] := valeurX[i]-valeurX[debut];
     if abs(valeurY[debut])<abs(valeurY[fin]) then begin
        modeleOK := false;
        exit;
     end;
end; // InitialiseRadio

Procedure InitialiseGauss;
var a : double;
    i : integer;
begin
     ParametreGr[1] := maxY;
     ParametreGr[2] := valeurX[posMaxY];
     a := maxY*exp(-1/2);
     i := posMaxY;
     repeat inc(i)
     until (i=fin) or (valeurY[i]<a);
     ParametreGr[3] := valeurX[i]-ParametreGr[2];
end;

Procedure InitialiseLorentz;
var a : double;
    i : integer;
begin
     ParametreGr[2] := valeurX[posMaxY];
     a := maxY/2;
     i := posMaxY;
     repeat inc(i)
     until (i=fin) or (valeurY[i]<a);
     ParametreGr[3] := 2*(valeurX[i]-ParametreGr[2]);
     ParametreGr[1] := maxY*sqr(ParametreGr[3])/4;
end;

Procedure InitialiseFiltre1;
var a : double;
    i : integer;
begin
     ParametreGr[1] := maxY;
     if ModeleDecibel
        then a := maxY-3
        else a := maxY/sqrt(2);
     case genre of
          mgPasseBas1 : begin
             i := debut;
             repeat inc(i)
             until (i=fin) or (valeurY[i]<a);
          end;
          mgPasseHaut1 : begin
             i := fin;
             repeat dec(i)
             until (i=debut) or (valeurY[i]<a);
          end;
          else i := (debut+fin) div 2;
     end;
     ParametreGr[2] := valeurX[i]; // fréquence de coupure
end;

Procedure InitialiseFiltre2;
var a : double;
    i,n : integer;
begin
     a := 0;
     n := (fin-debut) div 20;
     if genre=mgPasseBas2
        then for i := debut to debut+n do a := a + valeurY[i]
        else for i := fin-n to fin do a := a + valeurY[i];
     a := a/(n+1);
     ParametreGr[1] := a;
     if maxY>a
        then i := posMaxY { résonance }
        else begin
             if modeleDecibel
                then a := a-3
                else a := a/sqrt(2);
             case genre of
          mgPasseBas2 : begin
             i := debut;
             repeat inc(i)
             until (i=fin) or (valeurY[i]<a);
          end;
          mgPasseHaut2 : begin
             i := fin;
             repeat dec(i)
             until (i=debut) or (valeurY[i]<a);
          end;
          else i := (debut+fin) div 2;
            end;
     end;
     ParametreGr[2] := valeurX[i];// fréquence de coupure
     ParametreGr[3] := maxY/a; // Q ou QdB approx
     if modeleDecibel then
        ParametreGr[3] := power(10,ParametreGr[3]/20);// Q
     if not ModeleFacteurQualite then ParametreGr[3] := 1/2/ParametreGr[3]; { m }
end;

Procedure InitialisePasseBande;

Procedure ChercheDroite(i1,i2 : integer;var pente,origine : double);
var systeme : Tmatrice;
    x,y : double;
    i,j,k : integer;
    OriginePente : TmatriceLigne;
begin
    for k := 1 to 2 do
        for j := 1 to 3 do systeme[k,j] := 0;
    systeme[1,1] := i2-i1+1;
    for i := i1 to i2 do begin
        x := ln(valeurX[i]);
        y := ln(valeurY[i]);
        systeme[1,2] := systeme[1,2]+x;
        systeme[2,2] := systeme[2,2]+x*x;
        systeme[1,3] := systeme[1,3]+y;
        systeme[2,3] := systeme[2,3]+y*x;
    end;
    systeme[2,1] := systeme[1,2];
    Resolution(systeme,2,OriginePente);
    Origine := OriginePente[1];
    Pente := OriginePente[2];
end;

var i,N : integer;
    Origine1,Pente1,Origine2,Pente2 : double;
begin
     ParametreGr[1] := maxY;
     i := debut;
     repeat inc(i)
     until (i=fin) or (valeurY[i]=maxY);
     ParametreGr[2] := valeurX[i];
     N := (fin-debut) div 10;
     if N<3 then N := 3;
     ChercheDroite(debut,debut+N,pente1,origine1);
     ChercheDroite(fin-N,fin,pente2,origine2);
     ParametreGr[3] := ParametreGr[1]/exp((Origine1*pente2-Origine2*pente1)/(pente2-pente1))
end;

begin // InitialiseParametre
    tOrigine := 0;
    indexX := indexNom(nX);
    changeDebutDemande := changeDebutDemande and
        (ModeleGraphique[1].genre in [mgEchelon,mgRadio]) and
        (debut=0) and (succ(fin)=pages[pageCourante].nmes) and
        (indexX=0);
    copyVecteur(valeurX,grandeurs[indexX].valeur);
    indexY := indexNom(nY);
    copyVecteur(valeurY,grandeurs[indexY].valeur);
    while isNan(valeurY[debut]) or
          isNan(valeurX[debut])
            do inc(debut);
    while isNan(valeurY[fin]) or
          isNan(valeurX[fin])
            do dec(fin);
    for i := 1 to 4 do begin
        xs[i] := 0;
        ys[i] := 0;
    end;
    maxX := valeurX[debut];
    minX := maxX;
    maxY := valeurY[debut];
    posMaxY := debut;
    posMinY := debut;
    minY := maxY;
    Nbre := fin-debut+1;
    Milieu := debut+(Nbre div 2);
    for i := succ(debut) to fin do begin
        if valeurY[i]>maxY
           then begin
              maxY := valeurY[i];
              posMaxY := i;
           end
           else if valeurY[i]<minY then begin
              minY := valeurY[i];
              posMinY := i;
           end;
        if valeurX[i]>maxX
           then maxX := valeurX[i]
           else if valeurX[i]<minX then minX := valeurX[i];
    end;
    modeleOK := true;
    try
    case genre of
          mgLineaire :InitialiseLineaire;
          mgAffine :InitialiseAffine;
          mgAffineDouble :InitialiseAffineDouble;
          mgPuissance :InitialisePuissance;
          mgParabolique :InitialiseParabolique;
          mgHyperbolique :InitialiseHyperbolique;
          mgSinus :InitialiseSinus;
          mgSinusAmorti,mgQualite :InitialiseSinusAmorti;
          mgSigmoide : InitialiseSigmoide;
          mgSinusDiverge :InitialiseSinusDiverge;
          mgEchelon : InitialiseEchelon;
          mgRadio : InitialiseRadio;
          mgPasseBas1,mgPasseHaut1 : InitialiseFiltre1;
          mgPasseBas2,mgPasseHaut2 : InitialiseFiltre2;
          mgPasseBande : InitialisePasseBande;
          mgGauss : InitialiseGauss;
          mgLorentz : InitialiseLorentz;
          mgLogistique : InitialiseLogistique;
          mgDoubleExponentielle : InitialiseDoubleExp;
   end;
   if modeleOK then AffecteTout;
   except
       modeleOK := false;
   end;
   finalize(valeurX);
   finalize(valeurY);
   t0 := tOrigine;
end; // InitialiseParametre

Procedure TmodeleGr.AffecteTout;

Procedure InitialiseAffine;
var k : integer;
begin
    for k := 1 to indexPointMax[mgAffine] do
        ys[k] := (parametreGr[1]*xs[k]+parametreGr[2])
end;

Procedure InitialiseLogistique;
var k : integer;
begin
    for k := 1 to indexPointMax[mgLogistique] do
        ys[k] := parametreGr[1]/(1+exp((parametreGr[2]-xs[k])/parametreGr[3]))
end;

Procedure InitialiseDoubleExp;
var k : integer;
begin
    for k := 1 to indexPointMax[mgDoubleExponentielle] do
        ys[k] := parametreGr[1]
end;

Procedure InitialiseAffineDouble;
var k : integer;
begin
    for k := 1 to 2 do
        ys[k] := (parametreGr[1]*xs[k]+parametreGr[2]);
    for k := 3 to 4 do
        ys[k] := (parametreGr[3]*xs[k]+parametreGr[4]);
end;

Procedure InitialiseLineaire;
var k : integer;
begin
    for k := 1 to indexPointMax[mgLineaire] do
        ys[k] := parametreGr[1]*xs[k]
end;

Procedure InitialisePuissance;
var k : integer;
begin
    for k := 1 to indexPointMax[mgPuissance] do
        ys[k] := parametreGr[1]*power(xs[k],parametreGr[2]);
end;

Procedure InitialiseParabolique;
var k : integer;
begin
    for k := 1 to indexPointMax[mgParabolique] do
        ys[k] := parametreGr[1]+(parametreGr[2]+parametreGr[3]*xs[k])*xs[k];
end;

Procedure InitialiseHyperbolique;
var k : integer;
begin
    for k := 1 to indexPointMax[mgHyperbolique] do
        ys[k] := parametreGr[1]*xs[k]/(xs[k]+parametreGr[2])
end;

Procedure InitialiseSinus;
var xx : double;
begin
    Xs[1] := parametreGr[3]; // periode
    Ys[1] := parametreGr[1];// décalage
    if AngleEnDegre
       then xx := 180
       else xx := pi;
    if modeleCosinus
    then Xs[2] := parametreGr[3]*(1-parametreGr[4]/2/xx)
    else Xs[2] := parametreGr[3]*(1/4-parametreGr[4]/2/xx);
     // retard=(-phase+pi/2)*periode/2 pi
    Ys[2] := parametreGr[1]+parametreGr[2]; { maxi }
end;

Procedure InitialiseEchelon;
begin
    Xs[1] := parametreGr[2]; // cte de temps
    Ys[1] := parametreGr[1]; // asymptote
end;

Procedure InitialiseSinusAmorti;
begin
   InitialiseSinus;
   Xs[3] := parametreGr[5];
   Ys[2] := parametreGr[1]+parametreGr[2]*exp(-Xs[2]/parametreGr[5]);
   Ys[3] := parametreGr[1]+parametreGr[2]*exp(-1);
end;

Procedure InitialiseQualite;
begin // 3=omega 4=lambda 5=phase
    Xs[1] := 2*pi/parametreGr[3]; // periode à partir de pulsation
    Ys[1] := parametreGr[1]; // décalage
    if modeleCosinus
    then Xs[2] := (2*pi-parametreGr[5])/parametreGr[3]
    else Xs[2] := (pi/2-parametreGr[5])/parametreGr[3];
       // retard=(-phase+pi/2)/pulsation
    Ys[2] := parametreGr[1]+parametreGr[2]; // maxi
    Xs[3] := 1/(parametreGr[4]*parametreGr[3]); // tau=1/(lambda*omega0)
    Ys[2] := parametreGr[1]+parametreGr[2]*exp(-Xs[2]*parametreGr[4]*parametreGr[3]);
    Ys[3] := parametreGr[1]+parametreGr[2]*exp(-1);
end;

Procedure InitialiseSinusDiverge;
begin
   InitialiseSinus;
   Xs[3] := parametreGr[5];
   Ys[2] := parametreGr[1]+parametreGr[2]*exp(Xs[2]/parametreGr[5]);
   Ys[3] := parametreGr[1]+parametreGr[2]*exp(1);
end;

Procedure InitialiseFiltre1;
begin
   Xs[1] := parametreGr[2];
   Ys[1] := parametreGr[1];
end;

Procedure InitialisePasseBande;
begin
   Xs[1] := parametreGr[2];
   Xs[2] := parametreGr[2];
   Ys[1] := parametreGr[1];
   Ys[2] := abs(parametreGr[1]/parametreGr[3]);
end;

Procedure InitialiseGauss;
begin
   Xs[1] := parametreGr[2];
   Xs[2] := parametreGr[2]+parametreGr[3]; // moyenne + ecart type
   Ys[1] := parametreGr[1];
   Ys[2] := parametreGr[1];
end;

Procedure InitialiseLorentz;
begin
   Xs[1] := parametreGr[2]; // moyenne
   Xs[2] := parametreGr[2]+parametreGr[3]/2; // moyenne + demi largeur
   Ys[1] := 4*parametreGr[1]/sqr(parametreGr[3]);
   Ys[2] := Ys[1];
end;

Procedure InitialiseFiltre2;
begin
   Xs[1] := parametreGr[2];
   Xs[2] := parametreGr[2];
   Ys[1] := parametreGr[1];
   if ModeleFacteurQualite
      then if modeleDecibel
        then Ys[2] := parametreGr[1]+20*log10(parametreGr[3])
        else Ys[2] := abs(parametreGr[3]*parametreGr[1])
      else if modeleDecibel
        then Ys[2] := parametreGr[1]-20*log10(parametreGr[3]*2)
        else Ys[2] := abs(parametreGr[1]/parametreGr[3]/2);
end;

Procedure InitialiseSigmoide;
var Lpente : double;
begin
    ys[1] := parametreGr[1];
    ys[2] := parametreGr[2];
    ys[3] := (parametreGr[1]+parametreGr[2])/2;
    Lpente := parametreGr[4]*(parametreGr[1]-parametreGr[2])/4/parametreGr[3];
    xs[1] := parametreGr[3]+Lpente*(ys[1]-ys[3])*coeffPenteSig;
    xs[2] := parametreGr[3]+Lpente*(ys[2]-ys[3])*coeffPenteSig;
end;

begin
    case genre of
          mgLineaire :InitialiseLineaire;
          mgAffine :InitialiseAffine;
          mgAffineDouble :InitialiseAffineDouble;
          mgPuissance :InitialisePuissance;
          mgParabolique :InitialiseParabolique;
          mgHyperbolique :InitialiseHyperbolique;
          mgSinus :InitialiseSinus;
          mgSinusAmorti :InitialiseSinusAmorti;
          mgQualite : InitialiseQualite;
          mgSigmoide : InitialiseSigmoide;
          mgSinusDiverge :InitialiseSinusDiverge;
          mgEchelon,mgRadio :InitialiseEchelon;
          mgPasseBas1,mgPasseHaut1 : initialiseFiltre1;
          mgPasseBas2,mgPasseHaut2 : initialiseFiltre2;
          mgPasseBande : initialisePasseBande;
          mgGauss :InitialiseGauss;
          mgLorentz :InitialiseLorentz;
          mgLogistique :InitialiseLogistique;
          mgDoubleExponentielle :InitialiseDoubleExp;
   end;
end; // affecteTout

Procedure TmodeleGr.AffecteUnPoint(index : integer;X,Y : integer);

Procedure AffecteAffine;
begin
     parametreGr[1] := (Ys[1]-Ys[2])/(Xs[1]-Xs[2]);
     parametreGr[2] := Ys[1]-parametreGr[1]*Xs[1];
end;

Procedure AffecteAffineDouble;
begin
     parametreGr[1] := (Ys[1]-Ys[2])/(Xs[1]-Xs[2]);
     parametreGr[2] := Ys[1]-parametreGr[1]*Xs[1];
     parametreGr[3] := (Ys[3]-Ys[4])/(Xs[3]-Xs[4]);
     parametreGr[4] := Ys[3]-parametreGr[3]*Xs[3];
end;

Procedure AffecteLogistique;
begin
     parametreGr[1] := Ys[1]*2;
     parametreGr[2] := Xs[1];
     parametreGr[3] := Xs[2]-Xs[1];
end;

Procedure AffecteDoubleExp;
begin
     parametreGr[1] := Ys[1];
     parametreGr[2] := Xs[1];
     parametreGr[3] := Xs[2];
end;

Procedure AffecteLineaire;
begin
     try
     parametreGr[1] := Ys[1]/Xs[1]
     except
     end;
end;

Procedure AffectePuissance;
begin
     parametreGr[2] := ln(Ys[1]/Ys[2])/ln(Xs[1]/Xs[2]);
     parametreGr[1] := Ys[1]*power(Xs[1],-parametreGr[2]);
end;

Procedure AffecteParabolique;
var systeme : Tmatrice;
    k : integer;
begin
    for k := 1 to 3 do begin
        systeme[k,1] := 1;
        systeme[k,2] := xs[k];
        systeme[k,3] := xs[k]*xs[k];
        systeme[k,4] := ys[k];
    end;
    Resolution(systeme,3,parametreGr);
end;

Procedure AffecteHyperbolique;
begin
     parametreGr[2] := xs[2]*xs[1]*(ys[2]-ys[1])/(ys[1]*xs[2]-ys[2]*xs[1]);
     parametreGr[1] := ys[1]*(parametreGr[2]+xs[1])/xs[1];
end;

Procedure AffecteSinus;
var Lalpha : double;
begin
     parametreGr[1] := Ys[1]; { décalage }
     parametreGr[2] := Ys[2]-Ys[1]; { amplitude }
     parametreGr[3] := Xs[1]; { période }
     Lalpha := Xs[2]/Xs[1]; { Xs[2]=retard }
     parametreGr[4] := -2*pi*(Lalpha-int(Lalpha))+pi/2;
     if not modeleCosinus then parametreGr[4] := parametreGr[4]+pi/2;
     parametreGr[4] := AngleUtilisateur(parametreGr[4]);
      // phase=-retard*omega [2.pi]
end;

Procedure AffecteEchelon;
begin
     parametreGr[1] := Ys[1]; // asymptote
     parametreGr[2] := Xs[1]; // cte temps
end;

Procedure AffecteSinusAmorti;
begin
     AffecteSinus;
     parametreGr[5] := Xs[3];
     parametreGr[2] := parametreGr[2]*exp(Xs[2]/parametreGr[5]);
end;

Procedure AffecteQualite;
var Lalpha : double;
begin
     parametreGr[1] := Ys[1]; // décalage
     parametreGr[2] := Ys[2]-Ys[1]; // amplitude
     parametreGr[3] := 2*pi/Xs[1]; // pulsation à partir de période
     Lalpha := Xs[2]/Xs[1];// Xs[2]=retard
     parametreGr[5] := -2*pi*(Lalpha-int(Lalpha))+pi/2;
     if not modeleCosinus then parametreGr[5] := parametreGr[5]+pi/2;
      // phase=-retard*omega [2.pi]
     parametreGr[5] := AngleUtilisateur(parametreGr[5]);// degré/radian
      // phase=-retard*omega [2.pi]
     parametreGr[4] := 1/(Xs[3]*parametreGr[3]); // lambda=1/(omega0*tau)
     parametreGr[2] := parametreGr[2]*exp(Xs[2]*parametreGr[4]*parametreGr[3]);
end;

Procedure AffecteSinusDiverge;
begin
     AffecteSinus;
     parametreGr[5] := Xs[3];
     parametreGr[2] := parametreGr[2]*exp(-Xs[2]/parametreGr[5]);
end;

Procedure AffecteFiltre1;
begin
     parametreGr[2] := Xs[1];
     parametreGr[1] := Ys[1];
end;

Procedure AffecteFiltre2;
begin
     parametreGr[2] := Xs[index]; // freq coupure
     Xs[3-index] := Xs[index]; // affecte 1 à 2 ou réciproquement 
     parametreGr[1] := Ys[1]; { gain }
     if ModeleFacteurQualite
        then if modeleDecibel
           then parametreGr[3] := power(10,(Ys[2]-Ys[1])/20)
           else parametreGr[3] := Ys[2]/Ys[1]
        else if modeleDecibel
           then parametreGr[3] := power(10,(Ys[2]-Ys[1])/20)
           else parametreGr[3] := Ys[1]/Ys[2]/2;
end;

Procedure AffectePasseBande;
begin
     parametreGr[2] := Xs[index];
     Xs[3-index] := Xs[index]; // affecte 1 à 2 ou réciproquement
     parametreGr[1] := Ys[1];
     parametreGr[3] := Ys[1]/Ys[2];
end;

Procedure AffecteGauss;
begin
     parametreGr[2] := Xs[1];
     parametreGr[1] := Ys[1];
     parametreGr[3] := Xs[2]-Xs[1];
end;

Procedure AffecteLorentz;
begin
     parametreGr[2] := Xs[1];
     parametreGr[3] := 2*(Xs[2]-Xs[1]);
     parametreGr[1] := Ys[1]*sqr(parametreGr[3])/4;
end;

Procedure AffecteSigmoide;
var Lpente : double;
begin
    parametreGr[3] := (xs[2]+xs[1])/2; // abscisse milieu
    parametreGr[1] := ys[1]; // plateau inf.
    parametreGr[2] := ys[2]; // plateau sup.
    Lpente := (ys[2]-ys[1])/(xs[2]-xs[1]);
    parametreGr[4] := Lpente*4*parametreGr[3]/((parametreGr[1]-parametreGr[2]))/coeffPenteSig;
end;

begin
     if X<graphe.limiteCourbe.left then X := graphe.limiteCourbe.left;
     if X>graphe.limiteCourbe.right then X := graphe.limiteCourbe.right;
//   if Y<graphe.limiteCourbe.top then Y := graphe.limiteCourbe.top;
//   if Y>graphe.limiteCourbe.bottom then Y := graphe.limiteCourbe.bottom;
     Xi[index] := X;
     Yi[index] := Y;
     Graphe.MondeRT(xi[index],yi[index],mondeGr,xs[index],ys[index]);
     try
     case genre of
          mgLineaire       : AffecteLineaire;
          mgAffine         : AffecteAffine;
          mgAffineDouble   : AffecteAffineDouble;
          mgPuissance      : AffectePuissance;
          mgParabolique    : AffecteParabolique;
          mgHyperbolique   : AffecteHyperbolique;          
          mgSinus          : AffecteSinus;
          mgSinusAmorti    : AffecteSinusAmorti;
          mgQualite        : AffecteQualite;
          mgSigmoide       : AffecteSigmoide;
          mgSinusDiverge   : AffecteSinusDiverge;
          mgEchelon,mgRadio : AffecteEchelon;
          mgPasseBas1,mgPasseHaut1 : AffecteFiltre1;
          mgPasseBas2,mgPasseHaut2 : AffecteFiltre2;
          mgPasseBande : AffectePasseBande;
          mgGauss         : AffecteGauss;
          mgLorentz       : AffecteLorentz;
          mgLogistique    : AffecteLogistique;
          mgDoubleExponentielle : AffecteDoubleExp;
     end;
     except
         modeleOK := false;
     end;
end; // AffecteUnPoint

Function TmodeleGr.GetIndex(x,y : integer) : integer;
var k : integer;
begin
     GetIndex := 0;
     for k := 1 to 3 do
         if (abs(x-xi[k])+abs(y-yi[k]))<5 then begin
            GetIndex := k;
            exit;
         end;
end;

Function TmodeleGr.GetHint(index : integer) : string;
begin
     GetHint := '';
     case genre of
          mgLineaire,mgAffine,mgParabolique,mgAffineDouble,
               mgHyperbolique,mgPuissance : GetHint := hMovePoint;
          mgSinus,mgSinusAmorti,mgSinusDiverge,mgQualite : case index of
                1 : GetHint := hPeriode;
                2 : GetHint := hMaxi;
                3 : GetHint := hCteTemps;
          end;
          mgSigmoide : case index of
                1 : GetHint := hBottomSigmoide+hPenteSigmoide;
                2 : GetHint := hTopSigmoide+hPenteSigmoide;
               // 3 : GetHint := hMidSigmoide;
          end;
          mgGauss : case index of
                1 : GetHint := hMoyenne;
                2 : GetHint := hEcartType;
          end;
          mgLorentz : case index of
                1 : GetHint := hMoyenne;
                2 : GetHint := hDemiLargeur;
          end;
          mgLogistique : case index of
                1 : GetHint := hMoyenne;
                2 : GetHint := hDemiLargeur;
          end;
          mgDoubleExponentielle : case index of
                1 : GetHint := hMoyenne;
                2 : GetHint := hDemiLargeur;
          end;
          mgEchelon : GetHint := hCteTemps+' ; '+hAsymptote;
          mgRadio : GetHint := hCteTemps+' ; '+hValeur0;
          mgPasseBas1,mgPasseHaut1 :
             GetHint := hFreqCoupure+' ; '+hGainMax;
          mgPasseBas2 : case index of
              1 : GetHint := hFreqCoupure+' ; '+hGainContinu;
              2 : GetHint := hFreqCoupure+' ; '+hgainQ;
          end;
          mgPasseHaut2 : case index of
              1 : GetHint := hFreqCoupure+' ; '+hGainHF;
              2 : GetHint := hFreqCoupure+' ; '+hgainQ;
          end;
          mgPasseBande : case index of
              1 : GetHint := hFreqCoupure+' ; '+hGainMax;
              2 : GetHint := hValeurAsymptote;
          end;
     end;
end;

Procedure TmodeleGr.DessineUnPoint(index : integer);
var taille : integer;
begin
     taille := 5;
     graphe.canvas.pen.color := couleur;
     graphe.canvas.brush.color := couleur;
     graphe.canvas.brush.style := bsSolid;
     graphe.canvas.pen.mode := pmNotXor;
     graphe.WindowRT(xs[index],ys[index],mondeGr,xi[index],yi[index]);
     graphe.canvas.Rectangle(xi[index]-taille,yi[index]-taille,
                       xi[index]+taille,yi[index]+taille)
end;

Procedure TmodeleGr.DessineTout;
var i : integer;
begin
     for i := 1 to indexPointMax[genre] do dessineUnPoint(i)
end;

Procedure TmodeleGr.GetParametres(var P : TableauParam);
var k,index : integer;
begin
     for k := 1 to NbreParamMagnum[genre] do begin
         index := IndexToParam(paramNormal,indexNom(nomParam[k]));
         if index<>grandeurInconnue then P[index] := parametreGr[k]
     end;
end;

Procedure TmodeleGr.GetParamGlb;
var k,index : integer;
begin
     for k := 1 to NbreParamMagnum[genre] do begin
         index := IndexToParam(paramGlb,indexNom(nomParam[k]));
         if index<>grandeurInconnue then Parametres[paramGlb,Index].valeurCourante := parametreGr[k]
     end;
end;

Procedure TmodeleGr.SetParametres(var P : TableauParam);
var k,index : integer;
begin
     for k := 1 to NbreParamMagnum[genre] do begin
         index := IndexToParam(paramNormal,indexNom(nomParam[k]));
         if index<>grandeurInconnue then parametreGr[k] := P[index];
     end;
     affecteTout;
end;

Procedure TmodeleGr.SetParamGlb;
var k,index : integer;
begin
     for k := 1 to NbreParamMagnum[genre] do begin
         index := IndexToParam(paramGlb,indexNom(nomParam[k]));
         if index<>grandeurInconnue then
         parametreGr[k] := Parametres[paramGlb,Index].valeurCourante;
     end;
     affecteTout;
end;

constructor TmodeleGr.Create;
begin
   Expression := TstringList.Create ;
   numeroModele := 1;
end;

destructor TmodeleGr.Destroy;
begin
   Expression.Free;
   inherited destroy;
end;

Procedure CreateModeleGr;
var i : TcodeIntervalle;
begin
    for i := 1 to maxIntervalles do begin
       ModeleGraphique[i] := TmodeleGr.create;
       ModeleParametre[i] := TmodeleGr.create
    end;
end;

Procedure DestroyModeleGr;
var i : TcodeIntervalle;
begin
    for i := 1 to maxIntervalles do begin
       ModeleGraphique[i].free;
       ModeleParametre[i].free
    end;
end;

Procedure TmodeleGr.store;
var i : integer;
begin
      writeln(fichier,symbReg2,'18 MAGNUM');
      writeln(fichier,ord(genre)); // 1
      writeln(fichier,numeroModele);
      writeln(fichier,mondeGr);
      writeln(fichier,1);
      writeln(fichier,1); // 5
      for i := 1 to 5 do
          ecritChaineRW3(nomParam[i]);
      // 10
      for i := 1 to 3 do begin
          writeln(fichier,xs[i]);
          writeln(fichier,ys[i]);
      end;
      // 16
      ecritChaineRW3(nX);
      ecritChaineRW3(nY);
      // 18
end;

Procedure TmodeleGr.load;
var i,imax : integer;
    zut : double;
begin
      imax := NbreLigneWin(ligneWin); // $18 Magnum
      litLigneWin;
      genre := TgenreModeleGr(strToInt(ligneWin));
      litLigneWin;
      numeroModele := strToInt(ligneWin);
      litLigneWin;
      mondeGr := strToInt(ligneWin);
      readlnNombreWin(zut);
      readlnNombreWin(zut);
      for i := 1 to 5 do begin
          litLigneWin;
          nomParam[i] := ligneWin;
      end;
      for i := 1 to 3 do begin
          readlnNombreWin(xs[i]);
          readlnNombreWin(ys[i]);
      end;
      modeleOK := true;
      if imax>16 then begin
         nX := litLigneWinU;
         nY := litLigneWinU;
      end;
      for i := 19 to imax do readln(fichier);
end;

initialization
{$IFDEF Debug}
   ecritDebug('initialization modeleGr');
{$ENDIF}
    CreateModeleGr
Finalization
    DestroyModeleGr
end.
