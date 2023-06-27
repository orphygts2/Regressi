Procedure TFgrapheParam.EffectueModeleGlb(Ajuste : boolean);

{------- boucle de recherche par méthode gradient-Newton -------}
var
    J,Jprecedent,chi2Precedent,coeffJ : tableauReal;
// (FonctionTheorique(x,param)-FonctionExperimentale(x))^2 
    derJ  : TableauParam;
// derj = dérivée de J = (fonctionTheorique-Fexp)*dfonctionTheorique/dParam
    der2J : TMatriceParam;
{ der2j = dérivée seconde de J (approximative) =
  DfonctionTheorique/dparam*DfonctionTheorique/dparam
  on néglige (fonctionTheorique-Fexp)d2Fth/dparam*dparam }
    IncParam : TableauParam;
    diverge,stable : boolean;
    chi2Glb : tableauReal;

procedure calculPrecision;
var U,Invder2j : TMatriceParam;

procedure construireU;
var
   i,j : integer;
   k : integer;
   v : double;
begin
 for i := 1 to NbreParam[paramGlb] do begin
     try
     v := der2J[i,i];
     for k := 1 to pred(i) do v := v-sqr(U[k,i]);
     U[i,i] := sqrt(v);
     for j := succ(i) to NbreParam[paramGlb] do begin
         v := der2J[j,i];
         for k := 1 to pred(i) do v:=v-U[k,i]*U[k,j];
         U[i,j] := v/U[i,i];
     end;{j}
     except
     for j := 1 to NbreParam[paramGlb] do begin
        U[i,j] := 0;
        U[j,i] := 0;
        der2J[j,i] := 0;
        der2J[i,j] := 0;
// erreur sur param[i] mais on veut trouver les autres
     end {j}
     end;
  end;{i}
end; // construireU

procedure resoudreU(j : TcodeParam);
var i : TcodeParam;
    Y : TableauParam;
    v : extended;
    k : integer;
begin
    for i := 1 to NbreParam[paramGlb] do begin
        if (i=j)
            then v := 1
            else v := 0;
        for k := 1 to pred(i) do
            v := v-U[k,i]*Y[k];
        Y[i] := v/U[i,i];
     end;{i}
// passage à der2J
     for i := NbreParam[paramGlb] downto 1 do begin
         v := Y[i];
         for k := succ(i) to NbreParam[paramGlb] do
             v := v-U[i,k]*invder2J[j,k];
         invder2J[j,i] := v/U[i,i];
      end;{i}
end; // resoudreU

{ Trigeassou p 267 }
var i,j : integer;
    coeffInvDer2j,delta : double;
    puissance : double;
    N : integer;
    m : TcodeIntervalle;
begin // calculprecision
  construireU;
  erreurCalcul := false;
// résolution successive avec B=(1..0) jusqu'à (0..1)
  for i := 1 to NbreParam[paramGlb] do resoudreU(i);
  for i := 1 to NbreParam[paramGlb] do begin
     try
     coeffInvDer2j := 0;delta := 0;N := 0;
     for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do
         if ParamToIndex(paramGlb,i) in depend then begin
      // prise en compte de l'influence de coeffJ[m]
            delta := delta+sqr(sigmaY*coeffJ[m])*NbrePointsModele;
            N := N + NbrePointsModele;
            coeffInvDer2j := NbrePointsModele*coeffJ[m]+coeffInvDer2j;
         end; {m , if}
     if chi2actifGlb
          then delta := 1
          else delta := sqrt(delta/coeffInvDer2J);
     coeffInvDer2j := coeffInvDer2j/N;
     delta := sqrt(delta/N);
     incertParamGlb[i] := sqrt(coeffInvDer2j*invDer2j[i,i])*delta;
     incert95ParamGlb[i] := incertParamGlb[i]*Student95(N);
// intervalle de confiance (Student) à 95 % }
     puissance := dix(floor(log10(incertParamGlb[i]))-1);
     parametres[paramGlb,i].incertCourante := puissance*int(incertParamGlb[i]/puissance);
// covariance param(i,j) = invder2J[i,j] }
      incParam[i] := 0;
      for j := 1 to NbreParam[paramGlb] do
          incParam[i] := incParam[i] - invDer2j[j,i]*derj[j];
      erreurCalcul := erreurCalcul or (abs(incParam[i])>MaxReal);
      except
         parametres[paramGlb,i].incertCourante := Nan;
         incParam[i] := 0;
     end;
   end;{i}
   if chi2ActifGlb then
   for i := 1 to NbreParam[paramGlb] do
       for j := 1 to NbreParam[paramGlb] do
           CovarianceParamGlb[i,j] := invDer2J[i,j];
end; // calculprecision

function InitCalculJ : boolean;
// On calcule une valeur relative à l'étendue des mesures
var i : TcodePage;
    m : TcodeIntervalle;
    Chi2PermisGlb : boolean;
begin
    chi2PermisGlb := true;
    for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do begin
        NbrePointsModele := 0;
        for i := 1 to NbrePages do if pages[i].active then inc(NbrePointsModele);
        if (NbrePointsModele<=nbreParam[paramGlb]) then begin
           afficheErreur(erTropParam,0);
           InitCalculJ := false;
           exit;
        end;
        coeffSI := 1;
        dec(NbrePointsModele,NbreParam[paramGlb]);
        SommeCarreY := 0;
        for i := 1 to NbrePages do if pages[i].active then
            SommeCarreY := SommeCarreY +
               sqr(pages[i].valeurParametre(indexY));
        sigmaY := Nan;
        if  uniteSIGlb and
           (grandeurs[indexY].fonct.genreC=G_experimentale)
          then begin
               coeffSI := grandeurs[indexY].coeffSI;
               sommeCarreY := sommeCarreY*sqr(coeffSI);
          end;
        Jprecedent[m] := 2*sommeCarreY;
        chi2Precedent[m] := NbrePointsModele*100.0;
        chi2PermisGlb := chi2PermisGlb and chi2Permis;
    end;
    Chi2ActifGlb := chi2PermisGlb and avecChi2;
    if Chi2ActifGlb
       then // dèjà pris en compte par incertitude
          for m := 1 to NbreModeleGlb do coeffJ[m] := 1
       else for m := 1 to NbreModeleGlb do
              coeffJ[m] := Jprecedent[1]/Jprecedent[m];
    InitCalculJ := true;
end; // initCalculJ

procedure CalculJ(avecDerivee : boolean);
// calcul de J; avecDerivee => calcul derj,der2j

procedure calculFonction;
var k1,k2  : integer;
    i : TcodePage;
    ecart : extended; // valeur de l'écart entre la fonction théorique et expérimentale
    ValDerf : TableauParam; // valeur de la dérivée première
    dt,dy,coeffChi2 : double;
    m : TcodeIntervalle;
begin
   try
   for i := 1 to NbrePages do with pages[i] do begin
        AffecteConstParam(true);
        for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do begin
            ValeurTheoriqueGlb[m] := calcule(calcul);
            if active then begin
               Ecart := valeurTheoriqueGlb[m]-valeurParametre(indexY)*coeffSI;
               J[m] := J[m] + sqr(ecart);
               if avecDerivee then begin
               if Chi2ActifGlb
                  then begin
                     try
                     dy := precisionParametre(indexY)*coeffSI;
                     if isNan(dy) then dy := 0;
                     dt := precisionParametre(indexX);
                     dt := dt*calcule(fchi2);
                     if uniteSIglb then dt := dt*grandeurs[indexX].coeffSI;
                     if isNan(dt) then dt := 0;
                     coeffChi2 := 1/(sqr(dy)+sqr(dt));
                     except
                       try
                       coeffChi2 := 1e6/sqr(valeurParametre(indexY));
                       //  on force une incertitude de 0,1%
                       except
                          coeffChi2 := 0;
                       end;
                     end;
                    chi2Glb[m] := chi2Glb[m] + coeffChi2*sqr(ecart);
          end { chi2 }
          else coeffChi2 := coeffJ[m];
      for k1 := 1 to NbreParam[paramGlb] do begin
          valDerf[k1] := calcule(derf[m,k1]);
          derj[k1] := derj[k1] + Coeffchi2*Ecart*valDerf[k1];
          for k2 := 1 to k1 do
              der2j[k1,k2] := der2j[k1,k2]+Coeffchi2*valDerf[k2]*valDerf[k1];
     end;{k1}
     end;{dérivee}
     end;{active}
     end;{m}
   end;{i}
    except
       erreurCalcul := true
    end;
end; // calculFonction

Const PrecisionRelative = 1e-3;
      PrecisionAbsolueJ = 1e-6;
      PrecisionRelativeChi2 = 1e-2;
      PrecisionAbsolueChi2 = 1e-1;
var k1,k2 : integer;
    DeltaLoc : double;
    m : TcodeIntervalle;
begin
// Initialisation
   erreurCalcul := false;
   for m := 1 to NbreModeleGlb do begin
      J[m] := 0;
      chi2Glb[m] := 0;
   end;
   for k1 := 1 to NbreParam[paramGlb] do begin
      derJ[k1] := 0;
      for k2 := 1 to NbreParam[paramGlb] do
          der2J[k1,k2] := 0;
   end;{k1}
   calculFonction;
   stable := true;
   diverge := false;
   for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do begin
   if Chi2ActifGlb
      then begin
         chi2Relatif := chi2Glb[m]/NbrePointsModele;
         DeltaLoc := chi2Glb[m]-chi2Precedent[m];
         Stable := Stable and
                ( (abs(DeltaLoc)<(NbrePointsModele*PrecisionRelativeChi2)) or
                  (chi2Glb[m]<(NbrePointsModele*PrecisionAbsolueChi2)) );
         Diverge := Diverge or (DeltaLoc>0);
      end
      else begin
         sigmaY := sqrt(J[m]/NbrePointsModele);
         PrecisionModeleGlb[m] := sqrt(J[m]/SommeCarreY);
         DeltaLoc := J[m]-Jprecedent[m];
         Stable := stable and
                 ( (abs(DeltaLoc)<=(Jprecedent[m]*PrecisionRelative)) or
                   (PrecisionModeleGlb[m]<=PrecisionAbsolueJ));
         Diverge := diverge or (DeltaLoc>0);
     end;
   end;
end; // calculJ

const
    Maxi_i1 = 10; // time out
    Maxi_i2 = 6; // µ mini =(1/2)^7=1%
var k : integer;
    i2,i1  : integer;
    mu : double;
    sauveValeurParam : tableauParam;
begin // effectueModeleGlb : boucle de recherche par méthode gradient-Newton
    i1 := 0;
    if not InitCalculJ then exit;
    CalculJ(ajuste);
    if erreurCalcul then begin
       afficheErreur(erDomaine,0);
       exit;
    end;
    for k := 1 to NbreParam[paramGlb] do
        sauveValeurParam[k] := Parametres[paramGlb,k].valeurCourante;
    if ajuste then repeat
        inc(i1);
        Jprecedent := J;
        chi2Precedent := chi2Glb;
        calculPrecision;
        if erreurCalcul then begin
            afficheErreur(erDomaine,0);
            for k := 1 to NbreParam[paramGlb] do
                Parametres[paramGlb,k].valeurCourante := sauveValeurParam[k];
            exit;
        end;
        for k := 1 to NbreParam[paramGlb] do
            Parametres[paramGlb,k].valeurCourante :=
            Parametres[paramGlb,k].valeurCourante + incParam[k];
        CalculJ(true);
        mu := 1;i2 := 0;
        while Diverge and (i2<Maxi_I2) do begin
          inc(i2);
          mu := mu/2;
          for k := 1 to NbreParam[paramGlb] do
              Parametres[paramGlb,k].valeurCourante :=
                 Parametres[paramGlb,k].valeurCourante-incParam[k]*mu;
          CalculJ(false);
        end; { while }
        if (i2<>0) and not stable then calculJ(true);
        if erreurCalcul then begin
            afficheErreur(erDomaine,0);
            for k := 1 to NbreParam[paramGlb] do
                Parametres[paramGlb,k].valeurCourante := sauveValeurParam[k];
            exit;
        end;
        if diverge and (stable or (i1<=1)) then begin
           diverge := false;
           for k := 1 to NbreParam[paramGlb] do
                Parametres[paramGlb,k].valeurCourante := sauveValeurParam[k];
           CalculJ(not stable);                
        end;
        if diverge then begin
           afficheErreur(erDivergence,0);
           exit;
        end;
        for k := 1 to NbreParam[paramGlb] do
            sauveValeurParam[k] := Parametres[paramGlb,k].valeurCourante;
    until (i1>Maxi_i1) or stable;
    if ajuste and stable then calculPrecision;
    if i1>Maxi_i1 then afficheErreur(erTimeOut,0);
    if ajuste and chi2actifGlb and (chi2Glb[1]=0) then calculJ(true); // pour récupérer chi2
    ParamAjustesGlb := ajuste and stable;
    ModeleCalcule := true;
    if ajuste then begin
    for i1 := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[i1] do
        if IsSinusoide then begin
           if parametres[paramGlb,Amplitude].valeurCourante<0 then begin
              parametres[paramGlb,Amplitude].valeurCourante :=
                  -parametres[paramGlb,Amplitude].valeurCourante;
              parametres[paramGlb,Phase].valeurCourante := parametres[paramGlb,Phase].valeurCourante+AngleUtilisateur(pi);
           end;
           if parametres[paramGlb,PeriodeOuFrequence].valeurCourante<0 then
// Période peut être commune donc ne modifier T qu'après
              if IsCosinus
                 then parametres[paramGlb,Phase].valeurCourante :=
                        -parametres[paramGlb,Phase].valeurCourante
                 else parametres[paramGlb,Phase].valeurCourante :=
                        -parametres[paramGlb,Phase].valeurCourante+AngleUtilisateur(pi);
           with parametres[paramGlb,Phase] do
                valeurCourante := Atan2(sin(valeurCourante),cos(valeurCourante));
        end;
   for i1 := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[i1] do
        if IsSinusoide then parametres[paramGlb,PeriodeOuFrequence].valeurCourante :=
                  abs(parametres[paramGlb,PeriodeOuFrequence].valeurCourante);
end;
end; // EffectueModeleGlb

Procedure TFgrapheParam.CompileModeleGlb(var PosErreur,LongErreur : integer);
Type TypeLigne = (LCommentaire,LModele,Lsuperpose);
var i,posErreurLigne : integer;
    LigneCourante : string;

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
    nomLu := copy(ligneCourante,1,pred(posEgal));  { extrait le nom }
    trimComplet(nomLu);
    index := indexToParam(paramGlb,IndexNom(nomLu));
    if index=grandeurInconnue
       then result := Lmodele
end;

Procedure CompileSuperposition;
begin
     if NbreFonctionSuperGlb<maxIntervalles
        then begin
            inc(NbreFonctionSuperGlb);
            trimComplet(LigneCourante);
            if fonctionSuperposeeGlb[NbreFonctionSuperGlb].compileM(
                LigneCourante,posErreurLigne,longErreur) and
               (fonctionSuperposeeGlb[NbreFonctionSuperGlb].GenreC<>g_fonction)
                   then codeErreurC := erGenreModele;
        end
        else begin
             codeErreurC := erMaxModele;
             posErreurLigne := 0;
        end;
end;  // CompileSuperposition

Procedure CompileModelisation(i : integer);
begin
    if NbreModeleGlb<maxIntervalles
       then begin
            inc(NbreModeleGlb);
            trimComplet(LigneCourante);
            with fonctionTheoriqueGlb[NbreModeleGlb] do begin
                 LigneMemo := i;
                 if compileM(LigneCourante,posErreurLigne,longErreur)
                    and (GenreC in [g_diff1,g_diff2])
                 then codeErreurC := erModeleSystDiff;
           end;
      end
      else begin
           codeErreurC := erMaxModele;
           posErreurLigne := 0;
      end;
end; // CompileModelisation

begin
     NbreParam[paramGlb] := 0;
     CodeErreurC := '';
     PosErreur := 0;
     LongErreur := 0;
     etatModele :=  [];
     NbreModeleGlb := 0;
     NbreFonctionSuperGlb := 0;
     for i := 0 to pred(MemoModele.Lines.count) do begin
         LigneCourante := MemoModele.Lines[i];
         case TypeDeLigne of
            Lcommentaire : ;
            Lsuperpose : compileSuperposition;
            Lmodele : compileModelisation(i);
         end; { case }
         if codeErreurC=''
            then posErreur := posErreur + length(MemoModele.Lines[i])+2 { 2=CR+LF }
            else begin
                posErreur := posErreur + posErreurLigne;
                break;
            end;
     end; { for i }
     if codeErreurC=''
        then begin
           if NbreModeleGlb>0
              then include(etatModele,ModeleDefini)
              else include(etatModele,PasDeModele);
           if NbreFonctionSuperGlb>0 then include(etatModele,SimulationDefinie);
        end
        else begin
            afficheErreur(codeErreurC,0);
        end;
     include(GrapheP.Modif,gmModele);
end; // CompileModeleGlb

Procedure TFgrapheParam.ConstruitModeleGlb;

Procedure ConstruitFonction;
var j,k : integer;
    dependPossible : TsetGrandeur;
    i : TindiceOrdonnee;
    addrX : tgrandeur;
    m : TcodeIntervalle;
begin with GrapheP do begin
  with fonctionTheoriqueGlb[1] do begin
  if (indexX=0) or (indexX=grandeurInconnue) then
     indexX := Coordonnee[1].codeX;
  if indexX<NbreGrandeurs
     then addrX := grandeurs[indexX]
     else addrX := parametres[paramNormal,indexToParam(paramNormal,indexX)];
  if ( (addrX.nom<>coordonnee[1].nomX) or
       (addrY.nom<>coordonnee[1].nomY) ) and
       verifGraphe and
       OKreg(OkModifGr,0)
       then begin
         for i := 2 to maxOrdonnee do begin
             Coordonnee[i].nomX := '';
             Coordonnee[i].nomY := '';
             Coordonnee[i].iMondeC := mondeDroit;
         end;
         include(modif,gmModele);
         with Coordonnee[1] do begin
            nomX := addrX.nom;
            nomY := addrY.nom;
            iMondeC := mondeY;
         end;
         PaintBox.refresh;
      end;
  end;
  verifGraphe := true;
  setUniteParamGlb;
  include(etatModele,ModeleLineaire);
  for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do begin
      for k := 1 to NbreParam[paramGlb] do begin
         DeriveeForm(fonctionTheoriqueGlb[m],
             Parametres[paramGlb,k],derf[m,k],dependPossible);
         for j := 1 to NbreParam[paramGlb] do
             if ParamToIndex(ParamGlb,j) in dependPossible then
                exclude(etatModele,ModeleLineaire);
      end;{for k}
      if avecChi2
         then DeriveeForm(fonctionTheoriqueGlb[m],
              grandeurs[indexX],fchi2,dependPossible)
         else libere(fchi2);
  end;{m}
end end; // ConstruitFonction

var i : TcodePage;
    k : integer;
    m : TcodeIntervalle;
begin
   ConstruitFonction;
   for k := 1 to NbreParam[paramGlb] do Parametres[paramGlb,k].adaptable := true;
   chercheUniteParametreGlb;
   ModeleCalcule := false;
   for i := 1 to NbrePages do
       for m := 1 to maxIntervalles do
           Pages[i].valeurTheoriqueGlb[m] := Nan;
   include(etatModele,ModeleConstruit)
end; // construitModeleGlb

