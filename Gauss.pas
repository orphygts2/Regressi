Procedure CherchePeriode(const Y : vecteur;nbre : integer;var iDebut,iFin : integer);
const NbreRef = 5;
var Ymin,Ymax,Ymoy : reel;
    ecartQuad,ecartMin,ecartMinQuad : reel;
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
     { Premier passage par "zéro" (vers le bas par ex.) }
     iFin := iDebut+NbreRef;
     while (iFin<pred(Nbre)) and
           ((Y[iDebut]-Ymoy)*(Y[iFin]-Ymoy)>=0) do inc(iFin);
     { On repasse au dessus (par ex.) du "zéro" }
     iFin := iFin+NbreRef;
     while (iFin<pred(Nbre)) and
           ((Y[iDebut]-Ymoy)*(Y[iFin]-Ymoy)<=0) do inc(iFin);
     { On repasse par "zéro" dans le même sens }
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
end;

Procedure Resolution(A : matrice;ordre : integer;var Result : matriceLigne);
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
         raise EsystemeLineaireError.Create('Erreur résolution système linéaire')
    END;

    PROCEDURE Permute(i,j:integer);
    Var temp:reel;
        k:integer;
    BEGIN
       if i<>j then For k:=i to ordre+1 do BEGIN
          temp:=A[i,k];
          A[i,k]:=A[j,k];
          A[j,k]:=temp;
       END;
    END;

  var I,J,K : integer;
      M : reel;
  begin
    for k := 1 to ordre do begin
          Permute(k,pivot(k));
          for i:=k+1 to ordre do begin
              M := A[i,k]/A[k,k];
              for j:=k+1 to ordre+1 do A[i,j]:=A[i,j]-M*A[k,j];
              A[i,k]:=0.0;
          end;
       end;
    end; {Elimination}

    Procedure Substitution;
    var I,J : integer;
        S : reel;
    begin
         try
         for I:=ordre downto 1 do begin
             S:=A[I,ordre+1];
             for J:=I+1 to ordre do S:=S-A[I,J]*Result[J];
             Result[I]:=S/A[I,I];
         end;
         except
            on EzeroDivide do raise EsystemeLineaireError.Create('Erreur résolution système linéaire')
         end;
    end;

begin {Resolution}
  Elimination;
  Substitution;
end; {résolution}

procedure DeriveeGauss(const X,Yr : vecteur;N : integer;
   var Yder : vecteur;degreDer,NbrePointDer : integer);
var puissX : vectorPuiss;
    A : matrice;
    Coeff : matriceLigne;
    ii,puissMax,ordre : integer;

procedure initXY;
var j : integer;
    loc : reel;
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
var ajoute,retire : reel;
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

procedure DeriveeSecondeGauss(const X,Yr : vecteur;N : integer;
                              var Yder : vecteur;NbrePointDer : integer);
var puissX : vectorPuiss;
    A : matrice;
    Coeff : matriceLigne;
    ii,puissMax,ordre : integer;

procedure initXY;
var j : integer;
    loc : reel;
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
var ajoute,retire : reel;
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
         coeff[3] := 0;
     end;
end;

const degreDer = 2;
var i : integer;
begin { DeriveeSecondeGauss }
    for i := 0 to pred(N) do yder[i] := Nan;
    if N<NbrePointDer then exit;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    ii := NbrePointDer div 2;
    initXY;
    affecteCoeff;
    for i := 0 to ii do yder[i] := 2*coeff[3];
    for i := ii+1 to N-ii-1 do begin
        calculXY(i);
        affecteCoeff;
        yder[i] := 2*coeff[3];
    end;
    for i := N-ii to pred(N) do yder[i] := 2*coeff[3]
end; { DeriveeSecondeGauss }

function DeriveePonctuelle(const X,Y : vecteur;index,N : integer) : reel;
var puissX : vectorPuiss;
    A : matrice;
    Coeff : matriceLigne;
    puissMax,ordre : integer;

procedure initXY;
var j,jdebut,jfin : integer;
    loc : reel;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := 0;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    jdebut := index-(NbrePointDerivee div 2);
    if jdebut<0 then jdebut := 0;
    jfin := jDebut+NbrePointDerivee;
    if jfin>=N then begin
       jfin := pred(N);
       jdebut := jfin-NbrePointDerivee;
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

begin { DeriveePonctuelle }
    if (N<=NbrePointDerivee) or
       (isNan(X[index]) and
        isNan(Y[index])) then begin
       result := Nan;
       exit;
    end;
    ordre := degreDerivee+1;
    puissMax := 2*degreDerivee;
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

function DeriveeSecondePonctuelle(const X,Y : vecteur;index,N : integer) : reel;
var puissX : vectorPuiss;
    A : matrice;
    Coeff : matriceLigne;
    puissMax,ordre : integer;

procedure initXY;
var j,jdebut,jfin : integer;
    loc : reel;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := 0;
    for i := 1 to ordre do A[i,ordre+1] := 0;
    jdebut := index-(NbrePointDerivee div 2);
    if jdebut<0 then jdebut := 0;
    jfin := jDebut+NbrePointDerivee;
    if jfin>=N then begin
       jfin := pred(N);
       jdebut := jfin-NbrePointDerivee;
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

const degreDer = 2;
begin { DeriveeSecondePonctuelle }
    if (N<=NbrePointDerivee) or
       (isNan(X[index]) and
        isNan(Y[index])) then begin
       result := Nan;
       exit;
    end;
    ordre := degreDer+1;
    puissMax := 2*degreDer;
    initXY;
    try
    Resolution(A,ordre,Coeff);
    result := 2*coeff[3];
    except
         result := Nan;
    end;
end; { DeriveeSecondePonctuelle }

procedure IncertitudeDerivee(const X,Y,dX,dY:vecteur;N : integer;
   var Yder : vecteur;NbrePointDer : integer);
var i : integer;
    deltaX,deltaY,coeff : reel;
begin
    if N<3 then exit;
    for i := 1 to N-2 do
        try
        DeltaX :=abs(x[pred(i)]-x[succ(i)]);
        DeltaY :=abs(y[pred(i)]-y[succ(i)]);
        yder[i] :=
            ((dy[pred(i)]+dy[succ(i)])*deltaX+
             (dx[pred(i)]+dx[succ(i)])*deltaY)/
             sqr(deltaX);
        except
        yder[i] := Nan;
        end;
    yder[0] := yder[1];
    yder[pred(N)] := yder[N-2];
    coeff := 1/sqrt(NbrePointDer);
    for i := 0 to pred(N) do
        if not isNan(yder[i]) then yder[i] := yder[i]*coeff;
end; { IncertitudeDerivee }

Function CalculSurface(const X,Y:vecteur;N : integer) : reel;
var iFin : integer;

Procedure ChercheUnTour;
var i : integer;
    Ymin,Ymax,CoeffY,Xmin,Xmax,CoeffX : reel;
    ecartMin,ecartMax,ecartLoc : reel; { min,max pour hysteresis }

Function ecart : reel;
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
     { on est loin du départ }
     if i=pred(N) then exit;
     repeat inc(i)
     until (ecart<ecartMin) or entre0et1 or (i=pred(N));
     { on est près de la boucle }
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
     { on séloigne }
     i := iFin;
     if entre0et1 then dec(i); { plus d'un tour }
     iFin := i;
end;

var  i : integer;
     yprec,xprec,xx,yy,zz : reel;
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
  // on ferme la boucle
  zz := zz+(X[0]-xprec)*(Y[0]+yprec)/2;
  calculSurface := zz;
end;

Procedure chercheMinMax(const X,Y : vecteur;N : integer;
   EnvMax : boolean;var jMax : integer;var Xe,Ye : vecteur);
var i : integer;
    Yder : vecteur;
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
     Yder := nil;
end;

Procedure chercheEnveloppe(const X,Y : vecteur;
  N : integer;const Xe,Ye : vecteur;jMax : integer;var Env : vecteur);
type
    Vecteur4 = array[0..4] of reel;
    Vecteur2 = array[0..2] of reel;

var t,tPrec : vecteur4;
    f,fPrec : vecteur2;
    tlim : reel;

Procedure CalculCoeff(i : integer);
{i=index du point central}
var j : integer;
begin
    for j := 0 to 4 do tPrec[j] := t[j];
    for j := 0 to 2 do fPrec[j] := f[j];
    t[0] := Xe[i-1];
    t[1] := Xe[i];
    t[2] := Xe[i+1];
    t[3] := t[0];
    t[4] := t[1];
    f[0] := Ye[i-1];
    f[1] := Ye[i];
    f[2] := Ye[i+1];
    tlim := t[1];
end;

Function Valeur(i : integer;const t : vecteur4;const f : vecteur2) : reel;
var l : integer;
    D,tt : reel;
begin
    result := 0;
    tt := X[i];
    D := (t[0]-t[1])*(t[0]-t[2])*(t[1]-t[2]);
    for l := 0 to 2 do
        result := result+
          f[l]*(tt-t[l+1])*(tt-t[l+2])*(t[l+1]-t[l+2]);
    result := result/D;
end;

var i,j : integer;
begin
     CopyVecteur(Env,Y);
     if jMax<3 then exit;
     CalculCoeff(1);
     i := 0;
     while (X[i]<tlim) do begin
        Env[i] := valeur(i,t,f);
        inc(i);
     end;
     if jMax>3 then begin
        j := 2;
        CalculCoeff(2);
        while (i<N) do begin
           if X[i]>tlim then if j<(jMax-2)
                 then begin
                    inc(j);
                    calculCoeff(j);
                 end
                 else break;
           Env[i] := (valeur(i,t,f)+valeur(i,tprec,fprec))/2;
           inc(i);
        end;
     end;
     while i<N do begin
        Env[i] := valeur(i,t,f);
        inc(i);
     end;
end;

{
procedure CorrigeMagnum(const X,Y : vecteur;var Ycorr : vecteur;N : integer);
type Tcorrection = (maximum,minimum,egal);
const NbrePointMagnum = 5;
      DegreMagnum = 2;
      TailleTrait = 0.0018;
      Periode = 0.0036;
var puissA,puissB : vectorPuiss;
    A,B : matrice;
    CoeffA,coeffB : matriceLigne;
    puissMax,ordre : integer;

procedure Corrige(ii : integer);
var i,j : integer;
    loc : reel;
    xx,ecart : reel;
    Correction : Tcorrection;
begin
    for i := 1 to puissMax do begin
        puissA[i] := 0;
        puissB[i] := 0;
    end;
    puissA[0] := NbrePointMagnum;
    puissB[0] := NbrePointMagnum;
    for i := 1 to ordre do begin
       A[i,ordre+1] := 0;
       B[i,ordre+1] := 0;
    end;
    for j := ii downto ii-pred(NbrePointMagnum) do begin
        xx := x[j]-x[ii];
        loc := xx;
        for i := 1 to puissMax do begin
            puissA[i] := puissA[i]+loc;
            loc := loc*xx;
        end;
        loc := ycorr[j]-ycorr[ii];
        for i := 1 to ordre do begin
            A[i,ordre+1] := A[i,ordre+1]+loc;
            loc := loc*xx;
        end;
    end;
    for j := succ(ii) to (ii+NbrePointMagnum) do begin
        xx := x[j]-x[ii];
        loc := xx;
        for i := 1 to puissMax do begin
            puissB[i] := puissB[i]+loc;
            loc := loc*xx;
        end;
        loc := ycorr[j]-ycorr[ii];
        for i := 1 to ordre do begin
            B[i,ordre+1] := B[i,ordre+1]+loc;
            loc := loc*xx;
        end;
    end;
    for i := 1 to ordre do
         for j := 1 to ordre do begin
             A[i,j] := PuissA[i+j-2];
             B[i,j] := PuissB[i+j-2];
         end;
    try
    Resolution(A,ordre,CoeffA);
    Resolution(B,ordre,CoeffB);
    if y[ii+1]<y[ii]
       then correction := maximum
       else if y[ii+1]>y[ii]
            then correction := minimum
            else correction := egal;
// Debut de correction par Magnum 
    ecart := (coeffB[1]-0.25*sqr(coeffB[2])/coeffB[3])-
             (coeffA[1]-0.25*sqr(coeffA[2])/coeffA[3]);
// écart entre les sommets des paraboles
    case Correction of
        Maximum : if ecart<-periode
             then ecart := TailleTrait+Periode
             else ecart := TailleTrait;
        Minimum : if ecart>periode
              then ecart := -TailleTrait-Periode
              else ecart := -TailleTrait;
        egal : if ecart>0
            then ecart := -TailleTrait
            else ecart := TailleTrait
     end;
     for i := succ(ii) to pred(N) do
         Ycorr[i] := Ycorr[i]+ecart;
     except
     end;
end;

var i : integer;
begin // CorrigeMagnum
    ordre := degreMagnum+1;
    puissMax := 2*degreMagnum;
    copyVecteur(Ycorr,Y);
    i := NbrePointMagnum+1;
    repeat
        if (Y[i]-Y[i-1])*(Y[i+1]-Y[i])<=0 then begin
            Corrige(i);
            inc(i);
        end;
        inc(i);
    until i>=(N-NbrePointMagnum-1)
end; // CorrigeMagnum
}



