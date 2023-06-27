// modeleMono.pas include de graphvar

Procedure TFgrapheVariab.EffectueModeleMono(m : integer);
const LambdaMin = 1e-4;
      LambdaMax = 1e4;
var Lambda : double;
    diverge,stable : boolean;
    dependM : TsetGrandeur;

// boucle de recherche par méthode gradient-Newton
var
   J,Jprecedent,chi2Precedent : double;
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
  for i := 1 to NbreParam[paramNormal] do
     for k := 1 to NbreParam[paramNormal] do
         U[i,k] := 0;
  for i := 1 to NbreParam[paramNormal] do
  if i in dependM then begin
     v := der2J[i,i]*(1+Lambda);
     try
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for l := succ(i) to NbreParam[paramNormal] do begin
         v := der2J[l,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,l];
         U[i,l] := v/U[i,i];
     end;
     except
        for l := 1 to NbreParam[paramNormal] do begin
             U[i,l] := 0;
             U[l,i] := 0;
             der2J[l,i] := 0;
             der2J[i,l] := 0;
        end
      end
  end;
  for i := 1 to NbreParam[paramNormal] do
      for k := 1 to NbreParam[paramNormal] do
          invDer2J[i,k] := 0;
end;// construireU

procedure resoudreU(l : TcodeParam);
var i,k : integer;
    Y   : TableauParam;
    v   : double;
begin
    for i := 1 to NbreParam[paramNormal] do
    if i in dependM then
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
     for i := NbreParam[paramNormal] downto 1 do
     if i in dependM then begin
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

var sigmaLoc : double;
    i,l : integer;
begin // calculPrecision
with pages[pageCourante],fonctionTheorique[m] do begin
  construireU;
  erreurCalcul := false;
  for i := 1 to NbreParam[paramNormal] do
      if i in dependM then resoudreU(i);
  for i := 1 to NbreParam[paramNormal] do if i in dependM then begin
     try
     if Chi2Actif
        then sigmaLoc := 1
        else sigmaLoc := sigmaY;
     incertParam[i] := sqrt(invDer2j[i,i])*sigmaLoc;
                                  { TODO : param coeffSI }
     if uniteSIglb then
        incertParam[i] := incertParam[i]/Parametres[paramNormal,i].coeffSI;
     if paramInverse[i] then
        incertParam[i] := incertParam[i]/sqr(parametres[paramNormal,i].valeurCourante);
     incert95Param[i] := incertParam[i]*student95(NbrePointsModele);
     incParam[i] := 0;
     for l := 1 to NbreParam[paramNormal] do
         incParam[i] := incParam[i] - invDer2J[l,i]*derJ[l];
     erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
     except
         incertParam[i] := Nan;
         incParam[i] := 0;
         incert95Param[i] := Nan;
     end;
  end; // for i
  if uniteSIglb then
     for i := 1 to NbreParam[paramNormal] do
         incParam[i] := incParam[i]/Parametres[paramNormal,i].coeffSI; { TODO : coeffSI param }
  if chi2Actif then
  for i := 1 to NbreParam[paramNormal] do
      if i in dependM then
      for l := 1 to NbreParam[paramNormal] do
      if l in dependM then
         CovarianceParam[i,l] := invDer2J[i,l]
end end; // calculPrecision

function InitCalculJ : boolean;
// On calcule une valeur relative à l'étendue des mesures
var k : integer;
    i : integer;
    valeur : double;
begin with pages[pageCourante],fonctionTheorique[m] do begin
      InitCalculJ := false;
      if fin[m]<debut[m] then swap(fin[m],debut[m]);
      NbrePointsModele := succ(fin[m]-debut[m]);
      if (NbrePointsModele<NbreParamModele) then begin
           afficheErreur(erNombrePetit,0);
           exit;
      end;
      if chi2Permis
         then Chi2Actif := avecChi2
         else begin
              Chi2Actif := false;
              if avecChi2 then  begin
                 avecChi2 := false;
                 incertChi2Item.checked := false;
              end;
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
         ((grandeurs[indexY].fonct.genreC=G_experimentale)
 //         or ((grandeurs[indexY].fonct.genreC=G_fonction) and grandeurs[indexY].prefixeImpose)  /// new
         )
          then begin
               coeffSI := grandeurs[indexY].coeffSI;
               sommeCarreY := sommeCarreY*sqr(coeffSI);
          end
          else coeffSI := 1;
      jPrecedent := 2*sommeCarreY;
      chi2Precedent := NbrePointsModele*100.0;
   for k := 1 to MaxParametres do
       if k in dependM
          then incertParam[k] := Nan;
   InitCalculJ := (SommeCarreY>1E-22*nmes);
end end; // initCalculJ

procedure CalculJ;
// calcul de J; avecDerivee => calcul derj,der2j

var Y : TMatriceVecteur;

procedure calculFonction;
var i : integer;
    k1 : integer;
    z : double;
begin with pages[pageCourante],fonctionTheorique[m] do begin
    setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
    for i := debut[m] to fin[m] do
        if getPointActif(i) then begin
        AffecteVariableE(i);
        try
        z := calcule(calcul);
        if isNan(z)
           then EMathError.Create(erCalcul)
           else valeurTheorique[m,i] := z;
        for k1 := 1 to NbreParam[paramNormal] do begin
            z := calcule(derf[m,k1]);
            if isNan(z)
               then EMathError.Create(erCalcul)
               else Y[m,k1,i] := z;
        end;
        if Chi2Actif and (fchi2<>nil) and (incertVar[indexX]<>nil)
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
end end;// calculFonction

procedure calculLoc;
var k1,k2 : integer;
    i : integer;
    ValDerf : TableauParam;// valeur de la dérivée première
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
    CoeffChi2 : double;
    dy,dt : double;
begin with pages[pageCourante],fonctionTheorique[m] do begin
    try
        for i := debut[m] to fin[m] do
            if getPointActif(i) then begin
            if posErreurModele=i then continue;
            if uniteSIGlb
               then Ecart := valeurTheorique[m,i]-valeurVar[indexY,i]*coeffSI
               else Ecart := valeurTheorique[m,i]-grandeurs[indexY].valeur[i];
            J := J + sqr(ecart);
            if Chi2Actif then begin
                     try
                     dy := incertVar[indexY,i]*coeffSI;
                     if isNan(dy) then dy := 0;
                     try
                     dt := incertVar[indexX,i];
                     if uniteSIglb then dt := dt*grandeurs[indexX].coeffSI;
                     if isNan(dt)
                        then dt := 0
                        else dt := dt*valeurDeriveeX[m,i];
                     except
                        dt := 0;
                     end;
                     coeffChi2 := 1/(sqr(dy)+sqr(dt));
                     except
                       try
                       coeffChi2 := 1e6/sqr(grandeurs[indexY].valeur[i]);
                       // on force une incertitude de 0,1%
                       except
                          coeffChi2 := 0;
                       end;
                     end;
                     chi2[m] := chi2[m] + coeffChi2*sqr(ecart);
            end // chi2Actif
            else coeffChi2 := 1;
            for k1 := 1 to NbreParam[paramNormal] do
            if k1 in dependM then begin
                valDerf[k1] := Y[m,k1,i];
                derj[k1] := derj[k1]+coeffChi2*Ecart*valDerf[k1];
                for k2 := 1 to k1 do
                    der2j[k1,k2] := der2j[k1,k2]+coeffChi2*valDerf[k2]*valDerf[k1]; // *2 ??
            end
            else valDerf[k1] := 0;
        end;// for i
    except
          erreurParam := true
    end;
end end;// calculLoc

procedure calculDiff2;
var i : integer;
begin with pages[pageCourante] do begin
    genereLisseP(fonctionTheorique[m].indexYp);
    setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
    for i := 0 to NmesMax do ValeurDeriveeX[m,i] := 0;
    SystemeDiff2(derf,Y,m,m)
end end; // calculDiff2

procedure calculDiff1;
var i : integer;
begin with pages[pageCourante] do begin
    setTailleVecteur(ValeurDeriveeX[m],NmesMax+1);
    for i := 0 to NmesMax do ValeurDeriveeX[m,i] := 0;
    SystemeDiff1(derf,Y,m,m)
end end; // calculDiff1

Const
      PrecisionAbsolueJ = 0.001;
      PrecisionRelativeJ = 0.001;
      PrecisionRelativeChi2 = 0.001;
      PrecisionZero = 0.0000001; // prise en compte erreur arrondi dans comparaison à zéro
      PrecisionAbsolueChi2 = 0.1; // chi2 / (N-p) <0.1
var k1,k2 : integer;
    DeltaJ : double;
begin // calculJ
with pages[pageCourante],fonctionTheorique[m] do begin
// Initialisation
   AffecteConstParam(true);
   AffecteVariableP(false);
   erreurCalcul := false;
   erreurParam := false;
   J := 0;
   chi2[m] := 0;
   ErreurModele := false;
   PosErreurModele := -1;
   for k1 := 1 to NbreParam[paramNormal] do begin
       derJ[k1] := 0;
       for k2 := 1 to NbreParam[paramNormal] do
           der2j[k1,k2] := 0;
   end;// for k1
   for k1 := 1 to NbreParam[paramNormal] do
       setTailleVecteur(y[m,k1],NmesMax+1);
   try
   case genreC of
        g_fonction,g_equation : calculFonction;
        g_diff1 : calculDiff1;
        g_diff2 : calculDiff2;
   end;
   except
       on E : exception do begin
          derniereErreur := E.message;
          erreurCalcul := true;
       end;
   end;
   if not erreurCalcul then CalculLoc;
   for k1 := 1 to NbreParam[paramNormal] do
       y[m,k1] := nil;
   PrecisionModele[m] := sqrt(J/SommeCarreY);
   if Chi2Actif
           then begin
              chi2Relatif := chi2[m]/NbrePointsModele;
              DeltaJ := chi2[m]-chi2Precedent;
              Stable := (abs(DeltaJ)<(chi2Precedent*PrecisionRelativeChi2)) or
                        (chi2[m]<(NbrePointsModele*PrecisionAbsolueChi2));
              Diverge := DeltaJ>chi2[m]*PrecisionZero;
           end
           else begin
              sigmaY := sqrt(J/NbrePointsModele);
              DeltaJ := J-Jprecedent;
              Diverge := DeltaJ>J*PrecisionZero;
              Stable := (abs(DeltaJ)<(Jprecedent*PrecisionRelativeJ)) or
                        (PrecisionModele[m]<PrecisionAbsolueJ);
           end;
end end; // calculJ

procedure completeValTh;
var i : integer;
begin
   if (OmExtrapole in Graphes[1].optionModele) and
       pages[pageCourante].ModeleCalcule then with pages[pageCourante] do begin
      if isModeleSysteme and
         (fonctionTheorique[m].genreC in [g_fonction,g_equation]) then begin
              for i := 0 to pred(nmes) do
                  if (i<debut[m]) or (i>fin[m]) then begin
                     AffecteVariableE(i);
                     valeurTheorique[m,i] := calcule(fonctionTheorique[m].calcul);
                  end;// calculPoint
      end // g_fonction
      else begin
           for i := 0 to pred(nmes) do
               if (i<debut[1]) or (i>fin[1]) then
                   valeurTheorique[m,i] := Nan
      end;
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
        chi2Precedent := chi2[m];
        calculPrecision;
        for k := 1 to NbreParam[paramNormal] do if k in dependM then
               if paramInverse[k]
                  then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]+incParam[k])
                  else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]+incParam[k];
        CalculJ;
        if erreurParam then begin
           MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        if diverge or ErreurCalcul
           then begin // retour en arrière
               for k := 1 to NbreParam[paramNormal] do if k in dependM then
                   if paramInverse[k]
                      then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]-incParam[k])
                      else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]-incParam[k];
               // on tend vers méthode du gradient
               if Lambda<LambdaMax
                  then Lambda := 10*Lambda
                  else exit;
               CalculJ;
               stable := false;
               inc(i1);
           end
           else if Lambda>LambdaMin then // on tend vers Méthode de Gauss Newton
                Lambda := Lambda/10;
        PostMessage(Handle,WM_Reg_Modele,i1,0);
        Application.ProcessMessages; // pour mise à jour
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
    calculPrecision;
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
        chi2Precedent := chi2[m];
        calculPrecision;
        if erreurCalcul then begin
           MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        for k := 1 to NbreParam[paramNormal] do if k in dependM then
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]+incParam[k])
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]+incParam[k];
        CalculJ;
        if erreurParam then begin
           MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
      mu := 1;i2 := 0;
      while (Diverge or ErreurCalcul) and (i2<Maxi_i2) do begin
        inc(i2);
        mu := mu/2;
        for k := 1 to NbreParam[paramNormal] do if k in dependM then
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]-incParam[k]*mu)
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]-incParam[k]*mu;
        CalculJ;
      end; // while diverge
      if diverge and (stable or (i1<=1)) then begin
         ValeurParam[paramNormal] := sauveValeurParam;
         calculJ; // calcul dans l'état initial
         diverge := false;
         stable := true;
      end;
      if erreurCalcul or erreurParam or diverge
           then begin
              ValeurParam[paramNormal] := sauveValeurParam;
              if erreurCalcul or erreurParam
                 then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_EcartModelisationExperience)
                 else afficheErreur(erDivergence,HELP_DivergenceduneModelisation);
               exit;
           end
           else sauveValeurParam := ValeurParam[paramNormal];
      if not stable then begin
         PostMessage(Handle,WM_Reg_Modele,i1,0);
         Application.ProcessMessages; // pour mise à jour de l'affichage
      end;
    until (i1>Maxi_i1) or stable;
    if (i1>Maxi_i1) and avecMessage then afficheErreur(erTimeOut,HELP_Timeout);
    result := true;
    calculPrecision;
end end; // EffectueGaussNewton

var iParam,iRecuit,iRecuitMax : integer;
    i,l : integer;
begin // effectueModele
with pages[pageCourante],fonctionTheorique[m] do begin
    dependM := [];
    for iParam := 1 to NbreParam[paramNormal] do
        if ParamToIndex(paramNormal,iParam) in depend then include(dependM,iParam);
// boucle de recherche par méthode gradient-Newton
    ModeleCalcule := false;
    ModeleErrone := true;
    if not InitCalculJ then exit;
    CalculJ;
    if erreurCalcul or ErreurParam then begin
       MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HELP_ErreurdeDomainedeDefinition);
       exit;
    end;
    if recuit then iRecuitMax := 6 else iRecuitMax := 1;
    sauveValeurParam := ValeurParam[paramNormal];
    ValeurParamInit := ValeurParam[paramNormal];
    iRecuit := 1;
    while iRecuit<=iRecuitMax do begin
       avecMessage := (iRecuit=iRecuitmax);
       if LevenbergMarquardt
          then modeleErrone := not EffectueLevenbergMarquardt
          else modeleErrone := not EffectueGaussNewton;
       inc(iRecuit);
       if modeleErrone then exit;
       // random entre 0 et 1
       if (iRecuit<=iRecuitMax) and (PrecisionModele[1]>0.2) then begin
              ValeurParam[paramNormal] := ValeurParamInit;
              with fonctionTheorique[m] do
                  if IsSinusoide
                     then begin
                         valeurParam[paramNormal,amplitude] := valeurParam[paramNormal,amplitude]*(0.5+random);
                         valeurParam[paramNormal,Phase] := (random*2-1)*AngleUtilisateur(pi); // entre -pi et +pi
                         if (periodeOuFrequence<>grandeurInconnue) then
                             valeurParam[paramNormal,PeriodeOuFrequence] :=
                                        valeurParam[paramNormal,PeriodeOuFrequence]*(0.5+random); // entre 0,5 et 1,5
                     end
                     else for iParam := 1 to NbreParam[paramNormal] do if iparam in dependM then
                              if recuitFaible
                                 then valeurParam[paramNormal,iparam] := valeurParam[paramNormal,iparam]*(0.95+0.1*random) // +- 5%
                                 else valeurParam[paramNormal,iparam] := valeurParam[paramNormal,iparam]*(0.25+4*random); // entre 0.25 et 4
             CalculJ;
             if erreurCalcul or ErreurParam then begin
                  ValeurParam[paramNormal] := ValeurParamInit;
                  exit;
             end;
       end; // recuit
    end;
    ParamAjustes := stable;
    ModeleCalcule := true;
    CompleteValTh;
    calculResidu(m);
    if IsSinusoide then with pages[pageCourante] do begin
        if (amplitude in dependM) and
           (valeurParam[paramNormal,amplitude]<0) then begin
              valeurParam[paramNormal,amplitude] := -valeurParam[paramNormal,amplitude];
              valeurParam[paramNormal,Phase] := valeurParam[paramNormal,Phase]+
                                                AngleUtilisateur(pi);
        end;
        if (periodeOuFrequence<>grandeurInconnue) and
           (valeurParam[paramNormal,PeriodeOuFrequence]<0) then begin
// Période peut être commune à deux modèles donc ne modifier T qu'après
            if IsCosinus
               then valeurParam[paramNormal,Phase] := -valeurParam[paramNormal,Phase]
               else valeurParam[paramNormal,Phase] := -valeurParam[paramNormal,Phase]+
                                                         AngleUtilisateur(pi);
           valeurParam[paramNormal,Phase] := Atan2(MySin(valeurParam[paramNormal,Phase]),
                                                   MyCos(valeurParam[paramNormal,Phase]));
           valeurParam[paramNormal,PeriodeOuFrequence] := -valeurParam[paramNormal,PeriodeOuFrequence];
        end;
    end;
    if not chi2Actif then
       for i := 1 to NbreParam[paramNormal] do
       for l := 1 to NbreParam[paramNormal] do
           CovarianceParam[i,l] := 0
end end; // EffectueModeleMono


