unit arduinoGraphe;

interface

uses windows, sysUtils, graphics, classes, printers,
     Forms, Controls, Buttons, StdCtrls, ExtCtrls, Dialogs, math,
     system.math.vectors,
     maths, fft, regutil, oomisc;

const
        MaxVecteurArduino = 8192;
        mondeX = 0;
        mondeY = 1;
        mondeYmax = 6;
        indexVitesseMax = 4;
        vitesseBaud : array[0..indexVitesseMax] of integer = (9600,19200,38400,57600,115200);
 var
        NumeroCom : array[-1..MaxComHandles] of integer; // -1 pour itemIndex=-1 de combobox

type
        TindiceVecteurArduino = 0..MaxVecteurArduino;
        TvecteurArduino = array[TindiceVecteurArduino] of double;
        TindiceAxes = mondeX..mondeYMax;

 TmondeArduino = class
    FminiStr,FmaxiStr : string;
    Fcoeff : TcoefUnite;
    a,b : double; // entier = réel*a+b
    public
    mini,maxi : double;
    Valeur,ValeurNew,ValeurSinc : TvecteurArduino;
    nom,unite : string;
    deltaAxe : double;
    NbreChiffres : integer;
    coeffDix : double;
    PointDebut : double;
    valeurC : double;
    MinMaxData,MinMaxCourant : boolean;
    property miniStr : string read FminiStr write FminiStr;
    property maxiStr : string read FmaxiStr write FMaxiStr;
    constructor create;
    Procedure GetMinMaxMonde(Npoints,NpointsNew : integer);
    function formatMonde(x : double) : string;
    procedure setDelta;
    function getTitreOscillo : string;
    function getTitre : string;
    function RealToWindow(xr : double) : integer;
 end;

 const
    couleurArduino :  array[TindiceAxes] of Tcolor =
        (clBlack,clBlue,ClRed,clBlack,clGreen,clPurple,clYellow);
 type
   TgrapheArduino = class
      private
      FNbrePoints,FNbreSinc,FNbrePointsNew : integer;
      procedure setNbrePoints(aNbre : integer);
      public
      Canvas : Tcanvas;
      monde : array[TindiceAxes] of TmondeArduino;
      LimiteCourbe : Trect;
      mondeMax : integer;
      indexRoll : integer;
      modePoint : boolean;
      deltatRoll : double;
      ordreSinc : integer;
      avecSinc : boolean;
      isOscillo : boolean;
      property NbrePoints : integer read FNbrePoints write setNbrePoints;
      property NbreSinc : integer read FNbreSinc;
      property NbrePointsNew : integer read FNbrePointsNew write FNbrePointsNew;
      Constructor Create;
      Procedure DrawG;
      Procedure DrawAxis;
      destructor Destroy;override;
      procedure InterpoleSincOsc(m : TindiceAxes);
   end;

IMPLEMENTATION

const
   ordreMaxSinc = 13;
   CouleurFond = clWhite;
   magnet = 5;

constructor TmondeArduino.Create;
begin
    inherited create;
    A := 1;
    B := 0;
    Maxi := 0;
    Mini := 0;
    FmaxiStr := '';
    FminiStr := '';
    minMaxData := false;
    minMaxCourant := false;
end;

function TmondeArduino.getTitreOscillo : string;
var Lunite : string;
    Lc : TcoefUnite;
begin
    if unite='s'
    then begin
       Lc := Fcoeff;
       dec(Lc,2);
       if Lc=nulle
          then Lunite := unite
          else Lunite := prefixeUnite[Lc]+unite;
       result := nom+'/'+Lunite
    end
    else result := nom+'/1000' // données binaires
end;

function TmondeArduino.getTitre : string;
var Lunite : string;
begin
    if unite<>''
    then begin
       if Fcoeff=nulle
          then Lunite := unite
          else Lunite := prefixeUnite[Fcoeff]+unite;
       if pos('/',unite)>0
         then result := nom+' '+Lunite
         else result := nom+'/'+Lunite
    end
    else result := nom;
end;

Procedure TgrapheArduino.setNbrePoints(aNbre : integer);
var m : TindiceAxes;
begin
    FNbrePoints := aNbre;
    if aNbre=0 then begin
    for m := mondeX to mondeYmax do
    with monde[m] do begin
       mini := 0;
       maxi := 0;
    end;
    indexRoll := 0;
    end;
end;

Function TmondeArduino.RealToWindow(xr : double) : integer;
begin
    result := round(A*xr+B);
end;

procedure TgrapheArduino.InterpoleSincOsc(m : TindiceAxes);
Const a = 7; // sept points à droite et à gauche soit 15 points
      NijMax = (ordreMaxSinc+1)*(2*a+1); // soit 255
var
   Nij : array[0..NijMax] of double;
   i,j,k : integer;
   imin,imax : integer;
   yy,deltaX,w : double;
   X,Y : TvecteurArduino;
   Xsinc,Ysinc : TvecteurArduino;
begin
    FNbreSinc := FNbrePoints*ordreSinc;
    if FNbreSinc>maxVecteurArduino then begin
       ordreSinc := floor(maxVecteurArduino/FNbrePoints);
       FNbreSinc := FNbrePoints*ordreSinc;
    end;
    if ordreSinc<=1 then begin
       avecSinc := false;
       ordreSinc := 1;
       monde[mondeX].valeurSinc := monde[mondeX].valeur;
       monde[m].valeurSinc := monde[m].valeur;
       exit;
    end;
    Nij[0] := 1; // pour éviter div par 0
		for j := 1 to NijMax do begin // calcul du noyau
        yy := pi*j/ordreSinc;
        Nij[j] := sin(yy)*sin(yy/a)*a/sqr(yy);
    end;
    X := monde[mondeX].valeur;
    Y := monde[m].valeur;
    deltaX := X[1]/ordreSinc;
// calcul de Xsinc, Ysinc
    for j := 0 to FNbreSinc-1 do begin
        k := round(j/ordreSinc);
        Xsinc[j] := j*deltaX;
        imin := k-a;
        if imin<0 then imin := 0;
        imax := imin+2*a; // 2*a+1 points
        if imax>=FNbrePoints then begin
           imax := FNbrePoints-1;
           imin := imax-2*a;
           if imin<0 then imin := 0;
        end;
        yy := 0;
        w := 0;
        for i := imin to imax do begin
            yy := yy + Y[i]*Nij[abs(i*ordreSinc-j)];
            w := w + Nij[abs(i*ordreSinc-j)];
        end;
	   	  Ysinc[j] := yy/w;
    end;
    monde[mondeX].valeurSinc := Xsinc;
    monde[m].valeurSinc := Ysinc;
end; // InterpoleSinc

destructor TgrapheArduino.destroy;
var m : TindiceAxes;
begin
    for m := mondeX to mondeYmax do
        monde[m].free;
end;

constructor TgrapheArduino.Create;
var m : TindiceAxes;
begin
   inherited create;
   for m := mondeX to mondeYMax do
       monde[m] := TmondeArduino.create;
   mondeMax := mondeY;
   FNbrePoints := 0;
   FNbreSinc := 0;
   indexRoll := 0;
   isOscillo := false;
end;

Procedure TmondeArduino.GetMinMaxMonde(Npoints,NpointsNew : integer);
var i : integer;
    marge,margeM,margeP : double;
    miniImpose : boolean;
begin
     if length(FminiStr)>0 then mini := strToFloatWin(FminiStr);
     if (FminiStr='') or isNan(mini) then begin
        if Npoints>0 then Mini := Valeur[0] else mini := 0;
        miniImpose := false;
     end
     else miniImpose := true;
     if length(FmaxiStr)>0 then maxi := strToFloatWin(FmaxiStr);
     if (FmaxiStr='') or isNan(maxi) then if Npoints>0 then Maxi := Valeur[0] else maxi := 1;
     verifMinMaxReal(mini,maxi);
     if minMaxData then begin
       for i := 1 to pred(Npoints) do
         if Valeur[i]>Maxi
            then Maxi := Valeur[i]
            else if Valeur[i]<Mini
               then Mini := Valeur[i];
       if NpointsNew>3 then
       for i := 1 to pred(NpointsNew) do
         if ValeurNew[i]>Maxi
            then Maxi := ValeurNew[i]
            else if ValeurNew[i]<Mini
               then Mini := ValeurNew[i];
     end;
     if minMaxCourant then
        if ValeurC>Maxi
            then Maxi := ValeurC
            else if ValeurC<Mini
               then Mini := ValeurC;
     if not(miniImpose) then begin
        margeM := (maxi - mini)/10;
        margeP := abs(maxi + mini)/10;
        if margeM>margeP then marge := margeM else marge := margeP;
        if (mini>=0) and (mini<marge)
           then mini := 0
           else mini := mini - marge;
        if (maxi<=0) and (maxi>-marge)
           then maxi := 0
           else maxi := maxi + marge
     end;
     if maxi=mini then begin
        mini := 0;
        if maxi=0 then maxi := 1;
     end;
end;

procedure TgrapheArduino.DrawG;

procedure ChercheMinMaxOsc;
var m : TindiceAxes;
begin
    for m := mondeX to mondeMax do
        monde[m].GetMinMaxMonde(FNbrePoints,FNbrePointsNew);
    for m := mondeY to mondeMax do with monde[m] do begin
        A := (LimiteCourbe.top-LimiteCourbe.bottom)/(Maxi-Mini);
        B := LimiteCourbe.bottom-Mini*A;
    end;
    with monde[mondeX] do begin
        A := (LimiteCourbe.right-LimiteCourbe.left)/(Maxi-Mini);
        B := LimiteCourbe.left-Mini*A;
    end;
    if modePoint and (mondeMax>mondeY) then // axe X = Y
    with monde[mondeY] do begin
        A := (LimiteCourbe.right-LimiteCourbe.left)/(Maxi-Mini);
        B := LimiteCourbe.left-Mini*A;
    end;
end;// ChercheMinMaxOsc

procedure TraceCouleur;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
begin
  for m := mondeY to mondeMax do begin
      with monde[mondeX] do x := RealToWindow(valeur[0]);
      with monde[m] do y := RealToWindow(valeur[0]);
      Canvas.pen.color := couleurArduino[m];
      Canvas.moveTo(x,y);
      for i := 1 to pred(FnbrePoints) do begin
           with monde[mondeX] do x := RealToWindow(valeur[i]);
           with monde[m] do y := RealToWindow(valeur[i]);
           Canvas.LineTo(x,y)
      end;
  end;
end;// TraceCouleur

procedure TraceSinc;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
begin
  for m := mondeY to mondeMax do begin
      interpoleSincOsc(m);
      with monde[mondeX] do x := RealToWindow(valeurSinc[0]);
      with monde[m] do y := RealToWindow(valeurSinc[0]);
      Canvas.pen.color := couleurArduino[m];
      Canvas.moveTo(x,y);
      for i := 1 to pred(FNbreSinc) do begin
           with monde[mondeX] do x := RealToWindow(valeurSinc[i]);
           with monde[m] do y := RealToWindow(valeurSinc[i]);
           Canvas.LineTo(x,y)
      end;
  end;
end;// TraceSinc

procedure TraceCouleurRoll;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
    t : double;
begin
  for m := mondeY to mondeMax do begin
      t := 0;
      with monde[mondeX] do x := RealToWindow(0);
      with monde[m] do y := RealToWindow(valeur[indexRoll]);
      Canvas.pen.color := couleurArduino[m];
      Canvas.moveTo(x,y);
      for i := indexRoll+1 to pred(FnbrePoints) do begin
           t := t+deltatRoll;
           with monde[mondeX] do x := RealToWindow(t);
           with monde[m] do y := RealToWindow(valeur[i]);
           Canvas.LineTo(x,y)
      end;
      for i := 0 to indexRoll-1 do begin
           t := t+deltatRoll;
           with monde[mondeX] do x := RealToWindow(t);
           with monde[m] do y := RealToWindow(valeur[i]);
           Canvas.LineTo(x,y)
      end;
  end;
end;// TraceCouleurRoll

procedure TraceCouleurRollTemps;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
    tZero : double;
begin
  for m := mondeY to mondeMax do begin
      with monde[mondeX] do begin
         tZero := valeur[indexRoll];
         x := RealToWindow(0);
      end;
      with monde[m] do y := RealToWindow(valeur[indexRoll]);
      Canvas.pen.color := couleurArduino[m];
      Canvas.moveTo(x,y);
      for i := indexRoll+1 to pred(FnbrePoints) do begin
           with monde[mondeX] do x := RealToWindow(valeur[i]-tZero);
           with monde[m] do y := RealToWindow(valeur[i]);
           Canvas.LineTo(x,y)
      end;
      for i := 0 to indexRoll-1 do begin
           with monde[mondeX] do x := RealToWindow(valeur[i]-tZero);
           with monde[m] do y := RealToWindow(valeur[i]);
           Canvas.LineTo(x,y)
      end;
  end;
end;// TraceCouleurRollTemps

procedure TraceCouleurPoint;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
    taille : integer;
begin
  taille := magnet div 2;
  if mondeMax=mondeY then begin // y=f(index)
      Canvas.pen.color := couleurArduino[mondeY];
      Canvas.brush.color := couleurArduino[mondeY];
      for i := 0 to pred(FnbrePoints) do begin
           with monde[mondeX] do x := RealToWindow(valeur[i]);
           with monde[mondeY] do y := RealToWindow(valeur[i]);
           canvas.Ellipse(x-taille,y-taille,x+taille,y+taille)
      end;
  end
  else begin
  for m := mondeY+1 to mondeMax do begin // Y2=f(Y1)
      Canvas.pen.color := couleurArduino[m];
      Canvas.brush.color := couleurArduino[m];
      for i := 0 to pred(FnbrePoints) do begin
          with monde[mondeY] do x := RealToWindow(valeur[i]);
          with monde[m] do y := RealToWindow(valeur[i]);
          canvas.Ellipse(x-taille,y-taille,x+taille,y+taille)
      end;
  end;
  end;
end;// TraceCouleurPoint

procedure TraceCourant;
var x,y : integer;
    m : TindiceAxes;
begin
if mondeMax=mondeY then begin
      with monde[mondeX] do x := RealToWindow(valeurC);
      with monde[mondeY] do y := RealToWindow(valeurC);
      Canvas.pen.color := couleurArduino[mondeY];
      Canvas.brush.color := couleurArduino[mondeY];
      Canvas.ellipse(x-magnet,y-magnet,x+magnet,y+magnet);
end
else begin
   for m := mondeY+1 to mondeMax do begin
      with monde[mondeY] do x := RealToWindow(valeurC);
      with monde[m] do y := RealToWindow(valeurC);
      Canvas.pen.color := couleurArduino[m];
      Canvas.brush.color := couleurArduino[m];
      Canvas.ellipse(x-magnet,y-magnet,x+magnet,y+magnet);
   end;
end;
end;// TraceCourant

procedure TraceGris;
var x,y : integer;
    i : integer;
    m : TindiceAxes;
begin
      Canvas.pen.color := clSilver;
      for m := mondeY to mondeMax do begin
         with monde[mondeX] do x := RealToWindow(valeurNew[0]);
         with monde[m] do y := RealToWindow(valeurNew[0]);
         Canvas.moveTo(x,y);
         for i := 0 to pred(FnbrePointsNew) do begin
           with monde[mondeX] do x := RealToWindow(valeurNew[i]);
           with monde[m] do y := RealToWindow(valeurNew[i]);
           Canvas.LineTo(x,y)
         end;
      end;
end;// TraceGris

begin
     if mondeMax>mondeYmax then mondeMax := mondeYmax;
     if mondeMax<0 then exit;
     with canvas do begin
         brush.style := bsSolid;
         brush.color := couleurFond;
         pen.mode := pmCopy;
         pen.width := 1;
         limiteCourbe := clipRect;
         FillRect(LimiteCourbe);
         if isOscillo then inc(limiteCourbe.Left,4) else inc(limiteCourbe.Left,48);
         inc(limiteCourbe.Top,8);
         dec(limiteCourbe.Bottom,24);
     end;
     ChercheMinMaxOsc;
     DrawAxis;
     if modePoint
     then begin
        TraceCouleurPoint;
        traceCourant;
     end
     else if FnbrePoints>8 then begin
        if avecSinc
           then traceSinc
           else if indexRoll=0
              then TraceCouleur
              else if deltatRoll=0
                 then TraceCouleurRollTemps
                 else TraceCouleurRoll;
        if FnbrePointsNew>3 then TraceGris;
     end;
end; // tgrapheArduino.drawG

procedure TGrapheArduino.DrawAxis;
const quadrillage = false;
var yAxeX,xAxeY : integer;
    penWidth : integer;

procedure segment(x1,y1,x2,y2 : integer);
begin
    canvas.MoveTo(x1,y1);
    canvas.LineTo(x2,y2);
end;

Procedure graduationX(x : integer);
begin
  if quadrillage
       then segment(x,0,x,limiteCourbe.bottom)
       else segment(x,yAxex,x,yAxeX-magnet)
end;

Procedure graduationY(y : integer);
begin
   if quadrillage
       then segment(limiteCourbe.left,y,canvas.clipRect.right,y)
       else segment(xAxeY,y,xAxeY+magnet,y)
end;

  procedure traceAxeX(m : TindiceAxes);
  var xs,xmax : Integer;
      PointCourant : double;
      titre : string;
  begin with monde[m] do begin
    setDelta;
    PointCourant := PointDebut;
    canvas.font.Color := clBlack;
    if isOscillo then titre := getTitreOscillo else titre := getTitre;
    xmax := canvas.clipRect.right-canvas.TextWidth(titre)-4;
    canvas.TextOut(xmax,yaxeX+4,titre);
    canvas.pen.Color := clBlack;
    with limiteCourbe do begin
          segment(0,yAxeX,right,yAxeX);
          segment(right-magnet*2,yAxeX+magnet div 2,right,yAxeX);
          segment(right-magnet*2,yAxeX-magnet div 2,right,yAxeX);
    end;
    repeat
          xs := realToWindow(PointCourant);
          graduationX(xs);
          if xs<xmax then canvas.TextOut(xs,yAxeX+4,formatMonde(pointCourant));
          PointCourant := PointCourant+deltaAxe;
    until PointCourant>=maxi;
 end end; // traceAxeX

 procedure traceAxeY(m : TindiceAxes);
 var ys,deltay : Integer;
     PointCourant : double;
 begin with monde[m] do begin
      setDelta;
      canvas.font.Color := couleurArduino[mondeY];
      canvas.textOut(xAxeY+magnet,magnet,getTitre);
      PointCourant := PointDebut;
      deltay := canvas.TextHeight('A') div 2;
      canvas.Pen.Color := couleurArduino[mondeY];
      repeat
           ys := RealToWindow(PointCourant);
           canvas.TextOut(4,ys-deltaY,formatMonde(pointCourant));
           graduationY(ys);
           pointCourant := pointCourant+deltaAxe;
      until pointCourant>=maxi;
      segment(xAxeY,canvas.clipRect.Bottom,xAxeY,0);
      segment(xAxeY-magnet div 2,2*magnet,xAxeY,0);
      segment(xAxeY+magnet div 2,2*magnet,xAxeY,0);
end end; // traceAxeY

begin // DrawAxis
     penWidth := limiteCourbe.width div 1024;
     if penWidth<1 then penWidth := 1;
     canvas.Pen.style := psSolid;
     canvas.pen.width := penWidth;
     canvas.Font.size := 10;
     xAxeY := limiteCourbe.left;
     yAxeX := limiteCourbe.bottom;
     if modePoint and (mondeMax>mondeY)
       then begin
          traceAxeX(mondeY);
          traceAxeY(mondeY+1);
       end
       else begin
          traceAxeX(mondeX);
          if not isOscillo then traceAxeY(mondeY);
       end;
end; // DrawAxis

procedure TmondeArduino.SetDelta;
// Exposant=puissance de 10 multiple de 3 de manière à avoir entre
// ou NbreGradMin (5) et N/2.5 (2) graduations sur l'axes.
// Delta est l'intervalle entre les graduations qui commencent à PremiereGraduation

const
  indexMax = 5;
  nbreGradMin = 5;
  coeff: array[0..indexMax] of double = (0.1, 0.2, 0.5, 1, 2, 5);
var
  absMax, absMin, largeur : double;
  Exposant, N, index : integer;
begin // setDelta
  absMax := abs(maxi);
  absMin := abs(mini);
  if absMax < absMin then  absMax := absMin;
  Exposant := floor(Log10(Maxi - Mini));
  largeur  := (maxi - mini) * dix(-exposant);
  index := 0;
  while ((largeur / coeff[index]) >= NbreGradMin) and (index < indexMax) do
        Inc(index);
  DeltaAxe  := coeff[index] * dix(exposant);
  NbreChiffres := ceil(Log10(absMax)) - floor(Log10(DeltaAxe));
  if exposant = -1 then exposant := 0;
// nombre <~1 écrit sous forme 0.8 plutôt que 800.10-3
  Index := Exposant div 3;
  if ((Exposant mod 3) < 0) then Dec(index);
//la division euclidienne des informaticiens <> div des maths !
  coeffDix := power(10,3 * Index);
  Fcoeff := TCoefUnite(index+ord(nulle));
  N := ceil(Log10(absMax / Exposant));
  if N > NbreChiffres then NbreChiffres := N;
  if NbreChiffres < 3 then NbreChiffres := 3;
  PointDebut := ceil(mini / deltaAxe) * deltaAxe;
end; // setDelta

function TmondeArduino.formatMonde(x : double) : string;
begin
   result := FloatToStrF(x / coeffDix, ffGeneral, NbreChiffres, 0)
end;

end.

