// Pages.pas : fichier include de compile.pas

constructor Tpage.Create;
var i  : TcodeIntervalle;
    fy,k  : integer;
begin
  inherited create;
  MiniSimulation := 0;
  MaxiSimulation := 1;
  NbrePointsSauves := 0;              
  FinFFT := -1;
  DebutFFT := 0;
  Active := true;
  Numero := 1;
  Chi2Actif := false;
  Experimentale := true;
  TriAfaire := false;
  ModeleErrone := false;
  NmesMax := MaxVecteurDefaut;
  for k := 0 to pred(NbreGrandeurs) do AjouteGrandeurP(k);
  for k := NbreGrandeurs to pred(MaxGrandeurs) do begin
     valeurVar[k] := nil;
     valeurLisse[k] := nil;
     FenetreFourier[k] := nil;
     FFTimag[k] := nil;
     FFTreel[k] := nil;
     FFTampl[k] := nil;
     IncertVar[k] := nil;
     FtexteVar[k] := nil;
     oldValeurPython[k] := nil;
  end;
  FPointActif := TBits.create;
  FpointActif.size := MaxVecteurDefaut+1;
  ListeRepere := TlisteRepere.Create;
  modeleCalcule := false;
  Stat := TcalculStatistique.create;
  StatK := TcalculStatistique.create;
  StatV := TcalculStatistique.create;
  Stat2 := TStatistiqueDeuxVar.create;
  for i := 1 to MaxIntervalles do begin
      PrecisionModele[i] :=0;
      chi2[i] := 0;
      setLength(valeurTheorique[i],NmesMax+1);
      for fy := 0 to pred(NmesMax) do
          valeurTheorique[i,fy] := Nan;
      X_inter[i] := Nan;
      Y_inter[i] := Nan;
  end;{i}
  setLength(incertNulle,NmesMax+1);
  for fy := 0 to pred(NmesMax) do
      incertNulle[fy] := 0;
  for k := 0 to pred(MaxVecteurDefaut) do FPointActif[k] := true;
  TexteResultatModele := TstringList.Create;
  TexteModeleP := TstringList.Create;
  indicateurP := nil;
  StoechBecher := StoechBecherGlb;
  StoechBurette := StoechBuretteGlb;
  RazPage;
end; // TPage.Create

constructor Tsauvegarde.Create;
var k  : TcodePage;
begin
  NbreMax := MaxVecteurDefaut;
  for k := low(TcodePage) to high(TcodePage) do begin
      valeurVect[k] := nil;
      IncertVect[k] := nil;
  end;
  Nbre := 0;
end; // Sauvegarde.Create

function Tpage.TitrePage : string;
begin
    if NbrePages=1
       then TitrePage := commentaireP
       else Result := 'N°'+intToStr(numero)+' '+commentaireP
end;

procedure Tpage.RazPage;
var i : TcodeIntervalle;
    j : TcodeParam;
    g : TgenreGrandeur;
begin
  ParamAjustes := false;
  MajCornishAfaire := true;
  Active := true;
  nmes := 0;
  FinFFT := -1;
  TriAfaire := false;
  Chi2Actif := false;
  DebutFFT := 0;
  commentaireP := '';
  ModifiedP := false;
  MajCornishAfaire := true;
  ListeRepere.Clear;
  for g := ParamNormal to ParamDiff2 do
      for j := 1 to maxParametres do
          valeurParam[g,j] := Nan;
  for i := 1 to MaxIntervalles do begin
      Debut[i] := 0;
      Fin[i] := -1;
  end;
  TexteResultatModele.Clear;
  TexteModeleP.Clear;
end;{Page.Reset}

procedure Tpage.resetPointActif;
var i : integer;
begin
    for i := 0 to pred(MaxVecteurDefaut) do FPointActif[i] := true;
end;

procedure Tpage.GenereLisseP(index : TcodeGrandeur);
var tampon : Tvecteur;
begin
    try
     if (grandeurs[index].genreG=variable) and
        (valeurLisse[index]=valeurVar[index]) then begin
           setLength(tampon,NmesMax+1);
           valeurLisse[index] := tampon;
     end;
    except
        on EOutOfMemory do valeurLisse[index] := valeurVar[index]
    end;
end;

procedure Tpage.LibereLisseP(index : TcodeGrandeur);
begin
     if valeurLisse[index]<>valeurVar[index] then begin
         valeurLisse[index] := nil;  // on libère
         valeurLisse[index] := valeurVar[index]
     end
end;

procedure Tpage.LibereFourierP(index : TcodeGrandeur);
begin
     FFTimag[index] := nil;
     FFTreel[index] := nil;
     FFTampl[index] := nil;
     FenetreFourier[index] := nil;
end;

destructor Tpage.destroy;
var i : TcodeIntervalle;
    k : integer;
begin
   TexteResultatModele.free;
   TexteModeleP.free;
   Stat.free;
   StatK.free;
   StatV.free;
   Stat2.free;
   ListeRepere.Free;
   for k := 0 to pred(NbreGrandeurs) do
       LibereGrandeurP(k);
   for i := 1 to maxIntervalles do
       valeurTheorique[i] := nil;
   for k := 0 to pred(MaxGrandeurs) do
       oldValeurPython[k] := nil;
   incertNulle := nil;
   FpointActif.free;
   inherited destroy
end;

Procedure Tpage.AjouteRepere(z : double;const s : String);
var repere : Trepere;
begin
     repere := Trepere.Create;
     repere.texte := s;
     repere.valeur := z;
     ListeRepere.Add(repere);
end;

destructor Tsauvegarde.destroy;
var k : TcodePage;
begin
   for k := low(TcodePage) to high(TcodePage) do begin
       valeurVect[k] := nil;
       incertVect[k] := nil;
   end;
   inherited destroy
end;

Function Tpage.ParamEtPrec(k : TcodeGrandeur;incertType : boolean) : String;
var CoeffValeur : double;
    Decimales : integer;
    tampon,tamponPrec : String;
    PrecOk : boolean;
    valeurLoc,precLoc : double;
    premierChiffre,expPrec,expValeur,expValeurIng : integer;
begin // ParamEtPrec
   tampon := '';
   valeurLoc := abs(valeurParam[ParamNormal,k]);
   if incertType
      then precLoc := incertParam[k]
      else precLoc := incert95Param[k];
   expValeurIng := 3*floor(log10(valeurLoc)/3);
   CoeffValeur := dix(-expValeurIng);
   Decimales := precisionMaxIncert;
   if k<=NbreParam[ParamNormal] then with Parametres[ParamNormal,k] do begin
      precOK := ParamAjustes and not isNan(precLoc);
      if precOK then begin
           try
           expPrec := floor(log10(precLoc));
           expValeur := floor(log10(valeurLoc));
           Decimales := expValeur-expPrec;
           premierChiffre := floor(precLoc*dix(-expPrec));
           if premierChiffre<7 then // deux chiffres si premier chiffre (1,2,3,4) selon CEA
           // 10 % de précision sur l'incertitude
           // On passe à 1,2,3,4,5,6)
              inc(decimales);
           if Decimales>precisionMaxIncert then Decimales := PrecisionMaxIncert;
           decimales := decimales - expValeur + expValeurIng;
           if decimales<0 then decimales := 0;
           except
           precOK := false;
           end;
      end;// precOK
      if not precOK then begin
         Decimales := precisionMaxIncert;
         expValeurIng := 0;
         CoeffValeur := 1;
      end;
   valeurLoc := valeurParam[ParamNormal,k]*CoeffValeur;
   tampon := FloatToStrF(valeurLoc,ffFixed,Decimales+3,Decimales);
   if paramAjustes then if precOK
      then begin
         tamponPrec := FloatToStrF(precLoc*CoeffValeur,ffFixed,Decimales+4,Decimales);
         tampon := tampon+' ±'+tamponPrec;
      end
      else tampon := tampon+' ??';
   tampon := '('+tampon+')';
   if correct
      then tampon := tampon+NomAff(expValeurIng)
      else begin
          if expValeurIng<>0 then
             tampon:=tampon+pointMedian+'10'+puissToStr(expValeurIng);
          tampon:=tampon+' S.I.';
      end;
  result := nom+'='+tampon
end end; // ParamEtPrec

Function ParamEtPrecGlb(k : TcodeGrandeur;incertType : boolean) : String;
var CoeffValeur : double;
    Decimales : integer;
    tampon,tamponPrec : String;
    PrecOk : boolean;
    valeurLoc,precLoc : double;
    premierChiffre,expPrec,expValeur,expValeurIng : integer;
begin // ParamEtPrec
   tampon := '';
   valeurLoc := abs(Parametres[paramGlb,k].valeurCourante);
   if incertType
      then precLoc := incertParamGlb[k]
      else precLoc := incert95ParamGlb[k];
   expValeurIng := 3*floor(log10(valeurLoc)/3);
   CoeffValeur := dix(-expValeurIng);
   Decimales := precisionMaxIncert;
   if k<=NbreParam[ParamGlb] then with Parametres[ParamGlb,k] do begin
      precOK := not isNan(precLoc);
      if precOK then begin
           try
           expPrec := floor(log10(precLoc));
           expValeur := floor(log10(valeurLoc));
           Decimales := expValeur-expPrec;
           premierChiffre := floor(precLoc*dix(-expPrec));
           if premierChiffre<3 then inc(decimales); // deux chiffres pour 0,13 ou 0,24
           if Decimales>precisionMaxIncert then Decimales := PrecisionMaxIncert;
           decimales := decimales - expValeur + expValeurIng;
           if decimales<0 then decimales := 0;
           except
           precOK := false;
           end;
      end;// precOK
      if not precOK then begin
         Decimales := precisionMaxIncert;
         expValeurIng := 0;
         CoeffValeur := 1;
      end;
   valeurLoc := Parametres[paramGlb,k].valeurCourante*CoeffValeur;
   tampon := FloatToStrF(valeurLoc,ffFixed,Decimales+3,Decimales);
   if precOK
      then begin
         tamponPrec := FloatToStrF(precLoc*CoeffValeur,ffFixed,Decimales+3,Decimales);
         tampon := tampon+' ±'+tamponPrec;
      end
      else tampon := tampon+' ??';
   tampon := '('+tampon+')';
   if correct
      then tampon := tampon+NomAff(expValeurIng)
      else begin
          if expValeurIng<>0 then
             tampon:=tampon+'10'+puissToStr(expValeurIng);
          tampon:=tampon+' S.I.';
      end;
  result := nom+'='+tampon
end end; // ParamEtPrecGlb

Function Tpage.ParamNum(k : TcodeGrandeur) : String;
var puissValeur : shortInt;
    CoeffValeur,valeurDix : double;
    Precision,Decimales : byte;
    tampon : String;
    PrecOk : boolean;
    valeurLoc,precLoc : double;
begin // ParamNum
   if k<=NbreParam[ParamNormal] then with Parametres[ParamNormal,k] do begin
      valeurLoc := valeurParam[ParamNormal,k];
      precLoc := incertParam[k];
      Precision := 0;
      precOK := ParamAjustes and
           ( abs(valeurLoc)>precLoc ) and
           ( abs(valeurLoc)<1e9*precLoc );
      if precOK then begin
           try
           Precision := floor(log10(abs(valeurLoc))-floor(log10(precLoc))); // +1
           except
           precOK := false;
           end;
      end; // precOK
      if precOK
         then begin
            if Precision<=2
               then Precision := 3
               else if Precision>PrecisionMax
                  then Precision := PrecisionMax;
         end
         else Precision := PrecisionMax div 2;
   PuissValeur := 3*floor(log10(abs(valeurLoc))/3);
   CoeffValeur := dix(-puissValeur);
   Decimales := Precision-1;
   valeurDix := valeurLoc*CoeffValeur;
   if valeurDix>=10 then dec(Decimales);
   if valeurDix>=100 then dec(Decimales);
   tampon := FloatToStrF(valeurDix,ffFixed,Precision,Decimales);
   if puissValeur<>0 then
      tampon := tampon+pointMedian+'10'+puissToStr(puissValeur);
   result := tampon;
   end // param existant
   else result := '';
end; // ParamNum

Function Tpage.AjouteGrandeurP(index : TcodeGrandeur) : boolean;
var fy : integer;
begin
  try
  AjouteGrandeurP := true;
  case grandeurs[index].genreG of
       variable : begin
           setLength(valeurVar[index],NmesMax+1);
           setLength(incertVar[index],NmesMax+1);
           for fy := 0 to pred(NmesMax) do valeurVar[index,fy] := Nan;
           for fy := 0 to pred(NmesMax) do incertVar[index,fy] := Nan;
           fftImag[index] := nil;
           fftReel[index] := nil;
           fftAmpl[index] := nil;           
           fenetreFourier[index] := nil;
           valeurLisse[index] := valeurVar[index];
       end;
       constante : begin
          valeurConst[index] := Nan;
          incertConst[index] := Nan;
          TexteConst[index] := '';
          valeurConstLisse[index] := valeurConst[index];
       end;
  end;
  FtexteVar[index] := nil;
  iRaie1[index] := 1;
  except
      on EOutOfMemory do begin
         valeurVar[index] := nil; // à améliorer
         valeurLisse[index] := nil;
         AjouteGrandeurP := false;
      end;
  end;
end;

procedure Tpage.GenereSpectreFourierP(index : TcodeGrandeur);
var Df : double;
    i : integer;
begin
    DefinitGrandeurFrequence;
    try
    newFourierP(index);
    if FinFFT>=Nmes then FinFFT := pred(Nmes);
    if (FinFFT-DebutFFT)<8 then begin
         debutFFT := 0;
         finFFT := pred(Nmes);
    end;
//    allDataFFT := (finFFT=pred(nmes)) and (debutFFT=0);
    if grandeurs[index].Fonct.genreC=g_definitionFiltre
       then begin
            PeriodeFFT := (valeurVar[indexTri,pred(nmes)]-valeurVar[indexTri,0])/pred(Nmes)*Nmes;
            Df := 1/periodeFFT;
            NbreFFT := Puiss2Sup(Nmes);
            for i := 0 to (NbreFFT div 2) do
                grandeurs[cFrequence].valeur[i] := i*Df;
       end
       else begin
          GenereLisseP(indexTri);
          iRaie1[index] := 1;
          Fourier(DebutFFT,FinFFT,NmesMax,NbreFFT,PeriodeFFT,
              valeurVar[indexTri],valeurVar[index],grandeurs[cFrequence].valeur,
              valeurLisse[indexTri],fenetreFourier[index],
              fftReel[index],fftImag[index],fftAmpl[index],c_spectre);
       end;
    except
         on EOutOfMemory do
    end;
end;

procedure Tpage.calculFourierP(index : TcodeGrandeur;calculFFT : TcalculFFT);
begin
    try
    newFourierP(index);
    GenereLisseP(indexTri);
    Fourier(0,pred(nmes),NmesMax,NbreFFT,PeriodeFFT,
          valeurVar[indexTri],valeurVar[index],grandeurs[cFrequence].valeur,
          valeurLisse[indexTri],fenetreFourier[index],
          fftReel[index],fftImag[index],fftAmpl[index],calculFFT);
    except
         on EOutOfMemory do
    end;
end;

procedure Tpage.NewFourierP(index : TcodeGrandeur);
begin
      if fftReel[index]=nil then begin
         setLength(fftReel[index],NmesMax+1);
         setLength(fftImag[index],NmesMax+1);
         setLength(fftAmpl[index],NmesMax+1);
         setLength(FenetreFourier[index],NmesMax+1);
         grandeurs[index].valeurR := fftReel[index];
         grandeurs[index].valeurA := fftAmpl[index];         
         grandeurs[index].valeurI := fftImag[index];
      end;
end;

Procedure Tpage.SupprimeGrandeurP(index : TcodeGrandeur;S : Tsauvegarde);
var i,j : integer;
begin
    if (S<>nil) and (S.undo=UsupprVariab) then begin
        setLength(S.ValeurVect[numero],nmes);
        setLength(S.IncertVect[numero],nmes);
        for j := 0 to pred(nmes) do begin
            S.ValeurVect[numero,j] := valeurVar[index,j];
            S.IncertVect[numero,j] := incertVar[index,j];
        end;
    end;
    if (S<>nil) and (S.undo=UsupprVariabTexte) then begin
        S.SauveTexte[numero] := TstringList.create;
        for j := 0 to pred(nmes) do
            S.SauveTexte[numero].add(texteVar[index,j]);
    end;
    if (S<>nil) and (S.undo=UsupprConst) then begin
        S.ValeurUnique[numero] := valeurConst[index];
        S.IncertUnique[numero] := incertConst[index];
    end;
    if (S<>nil) and (S.undo=UsupprConstTexte) then begin
        if S.SauveTexteUnique=nil then S.SauveTexteUnique := TstringList.create;
        if S.sauveTexteUnique.count<=numero then
           for i := S.sauveTexteUnique.count to numero do
               S.sauveTexteUnique.Add('');
        S.SauveTexteUnique[numero] := texteConst[index];
    end;
    libereGrandeurP(index);
    for i := index to (NbreGrandeurs-2) do begin
         valeurVar[i] := valeurVar[succ(i)];
         valeurLisse[i] := valeurLisse[succ(i)];
         valeurConst[i] := valeurConst[succ(i)];
         incertConst[i] := incertConst[succ(i)];
         valeurConstLisse[i] := valeurConstLisse[succ(i)];
         FFTimag[i] := FFTimag[succ(i)];
         FFTreel[i] := FFTreel[succ(i)];
         FFTampl[i] := FFTampl[succ(i)];
         FenetreFourier[i] := FenetreFourier[succ(i)];
         IncertVar[i] := incertVar[succ(i)];
         FTexteVar[i] := FTexteVar[succ(i)];
    end;
end; // page.SupprimeGrandeurP

Procedure Tpage.LibereGrandeurP(index : TcodeGrandeur);
begin
     if FTexteVar[index]<>nil then freeAndNil(FTexteVar[index]);
     if (grandeurs[index].genreG<>variable) or
        (valeurVar[index]=nil) then exit;
     libereFourierP(index);
     libereLisseP(index);
     valeurVar[index] := nil;
     incertVar[index] := nil;
end; // libereGrandeurP

Procedure Tpage.TransfereVariabP(indexOrig,indexDest : TcodeGrandeur);
var tamponSL : TstringList;
    tamponS : string;
begin
       swap(fftImag[indexDest],fftImag[indexOrig]);
       swap(fftReel[indexDest],fftReel[indexOrig]);
       swap(fftAmpl[indexDest],fftAmpl[indexOrig]);
       swap(fenetreFourier[indexDest],fenetreFourier[indexOrig]);
       swap(incertVar[indexDest],incertVar[indexOrig]);
       swap(valeurVar[indexDest],valeurVar[indexOrig]);
       swap(valeurLisse[indexDest],valeurLisse[indexOrig]);
       swap(valeurConst[indexDest],valeurConst[indexOrig]);
       swap(incertConst[indexDest],incertConst[indexOrig]);
       swap(valeurConstLisse[indexDest],valeurConstLisse[indexOrig]);
       TamponSL := FTexteVar[indexOrig];
       FTexteVar[indexOrig] := FTexteVar[indexDest];
       FTexteVar[indexDest] := TamponSL;
       TamponS := TexteConst[indexOrig];
       TexteConst[indexOrig] := TexteConst[indexDest];
       TexteConst[indexDest] := TamponS;
end; // transfereVariableP

Procedure Tpage.SauveVarP(indexOrig,indexDest : TcodeGrandeur);
begin
       setLength(oldValeurPython[indexDest],NmesMax+1);
       swap(oldValeurPython[indexDest],valeurVar[indexOrig]);
end;

Procedure Tpage.RecupereVarP(indexOrig,indexDest : TcodeGrandeur);
begin
       if (oldValeurPython[indexOrig]<>nil) then
          swap(ValeurVar[indexDest],oldValeurPython[indexOrig]);
end;

procedure Tpage.affecteVariableP(lisse : boolean);
var i,index : integer;
begin
  for i := 0 to pred(NbreVariab) do begin
      index := indexVariab[i];
      with grandeurs[index] do begin
         if lisse
            then valeur := valeurLisse[index]
            else valeur := valeurVar[index];
         valIncert := incertVar[index];
         valeurR := fftReel[index];
         valeurA := fftAmpl[index];         
         valeurI := fftImag[index];
      end;{with}
  end;
  nmesCourant := nmes;
  NbreFFTcourant := NbreFFT;
  grandeurs[cNombre].valeurCourante := nmes;
end;

procedure Tpage.affecteConstParam(isModele : boolean);
var i : integer;
    index : TcodeGrandeur;
begin
   for i := 0 to pred(NbreConst) do begin
       index := indexConst[i];
       with grandeurs[index] do begin
           valeurCourante := valeurConst[index];
           incertCourante := incertConst[index];
           if uniteSIGlb and (fonct.genreC=G_experimentale) then begin
               incertCourante := incertCourante*coeffSI;
               valeurCourante := valeurCourante*coeffSI;
           end;
       end; // with
   end;                     { TODO : coeffSI param }
   for i := 1 to NbreParam[paramNormal] do begin
       if paramInverse[i] and isModele
          then if uniteSIGlb
             then Parametres[paramNormal,i].valeurCourante := 1/(valeurParam[paramNormal,i]*Parametres[paramNormal,i].coeffSI)
             else Parametres[paramNormal,i].valeurCourante := 1/valeurParam[paramNormal,i]
          else if uniteSIGlb
             then Parametres[paramNormal,i].valeurCourante := valeurParam[paramNormal,i]*Parametres[paramNormal,i].coeffSI
             else Parametres[paramNormal,i].valeurCourante := valeurParam[paramNormal,i];
       if uniteSIGlb
          then Parametres[paramNormal,i].incertCourante := incertParam[i]*Parametres[paramNormal,i].coeffSI
          else Parametres[paramNormal,i].incertCourante := incertParam[i];
       if isNan(Parametres[paramNormal,i].incertCourante) then
          Parametres[paramNormal,i].incertCourante := 0;
   end;
   Grandeurs[cPage].valeurCourante := numero;
   Grandeurs[cNombre].valeurCourante := nmes;
   if ModeAcquisition=acqSimulation then
      Grandeurs[cDeltat].valeurCourante := deltaSimulation;
   valeurConst[cNombre] := nmes;
   derniereErreur := '';
end; // affecteConstParam

procedure Tpage.SupprimeLignes(debutL,finL : integer);
var i,j,jmax : integer;
    k,index : TcodeGrandeur;
    S : tsauvegarde;
begin
     if debutL<0 then exit;
     verifMinMaxInt(debutL,finL);
     if finL>=nmes then begin
        finL := pred(nmes);
        if debutL>finL then exit;
     end;
     S := tsauvegarde.create;
     S.NbreGrandeursSauvees := NbreVariabExp;
     S.Nbre := succ(finL-debutL);
     S.undo := UsupprPoint;
     S.numeroPage := numero;
     if NbreVariabExp<MaxPages
        then jmax := NbreVariabExp
        else jmax := MaxPages;
     for j := 1 to jmax do begin
         setLength(S.valeurVect[j],S.Nbre+1);
         setLength(S.incertVect[j],S.Nbre+1);
     end;
     for j := 1 to jmax do begin
         index := indexVariab[pred(j)];
         S.nomData[j] := grandeurs[index].nom;
         for i := 0 to pred(S.Nbre) do begin
             S.valeurVect[j,i] := valeurVar[index,debutL+i];
             S.incertVect[j,i] := incertVar[index,debutL+i];
         end;
     end;
     dec(Fnmes,S.Nbre);
     for k := 0 to pred(NbreVariab) do begin
         index := indexVariab[k];
         for i := debutL to pred(nmes) do begin
             valeurVar[index,i] := valeurVar[index,i+S.nbre];
             incertVar[index,i] := incertVar[index,i+S.nbre];
         end;
         for i := nmes to pred(S.nbre+nmes) do begin
             valeurVar[index,i] := Nan;
             incertVar[index,i] := Nan;
         end;
         if (grandeurs[index].fonct.genreC=g_texte) and
            (FtexteVar[index]<>nil) then begin
            try
            for i := debutL to pred(nmes) do
                FtexteVar[index].strings[i] := FtexteVar[index].strings[i+S.nbre];
            except
            end;
         end;
       end;
   if ModeAcquisition=AcqSimulation then begin
        MiniSimulation := valeurVar[0,0];
        MaxiSimulation := valeurVar[0,pred(nmes)];
        MaxiSimulation := MaxiSimulation+(maxiSimulation-miniSimulation)/pred(nmes);
   end;
   CalculGlb;
// recalcul des fonctions globales : dérivée, maxi ...
   PileSauvegarde.Push(S);
end;

Function Tpage.ValeurParametre(i : TcodeGrandeur) : double;
// Renvoie la valeur du paramètre d'index i
var k : TcodeGrandeur;
begin
   if i<NbreGrandeurs
      then result := valeurConst[i]
      else begin
         k := indexToParam(paramNormal,i);
         if k<>grandeurInconnue then begin
             result := ValeurParam[paramNormal,k];
             exit;
         end;
         k := IndexToParam(paramGlb,i);
         if k<>grandeurInconnue
            then result := Parametres[paramGlb,k].valeurCourante
            else result := Nan;
     end;
end;

Function Tpage.PrecisionParametre(i : TcodeGrandeur) : double;
// Renvoie la precision du paramètre d'index i
var k : TcodeGrandeur;
begin
   if i<NbreGrandeurs
      then result := incertConst[i]
      else begin
         k := indexToParam(paramNormal,i);
         if k<>grandeurInconnue
            then result := incertParam[k]
            else begin
                k := IndexToParam(paramGlb,i);
                if k<>grandeurInconnue
                   then result := Parametres[paramGlb,k].incertCourante
                   else result := Nan;
             end;
      end;
end;

Procedure Tpage.SetNmes(NewNmes : LongInt);
var oldNmesMax : LongInt;

Procedure AllocationMemoire;
var i,N,k : LongInt;
begin
        N := NmesMax + 1;
        for i := 1 to MaxIntervalles do
            setLength(valeurTheorique[i],N);
        setLength(incertNulle,N);
        for k := oldNmesMax to pred(N) do incertNulle[k] := 0;
        for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG=variable then begin
               if valeurVar[i]<>valeurLisse[i] then
                  valeurLisse[i] := nil;
               setLength(valeurVar[i],N);
               valeurLisse[i] := valeurVar[i];
               setLength(incertVar[i],N);
               setLength(incertVar[i],N);
               if fftReel[i]<>nil then begin
                  setLength(fftReel[i],N);
                  setLength(fftImag[i],N);
                  setLength(fftAmpl[i],N);
                  setLength(FenetreFourier[i],N);
               end;
           end; // variable
        FPointActif.size := N;
        for k := oldNmesMax to pred(N) do FPointActif[k] := true;
end;

begin
   if newNmes>nmesMax
      then begin
        oldNmesMax := NmesMax;
        if newNmes>MaxMaxVecteur
           then newNmes := MaxMaxVecteur;
        NmesMax := Puiss2Sup(NewNmes);
        try
        AllocationMemoire;
        changeAdresse := true;
        Fnmes := newNmes;
        except
           NmesMax := oldNmesMax;
        end;
      end
      else Fnmes := newNmes;
end;

Procedure Tsauvegarde.SetNombre(NewNbre : integer);

Procedure AllocationMemoire;
var i,N : integer;
begin
        N := NbreMax + 2;
        for i := 1 to NbreGrandeursSauvees do begin
            setLength(valeurVect[i],N);
            setLength(incertVect[i],N);
        end;
end;

begin
     if newNbre>nbreMax then begin
        if newNbre>MaxMaxVecteur then exit;
        NbreMax := Puiss2Sup(NewNbre);
        try
        AllocationMemoire;
        except
         on EOutOfMemory do begin
            NbreMax := maxVecteurDefaut;
            AllocationMemoire;
            exit;
         end;
       end;
     end;
     Fnbre := newNbre;
end; // setNombre

Procedure Tsauvegarde.Restaure;
var oldNmes : integer;
    i,j : integer;
    index : integer;
    p : TcodePage;
begin
   case undo of
       UsupprPage : if NbrePages<MaxPages then begin
             inc(NbrePages);
             pageCourante := NbrePages;
             Pages[NbrePages] := PageSauvee;
       end;
       UsupprPoint : begin
          oldNmes := Pages[NumeroPage].nmes;
          Pages[NumeroPage].nmes := oldNmes+nbre;
          for j := 1 to NbreGrandeursSauvees do begin
              index := IndexNom(nomData[j]);
              for i := 0 to pred(nbre) do
                  Pages[NumeroPage].valeurVar[index,oldNmes+i] := valeurVect[j,i];
          end;
          pages[NumeroPage].TriAFaire := true;
          pages[NumeroPage].Tri;
          pages[NumeroPage].RecalculP;
       end;
       UsupprConst : begin
          index := AjouteGrandeurE(GrandeurSauvee);
          for p := 1 to NbrePages do begin
              pages[p].valeurConst[index] := valeurUnique[p];
              pages[p].incertConst[index] := valeurUnique[p];
          end;
       end;
       UsupprVariab : begin
          index := AjouteGrandeurE(GrandeurSauvee);
          for p := 1 to NbrePages do begin
              for j := 0 to pred(pages[p].nmes) do begin
                  pages[p].valeurVar[index,j] := valeurVect[p,j];
                  pages[p].incertVar[index,j] := incertVect[p,j];
              end;
              pages[p].RecalculP;
          end;
       end;
       UsupprConstTexte : begin
          index := AjouteGrandeurE(GrandeurSauvee);
          for p := 1 to NbrePages do
              pages[p].TexteConst[index] := SauveTexteUnique[p];
          SauveTexteUnique.free;
       end;
       UsupprVariabTexte : begin
          index := AjouteGrandeurE(GrandeurSauvee);
          for p := 1 to NbrePages do begin
              for j := 0 to pred(pages[p].nmes) do
                  pages[p].texteVar[index,j] := SauveTexte[p].strings[j];
              SauveTexte[p].free;
          end;
       end;
       Ugrouper : ;
   end;
end;  // Restaure

Function AjoutePage : boolean;
begin
    if NbrePages=MaxPages
       then ajoutePage := false
       else begin
           try
             if (NbrePages=0) or
                (pages[NbrePages].nmes>0) then begin
                   pages[succ(NbrePages)] :=  Tpage.create;
                   inc(NbrePages);
             end;
             ajoutePage := true;
             pageCourante := NbrePages;
           except
             ajoutePage := false;
           end;
      end;
end; // AjoutePage

Procedure Tpage.Tri;
// Tri Shell Meyer-Baudoin p 456 ; origine vecteur en 0
var fx,index : integer;
    IsTexte : set of byte;
    ModifTri : boolean;

Procedure TriTexte;
var increment,k : integer;
    cle : string;
    fx,i,j,index : integer;
    SauveV : array[TcodeGrandeur] of double;
    SauveI : array[TcodeGrandeur] of double;
    SauveT : array[TcodeGrandeur] of string;
Begin
   increment := 1;
   while (increment<(Nmes div 3)) do increment := succ(3*increment);
   repeat
     for k := 0 to pred(increment) do begin
         i := increment+k;
     while (i<Nmes) do begin
         for fx := 0 to pred(NbreVariab) do begin
                       index := indexVariab[fx];
                       if index in isTexte
                          then sauveT[index] := texteVar[index,i]
                          else begin
                              sauveV[index] := valeurVar[index,i];
                              sauveI[index] := incertVar[index,i];
                          end;
         end; // fx
         j := i-increment;
         cle := FtexteVar[indexTri].strings[i];
         while (j>=0) and (FtexteVar[indexTri].strings[j]>cle) do begin
              for fx := 0 to pred(NbreVariab) do begin
                     index := indexVariab[fx];
                     if index in isTexte
                        then FtexteVar[index].strings[j+increment] := FtexteVar[index].strings[j]
                        else begin
                             valeurVar[index,j+increment] := valeurVar[index,j];
                             incertVar[index,j+increment] := incertVar[index,j];
                        end;
             end; // fx
             dec(j,increment);
             modifTri := true;
         end; // while
        for fx := 0 to pred(NbreVariab) do begin
               index := indexVariab[fx];
               if index in isTexte
                   then FtexteVar[index].strings[j+increment] := sauveT[index]
                   else begin
                       valeurVar[index,j+increment] := sauveV[index];
                       incertVar[index,j+increment] := sauveI[index];
                   end;
       end; // fx
       inc(i,increment);
     end; // while i>=nmes
     end; // for k
     increment := increment div 3;
   Until increment=0;
end; // TriTexte

Procedure TriValeur;
var increment,k : integer;
    cle : double;
    fx,i,j,index : integer;
    SauveV : array[TcodeGrandeur] of double;
    SauveI : array[TcodeGrandeur] of double;
    SauveT : array[TcodeGrandeur] of string;
Begin
   increment := 1;
   while (increment<(Nmes div 3)) do increment := succ(3*increment);
   repeat
     for k := 0 to pred(increment) do begin
         i := increment+k;
     while (i<Nmes) do begin
         for fx := 0 to pred(NbreVariab) do begin
                       index := indexVariab[fx];
                       if index in isTexte
                          then sauveT[index] := texteVar[index,i]
                          else begin
                              sauveV[index] := valeurVar[index,i];
                              sauveI[index] := incertVar[index,i];
                          end;
         end; // fx
         j := i-increment;
         cle := ValeurVar[indexTri,i];
         while (j>=0) and (valeurVar[indexTri,j]>cle) do begin
              for fx := 0 to pred(NbreVariab) do begin
                              index := indexVariab[fx];
                              if index in isTexte
                                 then FtexteVar[index].strings[j+increment] := FtexteVar[index].strings[j]
                                 else begin
                                    valeurVar[index,j+increment] := valeurVar[index,j];
                                    incertVar[index,j+increment] := incertVar[index,j];
                                 end;
             end; // fx
             dec(j,increment);
             modifTri := true;
         end; // while
        for fx := 0 to pred(NbreVariab) do begin
               index := indexVariab[fx];
               if index in isTexte
                   then FtexteVar[index].strings[j+increment] := sauveT[index]
                   else begin
                       valeurVar[index,j+increment] := sauveV[index];
                       incertVar[index,j+increment] := sauveI[index];
                   end;
       end; // fx
       inc(i,increment);
     end; // while i>=nmes
     end; // for k
     increment := increment div 3;
   Until increment=0;
end; // TriValeur

Begin
   if not(TriAfaire) or FichierTrie then exit;
   modifTri := false;
   isTexte := [];
   DefinitGrandeurFrequence;
   for fx := 0 to pred(NbreVariab) do begin
       index := indexVariab[fx];
       libereLisseP(index);
       libereFourierP(index);
       if grandeurs[index].fonct.genreC=g_texte then include(isTexte,index);
   end;
   if grandeurs[indexTri].fonct.genreC=g_experimentale
      then triValeur
      else triTexte;
   TriAfaire := false;
   if modifTri and (numero=pageCourante)
      then Application.MainForm.Perform(WM_Reg_Maj,MajTri,0)
end; // Tpage.Tri

procedure Tsauvegarde.LibereS;
begin
     pageSauvee.free;
     grandeurSauvee.free;
end;

procedure Tpage.VerifIntervalles;
var i : TcodeIntervalle;
    iY,iX : integer;
begin
     for i := 1 to MaxIntervalles do begin
        if (fin[i]<0) or (fin[i]>=nmes) then fin[i] := pred(nmes);
        if (debut[i]<0) or (debut[i]>=nmes) then debut[i] := 0;
        if fin[i]<debut[i] then swap(debut[i],fin[i]);
        if fin[i]=debut[i] then resetDebutFin(i);
        if i<=NbreModele then begin
        iY := fonctionTheorique[i].indexY;
        iX := fonctionTheorique[i].indexX;
        if iY<>grandeurInconnue then
        while (debut[i]<nmes) and (isNan(valeurVar[iY,debut[i]])) do inc(debut[i]);
        if iX<>grandeurInconnue then
        while (debut[i]<nmes) and (isNan(valeurVar[iX,debut[i]])) do inc(debut[i]);
        if iY<>grandeurInconnue then
        while (fin[i]>debut[i]) and isNan(valeurVar[iY,fin[i]]) do dec(fin[i]);
        if iX<>grandeurInconnue then
        while (fin[i]>debut[i]) and isNan(valeurVar[iX,fin[i]]) do dec(fin[i]);
        end;
     end;
end;

Function Tpage.EffacePage(xdebut,ydebut,xfin,yfin : double;indexX,indexY : integer) : boolean;
var j,jj,k,index,oldNmes : integer;
    comm : string;
begin
result := false;
if commentaireP<>''
   then comm := commentaireP else if NbreConst>0
   then comm := grandeurs[indexConst[0]].FormatNomEtUnite(valeurConst[indexConst[0]]);
if OKreg(OkDelData+comm,0) then begin
       verifMinMaxReal(xdebut,xfin);
       verifMinMaxReal(ydebut,yfin);
       j := 0;
       oldNmes := nmes;
       while (j<nmes) do if
           isNan(valeurVar[indexy,j]) or (
           (valeurVar[indexx,j]>xdebut) and
           (valeurVar[indexx,j]<xfin) and
           (valeurVar[indexy,j]>ydebut) and
           (valeurVar[indexy,j]<yfin))
              then begin
                  dec(Fnmes);
                  result := true;
                  for k := 0 to pred(NbreVariab) do begin
                      index := indexVariab[k];
                      for jj := j to pred(nmes) do
                          valeurVar[index,jj] := valeurVar[index,succ(jj)];
                  end;
              end
              else inc(j);
        if result then
           for k := 0 to pred(NbreVariab) do begin
              index := indexVariab[k];
              for jj := nmes to pred(oldNmes) do
                  valeurVar[index,jj] := Nan;
           end;
end end; // effacePage

Procedure GroupePage;
var pageDest,pageOrig : TcodePage;
    i,sauveNmes : integer;
    j,k : TcodeGrandeur;
    S : tsauvegarde;
begin
   S := tsauvegarde.create;
   S.undo := Ugrouper;
   PileSauvegarde.Push(S);
   pageDest := 1;
   while (pageDest<NbrePages) and not(Pages[pageDest].Active)
     do inc(pageDest);
   if not pages[pageDest].Active then exit;
   pageOrig := succ(pageDest);
   while (pageOrig<=NbrePages) do if pages[pageOrig].Active
     then begin
        if (pages[pageOrig].nmes+pages[pageDest].Nmes)<MaxMaxVecteur
          then begin
            sauveNmes := pages[PageDest].nmes;
// essai d'allocation mémoire
            pages[PageDest].nmes := pages[PageDest].nmes+pages[pageOrig].nmes;
            if pages[PageDest].nmes>sauveNmes then begin // effectué 
               for j := 0 to pred(nbreVariab) do begin
                   k := indexVariab[j];
                   for i := 0 to pred(pages[pageOrig].nmes) do begin
                       pages[pageDest].valeurVar[k,sauveNmes+i] :=
                          pages[pageOrig].valeurVar[k,i];
                       pages[pageDest].incertVar[k,sauveNmes+i] :=
                          pages[pageOrig].incertVar[k,i];
                   end;
               end;
               SupprimePage(pageOrig,false);
            end
            else begin
               pageDest := pageOrig;
               inc(pageOrig);
            end
         end
         else begin
           pageDest := pageOrig;
           inc(pageOrig);
         end;
    end
    else inc(pageOrig);
  pages[PageDest].triAfaire := true;
  pageCourante := pageDest;
  for pageDest := 1 to NbrePages do pages[pageDest].active := true;
  pages[pageCourante].recalculP;
  Application.MainForm.perform(WM_Reg_Maj,MajGroupePage,0);
end; // GroupePage

Procedure GroupePageColonnes;
var i,imax,nbreVariabInit : integer;
    j,k,kp : TcodeGrandeur;
    p : TcodePage;
    S : tsauvegarde;
begin
   S := tsauvegarde.create;
   S.undo := Ugrouper;
   PileSauvegarde.Push(S);
   nbreVariabInit := nbreVariabExp;
   for p := nbrePages downto 2 do begin
       for j := 0 to pred(nbreVariabInit) do begin
           k := indexVariabExp[j];
           kp := AjouteExperimentale(grandeurs[k].nom+intToStr(p),variable);
           if pages[1].nmes>pages[p].nmes
              then imax := pred(pages[p].nmes)
              else imax := pred(pages[1].nmes);
           for i := 0 to imax do
               pages[1].valeurVar[kp,i] := pages[p].valeurVar[k,i];
           for i := succ(imax) to pred(pages[1].nmes) do
               pages[1].valeurVar[kp,i] := Nan;
       end;
       SupprimePage(p,false);
  end;
  pageCourante := 1;
  Application.MainForm.perform(WM_Reg_Maj,MajChangePage,0);
  Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
end; // GroupePageColonnes

Procedure SupprimePage(numero : integer;avecSauvegarde : boolean);
var page : integer;
    S : Tsauvegarde;
begin
   if (numero<1) or (numero>NbrePages) then exit;
   if NbrePages=1
      then pages[1].razPage
      else begin
        if avecSauvegarde
           then begin
               S := Tsauvegarde.create;
               S.undo := UsupprPage;
               S.PageSauvee := Pages[numero];
               PileSauvegarde.push(S);
           end
           else pages[numero].free;
        for page := succ(numero) to NbrePages do
            pages[pred(page)] := pages[page];
        dec(NbrePages);
        if pageCourante>NbrePages then PageCourante := 1;
      end;
end; // SupprimePage

Function AjoutePageForce : boolean;
begin
    if NbrePages=MaxPages
       then result := false
       else begin
           try
             pages[succ(NbrePages)] :=  Tpage.create;
             inc(NbrePages);
             result := true;
             pageCourante := NbrePages;
           except
             result := false;
           end;
      end;
end; // AjoutePageForce

Procedure TriConst(NumConst : TcodeGrandeur);
// Tri Shell Meyer-Baudoin p 456 ; origine vecteur en 1
var cle : double;
    i,j : integer;
    SauvePage : Tpage;
Begin
    i := 2;
    while (i<=NbrePages) do begin
        sauvePage := pages[i];
        cle := pages[i].valeurConst[numConst];
        j := pred(i);
        while (j>=1) and (pages[j].valeurConst[numConst]>cle) do begin
             pages[succ(j)] := pages[j];
             dec(j);
        end;
        pages[succ(j)] := sauvePage;
        inc(i);
    end;
end;//  triConst

Procedure TriParam(NumParam : TcodeGrandeur);
// Tri Shell Meyer-Baudoin p 456 ; origine vecteur en 1
var cle : double;
    i,j : integer;
    SauvePage : Tpage;
Begin
    i := 2;
    while (i<=NbrePages) do begin
        sauvePage := pages[i];
        cle := pages[i].valeurParam[paramNormal,numParam];
        j := pred(i);
        while (j>=1) and (pages[j].valeurParam[paramNormal,numParam]>cle) do begin
             pages[succ(j)] := pages[j];
             dec(j);
        end;
        pages[succ(j)] := sauvePage;
        inc(i);
    end;
end; // triParam

Procedure Tpage.ResetDebutFin(i : TcodeIntervalle);
begin
       debut[i] := 0;
       fin[i] := pred(nmes);
       if (i<=NbreModele) and
          (fonctionTheorique[i].indexY<>grandeurInconnue) and
          (fonctionTheorique[i].indexX<>grandeurInconnue) then begin
       while isNan(valeurVar[fonctionTheorique[i].indexY,debut[i]]) or
             isNan(valeurVar[fonctionTheorique[i].indexX,debut[i]])
            do inc(debut[i]);
       while isNan(valeurVar[fonctionTheorique[i].indexY,fin[i]]) or
             isNan(valeurVar[fonctionTheorique[i].indexX,fin[i]])
            do dec(fin[i]);
       end;
end;

function Tpage.getTexteVar(indexV,indexP : integer) : string;
begin
    if (FtexteVar[indexV]<>nil) and
       (indexP<FtexteVar[indexV].count)
          then result := FtexteVar[indexV].strings[indexP]
          else result := '';
end;

procedure Tpage.setTexteVar(indexV,indexP : integer;const value : string);
var i : integer;
begin
    if FtexteVar[indexV]=nil then FtexteVar[indexV] := TstringList.create;
    if FtexteVar[indexV].count<=indexP then
        for i := FtexteVar[indexV].count to indexP do
            FtexteVar[indexV].Add('');
    FtexteVar[indexV].strings[indexP] := value;
end;

procedure Tpage.setPointActif(index : integer;value : boolean);
begin
     FpointActif[index] := value
end;

function Tpage.getPointActif(index : integer) : boolean;
begin
    if (numero>0)
       then result := FPointActif[index]
       else if index<NbrePages
          then result := Pages[index+1].active
          else result := true

end;

function Tmodele.getPointActif(index: integer): boolean;
begin with pages[pageCourante] do begin
    result := FPointActif[index] and
              not isNan(valeurVar[indexX,index]) and
              not isNan(valeurVar[indexY,index])
end end;

Procedure Tpage.SetNomBitmap(const NewNom : string);
begin
    FnomFichierBitmap := newNom;
    FextensionBitmap := AnsiUpperCase(ExtractFileExt(FNomFichierBitmap));
end;

Function Tpage.AcquisitionAVI : boolean;
begin
    result := (FNomFichierBitmap<>'');
    if result then
        result := (FextensionBitmap='.AVI') or
                  (FextensionBitmap='.MPG') or
                  (FextensionBitmap='.WMV');  // mov divx
end;

procedure Tpage.VerifNomBitmap(const NouveauNomFichierData : string);
var NomCourant,NouveauNom : string;
    fichierOK : boolean;
    posP : integer;
begin
    if (FnomFichierBitmap='') or
       (NomFichierData='')
       then exit
       else begin
          fichierOK := (FextensionBitmap='.AVI') or
                  (FextensionBitmap='.BMP') or
                  (FextensionBitmap='.JPG') or
                  (FextensionBitmap='.WAV') or
                  (FextensionBitmap='.MPG');
          if not fichierOK then exit;
          if FileExists(FnomFichierBitmap)
             then nomCourant := FnomFichierBitmap
             else nomCourant := ExtractFilePath(NomFichierData)+
                                ExtractFileName(FnomFichierBitmap);
          if not FileExists(nomCourant) then begin
             posP := pos('.',nomCourant);
             nomCourant := Copy(nomCourant,1,posP-1)+intToStr(numero)+FextensionBitmap;
             if not FileExists(nomCourant) then exit;
          end;
          NouveauNom := ChangeFileExt(NouveauNomFichierData,FextensionBitmap);
          posP := pos('.',nouveauNom);
          NouveauNom := Copy(NouveauNom,1,posP-1)+intToStr(numero)+FextensionBitmap;
          if nouveauNom=nomCourant then exit;
          copyFile(Pchar(NomCourant),Pchar(NouveauNom),true);
          FNomFichierBitmap := ExtractFileName(NouveauNom);
      end;
end; //  verifnomBitmap

Function Tpage.GetNomBitmap : string;
var NomFichier : string;
    fichierOK : boolean;
    posP : integer;
begin
    result := '';
    if FnomFichierBitmap=''
       then exit
       else begin
          fichierOK := (FextensionBitmap='.AVI') or
                  (FextensionBitmap='.BMP') or
                  (FextensionBitmap='.JPG') or
                  (FextensionBitmap='.WAV') or
                  (FextensionBitmap='.MPG');
          if not fichierOK then exit;
          if FileExists(FnomFichierBitmap)
            then result := FnomFichierBitmap
            else begin
                 nomFichier := ExtractFilePath(NomFichierData)+
                               ExtractFileName(FnomFichierBitmap);
                 if FileExists(nomFichier)
                    then begin
                       result := nomFichier;
                       FnomFichierBitmap := ExtractFileName(FnomFichierBitmap);
                    end
                    else begin
                         nomFichier := ChangeFileExt(NomFichierData,FextensionBitmap);
                         if FileExists(nomFichier) then begin
                            FnomFichierBitmap := ExtractFileName(nomFichier);
                            result := nomFichier;
                         end
                         else begin
                            posP := pos('.',nomFichier);
                            nomFichier := Copy(nomFichier,1,posP-1)+intToStr(numero)+FextensionBitmap;
                            if FileExists(nomFichier) then begin
                               FnomFichierBitmap := ExtractFileName(nomFichier);
                               result := nomFichier;
                            end;
                         end;
                    end;
            end;
       end;
end; // getNomBitmap

function TPage.incertDefinie : boolean;
var i : integer;
begin
    result := false;
    for i := 0 to pred(NbreVariab) do
        if (Grandeurs[i].fonct.genreC=g_experimentale) and Grandeurs[i].incertDefinie then begin
            result := true;
            break;
        end;
end;

function TPage.incertCalculee : boolean;
var i : integer;
begin
    result := true;
    for i := 0 to pred(NbreVariab) do
        if (Grandeurs[i].fonct.genreC=g_experimentale) then
            result := result and Grandeurs[i].incertCalculee;
end;

// Pages.pas


