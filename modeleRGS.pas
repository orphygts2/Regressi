{ modeleRGS.pas include de RGS_U }

Procedure TFRGS.EffectueModele(Ajuste,withMessage : boolean);
const LambdaMin = 1e-4;
      LambdaMax = 1e4;
var Lambda : reel;
    diverge,stable : boolean;

{------- boucle de recherche par méthode gradient-Newton -------}
var
   J,Jprecedent : reel;
{ (FonctionTheorique(x,param)-FonctionExperimentale(x))^2
  coeffJ pour pondérer de manière égale deux modèles qqsoit les ordres de grandeur }
  derJ  : TableauParam;
{ derj = dérivée de J = (fonctionTheorique-Fexp)*dfonctionTheorique/dParam }
  der2J : MatriceParam;
{ der2j = dérivée seconde de J (approximative) =
  DfonctionTheorique/dparam*DfonctionTheorique/dparam
  on néglige (fonctionTheorique-Fexp)d2Fth/dparam*dparam }
  IncParam : TableauParam;

procedure calculPrecision;
var U,InvDer2j : MatriceParam;

procedure construireU;
var
   v  : reel;
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

procedure resoudreU(l : codeParam);
{ Inversion de der2J = symétrique définie positive par  Méthode de Choleski
  Trigeassou p 105 }
var i,k : integer;
    Y   : TableauParam;
    v   : reel;
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
{ passage à invder2J }
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
end;{resoudreU}

{ Trigeassou p 267 }
var delta,puissance,coeffInvDer2j : reel;
    i,l : integer;
    N : integer;
    coeffSIparam : reel;
begin { calculPrecision } with pages[pageCourante] do begin
  construireU; { résolution successive avec B=(1..0) jusqu'à (0..1) }
  erreurCalcul := false;
  for i := 1 to NbreParam[paramNormal] do resoudreU(i);
//  invMat(der2J,NbreParam[paramNormal],invDer2j);
  for i := 1 to NbreParam[paramNormal] do begin
     try
     delta := 0;N := NbrePointsModele;coeffInvDer2j := 0;coeffSIparam := 1;
         if ParamToIndex(paramNormal,i) in fonctionTheorique[1].depend then begin
            delta := delta+sqr(deltaReg)*NbrePointsModele;
            coeffInvDer2j := NbrePointsModele+coeffInvDer2j;
            coeffSIparam := fonctionTheorique[1].coeffSI;
         end; {if}
     delta := sqrt(delta/coeffInvDer2j); { deltaReg pondéré par Npoints et coeffJ }
     ecartTypeParam[i] := sqrt(invDer2j[i,i])*delta*coeffSIparam;
     if paramInverse[i] then
        ecartTypeParam[i] := ecartTypeParam[i]/sqr(parametres[paramNormal,i].valeurCourante);
     incertParam[i] := ecartTypeParam[i]*student95(N);
// intervalle de confiance (Student) à 95 % 
     if incertParam[i]>minReal then begin
           puissance := dix(floor(log(incertParam[i]))-1);
           incertParam[i] := puissance*int(incertParam[i]/puissance);
     end;
// covariance param(i,l) = invder2J[i,l] 
     incParam[i] := 0;
     for l := 1 to NbreParam[paramNormal] do
         incParam[i] := incParam[i] - invDer2j[l,i]*derj[l];
     erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
     except
         incertParam[i] := Nan;
         incParam[i] := 0;
         ecartTypeParam[i] := Nan;
     end;
  end;{i}
end end; { calculprecision }

function InitCalculJ : boolean;
// On calcule une valeur relative à l'étendue des mesures
var k : integer;
    i : integer;
    valeur : reel;
begin with pages[pageCourante] do begin
   InitCalculJ := false;
   with fonctionTheorique[1] do begin
      if fin[1]<debut[1] then swap(fin[1],debut[1]);
      NbrePointsModele := succ(fin[1]-debut[1]);
      if (NbrePointsModele<NbreParamModele) then begin
           afficheErreur(erNombrePetit,0);
           exit;
      end;
      NbrePointsModele := NbrePointsModele-NbreParamModele;
      if NbrePointsModele=0 then NbrePointsModele := 1;
      SommeCarreY := 0;
      for i := debut[1] to fin[1] do begin
          valeur := valeurVar[indexY,i];
          if isNan(valeur) or not PointActif[i]
             then dec(NbrePointsModele)
             else SommeCarreY := SommeCarreY + sqr(valeur);
      end;
      if NbrePointsModele<1 then begin
           afficheErreur(erNombrePetit,0);
           exit;
      end;
      with grandeurs[indexY] do
           calcSI := uniteSI and
                     (fonct.genreC=G_experimentale) and
                     (puissance<>0);
      if calcSI
          then begin
               coeffSI := grandeurs[indexY].coeffSI;
               sommeCarreY := sommeCarreY*sqr(coeffSI);
          end
          else coeffSI := 1;
      DeltaReg := Nan;
      jPrecedent := 2*sommeCarreY;
   end;
   for k := 1 to MaxParametres do incertParam[k] := Nan;
   InitCalculJ := (SommeCarreY>MinReal*nmes);
end end;{initCalculJ}

procedure CalculJ(avecDerivee : boolean);
// calcul de J; avecDerivee => calcul derj,der2j

type
    MatriceLoc  = array[codeParam] of Vecteur;
var
    Y : MatriceLoc;

procedure calculFonction;
var i : integer;
    k1 : integer;
begin with pages[pageCourante],fonctionTheorique[1] do begin
    setLength(ValeurDeriveeX[1],NmesMax+1);
    for i := debut[1] to fin[1] do
        if not isNan(valeurVar[indexY,i]) and
           PointActif[i] then begin
        AffecteVariableE(i);
        try
        valeurTheorique[1,i] := calcule(calcul);
        if avecDerivee then
           for k1 := 1 to NbreParam[paramNormal] do
               Y[k1,i] := calcule(derf[1,k1]);
        ValeurDeriveeX[1,i] := 0;
        except
            on E : exception do begin
               if ErreurModele then raise EMathError.Create(E.message);
// une erreur permise à la deuxième on réarme
               erreurModele := true;
               PosErreurModele := i;
               derniereErreur := E.message;
            end;
        end;

    end;{i}
end end;{calculFonction}

procedure calculLoc;
var k1,k2 : integer;
    i : integer;
    ValDerf : TableauParam;{ valeur de la dérivée première }
    ecart : reel; {valeur de l'écart entre la fonction théorique et expérimentale }
begin with pages[pageCourante],fonctionTheorique[1] do begin
     setLength(ValeurDeriveeX[1],NmesMax+1);
     for i := debut[1] to fin[1] do
         if not isNan(valeurVar[indexY,i]) and
            PointActif[i] then begin
            if posErreurModele=i then continue;
            if calcSI
               then Ecart := valeurTheorique[1,i]-valeurVar[indexY,i]*coeffSI
               else Ecart := valeurTheorique[1,i]-grandeurs[indexY].valeur[i];
        J := J + sqr(ecart);
        if avecDerivee then
        for k1 := 1 to NbreParam[paramNormal] do begin
            valDerf[k1] := Y[k1,i];
            derj[k1] := derj[k1]+Ecart*valDerf[k1];
            for k2 := 1 to k1 do
                der2j[k1,k2] := der2j[k1,k2]+valDerf[k2]*valDerf[k1];
         end; // k1
     end; // i
end end;{calculLoc}

Const
      PrecisionAbsolueJ = 0.001;
      PrecisionRelative = 0.001;
var k1,k2 : integer;
    Delta : reel;
begin // calculJ
with pages[pageCourante] do begin
// Initialisation
   AffecteConstParam;
   VerifParamInverse;
   AffecteVariableP(false);
   erreurCalcul := false;
   erreurParam := false;
   J := 0;
   ErreurModele := false;
   PosErreurModele := -1;
   for k1 := 1 to NbreParam[paramNormal] do begin
       derJ[k1] := 0;
       for k2 := 1 to NbreParam[paramNormal] do
          der2j[k1,k2] := 0;
   end;{k1}
   if avecDerivee then
      for k1 := 1 to NbreParam[paramNormal] do
          setLength(y[k1],NmesMax+1);
   try
   if fonctionTheorique[1].genreC=g_fonction
      then calculFonction
      else ;
   except
       on E : exception do begin
          derniereErreur := E.message;
          erreurCalcul := true;
       end;
   end;
   if not erreurCalcul then CalculLoc;
   if avecDerivee then
       for k1 := 1 to NbreParam[paramNormal] do
           y[k1] := nil;
   stable := true;
   diverge := false;
   PrecisionModele[1] := sqrt(J/SommeCarreY);
   DeltaReg := sqrt(J/NbrePointsModele)/FonctionTheorique[1].CoeffSI;
   Delta := J-Jprecedent;
   Diverge := Diverge or (Delta>0);
   Delta := abs(Delta);
   Stable := Stable and
            ( (Delta<(Jprecedent*PrecisionRelative)) or
              (PrecisionModele[1]<PrecisionAbsolueJ) );
end end; // calculJ

procedure completeValTh;
var i : integer;
begin
   if (OmExtrapole in GraphePrinc.optionModele) and
       pages[pageCourante].ModeleCalcule then with pages[pageCourante] do begin
      if (fonctionTheorique[1].genreC=g_fonction) then begin
              for i := 0 to pred(nmes) do
                  if (i<debut[1]) or (i>fin[1]) then begin
                     AffecteVariableE(i);
                     try
                     valeurTheorique[1,i] := calcule(fonctionTheorique[1].calcul);
                     except
                     valeurTheorique[1,i] := Nan
                     end
                  end;{calculPoint}
      end // g_fonction
      else begin
               for i := 0 to pred(nmes) do
                   if (i<debut[1]) or (i>fin[1]) then
                       valeurTheorique[1,i] := Nan
      end;
      with fonctionTheorique[1] do
          if calcSI then for i := 0 to pred(nmes) do
              valeurTheorique[1,i] := valeurTheorique[1,i]/coeffSI;
      remplitVarLisse;
end end; // completeValTh

var sauveValeurParam,ValeurParamInit : tableauParam;
    avecMessage : boolean;

Function EffectueGaussNewton : boolean;
const
    Maxi_i1 = 32; { time out }
    Maxi_i2 = 6; {µ mini =(1/2)^7=1%}
var k : codeParam;
    i1,i2 : integer;
    mu : reel;
// boucle de recherche par méthode gradient-Newton
begin with pages[pageCourante] do begin
    i1 := 0;
    Lambda := 0;
    result := false;
    repeat
        inc(i1);
        Jprecedent := J;
        calculPrecision;
        if erreurCalcul then begin
           if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HelpDomaine);
           valeurParam[paramNormal] := sauveValeurParam;
           exit;
        end;
        for k := 1 to NbreParam[paramNormal] do
            if paramInverse[k]
               then valeurParam[paramNormal,k] := 1/(1/valeurParam[paramNormal,k]+incParam[k])
               else valeurParam[paramNormal,k] := valeurParam[paramNormal,k]+incParam[k];
        CalculJ(true);
        if erreurParam then begin
           if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HelpDomaine);
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
                 then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HelpDomaine)
                 else afficheErreur(erDivergence,HelpDivergence);
               exit;
           end
           else sauveValeurParam := ValeurParam[paramNormal];
      if (i2>0) and not stable then begin
           inc(i1); // prise en compte du temps de calcul du retour en arrière
           calculJ(true);
      end;
      if not stable then begin
         PostMessage(Handle,WM_Reg_Modele,i1,0);
         Application.ProcessMessages;// pour mise à jour
      end;
   until (i1>Maxi_i1) or stable;
   if (i1>Maxi_i1) and avecMessage then afficheErreur(erTimeOut,HelpTimeOut);
   result := true;
end end;

var iParam : integer;
label finProc;
begin // effectueModele
with pages[pageCourante] do begin
// boucle de recherche par méthode gradient-Newton 
    ModeleCalcule := false;
    ModeleErrone := true;
    if not InitCalculJ then exit;
    CalculJ(ajuste);
    if erreurCalcul or ErreurParam then begin
       if withMessage then MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK],HelpDomaine);
       exit;
    end;
    sauveValeurParam := ValeurParam[paramNormal];
    ValeurParamInit := ValeurParam[paramNormal];
    avecMessage := true;
   if ajuste
       then modeleErrone := not EffectueGaussNewton
       else modeleErrone := false;
   if modeleErrone then exit;
   if (PrecisionModele[1]>0.2) then begin
              ValeurParam[paramNormal] := ValeurParamInit;
              with fonctionTheorique[1] do
                  if IsSinusoide
                     then begin
                         valeurParam[paramNormal,amplitude] := valeurParam[paramNormal,amplitude]*(0.5+random);
                         valeurParam[paramNormal,Phase] := (random*2-1)*AngleUtilisateur(pi);
                         if (periodeOuFrequence<>grandeurInconnue) then
                             valeurParam[paramNormal,PeriodeOuFrequence] :=
                                        valeurParam[paramNormal,PeriodeOuFrequence]*(0.5+random);
                     end
                     else for iParam := 1 to NbreParam[paramNormal] do
                             if ParamToIndex(paramNormal,iparam) in fonctionTheorique[1].depend then
                                valeurParam[paramNormal,iparam] := valeurParam[paramNormal,iparam]*(0.25+4*random);
             CalculJ(ajuste);
             if erreurCalcul or ErreurParam then begin
                  ValeurParam[paramNormal] := ValeurParamInit;
                  exit;
             end;
    end;
    ParamAjustes := ajuste and stable;
    ModeleCalcule := true;
    CompleteValTh;
    fonctionTheorique[1].residuStat.ecartDist := ecart;
    fonctionTheorique[1].calculResidu(1,csEcartImpose);
    if ajuste then begin
    with fonctionTheorique[1] do
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
    with fonctionTheorique[1] do
        if IsSinusoide and
           (periodeOuFrequence<>grandeurInconnue) then with pages[pageCourante] do
           valeurParam[paramNormal,PeriodeOuFrequence] := abs(valeurParam[paramNormal,PeriodeOuFrequence]);
end;
end end; // EffectueModele

Procedure TFRGS.CompileModele(var PosErreur,LongErreur : integer);
Type Tligne = (LCommentaire,LModele,Lsuper);
var posErreurLigne : integer;
    LigneCourante : string;
    i : integer;

Function TypeDeLigne : Tligne;
var PosEgal : integer;
    index : integer;
    NomLu : string;
begin
    result := Lcommentaire;
    if IsLigneComment(LigneCourante) then exit;
    PosEgal := Pos(':=',ligneCourante);
    if PosEgal>0 then begin
       codeErreurC := 'Pas de superposition possible';
       result := LSuper;
       exit;
    end;
    PosEgal := Pos('=',ligneCourante);
    if PosEgal=0 then begin
       codeErreurC := erEgalAbsent;
       exit;
    end;
    nomLu := copy(ligneCourante,1,pred(posEgal)); // extrait le nom
    trimComplet(nomLu);
    index := indexToParam(paramNormal,IndexNom(nomLu));
    if index=grandeurInconnue
       then result := Lmodele
end;

Procedure CompileModelisation;
var iY : integer;
begin
            if TypeDeLigne<>Lmodele then exit;
            NbreModele := 1;
            trimComplet(LigneCourante);
            with fonctionTheorique[1] do begin
                 LigneMemo := i;
                 compileM(LigneCourante,posErreurLigne,longErreur);
            end;
            if not ModifInverse then
            with pages[pageCourante] do begin
                 iY := fonctionTheorique[1].indexY;
                 if (debut[1]=0) and
                    (iY<>grandeurInconnue) and
                    isNan(valeurVar[iY,0])
                    then debut[1] := 1;
                 if (fin[1]=pred(nmes)) and
                    (iY<>grandeurInconnue) and
                    isNan(valeurVar[iY,pred(nmes)])
                    then fin[1] := nmes-2;
            end;
end; // CompileModelisation

begin
    for i := 1 to maxParametres do begin
        paramInverse[i] := false;
        inversePermis[i] := true;
    end;
    codeErreurC := '';
    modifInverse := false;
    LigneCourante := memoModele.text;
    compileModelisation;
    if modifInverse then begin
           codeErreurC := '';
           NbreModele := 0;
           modifInverse := false;
// recompiler les modéles si modifInverse
           compileModelisation;
     end;
     if codeErreurC=''
        then begin
             NbreParamModele := 0;
             for i := 1 to NbreParam[paramNormal] do
                 if ParamToIndex(paramNormal,i) in fonctionTheorique[1].depend then
                    inc(NbreParamModele);
             if NbreModele>0
                then include(etatModele,ModeleDefini)
                else include(etatModele,PasDeModele);
        end
        else afficheErreur(codeErreurC,0);
    include(GraphePrinc.Modif,gmModele);
end; // CompileModele

Procedure TFRGS.ConstruitModele;

Procedure ConstruitFonction;
var l,k : integer;
    dependPossible : TsetGrandeur;
    fchi2: Pelement;
begin with fonctionTheorique[1] do begin
     lineaire := true; { par défaut }
     DeriveeForm(fonctionTheorique[1],
             grandeurs[indexX],fchi2,dependPossible);
     libere(fchi2);
     lineaireVar := not(indexX in dependPossible);
     for k := 1 to NbreParam[paramNormal] do begin
         DeriveeForm(fonctionTheorique[1],Parametres[paramNormal,k],
            derf[1,k],dependPossible);
         for l := 1 to NbreParam[paramNormal] do
             if ParamToIndex(paramNormal,l) in dependPossible then begin
               exclude(etatModele,modeleLineaire);
               lineaire := false;
           end;
     end;{for k}
end end; // ConstruitFonction

Procedure VerifierGraphe;
var i : integer;
    CoordOK : boolean;
begin
     coordOK := false;
     with fonctionTheorique[1],graphePrinc do coordOK := coordOK or
              ( (grandeurs[indexX].nom=coordonnee[1].nomX) and
                (grandeurs[indexY].nom=coordonnee[1].nomY) ) or
              ( (grandeurs[indexX].nom=coordonnee[1].nomY) and
                (grandeurs[indexY].nom=coordonnee[1].nomX) );
     if not CoordOK then begin
         for i := 2 to maxOrdonnee do with GraphePrinc.Coordonnee[i] do begin
            nomY := '';
            nomX := '';
         end;
         with fonctionTheorique[1] do begin
              GraphePrinc.coordonnee[1].nomX := grandeurs[indexX].nom;
              GraphePrinc.Coordonnee[1].nomY := grandeurs[indexY].nom;
         end;
         graphePrinc.PaintBox.refresh;
   end; // not CoordOK
end; // VerifierGraphe

var l : integer;
    k : codePage;
begin
   VerifierGraphe;
   include(etatModele,modeleLineaire);
   if fonctionTheorique[1].genreC=g_fonction then ConstruitFonction;
   setUniteParametre;
   for k := 1 to NbrePages do with Pages[k] do begin
        ParamAjustes := false;
        ModeleCalcule := false;
        ModeleErrone := false;
        for l := 0 to pred(NmesMax) do
            valeurTheorique[1,l] := Nan;
   end; // for page[k]
   include(GraphePrinc.Modif,gmModele);
   include(etatModele,ModeleConstruit);
   with fonctionTheorique[1] do
        VariableEgalAbscisse := grandeurs[indexX]=graphePrinc.Monde[mondeX].axe;
end; // construitModele

