unit student;

interface

const
  big = 4.503599627370496e15;
  biginv =  2.22044604925031308085e-16;
  MACHEP = 1e-50;// (the machine roundoff error)
  MAXNUM = 1e+50;// (largest number represented)
  MAXLOG = 1e+50;
  MINLOG = 1e-50;


//Incomplete beta integral
functio incbet( a, b, x : double) : double;
// DESCRIPTION:

// Returns incomplete beta integral of the arguments, evaluated
// from zero to x.  The function is defined as
// The domain of definition is 0 <= x <= 1.  In this
// implementation a and b are restricted to positive values.
// The integral from x to 1 may be obtained by the symmetry
// relation

//    1 - incbet( a, b, x )  =  incbet( b, a, 1-x ).

// The integral is evaluated by a continued fraction expansion
// or, when b*x is small, by a power series.

// ACCURACY:

// Tested at uniformly distributed random points (a,b,x) with a and b
// in "domain" and x between 0 and 1.
//                                        Relative error
 // arithmetic   domain     # trials      peak         rms
//    IEEE      0,5         10000       6.9e-15     4.5e-16
//    IEEE      0,85       250000       2.2e-13     1.7e-14
//    IEEE      0,1000      30000       5.3e-12     6.3e-13
//    IEEE      0,10000    250000       9.3e-11     7.1e-12
//    IEEE      0,100000    10000       8.7e-10     4.8e-11
// Outputs smaller than the IEEE gradual underflow threshold
// were excluded from these statistics.


//   Inverse of imcomplete beta integral
function incbi(a,b,y : double) : double;
// DESCRIPTION:

// Given y, the function finds x such that
//  incbet( a, b, x ) = y .

// The routine performs interval halving or Newton iterations to find the
// root of incbet(a,b,x) - y = 0.


// ACCURACY:

 //                      Relative error:
//                x     a,b
// arithmetic   domain  domain  # trials    peak       rms
//    IEEE      0,1    .5,10000   50000    5.8e-12   1.3e-13
//    IEEE      0,1   .25,100    100000    1.8e-13   3.9e-15
//    IEEE      0,1     0,5       50000    1.1e-12   5.5e-15

// With a and b constrained to half-integer or integer values:
//    IEEE      0,1    .5,10000   50000    5.8e-12   1.1e-13
//    IEEE      0,1    .5,100    100000    1.7e-14   7.9e-16
// With a = .5, b constrained to half-integer or integer values:
//   IEEE      0,1    .5,10000   10000    8.3e-11   1.0e-11

//	Student's t distribution
function stdtr(k : integer;t : double) : double;
// DESCRIPTION:
// Computes the integral from minus infinity to t of the Student
// t distribution with integer k > 0 degrees of freedom:

// Relation to incomplete beta integral:
//     1 - stdtr(k,t) = 0.5 * incbet( k/2, 1/2, z )
// where
//       z = k/(k + t^2).

// For t < -2, this is the method of computation.  For higher t,
// a direct method is derived from integration by parts.
// Since the function is symmetric about t=0, the area under the
// right tail of the density is found by calling the function
// with -t instead of t.

// ACCURACY:
// Tested at random 1 <= k <= 25.  The "domain" refers to t.
//                      Relative error:
// arithmetic   domain     # trials      peak         rms
//    IEEE     -100,-2      50000       5.9e-15     1.4e-15
//    IEEE     -2,100      500000       2.7e-15     4.9e-17

//Functional inverse of Student's t distribution
function stdtri(k : integer;p : double) : double;
// t = stdtri( k, p );
// DESCRIPTION:
// Given probability p, finds the argument t such that stdtr(k,t)
// is equal to p.
// ACCURACY:

// Tested at random 1 <= k <= 100.  The "domain" refers to p:
//                      Relative error:
// arithmetic   domain     # trials      peak         rms
//    IEEE    .001,.999     25000       5.7e-15     8.0e-16
//    IEEE    10^-6,.001    25000       2.0e-12     2.9e-14

//Cephes Math Library Release 2.8:  June, 2000
//Copyright 1984, 1987, 1995, 2000 by Stephen L. Moshier

extern double PI;
#ifdef ANSIPROT
extern double sqrt ( double );
extern double atan ( double );
extern double incbet ( double, double, double );
extern double incbi ( double, double, double );
extern double fabs ( double );
#else
double sqrt(), atan(), incbet(), incbi(), fabs();
#endif

funnction stdtr( k : integer;t : double) : double;
var
x, rk, z, f, tz, p, xsqk : double;
j : integer;

if ( k <= 0 ) then result := 0.0;
if ( t = 0 ) then result := 0.5;

if ( t < -2.0 ) then begin
	rk := k;
	z := rk / (rk + t * t);
	p := 0.5 * incbet( 0.5*rk, 0.5, z );
	result := p;
end;

//	compute integral from -t to + t */

if ( t < 0 )
	then x := -t
  else x := t;

rk := k;	// degrees of freedom
z := 1.0 + ( x * x )/rk;

// test if k is odd or even
if( (k & 1) <> 0)
	then begin //	computation for odd k
	xsqk = x/sqrt(rk);
	p := atan( xsqk );
	if( k > 1 ) then begin
		f := 1.0;
		tz := 1.0;
		j := 3;
		while(  (j<=(k-2)) and ( (tz/f) > MACHEP )  )
			tz :=tz*(j-1)/( z * j );
			f := f+tz;
			j := j+2;
		end;
    p := p + f * xsqk/z;
		end;
	p := p*2.0/PI;
	end

else begin //	computation for even k
	f := 1.0;
	tz := 1.0;
	j := 2;
	while(  ( j <= (k-2) ) and ( (tz/f) > MACHEP )  )
		tz := tz*(j - 1)/( z * j );
		f := f+tz;
		j := j+2;
		end;
	p := f * x/sqrt(z*rk);
	end;

//	common exit	

if( t < 0 ) then p = -p;	// note destruction of relative accuracy

	p := 0.5 + 0.5 * p;
result := p;
end;

function stdtri( k : integer; p : double) : double;
var t, rk, z : double;
    rflg : integer;

if ( k <= 0 || p <= 0.0 || p >= 1.0 )
	then	result := 0;

rk := k;

if( p > 0.25 and p < 0.75 )
	then begin
	if ( p = 0.5 ) then result := 0.0;
	z := 1.0 - 2.0 * p;
	z := incbi( 0.5, 0.5*rk, fabs(z) );
	t := sqrt( rk*z/(1.0-z) );
	if( p < 0.5 ) then t := -t;
	result := t;
	end;
rflg = -1;
if( p >= 0.5) then begin
	p := 1.0 - p;
	rflg := 1;
	end;
z := incbi( 0.5*rk, 0.5, 2.0*p );

if( MAXNUM * z < rk ) then result := rflg* MAXNUM;
t := sqrt( rk/z - rk );
result := rflg * t;
end;

function incbi( aa, bb, yy0 : double ) : double;
var a, b, y0, d, y, x, x0, x1, lgm, yp, di, dithresh, yl, yh, xt : double;
    i, rflg, dir, nflg : integer;
begin

i := 0;
if( yy0 <= 0 ) then result := 0.0;
if( yy0 >= 1.0 ) then result := 1.0;
x0 := 0.0;
yl := 0.0;
x1 := 1.0;
yh := 1.0;
nflg := 0;

if( aa <= 1.0 or bb <= 1.0 )
	then begin
	dithresh := 1.0e-6;
	rflg := 0;
	a := aa;
	b := bb;
	y0 := yy0;
	x := a/(a+b);
	y := incbet( a, b, x );
	goto ihalve;
	end
else dithresh := 1.0e-4;
// approximation to inverse function

yp := -ndtri(yy0);

if( yy0 > 0.5 )
	then begin
	rflg := 1;
	a := bb;
	b := aa;
	y0 := 1.0 - yy0;
	yp := -yp;
	end
else begin
	rflg := 0;
	a := aa;
	b := bb;
	y0 := yy0;
	end;

lgm := (yp * yp - 3.0)/6.0;
x := 2.0/( 1.0/(2.0*a-1.0)  +  1.0/(2.0*b-1.0) );
d := yp * sqrt( x + lgm ) / x
	- ( 1.0/(2.0*b-1.0) - 1.0/(2.0*a-1.0) )
	* (lgm + 5.0/6.0 - 2.0/(3.0*x));
d := 2.0 * d;
if( d < MINLOG ) then begin
	x := 1.0;
	goto under;
	end;
x := a/( a + b * exp(d) );
y := incbet( a, b, x );
yp := (y - y0)/y0;
if( fabs(yp) < 0.2 ) then goto newt;

// Resort to interval halving if not close enough.
ihalve:

dir := 0;
di := 0.5;
for i:=0 to i=99	do begin
	if( i <> 0 )
		then begin
		x := x0  +  di * (x1 - x0);
		if( x = 1.0 ) then x := 1.0 - MACHEP;
		if( x = 0.0 )
			then begin
			di := 0.5;
			x := x0  +  di * (x1 - x0);
			if( x == 0.0 ) then goto under;
			end;
		y := incbet( a, b, x );
		yp := (x1 - x0)/(x1 + x0);
		if( fabs(yp) < dithresh )
			goto newt;
		yp := (y-y0)/y0;
		if( fabs(yp) < dithresh )
			goto newt;
		end;
	if( y < y0 )
		then begin
		x0 := x;
		yl := y;
		if( dir < 0 )
			then begin
			dir := 0;
			di := 0.5;
			end
		else if( dir > 3 ) then di = 1.0 - (1.0 - di) * (1.0 - di);
		else if( dir > 1 ) then di = 0.5 * di + 0.5;
		else di = (y0 - y)/(yh - yl);
		dir := di+1;
		if( x0 > 0.75 )
			then begin
			if( rflg == 1 )
				then begin
				rflg := 0;
				a := aa;
				b := bb;
				y0 := yy0;
				end
			else begin
				rflg := 1;
				a := bb;
				b := aa;
				y0 := 1.0 - yy0;
				end;
			x := 1.0 - x;
			y := incbet( a, b, x );
			x0 := 0.0;
			yl := 0.0;
			x1 := 1.0;
			yh := 1.0;
			goto ihalve;
			end;
		end
	else begin
		x1 := x;
		if( rflg = 1 and x1 < MACHEP ) then begin
			x := 0.0;
			goto done;
			end;
		yh := y;
		if( dir > 0 ) then begin
			dir := 0;
			di := 0.5;
			end
		else if( dir < -3 ) then di := di * di;
		else if( dir < -1 ) then di := 0.5 * di;
		else di := (y - y0)/(yh - yl);
		dir := di-1;
		end;
	end;
mtherr( "incbi", PLOSS );
if( x0 >= 1.0 ) then begin
	x := 1.0 - MACHEP;
	goto done;
	end;
if( x <= 0.0 ) then begin
under:
	mtherr( "incbi", UNDERFLOW );
	x := 0.0;
	goto done;
	end;

newt:

if( nflg ) then goto done;
nflg := 1;
lgm := lgam(a+b) - lgam(a) - lgam(b);

for  i=0 to i=7	do begin
// Compute the function at this point.
	if( i <> 0 ) then y = incbet(a,b,x);
	if( y < yl )
		then begin
		x := x0;
		y := yl;
		end
	else if( y > yh )
		then begin
		x := x1;
		y := yh;
		end
	else if( y < y0 )
		then begin
		x0 := x;
		yl := y;
		end
	else begin
		x1 := x;
		yh := y;
		end
	if( x = 1.0 or x = 0.0 ) then  break;
// Compute the derivative of the function at this point.
	d = (a - 1.0) * log(x) + (b - 1.0) * log(1.0-x) + lgm;
	if( d < MINLOG ) then goto done;
	if( d > MAXLOG ) then break;
	d = exp(d);
// Compute the step to the next approximation of x.
	d := (y - y0)/d;
	xt := x - d;
	if( xt <= x0 )
		then begin
		y := (x - x0) / (x1 - x0);
		xt := x0 + 0.5 * y * (x - x0);
		if( xt <= 0.0 ) then break;
		end;
	if( xt >= x1 )
		then begin
		y := (x1 - x) / (x1 - x0);
		xt := x1 - 0.5 * y * (x1 - x);
		if( xt >= 1.0 ) then break;
		end;
	x := xt;
	if( fabs(d/x) < 128.0 * MACHEP ) then goto done;
	end;
// Did not converge.
dithresh := 256.0 * MACHEP;
goto ihalve;

done:

if( rflg )
	then begin
	if( x <= MACHEP ) then x = 1.0 - MACHEP;
	else x = 1.0 - x;
	end
result :=  x ;
end;


function incbet( aa, bb, xx : double) : double;
var a, b, t, x, xc, w, y : double;
    flag : integer;
begin
if( aa <= 0.0 or bb <= 0.0 ) then goto domerr;

if( (xx <= 0.0) or ( xx >= 1.0) )
	then begin
	if( xx = 0.0 ) then result := 0.0;
	if( xx = 1.0 ) then result :=  1.0;
domerr:
	mtherr( "incbet", DOMAIN );
	result := 0.0;
	end;

flag := 0;
if( (bb * xx) <= 1.0 and xx <= 0.95)
	then begin
  	t := pseries(aa, bb, xx);
		goto done;
	end;

w = 1.0 - xx;

// Reverse a and b if x is greater than the mean.
if( xx > (aa/(aa+bb)) )
	then begin
	flag := 1;
	a := bb;
	b := aa;
	xc := xx;
	x := w;
	end
else begin
	a := aa;
	b := bb;
	xc := w;
	x := xx;
	end;

if( flag = 1 and (b * x) <= 1.0 and x <= 0.95)
	then begin
	t := pseries(a, b, x);
	goto done;
	end;

// Choose expansion for better convergence.
y := x * (a+b-2.0) - (a-1.0);
if( y < 0.0 )
   then w := incbcf( a, b, x )
   else w := incbd( a, b, x ) / xc;

// Multiply w by the factor

y := a * log(x);
t := b * log(xc);
if( (a+b) < MAXGAM and fabs(y) < MAXLOG and fabs(t) < MAXLOG )
	then begin
	t := pow(xc,b);
	t := t*pow(x,a);
	t := t/a;
	t := t*w;
	t := t*gamma(a+b) / (gamma(a) * gamma(b));
	goto done;
	end;
// Resort to logarithms.
y := y+t + lgam(a+b) - lgam(a) - lgam(b);
y := y+log(w/a);
if( y < MINLOG )
   then t := 0.0
   else t := exp(y);

done:

if( flag = 1 )
	then begin
	if( t <= MACHEP ) then t := 1.0 - MACHEP
	else t := 1.0 - t;
	end;
result :=  t ;
end;

// Continued fraction expansion #1
// for incomplete beta integral


function double incbcf( a, b, x : double) : double;
var xk, pk, pkm1, pkm2, qk, qkm1, qkm2 : double;
    k1, k2, k3, k4, k5, k6, k7, k8 : double;
    r, t, ans, thresh : double;
    n : integer;
begin
k1 := a;
k2 := a + b;
k3 := a;
k4 := a + 1.0;
k5 := 1.0;
k6 := b - 1.0;
k7 := k4;
k8 := a + 2.0;

pkm2 := 0.0;
qkm2 := 1.0;
pkm1 := 1.0;
qkm1 := 1.0;
ans := 1.0;
r := 1.0;
n := 0;
thresh := 3.0 * MACHEP;
repeat

	xk := -( x * k1 * k2 )/( k3 * k4 );
	pk := pkm1 +  pkm2 * xk;
	qk := qkm1 +  qkm2 * xk;
	pkm2 := pkm1;
	pkm1 := pk;
	qkm2 := qkm1;
	qkm1 := qk;

	xk := ( x * k5 * k6 )/( k7 * k8 );
	pk := pkm1 +  pkm2 * xk;
	qk := qkm1 +  qkm2 * xk;
	pkm2 := pkm1;
	pkm1 := pk;
	qkm2 := qkm1;
	qkm1 := qk;

	if( qk <> 0 ) then r := pk/qk;
	if( r <> 0 )
		then begin
		t := fabs( (ans - r)/r );
		ans := r;
		end
	else t := 1.0;

	if( t < thresh ) then goto cdone;

	k1 := k1+1.0;
	k2 := k2+1.0;
	k3 := k3+2.0;
	k4 := k4+2.0;
	k5 := k5+1.0;
	k6 := k6-1.0;
	k7 := k7+2.0;
	k8 := k8+2.0;

	if( (fabs(qk) + fabs(pk)) > big )
		then begin
    pkm2 := pkm2*biginv;
		pkm1 := pkm1*biginv;
		qkm2 := qkm2*biginv;
		qkm1 := qkm1*biginv;
		end;
	if( (fabs(qk) < biginv) or (fabs(pk) < biginv) )
		then begin
		pkm2 := pkm2*big;
		pkm1 := pkm1*big;
		qkm2 := qkm2*big;
		qkm1 := qkm1big;
		end;
	}
until n>=300;

cdone:
result := ans;
end;

// Continued fraction expansion #2
// for incomplete beta integral

function double incbd( a, b, x  : double) : double
var xk, pk, pkm1, pkm2, qk, qkm1, qkm2  : double;
    k1, k2, k3, k4, k5, k6, k7, k8  : double;
    r, t, ans, z, thresh  : double;
     n : integer;
begin
k1 := a;
k2 := b - 1.0;
k3 := a;
k4 := a + 1.0;
k5 := 1.0;
k6 := a + b;
k7 := a + 1.0;;
k8 := a + 2.0;

pkm2 := 0.0;
qkm2 := 1.0;
pkm1 := 1.0;
qkm1 := 1.0;
z := x / (1.0-x);
ans := 1.0;
r := 1.0;
n := 0;
thresh := 3.0 * MACHEP;
repeat
	xk := -( z * k1 * k2 )/( k3 * k4 );
	pk := pkm1 +  pkm2 * xk;
	qk := qkm1 +  qkm2 * xk;
	pkm2 := pkm1;
	pkm1 := pk;
	qkm2 := qkm1;
	qkm1 := qk;

	xk := ( z * k5 * k6 )/( k7 * k8 );
	pk := pkm1 +  pkm2 * xk;
	qk := qkm1 +  qkm2 * xk;
	pkm2 := pkm1;
	pkm1 := pk;
	qkm2 := qkm1;
	qkm1 := qk;

	if( qk <> 0 ) then r := pk/qk;
	if( r <> 0 )
		then begin
		t := fabs( (ans - r)/r );
		ans := r;
		end
	else t := 1.0;

	if( t < thresh ) then goto cdone;

	k1 := k1+1.0;
	k2 := k2-1.0;
	k3 := k3+2.0;
	k4 := k4+2.0;
	k5 := k5+1.0;
	k6 := k6+1.0;
	k7 := k7+2.0;
	k8 := k8+2.0;

	if( (fabs(qk) + fabs(pk)) > big )
		then begin
		pkm2 = pkm2*biginv;
		pkm1 = pkm1*biginv;
		qkm2 = qkm2*biginv;
		qkm1 = qkm1*biginv;
		end;
	if( (fabs(qk) < biginv) or (fabs(pk) < biginv) )
		then begin
		pkm2 := pkm2*big;
		pkm1 := pkm1*big;
		qkm2 := qkm2*big;
		qkm1 := qkm1*big;
		end
    inc(n);
until n>=300;
cdone:
result := ans;
end;

// Power series for incomplete beta integral.
// Use when b*x is small and x not too close to 1.

function pseries( a, b, x  : double) : double
var s, t, u, v, n, t1, z, ai  : double;
begin
ai := 1.0 / a;
u := (1.0 - b) * x;
v := u / (a + 1.0);
t1 := v;
t := u;
n := 2.0;
s := 0.0;
z := MACHEP * ai;
while( fabs(v) > z )	do begin
	u := (n - b) * x / n;
	t *= u;
	v := t / (a + n);
	s := s+v;
	n := n+1.0;
	end;
s :=s+ t1;
s := s+ai;

u := a * log(x);
if( (a+b) < MAXGAM and fabs(u) < MAXLOG )
	then begin
	t := gamma(a+b)/(gamma(a)*gamma(b));
	s := s * t * pow(x,a);
	end
else begin

	t := lgam(a+b) - lgam(a) - lgam(b) + u + log(s);
	if( t < MINLOG ) then s := 0.0
	else s := exp(t);
	end;
result := s;
end;

