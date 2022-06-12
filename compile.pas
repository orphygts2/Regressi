unit compile;

interface

uses SysUtils, Windows, Classes, Forms, Math, Graphics, contnrs,
   constreg, maths, regutil, uniteKer, fft, statcalc, indicateurU,
   System.Types;

// S'inspire fortement de la bibliothèque MODULOG produite par l'ALE Sup :
// V. Chauve, P. Cousot, H. Lehning, D. Monasse, C. Potier, R. Rolland, R. Smadja

const
   caracLogique    = '$';
   NomCoeffSimul   = 'Coeff';
   MaxParametres   = 10;
   MaxGrandeurs    = 100;
   cNombre         = MaxGrandeurs;
   Parametre0Glb   = MaxGrandeurs;
   Parametre0      = Parametre0Glb + MaxParametres;
   cFrequence      = Parametre0 + MaxParametres + 1;
   cMuette         = cFrequence + 1;
   cIndice         = cMuette + 1;
   cPage           = cIndice + 1;
   cImmediate      = cPage + 1;
   cDeltat         = cImmediate + 1;
   MaxMaxGrandeurs = cDeltat;
   GrandeurInconnue = MaxMaxGrandeurs + 1;
   CaracUnite: TsysCharSet =
      ['a'..'z', 'A'..'Z', '-','.','/','1'..'3','°','%'];

type
  Trepere = class
      Valeur: double;
      Texte: String;
  end;
  TOperateurLogique = (xorop,andop,orop,nandop,modop);
  TlisteRepere = class(TList)
  protected
    function Get(Index: integer): TRepere;
    procedure Put(Index: integer; Item: TRepere);
  public
    function Add(Item: TRepere): integer;
 //   function Remove(Item: TRepere): integer;
    property Items[Index: integer]: TRepere Read Get Write Put; default;
    procedure Clear; override;
  end;

   TsetGrandeur    = set of byte;
   Tundo           = (UsupprVariab, UsupprConst, UsupprPage, uSupprPoint,
      UsupprVariabTexte, UsupprConstTexte, Ugrouper);
   TgenreGrandeur  = (Variable, Constante, ConstanteGlb,
      ParamGlb, ParamNormal, ParamDiff1, ParamDiff2, indiceBoucle);
   TCodeFonction    = (absolue, signe, echelon, oppose, inverse,
      ArcTangente, entier, entierSup, entierInf, fractionnaire, arrondi,
      Carre, racine, exponentielle, lognep, logdec,
      sinus, cosinus, tangente, sinusCardinal, derSinCardinal,
      BesselCardinal, derBesselCardinal, errorFunction, aleatoire,
      ArcSinus, arcCosinus, CodeGamma, CodeFact, CodeBruit,
      CosHyper, sinHyper, tanHyper, NotFunction, ArgTanHyper,
      reelle, imaginaire, argument, angle,
      DateTime, mois, jour, annee, heure,
      SexaToDeci, UtilisateurToRadian, FonctInconnue);
   TCodeFonctionGlb = (Minimum, Position, Moyenne, MoyenneAll, MoyenneFFT,
      Somme, SommeFFT, Efficace, EfficaceAll, Initial, Frequence,
      FrequenceInstantanee, RmsInstantanee, Phase,
      EcartType, Pente, Origine, cCnp, cCreneau, cTriangle, cBitAlea, Filtrage, DefinitionFiltre,
      Enveloppe, Harmonique, CodeCorrelation, Equation, EquaDiff1, EquaDiff2,
      Derivee, DeriveeSeconde, Surface, LissageGlissant, LissageCentre, FonctionPage, RetardCorr, PhaseContinue,
      Integrale, IntegraleDefinie, IntegraleMuette, cPoisson, cGauss, cBinomial, cBessel, cPeigne,
      cPhaseModulo, dGaussMean, dGaussSigma, PythonVar, PythonConst,
      grandeurPage, Maximum);

   TCodeElement      = (Operateur, Fonction, Nombre, Grandeur,
      IfThenElse, PieceWise,
      RacineMoinsUn, FonctionGlb, GrandeurIndicee, grandeurEuler,
      Incert, IncertIndicee, BoucleFor, Texte);
// deriveeParametre=dérivée première ou seconde de J/param
   TcodeGrandeur     = 0..GrandeurInconnue;
   TCodeParam        = 1..MaxParametres;
   TCodePage         = 0..MaxPages;
   TableauGrandeur  = array[TcodeGrandeur] of double;
   TableauParam     = array[TcodeParam] of double;
   TableauBoolParam = array[TcodeParam] of boolean;
   TMatriceParam     = array[TcodeParam, TcodeParam] of double;
   TableauBornes    = array[TcodeIntervalle] of integer;
   TableauNbreParam = array[ParamGlb..ParamNormal] of integer;
   TgenreMecanique  = (gm_position, gm_vitesse, gm_acceleration, gm_initial);
   ToptionCurseur   = (coX, coY, coPente, coDeltaX, coDeltaY);
   ToptionCurseurF  = (gFrequence, gAmplitude);
   TgenreCalcul     = (g_experimentale, g_fonction, g_derivee, g_deriveeSeconde,
      g_lissageCentre, g_FreqInst, g_phaseContinue, g_equation, g_diff1, g_diff2,
      g_filtrage, g_definitionFiltre, g_retardCorr, g_enveloppe, g_harmonique,
      g_correlation, g_integrale, g_a_affecter, g_forward, g_texte,
      g_euler, g_decalage, g_PythonVar, g_PythonConst, g_lissageGlissant, g_RmsInst);

   Tgrandeur = class;

   Pelement = ^Telement;

   Tfonction = class
      addrY, addrYp, addrYp2: Tgrandeur;
// Yp pour équa diff (1 et 2) Yp2 pour equa diff 2
      expression: String; // expression permettant de la calculer
      calcul:     Pelement; // résultat de la compilation de expression
      depend:     TsetGrandeur;
      genreC:     TgenreCalcul;
      isSysteme, ContientCalculGlb: boolean;
      constructor Create;
      function compileF(var posErreur, LongErreur: integer;
         Ajuste: boolean; GenreParam: TgenreGrandeur;
         ordreEqua: integer): boolean;
      procedure genreFonction(var gf: TgenreGrandeur);
      procedure SetDependF;
      function ChercheDebutDepend: TcodeGrandeur;
      procedure ChangementVariable(x: Tgrandeur);
      destructor Destroy; override;
   end;

   TlisteFonction = class(TList)
   protected
      function Get(Index: integer): Tfonction;
      procedure Put(Index: integer; Item: Tfonction);
   public
      function Add(Item: Tfonction): integer;
      property Items[Index: integer]: Tfonction Read Get Write Put; default;
      procedure Clear; override;
   end;

   TuniteCalc = class(Tunite)
      procedure CalcUnite(F: Pelement);
      procedure CalcFonction(F: Pelement);
      procedure CalcFonctionGlb(F: Pelement);
      procedure CalcOperateur(F: Pelement);
      procedure CalcIf(F: Pelement);
      procedure CalcGrandeur(F: TuniteCalc);
   end;

   Tgrandeur = class(TuniteCalc)
      genreG:         TgenreGrandeur;
      valeurCourante, valeurCouranteIm, IncertCourante: double;
      fonct:          Tfonction;
      valeur, ValIncert: Tvecteur;
      valeurR, valeurI, valeurA: Tvecteur;
      valeurPage, IncertPage: array[TcodePage] of double;
      IncertCalcA: Tfonction;
      IncertCalcB: TFonction;
      AffSignif:      boolean;
      GenreMecanique: TgenreMecanique;
      isCurseur:      boolean;
      optionCurseur:  ToptionCurseur;
      optionCurseurF: ToptionCurseurF;
      nomVarPosition: string;
      valeurModelisee: boolean;
      indexG,indexOld : TcodeGrandeur;
      varInit : Tgrandeur;
      constructor Create;
      procedure init(const N: string; const U: string;
         const E: string; Agenre: TgenreGrandeur);
      procedure SetUnite;
      function TitreAff : string;
      function OrdreDeGrandeur: double;
      function CompileG(var posErreur, LongErreur: integer;
         ordreEqua: integer): boolean;
      function CompileIncertitude : boolean;
      function IncertDefinie : boolean;
      function IncertCalculee : boolean;
      procedure CalculIncertitudeExp(var Avaleur : double); // procedure car on peut ne pas toucher avaleur (donnée entrée au clavier)
      procedure CalculIncertitudeFonct(var Avaleur : double);
      destructor Destroy; override;
   end;

   Tmodele = class(Tfonction)
      indexX, indexY, indexYp: TcodeGrandeur;
      Ajuste, Implicite, Lineaire, LineaireVar: boolean;
      // lineaire / param a b c ou lineaireVar / variable x
      GenreParam:   TgenreGrandeur;
      enTete:       String;
      couleur:      Tcolor;
      LigneMemo:    integer;
      IsSinusoide: boolean;
      IsCosinus: boolean;
      valeurYEuler: Tvecteur;
      CoeffSI:      double;
      VariableEgalAbscisse: boolean;
      Amplitude, Phase, PeriodeOuFrequence: TcodeGrandeur; // codeParam
      ResiduStat:   TcalculStatistiqueResidu;
      Residu:       Tvecteur;
      SommeCarreY,sigmaY,chi2Relatif : double;
      NbreParamModele : integer;
      NbrePointsModele : integer;
      fchi2 : Pelement;
      ErreurModele : boolean;
      PosErreurModele : integer;
      pValueWald : double;
      function getPointActif(index: integer): boolean;
      constructor Create;
      function compileM(const LigneCourante: String;
         var posErreur, LongErreur: integer): boolean;
      procedure GenereM(X, Y: Tvecteur; miniX, maxiX: double; logX: boolean;
         var PointFinal: integer);
      procedure GenereMGlb(X, Y: Tvecteur; miniX, maxiX: double; logX: boolean;
         var PointFinal: integer);
      procedure GenereEquation(X, Y: Tvecteur; axeX, axeY: TGrandeur;p: TcodePage; var PointFinal: integer);
      procedure CalculResidu(mC: integer);
      function chi2Permis : boolean;
      function expressionNumerique : string;
      procedure CherchePenteOrigine(var indexPente,indexOrigine : integer);
      destructor Destroy; override;
   end;

   Telement = record
      case TypeElement: TcodeElement of
         Operateur: (CodeOp: char;
            OperG, OperD: Pelement);
         Fonction: (CodeF: TCodeFonction;
            AdresseF: TFonctionMath;
            Operand: Pelement);
         FonctionGlb: (CodeFglb: TCodeFonctionGlb;
            OperandGlb, OperandDer, OperandDebut, OperandFin: Pelement;
            varx, vary: Tgrandeur;
            typeGlb: TgenreGrandeur;
            valeurGlb, valeurInitDer: double);
         IfThenElse: (test, positif, negatif: Pelement);
         PieceWise: (PWtest, PWthen, PWtestElse: Pelement);
         Nombre, RacineMoinsUn: (Valeur: double);
         Grandeur: (Pvar: Tgrandeur);
         GrandeurIndicee: (Pvariab: Tgrandeur;
            IndexLigne,indexPage: Pelement;
            Numero: double);
         GrandeurEuler: (PvariabE: Tgrandeur;
            IndexLigneE: Pelement;
            indexMod: integer);
         BoucleFor: (PvariabI: Tgrandeur;
            Istart, Iend: Pelement;
            VarStart, VarEnd: TCodeGrandeur);
   end;

   TMatriceFonction = array[TcodeIntervalle, TcodeParam] of Pelement;
   TTableauFonction = array[TcodeIntervalle] of Pelement;
   TTableauVecteur  = array[0..MaxIntervalles] of TVecteur; { 0 = temps }
   TMatriceVecteur  = array[TcodeIntervalle, TcodeParam] of TVecteur;
   TMatriceReal     = array[TcodeIntervalle, TcodeParam] of double;
   TableauReal     = array[TcodeIntervalle] of double;

   TableauVariable = array[TcodeIntervalle] of integer;
   TableauElement  = array[TcodeIntervalle] of Pelement;

   Tsauvegarde = class;

   Tpage = class
   private
      FPointActif: TBits;
      function getTexteVar(indexV, indexP: integer): string;
      procedure setTexteVar(indexV, indexP: integer; const Value: string);
      function getPointActif(index: integer): boolean;
      procedure setPointActif(index: integer; Value: boolean);
      function GetDeltaSimulation: double;
      function GetNomBitmap: string;
      procedure SetNmes(NewNmes: longint);
      procedure SetNomBitmap(const NewNom: string);
   public
      ListeRepere: TListeRepere;
      FTexteVar:   array[TcodeGrandeur] of TStringList;
      StoechBecher,StoechBurette : integer;
      maxiSimulation, miniSimulation, FdeltaSimulation: double;
      FNomFichierBitMap: string;
      FextensionBitmap: string;
      NbrePointsSauves: integer;
      Fnmes:     longint; // nombre d'éléments de valeurVar
      NmesMax:   longint; // taille des dynamic array
      ParamAjustes, changeAdresse: boolean;
      Experimentale, Active : boolean;
      ModeleCalcule, ModeleErrone: boolean;
      Numero: TcodePage;
      Stat, statK, statV: TcalculStatistique;
      Stat2: TstatistiqueDeuxVar;
      MajCornishAfaire: boolean;
      ValeurParam: array[ParamNormal..ParamDiff2] of tableauParam;
      CovarianceParam : TmatriceParam;
      incertParam, incert95Param : tableauParam;
      ValeurVar, ValeurLisse, FenetreFourier, IncertVar:
         array[TcodeGrandeur] of Tvecteur;
      OldValeurPython: array[TcodeGrandeur] of Tvecteur;
      TexteConst:  array[TcodeGrandeur] of string;
      ValeurConst, IncertConst, ValeurConstLisse: tableauGrandeur;
      OldValeurConst: tableauGrandeur;
      iRaie1: array[TcodeGrandeur] of integer;
      FFTimag, FFTreel, FFTampl: array[TcodeGrandeur] of Tvecteur;
      ValeurTheorique: array[TcodeIntervalle] of Tvecteur;
      incertNulle : Tvecteur;
      debutFFT, finFFT: integer;
      chi2Actif : boolean;
// bornes des éléments de valeurVar utilisés pour FTT
      PeriodeFFT:      double;
      NbreFFT:         integer; // nombre d'éléments de FFT
      ModifiedP:       boolean;
      TriAfaire:       boolean;
      CommentaireP:    String;
      X_inter, Y_inter,sigmaX_inter,sigmaY_inter: tableauReal;
      PrecisionModele, Chi2: tableauReal;
      Debut, Fin:      tableauBornes;
// des intervalles de définition de Ytheorique
      TexteResultatModele: TStringList;
      TexteModeleP:    TStringList;
      NumeroAnim:      integer;
      ValeurTheoriqueGlb: tableauReal;
      ValeurCourante:  array[TcodeGrandeur] of double;
      indicateurP:     Tindicateur;
      nomParam : array[TCodeParam] of string;
      procedure AjouteRepere(z: double;const s: String);
      function incertDefinie : boolean;
      function IncertCalculee : boolean;
      function AcquisitionAVI : boolean;
      procedure VerifNomBitmap(const NouveauNomFichierData : string);
      property NomFichierBitMap: string Read getNomBitmap Write setNomBitmap;
      constructor Create;
      procedure razPage;
      procedure calcColonneP(index: TcodeGrandeur; lisse: boolean);
      function TitrePage: string;
      procedure SupprimeLignes(debutL, finL: integer);
      procedure calculLigne(numeroLigne: integer);
      procedure calculGlb;
      procedure RecalculP;
      procedure Tri;
      procedure RecalculFourierP;
      Procedure CalculIncertG(i : TcodeGrandeur);
      procedure LibereLisseP(index: TcodeGrandeur);
      procedure LibereFourierP(index: TcodeGrandeur);
      procedure GenereLisseP(index: TcodeGrandeur);
      procedure GenereSpectreFourierP(index: TcodeGrandeur);
      procedure CalculFourierP(index: TcodeGrandeur; calculFFT: TcalculFFT);
      procedure NewFourierP(index: TcodeGrandeur);
      procedure RemplitVarLisse;
      procedure AffecteConstParam(isModele : boolean);
      procedure TransfereVariabP(indexOrig, IndexDest: TcodeGrandeur);
      function AjouteGrandeurP(index: TcodeGrandeur): boolean;
      procedure LibereGrandeurP(index: TcodeGrandeur);
      procedure SauveVarP(indexOrig,IndexDest : TcodeGrandeur);
      procedure RecupereVarP(indexOrig,IndexDest : TcodeGrandeur);
      procedure SupprimeGrandeurP(index: TcodeGrandeur; S: Tsauvegarde);
      procedure AffecteVariableP(lisse: boolean);
      function ParamEtPrec(k: TcodeGrandeur;incertType : boolean): String;
      function ValeurParametre(i: TcodeGrandeur): double;
      function PrecisionParametre(i: TcodeGrandeur): double;
      procedure AffecteNbreFFT;
      destructor Destroy; override;
      property nmes: longint Read Fnmes Write setNmes;
      property DeltaSimulation: double Read getDeltaSimulation;
      function EffacePage(xdebut, ydebut, xfin, yfin: double;
         indexX, indexY: integer): boolean;
      procedure VerifIntervalles;
      function ParamNum(k : TcodeGrandeur) : String;
      procedure ResetDebutFin(i: TcodeIntervalle);
      procedure ResetPointActif;
      property PointActif[index: integer]: boolean
         Read getPointActif Write setPointActif;
      property TexteVar[indexV, indexP: integer]: string
         Read getTexteVar Write setTexteVar;
   end;

   Tsauvegarde = class
      private
      Fnbre:          integer; // nombre d'éléments de valeurVar
      procedure SetNombre(NewNbre: integer);
      public
      NbreMax:        integer; // taille des dynamic array
      ValeurVect, IncertVect: array[TcodePage] of Tvecteur;
      ValeurUnique, IncertUnique: array[TcodePage] of double;
      SauveTexte:     array[TcodePage] of TStringList;
      SauveTexteUnique: TStringList;
      nomData:        array[TcodePage] of string;
      GrandeurSauvee: tGrandeur;
      NumeroPage:     TcodePage;
      undo:           tUndo;
      NbreGrandeursSauvees: integer;
      PageSauvee:     Tpage;
      procedure Restaure;
      constructor Create;
      procedure LibereS;
      destructor Destroy; override;
      property nbre: integer Read Fnbre Write setNombre;
   end;

   TpileSauvegarde = class(TStack)
   public
      procedure Push(Asauvegarde: Tsauvegarde);
      function Pop: Tsauvegarde;
      function Peek: Tsauvegarde;
   end;

   TlisteBoucle = class(TList)
   protected
      function Get(Index: integer): Pelement;
      procedure Put(Index: integer; Item: Pelement);
   public
      function Add(Item: Pelement): integer;
 //     function Remove(Item: Pelement): integer;
      property Items[Index: integer]: Pelement Read Get Write Put; default;
      procedure Clear; override;
   end;

var
   ListeConstAff: TStringList;
   GrandeurImmediate: Tgrandeur;
   ModelePagesIndependantes: boolean;
   Pages: array[TcodePage] of Tpage;
   PileSauvegarde: TpileSauvegarde;
   ParamAjustesGlb: boolean;
   NomGrandeurTri: string;
   derniereErreur: string;
   PrecisionModeleGlb: tableauReal;
   PageCourante: integer;
   NbreVariab, NbreVariabExp, NbreVariabTexte, NbreVariabPython,
     NbreConst, NbreConstExp, NbreConstTexte, NbreConstPython,
     NbreConstGlb : integer;
   indexVariab, indexVariabExp, indexVariabTexte, indexVariabPython,
     indexConst, indexConstExp, indexConstTexte, indexConstPython,
     indexConstGlb : array[TcodeGrandeur] of TcodeGrandeur;
   NbreGrandeurs, NbrePages: integer;
   NbreParam: TableauNbreParam;
   incertParamGlb,incert95ParamGlb : tableauParam;
   covarianceParamGlb : TmatriceParam;
   isOrigine : tableauBoolParam;
   Grandeurs: array[0..MaxMaxGrandeurs] of Tgrandeur;
   Parametres: array[ParamGlb..ParamDiff2, TcodeParam] of Tgrandeur;
   ParamInverse, InversePermis: array[TcodeParam] of boolean;
   modifInverse, ajoutGrandeurNonModele: boolean;
   FonctionTheorique, FonctionTheoriqueGlb,
   FonctionSuperposee, FonctionSuperposeeGlb: array[1..MaxIntervalles] of Tmodele;
   NbreModele, NbreFonctionSuper, NbreFonctionSuperGlb, NbreModeleGlb: shortint;
   HarmoniqueAff: boolean;
   NbreHarmoniqueOptimise, bruitPresent: boolean;
   FonctionPagePermise: boolean;
   NomFichierData: string;

function IndexToParam(Agenre: TgenreGrandeur;index: TcodeGrandeur): TcodeGrandeur;
function ParamToIndex(Agenre: TgenreGrandeur;code: TcodeGrandeur): TcodeGrandeur;
procedure DebutCompileG;
procedure FinCompileG;
function compileBoucle(const Expression: string;var posErreur, LongErreur: integer): boolean;
function compileFinBoucle: boolean;
procedure RecalculE;
procedure RecalculColonneE;
procedure RecalculFourierE;
function AjouteGrandeurE(Avariable: Tgrandeur): integer;
procedure AffecteVariableE(indice: integer);
procedure LibereGrandeurE(index: TcodeGrandeur);
procedure SupprimeGrandeurE(index: TcodeGrandeur);
function AjouteExperimentale(const n: string; Agenre: TgenreGrandeur): integer;
procedure transfereVariabE(indexOrig, indexDest: TcodeGrandeur);
procedure transfereParamE(Agenre : TgenreGrandeur;indexOrig,indexDest : TcodeParam);
function IndexNom(const nomX: string): TcodeGrandeur;
Function indexNomVariab(const nomX : string) : TcodeGrandeur;
function CreerPythonVar(const nom : string) : TcodeGrandeur;
function CreerPythonConst(const nom : string) : TcodeGrandeur;
function IndexDerivee(y, x: Tgrandeur; Acalculer: boolean;
   Acreer: boolean): TcodeGrandeur;
function IndexVitesse(const position: string): TcodeGrandeur;
function IndexAcceleration(const position: string): TcodeGrandeur;
function IndexGrandeurInitiale(f: Tgrandeur;
   var GI: Tgrandeur; ParamModele: boolean): TcodeGrandeur;
function Calcule(F: Pelement): double;
procedure ConstruireIndex;
procedure ResetEnTete;
function NomCorrect(const S: String; index: TcodeGrandeur): boolean;
procedure construire2(dfdy, dfdyprime: Pelement;
   var dfdk: Pelement; k: TcodeGrandeur);
procedure construire1(dfdy: Pelement; var dfdk: Pelement; k: TcodeGrandeur);
procedure construireEquation(dfdy: Pelement; var dfdk: Pelement);
procedure DefinitGrandeurFrequence;
function AjoutePage: boolean;
function AjoutePageForce: boolean;
procedure SupprimePage(numero: integer; avecSauvegarde: boolean);
procedure GroupePage;
procedure GroupePageColonnes;
procedure Dichotomie(p: TcodePage; codeX: TcodeGrandeur; f1, f2: Pelement;
   Xmin, Xmax: double; var Yi, Xi: double);
procedure ChercheUniteParametre;
procedure ChercheUniteParametreGlb;
procedure GenereModeleParametrique(X, Y: Tvecteur;
   miniT, maxiT: double;var PointFinal: integer);
procedure TriConst(NumConst: TcodeGrandeur);
procedure TriParam(NumParam: TcodeGrandeur);
function VerifCreneau(var expression : string) : boolean;
function ParamEtPrecGlb(k: TcodeGrandeur;incertType : boolean): String;

var
   PointeurUn, PointeurPi: Pelement;
   logSimulation: boolean;
   indexTri:      TcodeGrandeur;
   prevenirFonctionDeParam: boolean;
   ListeBoucle:   TlisteBoucle;
   CodeErreurC:   string;
   modeleDependant : boolean;
   NonDefinieNulle : boolean = false;

procedure Libere(var expr: Pelement);
procedure DeriveeForm(F: Tfonction; xx: Tgrandeur;
   var Fprime: Pelement; var dependDer: TsetGrandeur);

const
   NomGenreGrandeur: array[TgenreGrandeur] of string =
      ('variable', 'paramètre', 'constante', '', 'paramètre', '', '', '');

   NomGenreCalcul: array[TgenreCalcul] of string =
      ('expérimentale', 'fonction', 'dérivée', 'dérivée seconde', 'lissage glissant', 'lissage centré','','',
      '', 'équation', 'équa. diff 1', 'équa diff. 2', 'filtrage',
      'filtre', '', 'enveloppe', 'harmonique', '',
      'intégrale', 'texte', '', 'prédéfinie', 'Euler', 'décalage', 'Python', 'Python');

   NomFonctionGlb: array[TCodeFonctionGlb] of string =
      ('MIN', 'POS', 'MOYP','MOY', 'MOYF', 'SOMME', 'SOMMEF', 'EFF', 'EFFTOUT','INIT', 'FREQ', 'FREQINST', 'EFFINST',
      'PHASE', 'STDEV', 'PENTE', 'ORIGINE', 'CNP', 'CRENEAU', 'TRIANGLE','BitRand',
      'FILTRE', 'FILTRE', 'ENV', 'HARM', 'CORR', 'SOLVE', '', '',
      'DIFF', 'DIFF2', 'AIRE', 'LISSEF','LISSEC', 'PAGE', 'TCORR', 'PHASEC',
      'INTG', 'INTG', 'INTGD', 'POISSON', 'GAUSS', 'BINOM', 'BESSEL', 'PEIGNE', 'MODUL',
      '', '','PYTHON', 'PYPARAM','', 'MAX');

   NomFonction: array[TCodeFonction] of string =
      ('ABS', 'SIGN', 'ECH', 'OPP', 'INV',
      'ATAN', 'INT', 'CEIL', 'FLOOR', 'FRAC', 'ROUND',
      'SQR', 'SQRT', 'EXP', 'LN', 'LOG',
      'SIN', 'COS', 'TAN', 'SINC', 'SC1', 'J1C', 'J1C1', 'ERF','RAND',
      'ASIN', 'ACOS', 'GAMMA', 'FACT', 'NOISE',
      'CH', 'SH', 'TH', 'NOT', 'ATH',
      'RE', 'IM', 'ARG', '',
      'TODATE', 'EXTMOIS', 'EXTJOUR', 'EXTANNEE', 'EXTHEURE', 'DEGDEC', '', '');

     NomOperateurLogique : array[ToperateurLogique] of string = ('XOR','AND','OR','NAND','MOD');

implementation

const
     AliasFonctionGlb: array[TCodeFonctionGlb] of string =
      ('MIN', 'POS', 'AVG','MEAN', 'MEANF', 'SUM', 'SUMF', 'RMS', 'RMSALL', 'INIT', 'FREQ', 'FREQINST', 'RMSINST',
      'PHASE', 'STDEV', 'SLOPE', 'ORIGIN', 'CNP', 'CRENEAU', 'TRIANGLE','BitAlea',
      'FILTER', 'FILTER', 'ENV', 'HARM', 'CORR', 'SOLVE', '', '',
      'DIFF', 'DIFF2', 'AIRE', 'LISSEG','LISSE', 'PAGE', 'TCORR', 'PHASEC',
      'INTG','INTG', 'INTGD', 'POISSON', 'GAUSS', 'BINOM', 'BESSEL', 'PEIGNE', 'MODUL',
      '', '', 'PYVAR', 'PYPAR','', 'MAX');
//     CodeOperateurLogique : array[ToperateurLogique] of char = ('X','A','O','N','M');

const
   EnvMax = 0;
   EnvMin = 1;
   EnvEqu = 2;
   EnvFourier = 3;
   PosUp  = 1;
   posDown = 2;
   PosMin = 3;
   posMax = 4;
   NbreIncertMax = 128;
   ZeroParam: array[ParamGlb..paramDiff2] of TcodeGrandeur =
      (parametre0Glb, parametre0,0,0);

var
   AdresseFonction: array[TcodeFonction] of TFonctionMath;
   finOldGrandeurs, debutOldGrandeurs: integer;
   OldGrandeurs: array[TcodeGrandeur] of Tgrandeur;
   BoucleEnCours: boolean;
   PointeurZero, PointeurJ, PointeurDeux : Pelement;
   indexFiltre: array[TcodeGrandeur] of TcodeGrandeur;
   NbreFFTcourant: integer;
   NmesCourant: integer;
   NbreFiltre: integer;

Function indexParamNom(const nomX : string) : integer;
// Renvoie le code du parametre de nom nomX
var i : integer;
begin
   result := 0;
   if nomX='' then exit;
   for i := 1 to NbreParam[paramNormal] do
       if nomX=Parametres[paramNormal,i].nom then begin
             result := i;
             break;
       end;
end;


{$I genere.pas}
{$I gestVar.pas}
{$I pages.pas}
{$I derive.pas}

procedure TlisteRepere.Clear;
var
  i: integer;
begin
  for i := 0 to pred(Count) do
    items[i].Free;
  inherited Clear;
end;

function TlisteRepere.Add(Item: TRepere): integer;
begin
  Result := inherited Add(Item);
end;

function TlisteRepere.Get(Index: integer): TRepere;
begin
  Result := TRepere(inherited Get(Index));
end;

procedure TlisteRepere.Put(Index: integer; Item: TRepere);
begin
  inherited Put(Index, Item);
end;

function NomCorrect(const S: String; index: TcodeGrandeur): boolean;
var
   ifonct: TcodeFonction;
   iFonctGlb: TcodeFonctionGlb;
   Smaj: String;
   j, jmax: integer;
   posZero: integer;
   k : char;
begin
   try
      jmax := length(s);
      posZero := pos('[', s);
      if posZero>0 then begin
         for k := '0' to '2' do begin
            posZero := pos('['+k+']', s);
            if (posZero > 1) and (posZero = jmax - 2) then begin
               jmax := pred(posZero);
               break;
            end;
         end;
      end;
      if jmax > longNom then
         raise Ecompile.Create(erTropLong);
      if S = '' then
         raise Ecompile.Create(erNomVide);
      if not isLettre(S[1]) then
         raise Ecompile.Create(erDebutNom);
      if (S = 'j') or (S = piMin) or (S = piMaj) or (S = 'pi') or (S = 'Pi') then
         raise Ecompile.Create(erNomInterdit);
      Smaj := UpperCase(S);
      ifonct := low(TcodeFonction);
      while (SMaj <> NomFonction[ifonct]) and (ifonct < FonctInconnue) do
         Inc(ifonct);
      if (SMaj = NomFonction[ifonct]) then
         raise Ecompile.Create(erNomFonction);
      ifonctGlb := low(TcodeFonctionGlb);
      while (SMaj <> NomFonctionGlb[ifonctGlb]) and
         (ifonctGlb < high(TcodeFonctionGlb)) do
         Inc(ifonctGlb);
      if (SMaj = NomFonctionGlb[ifonctGlb]) then
         raise Ecompile.Create(erNomFonction);
      j := indexNom(s);
      if (j <> GrandeurInconnue) and (j <> index) and (j < MaxGrandeurs) and
         (grandeurs[j].fonct.genreC <> g_forward) then
         raise Ecompile.Create(erNomExistant);
      if (modeAcquisition = AcqSimulation) and (S = grandeurs[cDeltat].nom) then
         raise Ecompile.Create(erNomExistant);
      if S = grandeurs[cPage].nom then
         raise Ecompile.Create(erNomExistant);
      for j := 2 to jmax do
         if not isCaracGrandeur(S[j]) then
            raise Ecompile.Create(erCaracNom);
      NomCorrect := True;
   except
      on E: Ecompile do begin
         NomCorrect  := False;
         codeErreurC := E.message;
      end;
   end;
end; // NomCorrect

Function isMonoCaractere(caracCourant : char) : boolean;
const MonoCaractere: TsysCharSet =
      ['+', '-', '*', '/', '^', '(', ')', '.', ',', '>', '<', '=', '[', ']'];
begin
     result := charInSet(caracCourant,monoCaractere) or
         (caracCourant=infEgal) or
         (caracCourant=supEgal) or
         (caracCourant=cdot) or
         (caracCourant=pointMedian) or
         (caracCourant=puce);
end;

(********** noyau de l'analyseur ********)

function Tfonction.compileF(var posErreur, LongErreur: integer;
   Ajuste: boolean; genreParam: TgenreGrandeur; ordreEqua: integer): boolean;

{Analyse la chaine expression et renvoie le pointeur calcul sur l'arbre
résultant de la compilation, en cas d'erreur posErreur renvoie la position
de celle-ci et codeErreur le type. A l'entrée depend contient les variables
dont peut dépendre la fonction }

const
   MaxPile = 128;
type
   TIndicePile = 1..MaxPile;
var
   PilePointeur: array[TIndicePile] of Pelement;
   IndicePileCourant: 0..MaxPile;
   CaracCourant: char;
   IdentCourant: string;
   complexeAtransformer, complexePermis: boolean;
   pointeurExp: word; // pointe sur le prochain caractère
   SauveNparam: tableauNbreParam;
   longExp: word;
   DependPermis: TsetGrandeur;
   TestEnCours: boolean;
   TextePermis: boolean;

   procedure Csuivant;
// Lit le prochain caractère et l'assigne à caracCourant
// Le caracCourant est toujours extrait avant appel d'un analyseur
   begin
      if (pointeurExp <= longExp) and (Expression[pointeurExp] <> '_') and
         (Expression[pointeurExp] <> crTab) then begin
         caracCourant := Expression[pointeurExp];
         Inc(pointeurExp);
      end
      else caracCourant := #0;
   end;

   procedure IdentSuivant;

      procedure LireIdEnt;
      begin
         IdentCourant := '';
         while isCaracGrandeur(caracCourant) do begin
            if length(IdentCourant) = longNom then
               raise ECompile.Create(erTropLong);
            identCourant := identCourant + caracCourant;
            Csuivant;
         end;
         if caracCourant='''' then begin // x'
            identCourant := identCourant + caracCourant;
            Csuivant;
         end;
         if caracCourant='''' then begin // x''
            identCourant := identCourant + caracCourant;
            Csuivant;
         end;
         if caracCourant='"' then begin // x"
            identCourant := identCourant + caracCourant;
            Csuivant;
         end;
      end; // LireIdEnt

      procedure LireNombre;

         procedure AjouteCourant;
         begin
            IdentCourant := IdentCourant + caracCourant;
            CSuivant;
         end;

         procedure lireEntier;
         begin
            while charinset(caracCourant,chiffre) do
               AjouteCourant;
         end;

      begin
         IdentCourant := '';
         if caracCourant = '.'
            then IdentCourant := IdentCourant + '0'
            else lireEntier;
         if (caracCourant = '.') {C'est un nombre décimal} then begin
            AjouteCourant;
            LireEntier;
         end;
         if (upCase(caracCourant) = 'E') {puissance de 10} then begin
            AjouteCourant;
            if (caracCourant = '+') or (caracCourant = '-') then
               AjouteCourant;
            lireEntier;
         end
         else if charinset(caracCourant,caracPrefixeSI) then begin
            AjouteCourant; {coeff unité}
            ConvertitPrefixe(IdentCourant);
         end;
      end; // lireNombre

      procedure LireTexte;
      begin
         if not TextePermis then
            raise ECompile.Create(erTexteNotTest);
         IdentCourant := '"';
         repeat
            CSuivant;
            IdentCourant := IdentCourant + caracCourant;
         until (caracCourant = '"') or (caracCourant = #0);
      end; // lireTexte

      procedure LireLogique;
      begin
         IdentCourant := '';
         repeat
            CSuivant;
            if caracCourant<>caracLogique then
               IdentCourant := IdentCourant + caracCourant;
         until (caracCourant = caracLogique);
         IdentCourant := upperCase(identCourant);
         Csuivant;
      end; // lireLogique

   begin // IdentSuivant
      while caracCourant = ' ' do
         Csuivant; // Saute les espaces
      PosErreur := pred(PointeurExp);
      if isMonoCaractere(caracCourant) then begin
         IdentCourant := caracCourant;
         Csuivant;
         if ((identCourant = '<') or (identCourant = '>')) and
            (caracCourant = '=') then begin
            if identCourant = '<' then
               identCourant := infEgal;
            if identCourant = '>' then
               identCourant := supEgal;
            Csuivant;
         end;
      end
      else if isLettre(caracCourant) then
         LireIdent
      else if charInSet(caracCourant,ChiffreEtc) then
         LireNombre
      else if caracCourant = '"' then
         lireTexte
      else if caracCourant = caracLogique then
         lireLogique
      else if caracCourant = #0 then
         identCourant := ''
      else
         raise ECompile.Create(erCaracInterdit);
      LongErreur := PointeurExp - PosErreur - 1;
   end; // IdentSuivant

   procedure InitFonctor;
   var
      i: TIndicePile;
      index, indexP, indexP2: integer;
      // y'=f(y,t) y0=valeur initiale
      // y''=f(y,y',t) y0,y'0=valeurs initiales
   begin
      codeErreurC := '';
      textePermis := False;
      longExp := Length(expression);
      pointeurExp := 1;
      sauveNparam := NbreParam;
      posErreur := 0;
      LongErreur := 0;
      indicePileCourant := 0;
      complexeAtransformer := False;
      complexePermis := False;
      testEnCours := False;
      for i := 1 to MaxPile do
         PilePointeur[i] := nil;
      Libere(calcul);
      if longExp = 0 then
         raise ECompile.Create(erVide);
      Csuivant;
      IdentSuivant;
      dependPermis := depend;
      depend := [];
      genreC := g_forward;
   // y''=f(y,y',t) ou y'=f(y,t) y0=valeur initiale
      if (ordreEqua = 1) or (ordreEqua = 2) then begin
         index := addrY.IndexG;
         include(dependPermis, index); { y }
         indexP := indexDerivee(addrY, grandeurs[0], ajuste, True);
         addrYp := grandeurs[indexP];
         include(dependPermis, indexP); { y' }
      end;{Diff1}
      // y''=f(y,y',t) y'0=valeur initiale
      if ordreEqua = 2 then begin
         indexP2 := indexDerivee(addrYp, grandeurs[0], ajuste, True);
         addrYp2 := grandeurs[indexP2];
         include(dependPermis, indexP2);{ y" }
      end; // Diff2
      if BoucleEnCours or (indexNom('i') = cIndice)
         then include(dependPermis, cIndice)
         else exclude(dependPermis, cIndice);
      include(dependPermis, cNombre);
      if modeAcquisition = AcqSimulation then
         include(dependPermis, cDeltat);
      include(dependPermis, cPage);
   end; // InitFonctor 

   function GetOperateur: char;
   begin
      if (length(identCourant)=1) and
         isMonoCaractere(identCourant[1]) then begin
         result := IdentCourant[1];
         if pos(result,cdot+pointMedian+puce)>0 then result := '*';
      end
      else if AnsiSameText(identCourant, 'XOR') then
         GetOperateur := 'X'
      else if AnsiSameText(identCourant, 'AND') then
         GetOperateur := 'A'
      else if AnsiSameText(identCourant, 'OR') then
         GetOperateur := 'O'
      else if AnsiSameText(identCourant, 'MOD') then
         GetOperateur := 'M'
      else if AnsiSameText(identCourant, 'NAND') then
         GetOperateur := 'N'
      else
         GetOperateur := #0;
      if ( charInSet(Result,['<', '>']) or
           (Result=infEgal) or (Result=supEgal)) and
           not testEnCours then
         raise ECompile.Create(erXOR);
   end;// GetOperateur

   procedure Depile(var P: Pelement);
   begin
      if indicePileCourant = 0 then
         raise ECompile.Create(erInterne)
      else begin
         P := PilePointeur[indicePileCourant];
         PilePointeur[indicePileCourant] := nil;
         Dec(indicePileCourant);
      end;
   end;

   procedure Empile(P: Pelement);
   begin
      if indicePileCourant = MaxPile
         then raise ECompile.Create(ErTropComplexe)
         else begin
            Inc(indicePileCourant);
            PilePointeur[indicePileCourant] := P;
         end;
   end;

   procedure empileGrandeur(code: TcodeGrandeur);
   begin
      identSuivant;
      include(depend, Code);
      Empile(GenVar(grandeurs[code]));
   end;

   procedure empileParam(Agenre: TgenreGrandeur; code: TcodeParam);
   begin
      identSuivant;
      include(depend, ParamToIndex(Agenre, Code));
      include(dependPermis, ParamToIndex(Agenre, code));
      empile(GenVar(parametres[Agenre, code]));
   end;

   function IsCaracSuite(acarac: char): boolean;
   begin
      Result := IdentCourant = acarac;
      if Result then IdentSuivant;
   end;

   function IsParentheseF: boolean;
   begin
      Result := IdentCourant = ')';
      if Result then IdentSuivant;
   end;

   function IsParentheseO: boolean;
   begin
      Result := identCourant = '(';
      if Result then IdentSuivant;
   end;

   function IsVirgule: boolean;
   begin
      Result := (identCourant = ',') or (identCourant = ';');
      if Result then IdentSuivant;
   end;

   procedure AnalyseExpression; forward;
   procedure AnalyseTest; forward;

   procedure E; // E=(.Expression.)
   begin
      if IsParentheseO then begin
         if TestEnCours
            then AnalyseTest
            else AnalyseExpression;
         if not IsParentheseF then
            raise Ecompile.Create(erParF);
      end;
   end;{E}

   procedure ChercheGrandeur(var trouve: boolean);
// Grandeur = nom/nom[.expression.]
   var
      i: integer;
      g: tGenreGrandeur;
      El, E2, V: Pelement;
      TransfertEffectue: boolean;
      index0: integer;
      nomInit : string;
      valInit : integer;
   begin
      trouve := False;
      for i := cFrequence to MaxMaxGrandeurs do
         if i in dependPermis then begin
            trouve := IdentCourant = grandeurs[i].nom;
            if trouve then begin
               identSuivant;
               empile(GenVar(grandeurs[i]));
               exit;
            end;
         end;
      i := indexNomVariab(identCourant);
      if i <> grandeurInconnue then begin
         trouve := (i in dependPermis) or
            ((i = addrY.IndexG) and
            charinset(caracCourant,['[', ')']));
         if trouve then begin
            EmpileGrandeur(i);
            if (length(identCourant)>0) and (identCourant[1]='[') then begin
               if grandeurs[i].genreG = constanteGlb then
                  raise ECompile.Create(erIndexNotVariab);
               identSuivant;
               include(dependPermis, cIndice);
               AnalyseExpression;
//               if not BoucleEnCours then exclude(dependPermis, cIndice);
               if isCaracSuite(']') then begin // g[i]
                  Depile(El);
                  Depile(V);
                  if ordreEqua = -1
                  then Empile(GenGrandeurEuler(grandeurs[i], El))
                  else if (El.typeElement = nombre)
                  then begin
                     valInit := round(El.valeur);
                     nomInit := grandeurs[i].nom + '['+intToStr(valInit)+']';
                     index0 := indexNom(nomInit);
                     if index0 = GrandeurInconnue
                        then Empile(GenGrandeurIndicee(grandeurs[i], nil, nil, valInit))
                        else Empile(GenVar(grandeurs[index0]));
                     libere(El);
                  end
                  else
                     Empile(GenGrandeurIndicee(grandeurs[i], El, nil, 0));
               end
               else if isCaracSuite(',') then begin //g[page,i]
                        identSuivant;
                        AnalyseExpression;
                        if isCaracSuite(']') then begin
                            Depile(E2);
                            Depile(El);
                            Depile(V);
                            if (El^.typeElement = nombre)
                                then begin
                                    Empile(GenGrandeurIndicee(
                                       grandeurs[i], nil, E2, El.valeur));
                                    libere(El);
                                end
                                else
                                  Empile(GenGrandeurIndicee(grandeurs[i], El, E2, 0));
                        end
                        else
                           raise ECompile.Create(erCrochetF);
               end
               else
                  raise ECompile.Create(erCrochetF);
            end; // crochet
            if (length(identCourant)>0) and (identCourant[1]='(') then
               if fonctionPagePermise then begin
                  if grandeurs[i].genreG = constanteGlb then
                     raise ECompile.Create(erIndexNotVariab);
                  identSuivant;
                  E;
                  Depile(V);
                  Empile(GenFonctionGlb(grandeurPage, V, nil, nil, grandeurs[i], nil));
               end
               else
                  raise ECompile.Create(erFonctionPage);
         end
         else
            raise ECompile.Create(erVarInterdite);
         exit;
      end; // grandeur connue
      for g := paramGlb to paramNormal do
         for i := 1 to NbreParam[g] do
            if IdentCourant = parametres[g, i].nom then begin
               trouve := ParamToIndex(g, i) in dependPermis;
               if not trouve then begin
                  prevenirFonctionDeParam := True;
                  trouve := True;(***)
               end;
               if trouve then begin
                  EmpileParam(g, i);
                  if (length(identCourant)>0) and (identCourant[1]='[') then begin
                     if g = paramGlb then
                        raise ECompile.Create(erIndexNotVariab);
                     identSuivant;
                     include(dependPermis, cIndice);
                     AnalyseExpression;
      //       if not BoucleEnCours then exclude(dependPermis, cIndice);
                     if isCaracSuite(']') then begin
                        Depile(El);
                        Depile(V);
                        if (El^.typeElement = nombre)
                        then begin
                           Empile(GenGrandeurIndicee(
                              parametres[g, i], nil, nil, El.valeur));
                           libere(El);
                        end
                        else
                           Empile(GenGrandeurIndicee(parametres[g, i], El, nil, 0));
                     end
                     else
                        raise ECompile.Create(erCrochetF);
                  end; // param[page]
               end
               else
                  raise ECompile.Create(erParamInterdit);
               exit;
            end;
      if Ajuste then
         if (NbreParam[genreParam] < MaxParametres) then begin
            Trouve := True;
            Inc(NbreParam[genreParam]);
            TransfertEffectue :=
               IdentCourant = parametres[genreParam, NbreParam[genreParam]].nom;
            // rien à faire
            if not transfertEffectue then begin
               // récupération des anciennes valeurs
               for i := succ(NbreParam[genreParam]) to maxParametres do
                  if IdentCourant = parametres[genreParam, i].nom then begin
                     transfereParamE(genreParam, i, NbreParam[genreParam]);
                     transfertEffectue := True;
                     break;
                  end;
            end;
            transfertEffectue := transfertEffectue or
                      (parametres[genreParam, NbreParam[genreParam]].nom = '');
            // rien à sauvegarder
            if not transfertEffectue then begin
               // sauve ancien paramètre dans un endroit vide
               for i := succ(NbreParam[genreParam]) to maxParametres do
                  if (parametres[genreParam, i].nom = '') then begin
                     transfereParamE(genreParam, NbreParam[genreParam], i);
                     break;
                  end;
            end;
            Parametres[genreParam, NbreParam[genreParam]].nom := IdentCourant;
            EmpileParam(genreParam, NbreParam[genreParam]);
         end
         else
            raise ECompile.Create(erTropParam)
      else begin // not ajuste 
         if modelePagesIndependantes and (genreParam = paramNormal) then
            for i := succ(NbreParam[paramNormal]) to maxParametres do
               if (parametres[ParamNormal, i].nom = identCourant) then begin
                  // paramètre d'une page <> pageCourante
                  trouve := True;
                  EmpileParam(ParamNormal, i);
                  exit;
               end;
         if AnsiSameText(identCourant, 'POSMIN') or
            AnsiSameText(identCourant, 'POSMAX') then
            raise ECompile.Create(erPosMin)
         else begin
            longErreur := length(identCourant);
            raise ECompile.Create(erVarInconnue);
         end;
      end;
   end; // ChercheGrandeur

   procedure AnalyseGrandeur(var v: Tgrandeur; VariabObligatoire: boolean);
   var
      Trouve: boolean;
      T: Pelement;
   begin
      ChercheGrandeur(Trouve);
      if trouve then begin
         depile(T);
         v := T^.Pvar;
         dispose(T);
         if (v.fonct.genreC=g_Texte) then
            raise ECompile.Create(erVarTexte);
         if VariabObligatoire and (v.genreG <> variable) then
            raise ECompile.Create(erVarAttendue);
      end
      else
         raise ECompile.Create(erVarAttendue);
   end;

    procedure compileIncert; // expr = u(x)
      var
         Tn: Pelement;
      begin
         identSuivant;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseExpression; // grandeur
         if not isParentheseF then
            raise ECompile.Create(erParF);
         Depile(Tn);
         if Tn.typeElement <> grandeur
            then raise ECompile.Create(erSyntaxeIncert)
            else Empile(GenIncert(Tn.Pvar));
      end;

// Les procédures ChercheXXX cherche si IdentCourant est une XXX et empile son code

   procedure ChercheFonction(var Trouve: boolean);
// Fonction=F(.expression.)
   var
      code: TcodeFonction;
      T: Pelement;
   begin
      if (identCourant='u') and (caracCourant='(') then begin
         compileIncert;
         trouve := true;
         exit;
      end;
      Code := absolue;
      while not (AnsiSameText(identCourant, NomFonction[code])) and
         (code <> FonctInconnue) do
         code := succ(code);
      Trouve := code <> FonctInconnue;
      if trouve then begin // Fonction = nomfonct.E
         IdentSuivant;
         if code in [Reelle, Imaginaire, Argument, Absolue] then
            complexePermis := True;
         if code in [Reelle, Imaginaire, Argument] then
            complexeAtransformer := True;
         E;
         Depile(T);
         Empile(GenFonction(code, T));
         bruitPresent := (code = aleatoire) or bruitPresent;
         if code in [Reelle, Imaginaire, Argument, Absolue] then
            complexePermis := False;
         bruitPresent := (code = codeBruit) or bruitPresent;
      end; // if trouve
   end; // ChercheFonction

   procedure ChercheFonctionGlb(var Trouve: boolean);
   var
      code: TcodeFonctionGlb;
      vx, vy: Tgrandeur;

      procedure compileDxDt; // expr = d(x)/d(t)
      begin
         identSuivant;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vy, True);
         if not isParentheseF then
            raise ECompile.Create(erParF);
         if not iscaracSuite('/') then
            raise ECompile.Create(erVirgule);
         if not iscaracSuite('d') then
            raise ECompile.Create(erVirgule);
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, True);
         if isParentheseF
            then Empile(GenFonctionGlb(derivee, nil, nil, nil, vx, vy))
            else raise Ecompile.Create(erParF);
         trouve := True;
      end; // compileDxDt

      procedure compileDerivee;
// expr = diff(vy,vx) ou corr(vy,vx) ou aire(vy,vx) ou diff2(vy,vx)
// ou diff(vy,vs,ordre,N) ou phase(x,y,seuil) ou pente(x,y) ou init(x,y)
      var
         Ordre, Npoints: Pelement;
      begin
         Ordre := nil;
         Npoints := nil;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vy, True);
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseGrandeur(vx, True);
         if (code = derivee) and isCaracSuite(',') then begin
            AnalyseExpression; // ordre
            if not isVirgule then
               raise ECompile.Create(erVirgule);
            AnalyseExpression; // nombre de points
            if not isParentheseF then
               raise ECompile.Create(erParF);
            depile(Npoints);
            depile(Ordre);
            Empile(GenFonctionGlb(derivee, Ordre, Npoints, nil, vx, vy));
            exit;
         end;
         if (code = phase) and isCaracSuite(',') then begin
            AnalyseExpression; // seuil
            depile(Ordre);
         end;
         if isParentheseF then
            Empile(GenFonctionGlb(code, nil, nil, Ordre, vx, vy))
         else
            raise Ecompile.Create(erParF);
      end; // compileDerivee

      procedure compilePage; // expr = page(n)
      var
         Tn: Pelement;
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseExpression; { numéro de page }
         if not isParentheseF then
            raise ECompile.Create(erParF);
         Depile(Tn);
         if Tn.typeElement <> nombre then
            raise ECompile.Create(erFonctionPage)
         else
            Empile(GenFonctionGlb(fonctionPage, Tn, nil, nil, nil, nil));
      end;

      procedure compileLissage; // expr = lisse(vx[,ordre])
      var
         Tn: Pelement;
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, True);
         Tn := nil;
         if isVirgule then begin
            AnalyseExpression; // ordre
            Depile(Tn);
         end;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         Empile(GenFonctionGlb(code, nil, Tn, nil, vx, nil));
      end; // compileLissage

      procedure compileGlbVariab;
// expr = Magnum(vx) ou PhaseC(vx) ou frequence(vx[,seuil]) ou
// frequenceInstantanee(vx,seuil) ou RmsInstantanee(,seuil) ou Incertitude(vx)
      var
         Tr: Pelement;
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, True);
         Tr := nil; // seuil auto par défaut
         if (code in [Frequence, frequenceInstantanee,RMSInstantanee]) and isVirgule then begin
            AnalyseExpression; // seuil
            Depile(Tr);
         end;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         Empile(GenFonctionGlb(code, nil, nil, Tr, vx, nil));
      end; // compileMagnum

      procedure CompileIntegrale;
      var
         T,a,b: Pelement; // intg(f(x),x)
      begin
         a := nil;
         b := nil;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         AnalyseExpression; // f(x)
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseGrandeur(vx, True); // x
         if isVirgule then begin // intg(f(x),x,a,b)
             AnalyseExpression; // a
             if not isVirgule then
                raise ECompile.Create(erVirgule);
             AnalyseExpression; // b
             depile(b);
             depile(a);
         end;
         if not isParentheseF then
            raise ECompile.Create(erParF);
         depile(T);
         if (a=nil)
            then Empile(GenFonctionGlb(integrale, T, nil, nil, vx, nil))
            else Empile(GenFonctionGlb(integraleDefinie, T, a, b, vx, nil));
      end; // CompileIntegrale

      procedure CompileIntegraleMuette;
      var
         T, a, b: Pelement; // intgd(x,a,b,f(x))
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         if indexNom(identCourant)<>grandeurInconnue then
            raise ECompile.Create(erMuette);
         if not nomCorrect(identCourant, grandeurInconnue) then
            exit;
         grandeurs[cMuette].nom := identCourant;
         identSuivant;
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         include(dependPermis, cMuette);
         AnalyseExpression; // a
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseExpression; // b
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseExpression; // f(x)
         if not isParentheseF then
            raise ECompile.Create(erParF);
         depile(T);
         depile(b);
         depile(a);
         Empile(GenFonctionGlb(integraleMuette, T, a, b, grandeurs[cMuette], nil));
         exclude(dependPermis, cMuette);
         grandeurs[cMuette].nom := '';
      end; // CompileIntegraleMuette

      procedure CompileCreneau;
      var
         Tt, Tf, Tr : Pelement;
// creneau(t,f,r) triangle(temps,fréquence,rapport cyclique)
// bitAlea(t,f,Nombre de bits)
// bessel(n,x) Cnp(n,p) Peigne(t,deltat)
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         Tt := nil;
         Tf := nil;
         Tr := nil;
         AnalyseExpression;
         Depile(Tt);
         if isVirgule then begin
            AnalyseExpression;
            Depile(Tf);
         end
         else raise Ecompile.Create(erVirgule);
         if (code in [cCreneau,cTriangle,cBitAlea]) and isVirgule then begin
            AnalyseExpression;
            Depile(Tr);
         end; // sinon défaut 0.5
         if not isParentheseF then
            raise ECompile.Create(erParF);
         Empile(GenFonctionGlb(code, Tt, Tf, Tr, nil, nil));
         if (code = cPeigne) and (modeAcquisition <> AcqSimulation) then
            raise Ecompile.Create(erPeigneSimul);
      end; // CompileCreneau

      procedure CompileFiltre; // filtre(x,G(f)) ou filtre(G(f))
      var
         T:  Pelement;
         sauveDepend: TsetGrandeur;
         vv: tgrandeur;
         utilisation: boolean;
         i:  integer;
      begin
         if not isParentheseO then
            raise ECompile.Create(erParO);
         utilisation := Expression[pred(PointeurExp)] = ',';
         if utilisation then begin
            AnalyseGrandeur(vv, True); // x
            if not isVirgule then
               raise Ecompile.Create(erVirgule);
         end;
         sauveDepend  := dependPermis;
         complexePermis := True;
         dependPermis := [cFrequence];
         for i := 0 to pred(NbreGrandeurs) do
            if grandeurs[i].genreG <> variable then
               include(dependPermis, i)
            else if grandeurs[i].fonct.genreC = g_definitionFiltre then
               include(dependPermis, i);
// permettre complexe et seulement grandeurFrequence
         AnalyseExpression; // G(f)
// interdire complexe
         complexeAtransformer := False;
         complexePermis := False;
 // ne pas transformer complexe en réel !
         dependPermis := sauveDepend;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         Depile(T);
         if utilisation
            then Empile(GenFonctionGlb(filtrage, T, nil, nil, vv, nil))
            else Empile(GenFonctionGlb(definitionFiltre, T, nil, nil, nil, nil));
      end; // CompileFiltre

      procedure CompileMaxMin;
// maximum minimum moyenne somme sommeFFT moyenneFFT ecarttype fonct(expression) 
      var
         T: Pelement;
      begin
         if code in [sommeFFT, moyenneFFT] then
            include(dependPermis, cFrequence);
         if not IsParentheseO then
            raise ECompile.Create(erParO);
         AnalyseExpression;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         depile(T);
         Empile(GenFonctionGlb(code, T, nil, nil, nil, nil));
      end; // CompileMaxMin 

      procedure CompileEquation;
// Equation = solve(Expression = Expression, Mini, Maxi)
      var
         T1, T2, T3, T4: Pelement;
         index: TcodeGrandeur;
      begin
         if not IsParentheseO then
            raise ECompile.Create(erParO);
         index := addrY.indexG;
         include(dependPermis, index);
         AnalyseExpression;
         if iscaracSuite('=') then begin
            AnalyseExpression;
            depile(T2);
            depile(T1);
            Empile(GenOperateur('-', T1, T2));
         end;
         T3 := nil;
         T4 := nil;
         if iscaracSuite(',') then begin
            AnalyseExpression;
            depile(T4);
            if iscaracSuite(',') then begin
               AnalyseExpression;
               depile(T3);
            end
            else
               raise ECompile.Create(erParamSolve);
         end;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         depile(T1);
         Empile(GenFonctionGlb(equation, T1, T4, T3, nil, addrY));
      end; // CompileEquation

      procedure CompileEnveloppe;
// enveloppe = env(x,Expression = Expression)
      var
         T1, T2: Pelement;
         identU : string;
      begin
         if not IsParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, False);
         if isParentheseF then begin
            Empile(GenFonctionGlbBis(enveloppe, nil, nil, nil, vx, nil, envMax, 0));
            exit;
         end;
         if not IsVirgule then exit;
         identU := UpperCase(identCourant);
         if (identU = 'MAXI') or (identU='MAX') then begin // pb
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(enveloppe, nil, nil, nil, vx, nil, envMax, 0));
            exit;
         end;
         if (IdentU = 'MINI') or (identU='MIN') then begin // pb
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(enveloppe, nil, nil, nil, vx, nil, envMin, 0));
            exit;
         end;
         if (identU = 'FFT') then begin // OK
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(enveloppe, nil, nil, nil, vx, nil, envFourier, 0));
            exit;
         end;
         AnalyseExpression;
         if iscaracSuite('=') then begin
            AnalyseExpression;
            depile(T2);
            depile(T1);
            Empile(GenOperateur('-', T1, T2));
         end;
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         depile(T1);
         Empile(GenFonctionGlbBis(enveloppe, T1, nil, nil, vx, nil, envEqu, 0));
      end; // CompileEnveloppe

      procedure CompilePosition;
// position = pos(x,Equation,[up|down|mini|maxi])
      var
         T1, T2: Pelement;
         identU: string;
      begin
         if not IsParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, False);
         if not IsVirgule then
            raise Ecompile.Create(erVirgule);
         AnalyseExpression;
         if iscaracSuite('=') then begin
            AnalyseExpression;
            depile(T2);
            depile(T1);
            Empile(GenOperateur('-', T1, T2));
         end;
         depile(T1);
         if isParentheseF then begin
            Empile(GenFonctionGlbBis(position, T1, nil, nil, vx, nil,0,0));
            exit;
         end;
         if not IsVirgule then
            raise Ecompile.Create(erVirgule);
         identU := UpperCase(identCourant);
         if identU = 'UP' then begin
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(position, T1, nil, nil, vx, nil, posUp, 0));
            exit;
         end;
         if identU = 'DOWN' then begin
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(position, T1, nil, nil, vx, nil, posDown, 0));
            exit;
         end;
         if (identU = 'MINI') or (identU = 'MIN') then begin
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(position, T1, nil, nil, vx, nil, posMin, 0));
            exit;
         end;
         if (identU = 'MAXI') or (identU = 'MAX') then begin
            IdentSuivant;
            if not IsParentheseF then
               raise ECompile.Create(erParF);
            Empile(GenFonctionGlbBis(position, T1, nil, nil, vx, nil, posMax, 0));
            exit;
         end;
      end; // CompilePosition

      procedure CompileHarmonique(varObligatoire : boolean);
// harm(variable,harm début,harm fin) ; gauss(x,moyenne,sigma)
// binom(x,n,p) ; modul(x,debut,fin) ; poisson(x,moyenne)
      var
         vdebut, vfin: Pelement;
      begin
         if not IsParentheseO then
            raise ECompile.Create(erParO);
         AnalyseGrandeur(vx, varObligatoire);
         if not IsVirgule then
            raise Ecompile.Create(erVirgule);
         AnalyseExpression;
         if code <> cPoisson then begin
            if not IsVirgule then
               raise Ecompile.Create(erVirgule);
            AnalyseExpression;
         end;
         if not IsParentheseF then
            raise Ecompile.Create(erParF);
         if code = cPoisson then
            vfin := nil
         else
            depile(vfin);
         depile(vdebut);
         Empile(GenFonctionGlb(code, vdebut, vfin, nil, vx, nil));
      end; // CompileHarmonique

   begin
      Code := minimum;
      while not (AnsiSameText(IdentCourant, NomFonctionGlb[code])) and
         (code <> maximum) do
         Inc(code);
      Trouve := AnsiSameText(IdentCourant, NomFonctionGlb[code]);
      if not Trouve then begin
         Code := minimum;
         while not (AnsiSameText(IdentCourant, AliasFonctionGlb[code])) and
            (code <> maximum) do
            Inc(code);
         Trouve := AnsiSameText(IdentCourant, AliasFonctionGlb[code]);
      end;
      if trouve then begin
         identSuivant;
         if (code in [filtrage, harmonique, definitionFiltre, equation, CodeCorrelation,
            integrale, surface, lissageGlissant,lissageCentre]) and
            (indicePileCourant > 0) then
            raise ECompile.Create(erFonctionGlbIsole);
         case code of
            derivee, deriveeSeconde, CodeCorrelation, surface,
            phase, pente, origine: compileDerivee;
            integrale: compileIntegrale;
            integraleMuette: compileIntegraleMuette;
            enveloppe: compileEnveloppe;
            filtrage, definitionFiltre: compileFiltre;
            harmonique, cPoisson, cBinomial, cPhaseModulo: compileHarmonique(true);
            cGauss: compileHarmonique(false);
            equation: compileEquation;
            lissageGlissant,lissageCentre: compileLissage;
            cCreneau, cTriangle, cBessel, cCnp, cPeigne, cBitAlea : compileCreneau;
            fonctionPage: if FonctionPagePermise
               then compilePage
               else raise ECompile.Create(erFonctionPageNonPermis);
            position: compilePosition;
            pythonVar,pythonConst: Empile(GenFonctionGlb(code, nil, nil, nil, nil, nil));
            // efficace avec option AC, N=nombre de périodes ?
            moyenneAll, maximum, minimum, somme, moyenneFFT, sommeFFT, ecarttype:
               compileMaxMin; // nomfonct(expression)
            else
               compileGlbVariab; // nomfonct(nomVariable)
         end;
         if (code in [filtrage, harmonique, definitionFiltre, equation, CodeCorrelation,
             surface, lissageGlissant,lissageCentre]) and
            (CaracCourant <> #0) then
            raise ECompile.Create(erFonctionGlbIsole);
      end;
      if (identCourant = 'd') and (expression[pred(PointeurExp)] = '(') then // d(x)/d(t) ?
         CompileDxDt;
   end; // ChercheFonctionGlb

   procedure AnalyseTest;
// test = expression.[< ; > ; >= ; <= ; =].expression
   var
      T1, T2: Pelement;
      C: char;
   begin
      TextePermis := True;
      AnalyseExpression;
      C := GetOperateur;
      if charInset(C,['>', '=', '<']) or (C=infEgal) or (C=supEgal) then begin
         IdentSuivant;
         AnalyseExpression;
         depile(T2);
         depile(T1);
         Empile(GenOperateur(C, T1, T2));
      end; {if}
      TextePermis := False;
   end; // AnalyseTest

   procedure ChercheIf(var Trouve: boolean);
   var
      t, n, p: Pelement;
   begin
      trouve := AnsiSameText(IdentCourant, 'IF') or AnsiSameText(IdentCourant, 'SI');
      if trouve then begin
         identSuivant;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         TestEnCours := True;
         AnalyseTest; {valeur}
         TestEnCours := False;
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseExpression; {>0}
         if not isVirgule then
            raise ECompile.Create(erVirgule);
         AnalyseExpression; {<=0}
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         try
         Depile(N);
         Depile(P);
         Depile(T);
         Empile(GenIf(T, P, N));
         except
            raise ECompile.Create(erParamIF);
         end;
      end;{trouve}
   end; // ChercheIf

   procedure CherchePieceWise(var Trouve: boolean);

   function dernierElement : boolean;
   var pointeurExpLoc : integer;
   begin
      result := caracCourant=')';
      if not result and (caracCourant<>',') then begin
         pointeurExpLoc := pointeurExp;
         while (pointeurExpLoc<longExp) and
             not charInSet(Expression[pointeurExpLoc],[',',')']) do
             Inc(pointeurExpLoc);
         result := (Expression[pointeurExpLoc]=')');
      end;
   end;

   var
      t, n, p: Pelement;
      i,ntest : integer;
   begin
      trouve := AnsiSameText(IdentCourant, 'PIECEWISE');
      if trouve then begin
         identSuivant;
         if not isParentheseO then
            raise ECompile.Create(erParO);
         ntest := 0;
         repeat
            TestEnCours := True;
            AnalyseTest;
            TestEnCours := False;
            if not isVirgule then
               raise ECompile.Create(erVirgule);
            AnalyseExpression; // expression si test
            if not isVirgule then
               raise ECompile.Create(erVirgule);
            inc(nTest);
         until dernierElement;
         AnalyseExpression; // else final
         if not IsParentheseF then
            raise ECompile.Create(erParF);
         try
         Depile(N);
         Empile(GenPW(nil, nil, N)); // else final
         for I := 1 to Ntest do begin
            Depile(N); // test précédent
            Depile(P);
            Depile(T);
            Empile(GenPW(T, P, N));
         end;
         except
            raise ECompile.Create(erParamPW);
         end;
      end; // trouve
   end; // CherchePieceWise

   procedure CherchePi(var trouve: boolean);
   begin
      trouve := (IdentCourant = piMin) or (IdentCourant = piMaj) or
         (IdentCourant = 'pi') or (IdentCourant = 'Pi');
      if trouve then
         Empile(pointeurPi);
   end; // CherchePi

   procedure ChercheJ(var trouve: boolean);
   begin
      trouve := IdentCourant = 'j';
      if trouve then
         if complexePermis then begin
            empile(pointeurJ);
            if not (cFrequence in DependPermis) then
               complexeAtransformer := True;
         end
         else
            raise ECompile.Create(erReel);
   end; // ChercheJ

   procedure AnalyseElement; // Element = fonction/E/nombre/grandeur
   var
      Trouve: boolean;
      valeur: double;
   begin
      if length(identCourant)=0 then
         raise ECompile.Create(erExpressionVide)
      else if isLettre(IdentCourant[1]) then begin
         CherchePi(trouve);
         if trouve then begin
            identSuivant;
            exit;
         end;
         ChercheJ(trouve);
         if trouve then begin
            identSuivant;
            exit;
         end;
         if (caracCourant='(') then ChercheFonction(trouve);
         if trouve then exit;
         if (caracCourant='(') or (caracCourant=#0) then ChercheFonctionGlb(trouve); // #0 Pour Python
         if trouve then exit;
         ChercheIf(trouve);
         if trouve then exit;
         CherchePieceWise(trouve);
         if trouve then exit;
         ChercheGrandeur(Trouve);
      end {Then}
      else if charInSet(IdentCourant[1],ChiffreEtc) then begin
         try
            valeur := StrToFloatWin(IdentCourant);
            Empile(GenNombre(valeur));
            IdentSuivant;
         except
            raise ECompile.Create(erNombre);
         end;
      end
      else
         E;
   end; // analyseElement

   procedure AnalyseFacteur; // facteur = Element.^.element
   var
      T1, T2: Pelement;
      C: char;
   begin
      AnalyseElement;
      C := getOperateur;
      while (c = '^') do begin
         IdentSuivant;
         C := GetOperateur;
         if charInSet(C,['+', '-'])
            then IdentSuivant
            else C := '+';
         AnalyseElement;
         if C = '-' then begin
            depile(T1);
            if T1.typeElement=nombre
               then begin
                  empile(genNombre(-T1.valeur));
                  libere(T1);
               end
               else empile(GenFonction(oppose, T1));
         end;
         depile(T2);
         depile(T1);
         if T2=PointeurDeux
            then Empile(GenFonction(carre,T1))
            else Empile(GenOperateur('^', T1, T2));
         C := getOperateur;
         if (T2.TypeElement=nombre) and (T2.valeur=1) and (C='/') then ;
            // message d'ambigüité pour ^1/2 ?
      end; {while}
   end; // AnalyseFacteur

   procedure AnalyseTerme; // terme = facteur.[* ou / ].facteur
   var
      C,C2: char;
      T1, T2: Pelement;
   begin
      AnalyseFacteur;
      c := GetOperateur;
      while charinset(c,['*', '/']) do begin
         IdentSuivant;
         C2 := GetOperateur;
         if charInSet(C2,['+','-','*','/',',','=','>','<']) then
            raise Ecompile.Create(erDoubleOperateur+C+C2);
         AnalyseFacteur;
         depile(T2);
         depile(T1);
         Empile(GenOperateur(C, T1, T2));
         C := GetOperateur;
      end; {while}
   end; // AnalyseTerme

   procedure AnalyseExpression;
// Expression = [+ ou - ou not ou rien].Terme.[+ ou - ou xor ou or ou and ou nand ou mod].terme
   var
      C: char;
      T1, T2: Pelement;
   begin
      C := GetOperateur;
      if charinset(C,['+', '-', 'N']) // N=Not
         then IdentSuivant
         else C := '+';
      AnalyseTerme;
      if C <> '+' then begin
         depile(T1);
         if T1.typeElement=nombre
            then begin
                empile(genNombre(-T1.valeur));
                libere(T1);
            end
            else empile(GenFonction(oppose, T1));
      end;
      C := GetOperateur;
      while charinset(C,['+', '-', 'O', 'X', 'A', 'M','N']) do begin
         IdentSuivant;
         AnalyseTerme;
         depile(T2);
         depile(T1);
         Empile(GenOperateur(C, T1, T2));
         C := GetOperateur;
      end; {while}
   end; // AnalyseExpression

// calcul formel en complexe

   function transformeReel(f: Pelement): Pelement; forward;
   function transformeNorme(f: Pelement): Pelement; forward;
   function transformeArg(f: Pelement): Pelement; forward;

   function jPresent(f: Pelement): boolean;
   begin
      if f=nil then begin
         result := false;
         exit;
      end;
      with f^ do
         case typeElement of
            fonction: jPresent := jPresent(Operand);
            fonctionGlb: if OperandGlb <> nil then
                  jPresent := jPresent(OperandGlb)
               else
                  jPresent := False;
            ifThenElse: jpresent :=
                  jPresent(test) or jPresent(positif) or jPresent(negatif);
            PieceWise: jpresent :=
                  jPresent(PWtest) or jPresent(PWthen) or jPresent(PWtestElse);
            racineMoinsUn: jPresent := True;
            operateur: jPresent := jPresent(operG) or jPresent(operD);
            else
               jPresent := False;
         end;{case}
   end;

   function genQuatre(sign1, sign2: char; a1, a2, a3, a4: Pelement): Pelement;
  //  (a1,sign2,a2),sign1,(a3,sign2,a4)
   begin
      genQuatre := genOperateurSimpl(sign1,
         genOperateurSimpl(sign2, a1, a2),
         genOperateurSimpl(sign2, a3, a4));
   end;

   function genNormeCarre(re, im: Pelement): Pelement;
   begin
      genNormeCarre := genOperateurSimpl('+',
         genFonctionSimpl(carre, re),
         genFonctionSimpl(carre, im));
   end;

   function transformeImag(f: Pelement): Pelement;
   var
      rea, reb, ima, imb, rebp, imbp: Pelement;
   begin
      transformeImag := pointeurZero;
      with f^ do
         case typeElement of
            fonction: case codeF of
                  oppose: transformeImag :=
                        genFonctionSimpl(oppose, transformeImag(operand));
                  carre: transformeImag  :=
                        genOperateurSimpl('*', genNombre(2),
                        genOperateurSimpl('*',
                        transformeReel(operand),
                        transformeImag(operand))); // 2*x*y
                  racine: transformeImag :=
                        genOperateurSimpl('*', genFonctionSimpl(racine,
                        transformeNorme(operand)),
                        genFonctionSimpl(sinus,
                        genOperateur('*',
                        transformeArg(operand),
                        genNombre(0.5))));
                  inverse: transformeImag :=
                        genOperateurSimpl('/', genFonctionSimpl(
                        oppose, transformeImag(operand)), genFonctionSimpl(
                        carre, transformeNorme(operand)));
                  exponentielle: transformeImag :=
                        genOperateurSimpl('*', genFonctionSimpl(
                        exponentielle, transformeReel(operand)), genFonctionSimpl(
                        sinus, transformeImag(operand)));
                  else
                     if jPresent(operand) then
                        raise ECompile.Create(erFonctNonCpx);
               end;
            racineMoinsUn: transformeImag := pointeurUn;
            nombre, grandeur: ;
            operateur: case codeOp of
                  '+', '-': transformeImag :=
                        genOperateurSimpl(codeOp, transformeImag(operg),
                        transformeImag(operd));
                  '*', '/': begin
                     rea := transformeReel(operg);
                     reb := transformeReel(operd);
                     ima := transformeImag(operg);
                     imb := transformeImag(operd);
                     if codeOp = '*' then
                        transformeImag :=
                           genQuatre('+', '*', ima, reb, imb, rea)
                     { im(a*b) = im(a)*re(b)+im(b)*re(a) }
                     else if imb = pointeurZero then
                        transformeImag := genOperateurSimpl('/', ima, reb)
                     else if reb = pointeurZero then
                        transformeImag := genFonctionSimpl(oppose,
                           genOperateurSimpl('/', rea, imb))
                     else begin
                        rebp := copie(reb);
                        imbp := copie(imb);
                        transformeImag :=
                           genOperateurSimpl('/',
                           genQuatre('-', '*', reb, ima, rea, imb),
                           genNormeCarre(rebp, imbp));
                     end;
// im(a/b) = (re(b)*im(a)-re(a)*im(b))/abs(b)^2
//  b réel im(a/b) = im(a)/re(b)
//  b imag im(a/b) = -re(a)/im(b)
                  end; { '*','/' }
                  '^': if operd.typeElement = nombre then
                        transformeImag := genOperateurSimpl('*',
                           genOperateur('^', transformeNorme(operg), copie(operd)),
                           genFonctionSimpl(sinus, genOperateur('*',
                           transformeArg(operg), copie(operd))))
                     else
                        raise ECompile.Create(erExposantCpx);
                  else
                     raise ECompile.Create(erOperNonCpx);
               end;{case operateur}
         end;{case type}
   end; // transformeImag

   function transformeReel(f: Pelement): Pelement;
   var
      rea, reb, ima, imb, rebp, imbp: Pelement;
   begin
      transformeReel := pointeurZero;
      with f^ do
         case typeElement of
            fonction: case codeF of
                  oppose: transformeReel :=
                        genFonctionSimpl(oppose, transformeReel(operand));
                  carre: transformeReel  :=
                        genOperateurSimpl('-', genFonctionSimpl(
                        carre, transformeReel(operand)), genFonctionSimpl(
                        carre, transformeImag(operand)));
                  racine: transformeReel :=
                        genOperateurSimpl('*', genFonctionSimpl(racine,
                        transformeNorme(operand)),
                        genFonctionSimpl(cosinus,
                        genOperateur('*',
                        transformeArg(operand),
                        genNombre(0.5))));
                  inverse: transformeReel :=
                        genOperateurSimpl('/', transformeReel(operand),
                        genFonctionSimpl(carre, transformeNorme(operand)));
                  exponentielle: transformeReel :=
                        genOperateurSimpl('*', genFonctionSimpl(
                        cosinus, transformeImag(operand)), genFonctionSimpl(
                        exponentielle, transformeReel(operand)));
                  else
                     if jPresent(operand) then
                        raise ECompile.Create(erFonctNonCpx)
                     else
                        transformeReel := copie(f);
               end;
            operateur: case codeOp of
                  '+', '-': transformeReel :=
                        genOperateurSimpl(codeOp, transformeReel(operg),
                        transformeReel(operd));
                  '*', '/': begin
                     rea := transformeReel(operg);
                     reb := transformeReel(operd);
                     ima := transformeImag(operg);
                     imb := transformeImag(operd);
                     if codeOp = '*' then
                        transformeReel :=
                           genQuatre('-', '*', rea, reb, ima, imb)
// re(a*b) = re(a)*re(b)-im(a)*im(b)
                     else if reb = pointeurZero then
                        transformeReel := genOperateurSimpl('/', ima, imb)
                     else if imb = pointeurZero then
                        transformeReel := genOperateurSimpl('/', rea, reb)
                     else begin
                        rebp := copie(reb);
                        imbp := copie(imb);
                        transformeReel :=
                           genOperateurSimpl('/', genQuatre('+', '*', rea, reb, ima, imb),
                           genNormeCarre(rebp, imbp));
                     end;
                     { re(a/b) = (re(a)re(b)+im(a)im(b))/abs(b)^2 }
                  end; { '*','/' }
                  '^': if operd.typeElement = nombre then
                        transformeReel := genOperateurSimpl('*',
                           genOperateur('^', transformeNorme(operg), copie(operd)),
                           genFonctionSimpl(cosinus, genOperateur('*',
                           transformeArg(operg), copie(operd))))
                     else
                        raise ECompile.Create(erExposantCpx);
                  else
                     raise ECompile.Create(erOperNonCpx);
               end;{case operateur}
            nombre: transformeReel := genNombre(valeur);
            grandeur: transformeReel := copie(f);
            racineMoinsUn: transformeReel := pointeurZero;
         end;{case type}
   end; // transformeReel

   function transformeNorme(f: Pelement): Pelement;

      function gen_plus_moins(code_op: char): Pelement;
      var
         rea, reb, ima, imb: Pelement;
      begin
         rea := transformeReel(f^.operg);
         reb := transformeReel(f^.operd);
         ima := transformeImag(f^.operg);
         imb := transformeImag(f^.operd);
         if (ima = PointeurZero) and (imb = PointeurZero) then
            gen_plus_moins := genFonctionSimpl(absolue, genOperateurSimpl(
               code_op, rea, reb))
         else if (rea = PointeurZero) and (reb = PointeurZero) then
            gen_plus_moins := genFonctionSimpl(absolue,
               genOperateurSimpl(code_op, ima, imb))
         else
            gen_plus_moins := genFonctionSimpl(racine,
               genOperateurSimpl('+',
               genFonctionSimpl(carre, genOperateurSimpl(code_op,
               rea, reb)),
               genFonctionSimpl(carre, genOperateurSimpl(code_op,
               ima, imb))));
// norme(a+-b) = racine((re(a)+-re(b))^2+(im(a)+-im(b))^2)
      end;

   begin
      transformeNorme := pointeurZero;
      with f^ do
         case typeElement of
            fonction: case codeF of
                  oppose: transformeNorme := transformeNorme(operand);
                  carre: transformeNorme  :=
                        genNormeCarre(transformeReel(operand), transformeImag(operand));
                  racine: transformeNorme :=
                        genFonctionSimpl(racine, genFonctionSimpl(racine,
                        genNormeCarre(transformeReel(operand),
                        transformeImag(operand))));
                  inverse: transformeNorme :=
                        genFonctionSimpl(inverse, transformeNorme(operand));
                  exponentielle: transformeNorme :=
                        genFonctionSimpl(exponentielle, transformeReel(operand));
                  else if jPresent(operand)
                     then raise ECompile.Create(erFonctNonCpx)
                     else transformeNorme := genFonctionSimpl(absolue, copie(f));
               end;
            operateur: case codeOp of
                  '*', '/': transformeNorme :=
                        genOperateurSimpl(codeOp, transformeNorme(operg),
                        transformeNorme(operd));
                  '+', '-': transformeNorme := gen_plus_moins(codeOp);
                  '^': if operd.typeElement = nombre then
                        transformeNorme := genOperateurSimpl('^',
                           transformeNorme(operg), copie(operd))
                     else raise ECompile.Create(erExposantCpx);
                  else raise ECompile.Create(erOperNonCpx);
               end;
            nombre: transformeNorme := genNombre(abs(valeur));
            grandeur: transformeNorme := genFonctionSimpl(absolue, copie(f));
            racineMoinsUn: transformeNorme := pointeurUn;
         end;{case type}
   end; // transformeNorme

   function transformeArg(f: Pelement): Pelement;
   begin
      transformeArg := pointeurZero;
      with f^ do
         case typeElement of
            fonction: case codeF of
                  oppose: { arg(-x)=atan2(-im(x)/-re(x)) }
                     transformeArg :=
                        genOperateur('&', genFonctionSimpl(oppose,
                        transformeImag(operand)),
                        genFonctionSimpl(oppose,
                        transformeReel(operand)));
                  carre: transformeArg :=
                        genOperateurSimpl('*', genNombre(2),
                        transformeArg(operand));
                  racine: transformeArg :=
                        genOperateur('*', genNombre(0.5),
                        genOperateur('&', transformeImag(operand),
                        transformeReel(operand)));
                  inverse: transformeArg := genFonctionSimpl(oppose, transformeArg(operand));
                  exponentielle: transformeArg := transformeImag(operand);
                  else
                     if jPresent(operand) then
                        raise ECompile.Create(erFonctNonCpx)
                     else
                        transformeArg := genFonction(argument, copie(f));
               end;
            operateur: case codeOp of
                  '*': transformeArg :=
                        genOperateurSimpl('@', transformeArg(operg),
                        transformeArg(operd));
                  { arg(a*b) = arg(a)+arg(b) }
                  '/': transformeArg :=
                        genOperateurSimpl('#', transformeArg(operg),
                        transformeArg(operd));
                  { arg(a/b) = arg(a)-arg(b) }
                  '+', '-': transformeArg :=
                        genQuatre('&', codeOp, transformeImag(operg),
                        transformeImag(operd),
                        transformeReel(operg),
                        transformeReel(operd));
// & = Atan2 (imag,double)
// arg(a+b)=atan2((im(a)+im(b))/(re(a)+re(b))
                  '^': if operd.typeElement = nombre then
                        transformeArg := genOperateurSimpl('*', copie(operd),
                           transformeArg(operg))
                     else
                        raise ECompile.Create(erExposantCpx);
                  else
                     raise ECompile.Create(erOperNonCpx);
               end;{case operateur}
            nombre: if valeur < 0 then
                  transformeArg := genFonction(Angle, pointeurPi);
            grandeur: transformeArg := genFonction(argument, copie(f));
            racineMoinsUn: transformeArg := genFonction(Angle, genNombre(pi / 2));
         end;{case type}
   end; // transformeArg

   function transformeComplexe(f: Pelement): Pelement;
   begin
      with f^ do
         case typeElement of
            fonction: case codeF of
                  argument: Result := transformeArg(operand);
                  absolue: Result := transformeNorme(operand);
                  reelle: Result := transformeReel(operand);
                  imaginaire: Result := transformeImag(operand);
// on supprime la fonction et on transforme l'opérande }
                  else Result := genFonction(codeF, transformeComplexe(operand));
// on change l'opérande pas la fonction ; calcul en réel ? => test en sortie ?
               end;{ case fonction }
            operateur: Result  := genOperateur(codeOp,
                  transformeComplexe(operg),
                  transformeComplexe(operd));
// on change les opérandes pas l'opérateur
            nombre, grandeur: Result := copie(f);
            ifThenElse: Result := copie(f);
            PieceWise: Result := copie(f);
// on renvoie tel quel
            else begin
               raise ECompile.Create(erReel);
            end;
         end; {case type}
   end; // transformeComplexe

var
   i: TIndicePile;
   g: TgenreGrandeur;
   addrY0, addrYp0: Tgrandeur;
   index, indexP: TcodeGrandeur;
begin // CompileF
   Result := True;
   if expression = '' then begin
      posErreur  := 0;
      LongErreur := 1;
      Libere(calcul);
      depend := [];
      genreC := g_forward;
      if (ordreEqua = 1) or (ordreEqua = 2) then begin // y''= ou y'=
         indexP := indexDerivee(addrY, grandeurs[0], ajuste, True); // crée y'
         if (ordreEqua = 2) and (indexP <> grandeurInconnue) then
            indexDerivee(grandeurs[indexP], grandeurs[0], ajuste, True); // crée y"
      end;
      isSysteme := True;
      codeErreurC := '';
      exit;
   end;
   try
      InitFonctor;
      if (ordreEqua = 1) or (ordreEqua = 2) then
         if ajuste and not (ajusteOrigine) then
            addrY0 := addrY
         // modélisation = expérimentale pour la valeur initiale
         else begin
            index := indexGrandeurInitiale(addrY, addrY0, ajuste);
            include(depend, index); // y0
         end;
      if ordreEqua = 2 then begin
         index := indexGrandeurInitiale(addrYp, addrYp0, ajuste);
         include(depend, index); //y'0
      end;
      AnalyseExpression;
      if (pointeurExp <= longExp) and (expression[pointeurExp] <> '_') then
         raise ECompile.Create(erSyntaxe);
      if complexeAtransformer then begin
         pilePointeur[2] := pilePointeur[1];
         pilePointeur[1] := TransformeComplexe(pilePointeur[1]);
         libere(pilePointeur[2]);
         if ExisteJ(pilePointeur[1]) then begin
            libere(pilePointeur[1]);
            raise ECompile.Create(erReel);
         end;
      end;
      calcul := PilePointeur[1];
      case ordreEqua of
         1: calcul := GenFonctionGlb(equaDiff1, calcul, nil, nil, addrY0, nil);
         2: calcul := GenFonctionGlb(equaDiff2, calcul, nil, nil, addrY0, addrYp0);
      end;
      for g := paramGlb to paramNormal do
          for index := 1 to maxParametres do
             Grandeurs[zeroParam[g] + index] := Parametres[g, index];
   except
      on E: Ecompile do begin
         for i := 1 to MaxPile do
            Libere(pilePointeur[i]);
         codeErreurC := E.message;
         NbreParam := sauveNparam;
         calcul := nil;
         Result := False;
      end;
   end;
end;// CompileF

procedure Tmodele.GenereM(X, Y: Tvecteur; miniX, maxiX: double; logX: boolean;
   var PointFinal: integer);
var
   deltaX: double;
   t0, coeff_t,coeff_x : double;
   Xtrie: boolean;
   dependMod: TsetGrandeur;

   procedure InitTableau;
   var
      j: integer;
      montant: boolean;
   begin
      with pages[pageCourante] do begin
         Xtrie := indexX = 0;
         if not Xtrie then begin
            montant := valeurVar[indexX, 2] > valeurVar[indexX, 0];
            if montant then begin
               for j := 1 to pred(nmes) do
                  if valeurVar[indexX, j] < valeurVar[indexX, pred(j)] then
                     exit;
            end
            else begin
               for j := 1 to pred(nmes) do
                  if valeurVar[indexX, j] > valeurVar[indexX, pred(j)] then
                     exit;
            end;
            Xtrie := True;
         end;
         if Xtrie then begin
            t0 := valeurVar[0, 0];
            coeff_t := pred(nmes) / (valeurVar[indexX, pred(nmes)] - valeurVar[indexX, 0]);
         end;
         grandeurs[cIndice].valeurCourante := 0;
         dependMod := depend;
         exclude(dependMod, indexX);
         for j := 0 to pred(NbreGrandeurs) do
            if (grandeurs[j].genreG <> variable) then
               exclude(dependMod, j);
      end;
   end;

   procedure SetTemps(t: double);
   var
      i, j: integer;
      dataOK: boolean;
      mini, ecart: double;
   begin with pages[pageCourante] do begin
         grandeurs[indexX].valeurCourante := t;
         if Xtrie then
            i := round(coeff_t * (t - t0))
         else begin // Longuet donc à voir
            exit;
            i := 0;
            mini := maxReal;
            for j := 0 to pred(nmes) do begin
               ecart := abs(valeurVar[indexX, j] - t);
               if ecart < mini then begin
                  mini := ecart;
                  i := j;
               end;
            end;
         end;
         dataOK := (i < 0) or (i >= nmes);
         if dataOK then
            grandeurs[cIndice].valeurCourante := i;
         for j := 0 to pred(NbreGrandeurs) do
            with grandeurs[j] do
               if (j in dependMod) then
                  if (fonct.genreC = g_fonction) then
                     valeurCourante := calcule(fonct.calcul)
                  else if dataOK then
                     valeurCourante := valeurVar[j, i];
   end end;

   procedure Trier;
// Tri Shell Meyer-Baudoin p 456 de x et y selon x
   var
      increment: integer;
      cle, sauveY: double;
      i, k, j: integer;
   begin
      increment := 1;
      while (increment < (PointFinal div 3)) do
         increment := succ(3 * increment);
      repeat
         for k := 0 to pred(increment) do begin
            i := increment + k;
            while (i <= PointFinal) do begin
               sauveY := y[i];
               cle := x[i];
               j := i - increment;
               while (j >= 0) and (x[j] > cle) do begin
                  x[j + increment] := x[j];
                  y[j + increment] := y[j];
                  Dec(j, increment);
               end;
               x[j + increment] := cle;
               y[j + increment] := sauveY;
               Inc(i, increment);
            end;
         end;
         increment := increment div 3;
      until increment = 0;
   end;{trier}

   procedure CalculLoc(debut, fin: integer; const Min: double);
   var
      i: integer;
   begin
      x[debut] := Min;
      for i := succ(debut) to fin do
         if logX
            then x[i] := x[pred(i)] * deltaX
            else x[i] := x[pred(i)] + deltaX;
      for i := debut to fin do begin
         setTemps(x[i]*coeff_x);
         Y[i] := calcule(calcul);
      end;{i}
   end;{ CalculLoc }

const
   NbreMin = 192;
var
   i, j, Lnbre: integer;
   Ymin, Ymax, YsecondeMin: double;
   NbreInter, // Nombre de points par intervalle
   NbreMax: integer;
begin
   if uniteSIGlb
       then coeff_x := grandeurs[indexX].coeffSI
       else coeff_x := 1;
   initTableau;
   NbreMax := high(X);
   NbreInter := 2 * (NbreMax - NbreMin) div NbreMin;
   NbreMax := NbreMin + (NbreInter) * (NbreMin div 2);
   if logX then begin
      deltaX := power(10,log10(MaxiX / MiniX) / NbreMin);
      CalculLoc(0, NbreMin, MiniX);
   end
   else begin
      deltaX := (MaxiX - MiniX) / NbreMin;
      CalculLoc(0, NbreMin, MiniX);
   end;
   i := 0;
   LNbre := NbreMin;
   repeat // ôte Nan
      if isNan(y[i]) then begin
         Dec(LNbre);
         for j := i to LNbre do begin
            y[j] := y[succ(j)];
            x[j] := x[succ(j)];
         end;
      end
      else Inc(i)
   until i > LNbre;
   Ymin := y[0];
   Ymax := y[0];
   for i := 1 to LNbre do
      if y[i] > ymax
         then ymax := y[i]
         else if y[i] < ymin
            then ymin := y[i];
   YsecondeMin := (Ymax - Ymin) / 128;
// dX*dX*y"(x)<4 pixels sachant que ymax-ymin=512 pixels et dX=2 pixels
   PointFinal := succ(LNbre);
   if logX
      then deltaX := power(10,log10(MaxiX / MiniX) / NbreMax)
      else deltaX := (MaxiX - MiniX) / NbreMax;
   i := 1;
   while (i<LNbre) do begin
      if (abs(y[succ(i)] + y[pred(i)] - 2 * y[i]) > YsecondeMin)
      then begin
         if logX
            then CalculLoc(PointFinal, PointFinal + pred(NbreInter), x[pred(i)] * deltaX)
            else CalculLoc(PointFinal, PointFinal + pred(NbreInter), x[pred(i)] + deltaX);
// + deltax évite de recalculer les points i-1 i+1,
// i évité par nombre de points pair dans l'intervalle
         Inc(PointFinal, NbreInter);
         Inc(i, 2);
      end
      else Inc(i)
   end;
   Dec(PointFinal);
   i := 0;
   while i<pointFinal do begin // ôte Nan
      if isNan(y[i]) then begin
         Dec(PointFinal);
         for j := i to pointFinal do begin
            y[j] := y[succ(j)];
            x[j] := x[succ(j)];
         end;
      end
      else Inc(i)
   end;
   Trier; // classe les points ajoutés
   if coeffSI<>1 then for i := 0 to PointFinal do
          y[i] := y[i] / coeffSI;
end; // GenereM

procedure Tmodele.GenereMGlb(X, Y: Tvecteur; miniX, maxiX: double; logX: boolean;
   var PointFinal: integer);
const
   NbreMax = 256;
var
   deltaX,coeff_x: double;

   procedure CalculLoc;
   var
      i: integer;
   begin
      x[0] := MiniX;
      for i := 1 to NbreMax do
         if logX
            then x[i] := x[pred(i)] * deltaX
            else x[i] := x[pred(i)] + deltaX;
      for i := 0 to NbreMax do begin
         try
            grandeurs[indexX].valeurCourante := x[i]*coeff_x;
            Y[i] := calcule(calcul);
         except
            Y[i] := Nan;
         end;
      end;{i}
   end;// CalculLoc

var i : integer;
begin
   if logX
      then deltaX := power(10,log10(MaxiX / MiniX) / NbreMax)
      else deltaX := (MaxiX - MiniX) / NbreMax;
   with grandeurs[indexX] do
      if uniteSIGlb and (fonct.genreC = G_experimentale)
          then coeff_x := dix(puissance)
          else coeff_x := 1;
   CalculLoc;
   if coeffSI<>1 then
      for i := 0 to NbreMax do
         y[i] := y[i] / coeffSI;
   PointFinal := NbreMax;
end; // GenereMGlb

procedure Tmodele.GenereEquation(X, Y: Tvecteur; axeX, axeY: TGrandeur;
   p: TcodePage; var PointFinal: integer);
var
   deltaX: double;
   miniX, maxiX: double;
   i:  integer;
   fx: integer;
   indexParam, indexMax: TcodeGrandeur;
   indexAbscisse, indexOrdonnee: TcodeGrandeur;
begin
   indexAbscisse := axeX.indexG;
   indexOrdonnee := axeY.indexG;
   grandeurs[cIndice].valeurCourante := 0;
   PointFinal := 340; { 1 point sur 3 en 1024 }
// Chercher les grandeurs à calculer pour obtenir l'abscisse et l'ordonnee : indexMax
   if indexAbscisse < indexOrdonnee
      then indexMax := indexOrdonnee
      else indexMax := indexAbscisse;
// Chercher de quoi dépend le paramètre de l'équation : indexParam
   if grandeurs[indexX].fonct.genreC = g_experimentale then
      indexParam := indexX
   else begin
      indexParam := grandeurs[indexX].fonct.chercheDebutDepend;
      if indexParam = grandeurInconnue then
         indexParam := indexX;
   end;
   GetMinMax(pages[p].valeurVar[indexParam], pages[p].nmes, miniX, maxiX);
   deltaX := (MaxiX - MiniX) / succ(PointFinal);
   grandeurs[indexY].valeurCourante := Nan;
   for i := 0 to PointFinal do begin
      try
         { Générer valeur de index1 }
         Grandeurs[indexParam].valeurCourante := MiniX + i * deltaX;
         // calculer les grandeurs dépendantes
         for fx := succ(indexParam) to indexX do
            with Grandeurs[fx] do
               if (genreG = variable) and (fonct.genreC in
                  [g_fonction, g_equation]) then begin
                  try
                     valeurCourante := calcule(fonct.calcul);
                  except
                     valeurCourante := Nan;
                  end;
               end;
         // Calculer la solution de l'équation
         grandeurs[indexY].valeurCourante := calcule(calcul);
         // calculer les grandeurs dépendantes
         for fx := succ(indexY) to indexMax do
            with Grandeurs[fx] do
               if (genreG = variable) and (fonct.genreC in
                  [g_fonction, g_equation]) and (indexY in fonct.depend) then begin
                  try
                     valeurCourante := calcule(fonct.calcul);
                  except
                     valeurCourante := Nan;
                  end;
               end;
         x[i] := grandeurs[indexAbscisse].valeurCourante;
         y[i] := grandeurs[indexOrdonnee].valeurCourante;
      except
         x[i] := Nan;
         y[i] := Nan;
      end;
   end;{i}
end;// GenereEquation

function Tmodele.CompileM(const LigneCourante: String;
   var posErreur, LongErreur: integer): boolean;
var
   ordreEqua: integer;

   procedure InterditInverse(k: TcodeGrandeur);
   begin
      if (k > 0) and
         (k <= maxParametres) then begin
         if paramInverse[k] then begin
            ModifInverse := True;
            paramInverse[k] := False;
         end;
         // Ne plus permettre l'inversion
         InversePermis[k] := False;
      end;
   end;

   procedure SetSinusoide;
   var
      posSinus, posParF, index, i, posCourante: integer;
      parO, parF: integer;
      nomP: string;
      expressionUC:string;
   begin
      expressionUC := UpperCase(expression);
      IsSinusoide := False;
      posSinus := pos('*SIN(', expressionUC);
      if posSinus = 0 then begin
         posSinus  := pos('*COS(', expressionUC);
         IsCosinus := posSinus > 0;
      end
      else IsCosinus := False;
      if posSinus > 1 then begin
         // a+b*sin(2*pi*t/T+phi) ?
         // amplitude >0
         Phase := grandeurInconnue;
         PeriodeOuFrequence := grandeurInconnue;
         Amplitude := grandeurInconnue;
         nomP := '';
         posCourante := posSinus - 1;
         while (posCourante > 0) and
               isCaracGrandeur(expression[posCourante]) do begin
            nomP := expression[posCourante] + nomP;
            Dec(posCourante);
         end;
         index := indexNom(nomP);
         Amplitude := IndexToParam(genreParam, index);
         if amplitude = grandeurInconnue then exit;
// phase entre -pi et + pi
         posCourante := posSinus + 3; // sin
         parO := 0;
         parF := 0;
         posParF := posSinus;
         repeat
            Inc(posCourante);
            if expression[posCourante] = '(' then
               Inc(parO);
            if expression[posCourante] = ')' then begin
               Inc(parF);
               posParF := posCourante;
            end;
         until (parO = parF) or (posCourante = length(expression));
         expressionUC := copy(expression,posSinus+5,posParF-posSinus-5);
         posCourante := pos('+', expressionUC);
         if posCourante=0 then posCourante := pos('-', expressionUC);
         if posCourante > 0 then begin // +- phi
            inc(posCourante, 1);
            nomP := '';
            while (posCourante <= length(expressionUC)) and
                  isCaracGrandeur(expressionUC[posCourante]) do begin
               nomP := nomP + expressionUC[posCourante];
               inc(posCourante);
            end;
            index := indexNom(nomP);
            Phase := IndexToParam(genreParam, index);
         end;
         if Phase = grandeurInconnue then exit;
         // période fréquence pulsation >0
         IsSinusoide := True;
         posCourante := pos('*' + grandeurs[0].nom, expressionUC);
         if posCourante > 0 then begin // f*t
            Dec(posCourante, 1);
            nomP := '';
            while (posCourante > 0) and
                  isCaracGrandeur(expressionUC[posCourante]) do begin
               nomP := expressionUC[posCourante] + nomP;
               Dec(posCourante);
            end;
            index := indexNom(nomP);
            PeriodeOuFrequence := IndexToParam(genreParam, index);
         end;
         posCourante := pos(grandeurs[0].nom+'/', expressionUC);
         if posCourante > 0 then begin // t/T
            inc(posCourante, 1+length(grandeurs[0].nom));
            nomP := '';
            while (posCourante < length(expressionUC)) and
                  isCaracGrandeur(expressionUC[posCourante]) do begin
               nomP := nomp + expressionUC[posCourante];
               inc(posCourante);
            end;
            index := indexNom(nomP);
            PeriodeOuFrequence := IndexToParam(genreParam, index);
         end;
         for i := 1 to NbreParam[genreParam] do
            if (i <> Phase) and (i <> amplitude) then begin
               if UpCase(parametres[genreParam, i].nom[1]) = 'T' then begin
                  PeriodeOuFrequence := i;
                  break;
               end;
               if UpCase(parametres[genreParam, i].nom[1]) = 'F' then begin
                  PeriodeOuFrequence := i;
                  break;
               end;
               if parametres[genreParam, i].nom[1] = omegaMin then begin
                  PeriodeOuFrequence := i;
                  break;
               end;
               if parametres[genreParam, i].nom[1] = omegaMaj then begin
                  PeriodeOuFrequence := i;
                  break;
               end;
            end;
      end;
      interditInverse(PeriodeOuFrequence);
      interditInverse(Phase);
   end;

   procedure SetParamInverse(F: Pelement);
   // Parametre 1/x à remplacer par iX=1/x
   var
      kD, kG: TcodeGrandeur;
   begin
      if F=nil then exit;
      case F^.typeElement of
         operateur: begin
            if (F^.operD.TypeElement = grandeur) then begin
               kD := F^.operD.Pvar.indexG;
               if (F^.operD.Pvar.genreG) = paramNormal
                  then kD := indexToParam(paramNormal, kD)
                  else kD := grandeurInconnue
            end
            else kD := grandeurInconnue;
            if (F^.operG.TypeElement = grandeur) then begin
               kG := F^.operG.Pvar.indexG;
               if f^.operG.Pvar.genreG = paramNormal
                  then kG := indexToParam(paramNormal, kG)
                  else kG := grandeurInconnue;
            end
            else kG := grandeurInconnue;
            if (F^.codeOp = '/') and
               (kD <> grandeurInconnue) and
               InversePermis[kD] then begin
               ParamInverse[kD] := True;
               F^.codeOp := '*';
               setParamInverse(F^.operG);
            end
            else begin
               interditInverse(kD);
               setParamInverse(F^.operG);
               setParamInverse(F^.operD);
            end;
            interditInverse(kG);
         end;
         fonction: setParamInverse(F^.operand);
         fonctionGlb: setParamInverse(F^.operandGlb);
         ifThenElse,PieceWise: begin
            setParamInverse(F^.Positif);
            setParamInverse(F^.Negatif);
         end;
         else
      end;{case}
   end; // setParamInverse

   procedure CompileLoc;
   var
      i:  integer;
      gf: TgenreGrandeur;
   begin
      if expression = '' then
         raise ECompile.Create(erVide);
      depend := [];
      for i := 0 to pred(NbreGrandeurs) do
         include(depend, i);
      for i := 1 to NbreParam[genreParam] do
         include(depend, ParamToIndex(genreParam, i));
      if genreParam = paramGlb then
         for i := 1 to NbreParam[ParamNormal] do
            include(depend, ParamToIndex(ParamNormal, i));
      if ordreEqua = -1 then include(depend, cDeltat);
      Result := compileF(posErreur, longErreur, ajuste, genreParam, ordreEqua);
      if not Result then exit;
      genreFonction(gf); // vérifier gf
      if (genreC = g_euler) and (ordreEqua >= 0) then
         raise ECompile.Create(erModeleIncorrect);
      if (genreC in [g_fonction, g_equation]) and (indexX <> grandeurInconnue) then
         case genreParam of
            ParamGlb: if grandeurs[indexX].genreG = variable then
                  indexX := grandeurInconnue;
            ParamNormal: if grandeurs[indexX].genreG <> variable then
                  indexX := grandeurInconnue;
         end;{case}
      if (genreC in [g_fonction, g_equation,g_euler]) and (indexX = grandeurInconnue) then
         case genreParam of
            ParamGlb: begin
               for i := 0 to pred(NbreGrandeurs) do
                  if (i in depend) and
                     (i <> indexY) and
                     (grandeurs[i].genreG = constante) then begin
                     indexX := i;
                     break;
                  end;
               if indexX = grandeurInconnue then
                  for i := 1 to NbreParam[ParamNormal] do
                     if (ParamToIndex(ParamNormal, i) in depend) then begin
                        indexX := ParamToIndex(ParamNormal, i);
                        break;
                     end;
            end;
            ParamNormal: begin
               for i := 0 to pred(NbreGrandeurs) do
                  if (i in depend) and (i <> indexY) and
                     (grandeurs[i].genreG = variable) then begin
                     indexX := i;
                     break;
                  end;
               if indexX = grandeurInconnue then
                  for i := 0 to pred(NbreGrandeurs) do
                     if (grandeurs[i].genreG = variable) and (i <> indexY) then
                     begin
                        indexX := i;
                        break;
                     end;
            end;
         end;
      case genreC of
         g_fonction: begin
            implicite := depend <= [indexX];
            if not (indexX in depend) then
               for i := 0 to pred(NbreGrandeurs) do
                  if (i in depend) and
                     (grandeurs[i].genreG = variable) and
                     (grandeurs[i].fonct.genreC = g_fonction) and
                     (indexX in grandeurs[i].fonct.depend) then begin
                     { remplacer grandeur G par fonction g(x) }
                     ChangementVariable(grandeurs[i]);
                  end;
            if indexX = 0
               then indexYp := indexDerivee(addrY, grandeurs[0], False, False)
               else indexYp := grandeurInconnue;
         end;
         g_equation: implicite := True;
         g_Euler: if (ordreEqua = -1) then
               implicite := False;
         g_diff1: implicite := depend <= [indexX, indexY];
         g_diff2: begin
            indexYp := addrYp.indexG;
            implicite := depend <= [indexX, indexY, indexYp];
         end;
         else
            raise ECompile.Create(erModeleIncorrect);
      end;
      if (genreParam <> paramNormal) and (genreC <> g_fonction) then
         raise ECompile.Create(erModeleGlb);
      if (genreParam=paramNormal) and
         (genreC=g_fonction) and
         (ordreEqua >= 0) then begin
            SetParamInverse(calcul);
            SetSinusoide;
      end;
   end; // CompileLoc Modele

var
   posEgal, posExp: word;
   i, idebut: integer;
   nomLu: string;
begin // compileM
   codeErreurC := '';
   try
      posEgal := Pos(':=', ligneCourante);
      posExp  := posEgal + 2;
      ajuste  := PosEgal = 0;
      if ajuste then begin
         posEgal := Pos('=', ligneCourante);
         posExp  := posEgal + 1;
      end;
      if posEgal = 0 then
         raise ECompile.Create(erEgalAbsent);
      indexX := grandeurInconnue;
      indexYp := grandeurInconnue;
      genreC := g_fonction;
      i := 0;
      repeat
         Inc(i)
      until charInSet(ligneCourante[i],['(', '=', ':', '''', '"', '[']);
      nomLu  := copy(ligneCourante, 1, pred(i));
      indexY := indexNom(nomLu);
      if (ligneCourante[i] = '''') and
         (indexY = grandeurInconnue) then begin // essayer nom de type y'
         Inc(i);
         nomLu  := nomLu + '''';
         indexY := indexNom(nomLu);
      end;
      if (ligneCourante[i] = '"') and
         (indexY = grandeurInconnue) then begin
         // essayer nom de type y" }
         Inc(i);
         nomLu  := nomLu + '"';
         indexY := indexNom(nomLu);
      end;
      ordreEqua := 0;
      if (ligneCourante[i] = '[') and
         (copy(ligneCourante, i, 3) = '[i]') then begin // Euler
         Inc(i);
         ordreEqua := -1;
         Inc(i, 3);
      end;
      if indexY = grandeurInconnue then begin
         posErreur  := 0;
         LongErreur := length(nomLu);
         raise ECompile.Create(erVarInconnue);
      end;
      addrY  := Grandeurs[indexY];
      iDebut := 1;
      while i < posEgal do begin
         if ligneCourante[i] = '(' then begin
            iDebut := succ(i);
            repeat
               Inc(i)
            until (ligneCourante[i] = ')') or (i = posEgal);
            nomLu  := copy(ligneCourante, iDebut, i - iDebut);
            indexX := indexNom(NomLu);
            if indexX = grandeurInconnue then begin
               posErreur  := iDebut;
               LongErreur := length(nomLu);
               raise ECompile.Create(erVarInconnue);
            end;
         end;
         if ligneCourante[i] = '''' then
            Inc(ordreEqua);
         if ligneCourante[i] = '"' then
            Inc(ordreEqua, 2);
         Inc(i);
      end;
      if ordreEqua > 2 then begin
         posErreur  := 0;
         LongErreur := posEgal;
         raise ECompile.Create(erDiff2);
      end;
      if ordreEqua > 0 then begin
         if ((indexX <> 0) and
           (indexX <> grandeurInconnue)) or (indexY = 0) then begin
            posErreur  := iDebut;
            LongErreur := length(nomLu);
            raise ECompile.Create(erDiff0);
         end;
         indexX := 0;
      end;
      expression := copy(ligneCourante, posExp, length(ligneCourante));
      enTete := copy(ligneCourante, 1, pred(posEgal));
      compileLoc;
      posErreur := posErreur + posEgal;
      setDependF;
   except
      on E: Ecompile do begin
         enTete := '';
         codeErreurC := E.message;
         Result := False;
      end;
   end;
end; // Tmodele.CompileM

function tgrandeur.OrdreDeGrandeur: double;
var
   i, j: integer;
   total: double;
   p: TcodePage;
begin
   i := 0;
   Result := Nan;
   while (i < NbreGrandeurs) and isNan(Result) do begin
      if uniteEgale(grandeurs[i]) then
         case grandeurs[i].genreG of
            Variable: with pages[pageCourante] do begin
                  total := 0;
                  for j := 0 to pred(nmes) do
                     total := total + abs(valeurVar[i, j]);
                  Result := total / nmes;
               end;
            Constante: begin
               total := 0;
               for p := 1 to NbrePages do
                  total := total + abs(pages[p].valeurConst[i]);
               Result := total / NbrePages;
            end;
            ConstanteGlb: Result := grandeurs[i].valeurCourante;
         end;{case genreG}
      Inc(i);
   end;
   if isNan(Result) then
      Result := 1;
end;

function tgrandeur.CompileG(var posErreur, LongErreur: integer;
   ordreEqua: integer): boolean;
var
   i: integer;
   positionUnite: integer;

   procedure RecupereOld;
   var
      i: integer;
      continuer: boolean;
   begin
      i := debutOldGrandeurs;
      continuer := i <> finOldGrandeurs;
      while continuer do
         if nom = oldGrandeurs[i].nom then begin
            incertCalcA.expression := oldGrandeurs[i].incertCalcA.expression;
            incertCalcB.expression := oldGrandeurs[i].incertCalcB.expression;
            if incertCalcA.expression = '' then
               incertCourante := oldGrandeurs[i].incertCourante;
            genreMecanique := oldGrandeurs[i].genreMecanique;
            isCurseur := oldGrandeurs[i].isCurseur;
            optionCurseur := oldGrandeurs[i].optionCurseur;
            optionCurseurF := oldGrandeurs[i].optionCurseurF;
            nomVarPosition := oldGrandeurs[i].nomVarPosition;
            if not uniteDonnee and (fonct.genreC=g_experimentale)
               then recopieUnite(oldGrandeurs[i]);
            continuer := False;
            indexOld := i;
         end
         else begin
            Inc(i);
            if i>=maxGrandeurs then i := 0; // stockage en rouleau
            continuer := i <> finOldGrandeurs;
         end;
   end;

var
   indexDer, indexDer2: integer;
   posC : integer; // position commentaire
   nomU : string;
begin // compileG
   fonct.depend := []; (**)
   indexOld := 0;
   for i := 0 to pred(NbreGrandeurs) do
       include(fonct.depend, i);
   include(fonct.depend, cPage);
   fonct.addrY := self;
   Result := fonct.compileF(posErreur, longErreur, False, paramNormal, ordreEqua);
   correct := Result;
   if not correct then exit;
   fonct.genreFonction(genreG);
   if (fonct.genreC in [g_PythonVar,g_PythonConst]) then fonct.calcul.varx := self;
   if fonct.genreC=g_euler then begin
         indexDer := indexNom(nom+'[0]');
         if indexDer=grandeurInconnue
            then varInit := nil
            else varInit := grandeurs[indexDer];
         include(fonct.depend, indexDer);
   end;
   positionUnite := pos('_', fonct.expression);
   if positionUnite > 0 then begin
      NomU := copy(fonct.expression, succ(
         positionUnite), length(fonct.expression) - positionUnite);
      posC := pos('''', nomU);
      if posC>0 then nomU := copy(nomU,1,posC-1);
      posC := pos(';', nomU);
      if posC>0 then nomU := copy(nomU,1,posC-1);
      nomUnite := nomU;
      if fonct.genreC in [g_diff1, g_diff2] then begin
         indexDer := IndexDerivee(self, grandeurs[0], False, False);
         if indexDer <> grandeurInconnue then begin
            grandeurs[indexDer].AdUnite('-', self, grandeurs[0]);
            if fonct.genreC = g_diff2 then begin
               indexDer2 :=
                  IndexDerivee(grandeurs[indexDer], grandeurs[0], False, False);
               if indexDer <> grandeurInconnue then
                  grandeurs[indexDer2].AdUnite('-', grandeurs[indexDer], grandeurs[0]);
            end;
         end;
      end;
   end
   else uniteDonnee := false;
   RecupereOld;
end; // CompileG 

function tgrandeur.CompileIncertitude : boolean;
var
   posErreur, LongErreur: integer;
   j,code: integer;
begin
   incertCalcA.depend := [];
   incertCalcB.depend := [];
   code := indexNomVariab(nom);
   for j := 0 to code+1 do begin
    // +1 : on permet récupération de la colonne suivante comme incertitude
      include(incertCalcA.depend, j);
      include(incertCalcB.depend, j);
   end;
   for j := 0 to pred(NbreConst) do begin
      include(incertCalcA.depend, indexConst[j]);
      include(incertCalcB.depend, indexConst[j]);
   end;
   incertCalcA.addrY := self;
   incertCalcB.addrY := self;
   result := true;
   if incertCalcA.expression <> ''
   then result := result and incertCalcA.compileF(posErreur, longErreur, False, paramNormal, 0)
   else libere(incertCalcA.calcul);
   if incertCalcB.expression <> ''
   then result := result and incertCalcB.compileF(posErreur, longErreur, False, paramNormal, 0)
   else libere(incertCalcB.calcul);
end;

procedure ResetEnTete;
var
   i: integer;
   S: tSauvegarde;
begin
   NomGrandeurTri := '';
   indexTri := 0;
   while NbrePages>0 do begin
       pages[NbrePages].Free;
       dec(NbrePages);
   end;
   PageCourante := 0;
   for i := 0 to maxGrandeurs do
       if oldGrandeurs[i]<>nil then begin
          oldGrandeurs[i].Free;
          oldGrandeurs[i] := nil;
       end;
   for i := 0 to pred(NbreGrandeurs) do
      grandeurs[i].Free;
   NbreGrandeurs := 0;
   VideVariable;
   TexteModele.Clear;
   VideParam;
   NbreModele := 0;
   NbreFonctionSuper := 0;
   NbreFonctionSuperGlb := 0;
   grandeurs[cFrequence].nom := 'f';
   while (PileSauvegarde.Count > 0) do begin
      S := PileSauvegarde.pop;
      S.libereS;
      S.Free;
   end;
   ListeConstAff.Clear;
end;

procedure InitEnTete;
var
   j: integer;
   g: TgenreGrandeur;
begin
   GenJ;
   Randomize;
   for g := paramGlb to paramDiff2 do
      for j := 1 to maxParametres do begin
          Parametres[g, j] := tgrandeur.Create;
          Parametres[g, j].Init('', '', '', g);
          Parametres[g, j].indexG := j+zeroParam[g];
      end;
   for j := 1 to maxIntervalles do begin
      fonctionTheorique[j]  := Tmodele.Create;
      fonctionSuperposee[j] := Tmodele.Create;
      fonctionSuperposeeGlb[j] := Tmodele.Create;
      fonctionSuperposeeGlb[j].genreParam := paramGlb;
      fonctionTheoriqueGlb[j] := Tmodele.Create;
      fonctionTheoriqueGlb[j].genreParam := paramGlb;
   end;
   NbrePages := 0;
   NbreHarmoniqueAff := 0;
   HarmoniqueAff := False;
   ListeConstAff := TStringList.Create;
   TexteModele := TStringList.Create;
   ResetEnTete;
   FinOldGrandeurs := 0;
   DebutOldGrandeurs := 0;
   for j := 0 to MaxGrandeurs do
       OldGrandeurs[j] := nil;
   ListeBoucle := TlisteBoucle.Create;
   Pages[0] := Tpage.Create;
   Pages[0].numero := 0;
end; // InitEnTete

procedure DetruitEnTete; far;
var
   j: integer;
   g: TgenreGrandeur;
begin
   for j := 1 to maxIntervalles do begin
      fonctionTheorique[j].Free;
      fonctionSuperposee[j].Free;
      fonctionSuperposeeGlb[j].Free;
      fonctionTheoriqueGlb[j].Free;
   end;
//   ResetEnTete fait par forme principale 
   Dispose(PointeurJ);
   Dispose(PointeurZero);
   Dispose(PointeurUn);
   Dispose(PointeurDeux);
   Dispose(PointeurPi);
   for g := paramGlb to paramDiff2 do
      for j := 1 to maxParametres do
         Parametres[g, j].Free;
   grandeurs[cNombre].Free;
   for j := cFrequence to MaxMaxGrandeurs do begin
      Grandeurs[j].valeur := nil;
      Grandeurs[j].valIncert := nil;
      Grandeurs[j].Free;
   end;
   PileSauvegarde.Free;
   ListeConstAff.Free;
   ListeBoucle.Free;
   Pages[0].Free;
end; // DetruitEnTete

procedure DebutCompileG;
var
   i, N: integer;
begin
   bruitPresent := False;
   ListeBoucle.Clear;
   PrevenirFonctionDeParam := False;
   DebutOldGrandeurs := FinOldGrandeurs;
   N := 0;
   for i := 0 to pred(NbreGrandeurs) do begin
      if grandeurs[i].fonct.genreC in [g_experimentale, g_texte] then begin
         if i <> N then
            TransfereVariabE(i, N);
         Inc(N);
//         if (pos('mol',grandeurs[i].nomUnite)>0) then uniteSIglb := false; // chimie !
      end; // grandeurs expérimentales au début
   end;
   for i := pred(NbreGrandeurs) downto N do
      libereGrandeurE(i);
   if LogSimulation then begin
      Grandeurs[cDeltat].nom := NomCoeffSimul;
      Grandeurs[cDeltat].nomUnite := '';
      Grandeurs[cDeltat].fonct.expression := 'Coeff. multiplicateur';
   end
   else if (N > 0) then begin
      Grandeurs[cDeltat].nom := deltaMaj + Grandeurs[0].nom;
      Grandeurs[cDeltat].nomUnite := Grandeurs[0].nomUnite;
      Grandeurs[cDeltat].fonct.expression := 'Intervalle de temps';
   end;
   NbreGrandeurs := N;
end;

procedure FinCompileG;
var
   i, j, p: integer;
   withRadian,withDegre : boolean;
   indexPython : integer;
begin
   withRadian := false;
   withDegre := false;
   indexPython := 0;
   for i := 0 to pred(NbreGrandeurs) do
      with grandeurs[i] do begin
         indexG := i;
         if uniteDonnee
            then begin
                 withRadian := withRadian or uniteEgale(uniteToleree[indexRadian]);
                 withDegre := withDegre or uniteEgale(uniteToleree[indexDegre]);
            end
            else SetUnite;
         if (genreG <> variable) then
            for p := 1 to NbrePages do
               with pages[p] do LibereGrandeurP(i);
// à la création on ne connait pas le type et donc valeurVar est créée par défaut
         if fonct.genreC = g_equation then begin
            genreG := constanteGlb;
            for j := 0 to pred(NbreConst) do
               if indexConst[j] in fonct.depend then
                  genreG := constante;
            for j := 0 to pred(NbreVariab) do
               if (indexVariab[j] in fonct.depend) and
                  (indexVariab[j] <> i) then
                  genreG := variable;
         end;
         if fonct.genreC = g_PythonConst then begin
            genreG := constante;
            for p := 1 to NbrePages do
                pages[p].ValeurConst[indexG] := pages[p].oldValeurConst[indexOld];
         end;
         if fonct.genreC = g_PythonVar then begin
            if indexOld=0 then indexOld := indexPython;
            for p := 1 to NbrePages do pages[p].recupereVarP(indexOld,indexG);
            inc(indexPython);
         end;
         if fonct.genreC = g_fonction then begin
            DeriveeIncert(fonct, incertCalcA.calcul);
         end;
         fonct.setDependF;(***)
      end;
    if uniteSIGlb then for i := 0 to pred(NbreGrandeurs) do
      with grandeurs[i] do
      if (genreG = constanteGlb) and
         (puissance <> 0) then begin
            fonct.calcul :=
               genOperateur('*', genNombre(dix(puissance)),
               fonct.calcul);
            uniteDonnee := False;
            uniteImposee := False;
            puissance := 0;
            coeffSI  := 1;
            nomUnite := nomAff(0);
      end;
   ConstruireIndex;
   DefinitGrandeurFrequence;
   if withRadian and not withDegre then angleEnDegre := false;
   if withDegre and not withRadian then angleEnDegre := true;
   ReCalculE;
end; // finCompileG

function IndexToParam(Agenre: TgenreGrandeur; index: TcodeGrandeur): TcodeGrandeur;
begin
   if (index <= zeroParam[agenre]) or
      (index > (zeroParam[agenre] + MaxParametres))
        then IndexToParam := grandeurInconnue
        else IndexToParam := index - zeroParam[agenre];
end;

function ParamToIndex(Agenre: TgenreGrandeur; code: TcodeGrandeur): TcodeGrandeur;
begin
   Result := code + zeroParam[Agenre];
   Grandeurs[Result] := parametres[Agenre, code];
end;

procedure DefinitGrandeurFrequence;
begin
   if NbreGrandeurs > 0 then
      with grandeurs[cFrequence] do begin
         if nomGrandeurTri <> '' then begin
            indexTri := indexNomVariab(nomGrandeurTri);
            if indexTri = grandeurInconnue then begin
               indexTri := 0;
               nomGrandeurTri := '';
            end;
         end
         else indexTri := 0;
         RecopieUnite(grandeurs[indexTri]);
         uniteDonnee  := False;
         uniteImposee := False;
         InverseUnite;
      end;
end;

procedure Tpage.AffecteNbreFFT;
var
   Df: double;
   i:  integer;
begin
   DebutFFT := 0;
   FinFFT := pred(Nmes);
   NbreFFT := Puiss2Inf(succ(finFFT - debutFFT));
   PeriodeFFT := (grandeurs[0].valeur[pred(nmes)] - grandeurs[0].valeur[0]) /
      pred(Nmes) * Nmes;
   Df := 1 / periodeFFT;
   for i := 0 to pred(NbreFFT) do
      grandeurs[cFrequence].valeur[i] := i * Df;
end;

// TpileSauvegarde

function TpileSauvegarde.Peek: TSauvegarde;
begin
   Result := TSauvegarde(inherited Peek);
end;

function TpileSauvegarde.Pop: TSauvegarde;
begin
   Result := TSauvegarde(inherited Pop);
end;

procedure TpileSauvegarde.Push(Asauvegarde: TSauvegarde);
var
   S: tsauvegarde;
begin
   if Count > 8 then
   begin
      S := List[0];
      S.libereS;
      List.Delete(0);
   end;
   inherited Push(ASauvegarde);
end;

function TlisteFonction.Add(Item: Tfonction): integer;
begin
   Result := inherited Add(Item);
end;

function TlisteFonction.Get(Index: integer): Tfonction;
begin
   Result := Tfonction(inherited Get(Index));
end;

procedure TlisteFonction.Put(Index: integer; Item: Tfonction);
begin
   inherited Put(Index, Item);
end;

procedure TListeFonction.Clear;
var
   i: integer;
begin
   for i := 0 to pred(Count) do
      Items[i].Free;
   inherited Clear;
end;

function compileBoucle(const Expression: string;
   var posErreur, LongErreur: integer): boolean;

// Analyse la chaine expression et renvoie le pointeur
// Istart sur la valeur initiale de i ; Iend sur la valeur finale de i
// en cas d'erreur posErreur renvoie la position de celle-ci et codeErreur le type

var
   Aboucle: Pelement;
const
   MaxPile = 8;
type
   TIndicePile = 1..MaxPile;
var
   PilePointeur: array[TIndicePile] of Pelement;
   IndicePileCourant: 0..MaxPile;
   CaracCourant: char;
   IdentCourant: String;
   pointeurExp: word; { pointe sur le prochain caractère }
   longExp: word;

   procedure Csuivant;
// Lit le prochain caractère et l'assigne à caracCourant
// Le caracCourant est toujours extrait avant appel d'un analyseur
   begin
      if (pointeurExp <= longExp) and (Expression[pointeurExp] <> crTab) then begin
         caracCourant := Expression[pointeurExp];
         Inc(pointeurExp);
      end
      else caracCourant := #0;
   end;

   procedure IdentSuivant;

      procedure LireIdEnt;
      begin
         IdentCourant := '';
         while isCaracGrandeur(caracCourant) do begin
            if length(IdentCourant) = longNom then
               raise ECompile.Create(erTropLong);
            identCourant := identCourant + caracCourant;
            Csuivant;
         end;
      end; // LireIdEnt

      procedure LireNombre;
      begin
         IdentCourant := '';
         while charinset(caracCourant,chiffre) do begin
            IdentCourant := IdentCourant + caracCourant;
            CSuivant;
         end;
      end; // LireNombre

   begin // IdentSuivant
      while caracCourant = ' ' do
         Csuivant; // Saute les espaces
      PosErreur := pred(PointeurExp);
      if isMonoCaractere(caracCourant) then begin
         IdentCourant := caracCourant;
         Csuivant;
      end
      else if caracCourant = ':' then begin
         Csuivant;
         if caracCourant = '=' then begin
            IdentCourant := '=';
            Csuivant;
         end
         else
            raise ECompile.Create(erBoucleFor);
      end
      else if isLettre(caracCourant) then
           LireIdent
      else if charInSet(caracCourant,Chiffre) then
         LireNombre
      else if caracCourant = #0 then
         identCourant := ''
      else
         raise ECompile.Create(erCaracInterdit);
      LongErreur := PointeurExp - PosErreur - 1;
   end; // IdentSuivant

   procedure InitFonctor;
   var
      i: TIndicePile;
   begin
      codeErreurC := '';
      New(Aboucle);
      Aboucle.TypeElement := BoucleFor;
      Aboucle.VarStart := NbreGrandeurs;
      Aboucle.VarEnd := NbreGrandeurs;
      ABoucle.Istart := nil;
      ABoucle.Iend := nil;
      longExp := Length(expression);
      pointeurExp := 1;
      posErreur := 0;
      LongErreur := 0;
      indicePileCourant := 0;
      for i := 1 to MaxPile do
         PilePointeur[i] := nil;
      Csuivant;
      IdentSuivant;
   end; // InitFonctor

   function GetOperateur: char;
   begin
      if (length(identCourant)=1) and
         isMonoCaractere(identCourant[1])
            then GetOperateur := IdentCourant[1]
            else GetOperateur := #0;
   end; // GetOperateur

   procedure Empile(P: Pelement);
   begin
      if indicePileCourant = MaxPile then
         raise ECompile.Create(ErTropComplexe)
      else begin
         Inc(indicePileCourant);
         PilePointeur[indicePileCourant] := P;
      end;
   end;

   procedure AnalyseExpression; forward;

   procedure E;
// E=(.Expression.)
   begin
      if identCourant = '(' then begin
         identSuivant;
         AnalyseExpression;
         if IdentCourant = ')' then
            IdentSuivant
         else
            raise Ecompile.Create(erParF);
      end;
   end;

   procedure Depile(var P: Pelement);
   begin
      if indicePileCourant = 0 then
         raise ECompile.Create(erInterne)
      else begin
         P := PilePointeur[indicePileCourant];
         PilePointeur[indicePileCourant] := nil;
         Dec(indicePileCourant);
      end;
   end;

   procedure AnalyseElement;
// Element = E/nombre/grandeur
   var
      valeur: double;
   begin
      if length(identCourant)=0 then
         raise ECompile.Create(erExpressionVide)
      else if (IdentCourant = grandeurs[cNombre].nom) then begin
         Empile(GenVar(grandeurs[cNombre]));
         identSuivant;
      end
      else if charinset(IdentCourant[1],ChiffreEtc) then begin
         try
            valeur := StrToFloatWin(IdentCourant);
            Empile(GenNombre(valeur));
            IdentSuivant;
         except
            raise ECompile.Create(erNombre);
         end;
      end
      else
         E;
   end; // analyseElement

   procedure AnalyseExpression;
 // Expression = [+ ou - ou rien].Terme.[+ ou - ].terme
   var
      C: char;
      T1, T2: Pelement;
   begin
      C := GetOperateur;
      if charinset(C,['+', '-'])
         then IdentSuivant
         else C := '+';
      AnalyseElement;
      if C <> '+' then begin
         depile(T1);
         if T1.typeElement=nombre
            then begin
                empile(genNombre(-T1.valeur));
                libere(T1);
            end
            else empile(GenFonction(oppose, T1));
      end;
      C := GetOperateur;
      while charinset(C,['+', '-']) do begin
         IdentSuivant;
         AnalyseElement;
         depile(T2);
         depile(T1);
         Empile(GenOperateur(C, T1, T2));
         C := GetOperateur;
      end; {while}
   end; // AnalyseExpression

var
   i: TIndicePile;
begin // CompileBoucle
   Result := True;
   try
      InitFonctor;
      // Found the FOR keyword
      identSuivant;
      // It should be an identifier and the variable must not exist
      if not nomCorrect(identCourant, grandeurInconnue) then
         raise Ecompile.Create(codeErreurC);
      ListeBoucle.Add(Aboucle);
      if identCourant = 'i'
      then Aboucle.PvariabI := grandeurs[cIndice]
      else begin
         Aboucle.PvariabI := tgrandeur.Create;
         Aboucle.PvariabI.Init(identCourant, '', '', indiceBoucle);
         ajouteGrandeurE(Aboucle.PvariabI);
      end;
      identSuivant;
      // Expecting an assignment statement
      if identCourant <> '=' then
         raise ECompile.Create(erBoucleFor);
      identSuivant;
      AnalyseExpression;
      // Calculate expression of token from current position
      depile(Aboucle.IStart);
      // See if we are going up
      if not AnsiSameText(identCourant, 'TO') then
         raise ECompile.Create(erBoucleFor);
      identSuivant;
      // Get the result of the calculation
      AnalyseExpression;
      depile(Aboucle.IEnd);
      if not AnsiSameText(identCourant, 'DO') then
         raise ECompile.Create(erBoucleFor);
      identSuivant;
      if not (AnsiSameText(identCourant, 'BEGIN') or (identCourant = '')) then
         raise ECompile.Create(erBoucleFor);
      BoucleEnCours := True;
   except
      on E: Ecompile do begin
         for i := 1 to MaxPile do
            Libere(pilePointeur[i]);
         libere(Aboucle);
         Result := False;
         CodeErreurC := E.Message;
      end;
   end;
end; // CompileBoucle

function compileFinBoucle: boolean;
begin
   ListeBoucle[ListeBoucle.Count - 1].VarEnd := NbreGrandeurs;
   BoucleEnCours := False;
   Result := True;
end;

function TlisteBoucle.Add(Item: Pelement): integer;
begin
   Result := inherited Add(Item);
end;

function TlisteBoucle.Get(Index: integer): Pelement;
begin
   Result := Pelement(inherited Get(Index));
end;

procedure TlisteBoucle.Put(Index: integer; Item: Pelement);
begin
   inherited Put(Index, Item);
end;

(*
function TlisteBoucle.Remove(Item: Pelement): integer;
begin
   Result := inherited Remove(Item);
   libere(Item);
end;
*)

procedure TListeBoucle.Clear;
var
   i: integer;
   z: Pelement;
begin
   for i := 0 to pred(Count) do begin
      z := Items[i];
      libere(z);
   end;
   BoucleEnCours := False;
   inherited Clear;
end;

procedure Dichotomie(p: TcodePage; codeX: TcodeGrandeur; f1, f2: Pelement;
   Xmin, Xmax: double; var Yi, Xi: double);

   function deltaY(X: double): double;
   var
      Y: double;
   begin
      grandeurs[codeX].valeurCourante := X;
      Y := calcule(f1);
      deltaY := Y - calcule(f2);
   end;

const
   imax = 16;
var
   dYmin, dYmax, dYmilieu: double;
   i: integer;
begin with pages[p] do begin
      try
         Yi := Nan;
         Xi := Nan;
         AffecteConstParam(false);
         dYmin := deltaY(Xmin);
         dYmax := deltaY(Xmax);
         if (dYmin * dYmax) > 0 then
            exit;
         i := 1;
         while ((dYmin * dYmax) < 0) and (i < imax) do begin
            Xi := (Xmax + Xmin) / 2;
            dYmilieu := deltaY(Xi);
            if dYmilieu * dYmax < 0 then begin
               dYmin := dYmilieu;
               Xmin  := Xi;
            end
            else begin
               dYmax := dYmilieu;
               Xmax  := Xi;
            end;
            Inc(i);
         end;
         grandeurs[codeX].valeurCourante := Xi;
         Yi := calcule(f1);
      except
         Yi := Nan;
         Xi := Nan;
      end;
   end;
end; // Dichotomie

procedure ChercheUniteParametre;
var
   i: integer;
   ULoc: Tunite;
   m: TcodeIntervalle;
   exclure: set of TcodeParam;

   procedure Ajoute(Agrandeur: Tgrandeur);
   var
      j: TcodeGrandeur;
   begin
      if Agrandeur <> nil then begin
         j := Agrandeur.indexG;
         if (j > parametre0) and (j <= (parametre0 + maxParametres)) then begin
            j := IndexToParam(paramNormal, j);
            include(exclure, j); // paramètre initial
         end;
      end;
   end;

   procedure Cherche;
   var
      m: TcodeIntervalle;
      i: integer;
   begin
      for m := 1 to NbreModele do
         with fonctionTheorique[m] do begin
            try
               ULoc.RecopieUnite(grandeurs[indexY]);
               if genreC in [g_diff1, g_diff2] then begin
                  ULoc.MoinsUnite(grandeurs[indexX]);
                  if genreC = g_diff2 then
                     ULoc.MoinsUnite(grandeurs[indexX]);
               end;
               AffecteUnite(calcul, ULoc);
            except
               on EUniteError do begin
                  for i := 1 to NbreParam[ParamNormal] do
                     if ParamToIndex(ParamNormal, i) in depend then
                        Parametres[ParamNormal, i].correct := False;
               end;
            end;
         end;
   end;

var
   refaire: boolean;
   uniteY, uniteX: Tunite;
   k: TcodeGrandeur;
begin  // ChercheUniteParametre
   exclure := [];
   if FonctionTheorique[1].genreC in [g_diff1, g_diff2] then
      for m := 1 to NbreModele do begin
         ajoute(FonctionTheorique[m].calcul^.varx);
         if FonctionTheorique[1].genreC = g_diff2 then
            ajoute(FonctionTheorique[m].calcul^.vary);
      end;
   for i := 1 to NbreParam[paramNormal] do
      if not (i in exclure) then
         with Parametres[paramNormal, i] do begin
            nomUnite := '';
            Correct  := True;
            Adaptable := True;
            UniteDonnee := False;
         end;
   ULoc := Tunite.Create;
   try
   Cherche;
   Refaire := False;
   for i := 1 to NbreParam[ParamNormal] do
      Refaire := Refaire or Parametres[paramNormal, i].Adaptable;
   if refaire then Cherche;
// Pour résoudre les pb du type L/R avec L et R paramètres,
// l'unité de R étant déterminée par ailleurs
   finally
      ULoc.Free;
   end;
   for i := 1 to NbreParam[ParamNormal] do
      with Parametres[ParamNormal, i] do begin
         if ParamInverse[i] then inverseUnite;
         imposeNomUnite(NomAff(0));
      end;
   uniteY := Tunite.Create;
   uniteX := Tunite.Create;
   try
   for m := 1 to NbreModele do begin
      uniteX.recopieUnite(grandeurs[FonctionTheorique[m].indexX]);
      uniteY.recopieUnite(grandeurs[FonctionTheorique[m].indexY]);
      for i := 1 to NbreParam[ParamNormal] do begin
         k := ParamToIndex(paramNormal, i);
         if k in FonctionTheorique[m].depend then
            Parametres[ParamNormal, i].verifTaux(uniteY, uniteX);
      end;
   end;
   finally
     uniteY.Free;
     uniteX.Free;
   end;
end; // ChercheUniteParametre

procedure ChercheUniteParametreGlb;
var
   i: integer;
   ULoc: Tunite;
   m: TcodeIntervalle;
   exclure: set of TcodeParam;

   procedure Cherche;
   var
      m: TcodeIntervalle;
      i: integer;
   begin
      for m := 1 to NbreModeleGlb do
         with fonctionTheoriqueGlb[m] do begin
            try
               ULoc.RecopieUnite(grandeurs[indexY]);
               AffecteUnite(calcul, ULoc);
            except
               on EUniteError do begin
                  for i := 1 to NbreParam[ParamGlb] do
                     if ParamToIndex(ParamGlb, i) in depend then
                        Parametres[ParamGlb, i].correct := False;
               end;
            end;
         end;
   end;

var
   refaire: boolean;
   uniteY, uniteX: Tunite;
   k: TcodeGrandeur;
begin  // ChercheUniteParametreGlb
   exclure := [];
   for i := 1 to NbreParam[paramGlb] do
      if not (i in exclure) then
         with Parametres[paramGlb, i] do begin
            nomUnite := '';
            Correct  := True;
            Adaptable := True;
            UniteDonnee := False;
         end;
   ULoc := Tunite.Create;
   try
   Cherche;
   Refaire := False;
   for i := 1 to NbreParam[ParamGlb] do
      Refaire := Refaire or Parametres[paramGlb, i].Adaptable;
   if refaire then Cherche;
// Pour résoudre les pb du type L/R avec L et R paramètres,
// l'unité de R étant déterminée par ailleurs
   finally
      ULoc.Free;
   end;
   for i := 1 to NbreParam[ParamGlb] do
      with Parametres[ParamGlb, i] do begin
         puissance := 0;
         coeffSI := 1;
         imposeNomUnite(NomAff(0));
      end;
   uniteY := Tunite.Create;
   uniteX := Tunite.Create;
   try
   for m := 1 to NbreModeleGlb do begin
      uniteX.recopieUnite(grandeurs[FonctionTheoriqueGlb[m].indexX]);
      uniteY.recopieUnite(grandeurs[FonctionTheoriqueGlb[m].indexY]);
      for i := 1 to NbreParam[ParamGlb] do begin
         k := ParamToIndex(paramGlb, i);
         if k in FonctionTheoriqueGlb[m].depend then
            Parametres[ParamGlb, i].verifTaux(uniteY, uniteX);
      end;
   end;
   finally;
      uniteY.Free;
      uniteX.Free;
   end;
end; // ChercheUniteParametreGlb

procedure GenereModeleParametrique(X, Y: Tvecteur; miniT, maxiT: double;
   var PointFinal: integer);
var
   deltaT: double;
   T: Tvecteur;

   procedure Trier;
// Tri Shell Meyer-Baudoin p 456 de x et y selon t
   var
      increment: integer;
      cle, sauveY, sauveX: double;
      i, k, j: integer;
   begin
      increment := 1;
      while (increment < (PointFinal div 3)) do
         increment := succ(3 * increment);
      repeat
         for k := 0 to pred(increment) do begin
            i := increment + k;
            while (i <= PointFinal) do begin
               sauveY := y[i];
               sauveX := x[i];
               cle := t[i];
               j := i - increment;
               while (j >= 0) and (t[j] > cle) do begin
                  t[j + increment] := t[j];
                  y[j + increment] := y[j];
                  x[j + increment] := x[j];
                  Dec(j, increment);
               end;
               t[j + increment] := cle;
               y[j + increment] := sauveY;
               x[j + increment] := sauveX;
               Inc(i, increment);
            end;
         end;
         increment := increment div 3;
      until increment = 0;
   end; // trier

   procedure CalculLoc(debut, fin: integer; const Min, Max: double);
   var
      i: integer;
   begin
      T[debut] := Min;
      for i := succ(debut) to fin do
         T[i] := T[pred(i)] + deltaT;
      for i := debut to fin do begin
         Grandeurs[0].valeurCourante := T[i];
         try
            X[i] := calcule(fonctionTheorique[1].calcul);
            Y[i] := calcule(fonctionTheorique[2].calcul);
         except
            Y[i] := Nan;
            X[i] := Nan;
         end;
      end;{i}
   end; // CalculLoc

// Calcul de fonction à pas variable pour tracé de modèle
const
   NbreMin = 200;
   NbreInter = 18; // Nombre de points par intervalle
   NbreMax = NbreMin + (NbreInter) * (NbreMin div 2); // <= 2047
var
   i, j: integer;
   Ymin, Ymax, YsecondeMin: double;
   Xmin, Xmax, XsecondeMin: double;
begin
   setLength(T, 2048);
   grandeurs[cIndice].valeurCourante := 0;
   deltaT := (MaxiT - MiniT) / NbreMin;
   CalculLoc(0, NbreMin, MiniT - deltaT, MaxiT);
   Ymin := y[0];
   Xmin := x[0];
   Ymax := y[0];
   Xmax := x[0];
   for i := 1 to NbreMin do begin
      if y[i] > ymax then
         ymax := y[i]
      else if y[i] < ymin then
         ymin := y[i];
      if x[i] > xmax then
         xmax := x[i]
      else if x[i] < xmin then
         xmin := x[i];
   end;
   YsecondeMin := (Ymax - Ymin) / 128;
   XsecondeMin := (Xmax - Xmin) / 128;
// dX*dX*y"(x)<4 pixels sachant que ymax-ymin=512 pixels et dX=2 pixels
   PointFinal := succ(NbreMin);
   i := 1;
   deltaT := (MaxiT - MiniT) / NbreMax;
   repeat
      if not isNan(y[i]) and not isNan(x[i]) and
         ((abs(y[succ(i)] + y[pred(i)] - 2 * y[i]) > YsecondeMin) or
         (abs(x[succ(i)] + x[pred(i)] - 2 * x[i]) > XsecondeMin)) then begin
         CalculLoc(PointFinal, PointFinal + pred(NbreInter),
            T[pred(i)] + deltaT, T[succ(i)] - deltaT);
// + deltax évite de recalculer les points i-1 i+1,
// i évité par nombre de points pair dans l'intervalle
         Inc(PointFinal, NbreInter);
         Inc(i, 2);
      end
      else
         Inc(i)
   until i >= NbreMin;
   Dec(PointFinal);
   i := 0;
   repeat // ôte SansSignif
      if isNan(y[i]) or isNan(x[i]) then begin
         Dec(PointFinal);
         for j := i to pointFinal do begin
            y[j] := y[succ(j)];
            x[j] := x[succ(j)];
            t[j] := t[succ(j)];
         end;
      end
      else
         Inc(i)
   until i = PointFinal;
   Trier; // classe les points ajoutés
   T := nil;
end; // GenereModeleParametrique

procedure Tmodele.CalculResidu(mC : integer);
var j, nbreR, i : integer;
begin with pages[pageCourante] do begin
      NbreR  := succ(fin[mC] - debut[mC]);
      residuStat.setValeur(NbreR,NbreParamModele);
      if not residuStat.statOK then exit;
      i := 0;
      residuStat.avecIncert := grandeurs[indexY].incertDefinie;
      for j := debut[mC] to fin[mC] do begin
         residuStat.residus[i] := valeurVar[indexY, j]-valeurTheorique[mC, j];
         residuStat.X[i] := valeurVar[indexX, j];
         if residuStat.avecIncert
            then residuStat.incertitudes[i] := incertVar[indexY, j];
         inc(i);
      end;
      residuStat.calcul;
// TODO autocorrélation des résidus
   end;
end;

function TGrandeur.incertDefinie : boolean;
var j,i,jmax : integer;
    x : double;
begin
    i := indexG;
    result := (incertCalcA.expression<>'') or (incertCalcB.expression<>'');
    if result then exit;
    case fonct.genreC of
        g_experimentale : begin
            case genreG of
                variable : begin
                if pages[pageCourante].incertVar[i]<>nil
                then begin
                jmax := pred(pages[pageCourante].nmes);
                if jmax>NbreIncertMax then jmax := NbreIncertMax;
                result := true;
                for j := 0 to jmax do begin
                    x := pages[pageCourante].incertVar[i,j];
                    if isNan(x) then begin
                        result := false;
                        break;
                    end;
                end; // for j
                end;
                end;// variable
                constante : begin
                   result := true;
                   for j := 1 to nbrePages do if pages[j].active then
                      if isNan(pages[j].incertConst[i]) then begin
                          result := false;
                          break;
                      end;
                end;// constante
                constanteGlb : result := not isNan(incertCourante);
                paramNormal,paramGlb : result := true;
            end; //case genreG
       end; // experimantale
       g_fonction,g_derivee,g_deriveeSeconde : begin
           result := true;
           for i in fonct.depend do begin
               if (indexG in grandeurs[i].fonct.depend) // bouclage récursif à éviter !
                  or not(grandeurs[i].IncertDefinie) then begin
                  result := false;
                  break;
               end;
           end;
       end; // fonction
       else result := false;
    end;
end;

function TGrandeur.incertCalculee : boolean;
begin
    result := (incertCalcA.expression<>'') or (incertCalcB.expression<>'');
end;

function TModele.chi2Permis : boolean;

procedure forceIncertNulle(i : TcodeGrandeur);
var j : integer;
begin
            case grandeurs[i].genreG of
                variable : if pages[pageCourante].incertVar[i]<>nil
                then
                for j := 0 to pred(pages[pageCourante].nmes) do
                    pages[pageCourante].incertVar[i,j] := 0;
                constante : begin
                   for j := 1 to nbrePages do
                       pages[j].incertConst[i] := 0;
                end;
            end; //case genreG
end;

var i : integer;
begin
    result := grandeurs[indexY].IncertDefinie;
    if not result then exit;    // incertitude sur Y doit être définie
    for i in depend do begin
        if i<=nbreGrandeurs then begin
           result := grandeurs[i].incertDefinie;
           if not result and
             (grandeurs[i].fonct.genreC=g_experimentale) and
             (grandeurs[i].incertCalcA.expression='') and
             (grandeurs[i].incertCalcB.expression='') then begin
               forceIncertNulle(i);
               result := true; // sur X on permet incertitude non définie => nulle
           end;
           if not result then exit;
        end;
    end;
end;

function VerifCreneau(var expression : string) : boolean;
// modification de syntaxe d'où transformation de l'ancienne en nouvelle
// creneau avec trois param ; bruit avec un seul paramètre
var posPar,Virgule,posC,nbre : integer;
    expU : string;
    isNoise : boolean;
    premierParam : string;
begin
    result := false;
    if NbreVariab<1 then exit;
    isNoise := false;
    expU := upperCase(expression);
    posPar := pos('CRENEAU(',expU);
    if posPar=0
       then begin
          posPar := pos('TRIANGLE(',expU);
          if posPar>0 then posPar := posPar + length('TRIANGLE(');
       end
       else posPar := posPar + length('CRENEAU(');
    if posPar=0 then begin
         posPar := pos('BRUIT(',expU);
         if posPar>0 then begin
            delete(expU,posPar,length('BRUIT'));
            Insert('NOISE',expU,posPar);
            delete(expression,posPar,length('BRUIT'));
            Insert('Noise',expression,posPar);
            result := true;
            posPar := 0;
         end;
    end;
    if posPar=0 then begin
         posPar := pos('NOISE(',expU);
         isNoise := posPar>0;
         if isNoise then posPar := posPar + length('NOISE(');
    end;
    if isNoise then begin // fonction d'une variable donc pas de virgule
       Virgule := 0;
       posC := posPar;
       while (posC<length(expression)) and
             (expression[posC]<>')') and
             (Virgule=0) do begin
                if expression[posC]=',' then Virgule := posC;
                inc(posC);
       end;
       if virgule=0 then exit;
       Nbre := 1;
       while (posC<length(expression)) and (expression[posC]<>')') do begin
          inc(nbre);
          inc(posC);
       end;
       delete(expression,virgule,Nbre);
       result := true;
       exit;
    end;
    if posPar>0 then begin // compter le nombre de virgule jusqu'à ")" : f(t,f,rc)
       Virgule := 0;
       posC := posPar;
       premierParam := '';
       while (posC<length(expression)) and (expression[posC]<>')') do begin
          if expression[posC]=',' then begin
             inc(Virgule);
             if virgule=1 then premierParam := copy(expression,posPar,posC-posPar);
          end;
          inc(posC);
       end;
       if (Virgule<2) and (grandeurs[0].nom<>premierParam) then begin
          Insert(grandeurs[0].nom+',',expression,posPar);
          result := true;
       end;
    end;
end;

initialization
{$IFDEF Debug}
   ecritDebug('initialization compile');
{$ENDIF}
   AdresseFonction[absolue] := MyAbs;
   AdresseFonction[signe] := Sign;
   AdresseFonction[echelon] := Ech;
   AdresseFonction[oppose] := Opp;
   AdresseFonction[inverse] := Inv;
   AdresseFonction[arctangente] := MyArcTan;
   AdresseFonction[entier] := MyInt;
   AdresseFonction[entierSup] := Plafond;
   AdresseFonction[entierInf] := Plancher;
   AdresseFonction[fractionnaire] := Fract;
   AdresseFonction[arrondi] := MyRound;
   AdresseFonction[carre] := Mysqr;
   AdresseFonction[racine] := Mysqrt;
   AdresseFonction[logdec] := MyLog;
   AdresseFonction[exponentielle] := MyExp;
   AdresseFonction[lognep] := MyLn;
   AdresseFonction[sinusCardinal] := sinc;
   AdresseFonction[derSinCardinal] := derSinc;
   AdresseFonction[tangente] := MyTan;
   AdresseFonction[sinus] := MySin;
   AdresseFonction[cosinus] := MyCos;
   AdresseFonction[arcsinus] := Asin;
   AdresseFonction[arccosinus] := Acos;
   AdresseFonction[sinHyper] := Sh;
   AdresseFonction[cosHyper] := Ch;
   AdresseFonction[tanHyper] := Th;
   AdresseFonction[argTanHyper] := aTh;
   AdresseFonction[besselCardinal] := BesselCard;
   AdresseFonction[derBesselCardinal] := derBesselCard;
   AdresseFonction[errorFunction] := erf;
   AdresseFonction[aleatoire] := aleat;
   AdresseFonction[CodeGamma] := Fgamma;
   AdresseFonction[CodeFact] := Factorielle;
   AdresseFonction[notFunction] := FonctionNot;
   AdresseFonction[reelle] := identite;
   AdresseFonction[imaginaire] := nul;
   AdresseFonction[argument] := arg;
   AdresseFonction[angle] := angleUtilisateur;
   AdresseFonction[SexaToDeci] := SexVersDec;
   AdresseFonction[UtilisateurToRadian] := AngleUtilisateur;
   AdresseFonction[DateTime] := ToDateTime;
   AdresseFonction[Mois] := ToMois;
   AdresseFonction[Jour] := ToJour;
   AdresseFonction[Annee] := ToAnnee;
   AdresseFonction[Heure] := ToHeure;
   AdresseFonction[CodeBruit] := Bruit;
   AdresseFonction[FonctInconnue] := nul;
   PileSauvegarde := TpileSauvegarde.Create;
   InitEnTete;

finalization
   DetruitEnTete
end.

