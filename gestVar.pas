// gestVar.pas : fichier inclus de compile.pas

procedure videParam;
var i : TcodeParam;
    g : TgenreGrandeur;
begin
   for g := paramGlb to paramNormal do begin
       NbreParam[g] := 0;
       for i := 1 to MaxParametres do
          Parametres[g,i].nom := '';
   end;
end;

Function GetIndexInit(f : Tgrandeur) : TcodeGrandeur;
var nomInit : string;
begin
    nomInit := f.nom+'[0]';
    result := indexNom(nomInit);
    if result=GrandeurInconnue then begin
       nomInit := f.nom+'0';
       result := indexNom(nomInit);
    end;
end;

Function Tgrandeur.TitreAff : string;
begin
     if AffSignif and (fonct.expression<>'')
        then result := fonct.expression
        else result := nom;
     if isUniteLatex then result := '$'+translateNomMath(result)+'$';
end;

Function indexNomVariab(const nomX : string) : TcodeGrandeur;
// Renvoie le code de la variable de nom : nomX
var i : integer;
begin
   result := GrandeurInconnue;
   if nomX='' then exit;
   for i := 0 to pred(NbreGrandeurs) do
       if nomX=grandeurs[i].nom then begin
         result := i;
         exit;
       end;
   if nomX=grandeurs[cNombre].nom then result := cNombre;
   if nomX=grandeurs[cDeltat].nom then result := cDeltat;
   if nomX=grandeurs[cIndice].nom then result := cIndice;
end;

Function indexNom(const nomX : string) : TcodeGrandeur;
// Renvoie le code de la grandeur de nom nomX
var i : integer;
    g : TgenreGrandeur;
begin
   result := indexNomVariab(nomX);
   if nomX='' then exit;
   if result=grandeurInconnue then
      for g := ParamGlb to ParamNormal do
       for i := 1 to NbreParam[g] do
          if nomX=Parametres[g,i].nom then begin
             result := ParamToIndex(g,i);
             exit;
          end;
end;

Procedure libereGrandeurE(index : TcodeGrandeur);
var i : integer;
begin
    if index>maxGrandeurs then exit;
    with grandeurs[index] do
        case genreG of
           Constante : begin
              case fonct.genreC of
                g_PythonConst : begin
                   dec(NbreConstPython);
                   for i := 1 to NbrePages do
                       pages[i].oldValeurConst[finOldGrandeurs] := pages[i].valeurConst[index];
                end;
                g_experimentale : dec(NbreConstExp);
                g_texte : dec(NbreConstTexte);
              end;
              dec(NbreConst);
           end;
           Variable : begin
              case fonct.genreC of
                g_PythonVar : begin
                   dec(NbreVariabPython);
                   for i := 1 to NbrePages do
                       pages[i].SauveVarP(index,finOldGrandeurs);
                end;
                g_experimentale : dec(NbreVariabExp);
                g_texte : dec(NbreVariabTexte);
              end;
              for i := 1 to NbrePages do
                  pages[i].libereGrandeurP(index);
              dec(NbreVariab);
           end;
           ConstanteGlb : dec(NbreConstGlb);
       end;
    oldGrandeurs[FinOldGrandeurs].free;
    oldGrandeurs[FinOldGrandeurs] := grandeurs[index];
    inc(FinOldGrandeurs);
    if FinOldGrandeurs>=MaxGrandeurs then finOldGrandeurs := 0;
    dec(NbreGrandeurs);
    for i := index to pred(NbreGrandeurs) do
        grandeurs[i] := grandeurs[succ(i)];
    ConstruireIndex;
end; // libereGrandeurE

Procedure transfereVariabE(indexOrig,indexDest : TcodeGrandeur);
var page : integer;
    tampon : tgrandeur;
begin
    if indexOrig=indexDest then exit;
    if grandeurs[indexOrig].genreG<>constanteGlb then
       for page := 1 to NbrePages do
           pages[page].transfereVariabP(indexOrig,indexDest);
    tampon :=  grandeurs[indexDest];
    grandeurs[indexDest] := grandeurs[indexOrig];
    grandeurs[indexOrig] := tampon;
end; // TransfereVariabE

Procedure transfereParamE(Agenre : TgenreGrandeur;indexOrig,indexDest : TcodeParam);
var page : integer;
begin
    if indexOrig=indexDest then exit;
    if Agenre<>ParamGlb then
       for page := 1 to NbrePages do with pages[page] do
           swap(valeurParam[Agenre,indexDest],valeurParam[Agenre,indexOrig]);
end; // TransfereParamE

Procedure RecalculE;
var p : TcodePage;
    index : TcodeGrandeur;
    c : byte;
    incertCourante : double;
begin // Pour calcul des grandeurs Glb
    for c := 1 to NbreConst do begin
        index := indexConst[pred(c)];
        for p := 1 to NbrePages do begin
            grandeurs[index].valeurPage[p] := pages[p].valeurConst[index];
            incertCourante := pages[p].incertConst[index];
            grandeurs[index].incertPage[p] := incertCourante;
            if (grandeurs[index].fonct.genreC=G_experimentale) then begin
                grandeurs[index].valeurPage[p] := grandeurs[index].valeurPage[p]*grandeurs[index].coeffSI;
                if not isNan(incertCourante) then
                    grandeurs[index].incertPage[p] := incertCourante*grandeurs[index].coeffSI;
            end;
        end;
    end;
    for c := 1 to NbreParam[paramNormal] do // coeffSI à 1 puisque calculé
        for p := 1 to NbrePages do begin
             Parametres[paramNormal,c].valeurPage[p] := pages[p].valeurParam[paramNormal,c];
             Parametres[paramNormal,c].incertPage[p] := pages[p].incertParam[c]
        end;
    for p := 1 to NbrePages do pages[p].RecalculP;
    pages[pageCourante].affecteVariableP(false);
end;

Procedure RecalculFourierE;
var i : integer;
begin
     for i := 1 to NbrePages do pages[i].RecalculFourierP
end;

Procedure RecalculColonneE;
var i : integer;
begin
     for i := 1 to NbrePages do with pages[i] do
         if modifiedP then ReCalculP
end;

Procedure videVariable;
begin
     NbreVariab := 0;
     NbreVariabExp := 0;
     NbreVariabTexte := 0;
     NbreVariabPython := 0;
     NbreConst := 0;
     NbreConstPython := 0;
     NbreConstExp := 0;
     NbreConstTexte := 0;
     NbreConstGlb := 0;
     NbreFiltre := 0;
     FillChar(indexConst,sizeOf(indexConst),grandeurInconnue);
     FillChar(indexConstPython,sizeOf(indexConstPython),grandeurInconnue);
     FillChar(indexConstExp,sizeOf(indexConstExp),grandeurInconnue);
     FillChar(indexConstTexte,sizeOf(indexConstTexte),grandeurInconnue);
     FillChar(indexConstGlb,sizeOf(indexConstGlb),grandeurInconnue);
     FillChar(indexVariab,sizeOf(indexVariab),grandeurInconnue);
     FillChar(indexVariabExp,sizeOf(indexVariabExp),grandeurInconnue);
     FillChar(indexVariabPython,sizeOf(indexVariabPython),grandeurInconnue);
     FillChar(indexVariabTexte,sizeOf(indexVariabTexte),grandeurInconnue);
     FillChar(indexFiltre,sizeOf(indexFiltre),grandeurInconnue);
end;

Procedure ConstruireIndex;
var i : integer;
begin
     VideVariable;
     for i := 0 to pred(NbreGrandeurs) do
         case grandeurs[i].genreG of
              constante : begin
                  indexConst[NbreConst] := i;
                  inc(NbreConst);
                  if grandeurs[i].fonct.genreC=g_experimentale then begin
                     indexConstExp[NbreConstExp] := i;
                     inc(NbreConstExp);
                  end;
                  if grandeurs[i].fonct.genreC=g_PythonConst then begin
                     indexConstPython[NbreConstPython] := i;
                     inc(NbreConstPython);
                  end;
                  if grandeurs[i].fonct.genreC=g_texte then begin
                     indexConstTexte[NbreConstTexte] := i;
                     inc(NbreConstTexte);
                  end;
              end;
              variable : begin
                  indexVariab[NbreVariab] := i;
                  inc(NbreVariab);
                  if grandeurs[i].fonct.genreC=g_experimentale then begin
                     indexVariabExp[NbreVariabExp] := i;
                     inc(NbreVariabExp);
                  end;
                   if grandeurs[i].fonct.genreC=g_PythonVar then begin
                     indexVariabPython[NbreVariabPython] := i;
                     inc(NbreVariabPython);
                  end;
                  if grandeurs[i].fonct.genreC=g_texte then begin
                     indexVariabTexte[NbreVariabTexte] := i;
                     inc(NbreVariabTexte);
                  end;
                  if grandeurs[i].fonct.genreC=g_definitionFiltre then begin
                     indexFiltre[NbreFiltre] := i;
                     inc(NbreFiltre);
                  end;
              end;
              constanteGlb : begin
                  indexConstGlb[NbreConstGlb] := i;
                  inc(NbreConstGlb);
              end;
         end; { case }
      indexConstExp[NbreConstExp] := cNombre;         
end;

Function AjouteGrandeurE(Avariable : tgrandeur) : integer;
var page : integer;
begin
  if NbreGrandeurs=MaxGrandeurs then begin
     AjouteGrandeurE := grandeurInconnue;
     exit;
  end;
  grandeurs[NbreGrandeurs] := Avariable;
  AjouteGrandeurE := NbreGrandeurs;
  if Avariable.genreG in [constante,variable] then
    for page := 1 to NbrePages do
        pages[page].AjouteGrandeurP(NbreGrandeurs);
  if NbrePages>0 then case Avariable.genreG of
     variable : begin
        grandeurs[NbreGrandeurs].valeur := pages[pageCourante].valeurVar[NbreGrandeurs];
        grandeurs[NbreGrandeurs].valIncert := pages[pageCourante].incertVar[NbreGrandeurs];        
     end;
     constante : begin
         grandeurs[NbreGrandeurs].valeurCourante := pages[pageCourante].valeurConst[NbreGrandeurs];
         grandeurs[NbreGrandeurs].incertCourante := pages[pageCourante].incertConst[NbreGrandeurs];
     end;
  end;
  inc(NbreGrandeurs);
  ConstruireIndex;
end;

Function AjouteExperimentale(const n : string;Agenre : TgenreGrandeur) : integer;
var UU : tgrandeur;
    j : integer;
begin
    j := indexNom(n);
    if (j<>grandeurInconnue) and
       (j<maxGrandeurs) and
       (grandeurs[j].genreG=Agenre) then begin
       result := j;
       exit;
    end;
    UU := tgrandeur.Create;
    UU.init(n,'','',Agenre);
    UU.fonct.genreC := g_experimentale;
    result := ajouteGrandeurE(UU)
end;

Procedure CalculIncertConstGlb(i : TcodeGrandeur);
begin with grandeurs[i] do
         case fonct.genreC of
              g_experimentale : ;
              g_fonction : begin
                  if IncertCalcA.calcul<>nil
                    then begin
                      try
                      IncertCourante := calcule(IncertCalcA.calcul);
                      except
                       IncertCourante := Nan;
                      end;
                  end;
              end
              else incertCourante := Nan;
         end;
end;

Procedure Tpage.ReCalculP;
const MaxDiff = 16;
type
    TypeEquation = (eFonction,eDiff1,eDiff2,eEuler);
    TdataDiff = record
        indexDiff : byte;
        Yp1,Yp2 : tgrandeur;
        Fequation : Pelement;
        typeE : TypeEquation;
        idebutEuler : integer;
    end;
    TVecteurSysteme = array[TcodeGrandeur] of double;
var DataDiff : array[1..MaxDiff] of TdataDiff;
    NbreDiff : byte;

Procedure CalculEuler;
var i,k,idebut,ifin : integer;
    z : double;
    BoucleI : Pelement;
begin
    affecteVariableE(0);
    for k := 1 to NbreDiff do with DataDiff[k] do
        if typeE=eFonction then begin
           z := calcule(fequation);
           grandeurs[indexDiff].valeurCourante := z;
           grandeurs[indexDiff].valeur[0] := z;
        end;
    BoucleI := nil;
    for i := 0 to pred(ListeBoucle.count) do
        if (ListeBoucle[i].PvariabI=grandeurs[cIndice]) then begin
           BoucleI := ListeBoucle[i];
           break;
        end;
    if (BoucleI=nil) or (BoucleI.Istart=nil)
       then idebut := 0
       else begin
            idebut := round(calcule(BoucleI.iStart));
            if idebut<0 then idebut := 0
       end;
    if (BoucleI=nil) or (BoucleI.Iend=nil)
       then ifin := pred(nmes)
       else begin
            ifin := round(calcule(BoucleI.iEnd));
            if ifin>=nmes then ifin := pred(nmes);
       end;
    for i := idebut to ifin do begin
        try
        affecteVariableE(i);
        for k := 1 to NbreDiff do with DataDiff[k] do if i>=idebutEuler then begin
           z := calcule(fequation);
           if isNan(z) then z := 0; // initilisation par défaut à 0
           grandeurs[indexDiff].valeurCourante := z;
           grandeurs[indexDiff].valeur[i] := z;
        end;
        except
            on E:exception do derniereErreur := E.message;
        end;
    end; // for i
end; // calculEuler

Procedure CalculDiff12;
// calcul par Runge-Kunta d'ordre 4 de z(t) solution de
//   z''=f(t,z,z') système équivalent : z'=x  z''=x'=f(t,z,x)
//   ou de z'=f(t,z)
var i : integer;
    index : TcodeGrandeur;
    instantDebut : TdateTime;
    coeffSI0 : double;
const dureeMax = 2;  // secondes

Procedure calcPoint;
var  t,deltatsur2 : double;
     p,p1,p2,p2bis,pbis : TVecteurSysteme;
     fp,fp1,fp2,fp2bis,fpbis : TVecteurSysteme;
     val_p,val_pprime : TvecteurSysteme;

Procedure Calc(var ffp,zzp : TvecteurSysteme;t,deltat : double);
var k : byte;
begin
    grandeurs[0].valeurCourante := t;
    for k := 1 to NbreDiff do with DataDiff[k] do begin
       index := indexDiff;
       if (typeE=eDiff2) or (Yp1<>nil) then Yp1.valeurCourante := val_pprime[index];
       grandeurs[index].valeurCourante := val_p[index];
    end;
    for k := 1 to NbreDiff do with DataDiff[k] do begin
       index := indexDiff;
       ffp[index] := calcule(fequation);
       case typeE of
          eDiff2 : begin
            zzp[index] := val_pprime[index];
            val_p[index] := p[index] + deltat*val_pprime[index];
            val_pprime[index] := fp[index] + deltat*ffp[index];
          end;
          eDiff1 : val_p[index] := val_p[index]+deltat*ffp[index];
          eFonction : val_p[index] := ffp[index];
       end;   
    end;
end; // Calc

var k : integer;
    valYsec : double;
begin
     if ((i mod 1024)=0) and (dureeEcoulee(instantDebut)>dureeMax) then
         Application.processMessages;
     t := grandeurs[0].valeur[pred(i)]*coeffSI0;
     deltatSur2 := (grandeurs[0].valeur[i]*coeffSI0-t)/2;
     affecteVariableE(i);
     for k := 1 to NbreDiff do with DataDiff[k] do begin
        index := indexDiff;
        p[index] := grandeurs[index].valeur[pred(i)];
        if (typeE=eDiff2) or (Yp1<>nil) then fp[index] := Yp1.valeur[pred(i)];
     end;
     val_p := p;
     val_pprime := fp;
     Calc(fp1,p1,t,deltatSur2);
     Calc(fp2,p2,t+deltatSur2,deltatSur2);
     Calc(fp2bis,p2bis,t+deltatSur2,deltatSur2*2);
     Calc(fpbis,pbis,t+deltatSur2*2,0);
     for k := 1 to NbreDiff do with DataDiff[k] do begin
        index := indexDiff;
        valYsec := (fp1[index]+2*fp2[index]+2*fp2bis[index]+fpbis[index])/6;
        case typeE of
           eDiff2 : begin
             Yp2.valeur[i] := valYsec;
             Yp1.valeur[i] := Yp1.valeur[pred(i)] + deltatSur2*valYsec*2;
             grandeurs[index].valeur[i] := grandeurs[index].valeur[pred(i)] +
                deltatSur2*(p1[index]+2*p2[index]+2*p2bis[index]+pbis[index])/3;
           end;
           eDiff1 : begin
              Yp1.valeur[i] := valYsec;
              grandeurs[index].valeur[i] := grandeurs[index].valeur[pred(i)] +
                 deltatSur2*valYsec*2;
           end;
           eFonction : grandeurs[index].valeur[i] := valYsec;
       end;
     end;
end; // calcPoint

Procedure calcPoint0;
var k : integer;
    z : double;
begin
     for k := 1 to NbreDiff do with DataDiff[k] do begin
        z := calcule(fequation);
        case typeE of
           eDiff2 : begin
              Yp2.valeur[0] := z;
              Yp2.valeurCourante := z;
           end;
           eDiff1 : begin
              Yp1.valeur[0] := z;
              Yp1.valeurCourante := z;
           end;
           eFonction : begin
              grandeurs[indexDiff].valeurCourante := z;
              grandeurs[indexDiff].valeur[0] := z;
           end;
       end;
     end;
end; // calcPoint0

var j : integer;
begin
     try
     if uniteSIGlb
        then coeffSI0 := grandeurs[0].coeffSI
        else coeffSI0 := 1;
     i := 0;
     instantDebut := time;
     affecteVariableE(0);
     calcPoint0;
     for i := 1 to pred(Nmes) do calcPoint;
     except
         on E:exception do begin
            derniereErreur := E.message;
            for j := i to pred(Nmes) do grandeurs[index].valeur[j] := Nan;
         end;
     end;
end; // CalculDiff12

Procedure CalcCol(i : integer);
var j : integer;
begin
    case grandeurs[i].fonct.genreC of
       g_experimentale : ;
       g_texte : for j := 0 to pred(nmes) do
                    grandeurs[i].valeur[j] := j;
       g_forward : ;
       else if not (grandeurs[i].fonct.isSysteme)
           then CalcColonneP(i,false)
    end;
end;

Procedure ChercheSystDiff(var IndexModifie : integer);
var DiffDepend,DiffVariab : tsetGrandeur;

Procedure AjouteFonct(i : integer);
var j,k : integer;
begin
       if i<indexModifie then indexModifie := i;
       grandeurs[i].fonct.isSysteme := true;
       inc(NbreDiff);
       include(diffVariab,i);
       diffDepend := diffDepend + grandeurs[i].fonct.depend;
       j := 1;
       while (j<NbreDiff) and
             (DataDiff[j].indexDiff<i) do inc(j);
       for k := NbreDiff downto succ(j) do
             DataDiff[k] := DataDiff[pred(k)];
       DataDiff[j].indexDiff := i;
       DataDiff[j].typeE := eFonction;
       DataDiff[j].fequation := grandeurs[i].fonct.calcul;
end;

var i,j : integer;
    index,i0 : TcodeGrandeur;
    DiffTrouve,modif : boolean;
begin // ChercheSystDiff 
       NbreDiff := 0;
       DiffTrouve := false;
       DiffVariab := [];
       DiffDepend := [];
       for i := 0 to pred(NbreGrandeurs) do with grandeurs[i].fonct do
           if (genreC in [g_diff1,g_diff2])  or
              (isSysteme and
               not(genreC in [g_derivee,g_diff1,g_diff2,g_euler])) then begin
                 inc(NbreDiff);
                 if NbreDiff>MaxDiff then begin
                     afficheErreur(erDiffSimul+intToStr(MaxDiff),0);
                     exit;
                 end;
                 with DataDiff[NbreDiff] do begin
                     indexDiff := i;
                     case genreC of
                          g_diff1 : typeE := eDiff1;
                          g_diff2 : typeE := eDiff2;
                          else typeE := eFonction;
                     end;
                     if typeE in [eDiff1,eDiff2]
                        then begin
                           fequation := calcul.OperandGlb;
                           i0 := getIndexInit(grandeurs[i]);
                           if isNan(valeurConst[i0]) then exit; // valeur initiale non définie
                        end
                        else fequation := calcul;
                     diffDepend := diffDepend + depend;
                     include(diffVariab,i);
                     if i<indexModifie then indexModifie := i;
                     DiffTrouve := DiffTrouve or (genreC in [g_diff1,g_diff2]);
                 end;
           end;
       if DiffTrouve
          then begin
               repeat
  // vérifier fonction incluse dans le système diff
               modif := false;
               for i := 0 to pred(NbreGrandeurs) do
                   if not grandeurs[i].fonct.isSysteme and
                      (grandeurs[i].fonct.genreC=g_fonction) and
                      (grandeurs[i].genreG=variable) and
                      (i in DiffDepend) and
                      ((grandeurs[i].fonct.depend*diffVariab<>[]) or
                       ((i>DataDiff[1].indexDiff) and
                        (i<DataDiff[NbreDiff].indexDiff))) then begin
                           if NbreDiff=MaxDiff then begin
                              afficheErreur(erDiffSimul+intToStr(MaxDiff),0);
                              exit;
                           end;
                           modif := true;
                           AjouteFonct(i);
                       end;
               until not modif;
//   modif x0 (varX) oblige à recalculer x' ; x'0 (varY) pour x'' 
          end
          else exit;
       for i := 0 to pred(NbreGrandeurs) do
           if (grandeurs[i].fonct.genreC=g_derivee) and
              (grandeurs[i].genreG=variable) then
                  for j := 1 to NbreDiff do begin
                      if (dataDiff[j].typeE in [eDiff2,eDiff1]) and
                         (dataDiff[j].Yp1=grandeurs[i])
                           then grandeurs[i].fonct.isSysteme := true;
                      if (dataDiff[j].typeE=eDiff2) and
                         (dataDiff[j].Yp2=grandeurs[i])
                           then grandeurs[i].fonct.isSysteme := true;
                  end;
       for i := 1 to NbreDiff do with DataDiff[i] do begin
           index := indexDiff;
           with grandeurs[index].fonct.calcul^ do
                case typeE of
                    eDiff1 : begin
                        Yp1 := grandeurs[index].fonct.addrYp;
                        grandeurs[index].valeur[0] := varX.valeurCourante;
                        Yp1.fonct.isSysteme := true;
                    end;
                    eDiff2 : begin
                        Yp1 := grandeurs[index].fonct.addrYp;
                        Yp2 := grandeurs[index].fonct.addrYp2;
                        grandeurs[index].valeur[0] := varX.valeurCourante;
                        Yp1.valeur[0] := varY.valeurCourante;
                        Yp1.fonct.isSysteme := true;
                        Yp2.fonct.isSysteme := true;
                    end;
                    else begin
                        Yp1 := nil;
                        Yp2 := nil;
                    end;
               end;{case}
       end;
       for i := 0 to pred(NbreGrandeurs) do
           if (i in DiffDepend) and not(i in DiffVariab)
              then calcCol(i);
       calculDiff12;
end; // ChercheSystDiff

Procedure ChercheEuler(var IndexModifie : integer);
var DiffDepend,DiffVariab : tsetGrandeur;

Procedure AjouteFonct(i : integer);
var j,k : integer;
begin
       if i<indexModifie then indexModifie := i;
       grandeurs[i].fonct.isSysteme := true;
       inc(NbreDiff);
       include(diffVariab,i);
       diffDepend := diffDepend + grandeurs[i].fonct.depend;
       j := 1;
       while (j<NbreDiff) and
             (DataDiff[j].indexDiff<i) do inc(j);
       for k := NbreDiff downto succ(j) do
             DataDiff[k] := DataDiff[pred(k)];
       DataDiff[j].indexDiff := i;
       DataDiff[j].typeE := eFonction;
       DataDiff[j].fequation := grandeurs[i].fonct.calcul;
end;

var i : integer;
    DiffTrouve,modif : boolean;
begin // ChercheEuler
       NbreDiff := 0;
       DiffTrouve := false;
       DiffVariab := [];
       DiffDepend := [];
       for i := 0 to pred(NbreGrandeurs) do with grandeurs[i].fonct do
           if (genreC=g_euler) or
              (isSysteme and not(genreC in [g_derivee,g_diff1,g_diff2,g_euler])) then begin
                 inc(NbreDiff);
                 if NbreDiff>MaxDiff then begin
                     afficheErreur(erDiffSimul+intToStr(MaxDiff),0);
                     exit;
                 end;
                 with DataDiff[NbreDiff] do begin
                     indexDiff := i;
                     if genreC=g_euler
                        then typeE := eEuler
                        else typeE := eFonction;
                     fequation := calcul;
                     diffDepend := diffDepend + depend;
                     include(diffVariab,i);
                     if i<indexModifie then indexModifie := i;
                     DiffTrouve := DiffTrouve or (genreC=g_euler);
                 end;
           end;
       if DiffTrouve
          then begin
               repeat
// vérifier fonction incluse dans le système
               modif := false;
               for i := 0 to pred(NbreGrandeurs) do
                   if not grandeurs[i].fonct.isSysteme and
                      (grandeurs[i].fonct.genreC=g_fonction) and
                      (grandeurs[i].genreG=variable) and
                      (i in DiffDepend) and
                      ((grandeurs[i].fonct.depend*diffVariab<>[]) or
                       ((i>DataDiff[1].indexDiff) and
                        (i<DataDiff[NbreDiff].indexDiff))) then begin
                           if NbreDiff=MaxDiff then begin
                              afficheErreur(erDiffSimul+intToStr(MaxDiff),0);
                              exit;
                           end;
                           modif := true;
                           AjouteFonct(i);
                       end;
               until not modif;
// modif x0 (varX) oblige à recalculer x' ;  x'0 (varY) pour x''
          end
          else exit;
       for i := 1 to NbreDiff do with DataDiff[i] do begin  // initialise Euler
           iDebutEuler := 0;
           if typeE=eEuler then with grandeurs[indexDiff] do begin
                 if varInit<>nil then begin
                      valeur[0] := varInit.valeurCourante;
                      iDebutEuler := 1;
                 end
                 else valeur[0] := 0;
                 fonct.isSysteme := true;
             end;
       end;
       for i := 0 to pred(NbreGrandeurs) do
          if (i in DiffDepend) and not(i in DiffVariab)
             then calcCol(i);
       calculEuler;
end; // ChercheEuler

procedure RemplitPage;
var i : integer;
begin
      getDeltaSimulation;
      valeurVar[0,0] := MiniSimulation;
      if logSimulation
         then for i := 1 to Nmes do
                 valeurVar[0,i] := valeurVar[0,pred(i)]*FdeltaSimulation
         else for i := 1 to Nmes do
                valeurVar[0,i] := MiniSimulation+i*FdeltaSimulation;
      AffecteNbreFFT;
      PeriodeFFT := MaxiSimulation-MiniSimulation;
      modifiedP := true;
      grandeurs[cDeltat].valeurCourante := FdeltaSimulation;
      precisionPeigne := FdeltaSimulation/2;
end;

var i,iModifie : integer;
    avecDiff : boolean;
begin // Tpage.recalculP
    if NbreGrandeurs=0 then exit;
    affecteConstParam(false);
    affecteVariableP(false); // recupère les valeurs des grandeurs dans la page considérée
    if ModeAcquisition=acqSimulation then remplitPage;
    AvecDiff := true;
    iModifie := NbreGrandeurs;
    for i := 0 to pred(NbreGrandeurs) do begin
         if Grandeurs[i].fonct.genreC in [g_diff1,g_diff2,g_euler] then begin
              iModifie := i;
              break;
         end;
         if Grandeurs[i].fonct.genreC=g_forward then begin
              avecDiff := false;
              break;
         end;
    end;
    for i := 0 to pred(iModifie) do
        calcCol(i);
    if avecDiff then begin
         iModifie := NbreGrandeurs;
         chercheEuler(iModifie);
         chercheSystDiff(iModifie);
    end;
    for i := succ(iModifie) to pred(NbreGrandeurs) do
        calcCol(i);
    for i := 0 to pred(NbreGrandeurs) do
        calculIncertG(i);
    modifiedP := false;
end; // Tpage.recalculP

Procedure Tpage.ReCalculFourierP;
var i : integer;
    Modif : TsetGrandeur;
begin
    affecteConstParam(false);
    affecteVariableP(false);
    Modif := [];
    if finFFT=-1 then affecteNbreFFT; (*debutFFT=0 ? *)
    for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
        if ( (genreG=variable)  and
             (fonct.genreC in [g_correlation,g_enveloppe,g_decalage,
                 g_retardCorr,g_filtrage,g_definitionFiltre,g_harmonique]) ) or
           (fonct.depend*Modif<>[])
              then begin
                   CalcColonneP(i,false);
                   include(modif,i);
              end;
    modifiedP := false;
end; // Tpage.recalculFourierP

procedure Tpage.CalcColonneP(index : TcodeGrandeur;lisse : boolean);
var indexX : integer;

Procedure calculFiltrage;
 { filtrage : grandeur*operandGlb dans l'espace des fréquences }
var  i,j : integer;
     z : Tcomplexe;
     x,y : double;
     NfiltreCalc : integer;
     sauveFenetre : Tfenetre;
     sauveDebut,sauveFin : integer;
begin
    sauveFenetre := fenetre;
    fenetre := rectangulaire;
    sauveDebut := debutFFT;
    sauveFin := finFFT;
    debutFFT := 0;
    finFFT := pred(nmes);
    GenereSpectreFourierP(indexX);
    NewFourierP(index);
    NfiltreCalc := -1;
    for j := 0 to pred(NbreFiltre) do
        if indexFiltre[j]<index then NfiltreCalc := j;
    for i := 0 to NbreFFT div 2 do begin
        grandeurs[cFrequence].valeurCourante := grandeurs[cFrequence].valeur[i];
        for j := 0 to NfiltreCalc do with grandeurs[indexFiltre[j]] do begin
              valeurCourante := valeurR[i];
              valeurCouranteIm := valeurI[i];
        end;
        grandeurs[cIndice].valeurCourante := i;
        x := fftReel[indexX][i];
        y := fftImag[indexX][i];
        try
        calculeCpx(grandeurs[index].fonct.calcul^.operandGlb,z);
        fftReel[index,i] := z.reel*x-z.imag*y;
        fftImag[index,i] := z.reel*y+z.imag*x;
        except
            if i=0 { f=0 à part pour éviter erreur /0 lors de passe-bande }
               then begin
                   fftReel[index,0] := 0;
                   fftImag[index,0] := 0;
               end
               else raise
        end;
    end;{for i}
    for i := succ(NbreFFT div 2) to pred(NbreFFT) do begin
    // f<0 donc complexe conjugué pour signal réel
        fftReel[index,i] := fftReel[index,NbreFFT-i];
        fftImag[index,i] := -fftImag[index,NbreFFT-i];
    end;{for i}
    FourierInverse(Nmes,NbreFFT,DebutFFT,PeriodeFFT,grandeurs[indexTri].valeur,
       grandeurs[index].valeur,fftReel[index],fftImag[index],c_spectre);
    fenetre := sauveFenetre;
    debutFFT := sauveDebut;
    finFFT := sauveFin;
end; // calculFiltrage

Procedure calculDefinitionFiltre;
// définition d'un filtre dans l'espace des fréquences
// et réponse impulsionnelle dans l'espace temporel
var  i,j : integer;
     z : Tcomplexe;
     sauveFenetre : Tfenetre;
     NfiltreCalc : integer;
     sauveDebut,sauveFin : integer;
begin
    sauveFenetre := fenetre;
    fenetre := rectangulaire;
    sauveDebut := debutFFT;
    sauveFin := finFFT;
    debutFFT := 0;
    finFFT := pred(nmes);
    GenereSpectreFourierP(index);
    NfiltreCalc := -1;
    for j := 0 to pred(NbreFiltre) do
        if indexFiltre[j]<index then NfiltreCalc := j;
    for i := 0 to NbreFFT div 2 do begin
          grandeurs[cFrequence].valeurCourante := grandeurs[cFrequence].valeur[i];
          for j := 0 to NFiltreCalc do with grandeurs[indexFiltre[j]] do begin
              valeurCourante := valeurR[i];
              valeurCouranteIm := valeurI[i];
          end;
          grandeurs[cIndice].valeurCourante := i;
          try
          calculeCpx(grandeurs[index].fonct.calcul^.operandGlb,z);
          fftReel[index,i] := z.reel;
          fftImag[index,i] := z.imag;
          except
             if i=0
// f=0 à part pour éviter erreur /0 lors de passe-bande ou passe-haut 
                then begin
                     fftReel[index,0] := 0;
                     fftImag[index,0] := 0;
                end
                else raise
          end;
          fftAmpl[index,i] := sqrt(sqr(fftReel[index,i])+sqr(fftImag[index,i]));
    end;{for i}
    for i := succ(NbreFFT div 2) to pred(NbreFFT) do begin
        fftReel[index,i] := fftReel[index,NbreFFT-i];
        fftImag[index,i] := -fftImag[index,NbreFFT-i];
    end;
    FourierInverse(Nmes,NbreFFT,0,PeriodeFFT,grandeurs[indexTri].valeur,
       grandeurs[index].valeur,fftReel[index],fftImag[index],c_spectre);
 // réponse impulsionnelle
    fenetre := sauveFenetre;
    debutFFT := sauveDebut;
    finFFT := sauveFin;
end; // calculDefinitionFiltre

Procedure calculEnveloppe;
var Ne : integer;
    Xe,Ye : Tvecteur;

Procedure chercheEquation(const X,Y : Tvecteur);
var i : integer;
    eqV : Tvecteur;
    eqE : Pelement;
begin
     setLength(Xe,Nmes);
     setLength(Ye,Nmes);
     setLength(eqV,Nmes);
     eqE := grandeurs[index].fonct.calcul.operandGlb;
     for i := 0 to pred(Nmes) do begin
         affecteVariableE(i);
         eqV[i] := calcule(eqE);
     end;
     Ne := 0;
     for i := 0 to Nmes-2 do
         if eqV[i]*eqV[succ(i)]<=0 then begin
            Xe[Ne] := X[i]-eqV[i]*(X[succ(i)]-X[i])/(eqV[succ(i)]-eqV[i]);
            Ye[Ne] := Y[i]+(Xe[Ne]-X[i])*(Y[succ(i)]-Y[i])/(X[succ(i)]-X[i]);
            inc(Ne);
         end;
     eqV := nil;
end;

var sauveFenetre : TFenetre;
begin
   indexX := grandeurs[index].fonct.calcul^.varX.indexG;
   case round(grandeurs[index].fonct.calcul^.valeurGlb) of
        envMax : chercheMinMax(grandeurs[0].valeur,grandeurs[indexX].valeur,Nmes,
                          true,Ne,Xe,Ye);
        envMin : chercheMinMax(grandeurs[0].valeur,grandeurs[indexX].valeur,Nmes,
                          false,Ne,Xe,Ye);
        envEqu : chercheEquation(grandeurs[0].valeur,grandeurs[indexX].valeur);
        envFourier : begin
             sauveFenetre := fenetre;
             fenetre := Rectangulaire;
             CalculFourierP(indexX,c_enveloppe);
             EnveloppeReelle(Nmes,NbreFFT,PeriodeFFT,grandeurs[0].valeur,
                grandeurs[index].valeur,
                fftReel[indexX],fftImag[indexX]);
             fenetre := sauveFenetre;
             GenereSpectreFourierP(indexX);
             exit;
        end;
   end;
   if Ne<=3
      then affecteVecteur(grandeurs[index].valeur,grandeurs[indexX].valeur)
      else chercheEnveloppe(grandeurs[0].valeur,Nmes,
                    Xe,Ye,Ne,
                    grandeurs[index].valeur);
   Xe := nil;
   Ye := nil;
end; // calculEnveloppe

Procedure calculRetard;
var i : integer;
    coeff,maxi : double;
begin
    Maxi := valeurVar[0,pred(nmes)]-valeurVar[0,0];
    try
    coeff := 1/pred(nmes);
    for i := 0 to pred(nmes) do
        valeurVar[index,i] := Maxi*i*coeff
    except
    end;
end; // calculRetard (pour corrélation)

Procedure calculHarmonique;
// harmonique debut à fin de grandeur
var  i,idebut,ifin : integer;
     sauveFenetre : Tfenetre;
     largeurRaie : integer;
begin
    sauveFenetre := fenetre;
    fenetre := rectangulaire;
    DefinitGrandeurFrequence;
    calculFourierP(indexX,c_spectre);
    newFourierP(index);
    with grandeurs[index].fonct.calcul^ do
    try
        iDebut := round(calcule(OperandGlb));
        ifin := round(calcule(OperandDebut));
    except
        idebut := 1;
        ifin := 1;
    end;
    iRaie1[index] := getFondamental(NbreFFT,fftAmpl[indexX]);
    largeurRaie := iRaie1[index] div 16;
    iDebut := iDebut*iRaie1[index]-largeurRaie;
    iFin := iFin*iRaie1[index]+largeurRaie;
    if iDebut<0 then iDebut := 0;
    if iFin<iDebut then iFin := iDebut;
    if iFin>(NbreFFT div 2) then iFin := NbreFFT div 2;
    if iDebut>iFin then iDebut := iFin;
    for i := 0 to pred(idebut) do begin
             fftReel[index,i] := 0;
             fftImag[index,i] := 0;
    end;{for i}
    for i := idebut to ifin do begin
             fftReel[index,i] := fftReel[indexX,i];
             fftImag[index,i] := fftImag[indexX,i];
    end;{for i}
    for i := succ(ifin) to NbreFFT div 2 do begin
             fftReel[index,i] := 0;
             fftImag[index,i] := 0;
    end;{for i}
    { facteur *2 pour le continu pris en compte par FFT ? }
(*    fftReel[index]^[0] := 2*fftReel[index]^[0];
    fftImag[index]^[0] := 2*fftImag[index]^[0];*)
    for i := succ(NbreFFT div 2) to pred(NbreFFT) do begin
        fftReel[index,i] := fftReel[index,NbreFFT-i];
        fftImag[index,i] := -fftImag[index,NbreFFT-i];
    end;{for i}
    FourierInverse(Nmes,NbreFFT,0,PeriodeFFT,grandeurs[indexTri].valeur,
       grandeurs[index].valeur,fftReel[index],fftImag[index],c_spectre);
    fenetre := sauveFenetre;
    GenereSpectreFourierP(indexX);
end; // calculHarmonique

procedure calculCorrelation;
var indexY : integer;
    i : integer;
    tampon : Tvecteur;
    coeff,coeffX,coeffY,dt : double;
    sauveFenetre : Tfenetre;
    sauveDebut,sauveFin : integer;
begin with grandeurs[index].fonct.calcul^ do begin
    sauveFenetre := fenetre;
    fenetre := rectangulaire;  // obligatoire mais il reste le leakage
//    fenetre := AjusteRect; // suppression du leakage ?
    sauveDebut := debutFFT;
    sauveFin := finFFT;
    indexY := varY.indexG;
    debutFFT := 0;
    finFFT := pred(nmes);
    setLength(tampon,NmesMax+1);
    calculFourierP(indexX,c_correlation);
    calculFourierP(indexY,c_correlation);
    newFourierP(index);
    fftReel[index,0] := fftReel[indexX,0]*fftReel[indexY,0]*2;
    fftImag[index,0] := 0;
    for i := 1 to pred(NbreFFT) do begin // conjugue(x)*y
        fftReel[index,i] := fftReel[indexX,i]*fftReel[indexY,i]+
                     fftImag[indexY,i]*fftImag[indexX,i];
        fftImag[index,i] := fftReel[indexX,i]*fftImag[indexY,i]-
                     fftImag[indexX,i]*fftReel[indexY,i];
    end;// for i
    dt := PeriodeFFT/NbreFFT;
    for i := 0 to pred(Nmes) do
        Tampon[i] := i*dt;
    FourierInverse(Nmes,NbreFFT,0,PeriodeFFT,tampon,
        grandeurs[index].valeur,fftReel[index],fftImag[index],c_correlation);
    if indexX=indexY
       then coeff := 1/grandeurs[index].valeur[0]
       else begin
           coeffX := 0;coeffY := 0;
           for i := 0 to pred(Nmes) do begin
               coeffX := coeffX+sqr(grandeurs[indexX].valeur[i]);
               coeffY := coeffY+sqr(grandeurs[indexY].valeur[i]);
           end;
           coeff := Nmes/sqrt(coeffX*coeffY)/2;
       end;
    for i := 0 to pred(Nmes) do
        grandeurs[index].valeur[i] := coeff*grandeurs[index].valeur[i];
    tampon := nil;
    fenetre := sauveFenetre;
    debutFFT := sauveDebut;
    finFFT := sauveFin;
end end; // calculCorrelation

Procedure calculDerivee; // d(vary)/d(varx)
var vi : TvecteurInt;
    valeurX,valeurY,valeurDer : Tvecteur;
    i,j : integer;
    degreDer,NbrePointDer : integer;
    coeff : double;
begin with grandeurs[index].fonct.calcul^ do begin
   GetParamDerivee(operandGlb,operandDebut,degreDer,NbrePointDer);
   setLength(vi,NmesMax+2);
   setLength(valeurDer,NmesMax+2);
   CopyVecteur(valeurX,varX.valeur);
   CopyVecteur(valeurY,varY.valeur);
   j := 0;
   for i := 0 to pred(nmes) do begin
       if not isNan(valeurX[i]) and
          not isNan(valeurY[i]) then begin
             vi[j] := i;
             valeurX[j] := valeurX[i];
             valeurY[j] := valeurY[i];
             inc(j);
       end
       else grandeurs[index].valeur[i] := Nan;
       incertVar[index][i] := Nan;
   end;
   DeriveeGauss(valeurX,valeurY,j,valeurDer,degreDer,NbrePointDer);
   for i := 0 to pred(j) do
       grandeurs[index].valeur[vi[i]] := valeurDer[i];
   if uniteSIGlb and (varY.puissance<>varX.puissance) then  begin
      coeff := dix(varY.puissance-varX.puissance);
      for i := 0 to pred(nmes) do with grandeurs[index] do
          valeur[i] := valeur[i]*coeff;
   end;
   vi := nil;valeurX := nil;valeurY := nil;valeurDer := nil;
end end; // calculDerivee

Procedure calculDeriveeSeconde; // d2(vary)/d(varx)2
var vi : TvecteurInt;
    valeurX,valeurY,valeurDer : Tvecteur;
    i,j : integer;
    degreDer,NbrePointsDer : integer;
    coeff : double;
begin with grandeurs[index].fonct.calcul^ do begin
   GetParamDerivee(operandGlb,operandDebut,degreDer,NbrePointsDer);
   setLength(vi,NmesMax+2);
   setLength(valeurDer,NmesMax+2);
   CopyVecteur(valeurX,varX.valeur);
   CopyVecteur(valeurY,varY.valeur);
   j := 0;
   for i := 0 to pred(nmes) do begin
       if not isNan(valeurX[i]) and
          not isNan(valeurY[i]) then begin
             vi[j] := i;
             valeurX[j] := valeurX[i];
             valeurY[j] := valeurY[i];
             inc(j);
       end
       else grandeurs[index].valeur[i] := Nan;
       incertVar[index][i] := Nan;
   end;
   DeriveeSecondeGauss(valeurX,valeurY,j,valeurDer,degreDer,nbrePointsDer);
   for i := 0 to pred(j) do
       grandeurs[index].valeur[vi[i]] := valeurDer[i];
   if uniteSIGlb then begin
      coeff := dix(varY.puissance-2*varX.puissance);
      for i := 0 to pred(nmes) do with grandeurs[index] do
          valeur[i] := valeur[i]*coeff;
   end;
   vi := nil;valeurX := nil;valeurY := nil;valeurDer := nil;
end end;// calculDeriveeSeconde

Procedure calculLissageGlissant;
var ordre : integer;
begin with grandeurs[index] do begin
   if fonct.calcul^.operandDebut=nil
      then ordre := ordreFiltrage
      else ordre := round(calcule(fonct.calcul^.operandDebut));
   MoyGlissante(fonct.calcul^.varX.valeur,valeur,ordre,nmes)
end end;// calculLissageGlissant

Procedure calculLissageCentre;
var ordre : integer;
begin with grandeurs[index] do begin
   if fonct.calcul^.operandDebut=nil
      then ordre := ordreFiltrage
      else ordre := round(calcule(fonct.calcul^.operandDebut));
   MoyCentree(fonct.calcul^.varX.valeur,valeur,ordre,nmes)
end end;// calculLissageCentre

Procedure calculFreqInst;
var i,j,iDebut : integer;
    freq : double;
    Di,Diprec : double;
    voieF : Tgrandeur;
    seuil,ymax,ymin,valeurC : double;
    seuilTrouve : boolean;
    tStart,tCourant : double;
begin with grandeurs[index] do begin
     voieF := fonct.calcul^.varx;
     if (fonct.calcul.operandFin<>nil)
        then seuil := calcule(fonct.calcul.OperandFin)
        else begin
            ymin := voieF.valeur[0];
            ymax := voieF.valeur[0];
            for i := 1 to pred(nmes) do begin
                valeurC := voieF.valeur[i];
                if valeurC>ymax
                   then ymax := valeurC
                   else if valeurC<ymin then ymin := valeurC;
            end;
            seuil := (ymax+ymin)/2;
            if ymin*ymax<0 then begin
               valeurC := (ymax-ymin)/32;
               if seuil<valeurC then seuil := 0;
            end;
        end;
     i := 0;
     Di := voieF.valeur[0];
     freq := 0;
     repeat
        inc(i);
        DiPrec := Di;
        Di := voieF.valeur[i];
        seuilTrouve := (Di>=seuil) and (DiPrec<seuil);
     until seuilTrouve or (i>=(Nmes-1));
     // traversée du seuil vers le haut à i
     iDebut := 0; // début du remplissage
     tStart := grandeurs[0].valeur[i]-
        (grandeurs[0].valeur[i]-grandeurs[0].valeur[i-1])*
        (voieF.valeur[i]-seuil)/(voieF.valeur[i]-voieF.valeur[i-1]);// interpolation
     while i<(Nmes-8) do begin
         inc(i,3); // "hystérésis" temporel
         while  (i<=(Nmes-6)) and (voieF.valeur[i]>=seuil) do inc(i);
// on est repassé en dessous valeur[i]<seuil
         inc(i,3);
         while (i<(Nmes-2)) and (voieF.valeur[i]<seuil) do inc(i);
// on est repassé au dessus valeur[i]>=seuil
         if (voieF.valeur[i]>=seuil) then begin
            tCourant := grandeurs[0].valeur[i]-
                (grandeurs[0].valeur[i]-grandeurs[0].valeur[i-1])*
                (voieF.valeur[i]-seuil)/(voieF.valeur[i]-voieF.valeur[i-1]);// interpolation
            freq := 1/(tCourant-tStart);
            for j := iDebut to pred(i) do valeur[j] := freq;
            iDebut := i;
            tStart := tCourant;
         end;
    end; // while i
    for j := iDebut to pred(nmes) do valeur[j] := freq; // on prend la dernière valeur
end end;// calculFreqInst

Procedure calculRMSInst;
var i,j,iDebut : integer;
    Di,Diprec : double;
    voieF : Tgrandeur;
    seuil,ymax,ymin,valeurC : double;
    seuilTrouve : boolean;
    somme,hyster : double;
begin with grandeurs[index] do begin
     voieF := fonct.calcul^.varx;
     if (fonct.calcul.operandFin<>nil)
        then begin
           seuil := calcule(fonct.calcul.OperandFin);
        end
        else begin
            ymin := voieF.valeur[0];
            ymax := voieF.valeur[0];
            for i := 1 to pred(nmes) do begin
                valeurC := voieF.valeur[i];
                if valeurC>ymax
                   then ymax := valeurC
                   else if valeurC<ymin then ymin := valeurC;
            end;
            seuil := (ymax+ymin)/2;
            if ymin*ymax<0 then begin
               valeurC := (ymax-ymin)/32;
               if seuil<valeurC then seuil := 0;
            end;
        end;
     Di := voieF.valeur[0];
     somme := 0;
     if nmes>15 then iDebut := 15 else iDebut := pred(nmes);
     for i := 0 to iDebut do
         somme := somme+sqr(voieF.valeur[i]-seuil);
     somme := sqrt(somme/(iDebut+1));
     i := 0;
     repeat
        inc(i);
        DiPrec := Di;
        Di := voieF.valeur[i];
        seuilTrouve := (Di>=seuil) and (DiPrec<seuil);
     until seuilTrouve or (i>=(Nmes-1));
     // traversée du seuil vers le haut à i
     // sans hystérèsis, donc on peut se planter au premier coup ; à voir
     iDebut := 0; // début du remplissage
     while i<(Nmes-8) do begin
         hyster := somme/10;
         inc(i,2);
         while (i<=(Nmes-6)) and (voieF.valeur[i]<(seuil+hyster)) do inc(i);// hystérésis
         while (i<=(Nmes-6)) and (voieF.valeur[i]>=seuil) do inc(i);
// on est repassé en dessous valeur[i]<seuil
         inc(i,2);
         while (i<=(Nmes-6)) and (voieF.valeur[i]>(seuil-hyster)) do inc(i);// hystérésis
         while (i<(Nmes-2)) and (voieF.valeur[i]<seuil) do inc(i);
// on est repassé au dessus valeur[i]>=seuil
         if (voieF.valeur[i]>=seuil) then begin
            somme := 0;
            for j := iDebut to pred(i) do somme := somme+sqr(voieF.valeur[j]);
            somme := sqrt(somme/(i-iDebut));
            for j := iDebut to pred(i) do valeur[j] := somme;
            iDebut := i;
         end;
    end; // while i
    for j := iDebut to pred(nmes) do valeur[j] := somme; // on prend la dernière valeur
end end;// calculRMSInst

Procedure CalculIntegrale;
// intégrale operandGlb / varx
var  i : integer;
     yprec,y,xprec,x : double;
     vecteurX : Tvecteur;
     coeff : double;
begin with grandeurs[index] do begin
        if uniteSIGlb
            then coeff := fonct.calcul^.varX.coeffSI
            else coeff := 1;
        copyVecteur(vecteurX,fonct.calcul^.varX.valeur);
        affecteVariableE(0);
        try
       	yprec := calculeLoc(fonct.calcul^.operandGlb);
        except
           yprec := 0;
        end;
      	valeur[0] := 0;
       	xprec := vecteurX[0];
      	for i := 1 to pred(nmes) do begin
      	   affecteVariableE(i);
           try
	         y := calculeLoc(fonct.calcul^.operandGlb);
      	   x := vecteurX[i]*coeff;
           valeur[i] := (x-xprec)*(y+yprec)/2+valeur[pred(i)];
       	   yprec := y;
           xprec := x;
           except
              on E:exception do begin
                 derniereErreur := E.message;
                 valeur[i] := Nan;
              end;
           end;
     	end;// for i
   	  affecteVariableE(0);
      vecteurX := nil;
end end;// CalculIntegrale

Procedure CalculFonction;
const NbreErreurMax = 3;
var i : integer;
begin with grandeurs[index] do begin
     for i := 0 to pred(nmes) do begin
         affecteVariableE(i);
         try
            valeur[i] := calcule(fonct.calcul);
            CalculIncertitudeFonct(valIncert[i]);
            if uniteSIGlb and uniteImposee then
               valeur[i] := valeur[i]/coeffSI;
         except
            on E:exception do begin
               derniereErreur := E.message;
               valeur[i] := Nan;
               valIncert[i] := Nan;
            end;
         end;
     end;{i}
end end;// calculFonction

procedure CalculPhaseContinue;
var deuxPi : double;
    i : integer;
begin with grandeurs[index] do begin
     if angleEnDegre then deuxPi := 360 else DeuxPi := 2*pi;
     CopyVecteur(valeur,fonct.calcul^.varX.valeur);
     for i := 1 to pred(nmes) do
         valeur[i] := valeur[i]-
               round((valeur[i]-valeur[pred(i)])/DeuxPi)*DeuxPi
end end;

// Tpage.CalcColonneP
begin with grandeurs[index] do begin
   if (nmes=0) and (genreG<>constanteGlb) then exit;
   libereFourierP(index);
   if (fonct.calcul^.typeElement=fonctionGlb) and (fonct.calcul^.varX<>nil)
      then indexX := fonct.calcul^.varX.indexG
      else indexX := grandeurInconnue;
   if lisse then begin
      GenereLisseP(index);
      if valeurLisse[index]=valeurVar[index] then exit;
   end;
   affecteVariableP(lisse);
   try
   case genreG of
       constante : begin
           grandeurs[cIndice].valeurCourante := 0;
           try
           valeurCourante := calcule(fonct.calcul);
           if uniteSIGlb and uniteImposee then
              valeurCourante := valeurCourante*coeffSI;
           except on E:exception do begin
              derniereErreur := E.message;
              valeurCourante := Nan;
           end end;
           valeurConst[index] := valeurCourante;
       end;
       constanteGlb : begin
           grandeurs[cIndice].valeurCourante := 0;
           try
           valeurCourante :=  calcule(fonct.calcul);
           if uniteSIGlb and uniteImposee then
              valeurCourante := valeurCourante*coeffSI;
           except
               on E:exception do begin
                  derniereErreur := E.message;
                  valeurCourante := Nan;
               end;
           end;
           CalculIncertConstGlb(index);
       end;
       variable : case Fonct.genreC of
             g_correlation : calculCorrelation;
             g_filtrage : calculFiltrage;
             g_definitionFiltre : calculDefinitionFiltre;
             g_harmonique : calculHarmonique;
             g_enveloppe : calculEnveloppe;
             g_retardCorr : calculRetard;
             g_diff1,g_diff2,g_euler : ; // fait au niveau global : système différentiel
             g_integrale : calculIntegrale;
             g_derivee : if not Fonct.isSysteme then calculDerivee;
             g_deriveeSeconde : if not Fonct.isSysteme then calculDeriveeSeconde;
             g_lissageGlissant : calculLissageGlissant;
             g_lissageCentre : calculLissageCentre;
             g_FreqInst : calculFreqInst;
             g_RmsInst : calculRmsInst;
             g_phaseContinue : calculPhaseContinue;
             g_forward : ; // calculé ailleurs système diff
             g_experimentale,g_texte : ;
             else if not Fonct.isSysteme then
                  calculFonction // g_fonction,g_equation
       end;
    end;
    except
        on E:exception do derniereErreur := E.message;
    end;
end end; // calcColonneP

Procedure Tpage.RemplitVarLisse;
// Avec résultat de la modélisation 

Procedure completer(i : TcodeIntervalle);
var j,jdebut : integer;
    k : TcodeIntervalle;
begin with fonctionTheorique[i] do begin
    GenereLisseP(indexY);
    jdebut := debut[i];
    if not isNan(X_inter[i]) then
       while (jdebut>1) and (jdebut>fin[pred(i)]) and
             (grandeurs[indexX].valeur[jdebut]>X_inter[i])
            do dec(jdebut);
       for k := 1 to pred(i) do if jdebut<fin[k] then jdebut := fin[k];
       for j := jdebut to pred(nmes) do
           valeurLisse[indexY,j] := valeurTheorique[i,j];
end end;

var i : TcodeIntervalle;
    v,index,j : integer;
    complete : boolean;
    dependLisse,dependModele : TsetGrandeur;
begin // RemplitVarLisse 
  affecteConstParam(false);
  dependLisse := [] ;
  for i := 1 to NbreModele do with fonctionTheorique[i] do begin
      include(dependLisse,indexY);
      LibereLisseP(indexX);
  end;
  for i := 1 to NbreModele do begin
      complete := false;
      for j := 1 to pred(i) do
          if fonctionTheorique[j].indexY=fonctionTheorique[i].indexY
             then begin
                completer(i);
                complete := true;
                break;
             end;
      if not complete then with fonctionTheorique[i] do begin
         GenereLisseP(indexY);
         if valeurVar[indexY]<>valeurLisse[indexY] then
            copyVecteur(valeurLisse[indexY],valeurTheorique[i]);
      end;
  end;
  if fonctionTheorique[1].genreC=g_diff2 then
     for i := 1 to NbreModele do
	       include(dependLisse,FonctionTheorique[i].indexYp);
  dependModele := dependLisse;
  for v := 0 to pred(NbreVariab) do begin
      index := indexVariab[v];
      if not (index in dependModele) then with grandeurs[index] do
	    if (genreG=Variable) and
         (not(fonct.genreC in [g_experimentale,g_texte])) and
         (fonct.depend*dependLisse <> [])
      then begin
		      calcColonneP(index,true);
		      include(dependLisse,index);
		  end
		  else LibereLisseP(index);
   end;
end; // RemplitVarLisse 

Procedure Tpage.CalculGlb;
// Fonction "globales" : dérivée maxi ...
var v : integer;
    dependGlb : TsetGrandeur;
begin
  affecteConstParam(false);
  dependGlb := [] ;
  for v := 0 to pred(NbreGrandeurs) do with grandeurs[v] do
      if not(fonct.genreC in [g_experimentale,g_texte]) and
              ((fonct.calcul^.TypeElement=fonctionGlb) or
               (fonct.depend*dependGlb <> [])) or
               fonct.contientCalculGlb
         then begin
           calcColonneP(v,false);
           include(dependGlb,v);
         end
end;// CalculGlb

Function CreerPythonVar(const nom : string) : TcodeGrandeur;
var UU : tgrandeur;
    index : integer;
begin
    UU := tgrandeur.Create;
    UU.init(nom,'','',variable);
    UU.fonct.genreC := g_PythonVar;
    index := ajouteGrandeurE(UU);
    if (index<>GrandeurInconnue) then with grandeurs[index] do begin
       fonct.expression := NomFonctionGlb[PythonVar];
       fonct.calcul := genFonctionGlb(pythonVar,nil,nil,nil,grandeurs[index],nil);
    end;
    result := index;
end;

Function CreerPythonConst(const nom : string) : TcodeGrandeur;
var UU : tgrandeur;
    index : integer;
begin
    UU := tgrandeur.Create;
    UU.init(nom,'','',constante);
    UU.fonct.genreC := g_PythonConst;
    index := ajouteGrandeurE(UU);
    if (index<>GrandeurInconnue) then with grandeurs[index] do begin
       fonct.expression := NomFonctionGlb[PythonConst];
       fonct.calcul := genFonctionGlb(pythonConst,nil,nil,nil,grandeurs[index],nil);
    end;
    result := index;
end;

Function IndexDerivee(y,x : tgrandeur;Acalculer : boolean;Acreer : boolean) : TcodeGrandeur;
var Lexpression : string;
    posDiv : integer;

Procedure DefinitDerivee(index : integer);
begin with grandeurs[index] do begin
       AdUnite('-',y,x);
       fonct.expression := 'd('+y.nom+')/d('+x.nom+')';
       fonct.calcul := genFonctionGlb(derivee,nil,nil,nil,x,y);
end end;

Function ChercheDx(Lnom : string) : boolean;
var Lpos : integer;
begin
   Lpos := pos(Lnom,Lexpression);
   result := (Lpos>0) and (Lpos>PosDiv);
end;

Function ChercheDy(Lnom : string) : boolean;
var Lpos : integer;
begin
   Lpos := pos(Lnom,Lexpression);
   result := (Lpos>0) and (Lpos<PosDiv);
end;

var UU : tgrandeur;
    nomDerivee : string;
    i,page : integer;
    nomx1,nomx2,nomx3 : string;
    nomy1,nomy2,nomy3 : string;
    dx,dy : integer;
begin
    for i := 0 to pred(NbreGrandeurs) do with grandeurs[i].fonct do
        if (genreC=g_derivee) and (calcul<>nil) and
           (calcul^.varY=y) and (calcul^.varX=x)
            then begin result := i;exit end;
    nomx1:= x.nom+'[i+1]';
    nomx2:= x.nom+'[i]';
    nomx3:= x.nom+'[i-1]';
    nomy1:= y.nom+'[i+1]';
    nomy2:= y.nom+'[i]';
    nomy3:= y.nom+'[i-1]';
    for i := 0 to pred(NbreGrandeurs) do
        if (grandeurs[i].fonct.genreC=g_fonction) then begin
           Lexpression := grandeurs[i].fonct.expression;
           posDiv := pos('/',Lexpression);
           if posDiv>0 then begin
              dx := 0;dy :=0;
              if chercheDx(nomx1) then inc(dx);
              if chercheDx(nomx2) then inc(dx);
              if chercheDx(nomx3) then inc(dx);
              if chercheDy(nomy1) then inc(dy);
              if chercheDy(nomy2) then inc(dy);
              if chercheDy(nomy3) then inc(dy);
              if (dx=2) and (dy=2) then begin
                result := i;exit
              end;
           end;
        end;
    nomDerivee := y.nom+'''';
    result := indexNomVariab(nomDerivee);
    if result=GrandeurInconnue
       then if Acreer
         then begin // Création de y'
           UU := tgrandeur.Create;
           UU.init(nomDerivee,'','',variable);
           UU.fonct.genreC := g_derivee;
           result := ajouteGrandeurE(UU);
           if result=GrandeurInconnue then exit;
           DefinitDerivee(result);
           for page := 1 to NbrePages do
              if Acalculer
                 then pages[page].CalcColonneP(result,false)
                 else pages[page].modifiedP := true;
          pages[pageCourante].affecteVariableP(false);
         end
         else
        else with grandeurs[result] do
           if (genreG=variable) and (fonct.genreC=g_forward) then begin
               fonct.genreC := g_derivee;
               DefinitDerivee(result);
           end;
end;

Function IndexVitesse(const position : string) : TcodeGrandeur;
var i : integer;
begin
    for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
        if (genreMecanique=gm_vitesse) and
           (nomvarPosition=position)
            then begin result := i;exit end;
    result := IndexDerivee(grandeurs[indexNom(position)],grandeurs[0],false,false);
end;

Function IndexAcceleration(const position : string) : TcodeGrandeur;
var i : integer;
begin
    for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
        if (genreMecanique=gm_acceleration) and
           (nomvarPosition=position)
            then begin result := i;exit end;
    result := IndexDerivee(grandeurs[indexNom(position)],grandeurs[0],false,false);
    if result<>GrandeurInconnue then
       result := IndexDerivee(grandeurs[result],grandeurs[0],false,false);
end;

Function IndexGrandeurInitiale(f : Tgrandeur;
         var GI : Tgrandeur;ParamModele: boolean) : TcodeGrandeur;
var nomInitiale : string;
    i : integer;
begin
    result := GrandeurInconnue;
    for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
        if (genreMecanique=gm_initial) and
           (nomVarPosition=f.nom)
            then begin result := i;break end;
    nomInitiale := f.nom+'[0]';
    if result=GrandeurInconnue then
       result := indexNom(nomInitiale);
    if result=GrandeurInconnue then begin
       nomInitiale := f.nom+'0';
       result := indexNom(nomInitiale);
    end;
    if result=GrandeurInconnue
       then begin
          if ParamModele
             then begin // Création de y0 comme paramètre de modélisation
                inc(NbreParam[ParamNormal]);
                result := ParamToIndex(ParamNormal,NbreParam[ParamNormal]);
                grandeurs[result].nom := nomInitiale;
             end
             else result := AjouteExperimentale(nomInitiale,constante);
             // Création de y0 comme parametre experimental
          grandeurs[result].recopieUnite(f);
          grandeurs[result].uniteDonnee := false;
      end;
    GI := grandeurs[result];
end; //  IndexGrandeurInitiale

Procedure supprimeGrandeurE(index : TcodeGrandeur);
var i : integer;
    S : Tsauvegarde;
    p : TcodePage;
begin
    if index>maxGrandeurs then exit;
    S := nil;
    if (grandeurs[index].fonct.genreC=g_experimentale) and
       (grandeurs[index].genreG in [variable,constante]) then begin
       S := tsauvegarde.create;
       if grandeurs[index].genreG=variable then
          S.undo := UsupprVariab;
       if grandeurs[index].genreG=constante then
          S.undo := UsupprConst;
       S.GrandeurSauvee := grandeurs[index];
       PileSauvegarde.push(S);
    end;
    if (grandeurs[index].fonct.genreC=g_texte) and
       (grandeurs[index].genreG in [variable,constante]) then begin
       S := tsauvegarde.create;
       if grandeurs[index].genreG=variable then begin
          S.undo := UsupprVariabTexte;
          for p := 1 to NbrePages do S.sauveTexte[p] := TstringList.create;
       end;
       if grandeurs[index].genreG=constante then begin
          S.undo := UsupprConstTexte;
          S.sauveTexteUnique := TstringList.create;          
       end;
       S.GrandeurSauvee := grandeurs[index];
       PileSauvegarde.push(S);
    end;
    for i := 1 to NbrePages do
        pages[i].supprimeGrandeurP(index,S);
    if not(grandeurs[index].fonct.genreC in [g_experimentale,g_texte]) or
       not (grandeurs[index].genreG in [variable,constante])
          then Grandeurs[index].free;
    dec(NbreGrandeurs);
    for i := index to pred(NbreGrandeurs) do
        grandeurs[i] := grandeurs[succ(i)];
    ConstruireIndex;
end; // SupprimeGrandeurE

Function Tpage.getDeltaSimulation : double;
begin
      if ModeAcquisition<>acqSimulation then begin
         FdeltaSimulation := 1;
         result := 1;
         exit;
      end;
      if Nmes<8 then Nmes := 8;
      if Nmes>MaxMaxVecteur then Nmes := 4096;
      if logSimulation
         then begin
             try
             MiniSimulation := abs(MiniSimulation);
             MaxiSimulation := abs(MaxiSimulation);
             VerifMinMaxReal(MiniSimulation,MaxiSimulation);
             FdeltaSimulation := Power(10,log10(MaxiSimulation/MiniSimulation)/Nmes);
             if FdeltaSimulation=1 then begin
                 FdeltaSimulation := 1.01;
                 MaxiSimulation := MiniSimulation*power(FdeltaSimulation,Nmes);
             end;
             except
                 FdeltaSimulation := 1000/Nmes;
                 MiniSimulation := maxiSimulation/1000;
                 AfficheErreur(erRemplitLog,0);
             end;
         end
         else begin
            VerifMinMaxReal(MiniSimulation,MaxiSimulation);
            FdeltaSimulation := (MaxiSimulation-MiniSimulation)/Nmes;
            if FdeltaSimulation<1E-12 then begin
               FdeltaSimulation := 1;
               MaxiSimulation := MiniSimulation+Nmes*FdeltaSimulation;
            end;
         end;
      result := FdeltaSimulation;
end;

Procedure Tpage.CalculIncertG(i : TCodeGrandeur);

Procedure CalculIncertDerivee;
var NbrePointDer : integer;
    indexX,indexY : TcodeGrandeur;
begin with grandeurs[i].fonct.calcul^ do begin
   if operandDebut<>nil
      then begin
         NbrePointDer := round(calcule(operandDebut));
         if not odd(NbrePointDer) then inc(NbrePointDer);
         if (NbrePointDer>11) or (NbrePointDer<3)
             then NbrePointDer := NbrePointDerivee;
      end
      else NbrePointDer := NbrePointDerivee;
   indexX := varX.indexG;
   indexY := varY.indexG;
   try
   incertitudeDerivee(varX.valeur,varY.valeur,
                incertVar[indexX],incertVar[indexY],nmes,incertVar[i],
                NbrePointDer);
   except
   end;
end end;

Procedure CalculIncertConst;
begin with grandeurs[i] do begin
         try
         case fonct.genreC of
              g_experimentale : if (IncertCalcA.expression<>'') or (IncertCalcB.expression<>'')
                  then calculIncertitudeExp(incertConst[i]); // else entrée dans le tableau
              g_fonction : if IncertCalcA.calcul<>nil
                 then if fonct.calcul.typeElement=fonctionGlb
                      then incertConst[i] := calculeIncertGlb(fonct.calcul,IncertCalcA.calcul)
                      else incertConst[i] := calcule(IncertCalcA.calcul)
                 else incertConst[i] := Nan;
              else incertConst[i] := Nan;
         end;
         except
         incertConst[i] := Nan;
         end;
         incertCourante := incertConst[i];
end end;

var j : integer;
begin
    affecteConstParam(false); // ??
    with grandeurs[i] do
        case genreG of
           variable : case fonct.genreC of
              g_experimentale : begin
                  if (IncertCalcA.expression<>'') or (IncertCalcB.expression<>'')
                  then for j := 0 to pred(nmes) do begin
                     affecteVariableE(j);
                     valeurCourante := valeurVar[i,j];
                     try
                        calculIncertitudeExp(IncertVar[i,j]);
                     except
                        IncertVar[i,j] := Nan;
                     end;
                  end
              end;
              g_fonction : for j := 0 to pred(nmes) do begin
                 affecteVariableE(j);
                 CalculIncertitudeFonct(valIncert[j]);
              end;
              g_derivee : calculIncertDerivee;
              else for j := 0 to pred(nmes) do
                     IncertVar[i,j] := Nan
           end; // variable  genreC
           constante : calculIncertConst;
           constanteGlb : calculIncertConstGlb(i);
        end; // genreG
end; // calculIncertG


// GestVar.pas inclus dans compile.pas


