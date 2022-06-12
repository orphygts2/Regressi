// FileRRR.pas : récupération des fichiers autre que RW3
unit filerrr;

interface

uses windows, sysUtils, clipBrd, classes, forms, controls, strUtils,
     constreg, maths, regutil, uniteker, compile, math, dialogs,
     valeurs, graphker, graphvar, graphFFT, graphpar, graphEuler,
     system.ansiStrings, System.IOUtils, shlObj, DateUtils,
     // file_wfm, lx_lib,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     DeLaFitsCommon, DeLaFitsString, DeLaFitsGraphics,
     hdf5dll;

Function LitFichierDos(const NomFichier : String) : boolean;
Function LitFichierCPT(const NomFichier : String) : boolean;
Function LitFichierCCD(const NomFichier : String) : boolean;
Function LitFichierCSV(const NomFichier : String;NouveauFichier : boolean;isPasco : boolean) : boolean;
Function LitFichierCSVHorizontal(const NomFichier : String;NouveauFichier : boolean) : boolean;
Function LitFichierLogger(const NomFichier : String) : boolean;
Function AjouteFichierCPT(const NomFichier : String) : boolean;
Function AjouteFichierCCD(const NomFichier : String) : boolean;
Function LitFichierVTT(const NomFichier : String) : boolean;
Function LitFichierFITS(const NomFichier : String) : boolean;
Function LitFichierH5(const NomFichier : String) : boolean;
Function AjouteFichierFITS(const NomFichier : String) : boolean;
Procedure EcritFichierXML(const NomFichier : String);
Function LitFichierXML(const NomFichier : String) : boolean;
Function LitFichierVotable(const NomFichier : String;const NouveauFichier : boolean) : boolean;

implementation

uses regmain, aidekey;

type
    TUniteVtt = class
       symbole,nomG : string;
       affecte : boolean;
       Npages : integer;
       index : integer;
       codeCourbe : integer;
       isAbscisse : boolean;
       AutreUnite : integer;
       constructor create;
       procedure Assign(Aunite : TuniteVTT);
    end;

    TinfoVtt = class
         cIndex,fPage,cUnite,cCourbe,fNombre,cXY,cUniteBis : integer;
         valeur : Tvecteur;
         cNomCoord,cNomCourbe,cNomUnite,cComment,cNomVecteur : string;
    end;
    EVtt = class(Exception);

function extraitNombre(var premiereLigne : string) : double;
var posV : integer;
begin
    posV := pos(',',premiereLigne);
    premiereLigne := copy(premiereLigne, posV+1, length(premiereLigne)-posV);
    posV := pos(',',premiereLigne);
    if posV>0 then premiereLigne := copy(premiereLigne, 1, posV-1);
    result := strToFloatWin(premiereLigne);
end;

Constructor TuniteVTT.create;
begin
      symbole := '';
      nomG := '';
      affecte := false;
      Npages := 1;
      index := 0;
      codeCourbe := 0;
      isAbscisse := true;
      AutreUnite := 0;
end;

Procedure TuniteVTT.assign(Aunite : TuniteVTT);
begin
      symbole := Aunite.symbole;
      nomG := Aunite.nomG;
      index := Aunite.index;
      isAbscisse := Aunite.isAbscisse;
end;

function litNombreVTT : double;
var chaine : string;
    carac : char;
begin
    chaine := '';
    repeat
       read(fichier,carac);
       if charInset(carac,['0'..'9','e','E','-','+','.',',']) then chaine := chaine+carac
    until (chaine<>'') and charInSet(carac,[' ',crTab,crCR,crLF]);
    result := strToFloatWin(chaine);
end;

procedure litLigneVTT;

const
CodeVTT : array[#128..#255] of char =
   (' ','ü','é','â','ä','à',' ','ç','ê','ë','è','ï','î',' ',' ',' ',
    ' ',' ',' ','ô','ö',' ','û','ù',' ',' ',' ',' ',' ',' ',' ',' ',
    ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
    '°',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
    ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
    ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',
    ' ','à','a','a','a','a','a','ç','è','é','ê','ë','i','i','i','i',
    ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ');

var ligneShort : shortString;
    longueur,i : integer;
    carac : ansiChar;
    caracU : char;
begin
   try
   finFichierWin := finFichierWin or eof(fichier);
   ligneWin := '';
   if not finFichierWin then begin
      readln(fichier,ligneShort);
      longueur := length(ligneShort);
      lignewin := '';
      for i := 1 to longueur do begin
         carac := ligneShort[i];
         case carac of
              #0..#30 : ;
              #31..#127 : ligneWin := ligneWin+char(carac);
              else begin
                 caracU := codeVTT[carac];
                 if caracU<>' ' then ligneWin := ligneWin+caracU;
              end;
         end;
      end;
   end;
   except
       FinFichierWin := true;
   end;
end;

Procedure VerifNomVTT(var Anom : string);

Function TrimNomGrandeur(const s : string) : string;
var longueur,i : integer;
begin
      result := '';
      longueur := Length(s);
      if (longueur>0) and
          charInSet(s[1],['a'..'z','A'..'Z'])
             then result := s[1];
      for i := 2 to longueur do
          if charInSet(s[i],['a'..'z','A'..'Z','0'..'9'])
             then result := result+s[i]
end;

begin
      Anom := trimNomGrandeur(Anom);
      Anom := copy(Anom,1,longNom);
      if not nomCorrect(Anom,grandeurInconnue) then Anom := '';
end;

Procedure Sans_accents(var tampon : string);
var
   i : Integer;
   carac : char;
begin
For i := 1 To Length(tampon) do begin
    carac := ligneWin[i];
    If charInSet(carac,['â','ä','à'])
       then tampon[i] := 'a'
       else If charInSet(carac,['ï','î'])
          then tampon[i] := 'i'
          else If charInSet(carac,['ô','ö'])
             then tampon[i] := 'o'
             else If charInSet(carac,['û','ù','ü'])
                 then tampon[i] := 'u'
                 else if charInSet(carac,['é','è','é','ê','ë'])
                    then tampon[i] := 'e'
                    else if carac='ç' then tampon[i] := 'c';
end;
End;

function extraitChaineVTT(NonAccentue,NomReg : boolean) : string;
var posG,longueur : integer;
begin
    posG := pos('"',ligneWin);
    longueur := length(ligneWin);
    result := copy(ligneWin,posG+1,longueur);
    posG := pos('"',result);
    if posG>0 then result := copy(result,1,posG-1);
    if NonAccentue then Sans_accents(result);
    if NomReg then verifNomVTT(result);
end;

function extraitDeuxPointsVTT(NonAccentue,NomReg : boolean) : string;
var posG,longueur : integer;
begin
    posG := pos(':',ligneWin);
    longueur := length(ligneWin);
    result := copy(ligneWin,posG+1,longueur);
    if NonAccentue then Sans_accents(result);
    if NomReg then verifNomVTT(result);
end;

function extraitNombreVTT : double;
var posEgal,longueur,fin : integer;
    chaine : string;
begin
    posEgal := pos('=',ligneWin);
    longueur := length(ligneWin);
    repeat
      inc(posEgal)
    until (posEgal>=longueur) or charInSet(ligneWin[posEgal],chiffre);
    fin := posEgal;
    while (fin<=longueur) and
          charInSet(ligneWin[fin],chiffreWin) do
             inc(fin);
    chaine := copy(ligneWin,posEgal,fin-posEgal);
    try
    result := strToFloatWin(chaine)
    except
       result := Nan
    end
end;

function LitFichierFITS(const NomFichier : String) : boolean;
var FFit: TFitsFileBitmap;
    lambda,intensite : Tspectre;
    i,imax : integer;
    coeff : double;
begin
   result := false;
   try
   ModeAcquisition := AcqFichier;
   FFit := TFitsFileBitmap.CreateJoin(NomFichier, cFileRead);
   if FFIT.HduCore.isSpectre then begin
      FFit.SpectreRead(lambda,intensite);
      imax := length(intensite);
      AjouteExperimentale('λ',variable);
      grandeurs[0].fonct.expression := 'Longueur d''onde';
      grandeurs[0].nomUnite := FFit.HduCore.uniteX;
      coeff := 1;
      if (pos('ANG', grandeurs[0].nomUnite)>0) or
         (pos('Ang', grandeurs[0].nomUnite)>0) or
         (grandeurs[0].nomUnite='') then begin
         grandeurs[0].nomUnite := 'nm';
         coeff := 0.1;
      end;
      if ('um'=grandeurs[0].nomUnite) then begin
         grandeurs[0].nomUnite := 'nm';
         coeff := 1000;
      end;
      AjouteExperimentale('I',variable);
      grandeurs[1].fonct.expression := 'Intensite';
      grandeurs[1].nomUnite := FFit.HduCore.uniteY;
      result := ajoutePage;
      if not result then exit;
      pages[pageCourante].nmes := imax;
      for i := 0 to imax do begin
         pages[pageCourante].ValeurVar[0,i] := lambda[i]*coeff;
         pages[pageCourante].ValeurVar[1,i] := intensite[i];
      end;
      result := true;
   end
   else showMessage('N''est pas un fichier de spectre');
   FFit.Free;
   except
      result := false;
      strErreurFichier := erFileLoad;
   end;
end;

function LitFichierVtt(const NomFichier : String) : boolean;
const codeAbscisse = 1;
      codeOrdonnee = 2; // pour CXY
      maxVTT = 512;
var
    TableauOid : array[1..maxVtt] of TinfoVtt;
    uniteVTT : array[1..maxVtt] of TuniteVTT;
    listeCalcul : TstringList;

Function VerifOid(code : integer) : boolean;
begin
    result := (code>0) and
              (code<=maxVtt) and
              (tableauOid[code]<>nil)
end;

Function VerifUnite(code : integer) : boolean;
begin
    result := (code>0) and
              (code<=maxVtt) and
              (uniteVtt[code]<>nil)
end;

Procedure litListeConfig;

procedure litVecteur;
{ [vecteur]
  oid = 8
  nom = "Y1"
  unité = 2
  points = table xxx
  validité = table yyy
}

var oidCourant,j : integer;
    tableau : TinfoVTT;
begin
   oidCourant := -1;
   Tableau := TinfoVtt.create;
   try
   repeat
      litLigneVTT;
      if pos('=',ligneWin)>0 then begin
          if pos('oid',ligneWin)<>0
             then OidCourant := round(extraitNombreVTT);
          if pos('unité',ligneWin)<>0 then begin
               Tableau.cUnite := round(extraitNombreVTT);
               if verifUnite(Tableau.cUnite) then
                  Tableau.cNomUnite := uniteVTT[Tableau.cUnite].nomG;
          end;
          if pos('nom',ligneWin)<>0
              then begin
                  Tableau.cNomVecteur := extraitChaineVTT(true,true);
              end;
          if pos('points',ligneWin)<>0 then begin
                Tableau.fNombre := round(extraitNombreVTT);
                setLength(Tableau.valeur,Tableau.fNombre);
                for j := 0 to pred(Tableau.fNombre) do
                    Tableau.valeur[j] := litNombreVTT;
          end;
      end;
   until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
   Tableau.fPage := 1;
   if (Tableau.fNombre=0) or
      (OidCourant>MaxVtt) or
      (OidCourant<1)
      then raise EVtt.create('')
      else TableauOid[OidCourant] := tableau;
   except
      tableau.free
   end;
end;// litVecteur

procedure litCourbe;
var codex,codey,oidCourbe : integer;
    nom,nomx,nomy,comment : string;
{
[courbe]
oid = 25
nom = "acq_1"
commentaire = ""
vx = 8
vy = 10
abscisse = "y"
ordonnée = "G"
formule = "" sinon calculée
}

begin
     codex := -1;
     codey := -1;
     nomx := '';
     nomy := '';
     oidCourbe := -1;
     repeat
         litLigneVTT;
         if Pos('oid',ligneWin)>0 then begin
            oidCourbe := round(extraitNombreVTT);
            continue;
         end;
         if Pos('vx',ligneWin)>0 then begin
            codex := round(extraitNombreVTT);
            if verifOid(codex) then begin
               tableauOid[codex].cCourbe := oidCourbe;
               tableauOid[codex].cXY := 1;
               if nomx<>'' then tableauOid[codex].cNomCoord := nomx;
            end;
            continue;
         end;
         if Pos('vy',ligneWin)>0 then begin
            codey := round(extraitNombreVTT);
            if verifOid(codey) then begin
               tableauOid[codey].cCourbe := oidCourbe;
               tableauOid[codey].cXY := 2;
               if nomy<>'' then tableauOid[codey].cNomCoord := nomy;
            end;
            continue;
         end;
         if (Pos('abscisse',ligneWin)>0) and
            (Pos('Fonction',ligneWin)=0) then begin
            nomx := extraitDeuxPointsVTT(true,true);
            if verifOid(codex) then tableauOid[codex].cNomCoord := nomx;
            continue;
         end;
         if ((Pos('ordonnée',ligneWin)>0) or
             (Pos('Ordonnée',ligneWin)>0) or
             (Pos('ordonn‚e',ligneWin)>0)) and
            (Pos('Fonction',ligneWin)=0) then begin
            nomy := extraitDeuxPointsVTT(true,true);
            if verifOid(codey) then begin
               tableauOid[codey].cNomCoord := nomy;
               tableauOid[codey].cComment := comment;
               tableauOid[codey].cNomCourbe := nom;
            end;
            continue;
         end;
         if Pos('nom',ligneWin)>0 then begin
            nom := extraitChaineVTT(true,true);
            if verifOid(codey) then tableauOid[codey].cNomCourbe := nom;
            continue;
         end;
         if Pos('commentaire',ligneWin)>0 then begin
            comment := extraitChaineVTT(false,false);
            continue;
         end;
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
     if verifOid(codex) and verifOid(codey) then begin
        tableauOid[codey].cUniteBis := tableauOid[codex].cUnite;
        tableauOid[codex].cUniteBis := tableauOid[codey].cUnite;
     end;
end;

procedure litCourbeCalc;
begin
     repeat litLigneVTT
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
end;

procedure litCalculs;
var pospv : integer;
begin
     listeCalcul := TstringList.Create;
     repeat
        litLigneVTT;
        pospv := pos(';',ligneWin);
        if (pospv>0) and
           (pos('Acquisition',LigneWin)=0) and
           (pos('Mod_fonct',LigneWin)=0) and
           (pos('Creat',LigneWin)=0) and
           (pos('equation',LigneWin)=0) and
           (pos('"',LigneWin)=0) and
           (pos(stTangente,LigneWin)=0)
            then begin
                 LigneWin[pospv] := '=';
                 pospv := pos(';',ligneWin);
                 if pospv>0 then ligneWin[pospv] := '_';
                 listeCalcul.add(ligneWin);
                 pospv := pos(';',ligneWin);
                 if pospv>0 then delete(ligneWin,pospv,1);
            end;
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
end;

procedure litUnite;
{
[unité]
oid = 2
symbole = "cm3"
grandeur = ""
variable = ""
ech_min = 0
ech_max = 1
}
var nomLoc : string;
    oidCourant : integer;
    uniteLoc : TuniteVtt;
begin
     OidCourant := -1;
     UniteLoc := TuniteVTT.create;
     try
     repeat
         litLigneVTT;
         if Pos('oid',ligneWin)>0
            then oidCourant := round(extraitNombreVTT)
            else if Pos('symbole',ligneWin)>0
              then UniteLoc.symbole := extraitChaineVTT(true,false)
              else if Pos('grandeur',ligneWin)>0
                  then begin
                     nomLoc := extraitChaineVTT(true,true);
                     if nomLoc=''
                        then begin
                           if UniteLoc.symbole='s'
                              then UniteLoc.nomG := 't';
                        end
                        else uniteLoc.nomG := nomLoc
                  end
                  else
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
     if (OidCourant>MaxVtt) or (OidCourant<1)
        then raise EVtt.create('')
        else uniteVtt[OidCourant] := uniteLoc;
     except
        uniteLoc.free
     end;
end;

procedure litModele;
var modele : string;
begin
     repeat
         litLigneVTT;
         if Pos('description',ligneWin)>0 then begin
             modele := extraitChaineVTT(true,false);
             if modele<>'' then Fvaleurs.memo.lines.add(''''+modele);
             if posEx('"',ligneWin,pos('"',ligneWin))=0 then
                repeat
                    litLigneVTT;
                    modele := extraitChaineVTT(true,false);
                    if modele<>'' then Fvaleurs.memo.lines.add(''''+modele);
                until finFichierWin or
                      (pos('"',ligneWin)>0) or
                     ((Length(LigneWin)>0) and (ligneWin[1]='['))
         end;
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['))
end;

procedure litAnnotation;
var modele : string;
begin
     repeat
         litLigneVTT;
         if Pos('texte',ligneWin)>0 then begin
             modele := extraitChaineVTT(true,false);
             if modele<>'' then Fvaleurs.memo.lines.add(''''+modele);
         end;
     until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['))
end;

begin // litListeConfig
    if Pos('[vecteur]',ligneWin)>0
       then litVecteur
       else if Pos('[courbe]',ligneWin)>0
         then litCourbe
         else if Pos('[unité]',ligneWin)>0
            then litUnite
            else if Pos('[modèle]',ligneWin)>0
             then litModele
             else if Pos('[courbecalc]',ligneWin)>0
                  then litCourbeCalc
                  else if Pos('[Calcul]',ligneWin)>0
                     then litCalculs
                     else if Pos('[Annotation]',ligneWin)>0
                       then litAnnotation
                       else litLigneVTT
end; // litListeConfig

procedure litValeurVecteur;
var index,oid,j : integer;
    p : integer;
begin
   oid := -1;
   repeat
      litLigneVTT;
      if pos('=',ligneWin)>0 then begin
          if pos('oid',ligneWin)<>0
               then oid := round(extraitNombreVTT);
          if (pos('points',ligneWin)<>0) and verifOid(oid) then begin
               p := tableauOid[oid].fPage;
               index := tableauOid[oid].cIndex;
               if (index>=0) and (index<NbreGrandeurs) and
                  (p>0) and (p<=NbrePages) then
                  with pages[p] do begin
                    nmes := round(extraitNombreVTT);
                    try
                    for j := 0 to pred(nmes) do
                        valeurVar[index,j] := litNombreVTT;
                    except
                    end;
                end;
          end;
      end;
   until finFichierWin or
         ((Length(LigneWin)>0) and (ligneWin[1]='['));
end; // litValeurVecteur

Procedure Organise;
var i,j : integer;
    codeCourbe : integer;
    unite : TuniteVTT;
    nom : string;
    Npages : integer;

Function MemePage : boolean;
var codeC : integer;
    j : integer;
    codeXY : integer;
    codeU : array[1..2,1..2] of integer;
    nomY : array[1..2] of string;
//  1 courbe en cours, 2 autre courbe
begin
     for j := 1 to maxVtt do if tableauOid[j]<>nil then with TableauOid[j] do begin
         codeC := cCourbe;
         codeXY := cXY; // soit abscisse soit ordonnée
         if codeC=unite.codeCourbe then
            codeU[1,codeXY] := cUnite;
         if codeC=codeCourbe then
            codeU[2,codeXY] := cUnite;
         if codeXY=2 then begin
            if codeC=unite.codeCourbe then nomY[1] := cnomVecteur;
            if codeC=codeCourbe then nomY[2] := cnomVecteur;
         end;
     end;
     result := (codeU[1,codeAbscisse]=codeU[2,codeAbscisse]) and
               ((codeU[1,codeOrdonnee]<>codeU[2,codeOrdonnee]) or
                 (((nomY[1]=unite.nomG) or unite.isAbscisse) and
                  (nomY[1]<>nomY[2])));
// deux courbes distinctes de même abscisse
     if result and (codeU[1,codeOrdonnee]=codeU[2,codeOrdonnee]) then
        unite.nomG := nomY[2];
end;

Procedure AffecteUnite;
begin
       nom := unite.nomG;
       if nom='' then nom := tableauOid[i].cNomCourbe;
       if nom='' then nom := tableauOid[i].cNomVecteur;
       if nom='' then nom := tableauOid[i].cNomUnite;
       if nom='' then nom := tableauOid[i].cNomCoord;
       if nom='' then nom := 'x'+intToStr(i);
       nom := copy(nom,1,longNom);
       if not nomCorrect(nom,grandeurInconnue)
          then nom := nom+intToStr(i);
       unite.nomG := nom;
       TableauOid[i].cIndex := AjouteExperimentale(nom,variable);
       grandeurs[TableauOid[i].cIndex].NomUnite := unite.symbole;
       unite.affecte := true;
       unite.codeCourbe := codeCourbe;
       unite.Npages := 1;
       unite.IsAbscisse := TableauOid[i].cXY=codeAbscisse;
       unite.AutreUnite := TableauOid[i].cUniteBis;
       if Npages<1 then Npages := 1;
       unite.index := TableauOid[i].cIndex;
       TableauOid[i].fPage := 1;
{
       if TableauOid[i].CXY=codeAbscisse
          then begin
              FgrapheVariab.graphes[1].Coordonnee[coordEnCours].nomX := nom;
              if coordEnCours=1 then FgrapheVariab.graphes[1].Coordonnee[2].nomX := nom;
          end
          else FgrapheVariab.graphes[1].Coordonnee[coordEnCours].nomY := nom;
}
end;

Procedure MajUnite(OldCodeUnite,NewCodeUnite,codeXY,CodeAutre : integer);
var i : integer;
    codeUnite,codeXYloc,codeAutreloc : integer;
begin
     for i := 1 to maxVtt do if TableauOid[i]<>nil then with TableauOid[i] do begin
         codeUnite := cUnite;
         codeXYloc := cXY;
         codeAutreloc := cUniteBis;
         if (codeUnite=oldCodeUnite) and
            (codeXYloc=codeXY) and
            (codeAutreloc=codeAutre)
            then cUnite := NewCodeUnite;
     end;
end;

var NewCode,n,k : integer;
    MinPoints,MaxPoints : integer;
    existe : boolean;
begin // Organise
    Npages := 0;
    MaxPoints := 0;
    MinPoints := 16384;
    for i := 1 to maxVtt do if TableauOid[i]<>nil then with TableauOid[i] do begin
        codeCourbe := cCourbe;
        if (codeCourbe>0) then begin
           N := cNombre;
           if (N<MinPoints) and (N>16) then MinPoints := N;
           if N>MaxPoints then MaxPoints := N;
        end;
    end;
    if (MaxPoints div MinPoints) > 1 then dec(MaxPoints);
// MaxPoints correspond à une modélisation
    for i := 1 to maxVtt do if TableauOid[i]<>nil then with TableauOid[i] do begin
        codeCourbe := cCourbe;
        if (codeCourbe=-1) or (codeCourbe=0) or
           (cNombre>MaxPoints) or
           (cNombre<MinPoints)
           then cIndex := -1
           else begin
                if not verifUnite(cUnite) then UniteVTT[cUnite] := TuniteVTT.create;
                unite := uniteVTT[cUnite];
                if (not unite.affecte) or
                   (unite.Affecte and (unite.codeCourbe=codeCourbe))
// Même courbe donc dans la même page (XY de même unité)
                   then begin
                      affecteUnite;
                   end
                   else if MemePage
                   then begin // deux courbes distinctes de même abscisse
                      existe := false;
                 // j même données que i ?
                      for j := 1 to maxVtt do if
                              (j<>i) and
                              (TableauOid[j]<>nil) and
                              (TableauOid[j].cUnite=TableauOid[i].cUnite) and
                              (TableauOid[j].fNombre=TableauOid[i].fNombre) and
                              (TableauOid[j].cNomVecteur=TableauOid[i].cNomVecteur)
                              then begin
                                   existe := true;
                                   for k := 0 to 15 do
                                       if TableauOid[j].valeur[k]<>TableauOid[j].valeur[k] then begin
                                          existe := false;
                                          break;
                                       end;
                      end;
                      if existe
                         then cIndex := -1
                         else begin
                             newCode := 1;
                             while (newCode<maxVtt) and (UniteVTT[newCode]<>nil) do inc(newCode);
                             UniteVTT[newCode] := TuniteVTT.create;
                             UniteVTT[newCode].assign(unite);
                             MajUnite(cUnite,newCode,cXY,cUniteBis);
                             unite := UniteVTT[newCode];
                             unite.AutreUnite := cUniteBis;
//                             CoordEnCours := 2;
                             AffecteUnite;
                        end;
                   end
                   else begin
                       inc(unite.Npages);
                       unite.codeCourbe := codeCourbe;
                       if Npages<unite.Npages then Npages := unite.Npages;
                       fPage := unite.Npages;
                       cIndex := unite.index;
                   end;
           end;
    end;
    for i := 1 to NPages do begin
        if not ajoutePage then break;
        for j := 1 to maxVtt do
        if TableauOid[j]<>nil then with TableauOid[j] do
        if fPage=i then
            pages[i].commentaireP := pages[i].commentaireP+
               ' '+cNomCourbe+
               ' '+cNomCoord+
               ' '+cComment;
        pages[pageCourante].nmes := 1;
    end;
end; // Organise

var i,j : integer;
    p : TcodePage;
    indiceOK : boolean;
begin // LitFichierVTT
     result := false;
     strErreurFichier := erFileData;
     ModeAcquisition := AcqFichier;
     FileMode := fmOpenRead;
     AssignFile(fichier,NomFichierData);
     Reset(fichier);
     finFichierWin := false;
     listeCalcul := nil;
     for i := 1 to maxVTT do begin
         UniteVtt[i] := nil;
         TableauOid[i] := nil
     end;
     try
     litLigneVTT;
     repeat
        if (Length(LigneWin)>0) and (ligneWin[1]='[')
           then litListeConfig
           else litLigneVTT
     until finFichierWin;
     Organise;
     Reset(fichier);
     finFichierWin := false;
     litLigneVTT;
     repeat
        if Pos('[vecteur]',ligneWin)>0
           then litValeurVecteur
           else litLigneVTT
     until finFichierWin;
     if (NbreGrandeurs>0) and (NbrePages>0) then begin
        LitFichierVTT := true;
        for p := 1 to NbrePages do with pages[p] do begin
            for j := pred(nmes) downto 0 do begin
                indiceOK := false;
                for i := 0 to pred(NbreGrandeurs) do
                    indiceOK := indiceOK or (valeurVar[i,j]<>0);
                if indiceOK then break else nmes := j;
            end;
        end;
        construireIndex;
        for i := 1 to pred(NbreGrandeurs) do
            if grandeurs[i].nom='t' then begin
               transfereVariabE(i,0);
               break
            end;
        pages[pageCourante].affecteVariableP(false);
     end;
     except
         result := false;
         strErreurFichier := erReadFile;
     end;
     for i := 1 to maxVTT do begin
         if TableauOid[i]<>nil then begin
            TableauOid[i].valeur := nil;
            TableauOid[i].Free;
         end;
         if UniteVtt[i]<>nil then UniteVtt[i].Free;
     end;
     CloseFile(fichier);
     if listeCalcul<>nil then begin
        for i := 0 to pred(listeCalcul.count) do
            Fvaleurs.memo.lines.add(''''+listeCalcul[i]);
        listecalcul.Free;
     end;
     FileMode := fmOpenReadWrite;
end; // LitFichierVTT

Function TrimNomGrandeur(const s : String) : string;
var longueur,i : integer;
begin
      result := '';
      longueur := Length(s);
      for i := 1 to longueur do
          if charinset(s[i],['a'..'z','A'..'Z','0'..'9'])
             then result := result+s[i]
             else if pos(s[i],LettreAccent)>0
                  then case s[i] of
                      'é','è','ê','ë' : result := result+'e';
                      'ï','î' : result := result+'i';
                      'à','â' : result := result+'a';
                      'ù','û','ü' : result := result+'u';
                      'ô','ö' : result := result+'o';
                  end;
end;

// On entre dans les procédures d'extraction avec la première ligne déjà lue
// et on en sort donc avec la ligne suivante déjà lue

var
   FichierCPT : file of word;

Function LitPageCPT : boolean;
var zut,i,imin : word;
begin
     try
     result := ajoutePage;
     if not result then exit;
     read(fichierCPT,zut);
     pages[pageCourante].ValeurConst[2] := zut;
     read(fichierCPT,zut);
     pages[pageCourante].ValeurConst[3] := zut;
     read(fichierCPT,zut); { nombre total de coups }
     read(fichierCPT,zut); { nombre de données }
     read(fichierCPT,zut); { maxi }
     read(fichierCPT,imin); { Nombre ce coups mini pendant dt = début des données}
     ModeAcquisition := AcqFichier;
     i := 0;
     repeat
           read(fichierCPT,zut);
           pages[pageCourante].ValeurVar[0,i] := imin+i;
           pages[pageCourante].ValeurVar[1,i] := zut;
           inc(i);
     until eof(fichierCPT);
     pages[pageCourante].nmes := i;
     except
        result := false;
     end;
end; // LitPageCPT

Function AjouteFichierCPT(const NomFichier : String) : boolean;
begin
     try
     strErreurFichier := erFileLoad;
     FileMode := fmOpenRead; // protection contre lecture seule
     Assign(fichierCPT,NomFichier);
     Reset(fichierCPT);
     result := litPageCPT;
     CloseFile(fichierCPT);
     except
        result := false;
     end;
     FileMode := fmOpenReadWrite;
end;

Function AjouteFichierFITS(const NomFichier : String) : boolean;
var FFit: TFitsFileBitmap;
    lambda,intensite : Tspectre;
    i,imax : integer;
    coeff : double;
begin
   result := false;
   try
   FFit := TFitsFileBitmap.CreateJoin(NomFichier, cFileRead);
   if FFIT.HduCore.isSpectre then begin
      FFit.SpectreRead(lambda,intensite);
      imax := length(intensite);
      coeff := 1;
      if (pos('ANG', FFit.HduCore.uniteX)>0) or
         (pos('Ang',  FFit.HduCore.uniteX)>0) or
         (grandeurs[0].nomUnite='') then begin
         coeff := 0.1;
      end;
      if ('um'=FFit.HduCore.uniteX) then begin
         coeff := 1000;
      end;
      result := ajoutePage;
      if not result then exit;
      pages[pageCourante].nmes := imax;
      for i := 0 to imax do begin
         pages[pageCourante].ValeurVar[0,i] := lambda[i]*coeff;
         pages[pageCourante].ValeurVar[1,i] := intensite[i];
      end;
      result := true;
   end
   else showMessage('N''est pas un fichier de spectre');
   FFit.Free;
   except
      strErreurFichier := erFileLoad;
   end;
end;

Function litFichierCPT(const NomFichier : String) : boolean;
begin
     try
     strErreurFichier := erFileLoad;
     FileMode := fmOpenRead;
     Assign(fichierCPT,NomFichier);
     Reset(fichierCPT);
     AjouteExperimentale('N',variable);
     grandeurs[0].fonct.expression := 'Nombre de désintégrations pendant dt';
     AjouteExperimentale('F',variable);
     grandeurs[1].fonct.expression := 'Fréquence (nombre de fois où l''on trouve le nombre N)';
     AjouteExperimentale('d',constante);
     grandeurs[2].fonct.expression := 'Distance entre la source radioactive et le détecteur';
     grandeurs[2].nomUnite := 'mm';
     AjouteExperimentale('dt',constante);
     grandeurs[2].fonct.expression := 'Durée du comptage';
     grandeurs[3].nomUnite := 's';
     result := litPageCPT;
     ModeAcquisition := AcqFichier;
     CloseFile(fichierCPT);
     except
        result := false;
     end;
     FileMode := fmOpenReadWrite;
end; // LitFichierCPT

function LitFichierCSVHorizontal(const NomFichier : String;NouveauFichier : boolean) : boolean;
var
    ligneList : TStringList;
    NbreCSV : integer;
    fichierCSV : textFile;
    finFichierCSV : boolean;
    uniteTrouvee : boolean;
    separateurCSV : Char; // pour distinguer 1.2,1.3 de 1,2;1,3

procedure litLigneCSV;
var aligne : string;
begin
   try
   NbreCSV := 0;
   FinFichierCSV := FinFichierCSV or eof(fichierCsv);
   if finFichierCSV then exit;
   readln(fichiercsv,aLigne);
   ligneList.DelimitedText := aLigne;
   NbreCSV := ligneList.count;
   if NbreCSV>maxGrandeurs then nbreCSV := maxGrandeurs;
   if LigneList[pred(NbreCSV)]='' then dec(NbreCSV);
   except
        FinFichierCSV := true;
        NbreCSV := 0;
   end;
end;

procedure LitValeurVecteurCSV(index : integer);
var i : integer;
    strValeur : string;
    Lvaleur : double;
begin with pages[pageCourante] do begin
      if nmes<NbreCSV then nmes := NbreCSV;
      for i := 1 to pred(NbreCSV) do begin
          strValeur := ligneList[i];
          if strValeur=''
             then Lvaleur := NAN
             else Lvaleur := strToFloatWin(strValeur);
          valeurVar[index,i-1] := Lvaleur;
      end;
end end; // litValeurVecteurCSV

Function VerifUnite : string;
var posO,posF : integer;
begin
   result := '';
   posO := pos('(',ligneList[0]);
   posF := pos(')',ligneList[0]);
   if (posO>1) and (posF>posO) then begin
      result := copy(ligneList[0],posO+1,posF-posO-1);
      ligneList[0] := copy(ligneList[0],1,posO-1);
      UniteTrouvee := true;
   end;
end;//verifUnite

procedure litUneLigne;
var index : integer;
    Lsignif : string;
    Lnom,unite : string;
begin
     litLigneCSV;
     if finFichierCSV then exit;
     Lsignif := LigneList[0];
     Unite := VerifUnite;
     LNom := Copy(trimNomGrandeur(LigneList[0]),1,longNom);
     if Lnom='' then Lnom := 'V';
     if indexNom(Lnom)<>grandeurInconnue then Lnom := Lnom+intToStr(NbreVariab);
     if (indexNom(Lnom)=grandeurInconnue) and
        (charInSet(Lnom[1],['0'..'9'])) then Lnom := 'V'+Lnom;
     index := AjouteExperimentale(Lnom,variable);
     grandeurs[index].NomUnite := unite;
     grandeurs[index].fonct.expression := Lsignif;
     litValeurVecteurCSV(index);
end; // litUneLigne

var premiereLigne : string;
    commentaire : string;
    NEnTete,i : integer;
begin // LitFichierCSVHorizontal
     result := false;
     strErreurFichier := erFileData;
     ModeAcquisition := AcqFichier;
     FileMode := fmOpenRead;
     ligneList := TStringList.Create;
     ligneList.strictDelimiter := true;
     separateurCSV := ',';
     ligneList.QuoteChar := #0;
     AssignFile(fichierCSV,NomFichier);
     Reset(fichierCSV);
     readln(fichierCSV,premiereLigne);
     NEnTete := 0;
     while (pos(';',premiereLigne)<=0) and
           (pos(',',premiereLigne)<=0) and
           not eof(fichierCSV) do begin
             inc(NEnTete);
             readln(fichierCSV,premiereLigne);
     end;
     if pos(';',premiereLigne)>0
        then separateurCSV := ';'
        else if pos(',',premiereLigne)>0
           then separateurCSV := ','
           else if (pos(crTab,premiereLigne)>0)
              then separateurCSV := crTab;
     ligneList.delimiter := separateurCSV;
     Reset(fichierCSV);
     finFichierCSV := false;
     NbreCSV := 0;
     if NEnTete>0
        then readln(fichierCSV,commentaire)
        else commentaire := '';
     for i := 2 to NEnTete do readln(fichierCSV,premiereLigne);
     if not ajoutePage then exit;
     repeat
           litUneLigne;
     until finFichierCSV or eof(fichierCSV);
     LigneList.free;
     CloseFile(fichierCSV);
     FileMode := fmOpenReadWrite;
     if (NbreGrandeurs>0) and
        (pages[pageCourante].nmes>0)then begin
            LitFichierCSVHorizontal := true;
            construireIndex;
     end;
end; // LitFichierCSVHorizontal


function LitFichierCSV(const NomFichier : String;NouveauFichier : boolean;isPasco : boolean) : boolean;
var
    nom,unite : array[0..maxGrandeurs] of string;
    ligneList : TStringList;
    DecodeVariab : array[0..maxGrandeurs] of integer;
    NbreCSV : integer;
    fichierCSV : textFile;
    finFichierCSV : boolean;
    uniteTrouvee : boolean;
    isLigneDeChiffres : boolean;
    avecNoms : boolean;
    indexDate,indexTime,indexDateTime : integer;
    separateurCSV : Char; // pour distinguer 1.2,1.3 de 1,2;1,3
    caracNomPasco : TsysCharset;
    VariabAsuppr : TstringList;

procedure litLigneCSV;
const
    degreIMCCE = 'Â°';
    minuteIMCCE = 'â€²';
    secondeIMCCE = 'â€³';
var i,j : integer;
    aligne : string;
    aElement : string;
    posCarac : integer;
    isNombre : boolean;
    avecBlanc : boolean;
begin
   try
   NbreCSV := 0;
   isLigneDeChiffres := false;
   FinFichierCSV := FinFichierCSV or eof(fichierCsv);
   if finFichierCSV then exit;
   isLigneDeChiffres := true;
   readln(fichiercsv,aLigne);
   ligneList.DelimitedText := aLigne;
   NbreCSV := ligneList.count;
   if NbreCSV>maxGrandeurs then nbreCSV := maxGrandeurs;
   if nbreCSV=0 then begin
      FinFichierCSV := true;
      isLigneDeChiffres := false;
      exit;
   end;
 // exemple éphémérides
 //  '2019-12-13T17:48:28.899;209Â°34â€²57.394â€³;2Â°15â€²30.136â€³;0.429831623898;-0.6;7.9576437;-1.0179604;7.4803727'
   for i := 0 to pred(NbreCSV) do begin
       aElement := ligneList[i];
       posCarac := pos(degreIMCCE,aElement);
       if posCarac>0 then begin
          delete(aElement,posCarac,1);
       end;
       posCarac := pos(minuteIMCCE,aElement);
       if posCarac>0 then begin
          delete(aElement,posCarac,2);
          aElement[posCarac] := '''';
       end;
       posCarac := pos(secondeIMCCE,aElement);
       if posCarac>0 then begin
          delete(aElement,posCarac,2);
          aElement[posCarac] := '"';
          ligneList[i] := aElement;
       end;
       if isLigneDeChiffres then begin
           isNombre := true;
           avecBlanc := false;
           for j := 1 to length(aElement) do begin
               isNombre := isNombre and
                   charInSet(aElement[j],['0'..'9','+','-','E','.',',','e','/',':','T','°','''','"',' ']); // / et : pour date et Time
               avecBlanc := avecBlanc or (aElement[j]=' ');
           end;
           if avecBlanc and isNombre then ligneList[i] := trim(aElement);
           isNombre := isNombre or (aElement='NaN');
           isLigneDeChiffres := isNombre;
       end;
   end;
   if LigneList[pred(NbreCSV)]='' then dec(NbreCSV);
   isLigneDeChiffres := isLigneDeChiffres and (NbreCsv>0);
   except
        FinFichierCSV := true;
        NbreCSV := 0;
   end;
end;

procedure LitValeurVecteurDoubleVirgule;
var i,NbrePoints : integer;
    index : integer;
    strValeur : string;
begin
   while not(finFichierCSV) and isLigneDeChiffres do with pages[pageCourante] do begin
      NbrePoints := nmes;
      nmes := nmes+1;
      for i := 0 to pred(NbreVariabExp) do begin
          index := decodeVariab[i];
          strValeur := ligneList[2*i]+','+ligneList[2*i+1];
          valeurVar[index,NbrePoints] := strToFloatWin(strValeur);
      end;
      litLigneCSV;
   end;
end; // litValeurVecteurDoubleVirgule

procedure LitValeurVecteurCSV;
var i,j,k,NbrePoints : integer;
    posDate,posTime,posDegre : integer;
    index : integer;
    strValeur : string;
    Asuppr : boolean;

Procedure RecupereDateHeure;
var posT : integer;
begin
    posT := pos('T',strValeur);
    if posT>0 then strValeur[posT] := ' ';
    posT := pos('.',strValeur);
    if posT>0 then delete(strValeur,posT,length(strValeur)-posT+1);
 // on ôte les centième de seconde
    posT := pos('-',strValeur);
    if posT>0 then strValeur[posT] := '/';
    posT := pos('-',strValeur);
    if posT>0 then strValeur[posT] := '/';

    FormatSettings.ShortDateFormat := 'yyyy/mm/dd hh.nn.ss';
end;

var sauveFormatDate : string;
    Lvaleur : double;
begin
    sauveFormatDate := FormatSettings.ShortDateFormat;
   indexDate := grandeurInconnue;
   indexTime := grandeurInconnue;
   indexDateTime := grandeurInconnue;
   while not(finFichierCSV) and isLigneDeChiffres do with pages[pageCourante] do begin
      NbrePoints := nmes;
      nmes := nmes+1;
      for i := 0 to pred(NbreCSV) do begin
          index := decodeVariab[i];
          strValeur := ligneList[i];
          posTime := pos(':',strValeur);
          posDate := pos('/',strValeur);
          posDegre := pos('°',strValeur);
          if pos('T',strValeur)>0 then begin
             recupereDateHeure;
             posDate := pos('/',strValeur);
          end;
          if (strValeur='') or (strValeur='Nan')
          then Lvaleur := NAN
          else if (posTime>0) or (posDate>0)
            then begin
                try
                if posTime>0
                   then if posDate>0
                        then begin // date et heure
                            Lvaleur := StrToDateTime(strValeur);
                            indexDateTime := index;
                            Grandeurs[index].formatU := fDateTime;
                        end
                        else begin  // heure seule
                           Lvaleur := StrToTime(strValeur);
                           indexTime := index;
                           Grandeurs[index].formatU := fTime;
                        end
                   else begin // date seule
                        Lvaleur := StrToDate(strValeur);
                        indexDate := index;
                        Grandeurs[index].formatU := fDate;
                   end;
                 except
                   Lvaleur := Nan;
                 end;
             end
             else if posDegre>0
                then Lvaleur := StrSexaToDeci(strValeur)
                else Lvaleur := strToFloatWin(strValeur);
          valeurVar[index,NbrePoints] := Lvaleur;
      end;
      litLigneCSV;
   end;
   if (indexTime<>grandeurInconnue) and
      (indexDate<>grandeurInconnue) and
      (indexDateTime=grandeurInconnue) then begin
           Fvaleurs.Memo.lines.add('t='+grandeurs[indexDate].nom+'+'+grandeurs[indexTime].nom);
           Fvaleurs.Memo.lines.add('''t=date et heure');
   end;
   for I := 0 to VariabAsuppr.Count-1 do begin
       index := indexNom(VariabAsuppr[i]);
       SupprimeGrandeurE(index);
   end;
   k := NbreVariab-1;
   while k>=0 do begin
       index := indexVariab[k];
       Asuppr := true;
       for j := 0 to 3 do
          Asuppr := Asuppr and isNan( pages[pageCourante].valeurVar[index,j]);
       if Asuppr then SupprimeGrandeurE(index);
       dec(k);
   end;
   FormatSettings.ShortDateFormat := sauveFormatDate;
end; // litValeurVecteurCSV

Function VerifUnite(num : integer) : string;
var posO,posF,posA,i : integer;
    reponse : string;
begin
   result := '';
   posO := pos('en ',ligneList[num]);
   if (posO>1) then begin
      reponse := copy(ligneList[num],posO+3,4);
      ligneList[num] := copy(ligneList[num],1,posO-1);
      i:=1;
      while i<=length(reponse) do
          if charInSet(reponse[i],caracUnite)
             then inc(i)
             else delete(reponse,i,1);
      reponse := copy(reponse,1,posO-2); // on enlève blanc ou ( avant en
      UniteTrouvee := true;
      if reponse='Second' then reponse := 's';
      if reponse='Volt' then reponse := 'V';
      result := reponse;
      exit;
   end;
   posO := pos('(',ligneList[num]);
   posF := pos(')',ligneList[num]);
   if (posO>1) and (posF>posO) then begin
      reponse := copy(ligneList[num],posO+1,posF-posO-1);
      ligneList[num] := copy(ligneList[num],1,posO-1);
      UniteTrouvee := true;
      if reponse='Second' then reponse := 's';
      if reponse='degrees' then reponse := '°';
      if reponse='Volt' then reponse := 'V';
      if reponse='undefined' then reponse := '';
      if reponse='deg' then reponse := '°';
      if reponse='au' then reponse := 'ua';
      if reponse='au/d' then reponse := 'ua/j ';
      if reponse='n' then reponse := 'N';
      posA := pos('Â',reponse);
      if posA>0 then delete(reponse,posA,1);
      if (reponse='max') or (reponse='min') then begin
         UniteTrouvee := false;
         ligneList[num] := ligneList[num]+reponse;
         reponse := '';
      end;
      result := reponse;
   end;
end;

Function LigneDeNom : boolean;
var i : integer;
    NbreNom : integer;
begin
  NbreNom := 0;
  for i := 0 to pred(NbreCSV) do
      if ligneList[i]<>'' then inc(NbreNom);
  result := (NbreCsv>1) and (NbreNom>0);
  if (NbreNom<NbreCsv) then
  for i := 0 to pred(NbreCSV) do
      if ligneList[i]='' then
      case i of
           0 : ligneList[0] := 't';
           1 : ligneList[1] := 'V1';
           2 : ligneList[2] := 'V2';
           else ligneList[i] := 'Var'+IntToStr(i);
      end;
end;

procedure litNomUnite;
const maxU = 3;
      nomCSV : array[0..MaxU,boolean] of string =
           (('Volt²','V2'),
            ('Ampere²','A2'),
            ('Volt','V'),
            ('second','s'));
var i,j,index : integer;
    Lsignif : string;
begin
for i := 0 to maxGrandeurs do DecodeVariab[i] := i;
if avecNoms then begin
     repeat
         litLigneCSV;
     until FinFichierCSV or LigneDeNom;
     UniteTrouvee := false;
     for i := 0 to pred(NbreCSV) do begin
         Lsignif := LigneList[i];
         Unite[i] := VerifUnite(i);
         Nom[i] := Copy(trimNomGrandeur(LigneList[i]),1,longNom);
         if nom[i]<>'' then begin
            if nom[i]='xaxis' then nom[i] := 't';
          // Keysight x-axis,1,2 -> t,V1,V2
            if indexNom(nom[i])<>grandeurInconnue then nom[i] := nom[i]+intToStr(i);
            if indexNom(nom[i])=grandeurInconnue then begin
               if charInSet(nom[i][1],['0'..'9']) then nom[i] := 'V'+nom[i];
               index := AjouteExperimentale(nom[i],variable);
               grandeurs[index].NomUnite := unite[i];
               grandeurs[index].fonct.expression := Lsignif;
            end
         end;
     end;
     litLigneCSV;
     if not uniteTrouvee and not isLigneDeChiffres then begin
        for i := 0 to pred(NbreCSV) do begin
            Unite[i] := LigneList[i];
            for j := 0 to maxU do
                if Unite[i]=nomCSV[j,false] then begin
                   Unite[i] := nomCSV[j,true];
                   break;
                end;
            if pos('_Time',unite[i])>0 then if pos('1',unite[i])>0
                 then begin
                   unite[i] := 's';
                   index := indexNom(nom[i]);
                   if index<>grandeurInconnue then begin
                      grandeurs[index].nom := 't';
                      nom[i] := 't';
                   end;
                 end
                 else VariabAsuppr.Add(nom[i]);
            // chx_Time à supprimer pour x>1
            grandeurs[i].NomUnite := unite[i];
         end;
         litLigneCSV;
     end;
     if not isLigneDeChiffres then begin // commentaires
        for i := 0 to pred(NbreCSV) do
            grandeurs[i].fonct.expression := LigneList[i];
        litLigneCSV;
     end;
end
else begin
     litLigneCSV;
     AjouteExperimentale('t',variable);
     grandeurs[0].NomUnite := 's';
     for i := 2 to NbreCSV do begin
        AjouteExperimentale('V'+intToStr(i),variable);
        grandeurs[1].NomUnite := 'V';
     end;
end;
     if not ajoutePage then exit;
     if (','=separateurCSV) and (NbreCsv>NbreVariabExp)
        then litValeurVecteurDoubleVirgule
        else litValeurVecteurCSV;
     if (NbreGrandeurs>0) and
        (pages[pageCourante].nmes>0)then begin
            LitFichierCSV := true;
            construireIndex;
     end;
end; // litNomUnite

procedure verifNoms;
var i : integer;
    Lnom : string;
    nomConnu : set of byte;
    compteur : integer;
begin
for i := 0 to maxGrandeurs do DecodeVariab[i] := i;
nomConnu := [];
if avecNoms then begin
     litLigneCSV;
     if NbreCSV<>NbreVariabExp then exit;
     for i := 0 to pred(NbreCSV) do begin
         LNom := VerifUnite(i);
         LNom := trimNomGrandeur(LigneList[i]);
         DecodeVariab[i] := indexNom(Lnom);
         if DecodeVariab[i] in nomConnu then begin
            Lnom := Lnom+intToStr(i);
            DecodeVariab[i] := indexNom(Lnom);
         end;
         include(nomConnu,DecodeVariab[i]);
         if DecodeVariab[i]=grandeurInconnue then exit;
     end;
     compteur := 1;
     repeat
        litLigneCSV; // unités ; commentaires
        inc(compteur);
     until isLigneDeChiffres or (compteur>3);
end
else begin
     litLigneCSV;
end;
     if not ajoutePage then exit;
     if (','=separateurCSV) and (NbreCsv>NbrevariabExp)
        then litValeurVecteurDoubleVirgule
        else litValeurVecteurCSV;
     if pages[pageCourante].nmes>0
          then LitFichierCSV := true
end; // verifNoms

procedure litPasco;
Const
  maxConnu = 13;
  nomPasco : array[1..MaxConnu] of string =
  ('Velocite','Vitesseangulaire','Temps','Position','PhaseShift','Frequency',
   'Velocity','Angle','AngularVelocity','Force','AngularAcceleration','Time','Acceleration');
  signifPasco : array[1..MaxConnu] of string =
  ('vitesse','vitesse angulaire','temps','position','phase','fréquence',
   'vitesse','angle','vitesse angulaire','force','accélération angulaire','temps','accélération');
  nomSimplePasco : array[1..MaxConnu] of string =
  ('v',omegaMin,'t','d',phiMin,'f',
   'v',theta,omegaMin,'F',alpha,'t','a');

var
  pagePasco : array[0..maxGrandeurs] of TcodePage;
  NomVariabPagePasco : array[1..maxConnu] of TStringList;
  nomPage : TstringList;
  nbreCsvPasco : integer;
  p: Integer;

procedure affectePagePasco;
var i : integer;
    pageC : TcodePage;
    indexNomTitre : integer;
begin
    nomPage := TstringList.Create;
    for i := 1 to MaxConnu do NomVariabPagePasco[i] :=  TstringList.Create;
    pageC := 0;
    for i := 0 to maxGrandeurs do pagePasco[i] := 0;
    NbreCSVPasco := NbreCSv;
    for i := 0 to pred(NbreCSV) do begin
        indexNomTitre := nomPage.indexOfName(ligneList[i]);
        if indexNomTitre=-1
        then begin // nouvellePage
             inc(pageC);
             nomPage.Add(ligneList[i]+'='+intToStr(pageC));
             pagePasco[i] := pageC;
        end
        else begin
             pagePasco[i] := strToInt(nomPage.valueFromIndex[indexNomTitre]);
        end;
    end;
end;

function ConvertitNomPasco(const chaine : string) : string;
var suivantUnicode : boolean;
    i : integer;
begin
    result := '';
    suivantUnicode := false;
    for i := 1 to length(chaine) do begin
        if chaine[i]='Ã'
           then SuivantUnicode := true
           else begin
              if suivantUnicode
                 then case chaine[i] of
                      '©' : result := result + 'e';//'é';
                      '²' : result := result + '2';
                      '¨' : result := result + 'e';//'è';
                      'ª' : result := result + 'e';//'ê';
                      '«' : result := result + 'e';//'ë';
                      '´' : result := result + 'o';//'ô';
                      '°' : ;//result := result + '°';
                      '§' : result := result + 'c';//'ç';
                      '¼' : result := result + 'u';//'ü';
                      '»' : result := result + 'u';//'û';
                 end
                 else if charInSet(chaine[i],caracNomPasco) then result := result + chaine[i];
                 // on enlève les blancs tirets ...
              suivantUnicode := false;
           end;
    end;
end;

procedure litNomUnitePasco;
var i,index : integer;
    Lsignif,suffixe : string;
    k,j: Integer;
begin
     for i := 0 to maxGrandeurs do DecodeVariab[i] := grandeurInconnue;
     for i := 0 to pred(NbreCSV) do begin
         Lsignif := LigneList[i];
         Unite[i] := VerifUnite(i);
         Nom[i] := convertitNomPasco(LigneList[i]);
         for k := 1 to maxConnu do begin
             if pos(nomPasco[k],nom[i])=1 then begin
                if length(nom[i])>length(nomPasco[k])
                   then suffixe := copy(nom[i],length(nomPasco[k])+1,length(nom[i])-length(nomPasco[k]))
                   else suffixe := '';
                Lsignif := signifPasco[k];
                if suffixe='resultante' then begin
                   suffixe := 'R'; // résultante
                   Lsignif := Lsignif+' résultante';
                end;
                nom[i] := nomSimplePasco[k]+suffixe;
             end;
         end;
         if nom[i]<>'' then begin
            if (indexNom(nom[i])<>grandeurInconnue) then begin
               decodeVariab[i] := indexNom(nom[i]);
               if pagePasco[i]=1 then begin // existe déjà -> mettre dans une autre page
                  j := 1;
                  repeat
                      inc(j);
                  until (nomVariabPagePasco[j].indexOfName(nom[i])<0) or (j=MaxConnu);
                  pagePasco[i] := j;
                  if j>nomPage.count then
                     nomPage.Add(char(ord('A')+j)+'='+intToStr(j));
               end;
               nomVariabPagePasco[pagePasco[i]].Add(nom[i]);
            end;
            if indexNom(nom[i])=grandeurInconnue then begin
               index := AjouteExperimentale(nom[i],variable);
               decodeVariab[i] := index;
               grandeurs[index].NomUnite := unite[i];
               grandeurs[index].fonct.expression := Lsignif;
            end;
         end;
     end;
end;

procedure LitValeursPasco;
var i : integer;
    index : integer;
    dataLigne : array[TcodePage] of integer;
    iPage : integer;
begin
   while not(finFichierCSV) do begin
      litLigneCSV;
      if NbreCSV=0 then exit;
      for i := 1 to NbrePages do
          dataLigne[i] := 0;
      for i := 0 to pred(NbreCSV) do begin
          index := decodeVariab[i];
          if index<>GrandeurInconnue then begin
             iPage := pagePasco[i];
             if ligneList[i]<>''
                then begin
                   pages[iPage].valeurVar[index,pages[iPage].nmes] := strToFloatWin(ligneList[i]);
                   inc(dataLigne[iPage]);
                end;
          end;
      end;
      for i := 1 to NbrePages do
          if dataLigne[i]>2 then pages[i].nmes := pages[i].nmes+1;
   end;
end; // litValeursPasco

var i,j,k,imax : integer;
    existeAilleurs : boolean;
    NomVariab : array[0..maxGrandeurs] of string;
    NbreDataZero : array[TcodePage,0..32] of integer;
    nbrevar : integer;
begin // litPasco
     caracNomPasco := ['a'..'z','A'..'Z','0'..'9'];
     finFichierCsv := false;
     Reset(fichierCSV);
     litLigneCSV;
     affectePagePasco;
     litLigneCSV;
     litNomUnitePasco;
     if NbreGrandeurs=0 then exit;
     for i := 0 to pred(nomPage.count) do begin
         ajoutePageForce;
         pages[pageCourante].CommentaireP := nomPage.Names[i];
     end;
     nomPage.Free;
     for i := 1 to MaxConnu do NomVariabPagePasco[i].free;
     litValeursPasco;
     construireIndex;
     FileMode := fmOpenReadWrite;
     for j := 0 to NbreCsvPasco do
         if decodeVariab[j]=grandeurInconnue
            then NomVariab[j] := ''
            else NomVariab[j] := grandeurs[decodeVariab[j]].nom;
     for i := NbrePages downto 1 do
           if (pages[i].nmes<8) and (NbrePages>1) then begin
                 SupprimePage(i,false);
                 // supprimer les grandeurs n'apparaissant que dans cette page
                 for j := 0 to pred(NbreCsvPasco) do
                     if PagePasco[j]=i then begin
                        existeAilleurs := false;
                        for k := 0 to pred(NbreCsvPasco) do
                            if (j<>k) and (nomVariab[k]=nomVariab[j]) then begin
                               existeAilleurs := true;
                               break;
                            end;
                        if not existeAilleurs then VariabASuppr.add(nomVariab[j]);
                     end;
                 for j := 0 to pred(NbreCsvPasco) do begin
                     if pagePasco[j]>i then dec(pagePasco[j]);
                     if pagePasco[j]=i then pagePasco[j] := 0;
                 end;
              end;
      if NbrePages>3 then begin
           // supprimer les grandeurs n'apparaissant que dans une page
           for j := 0 to pred(NbreGrandeurs) do begin
               i := 0;
               for k := 0 to pred(NbreCsvPasco) do
                   if (nomVariab[k]=grandeurs[j].nom) then
                      inc(i);
               if (i<2) and (grandeurs[j].nom<>'t') then VariabASuppr.add(grandeurs[j].nom);
           end;
      end;
      if NbrePages>=2 then begin
           // distribuer le temps sur les pages
           for j := 0 to pred(NbreGrandeurs) do
               if (grandeurs[j].nom='t') then begin
                   for p := 2 to NbrePages do begin
                       if isNan(pages[p].valeurVar[j,2]) then begin
                           if (pages[p].nmes>pages[1].nmes)
                               then imax := pred(pages[1].nmes)
                               else imax := pred(pages[p].nmes);
                           for i := 0 to imax do
                               pages[p].valeurVar[j,i] := pages[1].valeurVar[j,i];
                       end;
                   end;
                   break;
               end;
      end;
      for p := 1 to NbrePages do begin
          for j := 0 to pred(NbreGrandeurs) do begin
              NbreDataZero[p,j] := 0;
              for i := 0 to pred(pages[p].nmes) do
                  if IsNan(pages[p].ValeurVar[j,i]) or
                    (pages[p].ValeurVar[j,i]=0) then inc(NbreDataZero[p,j]);
          end;
      end;
      for j := 0 to pred(NbreGrandeurs) do begin
        // supprimer les grandeurs sans intérêt
          existeAilleurs := false;
          for p := 1 to NbrePages do
              if NbreDataZero[p,j]<(pages[p].nmes div 2) then begin
                 existeAilleurs := true;
                 break;
              end;
          if not existeAilleurs then VariabASuppr.add(grandeurs[j].nom);
      end;
      for p := NbrePages downto 1 do begin
      // supprimer les pages sans intérêt
          NbreVar := 0;
          for j := 0 to pred(NbreGrandeurs) do
              if NbreDataZero[p,j]<(pages[p].nmes div 2) then inc(Nbrevar);
          if (nbreVar<=1) and (NbrePages>1) then SupprimePage(p,false);
      end;
      for i := 0 to pred(VariabASuppr.count) do
          supprimeGrandeurE(indexNomVariab(VariabASuppr[i]));
      LitFichierCSV := (NbrePages>0) and (pages[1].nmes>0) and (NbreGrandeurs>1);
end; // litPasco

procedure litGoodwill;
var valeurY : array[0..8192] of integer;
    nbre : integer;
    premiereLigne : string;
    posV : integer;
    lecture : boolean;
    penteX,penteY,yzero : double;
    i : integer;
begin // GoodWill
     Reset(fichierCSV);
     if nouveauFichier then begin
        AjouteExperimentale('t',variable);
        grandeurs[0].NomUnite := 's';
        AjouteExperimentale('V',variable);
        grandeurs[1].NomUnite := 'V';
     end;
     if not ajoutePage then exit;
     lecture := false;
     nbre := 0;
     yzero := 0;
     penteX := 1e-6;
     penteY := 0.001;
     while not eof(fichierCSV) and not lecture do begin
           readln(fichierCSV,premiereLigne);
           if pos('Memory Length',premiereLigne)>0 then ;
           if pos('Vertical Units',premiereLigne)>0 then ;
           if pos('Horizontal Units',premiereLigne)>0 then ;
           if pos('Vertical Scale',premiereLigne)>0 then begin
              penteY := extraitNombre(premiereLigne)/25;
           end;
           if (pos('Sample Period',premiereLigne)>0) or
              (pos('Sampling Period',premiereLigne)>0)
              then begin
              penteX := extraitNombre(premiereLigne);
           end;
           if pos('Trigger Level',premiereLigne)>0 then ;
           if pos('Vertical Position',premiereLigne)>0 then begin
              yzero := extraitNombre(premiereLigne);
           end;
           if pos('Horizontal Position',premiereLigne)>0 then ;
           if pos('Horizontal Scale',premiereLigne)>0 then ;
           if pos('Firmware',premiereLigne)>0 then ;
           if pos('Waveform Data',premiereLigne)>0 then begin
              lecture := true;
           end;
           if pos('Source',premiereLigne)>0 then begin // CH1
              posV := pos(',',premiereLigne);
              premiereLigne := copy(premiereLigne, posV+1, length(premiereLigne)-posV);
              posV := pos(',',premiereLigne);
              if posV>0 then premiereLigne := copy(premiereLigne, 1, posV-1);
              grandeurs[1].Nom := premiereLigne;
           end;
     end;
     while not eof(fichierCSV) do begin
        readln(fichierCSV,premiereLigne);
        if premiereLigne<>'' then begin
           posV := pos(',',premiereLigne);
           if posV>0 then premiereLigne := copy(premiereLigne, 1, posV-1);
           valeurY[nbre] := strToInt(premiereLigne);
           inc(nbre);
        end;
     end;
     with pages[pageCourante] do begin
          nmes := nbre;
          for i := 0 to pred(Nbre) do begin
              valeurVar[0,i] := i*penteX;
              valeurVar[1,i] := valeurY[i]*penteY+yzero;
          end;
     end;
     result := pages[pageCourante].nmes>128;
end; // litGoodWill

procedure litGoodwillPC;
var valeurY : array[0..8192] of integer;
    nbre : integer;
    premiereLigne : string;
    posV : integer;
    lecture : boolean;
    penteX,penteY,yzero : double;
    i : integer;
begin  // GoodWill
     Reset(fichierCSV);
     if nouveauFichier then begin
        AjouteExperimentale('t',variable);
        grandeurs[0].NomUnite := 's';
        AjouteExperimentale('V',variable);
        grandeurs[1].NomUnite := 'V';
     end;
     if not ajoutePage then exit;
     lecture := false;
     nbre := 0;
     yzero := 0;
     penteX := 1e-6;
     penteY := 0.001;
     while not eof(fichierCSV) and not lecture do begin
           readln(fichierCSV,premiereLigne);
           if pos('Memory Length',premiereLigne)>0 then ;
           if pos('Vertical Units',premiereLigne)>0 then ;
           if pos('Horizontal Units',premiereLigne)>0 then ;
           if pos('VERTICAL SCALE',premiereLigne)>0 then begin
              penteY := extraitNombre(premiereLigne)/25;
           end;
           if pos('TIME BASE SCALE',premiereLigne)>0 then begin
              penteX := extraitNombre(premiereLigne)/256;
               // par division avec 8 divisions sur 256 niveaux soit 32
           end;
           if pos('Trigger Level',premiereLigne)>0 then ;
           if pos('Vertical Position',premiereLigne)>0 then begin
              yzero := extraitNombre(premiereLigne);
           end;
           if pos('Horizontal Position',premiereLigne)>0 then ;
           if pos('Horizontal Scale',premiereLigne)>0 then ;
           if pos('Firmware',premiereLigne)>0 then ;
           if pos('POINT,VALUE',premiereLigne)>0 then begin
              lecture := true;
           end;
           if pos('RECORD Length',premiereLigne)>0 then begin
             // NbreMax := round(extraitNombre);
           end;
           if pos('Channel',premiereLigne)>0 then begin // CH1
              posV := pos(',',premiereLigne);
              premiereLigne := copy(premiereLigne, posV+1, length(premiereLigne)-posV);
              posV := pos(',',premiereLigne);
              if posV>0 then premiereLigne := copy(premiereLigne, 1, posV-1);
              grandeurs[1].Nom := premiereLigne;
           end;
     end;
     while not eof(fichierCSV) do begin
        readln(fichierCSV,premiereLigne);
        if premiereLigne<>'' then begin
           posV := pos(',',premiereLigne);   // index X
           if posV>0 then premiereLigne := copy(premiereLigne, posV+1, length(premiereLigne)-posV);
           posV := pos(',',premiereLigne); // indexY
           if posV>0 then premiereLigne := copy(premiereLigne, 1, posV-1);
           valeurY[nbre] := strToInt(premiereLigne);
           inc(nbre);
        end;
     end;
     with pages[pageCourante] do begin
          nmes := nbre;
          for i := 0 to pred(Nbre) do begin
              valeurVar[0,i] := i*penteX;
              valeurVar[1,i] := valeurY[i]*penteY+yzero;
          end;
     end;
     result := pages[pageCourante].nmes>128;
end; // litGoodWillPC

procedure litTektro;
var penteY,penteX,Yzero,probe,Yoffset : double;

procedure extraitPoint;
const
    filtre : TSysCharSet = ['0'..'9'];
    filtreInterne : TSysCharSet = ['0'..'9','.','-','E'];
var chaine : string;
    nbreCarac,posDebut : integer;
    premiereLigne : string;

begin with pages[pageCourante] do begin  // Tektro
   readln(fichierCSV,premiereLigne);
   posDebut := length(premiereLigne);
   while not CharInset(premiereLigne[posDebut],filtre) do dec(posDebut);
   nbreCarac := 0;
   while CharInset(premiereLigne[posDebut],filtreInterne) do begin
     inc(nbreCarac);
     dec(posDebut);
   end;
   chaine := copy(premiereLigne,posDebut+1,nbreCarac);
   valeurVar[1,nmes] := strToFloatWin(chaine);
   while not CharInSet(premiereLigne[posDebut],filtre) do dec(posDebut);
   nbreCarac := 0;
   while charInset(premiereLigne[posDebut],filtre) do begin
     inc(nbreCarac);
     dec(posDebut);
   end;
   chaine := copy(premiereLigne,posDebut+1,nbreCarac);
   valeurVar[0,nmes] := strToFloatWin(chaine);
   nmes := nmes+1;
   if pos('Vertical Scale',premiereLigne)>0 then
         penteY := extraitNombre(premiereLigne)/2000;
// pleine échelle avec 10 divisions sur 2048 niveaux
   if pos('Horizontal Scale',premiereLigne)>0 then
         penteX := extraitNombre(premiereLigne)*1e-6/250;
// par division avec 10 divisions sur 2500 points en micro s
    if pos('Vertical Offset',premiereLigne)>0 then
         Yoffset := extraitNombre(premiereLigne);
    if pos('Probe Atten',premiereLigne)>0 then
         probe := extraitNombre(premiereLigne);
    if pos('Yzero',premiereLigne)>0 then
         yzero := extraitNombre(premiereLigne);
end end;

var i : integer;
begin  // Tektro
     Reset(fichierCSV);
     if nouveauFichier then begin
        AjouteExperimentale('t',variable);
        grandeurs[0].NomUnite := 's';
        AjouteExperimentale('V',variable);
        grandeurs[1].NomUnite := 'V';
     end;
     if not ajoutePage then exit;
     while not eof(fichierCSV) do extraitPoint;
     result := pages[pageCourante].nmes>128;
     penteY := penteY/probe;
     for i := 0 to pred(pages[pageCourante].nmes) do begin
         pages[pageCourante].valeurVar[0,i] := i*penteX;
         pages[pageCourante].valeurVar[1,i] := (pages[pageCourante].valeurVar[1,i]-yzero)*penteY+yOffset;
     end;
end;  // litTektro

function litLigneSecomam : string;
var i : integer;
    uneLigne : string;
begin
    readln(fichierCSV,uneLigne);
    result := '';
    for i := 1 to Length(uneLigne) do
        if ord(uneLigne[i])>1 then result := result+uneLigne[i];
end; // litTektro

procedure litSecomam;

procedure extraitPoint;
var chaine : string;
    posTab : integer;
    LuneLigne : string;
begin with pages[pageCourante] do begin
   LuneLigne := litLigneSecomam;
   posTab := pos(crTab,LuneLigne);
   if posTab=0 then exit;
   chaine := copy(LuneLigne,1,pred(posTab));
   valeurVar[0,nmes] := strToFloatWin(chaine);
   chaine := copy(LuneLigne,succ(posTab),length(LuneLigne));
   valeurVar[1,nmes] := strToFloatWin(chaine);
   nmes := nmes+1;
end end;

procedure getNU(const complet : string;var Anom,Aunite : string);
var posCO,posCF : integer;
begin
    posCO := pos('[',complet);
    posCF := pos('[',complet);
    if posCF>posCO then begin
       Aunite := copy(complet,succ(posCO),posCF-posCO+1);
       Anom := copy(complet,1,pred(posCO))
    end
    else begin
       Aunite := '';
       Anom := complet;
    end;
end;

var uneLigne : string;
    posTab : integer;
    nomComplet,Lnom,Lunite : string;
begin  // secomam : csv avec tabulation !
     repeat
         uneLigne := litLigneSecomam;
     until eof(fichierCSV) or (pos('Absorption',uneLigne)>0);
     if eof(fichierCSV) then exit;
     if nouveauFichier then begin
        posTab := pos(crTab,uneLigne);
        nomComplet := copy(uneLigne,1,pred(posTab));
        getNU(nomComplet,Lnom,Lunite);
        AjouteExperimentale(Lnom,variable);
        grandeurs[0].NomUnite := Lunite;
        grandeurs[0].fonct.expression := nomComplet;
        nomComplet := copy(uneLigne,succ(posTab),length(uneLigne));
        getNU(nomComplet,Lnom,Lunite);
        AjouteExperimentale(Lnom,variable);
        grandeurs[1].NomUnite := Lunite;
        grandeurs[1].fonct.expression := nomComplet;
     end;
     if not ajoutePage then exit;
    // pages[pageCourante].commentaireP := comment;
     while not eof(fichierCSV) do
        extraitPoint;
     result := pages[pageCourante].nmes>2;
end; // litSeconam

procedure litChauvinArnoux;

procedure LitValeurs;
var i,NbrePoints : integer;
    posTime,posDateCA : integer;
    strValeur : string;
    millisecStr : string;
    index : integer;
begin
   litLigneCSV;
   while not(finFichierCSV) do with pages[pageCourante] do begin
      NbrePoints := nmes;
      nmes := nmes+1;
      for i := 0 to pred(NbreCSV) do begin
          index := decodeVariab[i];
          strValeur := ligneList[i];
          posTime := pos(':',strValeur);
          posDateCA := pos('-',strValeur);
          if (posDateCA>0) and (posTime>0) then begin // Date Time Chauvin Arnoux 2012-12-25 12:56:13:000
              posDateCA := pos(' ',strValeur);
              if posDateCA>0 then strValeur := copy(strValeur,posDateCA+1,length(strValeur));
              millisecStr := copy(strValeur,10,3);
              strValeur := copy(strValeur,1,8);
              // on enlève la date
              if index<>grandeurInconnue then
                 valeurVar[index,NbrePoints] := StrToTime(strValeur);
              (* conversion en seconde
               millisec := strToInt(millisecStr)/1000;
               seconde := StrToTime(strValeur)*24*60*60;
               valeurVar[index,NbrePoints] := seconde+millisec;
              *)
          end
          else valeurVar[index,NbrePoints] := strToFloatWin(strValeur);
      end;
      litLigneCSV;
   end;
end; // litValeurs

var premiereLigne : string;
    i : integer;
begin // Chauvin Arnoux
    Reset(fichierCSV);
    finFichierCSV := false;
    NbreCSV := 0;
    readln(fichierCSV,premiereLigne);
    for i := 0 to maxGrandeurs do
        DecodeVariab[i] := grandeurInconnue;
    if nouveauFichier then begin
        AjouteExperimentale('index',variable);
        grandeurs[0].NomUnite := '';
        AjouteExperimentale('t',variable);
        grandeurs[1].NomUnite := 's';
        grandeurs[1].formatU := fTime;
        AjouteExperimentale('T',variable);
        grandeurs[2].NomUnite := '°C';
        for i := 0 to 2 do
            DecodeVariab[i] := i;
     end
     else begin
        DecodeVariab[0] := indexNom('index');
        if DecodeVariab[0]=grandeurInconnue then
           DecodeVariab[0] := 0;
        DecodeVariab[1] := indexNom('t');
        DecodeVariab[2] := indexNom('T');
     end;
     if not ajoutePage then exit;
     pages[pageCourante].commentaireP := premiereLigne;
     readln(fichierCSV,premiereLigne);// en fait la deuxième !
     separateurCSV := ';';
     litValeurs;
     if (pages[pageCourante].nmes>0)then begin
         LitFichierCSV := true;
         construireIndex;
     end;
end; // litChauvinArnoux

var premiereLigne : string;
    ls : string;
    commentaire : string;
    compteur,NEnTete,i : integer;
    indexDateTexte : integer;
    t0 : double;
label fin;

Procedure Test_LF_only;
var avecCR,avecLF : boolean;
    carac : char;
    ListeTampon : TStringList;
begin
   repeat
      read(fichierCSV,carac);
      avecCR := carac=crCR;
      avecLF := carac=crLF;
   until avecCR or avecLF or eof(fichierCSV);
   if not eof(fichierCSV) then begin
      read(fichierCSV,carac);
      if (avecCR and (carac<>crLF)) or
         (avecLF and (carac<>crCR)) then begin // CR ou LF seul
         listeTampon := TStringList.Create;
         if avecCR then listeTampon.LineBreak := crCR;
         if avecLF then listeTampon.LineBreak := crLF;
         closeFile(fichierCSV);
         listeTampon.LoadFromFile(NomFichier);
         listeTampon.LineBreak := crCR+crLF;
         listeTampon.SaveToFile(NomFichier);
         AssignFile(fichierCSV,NomFichier);
         listeTampon.Free;
      end;
   end;
   Reset(fichierCSV);
end;

begin // LitFichierCSV
     result := false;
     strErreurFichier := erFileData;
     ModeAcquisition := AcqFichier;
     FileMode := fmOpenRead;
     ligneList := TStringList.Create;
     ligneList.strictDelimiter := true;
     separateurCSV := ',';
     ligneList.QuoteChar := #0;
     VariabASuppr := TStringList.create;
     VariabASuppr.Duplicates := dupIgnore;
     AssignFile(fichierCSV,NomFichier);
     Reset(fichierCSV);
     Test_LF_Only;
     readln(fichierCSV,premiereLigne);
     if pos(';',premiereLigne)>0
        then separateurCSV := ';'
        else if pos(',',premiereLigne)>0
           then separateurCSV := ','
           else if (pos(crTab,premiereLigne)>0)
              then separateurCSV := crTab;
     ligneList.delimiter := separateurCSV;
     if not isPasco then
        isPasco := compte(premiereLigne,'Set')>5;
     if not isPasco then
        isPasco := compte(premiereLigne,'Calibrate')>5;
     if not isPasco then
        isPasco := compte(premiereLigne,'Run #')>5;
     if not isPasco then
        isPasco := compte(premiereLigne,'Monitor Run')>5;
     if not isPasco then
        isPasco := compte(premiereLigne,'ExÃ©cuter')>5;  // Exécuter #1 #2 ...
     if isPasco then begin
         litPasco;
         goto fin;
     end;
     if pos('Record Length',premiereLigne)>0 then begin
        litTektro;
        goto fin;
     end;
     if pos('IR Camera',premiereLigne)>0 then begin
        litChauvinArnoux;
        goto fin;
     end;
     if pos('Memory Length',premiereLigne)>0 then begin
        litGoodwill;
        goto fin;
     end;
     if pos('DESCRIPTION',premiereLigne)>0 then begin
         readln(fichierCSV,premiereLigne);
         if pos('MANUFACTURE',premiereLigne)>0 then begin
           litGoodwillPC;
           goto fin;
         end;
     end;
     NEnTete := 0;
     while (pos(';',premiereLigne)<=0) and
           (pos(',',premiereLigne)<=0) and
           (pos(crTab,premiereLigne)<=0) and
           not eof(fichierCSV) do begin
           inc(NEnTete);
           readln(fichierCSV,premiereLigne); // deuxième... en fait
           if pos(';',premiereLigne)>0
              then separateurCSV := ';'
              else if pos(',',premiereLigne)>0
                 then separateurCSV := ','
                 else if pos(crTab,premiereLigne)>0
                    then separateurCSV := crTab;
           ligneList.delimiter := separateurCSV;
     end;
     avecNoms := not ligneDeChiffres(premiereLigne);
     compteur := 1;
     repeat
        ls := litLigneSecomam;
        inc(compteur);
        until eof(fichierCSV) or
             (pos('UviLine',ls)>0) or
             (compteur=5);
     if (pos('UviLine',ls)>0) then begin
         litSecomam;
         goto fin;
     end;
     Reset(fichierCSV);
     finFichierCSV := false;
     NbreCSV := 0;
     if NEnTete>0
        then readln(fichierCSV,commentaire)
        else commentaire := '';
     for compteur := 2 to NEnTete do readln(fichierCSV,premiereLigne);
     try
     if NouveauFichier
        then litNomUnite
        else verifNoms;
     if result and nouveauFichier then begin
        if grandeurs[0].nom='Date' then begin
           grandeurs[0].nom := 't';
           grandeurs[0].nomUnite := 'jour';
           grandeurs[0].formatU := fDefaut;
           indexDateTexte := ajouteExperimentale('Date',variable);
           grandeurs[indexDateTexte].fonct.genreC := g_texte;
           with pages[pageCourante] do begin
              t0 := valeurVar[0,0];
              for i := 0 to nmes-1 do  begin
                 texteVar[indexDateTexte,i] := FormatDateTime('dd mmm yyyy',valeurVar[0,i]);
                 valeurVar[0,i] := valeurVar[0,i]-t0;
              end;
           end;
      end;
        pages[pageCourante].affecteVariableP(false);
        pages[pageCourante].commentaireP := commentaire;
     end;
     except
         strErreurFichier := erReadFile;
         result := false;
     end;
     fin:
     VariabAsuppr.free;
     LigneList.free;
     CloseFile(fichierCSV);
     FileMode := fmOpenReadWrite;
end; // LitFichierCSV

procedure EcritFichierXML(const nomFichier : String);

procedure writePage(ANode : IXMLNOde;p : integer);
begin
    ANode.Attributes[stPage] := intToStr(p);
end;

procedure writeIndex(ANode : IXMLNOde;p : integer);
begin
    ANode.Attributes['Index'] := intToStr(p);
end;

var i : integer;
    v : integer;
    p : TcodePage;
    donnees : TstringList;
    XmlDoc: TXMLDocument;
    Document: IXMLNode;
    Node1, Node2 : IXMLNode;
begin
     Screen.Cursor := crHourGlass;
     donnees := TstringList.create;
     XMLDoc := TXMLDocument.Create(nil);
     XMLDoc.active := true;
     XMLDoc.Options := [doNodeAutoIndent];

  //   XMLDoc.ExternalEncoding := seUTF16LE;
  //   XMLDoc.Declaration.Encoding := 'UTF-16';
  //   XMLDoc.xmlFormat := xfReadable;
     XMLDoc.DocumentElement := XMLDoc.createElement(stRegressi,'');
     Document := XMLDoc.DocumentElement;

     Node1 := Document.addChild('SOURCE');
     WriteStringXML(Node1,'Logiciel',stRegressi);
     WriteStringXML(Node1,'Version','3.05');
     WriteStringXML(Node1,'Acquisition',NomModeAcq[ModeAcquisition]);
     WriteDateTimeXML(Node1,'Date',now);
     WriteStringXML(Node1,'Copyright','Jean-Michel Millet');

     Node1 := Document.addChild(stOptions);
     WriteBoolXML(Node1,'Trigo',AngleEnDegre);
     WriteIntegerXML(Node1,'NbreDerivee',NbrePointDerivee);

     donnees.clear;
     for I := 0 to FValeurs.Memo.lines.Count - 1 do
         donnees.add(Fvaleurs.Memo.lines[i]);
     donnees.Delimiter := crCR;
     WriteStringXML(Document,'Memo',donnees.DelimitedText);
     for v := 0 to pred(NbreGrandeurs) do with grandeurs[v] do
     if fonct.genreC=g_experimentale then begin
         case genreG of
              variable : Node1 := Document.addChild('VARIABLE');
              constante : Node1 := Document.addChild('CONSTANTE');
         end;
         Node1.Attributes[stNom] := nom;
         WriteStringXML(Node1,'Unite',nomUnite);
         WriteIntegerXML(Node1,'Precision',precisionU);
         WriteIntegerXML(Node1,'GenreCalcul',ord(fonct.genreC));
         WriteStringXML(Node1,'Description',fonct.expression);
         if v=indexTri then WriteBoolXML(Node1,'Controle',true);
         for p := 1 to NbrePages do with pages[p] do begin
             case genreG of
                 variable : if fonct.genreC=g_texte
                    then begin
                         donnees.clear;
                         for i := 0 to pred(pages[p].nmes) do
                             donnees.Add(TexteVar[v,i]);
                         Node2 := writeStringXML(Node1,'Texte',donnees.text);
                         writePage(Node2,p);
                    end
                    else begin
                       donnees.clear;
                       for i := 0 to pred(pages[p].nmes) do
                           donnees.Add(FloatToStrPoint(valeurVar[v,i]));
                       donnees.Delimiter := ' ';
                       Node2 := WriteStringXML(Node1,'Valeur',donnees.DelimitedText);
                       writePage(Node2,p);
                   end;
                 constante : begin
                     Node2 := WriteFloatXML(Node1,'Valeur',valeurConst[v]);
                     writePage(Node2,p);
                 end;
             end;  // case
          end;  // for p
     end; // grandeur
     for v := 1 to NbreParam[paramNormal] do begin
         Node1 := Document.addChild('PARAMETRE');
         writeIndex(Node1,v);
         Node1.Attributes[stNom] := parametres[paramNormal,v].nom;
         WriteStringXML(Node1,stUnite,parametres[paramNormal,v].nomUnite);
         for p := 1 to NbrePages do begin
             Node2 := WriteFloatXML(Node1,'Valeur',pages[p].valeurParam[paramNormal,v]);
             writePage(Node2,p);
         end;
     end;
     for v := 1 to NbreParam[paramGlb] do begin
         Node1 := Document.addChild('PARAMGLB');
         writeIndex(Node1,v);
         Node1.Attributes[stNom] := parametres[paramGlb,v].nom;
         WriteStringXML(Node1,stUnite,parametres[paramGlb,v].nomUnite);
         Node2 := WriteFloatXML(Node1,'Valeur',parametres[paramGlb,v].valeurCourante);
         writePage(Node2,1);
   end;
     if (NbreModele>0) or (TexteModele.count>0) then begin
        Node1 := Document.addChild(stMODELE);
        TexteModele.Delimiter := crCR;
        WriteStringXML(Node1,'Modelisation',TexteModele.delimitedText);
        for i := 1 to NbreModele do
            for p := 1 to NbrePages do begin
                Node2 := writeIntegerXML(Node1,'DEBUT',pages[p].debut[i]);
                writeIndex(Node2,i);
                writePage(Node2,p);
                Node2 := writeIntegerXML(Node1,'FIN',pages[p].fin[i]);
                writeIndex(Node2,i);
                writePage(Node2,p);
            end;
     end;
     Node1 := Document.AddChild(stGraphe);
     FGrapheVariab.ecritConfigXML(Node1);
     if FgrapheFFT<>nil then begin
        Node1 := Document.AddChild('FOURIER');
        FgrapheFFT.ecritConfigXML(Node1);
     end;
     if FgrapheParam<>nil then begin
        Node1 := Document.AddChild('GrapheP');
        FgrapheParam.ecritConfigXML(Node1);
     end;
     if FgrapheEuler<>nil then begin
        Node1 := Document.AddChild('EULER');
        FgrapheEuler.ecritConfigXML(Node1);
     end;
     XMLDoc.saveToFile(NomFichier);
     donnees.free;
     Screen.Cursor := crDefault;
end; // EcritFichierXML

function LitFichierXML(const NomFichier : String) : boolean;
var
    XmlDoc: TXmlDocument; // Xml document
    indexCourant : integer; // de la grandeur
    codeCourant : integer; // du parametre
    modeleCourant : integer;
    chaines : TStringList;

procedure LoadXMLInReg(XMLNode: IXMLNode);

Function GetIntegerAttribute(const genre : string) : integer;
var s : string;
begin
     try
     s := XMLNode.Attributes[genre];
     result := StrToInt(s);
     except
        result := 1;
     end;
end;

Procedure ExtraitValeurs;
var i : integer;
    strValeur : string;
begin with pages[pageCourante] do begin
    chaines.Delimiter := ' ';
    chaines.DelimitedText := XMLNode.NodeValue;
    nmes := chaines.Count;
    for i := 0 to chaines.Count-1 do begin
        strValeur := chaines[i];
        try
        valeurVar[indexCourant,i] := strToFloatWin(strValeur);
        except
        valeurVar[indexCourant,i] := Nan;
        end;
    end;
end end; // extraitValeurs

Procedure ExtraitChaines;
begin
    chaines.Clear;
    chaines.DelimitedText := XMLNode.Text;
end; // extraitChaines

procedure Suite;
var i: Integer;
begin
if XMLNode.HasChildNodes then
   for I := 0 to XMLNode.ChildNodes.Count - 1 do
       LoadXMLInReg(XMLNode.ChildNodes.Nodes[I]);
end;

var
I: Integer;
code : integer;
nom : string;
begin //Les noeuds internes sont traitées récursivement
if XMLNode.NodeType <> ntElement then Exit;
//S'il s'agit d'une feuille
if (XmlNode.NodeName=stRegressi) then begin
   suite;
   exit;
end;
if (XmlNode.NodeName='Memo') then begin
   extraitChaines;
   Fvaleurs.Memo.Lines.Assign(chaines);
   exit;
end;
if (XmlNode.NodeName=stGraphe) then begin
   FGrapheVariab.LitConfigXML(XMLNode);
   exit;
end;
if (XmlNode.NodeName='GrapheP') then begin
   FgrapheParam := TfgrapheParam.create(FRegressiMain);
   FGrapheParam.LitConfigXML(XMLNode);
   exit;
end;
if (XmlNode.NodeName='FOURIER') then begin
   FgrapheFFT := TfgrapheFFT.create(FRegressiMain);
   FGrapheFFT.LitConfigXML(XMLNode);
   exit;
end;
if (XmlNode.NodeName='EULER') then begin
   FgrapheEuler := TfgrapheEuler.create(FRegressiMain);
   FGrapheEuler.LitConfigXML(XMLNode);
   exit;
end;
if (XmlNode.NodeName='Modelisation') then begin
   extraitChaines;
   TexteModele.Assign(chaines);
   exit;
end;
if (XMLNode.NodeName='Valeur') then begin
   pageCourante := getIntegerAttribute(stPage);
   if (pageCourante>0) and (pageCourante>NbrePages) then
        ajoutePage;
   if pageCourante=0 then exit;
   case grandeurs[indexCourant].genreG of
      variable : if grandeurs[indexCourant].fonct.genreC=g_texte
                    then begin
                       extraitChaines;
                       for i := 0 to chaines.Count-1 do
                           pages[pageCourante].TexteVar[indexCourant,i] := chaines[i];
                       exit;
                    end
                    else begin
                       ExtraitValeurs;
                    end;
      constante : begin
           pages[pageCourante].valeurConst[indexCourant] := getFloatXML(XMLNode);
           exit;
      end;
      paramNormal : begin
           pages[pageCourante].valeurParam[paramNormal,codeCourant] := getFloatXML(XMLNode);
           exit;
      end;
      paramGlb : begin
           parametres[paramGlb,codeCourant].valeurCourante := getFloatXML(XMLNode);
           exit;
      end;
   end;
end;

if (XmlNode.NodeName='VARIABLE') then begin
    nom := XmlNode.Attributes[stNom];
    indexCourant := AjouteExperimentale(nom,variable);
    suite;
    exit;
end;
if (XmlNode.NodeName=stModele) then begin
    suite;
    exit;
end;
if (XmlNode.NodeName='DEBUT') then begin
    pageCourante := getIntegerAttribute(stPage);
    modeleCourant := getIntegerAttribute('Index');
    pages[pageCourante].debut[modeleCourant] := getIntegerXML(XmlNode);
    exit;
end;
if (XmlNode.NodeName='FIN') then begin
    pageCourante := getIntegerAttribute(stPage);
    modeleCourant := getIntegerAttribute('Index');
    pages[pageCourante].fin[modeleCourant] := getIntegerXML(XMLNode);
    exit;
end;
if (XmlNode.NodeName='CONSTANTE') then begin
    nom := XmlNode.Attributes[stNom];
    indexCourant := AjouteExperimentale(nom,constante);
    suite;
    exit;
end;
if (XmlNode.NodeName='PARAMETRE') then begin
    nom := XmlNode.Attributes[stNom];
    codeCourant := GetIntegerAttribute('Index');
    parametres[paramNormal,codeCourant].nom := nom;
    if codeCourant>NbreParam[paramNormal] then
       NbreParam[paramNormal] := codeCourant;
    indexCourant := ParamToIndex(paramNormal,codeCourant);
    suite;
    exit;
end;
if (XmlNode.NodeName='PARAMGLB') then begin
    nom := XmlNode.Attributes[stNom];
    codeCourant := GetIntegerAttribute('Index');
    parametres[paramGlb,codeCourant].nom := nom;
    if codeCourant>NbreParam[paramGlb] then
       NbreParam[paramGlb] := codeCourant;
    indexCourant := ParamToIndex(paramGlb,codeCourant);
    suite;
    exit;
end;
if (XmlNode.NodeName='Trigo') then begin
    AngleEnDegre := GetBoolXML(XMLNode);
    exit;
end;

if (XmlNode.NodeName='NbreDerivee') then begin
    NbrePointDerivee := GetIntegerXML(XMLNode);
    exit;
end;

if (XmlNode.NodeName='SOURCE') then begin
   suite;
   exit;
end;

if XMLNode.NodeName='Unite' then begin
      grandeurs[indexCourant].nomUnite := XMLNode.Text;
      exit;
end;

if XMLNode.NodeName='GenreCalcul' then begin
      code := getIntegerXML(XMLNode);
      grandeurs[indexCourant].fonct.genreC := TGenreCalcul(code);
      exit;
end;

if XMLNode.NodeName='Description' then begin
      grandeurs[indexCourant].fonct.expression := XMLNode.Text;
      exit;
end;

end; // LoadXMLInReg

begin // LitFichierXML
strErreurFichier := erFileData;
ModeAcquisition := AcqFichier;
chaines := TStringList.create;
chaines.Delimiter := crCR;
XMLDoc := TXMLDocument.Create(application.MainForm);
try
XmlDoc.FileName := NomFichier;
if (XmlDoc.DOMVendor=nil) and (DomVendors.count>0)
    then XmlDoc.DOMVendor := DomVendors.Vendors[0];
XMLDoc.Active := True;
if (XMLDoc.DocumentElement.NodeType=ntElement) and
   (XMLDoc.DocumentElement.NodeName=stRegressi)
   then begin
      LoadXMLInReg(XMLDoc.DocumentElement);
      result := true;
   end
   else begin
      result := false;
      strErreurFichier := erReadRegressiXML;
   end;
except
    strErreurFichier := erReadFile;
    result := false;
    resetEnTete;
end;
chaines.free;
end; // LitFichierXML

function LitFichierLogger(const NomFichier : String) : boolean;
var
    FXmlDoc: TXmlDocument; // Xml document
    Ident,DecodeVariab : array[0..maxGrandeurs] of integer;
    Symbole,Comment,CommentInit : array[0..maxGrandeurs] of string;
    DataExp : array[0..maxGrandeurs] of boolean;
    nouvellePage : boolean;
    NbreVariabXML : integer;
    valeur : Tvecteur;
    NbreValeurs : integer;

Procedure ExtraitValeurs(i,j,k : integer);
var jj,ii : integer;
    index : integer;
    strValeur : string;
    s : string;
begin
    s := FXMLdoc.DocumentElement.ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeValue;
with pages[pageCourante] do begin
    ii := 0;jj := 1;
    Repeat
        strValeur := '';
        while (jj<=length(s)) and
              (ord(s[jj])<=ord(' ')) do inc(jj);
        // fin de ligne ou S[jj]<>CR
        while (jj<=length(s)) and
              (ord(s[jj])>ord(' ')) do begin
           strValeur := strValeur+s[jj];
           inc(jj);
        end; // fin de ligne ou S[jj]=CR
        if strValeur<>'' then begin
           try
           valeur[ii] := strToFloatWin(strValeur);
           inc(ii);
           if ii>=NbreValeurs then begin
              NbreValeurs := NbreValeurs+MaxVecteurDefaut;
              setLength(valeur,NbreValeurs);
           end;
           except
           end;
        end;
    until (jj>length(s));
    if ii>nmes then nmes := ii;
    index := decodeVariab[j];
    copyVecteur(valeurVar[index],valeur);
end end; // extraitValeurs

Procedure DecodeLogger(var s : String);
var longueur,posCourant : integer;
begin
	longueur := Length(s);
  for posCourant := 1 to longueur do begin
    	if (s[posCourant]=#195) then s[posCourant] := 'é';
      if (s[posCourant]=#178) then s[posCourant] := '2'; // exposant 2
  end;
  posCourant := 1;
 	while (posCourant<=longueur) do
		if not isLettre(s[posCourant]) and not charinset(s[posCourant],CaracNombre)
			then begin
			   Delete(s,posCourant,1);
			   dec(longueur);
			end
			else inc(posCourant);
end;

procedure LitNom(i,j : integer);
const maxU = 6;
      nomCSV : array[0..MaxU,boolean] of string =
          (('second','s'),
           ('Ampere','A'),
           ('Watt','W'),
           ('Volt','V'),
           ('Volts','V'),
           ('Amperes','A'),
           ('Hertz','Hz'));
var k,l,index,po : integer;
    nomUnite : string;
    cells : string;
    identStr : string;
begin with FXMLdoc.DocumentElement.ChildNodes[i].ChildNodes[j] do begin
    dataExp[j] := false;
    for k := 0 to ChildNodes.Count - 1 do begin
        if ChildNodes[k].NodeName='DataObjectName' then begin
           commentInit[j] := ChildNodes[k].Nodevalue;
           comment[j] := commentInit[j];
           decodeLogger(comment[j]);
        end;
        if ChildNodes[k].NodeName='DataObjectShortName' then begin
           symbole[j] := ChildNodes[k].NodeValue;
        //   TrimAscii127(symbole[j]);
           TrimComplet(symbole[j]);
           if pos('1/',symbole[j])>0 then begin
              system.delete(symbole[j],1,2);
              symbole[j] := 'inv'+symbole[j];
           end;
           po := pos('.',symbole[j]);
           if po>0 then system.delete(symbole[j],po,1);
           trimComplet(symbole[j]);
        end;
        if ChildNodes[k].NodeName='ID' then begin
           IdentStr := ChildNodes[k].NodeValue;
           trimComplet(identStr);
           Ident[j] := StrtoInt(identStr);
        end;
        if ChildNodes[k].NodeName='ColumnUnits' then begin
           nomUnite := ChildNodes[k].NodeValue;
           TrimAscii127(nomUnite);
           for l := 0 to maxU do
                if nomUnite=nomCSV[l,false] then begin
                   nomUnite := nomCSV[l,true];
                   break;
                end;
        end;
        if ChildNodes[k].NodeName='ColumnCells' then begin
           cells := ChildNodes[k].NodeValue;
           po := pos('Z',cells); // Z2:2 format ?
           dataExp[j] := (cells<>'') and
             ((po=0) or (po>16));
        end;
     end; // for k
     if dataExp[j] then begin
        if symbole[j]='' then begin
           symbole[j] := comment[j];
           po := pos('.',symbole[j]);
           if po>0 then system.delete(symbole[j],po,1);
           trimComplet(symbole[j]);
           comment[j] := '';
        end;
        if pageCourante=0 then begin
            index := AjouteExperimentale(symbole[j],variable);
            grandeurs[index].NomUnite := nomUnite;
            grandeurs[index].fonct.expression := comment[j];
            DecodeVariab[j] := index;
            nouvellePage := true;
        end
        else DecodeVariab[j] := indexNom(symbole[j]);
        inc(NbreVariabXML);
     end;
end end;

Procedure GetMemo;
var equationStr : string;

procedure MajFonctions;
const maxK = 10;
      nomLogger : array[0..MaxK,boolean] of string =
          (('secondDerivative','diff2'),
           ('derivative','diff'),
           ('diff2SG','diff2'),
           ('diffSG','diff'),
           ('sinh','sh'),
           ('cosh','ch'),
           ('tanh','th'),
           ('smoothAve','lisse'),
           ('integral','intg'),
           ('smoothSG','lisse'),
           ('ceiling','ceil'));

var po,k : integer;
begin
     for k := 0 to maxK do begin
         po := pos(nomLogger[k,false],equationStr);
         if po>0 then begin
              system.delete(equationStr,po,length(nomLogger[k,false]));
              equationStr := nomLogger[k,true]+equationStr;
         end;
    end;
end;

var i,j,k,po : integer;
    variabId : integer;
begin with FXMLDoc.DocumentElement do
    for i := 0 to ChildNodes.Count - 1 do if ChildNodes[i].NodeName='DataSourceServer' then // calculs
          for j := 0 to ChildNodes[i].ChildNodes.Count - 1 do
              if ChildNodes[i].ChildNodes[j].NodeName='CalcColumnSource2' then  begin
                 variabId := -1;
                 for k := 0 to ChildNodes[i].ChildNodes[j].ChildNodes.Count - 1 do begin
                     if ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeName='CalcEquation' then
                        equationStr := ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeValue;
                     if ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeName='CalcOutColumnID' then
                        variabId := strtoInt(ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeValue);
              end;// for k
              repeat
                  po := pos('"',equationStr);
                  if po>0 then system.delete(equationStr,po,1);
              until po=0;
              repeat
                  po := pos('Latest:',equationStr);
                  if po>0 then system.delete(equationStr,po,7);
              until po=0;
              MajFonctions;
              k := 0;
              repeat
                  if (symbole[k]<>'') and
                     (length(commentInit[k])>length(symbole[k])+3) then begin
                     po := pos(commentInit[k],equationStr);
                     if po>0 then begin
                        system.delete(equationStr,po,length(commentInit[k]));
                        insert(symbole[k],equationStr,po);
                     end;
                  end;
                  inc(k);
              until k=maxGrandeurs;
              for k := 0 to maxGrandeurs do
                  if ident[k]=variabId then begin
                     trimComplet(equationStr);
                     equationStr := symbole[k]+'='+equationStr;
                     Fvaleurs.memo.lines.Add(equationStr);
                     break;
                  end;
              end; // CalcColumnSource2
end;

function litChaine(noued : IXMLNode) : string;
begin
       try
           result := noued.NodeValue;
       except
           result := '';
       end;
end;

procedure GenereRW3;
const maxConst = 3;
var i,j,k,l : integer;
    nomNoeud : string;
    valeurStr,valeurUnit,valeurNom : string;
    valeurParam : array[1..maxConst] of double;
    editable : boolean;
    nomUnitParam,nomParam : array[1..maxConst] of string;
    indexParam : integer;
    nombreConstxmbl : integer;
begin
nombreConstxmbl := 0;
editable := false;
with FXMLDoc.DocumentElement do
      for i := 0 to ChildNodes.Count - 1 do begin
      nomNoeud := ChildNodes[i].NodeName;
      if nomNoeud='DataSet' then begin // nouvelle page
           nouvellePage := false;
           for j := 0 to maxGrandeurs do begin
               DecodeVariab[j] := j;
               ident[j] := 0;
               symbole[j] := '';
               comment[j] := '';
               commentInit[j] := '';
               dataExp[j] := false;
           end;
           NbreVariabXML := 0;
           for j := 0 to ChildNodes[i].ChildNodes.Count - 1 do begin
               if ChildNodes[i].ChildNodes[j].NodeName='DataColumn' then // c'est une variable
                   litNom(i,j);
           end; // for j
           if nouvellePage then getMemo;
           nouvellePage := nouvellePage or
                  ((pageCourante>0) and (NbreVariabExp=NbreVariabXML));
           if nouvellePage then begin
               ajoutePage;
               construireIndex;
               for j := 0 to ChildNodes[i].ChildNodes.Count - 1 do begin // une page
                   if ChildNodes[i].ChildNodes[j].NodeName='DataSetComments' then
                      pages[pageCourante].commentaireP := litChaine(ChildNodes[i].ChildNodes[j]);
                   if ChildNodes[i].ChildNodes[j].NodeName='DataSetName' then
                      pages[pageCourante].commentaireP := litChaine(ChildNodes[i].ChildNodes[j]);
                   if (ChildNodes[i].ChildNodes[j].NodeName='DataColumn') and dataExp[j] then begin
                      // nouvelle variable expérimentale
                      for k := 0 to ChildNodes[i].ChildNodes[j].ChildNodes.Count - 1 do
                          if ChildNodes[i].ChildNodes[j].ChildNodes[k].NodeName='ColumnCells' then
                             extraitValeurs(i,j,k);
                      if pages[pageCourante].nmes>2
                         then result := true
                         else if pageCourante>1 then supprimePage(pageCourante,false);
                   end; // DataColumn
               end;// for j
               for l := 1 to nombreConstXMBL do begin
                  indexParam := indexNom(nomParam[l]);
                  if indexParam=grandeurInconnue then begin
                     indexParam := AjouteExperimentale(nomParam[l],constante);
                     grandeurs[indexParam].nomUnite := nomUnitParam[l];
                  end;
                  pages[pageCourante].ValeurConst[indexParam] := valeurParam[l];
               end;
            end; // nouvelle page
      end // dataset
      else if nomNoeud='MathConstantValue' then begin
           valeurStr := litChaine(ChildNodes[i]);
      end
      else if nomNoeud='MathConstantEditable' then begin
           editable := ChildNodes[i].NodeValue='1';
      end
      else if nomNoeud='MathConstantUnits' then begin
           valeurUnit := litChaine(ChildNodes[i]);
      end
      else if nomNoeud='MathConstantName' then begin
           valeurNom := litChaine(ChildNodes[i]);
           if (valeurNom<>'pi') and
              editable and
              (nombreConstXMBL<maxConst) then begin
               inc(NombreConstXmbl);
               nomParam[NombreConstXMBL] := valeurNom;
               valeurParam[NombreConstXMBL] := strToFloatWin(valeurStr);
               nomUnitParam[NombreConstXMBL] := valeurUnit;
           end;
      end
      end;
end;// GenereRW3;

begin // LitFichierLogger
     result := false;
     strErreurFichier := erFileData;
     ModeAcquisition := AcqFichier;
     NbreValeurs := MaxVecteurDefaut;
     setLength(valeur,NbreValeurs);
    try
      FXmlDoc := TXMLDocument.Create(application.MainForm);
    //  FXMLDoc.ExternalEncoding := seUTF8;
    //  FXMLDoc.Declaration.Encoding := 'UTF-8';
    //  FXMLDoc.XmlFormat := xfReadable;
      FXmlDoc.LoadFromFile(NomFichier);
      if assigned(FXMLDoc.DocumentElement) then genereRW3;
      if result then
         pages[pageCourante].affecteVariableP(false);
      except
         strErreurFichier := erReadFile;
         AfficheErreur(erReadFile,0);
         result := false;
         resetEnTete;
     end;
     FXMLdoc.Free;
     finalize(valeur);
end; // LitFichierLogger

var
   fichierCCD : textFile;

function litPageCCD : boolean;

procedure  flush_lines (n : integer);
var i : integer;
begin
    for i := 0 to pred(n) do readln(fichierCCD)
end;
procedure readArray;
var x,xold,y : integer;
    index : integer;
begin
   xold := -1;
   index := 0;
   pages[pageCourante].nmes := 2048;
   repeat
      try
      read(fichierCCD,x);
      read(fichierCCD,y);
      readln(fichierCCD);
      x := round((x-301.68022)/ 2.007870679); //conversion PS->maths
      if x<>xold then begin       // sinon doublon
         pages[pageCourante].ValeurVar[0,index] := x;
         pages[pageCourante].ValeurVar[1,index] := (y-1712.9242 )/ 6.024724314;
         inc(index);
      end;
      xold := x;
      except
          // Pour éliminer les lignes bizarres SK
          readln(fichierCCD);
      end;
   until (index>=2048);
   pages[pageCourante].nmes := index-1;
end;

var ligne : string;
begin
   result := ajoutePage;
   if not result then exit;
   try
      flush_lines(3);
      readln(fichierCCD,ligne);
// Ligne 4 : %%Creator:(c)1991,93,94 G.Lauret
      if pos('Lauret',ligne)=0 then begin
         result := false;
         showMessage('Ce n''est pas un fichier CCD');
         exit;
      end;
      flush_lines(15);
      readarray;
      result := true;
   except
      result := false;
   end;
end; // LitPageCCD


function litFichierCCD(const NomFichier : string) : boolean;

(* Programme pour convertir les données produites par le logiciel DOS
   du Moniteur CCD Micrélec en fichier Régressi.
   Utiliser la fonction d'impression du logiciel, ce qui produit un EPS.
   Ce programme lit les coordonnées PostScript des points du graphes et
   les convertit en abscisses et ordonnées mathématiques.
*)
begin
  strErreurFichier := erFileLoad;
  FileMode := fmOpenRead;
  try
   Assign(fichierCCD,NomFichier);
   Reset(fichierCCD);
   ModeAcquisition := AcqFichier;
   AjouteExperimentale('x',variable);
   grandeurs[0].fonct.expression := 'Abscisse (index)';
   grandeurs[0].nomUnite := '';
   AjouteExperimentale('L',variable);
   grandeurs[1].fonct.expression := 'Luminance';
   grandeurs[1].nomUnite := '';
   result := litPageCCD;
   CloseFile(fichierCCD);
  except
      result := false;
  end;
  FileMode := fmOpenReadWrite;
end; // LitFichierCCD

Function AjouteFichierCCD(const NomFichier : String) : boolean;
begin
     try
     strErreurFichier := erFileLoad;
     FileMode := fmOpenRead; // protection contre lecture seule
     Assign(fichierCCD,NomFichier);
     Reset(fichierCCD);
     result := litPageCCD;
     CloseFile(fichierCCD);
     except
        result := false;
     end;
     FileMode := fmOpenReadWrite;
end;

function LitFichierVotable(const NomFichier : String;const NouveauFichier : boolean) : boolean;

const
  maxVotable = 32;
type
  tVotable = (vChar,vDouble,vCharDate,vCharAngle,vCharheure,vInteger,vBoolean);
  formatData = record
     name : string;
     nameR : string;
     signif : string;
  end;
var
  TypeColonne : array[0..maxVotable] of TVotable;
  formatISO : TFormatSettings;
  commentaire,target : string;
  angulaireGlb : boolean;
  iX,iY,iLongitude,iDateTexte,iDistance,iTarget,iTemps : integer;
//  iRiseTime,iRizeAzimuth,iTransitTime,iTransitAzimuth,iSetTime,iSetAzimuth : integer;
(*
name="Date" ucd="time.epoch" datatype="char"
name="Rise Time" ucd="time.epoch" datatype="float" unit="h"
name="Rise Azimuth" ucd="pos.az.azi" datatype="float" unit="deg"
name="Transit Time" ucd="time.epoch" datatype="float" unit="h"
name="Transit Elevation" ucd="pos.az.alt" datatype="float" unit="deg"
name="Set Time" ucd="time.epoch" datatype="float" unit="h"
name="Set Azimuth" ucd="pos.az.azi" datatype="float" unit="deg"
*)
  DecodeVariab : array[0..maxVotable] of integer;
  t0 : double;

const
Nvisibilite = 6;

FormatVisibilite : array[0..Nvisibilite] of formatData =
(
(name : 'Date'; nameR : 'Date'; signif : 'Date'),
(name : 'Rise Time';nameR : 'tLever'; signif : 'instant de lever du soleil'),
(name : 'Rise Azimuth';nameR : 'aLever'; signif : 'azimuth lever du soleil'),
(name : 'Transit Time';nameR : 'tMeridien'; signif : 'instant de passage au méridien du soleil'''),
(name : 'Transit Elevation';nameR : 'eMeridien'; signif : 'élévation du soleil'),
(name : 'Set Time'; nameR : 'tCoucher'; signif : 'instant de coucher du soleil'),
(name : 'Set Azimuth';nameR : 'aCoucher'; signif : 'azimuth coucher du soleil')
);

Function RecupereAngle(const chaine : string) : double;
var N : integer;
    c : integer;
    items : array[1..3] of string;
begin
    for N := 1 to 3 do Items[N] := '';
    N := 1;
    c := 1;
    repeat
       if charInSet(chaine[c],['0'..'9','E','.','-','+'])
          then Items[N] := Items[N] + chaine[c]
          else if CharInSet(chaine[c],[crTab,' ','|']) and
                  (Items[N]<>'') then inc(N);
       inc(c);
    until (N=4) or (c>length(chaine));
    result := StrToFloatSex(Items[1],Items[2],Items[3]);
end;

Function RecupereDate(const chaine : string) : double;
var dateStr,heureStr : string;
    posT : integer;
begin
    posT := pos('T',chaine);
//    dateStr := DateToStr(now);
//    heureStr := '00:00:00';
    if posT>0 then begin
       DateStr := copy(chaine,1,posT-1);
       trimASCII127(dateStr);
       HeureStr := copy(chaine,posT+1,length(chaine)-posT);
       posT := pos('.',HeureStr);
       if posT>0 then delete(heureStr,posT,length(HeureStr));
       result := double(StrToDate(dateStr,FormatISO))+double(StrToTime(heureStr));
    end
    else begin
         DateStr := chaine;
         result := double(StrToDate(dateStr,FormatISO));
    end;
  //  result := double(StrToDate(dateStr,FormatISO))+double(StrToTime(heureStr));
end;

Function recupereHeure(chaine : string) : double;
var posPoint,posPointSuivant : integer;
    compteur : integer;
begin
     posPoint := pos('.',chaine);
     if posPoint>0 then delete(chaine,posPoint,length(chaine)-1);
// on ôte les centième de seconde
     repeat
         posPoint := pos(' ',chaine);
         if posPoint=1 then delete(chaine,1,1);
     until (posPoint>1) or (posPoint=0);
// on ôte les blanc d'en-tête
     compteur := 0;
     repeat
       posPoint := pos(' ',chaine);
       if posPoint>0 then begin
          chaine[posPoint] := ':';
          inc(compteur);
          posPointSuivant := pos(' ',chaine);
          if posPointSuivant=posPoint+1 then chaine[posPointSuivant] := '0';
       end;
     until (posPoint=0); // on remplace blanc par : et double espace par :0
     if compteur<2 then chaine := '0:'+chaine;  // pas d'heure = heure 0
     // angle exprimée en heure transformé en degré
     result := Double(strToTime(chaine));
     result := result*360.0;
end;

procedure setGraphe;

Procedure AjouteOptionRect;
begin
if (iX=0) or (iY=0) then exit;
with FgrapheVariab.graphes[1] do begin
     Coordonnee[1].nomX := grandeurs[iX].nom;
     if iDateTexte>0 then Coordonnee[2].nomX := grandeurs[iX].nom;
     Coordonnee[1].nomY := grandeurs[iY].nom;
     if iDateTexte>0 then Coordonnee[2].nomY := grandeurs[iDateTexte].nom;
     include(OptionGraphe,OgOrthonorme);
     exclude(OptionGraphe,OgPolaire);
     FgrapheVariab.configCharge := true;
     FgrapheVariab.majFichierEnCours := true;
end end;

Procedure AjouteOptionAngle;
begin
if (iLongitude=0) or (iDistance=0) then exit;
with FgrapheVariab.graphes[1] do begin
     Coordonnee[1].nomX := grandeurs[iLongitude].nom;
     if iDateTexte>0 then Coordonnee[2].nomX := grandeurs[iLongitude].nom;
     Coordonnee[1].nomY := grandeurs[iDistance].nom;
     if iDateTexte>0 then Coordonnee[2].nomY := grandeurs[iDateTexte].nom;
     include(OptionGraphe,OgOrthonorme);
     include(OptionGraphe,OgPolaire);
     FgrapheVariab.configCharge := true;
     FgrapheVariab.majFichierEnCours := true;
end end;

begin
  if angulaireGlb then ajouteOptionAngle else ajouteOptionRect;
end;

var
colC,rowC : integer;

procedure LoadXMLInReg(XMLNode: IXMLNode;fieldEnCours : boolean);
var
i,j: Integer;
AttributNoeud: IXMLNode;
isField : boolean;
isParam : boolean;
isLigne : boolean;
isInfo : boolean;
valeurStr : string;
lNomUnite : string;
nomMaj : string;
indexGrandeur : integer;
valeurDate : double;
begin //Les noeuds internes sont traitées récursivement
if XMLNode.NodeType <> ntElement then Exit; //S'il s'agit d'une feuille
if (XmlNode.NodeName='vot:FRESOURCE') then ; // cébut des données
isParam := (XmlNode.NodeName='vot:PARAM');
isField := (XmlNode.NodeName='vot:FIELD');
if isField and nouveauFichier then AjouteExperimentale('xxxx',variable);
if (XMLNode.NodeName='vot:TABLEDATA') then begin // début de table
   colC := 0;
   rowC := 0;
   ajoutePage;
end;
isLigne := XmlNode.NodeName='vot:TR'; // une ligne de données
if isLigne then
   pages[pageCourante].nmes := pages[pageCourante].nmes + 1;

if (XmlNode.NodeName='vot:TD') then begin // une valeur
   valeurStr := XMLNode.NodeValue;
   indexGrandeur := decodeVariab[colC];
   if (colC=iTarget) and (typeColonne[colC]=vChar) then Target := valeurStr;
   if indexGrandeur<>grandeurInconnue then
      case typeColonne[colC] of
        vChar : pages[pageCourante].texteVar[indexGrandeur,rowC] := valeurStr;
        vDouble : begin
            pages[pageCourante].valeurVar[indexGrandeur,rowC] := strToFloatWin(valeurStr);
            if grandeurs[indexGrandeur].nom='Date' then begin
               valeurDate := DateUtils.JulianDateToDateTime(pages[pageCourante].valeurVar[indexGrandeur,rowC]);
               if nouveauFichier
                  then pages[pageCourante].valeurVar[indexGrandeur,rowC] := valeurDate
                  else begin // 'Date' texte ; 't' durée
                     pages[pageCourante].texteVar[indexGrandeur,rowC] := FormatDateTime('dd mmm yyyy',valeurDate);
                     if rowC=0 then t0 := valeurDate;
                     valeurDate := valeurDate-t0;
                     if iTemps<>grandeurInconnue
                        then pages[pageCourante].valeurVar[iTemps,rowC] := valeurDate;
                  end;
            end;
        end;
        vCharDate : begin
            valeurDate := recupereDate(valeurStr);
            pages[pageCourante].valeurVar[indexGrandeur,rowC] := valeurDate;
            if not nouveauFichier and (grandeurs[indexGrandeur].nom='Date') then begin
                  // 'Date' texte ; 't' durée
                pages[pageCourante].texteVar[indexGrandeur,rowC] := FormatDateTime('dd mmm yyyy',valeurDate);
                if rowC=0 then t0 := valeurDate;
                   valeurDate := valeurDate-t0;
                   if iTemps<>grandeurInconnue
                      then pages[pageCourante].valeurVar[iTemps,rowC] := valeurDate;
            end;
        end;
        vCharAngle : pages[pageCourante].valeurVar[indexGrandeur,rowC] := recupereAngle(valeurStr);
        vCharHeure : pages[pageCourante].valeurVar[indexGrandeur,rowC] := recupereHeure(valeurStr);
      end;
   inc(colC);
end;

if (XmlNode.NodeName='vot:DESCRIPTION') and FieldEnCours then
   if nouveauFichier then begin
      grandeurs[colC].fonct.expression := XMLNode.NodeValue;
      if pos('ISO',XMLNode.NodeValue)>0 then begin
        typeColonne[colC] := vCharDate;
        grandeurs[colC].formatU := fDate;
      end;
      if XMLNode.NodeValue='Date' then begin
        typeColonne[colC] := vCharDate;
        grandeurs[colC].formatU := fDate;
      end;
      if (typeColonne[colC]=vChar)
        then grandeurs[colC].fonct.genreC := g_texte;
   end
   else begin
       if pos('ISO',XMLNode.NodeValue)>0 then typeColonne[colC] := vCharDate;
   end;

//S'il y a des attributs on les ajoute...
isInfo := false;
for I := 0 to XMLNode.AttributeNodes.Count - 1 do begin
AttributNoeud := XMLNode.AttributeNodes.Nodes[I];
if isParam then begin
   if AttributNoeud.NodeName='ID' then begin
      if AttributNoeud.Text='coordinates' then isInfo := true;
      if AttributNoeud.Text='framecentre' then isInfo := true;
      if AttributNoeud.Text='targetname' then isInfo := true;
   end;
   if (AttributNoeud.NodeName='value')  and isInfo then
      if commentaire=''
         then Commentaire := AttributNoeud.Text
         else Commentaire := Commentaire + ' - ' + AttributNoeud.Text;
end;
if isField then begin
   if AttributNoeud.NodeName='name' then begin
      if nouveauFichier then begin
        grandeurs[colC].nom := AttributNoeud.Text;
        for j := 0 to Nvisibilite do
            if AttributNoeud.Text=formatVisibilite[j].name then begin
               grandeurs[colC].nom := formatVisibilite[j].nameR;
               grandeurs[colC].fonct.expression := formatVisibilite[j].signif;
            end;
        nomMaj := UpperCase(grandeurs[colC].nom);
        if pos('LONG',NomMaj)>0 then iLongitude := colC;
        if NomMaj='X' then iX := colC;
        if NomMaj='Y' then iY := colC;
        if (NomMaj='DOBS') or (pos('DIST',NomMaj)>0 ) then iDistance := colC;
      end
      else begin
        decodeVariab[colC] := indexNomVariab(AttributNoeud.Text);
      end;
      if AttributNoeud.Text='Target' then iTarget := colC;
   end;
   if AttributNoeud.NodeName='unit' then begin
      if AttributNoeud.Text='"h:m:s"' then begin
         typeColonne[colC] := vCharHeure;
         if nouveauFichier then grandeurs[colC].nomUnite := '°';
      end;
      if AttributNoeud.Text='"d:m:s"' then begin
         typeColonne[colC] := vCharAngle;
         if nouveauFichier then grandeurs[colC].nomUnite := '°';
         angulaireGlb := true;
      end;
      if typeColonne[colC]=vDouble then begin
         lNomUnite := AttributNoeud.Text;
         if lNomUnite='deg' then lNomUnite := '°';
         if lNomUnite='au' then lNomUnite := 'ua';
         if nouveauFichier then grandeurs[colC].nomUnite := lNomUnite;
      end;
   end;
   if AttributNoeud.NodeName='datatype' then begin
      if AttributNoeud.Text='char' then typeColonne[colC] := vChar;
      if AttributNoeud.Text='unicodechar' then typeColonne[colC] := vChar;
      if AttributNoeud.Text='double' then typeColonne[colC] := vDouble;
      if AttributNoeud.Text='float' then typeColonne[colC] := vDouble;
      if AttributNoeud.Text='short' then typeColonne[colC] := vInteger;
      if AttributNoeud.Text='long' then typeColonne[colC] := vInteger;
      if AttributNoeud.Text='int' then typeColonne[colC] := vInteger;
      if AttributNoeud.Text='boolean' then typeColonne[colC] := vBoolean;
   end;
end;
end;

//si le noeud courant a des noeuds enfants, on les ajoute
if XMLNode.HasChildNodes then
for I := 0 to XMLNode.ChildNodes.Count - 1 do
    LoadXMLInReg(XMLNode.ChildNodes.Nodes[I],isField); // description de field
if isLigne then begin // ligneSuivante
   inc(rowC);
   colC := 0;
end;
if isField then inc(colC); // colonneSuivante
end; // LoadXMLInReg

var XMLDoc : TXMLDocument;
    i,k : integer;
begin // litFichierVotable
if nouveauFichier
   then begin
      for i := 0 to maxVotable do DecodeVariab[i] := i;
      iTemps := grandeurInconnue;
   end
   else begin
      for i := 0 to maxVotable do DecodeVariab[i] := grandeurInconnue;
      iTemps := indexNomVariab('t');
   end;
iTarget := -1;
target := '';
ModeAcquisition := AcqFichier;
angulaireGlb := false;
for i := 0 to maxVotable do typeColonne[i] := vChar;
XMLDoc := TXMLDocument.Create(application.MainForm);
try
XmlDoc.FileName := NomFichier;
if (XmlDoc.DOMVendor=nil) and (DomVendors.count>0)
    then XmlDoc.DOMVendor := DomVendors.Vendors[0];
XMLDoc.Active := True;
colC := 0;
rowC := 1;
formatISO := TFormatSettings.Create('ISO');
formatISO.DateSeparator := '-'; // ISO
formatISO.ShortDateFormat := 'yyyy-MM-dd';
if (XMLDoc.DocumentElement.NodeType=ntElement) and
   (XMLDoc.DocumentElement.NodeName='vot:VOTABLE')
   then begin
      LoadXMLInReg(XMLDoc.DocumentElement,false);
      result := true;
      pages[pageCourante].CommentaireP := Commentaire;
      for k := 0 to 1 do
        if grandeurs[k].nom='Date' then begin
           grandeurs[k].nom := 't';
           grandeurs[k].nomUnite := 'jour';
           grandeurs[k].formatU := fDefaut;
           iDateTexte := ajouteExperimentale('Date',variable);
           grandeurs[iDateTexte].fonct.genreC := g_texte;
           with pages[pageCourante] do begin
             t0 := valeurVar[k,0];
             for i := 0 to nmes-1 do  begin
               texteVar[iDateTexte,i] := FormatDateTime('dd mmm yyyy',valeurVar[k,i]);
               valeurVar[k,i] := valeurVar[k,i]-t0;
             end;
           end;
           break;
        end;
      for k := 0 to 1 do
        if grandeurs[k].nom='Target' then begin
           supprimeGrandeurE(k);
           break;
        end;
      if nouveauFichier then setGraphe;
   end
   else begin
      result := false;
      strErreurFichier := erReadVotable;
   end;
except
    strErreurFichier := erReadFile;
    if XmlDoc.DOMVendor=nil then strErreurFichier := erDOMXML;
    result := false;
    resetEnTete;
end;
end; // litFichierVotable

// pour fichiers HDF .h5
var nomGroupes : TStringList;
    nomData : TStringList;
    NumPoints,pas : integer;
    Xinc,X0 : double;
    Xunit,Yunit : string;
    H5: THDF5Dll;
    H5Charge : boolean;

type
   PopData = ^Topdata;
   Topdata = record
      recurs : Cardinal; // Recursion level  0=root
      Faddr : haddr_t;  // Group address
      nom : string;
   end;

(* Operator function.  This function prints the name and type of the object passed to it.
  If the object is a group, it is first checked against other groups in its path using
  the group_check function, then if it is not a duplicate, H5Literate is called for that group.
  This guarantees that the program will not enter infinite recursion due to a
  circular path in the file.
*)

function InitHDF : boolean;

procedure Erreur(erreurDll : boolean);
begin
    H5charge := false;
    Aide(Help_FichierOuvrir);
end;

var NomhdfDll : string;
begin
   if not H5Charge then begin
      NomHdfdll := extractFilePath(Application.exeName)+'hdf5.dll';
      if fileExists(NomhdfDll) then begin
         try
         H5 := THDF5Dll.create(NomhdfDll);
         H5charge := true;
         except
         erreur(false);
         end;
      end
      else erreur(true);
   end;
   result := H5Charge;
end;


function attr_info(loc_id : hid_t; name : PAnsiChar;ainfo : PH5A_info_t; opdata : Pointer) : herr_t; cdecl;
var
    attr, atype, aspace : hid_t; // Attribute, datatype and dataspace identifiers
    rank : integer;
    sdim : array[0..63] of hsize_t;
    npoints : size_t; // Number of elements in the array attribute
    float_array : array of double; // Pointer to the array attribute
    int_array : array of integer; // Pointer to the array attribute
    aClasse : H5T_class_t;
    string_out : PAnsiChar;
    astring : string;
    int_out : integer;
    float_out : double;

(*
WaveForms/Channel 1
Count I32
MaxBandwidth F64
MinBandwidth F64
NumPoints I32
NumSegments I32
Start I32
WaveformType E8
XDispOrigin F64
XDispRange F32
XInc F64
XOrg F64
XUnits String32
YDispOrigin F64
YDispRange F32
*)

(*
Waveforms
NumWaveforms I32

FileType
AgilentH5FileType  : agilent Waveform

Frame
DateTime
ModelNumber
SerialNumber
SoftwareVersion
*)

begin
    // Open the attribute using its name
    attr := H5.H5Aopen(loc_id, name, H5P_DEFAULT);
    // Display attribute name
    // Get attribute datatype, dataspace, rank, and dimensions
    atype  := H5.H5Aget_type(attr);
    aspace := H5.H5Aget_space(attr);
    rank := H5.H5Sget_simple_extent_ndims(aspace);
    result := H5.H5Sget_simple_extent_dims(aspace, @sdim, nil);
    //  Display rank and dimension sizes for the array attribute
    aClasse := H5.H5Tget_class(atype);
    case aClasse of
        H5T_NO_CLASS:; // error
        H5T_INTEGER:case rank of
           0: begin
              result := H5.H5Aread(attr, atype, @int_out);
              if (result>=0) and (name='NumPoints') then begin
                 NumPoints := int_out;
                 pas := (NumPoints div 65536) + 1;
              end;
           end;
           1: begin
              npoints := H5.H5Sget_simple_extent_npoints(aspace);
              setLength(int_array,npoints);
              result := H5.H5Aread(attr, atype, int_array);
              finalize(int_array);
           end;
        end;// integer types
        H5T_FLOAT: case rank of
            0 : begin
               result := H5.H5Aread(attr, atype, @float_out);
               if (result>=0) then begin
                  if name='XInc' then Xinc := float_out;
                  if (name='XOrg') and (X0=0) then X0 := float_out;// XDispOrigin prioritaire
                  if name='XDispOrigin' then X0 := float_out;
                  // if name='XDispRange' then ;
                  // 64 bits MaxBandwidth ; MinBandwidth ; XDispOrigin ; XInc ; XOrg ; YDispOrigin
                  // 32 bits XDispRange ; YDispRange
               end;
            end;
            1 : begin
               npoints := H5.H5Sget_simple_extent_npoints(aspace);
               setLength(float_array,npoints);
               result := H5.H5Aread(attr, atype, float_array);
               finalize(float_array);
            end;
        end;  // floating-point types
        H5T_TIME :; // date and time types
        H5T_STRING :begin
            GetMem(string_out,64);
            result := H5.H5Aread(attr, atype, string_out);
            if (result>=0) then begin
               aString := string(system.ansiStrings.strPas(string_out));
               if name='XUnits' then Xunit := aString;
               if name='YUnits' then Yunit := aString;
            end;
        end; // character string types
        H5T_BITFIELD :; // bit field types
        H5T_OPAQUE :; // opaque types
        H5T_COMPOUND :; // compound types
        H5T_REFERENCE :; // reference types
        H5T_ENUM : begin // WaveformType
        end; // enumeration types
        H5T_VLEN :; // Variable-Length types
        H5T_ARRAY :; // Array types
        H5T_NCLASSES :;
    end;
    // Release all identifiers.
    H5.H5Tclose(atype);
    H5.H5Sclose(aspace);
    H5.H5Aclose(attr);
end;

function group_info(loc_id : hid_t;name : PAnsiChar; info : PH5L_info_t; operator_data : Pointer) : herr_t; cdecl;
var infobuf : H5O_info_t;
    od,nextod : Topdata; // Type conversion
    spaces : string;
    k : integer;
begin
// Get type of the object and display its name and type.
// The name of the object is passed to this function by the Library.
    od := TopData(operator_data^);
    spaces := '';
    for k := 1 to 3*(od.recurs+1) do
        spaces := spaces+' ';
    result := H5.H5Oget_info_by_name(loc_id, name, @infobuf, H5P_DEFAULT);
    if result<0 then exit;
    case infobuf.typ of
         H5O_TYPE_GROUP: begin
//  Check group address against linked list of operator data structures.
//  We could use H5Lget_info and never recurse on groups discovered by symbolic links;
//  Initialize new operator data structure and begin recursive iteration on the discovered group.
//  The new Topdata structure is given a pointer to the current one.
             nextod.recurs := od.recurs + 1;
             nextod.Faddr := infobuf.addr;
             nextod.nom := od.nom+'/'+string(system.ansiStrings.strPas(name));
             nomGroupes.add(nextod.nom);
             result := H5.H5Literate_by_name(loc_id, name, H5_INDEX_NAME,
                           H5_ITER_NATIVE, nil, group_info, @nextod,
                           H5P_DEFAULT);
        end;
        H5O_TYPE_DATASET:  begin
           nextod.nom := od.nom+'/'+string(system.ansiStrings.strPas(name));
           nomData.add(nextod.nom);
        end;
        H5O_TYPE_NAMED_DATATYPE: ;
        H5O_TYPE_UNKNOWN: ;  // Unknown object type
        H5O_TYPE_NTYPES: ; // Number of different object types (must be last!)
        else result := -1;
    end;
end;

Function LitFichierH5(const NomFichier : String) : boolean;
var fileid : hid_t;  // File identifier

function lectureValeur(const nomD : string) : herr_t;
var dataset_id: hid_t; // data identifier
    data: array of single;
    i,index: integer;
    aPAnsiChar: PAnsiChar;
begin
// Open an existing dataset
   aPAnsiChar := PAnsiChar(AnsiString(nomD));
   dataset_id := H5.H5Dopen2(fileid,aPAnsiChar, H5P_DEFAULT);
   setLength(data,Puiss2Sup(NumPoints)); // avec le "vrai" numpoints il peut y avoir des pb ?!
   result := H5.H5Dread(dataset_id, H5.H5T_NATIVE_FLOAT, H5S_ALL, H5S_ALL, H5P_DEFAULT, data);
   if (result>=0) then begin
      index := AjouteExperimentale('V'+IntToStr(NbreVariab),variable);
      grandeurs[index].fonct.expression := 'tension';
      grandeurs[index].nomUnite := 'V';
      for i := 0 to (NumPoints div pas)-1 do
         pages[pageCourante].ValeurVar[index,i] := data[i*pas];
   end;
   Finalize(data);
// Close the dataset
   result := H5.H5Dclose(dataset_id);
end;

function lectureStructure : herr_t;
var
    infobuf: H5O_info_t;
    od : Topdata;
begin
    result := H5.H5Oget_info(fileid, @infobuf);
    if (result>=0) then begin
       od.recurs := 0;
       od.Faddr := infobuf.addr;
       od.nom := '';
       result := H5.H5Literate(fileid, H5_INDEX_NAME, H5_ITER_NATIVE, nil, group_info,@od);
    end;
end;

procedure lectureAttribut(const nomG : string);
var
   dataset : hid_t;     // dataset identifier
   ret : herr_t;        // Return value
   aPAnsiChar : PAnsiChar;
   i : integer;
begin
   aPAnsiChar := PAnsiChar(AnsiString(nomG));
   // Open an existing group
   dataset := H5.H5Gopen2(fileid,aPAnsiChar,H5P_DEFAULT);
   // Get attribute info using iteration function
   ret := H5.H5Aiterate2(dataset, H5_INDEX_NAME, H5_ITER_INC, nil, attr_info, nil);
   if (ret>=0) and (NumPoints>0) and (NbreVariab=0) and (Xinc>0) then begin // base de temps
      AjouteExperimentale('t',variable);
      grandeurs[0].fonct.expression := 'temps';
      grandeurs[0].nomUnite := 's';
      ajoutePage;
      pages[pageCourante].nmes := NumPoints div pas;
      for i := 0 to (NumPoints div pas)-1 do
          pages[pageCourante].ValeurVar[0,i] := X0+i*Xinc*pas;
   end;
   // Close the dataset
   H5.H5Gclose(dataset);
end;

var aPAnsiChar : PAnsiChar;
    i : integer;
begin  // LitFichierH5
    result := false;
    if not initHDF then exit;
    nomGroupes := TStringList.create;
    nomData := TStringList.create;
    NumPoints := 0;
    pas := 1;
    Xinc := 0;
    X0 := 0;
    try
   // Open file
    aPAnsiChar := PAnsiChar(AnsiString(nomFichier));
    fileid := H5.H5Fopen(aPAnsiChar, H5F_ACC_RDONLY, H5P_DEFAULT);
    lectureStructure;
    for i := 0 to pred(nomGroupes.count) do
        lectureAttribut(nomGroupes[i]);
    for i := 0 to pred(nomData.count) do
        lectureValeur(nomData[i]);
    H5.H5Fclose(fileid); // Close file plante ?
    finally
      nomGroupes.Free;
      nomData.Free;
    end;
    result := (pageCourante>0) and (pages[pageCourante].nmes>0);
end; // LitFichierH5

Procedure VerifKilo(var exp : String);

function textePrefixe(pref : char) : String;
begin
case pref of
     'p' : textePrefixe := 'E-12';
     'n' : textePrefixe := 'E-9';
     'µ' : textePrefixe := 'E-6';
     'm' : textePrefixe := 'E-3';
     'k' : textePrefixe := 'E+3';
     'M' : textePrefixe := 'E+6';
     'G' : textePrefixe := 'E+9';
     else textePrefixe := '';
end end;

var j : integer;
begin
    j := 2;
    while j<=length(exp) do begin
        if charinset(exp[j],caracPrefixe) and
           charinset(exp[pred(j)],chiffre) then begin
             insert(textePrefixe(exp[j]),exp,succ(j));
             delete(exp,j,1);
             inc(j,3);
        end;
        inc(j);
    end;
end;

Function litFichierDos(const NomFichier : String) : boolean;
// Lecture des fichiers rrr
var
    FichierRegDos : text;
    LigneTampon : string;
    FinFichierRegDos : boolean;

procedure litLigneRegDos;
var Ligne : shortString;

Function DosVersWindows(s : ShortString) : string;

Function NouveauCode(c : byte) : char;
begin
   case c of
      129 : result := 'ü';
      130 : result := 'é';
      131 : result := 'â';
      132 : result := 'ä';
      133 : result := 'à';
      135 : result := 'ç';
      136 : result := 'ê';
      137 : result := 'ë';
      138 : result := 'è';
      139 : result := 'ï';
      140 : result := 'î';
      147 : result := 'ô';
      148 : result := 'ö';
      150 : result := 'û';
      151 : result := 'ù';
      156 : result := '£';
      159 : result := 'Ÿ';
      224 : result := alpha;
      225 : result := beta;
      226 : result := gammaMaj;
      227 : result := piMin;
      228 : result := sigmaMaj;
      229 : result := sigmaMin;
      230 : result := 'µ';
      231 : result := tau;
      232 : result := PhiMaj;
      233 : result := theta;
      234 : result := omegaMaj;
      235 : result := deltaMin;
      236 : result := 'i';
      237 : result := 'o';
      238 : result := epsilon;
      241 : result := '±';
      248 : result := '°';
      251 : result := '£';
      else result := ' ';
   end;
end;
var i : integer;
begin
     result := '';
     for i := 1 to length(s) do
         if (s[i]>#127)
            then result := result + NouveauCode(ord(s[i]))
            else result := result+char(s[i])
end;

begin
   try
   finFichierRegDos := finFichierRegDos or eof(fichierRegDos);
   if finFichierRegDos
      then ligneTampon := ''
      else begin
   	      readln(FichierRegDos,ligne);
   	      ligneTampon := DosVersWindows(Ligne);
          finFichierRegDos := eof(fichierRegDos);
      end;
   except
        FinFichierRegDos := true;
        ligneTampon := '';
   end;
end;

Function NombreLigneFichier : integer;
var fin : byte;
    StValeur : string;
begin
     fin := 2;
     while (ligneTampon[fin]>='0') and
     	   (ligneTampon[fin]<='9') do inc(fin);
     stValeur := copy(ligneTampon,2,fin-2);
     try
     NombreLigneFichier := StrToInt(stValeur)
     except
        on EConvertError do NombreLigneFichier := 0
     end
end;

Procedure LitPageCourante;
type TVecteurDos = array[0..16] of double;

Procedure ExtraitBornes(var A : tableauBornes);
var j,debut,i : byte;
begin
    litLigneRegDos;
    i := 0;j := 0;
    try
    repeat
        inc(i);
        repeat inc(j)
        until not charInset(ligneTampon[j],Separateur);
        debut := j;
        while charInSet(ligneTampon[j],chiffreEtc) do inc(j);
        A[i] := strToInt(copy(ligneTampon,debut,j-debut));
        dec(A[i]); // début à 0
    until (i=maxIntervalles) or (j>=length(ligneTampon));
    finally
        litLigneRegDos
    end;
end; // extraitBornes

Procedure ExtraitTableau(var AA : TvecteurDos;maxi : integer;var i : integer);
var j,debut : byte;
    ChaineTampon : string;
    ii : integer;
begin
    i := 0;j := 1;
    try { erreur de conversion }
    while (j<Length(LigneTampon)) and (i<maxi) do begin
    	while (j<Length(LigneTampon)) and charInSet(ligneTampon[j],Separateur) do inc(j);
    	debut := j;
    	while (j<=Length(LigneTampon)) and charInSet(ligneTampon[j],chiffreEtc) do inc(j);
    	chaineTampon := copy(ligneTampon,debut,j-debut);
        AA[i] := StrToFloatWin(chaineTampon);
        inc(i);
    end;
// (i>=maxi) or (j>=longueur) or (erreur de conversion)
    except
       on EConvertError do for ii := i to pred(maxi) do AA[i] := Nan;
    end;
    litLigneRegDos
end; // extraitTableau

Procedure ExtraitTableauVar;
var i,NbreLu : integer;
    vect : TvecteurDos;
    pageFini,ligneFin : boolean;
begin with pages[pageCourante] do begin
  nmes := 0;
  litLigneRegDos;
  Repeat
	extraitTableau(vect,NbreVariab,NbreLu);
	pageFini := NbreLu=0;
	if not pageFini then begin
	      for i := 0 to pred(NbreVariab) do
                      valeurVar[i,nmes] := Vect[i];
	      nmes := nmes+1;
	end;
  ligneFin := (length(ligneTampon)>0) and
              ((ligneTampon[1]=symbReg) or
               (ligneTampon[1]=#127));
	pageFini := pageFini or ligneFin or finFichierRegDos;
  until pageFini;
  FinFFT := Nmes;
  DebutFFT := 0;
end end; // extraitTableauVar

Procedure LitVal;
var valeur : TvecteurDos;
    NbreLu,i,Nligne : integer;
begin with pages[pageCourante] do begin
     Nligne := nombreLigneFichier;
     if Pos('CONST',ligneTampon)<>0 then begin
    	 litLigneRegDos;
    	 extraitTableau(valeur,NbreConst,NbreLu);
         for i := 0 to pred(NbreConst) do
             valeurConst[NbreVariab+i] := valeur[i];
    	 exit
     end;
     if pos('DEBUT',ligneTampon)<>0 then begin
         extraitBornes(debut);
         exit
     end;
     if pos('FIN',ligneTampon)<>0 then begin
         extraitBornes(fin);
         exit
     end;
     if (Pos('PARAM',ligneTampon)<>0) and
        (Pos('VAL',ligneTampon)<>0) then begin
    	    litLigneRegDos;
    	    extraitTableau(valeur,maxParametres,NbreLu);
            for i := 0 to pred(NbreLu) do
                valeurParam[paramNormal,succ(i)] := valeur[i];
    	    exit
     end;
     for i := 0 to Nligne do litLigneRegDos;
end end; // litVal

begin with pages[pageCourante] do begin
  commentaireP := ligneTampon;
  if (length(commentaireP)>0) and (commentaireP[1]=chr(127)) then Delete(commentaireP,1,1);
  extraitTableauVar;
  while (length(ligneTampon)>0) and (ligneTampon[1]=symbReg) do
	litVal;
end end;// litPageCourante

var NomPrime,NomNew : array[1..4] of string;
    NbrePrime : integer;
// Nom DOS du type x'

Procedure extraitNom(var nom : string;var vide : boolean);
var fin : byte;
begin
    nom := '';
    vide := true;
    while ( Length(LigneTampon)>0 ) and
     	  not isLettre(LigneTampon[1])
     		  do Delete(ligneTampon,1,1);
    if (Length(LigneTampon)>0) and isLettre(ligneTampon[1]) then begin
	    fin := 1;
 	    repeat inc(fin)
 	    until (fin>Length(LigneTampon)) or
 		     not isCaracGrandeur(ligneTampon[fin]);
 	    nom := copy(ligneTampon,1,pred(fin));
 	    Delete(ligneTampon,1,fin);
      fin := pos('''',nom);
      if fin>0 then begin
             afficheErreur(erPrimeRRR,0);
             inc(NbrePrime);
             NomPrime[NbrePrime] := nom;
             nom[fin] := 'p';
             NomNew[NbrePrime] := nom;
      end;
 	    vide := false;
    end;
end;

var
    deriveeGraphe,variableGraphe,fonctionGraphe,parametreGraphe : string;
    parametrique : boolean;

Procedure litExpression(imax : integer);
var i : integer;

Procedure AjouteNom;
begin
     Fvaleurs.memo.lines.Add(grandeurs[i].nom+'='+ligneTampon)
end;

Procedure CompileIntegraleOld;
var position : byte;
begin
     position := Pos(' ',ligneTampon);
     Delete(ligneTampon,position,1);
     Insert(',',ligneTampon,position);
     LigneTampon := nomFonctionGlb[integrale]+'('+ligneTampon+')';
     ajouteNom;
     grandeurs[i].fonct.genreC := g_integrale;
end;

Procedure compileDeriveeOld;
var position : byte;
// expr = d(y)/d(x) devient diff(y,x)
begin
     Delete(ligneTampon,1,1); // enlève d
     LigneTampon := nomFonctionGlb[derivee]+ligneTampon; // remplace par DIFF
     position := Pos(')',ligneTampon);
     Delete(ligneTampon,position,4);{ )/d( }
     Insert(',',ligneTampon,position);// remplacé par ,
     AjouteNom;
     grandeurs[i].fonct.genreC := g_derivee;
end;

Procedure compileEquationOld;
var position : byte;
begin
     position := Pos('=',ligneTampon);
     if position<>0 then begin
// f(x)=g(x) devient f(x)-(g(x)) sous-entendu=0
        ligneTampon[position] := '-';
        insert('(',ligneTampon,succ(position));
        ligneTampon:=ligneTampon+')';
     end;
     LigneTampon := nomFonctionGlb[equation]+'('+ligneTampon+')';
// f(x) devient solve(f(x))
     AjouteNom;
     grandeurs[i].fonct.genreC := g_forward;
end;

var choix : char;
    j,posPrime : integer;
begin
   for i := 0 to pred(imax) do begin
      if length(ligneTampon)=0
         then choix := ' '
         else begin
            choix := ligneTampon[1];
            delete(ligneTampon,1,1);
         end;
      for j := 1 to NbrePrime do
         repeat
            posPrime := pos(NomPrime[j],ligneTampon);
            if posPrime>0 then begin
               Delete(ligneTampon,posPrime,length(NomPrime[j]));
               Insert(NomNew[j],ligneTampon,posPrime);
            end;
         until posPrime=0;
      VerifKilo(ligneTampon);
      case choix of
         ' ' : ;
         '@' : begin
               ajouteNom;
               grandeurs[i].fonct.genreC := g_fonction;
         end;
         '£' : compileDeriveeOld;
         'Ÿ' : compileIntegraleOld;
           '?' : compileEquationOld;
      end;
      litLigneRegDos;
   end;
end;// litExpression

Procedure litIncertitude(imax : integer);
var i : integer;
begin
    for i := 0 to pred(imax) do begin
       if ligneTampon<>'' then begin
          grandeurs[i].incertCalcA.expression := ligneTampon;
          grandeurs[i].compileIncertitude;
       end;
       litLigneRegDos;
    end;
end;// litIncertitude

Procedure litNom(Agenre : TgenreGrandeur);
// extrait le nom des variables
var
   nomLu : string;
   fini : boolean;
   UU : tgrandeur;
begin
    repeat
       extraitNom(nomLu,fini);
       if not fini then begin
              UU := tgrandeur.Create;
              UU.Init(nomLu,'','',Agenre);
              AjouteGrandeurE(UU);
       end;
    until fini;
    litLigneRegDos;
end; // litNom

procedure litUnite(Agenre : TgenreGrandeur;imax : integer);
var i,deltaI : integer;
begin
    if Agenre=constante
        then deltaI := NbreVariab
        else deltaI := 0;
    for i := 0 to pred(imax) do begin
    	  grandeurs[i+deltaI].NomUnite := ligneTampon;
	      litLigneRegDos;
    end;
end; // litUnite

procedure litSignif(Agenre : TgenreGrandeur;imax : integer);
var i,deltaI : integer;
begin
      if Agenre=variable
         then deltaI := 0
         else deltaI := NbreVariab;
      try
      for i := 0 to pred(imax) do begin
	        if ligneTampon<>'' then
            Fvaleurs.memo.lines.Add(''''+grandeurs[i+DeltaI].nom+':'+ligneTampon);
          grandeurs[i+DeltaI].fonct.expression := ligneTampon;
	        litLigneRegDos;
      end;
      except
      end;
end; // litSignif

procedure litModelisation(imax : byte);
var i : byte;
    enTete : string;
begin
     for i := 1 to imax do begin
        if ligneTampon<>'' then begin
           if parametrique and (i=2)
              then enTete := variableGraphe
              else enTete := fonctionGraphe;
           if fonctionTheorique[1].genreC in [g_diff1,g_diff2] then
              enTete:=enTete+'''';
           if fonctionTheorique[1].genreC=g_diff2 then
              enTete:=enTete+'''';
           enTete:=enTete+'('+parametreGraphe+')=';
           enTete:=enTete+LigneTampon;
           TexteModele.add(enTete);
        end;
        litLigneRegDos;
     end;
end; // litModelisation

procedure litCFG(imax : byte);
var i : byte;
begin
     variableGraphe := ligneTampon; {1}
     litLigneRegDos;{2}
     fonctionGraphe := ligneTampon;
     litLigneRegDos;{3}
     parametreGraphe := ligneTampon;
     litLigneRegDos;{4}
     deriveeGraphe := ligneTampon; {4}
     litLigneRegDos;{5}
     litLigneRegDos;{6}
     litLigneRegDos;{7}
     litLigneRegDos;{8}
     litLigneRegDos;{9}
     case ligneTampon[1] of
        '1' : fonctionTheorique[1].genreC := g_diff1;
        '2' : fonctionTheorique[1].genreC := g_diff2;
        else fonctionTheorique[1].genreC := g_fonction;
     end;
     litLigneRegDos;{10}
     litLigneRegDos;{11}
     litLigneRegDos;{12}
     litLigneRegDos;{13}
     parametrique := ligneTampon='TRUE';
     litLigneRegDos;{14}
     AngleEnDegre := ligneTampon<>'RAD';
     litLigneRegDos;{15}
     for i := 15 to imax do litLigneRegDos;
end;// litCFG

procedure litConfiguration;
var
    codage : string;
    vide : boolean;
begin
// 1 = typeCoordonnée 3 = nbre intervalles
    case ligneTampon[3] of
        '1' : fonctionTheorique[1].genreC := g_diff1;
        '2' : fonctionTheorique[1].genreC := g_diff2;
        else fonctionTheorique[1].genreC := g_fonction;
     end;
     extraitNom(variableGraphe,vide);
     extraitNom(fonctionGraphe,vide);
     extraitNom(parametreGraphe,vide);
     extraitNom(deriveeGraphe,vide);
     extraitNom(codage,vide); // zeroXinclus
     extraitNom(codage,vide);// zeroYinclus
     extraitNom(codage,vide);// parametrique
     extraitNom(codage,vide);
     AngleEnDegre := codage='VRAI';
     litLigneRegDos;
end;// litConfiguration

Procedure litAcquisition;
var i : TmodeAcquisition;
begin
   ModeAcquisition := AcqClavier;
   for i := succ(AcqClavier) to AcqSimulation do if
       ligneTampon=NomModeAcq[i] then ModeAcquisition := AcqFichier;
   nomExeAcquisition := 'Acquisition DOS';
   litLigneRegDos
end;

procedure litListe;
var choix : byte;
    Nligne,i : byte;
begin
  choix := 0;
  if Pos('CONST',ligneTampon)<>0 then begin
      if Pos('NOM',ligneTampon)<>0 then choix := 1;
      if Pos('SIGNIF',ligneTampon)<>0 then choix := 2;
      if Pos('UNITE',ligneTampon)<>0 then choix := 6;
  end;
  if pos('CFG',ligneTampon)<>0 then choix := 8;
  if pos('CONFIG',ligneTampon)<>0 then choix := 4;
  if Pos('MODELE',ligneTampon)<>0 then choix := 5;
  if Pos('ACQUISITION',ligneTampon)<>0 then choix := 9;
  if Pos('VARIABLE',ligneTampon)<>0 then begin
     if Pos('EXPR',ligneTampon)<>0 then choix := 3;
     if Pos('UNITE',ligneTampon)<>0 then choix := 7;
     if pos('INCERT',ligneTampon)<>0 then choix := 10;
  end;
  Nligne := nombreLigneFichier;
  litLigneRegDos;
  case choix of
       0 : for i := 1 to Nligne do litLigneRegDos;
       1 : litNom(constante);
       2 : litSignif(constante,nligne);
       3 : litExpression(nligne);
       4 : LitConfiguration;
       5 : litModelisation(nligne);
       6 : litUnite(constante,Nligne);
       7 : litUnite(variable,Nligne);
       8 : litCfg(Nligne);
       9 : litAcquisition;
       10: litIncertitude(Nligne);
  end;
end; // litListe

begin
     strErreurFichier := erFileLoad;
     result := false;
     FileMode := fmOpenRead;
     Assign(fichierRegDos,NomFichier);
     Reset(fichierRegDos);
     finFichierRegDos := false;
     litLigneRegDos;
     if ( Pos('REGRESSI',ligneTampon)=0 ) or
        ( Pos('2.0',ligneTampon)=0 ) then begin
             strErreurFichier := erFormat;
             result := false;
             CloseFile(fichierRegDos);
             exit
     end;
     NbrePrime := 0;
     ModeAcquisition := AcqFichier;
     litLigneRegDos;
     Fvaleurs.memo.lines.add(''''+ligneTampon);
     litLigneRegDos;
     litNom(variable);
     if NbreGrandeurs=0 then exit;
     litSignif(variable,NbreVariab);
     while (Length(LigneTampon)>0) and
           (ligneTampon[1]=symbReg) do
               litListe;
     if not FinFichierRegDos then begin
     result := true;
     repeat
          if ajoutePage then litPageCourante;
     until FinFichierRegDos;
     end;
     if NbrePages>0 then result := true;
     CloseFile(fichierRegDos);
     FileMode := fmOpenReadWrite;
end; // LitFichierDos


(*
Function LitFichierWMF(const NomFichier : String) : boolean;
var WfmFile : TWfmFile;
    chan,len : integer;
    data : RSig; //array of single
    deltat : single;

property Info: ansiString read GetInfo;              // header info & sample statistics
    property Chan: integer read FChan write SetChan;  // current channel [zero-based]
    property Pos:  integer read GetPos write SetPos;  //   current position [samples]
    property Rate: Real read GetRate;              //   sample rate [Hz]
    property Size: integer read GetSize;              //   waveform length [samples]
    property Clip: integer read GetClip;              //   number of possibly clipped samples
    property Span: Span read GetSpan;              //   range of read samples [V]

begin
    WfmFile := TWfmFile.create(nomFichier);
    deltat := wfmFile.rate;
    for chan := 0 to 1 do begin
        wfmFile.Chan := chan;
        len := wfmFile.size;
        if len>0 then begin
           data := wfmFile.Load(len);
        end;
    end;
    result := true;
    WfmFile.free;
end;
*)

initialization
   H5Charge := false;

finalization
   if H5Charge then H5.free

end.

