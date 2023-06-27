unit TestContour;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  contour, compile;

const
    maxValeurParam = 64;

type
  TConvergenceModeleForm = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure testContourSinCos;
    procedure testContourExp;
    procedure traceConvergence;
  public
    trace : tprocedureTrace;
    valeurX,valeurY : array[0..maxValeurParam] of double;
    NbreValeurParam : integer;
    procedure afficheConvergence;
  end;

var
  ConvergenceModeleForm: TConvergenceModeleForm;

implementation

{$R *.dfm}

Const dimz = 16; // dimension for contour levels
      dimx = 64;
      dimy = 64;

procedure TraceP(x1,y1,x2,y2 : double);
begin
    ConvergenceModeleForm.paintBox1.canvas.moveTo( round(x1), round(y1));
    ConvergenceModeleForm.paintBox1.canvas.lineTo( round(x2), round(y2));
end;

procedure TConvergenceModeleForm.afficheConvergence;
begin

end;

procedure TConvergenceModeleForm.testContourSinCos;
Var
 Mat:TMatrix;  // 2D - Datafield
 scx:TVector;  // scaling vector west - east
 scy:TVector;  // scaling vector north - west
 z:TVector;  // vector for the countur levels
 i,j:Integer;  // adress indexes
 x,y:Double;   // coord. values
 mi,ma:Double; // for minimum & maximum
 echelleX,echelleY : double;

Begin
 setlength(scx,dimx); // create dynamicly the vectors and datafield
 setlength(scy,dimy);
 setlength(z,dimz);
 setlength(mat,dimx);
 For i:=0 to dimx-1 Do Setlength(mat[i],dimy);

 echelleX := paintBox1.Width/dimx;
 echelleY := paintBox1.Height/dimy;
 For i:=0 to dimx-1 Do scx[i] := i*echellex;
 For j:=0 to dimy-1 Do scy[j] := j*echelley;

 For i:=0 to dimx-1 Do  // set 2d data field
  For j:=0 to dimy-1 Do Begin
   x:=i-dimx/2;
   y:=j-dimy/2;
   mat[i,j]:= (sin(x/dimx*4*pi)    * cos(y/dimy*4*pi)) +
              (sin(x/dimx*2*pi)    * cos(y/dimy*2*pi)) +
              (sin(x/dimx*1*pi)    * cos(y/dimy*1*pi)) +
              (sin(x/dimx*0.5*pi)  * cos(y/dimy*0.5*pi))+
              (sin(x/dimx*0.25*pi) * cos(y/dimy*0.25*pi));
  End; // for j

 mi:=1e16;    // Set the minimunm and maximum fof the data field
 ma:=-1e16;
 For i:=0 to dimx-1 Do
  For j:=0 to dimy-1 Do Begin
   if mat[i,j]<mi then mi:=mat[i,j];
   if mat[i,j]>ma then ma:=mat[i,j];
  End;  // for j

For i:=0 to dimz-1 Do z[i]:=mi+i*(ma-mi)/(dimz-1); // create cut levels
conrec(mat,dimx,dimy,dimz,scx,scy,z,trace); // call the contour algorithm

end;

procedure TConvergenceModeleForm.testContourExp;
Const
   dimData = 9;
   dimPoint = 3;
Var
 Mat:TMatrix;  // 2D - Datafield
 scx:TVector;  // scaling vector west - east
 scy:TVector;  // scaling vector north - west
 z:TVector;  // vector for the countur levels
 i,j,k:Integer;  // adress indexes
 x,y,zc:Double;   // coord. values
 mi,ma:Double; // for minimum & maximum
 ti,fref : array[0..dimdata] of double;
 tau,A,taumax,Amax,taumin,Amin : double;
 deltaTau,deltaA,somme : double;
 echelleX,echelleY : double;
 deltat : double;
 xi,yi : integer;
 Ax,Ay,Bx,By : double;

Begin
 nbreValeurParam := 3;
 valeurX[0] := 0.1;valeurY[0]:= 40;
 valeurX[2] := 0.05;valeurY[1]:= 30;
 valeurX[1] := 0.08;valeurY[2]:= 20;
 tau := 0.1;A := 50;
 taumax := 0.15;Amax := 80;
 Amin := 0; TauMin := 0.01;
 deltat := 3/(tau*dimdata);
 For i := 0 to dimData Do begin
    ti[i] := i*deltat;
    fref[i] := A*exp(ti[i]*tau);
 end;
 setlength(scx,dimx); // create dynamicly the vectors and datafield
 setlength(scy,dimy);
 setlength(z,dimz);
 setlength(mat,dimx);
 For i:=0 to dimx-1 Do Setlength(mat[i],dimy);

 echelleX := paintBox1.Width/dimx;
 echelleY := paintBox1.Height/dimy;
 For i:=0 to dimx-1 Do scx[i] := i*echelleX;
 For j:=0 to dimy-1 Do scy[j] := j*echelley;

 deltaTau := (taumax-tauMin)/dimx;
 deltaA := (Amax-AMin)/dimy;
 For i:=0 to dimx-1 Do  // set 2d data field
  For j:=0 to dimy-1 Do Begin
   x := tauMin+i*deltaTau;
   y := Amin+j*deltaA;
   somme := 0;
   for k := 0 to dimdata do begin
       zc := y*exp(-ti[k]*x)-fref[k];
       somme := somme + zc*zc;
   end;
   mat[i,j]:=somme;
  End; // for j

 mi:=1e16;    // Set the minimunm and maximum fof the data field
 ma:=-1e16;
 For i:=0 to dimx-1 Do
  For j:=0 to dimy-1 Do Begin
   if mat[i,j]<mi then mi:=mat[i,j];
   if mat[i,j]>ma then ma:=mat[i,j];
  End;  // for j

For i:=0 to dimz-1 Do z[i]:=mi+i*(ma-mi)/(dimz-1); // create cut levels
conrec(mat,dimx,dimy,dimz,scx,scy,z,trace); // call the contour algorithm

Ax := paintBox1.width / (tauMax - tauMin);
Bx := - tauMin * A;
Ay := -PaintBox1.height / (AMax - AMin);
by := PaintBox1.height - AMin * a;
paintBox1.canvas.Pen.color := clRed;
for i := 0 to pred(NbreValeurParam) do begin
    xi := round(Ax*valeurX[i]+Bx);
    yi := round(Ay*valeurY[i]+By);
    paintBox1.canvas.ellipse(xi - dimPoint, yi - dimPoint, xi + dimPoint + 1, yi + dimPoint + 1);
    if i=0
       then paintBox1.canvas.moveTo(xi,yi)
       else paintBox1.canvas.lineTo(xi,yi);
end;
end;


procedure TConvergenceModeleForm.traceConvergence;
Const
   dimPoint = 3;
Var
 Mat:TMatrix;  // 2D - Datafield
 scx:TVector;  // scaling vector west - east
 scy:TVector;  // scaling vector north - west
 z:TVector;  // vector for the countur levels
 i,j,k:Integer;  // adress indexes
 x,y,zc:Double;   // coord. values
 mi,ma:Double; // for minimum & maximum
 xmax,ymax,xmin,ymin : double;
 deltaX,deltaY,somme : double;
 echelleX,echelleY : double;
 xi,yi : integer;
 Ax,Ay,Bx,By : double;
 dimData : integer;
 ecart : double;

Begin with fonctionTheorique[1],pages[pageCourante] do begin
 dimData := fin[1]-debut[1];
 xmin:=1e16; xmax:=-1e16;  ymin:=1e16; ymax:=-1e16;
 For i := 0 to nbreValeurParam Do begin
     if valeurX[i]<xmin then xmin := valeurX[i];
     if valeurX[i]>xmax then xmax := valeurX[i];
     if valeurY[i]<ymin then ymin := valeurX[i];
     if valeurY[i]>ymax then ymax := valeurX[i];
 end;
 ecart := (ymax-ymin)/3;
 ymin := ymin-ecart;
 ymax := ymax+ecart;
 ecart := (xmax-xmin)/3;
 xmin := xmin-ecart;
 xmax := xmax+ecart;
 setlength(scx,dimx); // create dynamicly the vectors and datafield
 setlength(scy,dimy);
 setlength(z,dimz);
 setlength(mat,dimx);
 For i:=0 to dimx-1 Do Setlength(mat[i],dimy);

 echelleX := paintBox1.Width/dimx;
 echelleY := paintBox1.Height/dimy;
 For i:=0 to dimx-1 Do scx[i] := i*echelleX;
 For j:=0 to dimy-1 Do scy[j] := j*echelley;

 deltaX := (xMax-xMin)/dimx;
 deltaY := (ymax-yMin)/dimy;
 For i:=0 to dimx-1 Do  // set 2d data field
    For j:=0 to dimy-1 Do Begin
      x := xMin+i*deltaX;
      y := ymin+j*deltaY;
      Parametres[paramNormal,1].valeurCourante := x;
      Parametres[paramNormal,2].valeurCourante := y;
      somme := 0;
      for k := 0 to dimdata-1 do begin
        affecteVariableE(k+debut[1]);
        zc := (calcule(fonctionTheorique[1].calcul)-grandeurs[indexY].valeurCourante);
        somme := somme + zc*zc;
      end;
      mat[i,j]:=somme;
    End; // for j

 mi:=1e16;    // Set the minimunm and maximum fof the data field
 ma:=-1e16;
 For i:=0 to dimx-1 Do
    For j:=0 to dimy-1 Do Begin
      if mat[i,j]<mi then mi:=mat[i,j];
      if mat[i,j]>ma then ma:=mat[i,j];
    End;  // for j

For i:=0 to dimz-1 Do z[i]:=mi+i*(ma-mi)/(dimz-1); // create cut levels
conrec(mat,dimx,dimy,dimz,scx,scy,z,trace); // call the contour algorithm

Ax := paintBox1.width / (xMax - xMin);
Bx := - xMin * Ax;
Ay := -PaintBox1.height / (yMax - yMin);
by := PaintBox1.height - yMin * Ay;
paintBox1.canvas.Pen.color := clRed;
for i := 0 to pred(NbreValeurParam) do begin
    xi := round(Ax*valeurX[i]+Bx);
    yi := round(Ay*valeurY[i]+By);
    paintBox1.canvas.ellipse(xi - dimPoint, yi - dimPoint, xi + dimPoint + 1, yi + dimPoint + 1);
    if i=0
       then paintBox1.canvas.moveTo(xi,yi)
       else paintBox1.canvas.lineTo(xi,yi);
end;
end;
End;


procedure TConvergenceModeleForm.Button1Click(Sender: TObject);
begin
   paintBox1.canvas.Pen.mode := pmCopy;
   paintBox1.canvas.brush.Color := clWindow;
   paintBox1.canvas.brush.style := bsSolid;
   paintBox1.canvas.FillRect(paintBox1.clientRect);
   TestContourSinCos
end;

procedure TConvergenceModeleForm.Button2Click(Sender: TObject);
begin
  paintBox1.canvas.Pen.mode := pmCopy;
  paintBox1.canvas.brush.Color := clWindow;
  paintBox1.canvas.brush.style := bsSolid;
  paintBox1.canvas.FillRect(paintBox1.clientRect);
  TestContourExp;
end;

procedure TConvergenceModeleForm.Button3Click(Sender: TObject);
begin
    traceConvergence;
end;

procedure TConvergenceModeleForm.FormCreate(Sender: TObject);
begin
     trace := traceP;
end;

end.
