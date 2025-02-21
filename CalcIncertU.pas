unit CalcIncertU;

interface

uses math;

const maxParam =5;
      maxData = 1024;

type
  TCodeParam = 1..maxParam;
  TMatriceParam     = array[TcodeParam, TcodeParam] of double;
  TTableauParam     = array[TcodeParam] of double;
  TVecteur = array[1..maxData] of double;
  TMatriceVecteur  = array[TcodeParam] of TVecteur;
  TStatistiqueDeuxVar = class
      private
      Sy,Sy2,Sx,Sx2,Sxx,Syy,sigma : double;
      U95Pente : double;
      SSE,SSR : double;
      X,Y : Tvecteur;
      xmoyen,ymoyen : double;
      Fcorrelation : double;
      FNbre : integer;
      public
      covariance,pente,Y0 : double;
      sigmaPente,sigmaY0 : double;
      covariancePenteY0 : double;
      Procedure GenereBande(Xmin,Ymin,Xmax,Ymax : Tvecteur;confiance : boolean);
      property Nbre : integer read Fnbre;
   end;

implementation


var der2J : TMatriceParam;
{ der2j = dérivée seconde de J (approximative) =
  Df/dparam*Df/dparam
  on néglige (f-Fexp)d2f/d2param }
   derJ  : TTableauParam;
// derj = dérivée de J = (f-Fexp)*df/dParam
   Param,incertParam, incert95Param : TtableauParam;
// valeur des param, des incertitudes types et incert à 95%
   avecIncert : boolean;
   covarianceParam : TmatriceParam;
   valeurTheorique : Tvecteur;
   valeurDeriveeX : Tvecteur;
   sigmaY : double;

const
  maxStudent = 20;

  TableStudent95 : array[1..maxStudent] of double =
(12.71,4.30,3.182,2.776,2.571,2.447,2.365,2.306,2.262,2.228,
 2.201,2.179,2.160,2.145,2.131,2.120,2.110,2.101,2.093,2.086);

Function Student95(ddl : integer) : double;
begin
    if ddl<1
       then result := 0
       else if ddl<=20 then result := TableStudent95[ddl]
       else student95 := ((4.5082/ddl+2.3090)/ddl+2.4033)/ddl+1.960
end;

//Dans les calculs l'exemple est celui de y=ax+b ; et en commentaire le cas général

procedure CalculJ(NbreParam,NbrePoints : integer;valeurX,valeurY : Tvecteur;incertX,incertY : Tvecteur);
// calcul de J,derj,der2j

var Y : TMatriceVecteur;
    J,chi2 : double;

procedure calculFonction;
var i : integer;
    k1 : integer;
    z : double;
begin
    for i := 1 to NbrePoints do begin
        try
        valeurTheorique[i] := Param[1]*valeurX[i]+param[2];  // calcul de f(x,a,b)
        for k1 := 1 to NbreParam do
            Y[k1,i] := 0; // calcule dérivée de f(x) par rapport au paramètre k1
        if avecIncert
           then ValeurDeriveeX[i] := Param[1] // dérivée de y=f(x,a,b) par rapport à x
           else ValeurDeriveeX[i] := 0;
        except
        end;
    end;// for i
end;// calculFonction

procedure calculLoc;
var k1,k2 : integer;
    i : integer;
    ValDerf : TTableauParam;// valeur de la dérivée première
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
    CoeffChi2 : double;
    dy,dt : double;
begin
    try
        for i := 1 to NbrePoints do begin
            Ecart := valeurTheorique[i]-valeurY[i];
            J := J + sqr(ecart);
            if avecIncert then begin
                     try
                     dy := incertY[i];
                     dt := incertX[i]*valeurDeriveeX[i];
                     coeffChi2 := 1/(sqr(dy)+sqr(dt));
                     chi2 := chi2 + coeffChi2*sqr(ecart);
                     except
                     end;
            end // avecIncert
            else coeffChi2 := 1;
            for k1 := 1 to NbreParam do begin
                valDerf[k1] := Y[k1,i];
                derj[k1] := derj[k1]+coeffChi2*Ecart*valDerf[k1];
                for k2 := 1 to k1 do
                    der2j[k1,k2] := der2j[k1,k2]+coeffChi2*valDerf[k2]*valDerf[k1];
            end
        end;// for i
    except
    end;
end;// calculLoc

var k1,k2 : integer;
begin // calculJ
// Initialisation
   J := 0;
   chi2 := 0;
   for k1 := 1 to NbreParam do begin
       derJ[k1] := 0;
       for k2 := 1 to NbreParam do
           der2j[k1,k2] := 0;
   end;// for k1
   try
   calculFonction;
   CalculLoc;
   sigmaY := sqrt(J/NbrePoints);
   except
   end;
end; // calculJ

procedure calculPrecision(NbreParam : integer;NbrePoints : integer);
var U,InvDer2j : TMatriceParam;

procedure construireU;
var
   v : double;
   i,l,k : integer;
begin
  for i := 1 to NbreParam do
     for k := 1 to NbreParam do
         U[i,k] := 0;
  for i := 1 to NbreParam do begin
     v := der2J[i,i];
     try
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for l := succ(i) to NbreParam do begin
         v := der2J[l,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,l];
         U[i,l] := v/U[i,i];
     end;
     except
     end
  end;
  for i := 1 to NbreParam do
      for k := 1 to NbreParam do
          invDer2J[i,k] := 0;
end;// construireU

procedure resoudreU(l : integer);
var i,k : integer;
    Y   : TTableauParam;
    v   : double;
begin
    for i := 1 to NbreParam do
    if U[i,i]= 0
        then Y[i] := 0
        else begin
           try
           if i=l then v := 1 else v := 0;
           for k := 1 to pred(i) do v := v-U[k,i]*Y[k];
           Y[i] := v/U[i,i];
           except
              Y[i] := 0
           end;
        end;
// passage à invder2J
     for i := NbreParam downto 1 do begin
         v := Y[i];
         for k := succ(i) to NbreParam do
             v := v-U[i,k]*invDer2J[l,k];
         try
         invDer2J[l,i] := v/U[i,i];
         except
            invDer2J[l,i] := 0
         end;
    end;{i}
end;// resoudreU

var i,l : integer;
begin // calculPrecision
  construireU;
  for i := 1 to NbreParam do resoudreU(i);
  for i := 1 to NbreParam do begin
     try
     incertParam[i] := sqrt(invDer2j[i,i]);
     if not avecIncert
        then incertParam[i] := incertParam[i]*sigmaY;
     incert95Param[i] := incertParam[i]*student95(NbrePoints);
     except
     end;
  end; // for i
  if avecIncert then
  for i := 1 to NbreParam do
      for l := 1 to NbreParam do
          CovarianceParam[i,l] := invDer2J[i,l]
end; // calculPrecision

Procedure TstatistiqueDeuxVar.GenereBande(Xmin,Ymin,Xmax,Ymax : Tvecteur;confiance : boolean);
// à l'entrée YMax contient Y[i]  Xmax contient X[i]
// à la sortie Ymin contient les ordonnées de la limite inf et Ymax la limite sup
// et Xmin Xmax idem pour les abscisses
var i : integer;
    ecart,st,zz : double;
begin
   st := student95(FNbre-2)*sigma; // 95%
   for i := 0 to pred(FNbre) do begin
       xMin[i] := xMax[i];
       zz := 1/FNbre+sqr(xMax[i]-xmoyen)/Sxx;
       if confiance
          then  ecart := st*sqrt(zz) // Confiance
          else  ecart := st*sqrt(1+zz); // sinon Prédiction
       yMin[i] := yMax[i]-ecart;
       yMax[i] := yMax[i]+ecart;
   end;// for i
end; // GenereBande

end.
