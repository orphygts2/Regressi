unit regdde;
// Regressi serveur DDE pour recevoir les ordres de l'acquisition

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DdeMan, ExtCtrls, ClipBrd, Grids,
  ComCtrls, richedit, system.UITypes,
  constreg, regutil, compile, math, maths, filerrr, valeurs, graphker;

type
  TformatSepare = (sTab,sBlanc,sComma,sSemiColon);

  TFormDDE = class(TForm)
    ServeurItem: TDdeServerItem;
    ServeurDDE: TDdeServerConv;
    ClientDDE: TDdeClientConv;
    Editor: TRichEdit;
    TimerOpenDDE: TTimer;
    procedure ExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerOpenDDETimer(Sender: TObject);
  private
    avecTab : TformatSepare;
    CoeffTempsVellman,CoeffCH1Vellman,CoeffCH2Vellman : double;
    ZeroVellman : integer;
    DecodeVariab,DecodeConst : array[TcodeGrandeur] of integer;
    isPrecVariab,isPrecConst : array[TcodeGrandeur] of boolean;
    NbrePrecVariab,NbrePrecConst : integer;    
    NbreVariabAlire : integer;
    separateurCSV : char;
    NomAcqCourt : string;
    PremierAppel : boolean;
    function GetData : boolean;
    function AjouteData : integer;
    Procedure AjouteDataPageCourante;
    Procedure AjouteColPageCourante;
    Function ExtraitValeur(Agenre : TgenreGrandeur;const s : string;imax : integer) : boolean;
    Function ExtraitCoord(var ligne : integer) : boolean;
    Function ExtraitIncert(var ligne : integer) : boolean;
    Function ExtraitVariableTexte(var ligne : integer) : boolean;
    Function ExtraitNomFichier(var ligne : integer) : boolean;
    Function ExtraitOrigineTemps(var ligne : integer) : boolean;
    Function ExtraitRepere(var ligne : integer) : boolean;
    Procedure extraitNom(const s : string;var ListeN,ListeU : TstringList;creation : boolean);
    procedure ChercheTab;
    procedure MemoAddComm(const Astr : string);
    function ChercheEnTeteVellman : boolean;
    Procedure ExtraitVellman;
    Function ExtraitEphemerides : boolean;
    Procedure ExtraitCassy(ajout : boolean);
  public
     donnees : TstringList;
     Procedure RazRTF;
     procedure AjouteMemo(Amemo : TcustomMemo);
     procedure AjouteGrid(Agrid : TstringGrid);
     procedure AjouteStringList(AstringList : TstringList);
     procedure EnvoieRTF;
     Function  ImporteDonnees : boolean;
     Function  ImporteFichierTableur(const NomFichier : string) : boolean;
     Function  AjouteFichierTableur(const NomFichier : string) : boolean;
     Procedure AjouteDonnees;
     Procedure ExporteFichierTableur(const NomFichier : string);
     Procedure FocusAcquisition;
     Function ImportePressePapier : boolean;
     Procedure AjoutePressePapier;
  end;

var
  FormDDE: TFormDDE;

implementation

uses RegMain, Graphvar, AffecteNom, addPageExp, options, selColonne, filerw3U;

const
    NbreTab = 8;
    MaxVecteurEph = 10000;
    MaxVoiesEph = 24;

type
 indiceVoieEph = 0..MaxVoiesEph;
 indiceVecteurEph = 0..MaxVecteurEph;
 vecteurEph = array[indiceVecteurEph] of string;
 TvoieEph = class
       Nom,Unite,Signif : string;
       Utile,Angulaire : boolean;
       Valeur : vecteurEph;
  end;

var indexTime,indexDate,indexDateTime,indexTexte : integer;

{$R *.DFM}

Function LigneVide(Astr : string) : boolean;
begin
      trimComplet(Astr);
      result := Astr=''
end;

Procedure TformDDE.extraitNom(const s : string;
                        var ListeN,ListeU : TstringList;creation : boolean);

Procedure extraitNomLoc;
var j,debut,long : integer;
    nomU : string;
    posParentheseO,posParentheseF,posIn : integer;
begin
    j := 1;
    Repeat
        while (j<length(s)) and
              not isLettre(s[j]) do inc(j);
        debut := j;
        while (j<=length(s)) and
              isCaracGrandeur(s[j]) do inc(j);
        if j<>debut then begin
            long := j-debut;
            nomU := copy(s,j,length(s));
            if long>longNom then long := longNom;
            listeN.Add(copy(s,debut,long));
            posIn := pos('/',nomU);
            if posIn=1 then begin
               nomU[1] := '(';
               nomU := nomU + ')';
            end;
            posParentheseO := pos('[',nomU); // grandeur sous forme : nom [unite]
            if posParentheseO>0 then nomU[posParentheseO] := '(';
            posParentheseF := pos(']',nomU);
            if posParentheseF>0 then nomU[posParentheseF] := ')';
            posParentheseO := pos('(',nomU); // grandeur sous forme : nom (unite)
            posParentheseF := pos(')',nomU);
            if (posParentheseO>0) and (posParentheseF>posParentheseO)
               then begin
                   nomU := copy(nomU,posParentheseO+1,posParentheseF-posParentheseO-1);
                   j := j+posParentheseF;
               end
               else nomU := '';
            listeU.Add(nomU);
        end;
     Until (j>=length(s)) or (listeN.count=32);
end;

Procedure extraitNomTab;
var j,debut,posIn : integer;
    nomLoc,nomU : string;
    posParentheseO,posParentheseF : integer;
begin
    j := 1;
    Repeat
        debut := j;
        while (j<=length(s)) and (s[j]<>crTab) do inc(j);
        nomLoc := copy(s,debut,j-debut);
        posIn := pos(' in ',nomLoc);
        if posIn>0 then begin
           nomLoc[posIn] := '(';
           delete(nomLoc,posIn+1,3);
           nomLoc := nomLoc + ')';
        end;
        trimComplet(nomLoc);
        if nomLoc='Magnum' then nomLoc := 'x';
        posParentheseO := pos('[',nomLoc); // grandeur sous forme : nom [unite]
        if posParentheseO>0 then nomLoc[posParentheseO] := '(';
        posParentheseF := pos(']',nomLoc);
        if posParentheseF>0 then nomLoc[posParentheseF] := ')';
        posParentheseO := pos('(',nomLoc);
        posParentheseF := pos(')',nomLoc);
        if (posParentheseO>0) and (posParentheseF>(posParentheseO+1))
           then begin
              nomU := copy(nomLoc,posParentheseO+1,posParentheseF-posParentheseO-1);
              nomLoc := copy(nomLoc,1,pred(posParentheseO));
           end
           else nomU := '';
        if (nomLoc='') and Creation then nomLoc := 'x'+intToStr(listeN.count);
        listeN.Add(nomLoc);
        listeU.Add(nomU);
        inc(j);
     Until (j>length(s)) or (listeN.count=32);
     if listeN[listeN.count-1]='' then begin
            // cas de dataDirect #9#9 pour trois variables ?
        if creation then listeN.Add('Z') else listeN.Add('');
        listeU.Add('');
     end;
end;

Procedure extraitNomCSV;
var j,debut : integer;
    nomLoc,nomU : string;
    posParentheseO,posParentheseF : integer;
begin
    j := 1;
    Repeat
        debut := j;
        while (j<=length(s)) and (s[j]<>separateurCSV) do inc(j);
        nomLoc := copy(s,debut,j-debut);
        trimComplet(nomLoc);
        posParentheseO := pos('[',nomLoc); // grandeur sous forme : nom [unite]
        if posParentheseO>0 then nomLoc[posParentheseO] := '(';
        posParentheseF := pos(']',nomLoc);
        if posParentheseF>0 then nomLoc[posParentheseF] := ')';
        posParentheseO := pos('(',nomLoc);
        posParentheseF := pos(')',nomLoc);
        if (posParentheseO>0) and (posParentheseF>(posParentheseO+1))
           then begin
              nomU := copy(nomLoc,posParentheseO+1,posParentheseF-posParentheseO-1);
              nomLoc := copy(nomLoc,1,pred(posParentheseO));
           end
           else nomU := '';
        if (nomLoc='') and Creation then nomLoc := 'x'+intToStr(listeN.count);
        listeN.Add(nomLoc);
        listeU.Add(nomU);
        inc(j);
     Until (j>length(s)) or (listeN.count=32);
end;

begin
   listeN.clear;
   listeU.clear;
   case avecTab of
        sTab :  extraitNomTab;
        sBlanc : extraitNomLoc;
        sComma,sSemiColon : extraitNomCSV;
   end;
end;

Function TFormDDE.ExtraitValeur(Agenre : TgenreGrandeur;
                             const s : string;imax : integer) : boolean;

Function ExtraitValeurLoc : boolean;
var jfin,jdebut : integer;
    i : integer;
    index : integer;
    valeur : array[TcodeGrandeur] of double;
    strValeur,texte : string;
    posDate,posTime : integer;
begin with pages[pageCourante] do begin
    result := (length(s)>0) and (s[1]<>SymbReg2);
    if not result then exit;
    i := 0;jfin := 1;
    try
    Repeat
        jdebut := jfin;
        while (jdebut<length(s)) and
              not charinset(s[jdebut],chiffreWin) do inc(jdebut);
        jfin := jdebut;
        while (jfin<=length(s)) and
              charinset(s[jfin],caracNombre) do inc(jfin);
        strValeur := copy(s,jdebut,jfin-jdebut);
        posTime := pos(':',strValeur);
        posDate := pos('/',strValeur);
        if (posTime>0) or (posDate>0)
            then begin
                try
                if Agenre=variable
                    then index := decodeVariab[i]
                    else index := decodeConst[i];
                if posTime>0
                   then if posDate>0
                        then begin
                            valeur[i] := StrToDateTime(strValeur);
                            Grandeurs[index].formatU := fDateTime;
                            indexDateTime := index;
                        end
                        else begin
                           valeur[i] := StrToTime(strValeur);
                           indexTime := index;
                           Grandeurs[index].formatU := fTime;
                        end
                   else begin
                        valeur[i] := StrToDate(strValeur);
                        indexDate := index;
                        Grandeurs[index].formatU := fDate;                        
                   end;
                 except
                   valeur[i] := Nan;
                 end;
             end
             else if i=indexTexte
               then texte := strValeur
               else valeur[i] := strToFloatWin(strValeur);
        inc(i);
    Until (jfin>=length(s)) or (i>=imax);
    imax := pred(i);
    if Agenre=variable
       then begin
           nmes := nmes+1;
           for i := 0 to imax do begin
               index := decodeVariab[i];
               if i=indexTexte
                  then texteVar[index,pred(Nmes)] := texte //??
                     else if isPrecVariab[i]
                          then incertVar[index,pred(Nmes)] := valeur[i]
                          else valeurVar[index,pred(Nmes)] := valeur[i];
           end;
       end
       else for i := 0 to imax do begin
            index := decodeConst[i];
            if isPrecConst[i]
               then incertConst[index] := valeur[i]
               else valeurConst[index] := valeur[i];
       end
     except
       result := false
     end;
end end; // extraitValeurLoc

Function ExtraitValeurTab : boolean;
var j,jDebut : integer;
    i : integer;
    k,kk : integer;
    index : integer;
    valeur : array[TcodeGrandeur] of double;
    strValeur : string;
    posDate,posTime : integer;
    valeurNonDef : boolean;

Procedure TrimStrValeur;
var longueur,posCourant : integer;
begin
     longueur := Length(strValeur);
     posCourant := 1;
     while (posCourant<=longueur) do
         if charinset(strValeur[posCourant],chiffreWin+[':','/'])
            then inc(posCourant)
            else if (posCourant=longueur) and
                    charinset(strValeur[posCourant],caracPrefixeSI)
                 then convertitPrefixe(strValeur)
                 else begin
                      Delete(strValeur,posCourant,1);
                      dec(longueur);
                 end;
end;

begin with pages[pageCourante] do begin
    result := (length(s)>0) and (s[1]<>SymbReg2);
    if not result then exit;
    i := 0;j := 1;
    valeurNonDef := false;
    result := false;
    Repeat
        jDebut := j;
        while (j<=length(s)) and (s[j]<>crTab) do inc(j);// s[j]=crTab
        strValeur := copy(s,jdebut,j-jdebut);
        trimStrValeur;
        posTime := pos(':',strValeur);
        posDate := pos('/',strValeur);
        try
        if (posTime>0) or (posDate>0)
            then begin
                if Agenre=variable
                    then index := decodeVariab[i]
                    else index := decodeConst[i];
                if posTime>0
                   then if posDate>0
                        then begin
                            valeur[i] := StrToDateTime(strValeur);
                            Grandeurs[index].formatU := fDateTime;
                        end
                        else begin
                           valeur[i] := StrToTime(strValeur);
                           indexTime := index;
                           Grandeurs[index].formatU := fTime;
                        end
                   else begin
                        valeur[i] := StrToDate(strValeur);
                        indexDate := index;
                        Grandeurs[index].formatU := fDate;
                   end
             end
             else valeur[i] := strToFloatWin(strValeur);
        result := true;
        except
              valeur[i] := Nan;
              traceDefaut := tdPoint;
              valeurNonDef := true;
        end;
        inc(i);
        inc(j);
        if (i=imax) and valeurNonDef and (j<length(s)) then begin
            k := -1;
            repeat inc(k)
            until (k=imax) or isNan(valeur[k]);
            if k<imax then begin
               for kk := k to (imax-2) do valeur[kk] := valeur[succ(kk)];
               dec(i);
            end;
        end;
    until (j>length(s)) or (i=imax);
    imax := pred(i);
    if (imax<0) or isNan(valeur[0]) then exit;
    if Agenre=variable
       then begin
           nmes := nmes+1;
           for i := 0 to imax do begin
               index := decodeVariab[i];
               if isPrecVariab[i]
                  then incertVar[index,pred(Nmes)] := valeur[i]
                  else valeurVar[index,pred(Nmes)] := valeur[i];
           end
       end
       else for i := 0 to imax do begin
               index := decodeConst[i];
               if isPrecConst[i]
                   then incertConst[index] := valeur[i]
                   else valeurConst[index] := valeur[i];
       end;
end end; // extraitValeurTab

Function ExtraitValeurCSV : boolean;
var j,jDebut : integer;
    i : integer;
    k,kk : integer;
    index : integer;
    valeur : array[TcodeGrandeur] of double;
    strValeur : string;
    posDate,posTime : integer;
    valeurNonDef : boolean;

Procedure TrimStrValeur;
var longueur,posCourant : integer;
begin
     longueur := Length(strValeur);
     posCourant := 1;
     while (posCourant<=longueur) do
         if charinset(strValeur[posCourant],chiffreWin+[':','/'])
            then inc(posCourant)
            else begin
                 Delete(strValeur,posCourant,1);
                 dec(longueur);
            end;
end;

begin with pages[pageCourante] do begin
    result := length(s)>0;
    if not result then exit;
    i := 0;j := 1;
    valeurNonDef := false;
    result := false;
    Repeat
        jDebut := j;
        while (j<=length(s)) and (s[j]<>separateurCSV) do inc(j);
// s[j]=separateur 
        strValeur := copy(s,jdebut,j-jdebut);
        trimStrValeur;
        posTime := pos(':',strValeur);
        posDate := pos('/',strValeur);
        try
        if (posTime>0) or (posDate>0)
            then begin
                if Agenre=variable
                    then index := decodeVariab[i]
                    else index := decodeConst[i];
                if posTime>0
                   then if posDate>0
                        then begin
                            valeur[i] := StrToDateTime(strValeur);
                            Grandeurs[index].formatU := fDateTime;
                        end
                        else begin
                           valeur[i] := strToTime(strValeur);
                           indexTime := index;
                           Grandeurs[index].formatU := fTime;
                        end
                   else begin
                        valeur[i] := StrToDate(strValeur);
                        indexDate := index;
                        Grandeurs[index].formatU := fDate;
                   end
             end
             else valeur[i] := strToFloatWin(strValeur);
        result := true;
        except
              valeur[i] := Nan;
              traceDefaut := tdPoint;
              valeurNonDef := true;
        end;
        inc(i);
        inc(j);
        if (i=imax) and valeurNonDef and (j<length(s)) then begin
            k := -1;
            repeat inc(k)
            until (k=imax) or isNan(valeur[k]);
            if k<imax then begin
               for kk := k to (imax-2) do valeur[kk] := valeur[succ(kk)];
               dec(i);
            end;
        end;
    until (j>length(s)) or (i=imax);
    imax := pred(i);
    if Agenre=variable
       then begin
           nmes := nmes+1;
           for i := 0 to imax do begin
               index := decodeVariab[i];
               valeurVar[index,pred(Nmes)] := valeur[i];
           end
       end
       else for i := 0 to imax do
            valeurConst[decodeConst[i]] := valeur[i];
end end; // extraitValeurCSV

begin
   case avecTab of
      sTab : result := extraitValeurTab;
      sBlanc :  result := extraitValeurLoc;
      sComma,sSemiColon :  result := extraitValeurCSV;
      else result := false;
   end;
end;

Function TFormDDE.ExtraitCoord(var ligne : integer) : boolean;
var NbreLigne,j : integer;
    s : string;
    zz : word;
    m : integer;
    index : integer;
    UnitePrec : string;
begin
    if ligne>=Donnees.count then begin
       result := false;
       exit;
    end;
    s := Donnees[ligne];
    result := (length(s)>3) and (s[1]=symbReg2);
    if not result then exit;
    NbreLigne := NbreLigneWin(s);
    if pageCourante>1 then begin // pas de mise à jour du graphe
       inc(ligne,succ(NbreLigne));
       exit;
    end;
    result := pos('NOMX',s)>0;
    if result then with FgrapheVariab.graphes[1] do begin
          for j := 1 to NbreLigne do begin
             inc(ligne);
             if j<=MaxOrdonnee then Coordonnee[j].nomX := Donnees[ligne];
          end;
          for j := succ(NbreLigne) to maxOrdonnee do
             Coordonnee[j].nomX := Coordonnee[1].nomX;
          Monde[mondeX].Graduation := gLin;
          FgrapheVariab.configCharge := true;
          FgrapheVariab.majFichierEnCours := true;
          inc(ligne);
          exit;
    end;
    result := pos('NOMY',s)>0;
    if result then with FgrapheVariab.graphes[1] do begin
          m := mondeY;
          UnitePrec := '';
          for j := 1 to NbreLigne do begin
             inc(ligne);
             if j<=MaxOrdonnee then begin
             Coordonnee[j].nomY := Donnees[ligne];
             index := IndexNom(Coordonnee[j].nomY);
             if index<>grandeurInconnue then begin
                if (j>1) and
                   (UnitePrec<>grandeurs[index].nomUnite) and
                   (m<MaxMonde)
                   then inc(m);
                UnitePrec := grandeurs[index].nomUnite;
             end;
             Coordonnee[j].iMondeC := m;
             Monde[m].Graduation := gLin;
             end;
          end;
          for j := succ(NbreLigne) to maxOrdonnee do
              Coordonnee[j].nomY := '';
          inc(ligne);
          FgrapheVariab.configCharge := true;
          FgrapheVariab.majFichierEnCours := true;
          exit;
    end;
    result := pos('LOGY',s)>0;
    if result then begin
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if Donnees[ligne]<>'0'
             then FgrapheVariab.graphes[1].monde[j].graduation := gLog
       end;
       inc(ligne);
       exit;
    end;
    result := pos('AnalLogique',s)>0;
    if result then begin
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if Donnees[ligne]<>'0'
             then include(FgrapheVariab.graphes[1].OptionGraphe,OgAnalyseurLogique);
       end;
       inc(ligne);
       exit;
    end;
    result := pos('DIMPOINT',s)>0;
    if result then begin
       inc(ligne);
       dimPointVGA := StrToInt(Donnees[ligne]);
       inc(ligne);
       exit;
    end;
    result := pos('DIMLIGNE',s)>0;
    if result then begin
       inc(ligne);
       inc(ligne);
       exit;
    end;
    result := pos(stGrille,s)>0;
    if result then begin
       inc(ligne);
       if Donnees[ligne]='0'
          then exclude(FgrapheVariab.Graphes[1].OptionGraphe,OgQuadrillage)
          else include(FgrapheVariab.Graphes[1].OptionGraphe,OgQuadrillage);
       inc(ligne);
       exit;
    end;
    result := pos('ORTHO',s)>0;
    if result then begin
       inc(ligne);
       if Donnees[ligne]='0'
          then exclude(FgrapheVariab.Graphes[1].OptionGraphe,OgOrthonorme)
          else include(FgrapheVariab.Graphes[1].OptionGraphe,OgOrthonorme);
       inc(ligne);
       exit;
    end;
    result := pos('POLAIRE',s)>0;
    if result then begin
       inc(ligne);
       if Donnees[ligne]='0'
          then exclude(FgrapheVariab.Graphes[1].OptionGraphe,OgPolaire)
          else include(FgrapheVariab.Graphes[1].OptionGraphe,OgPolaire);
       inc(ligne);
       exit;
    end;
    result := pos(stCouleur,s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if (j<=MaxOrdonnee) then couleurInit[j] := Tcolor(StrToInt(Donnees[ligne]));
       end;
       inc(ligne);
       exit;
    end;
    result := pos('MOTIF',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if (j<=MaxOrdonnee) then motifInit[j] := Tmotif(StrToInt(Donnees[ligne]));
       end;
       inc(ligne);
       exit;
    end;
    result := pos(stLigne,s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if (j<=MaxOrdonnee) then begin
          zz := StrToInt(Donnees[ligne]);
          if zz=1 then FgrapheVariab.graphes[1].Coordonnee[j].trace := [trPoint];
          if zz=2 then FgrapheVariab.graphes[1].Coordonnee[j].trace := [trLigne];
          if zz=3 then FgrapheVariab.graphes[1].Coordonnee[j].trace := [trLigne,trPoint];
          if zz=4 then FgrapheVariab.graphes[1].Coordonnee[j].trace := [trSpirometrie];
          FgrapheVariab.graphes[1].Coordonnee[j].ligne := LiDroite;
          end;
       end;
       inc(ligne);
       exit;
    end;
    result := pos('LOGX',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       inc(ligne);
       if Donnees[ligne]<>'0'
          then FgrapheVariab.graphes[1].monde[mondeX].graduation := gLog;
       inc(ligne,NbreLigne);
       exit;
    end;
    result := pos('Decibel',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       for j := 1 to NbreLigne do begin
          inc(ligne);
          if (Donnees[ligne]<>'0') and (j<=MaxOrdonnee) then
             FgrapheVariab.graphes[1].monde[j].graduation := gdB;
       end;
       inc(ligne);
       exit;
    end;
    result := pos('ANALOG',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       inc(ligne);
       if Donnees[ligne]='0'
          then exclude(FgrapheVariab.graphes[1].optionGraphe,ogAnalyseurLogique)
          else include(FgrapheVariab.graphes[1].optionGraphe,ogAnalyseurLogique);
       inc(ligne,NbreLigne);
       exit;
    end;
    result := pos('ZEROX',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       inc(ligne);
       FgrapheVariab.graphes[1].monde[mondeX].zeroInclus := Donnees[ligne]<>'0';
       inc(ligne,NbreLigne);
       exit;
    end;
    result := pos('ZEROY',s)>0;
    if result then begin
       NbreLigne := NbreLigneWin(s);
       m := mondeY;
       for j := 1 to NbreLigne do begin
          inc(ligne);
          FgrapheVariab.graphes[1].monde[m].zeroInclus := Donnees[ligne]<>'0';
           if (m<=MaxOrdonnee) then inc(m);
       end;
       inc(ligne);       
       exit;
    end;
    inc(ligne,succ(NbreLigne)); // code non reconnu
end; // extraitCoord

Function TFormDDE.ExtraitNomFichier(var ligne : integer) : boolean;
var j : TindiceOrdonnee;
begin
    result := (ligne<Donnees.count) and
              (pos(symbReg2+'1 FICHIER',Donnees[ligne])>0);
    if not result then exit;
    with pages[pageCourante] do begin
       inc(ligne);
       NomFichierBitmap := Donnees[ligne];
       with FgrapheVariab.graphes[1] do
          for j := 1 to maxOrdonnee do Coordonnee[j].iMondeC := mondeY;
       inc(ligne);
   end;
end; // extraitNomFichier

Function TFormDDE.ExtraitOrigineTemps(var ligne : integer) : boolean;
var s : string;
begin with pages[pageCourante] do begin
    if ligne>=Donnees.count then begin
       result := false;
       exit;
    end;
    s := Donnees[ligne];
    result := pos(symbReg2+'1 ORIGINE TEMPS',s)>0;
    if not result then exit;
    inc(ligne);
    inc(ligne);
end end; // extraitOrigineTemps

Function TFormDDE.ExtraitIncert(var ligne : integer) : boolean;

Function ExtraitValeurIncert(const s : string;N : integer) : boolean;
var jfin,jdebut : integer;
    i : integer;
    valeur : double;
begin with pages[pageCourante] do begin
    result := true;
    i := 0;jfin := 1;
    try
    Repeat
        jdebut := jfin;
        while (jdebut<length(s)) and
              not charinset(s[jdebut],chiffreWin) do inc(jdebut);
        jfin := jdebut;
        while (jfin<=length(s)) and
              charinset(s[jfin],chiffreWin) do inc(jfin);
        valeur := strToFloatWin(copy(s,jdebut,jfin-jdebut));
        incertVar[decodeVariab[i],N] := valeur;
        inc(i);
    Until (jfin>=length(s)) or (i>=NbreVariab);
    except
          result := false;
    end;
end end; // extraitValeurIncert

var NbreLigne,j : integer;
    s : string;
begin with pages[pageCourante] do begin
    if ligne>=Donnees.count then begin
       result := false;
       exit;
    end;
    s := Donnees[ligne];
    result := (pos('INCERT',s)>0) and (s[1]=symbReg2);
    if not result then exit;
    inc(ligne);
    NbreLigne := NbreLigneWin(s);
    result := pos('FONCT',s)>0;
    if result
          then for j := 0 to pred(NbreLigne) do begin
              grandeurs[j].IncertCalcA.expression := Donnees[ligne];
              grandeurs[j].compileIncertitude;
              inc(ligne);
          end
          else for j := 0 to pred(NbreLigne) do begin
             extraitValeurIncert(Donnees[ligne],j);
             inc(ligne);
          end;
     result := true;
end end; // extraitIncert

Function TFormDDE.ExtraitVariableTexte(var ligne : integer) : boolean;
var NbreLigne,j,index : integer;
    s : string;
begin with pages[pageCourante] do begin
    if ligne>=Donnees.count then begin
       result := false;
       exit;
    end;
    s := Donnees[ligne];
    result := (pos('VARIAB_TEXTE',s)>0) and (s[1]=symbReg2);
    if not result then exit;
    NbreLigne := NbreLigneWin(s);
    result := NbreLigne=(nmes+1);
    if not result then exit;
    inc(ligne); // nom de la variable texte
    index := indexNom(Donnees[ligne]);
    result := index>0;
    if not result then begin
       inc(ligne,NbreLigne);
       exit;
    end;
    inc(ligne); // les valeurs
    grandeurs[index].fonct.genreC := g_texte;
    for j := 0 to pred(nmes) do begin
         s := Donnees[ligne];
         texteVar[index,j] := s;
         inc(ligne);
    end;
    result := true;
end end; // extraitVariableTexte

Function TFormDDE.ImportePressePapier : boolean;
begin
     result := false;
     if Clipboard.HasFormat(CF_TEXT) then begin
           Donnees.clear;
           Donnees.text := ClipBoard.asText;
// tout de suite avant que le presse papiers change
           importeDonnees;
     end;
end;

Function TFormDDE.ImporteDonnees : boolean;
begin
     result := false;
     if not FregressiMain.VerifSauve then exit;
     if GetData then begin
            result := true;
            NomFichierData := '';
            ModeAcquisition := AcqClipBoard;
            FregressiMain.FinOuvertureFichier(true);
            if FregressiMain.WindowState=wsMinimized then
                  FregressiMain.WindowState := wsNormal;
            FregressiMain.sauveEtatCourant;
            ModifFichier := true;
     end;
     donnees.clear;
end;

procedure TFormDDE.ExecuteMacro(Sender: TObject; Msg: TStrings);

Procedure GetNomExe;
var i : integer;
begin
     Donnees.clear;
     Donnees.text := ClipBoard.AsText;
     if pos('ORPHY GTS',Donnees[0])>0 then exit;
     if pos('Capto',Donnees[0])>0 then traceDefaut := tdPoint; // à cause des trous
     nomExeAcquisition := AnsiUpperCase(Donnees[0]);
     i := AcqList.indexOf(nomExeAcquisition);
     if i<0 then begin
           if AcqList.count=MaxAcq+1 then AcqList.delete(MaxAcq);
           AcqList.Add(nomExeAcquisition);
     end;
end;

Procedure ClipLoad;
begin
     GetNomExe;
     FregressiMain.grandeursOpen;
     FregressiMain.grapheOpen;
     if ImportePressePapier then begin
          ModeAcquisition := AcqCan;
          FregressiMain.ModifConfigAcq := SaveConfigAcq;
          FregressiMain.FocusAcquisitionBtn.visible := true;
     end;
end;

Procedure FocusReg(ForceGraphe : boolean);
var Placement: TWindowPlacement;
begin
    lectureFichier := false;
    lecturePage := false;
    if not Application.active then Application.BringToFront;
    GetWindowPlacement(FregressiMain.Handle, @Placement);
    with Placement do if ShowCmd in
       [SW_HIDE,SW_MINIMIZE,SW_SHOWMINIMIZED,SW_SHOWMINNOACTIVE] then begin
// pour empêcher Regressi en tâche de fond ?
           ShowCmd := SW_SHOWNORMAL;
           SetWindowPlacement(FregressiMain.Handle,@Placement);
    end;
    FregressiMain.PanelStatut.visible := NbrePages>0;
    if (FgrapheVariab<>nil) and forceGraphe
       then begin
          GetWindowPlacement(FgrapheVariab.Handle, @Placement);
          with Placement do if ShowCmd in
             [SW_HIDE,SW_MINIMIZE,SW_SHOWMINIMIZED,SW_SHOWMINNOACTIVE] then begin
// pour empêcher Regressi en tâche de fond ?
             ShowCmd := SW_SHOWNORMAL;
             SetWindowPlacement(FgrapheVariab.Handle,@Placement);
          end;
          FgrapheVariab.setFocus;
       end
       else FregressiMain.setFocus;
end;

var FnName,extension : string;
    NomFichier : String;
    ArgStart,ArgEnd : integer;
    p,PageDebut : TcodePage;
    zut1,zut2,zut3 : string;
begin // ExecuteMacro
     if (Msg.Count = 1) then begin
       try
       ArgStart := Pos('(',Msg[0]);
       ArgEnd := Length(Msg[0]); // par défaut pour éviter parenthèse intérieure
       if Msg[0][ArgEnd]<>')' then ArgEnd := Pos(')',Msg[0]);
       if (ArgStart>ArgEnd) or (ArgStart*ArgEnd=0)
          then begin
             NomFichier := '';
             ArgStart := length(Msg[0]);
          end
          else begin
             inc(ArgStart);
             NomFichier := Copy(Msg[0],ArgStart, ArgEnd - ArgStart);
             dec(ArgStart,2);
          end;
       FnName := Copy(Msg[0], 1, ArgStart);
       extension := AnsiUpperCase(extractFileExt(nomFichier));
       if (extension<>'.RRR') and
          (extension<>'.TXT') then nomFichier := changeFileExt(nomFichier,'.RW3');
       if AnsiSameText('FILE|LOAD',FnName) then begin
          zut1 := ExtractShortPathName(nomFichier);
          zut3 := ExtractFileName(nomFichier);
          zut3 := AnsiUpperCase(zut3);
          if zut3='REGRESSI.TXT'
             then begin // fichier tampon WinOrphy
                zut2 := '';
                NomFichierData := '';
             end
             else zut2 := ExtractShortPathName(nomFichierData);
          if FileExists(NomFichier) and
             not(AnsiSameText(NomFichier,NomFichierData)) and
             not(AnsiSameText(zut1,zut2))
          then FRegressiMain.LitFichier(NomFichier,true,false);
          FocusReg(true);
          exit;
       end;
       if AnsiSameText('FILE|ADD',FnName) then begin
           if FileExists(NomFichier) then begin
              Screen.cursor := crHourGlass;
              lecturePage := true;
              PageDebut := succ(PageCourante);
              if extension = '.RW3'
                 then AjouteFichier(NomFichier)
                 else AjouteFichierTableur(NomFichier);
              for p := pageDebut to NbrePages do pages[p].recalculP;
              lecturePage := false;              
              Application.MainForm.Perform(WM_Reg_Maj,MajFichier,0);
              Screen.cursor := crDefault;
           end;
           FocusReg(false);
           exit
       end;
       if AnsiSameText('CLIP|LOAD',FnName) then begin
          clipLoad;
          FocusReg(true);
          exit
       end;
       if AnsiSameText('GET|GRID',FnName) then begin
           Fvaleurs.MajGridVariab := true;
           Fvaleurs.TraceGridVariab;
           razRTF;
           AjouteGrid(Fvaleurs.GridVariab);
           EnvoieRTF;
           exit
       end;
       if AnsiSameText('CLIP|ADD',FnName) then begin
            if pageCourante=0
               then clipLoad
               else AjoutePressePapier;
            FocusReg(false);
            exit
       end;
       if AnsiSameText('CLIP|PLUS',FnName) then begin
           if (pageCourante=0) or (pages[pageCourante].nmes=0)
              then clipLoad
              else ajouteDataPageCourante;
           FocusReg(false);
           exit;
       end;
       if AnsiSameText('CLIP|ADDCOL',FnName) then begin
           if (pageCourante=0) or (pages[pageCourante].nmes=0)
              then clipLoad
              else ajouteColPageCourante;
           if not Application.active then Application.BringToFront;
           FocusReg(false);
           exit;
       end;
       if AnsiSameText('FOCUS',FnName) then begin
           GetNomExe;
           FocusReg(false);
           exit;
       end;
       MessageDlg('Fonction inconnue : ' + Msg[0], mtError, [mbOK], 0);
       except
       end;
     end;
end; // ExecuteMacro

Procedure TFormDDE.AjoutePressePapier;
begin
     if pageCourante=0 then begin
        ImportePressePapier;
        exit;
     end;
     Donnees.clear;
     Donnees.text := ClipBoard.asText;
     AjouteDonnees;
end; // AjoutePressePapier

Procedure TFormDDE.AjouteDonnees;
var sauveModeAcq : TmodeAcquisition;
begin
     LecturePage := true;
     case AjouteData of
        idOK : begin
           if FregressiMain.WindowState=wsMinimized then
              FregressiMain.WindowState := wsNormal;
              if FgrapheVariab.WindowState=wsMinimized then
                 FgrapheVariab.WindowState:=wsMaximized;
              FgrapheVariab.show;
              FgrapheVariab.setFocus;
        end;
        idYes : begin
           sauveModeAcq := modeAcquisition;
           importePressePapier;
           modeAcquisition := sauveModeAcq;
           FgrapheVariab.setFocus;
        end;
        idCancel : ;
     end;
     donnees.Clear;
     LecturePage := false;
end; // AjouteDonnees

Function TFormDDE.AjouteData : integer;
var i : integer;
    listeNom,listeUnite : TstringList;
    isGTS : boolean;
    NbreVariabLu : integer;

Function ChercheVariab : boolean;
var i,j,k,kc : integer;
    libre : boolean;
 { TODO : Vérifier les doublons de nom }
begin
  NbreVariabAlire := NbreVariabExp+NbreVariabTexte;
  NbreVariabLu := 0;
  for i := 0 to MaxGrandeurs do DecodeVariab[i] := grandeurInconnue;
  for i := 0 to pred(listeNom.count) do begin
        k := indexNom(listeNom[i]);
        if k<>grandeurInconnue
          then begin
             inc(NbreVariabLu);
             DecodeVariab[i] := k;
          end
          else if (pos('sigma_',listeNom[i])<>1)
               then inc(NbreVariabLu);
  end;
  for i := 0 to pred(listeNom.count) do begin
        k := indexNom(listeNom[i]);
        if k=grandeurInconnue then begin  // else decodeVariab déjà affecté
             if pos('sigma_',listeNom[i])=1
                then begin
                    k := indexNom(copy(listeNom[i],7,length(listeNom[i])-6));
                    isPrecVariab[i] := k<>grandeurInconnue;
                    if isPrecVariab[i]
                       then begin
                           decodeVariab[i] := k;
                           inc(NbrePrecVariab); // decodeVariab non nécessaire
                       end;
                       // else à faire
                end
                else begin
                     kc := 0;
                     repeat
                        libre := true;
                        for j := 0 to pred(NbreVariabLu) do
                            if decodeVariab[j]=kc then begin // déjà pris
                               repeat
                                  inc(kc)
                               until ((grandeurs[kc].fonct.genreC=g_experimentale) and
                                      (grandeurs[kc].genreG=variable)) or
                                     (kc=pred(NbreGrandeurs));
                               libre := false;
                               break;
                            end;
                      until libre or (kc=pred(NbreGrandeurs));
                      if libre and
                        (grandeurs[kc].fonct.genreC=g_experimentale) and
                        (grandeurs[kc].genreG=variable) then DecodeVariab[i] := kc;
               end;
        end;
  end;
  if (NbreVariabAlire<NbreVariabLu) then begin
     for i := pred(NbreVariabAlire) downto NbreVariabLu do
         decodeVariab[i] := indexVariabExp[i]; // à améliorer
  end;
  result := true;
end; // ChercheVariab

procedure AjouteConstante;
var NbreConstCB : integer;

Procedure extraitUniteConst(const contenu : string);
var j,debut,long : integer;
    k,c : integer;
begin
    j := 1;
    c := 0;
    Repeat
        debut := j;
        k := decodeConst[c];
        while (j<=length(contenu)) and
              (contenu[j]<>separateurCSV) do inc(j);
        long := j-debut;
        if long>0 then begin
           Grandeurs[k].NomUnite := copy(contenu,debut,long);
           if pos('°',Grandeurs[k].nomUnite)>0 then AngleEnDegre := true;
           if pos('rad',Grandeurs[k].nomUnite)>0 then AngleEnDegre := false;
        end;
        inc(c);
        inc(j); { saute Tab }
     Until (j>length(contenu)) or (k>=NbreConstCB);
end;  // extraitUniteConst

Procedure AffecteNomConst;
var j,jmax : integer;
begin
    extraitNom(Donnees[i],listeNom,listeUnite,true);
    if NbreConstExp>listeNom.count
       then jmax := listeNom.count
       else jmax := NbreConstExp;
    for j := 0 to pred(jmax) do
        decodeConst[j] := IndexNom(listeNom[j]);
    for j := jmax to pred(listeNom.count) do begin
        decodeConst[j] := AjouteExperimentale(listeNom[j],constante);
        grandeurs[decodeConst[j]].nomUnite := listeUnite[j];
    end;
    NbreConstCB := listeNom.count;
end;

Procedure extraitCommConst(const contenu : string);
var j,debut,long : integer;
    k,c : integer;
begin
    j := 1;
    c := 0;
    Repeat
        k := decodeConst[c];
        debut := j;
        while (j<=length(contenu)) and
              (contenu[j]<>separateurCSV) do inc(j);
        long := j-debut;
        if long>0 then begin
           Fvaleurs.Memo.Lines.Add(''''+grandeurs[k].nom+'='+
                        copy(contenu,debut,long));
           grandeurs[k].fonct.expression := copy(contenu,debut,long);
        end;
        inc(c);
        inc(j);
     Until (j>=length(contenu)) or (k>=NbreConstCB);
end;

Function IsSymbReg2 : boolean;
begin
   result := (length(donnees[i])>0) and (donnees[i][1]=symbReg2)
end;

begin // AjouteConstante
     while (i<Donnees.count) and
           LigneVide(Donnees[i]) do inc(i);
     if (i>=Donnees.count) or isSymbReg2 then exit;
     affecteNomConst;
     inc(i);
     if (i>=Donnees.count) or isSymbReg2 then exit;
     extraitUniteConst(Donnees[i]);
     inc(i);
     if (i>=Donnees.count) or isSymbReg2 then exit;
     if not LigneDeChiffres(Donnees[i]) then begin
        extraitCommConst(Donnees[i]);
        inc(i);
     end;
     if (i>=Donnees.count) or isSymbReg2 then exit;
     ExtraitValeur(constante,Donnees[i],NbreConstExp);
     inc(i);
end; // AjouteConstante

Procedure AjouteValeur;
var s : string;
begin
     while (i<Donnees.count) and
           ExtraitValeur(variable,Donnees[i],NbreVariabAlire)
        do inc(i);
     AjouteConstante;
     while i<Donnees.count do begin
         s := Donnees[i];
         if (length(s)>1) and (s[1]=symbReg2)
               then if not ExtraitIncert(i) and
                       not ExtraitVariableTexte(i) and
                       not ExtraitRepere(i) and
                       not ExtraitOrigineTemps(i) and
                       not ExtraitNomFichier(i) and
                       not ExtraitCoord(i)
                            then inc(i)
                            else
               else inc(i);
     end;
     Pages[pageCourante].modifiedP := true;
end; // AjouteValeur

var Contenu,Comm : string;
    LigneNom,Fini : boolean;
    j,k : integer;
    FinContenu : string;
    DataSuppl,dataOK : boolean;
label fin;
begin // AjouteData
     screen.cursor := crHourGlass;
     for i := 0 to MaxGrandeurs do begin
         DecodeVariab[i] := indexVariabExp[i];
         isPrecVariab[i] := false;
         NbrePrecVariab := 0;
         DecodeConst[i] := indexConstExp[i];
         isPrecConst[i] := false;
         NbrePrecConst := 0;
     end;
     i := 0;
     isGTS := donnees[0]='Données acquises par ORPHY GTS';     
     result := idCancel;
     chercheTab;
     listeNom := TstringList.Create;
     listeUnite := TstringList.Create;
     if ChercheEnTeteVellman then begin
        if not ajoutePage then goto fin;
        extraitVellman;
        result := idOK;
        goto fin;
     end;
     LigneNom := true;
     Fini := false;
     Comm := '';
     if avecTab=sTab then while (i<Donnees.count) and not fini do begin
        Contenu := Donnees[i];
        if Length(contenu)>4
           then FinContenu := AnsiUppercase(copy(contenu,length(contenu)-3,4))
           else FinContenu := '';
        fini := pos(crTab,Contenu)<>0;
        if not fini then begin
              if FinContenu='.EXE'
                 then nomExeAcquisition := contenu
                 else comm := comm+Contenu;
              inc(i);
        end;
     end; // Tabulation trouvée
     fini := false;
     NbreVariabAlire := NbreVariabExp+NbreVariabTexte;
     while (i<Donnees.count) and not fini do begin
        Contenu := Donnees[i];
        Fini := LigneDeChiffres(Contenu);
        if not Fini and LigneNom and (length(Contenu)>2) then begin
               extraitNom(Contenu,listeNom,listeUnite,false);
            { TODO : vérifier listeNom.count<=nbrevariab }
               dataOK := true;
               if isGTS and (listeNom[0]='') then begin
                  for i := 0 to listeNom.count-2 do
                      listeNom[i] := listeNom[i+1];
                  listeNom[listeNom.Count-1] := 'numero';
               end;
               for j := 0 to pred(listeNom.count) do begin
                   k := indexVariabExp[j];
                   if k<NbreGrandeurs then dataOK := dataOK and (listeNom[j]=grandeurs[k].nom);
                               { TODO : sigma_ }
               end;
               if dataOK then begin
                  result := idOK;
                  NbreVariabLu := listeNom.count;
               end;
               if result<>idOK then if chercheVariab
                   then result := idOK
                   else begin
                      result := idYes;
                      goto fin;
                   end;
               DataSuppl := NbreVariabLu>NbreVariabAlire;
               if NbreVariabLu<>NbreVariabAlire then begin
                  AddPageExpDlg := TaddPageExpDlg.create(self);
                  if NbreVariabLu>NbreVariabAlire
                     then AddPageExpDlg.grid.colCount := NbreVariabLu
                     else AddPageExpDlg.grid.colCount := NbreVariabAlire;
                  for j := 0 to pred(NbreVariabExp) do
                      AddPageExpDlg.grid.cells[j,0] := grandeurs[indexVariabExp[j]].nom;
                  for j := 0 to pred(NbreVariabTexte) do
                      AddPageExpDlg.grid.cells[j,0] := grandeurs[indexVariabTexte[j]].nom;
                  k := 0;
                  for j := 0 to pred(listeNom.count) do if not isPrecVariab[j] then begin
                      AddPageExpDlg.grid.cells[k,1] := listeNom[j];
                      inc(k);
                  end;
                  result := AddPageExpDlg.showModal;
                  AddPageExpDlg.free;
               end;
               if result<>idOK then goto fin;
               if DataSuppl then begin
                  for i := 0 to pred(listeNom.count) do
                      if DecodeVariab[i]=grandeurInconnue then begin
                         isPrecVariab[i] := pos('sigma_',listeNom[i])=1;
                         if isPrecVariab[i] then begin
                            k := indexNom(copy(listeNom[i],7,length(listeNom[i])-6));
                            isPrecVariab[i] := k<>grandeurInconnue;
                            DecodeVariab[i] := k;
                            inc(NbrePrecVariab);
                         end;
                         if not isPrecVariab[i]
                            then DecodeVariab[i] := AjouteExperimentale(listeNom[i],variable);
                      end;
                  NbreVariabAlire := NbreVariabExp+NbreVariabTexte;
               end;
               for k := 0 to pred(NbreVariabExp) do
                   if DecodeVariab[k]=grandeurInconnue then DecodeVariab[k] := indexVariabExp[k];
               LigneNom := false;
        end;
        if Fini
           then begin
                NbreVariabLu := 0;
                repeat inc(NbreVariabLu)
                until DecodeVariab[NbreVariabLu]=grandeurInconnue;
                dec(NbreVariabLu);
           end
           else inc(i);
     end;
     if i=Donnees.count then begin // pas d'en tête ?
        i := 0;
        while (i<Donnees.count) and
              not ligneDeChiffres(donnees[i]) do inc(i);
        if i=Donnees.count then goto fin;
     end;
     if not ajoutePage then goto fin;
     Pages[pageCourante].commentaireP := Comm;
     ajouteValeur;
     if Pages[PageCourante].nmes=0
        then supprimePage(pageCourante,false)
        else begin
             pages[pageCourante].recalculP;
             lecturePage := false;
             Application.MainForm.perform(WM_Reg_Maj,MajAjoutPage,0);
             ModifFichier := true;
             result := idOK;
        end;
     fin :
     screen.cursor := crDefault;
     listeNom.free;
     listeUnite.free;
end; // AjouteData

Procedure TFormDDE.AjouteDataPageCourante;
var i : integer;
label fin;
begin
     screen.cursor := crHourGlass;
     for i := 0 to MaxGrandeurs do begin
         DecodeVariab[i] := indexVariabExp[i];
         DecodeConst[i] := indexConstExp[i];
         isPrecVariab[i] := false;
         isPrecConst[i] := false;
         NbrePrecVariab := 0;
         NbrePrecConst := 0;         
     end;
     Donnees.clear;
     Donnees.text := ClipBoard.asText;
     i := 0;
     while (i<Donnees.count) and
           ((pos(crTab,Donnees[i])=0) or
            not LigneDeChiffres(Donnees[i])) do inc(i);
     if i=Donnees.count then goto fin;
     while (i<Donnees.count) and
           ExtraitValeur(variable,Donnees[i],NbreVariabExp)
       do inc(i);
     Pages[pageCourante].modifiedP := true;
     pages[pageCourante].recalculP;
     Application.MainForm.perform(WM_Reg_Maj,MajValeur,0);
     ModifFichier := true;
     Fvaleurs.MajGridVariab := true;
     Fvaleurs.TraceGridVariab;
     fin : screen.cursor := crDefault;
     donnees.clear;
end; // AjouteDataPageCourante

Function TFormDDE.AjouteFichierTableur(const NomFichier : string) : boolean;
var sauveModeAcq : TmodeAcquisition;
    NomFichierCourt : string;
begin
     Donnees.clear;
     try
     Donnees.LoadFromFile(NomFichier);
     lecturePage := true;
     case AjouteData of
         idYes : begin
            sauveModeAcq := modeAcquisition;
            nomFichierCourt := extractFileName(NomFichier)+' : ';
            result := importeFichierTableur(NomFichier);
            if result then pages[pageCourante].commentaireP :=
               nomFichierCourt+' : '+pages[pageCourante].commentaireP;
            modeAcquisition := sauveModeAcq;
         end;
         idOK : result := true;
         idCancel : result := false;
         else result := false;
     end;
     except
         result := false;
     end;
     lecturePage := false;
     donnees.clear;
end; // AjouteFichierTableur

Function TFormDDE.GetData : boolean;
var isGTS : boolean;
    ligneCourante : integer;
    Comm : string;
    contenu : String;
    listeNom,listeU : TstringList;

Procedure AffecteNomG(Agenre : TgenreGrandeur);
var i,z : integer;
    isIncert : boolean;
begin
    extraitNom(Contenu,listeNom,listeU,true);
    for i := 0 to pred(listeNom.count) do begin
        isIncert := pos('sigma_',listeNom[i])=1;
        z := grandeurInconnue; // pour le compilateur
        if isIncert then begin // incertitude de qui ?
           z := indexNom(copy(listeNom[i],7,length(listeNom[i])-6));
           isIncert := (z<>grandeurInconnue) and
                       (grandeurs[z].genreG=Agenre);
        end;
        if not isIncert then begin
            z := indexNom(listeNom[i]);
            if z<>grandeurInconnue then
               listeNom[i] := listeNom[i]+intToStr(i);
            z := AjouteExperimentale(listeNom[i],Agenre);
        end;
        if agenre=variable
           then begin
              decodeVariab[i] := z;
              isPrecVariab[i] := isIncert;
              if isIncert then inc(NbrePrecVariab);
           end
           else begin
              decodeConst[i] := z;
              isPrecConst[i] := isIncert;
              if isIncert then inc(NbrePrecConst);
           end;
        grandeurs[z].nomUnite := listeU[i];
    end;
    if (Agenre=variable) and isGTS and (grandeurs[0].nom='') then begin
       for i := 0 to NbreVariab-2 do
           grandeurs[i].nom := grandeurs[i+1].nom;
       grandeurs[NbreVariab-1].nom := 'numero';
    end;
{ isGTS pour régler le pb de GTS en mode XY qui renvoie
"rien" x y
"rien" x1 y1 t1 }
// cas de dataDirect #9#9 pour trois variables ?
end;

Procedure completeNomVar;

Procedure TrimNomVar(var s : String);
var longueur,posCourant : integer;
    sMaj : String;
begin
     longueur := Length(s);
     posCourant := 1;
     while (posCourant<=longueur) do
         if isCaracGrandeur(s[posCourant])
            then inc(posCourant)
            else begin
                 Delete(s,posCourant,1);
                 dec(longueur);
            end;
     sMaj := AnsiUpperCase(s);
     if sMaj='TEMPERATURE' then s := 'T'
     else if sMaj='HAUT' then s := 'max'
     else if sMaj='BAS' then s := 'min'
     else if sMaj='VITESSE' then s := 'V'
     else if sMaj='BAROMETRE' then s := 'P'
     else if sMaj='HUMIDITE' then s := 'Hum'
     else if sMaj='EXTERIEURE' then s := 'ext'
     else if sMaj='INTERIEURE' then s := 'int'
     else if sMaj='REFROIDISSEMENT' then s := 'Refr'
end;

var liste : TstringList;
    i,imax : integer;
    z1,z2 : string;
begin
    liste := TstringList.Create;
    extraitNom(Contenu,liste,listeU,false);
    imax := pred(liste.count);
    if imax>=NbreVariab then imax := pred(NbreVariab);
    for i := 0 to imax do begin
        Z1 := listeNom[i];
        Z2 := liste[i];
        grandeurs[i].fonct.expression := z1+' '+z2;
        TrimNomVar(Z1);
        TrimNomVar(Z2);
        if ((z1='V') or (z2='V')) and
           (grandeurs[i].nomUnite='') then grandeurs[i].nomUnite := 'm/s';
        if ((z1='T') or (z2='T')) and
           (grandeurs[i].nomUnite='') then grandeurs[i].nomUnite := '°C';
        if ((z1='P') or (z2='P')) and
           (grandeurs[i].nomUnite='') then grandeurs[i].nomUnite := 'hPa';
        if ((z1='Hum') or (z2='Hum')) and
           (grandeurs[i].nomUnite='') then grandeurs[i].nomUnite := '%';
        if (length(Z1)+length(Z2))>longNom
           then grandeurs[i].nom := copy(Z1,1,longNom div 2)+
                                    copy(Z2,1,longNom div 2)
           else grandeurs[i].nom := Z1+Z2;
    end;
    liste.free;
    AffecteNomDlg := TAffecteNomDlg.create(self);
    AffecteNomDlg.showModal;
    AffecteNomDlg.free;
end;

Procedure extraitUniteLigne(Agenre : TgenreGrandeur);
var j,debut,long : integer;
    k : integer;
begin
    if pos('dt=0',contenu)=1 then exit; { fichier Synchronie }
    j := 1;
    if Agenre=variable then k := 0 else k := NbreVariab;
    Repeat
        debut := j;
        while (j<=length(contenu)) and
              (contenu[j]<>separateurCSV) do inc(j);
        long := j-debut;
        if long>0 then begin
           Grandeurs[k].NomUnite := copy(contenu,debut,long);
           if Grandeurs[k].nomUnite='°' then AngleEnDegre := true;
           if Grandeurs[k].nomUnite='rad' then AngleEnDegre := false;
        end;
        inc(k);
        inc(j); // saute Tab
     Until (j>length(contenu)) or (k>=NbreGrandeurs);
     if (Agenre=variable) and isGTS and (grandeurs[NbreVariab-1].nom='numero') then begin
         for j := 0 to NbreVariab-2 do
             grandeurs[j].nomUnite := grandeurs[j+1].nomUnite;
         grandeurs[NbreVariab-1].nomUnite := '';
     end;
end;

Procedure extraitCommLigne(Agenre : TgenreGrandeur);
var j,debut,long : integer;
    k : integer;
begin
    j := 1;
    if Agenre=variable then k := 0 else k := NbreVariab;
    Repeat
        debut := j;
        while (j<=length(contenu)) and
              (contenu[j]<>crTab) do inc(j);
        long := j-debut;
        if long>0 then begin
           Fvaleurs.Memo.Lines.Add(''''+grandeurs[k].nom+'='+
                        copy(contenu,debut,long));
           grandeurs[k].fonct.expression := copy(contenu,debut,long);
        end;
        inc(k);
        inc(j);
     Until (j>=length(contenu)) or (k>=NbreGrandeurs);
end;

function ChercheEnTeteVariabFichier : boolean;
var FinEnTete : boolean;
    Code : integer;
    FinContenu : string;

Procedure AffecteExe;
var i : integer;
begin
       if pos('ORPHY GTS',contenu)>0 then exit;
       nomExeAcquisition := AnsiUpperCase(contenu);
       i := AcqList.indexOf(nomExeAcquisition);
       if i<0 then begin
             if AcqList.count=MaxAcq+1 then AcqList.delete(MaxAcq);
             AcqList.Add(nomExeAcquisition);
       end;
end;

var k : integer;
begin // ChercheEnTeteVariabFichier
     FinEnTete := false;
     Code := 0;
     Comm := '';
     isGTS := donnees[0]='Données acquises par ORPHY GTS';
     while (ligneCourante<Donnees.count) and not FinEnTete do begin
        Contenu := Donnees[LigneCourante];
        FinEnTete := LigneDeChiffres(Contenu);
        if FinEnTete then break;
        if Length(contenu)>4
           then FinContenu := AnsiUppercase(copy(contenu,length(contenu)-3,4))
           else FinContenu := '';
        if (pos(crTab,Contenu)=0) and (avecTab=sTab)
           then if FinContenu='.EXE'
                then affecteExe
                else begin
                   MemoAddComm(Contenu);
                   Comm := Contenu;
                 end
           else if (pos(crTab,Contenu)<>0) or
                    (contenu<>'') then if FinContenu='.EXE'
                then affecteExe
                else begin
                  inc(code);
                  case code of
                      1 : if NbreVariab=0
                         then begin
                            affecteNomG(variable);
                            for k := 0 to pred(NbreVariab) do
                                if grandeurs[k].nom='' then begin
                                   code := 0;
                                   break
                                end;
                          end
                          else completeNomVar;
                      2 : extraitUniteLigne(variable);
                      3 : extraitCommLigne(variable);
                  end; {case}
            end; {else}
            inc(LigneCourante);
     end;
     result := NbreGrandeurs>0;
     isGTS := isGTS and (grandeurs[NbreVariab-1].nom='numero');
end; // ChercheEnTeteVariabFichier

function ChercheEnTeteVide : boolean;
var i,j,N : integer;
    NombreEnCours : boolean;
begin
    ligneCourante := 0;
    while (ligneCourante<Donnees.count) and
          (length(Donnees[LigneCourante])=0) do inc(LigneCourante);
    contenu := Donnees[LigneCourante];
    if pos(crTab,Contenu)>0 then avecTab := sTab else avecTab := sBlanc;
    Result := false;
    if length(contenu)=0 then exit;
    if not LigneDeChiffres(Contenu) then exit;
    NombreEnCours := charinset(contenu[1],caracNombre);
    if NombreEnCours then N := 1 else N := 0;
    for j := 2 to length(contenu) do
        if charinset(contenu[j],caracNombre) or
           (charinset(contenu[j],caracPrefixeSI) and
            charinset(contenu[j-1],chiffre))
           then if NombreEnCours
                then
                else begin
                   NombreEnCours := true;
                   inc(N);
                end
           else if charinset(contenu[j],separateur)
                then NombreEnCours := false
                else exit;
    result := N>=1;
    for i := 1 to N do
        AjouteExperimentale('var'+intToStr(i),variable);
    if N>=1 then begin
       AffecteNomDlg := TAffecteNomDlg.create(self);
       AffecteNomDlg.showModal;
       AffecteNomDlg.free;
    end;
end; // ChercheEnTeteVide

function ChercheEnTeteVernier : boolean;
begin
     Comm := '';
     result := pos('Vernier Format 2',Donnees[0])>0;
     if not result then exit;
     MemoAddComm(Donnees[1]); // untitled.txt 9/12/110 8:37:51
     MemoAddComm(Donnees[2]); // Run 1
// 3 : Temps	Tension
// 4 : T	T
// 5 : ms	V
// 6 :
// 7 : première ligne de données
     Contenu := Donnees[3];
     affecteNomG(variable);
     Contenu := Donnees[5];
     extraitUniteLigne(variable);
     contenu := Donnees[4];
     extraitCommLigne(variable);
     LigneCourante := 7;
     result := true;
end; // ChercheEnTeteVernier

function ChercheEnTeteConst : boolean;
var oldNbre : integer;
begin
     oldNbre := NbreGrandeurs;
     while (ligneCourante<Donnees.count) and
           LigneVide(Donnees[LigneCourante]) do inc(ligneCourante);
     result := ligneCourante<Donnees.count;
     if not result then exit;
     Contenu := Donnees[LigneCourante];
     result := (length(contenu)>0) and (contenu[1]<>SymbReg2);
     if not result then exit;
     affecteNomG(constante);
     result := NbreGrandeurs>OldNbre;
     if not result then exit;
     inc(ligneCourante);
     Contenu := Donnees[LigneCourante];
     extraitUniteLigne(constante);
     inc(LigneCourante);
     Contenu := Donnees[LigneCourante];
     if LigneDeChiffres(Contenu) then exit;
     extraitCommLigne(constante);
     inc(LigneCourante);
end; // ChercheEnTeteConst

function ChercheEnTeteCassy : boolean;
begin
     result := pos('MIN=',Donnees[0])>0;
     result := result and (pos('MAX=',Donnees[1])>0);
     result := result and (pos('SCALE=',Donnees[1])>0);
end; // ChercheEnTeteCassy

label fin;
var i,j,k : integer;
begin // GetData
     FichierTrie := DataTrieGlb;
     optionsDlg.resetConfig;
     for i := 0 to MaxGrandeurs do begin
         DecodeVariab[i] := i;
         DecodeConst[i] := indexConstExp[i];
         isPrecConst[i] := false;
         isPrecVariab[i] := false;
         NbrePrecConst := 0;
         NbrePrecVariab := 0;
     end;
     listeNom := TstringList.Create;
     listeU := TstringList.Create;
     screen.cursor := crHourGlass;
     GetData := false;
     ChercheTab;
     indexTime := grandeurInconnue;
     indexDate := grandeurInconnue;
     indexDateTime := grandeurInconnue;
     indexTexte := grandeurInconnue;
     LigneCourante := 0;
     if ChercheEnTeteVellman then begin
        if not ajoutePage then goto fin;
        AjouteExperimentale('t',variable);
        grandeurs[0].nomUnite := 's';
        AjouteExperimentale('V1',variable);
        grandeurs[1].nomUnite := 'V';
        AjouteExperimentale('V2',variable);
        grandeurs[2].nomUnite := 'V';
        pageCourante := 1;
        extraitVellman;
        getData := true;
        goto fin;
     end;
     if ChercheEnTeteCassy then begin
        if not ajoutePage then goto fin;
        extraitCassy(false);
        getData := true;
        goto fin;
     end;
     if ChercheEnTeteVernier then begin
        if not ajoutePage then goto fin;
        while (ligneCourante<Donnees.count) and
              ExtraitValeur(variable,Donnees[LigneCourante],NbreVariab)
           do inc(LigneCourante);
        getData := true;
        goto fin;
     end;
     if not ChercheEnTeteVariabFichier then begin
        if ChercheEnTeteVide and ajoutePage then begin
           pageCourante := 1;
           while (ligneCourante<Donnees.count) and
               ExtraitValeur(variable,Donnees[LigneCourante],NbreVariab+NbrePrecVariab)
               do inc(LigneCourante);
           getData := true;
        end;
        goto fin;
     end;
     if not AjoutePage then goto fin;
     pages[1].CommentaireP := Comm;
     pageCourante := 1;
     if indexTexte<>grandeurInconnue then ;
     while (ligneCourante<Donnees.count) and
            ExtraitValeur(variable,Donnees[LigneCourante],NbreVariab+NbrePrecVariab)
        do inc(LigneCourante);
     if (indexTime<>grandeurInconnue) and
        (indexDate<>grandeurInconnue) and
        (indexDateTime=grandeurInconnue) then begin
           with Fvaleurs do begin
                memo.Lines.Add('t='+grandeurs[indexDate].nom+'+'+grandeurs[indexTime].nom);
                memo.Lines.Add('''t=date et heure');
           end;
           with FgrapheVariab.graphes[1] do begin
               k := 0;
               for j := 1 to MaxOrdonnee do begin
                   Coordonnee[j].nomX := 't';
                   while (k=indexDate) or (k=indexTime) do inc(k);
                   if k<NbreGrandeurs then
                      Coordonnee[j].nomY := grandeurs[k].nom;
                   inc(k)
               end;
               Monde[mondeX].Graduation := gLin;
               Monde[mondeX].zeroInclus := false;
               FgrapheVariab.configCharge := true;
           end;
     end;
     if (ligneCourante<(Donnees.count-2)) and
        ChercheEnTeteConst and
        ligneDeChiffres(Donnees[LigneCourante]) then begin
             ExtraitValeur(constante,Donnees[LigneCourante],NbreConst+NbrePrecConst);
             inc(ligneCourante);
     end;
     while ligneCourante<Donnees.count do
           if not ExtraitIncert(ligneCourante)
              and not ExtraitVariableTexte(ligneCourante)
              and not ExtraitNomFichier(ligneCourante)
              and not ExtraitOrigineTemps(ligneCourante)
              and not ExtraitRepere(ligneCourante)
              and not ExtraitCoord(ligneCourante)
                   then inc(ligneCourante);
     GetData := true;
     fin : screen.cursor := crDefault;
     ListeNom.free;
     ListeU.free;
end; // GetData

Procedure TFormDDE.AjouteColPageCourante;
var ligneCourante : integer;
    Comm : string;
    contenu : string;
    listeNom,listeU : TstringList;
    indexNew : array[0..16] of integer;
    NmesLoc : integer;
    NewCol : boolean;

Function ExtraitValeurCol(const s : string) : boolean;
var j,jDebut : integer;
    i : integer;
    strValeur : string;

Procedure TrimStrValeur;
var longueur,posCourant : integer;
begin
     longueur := Length(strValeur);
     posCourant := 1;
     while (posCourant<=longueur) do
         if charinset(strValeur[posCourant],chiffreWin)
         then inc(posCourant)
         else begin
            Delete(strValeur,posCourant,1);
            dec(longueur);
         end;
end;

begin with pages[pageCourante] do begin
    result := (length(s)>0) and (s[1]<>SymbReg2);
    if not result then exit;
    i := 0;j := 1;
    Repeat
        jDebut := j;
        while (j<=length(s)) and (s[j]<>crTab) do inc(j);
        strValeur := copy(s,jdebut,j-jdebut);
        trimStrValeur;
        try
        valeurVar[indexNew[i],NmesLoc] := strToFloatWin(strValeur);
        except
              valeurVar[indexNew[i],NmesLoc] := Nan;
              result := false;
        end;
        inc(i);
        inc(j);
    Until (j>length(s)) or (indexNew[i]=0);
    inc(NmesLoc);
end end; // extraitValeurCol

Procedure affecteNomLigne;
var i : integer;
begin
    extraitNom(Contenu,listeNom,listeU,false);
    for i := 0 to pred(listeNom.count) do begin
        indexNew[i] := indexNom(listeNom[i]);
        if indexNew[i]=grandeurInconnue then begin
           indexNew[i] := AjouteExperimentale(listeNom[i],variable);
           grandeurs[indexNew[i]].nomUnite := listeU[i];
           NewCol := true;
        end;
    end;
    indexNew[listeNom.count] := 0;
end;

Procedure extraitUniteLigne;
var j,debut,long : integer;
    k : integer;
begin
    j := 1;
    k := 0;
    Repeat
        debut := j;
        while (j<=length(contenu)) and
              (contenu[j]<>crTab) do inc(j);
        long := j-debut;
        if long>0 then
           Grandeurs[indexNew[k]].NomUnite := copy(contenu,debut,long);
        inc(k);
        inc(j); { saute Tab }
     Until (j>length(contenu)) or (indexNew[k]=0);
end;

Procedure extraitCommLigne;
var j,debut,long : integer;
    k : integer;
begin
    j := 1;
    k := 0;
    Repeat
        debut := j;
        while (j<=length(contenu)) and
              (contenu[j]<>crTab) do inc(j);
        long := j-debut;
        if long>0 then with grandeurs[indexNew[k]] do begin
           fonct.expression := copy(contenu,debut,long);
           Fvaleurs.Memo.Lines.Add(''''+nom+'='+fonct.expression);
        end;
        inc(k);
        inc(j);
     Until (j>=length(contenu)) or (indexNew[k]=0);
end;

function ChercheEnTeteVariabPage : boolean;
var FinEnTete : boolean;
    Code : integer;
    FinContenu : string;
begin // ChercheEnTeteVariabPage 
     FinEnTete := false;
     Code := 0;
     Comm := '';
     NewCol := false;
     while (ligneCourante<Donnees.count) and not FinEnTete do begin
        Contenu := Donnees[LigneCourante];
        FinEnTete := LigneDeChiffres(Contenu);
        if FinEnTete then break;
        if Length(contenu)>4
           then FinContenu := AnsiUppercase(copy(contenu,length(contenu)-3,4))
           else FinContenu := '';
        if pos(crTab,Contenu)=0
           then begin
                MemoAddComm(Contenu);
                Comm := Contenu;
           end
           else if (pos(crTab,Contenu)<>0) or
                    (contenu<>'') then begin
                  inc(code);
                  case code of
                      1 : affecteNomLigne;
                      2 : extraitUniteLigne;
                      3 : extraitCommLigne;
                  end; {case}
            end; {else}
            inc(LigneCourante);
     end;
     result := NewCol;
end; // ChercheEnTeteVariabPage

begin // AjouteColPageCourante
     screen.cursor := crHourGlass;
     Donnees.clear;
     Donnees.text := ClipBoard.asText;
     LigneCourante := 0;
     NmesLoc := 0;
     listeNom := TstringList.Create;
     listeU := TstringList.Create;
     if ChercheEnTeteVariabPage then begin
        while (ligneCourante<Donnees.count) and
              ExtraitValeurCol(Donnees[LigneCourante])
            do inc(LigneCourante);
        Fvaleurs.MajGridVariab := true;
     end;
     screen.cursor := crDefault;
     donnees.clear;
     ListeNom.free;
     ListeU.free;
end; // AjouteColPageCourante

Function TformDDE.ImporteFichierTableur(const NomFichier : string) : boolean;

Function IsFichierEphemerides : boolean;
var ligne : string;

procedure verifChrome;
var termine : boolean;
    posAccent : integer;
begin
        repeat
             termine := true;
             posAccent := pos('Ã¨',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,1);
                ligne[posAccent] := 'è';
                termine := false;
             end;
             posAccent := pos('Ã©',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,1);
                ligne[posAccent] := 'é';
                termine := false;
             end;
             posAccent := pos('â€“',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,2);
                ligne[posAccent] := '-';
                termine := false;
             end;
             posAccent := pos('Ã‰',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,1);
                ligne[posAccent] := 'É';
                termine := false;
             end;
             posAccent := pos('Â°',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,1);
                termine := false;
             end;
             posAccent := pos('â€²',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,2);
                ligne[posAccent] := '''';
                termine := false;
             end;
             posAccent := pos('â€³',ligne);
             if posAccent>0 then begin
                delete(ligne,posAccent,2);
                ligne[posAccent] := '"';
                termine := false;
             end;
        until termine;
end;

var compteur,count : integer;
    extension : string;
begin
   result := false;
   extension := AnsiUpperCase(extractFileExt(nomFichier));
   if extension<>'.TXT' then exit;
   AssignFile(fichier,NomFichier);
   Reset(fichier);
   compteur := 0;count := 0;
   repeat
         readln(fichier,ligne);
         verifChrome;
         if pos('Éphémérides',ligne)>0 then inc(compteur);
         if pos('Héliocentre',ligne)>0 then inc(compteur);
         if pos('Corps du système solaire',ligne)>0 then inc(compteur);
         if pos('Système de coordonnées',ligne)>0 then inc(compteur);
         if pos('Sphériques',ligne)>0 then inc(compteur);
         if pos('Époque',ligne)>0 then inc(compteur);
         if pos('Astrométrique',ligne)>0 then inc(compteur);
         if pos('Colonnes',ligne)>0 then inc(compteur);
         inc(count);
   until eof(fichier) or (compteur>4) or (count>7);
   result := compteur>4;
   CloseFile(fichier);
end;

Function IsFichierVspec : boolean;
var fichier,newFile : textFile;
    carac,oldCarac : char;
    compteur,count : integer;
begin
   result := false;
   AssignFile(fichier,NomFichier);
   Reset(fichier);
   compteur := 0;count := 0;
   try
   repeat
         read(fichier,carac);
         case carac of
              #0 : result := true;
              '.' : if compteur = 0 then compteur := 1;
              's' : if compteur = 1 then compteur := 2;
              'p' : if compteur = 2 then compteur := 3;
              'c' : if compteur = 3 then compteur := 4;
              crCR : if compteur = 4 then compteur := 5;
              else begin
                 compteur := 0;
                 inc(count);
              end;
         end;
   until eof(fichier) or (compteur=5) or (count>128);
   result := result and (compteur=5);
   except
       result := false;
   end;
   if result then begin // ne pas tenir compte du début
      AssignFile(newFile,'vspecregressi.txt');
      Rewrite(newFile);
      readln(fichier);// CR + LF
      oldCarac := #0;
      repeat
         read(fichier,carac);
         if (carac<>crCR) or (oldCarac<>crCR) then write(newFile,carac);
         oldCarac := carac;
      until eof(fichier);
      closeFile(newFile);
      Donnees.LoadFromFile('vspecregressi.txt');
   end;
   CloseFile(fichier);
end;

begin
     Donnees.clear;
     result := false;
     if IsFichierEphemerides then begin
        ModeAcquisition := AcqFichier;
        donnees.LoadFromFile(nomFichier);
        result := extraitEphemerides;
        exit;
     end;
     try
     if not IsFichierVspec then Donnees.LoadFromFile(NomFichier);
     except
        on E:exception do begin
           strErreurFichier := E.message;
           exit;
        end;
     end;
     try
      if GetData
         then result := true
         else strErreurFichier := erFormat;
     ModeAcquisition := AcqFichier;
     except
         strErreurFichier := erFormat;
     end;
     donnees.Clear;
end; // ImporteFichierTableur

Procedure TformDDE.ExporteFichierTableur(const NomFichier : string);
type TtypeFichier = (tfCSV,tfTXT,tfAutre);
var typeFichier : TtypeFichier;
    FichierAsc : textFile;

Procedure sautDeLigne;
begin
    if typeFichier=tfCSV then write(FichierAsc,crLF) else writeln(fichierAsc)
end;

var
    i,j,iVar : integer;
    separeValue : char;
    extension,chaine : string;
begin
     extension := AnsiUpperCase(ExtractFileExt(NomFichier));
     typeFichier := tfAutre;
     if extension='.CSV' then typeFichier := tfCSV;
     if extension='.TXT' then typeFichier := tfTXT;
     SelectColonneDlg := TSelectColonneDlg.create(self);
     selectColonneDlg.CSVCB.visible := typeFichier=tfCSV;
     if (SelectColonneDlg.showModal=mrCancel) or
        (selectColonneDlg.selVariab.count<1) then begin
        selectColonneDlg.free;
        exit;
     end;
     case typeFichier of
        tfCSV : if (FormatSettings.decimalSeparator='.') or selectColonneDlg.CSVCB.checked
            then separeValue := ','
            else separeValue := ';'
        else separeValue := crTab;
     end;
     try
     AssignFile(fichierAsc,NomFichier);
     Rewrite(fichierAsc);
     if typeFichier=tfAutre then
        writeln(fichierAsc,pages[pageCourante].TitrePage);
     if not selectColonneDlg.valeursSeulesCB.checked then begin
        chaine := '';
        for i := 0 to pred(selectColonneDlg.selVariab.count) do begin
            iVar := selectColonneDlg.selVariab[i];
            if chaine<>'' then chaine := chaine+separeValue;
            chaine := chaine+grandeurs[iVar].nom;
        end;
        write(fichierAsc,chaine);
        sautDeLigne;
        chaine := '';
        for i := 0 to pred(selectColonneDlg.selVariab.count) do  begin
             if chaine<>'' then chaine := chaine+separeValue;
             iVar := selectColonneDlg.selVariab[i];
             chaine := chaine+grandeurs[iVar].nomUnite;
        end;
        write(fichierAsc,chaine);
        sautDeLigne;
     end;
     if typeFichier=tfAutre then begin
        chaine := '';
        for i := 0 to pred(selectColonneDlg.selVariab.count) do begin
               if chaine<>'' then chaine := chaine+separeValue;
               iVar := selectColonneDlg.selVariab[i];
               chaine := chaine+grandeurs[iVar].fonct.expression;
            end;
        write(fichierAsc,chaine);
        sautDeLigne;
     end;
     with pages[pageCourante] do
          for j := 0 to pred(Nmes) do begin
                chaine := '';
                for i := 0 to pred(selectColonneDlg.selVariab.count) do begin
                       if chaine<>'' then chaine := chaine+separeValue;
                       iVar := selectColonneDlg.selVariab[i];
                       if (typeFichier=tfCSV) and (separeValue=';')
                         then chaine := chaine+FloatToStr(valeurVar[iVar,j])
                         else chaine := chaine+FloatToStrPoint(valeurVar[iVar,j]);
                    end;
            write(fichierAsc,chaine);
            sautDeLigne;
     end; // for j
     if (NbreConst>0) and (typeFichier=tfAutre) then begin
        writeln(fichierAsc);
        for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG=constante then
               write(fichierAsc,grandeurs[i].nom,separeValue);
        writeln(fichierAsc);
        for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG=constante then
               write(fichierAsc,grandeurs[i].nomUnite,separeValue);
        writeln(fichierAsc);
        for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG=constante then
               write(fichierAsc,grandeurs[i].fonct.expression,separeValue);
        writeln(fichierAsc);
        for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG=constante then
               write(fichierAsc,FloatToStrPoint(pages[pageCourante].valeurConst[i]),separeValue);
        writeln(fichierAsc);
     end;
     closeFile(FichierAsc);
     except
     end;
     selectColonneDlg.free;
end; // ExporteFichierTableur

procedure TFormDDE.FocusAcquisition;

Function lance : boolean;
var hSemaphore : integer;
    CharVal: array[0..1024] of Char;
    StartInfo   : TStartupInfo;
    ProcessInfo : TProcessInformation;
begin
   result := true;
  // if pos(stAvi,nomCourt)>0  then include(menuPermis,imVitesse);
   StrPCopy(CharVal, NomAcqCourt);
   hSemaphore := CreateSemaphore(nil,0,1,CharVal);
   premierAppel := true;
   if (hSemaphore<>0) and
      (GetLastError = Error_Already_Exists) then begin
         timerOpenDDE.interval := 1000;
         timerOpenDDE.Enabled := true;
         exit;
   end;
// Mise à zéro de la structure StartInfo
   FillChar(StartInfo,SizeOf(StartInfo),#0);
// Seule la taille est renseignée, toutes les autres options
// laissées à zéro prendront les valeurs par défaut
   StartInfo.cb := SizeOf(StartInfo);
// Lancement de la ligne de commande
   screen.Cursor := crHourGlass;
   result := CreateProcess(Nil, PWideChar(nomExeAcquisition), Nil, Nil, False,
                0, Nil, Nil, StartInfo, ProcessInfo);
   timerOpenDDE.interval := 5000;
   if result
      then timerOpenDDE.enabled := true // problème de réponse du réseau
      else screen.Cursor := crDefault;
end;

var repert : string;
begin with ClientDDE do
    if (nomExeAcquisition='') or not FileExists(nomExeAcquisition)
        then begin
             showMessage(erProgAcq);
        end
        else begin
             NomAcqCourt := AnsiUpperCase(ExtractFileName(nomExeAcquisition));
             NomAcqCourt := ChangeFileExt(NomAcqCourt,'');
             repert := ExtractFilePath(nomExeAcquisition);
             if repert[length(repert)]='\' then delete(repert,length(repert),1);
             chdir(repert);
             ServiceApplication := nomExeAcquisition;
             Lance;
        end;
end;


procedure TFormDDE.AjouteMemo(Amemo : TcustomMemo);
var i : integer;
begin
  Editor.lines.Add('');
  for i := 0 to pred(Amemo.lines.count) do
      Editor.lines.Add(Amemo.lines[i]);
  Editor.lines.Add('');
end;

procedure TFormDDE.AjouteStringList(AstringList : TstringList);
var i : integer;
begin
    Editor.font.size := 10;
    Editor.selAttributes.size := 10;
    Editor.lines.Add('');
    for i := 0 to pred(AstringList.count) do
        Editor.lines.Add(AstringList[i]);
end;

procedure TFormDDE.EnvoieRTF;
begin
    Editor.SelStart := 0;
    Editor.SelLength := length(editor.text);
    Editor.copyToClipBoard;
end;

procedure TFormDDE.RazRTF;
begin
    Editor.Clear;
end;

procedure TFormDDE.TimerOpenDDETimer(Sender: TObject);
begin with ClientDDE do begin
             ServiceApplication := nomExeAcquisition;
             SetLink(NomAcqCourt,'ServeurDDE');
             screen.Cursor := crDefault;
             TimerOpenDDE.Enabled := false;
             if OpenLink then begin
                 ClientDDE.ExecuteMacro('Focus',false);
                 ClientDDE.closeLink;
             end
             else if premierAppel
                then begin // deuxième essai
                   TimerOpenDDE.Enabled := true;
                   screen.Cursor := crHourGlass;
                   premierAppel := false;
                end
                else showMessage(erProgAcqDialog+nomAcqCourt);
end end;

procedure TFormDDE.AjouteGrid(Agrid : TstringGrid);
var r,c,Lcol,Lrow,col2 : integer;
    Texte : String;
begin with aGrid do begin
      Editor.font.size := 8;
      Editor.selAttributes.size := 8;
      Editor.lines.Add('');
      if (cells[0,0]='') or
         ((cells[0,0]='i') and (cells[0,1]=''))
        then Lcol := 1
        else Lcol := 0;
      if permuteColRow
         then begin
            Lrow := Lcol;
            Lcol := 0;
            while Lcol<rowcount do begin
               col2 := Lcol+nbreTab; { NbreTab colonnes de 10 = 80 carac }
               if col2>=rowCount then col2 := pred(rowCount);
               for r := Lrow to pred(colCount) do begin
                   Texte := '';
                   for c := Lcol to col2 do
                       if c<2
                          then Texte := Texte+Agrid.Cells[r,c]+crTab
                          else Texte := Texte+Agrid.cells[r,c]+crTab;
                   delete(Texte,length(texte),1);
                   Editor.lines.Add(Texte);
               end; {for r}
               Lcol := col2+1;
            end;
         end {then}
         else begin
            for r := 0 to 1 do begin // texte
                texte := '';
                for c := Lcol to pred(colCount) do
                    Texte := Texte+Agrid.Cells[c,r]+crTab;
                Editor.lines.Add(Texte);
            end;
            for r := 2 to pred(rowCount) do begin // nombre
                texte := '';
                for c := Lcol to pred(colCount) do
                    Texte := Texte+Agrid.cells[c,r]+crTab;
                Editor.lines.Add(Texte);
            end;
        end;
      Editor.lines.Add('');
      Editor.font.size := 10;
      Editor.selAttributes.size := 10;
end end;

procedure TFormDDE.MemoAddComm(const Astr : string);
begin
       if Astr<>'' then Fvaleurs.Memo.Lines.Add(''''+Astr)
end;

procedure TFormDDE.ChercheTab;

Function LigneDeChiffresCSV(const s : String) : boolean;
var j : integer;
    AvecChiffres : boolean;
begin
    Result := false;
    AvecChiffres := false;
    for j := 1 to length(s) do
        if charinset(s[j],caracNombre)
           then avecChiffres := true
           else if not charinset(s[j],separateur) then exit;
    result := avecChiffres;
    if result then begin
       if pos(';',s)>0 then begin
          separateurCSV := ';';
          if pos(',',s)>0 then avecTab := sSemiColon; // 1,23;1,58
       end;
       if pos('.',s)>0 then begin
          separateurCSV := ',';
          if pos(',',s)>0 then avecTab := sComma; // 1.23,1.59
       end;
    end;
end;

var i : integer;
begin
     AvecTab := sBlanc;
     separateurCSV := crTab;
     if (donnees.count<3) then exit;
     i := 0;
     while (AvecTab=sBlanc) and
           (i<Donnees.count) and
           (i<5) do begin
              if pos(crTab,Donnees[i])<>0 then begin
                 avecTab := sTab;
                 separateurCSV := crTab;
              end;
              inc(i);
     end;
     if (AvecTab=sBlanc) then begin
          i := 0;
          separateurCSV := ' ';
          repeat inc(i)
          until (i=Donnees.count) or
                (i=4) or
                ligneDeChiffresCSV(donnees[i]);
     end;
end;

function TformDDE.ChercheEnTeteVellman : boolean;
var posTime,posVoltage : integer;

Function GetCoeff(ligne : integer) : double;
var N : integer;
    division : double;
    i,j : integer;
    Nstr : string;
begin
    result := 1;
    Nstr := Donnees[ligne];
    trimComplet(Nstr);
    i := pos(':',Nstr);
    if i>0 then delete(Nstr,1,i);
    i := pos('=',Nstr);
    if (i=0) or (i=length(Nstr)) then exit;
    N := strToInt(copy(Nstr,1,i-1));
    if ligne=posVoltage then ZeroVellman := N*4;
    j := i+1;
    while (j<=length(Nstr)) and
          charinset(Nstr[j],chiffreEtc) do inc(j);
    division := StrToFloatWin(copy(Nstr,i+1,j-i-1));
    if Nstr[j]='m' then division := division/1000;
    if Nstr[j]='k' then division := division*1000;
    if Nstr[j]='µ' then division := division/1e6;
    result := division/N;
end;

var i : integer;
begin
     posTime := 0;
     posVoltage := 0;
     i := 0;
     zeroVellman := 0;
     repeat
         if pos('TIME STEP:',Donnees[i])>0 then posTime := i+1;
         if pos('VOLTAGE STEP:',Donnees[i])>0 then posVoltage := i+1;
         inc(i);
         result := (posTime>0) and (posVoltage>0);
     until result or (i>=donnees.count) or (i=8);
     if result then begin
        CoeffTempsVellman := GetCoeff(posTime); { 160 = 10ms }
        CoeffCH1Vellman := GetCoeff(posVoltage); { CH1:  32 = 5V }
        CoeffCH2Vellman := GetCoeff(posVoltage+1); { CH2:  32 = 5V }
     end;
end; // ChercheEnTeteVellman

Procedure TformDDE.extraitVellman;
var ligneCourante,i : integer;
begin
     LigneCourante := 0;
     for i := 0 to MaxGrandeurs do begin
         DecodeVariab[i] := indexVariabExp[i];
         DecodeConst[i] := indexConstExp[i];
         isPrecConst[i] := false;
         isPrecVariab[i] := false;
         NbrePrecConst := 0;
         NbrePrecVariab := 0;
     end;
     repeat inc(LigneCourante)
     until (LigneCourante=Donnees.count) or
            LigneDeChiffres(Donnees[ligneCourante]);
     modifFichier := true;
     while (ligneCourante<Donnees.count) and
            ExtraitValeur(variable,Donnees[LigneCourante],NbreVariab)
         do inc(LigneCourante);
     with pages[pageCourante] do begin
        commentaireP := Donnees[0];
        for i := 0 to pred(nmes) do begin
           valeurVar[0,i] := valeurVar[0,i]*coeffTempsVellman;
           valeurVar[1,i] := (valeurVar[1,i]-zeroVellman)*coeffCH1Vellman;
           valeurVar[2,i] := (valeurVar[2,i]-zeroVellman)*coeffCH2Vellman;
        end;
     end;
end;

procedure TFormDDE.FormCreate(Sender: TObject);
var c : integer;
begin
{$IFDEF Debug}
   ecritDebug('Début formCreate dde');
{$ENDIF}
     donnees := TstringList.create;
     Editor.paragraph.tabCount := nbreTab;
     for c := 0 to pred(NbreTab) do
         Editor.paragraph.tab[c] := c*48;
end;

procedure TFormDDE.FormDestroy(Sender: TObject);
begin
     donnees.free;
     inherited
end;

Procedure TformDDE.extraitCassy(ajout : boolean);
var ligne,i,k : integer;
    index : integer;
    ligneCourante : string;
    chaineS,chaineU,chaineN : string;
begin
     ligne := 0;
     repeat inc(ligne)
     until (ligne>=Donnees.count) or (pos('DEF=',Donnees[ligne])>0);
     if ligne=Donnees.count then exit;
     k := 3;
     i := 0;
     ligneCourante := Donnees[ligne];
     while (k<length(ligneCourante)) do begin
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]<>'"') do inc(k);
           inc(k);
           chaineS := '';
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]<>'"') do begin
              chaineS := chaineS+ligneCourante[k];
              inc(k);
           end;
           inc(k);  { " }
           chaineN := '';
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]<=' ') do inc(k);
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]>' ') do begin
              chaineN := chaineN+ligneCourante[k];
              inc(k);
           end;
           chaineU := '';
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]<>'/') do inc(k);
           inc(k);
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]<=' ') do inc(k);
           while (k<length(ligneCourante)) and
                 (ligneCourante[k]>' ') do begin
              chaineU := chaineU+ligneCourante[k];
              inc(k);
           end;
           if ajout
              then begin
                   DecodeVariab[i] := indexNom(chaineN);
              end
              else begin
                 index := AjouteExperimentale(chaineN,variable);
                 grandeurs[index].nomUnite := chaineU;
                 grandeurs[index].fonct.expression := chaineS;
                 DecodeVariab[i] := index;
              end;
           inc(i);
     end;
     inc(ligne);
     modifFichier := true;
     while (ligne<Donnees.count) and
            ExtraitValeur(variable,Donnees[ligne],NbreVariab)
         do inc(ligne);
end;

procedure TFormDDE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    try
    clientDDE.closeLink
    except
    end;
end;

Function TFormDDE.ExtraitRepere(var ligne : integer) : boolean;
var NbreLigne,j,posTab : integer;
    valeur : double;
    s : string;
begin with pages[pageCourante] do begin
    if ligne>=Donnees.count then begin
       result := false;
       exit;
    end;
    s := Donnees[ligne];
    result := (pos('REPERE',s)>0) and (s[1]=symbReg2);
    if not result then exit;
    inc(ligne);
    NbreLigne := NbreLigneWin(s);
    j := 0;
    repeat
        inc(j);
        s := Donnees[ligne];
        posTab := pos(crTab,s);
        if posTab>2 then begin
           valeur := strToFloatWin(copy(s,1,pred(posTab)));
           s := copy(s,succ(posTab),length(s)-posTab);
           ajouteRepere(valeur,s);
        end;
        inc(ligne);
    until j=NbreLigne;
end end; // extraitRepere


function TFormDDE.ExtraitEphemerides : boolean;
const iDate = 0;

var DateStr,HeureStr : string;
    Debut : TdateTime;
    l : integer;
    NbreVoies : integer;
    Voies : array[indiceVoieEph] of TvoieEph;
    HelioCentrique,AngulaireGlb : boolean;
    iDistance : integer;
    iX,iY,iZ : integer;
    iLongitude : integer;
    commentaire : string;
    VoieDateTexte,voieHeureTexte : TvoieEph;
    NbreData : integer;
    acqFaite : boolean;
    VoiesString : TstringList;
    LigneCourante : string;

Procedure SepareVirgule;
begin
    voiesString.Clear;
    voiesString.Delimiter := ' ';
    trim(ligneCourante);
    voiesString.DelimitedText:= ligneCourante;
end;

procedure Recupere;
var index : array[indiceVoieEph] of integer;
    indexTxt : integer;

Procedure EcritPage;
var j : indiceVecteurEph;
    i,k : integer;
begin with pages[pageCourante] do begin
     commentaireP := Commentaire;
     nmes := NbreData;
     for i := 0 to pred(NbreVoies) do if Voies[i].utile then begin
         k := index[i];
         for j := 0 to pred(NbreData) do
             valeurVar[k,j] := StrToFloatWin(Voies[i].valeur[j]);
     end;
     for j := 0 to pred(NbreData) do
         TexteVar[indexTxt,j] := voieDateTexte.valeur[j];
end end;// ecritPage

Procedure ecritEnTeteTxt;
var i,zz : Integer;
begin
   Fvaleurs.memo.lines.add('''Données de l''institut de mécanique céleste et de calcul des éphémérides (IMCCE)');
   Fvaleurs.memo.lines.add(''''+Commentaire);
   for i := 0 to pred(NbreVoies) do if Voies[i].utile then begin
          zz := AjouteExperimentale(Voies[i].nom,variable);
          grandeurs[zz].nomUnite := Voies[i].unite;
          grandeurs[zz].fonct.expression := Voies[i].signif;
          index[i] := zz;
   end;
   indexTxt := AjouteExperimentale(voieDateTexte.nom,variable);
   grandeurs[indexTxt].fonct.genreC := g_texte;
   grandeurs[indexTxt].fonct.expression := voieDateTexte.signif;
end; // ecritEnTeteTxt

Procedure AjouteOptionRect;
begin with FgrapheVariab.graphes[1] do begin
     Coordonnee[1].nomX := voies[iX].nom;
     Coordonnee[2].nomX := voies[iX].nom;
     Coordonnee[1].nomY := voies[iY].nom;
     Coordonnee[2].nomY := voieDateTexte.nom;
     optionGraphe := [OgOrthonorme];
end end;

Procedure AjouteOptionAngle;
begin with FgrapheVariab.graphes[1] do begin
     Coordonnee[1].nomX := voies[iLongitude].nom;
     Coordonnee[2].nomX := voies[iLongitude].nom;
     Coordonnee[1].nomY := voies[iDistance].nom;
     Coordonnee[2].nomY := voieDateTexte.nom;
     optionGraphe := [OgOrthonorme,OgPolaire];
end end;

begin
    ecritEnTeteTxt;
    if ajoutePage then ecritPage;
    if angulaireGlb then ajouteOptionAngle else ajouteOptionRect;
    FgrapheVariab.configCharge := true;
    FgrapheVariab.majFichierEnCours := true;
end; // Recupere

Function SexVersDecEph(degStr,minStr,secStr : string) : string;
var deg,minute,seconde,valeur : extended;
    negatif : boolean;
begin
   negatif := degStr[1]='-';
   if negatif then delete(degStr,1,1);
   deg := StrToInt(degStr);
   minute := StrToInt(minStr);
   seconde := StrToFloatWin(secStr);
   valeur := deg+minute/60+seconde/3600;
   if negatif then valeur := -valeur;
   result := FloatToStrF(valeur,ffFixed,12,12);
end;

Function RecupereAngle(chaine : string) : string;
var c : integer;
    items : array[1..3] of string;
    zz : string;
begin
    if (pos('°',chaine)>0) or (pos('''',chaine)>0)
    then begin // sexagésimal
       for c := 1 to 3 do Items[c] := '0';
       zz := '';
       for c := 1 to length(chaine) do begin
          if charInSet(chaine[c],['0'..'9','.','-','+'])
          then zz := zz + chaine[c]
          else begin
             case chaine[c] of
               '°' : items[1] := zz;
               '''' : items[2] := zz;
               '"' : items[3] := zz;
             end;
             zz := '';
          end;
       end;
    result := SexVersDecEph(Items[1],Items[2],Items[3]);
    end
    else begin // décimal
        result := chaine;
    end;
end;

Procedure RecupereDateHeure(chaine : string);
var posT : integer;
    anneeS,moisS,jourS : string;
begin
    posT := pos('T',chaine);
    if posT=0 then exit;
    DateStr := copy(chaine,1,posT-1);
    HeureStr := copy(chaine,posT+1,length(chaine)-posT);
    posT := pos('.',HeureStr);
    if posT>0 then delete(heureStr,posT,length(HeureStr));
 // on ôte les centième de seconde
    trim(dateStr);
    posT := pos('-',dateStr);
    if posT=0 then exit;
    anneeS := copy(dateStr,1,posT-1);
    dateStr := copy(dateStr,posT+1,length(dateStr));
    posT := pos('-',dateStr);
    if posT=0 then exit;
    moisS := copy(dateStr,1,posT-1);
    jourS := copy(dateStr,posT+1,length(dateStr));
    dateStr := jourS+'/'+moisS+'/'+anneeS;
end;

procedure verifNoms;
var i : integer;
    nomMaj : string;
begin
    for i := 0 to pred(NbreVoies) do with voies[i] do begin
       if unite='deg' then unite := '°';
       if unite='au' then unite := 'ua';
       if unite='undefined' then unite := '';
       nomMaj := UpperCase(nom);
       utile := false;
       if nomMaj='DIST-DOT' then continue;
       if 'TT'=nomMaj then continue; // signif := 'temps universel coordonné (heure en fraction de jour)';
       if (nomMaj='VR') or (nomMaj='RV') then continue; // vitesse radiale / observateur
       if nomMaj='TSL' then continue; // signif := 'Temps sidéral local'; unite := 'jour';
       if nomMaj='TT - UTC' then continue; // signif := 'Différence entre le temps terrestre et le temps universel coordonné';
       if pos(DeltaMaj,nom)>0 then continue;
       if nomMaj='DATE' then begin
          nom := 't';
          unite := 'jour';
          signif := 'durée en jours depuis le premier point';
          utile := true;
       end;
       if (nomMaj='DG') or (nomMaj='DGEO') then begin
           signif := 'Distance géocentrique';
           utile := true;
       end;
       if (nomMaj='DH') or (nomMaj='DHELIO') then begin
           signif := 'Distance héliocentrique';
           utile := true;
       end;
       if nomMaj='DOBS' then begin
           signif := 'Distance entre le centre de l’astre et l’observateur';
           utile := true;
           nom := 'd';
           iDistance := i;
       end;
       if (nomMaj='X') or
          (nomMaj='Y') or
          (nomMaj='Z') or
          (nomMaj='PX') or
          (nomMaj='PY') or
          (nomMaj='PZ')
          then begin
                signif := 'position cartésienne';
                if (nomMaj='X') or (nomMaj='PX') then begin
                   iX := i;
                   nom := 'x';
                end;
                if (nomMaj='Y') or (nomMaj='PY') then begin
                  iY := i;
                  nom := 'z';
                end;
                if (nomMaj='Z') or (nomMaj='PZ') then begin
                  iZ := i;
                  nom := 'z';
                end;
                angulaire := false;
                utile := true;
          end;
       if (nomMaj='XP') or
          (nomMaj='YP') or
          (nomMaj='ZP') or
          (nomMaj='VX') or
          (nomMaj='VY') or
          (nomMaj='VZ')
          then ; // unite := 'ua/jour'; signif := 'vitesse cartésienne';  XP=x prime
        if pos('ELONG',nomMaj)=1 then begin
           signif := 'Elongation (angle entre les directions Terre/corps et Terre/Soleil)';
           nom := 'Elong';
           utile := true;
        end;
        if (pos('LONG',nomMaj)=1) or (nom=lambdaMin) then begin
            signif := 'Longitude';
            angulaire := true;
            iLongitude := i;
            utile := true;
            nom := lambdaMin;
        end;
        if nomMaj='UTC' then begin
            signif := 'Temps universel coordonné (heure en fraction de jour)';
            unite := 'jour';
            utile := true;
        end;
        if nomMaj='T-L' then begin
           signif := 'Temps mis par la lumière pour parcourir la distance séparant l’astre de l’observateur';
           unite := 'jour';
           nom := 'TL';
           utile := true;
        end;
        if nom='h' then begin
           signif := 'Hauteur compté de 0 à 90° à partir de l''horizon';
           utile := true;
        end;
        if nom='H' then begin
           signif := 'Angle horaire';
           utile := true;
        end;
        if nomMaj='AZ' then begin
           signif := 'azimut compté de 0 à 360° à partir du nord';
           utile := true;
        end;
        if (nomMaj='LAT') or (nom=beta) then begin
              signif := 'Latitude';
              angulaire := true;
              utile := true;
              nom := beta;
        end;
        if nomMaj='PHASE' then begin
           signif := 'angle de phase en degré';
           utile := true;
        end;
        if (nomMaj='DEC') or (nom=deltaMin) then begin
              signif := 'Déclinaison';
              angulaire := true;
              angulaireGlb := true;
              utile := true;
              nom := deltaMin;
        end;
        if (nomMaj='RA') or (nom=alpha) then begin
              signif := 'ascension droite';
              utile := true;
              angulaire := true;
              angulaireGlb := true;
              iLongitude := i;
              nom := alpha;
        end;
        if (nomMaj='MV') or (nomMaj='VMAG') then begin
           signif := 'magnitude visuelle apparente';
           utile := true;
           nom := 'Vmag';
        end;
        if nomMaj='DISTANCE' then begin
           nom := 'r';
           utile := true;
           iDistance := i;
           if heliocentrique
              then signif := 'distance au soleil en unité astronomique'
              else signif := 'distance à la terre en unité astronomique';
        end;
    end;// for i
end;

Function ChercheVariablesCB(l : integer) : boolean;
var i : integer;
begin
    ligneCourante := donnees[l];
    for i := 0 to MaxVoiesEph do with voies[i] do begin
       nom := '';
       unite := '';
       signif := '';
       utile := false;
       angulaire := false;
    end;
    separeVirgule;
    NbreVoies := voiesString.Count;
    if NbreVoies>MaxVoiesEph then NbreVoies := MaxVoiesEph;
    for i := 0 to pred(NbreVoies) do
        voies[i].nom := voiesString[i];
    result := true;
end; // ChercheVariablesCB

Procedure ChercheUnitesCB(l : integer);
var i : integer;
begin
    ligneCourante := donnees[l];
    separeVirgule;
    if voiesString.count<NbreVoies then begin
       ligneCourante := 'undefined '+ligneCourante;
       separeVirgule;
    end;
    for i := 0 to pred(NbreVoies) do
        voies[i].unite := voiesString[i];
    verifNoms;
end; // ChercheUnitesCB

Function recupereHeure(chaine : string) : string;
// 4:17:33.8037
var posPoint,posPointSuivant : integer;
    compteur : integer;
begin
     posPoint := pos('.',chaine);
     if posPoint>0 then delete(chaine,posPoint,length(chaine)-1);
// on ôte les centièmes de seconde
     trim(chaine); // on ôte les blanc d'en-tête
     compteur := 0;
     repeat
       posPoint := pos(' ',chaine);
       if posPoint>0 then begin
          chaine[posPoint] := ':';
          posPointSuivant := pos(' ',chaine);
          if posPointSuivant=posPoint+1 then chaine[posPointSuivant] := '0';
       end;
     until (posPoint=0); // on remplace blanc par : et double espace par :0
     posPoint := pos(':',chaine);
     if posPoint>0 then begin
        inc(compteur);
        posPoint := pos(':',copy(chaine,posPoint+1,length(chaine)));
        if posPoint>0 then inc(compteur)
     end;
     if compteur<2 then chaine := '0:'+chaine;  // pas d'heure = heure 0
     result := chaine;
end;

function analyseEnTeteTxt(var l : integer) : boolean;
var index : integer;
    posParO,posParF : integer;
    i : integer;
begin
    l := 0;
    result := false;
    commentaire := '';
    repeat
       LigneCourante := donnees[l];
       if (pos('Options',LigneCourante)>0)
          then
          else if (pos('Colonnes',LigneCourante)>0) then
          else if (pos('$$',LigneCourante)>0) then result := true  // SOE Start of Entry
          else if (pos('Corps',LigneCourante)>0) then begin  // targetName
              separeVirgule;
              for i := 0 to voiesString.Count-2 do begin
                  posparO := pos(':',voiesString[i]);
                  if posParO>0 then begin
                     Commentaire := voiesString[i+1];
                     break;
                  end;
              end;
          end
          else if (pos('coordonn',LigneCourante)>0) then begin
              helioCentrique := (pos('liocentre',LigneCourante)>0); // Sinon géocentrique
              commentaire := commentaire+' : '+ligneCourante;
          end
          else if (length(ligneCourante)>1) and charInSet(ligneCourante[1],['0'..'9']) then begin
             posParO := pos(':',ligneCourante);
             index := strToInt(copy(ligneCourante,1,posParO-1));
             nbreVoies := index;
             dec(index);
             ligneCourante := copy(ligneCourante,4,length(ligneCourante));
             voies[index].Nom := trim(ligneCourante);
             voies[index].unite := '';
             posParO := pos('(',ligneCourante);
             posParF := pos(')',ligneCourante);
             if (posParO>0) and (posParF>0) then begin
                voies[index].unite := copy(ligneCourante,posParO+1,posParF-posParO-1);
                voies[index].nom := trim(copy(ligneCourante,1,posParO-1));
             end;
          end;
       inc(l);
    until result or (l>=donnees.count);
    if not result then begin
       showMessage('Impossible de décoder');
       acqFaite := false;
    end
    else verifNoms;
end; // analyseEnteteTxt

procedure chercheData(l0 : integer);
var dateCourante : double;
    i : integer;
begin
    nbreData := 0;
    l := l0;
    while (l<donnees.count) and
          (length(donnees[l])>16) and
          (charInSet(donnees[l][1],['0'..'9'])) do begin
         ligneCourante := donnees[l];
         separeVirgule;
         for i := 0 to pred(NbreVoies) do with voies[i] do begin
             if nom='t' then begin
                RecupereDateHeure(voiesString[i]);
                dateCourante := double(strToDate(DateStr))+double(strToTime(HeureStr));
                if NbreData=0 then debut := dateCourante;
                voieDateTexte.valeur[NbreData] :=
                    FormatDateTime('dd mmm yyyy',strToDate(DateStr));
                valeur[NbreData] := FloatToStr(DateCourante-debut);
                voieHeureTexte.valeur[NbreData] := heureStr;
             end
             else if (nom='UTC') then begin
                // hh:min:sec
                HeureStr := recupereHeure(voiesString[i]);
                voieHeureTexte.valeur[NbreData] := HeureStr;
                valeur[NbreData] := FloatToStr(Double(strToTime(HeureStr)));
             end
             else if (nom=lambdaMin) or
                     (nom=beta) or
                     (nom=deltaMin) then begin // ° ' "
                  valeur[NbreData] := RecupereAngle(voiesString[i]);
             end
             else if (nom=alpha) then begin // ascension droite en h min sec
                  HeureStr := recupereHeure(voiesString[i]);
                  valeur[NbreData] :=
                      FloatToStr(Double(strToTime(HeureStr))*360);
// conversion en jour fractionnaire puis degré
             end
             else if utile then begin // F17.13
                  trim(voiesString[i]);
                  valeur[NbreData] := voiesString[i];
             end;
         end;// for i
         inc(NbreData);
         inc(l);
    end;
end;

procedure verifChrome;
var i : integer;
    termine : boolean;
    posAccent : integer;
begin
    for I := 0 to pred(donnees.Count) do begin
        ligneCourante := donnees[i];
        repeat
             termine := true;
             posAccent := pos('Ã¨',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,1);
                ligneCourante[posAccent] := 'è';
                termine := false;
             end;
             posAccent := pos('Ã©',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,1);
                ligneCourante[posAccent] := 'é';
                termine := false;
             end;
             posAccent := pos('â€“',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,2);
                ligneCourante[posAccent] := '-';
                termine := false;
             end;
             posAccent := pos('Ã‰',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,1);
                ligneCourante[posAccent] := 'É';
                termine := false;
             end;
             posAccent := pos('Â°',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,1);
                termine := false;
             end;
             posAccent := pos('â€²',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,2);
                ligneCourante[posAccent] := '''';
                termine := false;
             end;
             posAccent := pos('â€³',ligneCourante);
             if posAccent>0 then begin
                delete(ligneCourante,posAccent,2);
                ligneCourante[posAccent] := '"';
                termine := false;
             end;
        until termine;
        donnees[i] := ligneCourante;
    end;
end;

var i : integer;
    v : indiceVoieEph;
label fin;
begin // ExtraitEphemerides
    l := 0;
    iX := 2; iY := 3; iZ := 4;
    iLongitude := 2;
    iDistance := 3;
    Commentaire := '';
    heliocentrique := true;
    angulaireGlb := true;
    nbreData := 0;
    nbreVoies := 0;
    acqfaite := false;
    voiesString := Tstringlist.Create;
    for v := 0 to MaxVoiesEph do
        voies[v] := TvoieEph.create;

    voieDateTexte := TvoieEph.create;
    voieDateTexte.signif := 'Date sous forme de texte';
    voieDateTexte.nom := 'Date';
    voieDateTexte.unite := '';

    voieHeureTexte := TvoieEph.create;
    voieHeureTexte.signif := 'Heure sous forme de texte';
    voieHeureTexte.nom := 'Heure';
    voieHeureTexte.unite := '';

    if donnees.count<2 then goto fin;
    VerifChrome;
    if not analyseEnTeteTxt(l) then goto fin;
    chercheData(l);
    AcqFaite := (NbreVoies>1) and (NbreData>2);
    if acqfaite then begin
       for i := 0 to pred(NbreData) do
           Voies[NbreVoies].valeur[i] := Voies[iDate].valeur[i]; // date format texte
       recupere;
    end;
    fin :
    result := acqFaite;
    voiesString.Free;
    VoieDateTexte.free;
    VoieHeureTexte.free;
    for v := 0 to MaxVoiesEph do Voies[v].free;
end;// ExtraitEphemerides

end.



