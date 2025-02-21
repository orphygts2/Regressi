
unit regutil;

interface

uses
  System.UITypes, System.Types, system.IOutils, System.StrUtils,
  system.Inifiles, system.SysUtils,
  Windows, Messages, Classes, Dialogs, Forms,
  Graphics, printers, controls, grids, clipBrd,
  Math, StdCtrls, comctrls, richedit, registry, shlObj,
  Vcl.FileCtrl, Vcl.graphUtil, Vcl.Menus,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  constreg, maths,
  //Winapi.GDIPAPI,
  pngImage, gripSplitter, gifImg,
  OOmisc, adport, lnswin32, awuser,
  VCL.buttons,VCL.samples.spin,VCL.VirtualImageList;

var
  fichier : textFile;
  ExemplesDir,VideoDir,ImagesDir,wavDir,arduinoExe,dataDir,PythonDir,PythonDllDir : String;
  DocRegPdf,DocRegWord,DocIncertitudes,DocModelisation : string;
  GroupeDir : String;
  finFichierWin : boolean;
  autoIncrementation : boolean;
  ligneWin,userName : string;
  mesDocsDir : string;
  TempDirReg,programDir : string;
  ModifFichier : boolean;
  AcqList : TStringList;
  TexteModele : TstringList;
  NbreParamAnim : integer;
  SauvegardePermise : boolean = true;
  nomFichierIni : string;
  strErreurFichier : string;

// Les caractères au-delà de 7 bits sont différents selon l'encodage...
// £ encodé en UTF-8 donne (194)(163) ce qui, lu en latin-1, fait Â£.
// &                            (167)

{$IFDEF Debug}
      fichierDebug : textFile;
{$ENDIF}

const
        longNombre = 10;
        maxPages = 32;
        IntervalleSauvegarde = 1/(24*6); // 1 jour=1 donc 10 minutes
        RegistreReg = 'Software\Regressi';
        HautGrapheTxt = 0.32;// Hauteur graphe avec texte
        HautGrapheGr = 0.43;// Hauteur graphe seul
        HautGraphePaysage = 0.90; // Hauteur graphe seul pleine page
        PrecisionMin = 3;
        PrecisionMax = 15; // Precision double pour FloatToStrF
        PrecisionMaxIncert = 6; // Precision double pour FloatToStrF
        LongNom = 32;
        SymbReg : char = '£';
        SymbReg2 : char = '&';
        MaxPasAnim = 8192;
        MaxPasAnimTemps = 128;
        MinPasAnimTemps = 16;
        NbreItemParamAnim = 7;
        DetectUnicode = #194;

        UneHeure = 3600; // secondes
        UnJour = 24*UneHeure;
        UnMois = UnJour*365.25/12;
        QuartdHeure = 15*60;
        UneMinute = 60;
        UneSeconde = 1;

        UneHeureWin = 1/24; { 1 jour = 1.000 }
        QuartdHeureWin = 1/(24*4);
        UneMinuteWin = 1/(24*60);
        UneSecondeWin = 1/(24*60*60);
        UnMoisWin = 365.25/12;
        unAnWin = 365.25;
        unJourWin = 1;

        crLettre = 1;
        crGomme = 2;
        crPencil = 3;
        crZoom = 4;
        crCible = 5;
        crCibleMove = 6;
        crOrigine = 7;
        crRectangle = 8;
        crOrigineTemps = 9;

        MaxAcq = 12;
        MaxParamAnim = 12;

        WM_Reg_Maj = WM_USER + 0;
        WM_Reg_Calcul = WM_USER + 1;
        WM_Reg_Origine = WM_USER + 2;
        WM_Reg_Fichier = WM_USER + 3;
        WM_Reg_InitMagnum = WM_USER + 4;
        WM_Reg_Modele = WM_USER + 6;
        WM_Reg_Animation = WM_USER + 7;
        WM_Maj_AVI = WM_USER + 9;
        WM_Maj_Wav = WM_USER + 10;

{
    protected
    procedure WMRegMaj(var Message: TWMRegMAj); message WM_reg_Maj;

    procedure TMyComponent.WMRegMaj(var Message: TWMRegMaj);
    begin
       ...
      inherited;
    end;
}

        MajModele = 0; { modification de l'expresssion du modèle }
        MajGrandeur = 1; { modification de l'expression des grandeurs }
        MajValeur = 2;{ modification des valeurs expérimentales dans tableur }
        MajFichier = 3; { général après chargement de fichier ... }
        MajChangePage = 4; { changement de page }
        MajAjoutPage = 5; { ajout de page }
        MajSupprPage = 6; { suppression de page }
        MajVide = 7; { nettoyage }
        MajTri = 9; { modif de l'ordre }
        MajIncertitude = 12;
        MajPolice = 10;
        MajSuperposition = 13;
        MajNumeroMesure = 14;
        MajUnites = 15;
        MajValeurAcq = 16;{ modification des valeurs expérimentales par acquisition }
        MajModeleGlb = 18;{ modification du modèle des paramètres }
        MajUnitesParam = 19;
        MajSupprPoints = 20;
        MajNom = 22; { Modif d'un nom }
        MajAjoutValeur = 23; { ajout d'un point en mode clavier }
        MajSelectPage = 24; { changement de sélection des pages }
        MajPreferences = 25; { préférences de couleurs ... }
        MajGroupePage = 26; { groupement de pages }
        MajOptionsGraphe = 27; { groupement de pages }
        MajValeurGr = 28;{ modification des valeurs expérimentales dans le graphe }
        MajSauvePage = 29; { avant de changer de page }
        MajValeurConst = 30; { modification des valeurs des paramètres dans tableur }
        MajEquivalence = 31; { modification calcul dérivée donc équivalences à revoir}

        CalculCompile = 1;
        CalculRemplit = 2;
        CalculAjuste = 3;
        CalculModele = 4;

        alpha=WideChar($03B1);alphaMaj=WideChar($0391);
        beta=WideChar($03B2);betaMaj=WideChar($0392);
        gammaMin=WideChar($03B3);gammaMaj=WideChar($0393);
        deltaMin=WideChar($03B4);deltaMaj = WideChar($0394);
        chi=WideChar($03C7);chiMaj=WideChar($03A7);
        epsilon=WideChar($03B5);epsilonMaj=WideChar($0395);
        upsilon=WideChar($03C5);upsilonMaj=WideChar($03A5);
        iota=WideChar($03B9);iotaMaj=WideChar($0399);
        phiMin=WideChar($03C6);phiMaj=WideChar($03A6);
        eta=WideChar($03B7);etaMaj=WideChar($0397);
        lambdaMaj=WideChar($039B);lambdaMin=WideChar($03BB);
        nu=WideChar($03BD);nuMaj=WideChar($039D);
        xiMaj=WideChar($039E);xi=WideChar($03BE);
        piMin=WideChar($03C0);piMaj=WideChar($03A0);
        thetaMaj=WideChar($0398);theta=WideChar($03B8);
        rho=WideChar($03C1);rhomaj=WideChar($03A1);
        sigmaMin=WideChar($03C3);sigmaMaj=WideChar($03A3);
        tau=WideChar($03C4); tauMaj=WideChar($03A4);
        omegaMin=WideChar($03C9);omegaMaj=WideChar($03A9);
        psi=WideChar($03C8);psiMaj=WideChar($03A8);
        zeta=WideChar($03B6);zetaMaj=WideChar($0396);
        mu=WideChar($03BC);muMaj=WideChar($039C);
        kappa=WideChar($03BA);kappaMaj=WideChar($039A);
        omicron=WideChar($03Bf);omicronMaj=WideChar($039F);
        pourMille=WideChar(8240);cdot=WideChar($22C5);// inconnu de Segoe
        pointMedian=WideChar($00B7);puce=WideChar($2219);
        SymbRegUnicode=WideChar(163);
        SymboleAngstrom=WideChar($00C5);


        ChiffreExp : array[0..9] of Char =
  (Char($2070),Char($00B9),Char($00B2),Char($00B3),
   Char($2074),Char($2075),Char($2076),Char($2077),
   Char($2078),Char($2079)); // Tahoma 1 2 3 uniquement

       MoinsExp = Char($207B); // pas Tahoma
       PlusExp = Char($207A);
       supEgal = Char($2265);
       infEgal = Char($2264);

       RepereConst = 'Cte:';
       SeparateurConst =  '________________';

type
    TRGBTripleArray = ARRAY[Word] of TRGBTriple;
    pRGBTripleArray = ^TRGBTripleArray; // Use a PByteArray for pf8bit color.
    Tincertitude = (iEllipse,iCroix,iRectangle);
    TAffIncertParam = (iType,i95,iBoth);
    EGetFloatError = class(Exception);
    TdispositionFenetre = (dMaxi,dCascade,dMosaicVert,dMosaicHoriz,dNone);
 //   TgrapheClipBoard = (gcEMF,gcJpeg,gcBitmap,gcPng);
    TgrapheClipBoard = (gcJpeg,gcBitmap,gcPng);
    TnombreFormat = (fDefaut,fExponent,fFixed,
       fLongueDuree,fDateTime,fDate,fTime,fDegreMinute,
       fBinary,fHexa);
    TligneRappel = (lrEquivalence,lrTangente,lrXdeY,lrReticule,lrEquivalenceManuelle,lrX,lrY,lrPente);
    TsetLigneRappel = set of TligneRappel;
    Tgraduation = (gLin,gLog,gInv,gdB,gBits);

    TstrListe = class(TstringList)
         public
             function MyIndexOf(const Item : string) : Integer;
    end;
    TWMRegMessage = record
       Msg: Uint;
       case Boolean of
          false: (WParam: WParam;LParam: LParam;Result: LResult);
          true: (TypeMaJ: WParam;CodeMaj : LParam;ResultR: LResult);
    end;

(*
TMessage = record
    Msg: Cardinal;
    case Integer of
      0: (
        WParam: WPARAM;
        LParam: LPARAM;
        Result: LRESULT);
      1: (
        WParamLo: Word;
        WParamHi: Word;
        WParamFiller: TDWordFiller;
        LParamLo: Word;
        LParamHi: Word;
        LParamFiller: TDWordFiller;
        ResultLo: Word;
        ResultHi: Word;
        ResultFiller: TDWordFiller);
  end;

*)

    TPrinterRecord = record
        Cur: TPoint;
        MargeTexte : integer;
        Finish: TPoint; // End of the printable area
        Height: Integer; // Height of the current line
        sauveOrientation : TprinterOrientation;
        PageH,PageW : integer;
    end;

        TCoefUnite = (zero,yocto,zepto,atto,femto,pico,nano,micro,milli,
               nulle,kilo,mega,giga,tera,peta,exa,zetta,yotta,infini);
        TmodeAcquisition = (AcqClavier,AcqFichier,AcqCan,AcqClipBoard,
                            AcqBitMap,AcqSimulation,AcqVideo,AcqSon,AcqChrono,
                            AcqCourbes,AcqArduino,AcqOscilloArduino);

        TparamAnimation = class
           groupBoxA : TgroupBox;
           sliderA : TtrackBar;
           groupBoxF : TgroupBox;
           sliderF : TtrackBar;
           nomA : string;
           codeA : integer;
           ValeurA,DebutA,FinA,PasA : double;
           Active,VariationLog,Ainitialiser : boolean;
           constructor create;
           procedure init;
           procedure litFichier(NbreItem : integer);
           procedure ecritFichier;
           procedure loadXML(Anode : IXMLNode);
           procedure storeXML(Anode : IXMLNode);
           function sliderMaxValue : integer;
        end;

const
        GridFontSize = 10;
        crSupprArr = char(vk_back);
        crSuppr = char(vk_delete);
        crHaut = char(vk_up);
        crBas = char(vk_down);
        crGauche = char(vk_left);
        crDroite = char(vk_right);
        crHome = char(vk_home);
        crEnd = char(vk_end);
        crCR = #13;
        crLF = #10;
        crESC = #27;
        crTab = char(vk_tab);
        Separateur : tSysCharSet = [' ',crTab,',',';'];
        NomModeAcq : array[TmodeAcquisition] of string =
            ('CLAVIER','FICHIER','EXTERNE','PRESSE-PAPIER','RS232',
             'SIMULATION','VIDEO','SON','CHRONOPHOTO','COURBES','ARDUINO','OSCILLOARDUINO');
        Majuscule   : tSysCharSet = ['A'..'Z'];
        Minuscule   : tSysCharSet = ['a'..'z'];
        LettreAccent = 'éèêëàâùïüô';

        Chiffre     : tSysCharSet = ['0'..'9'];
        ChiffreEtc : tSysCharSet = ['0'..'9','+','-','e','E','.'];
        ChiffreWin : tSysCharSet = ['0'..'9','+','-','e','E','.',','];
        CaracNombre : tSysCharSet = ['0'..'9','+','-','e','E','.',',','/',':'];
        CaracArduino : tSysCharSet = ['0'..'9','+','-','e','E',',',';','.',crCR,crLF];
        CaracDateTime : tSysCharSet = ['0'..'9','/',':',' ',crSupprArr,crSuppr,crTab,crCR];
        CaracDate : tSysCharSet = ['0'..'9','/',crSupprArr,crSuppr,crTab,crCR];
        CaracTime : tSysCharSet = ['0'..'9',':',crSupprArr,crSuppr,crTab,crCR];
        CaracDegre : tSysCharSet = ['0'..'9','+','-',':','°','''','"',crSupprArr,crSuppr,crTab,crCR];
        ChiffreExpStr = WideChar($2070)+WideChar($00B9)+WideChar($00B2)+
               WideChar($00B3)+WideChar($2074)+WideChar($2075)+WideChar($2076)+
               WideChar($2077)+WideChar($2078)+WideChar($2079);

        caracPrefixeSI : tSysCharSet = ['y','z','a','f','p','n','µ','m','k','M','G','T','P','E','Z','Y'];
        caracPrefixe: TSysCharSet =
             ['y', 'z', 'a', 'f', 'p', 'n', 'µ', 'm', 'd', 'c', 'h', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'];
        prefixeUnite : array[TcoefUnite] of char =
              ('0','y','z','a','f','p','n','µ','m',
               ' ','k','M','G','T','P','E','Z','Y','ì');
        valUnite : array[TcoefUnite] of double =
              (1E-27,1E-24,1E-21,1E-18,1E-15,1E-12,1E-9,1E-6,1E-3,
               1,1E+3,1E+6,1E+9,1E+12,1E+15,1E+18,1E+21,1E+24,1E+27);
        puissanceUnite : array[TcoefUnite] of shortInt =
              (-27,-24,-21,-18,-15,-12,-9,-6,-3,
                0,+3,+6,+9,+12,+15,+18,+21,+24,+27);
        NomLigneRappel : array[TligneRappel] of string =
            ('Equivalences','Tangentes','Valeurs du modèle','Réticules','Equivalences','Delta X','Delta Y','Pente');

var
        fontName : string = 'Segoe UI';
        AffIncertParam : TAffIncertParam = i95;
        FontSizeMemo : integer = 12;
        grapheClip : TgrapheClipBoard;
        TexteGrapheSize : integer = 3;
        RappelTroisGraphes : boolean = true;
        CoeffEllipse : double = 1.0;
        ModeleFacteurQualite : boolean = true; // sinon facteur d'amortissement Q=1/2m
        ModeleDecibel : boolean = false;
        FichierTrie : boolean = false;
        DataTrieGlb : boolean = false;
        Recuit : boolean = false;
        modeleCosinus : boolean = true;
        VisualisationAjustement : boolean = false;
        DispositionFenetre : TDispositionFenetre = dMaxi;
        GridPrint : boolean = false;
        StoechBecherGlb : integer = 1;
        StoechBuretteGlb : integer = 1;
        OrdreBruit : integer = 3;
        DataCanModifiable : boolean = false;
        SaveConfigAcq : boolean = true;
        withCoeffCorrel : boolean = true;
        withPvaleur : boolean = false;
        withBandeConfiance : boolean = false;
        withBandePrediction : boolean = false;
        avecModeleManuel : boolean = true;
        ajusteOrigine : boolean = false;
        PrecisionCorrel : integer = 5;
        LevenbergMarquardt : boolean = false;
        MaxCopiesPrinter : integer = 1;
        couleurIncertitude : Tcolor = clBlue;
        couleurNonExp : Tcolor = clGray;
        couleurExp : Tcolor = clBlack;
        ChercheUniteParam : boolean = true;
        avecTableau : boolean = true;
        uniteParenthese : boolean = false;
        TraceIncert : Tincertitude = iEllipse;
        ClavierAvecGraphe : boolean = true;
        modelePourCent : boolean = false;
        arretConversionVideo : boolean = false;
        largeurColonneTexte : integer = 80;
        HauteurColonne : integer;
        LargeurUnCarac : integer;
        NbreMC : integer = 1024;
        FFTperiodique : boolean = true;

Function OKReg(const strOk : string;const helpCtx : LongInt) : boolean;
Function OKformat(const strOk : string;args : array of const) : boolean;
Procedure afficheErreur(const strErreur : string;const HelpCtx : LongInt);
Procedure ValidateReel(Sender : Tedit;var z : double);
Function ToucheValidation(key : word) : boolean;
Procedure VerifKeyGetFloat(var key : char);
Procedure VerifKeyGetInt(var key : char);
Procedure TrimComplet(var S : String);
Procedure TrimAscii127(var S : String);
Function Pad(const S : String;Len : integer) : String;
Procedure ConvertitPrefixe(var nombre : string);
Procedure ConvertitPrefixeExpression(var Texte : string);
Function FormatGeneral(const nombre : double;const Nchiffres : integer) : string;
Function FormatIngenieur(Nombre : double;PrecisionU : integer) : string;
Function FormatRadian(nombre : double) : string;
Function FormatReg(const nombre : double) : string;
Function FormatCourt(const nombre : double) : string;
Function FormatLongueDureeAxe(const nombre : double) : string;
Function ChainePrec(const prec : double) : String;
function Compte(const chaine,sousChaine : string) : integer;
function litLigneWinU : string;
function litLigneWin : string;
function EnTeteRW3 : boolean;
function litBooleanWin : boolean;
procedure ecritChaineRW3(const s : String);
procedure readLnNombreWin(var z : double);
Function NbreLigneWin(const s : String) : LongInt;
Function PowerToStr(puiss : integer) : string;
Function IsLigneComment(const ligneCourante : String) : boolean;
Function FloatToStrPoint(const valeur : double) : string;
Function FloatToStrLatex(const valeur : double) : string;
Function FloatToStrFixedLatex(const valeur : double;Precision,Decimales : integer) : string;
Function StrToFloatWin(nombre : String) : double;
Function StrToFloatSex(degStr : string;const minStr,secStr : string) : double;
function IniReadFloat(const Ini : TMemIniFile;const Section, Name: string; ValDefault: Double): Double;
Function DureeEcoulee(const InstantDebut : TdateTime) : double;
Function existeOption(opt : char;const defaut : boolean) : boolean;
Function CaracToChiffre(carac : char) : integer;
Function StrSexaToDeci(Nombre : String) : double;
Function GetFloat(Nombre : String) : double;
Function GetFloatDate(Nombre : String;Aformat : TnombreFormat) : double;
Function LigneDeChiffres(const s : String) : boolean;
Procedure ImprimerGrid(g : TstringGrid;var debut : integer);
Procedure VerifOrpheline(count : integer;var debut : integer);
Procedure DebutImpressionTexte(var haut : integer);
Procedure DebutImpressionGr(Orientation : TprinterOrientation;var bas : integer);
Procedure FinImpressionGr;
Procedure ResetPrinter;
Procedure ImprimerLigne(const TextStr : String;var debut : integer);
function valeur125(valInt : integer;down : boolean) : integer;
function getNomCoord(nom : string) : string;
procedure AffecteStatusPanel(var Astatus : TstatusBar;i : integer;const Atext : string);
procedure VideStatusPanel(var Astatus : TstatusBar;i : integer);
function FichierGroupe : String;
Procedure RemoveBackSlash(var aPath : String);
procedure VerifMemo(memo: TRichEdit);
Function isCaracGrandeur(carac : char) : boolean;
Function isCaracUnite(carac : char) : boolean;
Procedure convertitExpUnite(var unite : string);
Function isLettre(carac : char) : boolean;
function litColor(couleurDefaut : TColor) : Tcolor;
function SelectDir(var aDirectory : string) : boolean;
function IsPortAvailable(ComNum: cardinal): boolean;
Function getcouleurFond(Abitmap : Tbitmap) : TColor;
Function couleurComplementaire(couleur : Tcolor) : TColor;
Function TeinteToRGB(teinte : double) : Tcolor;
Function SigneToRGB(teinte : double) : Tcolor;
function RGBToValue(const R, G, B: Single) : single;

function writeStringXML(ANode : IXMLNOde;const Nom,valeur : string) : IXMLNode;
function writeIntegerXML(ANode : IXMLNOde;const Nom : string;valeur : integer) : IXMLNode;
function writeBoolXML(ANode : IXMLNOde;const Nom : string;valeur : boolean) : IXMLNode;
function writeFloatXML(ANode : IXMLNOde;const Nom : string;valeur : double) : IXMLNode;
function writeColorXML(ANode : IXMLNOde;const Nom : string;valeur : TColor) : IXMLNode;
function writeDateTimeXML(ANode : IXMLNOde;const Nom : string;valeur : TDateTime) : IXMLNode;

Function GetBoolXML(ANode : IXMLNOde) : boolean;
Function GetIntegerXML(ANode : IXMLNOde) : integer;
Function GetFloatXML(ANode : IXMLNOde) : double;
Function GetColorXML(ANode : IXMLNOde) : Tcolor;
function GetDateTimeXML(ANode : IXMLNOde) : TdateTime;

//procedure ResizeButtonImagesforHighDPI(const container: TWinControl);
//procedure SetFontTedit(const sb : TEdit;const DPI : integer);

Function GetFolder(CSIDLValue: integer): String;
function CheckFileAvimeca(FileName : string) : string;


{$IFDEF Debug}
procedure ecritDebug(s : string);
{$ENDIF}

//PROCEDURE Zoom_Lineaire(VAR BMP : TBitmap; CONST zoom : single);
procedure RotateBitmap(var bmp : TBitmap;sensHoraire : boolean);
procedure RotateBitmap2(Bmp: TBitmap; Rads: integer);
procedure ConvertitGifBmp(var nomFichier: string);
function CouleurLatex(color: Tcolor): string;
function TranslateNomMath(const anom : string) : string;
function TranslateNomTexte(const anom : string) : string;

Procedure Aide(index : integer);
Procedure AideStr(st : string);

var
     precision : integer;
     erreurDetectee : boolean;
     avecOptionsXY : boolean;
     ModeAcquisition : TModeAcquisition;
     NomExeAcquisition : String;
     LigneRappelCourante : TligneRappel;
     LigneRappelTangente : TligneRappel;
     avecEllipse,avecChi2,ReticuleComplet,PermuteColRow,
     UseItalic,UseMathPlayer : boolean;
     FontSizeImpr : integer;
     GraduationPi : boolean;
     LectureFichier,LecturePage : boolean;
     ParamAnimManuelle : array[0..MaxParamAnim] of TparamAnimation;
     PrinterParam : TprinterRecord;
     virtualImageListSize : integer;

// graphique pour configRegressi
const
    MaxOrdonnee   = 6;
    MaxPagesGr = 13;
type
    TindiceOrdonnee  = 1..MaxOrdonnee;
    Tmotif = (mCroix, mCroixDiag, mCercle, mCarre, mLosange,
    mCerclePlein, mCarrePlein, mIncert, mEchantillon, mHisto,
    mSpectre, mPixel, mReticule, mBarreD, mBarreG, mLigneH, mLigneEuler);
// etoile, triangle, pentagone, asterisque, losangePlein, pentagonePlein, trianglePlein

var
    CouleurPages: array[0..MaxPagesGr] of
    Tcolor = (clGray, clBlue, clRed, clOlive, clNavy, clPurple, clTeal, clBlack,
              clMaroon, clFuchsia, clBlue, clGray, clAqua, clTeal);
    StylePages: array[0..MaxPagesGr] of
    TpenStyle = (psSolid, psDash, psDot, psDashDot, psDashDotDot,
                 psSolid, psDash, psDot, psDashDot, psDashDotDot,
                 psSolid, psDash, psDot, psDashDot);
    MotifPages: array[0..MaxPagesGr] of
    Tmotif = (mCroix, mCroixDiag, mCercle, mCarre, mLosange, mCerclePlein, mCarrePlein,
              mCroix, mCroixDiag, mCercle, mCarre, mLosange, mCerclePlein, mCarrePlein);
    CouleurModele: array[-MaxIntervalles..MaxIntervalles] of
    Tcolor = (clTeal, clMaroon, clFuchsia, clNavy, clWhite, clBlue, clRed, clPurple, clGreen);
    CouleurInit: array[TindiceOrdonnee] of Tcolor =
         (clBlack, clBlue, clRed, clPurple, clGreen, clNavy);
    MotifInit: array[TindiceOrdonnee] of Tmotif =
         (mCroix, mCroixDiag, mCercle, mCarre, mLosange, mCerclePlein);
    CharNavigationDG : tSysCharSet = [crGauche,crDroite,crSupprArr,crSuppr,crTab,crCR];
    CharNavigationHB : tSysCharSet = [crHaut,crBas,crSupprArr,crSuppr,crTab,crCR];


implementation

const
    expUnite : array[TcoefUnite] of string =
              ('E-27','E-24','E-21','E-18','E-15','E-12','E-9','E-6','E-3',
                '','E+3','E+6','E+9','E+12','E+15','E+18','E+21','E+24','E+27');
    Grecque = alpha+beta+gammaMin+gammaMaj+deltaMin+deltaMaj+
              epsilon+chi+zeta+eta+theta+thetaMaj+kappa+
              lambdaMin+lambdaMaj+mu+nu+xi+xiMaj+
              piMin+piMaj+rho+sigmaMin+sigmaMaj+tau+
              phiMin+phiMaj+chi+psi+psiMaj+omegaMin+omegaMaj;
    ChiffrePuiss = WideChar($2070)+WideChar($00B9)+WideChar($00B2)+
               WideChar($00B3)+WideChar($2074)+WideChar($2075)+WideChar($2076)+
               WideChar($2077)+WideChar($2078)+WideChar($2079)+MoinsExp+PlusExp;
    CharGetFloat : tSysCharSet = ['0'..'9','+','-','e','E','.',',','*','/','^',
            'P','p','I','i',piMin,piMaj,'m','µ','n','f','k','M','G','T',
            '(',')',crSupprArr,crSuppr,crTab,crCR];
    CharGetInt : tSysCharSet = ['0'..'9',crGauche,crDroite,crSupprArr,crSuppr,crTab,crCR];
    MargeImprimante = 21;
    MargeImprimantePaysage = 30; // soit 1 cm

        alphaR =  AnsiChar(128);
        betaR = AnsiChar(129);
        chiR = AnsiChar(130);
        deltaR = AnsiChar(131); deltaMajR = AnsiChar(150);
        epsilonR = AnsiChar(132);
        phiR = AnsiChar(133); phiMajR = AnsiChar(151);
        gammaR = AnsiChar(134); gammaMajR = AnsiChar(152);
        etaR = AnsiChar(135);
        lambdaR = AnsiChar(136); lambdaMajR = AnsiChar(153);
        nuR = AnsiChar(138);
        piR = AnsiChar(139);piMajR = AnsiChar(154);
        thetaR = AnsiChar(140);thetaMajR = AnsiChar(155);
        rhoR = AnsiChar(141);
        sigmaR = AnsiChar(142);sigmaMajR = AnsiChar(156);
        tauR = AnsiChar(143);
        omegaR = AnsiChar(144);omegaMajR = AnsiChar(157);
        xiR = AnsiChar(147);xiMajR = AnsiChar(158);
        psiR = AnsiChar(148);psiMajR = AnsiChar(159);
        zetaR = AnsiChar(149);
        muR = AnsiChar(181);
        MoinsExpR = AnsiChar(170); // idem pour Regressi fontes
        PlusExpR = AnsiChar(184);
        infEgalR = AnsiChar(250);
        supEgalR = AnsiChar(249);
        ChiffreExpR : array[0..9] of ansiChar =
  (AnsiChar(186),AnsiChar(185),AnsiChar(178),AnsiChar(179),
   AnsiChar(165),AnsiChar(169),AnsiChar(172),AnsiChar(173),
   AnsiChar(174),AnsiChar(188));

{
  William Egge, public@eggcentric.com
  http://www.eggcentric.com

  This unit converts between RGB and HSV color models.

  procedure HSVToRGB(const H, S, V: Single; out R, G, B: Single);
    in
    H = Hue.  Range is from 0..1.  0.5 = 180 degrees, 1 = 360. or H < 0 for gray
    S = Satration.  Range is 0..1 where 0 is white and 1 is no saturation.
    V = Value.  Range is 0..255

    out
    R = 0..255
    G = 0..255
    B = 0..255

    If H < 0 then the result is a gray value R=V, G=V, B=V

  procedure RGBToHSV(const R, G, B: Single; out H, S, V: Single);
    in
    R = 0..255
    G = 0..255
    B = 0..255

    out
    H = Hue. -1 for grey scale or range 0..1.  0..1 represents 0..360 degrees
    S = Saturation. Range = 0..1. 0 = white, 1 = no saturation.
    V = Value or intensity. Range 0..255
}

var avecExposantLatex : boolean;

Function UnicodeToLatexMath(carac : char) : string;
var j : integer;
begin
     avecExposantLatex := false;
     case carac of
                      alpha : result := '\alpha ';
                      beta : result := '\beta ';
                      gammaMin: result := '\gamma ' ;
                      gammaMaj: result := '\Gamma ';
                      deltaMin: result := '\delta ';
                      deltaMaj: result := '\Delta ';
                      epsilon: result := '\epsilon ';
                      zeta: result := '\zeta ';
                      eta: result := '\eta ';
                      kappa: result := '\kappa ';
                      lambdaMin: result := '\lambda ';
                      lambdaMaj: result := '\Lambda ';
                      mu: result := '\mu ';
                      nu: result := '\nu ';
                      xi: result := '\xi ';
                      xiMaj: result := '\Xi ';
                      pimin: result := '\pi ';
                      piMaj: result := '\Pi ';
                      rho: result := '\rho ';
                      sigmaMin: result := '\sigma ';
                      sigmaMaj: result := '\Sigma ';
                      tau: result := '\tau ';
                      theta: result := '\theta ';
                      thetaMaj: result := '\Theta ';
                      phiMin: result := '\phi ';
                      phiMaj: result := '\Phi ';
                      chi: result := '\chi ';
                      psi: result := '\psi ';
                      psiMaj: result := '\Psi ';
                      omegaMin: result := '\omega ';
                      omegaMaj: result := '\Omega ';
                      '§' : result := '\S';
                      '&' : result := '\&';
                      '#' : result := '\#';
                   //   '°' : result := '°';
                      '±' : result := '\pm ';
                      '%' : result := '\%';
                      pourMille : result := '\textperthousand ';
                      MoinsExp : result := '-';
                      PlusExp : result := '+';
                      InfEgal : result := '\leq ';
                      SupEgal : result := '\geq ';
                      pointMedian : result := '\cdot ';
                      cdot : result := '\cdot ';
                      else begin
                         result := carac;
                         for j := 0 to 9 do
                            if carac=ChiffreExp[j] then begin
                               result := intToStr(j);
                               break;
                            end;
                      end;
     end;
end;

Function UnicodeToLatexTexte(carac : char) : string;
var j : integer;
begin
     avecExposantLatex := false;
     case carac of
                      alpha : result := '$\alpha$';
                      beta : result := '$\beta$';
                      gammaMin: result := '$\gamma$' ;
                      gammaMaj: result := '$\Gamma$';
                      deltaMin: result := '$\delta$';
                      deltaMaj: result := '$\Delta$';
                      epsilon: result := '$\epsilon$';
                      zeta: result := '$\zeta$';
                      eta: result := '$\eta$';
                      kappa: result := '$\kappa$';
                      lambdaMin: result := '$\lambda$';
                      lambdaMaj: result := '$\Lambda$';
                      mu: result := '$\mu$';
                      nu: result := '$\nu$';
                      xi: result := '$\xi$';
                      xiMaj: result := '$\Xi$';
                      pimin: result := '$\pi$';
                      piMaj: result := '$\Pi$';
                      rho: result := '$\rho$';
                      sigmaMin: result := '$\sigma$';
                      sigmaMaj: result := '$\Sigma$';
                      tau: result := '$\tau$';
                      theta: result := '$\theta$';
                      thetaMaj: result := '$\Theta$';
                      phiMin: result := '$\phi$';
                      phiMaj: result := '$\Phi$';
                      chi: result := '$\chi$';
                      psi: result := '$\psi$';
                      psiMaj: result := '$\Psi$';
                      omegaMin: result := '$\omega$';
                      omegaMaj: result := '$\Omega$';
                      '%' : result := '\%';
                      pourmille : result := '\textperthousand';
                      '§' : result := '\S';
                      '&' : result := '\&';
                      '#' : result := '\#';
                      '°' : result := '°';
                      MoinsExp : begin
                         avecExposantLatex := true;
                         result := '-';
                      end;
                      PlusExp : begin
                         avecExposantLatex := true;
                         result := '+';
                      end;
                      InfEgal : result := '$\leq$';
                      SupEgal : result := '$\geq$';
                      '±' : result := '$\pm$';
                      pointMedian : result := '\cdot ';
                      cdot : result := '\cdot ';
                      else begin
                         result := carac;
                         for j := 0 to 9 do
                            if carac=ChiffreExp[j] then begin
                               avecExposantLatex := true;
                               result := intToStr(j);
                               break;
                            end;
                      end;
     end;
end;

function TranslateNomMath(const anom : string) : string;
var i : integer;
begin
    result := '';
    for i := 1 to length(anom) do
        result := result+unicodeToLatexMath(anom[i]);
end;

function TranslateNomTexte(const anom : string) : string;
var i : integer;
    tr : string;
    exposantEnCours : boolean;
begin
    result := '';
    exposantEnCours := false;
    for i := 1 to length(anom) do begin
        tr := unicodeToLatexTexte(anom[i]);
        if exposantEnCours
           then if avecExposantLatex
              then
              else begin
                 exposantEnCours := false;
                 result := result+'}$';
              end
           else if avecExposantLatex
              then begin
               result := result+'$^{';
               exposantEnCours := true;
              end;
        result := result+tr;
    end;
    if exposantEnCours then
        result := result+'}$';
end;

function CouleurLatex(color: Tcolor): string;
begin
  case color of
    clBlack: Result := 'black';
    clMaroon: Result := 'brown';
    clGreen: Result := 'green';
    clOlive: Result := 'olive';
    clNavy: Result := 'blue';
    clPurple: Result := 'red';
    clTeal: Result := 'teal';
    clGray: Result := 'gray';
    clSilver: Result := 'lightgray';
    clRed: Result  := 'red';
    clLime: Result := 'lime';
    clYellow: Result := 'yellow';
    clBlue: Result := 'blue';
    clFuchsia: Result := 'purple';
    clAqua: Result := 'blue';
    clWhite: Result := 'white';
    clMoneyGreen: Result := 'green';
    clSkyBlue: Result := 'blue';
    clCream: Result := 'lightgray';
    clMedGray: Result := 'darkgray';
    else Result := 'black';
  end;
end;

procedure HSVToRGB(const H, S, V: Single; out R, G, B: Single);
const
  SectionSize = 60 / 360;
var
  Section: Single;
  SectionIndex: Integer;
  f: single;
  p, q, t: Single;
begin
  if H < 0 then begin
    R := V;
    G := R;
    B := R;
  end
  else begin
    Section := H / SectionSize;
    SectionIndex := Floor(Section);
    f := Section - SectionIndex;
    p := V * (1 - S);
    q := V * (1 - S * f);
    t := V * (1 - S * (1 - f));
    case SectionIndex of
      0: begin
          R := V;
          G := t;
          B := p;
      end;
      1: begin
          R := q;
          G := V;
          B := p;
      end;
      2: begin
          R := p;
          G := V;
          B := t;
      end;
      3: begin
          R := p;
          G := q;
          B := V;
      end;
      4: begin
          R := t;
          G := p;
          B := V;
      end;
      else begin
         R := V;
         G := p;
         B := q;
      end;
    end;
  end;
end;

procedure RGBToHSV(const R, G, B: Single; out H, S, V: Single);
var
  RGB: array[0..2] of Single;
  MinIndex, MaxIndex: Integer;
  Range: Single;
begin
  RGB[0] := R;
  RGB[1] := G;
  RGB[2] := B;
  MinIndex := 0;
  if G < R then MinIndex := 1;
  if B < RGB[MinIndex] then MinIndex := 2;
  MaxIndex := 0;
  if G > R then MaxIndex := 1;
  if B > RGB[MaxIndex] then MaxIndex := 2;
  Range := RGB[MaxIndex] - RGB[MinIndex];
  // Check for a gray level
  if Range = 0 then begin
    H := -1; // Can't determine on greys, so set to -1
    S := 0; // Gray is at the center;
    V := R; // could choose R, G, or B because they are all the same value.
  end
  else begin
    case MaxIndex of
      0: H := (G - B) / Range;
      1: H := 2 + (B - R) / Range;
      2: H := 4 + (R - G) / Range;
    end;
    S := Range / RGB[MaxIndex];
    V := RGB[MaxIndex];
    H := H * (1 / 6);
    if H < 0 then H := 1 + H;
  end;
end;

function RGBToValue(const R, G, B: Single) : single;
var
  RGB: array[0..2] of Single;
  MinIndex, MaxIndex: Integer;
  Range,H: Single;
begin
  RGB[0] := R;
  RGB[1] := G;
  RGB[2] := B;
  MinIndex := 0;
  if G < R then MinIndex := 1;
  if B < RGB[MinIndex] then MinIndex := 2;
  MaxIndex := 0;
  if G > R then MaxIndex := 1;
  if B > RGB[MaxIndex] then MaxIndex := 2;
  Range := RGB[MaxIndex] - RGB[MinIndex];
  // Check for a gray level
  if Range = 0 then result := R // could choose R, G, or B because they are all the same value.
  else begin
    case MaxIndex of
      0: H := (G - B) / Range;
      1: H := 2 + (B - R) / Range;
      2: H := 4 + (R - G) / Range;
      else H := 0;//pour le compilateur
    end;
    H := H * (1 / 6);
    if H < 0 then H := 1 + H;
    result := H;
  end;
end;

Function GetCouleurFond(Abitmap : Tbitmap) : Tcolor;
var zz : TRGBtriple;
    i,j : integer;
    scanLine : pRGBTripleArray;
    rouge,vert,bleu : integer;
    pasY,pasX : integer;
    aColor : TcolorRef;
begin
       rouge := 0;
       vert := 0;
       bleu := 0;
       pasY := Abitmap.height div 9;
       pasX := Abitmap.width div 9;
       for i := 1 to 8 do begin
           scanLine := Abitmap.scanLine[i*pasY];
           for j := 1 to 8 do begin
              zz := scanLine[j*pasX];
              rouge := rouge+(zz.rgbtRed);
              vert := vert+(zz.rgbtGreen);
              bleu := bleu+(zz.rgbtBlue);
           end;
       end;
       acolor := RGB(rouge div 64,vert div 64,bleu div 64);
       result := aColor;
end;

Function CouleurComplementaire(couleur : Tcolor) : Tcolor;
var H,L,S : word;
    rr,gg,bb : byte;
begin
       ColorRGBToHLS(couleur,H,L,S); // 0..240 pour H
       if H>120
          then H := H-120
          else H := H+120; // couleur complémentaire
       if S<127 // non saturé, il faut jouer sur l'intensité : clair sur foncé et réciproquement
          then if L<127
             then L := 255
             else L := 0;
       S := 255; // saturation maxi
       couleur := ColorHLSToRGB(H,L,S);
       rr := 64*(GetRvalue(Couleur) div 64);
       gg := 64*(GetGvalue(Couleur) div 64);
       bb := 64*(GetBvalue(Couleur) div 64);
       result := RGB(rr,gg,bb);
end;

Function TeinteToRGB(teinte : double) : Tcolor;
// 0 noir 0.15 jaune 0.35 vert 0.5 cyan 0.7 bleu 0.85 magenta 1 rouge
var H : word;
begin
    if teinte<0 then teinte := 0;
    if teinte>1 then teinte := 1;
    H:= round(teinte*240);
    if H<20
       then result := clBlack
       else result := ColorHLSToRGB(H,127,255);  // L=255 blanc L=0 noir
end;

Function SigneToRGB(teinte : double) : Tcolor;
// <0 bleu >0 rouge
var H : word;
begin
    if teinte<-1 then teinte := -1;
    if teinte>1 then teinte := 1;
    H := round(255*(1-abs(teinte)));
    if teinte<0
       then result := RGB(H,H,255)  // bleu
       else result := RGB(255,H,H); // rouge
end;

procedure ConvertitGifBmp(var nomFichier: string);
var
  GIF		 : TGIFImage;
  Bitmap : TBitmap;
begin
    GIF := TGIFImage.Create;
    try
      GIF.OnProgress := Nil;
      // Load the GIF that will be converted
      nomFichier := ChangeFileExt(nomFichier,'.gif');
      GIF.LoadFromFile(nomFichier);
      Bitmap := TBitmap.Create;
      try
        // Convert the GIF to a BMP
        Bitmap.Assign(GIF);
        Bitmap.pixelFormat := pf24bit;
        // Save the BMP
        nomFichier := ChangeFileExt(nomFichier,'.bmp');
        Bitmap.SaveToFile(nomFichier);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
end;

(**** XML *****)

function writeStringXML(ANode : IXMLNOde;const Nom,valeur : string) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := valeur;
    result := newNode;
end;

function writeIntegerXML(ANode : IXMLNOde;const Nom : string;valeur : integer) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := intToStr(valeur);
    result := newNode;
end;

function writeFloatXML(ANode : IXMLNOde;const Nom : string;valeur : double) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := FloatToStrPoint(valeur);
    result := newNode;
end;

function writeDateTimeXML(ANode : IXMLNOde;const Nom : string;valeur : TDateTime) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := valeur;
    result := newNode;
end;

function writeBoolXML(ANode : IXMLNOde;const Nom : string;valeur : boolean) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := ord(valeur);
    result := newNode;
end;

function writeColorXML(ANode : IXMLNOde;const Nom : string;valeur : TColor) : IXMLNode;
var newNode : IXMLNode;
begin
    newNode := Anode.AddChild(Nom);
    newNode.nodeValue := colorToString(valeur);
    result := newNode;
end;

Function GetBoolXML(ANode : IXMLNOde) : boolean;
var s : string;
begin
     s := ANode.NodeValue;
     result := s<>'0';
end;

Function GetIntegerXML(ANode : IXMLNOde) : integer;
begin
     try
     result := StrToInt(ANode.text);
     except
        result := 0;
     end;
end;

Function GetFloatXML(ANode : IXMLNOde) : double;
var s : string;
begin
     try
     s := ANode.NodeValue;
     result := StrToFloatWin(s);
     except
       result := Nan
     end;
end;

Function GetDateTimeXML(ANode : IXMLNOde) : TDateTime;
var s : string;
    z : double;
begin
     try
     s := ANode.NodeValue;
     z := StrToFloatWin(s);
     result := TDateTime(z);
     except
       result := Nan
     end;
end;

Function GetColorXML(ANode : IXMLNOde) : Tcolor;
begin
    result := stringToColor(ANode.Text);
end;

(**** fin XML *****)

var
     SuiteCaracGrandeur : TsysCharSet; // carac permis à l'interieur d'un nom de grandeur
     Lettres : TsysCharSet;
     RW3Unicode : boolean;

function IsPortAvailable(ComNum: cardinal): boolean;

   function MakeComName(const Dest: PChar; const ComNum: cardinal): PChar;
   begin
      StrFmt(Dest, '\\.\COM%d', [ComNum]);
      MakeComName := Dest;
   end;

var
   ComName: array[0..12] of char;
   Res: integer;
   DeviceLayer: TApdBaseDispatcher;
begin
   DeviceLayer := TApdWin32Dispatcher.Create(nil);
   try
      Res := DeviceLayer.OpenCom(MakeComName(ComName, ComNum), 64, 64);
      Result := (Res >= 0) or (GetLastError = DWORD(Abs(ecAccessDenied)));
      if Result then
         DeviceLayer.CloseCom;
   finally
      DeviceLayer.Free;
   end;
end;

Function StrToFloatSex(degStr : string;const minStr,secStr : string) : double;
var deg,minute,seconde,valeur : double;
    negatif : boolean;
begin
   negatif := degStr[1]='-';
   if negatif then delete(degStr,1,1);
   deg := StrToInt(degStr);
   minute := StrToInt(minStr);
   seconde := StrToFloatWin(secStr);
   valeur := deg+minute/60+seconde/3600;
   if negatif then valeur := -valeur;
   result := valeur;
end;

Function ConvertitChaine(nombre : string;var valeur : double) : boolean;
begin
   convertitChaine := false;
   TrimComplet(nombre);
   valeur := Nan;
   if Length(nombre)=0 then exit;
   case nombre[1] of
        'e','E' : nombre := '1'+nombre;
        '.',',' : begin
           nombre[1] := FormatSettings.decimalSeparator;
           nombre := '0'+nombre
        end;
        '0'..'9','+','-' : ;
        else exit;
   end;
   convertitChaine := true;
   convertitPrefixe(nombre);
   try
   valeur := StrToFloat(nombre);
   except
      convertitChaine := false;
   end;
end;

Procedure TrimComplet(var s : string);
var longueur,posCourant : integer;
begin
	longueur := Length(s);
	posCourant := 1;
	while (posCourant<=longueur) do
		if ord(s[posCourant])<=32
			then begin
			   Delete(s,posCourant,1);
			   dec(longueur);
			end
			else inc(posCourant);
end;

Procedure TrimAscii127(var s : String);
var longueur,posCourant : integer;
begin
	longueur := Length(s);
  posCourant := 1;
	while (posCourant<=longueur) do
		if ((s[posCourant]<=' ') or (s[posCourant]>'z'))
			then begin
			   Delete(s,posCourant,1);
			   dec(longueur);
			end
			else inc(posCourant);
end;

Function GetFloat(Nombre : String) : double;
Const
    MaxPile = 10;
    CaracCte : tSysCharSet = [piMin,piMaj,'P','I','p','i'];
type
    TIndicePile  = 1..MaxPile;
Var
    Pile : Array[TIndicePile] of double;
    IndicePileCourant : 0..MaxPile;
    CaracCourant   : char;
    PointeurExp : integer;

Procedure suivant;
// Lit le prochain caractère et l'assigne à caracCourant
// Le caracCourant est toujours extrait avant appel d'un analyseur
begin
    inc(pointeurExp);
    if pointeurExp<=length(Nombre)
       then begin
          caracCourant := Nombre[pointeurExp];
          if charInSet(caracCourant,[cDot,pointMedian,puce]) then caracCourant := '*';
       end
       else caracCourant := #0;
end;

Procedure InitFonctor;
Begin
  pointeurExp := 0;
  indicePileCourant := 0;
  suivant;
end;

// Les procédures LireXXX extraient un XXX de la chaine Nombre à partir du pointeur courant

Function LireNombre : double;
    Var PointeurChiffre : integer;
        Valeur : double;
        NombreLoc : String;

    Procedure lireEntier;
    begin
       While charinset(caracCourant,chiffre) do suivant
    end;

    Begin
        PointeurChiffre := PointeurExp; // pointe le premier chiffre du nombre
        If charinset(caracCourant,['-','+']) then suivant; // saute le signe
        lireEntier;
        If caracCourant=FormatSettings.decimalSeparator // C'est un nombre décimal
           Then begin
              suivant; // on saute le .
              lireEntier
           end;
        If ( upcase(caracCourant) = 'E' ) // puissance de 10
           then begin
              suivant; // on saute le E
              if (caracCourant='+') or (caracCourant='-')  then suivant;
              lireEntier
           end
           else if charInSet(caracCourant,caracPrefixe) then suivant; // coeff unité
        NombreLoc := copy(nombre,pointeurChiffre,pointeurExp-PointeurChiffre);
        if not ConvertitChaine(nombreLoc,valeur)
           then raise EGetFloatError.Create(erNombre);
        LireNombre := valeur;
   end; // lireNombre

Function LireIdEnt : String;
Var PointeurIdent : integer;
Begin
  PointeurIdent := pointeurExp;
  While charinset(caracCourant,CaracCte) do suivant;
  if (pointeurExp-pointeurIdent)>longNom then raise EGetFloatError.Create(erTropLong);
  LireIdent := copy(nombre,pointeurIdent,pointeurExp-pointeurIdent)
End;  // LireIdEnt

Procedure Depile(Var P : double);
Begin
  if indicePileCourant=0
    then raise EGetFloatError.Create(Erinterne)
    else begin
      P := Pile[indicePileCourant];
      dec(indicePileCourant);
   end;
End;

Procedure Empile(P : double);
Begin
  if indicePileCourant=MaxPile
    then raise EGetFloatError.Create(erTropcomplexe)
    else begin
      inc(indicePileCourant);
      Pile[indicePileCourant] := P;
   end;
End;

Function CalcOperateur(C : char;PG,PD : double) : double;
begin
   case C of
         '+'  : calcOperateur := PG+PD;
         '-'  : calcOperateur := PG-PD;
         '/'  : calcOperateur := PG/PD;
         '*'  : calcOperateur := PG*PD;
         '^'  : calcOperateur := Power(PG,PD);
         else CalcOperateur := 0;
   end;
end;

Procedure AnalyseExpression;Forward;

Procedure E; // E=(.Expression.)
Begin
  If caracCourant='('
    Then Begin
        suivant;
        AnalyseExpression;
        case caracCourant of
             ')'  : suivant;
             #0 : ; // fin => on ajoute ) manquante
             else raise EGetFloatError.Create(erParF);
        end;
    End
    Else raise EGetFloatError.Create(erParO)
End;// E

Procedure AnalyseElement; // Element = E/nombre
Var
  U : String;
Begin
  If charInSet(caracCourant,['P','p']) or (caracCourant=piMin) or (caracCourant=piMaj)
    Then Begin
        U := LireIdent;
        U := AnsiUpperCase(U);
        if (U=piMin) or (U='PI')or (U=piMaj)
           then Empile(pi)
           else raise EGetFloatError.Create('Pi ?')
    End // then
    Else If charinset(caracCourant,Chiffre+['-','+','.'])
        Then Empile(LireNombre)
        Else E
End; // analyseElement

Procedure AnalyseFacteur; // facteur = Element.^.element
Var  T1,T2 : double;
Begin
  AnalyseElement;
  While (caracCourant='^') do Begin
     suivant;
     AnalyseElement;
     depile(T2);
     depile(T1);
     Empile(CalcOperateur('^',T1,T2));
  End
End; // AnalyseFacteur

Procedure AnalyseTerme; // terme = facteur.[* ou /].facteur
Var
  C        : Char;
  T1,T2    : double;
Begin
   AnalyseFacteur;
   While (caracCourant='*') or (caracCourant='/') do Begin
       C:=caracCourant;
       suivant;
       AnalyseFacteur;
       depile(T2);
       depile(T1);
       Empile(CalcOperateur(C,T1,T2));
   End
End; // AnalyseTerme

Procedure AnalyseExpression;// Expression = [+ ou - ou rien].Terme.[+ ou -].terme
Var
  C      : Char;
  T1,T2  : double;
Begin
  If (caracCourant='+') or (caracCourant='-')
     Then Begin
        C:=caracCourant;
        suivant
     end
     Else C:='+';
  AnalyseTerme;
  If C='-' Then begin
         depile(T1);
         Empile(-T1)
  end;
  While (caracCourant='+') or (caracCourant='-') do Begin
      C:=caracCourant;
      suivant;
      AnalyseTerme;
      depile(T2);
      depile(T1);
      Empile(CalcOperateur(C,T1,T2));
  End // while
End; // AnalyseExpression

procedure VerifExposant;
var i,j : integer;
    acarac : char;
    ExpInsere : boolean;
begin
    i := 1;
    expInsere := false;
    while (i<=length(nombre)) do begin
        acarac := nombre[i];
        if pos(acarac,chiffrePuiss)>0
            then begin
                 for j := 0 to 9 do
                 if acarac=ChiffreExp[j] then begin
                    if expInsere
                    then begin
                       nombre[i] := char(ord('0')+j);
                       inc(i);
                    end
                    else begin
                       nombre.Insert(i-1,'^');
                       expInsere := true;
                       nombre[i+1] := char(ord('0')+j);
                       inc(i,2);
                    end;
                    break;
                 end;
                 if aCarac=moinsExp then begin
                       nombre.Insert(i-1,'^');
                       expInsere := true;
                       nombre[i+1] := '-';
                       inc(i,2);
                 end;
                 if aCarac=plusExp then begin
                       nombre.Insert(i-1,'^');
                       expInsere := true;
                       nombre[i+1] := '+';
                       inc(i,2);
                 end;
            end
            else inc(i);
    end;
end;

var posVirgule : integer;
    virgule : char;
Begin // getFloat
  trimComplet(Nombre);
  verifExposant;
  if nombre='' then raise EGetFloatError.Create(erExpressionVide);
  if FormatSettings.decimalSeparator='.' then virgule := ',' else virgule := '.';
  posVirgule := pos(virgule,nombre);
  while posVirgule>0 do begin
        Nombre[posVirgule] := FormatSettings.decimalSeparator;
        posVirgule := pos(virgule,nombre);
  end;
  InitFonctor;
  AnalyseExpression;
  if pred(pointeurExp)<>length(nombre) then
     raise EGetFloatError.Create(erNombre);
  result := Pile[1];
  if isInfinite(result) then result := Nan;
end; // getFloat

Function StrLongueDureeToSecond(zz : string) : double;

function Extrait : integer;
var posSepar : integer;
begin
       posSepar := pos(':',zz);
       if posSepar=0
          then if zz=''
             then result := 0
             else begin
                result := strToInt(zz);
                zz := '';
             end
             else begin
                 result := strToInt(copy(zz,1,posSepar-1));
                 delete(zz,1,posSepar);
             end;
end;

//  conversion d hh:mm:ss en secondes
var posJour,sec,min,hour,day : integer;
begin
    posJour := pos('j',zz);
    if posJour>0
       then begin
         try
         day := strToInt(copy(zz,1,posJour-1));
         except
         day := 0;
         end;
         delete(zz,1,posJour);
       end
       else day := 0;
    if (day=0) and (pos(':',zz)=0)
       then result := strToFloat(zz)  { donnée en seconde }
       else begin
          sec := 0;
          for min := 1 to length(zz) do
              if zz[min]=':' then inc(sec);
          if (day>0) or (sec>1)
             then begin
                hour := extrait;
                min := extrait;
                sec := extrait;
             end
             else begin
                min := extrait;
                sec := extrait;
                hour := 0;
             end;
          result := ((day*24+hour)*60+min)*60+sec;
      end;
end;

Function StrSexaToDeci(Nombre : String) : double;
var posDegre,posSeconde,posMinute,posPoint : integer;
    degre,minute,seconde : integer;
begin
     nombre := trim(nombre);
     posDegre := pos('°',nombre);
     if posDegre=0 then posDegre := pos(' ',nombre);  // Miriade
     posMinute := pos('''',nombre);
     if posMinute=0 then posMinute := pos(' ',nombre,posDegre+2);  // Miriade
     posSeconde := pos('"',nombre);
     if posSeconde=0 then posSeconde := pos('''''',nombre);
     if posSeconde>0 then delete(nombre,posSeconde,length(nombre)-posSeconde);
     posPoint := pos('.',nombre);
     if posPoint>0 then delete(nombre,posPoint,length(nombre));
     if (posDegre>0) or (posMinute>0) then begin
             if posDegre>0
                then degre := strToInt(trim(copy(nombre,1,posDegre-1)))
                else degre := 0;
             if posMinute>0
                then minute := strToInt(trim(copy(nombre,posDegre+1,posMinute-posDegre-1)))
                else begin
                     posMinute := posDegre;
                     minute := 0;
                end;
             if posMinute<length(nombre)
                then seconde := strToInt(trim(copy(nombre,posMinute+1,length(nombre)-posMinute)))
                else seconde := 0;
             if degre<0
                then result := degre-minute/60-seconde/60/60
                else result := degre+minute/60+seconde/60/60;
     end // posDegre <> 0
     else result := getFloat(nombre);
end; // StrSexaToDeci

Function GetFloatDate(Nombre : String;Aformat : TnombreFormat) : double;
var posDegre,posSeconde,posMinute : integer;
begin
  case Aformat of
     fDateTime : result := StrToDateTime(nombre);
     fDate : result := StrToDate(nombre);
     fTime : result := StrToTime(nombre);     
     fLongueDuree : result := StrLongueDureeToSecond(nombre);
     else begin
        posDegre := pos(':',nombre);
        if posDegre>0 then begin
           nombre[posDegre] := '°';
           posDegre := pos(':',nombre);
           if posDegre>0 then nombre[posDegre] := '''';
        end;
        posDegre := pos('°',nombre);
        posMinute := pos('''',nombre);
        posSeconde := pos('"',nombre);
        if posSeconde=0 then begin
           posSeconde := pos('''''',nombre);
           if posSeconde>0 then begin
              nombre[posSeconde] := '"';
              delete(nombre,posSeconde+1,1);
           end;
        end;
        if (posDegre>0) or (posMinute>0) or (posSeconde>0)
             then result := StrSexaToDeci(nombre)
             else result := getFloat(nombre);
     end // else
  end; // case format
end; // GetFloatDate

Function OKReg(const strOk : string;const helpCtx : LongInt) : boolean;
var SauveCursor : Tcursor;
begin
     SauveCursor := Screen.cursor;
     Screen.cursor := crDefault;
     result := MessageDlg(strOK,mtConfirmation,[mbYes,mbNo,mbHelp],HelpCtx) = idYes;
     Screen.cursor := SauveCursor;
// TMsgDlgType = ( mtWarning, mtError,  mtInformation,  mtConfirmation,  mtCustom);
// TMsgDlgBtn = (mbYes,mbNo,mbOK,mbCancel,mbAbort,mbRetry,mbIgnore,mbAll,mbNoToAll,mbYesToAll,mbHelp,mbClose);
end;

Function OKformat(const strOk : string;args : array of const) : boolean;
begin
     result := MessageDlg(format(strOK,args),mtConfirmation,[mbYes,mbNo,mbHelp],0)=idYes;
end;

Function StrToFloatWin(nombre : String) : double;
var posSeparator : integer;
begin
   if FormatSettings.decimalSeparator='.'
   then begin
      posSeparator := pos(',',nombre);
      if posSeparator>0
         then Nombre[posSeparator] := '.';
   end
   else begin
      posSeparator := pos('.',nombre);
      if posSeparator>0
         then Nombre[posSeparator] := ',';
   end;
   try
       result := strToFloat(nombre);
   except
       result := Nan
   end;
end;

Function FloatToStrPoint(const valeur : double) : string;
var posSeparator : integer;
begin
   result := FloatToStr(valeur);
   if FormatSettings.decimalSeparator<>'.' then begin
      posSeparator := pos(FormatSettings.decimalSeparator,result);
      if posSeparator>0 then result[posSeparator] := '.';
   end;
end;

Function FloatToStrLatex(const valeur : double) : string;
var posSeparator : integer;
begin
   if isNan(valeur) or isInfinite(valeur)
   then result := ''
   else begin
      result := FloatToStrF(valeur,ffGeneral,4,2);
      if FormatSettings.decimalSeparator<>'.' then begin
         posSeparator := pos(FormatSettings.decimalSeparator,result);
         if posSeparator>0 then result[posSeparator] := '.';
      end;
   end;
end;

Function FloatToStrFixedLatex(const valeur : double;Precision,Decimales : integer) : string;
var posSeparator : integer;
begin
      result := FloatToStrF(valeur,ffFixed,precision,decimales);
      if FormatSettings.decimalSeparator<>'.' then begin
         posSeparator := pos(FormatSettings.decimalSeparator,result);
         if posSeparator>0 then result[posSeparator] := '.';
      end;
end;

Procedure ConvertitPrefixe(var nombre : string);
var u : TcoefUnite;
    c : char;
    prefixeToN : string;
begin
   c := nombre[length(nombre)];
   if charInSet(c,caracPrefixeSI) then begin
      u := zero;
      repeat inc(u) until (c=prefixeUnite[u]);
      delete(nombre,length(nombre),1);
      nombre := nombre+expUnite[u];
   end
   else begin
       case c of
            mu: prefixeToN := 'E-6';
            'c': prefixeToN := 'E-2';
            'd': prefixeToN := 'E-1';
            'h': prefixeToN := 'E+2';
            else exit;
       end;
       delete(nombre,length(nombre),1);
       nombre := nombre+prefixeToN;
   end;
end;

Procedure ConvertitPrefixeExpression(var Texte : string);
var u : TcoefUnite;
    c : char;
    long : integer;
    prefixeToN : string;
begin
   long := length(texte);
   if (long>1) and charInSet(texte[long-1],['0'..'9']) then begin
      c := texte[long];
      if charInSet(c,caracPrefixeSI) then begin
         u := zero;
         repeat inc(u) until (c=prefixeUnite[u]);
         delete(texte,length(texte),1);
         texte := texte+expUnite[u];
      end
      else begin
         case c of
            mu: prefixeToN := 'E-6';
            'c': prefixeToN := 'E-2';
            'd': prefixeToN := 'E-1';
            'h': prefixeToN := 'E+2';
            else exit;
         end;
         delete(texte,length(texte),1);
         texte := texte+prefixeToN;
      end;
   end
end;

Function FormatIngenieur(Nombre : double;PrecisionU : integer) : string;

Function FormatZero : string;
var i : integer;
begin
     result := '0.';
     for i := 1 to precisionU do result := result+'0';
end;

var
   tampon  : string;
   unite   : TcoefUnite;
   PuissanceDix : double;
   Longueur : integer;
   AbsNombre : double;
   negatif : boolean;
begin
     if isNan(Nombre) or isInfinite(nombre) then begin
        result := '';
        exit;
     end;
     if isZero(Nombre,1e-24) then begin
        result := formatZero;
        exit;
     end;
     absNombre := abs(Nombre);
     negatif := nombre<0;
     try
     PuissanceDix := Dix(ceil(log10(absNombre))-precisionU);
     except
       result := '?';
       exit;
     end;
     AbsNombre := round(AbsNombre/PuissanceDix)*PuissanceDix;
     unite := nulle;
     while ( AbsNombre>=999 ) and (unite<infini) do begin
          AbsNombre := AbsNombre/1000;
          inc(unite)
     end; // abs(nombre)<1000 ou infini
     if unite=infini then begin // ne devrait pas arriver
        result := 'INF';
        exit
     end;
     while ( AbsNombre<0.999 ) and (unite>zero) do begin
          AbsNombre := AbsNombre*1000;
          Dec(unite)
     end; // abs(nombre)>=1 ou zero
     if unite=zero then begin // ne devrait pas arriver
        result := FormatZero;
        exit
     end;
     longueur := succ(PrecisionU); // succ pour le point
     if AbsNombre<10
       then tampon := FloatToStrF(AbsNombre,ffGeneral,longueur,longueur-2)
// 2 = un chiffre avant la virgule + virgule
       else if AbsNombre<100
            then tampon := FloatToStrF(AbsNombre,ffGeneral,longueur,longueur-3)
// 3 =  deux chiffres avant la virgule + virgule
            else tampon := FloatToStrF(AbsNombre,ffGeneral,longueur,longueur-4);
// 4 =  trois chiffres avant la virgule + virgule
      while tampon[1]=' ' do delete(tampon,1,1);
      longueur := pos(FormatSettings.decimalSeparator,tampon);
      if longueur<=PrecisionU
         then tampon := copy(tampon,1,PrecisionU+1)
         else tampon := copy(tampon,1,PrecisionU);
   if negatif then tampon := '-' + tampon;
   if unite<>nulle then tampon := tampon+expUnite[unite];
   result := tampon;
end; // FormatIngenieur

Function FormatMilli(Nombre : double;PrecisionU : integer) : string;
var
   Longueur : integer;
   i : integer;
begin
     if isNan(Nombre) or isInfinite(Nombre) then result := ''
     else begin
     result := FormatGeneral(Nombre,PrecisionU);
     longueur := precisionU-length(result)+1;// +1=decimalSeparator
     if (longueur>0) and
          (pos(FormatSettings.decimalSeparator,result)>0) and
          (pos('E',result)<=0) then begin
           for i := 1 to longueur do
               result := result+'0';
     end;
     end;
end; // FormatMilli

Function FormatGeneral(const Nombre : double;const Nchiffres : integer) : string;
var Nexp,posV,posE,i : integer;
    exposant : string;
begin
   if isNan(Nombre) or isInfinite(Nombre)
      then FormatGeneral := ''
      else begin
           result := FloatToStrF(nombre,ffGeneral,Nchiffres,2);
           posV := pos(FormatSettings.decimalSeparator,result);
           if posV=0
        then begin
           posE := pos('E',result);
           if posE>0
              then begin
                 exposant := copy(result,posE+1,length(result)-posE);
                 result := copy(result,1,posE-1);
                 Nexp := Nchiffres-posE+1;
              end
              else begin
                 exposant := '';
                 Nexp := Nchiffres-length(result);
              end;
           if Nexp>0 then begin
              result := result+FormatSettings.decimalSeparator;
              for i := 1 to Nexp do result := result+'0';
           end;
        end
        else begin
           posE := pos('E',result);
           if posE>0
              then begin
                 exposant := copy(result,posE+1,length(result)-posE);
                 result := copy(result,1,posE-1);
                 Nexp := Nchiffres-posE+2;
              end
              else begin
                 exposant := '';
                 Nexp := Nchiffres-length(result)+1;
              end;
           if result[1]='-' then begin
             inc(Nexp);
             if result[2]='0' then inc(Nexp);
           end
           else if result[1]='0' then inc(Nexp);
           for i := 1 to Nexp do result := result+'0';
        end;
     end;
     if exposant<>'' then begin
         Nexp := strToInt(exposant);
         result := result+pointMedian+'10'+powerToStr(Nexp);
     end;
end; // FormatGeneral

Function FormatRadian(Nombre : double) : string;
var num,denom : integer;
    strNum,strDenom : string;
begin
   if nombre<0 then strNum := '-' else strNum := '';
   nombre := abs(nombre);
   AngleEnRadian(nombre);
   if nombre<pi/12
      then result := '0'
      else begin
          denom := 12;
          num := round(nombre*12/pi);
          if num mod 2 = 0 then begin
             num := num div 2;
             denom := denom div 2;
          end;
          if num mod 2 = 0 then begin
             num := num div 2;
             denom := denom div 2;
          end;
          if num mod 3 = 0 then begin
             num := num div 3;
             denom := denom div 3;
          end;
          if AngleEnDegre
             then result := StrNum+IntToStr(180*num div denom)
             else begin
                if denom=1 then strDenom := '' else strDenom := '/'+intToStr(Denom);
                if num<>1 then strNum := strNum + intToStr(Num);
                result := strNum+piMin+strDenom;
             end;
     end;
end; // FormatRadian

Function FormatReg(const Nombre : double) : string;
begin
       result := FormatMilli(Nombre,Precision)
end;

Function FormatCourt(const Nombre : double) : string;
begin
       result := FormatMilli(Nombre,PrecisionMin)
end;

Function ChainePrec(const Prec : double) : String;
begin
   if prec>=1
       then result := '???'
       else if prec>1e-3
          then result := FloatToStrF(prec*100,ffGeneral,1,0)+' %'
          else result := '<0,1%';
    result := ' '+result;
end;

Function NbreLigneWin(const s : String) : LongInt;
var fin : integer;
    StValeur : string;
begin
     fin := 2;
     while (s[fin]>='0') and
     	   (s[fin]<='9') do inc(fin);
     stValeur := copy(s,2,fin-2);
     try
     NbreLigneWin := StrToInt(stValeur)
     except
        on EConvertError do NbreLigneWin := 0
     end
end;

function litColor(couleurDefaut : Tcolor) : TColor;
var couleurStr : string;
    couleurInt : longWord;
begin
    try
    readln(fichier,couleurStr);
    couleurInt := round(strToFloat(couleurStr));
    couleurInt := couleurInt mod 16777216; // 2^24
    result := Tcolor(couleurInt);
    except
        result := couleurDefaut
    end;
end;

procedure afficheErreur(const strErreur : string;const HelpCtx : LongInt);
var  Boutons : TMsgDlgButtons;
     SauveCursor : Tcursor;
begin
     if HelpCtx=0
        then boutons := [mbOK]
        else boutons := [mbOK,mbHelp];
     SauveCursor := Screen.cursor;
     Screen.cursor := crDefault;
  //   (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
     MessageDlg(strErreur,mtError,boutons,HelpCtx);
     Screen.cursor := SauveCursor;
end;

Function PowerToStr(puiss : integer) : string;
var tampon : string;
    i : integer;
    numero : integer;
begin
  if puiss=0
     then result := ''
     else begin
        tampon := IntToStr(puiss);
        result := '';
        for i := 1 to length(tampon) do
            case tampon[i] of
               '0'..'9' : begin
                  numero := strToInt(tampon[i]);
                  result := result+chiffreExp[numero];
               end;
               '+' : result := result+PlusExp;
               '-' : result := result+MoinsExp;
            end;
      end;
end;

function Compte(const chaine,sousChaine : string) : integer;
var index : integer;
begin
     index := System.StrUtils.PosEx(sousChaine,chaine,1);
     result := 0;
     while index>0 do begin
           inc(result);
           index := System.StrUtils.PosEx(sousChaine,chaine,index+length(sousChaine));
     end;
end;

Function IsLigneComment(const ligneCourante : String) : boolean;
// ligne vide ou ligne de commentaire
var PosBlanc : integer;
begin
    posBlanc := 1;
    while (posBlanc<=length(ligneCourante)) and
          (ligneCourante[posBlanc]=' ') do inc(posBlanc);
    IsLigneComment :=
        (posBlanc>length(ligneCourante)) or
        charInSet(ligneCourante[posBlanc],['''',';'] )
end;

function EnTeteRW3 : boolean;
begin
   result := false;
   ligneWin := '';
   try
   readln(fichier,ligneWin);
   result := Pos('REGRESSI WINDOWS',ligneWin)>0;
   except
        FinFichierWin := true;
   end;
   finFichierWin := finFichierWin or eof(fichier);
   RW3Unicode := false;
end;

function litLigneWinU : string;
var ligneShort : shortString;

Procedure RW3versUnicode;
const
  NouveauCode : array[123..188] of Char =
    ('a','b',sigmaMin,'c','d',
     alpha,beta,
     chi,deltaMin,epsilon,phiMin,gammaMin,eta,lambdaMin,#137,nu,piMin,
     theta,rho,sigmaMin,tau,omegaMin,#145,#146,xi,psi,zeta,
     deltaMaj,phiMaj,gammaMaj,lambdaMaj,piMaj,thetaMaj,sigmaMaj,omegaMaj,xiMaj,psiMaj,
     #160,#161,#162,#163,WideChar($00B3),#165,#166,#167,#168,WideChar($2074),
     MoinsExp,#171,WideChar($2076),WideChar($2077),WideChar($2078),#175,#176,#177,WideChar($00B2),WideChar($00B3),
     #180,mu,#182,#183,PlusExp,WideChar($00B9),WideChar($2070),#187,WideChar($0079));

// 200-209 » … Ã   Õ Œ  œ –   —
// 210 219 “ ”  ‘  ’÷ ◊ ÿ Ÿ  ⁄ €

var i : integer;
    numero : integer;
begin
     ligneWin := '';
     for i := 1 to length(ligneShort) do begin
         numero := ord(ligneShort[i]);
         if (numero=194) then continue;
// Les caractères au-delà de 7 bits sont différents selon l'encodage...
// £ encodé en UTF-8 donne (194)(163) ce qui, lu en latin-1, fait Â£.
         if (numero<123) or (numero>188)
            then ligneWin := ligneWin+char(numero)
            else ligneWin := ligneWin+NouveauCode[numero]
     end;
end;

begin
   try
   finFichierWin := finFichierWin or eof(fichier);
   if finFichierWin
      then begin
        ligneWin := '';
        result := '';
      end
      else begin
      readln(fichier,ligneShort);
      RW3versUnicode;
      result := ligneWin;
   end;
   except
       FinFichierWin := true;
       ligneWin := '';
       result := '';
   end;
end;

function litLigneWin : string;
begin
   try
   finFichierWin := finFichierWin or eof(fichier);
   if finFichierWin
      then ligneWin := ''
      else readln(fichier,ligneWin);
   if (length(ligneWin)>1) and (ligneWin[1]='Â') then delete(ligneWin,1,1);
   result := ligneWin;
   except
       FinFichierWin := true;
       ligneWin := '';
       result := '';
   end;
end;

procedure readLnNombreWin(var z : double);
begin
    try
    readln(fichier,z);
    if z=1e-26 then z := nan;
    except
        z := nan;
    end;
end;

function litBooleanWin : boolean;
begin
   litLigneWin;
   litBooleanWin := (length(ligneWin)>0) and (ligneWin[1]<>'0')
end;

Function ToucheValidation(key : word) : boolean;
begin
    ToucheValidation := key in [vk_tab,vk_left,vk_right,vk_down,vk_up,vk_return]
end;

Procedure VerifKeyGetFloat(var key : char);
begin
     if charinset(key,[',','.'])
        then key := FormatSettings.decimalSeparator
        else if not charinset(key,CharGetFloat) then key := #0
end;

Procedure VerifKeyGetInt(var key : char);
begin
     if not charinset(key,CharGetInt) then key := #0
end;

Procedure ValidateReel(Sender : Tedit;var z : double);
begin
     try
         z := StrToFloatWin(sender.text)
     except
         sender.text := FloatToStr(z);
         raise EGetFloatError.Create(erNombre)
     end;
end;

function PadChar(const S : String;Len : integer;Achar : char) : String;
// Return a string right-padded to length len with Achar
var i,Slen : integer;
begin
   SLen := length(S); 
   if SLen>=Len
      then result := copy(S,1,Len)
      else begin
         result := S;
         for i := Slen+1 to len do
             result := result + Achar;
      end;
end;

function Pad(const S : String;Len : integer) : String;
// Return a string right-padded to length len with ' '
begin
     result := PadChar(S,len,' ')
end;

Function DureeEcoulee(const InstantDebut : TdateTime) : double;
var h,m,s,ms : word;
begin
      decodeTime(time-instantDebut,h,m,s,ms);
      DureeEcoulee := h*3600.0+m*60.0+s*1.0+ms*0.001;
end;

Function existeOption(opt : char;const defaut : boolean) : boolean;
var chaine : String;
    i : integer;
begin
    result := defaut;
    for i := 1 to ParamCount do begin
       chaine := ParamStr(i);
       if (length(chaine)>1) and (chaine[1]='/') and (upcase(chaine[2])=opt) then begin
          if length(chaine)=2
             then result := true
             else result := (chaine[3]='+');
          exit;
       end;
     end;
end;

Function CaracToChiffre(carac : char) : integer;
var i : integer;
begin
      if charInSet(carac,chiffre)
         then result := ord(carac)-ord('0')
         else begin
            result := 0;
            for i := 0 to 9 do
                if carac=ChiffreExp[i] then begin
                   result := i;
                   break;
                end;
         end
end;

procedure NewPage;
begin with PrinterParam do begin
    Cur.X := MargeTexte;
    Cur.Y := MargeTexte;
    Printer.NewPage;
end end;

function HeightLinePrinter : Word;
begin
    Result := abs(Printer.Canvas.Font.Height)
end;

Procedure VerifOrpheline(count : integer;var debut : integer);
var hauteur : integer;
begin
    Hauteur := succ(count)*HeightLinePrinter;
    PrinterParam.PageH := GetDeviceCaps (Printer.Handle,PHYSICALHEIGHT); //??
    if (debut+hauteur)>PrinterParam.PageH
        then begin
             Printer.NewPage;
             debut := 0;
             DebutImpressionTexte(debut);
        end
        else begin
             DebutImpressionTexte(debut);
             ImprimerLigne('',debut);
        end;
end;

// Start a new line on the current page, if no more lines left start a new page
procedure NewLine;
begin with printerParam do begin
    Cur.X := MargeTexte;
    if Height = 0
       then Inc(Cur.Y,HeightLinePrinter)
       else Inc(Cur.Y,Height);
    if Cur.Y > (Finish.Y - Height) then NewPage;
    Height := 0;
end end;

// Print a string to the printer without regard to special characters
procedure ImprimerTexte(const TextStr: string);
var L : integer;
begin with PrinterParam do begin
    L := Printer.Canvas.TextWidth(TextStr);
    Printer.Canvas.TextOut(Cur.X,Cur.Y,TextStr);
    Inc(Cur.X,L);
end end;

procedure ImprimerColonne(const TextStr: string;const largeurCol,NumCol : integer);
var XX : integer;
begin with PrinterParam do begin
    Cur.X := margeTexte+numCol*largeurCol;
    if GridPrint then begin
       XX := Cur.X+largeurCol-3; // ligne en fin de colonne
       Printer.Canvas.MoveTo(XX,Cur.Y-1);
       Printer.Canvas.LineTo(XX,Cur.Y+height-1);
    end;
    ImprimerTexte(textStr);
end end;

Function FinImpressionTexte : integer;
begin
     NewLine;
     result := printerParam.Cur.Y
end;

procedure ImprimerLigne(const TextStr : string;var debut : integer);
begin
    ImprimerTexte(textStr);
    debut := finImpressionTexte;
end;

Procedure DebutImpressionTexte(var haut : integer);
var limite : Trect;
begin with printerParam do begin
     limite := Printer.Canvas.ClipRect;
     with limite do begin
        PageW := right-left;
        PageH := bottom-top;
     end;
     if printer.Orientation=poPortrait
        then MargeTexte := PageW div MargeImprimante
        else MargeTexte := PageW div MargeImprimantePaysage;
     Finish.X := PageW-margeTexte;
     Finish.Y := PageH-margeTexte;
     Cur.X := MargeTexte;
     if haut<margeTexte then haut := MargeTexte;
     if haut>Finish.Y
       then NewPage
       else Cur.Y := haut;
     Height := 0;
     Printer.title := stRegressi;
     Printer.Canvas.Font.Name := FontName;
     Printer.Canvas.Font.Size := FontSizeImpr;
     Printer.Canvas.Font.Color := clBlack;
     Printer.Canvas.TextFlags := 0;
     Printer.canvas.Brush.Style := bsClear;
end end;

Procedure FinImpressionGr;
begin
     printer.endDoc;
     printer.orientation := printerParam.sauveOrientation
end;

Procedure DebutImpressionGr(Orientation : TprinterOrientation;var bas : integer);
begin
     printerParam.sauveOrientation := printer.orientation;
     printer.Orientation := Orientation;
     printer.title := stRegressi;
     PrinterParam.PageW := GetDeviceCaps (Printer.Handle,PHYSICALWIDTH); //??
     PrinterParam.PageH := GetDeviceCaps (Printer.Handle,PHYSICALHEIGHT); //??
     with printerParam do begin
        MargeTexte := PageW div MargeImprimante;
        Finish.X := PageW-margeTexte;
        Finish.Y := PageH-margeTexte;
        Cur.X := MargeTexte;
        Cur.Y := MargeTexte;
        Height := 0;
     end;
     Printer.Canvas.Font.Name := FontName;
     Printer.Canvas.Font.Size := FontSizeImpr;
     Printer.Canvas.Font.Color := clBlack;
     bas := 0;
     printer.beginDoc;
     ImprimerLigne(userName,bas);
end;

procedure ImprimerGrid(g : TstringGrid;var debut : integer);

var colMax,LargeurColonne,Longueur : integer;

procedure PrintPermute;
var r,c : integer;
    rdebut,rfin,bloc : integer;
    texte : string;
begin with G do begin
      if rowCount>64 then begin
          afficheErreur(erGrandTableau,0);
          exit;
      end;
      if GridPrint then with PrinterParam do begin
           Printer.Canvas.MoveTo(margeTexte,Cur.Y-1);
           Printer.Canvas.LineTo(Finish.X,Cur.Y-1);
      end;
      for bloc := 0 to rowCount div (colMax-1) do begin
          rdebut := bloc*(colMax-1)+2; // -1 = nom(unité)
          rfin := rdebut+(colMax-1);
          if rfin>rowCount then rfin := rowCount;
          for c := 0 to pred(colCount) do begin
             texte := cells[c,0];
             if cells[c,1]<>'' then texte := texte+'('+cells[c,1]+')';
             ImprimerColonne(texte,largeurColonne,0);
             for r := rdebut to pred(rfin) do
                 ImprimerColonne(cells[c,r],largeurColonne,(r-rdebut) + 1);
             newLine;
             if GridPrint then with PrinterParam do begin
                  Printer.Canvas.MoveTo(margeTexte,Cur.Y-1);
                  Printer.Canvas.LineTo(Finish.X,Cur.Y-1);
             end;
          end;
      end;
end end;

Procedure PrintNormal;
var r,c,colDebut,colFin,pas,XX,oldY : integer;
begin with G do begin
      colDebut := 0;
      if GridPrint then with PrinterParam do begin // ligne horizontale
           Printer.Canvas.MoveTo(margeTexte,Cur.Y-1);
           Printer.Canvas.LineTo(Finish.X,Cur.Y-1);
      end;
      pas := succ(rowCount div 64);
      repeat
         colFin := pred(ColCount);
         if (colFin-colDebut)>=colMax
            then colFin := colDebut+pred(colMax);
         oldY := 0; // pour le compilateur
         for r := 0 to pred(RowCount) do begin
             if (r<3) or (((r-2) mod pas)=0) then begin
                if GridPrint then begin // ligne verticale au début
                   XX := printerParam.Cur.X+largeurColonne-3;
                   Printer.Canvas.MoveTo(XX,printerParam.Cur.Y-1);
                   Printer.Canvas.LineTo(XX,printerParam.Cur.Y+printerParam.Height-1);
                end;
                for c := colDebut to colFin do
                    ImprimerColonne(cells[c,r],largeurColonne,c-colDebut);
                if r=0 then oldY := PrinterParam.Cur.Y-1;
                NewLine;
                if GridPrint then with PrinterParam do begin // ligne horizontale
                   if r=0 then begin
                      Printer.Canvas.MoveTo(margeTexte,oldY);
                      Printer.Canvas.LineTo(margeTexte+(colFin-colDebut+1)*largeurColonne,oldY);
                   end;
                   Printer.Canvas.MoveTo(margeTexte,cur.Y-1);
                   Printer.Canvas.LineTo(margeTexte+(colFin-colDebut+1)*largeurColonne,cur.Y-1);
                end;
             end;
         end;
         colDebut := colFin+1;
      until colDebut>pred(colCount);
end end;

begin with G do begin // ImprimerGrid
      Printer.Canvas.TextFlags := 0;
      Longueur := Precision+6; // blanc signe . Exx
      DebutImpressionTexte(debut);
      NewLine;
      LargeurColonne := Printer.Canvas.TextWidth(PadChar('',longueur,'A'));
      colMax := (printerParam.PageW-2*printerParam.MargeTexte) div largeurColonne;
      if permuteColRow and (rowCount>colCount)
         then printPermute
         else printNormal;
      NewLine;
      debut := FinImpressionTexte;
end end; // ImprimerGrid

Function LitBool : boolean;
var m : integer;
begin
      readln(fichier,m);
      result := boolean(m);
end;

constructor TparamAnimation.create;
begin
    inherited create;
    init;
end;

function TparamAnimation.sliderMaxValue : integer;
begin
     if variationLog
        then begin
           try
           result := round(log10(finA/debutA)/log10(pasA));
           except
               result := 16;
               try
               pasA := power(10,log10(finA/debutA)/16);
               except
                   debutA := 1;
                   finA := 10;
                   pasA := power(10,1/16);
               end;
           end;
           if result>MaxPasAnim then begin
               result := MaxPasAnim;
               pasA := power(10,log10(finA/debutA)/MaxPasAnim);
           end;
        end
        else begin
           try
           result := round((finA-debutA)/pasA);
           except
              result := 16;
              pasA := (finA-debutA)/16;
              if pasA=0 then begin
                 finA := debutA+1;
                 pasA := 1/16;
              end;
           end;
           if result<2 then begin
               result := 2;
               if abs(DebutA)<1E-9 then debutA := 1E-9;
               pasA := abs(debutA);
               finA := debutA+pasA;
           end;
           if result>MaxPasAnim then begin
               result := MaxPasAnim;
               pasA := (finA-debutA)/MaxPasAnim;
           end;
        end;
end;

procedure TparamAnimation.init;
begin
     nomA := '';
     codeA := 255;
     ValeurA := Nan;
     DebutA := Nan;
     FinA := Nan;
     PasA := Nan;
     active := false;
     variationLog := false;
     aInitialiser := false;
end;

Procedure TparamAnimation.litFichier(NbreItem : integer);
var i,intZut : integer;

function getReel(defaut: double) : double;
var texte : string;
begin
     readln(fichier,texte);
     texte := Trim(texte);
     if (texte='NAN') or (texte='INF') or (texte='-INF')
        then result := defaut
        else result := strToFloatWin(texte);
end;

begin
     PasA := getReel(1);{1}
     readln(fichier,NomA);{2}
     DebutA := getReel(0);{3}
     FinA := getReel(debutA+16*pasA);{4}
     readln(fichier,intZut);{5}
     active := intZut>0;
     readln(fichier,intZut);{6}
     variationLog := intZut>0;
     verifMinMaxReal(debutA,finA);
     if NbreItem>6
        then valeurA := getReel(debutA) {7}
        else valeurA := debutA;
     pasA := abs(pasA);
     for i := 8 to NbreItem do readln(fichier);
end;

procedure TparamAnimation.LoadXML(ANode : IXMLNode);

procedure LitEnfant(Anode : IXMLNode);
begin
   if ANode.NodeName='valeur' then begin
      valeura := getFloatXML(ANode);
      exit;
   end;
   if ANode.NodeName='debut' then begin
      debuta := getFloatXML(ANode);
      exit;
   end;
   if ANode.NodeName='fin' then begin
       fina := getFloatXML(ANode);
       exit;
   end;
   if ANode.NodeName='pas' then begin
       pasa := getFloatXML(ANode);
       exit;
   end;
   if ANode.NodeName='active' then begin
     active := getBoolXML(ANode);
     exit;
   end;
   if ANode.NodeName='Log' then begin
     variationLog := getBoolXML(ANode);
     exit;
   end;
   if ANode.NodeName='Nom' then begin
     nomA := ANode.text;
     exit;
   end;
end;

var i : integer;
begin
   if ANode.HasChildNodes then
      for i := 0 to ANode.ChildNodes.Count - 1 do
          LitEnfant(ANode.ChildNodes.Nodes[i]);
end; // TParamAnimation.loadXML

Function FormatLongueDureeAxe(const nombre : double) : string;
var t : longInt;
    min,hour,day : integer;
begin
    result := '';
    t := round(nombre);
    day := t div UnJour;
    if day>0 then result := intToStr(day)+'j';
    t := t-day*UnJour;
    hour := t div UneHeure;
    if hour>0 then result := result+IntToStr(hour)+'h';
    if day=0 then begin
       t := t-hour*UneHeure;
       min := t div UneMinute;
       result := result+IntToStr(min);
    end;
end;

procedure TParamAnimation.StoreXML(ANode : IXMLNode);
begin
  writeFloatXML(ANode,'valeur',valeurA);
  writeFloatXML(ANode,'debut',debutA);
  writeFloatXML(ANode,'fin',finA);
  writeFloatXML(ANode,'pas',pasA);
  writeBoolXML(ANode,'Log',variationLog);
  writeBoolXML(ANode,'active',active);
  writeStringXML(ANode,'Nom',nomA);
end; // dessin.storexml

Procedure TparamAnimation.ecritFichier;
begin
      writeln(fichier,PasA);   {1}
      writeln(fichier,nomA);   {2}
      writeln(fichier,debutA);   {3}
      writeln(fichier,finA); {4}
      writeln(fichier,ord(active)); {5}
      writeln(fichier,ord(variationLog)); {6}
      writeln(fichier,valeurA); {7}
end;

procedure VerifMemo(memo: TRichEdit);
var oldSelStart : integer;
begin
     oldSelStart := memo.SelStart;
     memo.SelectAll;
     memo.selAttributes.size := fontSizeMemo;
     memo.selAttributes.style := [];
     memo.selLength := 0;
     memo.DefAttributes := memo.SelAttributes;
     memo.font.size := fontSizeMemo;
     memo.SelStart := oldSelStart;
end;

function valeur125(valInt : integer;down : boolean) : integer;
var mantisse,exposant,coeff : double;
    valeur : double;
begin
     if down
        then Valeur := ValInt/2.15
        else Valeur := ValInt*2.15;
     exposant := log10(valeur);
     coeff := Int(exposant);
     if (exposant<0) and (coeff<>exposant) then coeff := coeff-1;
     coeff := power(10,coeff);
     mantisse := Int(valeur/coeff);
     if mantisse>2 then if mantisse<6
           then mantisse := 5
           else mantisse := 10;
     result := round(mantisse*coeff);
end;

procedure AffecteStatusPanel(var Astatus : TstatusBar;i : integer;const Atext : string);
begin with Astatus.panels[i] do begin
     text := ' '+Atext+' ';
     width := Length(Atext)*abs(Astatus.font.height)*2 div 3;
end end;

procedure VideStatusPanel(var Astatus : TstatusBar;i : integer);
begin with Astatus.panels[i] do begin
     text := '';
     width := 16;
end end;

    function TstrListe.MyIndexOf(const Item : string) : Integer;
    var i : integer;
        zut : string;
    begin
        result := -1;
        for i := 0 to pred(count) do begin
            zut := strings[i];
            if pos(RepereConst,zut)>0 then
               system.delete(zut,1,length(RepereConst));
            if Item=zut then begin
               if Item=SeparateurConst
                  then result := i-1
                  else result := i;
               exit;
            end;
        end;
    end;

    function getNomCoord(nom : string) : string;
    begin
       if pos(RepereConst,nom)>0 then
          system.delete(nom,1,length(RepereConst));
       result := nom;
    end;

    function FichierGroupe : String;
    begin
        result := GroupeDir+'\Regressi.RW3'
    end;

Procedure AddBackSlash(var aPath : String);
var long : integer;
Begin
  Long := Length(aPath);
  If (Long>1) and (aPath[Long] <> '\') Then
         aPath := aPath + '\';
End;

Procedure RemoveBackSlash(var aPath : String);
var long : integer;
Begin
  Long := Length(aPath);
  If (Long>1) and (aPath[Long] = '\') Then
         delete(aPath,Long,1);
End;

// permet de retrouver un repertoire d'après sa valeur CSIDL
Function GetFolder(CSIDLValue: integer): String;
Var
  IdList    : PItemIdList;
  Folder    : Array[0..MAX_PATH] Of Char;
Begin
  if Failed(SHGetFolderLocation(0, CSIDLValue, 0, 0, IdList))
  then result := ''
  else begin
      SHGetPathFromIDList(IdList, Folder);
      result := folder;
      AddBackSlash(result);
  end;
End;

Function LigneDeChiffres(const s : String) : boolean;
var j : integer;
    AvecChiffres : boolean;
begin
    Result := false;
    AvecChiffres := false;
    for j := 1 to length(s) do
        if charinset(s[j],caracNombre) or
           (charinset(s[j],caracPrefixeSI) and (j>1) and
           charinset(s[j-1],chiffre))
           then avecChiffres := true
           else if not charinset(s[j],separateur) then exit;
    result := avecChiffres;
end;

Procedure WindowsVersXML(var s : String);
const
  NouveauCode : array[128..160] of Char =
    (alpha,beta,chi,deltaMin,epsilon,phiMin,gammaMin,eta,lambdaMin,#137,
     nu,pimin,theta,rho,sigmaMin,tau,omegaMin,#145,#146,xi,
     psi,zeta,deltaMaj,phiMaj,gammaMaj,lambdaMaj,piMaj,thetaMaj,sigmaMaj,omegaMaj,
     xiMaj,psiMaj,#160);

var i,numero : integer;
    resu : string;
begin
     resu := '';
     for i := 1 to length(s) do begin
         numero := ord(s[i]);
         if (numero<127) or (numero>160)
            then resu := resu+s[i]
            else resu := resu+NouveauCode[numero]
     end;
     s := resu;
end;

Function isLettre(carac : char) : boolean;
begin
    result := charInSet(carac,Lettres);
    if not result then result := pos(carac,grecque)>0;
end;

Function isCaracGrandeur(carac : char) : boolean;
begin
    result := isLettre(carac);
    if not result then result :=
         charInset(carac,SuiteCaracGrandeur);
end;

Function isCaracUnite(carac : char) : boolean;
const caracUnite: TSysCharSet =
      ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'l', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'y', 'z',
       'A', 'B', 'C', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'S', 'T', 'V', 'W', 'Y', 'Z',
       '°', '-', '/', 'µ', '^',
       '1', '2', '3'];
begin
    result := charInset(carac,CaracUnite);
    if not result then
       if carac=OmegaMaj then begin
            result := true;
            exit;
       end;
end;

Procedure convertitExpUnite(var unite : string);
var i : integer;
    caracCourant : char;
    numero : integer;
begin
    for i := 1 to length(unite) do begin
        caracCourant := unite[i];
        if caracCourant = '-' then
           Unite[i] := moinsExp;
         if caracCourant = '+' then
            Unite[i] := plusExp;
         if charInSet(caracCourant,chiffre) then begin
            numero := strToInt(Unite[i]);
            Unite[i] := chiffreExp[numero];
         end;
    end;
end;

procedure ecritChaineRW3(const s : string);
var sRW3 : shortString;

Procedure UnicodeVersRW3;
var i,j : integer;
    carac : char;
    caracR : AnsiChar;
begin
     sRW3 := '';
     for i := 1 to length(s) do begin
         carac := s[i];
         if (pos(carac,grecque)>0) or
            (pos(carac,lettreAccent)>0) or
            (pos(carac,chiffrePuiss)>0)
            then case carac of
                      alpha : caracR := alphaR;
                      beta : caracR := betaR;
                      gammaMin: caracR := gammaR;
                      gammaMaj: caracR := gammaMajR;
                      deltaMin: caracR := deltaR;
                      deltaMaj: caracR := deltaMajR;
                      epsilon: caracR := epsilonR;
                      zeta: caracR := zetaR;
                      eta: caracR := etaR;
                      kappa: caracR := 'k';
                      lambdaMin: caracR := lambdaR;
                      lambdaMaj: caracR := lambdaMajR;
                      mu: caracR := muR;
                      nu: caracR := nuR;
                      xi: caracR := xiR;
                      xiMaj: caracR := xiMajR;
                      pimin: caracR := piR;
                      piMaj: caracR := piMajR;
                      rho: caracR := rhoR;
                      sigmaMin: caracR := sigmaR;
                      sigmaMaj: caracR := sigmaMajR;
                      tau: caracR := tauR;
                      theta: caracR := thetaR;
                      thetaMaj: caracR := thetaMajR;
                      phiMin: caracR := phiR;
                      phiMaj: caracR := phiMajR;
                      chi: caracR := chiR;
                      psi: caracR := psiR;
                      psiMaj: caracR := psiMajR;
                      omegaMin: caracR := omegaR;
                      omegaMaj: caracR := omegaMajR;
                      'é' : caracR := AnsiChar(233);
                      'è' : caracR := AnsiChar(232);
                      'ê' : caracR := AnsiChar(234);
                      'ë' : caracR := AnsiChar(235);
                      'ï' : caracR := AnsiChar(239);
                      'à' : caracR := AnsiChar(224);
                      'â' : caracR := AnsiChar(226);
                      'ù' : caracR := AnsiChar(249);
                      'û' : caracR := AnsiChar(251);
                      'ü' : caracR := AnsiChar(252);
                      'ô' : caracR := AnsiChar(252);
                      MoinsExp : caracR := moinsExpR;
                      PlusExp : caracR := plusExpR;
                      InfEgal : caracR := infEgalR;
                      SupEgal : caracR := supEgalR;
                      else begin
                         caracR := '?';
                         for j := 0 to 9 do
                            if carac=ChiffreExp[j] then begin
                               caracR := ChiffreExpR[j];
                               break;
                            end;
                      end;
                 end
            else caracR := AnsiChar(carac);
            sRW3 := sRW3+caracR;
     end;
end;

begin
    UnicodeVersRW3;
    writeln(fichier,sRW3);
end;

function IniReadFloat(const Ini : TMemIniFile;const Section, Name: string; ValDefault: Double): Double;
var
  FloatStr: string;
begin
  FloatStr := Ini.ReadString(Section, Name, '');
  Result := ValDefault;
  if FloatStr <> '' then
  try
    Result := StrToFloatWin(FloatStr);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;


var OldPrinter : integer;

Procedure ResetPrinter;
begin
     Printer.PrinterIndex := oldPrinter
end;

function GetUserName: string;
 var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey('\Volatile Environment', True);
  Result := Reg.ReadString('UserName');
end;

function SelectDir(var aDirectory : string) : boolean;
begin
    result := SelectDirectory(aDirectory,[sdAllowCreate,sdPerformCreate,sdPrompt],0)
end;

(*
//Module permettant d'effectuer un Redimensionnement par Interpolation BiLinéaire
//l'Image résultante est bien meilleur qu'avec un redimensionnement brute (problème d'Aliasing)
//Créé par MORLET Alexandre en Mai 2002
//Basé sur le Code Source en C de Christophe Boyanique et Emmanuel Pinard
//L'Interpolation BiLinéaire consiste à utiliser les 4 points les
//plus proches des cordonnées calculées dans l'image source en les pondérant par des
//coefficients inversement proportionnels à la distance et dont la somme vaut 1

PROCEDURE zoom_LINEAIRE(VAR BMP : TBitmap; CONST zoom : single);
TYPE
TRGBArray = ARRAY[0..0] OF TRGBTriple;
PRGBArray = ^TRGBArray;
VAR
Largeur, Hauteur : integer;
X, Y : integer; //coordonnées image source
I, J : integer; //coordonnées image destination
Diff0,Diff1,Diff2,Diff3 : single; //distance pour l'interpolation bilinéaire
DX0, DX1, DY0, DY2 : single; //coordonnees image source (points voisins, reelles)
X0,X1,X2,X3, Y0,Y1,Y2,Y3 : integer;  //coordonnees image source (points voisins, entieres)
XR, YR : double; //coordonnees image source (reelles)
R0,R1,R2,R3 : integer;
G0,G1,G2,G3 : integer;
B0,B1,B2,B3 : integer;
TabScanlineBMP : array of PRGBArray;
TabScanlineBMPF : PRGBArray;
V : single;
BMPF : vcl.Graphics.Tbitmap;
BEGIN
   WITH BMP DO BEGIN
        largeur := Width;
        hauteur := Height;
        pixelFormat := pf24bit;
   END;
   BMPF := vcl.Graphics.TBitmap.Create;
   WITH BMPF DO BEGIN
        Width := round(Largeur*zoom);
        Height := round(Hauteur*zoom);
        pixelFormat := pf24bit;
   END;

   setLength(TabScanlineBMP,BMP.Height);
   FOR J := 0 TO BMP.Height - 1 DO
       TabScanlineBMP[J] := BMP.Scanline[J];

   FOR J := 0 TO BMPF.Height - 1 DO BEGIN
       TabScanlineBMPF := BMPF.Scanline[J];
       YR := -0.5 + J / zoom;
       Y := Trunc(YR);
       Y := Min(Y, BMP.Height - 1);
       Y := Max(Y, 0);
       YR := Min(YR, BMP.Height - 1);
       YR := Max(YR, 0);
       DY0 := YR - Floor(YR);
       Y0 := Trunc(Floor(YR));
       Y1 := Y0;
       DY2 := 1 - DY0;
       Y2 := Y0 + 1;
       Y3 := Y2;
       FOR I := 0 TO BMPF.Width - 1 DO BEGIN
          XR := -0.5 + I / zoom;
	        X := Trunc(XR);
	        X := Min(X, BMP.Width - 1);
	        X := Max(X, 0);
	        XR := Min(XR, BMP.Width - 1);
	        XR := Max(XR, 0);

	        IF (X = XR) AND (Y = YR)
          THEN BEGIN
              TabScanlineBMPF[I] := TabScanlineBMP[Y,X]; // Direct
          END
          ELSE BEGIN
	          DX0 := XR - Floor(XR);
            X0 := Trunc(Floor(XR));
 	          DX1 := 1 - DX0;
            X1 := X0 + 1;
 	          X2 := X0;
            X3 := X1;

	          IF (DX0 = 0) THEN BEGIN  // 2 points sur verticale
		          Diff0 := 1 / Abs(DY0);
		          Diff2 := 1 / Abs(DY2);
		          V := 1/(Diff0 + Diff2);

		          R0 := TabScanlineBMP[Y0,X0].RGBTRed;
		          G0 := TabScanlineBMP[Y0,X0].RGBTGreen;
		          B0 := TabScanlineBMP[Y0,X0].RGBTBlue;

		          R2 := TabScanlineBMP[Y2,X2].RGBTRed;
		          G2 := TabScanlineBMP[Y2,X2].RGBTGreen;
		          B2 := TabScanlineBMP[Y2,X2].RGBTBlue;

		          TabScanlineBMPF[I].RGBTRed   := Trunc((R0*Diff0 + R2*Diff2)*V);
		          TabScanlineBMPF[I].RGBTGreen := Trunc((G0*Diff0 + G2*Diff2)*V);
		          TabScanlineBMPF[I].RGBTBlue  := Trunc((B0*Diff0 + B2*Diff2)*V);
		        END
            ELSE IF (DY0 = 0) THEN BEGIN // 2 points sur horizontale
		          Diff0 := 1 / Abs(DX0);
		          Diff1 := 1 / Abs(DX1);
		          V := 1/(Diff0 + Diff1);

		          R0 := TabScanlineBMP[Y0,X0].RGBTRed;
		          G0 := TabScanlineBMP[Y0,X0].RGBTGreen;
		          B0 := TabScanlineBMP[Y0,X0].RGBTBlue;

              R1 := TabScanlineBMP[Y1,X1].RGBTRed;
		          G1 := TabScanlineBMP[Y1,X1].RGBTGreen;
		          B1 := TabScanlineBMP[Y1,X1].RGBTBlue;

		          TabScanlineBMPF[I].RGBTRed   := Trunc((R0*Diff0 + R1*Diff1)*V);
		          TabScanlineBMPF[I].RGBTGreen := Trunc((G0*Diff0 + G1*Diff1)*V);
		          TabScanlineBMPF[I].RGBTBlue  := Trunc((B0*Diff0 + B1*Diff1)*V);
            END
            ELSE BEGIN
		          Diff0 := 1 / Sqrt( DX0*DX0 + DY0*DY0);
		          Diff1 := 1 / Sqrt( DX1*DX1 + DY0*DY0);
		          Diff2 := 1 / Sqrt( DX0*DX0 + DY2*DY2);
		          Diff3 := 1 / Sqrt( DX1*DX1 + DY2*DY2);
		          V := 1/(Diff0 + Diff1 + Diff2 + Diff3);

              R0 := TabScanlineBMP[Y0,X0].RGBTRed;
		          G0 := TabScanlineBMP[Y0,X0].RGBTGreen;
		          B0 := TabScanlineBMP[Y0,X0].RGBTBlue;

		          R1 := TabScanlineBMP[Y1,X1].RGBTRed;
		          G1 := TabScanlineBMP[Y1,X1].RGBTGreen;
		          B1 := TabScanlineBMP[Y1,X1].RGBTBlue;

              R2 := TabScanlineBMP[Y2,X2].RGBTRed;
		          G2 := TabScanlineBMP[Y2,X2].RGBTGreen;
		          B2 := TabScanlineBMP[Y2,X2].RGBTBlue;

		          R3 := TabScanlineBMP[Y3,X3].RGBTRed;
		          G3 := TabScanlineBMP[Y3,X3].RGBTGreen;
		          B3 := TabScanlineBMP[Y3,X3].RGBTBlue;

		          TabScanlineBMPF[I].RGBTRed :=
		          Trunc((R0*Diff0 + R1*Diff1 + R2*Diff2 + R3*Diff3)*V);

		          TabScanlineBMPF[I].RGBTGreen :=
		          Trunc((G0*Diff0 + G1*Diff1 + G2*Diff2 + G3*Diff3)*V);

		          TabScanlineBMPF[I].RGBTBlue :=
		          Trunc((B0*Diff0 + B1*Diff1 + B2*Diff2 + B3*Diff3)*V);
		        END; // 4 points
          END; // 2 ou 4 points
       END; // for I
   END;// for J
   BMP.Assign(BMPF);
   BMPF.Free;
END;
*)

procedure RotateBitmap(var Bmp: TBitmap;sensHoraire : boolean);
var
  Tmp: TBitmap;
  OffsetX,OffsetY: integer;
  Points: array[0..2] of TPoint;
begin
  Tmp := TBitmap.Create;
  try
    Tmp.Width := Bmp.Height;
    Tmp.Height := Bmp.Width;
    if sensHoraire
      then begin
        OffsetX := Tmp.Width;
        OffsetY := 0;
      end
      else begin
         OffsetX := 0;
         OffsetY := Tmp.Height;
      end;
    Points[0].X := OffsetX;
    Points[0].Y := OffsetY;
    Points[1].X := OffsetX;
    if sensHoraire
      then begin
        Points[1].Y := Bmp.Width;
        Points[2].X := 0;
      end
      else begin
         Points[1].Y := 0;
         Points[2].X := Bmp.Height;
      end;
    Points[2].Y := OffsetY;
    PlgBlt(Tmp.Canvas.Handle, Points, Bmp.Canvas.Handle, 0, 0, Bmp.Width,
           Bmp.Height, 0, 0, 0);
    Bmp.Assign(Tmp);
  finally
    Tmp.Free;
  end;
end;

procedure RotateBitmap2(Bmp: TBitmap; Rads: integer);
var
  C,S: integer;
  Tmp: TBitmap;
  OffsetX,OffsetY: integer;
  Points: array[0..2] of TPoint;
begin
  C := round(Cos(pi/2*Rads));
  S := round(Sin(pi/2*Rads));
  Tmp := TBitmap.Create;
  try
    Tmp.Width := Bmp.Width * Abs(C) + Bmp.Height * Abs(S);
    Tmp.Height := Bmp.Width * Abs(S) + Bmp.Height * Abs(C);
    OffsetX := (Tmp.Width - Bmp.Width * C + Bmp.Height * S) div 2;
    OffsetY := (Tmp.Height - Bmp.Width * S - Bmp.Height * C) div 2;
    Points[0].X := OffsetX;
    Points[0].Y := OffsetY;
    Points[1].X := OffsetX + Bmp.Width * C;
    Points[1].Y := OffsetY + Bmp.Width * S;
    Points[2].X := OffsetX - Bmp.Height * S;
    Points[2].Y := OffsetY + Bmp.Height * C;
    PlgBlt(Tmp.Canvas.Handle, Points, Bmp.Canvas.Handle, 0, 0,
       Bmp.Width, Bmp.Height, 0, 0, 0);
    Bmp.Assign(Tmp);
  finally
    Tmp.Free;
  end;
end;

Procedure Aide(index : integer);
begin
   if Application.HelpFile=''
       then ShowMessage('Regressi.chm non trouvé. Effectuer l''installation complète')
       else Application.HelpContext(index);
end;

Procedure AideStr(st : string);
begin
   if Application.HelpFile=''
       then ShowMessage('Regressi.chm non trouvé. Effectuer l''installation complète')
       else Application.HelpKeyword(st);
end;

{$IFDEF Debug}
procedure ecritDebug(s : string);
begin
//      exit;
      append(fichierDebug);
      writeln(fichierDebug,s);
      flush(fichierDebug);
      closeFile(fichierDebug);
end;
{$ENDIF}

(*
procedure SetFontSpeedButton(const sb : TSpeedButton;const DPI : integer);
begin
     sb.Font.Height := Screen.PixelsPerInch div 4;
     sb.height := sb.Font.Height;
     sb.width := sb.Font.Height+8;
end; //setFontSpeedButton

procedure SetFontSpeedButtonGr(const sb : TSpeedButton;const DPI : integer);
begin
     sb.Font.Height := Screen.PixelsPerInch div 4;
     sb.height := sb.Font.Height;
     sb.width := sb.Font.Height;
end; //setFontSpeedButton

procedure SetFontTEdit(const sb : TEdit;const DPI : integer);
begin
     sb.Font.Height := Screen.PixelsPerInch div 5;
     sb.width := 9*Screen.PixelsPerInch div 12;
end; //setFontSpeedButton
*)

(*
procedure ResizeButtonImagesforHighDPI(const container: TWinControl);
var
  b : TBitmap;
  i : integer;

  procedure ResizeGlyph(const sb : TSpeedButton; const bb : TBitBtn);
  var
    ng : integer;
  begin
    ng := 1;
    if Assigned(sb) then ng := sb.NumGlyphs;
    if Assigned(bb) then ng := bb.NumGlyphs;

    b := TBitmap.Create;
    try
      b.Width := ng * MulDiv(20, Screen.PixelsPerInch, Screen.DefaultPixelsPerInch);
      b.Height := MulDiv(20, Screen.PixelsPerInch, Screen.DefaultPixelsPerInch);
      b.Canvas.FillRect(b.Canvas.ClipRect);

      if Assigned(sb) AND (NOT sb.Glyph.Empty) then begin
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), sb.Glyph) ;
        sb.Glyph.Assign(b);
      end;

      if Assigned(bb) AND (NOT bb.Glyph.Empty) then begin
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), bb.Glyph) ;
        bb.Glyph.Assign(b);
      end;
    finally
      b.Free;
    end;
  end; //ResizeGlyph

  procedure ResizeGlyphSB(const sb : TSpeedButton);
  var
    ng : integer;
  begin
    if sb.Glyph.Empty then ng := 0 else ng := sb.NumGlyphs;
    if ng>0 then begin
      b := TBitmap.Create;
      try
        b.Height := MulDiv(20, Screen.PixelsPerInch, Screen.DefaultPixelsPerInch);
        b.Width := ng * b.Height;
        b.Canvas.FillRect(b.Canvas.ClipRect);
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), sb.Glyph) ;
        sb.Glyph.Assign(b);
      finally
        b.Free;
      end;
    end;
  end; //ResizeGlyphSB

  procedure ResizeGlyphBB(const bb : TBitBtn);
  var
    ng : integer;
  begin
    if bb.Glyph.Empty then ng := 0 else ng := bb.NumGlyphs;
    if ng>0 then begin
      b := TBitmap.Create;
      try
        b.Height := MulDiv(20, Screen.PixelsPerInch, Screen.DefaultPixelsPerInch);
        b.Width := ng * b.Height;
        b.Canvas.FillRect(b.Canvas.ClipRect);
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), bb.Glyph) ;
        bb.Glyph.Assign(b);
      finally
        b.Free;
      end;
    end;
  end; //ResizeGlyphBB

begin
  if Screen.PixelsPerInch = Screen.DefaultPixelsPerInch then Exit;

  for i := 0 to -1 + container.ControlCount do begin
     if container.Controls[i] is TBitBtn then ResizeGlyphBB(TBitBtn(container.Controls[i]));
     if container.Controls[i] is TGripSplitter then continue;
     if container.Controls[i] is TSpeedButton then ResizeGlyphSB(TSpeedButton(container.Controls[i]));
     if container.Controls[i] is TSpinEdit then continue;
     if container.Controls[i] is TSpinButton then continue;
     if container.Controls[i] is TStringGrid then TStringGrid(container.Controls[i]).DefaultRowHeight := hauteurColonne;
     if container.Controls[i] is TWinControl then
        ResizeButtonImagesforHighDPI(TWinControl(container.Controls[i]));
  end;

end; // ResizeButtonImagesforHighDPI
*)


(*
function CheckFile(FileName : string) : string;
var VirtualStorePath : string;
    Filepath : string;
begin
    if FileExists(FileName) then result := fileName;
    // Make sure path is padded to the right with a \
    FilePath := extractFilePath(fileName);
    FileName := extractFileName(fileName);
    AddbackSlash(FilePath);
    if pos(':',FilePath)=2 then FilePath := copy(FilePath,3,length(filePath));
    VirtualStorePath := GetFolder(CSIDL_Local_AppData);
    VirtualStorePath := VirtualStorePath + 'VirtualStore';
    AddbackSlash(VirtualStorePath);
    VirtualStorePath := VirtualStorePath + FilePath;
// CSIDL_LOCAL_APPDATA : C:\Documents and Settings\username\Local Settings\Application Data.
// return first VirtualStorePath if the file exists in user VirtualStore
    if (FileExists(VirtualStorePath + FileName)) then
        result:= VirtualStorePath + FileName;
    if (FileExists(FilePath + FileName)) then
        result := FilePath + FileName;
end;
*)

function CheckFileAvimeca(fileName : string) : string;
var VirtualStorePath : string;
    RegPath : string;
// Avimeca écrit dans
// C:\Users\JMM\AppData\Local\VirtualStore\Program Files (x86)\Evariste\Regressi
begin
    VirtualStorePath := GetFolder(CSIDL_Local_AppData);
// CSIDL_LOCAL_APPDATA : C:\Documents and Settings\username\Local Settings\Application Data.
    VirtualStorePath := VirtualStorePath + 'VirtualStore';
    AddBackSlash(VirtualStorePath);
    RegPath := extractFilePath(application.ExeName);
    if pos(':',regPath)=2 then delete(RegPath,1,3); // enlève c:\
    VirtualStorePath := TPath.combine(VirtualStorePath,RegPath);
// return first VirtualStorePath if the file exists in user VirtualStore
    AddBackSlash(VirtualStorePath);
    if (FileExists(VirtualStorePath + FileName))
       then result:= VirtualStorePath + FileName
       else result := fileName;
end;


Initialization

     ExemplesDir := extractFilePath(application.ExeName)+'Exemples\';
     DocRegPdf := changeFileExt(application.ExeName,'.pdf');
     DocRegWord := changeFileExt(application.ExeName,'.odt');
     DocIncertitudes := extractFilePath(application.ExeName)+'Regressi-incertitudes.pdf';
     DocModelisation := extractFilePath(application.ExeName)+'Regressi-modelisation.pdf';
     mesDocsDir := GetFolder(CSIDL_Personal)+stRegressi;
     videoDir := GetFolder(CSIDL_MyVideo); // GetFolder(CSIDL_Common_Video);
     imagesDir := GetFolder(CSIDL_MYPICTURES);
     wavDir := GetFolder(CSIDL_MYMUSIC);
     ProgramDir := GetFolder(CSIDL_Program_Files);
     arduinoExe := ProgramDir;
     addBackSlash(arduinoExe);
     arduinoExe := arduinoExe+'arduino\arduino.exe';
     system.sysUtils.forceDirectories(MesDocsDir);
     dataDir := mesDocsDir;
     pythonDir := mesDocsDir;
     pythonDllDir := '';
     addBackSlash(mesDocsDir);
     nomFichierIni := mesDocsDir+'Regressi.ini';
     tempDirReg := GetEnvironmentVariable('TEMP');  // TEMP : path of temporary files folder
     if tempDirReg='' then tempDirReg := GetEnvironmentVariable('TMP'); // TMP : directory to store temporary file
     if tempDirReg='' then tempDirReg := 'C:\Temp';
     // Protégé sur certains réseaux ?
     userName := GetUserName;
     precision := 4;
     autoIncrementation := false;
     ReticuleComplet := true;
     LigneRappelCourante := lrEquivalence;
     LigneRappelTangente := lrEquivalence;
     AcqList := TStringList.Create;
     AcqList.sorted := true;
     AcqList.Duplicates := dupIgnore;
     TexteModele := TStringList.Create;
     GraduationPi := false;
     Lettres := ['a'..'z','A'..'Z'];
 //    SuiteCaracGrandeur := ['''','%','"','0'..'9']; // '_' utilisé pour unité
     SuiteCaracGrandeur := ['%','0'..'9']; // '_' utilisé pour unité
     avecOptionsXY := true;

{$IFDEF Debug}
      assignFile(fichierDebug,mesDocsDir+'Regressi.txt');
      rewrite(fichierDebug);
      writeln(fichierDebug,'Regressi ffmpeg 08/03/2023');
      writeln(fichierDebug,'Initialisation regutil');
      flush(fichierDebug);
      closeFile(fichierDebug);
{$ENDIF}

Finalization
   AcqList.Free;
   TexteModele.free;
end.

