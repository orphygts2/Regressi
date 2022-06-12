unit systdiff;
// Calcul de système différentiel pour modélisation

interface

uses regutil, math, maths, compile, sysutils;

Procedure SystemeDiff1(EquaDiff : TMatriceFonction;
      ResultParam : TMatriceVecteur;mdebut,mfin : TcodeIntervalle);
Procedure SystemeDiff2(EquaDiff : TMatriceFonction;
      ResultParam : TMatriceVecteur;mdebut,mfin : TcodeIntervalle);
Procedure EquationDiff2(mdebut,mfin : TcodeIntervalle);
Procedure EquationDiff1(mdebut,mfin : TcodeIntervalle);
Procedure ExtrapoleDiff2(pg : TcodePage;PosInit : integer;Tmini,Tmaxi : double;
     var ValX : Tvecteur;var ValY,valYp : TvecteurExtrapole;mdebut,mfin : TcodeIntervalle);
Procedure ExtrapoleDiff1(pg : TcodePage;PosInit : integer;Tmini,Tmaxi : double;
     var ValX : Tvecteur;var ValY : TvecteurExtrapole;mdebut,mfin : TcodeIntervalle);
Procedure ModeleEuler(NbrePoints : integer);

implementation

var TableauVariab : array[0..MaxGrandeurs] of integer;
    NbreVariabDiff : integer;

Procedure SetTemps(t : double;pg : TcodePage);
var i,j,k : integer;
begin with pages[pg] do begin
      grandeurs[0].valeurCourante := t;
      if NbreVariabDiff=0 then exit;
      i := round(pred(nmes)*(t-valeurVar[0,0])/(valeurVar[0,pred(nmes)]-valeurVar[0,0]));
      if i<0
         then i := 0
         else if i>=nmes then i := pred(nmes);
      for j := 1 to NbreVariabDiff do begin
          k := TableauVariab[j];
          grandeurs[k].valeurCourante := valeurVar[k,i]
      end;
end end;

Procedure InitTableau(mdebut,mfin : TcodeIntervalle);
var j,m : integer;
begin
     NbreVariabDiff := 0;
     for j := 0 to pred(NbreGrandeurs) do with grandeurs[j] do
         if (genreG=variable) then
         for m := mDebut to mFin do
             if j in fonctionTheorique[m].depend then begin
                inc(NbreVariabDiff);
                TableauVariab[NbreVariabDiff] := j
             end;
end;

Procedure getNbre(debut,fin,NbreMax : integer; var Nbre,NbrePas : integer);
begin
     Nbre := fin-debut;
     NbrePas := NbreMax div Nbre;
     if NbrePas<1 then NbrePas := 1;
     if NbrePas>10 then NbrePas := 10;
     Nbre := Nbre*NbrePas;
end;

Procedure SystemeDiff1(EquaDiff : TMatriceFonction;
       ResultParam : TMatriceVecteur;mdebut,mfin : TcodeIntervalle);

// calcul par Runge-Kunta ordre 4 de xi(t) solutions de : x'=xp(x,t)

var i : integer;

Procedure calcPoint;
var deltatsur2 : double;
    p,p1,p2,p2bis,pbis : TMatriceReal;
    vp,vp1,vp2,vp2bis,vpbis : TableauReal;
    k : integer;

Procedure Calc(var pp : TMatriceReal;var vpp : TableauReal;t,delta : double);
var m : TcodeIntervalle;
    k : TcodeParam;
begin
    setTemps(t,pageCourante);
    for m := mDebut to mFin do begin
        fonctionTheorique[m].addrY.valeurCourante := vp[m];
        for k := 1 to NbreParam[paramNormal] do
            parametres[ParamDiff1,k].valeurCourante := p[m,k];
    end;
    for m := mDebut to mFin do begin
        vpp[m] := calcule(fonctionTheorique[m].calcul^.OperandGlb);
        for k := 1 to NbreParam[paramNormal] do
            pp[m,k] := calcule(EquaDiff[m,k]^.OperandGlb);
    end;
    for m := mDebut to mFin do begin
        for k := 1 to NbreParam[paramNormal] do
            p[m,k] := ResultParam[m,k,i]+delta*pp[m,k];
        vp[m] := pages[pageCourante].valeurTheorique[m,i]+delta*vpp[m];
    end;
end; // calc

var m : TcodeIntervalle;
    t : double;
begin // calcPoint
   t := grandeurs[0].valeur[i];
   deltatSur2 := (grandeurs[0].valeur[succ(i)]-t)/2;
   affecteVariableE(i);
   for m := mDebut to mFin do begin
       vp[m] := pages[pageCourante].valeurTheorique[m,i];
       for k := 1 to NbreParam[paramNormal] do
           p[m,k] := ResultParam[m,k,i];
   end;
   Calc(p1,vp1,t,deltatSur2);
   Calc(p2,vp2,t+deltatSur2,deltatSur2);
   Calc(p2bis,vp2bis,t+deltatSur2,deltatSur2*2);
   Calc(pbis,vpbis,t+deltatSur2*2,0);
   for m := mDebut to mFin do begin
       pages[pageCourante].valeurTheorique[m,succ(i)] :=
            pages[pageCourante].valeurTheorique[m,i] +
                deltatSur2*(vp1[m]+2*vp2[m]+2*vp2bis[m]+vpbis[m])/3;
       for k := 1 to NbreParam[paramNormal] do
           ResultParam[m,k,succ(i)] := ResultParam[m,k,i]+
                   deltatSur2*(p1[m,k]+2*p2[m,k]+2*p2bis[m,k]+pbis[m,k])/3;
   end;
end; // calcPoint

var m : TcodeIntervalle;
    k : TcodeParam;
    j : integer;
begin with Pages[pageCourante] do begin
    InitTableau(mDebut,mFin);
    affecteVariableE(debut[mDebut]);
    for m := mDebut to mFin do with fonctionTheorique[m] do begin
         valeurTheorique[m,debut[m]] := calcul^.varX.valeurCourante;
         for k := 1 to NbreParam[paramNormal] do
             resultParam[m,k,debut[m]] := EquaDiff[m,k]^.valeurGlb;
   end;
   try
   for i := debut[mDebut] to pred(fin[mDebut]) do calcPoint
   except
       on E : exception do begin
          for m := mDebut to mFin do
              for j := i to fin[m] do
                  pages[pageCourante].valeurTheorique[m,j] := Nan;
          raise EMathError.create(E.message);
       end;
   end;
end end; // systemeDiff1 

Procedure EquationDiff1(mdebut,mfin : TcodeIntervalle);
{ calcul par Runge-Kunta ordre 4 de xi(t) solutions de : x'=xp(x,t) }

var i : integer;

Procedure calcPoint;
var p,p1,p2,p2bis,pbis : tableauReal;

Procedure Calc(var pp : tableauReal;t,delta : double);
var m : TcodeIntervalle;
begin
    setTemps(t,pageCourante);
    for m := mDebut to mFin do
        grandeurs[fonctionTheorique[m].indexY].valeurCourante := p[m];
    for m := mDebut to mFin do begin
        pp[m] := calcule(fonctionTheorique[m].calcul^.operandGlb);
        p[m] := pages[pageCourante].valeurTheorique[m,i]+delta*pp[m];
     end;
end;

var m : TcodeIntervalle;
    t,deltatSur2 : double;
begin
    t := grandeurs[0].valeur[i];
    deltatSur2 := (grandeurs[0].valeur[succ(i)]-t)/2;
    affecteVariableE(i);
    for m := mDebut to mFin do
        p[m] := pages[pageCourante].valeurTheorique[m,i];
    Calc(p1,t,deltatSur2);
    Calc(p2,t+deltatSur2,deltatsur2);
    Calc(p2bis,t+deltatSur2,deltatsur2*2);
    Calc(pbis,t+deltatSur2*2,0);
    for m := mDebut to mFin do
        pages[pageCourante].valeurTheorique[m,succ(i)] :=
            pages[pageCourante].valeurTheorique[m,i] +
                deltatsur2*(p1[m]+2*p2[m]+2*p2bis[m]+pbis[m])/3;
end; // calcPoint

var m : TcodeIntervalle;
    j : integer;
begin with pages[pageCourante] do begin
    InitTableau(mDebut,mFin);
    affecteVariableE(debut[mDebut]);
    for m := mDebut to mFin do with fonctionTheorique[m] do
        valeurTheorique[m,debut[m]] := calcul^.varx.valeurCourante;
    try
    for i := debut[mDebut] to pred(fin[mDebut]) do calcPoint;
    except
        on E : exception do begin
        for j := i to fin[mDebut] do
            for m := mDebut to mFin do
                valeurTheorique[m,j] := Nan;
        raise EMathError.create(E.message);
        end
    end;
end end; // equationDiff1

Procedure SystemeDiff2(EquaDiff : TMatriceFonction;
      ResultParam : TMatriceVecteur;mdebut,mfin : TcodeIntervalle);

 { calcul par Runge-Kunta d'ordre 4 de z(t) solution de z''=f(t,z,z')
   système équivalent : z'=x  z''=x'=f(t,z,x) }

var i,j : integer;
    PrimeParam : TMatriceReal;
    LissePrime,Ytheorique : array[TcodeIntervalle] of Tvecteur;
    Xtheorique : Tvecteur;

Procedure calcPoint;
var  t,deltatSur2 : double;
     p1,p2,p2bis,pbis : TMatriceReal;
     fp1,fp2,fp2bis,fpbis : TMatriceReal;
     v1,v2,v2bis,vbis : TableauReal;
     fv1,fv2,fv2bis,fvbis : TableauReal;
     ValeurParCourant,DerParCourant : TMatriceReal;
     ValeurVarCourant,DerVarCourant : TableauReal;
     k : integer;
     m : TcodeIntervalle;

Procedure Calc(var ffp,zzp : TMatriceReal;var ffv,zzv : TableauReal;t,deltat : double);
var m : TcodeIntervalle;
    k : TcodeParam;
begin
    setTemps(t,pageCourante);
    for m := mDebut to mFin do begin
        fonctionTheorique[m].addrY.valeurCourante := ValeurVarCourant[m];
        fonctionTheorique[m].addrYp.valeurCourante := DerVarCourant[m];
        for k := 1 to NbreParam[paramNormal] do begin
            parametres[ParamDiff1,k].valeurCourante := ValeurParCourant[m,k];
            parametres[ParamDiff2,k].valeurCourante := DerParCourant[m,k];
        end;{k}
    end;{m}
    for m := mDebut to mFin do begin
        ffv[m] := calcule(fonctionTheorique[m].calcul^.OperandGlb);
        for k := 1 to NbreParam[paramNormal] do
            ffp[m,k] := calcule(EquaDiff[m,k]^.OperandGlb);
    end;
    zzp := DerParCourant;
    zzv := DerVarCourant;
    for m := mDebut to mFin do begin
        ValeurVarCourant[m] := Ytheorique[m,i] + deltat*DerVarCourant[m];
        DerVarCourant[m] := LissePrime[m,i] + deltat*ffv[m];
        for k := 1 to NbreParam[paramNormal] do begin
            ValeurParCourant[m,k] := ResultParam[m,k,i] +
                deltat*DerParCourant[m,k];
            DerParCourant[m,k] := PrimeParam[m,k] + deltat*ffp[m,k];
        end;
    end;
end; { Calc }

begin
     t := Xtheorique[i];
     deltatSur2 := (Xtheorique[succ(i)]-t)/2;
     for m := mDebut to mFin do begin
        ValeurVarCourant[m] := Ytheorique[m,i];
        DerVarCourant[m] := LissePrime[m,i];
        for k := 1 to NbreParam[paramNormal] do
           ValeurParCourant[m,k] := ResultParam[m,k,i];
     end;
     DerParCourant := PrimeParam;
     Calc(fp1,p1,fv1,v1,t,deltatSur2);
     Calc(fp2,p2,fv2,v2,t+deltatSur2,deltatSur2);
     Calc(fp2bis,p2bis,fv2bis,v2bis,t+deltatSur2,deltatSur2*2);
     Calc(fpbis,pbis,fvbis,vbis,t+deltatSur2*2,0);
     for m := mDebut to mFin do begin
          LissePrime[m,succ(i)] := LissePrime[m,i] +
                deltatSur2*(fv1[m]+2*fv2[m]+2*fv2bis[m]+fvbis[m])/3;
          Ytheorique[m,succ(i)] := Ytheorique[m,i]+
                deltatSur2*(v1[m]+2*v2[m]+2*v2bis[m]+vbis[m])/3;
          for k := 1 to NbreParam[paramNormal] do begin
                 PrimeParam[m,k] := primeParam[m,k] + deltatSur2*
                    (fp1[m,k]+2*fp2[m,k]+2*fp2bis[m,k]+fpbis[m,k])/3;
                 ResultParam[m,k,succ(i)] := ResultParam[m,k,i]+deltatSur2*
                    (p1[m,k]+2*p2[m,k]+2*p2bis[m,k]+pbis[m,k])/3;
          end;{k}
     end;
end; { calcPoint }

var k : TcodeParam;
    m : TcodeIntervalle;
    Nbre,NbrePas : integer;
    t,pasT : double;
begin //  SystemeDiff2
with pages[pageCourante] do begin
     InitTableau(mdebut,mfin);
     GetNbre(debut[mDebut],fin[mDebut],NmesMax,Nbre,NbrePas);
     setLength(Xtheorique,Nbre+2);
     affecteVariableE(debut[mDebut]);
     for m := mDebut to mFin do with fonctionTheorique[m] do begin
         indexYp := addrYp.indexG;
         indexY := addrY.indexG;
         setlength(LissePrime[m],NmesMax+1);
         setLength(Ytheorique[m],NmesMax+1);
         Ytheorique[m,0] := calcul^.varX.valeurCourante;
         LissePrime[m,0] := calcul^.varY.valeurCourante;
         for i := debut[m] to pred(fin[m]) do begin
             t := grandeurs[0].valeur[i];
             pasT := (grandeurs[0].valeur[succ(i)]-t)/nbrePas;
             for j := 0 to pred(NbrePas) do
                 XTheorique[j+(i-debut[m])*NbrePas] := t+j*pasT;
         end;
         Xtheorique[Nbre] := grandeurs[0].valeur[fin[m]];
         for k := 1 to NbreParam[paramNormal] do begin
             primeParam[m,k] := EquaDiff[m,k]^.valeurInitDer;
             resultParam[m,k,0] := EquaDiff[m,k]^.valeurGlb;
         end;
     end;
     try
     for i := 0 to pred(Nbre) do begin
         if i mod NbrePas=0 then
            affecteVariableE(debut[mDebut]+(i div NbrePas));
         calcPoint;
     end;
     except
         on E : exception do begin
         for j := i to pred(Nbre) do
             for m := mDebut to mFin do begin
                LissePrime[m,j] := Nan;
                Ytheorique[m,j] := Nan;
             end;
         raise EMathError.create(E.message);
         end
     end;
     for m := mDebut to mFin do begin
         for i := debut[m] to fin[m] do begin
            j := (i-debut[m])*NbrePas;
            valeurTheorique[m,i] := Ytheorique[m,j];
            valeurLisse[fonctionTheorique[m].indexYp,i] := LissePrime[m,j];
            for k := 1 to NbreParam[paramNormal] do
                ResultParam[m,k,i] := ResultParam[m,k,j];
         end;
         finalize(LissePrime[m]);
         finalize(Ytheorique[m]);
     end;
     finalize(Xtheorique);
end end; // SystemeDiff2

Procedure EquationDiff2(mdebut,mfin : TcodeIntervalle);
{ calcul par Runge-Kunta d'ordre 4 de z(t) solution de z''=f(t,z,z')
  système équivalent : z'=x  z''=x'=f(t,z,x) }

var i : integer;
    LissePrime,Ytheorique : array[TcodeIntervalle] of Tvecteur;
    Xtheorique : Tvecteur;

Procedure calcPoint;
var  t,deltatSur2 : double;
     p,p1,p2,p2bis,pbis : tableauReal;
     fp,fp1,fp2,fp2bis,fpbis : tableauReal;
     val_p,val_pprime : tableauReal;
     m : TcodeIntervalle;

Procedure Calc(var ffp,zzp : tableauReal;t,deltat : double);
var m : TcodeIntervalle;
begin
    setTemps(t,pageCourante);
    for m := mDebut to mFin do begin
        fonctionTheorique[m].addrY.valeurCourante := val_p[m];
        fonctionTheorique[m].addrYp.valeurCourante := val_pprime[m];
    end;{m}
    for m := mDebut to mFin do
        ffp[m] := calcule(fonctionTheorique[m].calcul^.operandGlb);
    zzp := val_pprime;
    for m := mDebut to mFin do begin
         val_p[m] := p[m] + deltat*val_pprime[m];
         val_pprime[m] := fp[m] + deltat*ffp[m];
    end;
end; { Calc }

begin
     t := Xtheorique[i];
     deltatSur2 := (Xtheorique[succ(i)]-t)/2;
     affecteVariableE(i);
     for m := mDebut to mFin do begin
         p[m] := Ytheorique[m,i];
         fp[m] := LissePrime[m,i];
     end;
     val_p := p;
     val_pprime := fp;
     Calc(fp1,p1,t,deltatSur2);
     Calc(fp2,p2,t+deltatSur2,deltatSur2);
     Calc(fp2bis,p2bis,t+deltatSur2,deltatSur2*2);
     Calc(fpbis,pbis,t+deltatSur2*2,0);
     for m := mDebut to mFin do begin
          LissePrime[m,succ(i)] := LissePrime[m,i] +
               deltatSur2*(fp1[m]+2*fp2[m]+2*fp2bis[m]+fpbis[m])/3;
          Ytheorique[m,succ(i)] := Ytheorique[m,i] +
               deltatSur2*(p1[m]+2*p2[m]+2*p2bis[m]+pbis[m])/3;
     end;{m}
end; { calcPoint }

var m : TcodeIntervalle;
    Nbre,NbrePas,j : integer;
    t,pasT : double;
begin {EquationDiff2} with pages[pageCourante] do begin
     InitTableau(mdebut,mfin);
     affecteVariableE(debut[mDebut]);
     GetNbre(debut[mDebut],fin[mDebut],NmesMax,Nbre,NbrePas);
     setLength(Xtheorique,Nbre+2);
     for m := mDebut to mFin do with fonctionTheorique[m] do begin
         indexYp := addrYp.indexG;
         indexY := addrY.indexG;
         setlength(LissePrime[m],NmesMax+1);
         setLength(Ytheorique[m],NmesMax+1);
         Ytheorique[m,0] := calcul^.varX.valeurCourante;
         LissePrime[m,0] := calcul^.varY.valeurCourante;
         for i := debut[m] to pred(fin[m]) do begin
             t := grandeurs[0].valeur[i];
             pasT := (grandeurs[0].valeur[succ(i)]-t)/nbrePas;
             for j := 0 to pred(NbrePas) do
                 XTheorique[j+(i-debut[m])*NbrePas] := t+j*pasT;
         end;
         Xtheorique[Nbre] := grandeurs[0].valeur[fin[m]];
     end;
     try
     for i := 0 to pred(Nbre) do begin
        if i mod NbrePas=0 then
            affecteVariableE(debut[mDebut]+(i div NbrePas));
        calcPoint;
     end;
     except
        on E : exception do begin
           for j := i to pred(Nbre) do
               for m := mDebut to mFin do begin
                   LissePrime[m,j] := Nan;
                   Ytheorique[m,j] := Nan;
               end;
           raise EMathError.create(E.message);
         end;
     end;
     for m := mDebut to mFin do begin
         for i := debut[m] to fin[m] do begin
            j := (i-debut[m])*NbrePas;
            valeurTheorique[m,i] := Ytheorique[m,j];
            valeurLisse[fonctionTheorique[m].indexYp,i] := LissePrime[m,j];
         end;
         finalize(LissePrime[m]);
         finalize(Ytheorique[m]);
     end;
     finalize(Xtheorique);
end end;{EquationDiff2}

Procedure ExtrapoleDiff2(pg : TcodePage;PosInit : integer;Tmini,Tmaxi : double;
    var ValX : Tvecteur;var ValY,valYp : TvecteurExtrapole;mdebut,mfin : TcodeIntervalle);
{ calcul par Runge-Kunta d'ordre 4 de z(t) solution de z''=f(t,z,z')
  système équivalent : z'=x  z''=x'=f(t,z,x) }
var i,iDebut : integer;
    deltat,Tinit : double;

Procedure calcPoint(ii : integer);
var  p,p1,p2,p2bis,pbis : tableauReal;
     fp,fp1,fp2,fp2bis,fpbis : tableauReal;
     val_p,val_pprime : tableauReal;
     m : TcodeIntervalle;
     t : double;

Procedure Calc(var ffp,zzp : tableauReal;t,deltat : double);
var m : TcodeIntervalle;
begin
    setTemps(t,pg);
    for m := mDebut to mFin do begin
        fonctionTheorique[m].addrY.valeurCourante := val_p[m];
        fonctionTheorique[m].addrYp.valeurCourante := val_pprime[m];
    end;{m}
    for m := mDebut to mFin do
        ffp[m] := calcule(fonctionTheorique[m].calcul^.operandGlb);
    zzp := val_pprime;
    for m := mDebut to mFin do begin
         val_p[m] := p[m] + deltat*val_pprime[m];
         val_pprime[m] := fp[m] + deltat*ffp[m];
    end;
end; { Calc }

begin
     t := valX[i];
     for m := mDebut to mFin do begin
         p[m] := valY[m,i];
         fp[m] := valYp[m,i];
     end;
     val_p := p;
     val_pprime := fp;
     Calc(fp1,p1,t,deltat/2);
     Calc(fp2,p2,t+deltat/2,deltat/2);
     Calc(fp2bis,p2bis,t+deltat/2,deltat);
     Calc(fpbis,pbis,t+deltat,0);
     for m := mDebut to mFin do begin
         valYp[m,ii] := valYp[m,i] +
               deltat*(fp1[m]+2*fp2[m]+2*fp2bis[m]+fpbis[m])/6;
         valY[m,ii] := valY[m,i] +
               deltat*(p1[m]+2*p2[m]+2*p2bis[m]+pbis[m])/6;
     end;{m}
end; { calcPoint }

var m : TcodeIntervalle;
    j : integer;
begin {ExtrapoleDiff2} with pages[pg] do begin
     InitTableau(mdebut,mfin);
     affecteVariableE(posInit);
     tInit := grandeurs[0].valeur[posInit];
     if Tinit<Tmini then Tmini := Tinit;
     deltat := (Tmaxi-Tmini)/NmesMax;
     idebut := round((Tinit-Tmini)/Deltat);
     setLength(valX,NmesMax+1);
     for m := mDebut to mFin do with fonctionTheorique[m] do begin
         indexYp := addrYp.indexG;
         indexY := addrY.indexG;
         setLength(valY[m],NmesMax+1);
         setLength(valYp[m],NmesMax+1);
         valY[m,iDebut] := calcul^.varX.valeurCourante; { valeur init }
         valYp[m,iDebut] := calcul^.varY.valeurCourante; { dérivée init }
     end;
     for i := 0 to pred(NmesMax) do valX[i] := Tinit+(i-iDebut)*deltat;
     try
     for i := iDebut to NmesMax-2 do calcPoint(succ(i));
     except
        on E : exception do begin
           for j := i to Pred(NmesMax) do
              for m := mDebut to mFin do begin
                 valYp[m,j] := Nan;
                 valY[m,j] := Nan;
              end;{m}
           raise EMathError.create(E.message);
        end;
     end;
     deltat := -deltat;
     try
     for i := iDebut downto 1 do calcPoint(pred(i));
     except
        on E : exception do begin
           for j := i downto 0 do
              for m := mDebut to mFin do begin
                  valYp[m,j] := Nan;
                  valY[m,j] := Nan;
               end;{m}
           raise EMathError.create(E.message);
        end;
     end;
end end;{ExtrapoleDiff2}

Procedure ExtrapoleDiff1(pg : TcodePage;PosInit : integer;Tmini,Tmaxi : double;
    var ValX : Tvecteur;var ValY : TvecteurExtrapole;mdebut,mfin : TcodeIntervalle);
{ calcul par Runge-Kunta ordre 4 de xi(t) solutions de : x'=xp(x,t) }

var i : integer;
    t,deltat : double;

Procedure calcPoint(ii : integer);
var p,p1,p2,p2bis,pbis : tableauReal;

Procedure Calc(var pp : tableauReal;t,delta : double);
var m : TcodeIntervalle;
begin
    setTemps(t,pg);
    for m := mDebut to mFin do
        grandeurs[fonctionTheorique[m].indexY].valeurCourante := p[m];
    for m := mDebut to mFin do begin
        pp[m] := calcule(fonctionTheorique[m].calcul^.operandGlb);
        p[m] := valY[m,i]+delta*pp[m];
     end;
end;

var m : TcodeIntervalle;
begin
    t := valX[i];
    for m := mDebut to mFin do p[m] := valY[m,i];
    Calc(p1,t,deltat/2);
    Calc(p2,t+deltat/2,deltat/2);
    Calc(p2bis,t+deltat/2,deltat);
    Calc(pbis,t+deltat,0);
    for m := mDebut to mFin do
        valY[m,ii] := valY[m,i] +
                deltat*(p1[m]+2*p2[m]+2*p2bis[m]+pbis[m])/6;
end; { calcPoint }

var m : TcodeIntervalle;
    iDebut : integer;
    Tinit : double;
    j : integer;
begin{ ExtrapoleDiff1 }
with pages[pg] do begin
    InitTableau(mdebut,mfin);
    affecteVariableE(debut[mDebut]);
    tInit := grandeurs[0].valeur[posInit];
    if Tinit<Tmini then Tmini := Tinit;
    deltat := (Tmaxi-Tmini)/NmesMax;
    idebut := round((Tinit-Tmini)/Deltat);
    setLength(valX,NmesMax+1);
    for i := 0 to pred(NmesMax) do valX[i] := Tinit+(i-iDebut)*deltat;
    for m := mDebut to mFin do begin
        setLength(valY[m],NmesMax+1);
        with fonctionTheorique[m] do
           valY[m,iDebut] := calcul^.varX.valeurCourante;
    end;
    try
    for i := iDebut to NmesMax-2 do calcPoint(succ(i));
    except
       on E : exception do begin
          for j := i to NmesMax-2 do
              for m := mDebut to mFin do
                valY[m,j] := Nan;
          raise EMathError.create(E.message);
       end;
     end;
    deltat := -deltat;
    try
    for i := iDebut downto 1 do calcPoint(pred(i));
    except
       on E : exception do begin
          for j := i downto 0 do
              for m := mDebut to mFin do
                valY[m,j] := Nan;
          raise EMathError.create(E.message);
       end;
    end;
end end; // ExtrapoleDiff1

Procedure ModeleEuler(NbrePoints : integer);
var i,j : integer;
    m,indexT : TcodeIntervalle;
    t,coeff : double;
begin with pages[pageCourante] do begin
    affecteVariableE(0);
    affecteConstParam(true);
    indexT := 1;
    for m := 1 to NbreModele do with FonctionTheorique[m] do begin
        setLength(valeurYEuler,NbrePoints+1);
        if calcul^.varx<>nil
           then j := IndexNom(calcul^.varx.nom)
           else j := 0;
        if (j>parametre0)
            then begin // origine est un paramètre
               j := IndexToParam(paramNormal,j);
               valeurYEuler[0] := ValeurParam[paramNormal,j];
            end
            else valeurYEuler[0] := valeurVar[indexY,0];
               // initialisation par défaut à la valeur exp
        addrY.valeurCourante := valeurYEuler[0];
        if indexY=0 then indexT := m;
    end;
    try
    for i := 1 to NbrePoints do begin
        grandeurs[cIndice].valeurCourante := i;
        for m := 1 to NbreModele do
            with FonctionTheorique[m] do begin
                 valeurYEuler[i] := calcule(calcul);
                 addrY.valeurCourante := valeurYEuler[i];
            end;
    end;
    except
    on E : exception do begin
        raise EMathError.create(E.message);
        for j := i to NbrePoints do
            for m := 1 to NbreModele do
                FonctionTheorique[m].valeurYEuler[j] := Nan;
    end end;
    for m := 1 to NbreModele do
        valeurTheorique[m,0] := FonctionTheorique[m].valeurYEuler[0];
    j := 0;
    for i := 1 to pred(nmes) do begin
        t := valeurVar[0,i];
        with FonctionTheorique[indexT] do begin
            while (valeurYeuler[j]<t) and (j<NbrePoints) do inc(j);
            coeff := (valeurYeuler[j]-t)/
                     (valeurYeuler[j]-valeurYeuler[pred(j)]);
            valeurTheorique[indexT,i] := t;
        end;
        for m := 1 to NbreModele do if m<>indexT then
            valeurTheorique[m,i] := FonctionTheorique[m].valeurYEuler[pred(j)]*coeff+
                          FonctionTheorique[m].valeurYEuler[j]*(1-coeff);
    end;
end end; // modeleEuler


end.
