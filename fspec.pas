{ **********************************************************************
  *                            Unit FSPEC.PAS                          *
  *                             Version 1.2d                           *
  *                       (c) J. Debord, May 2003                      *
  **********************************************************************
             Special functions and probability distributions
  **********************************************************************
  Error handling: The global variable MathError returns the error code
  from the last function evaluation. It must be checked immediately
  after a function call:

       Y := f(X);        (* f is one of the functions of the library *)
       if MathError = FN_OK then ...

  The possible error codes are the following:

     ---------------------------------------------
     Error code   Value  Significance
     ---------------------------------------------
     FN_OK          0    No error
     FN_DOMAIN     -1    Argument domain error
     FN_SING       -2    Function singularity
     FN_OVERFLOW   -3    Overflow range error
     FN_UNDERFLOW  -4    Underflow range error
     FN_TLOSS      -5    Total loss of precision
     FN_PLOSS      -6    Partial loss of precision
     ---------------------------------------------

  **********************************************************************
  Most functions are translated C code from Cephes math library
  by S. Moshier (http://www.moshier.net)
  ********************************************************************** }

unit fspec;

interface

uses
  fmath;

{ Table of factorials }

const
  NFACT = 33;

var
  FactArray : array[0..NFACT] of Float =
    (1.0,
     1.0,
     2.0,
     6.0,
     24.0,
     120.0,
     720.0,
     5040.0,
     40320.0,
     362880.0,
     3628800.0,
     39916800.0,
     479001600.0,
     6227020800.0,
     87178291200.0,
     1307674368000.0,
     20922789888000.0,
     355687428096000.0,
     6402373705728000.0,
     121645100408832000.0,
     2432902008176640000.0,
     51090942171709440000.0,
     1124000727777607680000.0,
     25852016738884976640000.0,
     620448401733239439360000.0,
     15511210043330985984000000.0,
     403291461126605635584000000.0,
     10888869450418352160768000000.0,
     304888344611713860501504000000.0,
     8841761993739701954543616000000.0,
     265252859812191058636308480000000.0,
     8222838654177922817725562880000000.0,
     263130836933693530167218012160000000.0,
     8683317618811886495518194401280000000.0);

{ ----------------------------------------------------------------------
  Special functions
  ---------------------------------------------------------------------- }

function Fact(N : Integer) : Float;         { Factorial }
function Binomial(N, K : Integer) : Float;  { Binomial coef. C(N,K) }
function Gamma(X : Float) : Float;          { Gamma function }
function SgnGamma(X : Float) : Integer;     { Sign of Gamma function }
function IGamma(A, X : Float) : Float;      { Incomplete Gamma function }
function JGamma(A, X : Float) : Float;      { Complement of IGamma }
function Beta(X, Y : Float) : Float;        { Beta function }
function IBeta(A, B, X : Float) : Float;    { Incomplete Beta function }
function Erf(X : Float) : Float;            { Error function }
function Erfc(X : Float) : Float;           { Complement of Erf }

function LnGamma(X : Float)   : Float;   overload;  { Log(|Gamma(X)|) }
function LnGamma(Z : Complex) : Complex; overload;

{ ----------------------------------------------------------------------
  Binomial distribution with probability P and number of repetitions N
  ---------------------------------------------------------------------- }

function PBinom(N : Integer; P : Float; K : Integer) : Float; { Prob(X = K) }
function FBinom(N : Integer; P : Float; K : Integer) : Float; { Prob(X <= K) }

{ ----------------------------------------------------------------------
  Poisson distribution with mean Mu
  ---------------------------------------------------------------------- }

function PPoisson(Mu : Float; K : Integer) : Float;  { Prob(X = K) }
function FPoisson(Mu : Float; K : Integer) : Float;  { Prob(X <= K) }

{ ----------------------------------------------------------------------
  Standard normal distribution
  ---------------------------------------------------------------------- }

function DNorm(X : Float) : Float;    { Density of standard normal }
function FNorm(X : Float) : Float;    { Prob(U <= X) }
function PNorm(X : Float) : Float;    { Prob(|U| >= |X|) }
function InvNorm(P : Float) : Float;  { Inverse of FNorm : returns X
                                        such that Prob(U <= X) = P}

{ ----------------------------------------------------------------------
  Student distribution with Nu d.o.f.
  ---------------------------------------------------------------------- }

function DStudent(Nu : Integer; X : Float) : Float;  { Density of t }
function FStudent(Nu : Integer; X : Float) : Float;  { Prob(t <= X) }
function PStudent(Nu : Integer; X : Float) : Float;  { Prob(|t| >= |X|) }

{ ----------------------------------------------------------------------
  Khi-2 distribution with Nu d.o.f.
  ---------------------------------------------------------------------- }

function DKhi2(Nu : Integer; X : Float) : Float;  { Density of Khi2 }
function FKhi2(Nu : Integer; X : Float) : Float;  { Prob(Khi2 <= X) }
function PKhi2(Nu : Integer; X : Float) : Float;  { Prob(Khi2 >= X) }

{ ----------------------------------------------------------------------
  Fisher-Snedecor distribution with Nu1 and Nu2 d.o.f.
  ---------------------------------------------------------------------- }

function DSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;  { Density of F }
function FSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;  { Prob(F <= X) }
function PSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;  { Prob(F >= X) }

{ ----------------------------------------------------------------------
  Exponential distribution
  ---------------------------------------------------------------------- }

function DExpo(A, X : Float) : Float;  { Density of exponential distrib. }
function FExpo(A, X : Float) : Float;  { Prob( <= X) }

{ ----------------------------------------------------------------------
  Beta distribution
  ---------------------------------------------------------------------- }

function DBeta(A, B, X : Float) : Float;   { Density of Beta distribution }
function FBeta(A, B, X : Float) : Float;   { Prob( <= X) }

{ ----------------------------------------------------------------------
  Gamma distribution
  ---------------------------------------------------------------------- }

function DGamma(A, B, X : Float) : Float;  { Density of Gamma distribution }
function FGamma(A, B, X : Float) : Float;  { Prob( <= X) }

{ ********************************************************************** }

implementation

{ ----------------------------------------------------------------------
  Error handling function
  ---------------------------------------------------------------------- }

  function DefaultVal(ErrCode : Integer; Default : Float) : Float;
  { Sets the global variable MathError and the function default value
    according to the error code }
  begin
    MathError := ErrCode;
    DefaultVal := Default;
  end;

{ ----------------------------------------------------------------------
  Special functions
  ---------------------------------------------------------------------- }

const { Used by IGamma and IBeta }
  BIG    = 9.223372036854775808E18;
  BIGINV = 1.084202172485504434007E-19;

type
  TabCoef = array[0..9] of Float;

  function PolEvl(var X : Float; Coef : TabCoef; N : Integer) : Float;
{ ----------------------------------------------------------------------
  Evaluates polynomial of degree N:
  Coefficients are stored in reverse order:
  Coef[0] = C  , ..., Coef[N] = C
             N                   0
  The function P1Evl() assumes that Coef[N] = 1.0 and is
  omitted from the array. Its calling arguments are
  otherwise the same as PolEvl().
  ---------------------------------------------------------------------- }
  var
    Ans : Float;
    I : Integer;
  begin
    Ans := Coef[0];
    for I := 1 to N do
      Ans := Ans * X + Coef[I];
    PolEvl := Ans;
  end;

  function P1Evl(var X : Float; Coef : TabCoef; N : Integer) : Float;
{ ----------------------------------------------------------------------
  Evaluate polynomial when coefficient of X is 1.0.
  Otherwise same as PolEvl.
  ---------------------------------------------------------------------- }
  var
    Ans : Float;
    I : Integer;
  begin
    Ans := X + Coef[0];
    for I := 1 to N - 1 do
      Ans := Ans * X + Coef[I];
    P1Evl := Ans;
  end;

  function SgnGamma(X : Float) : Integer;
  begin
    if X > 0.0 then
      SgnGamma := 1
    else if Odd(Trunc(Abs(X))) then
      SgnGamma := 1
    else
      SgnGamma := - 1;
  end;

  function Stirf(X : Float) : Float;
  { Stirling's formula for the gamma function
    Gamma(x) = Sqrt(2*Pi) x^(x-.5) exp(-x) (1 + 1/x P(1/x))
    where P(x) is a polynomial }
  const
    STIR : TabCoef = (
        7.147391378143610789273E-4,
      - 2.363848809501759061727E-5,
      - 5.950237554056330156018E-4,
        6.989332260623193171870E-5,
        7.840334842744753003862E-4,
      - 2.294719747873185405699E-4,
      - 2.681327161876304418288E-3,
        3.472222222230075327854E-3,
        8.333333333333331800504E-2,
        0);

  var
    W, P : Float;
  begin
    W := 1.0 / X;
    if X > 1024.0 then begin
        P := 6.97281375836585777429E-5 * W + 7.84039221720066627474E-4;
        P := P * W - 2.29472093621399176955E-4;
        P := P * W - 2.68132716049382716049E-3;
        P := P * W + 3.47222222222222222222E-3;
        P := P * W + 8.33333333333333333333E-2;
      end
    else
      P := PolEvl(W, STIR, 8);
    Stirf := SQRT2PI * Exp((X - 0.5) * Ln(X) - X) * (1.0 + W * P);
  end;

  function GamSmall(X1, Z : Float) : Float;
  { Gamma function for small values of the argument }
  const
    S : TabCoef = (
      - 1.193945051381510095614E-3,
        7.220599478036909672331E-3,
      - 9.622023360406271645744E-3,
      - 4.219773360705915470089E-2,
        1.665386113720805206758E-1,
      - 4.200263503403344054473E-2,
      - 6.558780715202540684668E-1,
        5.772156649015328608253E-1,
        1.000000000000000000000E0,
        0);

    SN : TabCoef = (
        1.133374167243894382010E-3,
        7.220837261893170325704E-3,
        9.621911155035976733706E-3,
      - 4.219773343731191721664E-2,
      - 1.665386113944413519335E-1,
      - 4.200263503402112910504E-2,
        6.558780715202536547116E-1,
        5.772156649015328608727E-1,
      - 1.000000000000000000000E0,
        0);

  var
    P : Float;
  begin
    if X1 = 0.0 then begin
        GamSmall := DefaultVal(FN_SING, MAXNUM);
        Exit;
      end;
    if X1 < 0.0 then begin
        X1 := - X1;
        P := PolEvl(X1, SN, 8);
      end
    else
      P := PolEvl(X1, S, 8);
    GamSmall := Z / (X1 * P);
  end;

  function StirfL(X : Float) : Float;
  { Approximate Ln(Gamma) by Stirling's formula, for X >= 13 }
  const
    P : TabCoef = (
        4.885026142432270781165E-3,
      - 1.880801938119376907179E-3,
        8.412723297322498080632E-4,
      - 5.952345851765688514613E-4,
        7.936507795855070755671E-4,
      - 2.777777777750349603440E-3,
        8.333333333333331447505E-2,
        0, 0, 0);

  var
    Q, W : Float;
  begin
    Q := Ln(X) * (X - 0.5) - X;
    Q := Q + LNSQRT2PI;
    if X > 1.0E+10 then
      StirfL := Q
    else begin
        W := 1.0 / Sqr(X);
        StirfL := Q + PolEvl(W, P, 6) / X;
      end;
  end;

  function Gamma(X : Float) : Float;
  const
    P : TabCoef = (
      4.212760487471622013093E-5,
      4.542931960608009155600E-4,
      4.092666828394035500949E-3,
      2.385363243461108252554E-2,
      1.113062816019361559013E-1,
      3.629515436640239168939E-1,
      8.378004301573126728826E-1,
      1.000000000000000000009E0,
      0, 0);

    Q : TabCoef = (
      - 1.397148517476170440917E-5,
        2.346584059160635244282E-4,
      - 1.237799246653152231188E-3,
      - 7.955933682494738320586E-4,
        2.773706565840072979165E-2,
      - 4.633887671244534213831E-2,
      - 2.243510905670329164562E-1,
        4.150160950588455434583E-1,
        9.999999999999999999908E-1,
        0);

  var
    SgnGam, N : Integer;
    A, X1, Z : Float;
  begin
    MathError := FN_OK;
    SgnGam := SgnGamma(X);

    if (X = 0.0) or ((X < 0.0) and (Frac(X) = 0.0)) then begin
        Gamma := DefaultVal(FN_SING, SgnGam * MAXNUM);
        Exit;
      end;

    if X > MAXGAM then begin
        Gamma := DefaultVal(FN_OVERFLOW, MAXNUM);
        Exit;
      end;

    A := Abs(X);
    if A > 13.0 then begin
        if X < 0.0 then begin
            N := Trunc(A);
            Z := A - N;
            if Z > 0.5 then begin
                N := N + 1;
                Z := A - N;
              end;
            Z := Abs(A * Sin(PI * Z)) * Stirf(A);
            if Z <= PI / MAXNUM then begin
                Gamma := DefaultVal(FN_OVERFLOW, SgnGam * MAXNUM);
                Exit;
              end;
            Z := PI / Z;
          end
        else
          Z := Stirf(X);
        Gamma := SgnGam * Z;
      end
    else begin
        Z := 1.0;
        X1 := X;
        while X1 >= 3.0 do begin
            X1 := X1 - 1.0;
            Z := Z * X1;
          end;
        while X1 < - 0.03125 do begin
            Z := Z / X1;
            X1 := X1 + 1.0;
          end;
        if X1 <= 0.03125 then
          Gamma := GamSmall(X1, Z)
        else begin
            while X1 < 2.0 do begin
                Z := Z / X1;
                X1 := X1 + 1.0;
              end;
            if (X1 = 2.0) or (X1 = 3.0) then
              Gamma := Z
            else begin
                X1 := X1 - 2.0;
                Gamma := Z * PolEvl(X1, P, 7) / PolEvl(X1, Q, 8);
              end;
          end;
      end;
  end;

  function LnGamma(X : Float) : Float; overload;
  const
    P : TabCoef = (
      - 2.163690827643812857640E3,
      - 8.723871522843511459790E4,
      - 1.104326814691464261197E6,
      - 6.111225012005214299996E6,
      - 1.625568062543700591014E7,
      - 2.003937418103815175475E7,
      - 8.875666783650703802159E6,
        0, 0, 0);

    Q : TabCoef = (
      - 5.139481484435370143617E2,
      - 3.403570840534304670537E4,
      - 6.227441164066219501697E5,
      - 4.814940379411882186630E6,
      - 1.785433287045078156959E7,
      - 3.138646407656182662088E7,
      - 2.099336717757895876142E7,
        0, 0, 0);

  var
    N, SgnGam : Integer;
    A, X1, Z : Float;
  begin
    MathError := FN_OK;
    SgnGam := SgnGamma(X);

    if (X = 0.0) or ((X < 0.0) and (Frac(X) = 0.0)) then begin
        LnGamma := DefaultVal(FN_SING, MAXNUM);
        Exit;
      end;

    if X > MAXLGM then begin
        LnGamma := DefaultVal(FN_OVERFLOW, MAXNUM);
        Exit;
      end;

    A := Abs(X);
    if A > 34.0 then begin
        if X < 0.0 then begin
            N := Trunc(A);
            Z := A - N;
            if Z > 0.5 then begin
                N := N + 1;
                Z := N - A;
              end;
            Z := A * Sin(PI * Z);
            if Z = 0.0 then begin
                LnGamma := DefaultVal(FN_OVERFLOW, SgnGam * MAXNUM);
                Exit;
              end;
            Z := LNPI - Ln(Z) - StirfL(A);
          end
        else
          Z := StirfL(X);
        LnGamma := Z;
      end
    else if X < 13.0 then begin
        Z := 1.0;
        X1 := X;
        while X1 >= 3 do begin
            X1 := X1 - 1.0;
            Z := Z * X1;
          end;
        while X1 < 2.0 do begin
            if Abs(X1) <= 0.03125 then begin
                LnGamma := Ln(Abs(GamSmall(X1, Z)));
                Exit;
              end;
            Z := Z / X1;
            X1 := X1 + 1.0;
          end;
        if Z < 0.0 then Z := - Z;
        if X1 = 2.0 then
          LnGamma := Ln(Z)
        else begin
            X1 := X1 - 2.0;
            LnGamma := X1 * PolEvl(X1, P, 6) / P1Evl(X1, Q, 7) + Ln(Z);
          end;
      end
    else
      LnGamma := StirfL(X);
  end;

  function ApproxLnGamma(Z : Complex) : Complex;
  { This is the approximation used in the National Bureau of
    Standards "Table of the Gamma Function for Complex Arguments,"
    Applied Mathematics Series 34, 1954. The NBS table was created
    using this approximation over the area 9 < Re(z) < 10 and
    0 < Im(z) < 10. Other table values were computed using the
    relationship:
        _                   _
    ln | (z+1) = ln z + ln | (z) }

  const
    C : array[1..8] of Float =
    (8.33333333333333E-02, - 2.77777777777778E-03,
     7.93650793650794E-04, - 5.95238095238095E-04,
     8.41750841750842E-04, - 1.91752691752692E-03,
     6.41025641025641E-03, - 2.95506535947712E-02);
  var
    I : Integer;
    Powers : array[1..8] of Complex;
    Temp1, Temp2, Sum : Complex;
  begin
    Temp1 := Log(Z);                       { Ln(Z) }
    Temp2 := Cmplx(Z.X - 0.5, Z.Y);        { Z - 0.5 }
    Sum := CMult(Temp1, Temp2);            { (Z - 0.5)*Ln(Z) }
    Sum := CSub(Sum, Z);                   { (Z - 0.5)*ln(Z) - Z }
    Sum.X := Sum.X + LN2PIDIV2;
    Temp1 := C_one;
    Powers[1] := CDiv(Temp1, Z);           { Z^(-1) }
    Temp2 := CMult(Powers[1], Powers[1]);  { Z^(-2) }
    for I := 2 to 8 do
      Powers[I] := CMult(Powers[I - 1], Temp2);
    for I := 8 downto 1 do
      Sum := CAdd(Sum, Cmplx(C[I] * Powers[I].X, C[I] * Powers[I].Y));
    ApproxLnGamma := Sum;
  end;

  function LnGamma(Z : Complex) : Complex; overload;
  var
    A, LnZ, Temp : Complex;
  begin
    if (Z.X <= 0.0) and (Z.Y = 0.0) then
      if (Int(Z.X - 1E-8) - Z.X) = 0.0 then begin { Negative integer? }
          MathError := FN_SING;
          LnGamma := C_infinity;
          Exit
        end;
    if Z.Y < 0.0 then begin           { 3rd or 4th quadrant? }
        A := LnGamma(CConj(Z));  { Try again in 1st or 2nd quadrant }
        LnGamma := CConj(A);     { Left this out! 1/3/91 }
      end
    else begin
        if Z.X < 9.0 then begin  { "left" of NBS table range }
            LnZ := Log(Z);
            Z := Cmplx(Z.X + 1.0, Z.Y);
            Temp := LnGamma(Z);
            LnGamma := CSub(Temp, LnZ)
          end
        else
          LnGamma := ApproxLnGamma(Z)  { NBS table range: 9 < Re(z) < 10 }
      end
  end;

  function IGamma(A, X : Float) : Float;
  const epsilon = 1E-5;
  var
    Ans, Ax, C, R : Float;
  begin
    MathError := FN_OK;

    if (X <= 0.0) or (A <= 0.0) then begin
        IGamma := 0.0;
        Exit;
      end;

    if (X > 1.0) and (X > A) then begin
        IGamma := 1.0 - JGamma(A, X);
        Exit;
      end;

    Ax := A * Ln(X) - X - LnGamma(A);
    if Ax < MINLOG then begin
        IGamma := DefaultVal(FN_UNDERFLOW, 0.0);
        Exit;
      end;

    Ax := Exp(Ax);

    { Power series }
    R := A;
    C := 1.0;
    Ans := 1.0;

    repeat
      R := R + 1.0;
      C := C * X / R;
      Ans := Ans + C;
    until C / Ans <= epsilon;

    IGamma := Ans * Ax / A;
  end;

  function JGamma(A, X : Float) : Float;
  const epsilon = 1E-5;
  var
    Ans, C, Yc, Ax, Y, Z, R, T,
    Pk, Pkm1, Pkm2, Qk, Qkm1, Qkm2 : Float;
  begin
    MathError := FN_OK;

    if (X <= 0.0) or (A <= 0.0) then begin
        JGamma := 1.0;
        Exit;
      end;

    if (X < 1.0) or (X < A) then begin
        JGamma := 1.0 - IGamma(A, X);
        Exit;
      end;

    Ax := A * Ln(X) - X - LnGamma(A);

    if Ax < MINLOG then begin
        JGamma := DefaultVal(FN_UNDERFLOW, 0.0);
        Exit;
      end;

    Ax := Exp(Ax);

    { Continued fraction }
    Y := 1.0 - A;
    Z := X + Y + 1.0;
    C := 0.0;
    Pkm2 := 1.0;
    Qkm2 := X;
    Pkm1 := X + 1.0;
    Qkm1 := Z * X;
    Ans := Pkm1 / Qkm1;

    repeat
      C := C + 1.0;
      Y := Y + 1.0;
      Z := Z + 2.0;
      Yc := Y * C;
      Pk := Pkm1 * Z - Pkm2 * Yc;
      Qk := Qkm1 * Z - Qkm2 * Yc;
      if Qk <> 0.0 then begin
          R := Pk / Qk;
          T := Abs((Ans - R) / R);
          Ans := R;
        end
      else
        T := 1.0;
      Pkm2 := Pkm1;
      Pkm1 := Pk;
      Qkm2 := Qkm1;
      Qkm1 := Qk;
      if Abs(Pk) > BIG then begin
          Pkm2 := Pkm2 / BIG;
          Pkm1 := Pkm1 / BIG;
          Qkm2 := Qkm2 / BIG;
          Qkm1 := Qkm1 / BIG;
        end;
    until T <= epsilon;

    JGamma := Ans * Ax;
  end;

  function Fact(N : Integer) : Float;
  begin
    MathError := FN_OK;
    if N < 0 then
      Fact := DefaultVal(FN_DOMAIN, 1.0)
    else if N > MAXFAC then
      Fact := DefaultVal(FN_OVERFLOW, MAXNUM)
    else if N <= NFACT then
      Fact := FactArray[N]
    else
      Fact := Gamma(N + 1);
  end;

  function Binomial(N, K : Integer) : Float;
  var
    I, N1 : Integer;
    Prod : Float;
  begin
    MathError := FN_OK;
    if K < 0 then
      Binomial := 0.0
    else if (K = 0) or (K = N) then
      Binomial := 1.0
    else if (K = 1) or (K = N - 1) then
      Binomial := N
    else begin
        if K > N - K then K := N - K;
        N1 := Succ(N);
        Prod := N;
        for I := 2 to K do
          Prod := Prod * ((N1 - I) / I);
        Binomial := Int(0.5 + Prod);
      end;
  end;

  function Beta(X, Y : Float) : Float;
  { Computes Beta(X, Y) = Gamma(X) * Gamma(Y) / Gamma(X + Y) }
  var
    Lx, Ly, Lxy : Float;
    SgnBeta : Integer;
  begin
    MathError := FN_OK;
    SgnBeta := SgnGamma(X) * SgnGamma(Y) * SgnGamma(X + Y);
    Lxy := LnGamma(X + Y);
    if MathError <> FN_OK then begin
        Beta := 0.0;
        Exit;
      end;
    Lx := LnGamma(X);
    if MathError <> FN_OK then begin
        Beta := SgnBeta * MAXNUM;
        Exit;
      end;
    Ly := LnGamma(Y);
    if MathError <> FN_OK then begin
        Beta := SgnBeta * MAXNUM;
        Exit;
      end;
    Beta := SgnBeta * Exp(Lx + Ly - Lxy);
  end;

  function PSeries(A, B, X : Float) : Float;
  { Power series for incomplete beta integral. Use when B*X is small }
  var
    S, T, U, V, T1, Z, Ai : Float;
    N : Integer;
  begin
    Ai := 1.0 / A;
    U := (1.0 - B) * X;
    V := U / (A + 1.0);
    T1 := V;
    T := U;
    N := 2;
    S := 0.0;
    Z := MACHEP * Ai;
    while Abs(V) > Z do
      begin
        U := (N - B) * X / N;
        T := T * U;
        V := T / (A + N);
        S := S + V;
        N := N + 1;
      end;
    S := S + T1;
    S := S + Ai;

    U := A * Ln(X);
    if (A + B < MAXGAM) and (Abs(U) < MAXLOG) then begin
        T := Gamma(A + B) / (Gamma(A) * Gamma(B));
        S := S * T * Power(X, A);
      end
    else begin
        T := LnGamma(A + B) - LnGamma(A) - LnGamma(B) + U + Ln(S);
        if T < MINLOG then
          S := 0.0
        else
          S := Exp(T);
      end;
    PSeries := S;
  end;

  function CFrac1(A, B, X : Float) : Float;
  { Continued fraction expansion #1 for incomplete beta integral }
  var
    Xk, Pk, Pkm1, Pkm2, Qk, Qkm1, Qkm2,
    K1, K2, K3, K4, K5, K6, K7, K8,
    R, T, Ans, Thresh : Float;
    N : Integer;
  label
    CDone;
  begin
    K1 := A;
    K2 := A + B;
    K3 := A;
    K4 := A + 1.0;
    K5 := 1.0;
    K6 := B - 1.0;
    K7 := K4;
    K8 := A + 2.0;

    Pkm2 := 0.0;
    Qkm2 := 1.0;
    Pkm1 := 1.0;
    Qkm1 := 1.0;
    Ans := 1.0;
    R := 1.0;
    N := 0;
    Thresh := 3.0 * MACHEP;

    repeat
      Xk := - (X * K1 * K2) / (K3 * K4);
      Pk := Pkm1 + Pkm2 * Xk;
      Qk := Qkm1 + Qkm2 * Xk;
      Pkm2 := Pkm1;
      Pkm1 := Pk;
      Qkm2 := Qkm1;
      Qkm1 := Qk;

      Xk := (X * K5 * K6) / (K7 * K8);
      Pk := Pkm1 + Pkm2 * Xk;
      Qk := Qkm1 + Qkm2 * Xk;
      Pkm2 := Pkm1;
      Pkm1 := Pk;
      Qkm2 := Qkm1;
      Qkm1 := Qk;

      if Qk <> 0.0 then R := Pk / Qk;

      if R <> 0.0 then begin
          T := Abs((Ans - R) / R);
          Ans := R;
        end
      else
        T := 1.0;

      if T < Thresh then goto CDone;

      K1 := K1 + 1.0;
      K2 := K2 + 1.0;
      K3 := K3 + 2.0;
      K4 := K4 + 2.0;
      K5 := K5 + 1.0;
      K6 := K6 - 1.0;
      K7 := K7 + 2.0;
      K8 := K8 + 2.0;

      if Abs(Qk) + Abs(Pk) > BIG then begin
          Pkm2 := Pkm2 * BIGINV;
          Pkm1 := Pkm1 * BIGINV;
          Qkm2 := Qkm2 * BIGINV;
          Qkm1 := Qkm1 * BIGINV;
        end;

      if (Abs(Qk) < BIGINV) or (Abs(Pk) < BIGINV) then begin
          Pkm2 := Pkm2 * BIG;
          Pkm1 := Pkm1 * BIG;
          Qkm2 := Qkm2 * BIG;
          Qkm1 := Qkm1 * BIG;
        end;
      N := N + 1;
    until N > 400;

CDone:
    CFrac1 := Ans;
  end;

  function CFrac2(A, B, X : Float) : Float;
  { Continued fraction expansion #2 for incomplete beta integral }
  var
    Xk, Pk, Pkm1, Pkm2, Qk, Qkm1, Qkm2,
    K1, K2, K3, K4, K5, K6, K7, K8,
    R, T, Z, Ans, Thresh : Float;
    N : Integer;
  label
    CDone;
  begin
    K1 := A;
    K2 := B - 1.0;
    K3 := A;
    K4 := A + 1.0;
    K5 := 1.0;
    K6 := A + B;
    K7 := A + 1.0;
    K8 := A + 2.0;

    Pkm2 := 0.0;
    Qkm2 := 1.0;
    Pkm1 := 1.0;
    Qkm1 := 1.0;
    Z := X / (1.0 - X);
    Ans := 1.0;
    R := 1.0;
    N := 0;
    Thresh := 3.0 * MACHEP;

    repeat
      Xk := - (Z * K1 * K2) / (K3 * K4);
      Pk := Pkm1 + Pkm2 * Xk;
      Qk := Qkm1 + Qkm2 * Xk;
      Pkm2 := Pkm1;
      Pkm1 := Pk;
      Qkm2 := Qkm1;
      Qkm1 := Qk;

      Xk := (Z * K5 * K6) / (K7 * K8);
      Pk := Pkm1 + Pkm2 * Xk;
      Qk := Qkm1 + Qkm2 * Xk;
      Pkm2 := Pkm1;
      Pkm1 := Pk;
      Qkm2 := Qkm1;
      Qkm1 := Qk;

      if Qk <> 0.0 then R := Pk / Qk;

      if R <> 0.0 then begin
          T := Abs((Ans - R) / R);
          Ans := R;
        end
      else
        T := 1.0;

      if T < Thresh then goto CDone;

      K1 := K1 + 1.0;
      K2 := K2 - 1.0;
      K3 := K3 + 2.0;
      K4 := K4 + 2.0;
      K5 := K5 + 1.0;
      K6 := K6 + 1.0;
      K7 := K7 + 2.0;
      K8 := K8 + 2.0;

      if Abs(Qk) + Abs(Pk) > BIG then begin
          Pkm2 := Pkm2 * BIGINV;
          Pkm1 := Pkm1 * BIGINV;
          Qkm2 := Qkm2 * BIGINV;
          Qkm1 := Qkm1 * BIGINV;
        end;

      if (Abs(Qk) < BIGINV) or (Abs(Pk) < BIGINV) then
        begin
          Pkm2 := Pkm2 * BIG;
          Pkm1 := Pkm1 * BIG;
          Qkm2 := Qkm2 * BIG;
          Qkm1 := Qkm1 * BIG;
        end;
      N := N + 1;
    until N > 400;
    MathError := FN_PLOSS;

CDone:
    CFrac2 := Ans;
  end;

  function IBeta(A, B, X : Float) : Float;
  var
    A1, B1, X1, T, W, Xc, Y : Float;
    Flag : Boolean;
  label
    Done;
  begin
    MathError := FN_OK;

    if (A <= 0.0) or (B <= 0.0) or (X < 0.0) then begin
        IBeta := DefaultVal(FN_DOMAIN, 0.0);
        Exit;
      end;

    if X > 1.0 then begin
        IBeta := DefaultVal(FN_DOMAIN, 1.0);
        Exit;
      end;

    if (X = 0.0) or (X = 1.0) then begin
        IBeta := X;
        Exit;
      end;

    Flag := False;
    if (B * X <= 1.0) and (X <= 0.95) then
      begin
        T := PSeries(A, B, X);
        goto Done;
      end;

    W := 1.0 - X;

    { Reverse a and b if x is greater than the mean. }
    if X > A / (A + B) then begin
        Flag := True;
        A1 := B;
        B1 := A;
        Xc := X;
        X1 := W;
      end
    else begin
        A1 := A;
        B1 := B;
        Xc := W;
        X1 := X;
      end;

    if Flag and (B1 * X1 <= 1.0) and (X1 <= 0.95) then begin
        T := PSeries(A1, B1, X1);
        goto Done;
      end;

    { Choose expansion for optimal convergence }
    Y := X1 * (A1 + B1 - 2.0) - (A1 - 1.0);
    if Y < 0.0 then
      W := CFrac1(A1, B1, X1)
    else
      W := CFrac2(A1, B1, X1) / Xc;

    { Multiply w by the factor
     a      b   _             _     _
    x  (1-x)   | (a+b) / ( a | (a) | (b) )    }

    Y := A1 * Ln(X1);
    T := B1 * Ln(Xc);
    if (A1 + B1 < MAXGAM) and (Abs(Y) < MAXLOG) and (Abs(T) < MAXLOG) then begin
        T := Power(Xc, B1) ;
        T := T * Power(X1, A1);
        T := T / A1;
        T := T * W;
        T := T * Gamma(A1 + B1) / (Gamma(A1) * Gamma(B1));
      end
    else begin
        { Resort to logarithms }
        Y := Y + T + LnGamma(A1 + B1) - LnGamma(A1) - LnGamma(B1) + Ln(W / A1);
        if Y < MINLOG then
          T := 0.0
        else
          T := Exp(Y);
      end;

Done:
    if Flag then
      if T <= MACHEP then
        T := 1.0 - MACHEP
      else
        T := 1.0 - T;

    IBeta := T;
  end;

  function Erf(X : Float) : Float;
  begin
    if X < 0.0
      then Erf := - IGamma(0.5, Sqr(X))
      else Erf := IGamma(0.5, Sqr(X));
  end;

  function Erfc(X : Float) : Float;
  begin
    if X < 0.0
       then Erfc := 1.0 + IGamma(0.5, Sqr(X))
       else Erfc := JGamma(0.5, Sqr(X));
  end;

{ ----------------------------------------------------------------------
  Probability functions
  ---------------------------------------------------------------------- }

  function PBinom(N : Integer; P : Float; K : Integer) : Float;
  begin
    MathError := FN_OK;
    if (P < 0.0) or (P > 1.0) or (N <= 0) or (N < K) then
      PBinom := DefaultVal(FN_DOMAIN, 0.0)
    else if K = 0 then
      PBinom := Power(1.0 - P, N)
    else if K = N then
      PBinom := Power(P, N)
    else
      PBinom := Binomial(N, K) * Power(P, K) * Power(1.0 - P, N - K);
  end;

  function FBinom(N : Integer; P : Float; K : Integer) : Float;
  begin
    MathError := FN_OK;
    if (P < 0.0) or (P > 1.0) or (N <= 0) or (N < K) then
      FBinom := DefaultVal(FN_DOMAIN, 0.0)
    else if K = 0 then
      FBinom := Power(1.0 - P, N)
    else if K = N then
      FBinom := 1.0
    else
      FBinom := 1.0 - IBeta(K + 1, N - K, P);
  end;

  function PPoisson(Mu : Float; K : Integer) : Float;
  var
    P : Float;
    I : Integer;
  begin
    MathError := FN_OK;
    if (Mu <= 0.0) or (K < 0) then
      PPoisson := DefaultVal(FN_DOMAIN, 0.0)
    else if K = 0 then
      PPoisson := Expo(- Mu)
    else
      begin
        P := Mu;
        for I := 2 to K do
          P := P * Mu / I;
        PPoisson := Expo(- Mu) * P;
      end;
  end;

  function FPoisson(Mu : Float; K : Integer) : Float;
  begin
    MathError := FN_OK;
    if (Mu <= 0.0) or (K < 0) then
      FPoisson := DefaultVal(FN_DOMAIN, 0.0)
    else if K = 0 then
      FPoisson := Expo(- Mu)
    else
      FPoisson := JGamma(K + 1, Mu);
  end;

  function DNorm(X : Float) : Float;
  begin
    DNorm := INVSQRT2PI * Expo(- 0.5 * Sqr(X));
  end;

  function FNorm(X : Float) : Float;
  begin
    FNorm := 0.5 * (1.0 + Erf(X * SQRT2DIV2));
  end;

  function InvNorm(P : Float) : Float;
{ ----------------------------------------------------------------------
  Inverse of Normal distribution function

  Returns the argument, X, for which the area under the Gaussian
  probability density function (integrated from minus infinity to X)
  is equal to P.
  ---------------------------------------------------------------------- }
  const
    P0 : TabCoef = (
        8.779679420055069160496E-3,
      - 7.649544967784380691785E-1,
        2.971493676711545292135E0,
      - 4.144980036933753828858E0,
        2.765359913000830285937E0,
      - 9.570456817794268907847E-1,
        1.659219375097958322098E-1,
      - 1.140013969885358273307E-2,
        0, 0);

    Q0 : TabCoef = (
      - 5.303846964603721860329E0,
        9.908875375256718220854E0,
      - 9.031318655459381388888E0,
        4.496118508523213950686E0,
      - 1.250016921424819972516E0,
        1.823840725000038842075E-1,
      - 1.088633151006419263153E-2,
        0, 0, 0);

    P1 : TabCoef = (
      4.302849750435552180717E0,
      4.360209451837096682600E1,
      9.454613328844768318162E1,
      9.336735653151873871756E1,
      5.305046472191852391737E1,
      1.775851836288460008093E1,
      3.640308340137013109859E0,
      3.691354900171224122390E-1,
      1.403530274998072987187E-2,
      1.377145111380960566197E-4);

    Q1 : TabCoef = (
      2.001425109170530136741E1,
      7.079893963891488254284E1,
      8.033277265194672063478E1,
      5.034715121553662712917E1,
      1.779820137342627204153E1,
      3.845554944954699547539E0,
      3.993627390181238962857E-1,
      1.526870689522191191380E-2,
      1.498700676286675466900E-4,
      0);

    P2 : TabCoef = (
      3.244525725312906932464E0,
      6.856256488128415760904E0,
      3.765479340423144482796E0,
      1.240893301734538935324E0,
      1.740282292791367834724E-1,
      9.082834200993107441750E-3,
      1.617870121822776093899E-4,
      7.377405643054504178605E-7,
      0, 0);

    Q2 : TabCoef = (
      6.021509481727510630722E0,
      3.528463857156936773982E0,
      1.289185315656302878699E0,
      1.874290142615703609510E-1,
      9.867655920899636109122E-3,
      1.760452434084258930442E-4,
      8.028288500688538331773E-7,
      0, 0, 0);

    P3 : TabCoef = (
        2.020331091302772535752E0,
        2.133020661587413053144E0,
        2.114822217898707063183E-1,
      - 6.500909615246067985872E-3,
      - 7.279315200737344309241E-4,
      - 1.275404675610280787619E-5,
      - 6.433966387613344714022E-8,
      - 7.772828380948163386917E-11,
        0, 0);

    Q3 : TabCoef = (
        2.278210997153449199574E0,
        2.345321838870438196534E-1,
      - 6.916708899719964982855E-3,
      - 7.908542088737858288849E-4,
      - 1.387652389480217178984E-5,
      - 7.001476867559193780666E-8,
      - 8.458494263787680376729E-11,
        0, 0, 0);

  var
    X, Y, Z, Y2, X0, X1 : Float;
    Code : Integer;
  begin
    if (P <= 0.0) or (P >= 1.0) then begin
        InvNorm := DefaultVal(FN_DOMAIN, 0.0);
        Exit;
      end;

    Code := 1;
    Y := P;
    if Y > (1.0 - 0.13533528323661269189) then begin { 0.135... = exp(-2) }
        Y := 1.0 - Y;
        Code := 0;
      end;
    if Y > 0.13533528323661269189 then begin
        Y := Y - 0.5;
        Y2 := Y * Y;
        X := Y + Y * (Y2 * PolEvl(Y2, P0, 7) / P1Evl(Y2, Q0, 7));
        X := X * SQRT2PI;
        InvNorm := X;
        Exit;
      end;

    X := Sqrt(- 2.0 * Ln(Y));
    X0 := X - Ln(X) / X;
    Z := 1.0 / X;
    if X < 8.0 then
      X1 := Z * PolEvl(Z, P1, 9) / P1Evl(Z, Q1, 9)
    else if X < 32.0 then
      X1 := Z * PolEvl(Z, P2, 7) / P1Evl(Z, Q2, 7)
    else
      X1 := Z * PolEvl(Z, P3, 7) / P1Evl(Z, Q3, 7);
    X := X0 - X1;
    if Code <> 0 then
      X := - X;
    InvNorm := X;
  end;

  function PNorm(X : Float) : Float;
  var
    A : Float;
  begin
    A := Abs(X);
    MathError := FN_OK;
    if A = 0.0 then
      PNorm := 1.0
    else if A < 1.0 then
      PNorm := 1.0 - Erf(A * SQRT2DIV2)
    else
      PNorm := Erfc(A * SQRT2DIV2);
  end;

  function DStudent(Nu : Integer; X : Float) : Float;
  var
    L, P, Q : Float;
  begin
    MathError := FN_OK;
    if Nu < 1 then
      DStudent := DefaultVal(FN_DOMAIN, 0.0)
    else
      begin
        P := 0.5 * (Nu + 1);
    	Q := 0.5 * Nu;
    	L := LnGamma(P) - LnGamma(Q) - 0.5 * Ln(Nu * PI) - P * Ln(1.0 + Sqr(X) / Nu);
    	DStudent := Expo(L);
      end;
  end;

  function FStudent(Nu : Integer; X : Float) : Float;
  var
    F : Float;
  begin
    MathError := FN_OK;
    if Nu < 1 then
      FStudent := DefaultVal(FN_DOMAIN, 0.0)
    else if X = 0.0 then
      FStudent := 0.5
    else
      begin
        F := 0.5 * IBeta(0.5 * Nu, 0.5, Nu / (Nu + Sqr(X)));
        if X < 0.0 then FStudent := F else FStudent := 1.0 - F;
      end;
  end;

  function PStudent(Nu : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    if Nu < 1 then
      PStudent := DefaultVal(FN_DOMAIN, 0.0)
    else
      PStudent := IBeta(0.5 * Nu, 0.5, Nu / (Nu + Sqr(X)));
  end;

  function DKhi2(Nu : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    DKhi2 := DGamma(0.5 * Nu, 0.5, X);
  end;

  function FKhi2(Nu : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    if (Nu < 1) or (X <= 0.0) then
      FKhi2 := DefaultVal(FN_DOMAIN, 0.0)
    else
      FKhi2 := IGamma(0.5 * Nu, 0.5 * X);
  end;

  function PKhi2(Nu : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    if (Nu < 1) or (X <= 0.0) then
      PKhi2 := DefaultVal(FN_DOMAIN, 0.0)
    else
      PKhi2 := JGamma(0.5 * Nu, 0.5 * X);
  end;

  function DSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;
  var
    P1, P2, R, S, L : Float;
  begin
    MathError := FN_OK;
    if (Nu1 < 1) or (Nu2 < 1) or (X <= 0.0) then
      DSnedecor := DefaultVal(FN_DOMAIN, 0.0)
    else begin
        R := Int(Nu1) / Int(Nu2);
        P1 := 0.5 * Nu1;
        P2 := 0.5 * Nu2;
        S := P1 + P2;
        L := LnGamma(S) - LnGamma(P1) - LnGamma(P2) + P1 * Ln(R) +
               (P1 - 1.0) * Ln(X) - S * Ln(1.0 + R * X);
        DSnedecor := Expo(L);
      end;
  end;

  function FSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    if (Nu1 < 1) or (Nu2 < 1) or (X <= 0.0) then
      FSnedecor := DefaultVal(FN_DOMAIN, 0.0)
    else
      FSnedecor := 1.0 - IBeta(0.5 * Nu2, 0.5 * Nu1, Nu2 / (Nu2 + Nu1 * X));
  end;

  function PSnedecor(Nu1, Nu2 : Integer; X : Float) : Float;
  begin
    MathError := FN_OK;
    if (Nu1 < 1) or (Nu2 < 1) or (X <= 0.0) then
      PSnedecor := DefaultVal(FN_DOMAIN, 0.0)
    else
      PSnedecor := IBeta(0.5 * Nu2, 0.5 * Nu1, Nu2 / (Nu2 + Nu1 * X));
  end;

  function DExpo(A, X : Float) : Float;
  begin
    if (A <= 0.0) or (X < 0.0) then
      DExpo := DefaultVal(FN_DOMAIN, 0.0)
    else
      DExpo := A * Expo(- A * X);
  end;

  function FExpo(A, X : Float) : Float;
  begin
    if (A <= 0.0) or (X < 0.0) then
      FExpo := DefaultVal(FN_DOMAIN, 0.0)
    else
      FExpo := 1.0 - Expo(- A * X);
  end;

  function DBeta(A, B, X : Float) : Float;
  var
    L : Float;
  begin
    MathError := FN_OK;
    if (A <= 0.0) or (B <= 0.0) or (X < 0.0) or (X > 1.0) then
      DBeta := DefaultVal(FN_DOMAIN, 0.0)
    else if X = 0.0 then
      if A < 1.0 then DBeta := DefaultVal(FN_SING, MAXNUM) else DBeta := 0.0
    else if X = 1.0 then
      if B < 1.0 then DBeta := DefaultVal(FN_SING, MAXNUM) else DBeta := 0.0
    else begin
        L := LnGamma(A + B) - LnGamma(A) - LnGamma(B) +
               (A - 1.0) * Ln(X) + (B - 1.0) * Ln(1.0 - X);
        DBeta := Expo(L);
      end;
  end;

  function FBeta(A, B, X : Float) : Float;
  begin
    FBeta := IBeta(A, B, X);
  end;

  function DGamma(A, B, X : Float) : Float;
  var
    L : Float;
  begin
    MathError := FN_OK;
    if (A <= 0.0) or (B <= 0.0) or (X < 0.0) then
      DGamma := DefaultVal(FN_DOMAIN, 0.0)
    else if X = 0.0 then
      if A < 1.0 then
        DGamma := DefaultVal(FN_SING, MAXNUM)
      else if A = 1.0 then
        DGamma := B
      else
        DGamma := 0.0
    else begin
        L := A * Ln(B) - LnGamma(A) + (A - 1.0) * Ln(X) - B * X;
        DGamma := Expo(L);
      end;
  end;

  function FGamma(A, B, X : Float) : Float;
  begin
    FGamma := IGamma(A, B * X);
  end;

Initialization

  MathError := FN_OK;
end.
