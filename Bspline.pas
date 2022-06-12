procedure CalculBSpline(const X,Y : Tvecteur;ordre : integer;
                        var N : integer;var Xspline,Yspline : Tvecteur);
// B-spline : approximation ; spline : interpolation
// B pour polynôme d'approximation de Bernstein
// X,Y : données
// Xspline,Yspline : courbe B-spline
// N : nombre de points de X à l'entrée, de xspline à la sortie
// ordre : degré du polynome

Const Nmax = 1024; // 1 pixel sur 2 pour écran 2048
var
   xi : Tvecteur;
   Nij : array[1..ordreMaxSpline] of Tvecteur;
   nspl,ix : integer;  // variable de boucles
   pas : double; //selon x pour xspline
   t : double; // variable intermédiaire pour stocker pas*i=xspline[i]
   xx,yy : double; // variable intermédiaire pour sommation
   e1,e2 : double;
   i,k,j : integer; // variable de boucles

  procedure calculX;
  var i : integer;
  begin
     for i := 1 to ordre do xi[i] := 0;
     for i := ordre+1 to ordre+n do
         if i>n
            then xi[i] := N+1-ordre
            else xi[i] := i-ordre
  end;

  var coeff : double; // variable intermédiaire
  begin // CalculBSpline
    copyVecteur(Xspline,X);
    copyVecteur(Yspline,Y);
    if ordre>ordreMaxSpline then ordre := ordreMaxSpline;
    if ordre<ordreMinSpline then ordre := ordreMinSpline;
    if (N<=ordre) or (N>=(Nmax div 2)) then exit;
    setLength(xi,N+OrdreMaxSpline+3);
    for j := 1 to ordre do setLength(Nij[j],N+OrdreMaxSpline+3);
    calculX;
    pas := (N+1-ordre)/Nmax;
    setLength(Xspline,Nmax+1);
    setLength(Yspline,Nmax+1);
    Xspline[0] := X[0];
    Yspline[0] := Y[0];
// balayage de Xspline
    ix := ordre;
    for nspl := 1 to pred(Nmax) do begin
        t := nspl*pas;
// recherche de xi
        while t>xi[succ(ix)] do inc(ix);
// xi[ix]<=t<=xi[ix+1]
// initialisation Nij
		    for j := 1 to ordre do
			      for i := 1 to n+ordre do
				        Nij[j,i] := 0;
// affectation de Ni1
  		  Nij[1,ix] := 1;
// Calcul Ni2
        try
        Coeff := 1/(xi[succ(ix)]-xi[ix]);
		    Nij[2,ix]:=(t-xi[ix])*coeff;
		    Nij[2,pred(ix)]:=(xi[succ(ix)]-t)*coeff;
        except
        end;
// Calcul Nij j>2
		    for j := 3 to ordre do begin
		       for k := ix-j+1 to ix do begin
               e1 := xi[k+j-1]-xi[k];
               if e1<>0 then e1:=(t-xi[k])*Nij[j-1,k]/e1;
               e2 := xi[k+j]-xi[k+1];
               if e2<>0 then e2:=(xi[k+j]-t)*Nij[j-1,k+1]/e2;
               Nij[j,k] := e1+e2;
		       end;// for k
		    end;// for j
// calcul de Xspline, Yspline
		    xx := 0;
		    yy := 0;
		    for k := 0 to pred(N) do begin
		       xx := X[k]*Nij[ordre,k+1]+xx;
		       yy := Y[k]*Nij[ordre,k+1]+yy;
		    end;// for k
		    Xspline[nspl] := xx;
		    Yspline[nspl] := yy;
	  end; // for nspl
    Xspline[Nmax] := X[pred(N)];
    Yspline[Nmax] := Y[pred(N)];
    N := succ(Nmax);
    xi := nil;
    for j := 1 to ordre do Nij[j] := nil;
end; // CalculBSpline

procedure InterpoleSinc(const X,Y : Tvecteur;ordre : integer;
                        var N : integer;var Xspline,Yspline : Tvecteur);
Const Nmax = 4096; // tous les pixels d'un écran 4096
      a = 6; // six points à droite et à gauche soit 13 points
      ordreMaxSinc = 15;
      NijMax = (ordreMaxSinc+1)*(2*a+1); // soit 208
var
   Nij : array[0..NijMax] of double;
   i,j,k,Nsinc : integer;
   imin,imax : integer;
   yy,deltaX,w : double;
begin
    copyVecteur(Xspline,X);
    copyVecteur(Yspline,Y);
    if (N<ordreMaxSinc) then exit;
    if ordre>ordreMaxSinc then ordre := ordreMaxSinc;
    if ordre<2 then ordre := 2;
    while ((N*ordre)>Nmax) and (ordre>2) do dec(ordre);
    Nsinc := N*ordre;
    if Nsinc>Nmax then exit;
    setLength(Xspline,Nsinc+1);
    setLength(Yspline,Nsinc+1);
    Nij[0] := 1; // pour éviter div par 0
		for j := 1 to NijMax do begin // calcul du noyau
        yy := pi*j/ordre;
        Nij[j] := sin(yy)*sin(yy/a)*a/sqr(yy);
    end;
    deltaX := (X[N-1]-X[0])/(N-1)/ordre;
// calcul de Xspline, Yspline
    for j := 0 to Nsinc-1 do begin
        k := round(j/ordre);
        Xspline[j] := X[0]+j*deltaX;
        imin := k-a;
        if imin<0 then imin := 0;
        imax := imin+2*a; // 2*a+1 points
        if imax>=N then begin
           imax := N-1;
           imin := imax-2*a;
           if imin<0 then imin := 0;
        end;
        yy := 0;
        w := 0;
        for i := imin to imax do begin
            yy := yy + Y[i]*Nij[abs(i*ordre-j)];
            w := w + Nij[abs(i*ordre-j)];
        end;
	   	  Yspline[j] := yy/w;
    end;
    N := Nsinc;
end; // InterpoleSinc

procedure RemoveGlitche(Y,Ylisse : Tvecteur;ordre,N : integer);
var
   ordreG,j : integer;
   ecart,coeff : double;
   Yg,dY : Tvecteur;
begin
   setLength(dy,N+1);
   ordreG := ordre div 3;
   if ordreG<3 then ordreG := 3;
   coeff := 1/ordreG;
   copyVecteur(Yg,Y);
   ecart := 0;
   for j := 1 to N-1 do dY[j] := y[j]-y[j-1];
   for j := 1 to 2*ordreG do ecart := ecart+abs(dY[j]);
   for j := ordreG to N-ordreG-1 do begin
       ecart := ecart+abs(dy[j+ordreG])-abs(dy[j-ordreG])-abs(dy[j])-abs(dy[j+1]);
       if (dy[j]*dy[j+1]<0) and
          (abs(dy[j])>ecart*coeff) and
          (abs(dy[j+1])>ecart*coeff) then begin
              Yg[j] := (y[j+1]+yg[j-1])/2;
              dy[j] := yg[j]-yg[j-1];
              dy[j+1] := y[j+1]-yg[j];
       end;
       ecart := ecart+abs(dy[j])+abs(dy[j+1]);
   end;
   for j := N-ordreG to N-2 do begin
       ecart := ecart-dy[j]-dy[j+1];
       if (dy[j]*dy[j+1]<0) and
          ((abs(dy[j])>ecart*coeff) or
           (abs(dy[j+1])>ecart*coeff)) then begin
              Yg[j] := (y[j+1]+yg[j-1])/2;
              dy[j] := yg[j]-yg[j-1];
              dy[j+1] := y[j+1]-yg[j];
       end;
       ecart := ecart+dy[j]+dy[j+1];
   end;
   if (abs(dy[N-1])>abs(dy[N-2])*1.5) or
      (abs(dy[N-1])<abs(dy[N-2])*0.5) then
        Yg[N-1] := Yg[N-2]+dY[N-2];
   ecart := 0;
   for j := 1 to 2*ordreG do ecart := ecart+dY[j];
   for j := 1 to ordreG-1 do begin
       ecart := ecart-dy[j]-dy[j+1];
       if (dy[j]*dy[j+1]<0) and
          ((abs(dy[j])>ecart*coeff) or
           (abs(dy[j+1])>ecart*coeff)) then begin
              Yg[j] := (y[j+1]+yg[j-1])/2;
              dy[j] := yg[j]-yg[j-1];
              dy[j+1] := y[j+1]-yg[j];
       end;
       ecart := ecart+dy[j]+dy[j+1];
   end;
   if (abs(dy[1])>abs(dy[2])*1.5) or
      (abs(dy[1])<abs(dy[2])*0.5) then
        Yg[0] := Yg[1]-dY[2];
   affecteVecteur(Ylisse,yg);
   yg := nil;
   dy := nil;
end; // RemoveGlitche

procedure MoyGlissante(Y,Ylisse : Tvecteur;ordre,N : integer);
var j : integer;
    a : double;
begin  // MoyGlissante
   if ordre>ordreMaxMoy then ordre := ordreMaxMoy;
   if ordre<1 then ordre := 1;
   RemoveGlitche(Y,Ylisse,ordre,N);
   a := exp(-1/ordre);
   Ylisse[0] := Y[0];
   for j := 1 to pred(N) do
       Ylisse[j] := Y[j]*(1-a)+a*Ylisse[j-1];
 // (1-a) de manière à avoir une réponse de 1 à une entrée de 1
end; // MoyGlissante

procedure MoyCentree(Y,Ylisse : Tvecteur;ordre,N : integer);
var j,k,indexCourant : integer;
    coeff : double;
begin  // MoyCentree
   if ordre>ordreMaxMoy then ordre := ordreMaxMoy;
   if ordre<1 then ordre := 1;
   RemoveGlitche(Y,Ylisse,ordre,N);
   for j := 0 to ordre do begin
       Ylisse[j] := 0;
       for k := 0 to j+ordre do
          Ylisse[j] := Ylisse[j]+Y[k];
       Ylisse[j] := Ylisse[j]/(j+ordre+1);
   end;
   coeff := 1/(2*ordre+1);
   for j := succ(ordre) to pred(N-ordre) do
       Ylisse[j] := Ylisse[j-1]+(Y[j+ordre]-Y[j-ordre-1])*coeff;
   for j := 0 to pred(ordre) do begin
       indexCourant := j+N-ordre;
       Ylisse[indexCourant] := 0;
       for k := indexCourant-ordre to N-1 do
           Ylisse[indexCourant] := Ylisse[indexCourant]+Y[k];
       Ylisse[indexCourant] := Ylisse[indexCourant]/(2*ordre-j);
   end;
end; // MoyCentree

Procedure CalculIntLineaire(const X,Y : Tvecteur;Debut,Fin,NbreLisse : integer;
          var XLisse,YLisse : Tvecteur);
var
      pas,t : double;
      i,ix : integer;
begin
      pas := (X[fin]-X[debut])/pred(NbreLisse);
      Xlisse[0] := X[debut];
      Ylisse[0] := Y[debut];
      Ylisse[pred(NbreLisse)] := Y[fin];
      Xlisse[pred(NbreLisse)] := X[fin];
      ix := debut;
      for i := 1 to NbreLisse-2 do begin
          t := X[debut]+i*pas;
          Xlisse[i] := t;
// recherche de ix
	  while t>x[succ(ix)] do inc(ix);
// x[ix]<t<=x[ix+1]
          try
	      Ylisse[i] := Y[ix]+(t-X[ix])*(Y[succ(ix)]-Y[ix])/(X[succ(ix)]-X[ix]);
          except
          Ylisse[i] := Nan;
          end
      end; // for i
// interpolation à gauche
      try
      Ylisse[NbreLisse] := Y[fin]+pas*(Y[pred(fin)]-Y[fin])/(X[pred(fin)]-X[fin]);
      except
      Ylisse[NbreLisse] := Y[fin];
      end;
      Xlisse[NbreLisse] := X[fin]+pas;
end; // CalculIntLineaire

function DiffThreePoint(T : Double;
     X0,X1,X2 : Double;
     F0,F1,F2 : Double):Double;
var
    A : Double;
    B : Double;
begin
    T := T-X0;
    X1 := X1-X0;
    X2 := X2-X0;
    A := (F2-F0-X2/X1*(F1-F0))/(Sqr(X2)-X1*X2);
    B := (F1-F0-A*Sqr(X1))/X1;
    Result := 2*A*T+B;
end;

procedure BuildHermiteSpline(X,Y,D : Tvecteur;N : Integer;var C : TCoeffSpline);
var
    I : Integer;
    Delta : Double;
    Delta2 : Double;
    Delta3 : Double;
begin
    Assert(N>=2, 'BuildHermiteSpline: N<2!');
    // C[0]...C[3] - coefficients table
    for i := 0 to 3 do SetLength(C[i], N);
    for i := 0 to N-2 do begin
        Delta := X[I+1]-X[I];
        Delta2 := Sqr(Delta);
        Delta3 := Delta*Delta2;
        C[0,I] := Y[I];
        C[1,I] := D[I];
        C[2,I] := (3*(Y[I+1]-Y[I])-2*D[I]*Delta-D[I+1]*Delta)/Delta2;
        C[3,I] := (2*(Y[I]-Y[I+1])+D[I]*Delta+D[I+1]*Delta)/Delta3;
    end;
end;

procedure BuildAkimaSpline(X,Y : Tvecteur;N : Integer;var C : TCoeffSpline);
var
    I : Integer;
    D : Tvecteur;
    W : Tvecteur;
    Diff : Tvecteur;
begin
    Assert(N>=5, 'BuildAkimaSpline: N<5!');

    // Prepare W (weights), Diff (divided differences)
    SetLength(W, N);
    SetLength(Diff, N);
    for I := 0 to N-2 do
        Diff[I] := (Y[I+1]-Y[I])/(X[I+1]-X[I]);
    for I := 1 to N-2 do
        W[I] := Abs(Diff[I]-Diff[I-1]);

    // Prepare Hermite interpolation scheme
    SetLength(D, N);
    for I := 2 to N-3 do
        if Abs(W[I-1])+Abs(W[I+1])<>0
           then D[I] := (W[I+1]*Diff[I-1]+W[I-1]*Diff[I])/(W[I+1]+W[I-1])
           else D[I] := ((X[I+1]-X[I])*Diff[I-1]+(X[I]-X[I-1])*Diff[I])/(X[I+1]-X[I-1]);
    D[0] := DiffThreePoint(X[0], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
    D[1] := DiffThreePoint(X[1], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
    D[N-2] := DiffThreePoint(X[N-2], X[N-3], Y[N-3], X[N-2], Y[N-2], X[N-1], Y[N-1]);
    D[N-1] := DiffThreePoint(X[N-1], X[N-3], Y[N-3], X[N-2], Y[N-2], X[N-1], Y[N-1]);

    // Build Akima spline using Hermite interpolation scheme
    BuildHermiteSpline(X, Y, D, N, C);
end;

