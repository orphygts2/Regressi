{ **********************************************************************
  *                            Unit FMATH.PAS                          *
  *                             Version 3.0d                           *
  *                      (c) J. Debord, August 2003                    *
  **********************************************************************
    This unit implements some mathematical functions in Delphi Pascal
  **********************************************************************
  Notes:

  1) The default real type is DOUBLE (8-byte real).
     Other types may be selected by defining the symbols:

       SINGLEREAL   (Single precision, 4 bytes)
       EXTENDEDREAL (Extended precision, 10 bytes)

  2) Error handling: The global variable MathError returns the error code
     from the last function evaluation. It must be checked immediately
     after a function call:

       Y := f(X);        (* f is one of the functions of the library *)
       if MathError = FN_OK then ...

     The possible error codes are:

     ---------------------------------------------
     Error code   Value  Significance
     ---------------------------------------------
     FN_OK          0    No error
     FN_DOMAIN     -1    Argument domain error
     FN_SING       -2    Positive singularity
     FN_OVERFLOW   -3    Overflow range error
     FN_UNDERFLOW  -4    Underflow range error
     FN_TLOSS      -5    Total loss of precision
     FN_PLOSS      -6    Partial loss of precision
     ---------------------------------------------

     When an error occurs, a default value is attributed to the function.

     The standard functions Exp and Ln have been redefined according to
     the above conventions as Expo and Log.

  **********************************************************************
  References:

  Complex functions: modified Pascal code from E. F. Glynn
                     (http://www.efg2.com/Lab/)

  Lambert's function: translated Fortran code from D. A. Barry et al.
                      (http://www.netlib.org/toms/743)

  Thanks to Volker Walter <vw@metrohm.ch>
  for improving the Power functions.
  ********************************************************************** }

unit fmath;

interface

{ ----------------------------------------------------------------------
  Floating point type (Default = Double)
  ---------------------------------------------------------------------- }

{$IFDEF SINGLEREAL}
  type Float = Single;
{$ELSE}
{$IFDEF EXTENDEDREAL}
  type Float = Extended;
{$ELSE}
  {$DEFINE DOUBLEREAL}
  type Float = Double;
{$ENDIF}
{$ENDIF}

{ ----------------------------------------------------------------------
  Mathematical constants
  ---------------------------------------------------------------------- }

const
  PI         = 3.14159265358979323846;  { Pi }
  LN2        = 0.69314718055994530942;  { Ln(2) }
  LN10       = 2.30258509299404568402;  { Ln(10) }
  LNPI       = 1.14472988584940017414;  { Ln(Pi) }
  INVLN2     = 1.44269504088896340736;  { 1/Ln(2) }
  INVLN10    = 0.43429448190325182765;  { 1/Ln(10) }
  TWOPI      = 6.28318530717958647693;  { 2*Pi }
  PIDIV2     = 1.57079632679489661923;  { Pi/2 }
  SQRTPI     = 1.77245385090551602730;  { Sqrt(Pi) }
  SQRT2PI    = 2.50662827463100050242;  { Sqrt(2*Pi) }
  INVSQRT2PI = 0.39894228040143267794;  { 1/Sqrt(2*Pi) }
  LNSQRT2PI  = 0.91893853320467274178;  { Ln(Sqrt(2*Pi)) }
  LN2PIDIV2  = 0.91893853320467274178;  { Ln(2*Pi)/2 }
  SQRT2      = 1.41421356237309504880;  { Sqrt(2) }
  SQRT2DIV2  = 0.70710678118654752440;  { Sqrt(2)/2 }
  GOLD       = 1.61803398874989484821;  { Golden Mean = (1 + Sqrt(5))/2 }
  CGOLD      = 0.38196601125010515179;  { 2 - GOLD }

{ ----------------------------------------------------------------------
  Machine-dependent constants
  ---------------------------------------------------------------------- }

{$IFDEF SINGLEREAL}
const
  MACHEP = 1.192093E-7;               { Floating point precision: 2^(-23) }
  MAXNUM = 3.402823E+38;              { Max. floating point number: 2^128 }
  MINNUM = 1.175495E-38;              { Min. floating point number: 2^(-126) }
  MAXLOG = 88.72283;                  { Max. argument for Exp = Ln(MAXNUM) }
  MINLOG = -87.33655;                 { Min. argument for Exp = Ln(MINNUM) }
  MAXFAC = 33;                        { Max. argument for Factorial }
  MAXGAM = 34.648;                    { Max. argument for Gamma }
  MAXLGM = 1.0383E+36;                { Max. argument for LnGamma }
{$ELSE}
{$IFDEF DOUBLEREAL}
const
  MACHEP = 2.220446049250313E-16;     { 2^(-52) }
  MAXNUM = 1.797693134862315E+308;    { 2^1024 }
  MINNUM = 2.225073858507202E-308;    { 2^(-1022) }
  MAXLOG = 709.7827128933840;
  MINLOG = -708.3964185322641;
  MAXFAC = 170;
  MAXGAM = 171.624376956302;
  MAXLGM = 2.556348E+305;
{$ELSE}
{$IFDEF EXTENDEDREAL}
const
  MACHEP = 1.08420217248550444E-19;   { 2^(-63) }
  MAXNUM = 1.18973149535723103E+4932; { 2^16384 }
  MINNUM = 3.36210314311209558E-4932; { 2^(-16382) }
  MAXLOG = 11356.5234062941439;
  MINLOG = - 11355.137111933024;
  MAXFAC = 1754;
  MAXGAM = 1755.455;
  MAXLGM = 1.04848146839019521E+4928;
{$ENDIF}
{$ENDIF}
{$ENDIF}

{ ----------------------------------------------------------------------
  Error codes for mathematical functions
  ---------------------------------------------------------------------- }

const
  FN_OK        =   0;  { No error }
  FN_DOMAIN    = - 1;  { Argument domain error }
  FN_SING      = - 2;  { Singularity }
  FN_OVERFLOW  = - 3;  { Overflow range error }
  FN_UNDERFLOW = - 4;  { Underflow range error }
  FN_TLOSS     = - 5;  { Total loss of precision }
  FN_PLOSS     = - 6;  { Partial loss of precision }

{ ----------------------------------------------------------------------
  Global variables
  ---------------------------------------------------------------------- }

var
  MathError    : Integer;  { Error code from the latest function evaluation }
  SgnZeroIsOne : Boolean;  { Indicates if Sgn(0) returns 1 (default) or 0 }

{ ----------------------------------------------------------------------
  Functional type
  ---------------------------------------------------------------------- }

type
  TFunc = function(X : Float) : Float;

{ ----------------------------------------------------------------------
  Complex numbers
  ---------------------------------------------------------------------- }

type
  Complex = record
    X, Y : Float;
  end;

{ ----------------------------------------------------------------------
  Complex constants
  ---------------------------------------------------------------------- }

const
  C_infinity : Complex = (X : MAXNUM; Y : 0.0);
  C_zero     : Complex = (X : 0.0;    Y : 0.0);
  C_one      : Complex = (X : 1.0;    Y : 0.0);
  C_i        : Complex = (X : 0.0;    Y : 1.0);
  C_pi       : Complex = (X : PI;     Y : 0.0);
  C_pi_div_2 : Complex = (X : PIDIV2; Y : 0.0);

{ ----------------------------------------------------------------------
  Min, max, sign and exchange
  ---------------------------------------------------------------------- }

function Min(X, Y : Integer) : Integer; overload;
function Max(X, Y : Integer) : Integer; overload;

function Min(X, Y : Float) : Float; overload;
function Max(X, Y : Float) : Float; overload;

function Sgn(X : Float)     : Integer; overload;  { Sign }
function Sgn(Z : Complex)   : Integer; overload;  { Complex sign }
function DSgn(A, B : Float) : Float;              { Sgn(B) * |A| }

procedure Swap(var X, Y : Float);   overload;   { Exchange 2 reals }
procedure Swap(var X, Y : Integer); overload;   { Exchange 2 integers }
procedure Swap(var W, Z : Complex); overload;   { Exchange 2 complexes }

{ ----------------------------------------------------------------------
  Complex numbers
  ---------------------------------------------------------------------- }

function Cmplx(X, Y : Float)     : Complex;  { X + i.Y }
function Polar(R, Theta : Float) : Complex;  { R.exp(i.Theta) }

function CAbs(Z : Complex) : Float;          { |Z| }
function CArg(Z : Complex) : Float;          { Arg(Z) }

function CNeg(A : Complex)     : Complex;    { -A }
function CConj(A : Complex)    : Complex;    { A* }
function CAdd(A, B : Complex)  : Complex;    { A + B }
function CSub(A, B : Complex)  : Complex;    { A - B }
function CMult(A, B : Complex) : Complex;    { A * B }
function CDiv(A, B : Complex)  : Complex;    { A / B }

function CSqrt(Z : Complex)                 : Complex;  { Sqrt(Z) }
function CRoot(Z : Complex; K, N : Integer) : Complex;  { Z^(1/N), K=0..N-1 }

function CSin(Z : Complex)    : Complex;     { Sin(Z) }
function CCos(Z : Complex)    : Complex;     { Cos(Z) }
function CArcTan(Z : Complex) : Complex;     { ArcTan(Z) }

{ ----------------------------------------------------------------------
  Logarithms, exponentials, and powers (real or complex argument)
  ---------------------------------------------------------------------- }

function Expo(X : Float)   : Float;   overload;  { Exponential }
function Expo(Z : Complex) : Complex; overload;

function Log(X : Float)   : Float;   overload;   { Natural log }
function Log(Z : Complex) : Complex; overload;

function Power(X : Float; N : Integer)   : Float;   overload; { X^N }
function Power(X, Y : Float)             : Float;   overload; { X^Y, X >= 0 }
function Power(Z : Complex; N : Integer) : Complex; overload; { Z^N }
function Power(Z : Complex; X : Float)   : Complex; overload; { Z^X }
function Power(A, B : Complex)           : Complex; overload; { A^B }

{ ----------------------------------------------------------------------
  Other logarithms and exponentials (real argument only)
  ---------------------------------------------------------------------- }

function Exp2(X : Float)    : Float;  { 2^X }
function Exp10(X : Float)   : Float;  { 10^X }
function Log2(X : Float)    : Float;  { Log, base 2 }
function Log10(X : Float)   : Float;  { Decimal log }
function LogA(X, A : Float) : Float;  { Log, base A }

{ ----------------------------------------------------------------------
  Lambert's function
  ---------------------------------------------------------------------- }
function LambertW(X : Float; UBranch, Offset : Boolean) : Float;
{ ----------------------------------------------------------------------
  Lambert's W function: Y = W(X) ==> X = Y * Exp(Y)    X >= -1/e
  ----------------------------------------------------------------------
  X       = Argument
  UBranch = TRUE  for computing the upper branch (X >= -1/e, W(X) >= -1)
            FALSE for computing the lower branch (-1/e <= X < 0, W(X) <= -1)
  Offset  = TRUE  for computing W(X - 1/e), X >= 0
            FALSE for computing W(X)
  ---------------------------------------------------------------------- }

{ ----------------------------------------------------------------------
  Trigonometric functions (real or complex argument)
  ---------------------------------------------------------------------- }

function Tan(X : Float)   : Float;   overload;     { Tangent }
function Tan(Z : Complex) : Complex; overload;

function ArcSin(X : Float)   : Float;   overload;  { Arc sinus }
function ArcSin(Z : Complex) : Complex; overload;

function ArcCos(X : Float)   : Float;   overload;  { Arc cosinus }
function ArcCos(Z : Complex) : Complex; overload;

{ ----------------------------------------------------------------------
  Other trigonometric functions (real argument only)
  ---------------------------------------------------------------------- }

function Pythag(X, Y : Float)    : Float;  { Sqrt(X^2 + Y^2) }
function ArcTan2(Y, X : Float)   : Float;  { Angle (Ox, OM) with M(X,Y) }
function FixAngle(Theta : Float) : Float;  { Set Theta in -Pi..Pi }

{ ----------------------------------------------------------------------
  Hyperbolic functions (real or complex argument)
  ---------------------------------------------------------------------- }

function Sinh(X : Float)   : Float;   overload;     { Hyperbolic sine }
function Sinh(Z : Complex) : Complex; overload;

function Cosh(X : Float)   : Float;   overload;     { Hyperbolic cosine }
function Cosh(Z : Complex) : Complex; overload;

function Tanh(X : Float)   : Float;   overload;     { Hyperbolic tangent }
function Tanh(Z : Complex) : Complex; overload;

function ArcSinh(X : Float)   : Float;   overload;  { Inverse hyperbolic sine }
function ArcSinh(Z : Complex) : Complex; overload;

function ArcCosh(X : Float)   : Float;   overload;  { Inverse hyperbolic cosine }
function ArcCosh(Z : Complex) : Complex; overload;

function ArcTanh(X : Float)   : Float;   overload;  { Inverse hyperbolic tangent }
function ArcTanh(Z : Complex) : Complex; overload;

{ ----------------------------------------------------------------------
  Other hyperbolic function (real argument only)
  ---------------------------------------------------------------------- }

procedure SinhCosh(X : Float; var SinhX, CoshX : Float);  { Sinh & Cosh }

{ ********************************************************************** }

implementation

{ ----------------------------------------------------------------------
  Error handling function
  ---------------------------------------------------------------------- }

  function DefaultVal(ErrCode : Integer; Default : Float) : Float;
  { Sets the global variable MathError and returns
    the default value according to the error code }
  begin
    MathError := ErrCode;
    DefaultVal := Default;
  end;

{ ----------------------------------------------------------------------
  Min, max, sign and exchange
  ---------------------------------------------------------------------- }

  function Min(X, Y : Integer) : Integer; overload;
  begin
    if X < Y then Min := X else Min := Y;
  end;

  function Max(X, Y : Integer) : Integer; overload;
  begin
    if X > Y then Max := X else Max := Y;
  end;

  function Min(X, Y : Float) : Float; overload;
    begin
    if X < Y then Min := X else Min := Y;
  end;

  function Max(X, Y : Float) : Float; overload;
  begin
    if X > Y then Max := X else Max := Y;
  end;

  function Sgn0(X : Float) : Integer;
  begin
    if X > 0.0 then
      Sgn0 := 1
    else if X = 0.0 then
      Sgn0 := 0
    else
      Sgn0 := - 1;
  end;

  function Sgn(X : Float) : Integer;
  begin
    if X > 0.0 then
      Sgn := 1
    else if X < 0.0 then
      Sgn := - 1
    else
      Sgn := Ord(SgnZeroIsOne);
  end;

  function Sgn(Z : Complex) : Integer; overload;
  begin
    if Z.X > 0.0 then
      Sgn := 1
    else if Z.X < 0.0 then
      Sgn := - 1
    else if Z.Y > 0.0 then
      Sgn := 1
    else if Z.Y < 0.0 then
      Sgn := - 1
    else
      Sgn := Ord(SgnZeroIsOne);
  end;

  function DSgn(A, B : Float) : Float;
  begin
    if B < 0.0 then DSgn := - Abs(A) else DSgn := Abs(A);
  end;

  procedure Swap(var X, Y : Integer); overload;
  var
    Temp : Integer;
  begin
    Temp := X;
    X := Y;
    Y := Temp;
  end;

  procedure Swap(var X, Y : Float); overload;
  var
    Temp : Float;
  begin
    Temp := X;
    X := Y;
    Y := Temp;
  end;

  procedure Swap(var W, Z : Complex); overload;
  var
    Temp : Complex;
  begin
    Temp := W;
    W := Z;
    Z := Temp;
  end;

{ ----------------------------------------------------------------------
  Elementary functions
  ---------------------------------------------------------------------- }

  function Expo(X : Float) : Float; overload;
  begin
    MathError := FN_OK;
    if X < MINLOG then
      Expo := DefaultVal(FN_UNDERFLOW, 0.0)
    else if X > MAXLOG then
      Expo := DefaultVal(FN_OVERFLOW, MAXNUM)
    else
      Expo := Exp(X);
  end;

  function Exp2(X : Float) : Float;
  var
    XLn2 : Float;
  begin
    MathError := FN_OK;
    XLn2 := X * LN2;
    if XLn2 < MINLOG then
      Exp2 := DefaultVal(FN_UNDERFLOW, 0.0)
    else if XLn2 > MAXLOG then
      Exp2 := DefaultVal(FN_OVERFLOW, MAXNUM)
    else
      Exp2 := Exp(XLn2);
  end;

  function Exp10(X : Float) : Float;
  var
    XLn10 : Float;
  begin
    MathError := FN_OK;
    XLn10 := X * LN10;
    if XLn10 < MINLOG then
      Exp10 := DefaultVal(FN_UNDERFLOW, 0.0)
    else if XLn10 > MAXLOG then
      Exp10 := DefaultVal(FN_OVERFLOW, MAXNUM)
    else
      Exp10 := Exp(XLn10);
  end;

  function Log(X : Float) : Float; overload;
  begin
    MathError := FN_OK;
    if X < 0.0 then
      Log := DefaultVal(FN_DOMAIN, - MAXNUM)
    else if X = 0.0 then
      Log := DefaultVal(FN_SING, - MAXNUM)
    else
      Log := Ln(X);
  end;

  function Log10(X : Float) : Float;
  begin
    MathError := FN_OK;
    if X < 0.0 then
      Log10 := DefaultVal(FN_DOMAIN, - MAXNUM)
    else if X = 0.0 then
      Log10 := DefaultVal(FN_SING, - MAXNUM)
    else
      Log10 := Ln(X) * INVLN10;
  end;

  function Log2(X : Float) : Float;
  begin
    MathError := FN_OK;
    if X < 0.0 then
      Log2 := DefaultVal(FN_DOMAIN, - MAXNUM)
    else if X = 0.0 then
      Log2 := DefaultVal(FN_SING, - MAXNUM)
    else
      Log2 := Ln(X) * INVLN2;
  end;

  function LogA(X, A : Float) : Float;
  var
    Y : Float;
  begin
    Y := Log(X);
    if MathError = FN_OK then
      if A = 1.0 then
        Y := DefaultVal(FN_SING, Sgn(Y) * MAXNUM)
      else
        Y := Y / Log(A);
    LogA := Y;
  end;

{ ----------------------------------------------------------------------
  Power functions
  ---------------------------------------------------------------------- }

  function PowerTests(X, Y : Float; var Res : Float) : Boolean;
  { Tests the cases X=0, Y=0 and Y=1. Returns X^Y in Res }
  begin
    if X = 0.0 then
      begin
        PowerTests := True;
        if Y = 0.0 then       { 0^0 = lim  X^X = 1 }
          Res := 1.0          {       X->0         }
        else if Y > 0.0 then
          Res := 0.0          { 0^Y = 0 }
        else
          Res := DefaultVal(FN_SING, MAXNUM);
      end
    else if Y = 0.0 then
      begin
        Res := 1.0;           { X^0 = 1 }
        PowerTests := True;
      end
    else if Y = 1.0 then
      begin
        Res := X;             { X^1 = X }
        PowerTests := True;
      end
    else
      PowerTests := False;
  end;

  function IntPower(X : Float; N : Integer) : Float;
  { Computes X^N by repeated multiplications }
  const
    InverseMaxNum = 1.0 / MAXNUM;
  var
    T      : Float;
    M      : Integer;
    Invert : Boolean;
  begin
    if PowerTests(X, N, T) then
      begin
        IntPower := T;
        Exit;
      end;

    Invert := (N < 0);    { Test if inverting is needed }
    if 1.0 < Abs(X) then  { Test for 0 ..|x| .. 1 }
      begin
        X := 1.0 / X;
        Invert := not Invert;
      end;

    { Legendre's algorithm for
      minimizing the number of multiplications }
    T := 1.0; M := Abs(N);
    while 0 < M do
      begin
        if Odd(M) then T := T * X;
        X := Sqr(X);
        M := M div 2;
      end;

    if Invert then
      if Abs(T) < InverseMaxNum then  { Only here overflow }
        T := DefaultVal(FN_OVERFLOW, Sgn(T) * MAXNUM)
      else
        T := 1.0 / T;

    IntPower := T;
  end;

  function Power(X : Float; N : Integer) : Float; overload;
  begin
    Power := IntPower(X, N);
  end;

  function Power(X, Y : Float) : Float; overload;
  { Computes X^Y = Exp(Y * Ln(X)), for X > 0
    Resorts to IntPower if Y is integer }
  var
    Res  : Float;
    YLnX : Float;
  begin
    if PowerTests(X, Y, Res) then
      Power := Res
    else if (Abs(Y) < MaxInt) and (Trunc(Y) = Y) then  { Integer exponent }
      Power := IntPower(X, Trunc(Y))
    else if X <= 0.0 then
      Power := DefaultVal(FN_DOMAIN, 0.0)
    else
      begin
        YLnX := Y * Ln(X);
        if YLnX < MINLOG then
          Power := DefaultVal(FN_UNDERFLOW, 0.0)
        else if YLnX > MAXLOG then
          Power := DefaultVal(FN_OVERFLOW, MAXNUM)
        else
          Power := Exp(YLnX);
      end;
  end;

  function Pythag(X, Y : Float) : Float;
  { Computes Sqrt(X^2 + Y^2) without destructive underflow or overflow }
  var
    AbsX, AbsY : Float;
  begin
    MathError := FN_OK;
    AbsX := Abs(X);
    AbsY := Abs(Y);
    if AbsX > AbsY then
      Pythag := AbsX * Sqrt(1.0 + Sqr(AbsY / AbsX))
    else if AbsY = 0.0 then
      Pythag := 0.0
    else
      Pythag := AbsY * Sqrt(1.0 + Sqr(AbsX / AbsY));
  end;

{ ----------------------------------------------------------------------
  Lambert's function
  ---------------------------------------------------------------------- }

var
  NBITS : Integer;

var
  LC : record
         EM, EM9, C13, C23, EM2, D12, X0, X1,
         AN3, AN4, AN5, AN6, S21, S22, S23 : Float;
       end;

  function LambertW(X : Float; UBranch, Offset : Boolean) : Float;
  var
    I, NITER : Integer;
    AN2, DELX, ETA, RETA, T, TEMP, TEMP2, TS, WAPR, XX, ZL, ZN : Float;

  begin
    if Offset then
      begin
        DELX := X;
        if DELX < 0.0 then
          begin
            LambertW := DefaultVal(FN_DOMAIN, 0.0);
            Exit;
          end;
        XX := X + LC.EM;
      end
    else
      begin
        if X < LC.EM then
          begin
            LambertW := DefaultVal(FN_DOMAIN, 0.0);
            Exit;
          end;

        if X = LC.EM then
          begin
            LambertW := - 1.0;
            Exit;
          end;

        XX := X;
        DELX := XX - LC.EM;
      end;

    if UBranch then
      begin
        if Abs(XX) <= LC.X0 then
          begin
            LambertW := XX / (1.0 + XX / (1.0 + XX / (2.0 + XX / (0.6 + 0.34 * XX))));
            Exit;
          end;

        if XX <= LC.X1 then
          begin
            RETA := Sqrt(LC.D12 * DELX);
            LambertW := RETA / (1.0 + RETA / (3.0 + RETA / (RETA / (LC.AN4 +
                        RETA / (RETA * LC.AN6 + LC.AN5)) + LC.AN3))) - 1.0;
            Exit;
          end;

        if XX <= 20.0 then
          begin
            RETA := SQRT2 * Sqrt(1.0 - XX / LC.EM);
            AN2 := 4.612634277343749 * Sqrt(Sqrt(RETA + 1.09556884765625));
            WAPR := RETA / (1.0 + RETA / (3.0 + (LC.S21 * AN2 + LC.S22) * RETA / (LC.S23 * (AN2 + RETA)))) - 1.0;
          end
        else
          begin
            ZL := Ln(XX);
            WAPR := Ln(XX / Ln(Power(XX / ZL, Exp(- 1.124491989777808 / (0.4225028202459761 + ZL)))));
          end
      end
    else
      begin
        if XX >= 0.0 then
          begin
            LambertW := DefaultVal(FN_DOMAIN, 0.0);
            Exit;
          end;

        if XX <= LC.X1 then
          begin
            RETA := Sqrt(LC.D12 * DELX);
            LambertW := RETA / (RETA / (3.0 + RETA / (RETA / (LC.AN4 +
                        RETA / (RETA * LC.AN6 - LC.AN5)) - LC.AN3)) - 1.0) - 1.0;
            Exit;
          end;

        if XX <= LC.EM9 then
          begin
            ZL := Ln(- XX);
            T := - 1.0 - ZL;
            TS := Sqrt(T);
            WAPR := ZL - (2.0 * TS) / (SQRT2 + (LC.C13 - T / (2.7E2 + TS * 127.0471381349219)) * TS);
          end
        else
          begin
            ZL := Ln(- XX);
            ETA := 2.0 - LC.EM2 * XX;
            WAPR := Ln(XX / Ln(- XX / ((1.0 - 0.5043921323068457 * (ZL + 1.0)) * (Sqrt(ETA) + ETA / 3.0) + 1.0)));
          end
      end;

    if NBITS < 52 then NITER := 1 else NITER := 2;

    for I := 1 to NITER do
      begin
        ZN := Ln(XX / WAPR) - WAPR;
        TEMP := 1.0 + WAPR;
        TEMP2 := TEMP + LC.C23 * ZN;
        TEMP2 := 2.0 * TEMP * TEMP2;
        WAPR := WAPR * (1.0 + (ZN / TEMP) * (TEMP2 - ZN) / (TEMP2 - 2.0 * ZN));
      end;

    LambertW := WAPR;
  end;

{ ----------------------------------------------------------------------
  Trigonometric functions
  ---------------------------------------------------------------------- }

  function FixAngle(Theta : Float) : Float;
  begin
    MathError := FN_OK;
    while Theta > PI do
      Theta := Theta - TWOPI;
    while Theta <= - PI do
      Theta := Theta + TWOPI;
    FixAngle := Theta;
  end;

  function Tan(X : Float) : Float; overload;
  var
    SinX, CosX : Float;
  begin
    MathError := FN_OK;
    SinX := Sin(X);
    CosX := Cos(X);
    if CosX = 0.0 then
      Tan := DefaultVal(FN_SING, Sgn(SinX) * MAXNUM)
    else
      Tan := SinX / CosX;
  end;

  function ArcSin(X : Float) : Float;
  var
    A : Float;
  begin
    MathError := FN_OK;
    A := Abs(X);
    if A > 1.0 then
      ArcSin := DefaultVal(FN_DOMAIN, Sgn(X) * PIDIV2)
    else if A = 1.0 then
      ArcSin := Sgn(X) * PIDIV2
    else
      ArcSin := ArcTan(X / Sqrt(1.0 - Sqr(X)));
  end;

  function ArcCos(X : Float) : Float;
  begin
    MathError := FN_OK;
    if X < - 1.0 then
      ArcCos := DefaultVal(FN_DOMAIN, PI)
    else if X > 1.0 then
      ArcCos := DefaultVal(FN_DOMAIN, 0.0)
    else if X = 1.0 then
      ArcCos := 0.0
    else if X = - 1.0 then
      ArcCos := PI
    else
      ArcCos := PIDIV2 - ArcTan(X / Sqrt(1.0 - Sqr(X)));
  end;

  function ArcTan2(Y, X : Float) : Float;
  var
    Theta : Float;
  begin
    MathError := FN_OK;
    if X = 0.0 then
      if Y = 0.0 then
        ArcTan2 := 0.0
      else if Y > 0.0 then
        ArcTan2 := PIDIV2
      else
        ArcTan2 := - PIDIV2
    else
      begin
        { 4th/1st quadrant -PI/2..PI/2 }
        Theta := ArcTan(Y / X);

        { 2nd/3rd quadrants }
        if X < 0.0 then
          if Y >= 0.0 then
            Theta := Theta + PI   { 2nd quadrant:  PI/2..PI }
          else
            Theta := Theta - PI;  { 3rd quadrant: -PI..-PI/2 }
        ArcTan2 := Theta;
      end;
  end;

{ ----------------------------------------------------------------------
  Hyperbolic functions
  ---------------------------------------------------------------------- }

  function Sinh(X : Float) : Float;
  var
    ExpX : Float;
  begin
    MathError := FN_OK;
    if (X < MINLOG) or (X > MAXLOG) then
      Sinh := DefaultVal(FN_OVERFLOW, Sgn(X) * MAXNUM)
    else
      begin
        ExpX := Exp(X);
        Sinh := 0.5 * (ExpX - 1.0 / ExpX);
      end;
  end;

  function Cosh(X : Float) : Float;
  var
    ExpX : Float;
  begin
    MathError := FN_OK;
    if (X < MINLOG) or (X > MAXLOG) then
      Cosh := DefaultVal(FN_OVERFLOW, MAXNUM)
    else
      begin
        ExpX := Exp(X);
        Cosh := 0.5 * (ExpX + 1.0 / ExpX);
      end;
  end;

  procedure SinhCosh(X : Float; var SinhX, CoshX : Float);
  var
    ExpX, ExpMinusX : Float;
  begin
    MathError := FN_OK;
    if (X < MINLOG) or (X > MAXLOG) then
      begin
        CoshX := DefaultVal(FN_OVERFLOW, MAXNUM);
        SinhX := Sgn(X) * CoshX;
      end
    else
      begin
        ExpX := Exp(X);
        ExpMinusX := 1.0 / ExpX;
        SinhX := 0.5 * (ExpX - ExpMinusX);
        CoshX := 0.5 * (ExpX + ExpMinusX);
      end;
  end;

  function Tanh(X : Float) : Float;
  var
    SinhX, CoshX : Float;
  begin
    SinhCosh(X, SinhX, CoshX);
    Tanh := SinhX / CoshX;
  end;

  function ArcSinh(X : Float) : Float;
  begin
    MathError := FN_OK;
    ArcSinh := Ln(X + Sqrt(Sqr(X) + 1.0));
  end;

  function ArcCosh(X : Float) : Float;
  begin
    MathError := FN_OK;
    if X < 1.0 then
      ArcCosh := DefaultVal(FN_DOMAIN, 0.0)
    else
      ArcCosh := Ln(X + Sqrt(Sqr(X) - 1.0));
  end;

  function ArcTanh(X : Float) : Float;
  begin
    MathError := FN_OK;
    if (X < - 1.0) or (X > 1.0) then
      ArcTanh := DefaultVal(FN_DOMAIN, Sgn(X) * MAXNUM)
    else if (X = - 1.0) or (X = 1.0) then
      ArcTanh := DefaultVal(FN_SING, Sgn(X) * MAXNUM)
    else
      ArcTanh := 0.5 * Ln((1.0 + X) / (1.0 - X));
  end;

{ ----------------------------------------------------------------------
  Complex functions
  ---------------------------------------------------------------------- }

  function Cmplx(X, Y : Float) : Complex;
  var
    Z : Complex;
  begin
    Z.X := X;
    Z.Y := Y;
    Cmplx := Z;
  end;

  function Polar(R, Theta : Float) : Complex;
  begin
    Polar := Cmplx(R * Cos(Theta), R * Sin(Theta));
  end;

  function CAbs(Z : Complex) : Float;
  begin
    CAbs := Pythag(Z.X, Z.Y);
  end;

  function CArg(Z : Complex) : Float;
  begin
    CArg := ArcTan2(Z.Y, Z.X);
  end;

  function CNeg(A : Complex) : Complex;
  begin
    CNeg := Cmplx(-A.X, -A.Y);
  end;

  function CConj(A : Complex) : Complex;
  begin
    CConj := Cmplx(A.X, -A.Y);
  end;

  function CAdd(A, B : Complex) : Complex;
  begin
    CAdd := Cmplx(A.X + B.X, A.Y + B.Y);
  end;

  function CSub(A, B : Complex) : Complex;
  begin
    CSub := Cmplx(A.X - B.X, A.Y - B.Y);
  end;

  function CMult(A, B : Complex) : Complex;
  begin
    CMult := Cmplx(A.X * B.X - A.Y * B.Y, A.X * B.Y + A.Y * B.X);
  end;

  function CDiv(A, B : Complex) : Complex;
  var
    Temp : Float;
  begin
    if (B.X = 0.0) and (B.Y = 0.0) then
      begin
        MathError := FN_OVERFLOW;
        CDiv := C_infinity;
        Exit;
      end;
    Temp := Sqr(B.X) + Sqr(B.Y);
    CDiv := Cmplx((A.X * B.X + A.Y * B.Y) / Temp,
                  (A.Y * B.X - A.X * B.Y) / Temp);
  end;

  function CRoot(Z : Complex; K, N : Integer) : Complex;
  { CRoot can calculate all 'N' roots of 'A' by varying 'K' from 0..N-1 }
  var
    R, Theta : Float;
  begin
    if (N <= 0) or (K < 0) or (K >= N) then
      begin
        MathError := FN_DOMAIN;
        CRoot := C_zero;
        Exit;
      end;
    R := CAbs(Z);
    Theta := CArg(Z);
    if R = 0.0 then
      Croot := C_zero
    else
      Croot := Polar(Power(R, 1.0 / N), FixAngle((Theta + K * TWOPI) / N));
  end;

  function CSqrt(Z : Complex) : Complex;
  var
    R, Theta : Float;
  begin
    R := CAbs(Z);
    Theta := CArg(Z);
    if R = 0.0 then
      CSqrt := C_zero
    else
      CSqrt := Polar(Sqrt(R), FixAngle(0.5 * Theta));
  end;

  function CCos(Z : Complex) : Complex;
  var
    SinX, CosX, SinhY, CoshY : Float;
  begin
    SinX := Sin(Z.X);
    CosX := Cos(Z.X);
    SinhCosh(Z.Y, SinhY, CoshY);  { Called here to set MathError }
    CCos := Cmplx(CosX * CoshY, - SinX * SinhY);
  end;

  function CSin(Z : Complex) : Complex;
  var
    SinX, CosX, SinhY, CoshY : Float;
  begin
    SinX := Sin(Z.X);
    CosX := Cos(Z.X);
    SinhCosh(Z.Y, SinhY, CoshY);  { Called here to set MathError }
    CSin := Cmplx(SinX * CoshY, CosX * SinhY);
  end;

  function CArcTan(Z : Complex) : Complex;
  var
    XX, Yp1, Ym1 : Float;
  begin
    if (Z.X = 0.0) and (Abs(Z.Y) = 1.0) then  { Z = +/- i }
      begin
        MathError := FN_SING;
        CArcTan := Cmplx(0.0, Sgn(Z.Y) * MAXNUM);
        Exit;
      end;
    XX := Sqr(Z.X);
    Yp1 := Z.Y + 1.0;
    Ym1 := Z.Y - 1.0;
    CArcTan := Cmplx(0.5 * (ArcTan2(Z.X, - Ym1) - ArcTan2(- Z.X, Yp1)),
                     0.25 * Log((XX + Sqr(Yp1)) / (XX + Sqr(Ym1))));
  end;

  function Expo(Z : Complex) : Complex; overload;
  var
    ExpX : Float;
  begin
    ExpX := Expo(Z.X);
    if MathError = FN_OK then
      Expo := Cmplx(ExpX * Cos(Z.Y), ExpX * Sin(Z.Y))
    else
      Expo := Cmplx(ExpX, 0.0);
  end;

  function Log(Z : Complex) : Complex; overload;
  var
    R, Theta, LnR : Float;
  begin
    R := CAbs(Z);
    Theta := CArg(Z);
    LnR := Log(R);
    if MathError = FN_OK then
      Log := Cmplx(LnR, Theta)
    else
      Log := Cmplx(- MAXNUM, 0.0);
  end;

  function Power(Z : Complex; N : Integer) : Complex; overload;
  var
    R, Theta : Float;
  begin
    R := CAbs(Z);
    Theta := CArg(Z);
    if R = 0.0 then
      if N = 0 then
        Power := C_one
      else if N > 0 then
        Power := C_zero
      else
        begin
          MathError := FN_SING;
          Power := C_infinity;
        end
    else
      Power := Polar(IntPower(R, N), FixAngle(N * Theta));
  end;

  function Power(Z : Complex; X : Float) : Complex; overload;
  var
    R, Theta : Float;
  begin
    R := CAbs(Z);
    Theta := CArg(Z);
    if R = 0.0 then
      if X = 0.0 then
        Power := C_one
      else if X > 0.0 then
        Power := C_zero
      else
        begin
          MathError := FN_SING;
          Power := C_infinity;
        end
    else
      Power := Polar(Power(R, X), FixAngle(X * Theta));
  end;

  function Power(A, B : Complex) : Complex; overload;
  begin
    if (A.X = 0.0) and (A.Y = 0.0) then
      if (B.X = 0.0) and (B.Y = 0.0) then
        Power := C_one                         { lim a^a = 1 as a -> 0 }
      else
        Power := C_zero                        { 0^b = 0, b > 0 }
    else
      Power := Expo(CMult(B, Log(A)));         { a^b = exp(b * ln(a)) }
  end;

  function Tan(Z : Complex) : Complex; overload;
  var
    X2, Y2, SinX2, CosX2, SinhY2, CoshY2, Temp : Float;
  begin
    X2 := 2.0 * Z.X;
    Y2 := 2.0 * Z.Y;
    SinX2 := Sin(X2);
    CosX2 := Cos(X2);
    SinhCosh(Y2, SinhY2, CoshY2);
    if MathError = FN_OK then
      Temp := CosX2 + CoshY2
    else
      Temp := CoshY2;
    if Temp <> 0.0 then
      Tan := Cmplx(SinX2 / Temp, SinhY2 / Temp)
    else
      begin                  { Z = Pi/2 + k*Pi }
        MathError := FN_SING;
        Tan := C_infinity;
      end;
  end;

  function ArcSin(Z : Complex) : Complex; overload;
  var
    Rp, Rm, S, T, X2, XX, YY : Float;
    B                        : Complex;
  begin
    B := Cmplx(Z.Y, - Z.X);  { Y - i*X }
    X2 := 2.0 * Z.X;
    XX := Sqr(Z.X);
    YY := Sqr(Z.Y);
    S := XX + YY + 1.0;
    Rp := 0.5 * Sqrt(S + X2);
    Rm := 0.5 * Sqrt(S - X2);
    T := Rp + Rm;
    ArcSin := Cmplx(ArcSin(Rp - Rm), Sgn(B) * Log(T + Sqrt(Sqr(T) - 1.0)));
  end;

  function ArcCos(Z : Complex) : Complex; overload;
  begin
    ArcCos := CSub(C_pi_div_2, ArcSin(Z));  { Pi/2 - ArcSin(Z) }
  end;

  function Sinh(Z : Complex) : Complex; overload;
  var
    SinhX, CoshX : Float;
  begin
    SinhCosh(Z.X, SinhX, CoshX);
    Sinh := Cmplx(SinhX * Cos(Z.Y), CoshX * Sin(Z.Y));
  end;

  function Cosh(Z : Complex) : Complex; overload;
  var
    SinhX, CoshX : Float;
  begin
    SinhCosh(Z.X, SinhX, CoshX);
    Cosh := Cmplx(CoshX * Cos(Z.Y), SinhX * Sin(Z.Y))
  end;

  function Tanh(Z : Complex) : Complex; overload;
  var
    X2, Y2, SinY2, CosY2, SinhX2, CoshX2, Temp : Float;
  begin
    X2 := 2.0 * Z.X;
    Y2 := 2.0 * Z.Y;
    SinY2 := Sin(Y2);
    CosY2 := Cos(Y2);
    SinhCosh(X2, SinhX2, CoshX2);
    if MathError = FN_OK then
      Temp := CoshX2 + CosY2
    else
      Temp := CoshX2;
    if Temp <> 0.0 then
      Tanh := Cmplx(SinhX2 / Temp, SinY2 / Temp)
    else
      begin                  { Z = i * (Pi/2 + k*Pi) }
        MathError := FN_SING;
        Tanh := Cmplx(0.0, MAXNUM);
      end;
  end;

  function ArcSinh(Z : Complex) : Complex; overload;
  { ArcSinh(Z) = -i*ArcSin(i*Z) }
  begin
    ArcSinh := Cneg(CMult(C_i, ArcSin(CMult(C_i, Z))));
  end;

  function ArcCosh(Z : Complex) : Complex; overload;
  { ArcCosh(Z) = CSgn(Y + i(1-X))*i*ArcCos(Z) where Z = X+iY }
  var
    Temp : Complex;
  begin
    Temp := CMult(C_i, ArcCos(Z));
    if Sgn(Cmplx(Z.Y, 1.0 - Z.X)) = -1 then
      Temp := CNeg(Temp);
    ArcCosh := Temp;
  end;

  function ArcTanh(Z : Complex) : Complex; overload;
  { ArcTanh(Z) = -i*ArcTan(i*Z) }
  begin
    if (Abs(Z.X) = 1.0) and (Z.Y = 0.0) then  { Z = +/- 1 }
      begin
        MathError := FN_SING;
        ArcTanh := Cmplx(Sgn(Z.X) * MAXNUM, 0.0);
      end
    else
      ArcTanh := CNeg(CMult(C_i, CArcTan(CMult(C_i, Z))));
  end;

begin
  MathError := FN_OK;
  SgnZeroIsOne := True;

  { Initialize constants for Lambert's function }
  NBITS := Round(- Log2(MACHEP));
  with LC do
    begin
      EM := - Exp(- 1.0);
      EM9 := - Exp(- 9.0);
      C13 := 1.0 / 3.0;
      C23 := 2.0 * C13;
      EM2 := 2.0 / EM;
      D12 := - EM2;
      X0 := Power(MACHEP, 1.0 / 6.0) * 0.5;
      X1 := (1.0 - 17.0 * Power(MACHEP, 2.0 / 7.0)) * EM;
      AN3 := 8.0 / 3.0;
      AN4 := 135.0 / 83.0;
      AN5 := 166.0 / 39.0;
      AN6 := 3167.0 / 3549.0;
      S21 := 2.0 * SQRT2 - 3.0;
      S22 := 4.0 - 3.0 * SQRT2;
      S23 := SQRT2 - 2.0;
    end;
end.
