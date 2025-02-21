unit filerw3U;

interface

uses windows, sysUtils, classes, forms, controls, strUtils,
     constreg, maths, regutil, uniteker, compile, math, dialogs,
     valeurs, graphker, graphvar, graphFFT, graphpar, graphEuler,
     indicateurU, fusionU, statisti,
     system.ansiStrings,system.Contnrs, System.IOUtils,
     VCL.ComCtrls,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     DeLaFitsCommon, DeLaFitsString, DeLaFitsGraphics;

procedure EcritFichierWin(NomFichier : string);
function LitFichierWin : boolean;
procedure LitCalcul(const FileName : string);
Procedure AjouteFichier(const NomFichier : string);

var largeurColonnesVariab : array[0..MaxGrandeurs] of integer;

    // largeurColonnesConst : array[0..MaxGrandeurs] of integer;

implementation

uses regmain;

procedure EcritFichierWin(NomFichier : string);
var NbreParamNormal : integer;

Procedure EcritPage(page : integer);
var i,j : LongInt;
    ivar : integer;
    ligneVide : boolean;
begin with pages[page] do begin
    writeln(fichier,symbReg,'1 PAGE COMMENT');
    ecritChaineRW3(commentaireP);
    ligneVide := true;
    while (nmes>0) and ligneVide do begin
       for i := 0 to pred(NbreVariabExp) do
           ligneVide := ligneVide and isNan(valeurVar[indexVariabExp[i],pred(nmes)]);
       if ligneVide then nmes := nmes-1;
    end;
    if nmes>0 then begin
       writeln(fichier,symbReg2,IntToStr(nmes)+' VALEUR VAR');
       for j := 0 to pred(nmes) do begin
           for i := 0 to pred(NbreVariabExp) do
               write(fichier,valeurVar[indexVariabExp[i],j],' ');
           writeln(fichier);
       end; // for j
       if nbreVariabPython>0 then begin
          writeln(fichier,symbReg2,IntToStr(nmes)+' VALEUR PYTHON');
          for j := 0 to pred(nmes) do begin
              for i := 0 to pred(NbreVariabPython) do
                  write(fichier,valeurVar[indexVariabPython[i],j],' ');
          writeln(fichier);
       end; // for j
       end;
       if NbreVariabTexte>0 then begin
          writeln(fichier,symbReg2,Nmes,' TEXTE VAR');
          ivar := indexVariabTexte[0];
          for j := 0 to pred(nmes) do
                ecritChaineRW3(texteVar[iVar,j]);
       end;
       if incertDefinie and not incertCalculee then begin
          writeln(fichier,symbReg2,Nmes,' INCERT VAR');
          for j := 0 to pred(nmes) do begin
             for i := 0 to pred(NbreVariabExp) do
                 if IncertVar[indexVariabExp[i]]=nil
                    then write(fichier,'0 ')
                    else write(fichier,IncertVar[indexVariabExp[i],j],' ');
             writeln(fichier);
          end; // for j
       end;
    end;// Nmes>0
    if NbreConstExp>0 then begin
       writeln(fichier,symbReg2,NbreConstExp,' VALEUR CONST');
       for i := 0 to pred(NbreConstExp) do
           writeln(fichier,ValeurConst[indexConstExp[i]]);
       writeln(fichier,symbReg2,NbreConstExp,' INCERT CONST');
       for i := 0 to pred(NbreConstExp) do
           writeln(fichier,incertConst[indexConstExp[i]]);
    end;
    if NbreConstPython>0 then begin
       writeln(fichier,symbReg2,NbreConstPython,' VALEUR PYCONST');
       for i := 0 to pred(NbreConstPython) do
           writeln(fichier,ValeurConst[indexConstPython[i]]);
    end;
    if NbreConstTexte>0 then begin
       writeln(fichier,symbReg2,NbreConstTexte,' TEXTE CONST');
       for i := 0 to pred(NbreConstTexte) do
           ecritChaineRW3(TexteConst[indexConstTexte[i]]);
    end;
    writeln(fichier,symbReg2,'2 OPTIONS');
    writeln(fichier,ord(active));
    writeln(fichier,ord(experimentale));
    if stat.StatOK then with stat do begin
       writeln(fichier,symbReg2,Nbre,' VALEUR STAT');
       for i := 0 to pred(Nbre) do
           writeln(fichier,Donnees[i]);
    end;
    if ModelePagesIndependantes and
       (TexteModeleP.count>0) then begin
         writeln(fichier,symbReg2,TexteModeleP.count,' MODELEPAGE');
         for i := 0 to pred(TexteModeleP.count) do
             ecritChaineRW3(TexteModeleP[i])
    end;
    if debutFFT>0 then begin
       writeln(fichier,symbReg2,'2 BORNES FFT');
       writeln(fichier,debutFFT);
       writeln(fichier,finFFT);
    end;
    if NbreParamNormal>0 then begin
       writeln(fichier,symbReg2,NbreParamNormal,' VALEUR PARAM');
       for i := 1 to NbreParamNormal do
           writeln(fichier,valeurParam[paramNormal,i]);
       writeln(fichier,symbReg2,NbreParamNormal,' INCERT PARAM');
       for i := 1 to NbreParamNormal do
           writeln(fichier,incertParam[i]);
       writeln(fichier,symbReg2,NbreParamNormal,' STDEV PARAM');
       for i := 1 to NbreParamNormal do
           writeln(fichier,incert95Param[i]);
    end;
    if NbreModele>0 then begin
       writeln(fichier,symbReg2,NbreModele,' DEBUT');
       for i := 1 to NbreModele do writeln(fichier,debut[i]);
       writeln(fichier,symbReg2,NbreModele,' FIN');
       for i := 1 to NbreModele do writeln(fichier,fin[i]);
    end;
    if NomFichierBitmap<>'' then begin
       verifNomBitmap(NomFichier);
       writeln(fichier,symbReg2,'1 BITMAP');
       writeln(fichier,ExtractFileName(NomFichierBitmap));
    end;
    if (indicateurP<>nil) and (indicateurDlg<>nil) then begin
        writeln(fichier,symbReg2,'1 INDICATEUR');
        writeln(fichier,indicateurDlg.indicateurs.indexOf(indicateurP));
    end;
    if FgrapheVariab.graphes[1].Equivalences[page].count>0 then begin
       writeln(fichier,symbReg2,FgrapheVariab.graphes[1].Equivalences[page].count,' EQUIVALENCE');
       for i := 0 to pred(FgrapheVariab.graphes[1].Equivalences[page].count) do
           with FgrapheVariab.graphes[1].Equivalences[page][i] do begin
           write(fichier,pente,' ',ve,' ',phe,' ');
           write(fichier,x1,' ',y1,' ',x2,' ',y2,' ');
           write(fichier,x1i,' ',y1i,' ',x2i,' ',y2i);
           writeln(fichier);
      end;
    end;
    if ListeRepere.count>0 then begin
       writeln(fichier,symbReg2,ListeRepere.count,' REPERE');
       for i := 0 to pred(ListeRepere.count) do begin
           write(fichier,ListeRepere[i].valeur,crTab);
           write(fichier,ListeRepere[i].texte);
           writeln(fichier);
       end;
    end;
end end; // ecritPage

Procedure ecritEnTete;

Procedure EcritMemoExpressions;
var i : integer;
    nom : string;
begin
   if Fvaleurs.Memo.lines.count>0 then begin
      writeln(fichier,symbReg,Fvaleurs.Memo.lines.count,' MEMO GRANDEURS');
      for i := 0 to pred(Fvaleurs.Memo.lines.count) do begin
          nom := Fvaleurs.Memo.lines[i];
          ecritChaineRW3(nom);
      end;
   end;
end;

Procedure EcritMemoPython;
var i : integer;
    nom : string;
    ligneVide : boolean;
begin
   if Fvaleurs.MemoSource.lines.count>0 then begin
      i := 0;
      ligneVide := false;
      repeat
           if Fvaleurs.MemoSource.lines[i]=''
             then if ligneVide
                then begin
                   Fvaleurs.MemoSource.lines.Delete(i)
                end
                else begin
                   ligneVide := true;
                   inc(i);
                end
             else begin
                ligneVide := false;
                inc(i);
             end;
      until (i=Fvaleurs.MemoSource.lines.count);
      writeln(fichier,symbReg,Fvaleurs.MemoSource.lines.count,' MEMO PYTHON');
      for i := 0 to pred(Fvaleurs.MemoSource.lines.count) do begin
          nom := Fvaleurs.MemoSource.lines[i];
          ecritChaineRW3(nom);
      end;
   end;
end;

Procedure EcritStrList(M : TstringList;const nom : string);
var i : integer;
begin
   if M.count>0 then begin
      writeln(fichier,symbReg,M.count,nom);
      for i := 0 to pred(M.count) do
          ecritChaineRW3(M[i])
   end;
end;

Procedure EcritRichEdit(RE : TrichEdit;const nom : string);
var i : integer;
begin
   if RE.lines.count>0 then begin
      writeln(fichier,symbReg,RE.lines.count,nom);
      for i := 0 to pred(RE.lines.count) do
          ecritChaineRW3(RE.lines[i])
   end;
end;

var i,coeffDelta : integer;
    mecaOK,avecIncert : boolean;
    avecUniteGraphe : boolean;
begin // ecritEnTete
   writeln(fichier,'EVARISTE REGRESSI WINDOWS 1.0');
   writeln(fichier,symbReg,NbreVariab,' NOM VAR');
   for i := 0 to pred(NbreVariab) do
       ecritChaineRW3(grandeurs[indexVariab[i]].nom);
   writeln(fichier,symbReg,NbreVariab,' GENRE VAR');
   for i := 0 to pred(NbreVariab) do
       writeln(fichier,ord(grandeurs[indexVariab[i]].fonct.genreC));
   writeln(fichier,symbReg,NbreVariab,' LARGEUR VAR');
   if Fvaleurs.deltaBtn.down then CoeffDelta := 2 else CoeffDelta := 1;
   for i := 0 to pred(NbreVariab) do
       writeln(fichier,Fvaleurs.GridVariab.colWidths[i*coeffDelta+1]);
   avecUniteGraphe := false;
   writeln(fichier,symbReg,NbreVariab,' UNITE VAR');
   for i := 0 to pred(NbreVariab) do begin
       if grandeurs[indexVariab[i]].UniteDonnee
          then ecritChaineRW3(grandeurs[indexVariab[i]].nomUnite)
          else writeln(fichier);
       if grandeurs[indexVariab[i]].UniteGrapheImposee then avecUniteGraphe := true;
   end;
   if avecUniteGraphe  then begin
      writeln(fichier,symbReg,NbreVariab,' UNITE GRAPHE');
      for i := 0 to pred(NbreVariab) do
          if grandeurs[indexVariab[i]].UniteGrapheImposee
            then ecritChaineRW3(grandeurs[indexVariab[i]].UniteGraphe)
            else writeln(fichier);
   end;
   if indexTri<>0 then begin
      writeln(fichier,symbReg,'1 GrandeurTri');

      ecritChaineRW3(nomGrandeurTri);
   end;
   writeln(fichier,symbReg,NbreVariab,' FORMAT VAR');
   for i := 0 to pred(NbreVariab) do
       writeln(fichier,ord(grandeurs[indexVariab[i]].formatU));
   mecaOK := false;
   for i := 0 to pred(NbreVariab) do
       if grandeurs[indexVariab[i]].affSignif then begin
           mecaOK := true;
           break;
       end;
   if mecaOK then begin
      writeln(fichier,symbReg,NbreVariab,' AFF VAR');
      for i := 0 to pred(NbreVariab) do
          writeln(fichier,ord(grandeurs[indexVariab[i]].affSignif));
   end;
   if (stoechBecherGlb>1) or (stoechBuretteGlb>1) then begin
      writeln(fichier,symbReg,2,' DOSAGE');
      writeln(fichier,stoechBecherGlb);
      writeln(fichier,stoechBuretteGlb);
   end;
   writeln(fichier,symbReg,NbreVariab,' PRECISION VAR');
   for i := 0 to pred(NbreVariab) do
       writeln(fichier,ord(grandeurs[indexVariab[i]].precisionU));
   mecaOK := false;
   for i := 0 to pred(NbreVariab) do with grandeurs[indexVariab[i]] do
       if genreMecanique<>gm_position then begin
              mecaOK := true;
              break;
       end;
   if mecaOK then begin
      writeln(fichier,symbReg,NbreVariab,' MECA VAR');
      for i := 0 to pred(NbreVariab) do with grandeurs[indexVariab[i]] do
          if genreMecanique=gm_position
             then writeln(fichier,ord(gm_position))
             else writeln(fichier,intTostr(ord(genreMecanique))+' '+nomvarPosition);
   end;
   writeln(fichier,symbReg,NbreVariabExp,' SIGNIF VAR');
   for i := 0 to pred(NbreVariabExp) do
       ecritChaineRW3(grandeurs[indexVariab[i]].fonct.expression);
   avecIncert := false;
   for i := 0 to pred(NbreVariabExp) do with grandeurs[indexVariabExp[i]] do
       if (IncertCalcA.expression<>'') or (IncertCalcB.expression<>'') then begin
            avecIncert := true;
            break;
       end;
   if avecIncert then begin
      writeln(fichier,symbReg,NbreVariabExp,' INCERTITUDE');
      for i := 0 to pred(NbreVariabExp) do
          ecritChaineRW3(grandeurs[indexVariabExp[i]].IncertCalcA.expression);
      writeln(fichier,symbReg,NbreVariabExp,' INCERT_TYPEB');
      for i := 0 to pred(NbreVariabExp) do
          ecritChaineRW3(grandeurs[indexVariabExp[i]].IncertCalcB.expression);
   end;
   if (NbreConstExp+NbreConstPython)>0 then begin
      writeln(fichier,symbReg,NbreConstExp+NbreConstPython,' NOM CONST');
      for i := 0 to pred(NbreConstExp) do
          ecritChaineRW3(grandeurs[indexConstExp[i]].nom);
      if NbreConstPython>0 then begin
         for i := 0 to pred(NbreConstPython) do
            ecritChaineRW3(grandeurs[indexConstPython[i]].nom);
         writeln(fichier,symbReg,NbreConstExp+NbreConstPython,' GENRE CONST');
         for i := 0 to pred(NbreConstExp) do
            writeln(fichier,ord(grandeurs[indexConstExp[i]].fonct.genreC));
         for i := 0 to pred(NbreConstPython) do
            writeln(fichier,ord(grandeurs[indexConstPython[i]].fonct.genreC));
      end;
      if NbreConstExp>0 then begin
        writeln(fichier,symbReg,NbreConstExp,' UNITE CONST');
        for i := 0 to pred(NbreConstExp) do
          ecritChaineRW3(grandeurs[indexConstExp[i]].nomUnite);
        writeln(fichier,symbReg,NbreConstExp,' SIGNIF CONST');
        for i := 0 to pred(NbreConstExp) do
          ecritChaineRW3(grandeurs[indexConstExp[i]].fonct.expression);
        writeln(fichier,symbReg,NbreConstExp,' FORMAT CONST');
        for i := 0 to pred(NbreConstExp) do
          writeln(fichier,ord(grandeurs[indexConstExp[i]].formatU));
        writeln(fichier,symbReg,NbreConstExp,' PRECISION CONST');
        for i := 0 to pred(NbreConstExp) do
          writeln(fichier,ord(grandeurs[indexConstExp[i]].precisionU));
        writeln(fichier,symbReg,NbreConstExp,' AFF CONST');
        for i := 0 to pred(NbreConstExp) do
          writeln(fichier,ord(grandeurs[indexConstExp[i]].AffSignif));
        avecIncert := false;
        for i := 0 to pred(NbreConstExp) do with grandeurs[indexConstExp[i]] do
            if (IncertCalcA.expression<>'') or (IncertCalcB.expression<>'') then begin
              avecIncert := true;
              break;
            end;
        if avecIncert then begin
          writeln(fichier,symbReg,NbreConstExp,' INCERT CONST');
          for i := 0 to pred(NbreConstExp) do
              ecritChaineRW3(grandeurs[indexConstExp[i]].IncertCalcA.expression);
        end;
      end;
      if ListeConstAff.count>0 then begin
         writeln(fichier,symbReg,ListeConstAff.count,' PANEL CONST');
         for i := 0 to pred(ListeConstAff.count) do
             ecritChaineRW3(ListeConstAff[i]);
      end;
   end;
   if NbreConstTexte>0 then begin
      writeln(fichier,symbReg,NbreConstTexte,' NOM TC');
      for i := 0 to pred(NbreConstTexte) do
          ecritChaineRW3(grandeurs[indexConstTexte[i]].nom);
      writeln(fichier,symbReg,NbreConstTexte,' SIGNIF TC');
      for i := 0 to pred(NbreConstTexte) do
          ecritChaineRW3(grandeurs[indexConstTexte[i]].fonct.expression);
   end;
   (*
   if NbreConstGlb>0 then begin
      writeln(fichier,symbReg,NbreConstGlb,' INCERT GLB');
      for i := 0 to pred(NbreConstGlb) do
          writeln(fichier,grandeurs[indexConstGlb[i]].incertCourante);
   end;
   *)
   NbreParamNormal := NbreParam[paramNormal];
   if (NbreParamNormal>0) and modelePagesIndependantes then
       while (NbreParamNormal<MaxParametres) and
             (parametres[paramNormal,NbreParamNormal+1].nom<>'')
             do inc(NbreParamNormal);
   if NbreParamNormal>0 then begin
      writeln(fichier,symbReg,NbreParamNormal,' NOM PARAM');
      for i := 1 to NbreParamNormal do
          ecritChaineRW3(parametres[paramNormal,i].nom);
      writeln(fichier,symbReg,NbreParamNormal,' UNITE PARAM');
      for i := 1 to NbreParamNormal do
          ecritChaineRW3(parametres[paramNormal,i].nomUnite);
   end;
   if NbreParam[paramGlb]>0 then begin
       writeln(fichier,symbReg,NbreParam[paramGlb],' NOM GLB');
       for i := 1 to NbreParam[paramGlb] do
           ecritChaineRW3(parametres[paramGlb,i].nom);
       writeln(fichier,symbReg,NbreParam[paramGlb],' VALEUR PARAM GLB');
       for i := 1 to NbreParam[paramGlb] do
           writeln(fichier,parametres[paramGlb,i].valeurCourante);
   end;
   writeln(fichier,symbReg,'1 TRIGO');
   writeln(fichier,ord(AngleEnDegre));
   if not FFTperiodique then begin
      writeln(fichier,symbReg,'1 FFTPERIODE');
      writeln(fichier,ord(FFTperiodique));
   end;
   writeln(fichier,symbReg,'1 uniteSI');
   writeln(fichier,ord(uniteSIGlb));
   if avecEllipse then begin
      writeln(fichier,symbReg,'1 ELLIPSE');
      writeln(fichier,ord(avecEllipse));
   end;
   if avecChi2 then begin
      writeln(fichier,symbReg,'1 CHI2');
      writeln(fichier,ord(avecChi2));
   end;
   if FichierTrie then begin
      writeln(fichier,symbReg,'1 TRIDATA');
      writeln(fichier,ord(FichierTrie));
   end;
   if ModeAcquisition=AcqSimulation then begin
      writeln(fichier,symbReg,'1 LOGBOX');
      writeln(fichier,ord(Fvaleurs.logBox.checked));
      writeln(fichier,symbReg,'1 CBPAGESINDEP');
      writeln(fichier,ord(Fvaleurs.pagesIndependantesCB.checked));
   end;
   ecritMemoExpressions;
   if (NbreVariabPython+NbreConstPython>0) or Fvaleurs.modifPython then ecritMemoPython;
   ecritStrList(TexteModele,' MODELISATION');
   if FgrapheParam<>nil then
      ecritRichEdit(FgrapheParam.MemoModele,' MODELEGLB');
   writeln(fichier,symbReg,'2 ACQUISITION');
   writeln(fichier,NomModeAcq[ModeAcquisition]);
   writeln(fichier,nomExeAcquisition);
end; // ecritEnTete

Procedure ecritFenetres;
begin
         if FgrapheFFT<>nil then begin
            writeln(fichier,symbReg,'0 FOURIER');
            FgrapheFFT.ecritConfig;
         end;
         if (Fvaleurs<>nil) and (dispositionFenetre=dNone) then begin
            writeln(fichier,symbReg,'0 FenetreTxt');
            Fvaleurs.ecritConfig;
         end;
         if FgrapheVariab<>nil then begin
            writeln(fichier,symbReg,'0 GRAPHE VAR');
            FgrapheVariab.ecritConfig;
         end;
        if FgrapheEuler<>nil then begin
            writeln(fichier,symbReg,'0 EULER');
            FgrapheEuler.ecritConfig;
         end;
         if FgrapheParam<>nil then begin
            writeln(fichier,symbReg,'0 GRAPHE CONST');
            FgrapheParam.ecritConfig;
         end;
         if Fstatistique<>nil then begin
            writeln(fichier,symbReg,'0 STATISTIQUE');
            Fstatistique.ecritConfig;
         end;
end;// ecritFenetres

//  EcritFichierWin
var p : TCodePage;
begin
     Screen.cursor := crHourGlass;
     NomFichier := changeFileExt(NomFichier,'.rw3');
     AssignFile(fichier,NomFichier);
     Rewrite(fichier);
     try
     ecritEnTete;
     ecritFenetres;
     for p := 1 to NbrePages do ecritPage(p);
     CloseFile(fichier);
     modifFichier := false;
     except
         CloseFile(fichier);
         AfficheErreur(erWriteFile,0);
     end;
     Screen.cursor := crDefault;
end; // ecritFichierWin

function LitFichierWin : boolean;
var ligneList : TStringList;

procedure litPage;
var ligneWinaLire : boolean;

Procedure litValeurRepere(imax : integer);
var i,posTab : integer;
    valeur : double;
    texte : string;
begin
    for i := 1 to imax do begin
        readln(fichier,texte);
        posTab := pos(crTab,texte);
        valeur := strToFloatWin(copy(texte,1,pred(posTab)));
        texte := copy(texte,succ(posTab),length(texte)-posTab);
        pages[pageCourante].ajouteRepere(valeur,texte);
    end;
end;

Procedure litValeur(imax : integer);
var i,j,jmax : integer;
begin with pages[pageCourante] do begin
    nmes := imax;
    jmax := 0; // pour le compilateur
    try
    for j := 0 to pred(nmes) do begin
        litLigneWin;
        ligneList.DelimitedText := ligneWin;
        for i := 0 to pred(NbreVariabExp) do
            valeurVar[i,j] := StrToFloatWin(ligneList[i]);
        jmax := j;
    end;
    except
        nmes := jmax;
        repeat
           litLigneWin; // trop tard on a déjà mangé le $2
        until finFichierWin or
              (Length(LigneWin)=0) or
              charinset(ligneWin[1],[symbReg2,symbReg]);
        ligneWinAlire := (Length(LigneWin)>0) and
                         not charInSet(ligneWin[1],[symbReg2,symbReg]);
    end;
    for i := 0 to pred(NbreVariabExp) do
        if isNan(valeurVar[i,pred(nmes)]) then
             nmes := nmes-1;
end end;

Procedure litValeurPython(imax : integer);
var i,j : integer;
begin with pages[pageCourante] do begin
    try
    for j := 0 to pred(imax) do begin
        litLigneWin;
        ligneList.DelimitedText := ligneWin;
        for i := 0 to pred(NbreVariabPython) do
            ValeurVar[indexVariabPython[i],j] := StrToFloatWin(ligneList[i]);
    end;
    except
    end;
end end;

Procedure litIncertVariab(imax : integer);
var i,j : integer;
begin with pages[pageCourante] do begin
    try
    for j := 0 to pred(imax) do begin
        litLigneWin;
        ligneList.DelimitedText := ligneWin;
        for i := 0 to pred(NbreVariabExp) do
            incertVar[i,j] := StrToFloatWin(ligneList[i]);
    end;
    except
    end;
end end;

Procedure litEquivalence(imax : integer);
var i : integer;
    equivalence : Tequivalence;
begin
    for i := 1 to imax do begin
        equivalence := Tequivalence.Create(0,0,0,0,0,0,0,FgrapheVariab.graphes[1]);
        with equivalence do begin
           read(fichier,pente,ve,phe);
           read(fichier,x1,y1,x2,y2);
           read(fichier,x1i,y1i,x2i,y2i);
           readln(fichier);
        end;
        if equivalence.pente<>0
           then FgrapheVariab.graphes[1].Equivalences[pageCourante].Add(equivalence)
           else equivalence.Free
    end;
end;

procedure litValeurConstPython(imax : integer);
var i,j : integer;
begin
   for i := 0 to pred(imax) do begin
          j := indexConstPython[i];
          try
              if j=grandeurInconnue
                 then readln(fichier)
                 else readlnNombreWin(pages[pageCourante].ValeurConst[j]);
          except
              pages[pageCourante].ValeurConst[j] := 0;
          end;
   end;
end;

procedure litValeurConst(imax : integer);
var i,j : integer;
begin
   for i := 0 to pred(imax) do begin
          j := indexConstExp[i];
          try
              if j=grandeurInconnue
                 then readln(fichier)
                 else readlnNombreWin(pages[pageCourante].ValeurConst[j]);
          except
              pages[pageCourante].ValeurConst[j] := 0;
          end;
   end;
end;

var i,j,imax,choix,iVar : integer;
begin // litPage
   if ajoutePage then with pages[pageCourante] do begin
      commentaireP := ligneWin;
      litLigneWin;
      while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
        imax := NbreLigneWin(ligneWin);
        choix := 0;
        if pos('VALEUR',ligneWin)<>0 then begin
           if pos('VAR',ligneWin)<>0 then choix := 1 else
           if pos('CONST',ligneWin)<>0 then choix := 2 else
           if pos('PARAM',ligneWin)<>0 then choix := 3 else
           if pos('GLB',ligneWin)<>0 then choix := 5 else
           if pos('STAT',ligneWin)<>0 then choix := 6 else
           if pos('PYTHON',ligneWin)<>0 then choix := 7 else
           if pos('PYCONST',ligneWin)<>0 then choix := 8 else
        end else
        if pos('DEBUT',ligneWin)<>0 then choix := 10 else
        if pos('FIN',ligneWin)<>0 then choix := 11 else
        if pos(stOptions,ligneWin)<>0 then choix := 13 else
        if pos('INCERT',ligneWin)<>0 then begin
           if pos('VAR',ligneWin)<>0 then choix := 14 else
           if pos('CONST',ligneWin)<>0 then choix := 15 else
           if pos('GLB',ligneWin)<>0 then choix := 23 else
           if pos('PARAM',ligneWin)<>0 then choix := 20;
        end else
        if pos('STDEV',ligneWin)<>0 then begin
           if pos('PARAM',ligneWin)<>0 then choix := 21;
        end else
        if pos('ORIGINE TEMPS',ligneWin)<>0 then choix := 17 else
        if pos('TEXTE',ligneWin)<>0 then begin
           if pos('VAR',ligneWin)<>0 then choix := 18 else
           if pos('CONST',ligneWin)<>0 then choix := 19;
        end else
        if pos('EQUIVALENCE',ligneWin)<>0 then choix := 22 else
        if pos('INDICATEUR',ligneWin)<>0 then choix := 26 else
        if pos('MODELEPAGE',ligneWin)<>0 then choix := 24 else
        if (pos('BORNES FFT',ligneWin)<>0) and (imax=2) then choix := 25 else
        if pos('BITMAP',ligneWin)<>0 then choix := 16 else
        if pos('REPERE',ligneWin)<>0 then choix := 27;
        ligneWinalire := true;
        case choix of
             0 : for i := 1 to imax do litLigneWin;
             1 : litValeur(imax);
             2 : litValeurConst(imax);
             3 : for i := 1 to imax do readlnNombreWin(valeurParam[paramNormal,i]);
             6 : with stat do begin
                 Nbre := imax;
                 StatOK := true;
                 setLength(Donnees,iMax+1);
                 for i := 0 to pred(imax) do
                     readlnNombreWin(Donnees[i]);
             end;
             7 : litValeurPython(imax);
             8 : litValeurConstPython(imax);
             10 : for i := 1 to imax do readln(fichier,debut[i]);
             11 : for i := 1 to imax do readln(fichier,fin[i]);
             13 : begin
                active := litBooleanWin;
                experimentale := litBooleanWin;
             end;
             14 : litIncertVariab(imax);
             15 : for i := 0 to pred(imax) do begin
                 j := indexConstExp[i];
                 if j=grandeurInconnue
                    then readln(fichier)
                    else readlnNombreWin(incertConst[j]);
             end;
             16 : begin
                  litLigneWin;
                  NomFichierBitmap := ligneWin;
             end;
             17 : readln(fichier);
             18 : for i := 0 to pred(NbreVariabTexte) do begin
                      iVar := indexVariabTexte[i];
                      for j := 0 to pred(nmes) do
                          texteVar[iVar,j] := litLigneWinU;
             end;
             19 : for i := 0 to pred(imax) do begin
                      j := indexConstTexte[i];
                      litLigneWinU;
                      if j<>grandeurInconnue then begin
                            texteConst[j] := ligneWin;
                            valeurConst[j] := 0;
                      end;
             end;
             20 : for i := 1 to imax do readlnNombreWin(incertParam[i]);
             21 : for i := 1 to imax do readlnNombreWin(incert95Param[i]);
             22 : litEquivalence(imax);
             23 : for i := 0 to pred(imax) do begin
                      j := indexConstGlb[i];
                      if j=grandeurInconnue
                        then readln(fichier)
                        else readlnNombreWin(grandeurs[j].incertCourante);
             end;
             24 : begin
                 for i := 1 to imax do begin
                     litLigneWinU;
                     TexteModeleP.add(ligneWin);
                 end;
                 FGrapheVariab.ModelePagesIndependantesMenu.Checked := true;
                 ModelePagesIndependantes := true;
             end;
             25 : begin
                readln(fichier,debutFFT);
                readln(fichier,finFFT);
             end;
             26 : begin
                readln(fichier,iVar);
                try
                if (iVar>=0) and (iVar<indicateurDlg.indicateurs.count)
                   then indicateurP := Tindicateur(indicateurDlg.indicateurs[iVar])
                   else indicateurP := nil;
                except
                indicateurP := nil;
                end;
             end;
             27 : litValeurRepere(imax);
        end;
        if ligneWinaLire then litLigneWin;
     end;{while}
     if ModeAcquisition=AcqSimulation then begin
          MiniSimulation := valeurVar[0,0];
          MaxiSimulation := valeurVar[0,pred(nmes)];
          VerifMinMaxReal(MiniSimulation,MaxiSimulation);
          if MiniSimulation=MaxiSimulation then
             MaxiSimulation := MiniSimulation+1;
          valeurVar[0,pred(nmes)] := MaxiSimulation;
          MaxiSimulation := MaxiSimulation+(maxiSimulation-miniSimulation)/pred(nmes);
          valeurVar[0,0] := MiniSimulation;
      end;
   end
   else litLigneWin;
end; // litPage

procedure litListe;

Procedure litLargeurVariab(imax : integer);
var i : integer;
    largeurDefaut : integer;
begin
    try
    for i := 0 to pred(imax) do begin
        largeurColonnesVariab[i] := StrToInt(ligneWin);
        if grandeurs[i].fonct.genreC=g_texte then
           largeurColonneTexte := largeurColonnesVariab[i];
        litLigneWin;
    end;
    largeurDefaut := largeurColonnesVariab[1];
    for i := imax to maxGrandeurs do
        largeurColonnesVariab[i] := largeurDefaut;
    FValeurs.MajWidthsVariab := true;
    except
    end;
end;

(*
Procedure litLargeurConst(imax : integer);
var i : integer;
begin
    try
    for i := 0 to pred(imax) do begin
        largeurColonnesConst[i] := StrToInt(ligneWin);
        litLigneWin;
    end;
    FValeurs.MajWidthsConst := true;
    except
    end;
end;
*)

procedure litMemoGrandeurs(imax : integer);

Procedure VerifBoucle;
var LigneMaj : string;

Function VerifN(const strN : string) : boolean;
var posN : integer;
begin
    posN := pos(strN,ligneMaj);
    result := posN>10;
    if result then begin
       delete(ligneWin,posN,length(strN));
       insert(' '+grandeurs[cNombre].nom,ligneWin,posN)
    end;
end;

begin
     LigneMaj := UpperCase(LigneWin);
     if copy(ligneMaj,1,4)='FOR ' then begin
         if verifN(' NOMBRE') then exit;
         if verifN(' NBRE') then exit;
         if verifN(' NPOINTS') then exit;
         if verifN(' N') then exit;
     end;
end;

Procedure VerifEnvNeg;
var LigneMaj : string;
var posN : integer;
begin
    LigneMaj := UpperCase(LigneWin);
    posN := pos('ENVNEG(',ligneMaj);
    result := posN>0;
    if result then begin
       delete(ligneWin,posN+3,3);
       posN := pos(')',ligneWin);
       if posN>0 then insert(',min',ligneWin,posN);
    end;
end;

var i : integer;
begin
     for i := 1 to imax do begin
         VerifBoucle;
         VerifEnvNeg;
         Fvaleurs.Memo.lines.add(ligneWin);
         litLigneWinU;
     end;
     Fvaleurs.Memo.lines.Add('');
end; // litMemoGrandeurs

procedure litMemoPython(imax : integer);
var i : integer;
begin
     Fvaleurs.MemoSource.clear;
     for i := 1 to imax do begin
         Fvaleurs.MemoSource.lines.add(ligneWin);
         litLigneWin;
     end;
     Fvaleurs.MemoSource.lines.Add('');
end;

procedure litNom(Agenre : TgenreGrandeur;imax : integer);
var i : integer;
begin
     for i := 1 to imax do begin
         if lignewin='Longueur d''''onde' then lignewin := lambdaMin;
         if lignewin='%' then lignewin := 'T';
         AjouteExperimentale(ligneWin,Agenre);
         litLigneWinU
     end;
end;

procedure litNomConstTexte(imax : integer);
var i : integer;
    index : integer;
begin
     for i := 1 to imax do begin
         index := AjouteExperimentale(ligneWin,constante);
         grandeurs[index].fonct.genreC := g_texte;
         litLigneWinU
     end;
     construireIndex;
end;

procedure litNomParam(genre : TgenreGrandeur;imax : integer;affecte : boolean);
var i : integer;
begin
     if affecte then NbreParam[genre] := imax;
     for i := 1 to imax do begin
         parametres[genre,i].nom := ligneWin;
         litLigneWinU
     end;
end;

procedure litGenreVariab(Nbrei : integer);
var i,iTexte : integer;
    genre : TgenreCalcul;
begin
     iTexte := -1;
     for i := 0 to pred(Nbrei) do begin
         genre := TgenreCalcul(StrToInt(ligneWin));
         if abs(ord(genre)-ord(g_texte))<2 then genre := g_texte;
         // pour régler le pb de décalage intempestif de g_texte !!!
         if genre<>g_experimentale then begin
            grandeurs[i].fonct.genreC := genre;
            dec(NbreVariabExp);
         end;
         if genre=g_texte then begin
            inc(NbreVariabTexte);
            iTexte := i;
         end;
         litLigneWin
     end;
     if (iTexte>0) and  (iTexte<NbreVariabExp) then begin
        transfereVariabE(iTexte,NbreVariabExp);
     // mettre g_texte à la fin
     end;
     construireIndex;
end;

procedure litGenreConst(Nbrei : integer);
var i : integer;
    genre : TgenreCalcul;
begin
     for i := 0 to pred(Nbrei) do begin
         genre := TgenreCalcul(StrToInt(ligneWin));
         if genre<>g_experimentale then begin
            grandeurs[indexConstExp[i]].fonct.genreC := genre;
            dec(NbreConstExp);
         end;
         litLigneWin
     end;
     construireIndex;
end;

procedure litUnite(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].NomUnite := ligneWin;
         litLigneWinU
     end;
end;

procedure litUniteGraphe(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].UniteGraphe := ligneWin;
         grandeurs[i].UniteGrapheImposee := grandeurs[i].UniteGraphe<>'';
         litLigneWinU
     end;
end;

procedure litAff(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].affSignif := ligneWin<>'0';
         litLigneWin
     end;
end;

procedure litMeca(Nbre : integer);
var i : integer;
    k : integer;
begin
     for i := 0 to pred(Nbre) do with grandeurs[i] do begin
         k := strToInt(ligneWin[1]);
         genreMecanique := TgenreMecanique(k);
         if genreMecanique>gm_position then begin
            nomVarPosition := copy(ligneWin,3,length(ligneWin));
            k := indexNom(nomVarPosition);
            if k=grandeurInconnue then nomVarPosition := '';
         end;
         litLigneWin
     end;
end;

procedure litUniteParam(imax : integer);
var i : integer;
begin
     for i := 1 to imax do begin
         parametres[paramNormal,i].NomUnite := ligneWin;
         litLigneWin
     end;
end;

procedure litValeurParamGlb(imax : integer);
var i : integer;
begin
     for i := 1 to imax do begin
         Parametres[paramGlb,i].valeurCourante := StrToFloatWin(ligneWin);
         litLigneWin
     end;
end;

procedure litSignif(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].fonct.expression := ligneWin;
         litLigneWin
     end;
end;

procedure litPrecision(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         try
         grandeurs[i].precisionU := strToInt(ligneWin);
         except
         end;
         litLigneWin
     end;
end;

procedure litFormat(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].formatU := TnombreFormat(strToInt(ligneWin));
         litLigneWin
     end;
end;

procedure litIncertitude(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         ConvertitPrefixeExpression(ligneWin);
         grandeurs[i].IncertCalcA.expression := ligneWin;
         grandeurs[i].compileIncertitude;
         litLigneWin;
     end;
end;

procedure litIncertitudeB(iDebut,Nbrei : integer);
var i : integer;
begin
     for i := iDebut to pred(iDebut+Nbrei) do begin
         grandeurs[i].IncertCalcB.expression := ligneWin;
         ConvertitPrefixeExpression(grandeurs[i].IncertCalcB.expression);
         grandeurs[i].compileIncertitude;
         litLigneWin;
     end;
end;

Procedure litAcquisition(Nligne : byte);
var i : TmodeAcquisition;
    j : byte;
begin
   ModeAcquisition := AcqCan;
   LigneWin := AnsiUpperCase(ligneWin);
   for i := low(TmodeAcquisition) to high(TmodeAcquisition) do
       if ligneWin=NomModeAcq[i] then begin
          ModeAcquisition := i;
          break;
       end;
   if Nligne>=2 then begin
      litLigneWin;
      nomExeAcquisition := ligneWin;
   end;
   for j := 3 to Nligne do litLigneWin;
   litLigneWin;
end;

procedure litModeleGlb(imax : integer);
var i : integer;
begin
    FregressiMain.GrapheConstOpen;
    FgrapheParam.MajModelePermis := false;
    FgrapheParam.MemoModele.Clear;
    for i := 0 to pred(imax) do begin
         FgrapheParam.MemoModele.Lines.Add(ligneWin);
         litLigneWinU;
    end;
    FgrapheParam.MajModelePermis := true;
end;

procedure litStrList(T : TstringList;imax : integer);
var i : integer;
begin
     for i := 1 to imax do begin
         T.add(ligneWin);
         litLigneWinU;
     end;
end;

Procedure litIncertConstGlb(imax : integer);
var i : integer;
begin
    try
    for i := 0 to pred(imax) do begin
        litLigneWin;
       // grandeurs[indexConstGlb[i]].incertCourante := StrToFloatWin(ligneWin);
    end;
    except
    end;
end;

Procedure litChoix(choix : integer);
var i : integer;
    Nligne : integer;
begin
    Nligne := NbreLigneWin(ligneWin);
    litLigneWinU;
    case choix of
         0 : begin
            for i := 1 to Nligne do litLigneWin;
            while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
               Nligne := NbreLigneWin(ligneWin);
               for i := 0 to Nligne do litLigneWin;
            end;
         end;
         1 : litPage;
         2 : FgrapheVariab.litConfig;
         3 : begin
            FregressiMain.FourierOpen;
            FgrapheFFT.litConfig;
         end;
         4 : litNom(variable,Nligne);
         5 : litNom(constante,Nligne);
         6 : litUnite(NbreVariab,Nligne);
         7 : litUnite(0,Nligne);
         8 : litIncertitude(0,Nligne);
         9 : begin
            FregressiMain.GrapheConstOpen;
            FgrapheParam.litConfig;
         end;
         10 : LitMemoGrandeurs(Nligne);
         11 : LitMemoPython(Nligne);
         12 : LitStrList(TexteModele,Nligne);
         13 : LitModeleGlb(Nligne);
         14 : LitAcquisition(Nligne);
         15 : begin
            FregressiMain.StatistiqueOpen;
            Fstatistique.litConfig;
         end;
         16 : begin
             Fvaleurs.logBox.checked := ligneWin<>'0';
             logSimulation := ligneWin<>'0';
             litLigneWin;
         end;
         17 : begin
             AngleEnDegre := ligneWin<>'0';
             litLigneWin;
         end;
         18 : litGenreVariab(Nligne);
         19 : litSignif(NbreVariab,Nligne);
         20 : litSignif(0,Nligne);
         22 : litFormat(NbreVariab,Nligne);
         23 : litFormat(0,Nligne);
         24 : litPrecision(NbreVariab,Nligne);
         25 : litPrecision(0,Nligne);
         26 : litNomParam(paramNormal,Nligne,true);
         28 : litUniteParam(Nligne);
         29 : begin
             uniteSIGlb := ligneWin<>'0';
             litLigneWin;
         end;
         30 : litNomParam(paramNormal,Nligne,false);
         31 : begin
             litLigneWin;
             litLigneWin;
         end;
         32 : litNomParam(paramGlb,Nligne,true);
         33 : litValeurParamGlb(Nligne);
         34 : litAff(NbreVariab,Nligne);
         35 : litAff(0,Nligne);
         36 : litMeca(Nligne);
         38 : begin
             Fvaleurs.PagesIndependantesCB.checked := ligneWin<>'0';
             litLigneWin;
         end;
         39 : litNomConstTexte(Nligne);
         40 : litSignif(NbreVariab+NbreConstExp,Nligne);
         42 : begin
             avecEllipse := ligneWin<>'0';
             litLigneWin;
         end;
         43 : begin
             nomGrandeurTri := ligneWin;
             litLigneWin;
         end;
         44 : begin
             FichierTrie := ligneWin<>'0';
             litLigneWin;
         end;
         45 : Fvaleurs.litConfig;
         46 : begin
             avecChi2 := ligneWin<>'0';
             litLigneWin;
         end;
         47 : begin
              stoechBecherGlb := strToInt(ligneWin);
              litLigneWin;
              stoechBuretteGlb := strToInt(ligneWin);
              litLigneWin;
         end;
         48 : begin
            FregressiMain.StatistiqueOpen;
            Fstatistique.litConfig;
         end;
         49 : litNom(constanteGlb,Nligne);
         50 : begin
            FregressiMain.GrapheEulerOpen;
            FGrapheEuler.litConfig;
         end;
         51 : litGenreConst(Nligne);
         52 : litIncertConstGlb(Nligne);
         53 : litIncertitudeB(0,Nligne);
         54 : litLargeurVariab(Nligne);
    //     55 : litLargeurConst(Nligne);
         56 : litUniteGraphe(0,Nligne);
         57 : begin
             FFTperiodique := ligneWin<>'0';
             litLigneWin;
         end;
         58 : litIncertitudeB(NbreVariab,Nligne);
         59 : litIncertitude(NbreVariab,Nligne);
   end;
end;

begin
    if ligneWin='PAGESINDEP' then ligneWin := 'CBPAGESINDEP';
    if Pos('PAGE',ligneWin)=4 then litChoix(1)
    else if Pos('GRAPHE',ligneWin)=4 then begin
       if Pos('CONST',ligneWin)<>0
          then litChoix(9)
          else litChoix(2);
    end
    else if Pos('FOURIER',ligneWin)=4 then litChoix(3)
    else if Pos('STATISTIQUE',ligneWin)=4 then litChoix(48)
    else if Pos('NOM',ligneWin)<>0 then begin
        if Pos('CONST',ligneWin)<>0 then litChoix(5)
        else if Pos('VAR',ligneWin)<>0 then litChoix(4)
        else if Pos('PARAM',ligneWin)<>0 then litChoix(26)
        else if Pos('SAUVE',ligneWin)<>0 then litChoix(30)
        else if Pos('GLB',ligneWin)<>0 then litChoix(32)
        else if Pos('TC',ligneWin)<>0 then litChoix(39) // texte const
        else litChoix(0)
    end
    else if (Pos('MECA',ligneWin)<>0) and
       (Pos('VAR',ligneWin)<>0) then litChoix(36)
    else if Pos('GENRE',ligneWin)<>0 then begin
       if Pos('VAR',ligneWin)<>0 then litChoix(18)
       else if Pos('CONST',ligneWin)<>0 then litChoix(51)
       else litChoix(0)
    end
    else if Pos('LARGEUR',ligneWin)<>0 then begin
       if Pos('VAR',ligneWin)<>0 then litChoix(54)
//       else if Pos('CONST',ligneWin)<>0 then litChoix(55)
       else litChoix(0)
    end
    else if Pos('UNITE',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(6)
       else if Pos('VAR',ligneWin)<>0 then litChoix(7)
       else if Pos('PARAM',ligneWin)<>0 then litChoix(28)
       else if Pos('GRAPHE',ligneWin)<>0 then litChoix(56)
       else litChoix(0)
    end
    else if Pos('FORMAT',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(22)
       else if Pos('VAR',ligneWin)<>0 then litChoix(23)
       else litChoix(0)
    end
    else if Pos('AFF',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(34)
       else if Pos('VAR',ligneWin)<>0 then litChoix(35)
       else litChoix(0)
    end
    else if Pos('PRECISION',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(24)
       else if Pos('VAR',ligneWin)<>0 then litChoix(25)
       else litChoix(0)
    end
    else if Pos('SIGNIF',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(19)
       else if Pos('VAR',ligneWin)<>0 then litChoix(20)
       else if Pos('TC',ligneWin)<>0 then litChoix(40) { texte const }
       else litChoix(0)
    end
    else if Pos('INCERT',ligneWin)<>0 then begin
       if Pos('CONST',ligneWin)<>0 then litChoix(59)
       else if Pos('TYPEB',ligneWin)<>0 then litChoix(53)
       else if Pos('CONST',ligneWin)<>0 then litChoix(59)
       else if Pos('GLB',ligneWin)<>0 then litChoix(52)
    //    else if Pos('const typeb',ligneWin)<>0 then litChoix(58)
       else if Pos('TUDE',ligneWin)<>0 then litChoix(8)
       else litchoix(0)
    end
    else if Pos('GRANDEURS',ligneWin)<>0 then begin
       if Pos('MEMO',ligneWin)<>0
          then litChoix(10)
          else litChoix(0)
    end
    else if Pos('MODELISATION',ligneWin)<>0 then litChoix(12)
    else if Pos('PYTHON',ligneWin)<>0 then litChoix(11)
    else if Pos('TRIGO',ligneWin)<>0 then litChoix(17)
    else if Pos('CHI2',ligneWin)<>0 then litChoix(46)
    else if Pos('ELLIPSE',ligneWin)<>0 then litChoix(42)
    else if Pos('uniteSI',ligneWin)<>0 then litChoix(29)
    else if Pos('TRIDATA',ligneWin)<>0 then litChoix(44)
    else if Pos('MODELEGLB',ligneWin)<>0 then litChoix(13)
    else if Pos('ACQUISITION',ligneWin)<>0 then litChoix(14)
    else if Pos('STATISTIQUE',ligneWin)=4 then litChoix(15)
    else if Pos('LOGBOX',ligneWin)=4 then litChoix(16)
    else if Pos('CBPAGESINDEP',ligneWin)=4 then litChoix(38)
    else if Pos('DATETIME',ligneWin)=4 then litChoix(31)
    else if pos('VALEUR PARAM GLB',ligneWin)<>0 then litChoix(33)
    else if pos('GrandeurTri',ligneWin)<>0 then litChoix(43)
    else if pos('FenetreTxt',ligneWin)<>0 then litChoix(45)
    else if pos('DOSAGE',ligneWin)<>0 then litChoix(47)
    else if pos('FFTPERIODE',ligneWin)<>0 then litChoix(57)
    else litChoix(0)
end; // litListe

procedure litFichierRW3;
begin
     litLigneWin;
     FichierTrie := dataTrieGlb;
     while (Length(LigneWin)>0) and (ligneWin[1]=symbReg) do
         litListe;
     if pageCourante>0 then begin
        LitFichierWin := true;
        pages[pageCourante].affecteConstParam(false);
        pages[pageCourante].affecteVariableP(false);
     end;
end;

var i,j : integer;
    index : integer;
    trouve : boolean;
    p : TcodePage;
begin // LitFichierWin
     LectureFichier := true;
     result := false;
     strErreurFichier := erFileData;
     ModeAcquisition := AcqClavier;
     FileMode := fmOpenRead;
     FGrapheVariab.ModelePagesIndependantesMenu.Checked := false;
     ModelePagesIndependantes := false;
     AssignFile(fichier,NomFichierData);
     Reset(fichier);
     finFichierWin := false;
     ligneList := TStringList.create;
     ligneList.delimiter := ' ';
     try
     if not enTeteRW3 then begin
            afficheErreur(erFormat,0);
            CloseFile(fichier);
            LectureFichier := false;
            exit
     end;
     for i := 0 to MaxParamAnim do paramAnimManuelle[i].init;
     litFichierRW3;
     except
         strErreurFichier := erReadFile;
         result := false;
     end;
     CloseFile(fichier);
     FileMode := fmOpenReadWrite;
     for i := pred(NbreVariabTexte) downto 0 do begin
         index := indexVariabTexte[i];
         trouve := false;
         for p := 1 to NbrePages do
             trouve := trouve or (pages[p].FtexteVar[index]<>nil);
         if not trouve then begin
            grandeurs[index].fonct.genreC := g_forward;
            for j := succ(i) to pred(NbreVariabTexte) do
                indexVariabTexte[j-1] := indexVariabTexte[j];
            dec(NbreVariabTexte);
         end;
     end;
     ligneList.free;
     LectureFichier := false;
end; // LitFichierWin

Procedure AjouteFichier(const NomFichier : string);
var FichierOK : boolean;
    DecodeVariab,DecodeConst : array[TcodeGrandeur] of TcodeGrandeur;
    NomFichierCourt : string;
    NbreVariabFichier,NbreVariabExpFichier : integer;

procedure litGenreVariab(Nbrei : integer);
var i,j : integer;
    genre : TgenreCalcul;
    debut : string;
begin
     NbreVariabExpFichier := 0;
     for i := 0 to pred(Nbrei) do begin
         litLigneWin;
         genre := TgenreCalcul(StrToInt(ligneWin));
         if genre=g_experimentale
         then begin
            inc(NbreVariabExpFichier);
            if (grandeurs[decodeVariab[i]].fonct.genreC<>g_experimentale) and
                OKReg('Transformer '+grandeurs[decodeVariab[i]].nom+' en grandeur experimentale ?',0) then begin
                     grandeurs[decodeVariab[i]].fonct.genreC := g_experimentale;
                     construireIndex;
                     debut := grandeurs[decodeVariab[i]].nom+'=';
                     for j := 0 to Fvaleurs.Memo.Lines.Count-1 do begin
                         if pos(debut,Fvaleurs.Memo.Lines[j])=1 then begin
                            Fvaleurs.Memo.Lines.Delete(j);
                            break;
                         end;
                     end;
                end;
         end
         else begin
            if grandeurs[decodeVariab[i]].fonct.genreC=g_experimentale
               then afficheErreur('Valeurs de '+grandeurs[decodeVariab[i]].nom+' non données dans le fichier importé',0);
         end;
     end;
     litLigneWin
end;

procedure litExpression(imax : integer);
var i,posEgal,k : integer;
    nom : string;
begin
    for i := 0 to pred(imax) do begin
        litLigneWinU;
        PosEgal := Pos('=',ligneWin);
        if PosEgal>0 then begin
           nom := copy(ligneWin,1,posEgal-1);
           PosEgal := Pos('[',ligneWin);
           if PosEgal>0 then
              nom := copy(nom,1,posEgal-1);
           PosEgal := Pos('''',ligneWin);
           if PosEgal>0 then
              nom := copy(nom,1,posEgal-1);
           k := indexNom(nom);
           if k=grandeurInconnue then
              Fvaleurs.Memo.lines.add(ligneWin);
        end
        else Fvaleurs.Memo.lines.add(ligneWin); // commentaire
    end;
    litLigneWinU;
end;

procedure litPage;
var ligneList : TStringList;

Procedure litValeur(imax : integer);
var i,j,jmax : integer;
begin with pages[pageCourante] do begin
    nmes := imax;
    jmax := 0; // pour le compilateur
    try
    for j := 0 to pred(nmes) do begin
        litLigneWin;
        ligneList.DelimitedText := ligneWin;
        for i := 0 to pred(NbreVariabExpFichier) do
            valeurVar[decodeVariab[i],j] := StrToFloatWin(ligneList[i]);
     { TODO : mettre à 1 les variables non définies dans le fichier }
        jmax := j;
    end;
    except
        nmes := jmax;
    end;
end end;

Procedure litValeurRepere(imax : integer);
var i,posTab : integer;
    valeur : double;
    texte : string;
begin
    for i := 1 to imax do begin
        readln(fichier,texte);
        posTab := pos(crTab,texte);
        valeur := strToFloatWin(copy(texte,1,pred(posTab)));
        texte := copy(texte,succ(posTab),length(texte)-posTab);
        pages[pageCourante].ajouteRepere(valeur,texte);
    end;
end;

var i,j,imax,choix,iVar : integer;
begin
   if ajoutePage then with pages[pageCourante] do begin
      commentaireP := nomFichierCourt+ligneWin;
      ligneList := TStringList.create;
      ligneList.delimiter := ' ';
      litLigneWin;
      while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
        imax := NbreLigneWin(ligneWin);
        choix := 0;
        if pos('VALEUR',ligneWin)<>0 then begin
           if pos('VAR',ligneWin)<>0 then choix := 1 else
           if pos('CONST',ligneWin)<>0 then choix := 2 else
           if pos('PARAM',ligneWin)<>0 then choix := 5;
        end else
        if pos('TEXTE',ligneWin)<>0 then begin
           if pos('VAR',ligneWin)<>0 then choix := 3 else
           if pos('CONST',ligneWin)<>0 then choix := 4;
        end else
        if pos('REPERE',ligneWin)<>0 then choix := 7;
        case choix of
             0 : for i := 1 to imax do litLigneWin;
             1 : litValeur(imax);
             2 : for i := 0 to pred(imax) do begin
                 j := decodeConst[i];
                 if j=grandeurInconnue
                    then readln(fichier)
                    else readlnNombreWin(ValeurConst[j]);
             end;
             3 : for i := 0 to pred(NbreVariabTexte) do begin
                      iVar := indexVariabTexte[i];
                      for j := 0 to pred(imax) do
                          texteVar[iVar,j] := litLigneWinU;
             end;
             4 : for i := 0 to pred(imax) do begin
                     j := indexConstTexte[i];
                     litLigneWinU;
                     if j<>grandeurInconnue then
                        texteConst[j] := ligneWin;
             end;
             5 : for i := 1 to imax do readlnNombreWin(valeurParam[paramNormal,i]);
             7 : litValeurRepere(imax);
        end;
        litLigneWin;
     end;
   end
   else litLigneWin;
   ligneList.free;
end; // litPage

Procedure litListe;

Procedure LitVariab(N : integer);
var i,j,k,kc,p : integer;
    nomCourant : string;
    posEgal,posVar : integer;
begin
  NbreVariabFichier := N;
  NbreVariabExpFichier := N; // par défaut avant lecture du genre
  for i := 0 to pred(NbreVariabFichier) do begin
        nomCourant := litLigneWinU;
        if nomCourant='Longueur d''''onde' then nomCourant := lambdaMin;
        if nomCourant='%' then nomCourant := 'T';
        k := indexNom(nomCourant);
        if (i<NbreVariabExp) then begin
           if (k=grandeurInconnue) then begin
             if FusionDlg=nil then
                Application.CreateForm(TFusionDlg, FusionDlg);
             FusionDlg.nom := nomCourant;
             case FusionDlg.showModal of
                 idYes  : begin // nouvelle colonne expérimentale
                    k := AjouteExperimentale(NomCourant,variable);
                    for p := 1 to pageCourante do with pages[p] do
                       for j := 0 to nmes - 1 do
                           valeurVar[k,j] := 1;
                 end;
                 idNo : begin // première colonne libre
                    k := indexNom(FusionDlg.nomCB.text);
                    if k=grandeurInconnue then begin
                      kc := 0;
                      for j := 0 to pred(i) do
                        if decodeVariab[j]=kc then
                         repeat inc(kc)
                         until (grandeurs[kc].fonct.genreC=g_experimentale) or
                           (grandeurs[kc].genreG=variable) or
                           (kc=NbreGrandeurs);
                      if (grandeurs[kc].fonct.genreC=g_experimentale) or
                       (grandeurs[kc].genreG=variable) then k := kc;
                    end;
                 end;// idNo
                 idCancel : begin
                    afficheErreur(erFileAdd,0);
                    FichierOK := false;
                    exit;
                 end;
             end;// case
           end
           else begin // grandeur connue
             if (grandeurs[k].fonct.genreC<>g_experimentale) then
                if OKReg('Transformer '+grandeurs[decodeVariab[i]].nom+' en grandeur experimentale ?',0) then begin
                     grandeurs[decodeVariab[i]].fonct.genreC := g_experimentale;
                     construireIndex;
                     for j := 0 to Fvaleurs.Memo.Lines.Count-1 do begin
                         posEgal := pos('=',Fvaleurs.Memo.Lines[j]);
                         posVar := pos(grandeurs[k].nom,Fvaleurs.Memo.Lines[j]);
                         if (posVar>0) and (posVar<posEgal) then begin
                            Fvaleurs.Memo.Lines.Delete(j);
                            break;
                         end;
                     end;
                end
                else begin
                   afficheErreur(erFileAdd,0);
                   FichierOK := false;
                   exit;
                end;
             if grandeurs[k].genreG<>variable then begin
               afficheErreur(erFileAdd,0);
               FichierOK := false;
               exit;
             end;
           end;
        end; // (i<NbreVariabExp)
        DecodeVariab[i] := k;
  end; // for i
  litLigneWinU;
end;

Procedure LitConst(NbreConstFichier : integer);
var i,k : integer;
begin
    for i := 0 to pred(NbreConstFichier) do begin
        litLigneWinU;
        k := indexNom(ligneWin);
        if k=grandeurInconnue then
           k := ajouteExperimentale(ligneWin, constante);
        decodeConst[i] := k;
        if (i<NbreConstExp) and
           ((k=grandeurInconnue) or
           ((grandeurs[k].fonct.genreC<>g_experimentale) or
            (grandeurs[k].genreG<>constante))) then begin
                 afficheErreur(erFileAdd,0);
                 FichierOK := false;
                 exit;
        end;
  end;
  litLigneWinU;
end;

var
    Nligne,i : integer;
begin
    Nligne := NbreLigneWin(ligneWin);
    if pos('NOM CONST',ligneWin)<>0
        then LitConst(Nligne)
        else if pos('NOM VAR',ligneWin)<>0
        then LitVariab(Nligne)
        else if pos('GENRE VAR',ligneWin)<>0
        then LitGenreVariab(Nligne)
        else if pos('MEMO GRANDEURS',ligneWin)<>0
        then litExpression(Nligne)
        else if pos('PAGE',ligneWin)<>0
        then begin
            litLigneWinU;
            litPage
        end
        else begin
           for i := 0 to Nligne do litLigneWin;
           while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
               Nligne := NbreLigneWin(ligneWin);
               for i := 0 to Nligne do litLigneWin;
            end;
       end;
end; // litListe

begin
     FileMode := fmOpenRead;
     AssignFile(Fichier,nomFichier);
     Reset(Fichier);
     finFichierWin := false;
     litLigneWin;
     if pos('REGRESSI WINDOWS',ligneWin)=0
          then AfficheErreur(erFormat,0)
          else begin
              litLigneWin;
              nomFichierCourt := extractFileName(NomFichier)+' : ';
              FichierOK := true;
              while fichierOK and
                   (ligneWin<>'') and
                   (ligneWin[1]=symbReg) do litListe;
          end;
     closeFile(fichier);
     FileMode := fmOpenReadWrite;
end; // AjouteFichier

procedure LitCalcul(const FileName : string);
var termine : boolean;

Function LitCalculWin : boolean;

Procedure litListe;
var DecodeConst : array[TcodeGrandeur] of TcodeGrandeur;

procedure litMemoGrandeurs(imax : integer);
var i : integer;
    posEgal : integer;
    nomAjout : string;
    Ajoute : boolean;
begin
     Fvaleurs.Memo.lines.Add('''Ajout');
     for i := 1 to imax do begin
         litLigneWinU;
         posEgal := pos('=',ligneWin);
         Ajoute := posEgal=0;
         if not Ajoute then begin
             nomAjout := copy(ligneWin,1,pred(posEgal));
             Ajoute := indexNom(nomAjout)=grandeurInconnue;
         end;
         if ajoute then Fvaleurs.Memo.lines.add(ligneWin);
     end;
     Fvaleurs.Memo.lines.Add('');
     LitLigneWinU;
end;

procedure litMemoPython(imax : integer);
var i : integer;
begin
     Fvaleurs.MemoSource.clear;
     for i := 1 to imax do begin
         litLigneWin;
         Fvaleurs.MemoSource.lines.add(ligneWin);
     end;
     Fvaleurs.MemoSource.lines.Add('');
     LitLigneWinU;
end;

procedure litModele(imax : integer);
var i : integer;
begin
    FgrapheVariab.MemoModele.Clear;
    TexteModele.Clear;
    for i := 0 to pred(imax) do begin
         litLigneWinU;
         TexteModele.add(ligneWin);
         FgrapheVariab.MemoModele.Lines.Add(ligneWin);
    end;
    litLigneWin;
end;

procedure litModeleGlb(imax : integer);
var i : integer;
begin
    FregressiMain.GrapheConstOpen;
    FgrapheParam.MemoModele.Clear;
    for i := 0 to pred(imax) do begin
         litLigneWinU;
         FgrapheParam.MemoModele.Lines.Add(ligneWin);
    end;
    litLigneWin;
end;

Procedure LitVariab(N : integer);
var i,k : integer;
begin
  if N<NbreVariabExp then begin
     afficheErreur(erFileCalc,0);
     result := false;
     exit;
  end;
  for i := 0 to pred(N) do begin
        litLigneWinU;
        k := indexNom(ligneWin);
        if (i<NbreVariabExp) and
           ((k=grandeurInconnue) or
           ((grandeurs[k].fonct.genreC<>g_experimentale) or
            (grandeurs[k].genreG<>variable))) then begin
              afficheErreur(erFileCalc,0);
              result := false;
              exit;
        end;
  end;
  litLigneWin;
end;

Procedure LitConst(NbreConstFichier : integer);
var i,k : integer;
begin
    for i := 0 to pred(NbreConstFichier) do begin
        litLigneWinU;
        k := indexNom(ligneWin);
        if k=grandeurInconnue then
           k := ajouteExperimentale(ligneWin, constante);
        decodeConst[i] := k;
        if (i<NbreConstExp) and
           ((k=grandeurInconnue) or
           ((grandeurs[k].fonct.genreC<>g_experimentale) or
            (grandeurs[k].genreG<>constante))) then begin
                 afficheErreur(erFileCalc,0);
                 result := false;
                 exit;
        end;
  end;
  litLigneWin;
end;

procedure litValeurConst;
var i,j,imax : integer;
begin with pages[pageCourante] do begin
    litLigneWinU;
    litLigneWin;
    while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
        imax := NbreLigneWin(ligneWin);
        if (pos('VALEUR',ligneWin)<>0) and (pos('CONST',ligneWin)<>0)
           then begin
              for i := 0 to pred(imax) do begin
                 j := decodeConst[i];
                 try
                    readlnNombreWin(ValeurConst[j]);
                 except
                    ValeurConst[j] := 0;
                 end;
              end;
              pages[pageCourante].affecteConstParam(false);
              break;
           end
           else for i := 0 to imax do litLigneWin;
        end;
   end; // while
end;

var
    Nligne,i : integer;
begin
    Nligne := NbreLigneWin(ligneWin);
    if pos('NOM CONST',ligneWin)<>0
        then LitConst(Nligne)
        else if pos('NOM VAR',ligneWin)<>0
        then LitVariab(Nligne)
        else if pos('MEMO GRANDEURS',ligneWin)<>0
        then LitMemoGrandeurs(Nligne)
        else if pos('MEMO PYTHON',ligneWin)<>0
        then LitMemoPython(Nligne)
        else if pos('MODELISATION',ligneWin)<>0
        then LitModele(Nligne)
        else if pos('MODELEGLB',ligneWin)<>0
        then LitModeleGlb(Nligne)
        else if pos('PAGE',ligneWin)<>0
        then begin
           LitValeurConst;
           termine := true;
           exit;
        end
        else begin
           for i := 0 to Nligne do litLigneWin;
           while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
               Nligne := NbreLigneWin(ligneWin);
               for i := 0 to Nligne do litLigneWin;
           end;
       end;
end; // litListe

begin // LitCalculWin
     FileMode := fmOpenRead;
     AssignFile(Fichier,FileName);
     Reset(Fichier);
     finFichierWin := false;
     result := false;
     termine := false;
     try
     litLigneWin;
     if pos('REGRESSI WINDOWS',ligneWin)=0
          then AfficheErreur(erFormat,0)
          else begin
              litLigneWin;
              result := true;
              repeat
                 if (length(ligneWin)>0) and (ligneWin[1]=symbReg)
                    then litListe
                    else litLigneWin;
              until termine or (ligneWin='') or not result;
          end;
     closeFile(fichier);
     except
         CloseFile(fichier);
         result := false;
         AfficheErreur(erReadFile,0);
     end;
     FileMode := fmOpenReadWrite;
end; // LitCalculWin

begin
try
  if FileExists(FileName)
  then begin
     Screen.cursor := crHourGlass;
     if litCalculWin then begin
          FValeurs.MajBtnClick(nil);
          FgrapheVariab.Perform(WM_Reg_Maj,MajFichier,0);
     end;
  end
  else afficheErreur(erFileNotExist+' : '+FileName,0);
except
end;
Screen.cursor := crDefault;
end; // LitCalcul

Initialization
{$IFDEF Debug}
   ecritDebug('initialization filerw3');
{$ENDIF}
var i : integer;
     for i := 0 to maxGrandeurs do
         largeurColonnesVariab[i] := 128;

end.
