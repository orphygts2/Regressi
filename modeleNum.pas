unit modeleNum;

interface

uses Windows, SysUtils, Graphics, Classes,
  Forms, Controls, regutil,
  system.UITypes, system.Types,
  Math, constreg, maths, uniteker, compile,
  statCalc;

type
  tPositionEquivalence = (pAvant,pApres,pEAvant,pEApres);
  tModeleEquivalence = class
     valeurParamE : tableauParam;
     debut,fin : integer;
     valeurYth : Tvecteur;
     signe : double;
     NParam : integer;
     indexX,indexY : integer;
     Xl,Yl,Yder : Tvecteur;
     positionEquivalence : TPositionEquivalence;
     Function EffectueModeleNum : boolean;
     constructor Create;
     destructor Destroy;override;
  end;

  (*
  tModeleInflexionVerticale = class
     valeurParam : tableauParam;
     debut,fin : integer;
     valeurYth : vecteur;
     NParam : integer;
     indexX,indexY : integer;
     Xlisse,Ylisse,Yder : vecteur;
     vInflexion,phInflexion : double;
     Function EffectueModeleNum : boolean;
     constructor Create;
     destructor Destroy;override;
  end;
  *)

var modeleAvant,modeleApres : TModeleEquivalence;
   // modeleInflexionverticale : TModeleInflexionVerticale;

function ModeleInflexion(const X,Y : Tvecteur;const index : integer;
                       var Xl,Yl : Tvecteur;var ve,phe : double;pente : double) : boolean;

implementation

const NmesMax = 1024;

Function TModeleEquivalence.EffectueModeleNum : boolean;
var diverge,stable : boolean;
    precisionModele : double;
    erreurCalcul,erreurParam : boolean;
    sommeCarreY : double;

// boucle de recherche par méthode gradient-Newton
var
   J,Jprecedent : double;
{ (FonctionTheorique(x,param)-FonctionExperimentale(x))^2
  coeffJ pour pondérer de manière égale deux modèles qqsoit les ordres de grandeur }
  derJ  : TableauParam;
// derj = dérivée de J = (fonctionTheorique-Fexp)*dfonctionTheorique/dParam
  der2J : TMatriceParam;
{ der2j = dérivée seconde de J (approximative) =
  DfonctionTheorique/dparam*DfonctionTheorique/dparam
  on néglige (fonctionTheorique-Fexp)d2Fth/dparam*dparam }
  IncParam : TableauParam;

procedure calculPrecision;
var U,InvDer2j : TMatriceParam;

procedure construireU;
var
   v : double;
   i,l,k : integer;
begin
 for i := 1 to NParam do
     for k := 1 to NParam do
         U[i,k] := 0;
 for i := 1 to NParam do begin
     v := der2J[i,i];
     try
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for l := succ(i) to NParam do begin
         v := der2J[l,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,l];
         U[i,l] := v/U[i,i];
     end;
     except
        for l := 1 to NParam do begin
             U[i,l] := 0;
             U[l,i] := 0;
             der2J[l,i] := 0;
             der2J[i,l] := 0;
        end
      end
  end;
  for i := 1 to NParam do
      for k := 1 to NParam do
          invDer2J[i,k] := 0;
end;// construireU

procedure resoudreU(l : TcodeParam);
var i,k : integer;
    Y   : TableauParam;
    v   : double;
begin
    for i := 1 to NParam do
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
     for i := NParam downto 1 do begin
         v := Y[i];
         for k := succ(i) to NParam do
             v := v-U[i,k]*invDer2J[l,k];
         try
         invDer2J[l,i] := v/U[i,i];
         except
            invDer2J[l,i] := 0
         end;
     end;
end;// resoudreU

var i,l : integer;
begin // calculPrecision
  construireU;
  erreurCalcul := false;
  for i := 1 to NParam do resoudreU(i);
  for i := 1 to NParam do begin
     try
     incParam[i] := 0;
     for l := 1 to NParam do
         incParam[i] := incParam[i] - invDer2J[l,i]*derJ[l];
     erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
     except
         incParam[i] := 0;
     end;
  end; // for i
end; // calculPrecision

procedure InitCalculJ;
var  i : integer;
begin
      SommeCarreY := 0;
      for i := debut to fin do
          SommeCarreY := SommeCarreY + sqr(pages[pageCourante].valeurVar[indexY,i]);
      jPrecedent := 2*sommeCarreY;
end; // initCalculJ

procedure CalculJ;
// calcul de J; avecDerivee => calcul derj,der2j

var Y : array[TcodeParam,0..NmesMax] of double;

procedure calculFonction;
var i : integer;
    x : double;
begin
    try
    for i := debut to fin do begin
        x := pages[pageCourante].valeurVar[indexX,i];;
        case positionEquivalence of
             pAvant : valeurYTh[i] := valeurParamE[1]-signe*log10(valeurParamE[2]-x);
             pApres : valeurYTh[i] := valeurParamE[1]+signe*log10(x-valeurParamE[2]);
             pEAvant : valeurYTh[i] := valeurParamE[1]-signe*valeurParamE[3]*log10(valeurParamE[2]-x);
             pEApres : valeurYTh[i] := valeurParamE[1]+signe*valeurParamE[3]*log10(x-valeurParamE[2]);
        end;
        // constante
        case positionEquivalence of
             pAvant : Y[1,i] := 1;
             pApres : Y[1,i] := 1;
             pEAvant : Y[1,i] := 1;
             pEApres : Y[1,i] := 1;
        end;
        // Veq
        case positionEquivalence of
             pAvant : Y[2,i] := -signe/ln(10)/(valeurParamE[2]-x);
             pApres : Y[2,i] := -signe/ln(10)/(x-valeurParamE[2]);
             pEAvant : Y[2,i] := -signe*valeurParamE[3]/ln(10)/(valeurParamE[2]-x);
             pEApres : Y[2,i] := -signe*valeurParamE[3]/ln(10)/(x-valeurParamE[2]);
        end;
        case positionEquivalence of
             pAvant : ;
             pApres : ;
             pEAvant : Y[3,i] := -signe*log10(valeurParamE[2]-x);
             pEApres : Y[3,i] := +signe*log10(x-valeurParamE[2]);
        end;
    end;// for i
    except
       on E : exception do begin
          erreurCalcul := true;
       end;
    end;
end;// calculFonction

procedure calculLoc;
var k1,k2 : integer;
    i : integer;
    ValDerf : TableauParam;// valeur de la dérivée première
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
begin
    try
        for i := debut to fin do begin
            Ecart := valeurYTh[i]-pages[pageCourante].valeurVar[indexY,i];
            J := J + sqr(ecart);
        for k1 := 1 to NParam do begin
            valDerf[k1] := Y[k1,i];
            derj[k1] := derj[k1]+Ecart*valDerf[k1];
            for k2 := 1 to k1 do
                der2j[k1,k2] := der2j[k1,k2]+valDerf[k2]*valDerf[k1]; // *2 ??
         end;
     end;// for i
    except
          erreurParam := true
    end;
 end;// calculLoc

Const
      PrecisionAbsolueJ = 0.001;
      PrecisionRelativeJ = 0.001;
      PrecisionZero = 0.0000001; // prise en compte erreur arrondi dans comparaison à zéro
var k1,k2 : integer;
    DeltaJ : double;
begin // calculJ
   erreurCalcul := false;
   erreurParam := false;
   J := 0;
   for k1 := 1 to NParam do begin
       derJ[k1] := 0;
       for k2 := 1 to NParam do
           der2j[k1,k2] := 0;
   end;// for k1
   calculFonction;
   if not erreurCalcul then CalculLoc;
   PrecisionModele := sqrt(J/SommeCarreY);
   DeltaJ := J-Jprecedent;
   Diverge := DeltaJ>J*PrecisionZero;
   Stable := (abs(DeltaJ)<(Jprecedent*PrecisionRelativeJ)) or
                        (PrecisionModele<PrecisionAbsolueJ);
end; // calculJ

Function EffectueGaussNewton : boolean;
const
    Maxi_i1 = 32; // time out
    Maxi_i2 = 6; // µ mini =(1/2)^7=1%
var k : integer;
    i1,i2 : integer;
    mu : double;
// boucle de recherche par méthode gradient-Newton
begin
    i1 := 0;
    result := false;
    repeat
        inc(i1);
        Jprecedent := J;
        calculPrecision;
        if erreurCalcul then exit;
        for k := 1 to NParam do
            valeurParamE[k] := valeurParamE[k]+incParam[k];
        CalculJ;
        if erreurParam then exit;
        mu := 1;i2 := 0;
        while (Diverge or ErreurCalcul) and (i2<Maxi_i2) do begin
            inc(i2);
            mu := mu/2;
            for k := 1 to NParam do
                valeurParamE[k] := valeurParamE[k]-incParam[k]*mu;
            CalculJ;
        end; // while diverge
        if diverge and (stable or (i1<=1)) then begin
           calculJ; // calcul dans l'état initial
           diverge := false;
           stable := true;
        end;
        if erreurCalcul or erreurParam or diverge then exit;
   until (i1>Maxi_i1) or stable;
   result := true;
end; // EffectueGaussNewton

var Ndiv2 : integer;
    deltax,x0,x1 : double;
    i,ii : integer;
begin // effectueModele
    result := false;
    InitCalculJ;
    CalculJ;
    if erreurCalcul or ErreurParam then exit;
    if not EffectueGaussNewton then exit;
    result := stable;
    Ndiv2 := NbrePointDeriveeLisse div 2;
    x1 := pages[pageCourante].valeurVar[indexX,(debut+fin) div 2];
    x0 := pages[pageCourante].valeurVar[indexX,debut];
    deltax := (x1-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       xl[i] := x0+i*deltax;
       case positionEquivalence of
             pAvant : begin
                yl[i] := valeurParamE[1]-signe*log10(valeurParamE[2]-xl[i]);
                yder[i] := signe/ln(10)/(valeurParamE[2]-xl[i]);
             end;
             pApres : begin
                yl[i] := valeurParamE[1]+signe*log10(xl[i]-valeurParamE[2]);
                yder[i] := -signe*valeurParamE[3]/ln(10)/(valeurParamE[2]-xl[i]);
             end;
             pEAvant : begin
                yl[i] := valeurParamE[1]-signe*valeurParamE[3]*log10(valeurParamE[2]-xl[i]);
                yder[i] := signe/ln(10)/(valeurParamE[2]-xl[i]);
             end;
             pEApres : begin
                yl[i] := valeurParamE[1]+signe*valeurParamE[3]*log10(xl[i]-valeurParamE[2]);
                yder[i] := -signe*valeurParamE[3]/ln(10)/(valeurParamE[2]-xl[i]);
             end;
       end;
    end;
    x0 := pages[pageCourante].valeurVar[indexX,(debut+fin) div 2];
    x1 := pages[pageCourante].valeurVar[indexX,fin];
    deltax := (x1-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       ii := i+Ndiv2;
       xl[ii] := x0+i*deltax;
       case positionEquivalence of
             pAvant : begin
                 yl[ii] := valeurParamE[1]-signe*log10(valeurParamE[2]-xl[ii]);
                 yder[ii] := signe/ln(10)/(valeurParamE[2]-xl[ii]);
             end;
             pApres : begin
                 yl[ii] := valeurParamE[1]+signe*log10(xl[ii]-valeurParamE[2]);
                 yder[ii] := -signe/ln(10)/(valeurParamE[2]-xl[ii]);
             end;
             pEAvant : begin
                 yl[ii] := valeurParamE[1]-signe*valeurParamE[3]*log10(valeurParamE[2]-xl[ii]);
                 yder[ii] := signe*valeurParamE[3]/ln(10)/(valeurParamE[2]-xl[ii]);
             end;
             pEApres : begin
                 yl[ii] := valeurParamE[1]+signe*valeurParamE[3]*log10(xl[ii]-valeurParamE[2]);
                 yder[ii] := -signe*valeurParamE[3]/ln(10)/(valeurParamE[2]-xl[ii]);
             end;
       end;
    end;
end; // EffectueModeleNum

(*
Function TModeleInflexionVerticale.EffectueModeleNum : boolean;
var diverge,stable : boolean;
    precisionModele : double;
    erreurCalcul,erreurParam : boolean;
    sommeCarreY : double;

// boucle de recherche par méthode gradient-Newton
var
   J,Jprecedent : double;
{ (FonctionTheorique(x,param)-FonctionExperimentale(x))^2
  coeffJ pour pondérer de manière égale deux modèles qqsoit les ordres de grandeur }
  derJ  : TableauParam;
// derj = dérivée de J = (fonctionTheorique-Fexp)*dfonctionTheorique/dParam
  der2J : MatriceParam;
{ der2j = dérivée seconde de J (approximative) =
  DfonctionTheorique/dparam*DfonctionTheorique/dparam
  on néglige (fonctionTheorique-Fexp)d2Fth/dparam*dparam }
  IncParam : TableauParam;

procedure calculPrecision;
var U,InvDer2j : MatriceParam;

procedure construireU;
var
   v : double;
   i,l,k : integer;
begin
 for i := 1 to NParam do
     for k := 1 to NParam do
         U[i,k] := 0;
 for i := 1 to NParam do begin
     v := der2J[i,i];
     try
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for l := succ(i) to NParam do begin
         v := der2J[l,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,l];
         U[i,l] := v/U[i,i];
     end;
     except
        for l := 1 to NParam do begin
             U[i,l] := 0;
             U[l,i] := 0;
             der2J[l,i] := 0;
             der2J[i,l] := 0;
        end
      end
  end;
  for i := 1 to NParam do
      for k := 1 to NParam do
          invDer2J[i,k] := 0;
end;// construireU

procedure resoudreU(l : codeParam);
var i,k : integer;
    Y   : TableauParam;
    v   : double;
begin
    for i := 1 to NParam do
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
     for i := NParam downto 1 do begin
         v := Y[i];
         for k := succ(i) to NParam do
             v := v-U[i,k]*invDer2J[l,k];
         try
         invDer2J[l,i] := v/U[i,i];
         except
            invDer2J[l,i] := 0
         end;
     end;
end;// resoudreU

var i,l : integer;
begin // calculPrecision
  construireU;
  erreurCalcul := false;
  for i := 1 to NParam do resoudreU(i);
  for i := 1 to NParam do begin
     try
     incParam[i] := 0;
     for l := 1 to NParam do
         incParam[i] := incParam[i] - invDer2J[l,i]*derJ[l];
     erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
     except
         incParam[i] := 0;
     end;
  end; // for i
end; // calculPrecision

procedure InitCalculJ;
var  i : integer;
begin
      SommeCarreY := 0;
      for i := debut to fin do
          SommeCarreY := SommeCarreY + sqr(pages[pageCourante].valeurVar[indexY,i]);
      jPrecedent := 2*sommeCarreY;
end; // initCalculJ

function evalValeurYth(x : double) : double;
begin
   result := valeurParamE[1]+sqr(valeurParamE[2])*x/(3*valeurParamE[3])+valeurParamE[2]*sqr(x)+valeurParamE[3]*power(x,3);
end;

function evalValeurderYth(x : double) : double;
begin
   result := sqr(valeurParamE[2])/(3*valeurParamE[3])+2*valeurParamE[2]*x+3*valeurParamE[3]*sqr(x);
end;

procedure CalculJ;
// calcul de J; avecDerivee => calcul derj,der2j

var Y : array[codeParam,0..NmesMax] of double;

procedure calculFonction;
var i : integer;
    x : double;
begin
    try
    for i := debut to fin do begin
        x := pages[pageCourante].valeurVar[indexX,i];;
        valeurYTh[i] := evalValeurYth(x);
        Y[1,i] := 1;
        Y[2,i] := 2*valeurParamE[2]*x/(3*valeurParamE[3])+sqr(x);
        Y[3,i] := -sqr(valeurParamE[2])*x/(3*sqr(valeurParamE[3]))+power(x,3);
    end;// for i
    except
       on E : exception do begin
          erreurCalcul := true;
       end;
    end;
end;// calculFonction

procedure calculLoc;
var k1,k2 : integer;
    i : integer;
    ValDerf : TableauParam;// valeur de la dérivée première
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
begin
    try
        for i := debut to fin do begin
            Ecart := valeurYTh[i]-pages[pageCourante].valeurVar[indexY,i];
            J := J + sqr(ecart);
        for k1 := 1 to NParam do begin
            valDerf[k1] := Y[k1,i];
            derj[k1] := derj[k1]+Ecart*valDerf[k1];
            for k2 := 1 to k1 do
                der2j[k1,k2] := der2j[k1,k2]+valDerf[k2]*valDerf[k1];
         end;
     end;// for i
    except
          erreurParam := true
    end;
 end;// calculLoc

Const
      PrecisionAbsolueJ = 0.001;
      PrecisionRelativeJ = 0.001;
      PrecisionZero = 0.0000001; // prise en compte erreur arrondi dans comparaison à zéro
var k1,k2 : integer;
    DeltaJ : double;
begin // calculJ
   erreurCalcul := false;
   erreurParam := false;
   J := 0;
   for k1 := 1 to NParam do begin
       derJ[k1] := 0;
       for k2 := 1 to NParam do
           der2j[k1,k2] := 0;
   end;// for k1
   calculFonction;
   if not erreurCalcul then CalculLoc;
   PrecisionModele := sqrt(J/SommeCarreY);
   DeltaJ := J-Jprecedent;
   Diverge := DeltaJ>J*PrecisionZero;
   Stable := (abs(DeltaJ)<(Jprecedent*PrecisionRelativeJ)) or
                        (PrecisionModele<PrecisionAbsolueJ);
end; // calculJ

Function EffectueGaussNewton : boolean;
const
    Maxi_i1 = 32; // time out
    Maxi_i2 = 6; // µ mini =(1/2)^7=1%
var k : integer;
    i1,i2 : integer;
    mu : double;
// boucle de recherche par méthode gradient-Newton
begin
    i1 := 0;
    result := false;
    repeat
        inc(i1);
        Jprecedent := J;
        calculPrecision;
        if erreurCalcul then exit;
        for k := 1 to NParam do
            valeurParamE[k] := valeurParamE[k]+incParam[k];
        CalculJ;
        if erreurParam then exit;
        mu := 1;i2 := 0;
        while (Diverge or ErreurCalcul) and (i2<Maxi_i2) do begin
            inc(i2);
            mu := mu/2;
            for k := 1 to NParam do
                valeurParamE[k] := valeurParamE[k]-incParam[k]*mu;
            CalculJ;
        end; // while diverge
        if diverge and (stable or (i1<=1)) then begin
           calculJ; // calcul dans l'état initial
           diverge := false;
           stable := true;
        end;
        if erreurCalcul or erreurParam or diverge then exit;
   until (i1>Maxi_i1) or stable;
   result := true;
end; // EffectueGaussNewton

var Ndiv2 : integer;
    deltax,x0,x1 : double;
    i,ii : integer;
begin // effectueModeleNum
    result := false;
    InitCalculJ;
    CalculJ;
    if erreurCalcul or ErreurParam then exit;
    if not EffectueGaussNewton then exit;
    result := stable;
    Ndiv2 := NbrePointDeriveeLisse div 2;
    x1 := pages[pageCourante].valeurVar[indexX,(debut+fin) div 2];
    x0 := pages[pageCourante].valeurVar[indexX,debut];
    deltax := (x1-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       xLisse[i] := x0+i*deltax;
       yLisse[i] := evalValeurYth(xLisse[i]);
       yder[i] := evalValeurderYth(xLisse[i]);
    end;
    x0 := pages[pageCourante].valeurVar[indexX,(debut+fin) div 2];
    x1 := pages[pageCourante].valeurVar[indexX,fin];
    deltax := (x1-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       ii := i+Ndiv2;
       xLisse[ii] := x0+i*deltax;
       yLisse[ii] := evalValeurYth(xLisse[ii]);
       yder[ii] := evalValeurderYth(xLisse[i]);
    end;
    pHInflexion := -valeurParamE[2]/(3*valeurParamE[3]);
    vInflexion := evalValeurYth(pHInflexion);
end; // EffectueModeleNum

constructor TmodeleInflexionVerticale.create;
begin
    setLength(valeurYth,Nmesmax);
    NParam := 3;
    setLength(xLisse,NbrePointDeriveeLisse+1);
    setLength(yLisse,NbrePointDeriveeLisse+1);
    setLength(yder,NbrePointDeriveeLisse+1);
end;

destructor TmodeleInflexionVerticale.destroy;
begin
    valeurYth := nil;
    inherited destroy;
end;
*)

constructor TmodeleEquivalence.create;
begin
    setLength(valeurYth,Nmesmax);
    NParam := 2;
    setLength(xl,NbrePointDeriveeLisse+1);
    setLength(yl,NbrePointDeriveeLisse+1);
    setLength(yder,NbrePointDeriveeLisse+1);
end;

destructor TmodeleEquivalence.destroy;
begin
    valeurYth := nil;
    inherited destroy;
end;

function ModeleInflexion(const X,Y : Tvecteur;const index : integer;
         var Xl,Yl : Tvecteur;var ve,phe : double;pente : double) : boolean;
// on modélise y=a+bx+cx^2+dx^3 pour déterminer un point d'inflexion verticale donc avec b=c^2/3d
const degreDeriveeL = 3;
      ordre = degreDeriveeL+1;
      puissMax = 2*degreDeriveeL;
      ecart = 2; // centre (index) et deux points de chaque côté
var puissX : TvectorPuiss;
    A : Tmatrice;
    Coeff : TmatriceLigne;
    x0,x2,deltax : double;
    NDiv2 : integer;

Function ResoudEquation : boolean;
var
    PrecisionValeur : double;
Const
    PrecisionRelative = 1e-8;
    PrecisionAbsolue = 1e-15; // calcul de pH à 10-2 près à pH=13
var
    J,Jprec,incph : double; // J = F(x)^2
    diverge,stable : boolean;
    valF,valFprime : double; // valeur de la fonction et de sa dérivée
    pha: double;

procedure CalculF;
begin
   valF := coeff[1]+phe/pente-ve+pha*(coeff[2]-1/pente)+coeff[3]*pha*pha+coeff[4]*pha*pha*pha;
   J := sqr(valF);
   Diverge := J>Jprec;
end;

procedure CalculJ;
begin
   CalculF;
   valFprime := coeff[2]-1/pente+2*coeff[3]*pha+3*coeff[4]*pha*pha;
   incph := valF/valFprime;
   Stable := J<=precisionValeur;
   Diverge := Diverge and (not Stable);
end;

const
    Maxi_i1 = 12; // time out
    Maxi_i2 = 5; // soit µ mini =(1/3)^5=0.4%
var
    i1,i2 : integer;
    mu : double;
begin // resoudEquation
    pha := phe;
    result := false;
    PrecisionValeur := abs(pha)*PrecisionRelative;
    if PrecisionValeur<PrecisionAbsolue then PrecisionValeur := PrecisionAbsolue;
    stable := false;
    Jprec := 0;
    i1 := 0;
    try;
    CalculJ;
    Repeat
       Jprec := J;
       pha := pha-incph;
       CalculF;
       if diverge then begin
          mu := 1;
          i2 := 0;
          repeat
             mu := mu/3;
             pha := pha+incph*mu;
             calculF;
             inc(i2);
          until (not diverge) or (i2>=Maxi_i2);
       end;
       calculJ;
       inc(i1);
    until stable or (i1>=Maxi_i1) or diverge;
    if (i1>=Maxi_i1) or diverge then exit;
    if abs(phe-pha)<phe/20 then phe := pha;
    ve := coeff[1]+phe*(coeff[2]+phe*(coeff[3]+coeff[4]*phe));
    result := true;
    except
    end;
end;// resoudEquation

procedure initXY;
var j : integer;
    loc : double;
    i : integer;
begin
    for i := 1 to puissMax do puissX[i] := 0;
    puissX[0] := 5;
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

Function VerifDerivee : boolean;
var i : integer;
    ref,courant : double;
begin
     result := false;
     ref := coeff[2]+(2*coeff[3]+3*coeff[4]*xl[0])*xl[0];
     for i := 1 to pred(NbrePointDeriveeLisse) do begin
         courant := coeff[2]+(2*coeff[3]+3*coeff[4]*xl[i])*xl[i];
         if (courant*ref<0) and (abs(courant)>(abs(ref)/32)) then exit;
         // la dérivée change de signe ou devient trop grande
     end;
     result := true;
end;

Procedure AffecteValeur(i : integer);
begin
    yl[i] := coeff[1]+xl[i]*(coeff[2]+(coeff[3]+coeff[4]*xl[i])*xl[i]);
end;

var i,j : integer;
begin // ModeleInflexion
    Ndiv2 := NbrePointDeriveeLisse div 2;
    setLength(xl,NbrePointDeriveeLisse+1);
    setLength(yl,NbrePointDeriveeLisse+1);
    initXY;
    AffecteCoeff;
    x0 := x[index-ecart];
    x2 := x[index];
    deltax := (x2-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       xl[i] := x0+i*deltax;
       AffecteValeur(i);
    end;
    x0 := x[index];
    x2 := x[index+ecart];
    deltax := (x2-x0)/Ndiv2;
    for i := 0 to Ndiv2 do begin
       j := i+Ndiv2;
       xl[j] := x0+i*deltax;
       AffecteValeur(j);
    end;
    result := verifDerivee and resoudEquation;
end; // ModeleInflexion

initialization
{$IFDEF Debug}
   ecritDebug('initialization modeleNum');
{$ENDIF}
   modeleAvant := TmodeleEquivalence.Create;
   modeleAvant.positionEquivalence := pAvant;
   modeleApres := TmodeleEquivalence.Create;
   modeleApres.positionEquivalence := pApres;
   //modeleInflexionVerticale := TmodeleInflexionVerticale.Create;

finalization
   modeleAvant.Free;
   modeleApres.Free;
 //  modeleInflexionVerticale.free;

end.
