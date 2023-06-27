{$F+} // pour passage de fonction en paramètres

Unit maths;

Interface

uses Windows, SysUtils, constreg, math, fspec;

const
    MaxVecteurDefaut = 2048;
    MaxVecteurSpline = 512;
    MaxMaxVecteur = 1048576; // 2^20 = 1 Mo
    MaxIntervalles = 4;
    MinPointsDerivee = 3;
    MaxPointsDerivee = 15;
    ordreMaxSpline = 7;
    ordreMinSpline = 3;

type
     TComplexe = record
         reel,imag : double;
     end;
     TFonctionMath = Function(x : double) : double;
     TVecteur = array of double;
     TVecteurInt = array of integer;
     TCodeIntervalle = 1..maxIntervalles;

     TFonctionMath2 = Function(im,re : double) : double;
     EComplexe = class(Exception);
     ECompile = class(Exception);
     ERegressi = class(Exception);
     TvecteurExtrapole = array[TcodeIntervalle] of Tvecteur;

const
     MaxReal : double = 1e+36;
     ComplexeUn : Tcomplexe = (reel : 1;imag : 0);
     ComplexeJ : Tcomplexe = (reel : 0;imag : 1);
     NbrePointDeriveeLisse = 41;

var
     NbrePointDerivee : integer = 5;
     DegreDerivee : integer = 2;
     AngleEnDegre : boolean = false;
     PrecisionPeigne : double = 1;
     OrdreFiltrage : integer = 2;
     extrapoleDerivee : boolean = true;

Function Dix(x : integer) : double;
Function MyLog(x : double) : double;
Function MyInt(x : double) : double;
Function Plafond(x : double) : double;
Function Plancher(x : double) : double;
Function Fract(x : double) : double;
Function MyRound(x : double) : double;
Function FonctionNot(x : double) : double;
Function Peigne(dt,t : double) : double;
Function Atan2(im,re:double) : double;
Function Gauss(X,Moyenne,Sigma : double) : double;
Function BesselJ(x,n : double) : double;
Function DerGaussMean(X,Moyenne,Sigma : double) : double;
Function DerGaussSigma(X,Moyenne,Sigma : double) : double;
Function Sinc(x : double) : double;
Function derSinc(x : double) : double;
Function BesselCard(x : double) : double;
Function derBesselCard(x : double) : double;
Function erf(x : double) : double;
Function MyTan(X : double) : double;
Function Sh(X : double) : double;
Function Ch(X : double) : double;
Function Th(X : double) : double;
Function MyArctan(x : double) : double;
Function MySin(x : double) : double;
Function MyCos(x : double) : double;
Function ASin(x : double) : double;
Function ACos(x : double) : double;
Function ATh(x : double) : double;
Function ACh(x : double) : double;
Function ASh(x : double) : double;
Function Identite(x : double) : double;
Function Nul(x : double) : double;
Function Arg(x : double) : double;
Function Aleat(x : double) : double;
Function Fgamma(x : double) : double;
Function Factorielle(x : double) : double;
Function Inv(x : double) : double;
Function Opp(x : double) : double;
Function Ech(x : double) : double;
Function Sign(x : double) : double;
Function MyLn(x : double) : double;
Function MyExp(x : double) : double;
Function MySqrt(x : double) : double;
Function MySqr(x : double) : double;
Function MyAbs(x : double) : double;
Procedure AngleEnRadian(var alpha : double);
Function Bruit(x : double) : double;
Function AngleUtilisateur(x : double) : double;
Function Student95(ddl : integer) : double;
Function Student99(ddl : integer) : double;
Function Creneau(t,f,RapportCyclique : double) : double;
Function Triangle(t,f,RapportCyclique : double) : double;
Function BitAleatoire(t,per : double;nombre : integer) : double;
Function ToDateTime(x : double) : double;
Function ToMois(x : double) : double;
Function ToAnnee(x : double) : double;
Function ToJour(x : double) : double;
Function ToHeure(x : double) : double;
function Puiss2Inf(N : LongInt) : LongInt;
// Puissance de 2 inférieure ou égale à N
function Puiss2Sup(N : LongInt) : LongInt;
// Puissance de 2 supérieure ou égale à N
Function PhaseModulo(X,debut,fin : double) : double;
// renvoie x entre debut et fin

Procedure PlusCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
Procedure MoinsCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
Procedure MultCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
Procedure DivCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
Procedure PuissCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
Procedure ExpCpx(X : Tcomplexe;var Z : Tcomplexe);
Function NormeCpx(X : Tcomplexe) : double;
Function ArgumentCpx(X : Tcomplexe) : double;
Procedure RacineCpx(X : Tcomplexe;var Z : Tcomplexe);
Function RealToCpx(X,Y : double) : Tcomplexe;
Function Poisson(X,Moyenne : double) : double;
Function Binomial(a : double;n,m : integer) : double;
Function CNP(n,p : integer) : double;
Function Chi2Inverse(alpha : double;m : integer) : double;
Procedure TestChi295(m : integer;var min,max : double);
Procedure TestChi299(m : integer;var min,max : double);
function pValue_Wald(r,n1,n2 : integer) : double;

Function SexVersDec(alpha : double) : double;

Procedure VerifMinMaxInt(var mini,maxi : integer);
Procedure VerifMinMaxReal(var mini,maxi : double);
Procedure GetMinMax(const V : Tvecteur;N : integer;var mini,maxi : double);
//procedure BuildAkimaSpline(X,Y : Tvecteur;N : Integer; var C : TCoeffSpline);
Procedure CalculBSpline(const X,Y : Tvecteur;ordre : integer;
   var N : integer;var Xspline,Yspline : Tvecteur);
Procedure InterpoleSinc(const X,Y : Tvecteur;ordre : integer;
   var N : integer;var Xspline,Yspline : Tvecteur);
Procedure CalculIntLineaire(const X,Y : Tvecteur;Debut,Fin,NbreLisse : integer;
          var XLisse,YLisse : Tvecteur);
procedure MoyGlissante(Y,Ylisse : Tvecteur;ordre,N : integer);
procedure MoyCentree(Y,Ylisse : Tvecteur;ordre,N : integer);
Procedure chercheMinMax(const X,Y : Tvecteur;N : integer;
   EnvMax : boolean;var jMax : integer;var Xe,Ye : Tvecteur);
Procedure chercheEnveloppe(const X : Tvecteur;N : integer;
                           const Xe,Ye : Tvecteur;Ne : integer;
                           var Env : Tvecteur);

Procedure Swap(var v1,v2 : Tvecteur); overload;
Procedure CopyVecteur(var destination : Tvecteur; const source : Tvecteur);
Procedure AffecteVecteur(var destination : Tvecteur; const source : Tvecteur);
Procedure setTailleVecteur(var v : Tvecteur;Nbre : integer);
Procedure Swap(var v1,v2 : double); overload;
Procedure Swap(var v1,v2 : integer); overload;

Function isEntier(x : double;var n : integer) : boolean;
function isCorrect(aValue : double) : boolean;
function isIncorrect(aValue : double) : boolean;

const
   degreMax = 4;
   ordreMax = degreMax+1;

type
   Tmatrice = array[1..ordreMax,1..ordreMax+1] of double;
   TmatriceLigne = array[1..ordreMax] of double;
   EsystemeLineaireError = class(Exception);
   TvectorPuiss = array[0..2*degreMax] of double;

Procedure DeriveeGauss(const X,Yr : Tvecteur;N : integer;
        var Yder : Tvecteur;degreDer,NbrePointDer : integer);
procedure DeriveeLisse(const X,Y : Tvecteur;
        const NbrePointDeriveeL : integer;
        index : integer;
        var Xl,Yl,Yder : Tvecteur);
Function DeriveePonctuelle(const X,Y : Tvecteur;index,N : integer;
       degreDer,NbrePointDer : integer) : double;
function DeriveePonctuelleSpline(const X,Y : Tvecteur;
     index : integer;Xi : double) : double;
Procedure DeriveeSecondeGauss(const X,Yr : Tvecteur;N : integer;
              var Yder : Tvecteur;degreDer,NbrePointDer : integer);
Function DeriveeSecondePonctuelle(const X,Y : Tvecteur;index,N : integer;
       degreDer,NbrePointDer : integer) : double;
Procedure IncertitudeDerivee(const X,Y,dX,dY : Tvecteur;N : integer;
              var Yder : Tvecteur;NbrePointder : integer);
Function CalculSurface(const X,Y : Tvecteur;N : integer) : double;
Procedure Resolution(A : Tmatrice;ordre : integer;var Result : TmatriceLigne);
Procedure CherchePeriode(const Y : Tvecteur;nbre : integer;var iDebut,iFin : integer);
procedure MaxiMini(vect: Tvecteur; var max, min: double; Debut, Fin: integer);

Implementation

const
   OrdreMaxMoy = 32;
   ComplexeNAN : Tcomplexe = (reel : Nan;imag : Nan);
   ConversionSecondeJour = 1/24/60/60; // 24 heures 60 minutes 60 secondes
var
   bitCourant : integer = 1;
   periodeCourante : double = 0;

type
   TCoeffSpline = array[0..3] of Tvecteur;

function isCorrect(aValue : double) : boolean;
begin
    result := not (isNan(aValue) or isInfinite(aValue))
end;

function isIncorrect(aValue : double) : boolean;
begin
    result := isNan(aValue) or isInfinite(aValue)
end;

function pWald_exact(r,n1,n2 : integer) : double;

Function Ppaire(u : integer) : double;
begin
    u := u div 2;
    result := 2*Cnp(n1-1,u-1)*Cnp(n2-1,u-1)/cnp(n1+n2,n1)
end;

Function Pimpaire(u : integer) : double;
begin
    u := u div 2;
    result := (Cnp(n1-1,u-1)*Cnp(n2-1,u)+Cnp(n1-1,u)*Cnp(n2-1,u-1))/cnp(n1+n2,n1)
end;

Function Psup(r : integer) : double;
var Rmax,v : integer;
    p : double;
begin
    if n1<n2 then Rmax := 2*n1+1 else Rmax := 2*n2+1;
    p := 0;
    for v := r to Rmax do
        if odd(v)
           then p := p + Pimpaire(v)
           else p := p + Ppaire(v);
    result := p;
end;

Function Pinf(r : integer) : double;
var v : integer;
    p : double;
begin
    p := 0;
    for v := 2 to r do
        if odd(v)
           then p := p + Pimpaire(v)
           else p := p + Ppaire(v);
    result := p;
end;

var vinf,vsup : integer;
    ER : double;
    pi,ps : double;
begin
    ER := 2*n1*n2/(n1+n2)+1;
    vinf := floor(ER-abs(r-ER));
    vsup := ceil(ER+abs(r-ER));
    Pi := Pinf(vinf);
    Ps := Psup(vsup);
    result := Ps+Pi;
end;

function pWald_Gauss(r,n1,n2 : integer) : double;
var mu,sigma,Z : double;
// suppose n1 et n2 >10
//    Zc : double;
begin
     mu := 2*n1*n2/(n1+n2)+1;
     sigma := sqrt((mu-1)*(mu-2)/(n1+n2-1));
     Z := (r-mu)/sigma;
   //  Zc := (abs(r-mu)-0.5)/sigma;
   //  result := PNorm(Zc);
     result := PNorm(Z);
end;

function pValue_Wald(r,n1,n2 : integer) : double;
begin
     if ((n1>10) and (n2>10)) or ((n1+n2)>20)
        then result := pWald_Gauss(r,n1,n2)
        else result := pWald_exact(r,n1,n2)
end;

procedure MaxiMini(vect: Tvecteur; var max, min: double; Debut, Fin: integer);
var
  j: integer;
  z : double;
begin
  while (debut<fin) and isIncorrect(vect[debut]) do inc(debut);
  Max := vect[debut];
  min := max;
  for j := succ(debut) to Fin do begin
    z := vect[j];
    if isCorrect(z) then
       if z > Max then
          Max := z
    else if z < Min then
      Min := z;
  end;
end; // maxiMini

(*
Function DecVersSex(alpha : double) : double;
begin
   DecVersSex := int(alpha)+frac(alpha)*0.6
end;
*)

Function SexVersDec(alpha : double) : double;
var deg,minute,seconde : double;
    negatif : boolean;
begin
   negatif := alpha<0;
   alpha := abs(alpha);
   deg := int(alpha);
   alpha := (alpha-deg)*100;
   minute := int(alpha);
   if minute>60 then begin
      result := Nan;
      exit;
   end;
   alpha := (alpha-minute)*100;
   seconde := round(alpha);
   if seconde>98
      then begin
         minute := minute+1; // pb d'arrondi .5999999 = .6000
         seconde := 0;
      end
      else if seconde>60 then begin
         result := Nan;
         exit;
      end;
   result := deg+minute/60+seconde/3600;
   if negatif then result := -result
end;

Procedure AngleEnRadian(var alpha : double);
// donne l'angle en radian correspondant à l'angle exprimé en unité courante
begin
    if angleEnDegre then
        alpha := DegToRad(alpha)
end;

Function AngleUtilisateur(x : double) : double;
// donne l'angle en uniteCourante correspondant à l'angle exprimé en radian
begin
   if angleEnDegre
      then result := RadToDeg(x)
      else result := x
end;

Function PuissEnt(X:double;N:Integer): double;

  Function Puiss2(N:integer):double; { N>=0 }
  var Y : double;
  begin
     if N=0
        then Puiss2 := 1
        else begin
           Y := Puiss2(N div 2);
	         Y := Sqr(Y);
 	         if (N mod 2)=0
	           then Puiss2 := Y
	           else Puiss2 := X*Y;
        end;
  end;{ puiss2 }

begin {PuissEnt}
    If N<0
       then PuissEnt := 1/Puiss2(-N)
       else PuissEnt := Puiss2(N)
end;{PuissEnt}

function Dix(x : integer) : double;
Begin
    Dix := PuissEnt(10,X)
end;

Function MyLog(X:double):double;
Begin
   result := Log10(X)
End;

function MyInt(x : double) : double;
begin
    result := floor(x)
end;

function Plafond(x : double) : double;
begin
    result := ceil(x)
end;

function Plancher(x : double) : double;
begin
    result := floor(x)
end;

function Fract(x : double) : double;
var zut : double;
begin
     Zut := frac(x);
     if (x>=0) or (zut=0)
        then Fract := zut
        else Fract := zut+1
end;

function MyRound(x : double) : double;
begin
     result := round(x)
end;

function FonctionNot(x : double) : double;
var xi : word;
begin
     try
     xi := round(x);
     if xi=0
        then result := 1
        else result := 0;
     except
        result := 0;
     end
end;

Function Atan2(im,re:double) : double;
// z = re + j*im
var valeur : double;
begin
   if re=0
      then if im<0
          then valeur := -pi/2
          else valeur := pi/2
      else valeur := arcTan2(im,re);
   result := AngleUtilisateur(valeur);
end;

Function Gauss(X,Moyenne,Sigma : double) : double;
Const Coeff = 0.39894228040; { 1/sqrt(2*pi) }
begin
    Gauss := Coeff*exp(-sqr((x-moyenne)/sigma)/2)/sigma
end;

Function DerGaussMean(X,Moyenne,Sigma : double) : double;
begin
    result := Gauss(X,Moyenne,Sigma)*(x-moyenne)/sqr(sigma)
end;

Function DerGaussSigma(X,Moyenne,Sigma : double) : double;
begin
    result := Gauss(X,Moyenne,Sigma)*sqr((x-moyenne)/sigma)/sigma
end;

Function sinc(x : double) : double;
begin
   try
      AngleEnRadian(x);
      if isZero(x,1e-6)
        then result := 1
        else result := sin(x)/x;
   except
      result := 1
   end;
end;

Function derSinc(x : double) : double;
begin
    try
      AngleEnRadian(X);
      if isZero(x,1e-6)
         then result := 0
         else result := (X*cos(X)-sin(X))/sqr(x);
    except
      result := 0
    end;
end;

Function MyTan(X:double):double;
Begin
    angleEnRadian(X);
    result := tan(x);
End;

Function MyCos(X:double):double;
Begin
    angleEnRadian(X);
    result := cos(x);
End;

Function MySin(X:double):double;
Begin
    angleEnRadian(X);
    result := sin(x);
End;

Function Sign(X:double):double;
Begin
  If X>=0 Then Sign:=+1 Else Sign:=-1
End;

Function MyAbs(x : double) : double;
begin
   MyAbs := Abs(X)
end;

Function Ech(x : double) : double;
begin
   if X>=0
        then Ech := 1
        else Ech := 0
end;

Function MySqr(x : double) : double;
Begin
     MySqr := Sqr(X)
end;

Function MySqrt(x : double) : double;
begin
     MySqrt := Sqrt(x)
end;

Function MyExp(x: double) : double;
begin
    MyExp := Exp(x)
end;

Function MyLn(x : double) : double;
begin
    MyLn := ln(x)
end;

Function Opp(x : double) : double;
begin
   opp := -X
end;

Function Inv(x : double) : double;
begin
     Inv := 1/x
end;

Function Nul(x : double) : double;
begin
    Nul := Nan
end;

Function Aleat(x : double) : double;
// Aléatoire entre 0 et +x
begin
   result := X*Random
end;

Function Arg(x : double) : double;
begin
   if X<0
     then if angleEnDegre
         then arg := 180
         else arg := pi
     else arg := 0
end;

Function MyArcTan(x : double) : double;
begin
     MyArcTan := AngleUtilisateur(ArcTan(X))
end;

Function Identite(x : double) : double;
begin
    Identite := x
end;

Function Th(X : double) : double;
begin
     Th := tanh(x)
end;

Function Ch(X : double) : double;
begin
     Ch := Cosh(x)
end;

Function Sh(X : double) : double;
begin
    Sh := Sinh(x)
end;

function ASIN(x : double): double;
var valeur : double;
begin
     try
       valeur := ArcSin(x)
     except
         on EMathError do begin
            if round(x)=1
               then valeur := +pi/2
               else valeur := -pi/2;
         end;
     end;
     asin := angleUtilisateur(valeur)
end;

function ACOS(x : double): double;
var valeur : double;
begin
   try
     valeur := ArcCos(x);
   except
         on EMathError do
            if x<0
               then valeur :=  -pi/2
               else valeur :=  +pi/2
   end;
   acos := AngleUtilisateur(valeur);
end;

Function Ath(x: double): double;
begin
  result := arcTanh(x)
end;

Function ACh(x: double): double;
begin
  result := arcCosh(x)
end;

Function ASh(x: double): double;
begin
  result := arcSinh(x)
end;

const

maxStudent = 20;

TableStudent95 : array[1..maxStudent] of double =
(12.71,4.30,3.182,2.776,2.571,2.447,2.365,2.306,2.262,2.228,
 2.201,2.179,2.160,2.145,2.131,2.120,2.110,2.101,2.093,2.086);

TableStudent99 : array[1..maxStudent] of double =
(63.65,9.925,5.841,4.604,4.032,3.707,3.499,3.355,3.250,3.169,
 3.106,3.055,3.012,2.977,2.947,2.921,2.898,2.878,2.861,2.845);

Function Student95(ddl : integer) : double;
begin
    if ddl<1
       then result := 0
       else if ddl<=20 then result := TableStudent95[ddl]
       else student95 := ((4.5082/ddl+2.3090)/ddl+2.4033)/ddl+1.960
end;

Function Student99(ddl : integer) : double;
begin
    if ddl<1
       then result := 0
       else if ddl<=20 then result := TableStudent99[ddl]
       else student99 := ((29.769/ddl+4.0933)/ddl+5.1992)/ddl+2.576
end;

Procedure VerifMinMaxInt(var mini,maxi : integer);
var z : integer;
begin
     if Maxi<Mini then begin
    	  z := Maxi;
    	  Maxi := Mini;
	      Mini := z;
     end
end;

Procedure VerifMinMaxReal(var mini,maxi : double);
var z : double;
begin
     if isIncorrect(maxi) or isIncorrect(mini) then exit;
     if Maxi<Mini then begin
     	  z := Maxi;
    	  Maxi := Mini;
	      Mini := z;
     end
end;

Procedure Swap(var v1,v2 : Tvecteur);
var v3 : Tvecteur;
begin
     v3 := v1;
     v1 := v2;
     v2 := v3;
end;

Procedure CopyVecteur(var destination : Tvecteur;const source : Tvecteur);
begin
     destination := nil;// libére si existe déjà
     destination := copy(source,0,high(source)+1);
end;

Procedure AffecteVecteur(var destination : Tvecteur;const source : Tvecteur);
var i : integer;
begin
    if high(destination)<high(source) then
        setLength(destination,high(source)+1);
    for i := 0 to high(source) do
        destination[i] := source[i];
end;

Procedure Swap(var v1,v2 : double);
var v3 : double;
begin
     v3 := v1;
     v1 := v2;
     v2 := v3
end;

Procedure Swap(var v1,v2 : integer);
var v3 : integer;
begin
     v3 := v1;
     v1 := v2;
     v2 := v3
end;

Procedure PlusCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
begin
     Z.reel := X.reel+Y.reel;
     Z.imag := X.imag+Y.imag
end;

Procedure MoinsCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
begin
     Z.reel := X.reel-Y.reel;
     Z.imag := X.imag-Y.imag
end;

Procedure MultCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
begin
     Z.reel := X.reel*Y.reel-X.imag*Y.imag;
     Z.imag := X.reel*Y.imag+X.imag*Y.reel
end;

Function NormeCpx(X : Tcomplexe) : double;
begin
     normeCpx := sqrt(sqr(X.reel)+sqr(X.imag))
end;

Function ArgumentCpx(X : Tcomplexe) : double;
begin
   try
   result := X.imag/X.reel;
   result := arcTan(result);
   if X.reel<0
     then if X.imag<0
        then result := result-pi
        else result := result+pi;
   except
//         on EZeroDivide do begin
         on EMathError do begin
            if X.imag<0
	             then argumentCpx := -pi/2
               else argumentCpx := pi/2;
         end;
   end;
end;

Procedure DivCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
var n2 : double;
begin
    try
    n2 := sqr(Y.reel)+sqr(Y.imag);
    Z.reel := (x.reel*y.reel+x.imag*y.imag)/n2;
    Z.imag := (y.reel*x.imag-y.imag*x.reel)/n2;
    except
        Z := ComplexeNAN;
        raise
    end;
end;

Procedure RacineCpx(X : Tcomplexe;var Z : Tcomplexe);
var norme,phi : double;
begin
    try
    norme := sqrt(normeCpx(X));
    phi := argumentCpx(X)/2;
    Z.reel := norme*cos(phi);
    Z.imag := norme*sin(phi);
    except
        Z := ComplexeNAN;
        raise
    end;
end;

Function NormeArgToCpx(n,a : double) : Tcomplexe;
var z : Tcomplexe;
begin
     z.reel := n*cos(a);
     z.imag := n*sin(a);
     NormeArgToCpx := z;
end;

Procedure PuissCpx(X,Y : Tcomplexe;var Z : Tcomplexe);
var n : integer;
    Norme,Argument : double;
begin
    if abs(Y.imag)>0
       then raise EComplexe.Create(erPuissEnt)
       else begin
           if isEntier(Y.reel,n)
              Then begin
                   Norme := PuissEnt(NormeCpx(x),n);
                   Argument := ArgumentCpx(x)*n;
                   z := NormeArgToCpx(Norme,Argument);
              end
              Else raise EComplexe.Create(ErPuissEnt);
      end
end;

Procedure ExpCpx(X : Tcomplexe;var Z : Tcomplexe);
var y : double;
begin
     y := exp(x.reel);
     z.reel := y*cos(x.imag);
     z.imag := y*sin(x.imag)
end;

Procedure GetMinMax(const V : Tvecteur;N : integer;var mini,maxi : double);
var i,j : integer;
begin
     j := 0;
     while (j<N) and isNan(V[j]) do inc(j);
     if j=N then begin
        Mini := 0;
        Maxi := 0;
        exit;
     end;
     Mini := V[j];
     Maxi := V[j];
     for i := succ(j) to pred(N) do
         if isNan(V[i]) then
         else if V[i]>Maxi
            then Maxi := V[i]
            else if V[i]<Mini
               then Mini := V[i]
end;

Function RealToCpx(X,Y : double) : Tcomplexe;
var z : Tcomplexe;
begin
     z.reel := X;
     z.imag := Y;
     RealToCpx := z;
end;

Function Creneau(t,f,RapportCyclique : double) : double;
var z1 : double;
begin
     z1 := t*f;
     z1 := z1-floor(z1);
     if z1<rapportCyclique then creneau := 1 else creneau := -1
end;

Function Triangle(t,f,RapportCyclique : double) : double;
var z1 : double;
begin
     z1 := t*f; // temps réduit
     z1 := z1-floor(z1); // temps réduit modulo une période
     try
     if z1<rapportCyclique
        then triangle := -1+2*z1/rapportCyclique
        else triangle := +1-2*(z1-rapportCyclique)/(1-rapportCyclique)
     except
        triangle := 0
     end
end;

Function BitAleatoire(t,per : double;nombre : integer) : double;
var numPeriode,tirage : double;
    maxi : integer;
begin
     maxi := 1 shl nombre;
     NumPeriode := round(t/per)*maxi; // numéro de la période
     if numPeriode<>PeriodeCourante then begin
        tirage := random*maxi;
        bitCourant := trunc(tirage);
        periodeCourante := numPeriode;
     end;
     result := bitCourant;
end;

function Puiss2Inf(N : LongInt) : LongInt;
begin
    result := 1;
    while result<N do result := 2*result;
    if result>N then result := result div 2;
end;

function Puiss2Sup(N : LongInt) : LongInt;
begin
    result := Puiss2Inf(N);
    if result<N then result := 2*result;
end;

Function Cnp(n,p : integer) : double;
var m : integer;
    c : double;
begin
    if n<p then swap(n,p); // erreur de syntaxe
    c := 1;
    for m := 1 to p do
        c := c*(n-m+1)/m;
    result := c;    
end;

Function Poisson(X,Moyenne : double) : double;
var z,Facteur,MX : double;
    i,iX : integer;
begin
    iX := round(X);
    if iX<0 then iX := 0;
    if iX=0
       then z := exp(-Moyenne)
       else begin
          MX := moyenne/iX;
          Facteur := exp(-MX)*Moyenne;
          z := facteur;
          for i := 2 to iX do z := z*facteur/i;
       end;
    Poisson := z;
end;

Function Binomial(a : double;n,m : integer) : double;
var z,F1,F2 : double;
begin
    if m=0
       then z := power(1-a/n,n-m)
       else begin
          F1 := power(a/n,m);
          F2 := power(1-a/n,n-m);
          z := F1*F2*Cnp(m,n);
       end;
    result := z;
end;

Function BesselCard(x : double) : double;
const
   xi : array[1..6] of double =
      (0.2386191861,0.6612093865,0.9324695142,-0.2386191861,-0.6612093865,-0.9324695142);
   wi : array[1..6] of double =
      (0.4679139346,0.3607615730,0.1713244924,0.4679139346,0.3607615730,0.1713244924);
var
    i : integer;
    f,t : double;
begin
    angleEnRadian(x);
    if abs(X)>15
       then result := 0
       else begin
          f := 0;
          try
          for i := 1 to 6 do begin
              t := 0.5+xi[i]*0.5;
              f := f+wi[i]*cos(t*X)*sqrt(1-t*t);
          end;
          result := f/pi;
          except
             result := 0.5;
          end;
    end;
end;

Function DerBesselCard(x : double) : double;
const
   xi : array[1..6] of double =
      (0.2386191861,0.6612093865,0.9324695142,-0.2386191861,-0.6612093865,-0.9324695142);
   wi : array[1..6] of double =
      (0.4679139346,0.3607615730,0.1713244924,0.4679139346,0.3607615730,0.1713244924);
var
    i : integer;
    f,t : double;
begin
    angleEnRadian(x);
    if abs(X)>15
       then result := 0
       else begin
           f := 0;
           try
           for i := 1 to 6 do begin
              t := 0.5+xi[i]*0.5;
              f := f+wi[i]*cos(t*x)*Power(1-t*t,3/2);
           end;
           result := -F*X/pi/3;
           except
              result := 0;
           end;
    end
end;

Procedure CherchePeriode(const Y : Tvecteur;nbre : integer;var iDebut,iFin : integer);
const NbreRef = 5;
var Ymin,Ymax,Ymoy : double;
    ecartQuad,ecartMin,ecartMinQuad : double;
    i,j : integer;
begin
     if nbre<2*NbreRef then begin
        iDebut := 0;
        iFin := pred(nbre);
        exit;
     end;
     Ymin := y[0];
     Ymax := Ymin;
     for i := 1 to pred(nbre) do
         if y[i]>Ymax
             then Ymax := Y[i]
             else if y[i]<Ymin then Ymin := y[i];
     Ymoy := (Ymax+Ymin)/2;
     ecartMin := (Ymax-Ymin)/20;
     ecartMinQuad := sqr(ecartMin)*NbreRef;
     iDebut := 0;
     repeat inc(iDebut)
     until ((Y[iDebut]-Ymoy)*(Y[0]-Ymoy)<0) or (iDebut=Nbre div 2);
 // Premier passage par "zéro" (vers le bas par ex.)
     iFin := iDebut+NbreRef;
     while (iFin<pred(Nbre)) and
           ((Y[iDebut]-Ymoy)*(Y[iFin]-Ymoy)>=0) do inc(iFin);
 // On repasse au dessus (par ex.) du "zéro"
     iFin := iFin+NbreRef;
     while (iFin<pred(Nbre)) and
           ((Y[iDebut]-Ymoy)*(Y[iFin]-Ymoy)<=0) do inc(iFin);
// On repasse par "zéro" dans le même sens
     for i := iFin to pred(Nbre-NbreRef) do
         if abs(Y[i]-Ymoy)<ecartMin then begin
                ecartQuad := 0;
                for j := 0 to pred(NbreRef) do
                    ecartQuad := ecartQuad + sqr(Y[i+j]-Y[iDebut+j]);
                if ecartQuad<ecartMinQuad then begin { Meilleure ressemblance }
                   ecartMinQuad := ecartQuad;
                   ecartMin := sqrt(ecartMinQuad/NbreRef);
                   iFin := i;
                end;
         end;
     dec(iFin);
end;

Procedure Resolution(A : Tmatrice;ordre : integer;var Result : TmatriceLigne);
 { Cette procédure résoud un système AX = B }
 { écrit sous la forme AX = A(n+1) }
 { par la méthode d'élimination de Gauss (pivot partiel) }

  Procedure Elimination;

    FUNCTION Pivot(i :integer):integer;
    Var n,temp : integer;
    BEGIN
      temp := i;
      for n := i+1 to ordre do
          if abs(A[n,i]) > abs(A[i,i]) then temp:= n;
      pivot:=temp;
      if abs(A[temp,i]) <= 1e-100 then
         raise EsystemeLineaireError.Create(erSysLin)
    END;

    PROCEDURE Permute(i,j:integer);
    Var temp:double;
        k:integer;
    BEGIN
       if i<>j then For k:=i to ordre+1 do BEGIN
          temp:=A[i,k];
          A[i,k]:=A[j,k];
          A[j,k]:=temp;
       END;
    END;

  var I,J,K : integer;
      M : double;
  begin
    for k := 1 to ordre do begin
          Permute(k,pivot(k));
          for i:=k+1 to ordre do begin
              M := A[i,k]/A[k,k];
              for j:=k+1 to ordre+1 do A[i,j]:=A[i,j]-M*A[k,j];
              A[i,k]:=0.0;
          end;
       end;
    end; // Elimination

    Procedure Substitution;
    var I,J : integer;
        S : double;
    begin
         try
         for I:=ordre downto 1 do begin
             S:=A[I,ordre+1];
             for J:=I+1 to ordre do S:=S-A[I,J]*Result[J];
             Result[I]:=S/A[I,I];
         end;
         except
            on EzeroDivide do raise EsystemeLineaireError.Create(erSysLin)
         end;
    end;

begin
  Elimination;
  Substitution;
end; // Résolution

procedure DeriveeGauss(const X,Yr : Tvecteur;N : integer;
   var Yder : Tvecteur;degreDer,NbrePointDer : integer);
var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    ii,puissMax,ordre : integer;

procedure initXY;
var j : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := NbrePointDer;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    for j := 0 to pred(NbrePointDer) do begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := yr[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
    end;
end;

Procedure CalculXY(i : integer);
var ajoute,retire : double;
    k : integer;
begin
        ajoute := X[i+ii];
        retire := X[i-ii-1];
        for k := 1 to puissMax do begin
            puissX[k] := puissX[k]+ajoute-retire;
            retire := retire*X[i-ii-1];
            ajoute := ajoute*X[i+ii];
        end;
        ajoute := Yr[i+ii];
        retire := Yr[i-ii-1];
        for k := 1 to ordre do begin
            A[k,ordre+1] := A[k,ordre+1]+ajoute-retire;
            retire := retire*X[i-ii-1];
            ajoute := ajoute*X[i+ii];
        end;
end;

procedure AffecteCoeff;
var i,j : integer;
begin
     for i := 1 to ordre do
         for j := 1 to ordre do
             A[i,j] := PuissX[i+j-2];
     try
     Resolution(A,ordre,Coeff);
     except
         coeff[2] := Nan;
         coeff[3] := 0;
         coeff[4] := 0;
     end;
end;

Procedure AffecteDerivee(i : integer);
begin
   case degreDer of
        1 : yder[i] := coeff[2];
        2 : yder[i] := coeff[2]+2*coeff[3]*x[i];
        3 : yder[i] := coeff[2]+x[i]*(2*coeff[3]+3*coeff[4]*x[i]);
   end;
end;

var i : integer;
begin // DeriveeGauss
    for i := 0 to pred(N) do yder[i] := Nan;
    if N<NbrePointDer then begin
       repeat
          dec(NbrePointDer,2)
       until (N>=NbrePointDer) or (NbrePointDer<=MinPointsDerivee);
       if N<NbrePointDer then exit;
    end;
    if NbrePointDer<MinPointsDerivee
       then NbrePointDer := MinPointsDerivee;
    if (degreDer=3) and (NbrePointDer<5) then degreDer := 2;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    ii := NbrePointDer div 2;
    initXY;
    affecteCoeff;
    if extrapoleDerivee then
       for i := 0 to pred(ii) do affecteDerivee(i);
    affecteDerivee(ii);
    for i := ii+1 to N-ii-1 do begin
        calculXY(i);
        affecteCoeff;
        affecteDerivee(i);
    end;
    if extrapoleDerivee then
       for i := N-ii to pred(N) do affecteDerivee(i);
end; // DeriveeGauss

procedure DeriveeLisse(const X,Y : Tvecteur;
     const NbrePointDeriveeL : integer;
     index : integer;
     var Xl,Yl,Yder : Tvecteur);

var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    ecart,puissMax,ordre : integer;
    x0,x2,deltax : double;
    DegreDeriveeL,NDiv2 : integer;

procedure initXY;
var j : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := NbrePointDeriveeL;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    for j := index-ecart to index+ecart do begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := y[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
    end;
end;

procedure AffecteCoeff;
var i,j : integer;
begin
     for i := 1 to ordre do
         for j := 1 to ordre do
             A[i,j] := PuissX[i+j-2];
     try
     Resolution(A,ordre,Coeff);
     except
         coeff[2] := Nan;
         coeff[3] := 0;
         coeff[4] := 0;
     end;
end;

Procedure AffecteDerivee(i : integer);
begin
   case degreDeriveeL of
        1 : begin
           yder[i] := coeff[2];
           yl[i] := coeff[1]+coeff[2]*xl[i];
        end;
        2 : begin
           yder[i] := coeff[2]+2*coeff[3]*xl[i];
           yl[i] := coeff[1]+xl[i]*(coeff[2]+coeff[3]*xl[i]);
        end;
        3 : begin
           yder[i] := coeff[2]+xl[i]*(2*coeff[3]+3*coeff[4]*xl[i]);
           yl[i] := coeff[1]+xl[i]*(coeff[2]+(coeff[3]+coeff[4]*xl[i])*xl[i]);
        end;
   end;
end;

var i,j : integer;
begin // DeriveeLisse
    Ndiv2 := NbrePointDeriveeLisse div 2;
    setLength(xl,NbrePointDeriveeLisse+1);
    setLength(yl,NbrePointDeriveeLisse+1);
    setLength(yder,NbrePointDeriveeLisse+1);
    degreDeriveeL := 2;
    (*
    if NbrePointDeriveeL>5
       then degreDeriveeL := 3
       else degreDeriveeL := 2;
    *)
    ordre := degreDeriveeL+1;
    puissMax := 2*degreDeriveeL;
    ecart := NbrePointDeriveeL div 2;
    initXY;
    affecteCoeff;
    x0 := x[index];
    x2 := x[index+ecart];
    deltax := (x2-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       j := i+Ndiv2;
       xl[j] := x0+i*deltax;
       affecteDerivee(j);
    end;
    x2 := x[index-ecart];
    deltax := (x2-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       j := Ndiv2-i;
       xl[j] := x0+i*deltax;
       affecteDerivee(j);
    end;
end; // DeriveeLisse

function DeriveePonctuelleSpline(const X,Y : Tvecteur;
     index : integer;Xi : double) : double;

const NbrePointDeriveeL = 3;
      degreDeriveeL = 2;
      ordre = degreDeriveeL+1;
      puissMax = 2*degreDeriveeL;

var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;

procedure initXY;
var j : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := NbrePointDeriveeL;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    for j := index-1 to index+1 do begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := y[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
    end;
end;

procedure AffecteCoeff;
var i,j : integer;
begin
     for i := 1 to ordre do
         for j := 1 to ordre do
             A[i,j] := PuissX[i+j-2];
     try
     Resolution(A,ordre,Coeff);
     except
         coeff[2] := Nan;
         coeff[3] := 0;
         coeff[4] := 0;
     end;
end;

begin
    initXY;
    affecteCoeff;
    result := coeff[2]+2*coeff[3]*xi;
end; // DeriveePonctuelleSpline

procedure DeriveeSecondeGauss(const X,Yr : Tvecteur;N : integer;
                              var Yder : Tvecteur;degreDer,NbrePointDer : integer);
var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    ii,puissMax,ordre : integer;

procedure initXY;
var j : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := NbrePointDer;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    for j := 0 to pred(NbrePointDer) do begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := yr[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
    end;
end;

Procedure CalculXY(i : integer);
var ajoute,retire : double;
    k : integer;
begin
        ajoute := X[i+ii];
        retire := X[i-ii-1];
        for k := 1 to puissMax do begin
            puissX[k] := puissX[k]+ajoute-retire;
            retire := retire*X[i-ii-1];
            ajoute := ajoute*X[i+ii];
        end;
        ajoute := Yr[i+ii];
        retire := Yr[i-ii-1];
        for k := 1 to ordre do begin
            A[k,ordre+1] := A[k,ordre+1]+ajoute-retire;
            retire := retire*X[i-ii-1];
            ajoute := ajoute*X[i+ii];
        end;
end;

procedure AffecteCoeff;
var i,j : integer;
begin
     for i := 1 to ordre do
         for j := 1 to ordre do
             A[i,j] := PuissX[i+j-2];
     try
     Resolution(A,ordre,Coeff);
     except
         coeff[3] := Nan;
         coeff[4] := 0;
     end;
end;

Procedure AffecteDerivee(i : integer);
begin
   case degreDer of
        1 : yder[i] := 0;
        2 : yder[i] := 2*coeff[3];
        3 : yder[i] := 2*coeff[3]+x[i]*6*coeff[4];
   end;
end;

var i : integer;
begin // DeriveeSecondeGauss
    for i := 0 to pred(N) do yder[i] := Nan;
    if N<NbrePointDer then exit;
    if degreDer<2 then degreDer := 2;
    if NbrePointDer<5 then NbrePointDer := 5;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    ii := NbrePointDer div 2;
    initXY;
    affecteCoeff;
    for i := 0 to ii do affecteDerivee(i);
    for i := ii+1 to N-ii-1 do begin
        calculXY(i);
        affecteCoeff;
        affecteDerivee(i);
    end;
    for i := N-ii to pred(N) do affecteDerivee(i);
end; // DeriveeSecondeGauss

function DeriveePonctuelle(const X,Y : Tvecteur;index,N : integer;degreDer,NbrePointDer : integer) : double;
var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    puissMax,ordre : integer;

procedure initXY;
var j,jdebut,jfin : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := 0;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    jdebut := index-(NbrePointDer div 2);
    if jdebut<0 then jdebut := 0;
    jfin := jDebut+NbrePointDer;
    if jfin>=N then begin
       jfin := pred(N);
       jdebut := jfin-NbrePointDer;
    end;
    for j := jdebut to jfin do if
       not isNan(X[j]) and not isNan(Y[j]) then begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := y[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
        puissX[0] := puissX[0] + 1;
    end;
    for i := 1 to ordre do
        for j := 1 to ordre do
            A[i,j] := PuissX[i+j-2];
end;

begin // DeriveePonctuelle
    result := Nan;
    if isNan(X[index]) or isNan(Y[index]) then exit;
    while (NbrePointDer>MinPointsDerivee) and (N<=NbrePointDer) do dec(NbrePointDer,2);
    if (N<=NbrePointDer) then exit;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    initXY;
    try
    Resolution(A,ordre,Coeff);
    case degreDerivee of
        1 : result := coeff[2];
        2 : result := coeff[2]+2*coeff[3]*x[index];
        3 : result := coeff[2]+x[index]*(2*coeff[3]+3*coeff[4]*x[index]);
        else result := Nan;
    end;
    except
         result := Nan;
    end;
end; // DeriveePonctuelle

function DeriveeSecondePonctuelle(const X,Y : Tvecteur;index,N : integer;degreDer,NbrePointDer : integer) : double;
var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    puissMax,ordre : integer;

procedure initXY;
var j,jdebut,jfin : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := 0;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    jdebut := index-(NbrePointDer div 2);
    if jdebut<0 then jdebut := 0;
    jfin := jDebut+NbrePointDer;
    if jfin>=N then begin
       jfin := pred(N);
       jdebut := jfin-NbrePointDer;
    end;
    for j := jdebut to jfin do if
       not isNan(X[j]) and not isNan(Y[j]) then begin
        loc := x[j];
        for i := 1 to puissMax do begin
            puissX[i] := puissX[i]+loc;
            loc := loc*x[j];
        end;
        loc := y[j];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*x[j];
        end;
        puissX[0] := puissX[0] + 1;
    end;
    for i := 1 to ordre do
        for j := 1 to ordre do
            A[i,j] := PuissX[i+j-2];
end;

begin // DeriveeSecondePonctuelle
    result := Nan;
    if isNan(X[index]) or isNan(Y[index]) then exit;
    while (NbrePointDer>MinPointsDerivee) and (N<=NbrePointDer) do dec(NbrePointDer,2);
    if (N<=NbrePointDer) then exit;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    initXY;
    try
    Resolution(A,ordre,Coeff);
    result := 2*coeff[3];
    except
         result := Nan;
    end;
end; // DeriveeSecondePonctuelle

procedure IncertitudeDerivee(const X,Y,dX,dY:Tvecteur;N : integer;
   var Yder : Tvecteur;NbrePointDer : integer);
var i : integer;
    deltaX,deltaY,coeff : double;
begin
    if N<3 then exit;
    for i := 1 to N-2 do
        try
        DeltaX := abs(x[pred(i)]-x[succ(i)]);
        DeltaY := abs(y[pred(i)]-y[succ(i)]);
        yder[i] := sqrt(sqr(deltaX)*(sqr(dy[pred(i)])+sqr(dy[succ(i)]))+
                        sqr(deltaY)*(sqr(dx[pred(i)])+sqr(dx[succ(i)])))/sqr(deltaX);
        except
        yder[i] := Nan;
        end;
    yder[0] := yder[1];
    yder[pred(N)] := yder[N-2];
    coeff := 1/sqrt(NbrePointDer);
    for i := 0 to pred(N) do
        if not isNan(yder[i]) then yder[i] := yder[i]*coeff;
end; // IncertitudeDerivee

Function CalculSurface(const X,Y:Tvecteur;N : integer) : double;
var iFin : integer;

Procedure ChercheUnTour;
var i : integer;
    Ymin,Ymax,CoeffY,Xmin,Xmax,CoeffX : double;
    ecartMin,ecartMax,ecartLoc : double;// min,max pour hysteresis

Function ecart : double;
begin
      ecart := abs(CoeffY*(Y[i]-Y[0]))+abs(CoeffX*(X[i]-X[0]))
end;

Function entre0et1 : boolean;
begin
      result := ((Y[i]-Y[0])*(Y[i]-Y[1])<0) and ((X[i]-X[0])*(X[i]-X[1])<0)
end;

begin
     iFin := pred(N);
     if N<16 then exit;
     GetMinMax(y,N,ymin,ymax);
     GetMinMax(x,N,xmin,xmax);
     CoeffY := 1/(Ymax-Ymin);
     CoeffX := 1/(Xmax-Xmin);
     ecartMax := 1/4;
     ecartMin := 1/16;
     i := 1;
     repeat inc(i)
     until (ecart>ecartMax) or (i=pred(N));
// on est loin du départ
     if i=pred(N) then exit;
     repeat inc(i)
     until (ecart<ecartMin) or entre0et1 or (i=pred(N));
// on est près de la boucle
     if i=pred(N) then exit;
     iFin := i;
     repeat
         inc(i);
         ecartLoc := ecart;
         if ecartLoc<ecartMin then begin
               ecartMin := ecartLoc;
               iFin := i;
         end; { on se rapproche }
     until (ecartLoc>ecartMax) or (i=pred(N));
// on séloigne
     i := iFin;
     if entre0et1 then dec(i); { plus d'un tour }
     iFin := i;
end;

var  i : integer;
     yprec,xprec,xx,yy,zz : double;
     Fermee : boolean;
begin
  ChercheUnTour;
	yprec := y[0];
	xprec := x[0];
  zz := 0;
	for i := 1 to iFin do begin
	   xx := X[i];
	   yy := Y[i];
	   zz := zz+(xx-xprec)*(yy+yprec)/2;
	   yprec := yy;
	   xprec := xx;
	end;{for i}
  fermee := iFin<pred(N);
  if fermee then // on ferme la boucle
     zz := zz+(X[0]-xprec)*(Y[0]+yprec)/2;
  result := zz;
end;

Procedure chercheMinMax(const X,Y : Tvecteur;N : integer;
   EnvMax : boolean;var jMax : integer;var Xe,Ye : Tvecteur);
var i : integer;
    Yder : Tvecteur;
    extremum : boolean;
begin
     setLength(Xe,N);
     setLength(Ye,N);
     setLength(Yder,N);
     DeriveeGauss(X,Y,N,Yder,degreDerivee,NbrePointDerivee);
     jMax := 0;
     for i := 0 to N-2 do begin
         if envMax
            then extremum := (Yder[i]>=0) and (Yder[succ(i)]<0)
            else extremum := (Yder[i]<=0) and (Yder[succ(i)]>0);
         if extremum then begin
            Xe[jMax] := X[i]-Yder[i]*(X[succ(i)]-X[i])/(Yder[succ(i)]-Yder[i]);
            Ye[jMax] := Y[i]+(Xe[jMax]-X[i])*(Y[succ(i)]-Y[i])/(X[succ(i)]-X[i]);
            inc(jMax);
         end;
     end;
     Finalize(Yder);
end;

{$I Bspline.pas}

Procedure chercheEnveloppe(const X : Tvecteur;N : integer;
                           const Xe,Ye : Tvecteur;Ne : integer;
                           var Env : Tvecteur);
var C : TCoeffSpline;

procedure ValeurA(i,j : integer);
var k : integer;
    zz,tt : double;
begin
    tt := X[i]-Xe[j];
    zz := 0;
    for k := 3 downto 0 do
        zz := C[k,j]+zz*tt;
    Env[i] := zz;
end;

var i,j : integer;
begin
     if Ne<=3 then exit;
     BuildAkimaSpline(Xe,Ye,Ne,C);
     i := 0;
     while (X[i]<Xe[2]) do begin
        Env[i] := Nan;
        inc(i);
     end;
     j := 2;
     while i<N do begin
         if (X[i]>=Xe[j+1]) then
            if (j<(Ne-4)) then inc(j) else break;
         valeurA(i,j);
         inc(i);
     end;
     while i<N do begin
         Env[i] := Nan;
         inc(i);
     end;
end; // chercheEnveloppe

Function MyPsi(alpha : double) : double;
const
     c0 = 2.515517;
     c1 = 0.802853;
     c2 = 0.010328;
     d1 = 1.432788;
     d2 = 0.189269;
     d3 = 0.001308;
var t : double;
    num,den : double;
    Complementaire : boolean;
begin
    complementaire := alpha>0.5;
    if not complementaire then alpha := 1-alpha;
    t := sqrt(-2*ln(alpha));
    num := c1+c2*t;
    num := c0+t*num;
    den := d2+d3*t;
    den := d1+den*t;
    den := 1+den*t;
    result := t-num/den;
    if complementaire then result := 1-result
end;

Function Chi2Inverse(alpha : double;m : integer) : double;// m grand
begin
     result := sqr(MyPsi(alpha)+sqrt(2*m-1))/2/m
end;

Procedure TestChi295(m : integer;var min,max : double); // m grand
var alpha : double;
begin
     alpha := student95(m);
     min := sqr(alpha+sqrt(2*m-1))/2/m;
     max := sqr(-alpha+sqrt(2*m-1))/2/m;
end;

Procedure TestChi299(m : integer;var min,max : double);// vrai pour m grand
var alpha : double;
begin
     alpha := student99(m);
     min := sqr(alpha+sqrt(2*m-1))/2/m;
     max := sqr(-alpha+sqrt(2*m-1))/2/m;
end;

Function erf(x : double) : double;
begin
    result := fspec.erf(x)
end;

Function ToDateTime(x : double) : double;
begin
    result := x*ConversionSecondeJour
end;

Function ToMois(x : double) : double;
var Year, Month, Day : word;
begin
   DecodeDate(x,Year, Month, Day);
   Result := Month
end;

Function ToHeure(x : double) : double;
begin
   Result := frac(x)
end;

Function ToAnnee(x : double) : double;
var Year, Month, Day : word;
begin
   DecodeDate(x,Year, Month, Day);
   Result := Year
end;

Function ToJour(x : double) : double;
var Year, Month, Day : word;
begin
   DecodeDate(x,Year, Month, Day);
   Result := Day
end;

Function PhaseModulo(x,debut,fin : double) : double;
begin
    result := x - (fin-debut)*floor((x-debut)/(fin-debut))
end;

Function Factorielle(x : double) : double;
begin
    result := gamma(x+1)
end;

Function FactorielleEnt(n : integer) : double;
var i : integer;
begin
    result := 1;
    for i := 2 to n do result := result*i
end;

Function Fgamma(x : double) : double;
begin
    result := gamma(x)
end;

Function GammaDemi(n : integer) : double;
{ Gamma(n+1/2) }
begin
    result := sqrt(pi)*FactorielleEnt(2*n)/(FactorielleEnt(n)*PuissEnt(2,2*n));
end;

Function BesselJ(x,n : double) : double;
const
   xi : array[1..12] of double =
      (0.1252334085,0.3678314990,0.5873179543,0.7699026742,0.9041172564,0.9815606342,
      -0.1252334085,-0.3678314990,-0.5873179543,-0.7699026742,-0.9041172564,-0.9815606342);
   wi : array[1..12] of double =
      (0.2491470458,0.2334925365,0.2031674267,0.1600783285,0.1069393260,0.0471753364,
       0.2491470458,0.2334925365,0.2031674267,0.1600783285,0.1069393260,0.0471753364);
var
    i,nn : integer;
    coeff,f,t : double;
begin
    angleEnRadian(x);
    nn := round(n);
    coeff := 1/sqrt(pi);
    if nn<0 then begin
       nn := abs(nn);
       if (nn div 2)=1 then coeff := -coeff;
    end;
    if abs(x)>(30-2*nn)
       then result := 0
       else begin
          f := 0;
          try
          for i := 1 to 12 do begin
              t := 0.5+xi[i]*0.5;
              f := f+wi[i]*cos(t*x)*power(1-t*t,nn-1/2);
          end;
          result := coeff*f/GammaDemi(nn)*puissEnt(x/2,nn);
          except
             result := 0.5;
          end;
    end;
end;

Function Peigne(dt,t : double) : double;
var n : integer;
begin
    n := round(t/dt);
    if abs(t-n*dt)<precisionPeigne
        then result := 1
        else result := 0
end;

Function isEntier(x : double;var n : integer) : boolean;
begin
    n := round(x);
    result := abs(x-n)<1E-6
end;

Procedure setTailleVecteur(var v : Tvecteur;Nbre : integer);
begin
    if (high(V)<Nbre) then setLength(V,Nbre)
end;

Function Bruit(x : double) : double;
begin
   result := randG(0,x)
end;

end.

