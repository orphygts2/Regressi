unit Grapheu;

interface

uses windows, sysUtils, graphics, classes, printers,
     Forms, Controls, Buttons, StdCtrls, ExtCtrls, Dialogs, math,
     system.math.vectors,
     maths, fft, regutil;

const
        maxPixel = 2048;
        MaxVecteurOptique = 4096;

type
        TIndiceVecteurOptique = -MaxVecteurOptique..MaxVecteurOptique;
        TvecteurOptique = array[TindiceVecteurOptique] of double;
        TstyleDrag = (bsNone,bsMesure,bsOrigine,bsEchelle1,bsEchelle2,
                      bsChrono,bsChronoInit,bsAxeX,bsAxeY,bsSuppr,bsPlay);
        TarrayPoint = array[TstyleDrag] of Tpoint;

 Tmonde = class
    mini,maxi : double;
    a,b : double; // entier = réel*a+b
    Procedure ToScreen(xr : double;var xi : integer);
    Procedure ToReal(xi : integer;var xr : double);
    constructor create;
 end;

 type
 Tgraphe = class
      LimiteCourbe : Trect;
      Canvas : Tcanvas;
      mondeX : Tmonde;
      mondeY : Tmonde;
      debutG,finG,pasG : integer;
      dimPix,decalage : double;
      ValeurY,vertY,rougeY,bleuY : TvecteurOptique;
      ValeurX : TvecteurOptique;
      wR,wG,wB,wL : boolean;
      Constructor Create;
      Procedure DrawG;
      Procedure WindowXY(xr,yr : double;var xi,yi : integer);
      Function getXmonde(xi : integer) : double;
      procedure TraceReticule(x : integer);
      procedure TraceEcart(x1,x2 : integer);
      destructor Destroy;override;
   end;

   TgrapheSon = class
        LimiteCourbe : Trect;
        Canvas : Tcanvas;
        mondeX : Tmonde;
        mondeY : Tmonde;
        debutS,finS,pasS : integer;
        vecteurSon : TvecteurSon;
        Enveloppe : boolean;
        Constructor Create;
        Procedure DrawG;
        Procedure WindowXY(xr,yr : double;var xi,yi : integer);
        Procedure MondeXY(xi,yi : integer;var xr,yr : double);
        Function Xecran(xr : double) : integer;
        destructor Destroy;override;
   end;

var magnet : integer;

IMPLEMENTATION

const
   CouleurFond = clWhite;
   CouleurCourbeOptique = clBlack;
   mondeX = 0;
   mondeY = 1;

constructor Tmonde.Create;
begin
    inherited create;
    A := 1;
    B := 0;
    Maxi := 1;
    Mini := 0;
end;

Procedure TgrapheSon.MondeXY(xi,yi : integer;var xr,yr : double);
begin
    with mondeX do xr := (xi-B)/A;
    with mondeY do yr := (yi-B)/A
end;

Procedure Tmonde.ToReal(xi : integer;var xr : double);
begin
    xr := (xi-B)/A;
end;

Procedure Tmonde.ToScreen(xr : double;var xi : integer);
begin
    if isIncorrect(xr)
           then xi := -1
           else xi := round(A*xr+B);
end;

Procedure TgrapheSon.WindowXY(xr,yr : double;var xi,yi : integer);
begin
    mondeX.ToScreen(xr,xi);
    mondeY.ToScreen(yr,yi);
end;

Function TgrapheSon.Xecran(xr : double) : integer;
begin
    with mondeX do result := round(A*(xr-debutS)+B)
end;

procedure TgrapheSon.DrawG;

procedure ChercheMonde;
begin
    with LimiteCourbe do begin
         mondeX.A := (right-left)/(finS-debutS);
         Enveloppe := mondeX.A<0.2;
         mondeX.B := left;
         mondeY.A := (top-bottom)/2;  // données entre -1 et +1
         mondeY.B := bottom+mondeY.A;
     end;
end;// ChercheMonde

procedure TraceCourbe(valeur : TarraySon);
var x,y : integer;
    i : integer;
begin with LimiteCourbe,mondeY do begin
      windowXY(0,valeur[debutS],x,y);
      Canvas.moveTo(x,y);
      for i := debutS to finS do if ((debutS mod pasS)=0) then begin
          windowXY(i-debutS,valeur[i],x,y);
          Canvas.LineTo(x,y);
      end;
end end;// TraceCourbe

procedure TraceEnveloppe(valeur : TarraySon);
var x1,y1,x2,y2 : integer;
    i,j,pas,jdebut : integer;
    minSon,maxSon : double;
    valeurI : double;
begin with LimiteCourbe,mondeY do begin
      pas := trunc((finS-debutS)/(right-left));
      if pas<1 then pas := 1;
      for i := left to (right-2) do begin
          jdebut := debutS+(i-left)*pas;
          minSon := valeur[jdebut];
          maxSon := minSon;
          for j := succ(jdebut) to pred(jdebut+pas) do begin
              valeurI := valeur[j];
              if valeurI>maxSon
                  then maxSon := valeurI
                  else if valeurI<minSon
                       then minSon := valeurI;
          end;
          windowXY(jdebut,minSon,x1,y1);
          windowXY(jdebut,maxSon,x2,y2);
          Canvas.moveTo(i,y1);
          Canvas.lineTo(i,y2);
      end; // i
end end;// TraceEnveloppe

begin with canvas do begin
     brush.style := bsSolid;
     brush.color := clWhite;
     pen.mode := pmCopy;
     pen.width := 1;
     pen.color := clBlue;
     FillRect(LimiteCourbe);
     if debutS>=finS then exit;
     ChercheMonde;
     if enveloppe
        then traceEnveloppe(vecteurSon.valeur)
        else traceCourbe(vecteurSon.valeur);
     if vecteurSon.stereo  then begin
        pen.color := clRed;
        if enveloppe
           then traceEnveloppe(vecteurSon.valeurBis)
           else traceCourbe(vecteurSon.valeurBis);
      end;
end end; // TgrapheSon.DrawG

destructor TgrapheSon.destroy;
begin
    mondeX.free;
    mondeY.free;
end;

constructor TgrapheSon.Create;
begin
   inherited create;
   mondeX := Tmonde.create;
   mondeY := Tmonde.create;
   finS := 0;
   debutS := 0;
   pasS := 1;
end;

Function Tgraphe.getXMonde(xi : integer) : double;
begin
     with mondeX do result := (xi-B)/A;
     result := dimPix*result+decalage;
end;

Procedure Tgraphe.WindowXY(xr,yr : double;var xi,yi : integer);
begin
        mondeX.ToScreen(xr,xi);
        mondeY.ToScreen(yr,yi);
end;

procedure Tgraphe.DrawG;

procedure ChercheMonde;
begin
    with LimiteCourbe do begin
         mondeX.A := (right-left)/(mondeX.Maxi-mondeX.Mini);
         mondeX.B := left-mondeX.Mini*mondeX.A;
         mondeY.A := (top-bottom)/(mondeY.Maxi-mondeY.Mini);
         mondeY.B := bottom-mondeY.Mini*mondeY.A;
     end;
end;// ChercheMonde

procedure TraceCouleur(vect : TvecteurOptique;couleur : Tcolor);
var x,y : integer;
    i : integer;
begin with LimiteCourbe,mondeY do begin
      if finG<=debutG then exit;
      windowXY(valeurX[debutG],vect[debutG],x,y);
      Canvas.pen.color := couleur;
      Canvas.moveTo(x,y);
      for i := debutG to finG do begin
           windowXY(valeurX[i],vect[i],x,y);
           if (x>0) and (y>0) then Canvas.LineTo(x,y)
      end;
end end;// TraceCouleur

begin
     with canvas do begin
         brush.style := bsSolid;
         brush.color := couleurFond;
         pen.mode := pmCopy;
         pen.width := 1;
         FillRect(LimiteCourbe);
     end;
     if finG>maxVecteurOptique then finG := maxVecteurOptique;
     if debutG<-maxVecteurOptique then debutG := -maxVecteurOptique;
     ChercheMonde;
     if wL then TraceCouleur(valeurY,couleurCourbeOptique);
     if wR then TraceCouleur(rougeY,clRed);
     if wB then TraceCouleur(bleuY,clBlue);
     if wG then TraceCouleur(vertY,clGreen);
end; // tgraphe.drawG

destructor Tgraphe.destroy;
begin
    mondeX.free;
    mondeY.free;
    inherited
end;

constructor Tgraphe.Create;
begin
   inherited;
   mondeX := Tmonde.create;
   mondeY := Tmonde.create;
   finG := 0;
   debutG := 0;
   pasG := 1;
end;

procedure TGraphe.TraceReticule(x : integer);
begin with Canvas do begin
    Pen.Color := clBlack;
    Pen.mode  := pmNotXor;
    moveTo(X, 0);
    lineTo(X, limiteCourbe.bottom);
    Pen.mode := pmCopy;
end; end;

procedure TGraphe.TraceEcart(x1,x2 : integer);
var y0 : integer;
begin
    if x1<>x2 then with Canvas do begin
       Pen.mode  := pmNotXor;
       y0 := limiteCourbe.bottom div 2;
       Pen.color := clHighLight;
       Pen.width := 3;
       moveTo(x1, y0);
       lineTo(x2, y0);
       Pen.width := 1;
       Pen.Color := clBlack;
       moveTo(x1, 0);
       lineTo(x1, limiteCourbe.bottom);
       Pen.mode := pmCopy;
    end;
end;

initialization
   magnet := screen.Width div 256;
   if magnet<5 then magnet := 5;
end.

