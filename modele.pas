// modele.pas include de graphvar

Procedure TFgrapheVariab.EffectueModele(Ajuste,withMessage : boolean);
const LambdaMin = 1e-4;
      LambdaMax = 1e4;
var Lambda : double;
    diverge,stable : boolean;

// boucle de recherche par méthode gradient-Newton
var
   J,Jprecedent,chi2Precedent,coeffJ : tableauReal;
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
  for i := 1 to NbreParam[paramNormal] do begin
     v := der2J[i,i]*(1+Lambda);
     try
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for l := succ(i) to NbreParam[paramNormal] do begin
         v := der2J[l,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,l];
         U[i,l] := v/U[i,i];
     end;{l}
     except
        for l := 1 to NbreParam[paramNormal] do begin
             U[i,l] := 0;
             U[l,i] := 0;
             der2J[l,i] := 0;
             der2J[i,l] := 0;
// erreur sur param[i] mais on veut trouver les autres
        end {l}
      end
  end;{i}
end;{construireU}

procedure resoudreU(l : TcodeParam);
// Inversion de der2J = symétrique définie positive par
// Méthode de Choleski Trigeassou p 105
var i,k : integer;
    Y   : TableauParam;
    v   : double;
begin
    for i := 1 to NbreParam[paramNormal] do if U[i,i]= 0
        then Y[i] := 0
        else begin
           try
           if i=l then v := 1 else v := 0;
           for k := 1 to pred(i) do v := v-U[k,i]*Y[k];
           Y[i] := v/U[i,i];
           except
              Y[i] := 0
           end;
        end;{else}
// passage à invder2J
     for i := NbreParam[paramNormal] downto 1 do begin
         v := Y[i];
         for k := succ(i) to NbreParam[paramNormal] do
             v := v-U[i,k]*invDer2J[l,k];
         try
         invDer2J[l,i] := v/U[i,i];
         except
            invDer2J[l,i] := 0
         end;
    end;{i}
end;// resoudreU

// Trigeassou p 267
var m,i,l : integer;
    N : integer;
    sigmaLoc,coeffInvDer2J : double;
begin // calculPrecision
with pages[pageCourante] do begin
   construireU; // résolution successive avec B=(1..0) jusqu'à (0..1)
   erreurCalcul := false;
   for i := 1 to NbreParam[paramNormal] do resoudreU(i);
//  invMat(der2J,NbreParam[paramNormal],invDer2j);
   for i := 1 to NbreParam[paramNormal] do begin
   try
      sigmaLoc := 0;N := 0;coeffInvDer2j := 0;
      for m := 1 to NbreModele do with fonctionTheorique[m] do
           if ParamToIndex(paramNormal,i) in depend then begin
// prise en compte de l'influence de coeffJ[m]
// dans sqr car 1 pour N*coeff et 1 pour inver2j }
              if not chi2Actif then begin
               sigmaLoc := sigmaLoc+sqr(sigmaY*coeffJ[m])*NbrePointsModele;
               coeffInvDer2j := NbrePointsModele*coeffJ[m]+coeffInvDer2j;
              end;
              N := N + NbrePointsModele;
           end; {if}
       if chi2actif
          then sigmaLoc := 1
          else sigmaLoc := sqrt(sigmaLoc/coeffInvDer2J);
// pas d'incertitude => on évalue celle-ci comme écart data-fit
// avec incertitude, prise en compte dans der2J
// deltaReg est pondéré par Npoints et coeffJ
       incertParam[i] := sqrt(invDer2j[i,i])*sigmaLoc;
                                  { TODO : param coeffSI }
       if uniteSIglb then
          incertParam[i] := incertParam[i]/Parametres[paramNormal,i].coeffSI;
       if paramInverse[i] then
          incertParam[i] := incertParam[i]/sqr(parametres[paramNormal,i].valeurCourante);
       incert95Param[i] := incertParam[i]*student95(N);
// intervalle de confiance (Student) à 95 %
       incParam[i] := 0;
       for l := 1 to NbreParam[paramNormal] do
          incParam[i] := incParam[i] - invDer2j[l,i]*derj[l];
       erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
   except
         incertParam[i] := Nan;
         incParam[i] := 0;
         incert95Param[i] := Nan;
   end;
  end;{i}
  if chi2Actif then
  for i := 1 to NbreParam[paramNormal] do
      for l := 1 to NbreParam[paramNormal] do
          CovarianceParam[i,l] := invDer2J[i,l];
  if uniteSIglb then
      for i := 1 to NbreParam[paramNormal] do
          incParam[i] := incParam[i]/Parametres[paramNormal,i].coeffSI; { TODO : coeffSI param }
end end; // calculPrecision

function InitCalculJ : boolean;
// On calcule une valeur relative à l'étendue des mesures
var m,k : integer;
    i : integer;
    valeur : double;
begin with pages[pageCourante] do begin
   InitCalculJ := false;
   Chi2Actif := avecChi2;
   for m := 1 to NbreModele do with fonctionTheorique[m] do begin
      if fin[m]<debut[m] then swap(fin[m],debut[m]);
      NbrePointsModele := succ(fin[m]-debut[m]);
      if (NbrePointsModele<NbreParamModele) then begin
           afficheErreur(erNombrePetit,0);
           exit;
      end;
      NbrePointsModele := NbrePointsModele-NbreParamModele;
      if NbrePointsModele=0 then NbrePointsModele := 1;
      SommeCarreY := 0;
      for i := debut[m] to fin[m] do begin
          valeur := valeurVar[indexY,i];
          if getPointActif(i)
             then SommeCarreY := SommeCarreY + sqr(valeur)
             else dec(NbrePointsModele);
      end;
      if NbrePointsModele<1 then begin
           afficheErreur(erNombrePetit,0);
           exit;
      end;
      if  uniteSIGlb and
          (grandeurs[indexY].fonct.genreC=G_experimentale)
          then begin
               coeffSI := grandeurs[indexY].coeffSI;
               sommeCarreY := sommeCarreY*sqr(coeffSI);
          end
          else coeffSI := 1;
      fonctionTheorique[m].sigmaY := Nan;
      jPrecedent[m] := 2*sommeCarreY;
      chi2Precedent[m] := NbrePointsModele*100.0;
      Chi2Actif := chi2Actif and chi2Permis;
   end;
   if Chi2Actif // dèjà pris en compte par incertitude
     then for m := 1 to NbreModele do coeffJ[m] := 1
     else begin
        avecChi2 := false;
        Incertchi2Item.checked := false;
        for m := 1 to NbreModele do
            coeffJ[m] := Jprecedent[1]/Jprecedent[m];
     end;
   for k := 1 to MaxParametres do incertParam[k] := Nan;
   with fonctionTheorique[1] do
       InitCalculJ := (SommeCarreY>1E-22*nmes);
end end; // initCalculJ

procedure CalculJ(avecDerivee : boolean);
// calcul de J; avecDerivee => calcul derj,der2j

var Y : TMatriceVecteur;

procedure calculFonction(mDebut,mFin : TcodeIntervalle);
var i : integer;
    m,k1 : integer;
    z : double;
begin with pages[pageCourante] do begin
for m := mDebut to mFin do with fonctionTheorique[m] do begin
    setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
    for i := debut[m] to fin[m] do
        if getPointActif(i) then begin
        AffecteVariableE(i);
        try
        z := calcule(calcul);
        if isNan(z)
           then EMathError.Create(erCalcul)
           else valeurTheorique[m,i] := z;
        if avecDerivee then
           for k1 := 1 to NbreParam[paramNormal] do begin
               z := calcule(derf[m,k1]);
               if isNan(z)
                  then EMathError.Create(erCalcul)
                  else Y[m,k1,i] := z;
           end;
        if Chi2Actif and (fchi2<>nil)
           then begin
              z := calcule(fchi2);
              if isNan(z)
                 then ValeurDeriveeX[m,i] := 0
                 else ValeurDeriveeX[m,i] := z;
           end
           else ValeurDeriveeX[m,i] := 0;
        except
            on E : exception do begin
               if ErreurModele then raise EMathError.Create(E.message);
// une erreur permise à la deuxième on réarme
               erreurModele := true;
               PosErreurModele := i;
               derniereErreur := E.message;
            end;
        end;
    end;// for i
 end;{m}
end end; // calculFonction

procedure calculLoc;
var k1,k2,m : integer;
    i : integer;
    ValDerf : TableauParam;// valeur de la dérivée première
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
    CoeffChi2 : double;
    dy,dt : double;
begin with pages[pageCourante] do begin
    try
    for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
        for i := debut[m] to fin[m] do
            if getPointActif(i) then begin
            if posErreurModele=i then continue;
            if uniteSIGlb
               then Ecart := valeurTheorique[m,i]-valeurVar[indexY,i]*coeffSI
               else Ecart := valeurTheorique[m,i]-grandeurs[indexY].valeur[i];
            J[m] := J[m] + sqr(ecart);
            if avecDerivee then begin
               if Chi2Actif
                  then begin
                     try
                     dy := incertVar[indexY,i]*coeffSI;
                     if isNan(dy) then dy := 0;
                     try
                     dt := incertVar[indexX,i];
                     if isNan(dt)
                        then dt := 0
                        else dt := dt*valeurDeriveeX[m,i];
                     if uniteSIglb then dt := dt*grandeurs[indexX].coeffSI;
                     except
                        dt := 0;
                     end;
                     coeffChi2 := 1/(sqr(dy)+sqr(dt));
                     except
                       try
// on force une incertitude de 0,1% : 1e6=1/sqr(0,001)
                       coeffChi2 := 1e6/sqr(grandeurs[indexY].valeur[i]);
                       except
                          coeffChi2 := 0;
                       end;
                     end;
                     chi2[m] := chi2[m] + coeffChi2*sqr(ecart);
                  end // chi2Actif
                  else coeffChi2 := coeffJ[m];
              for k1 := 1 to NbreParam[paramNormal] do begin
                valDerf[k1] := Y[m,k1,i];
                derj[k1] := derj[k1]+coeffChi2*Ecart*valDerf[k1];
                for k2 := 1 to k1 do
                    der2j[k1,k2] := der2j[k1,k2]+coeffChi2*valDerf[k2]*valDerf[k1];
              end;// for k1
            end;// dérivée
        end;// for i
    end;// for m
    except
          erreurParam := true
    end;
end end;// calculLoc

procedure calculDiff2(mDebut,mFin : TcodeIntervalle);
// calcul_J pour équation diff d'ordre 2
var m : integer;
    i : integer;
begin
    if mDebut<>mFin then for m := 2 to mFin do
       with pages[pageCourante] do begin
         debut[m] := debut[1];
         fin[m] := fin[1];
       end;
    for m := mDebut to mFin do with pages[pageCourante] do begin
        genereLisseP(fonctionTheorique[m].indexYp);
        setTaillevecteur(ValeurDeriveeX[m],NmesMax+1);
        for i := 0 to NmesMax do ValeurDeriveeX[m,i] := 0;
    end;
    if avecDerivee
        then SystemeDiff2(derf,Y,mDebut,mFin)
        else EquationDiff2(mDebut,mFin)
end; // calculDiff2

procedure calculDiff1(mDebut,mFin : TcodeIntervalle);
// calcul_J pour équation diff d'ordre 1 
var m : integer;
    i : integer;
begin
    if mDebut<>mFin then for m := 2 to mFin do
       with pages[pageCourante] do begin
         debut[m] := debut[1];
         fin[m] := fin[1];
       end;
    for m := mDebut to mFin do with pages[pageCourante] do begin
        setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
        for i := 0 to NmesMax do ValeurDeriveeX[m,i] := 0;
    end;
    if avecDerivee
       then SystemeDiff1(derf,Y,mDebut,mFin)
       else EquationDiff1(mDebut,mFin);
end; // calculDiff1

Const
      PrecisionAbsolueJ = 0.001;
      PrecisionRelative = 0.001;
      PrecisionZero = 0.0000001; // prise en compte erreur arrondi dans comparaison à zéro
      PrecisionAbsolueChi2 = 0.1;
var k1,k2,m : integer;
    Delta : double;
begin // calculJ
with pages[pageCourante] do begin
// Initialisation
   AffecteConstParam(true);
   AffecteVariableP(false);
   erreurCalcul := false;
   erreurParam := false;
   for m := 1 to NbreModele do with fonctionTheorique[m] do begin
       J[m] := 0;
       chi2[m] := 0;
       ErreurModele := false;
       PosErreurModele := -1;
   end;
   for k1 := 1 to NbreParam[paramNormal] do begin
       derJ[k1] := 0;
       for k2 := 1 to NbreParam[paramNormal] do
          der2j[k1,k2] := 0;
   end;// for k1
   if avecDerivee then
      for m := 1 to NbreModele do
          for k1 := 1 to NbreParam[paramNormal] do
              setTailleVecteur(y[m,k1],NmesMax+1);
   try
   if isModeleSysteme
      then case fonctionTheorique[1].genreC of
           g_fonction,g_equation : calculFonction(1,NbreModele);
           g_diff1 : calculDiff1(1,NbreModele);
           g_diff2 : calculDiff2(1,NbreModele);
      end
      else for m := 1 to NbreModele do
        case fonctionTheorique[m].genreC of
           g_fonction,g_equation : calculFonction(m,m);
           g_diff1 : calculDiff1(m,m);
           g_diff2 : calculDiff2(m,m);
        end;
   except
       on E : exception do begin
          derniereErreur := E.message;
          erreurCalcul := true;
       end;
   end;
   if not erreurCalcul then CalculLoc;
   if avecDerivee then
      for m := 1 to NbreModele do
          for k1 := 1 to NbreParam[paramNormal] do
              y[m,k1] := nil;
   stable := true;
   diverge := false;
   for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        PrecisionModele[m] := sqrt(J[m]/SommeCarreY);
        if Chi2Actif
           then begin
              chi2Relatif := chi2[m]/NbrePointsModele;
              Delta := chi2[m]-chi2Precedent[m];
              Stable := Stable and
                    ( (abs(Delta)<(NbrePointsModele*PrecisionRelative)) or
                     (chi2[m]<(NbrePointsModele*PrecisionAbsolueChi2)) );
              Diverge := Diverge or (Delta>chi2[m]*PrecisionZero);
           end
           else begin
              SigmaY := sqrt(J[m]/NbrePointsModele); // / coeffSI
              Delta := J[m]-Jprecedent[m];
              Diverge := Diverge or (Delta>J[m]*PrecisionZero);
              Stable := Stable and
                  ( (abs(Delta)<(Jprecedent[m]*PrecisionRelative)) or
                    (PrecisionModele[m]<PrecisionAbsolueJ) );
           end;
   end; // m
end end; // calculJ

procedure completeValTh;
var m : integer;
    i : integer;
begin
   if (OmExtrapole in Graphes[1].optionModele) and
       pages[pageCourante].ModeleCalcule then with pages[pageCourante] do begin
      if isModeleSysteme and
         (fonctionTheorique[1].genreC in [g_fonction,g_equation]) then begin
         for m := 1 to NbreModele do
              for i := 0 to pred(nmes) do
                  if (i<debut[m]) or (i>fin[m]) then begin
                     AffecteVariableE(i);
                     valeurTheorique[m,i] := calcule(fonctionTheorique[m].calcul);
                  end;// calculPoint
      end // g_fonction
      else begin
         for m := 1 to NbreModele do
               for i := 0 to pred(nmes) do
                   if (i<debut[1]) or (i>fin[1]) then
                       valeurTheorique[m,i] := Nan
      end;
      for m := 1 to NbreModele do with fonctionTheorique[m] do
          if coeffSI<>1 then for i := 0 to pred(nmes) do
             valeurTheorique[m,i] := valeurTheorique[m,i]/coeffSI;
      remplitVarLisse;
end end; // completeValTh

var sauveValeurParam,ValeurParamInit : tableauParam;
    avecMessage : boolean;

Function EffectueLevenbergMarquardt : boolean;
const  Maxi_i1 = 32; // time out
var i1 : integer;
    k : integer;
begin with pages[pageCourante] do begin
    Lambda := 1e-3; // calcul quasi Gauss Newton
    i1 := 0;
    result := false;
    repeat
        inc(i1);
        Jprecedent := J;
        chi2Precedent := chi2;
        calculPrecision;
        for k := 1 to NbreParam[paramNormal] do
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]+incParam[k])
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]+incParam[k];
        CalculJ(true);
        if erreurParam then begin
           if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        if diverge or ErreurCalcul
           then begin // retour en arrière
               for k := 1 to NbreParam[paramNormal] do
                   if paramInverse[k]
                      then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]-incParam[k])
                      else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]-incParam[k];
               // on tend vers méthode du gradient
               if Lambda<LambdaMax
                  then Lambda := 10*Lambda
                  else exit;
               CalculJ(true);
               stable := false;
               inc(i1);
           end
           else if Lambda>LambdaMin then // on tend vers Méthode de Gauss Newton
                Lambda := Lambda/10;
        PostMessage(Handle,WM_Reg_Modele,i1,0);
        Application.ProcessMessages; { pour mise à jour }
    until (i1>Maxi_i1) or stable;
    if diverge then begin
        ValeurParam[paramNormal] := sauveValeurParam;
        if not stable then begin
            afficheErreur(erDivergence,HELP_DivergenceduneModelisation);
            exit;
        end;
    end;
    if (i1>Maxi_i1) and avecMessage then afficheErreur(erTimeOut,HELP_Timeout);
    result := true;
end end; // LevenbergMarquardt

Function EffectueGaussNewton : boolean;
const
    Maxi_i1 = 32; // time out
    Maxi_i2 = 6; // µ mini =(1/2)^7=1%
var k : integer;
    i1,i2 : integer;
    mu : double;
// boucle de recherche par méthode gradient-Newton
begin with pages[pageCourante] do begin
    i1 := 0;
    Lambda := 0;
    result := false;
    repeat
        inc(i1);
        Jprecedent := J;
        chi2Precedent := chi2;
        calculPrecision;
        if erreurCalcul then begin
           if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        for k := 1 to NbreParam[paramNormal] do
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]+incParam[k])
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]+incParam[k];
        CalculJ(true);
        if erreurParam then begin
           if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        mu := 1;i2 := 0;
        while (Diverge or ErreurCalcul) and (i2<Maxi_i2) do begin
        inc(i2);
        mu := mu/2;
        for k := 1 to NbreParam[paramNormal] do
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]-incParam[k]*mu)
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]-incParam[k]*mu;
        CalculJ(false);
        end; // while diverge
        if diverge and (stable or (i1<=1)) then begin
         ValeurParam[paramNormal] := sauveValeurParam;
         calculJ(not stable); // calcul dans l'état initial
         diverge := false;
         stable := true;
         i2 := 0;
        end;
        if erreurCalcul or erreurParam or diverge
           then begin
              ValeurParam[paramNormal] := sauveValeurParam;
              if withMessage then if erreurCalcul or erreurParam
                 then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_EcartModelisationExperience)
                 else afficheErreur(erDivergence,HELP_DivergenceduneModelisation);
               exit;
           end
           else sauveValeurParam := ValeurParam[paramNormal];
        if (i2>0) and not stable then begin
           inc(i1); // prise en compte du temps de calcul du retour en arrière
           calculJ(true);
        end;
        if not stable then begin
         PostMessage(Handle,WM_Reg_Modele,i1,0);
         Application.ProcessMessages; // pour mise à jour de l'affichage
        end;
    until (i1>Maxi_i1) or stable;
    if (i1>Maxi_i1) and avecMessage then afficheErreur(erTimeOut,HELP_Timeout);
    result := true;
end end;

var iParam,iModele,iRecuit,iRecuitMax : integer;
    i,l : integer;
//label finProc; // effectueModele
begin with pages[pageCourante] do begin
// boucle de recherche par méthode gradient-Newton 
    ModeleCalcule := false;
    ModeleErrone := true;
    if not InitCalculJ then exit;
    CalculJ(ajuste);
    if erreurCalcul or ErreurParam then begin
       if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
       exit;
    end;
    if recuit and ajuste then iRecuitMax := 6 else iRecuitMax := 1;
    sauveValeurParam := ValeurParam[paramNormal];
    ValeurParamInit := ValeurParam[paramNormal];
    iRecuit := 1;
    while iRecuit<=iRecuitMax do begin
       avecMessage := (iRecuit=iRecuitmax);
       if ajuste
          then if LevenbergMarquardt
             then modeleErrone := not EffectueLevenbergMarquardt
             else modeleErrone := not EffectueGaussNewton
          else modeleErrone := false;
       inc(iRecuit);
       if modeleErrone then exit;
       if (iRecuit<=iRecuitMax) and (PrecisionModele[1]>0.2) then begin
              ValeurParam[paramNormal] := ValeurParamInit;
              for iModele := 1 to NbreModele do with fonctionTheorique[iModele] do
                  if IsSinusoide
                     then begin
                         valeurParam[paramNormal,amplitude] := valeurParam[paramNormal,amplitude]*(0.5+random);
                         valeurParam[paramNormal,Phase] := (random*2-1)*AngleUtilisateur(pi);
                         if (periodeOuFrequence<>grandeurInconnue) then
                             valeurParam[paramNormal,PeriodeOuFrequence] :=
                                        valeurParam[paramNormal,PeriodeOuFrequence]*(0.5+random);
                     end
                     else for iParam := 1 to NbreParam[paramNormal] do
                             if ParamToIndex(paramNormal,iparam) in fonctionTheorique[iModele].depend then
                                valeurParam[paramNormal,iparam] := valeurParam[paramNormal,iparam]*(0.25+4*random);
             CalculJ(ajuste);
             if erreurCalcul or ErreurParam then begin
                  ValeurParam[paramNormal] := ValeurParamInit;
                  exit;
             end;
        end; // recuit
    end;
    calcIntersection;
    ParamAjustes := ajuste and stable;
    ModeleCalcule := true;
    CompleteValTh;
    for iModele := 1 to NbreModele do
        fonctionTheorique[iModele].calculResidu(iModele);
    if ajuste then begin
    for iModele := 1 to NbreModele do with fonctionTheorique[iModele] do
        if IsSinusoide then with pages[pageCourante] do begin
           if valeurParam[paramNormal,amplitude]<0 then begin
              valeurParam[paramNormal,amplitude] := -valeurParam[paramNormal,amplitude];
              valeurParam[paramNormal,Phase] := valeurParam[paramNormal,Phase]+
                                                AngleUtilisateur(pi);
           end;
           if (periodeOuFrequence<>grandeurInconnue) and
              (valeurParam[paramNormal,PeriodeOuFrequence]<0) then
// Période peut être commune à deux modèles donc ne modifier T qu'après
              if IsCosinus
                 then valeurParam[paramNormal,Phase] := -valeurParam[paramNormal,Phase]
                 else valeurParam[paramNormal,Phase] := -valeurParam[paramNormal,Phase]+
                                                         AngleUtilisateur(pi);
           valeurParam[paramNormal,Phase] := Atan2(MySin(valeurParam[paramNormal,Phase]),
                                                   MyCos(valeurParam[paramNormal,Phase]));
        end;
    for iModele := 1 to NbreModele do with fonctionTheorique[iModele] do
        if IsSinusoide and
           (periodeOuFrequence<>grandeurInconnue) then with pages[pageCourante] do
           valeurParam[paramNormal,PeriodeOuFrequence] := abs(valeurParam[paramNormal,PeriodeOuFrequence]);
end;
  if not chi2Actif then
      for i := 1 to NbreParam[paramNormal] do
      for l := 1 to NbreParam[paramNormal] do
          CovarianceParam[i,l] := 0
end end; // EffectueModele

Procedure TFgrapheVariab.CalcIntersection;

Procedure CalcIntersectionLineaire(i : integer);
var  St1,St2 : TStatistiqueDeuxVar;

procedure CalculLoc;
var elarg : double;
    S : double;
    coeffCov : double;
begin
    coeffCov := 2*(st2.Y0-st1.Y0)/power(st1.pente-st2.pente,3);
    elarg := sqrt(Student95(st1.Nbre-2)*Student95(st2.Nbre-2)); // à la louche : moyenne géométrique !
    pages[pageCourante].X_inter[i] := (st2.Y0-st1.Y0)/(st1.pente-st2.pente);
    pages[pageCourante].Y_inter[i] := (st1.pente*st2.Y0-st2.pente*st1.Y0)/(st1.pente-st2.pente);
    S := (sqr(st1.sigmaY0)+sqr(st2.sigmaY0))/sqr(st2.pente-st1.pente);  // terme en sigma X
    S := S+(sqr(st1.sigmaPente)+sqr(st2.sigmaPente))*sqr(st2.Y0-st1.Y0)/power(st1.pente-st2.pente,4); // terme en sigma pente
    S := S+(st1.covariancePenteY0+st2.covariancePenteY0)*coeffCov; // terme en covariance
    pages[pageCourante].sigmaX_inter[i] := elarg*sqrt(S); // élargissement
    S := (sqr(st1.pente*st2.sigmaY0)+sqr(st2.pente*st1.sigmaY0))/sqr(st1.pente-st2.pente); // terme en sigma Y
    S := S+sqr(st1.Y0-st2.Y0)*(sqr(st2.pente*st1.sigmaPente)+sqr(st1.pente*st2.sigmaPente))/power(st1.pente-st2.pente,4); // terme en sigma X
    S := S+(sqr(st2.pente)*st1.covariancePenteY0+sqr(st1.pente)*st2.covariancePenteY0)*coeffCov; // terme en covariance
    pages[pageCourante].sigmaY_inter[i] := elarg*sqrt(S);
end;

function CalculLocChi2 : boolean;
var elarg : double;
    S : double;
    Pente1G,Pente2G,Origine1G,Origine2G : integer;
    Pente1,Pente2,Y01,Y02 : double;
    sigmaPente1,sigmaPente2,sigmaY01,sigmaY02 : double;
    covariance1,covariance2 : double;
    coeffCov,coeffY0 : double;
begin
    result := false;
    try
    fonctionTheorique[i].cherchePenteOrigine(pente1G,origine1G);
    if (pente1G=0) or (origine1G=0) then exit;
    fonctionTheorique[i-1].cherchePenteOrigine(pente2G,origine2G);
    if (pente2G=0) or (origine2G=0)  then exit;
    with pages[pageCourante] do begin
         pente1 := valeurParam[paramNormal,pente1G];
         pente2 := valeurParam[paramNormal,pente2G];
         Y01 := valeurParam[paramNormal,Origine1G];
         Y02 := valeurParam[paramNormal,Origine2G];
         sigmapente1 := incertParam[pente1G];
         sigmapente2 := incertParam[pente2G];
         sigmaY01 := incertParam[Origine1G];
         sigmaY02 := incertParam[Origine2G];
         covariance1 := covarianceParam[pente1G,origine1G];
         covariance2 := covarianceParam[pente2G,origine2G]; // trop grandes ?
    end;
    coeffCov := 2*(Y02-Y01)/power(pente1-pente2,3);
    coeffY0 := sqr(Y02-Y01)/power(pente1-pente2,4);
    elarg := sqrt(Student95(fonctionTheorique[i].nbrePointsModele)*
                  Student95(fonctionTheorique[i].nbrePointsModele)); // à la louche !
    pages[pageCourante].X_inter[i] := (Y02-Y01)/(pente1-pente2);
    pages[pageCourante].Y_inter[i] := (pente1*Y02-pente2*Y01)/(pente1-pente2);
    S := (sqr(sigmaY01)+sqr(sigmaY02))/sqr(pente2-pente1);
    S := S+(sqr(sigmaPente1)+sqr(sigmaPente2))*coeffY0;
    S := S+(covariance1+covariance2)*coeffCov;
    pages[pageCourante].sigmaX_inter[i] := elarg*sqrt(S);
    S := (sqr(pente1*sigmaY02)+sqr(pente2*sigmaY01))/sqr(pente1-pente2);
    S := S+(sqr(pente2*sigmaPente1)+sqr(pente1*sigmaPente2))*coeffY0;
    S := S+(sqr(pente2)*covariance1+sqr(pente1)*covariance2)*coeffCov;
    pages[pageCourante].sigmaY_inter[i] := elarg*sqrt(S);
    result := true;
    except
         pages[pageCourante].X_inter[i] := Nan;
         pages[pageCourante].Y_inter[i] := Nan;
    end;
end;

begin with pages[pageCourante] do begin
    if chi2Actif and calculLocChi2 then exit;
    st1 := TStatistiqueDeuxVar.Create;
    st2 := TStatistiqueDeuxVar.Create;
    try
    with fonctionTheorique[i] do
         st1.Init(valeurVar[indexX],valeurVar[indexY],debut[i],fin[i]);
    with fonctionTheorique[i-1] do
         st2.Init(valeurVar[indexX],valeurVar[indexY],debut[i-1],fin[i-1]);
    calculLoc;
    finally
    st1.free;
    st2.free;
    end;
end end;

var i,iX : integer;
    posDebut,posFin : integer;
begin with pages[pageCourante] do begin
   if isModeleSysteme and (fonctionTheorique[1].genreC=g_fonction) then
   for i := 2 to NbreModele do
       if (fonctionTheorique[pred(i)].indexX=fonctionTheorique[i].indexX) and
          (fonctionTheorique[pred(i)].indexY=fonctionTheorique[i].indexY)
           then begin
              if fonctionTheorique[pred(i)].lineaire and
                 fonctionTheorique[i].lineaire then begin
                 CalcIntersectionLineaire(i);
                 continue;
              end;
              if fin[pred(i)]<debut[i]
                 then begin // (i-1) avant i
                      posDebut := fin[pred(i)]-1;
                      posFin := debut[i]+1;
                 end
                 else if fin[i]<debut[pred(i)]
                    then begin // i avant i-1
                        posDebut := fin[i]-1;
                        posFin := debut[pred(i)]+1;
                    end
                    else begin // zone commune
                        if debut[i]>debut[pred(i)]
                           then posDebut := debut[i]-1
                           else posDebut := debut[pred(i)]-1;
                        if fin[i]>fin[pred(i)]
                           then posFin := fin[pred(i)]+1
                           else posFin := fin[i]+1;
                    end;
              while (posFin-posDebut)<5 do begin
                  dec(posDebut);
                  inc(posFin);
              end;
              if posDebut<0 then posDebut := 0;
              if posFin>=nmes then posFin := pred(nmes);                   
              iX := fonctionTheorique[i].indexX;
              try
              Dichotomie(pageCourante,iX,
                 fonctionTheorique[pred(i)].calcul,fonctionTheorique[i].calcul,
                 valeurVar[iX,posDebut],valeurVar[iX,posFin],
                 Y_inter[i],X_inter[i]);
              sigmaX_inter[i] := 0;
              sigmaY_inter[i] := 0;
              except;
                 Y_inter[i] := Nan;
                 X_inter[i] := Nan
              end;
           end
           else begin
                Y_inter[i] := Nan;
                X_inter[i] := Nan
           end;
end end; // calcIntersection

Procedure TFgrapheVariab.CompileModele(var PosErreur,LongErreur : integer);
Type TypeLigne = (LCommentaire,LModele,Lsuperpose);
var posErreurLigne : integer;
    LigneCourante : string;
    i : integer;

Function TypeDeLigne : TypeLigne;
var PosEgal : integer;
    index : integer;
    NomLu : string;
begin
    result := Lcommentaire;
    if IsLigneComment(LigneCourante) then exit;
    if pos(':=',LigneCourante)>0 then begin
       result := Lsuperpose;
       exit;
    end;
    PosEgal := Pos('=',ligneCourante);
    if PosEgal=0 then begin
       codeErreurC := erEgalAbsent;
       exit;
    end;
    nomLu := copy(ligneCourante,1,pred(posEgal));// extrait le nom
    trimComplet(nomLu);
    index := indexToParam(paramNormal,IndexNom(nomLu));
    if index=grandeurInconnue
       then result := Lmodele
end;

Procedure CompileModelisation;
var iY : integer;
begin
    if NbreModele<maxIntervalles
       then begin
            inc(NbreModele);
            trimComplet(LigneCourante);
            with fonctionTheorique[NbreModele] do begin
                 LigneMemo := i;
                 compileM(LigneCourante,posErreurLigne,longErreur);
                 if (pos('PI', UpperCase(ligneCourante))>0) or
                    (pos(PiMin, ligneCourante)>0) or
                    (pos(omegaMin, ligneCourante)>0) then
                       Fvaleurs.passageEnRadian(false);
            end;
            if ModifInverse then exit;
            if NbreModele>1 then begin
                 if fonctionTheorique[1].GenreC<>fonctionTheorique[NbreModele].GenreC then
                      IsModeleSysteme := false;
                 if (codeErreurC='') and
                    (fonctionTheorique[1].GenreC in [g_diff1,g_diff2]) and
                    (fonctionTheorique[1].indexY=fonctionTheorique[NbreModele].indexY) then
                      IsModeleSysteme := false;
            end;
            with pages[pageCourante] do begin
                 iY := fonctionTheorique[nbreModele].indexY;
                 if (debut[NbreModele]=0) and
                    (iY<>grandeurInconnue) and
                    isNan(valeurVar[iY,0])
                    then debut[NbreModele] := 1;
                 if (fin[NbreModele]=pred(nmes)) and
                    (iY<>grandeurInconnue) and
                    isNan(valeurVar[iY,pred(nmes)])
                    then fin[NbreModele] := nmes-2;
            end;
       end
       else begin
           codeErreurC := erMaxModele;
           posErreurLigne := 0;
       end;
end; // CompileModelisation

Procedure CompileSuperposition;
var iY : integer;
begin
     if NbreFonctionSuper<maxIntervalles
        then begin
            inc(NbreFonctionSuper);
            trimComplet(LigneCourante);
            fonctionSuperposee[NbreFonctionSuper].compileM(
                LigneCourante,posErreurLigne,longErreur);
            if (codeErreurC='') and
               not(fonctionSuperposee[NbreFonctionSuper].GenreC in [g_fonction,g_equation])
                   then codeErreurC := erGenreModele;
            iY := fonctionSuperposee[NbreFonctionSuper].indexY;
            if  uniteSIGlb and (grandeurs[iY].fonct.genreC=G_experimentale)
               then fonctionSuperposee[NbreFonctionSuper].coeffSI := grandeurs[iY].coeffSI
               else fonctionSuperposee[NbreFonctionSuper].coeffSI := 1;
        end
        else begin
             codeErreurC := erMaxModele;
             posErreurLigne := 0;
        end;
end; // CompileSuperposition

var m,iMod,jMod,jParam : integer;
    dependI,dependJ,dependInter : TsetGrandeur;
begin
    IsModeleSysteme := true;
    exclude(etatModele,ModeleDefini);
    for i := 1 to maxParametres do begin
        paramInverse[i] := false;
        inversePermis[i] := true;
    end;
    codeErreurC := '';
    modifInverse := false;
    i := 0;
    while i<MemoModele.Lines.count do begin
        LigneCourante := memoModele.Lines[i];
        case TypeDeLigne of
            Lcommentaire : ;
            Lmodele : compileModelisation;
            Lsuperpose : compileSuperposition;
        end;
        if codeErreurC=''
           then posErreur := posErreur + length(LigneCourante) + 2 { 2=CR+LF }
           else begin
                posErreur := posErreur + posErreurLigne;
                break;
           end;
     if modifInverse
         then begin
             i := 0;
             codeErreurC := '';
             NbreModele := 0;
             NbreFonctionSuper := 0;
             modifInverse := false;
         end
         else begin
             inc(i);
             for jParam := 1 to NbreParam[ParamNormal] do
                if not paramInverse[jParam] then inversePermis[jParam] := false;
         end;
    end; // while i
 // recompiler les modéles si modifInverse
    if codeErreurC=''
        then begin
           TexteModele.Clear;
           for i := 0 to pred(MemoModele.Lines.count) do
               TexteModele.Add(MemoModele.Lines[i]);
           for m := 1 to NbreModele do with fonctionTheorique[m] do begin
               NbreParamModele := 0;
               for i := 1 to NbreParam[paramNormal] do
                   if ParamToIndex(paramNormal,i) in depend then
                      inc(NbreParamModele);
           end;
           if NbreModele>0
              then include(etatModele,ModeleDefini)
              else include(etatModele,PasDeModele);
           if NbreFonctionSuper>0 then include(etatModele,SimulationDefinie);
           { TODO :  rechercher si y ne dépend que de x } 
        end
        else afficheErreur(codeErreurC,0);
    for i := 1 to 3 do
        include(Graphes[i].Modif,gmModele);
    modeleDependant := false;
    for iMod := 1 to NbreModele do
        for jMod := succ(iMod) to NbreModele do begin
            dependI := fonctionTheorique[iMod].depend;
            dependJ := fonctionTheorique[jMod].depend;
            dependInter := dependI * dependJ;
            modeleDependant := modeleDependant or (dependInter<>[]);
        end;
end; // CompileModele

Procedure TFgrapheVariab.ConstruitModele;

Procedure ConstruitFonction(m : TcodeIntervalle);
var l,k : integer;
    dependPossible : TsetGrandeur;
begin with fonctionTheorique[m] do begin
     lineaire := true; // par défaut
     DeriveeForm(fonctionTheorique[m],
             grandeurs[indexX],fchi2,dependPossible);
     if not avecChi2 then libere(fchi2);
     lineaireVar := not(indexX in dependPossible);
     for k := 1 to NbreParam[paramNormal] do begin
         DeriveeForm(fonctionTheorique[m],Parametres[paramNormal,k],
            derf[m,k],dependPossible);
        {$IFDEF DEBUG}
        //      AfficheErreur(TranslateExpression(derf[m,k]),0);
        {$ENDIF}
         if ParamToIndex(paramNormal,k) in fonctionTheorique[m].depend then
            isOrigine[k] := derf[m,k]=PointeurUn;
         for l := 1 to NbreParam[paramNormal] do
             if ParamToIndex(paramNormal,l) in dependPossible then begin
               exclude(etatModele,modeleLineaire);
               lineaire := false;
             end;
     end; // for k
end end; // ConstruitFonction

procedure ConstruitDiff(m : TcodeIntervalle);
// pour dérivée seconde ou première : y'=f(y,x,a,b,c) ou y''=f(y,y',x,a,b,c)
var
   derf_y,derf_yprime : Pelement; // df/dy' et df/dy
   l : integer;
   dependDer : TsetGrandeur;
   second : boolean;
begin
    exclude(etatModele,modeleLineaire);
    with fonctionTheorique[m] do begin
         lineaire := false;
         lineaireVar := false;
         derf_y := nil;derf_yprime := nil;
         second := genreC=g_diff2;
         libere(fchi2);
         DeriveeForm(fonctionTheorique[m],addrY,derf_y,dependDer);
         if second then
             DeriveeForm(fonctionTheorique[m],addrYp,derf_yprime,dependDer);
         for l := 1 to NbreParam[paramNormal] do begin
             DeriveeForm(fonctionTheorique[m],Parametres[paramNormal,l],derf[m,l],dependDer);
             if second
                then construire2(derf_y,derf_yprime,derf[m,l],l)
                else construire1(derf_y,derf[m,l],l);
             if Parametres[paramNormal,l]=fonctionTheorique[m].calcul^.varx
                then derf[m,l].valeurGlb := 1
                else derf[m,l].valeurGlb := 0;
             if Parametres[paramNormal,l]=fonctionTheorique[m].calcul^.vary
                  then derf[m,l].valeurInitDer := 1
                  else derf[m,l].valeurInitDer := 0;
//  valeur initiale fonction et dérivée nulle sauf pour
//  y0 : fonction=1 ;  y'0 : dérivée=1 
    end;// for l
    end;// with
    libere(derf_y);
    libere(derf_yprime);
end; // ConstruitDiff

procedure ConstruitEquation(m : TcodeIntervalle);
// pour équation f(y,x,a,b,c)=0
var
   derf_y : Pelement; { df/dy }
   l : integer;
   dependDer : TsetGrandeur;
begin
    exclude(etatModele,modeleLineaire);
    with fonctionTheorique[m] do begin
         lineaire := false;
         lineaireVar := false;
         derf_y := nil;
         libere(fchi2);
         DeriveeForm(fonctionTheorique[m],addrY,derf_y,dependDer);
         for l := 1 to NbreParam[paramNormal] do begin
              DeriveeForm(fonctionTheorique[m],Parametres[paramNormal,l],derf[m,l],dependDer);
              construireEquation(derf_y,derf[m,l]);
         end; // for l
    end;// with
    libere(derf_y);
end; // ConstruitEquation

Procedure VerifierGraphe;
var iPrinc,iTop,i : integer;
    CoordOK : boolean;
    m : integer;
begin
     coordOK := false;
     for i := 1 to 3 do if graphes[i].paintBox.visible then
     with fonctionTheorique[1],graphes[i] do coordOK := coordOK or
              ( (grandeurs[indexX].nom=coordonnee[1].nomX) and
                (grandeurs[indexY].nom=coordonnee[1].nomY) ) or
              ( (grandeurs[indexX].nom=coordonnee[1].nomY) and
                (grandeurs[indexY].nom=coordonnee[1].nomX) );
     if not CoordOK and (NbreModele>1) then
        for i := 1 to 3 do if graphes[i].paintBox.visible then
            with graphes[1] do coordOK := coordOK or
            ((grandeurs[fonctionTheorique[1].indexY].nom=coordonnee[1].nomX) and
              (grandeurs[fonctionTheorique[2].indexY].nom=coordonnee[1].nomY)) or
            ((grandeurs[fonctionTheorique[2].indexY].nom=coordonnee[1].nomX) and
              (grandeurs[fonctionTheorique[1].indexY].nom=coordonnee[1].nomY));
     if not CoordOK and OKReg(OkModifGr,0) then begin
         for i := 2 to maxOrdonnee do with Graphes[1].Coordonnee[i] do begin
            nomY := '';
            nomX := '';
            iMondeC := MondeY;
         end;
         with fonctionTheorique[1] do begin
              Graphes[1].coordonnee[1].nomX := grandeurs[indexX].nom;
              Graphes[1].Coordonnee[1].nomY := grandeurs[indexY].nom;
         end;
         iPrinc := 1;iTop := 0;
         for m := 2 to NbreModele do with fonctionTheorique[m] do
             if (grandeurs[indexX].nom=Graphes[1].Coordonnee[1].nomX)
                then begin
                    if (grandeurs[indexY].nom<>Graphes[1].Coordonnee[1].nomY)
                       then begin
                           inc(iPrinc);
                           Graphes[1].Coordonnee[iPrinc].nomX := grandeurs[indexX].nom;
                           Graphes[1].Coordonnee[iPrinc].nomY := grandeurs[indexY].nom;
                       end;
                end
                else if iTop=0
                     then begin
                         for i := 2 to maxOrdonnee do with Graphes[2].Coordonnee[i] do begin
                             nomX := '';
                             nomY := '';
                             iMondeC := MondeY;
                         end;
                         iTop := 1;
                         Graphes[2].Coordonnee[1].nomY := grandeurs[indexY].nom;
                         Graphes[2].Coordonnee[1].nomX := grandeurs[indexX].nom;
                     end
                     else if (grandeurs[indexX].nom=Graphes[2].Coordonnee[1].nomX)
                           and (grandeurs[indexY].nom<>Graphes[2].Coordonnee[1].nomY)
                       then begin
                           inc(iTop);
                           Graphes[2].Coordonnee[iTop].nomY := grandeurs[indexY].nom;
                           Graphes[2].Coordonnee[iTop].nomX := grandeurs[indexX].nom;
                       end;
         for i := 1 to 3 do begin
             include(Graphes[i].modif,gmModele);
             if graphes[i].PaintBox.visible then graphes[i].PaintBox.refresh;
         end;
   end; // not CoordOK
   for m := succ(NbreModele) to maxIntervalles do
       fonctionTheorique[m].VariableEgalAbscisse := false;
end; // VerifierGraphe

var m : TcodeIntervalle;
    l : integer;
    k : TcodePage;
begin
   if VerifGraphe then VerifierGraphe;
   VerifGraphe := true;
   for l := 1 to NbreParam[paramNormal] do isOrigine[l] := false;
   include(etatModele,modeleLineaire);
   for m := 1 to NbreModele do
   case fonctionTheorique[m].genreC of
      g_fonction : ConstruitFonction(m);
      g_diff1,g_diff2 : ConstruitDiff(m);
      g_equation : ConstruitEquation(m);
   end;
   setUniteParametre;
   for k := 1 to NbrePages do with Pages[k] do begin
        ParamAjustes := false;
        ModeleCalcule := false;
        ModeleErrone := false;
        for m := 1 to NbreModele do
            for l := 0 to pred(NmesMax) do
                valeurTheorique[m,l] := Nan;
   end; // for page[k]
   include(etatModele,ModeleConstruit);
   for m := 1 to NbreModele do with fonctionTheorique[m] do
       VariableEgalAbscisse := grandeurs[indexX]=graphes[1].Monde[mondeX].axe;
end; // construitModele

