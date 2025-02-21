unit graphker;

interface

uses Windows, SysUtils, Graphics, Classes, Printers,
  Forms, Controls,
  system.UITypes, system.Contnrs, system.Types, system.IOUtils,
  Dialogs, clipBrd, ComCtrls, stdctrls, extctrls,
  Math, grids, jpeg, pngImage,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  fft, constreg, maths, uniteker, compile,
  regutil, curmodel, statCalc, indicateurU, latex,
  couleurLambda, identPagesU, modeleNum;

const
  decalageModeleGlb = 5;
  NbreDataEquiv  = 10;
  MaxMonde       = 10;
  MondeVitesse   = 1;
  MondeAcc       = 2;
  curseurData1   = 4;
  curseurData2   = 5;
  maxCurseur     = 5;
  rayonArcAngle  = 60;

type
  TindexCurseur   = 1..maxCurseur;
  ToptionIndicateur = (oiBandeVirage, oiEchelleTeinte, oiNomIndicateur);
  ToptionsIndicateur = set of ToptionIndicateur;
  TreperePage     = (SPstyle, SPmotif, SPcouleur);
  Tidentification = (identNone, identAnimation, identCoord, identDroite, identRaie);
  TetatModele     = (ModeleConstruit, ModeleLineaire, ModeleDefini,
    SimulationDefinie, AjustementGraphique, UniteParamDefinie, PasDeModele);
  TsetEtatModele  = set of TetatModele;
  Tcurseur        = (curSelect, curTexte, curLigne, curEfface,
    curReticule, curReticuleData, curEquivalence, curOrigine,
    curModele, curZoomAv, curModeleGr, curBornes, curMove, curReticuleModele,
    curXMini, curXMaxi,curYMini, curYMaxi,curReticuleDataNew);
  TcurseurFrequence = (curSelectF, curTexteF, curReticuleF,
    curZoomF, curMoveF, curFmaxi, curFmaxiSon, curLigneF);
  TcurseurTemps   = (curNormal, curDebut, curFin, curDeplace);
  TpanEffect      = (panZoom,panBornes,panEfface,panDragBorne,panDeplace);
  TcodeCouleur = (tHue,tSigne);

const
  NbreCouleur      = 17;
  mondeX           = 0;
  mondeY           = 1;
  mondeDroit       = 2;
  mondeSans        = 3;
  BrushCouleurSelect = clRed;
  BrushCouleurZoom   = clSilver;
  CouleurBandeConfiance    = clGreen;
  CouleurBandePrediction   = clLime;
  CouleurAxeX      = clBlack;
  taillePointEq    = 3;
  codeCouleurStr : array[TcodeCouleur] of string =
       ('expression (valeur 0..1)= teinte du point',
        'expression (valeur -1..1) = teinte du point');

var
  CouleurGrille:      Tcolor = clMedGray;
//  CouleurTexte:       Tcolor = clBlue;
  CouleurLigne:       Tcolor = clBlue;
  CouleurMethodeTangente:TColor = clHighLight;
  ImprimanteMonochrome: boolean = false;
  OrdreLissage:       integer = 3;
  reperePage:         TReperePage = SPcouleur;
  UseFaussesCouleurs: boolean = True;
  DimPointVGA:        integer = 3; // dimension du point en pixel VGA
  PStyleTangente:     TpenStyle = psSolid;
  PStyleReticule:     TpenStyle = psSolid;
  PStyleRepere:       TpenStyle = psDot;
  PcolorTangente:     Tcolor = clBlack;
  PcolorReticule:     Tcolor = clBlack;
  PcolorRepere:       Tcolor = clBlue;
  FondReticule:       Tcolor = clInfoBk;
  optionsIndicateur:  ToptionsIndicateur = [oiEchelleTeinte];
  CouleurVitesseImposee: boolean = True;
  FichierSon:         string;
  FreqEchWave:        integer;

  CouleurMecanique: array[1..2] of Tcolor = (clBlue, clRed);

  NomCurseur: array[curZoomAv..curBornes] of
  string = ('Zoom', 'Modèle graphique', 'Bornes');
  IconCurseur: array[Tcurseur] of integer =
      (27, 2, 1, 0, 3, 30, 4, 27, 29, 16, 5, 7, 0, 41,
       56,55,58,57,29); // 0 à définir

type
  TmodifGraphe       = (gmEchelle, gmOptions, gmXY, gmValeurs,
                        gmModele, gmPage, gmValeurModele, gmEquivalence);
  TmotifTexte        = (mtNone, mtCroix, mtFleche, mtVert, mtHoriz,
                        mtLigneRappel,mtDoubleFleche);
  TselectDessin      = (sdNone, sdCadre, sdPoint1, sdPoint2,
                        sdCentre, sdHoriz, sdVert);
  TselectEquivalence = (seNone, sePente1, sePoint1, sePoint2,
                        sePointEq, sePente2, sePenteEq);
  TtexteLigne        = (tlNone, tlPente, tlEquation, tlEcartY, tlEcartX);
  TsetModifGraphe    = set of TmodifGraphe;
  TcurseurStat       = (crsSelect, crsTexte, crsEfface);
  ToptionGraphe      = (OgQuadrillage, OgPolaire, OgOrthonorme, OgMemeZero,
                        OgPseudo3D, OgAnalyseurLogique, OgMemeEchelle, OgZeroGradue);
  ToptionModele      = (OmEchelle, OmExtrapole, OmManuel);

  TsetOptionGraphe = set of ToptionGraphe;
  TsetOptionModele = set of ToptionModele;
  Ttrace           = (trLigne, trPoint, trPixel,
    trResidus, trCouples, trIntensite, trSpirometrie,
    trStat, trVitesse, trAcceleration, trTexte, trSonagramme,
    trIndicateur, trCouleursSpectre);
// TrCouples trSpirometrie non pris en compte, restent en place à cause du stockage par indice dans les fichiers
  TtraceXML        = (trLigneX, trPointX, trResidusX, trStatX, trIntensiteX,
                      trVitesseX, trAccelerationX, trSonagrammeX, trIndicateurX, trCouleursSpectreX);

  TsetTrace        = set of Ttrace;
  TsetTraceXML     = set of TtraceXML;
  Tligne           = (LiDroite, LiModele, LiSpline, LiSinc);
  TindiceMonde     = mondeX..MaxMonde;
  TsetOptionCurseur= set of ToptionCurseur;

  TcurseurDonnees = record
// 1 à 3 réticule ; 4 et 5 curseur données
    xc, yc, ic:      integer;
    xr, yr:          double;
    grandeurCurseur: tGrandeur;
    indexCourbe:     integer;
    mondeC:          TindiceMonde;
  end;

  TCoordonnee = record
    nomX, nomY, nomZ: string;
    codeX, codeY, codeZ: integer;
    iMondeC:      TindiceMonde;

    regionTitre:  HRgn;
    iCourbe:      integer;
    Trace:        TsetTrace;
    Ligne:        Tligne;
    couleur:      Tcolor;
    styleT:       TpenStyle;
    Motif:        Tmotif;
    couleurPoint: string;
    codeCouleur : TcodeCouleur;
  end;

  TListeY = array[TindiceOrdonnee] of Tcoordonnee;

  TgrapheReg = class;

  Tdessin = class
    private
    Fgraphe: TgrapheReg;
    public
    x1, y1, x2, y2: double;
    x1i, y1i, x2i, y2i: integer;
    nomX,nomY:    string;
    iMonde:       TindiceMonde;
    LigneMax, LigneMin, longAnim: integer;
    cadre:        Trect;
    hauteur:      integer;
    souligne, avecCadre: boolean;
    centre, vertical: boolean;
    Alignement:   integer;
    pen:          Tpen;
    Identification: Tidentification;
    paramModeleBrut: boolean;
    isTexte, avecLigneRappel: boolean;
    isOpaque, isTitre: boolean;
    couleurFond:  Tcolor;
    MotifTexte:   TmotifTexte;
    MotifCourbe:  Tmotif;
    TexteLigne:   TtexteLigne;
    Texte:        TStringList;
    NumPage:      integer;
    Deplacable:   boolean;
// false pour les lignes ajoutés par le logiciel type statistique
    sousDessin:   Tdessin;
    proprietaire: Tdessin;
    repere:       Trepere;
    NumeroPage:   TcodePage;
// si identification=identCoord, numCoord indique la grandeur à identifier
// et numPoint indique le numéro du point sur lequel pointe la flèche
    NumCoord:      integer;
    NumPoint:     integer;
    constructor Create(gr : TgrapheReg);
    function NbreData: integer;
    procedure Draw;
    procedure DrawLatex(var latexStr : TstringList);
    procedure AffectePosition(x, y: integer;
      PosDessin: TselectDessin; Shift: TShiftState);
    function LitOption(grapheC: TgrapheReg): boolean;
    procedure SetPourCent(var i: integer;TexteLoc : TstringList);
    procedure SetUnPointInt(ax,ay : integer);
    procedure Load;
    procedure Store;
    procedure LoadXML(ANode : IXMLNode);
    procedure StoreXML(ANode : IXMLNode);
    destructor Destroy; override;
  end;

  TlisteDessin = class(TList)
  protected
    function Get(Index: integer): Tdessin;
    procedure Put(Index: integer; Item: Tdessin);
  public
    function Add(Item: Tdessin): integer;
    function Remove(Item: Tdessin): integer;
    property Items[Index: integer]: Tdessin Read Get Write Put; default;
    procedure Clear; override;
  end;

  TCourbe = class;

  Tequivalence = class(Tdessin)
    pente, ve, phe: double;
    vei, phei: integer;
    correcte:  boolean;
    varY:      Tgrandeur;
    mondepH:   TindiceMonde;
    ligneRappel: TligneRappel;
    indexModele: integer;
    commentaire: string;
    index1,index2: integer;
    constructor Create(v1, ph1, v2, ph2, v, ph, p: double;gr : TgrapheReg);
    constructor CreateVide(gr: TgrapheReg);
    procedure Draw;
    procedure DrawFugitif;
    Procedure DrawLatex(var latexStr : TstringList);
    procedure SetValeurEquivalence(i: integer);
    function Modif(x, y: integer;selectEq: TselectEquivalence): boolean;
    procedure Load;
    procedure Store;
    procedure LoadXML(ANode : IXMLNode);
    procedure StoreXML(ANode : IXMLNode);
  end;

  TlisteEquivalence = class(TList)
  protected
    function Get(Index: integer): Tequivalence;
    procedure Put(Index: integer; Item: Tequivalence);
  public
    function Add(Item: Tequivalence): integer;
    function Remove(Item: Tequivalence): integer;
    property Items[Index: integer]: Tequivalence Read Get Write Put; default;
    procedure Clear; override;
  end;

  Tmonde = class
    minDefaut, maxDefaut: double;
    miniInt,maxiInt: integer;
    mini, maxi:   double;
    horizontal:   boolean;
    axeInverse: boolean; // dans le sens décroissant
    miniOrtho, maxiOrtho: double;
    MinidB:  double;
    a, b: double; // entier = réel*a+b
    az,bz: double; // idem pour zoom
    ecartBit:     integer; // écart entre deux tracés de bit
    valeurBit:    integer; // valeur pour bit=1
    nombreBits:   integer;
    Graduation:   Tgraduation;
    defini, zeroInclus, autoTick: boolean;
    Axe:          tgrandeur;
    deltaAxe, Fexposant, pointDebut: double;
    // deltaAxe = écart entre graduations sur les axes
    // FExposant=puissance de 10 multiple de 3
    Nticks, TickDebut: integer;
    // Nticks nombre de graduations sans valeur affichée
    graduationPiActive: boolean;
    NbreChiffres,NbreDecimal: integer;
    TitreAxe:     TstrListe;
    xTitre, yTitre: integer;
    courbeBottom, courbeTop: integer;
    formatDuree:  string;
    ArrondiAxe:      double;
    Orthonorme, Polaire: boolean;
    constructor Create;
    procedure setDelta(grandAxe: boolean);
    procedure setDeltaImpose;
    procedure raz(IsPolaire: boolean);
    procedure affecteMinMax(x: double);
    function Trouve(V: Tvecteur; Debut, Fin: integer): boolean;
    function affecteEntier(r: double): integer;
    procedure setDefaut;
    function FormatMonde(x: double): string;
    destructor Destroy; override;
    procedure SetMinMaxDefaut(min, max: double);
    procedure GetMinMaxDefaut;
    procedure SetZoom(y0, zoom : integer);
  end;

  TmondeVecteur = class
    maxi:      double;
    ax, ay:    double; // entier = réel*a
    defini, vitesse, echelleTrace: boolean;
    Dimension: integer;
    echelle:   double;
    MondeOrd:  TindiceMonde;
    constructor Create;
    procedure raz;
    procedure Trouve(Vx, Vy: Tvecteur; Nbre: integer);
    procedure GetEntier(x, y: double; var xi, yi: integer);
    procedure GetPolaire(r, teta, rp, tetap, rs, tetas: double; var x, y: double);
  end;

  TCourbe = class
    valXe,valYe : TvecteurInt; // e pour extrapolé
    valX, valY, incertX, incertY: Tvecteur;
    valXder, valYder, valXder2, valYder2: Tvecteur;
    texteC:      TStringList;
    couleurTexte : Tcolor;
    trace:       TsetTrace;
    DebutC,finC: integer;
    finE,lenvalXe: integer;
    NumAnim:     integer;
    iMondeC:     TindiceMonde;
    varX, varY:  tGrandeur;
    varDer:      array[1..2] of tGrandeur;
    Couleur:     Tcolor;
    StyleT:      TpenStyle;
    Motif:       Tmotif;
    IndexModele, IndexBande: shortInt;
    OptionLigne: Tligne;
    Adetruire, DetruireIncert, CourbeExp, PortraitDePhase,
    ModeleParametrique, ModeleParamX1: boolean;
    Page:        integer;
    decalage:    integer;
    PointSelect: set of byte;
    couleurPoint: string;
    codeCouleur : TcodeCouleur;
    constructor Create(AX, AY: Tvecteur; D, F: integer;
      VX, VY: tgrandeur);
    procedure setStyle(Acouleur: Tcolor; Astyle: TpenStyle; Amotif: Tmotif);
    procedure setStylePoint(AcouleurPoint : string;AcodeCouleur : TcodeCouleur);
    destructor Destroy; override;
  end;

  TtraceDefaut = (tdLigne, tdPoint, tdLissage);
  TstyleBorne  = (bsDebut, bsFin, bsDebutVert, bsFinVert, bsAucune);

  Tborne = record
    Xb, Yb: integer;
    IndexModele, IndexCourbe: integer;
    style:  TstyleBorne;
  end;

  TlisteCourbe = class(TList)
  protected
    function Get(Index: integer): Tcourbe;
    procedure Put(Index: integer; Item: Tcourbe);
  public
    function Add(Item: Tcourbe): integer;
    function Remove(Item: Tcourbe): integer;
    property Items[Index: integer]: Tcourbe Read Get Write Put; default;
    procedure Clear; override;
  end;

  TgrapheReg = class
    LargCarac, HautCarac: integer;
    alignement : integer;
    canvas:        Tcanvas;
    paintBox:      TpaintBox;
    panel:         Tpanel;
    coordonnee:    TlisteY;
    dimPoint:      integer;
    sansAxeX,sansAxeY : boolean;
    avecAxeX, avecAxeY: boolean;
    grandAxeX, grandAxeY: boolean;
    superposePage, empilePage: boolean;
    mondeDebut:    TindiceMonde;
    mondeDerivee:  TindiceMonde;
    monde:         array[TindiceMonde] of Tmonde;
    mondeVecteur:  array[1..2] of TmondeVecteur;
    courbes:       TlisteCourbe;
    Dessins:       TlisteDessin;
    Equivalences:  array[TcodePage] of TlisteEquivalence;
    EquivalenceCourante, EquivalenceTampon: Tequivalence;
    indexCourbeEquivalence: integer;
    LimiteCourbe, LimiteFenetre: Trect;
    BorneFenetre: Trect;
    Marge,MargeBorne,dimBorne : integer;
    CurseurOsc:   array[1..5] of TcurseurDonnees;
    CurseurActif : Tcurseur;
    withDebutFin: boolean;
    CurseurDebut:  Tpoint;
    UnitePente:    Tunite;
    grapheOK, verifierOrtho, verifierInv: boolean;
    modif:         TsetModifGraphe;
    OptionGraphe:  TsetOptionGraphe;
    OptionModele:  TsetOptionModele;
    StatusSegment: array[0..1] of TStringList;
    useDefaut, useDefautX: boolean;
    useZoom: boolean;
    AutoTick, GraduationZeroX, GraduationZeroY, FilDeFer:      boolean;
    NbreOrdonnee:  integer;
    penWidth:      integer;
    MiniTemps, MaxiTemps: double;
    avecAnimTemporelle : boolean;
    PasPoint:      integer;
    PixelsPerInchX, PixelsPerInchY: integer;
    avecBorne:     boolean;
    margeHautBas:  integer;
    margeCaracY:   integer;
    indicateur:    Tindicateur;
    bitmapReg:     Tbitmap;
    UnAxeX:        boolean;
    miniMod, maxiMod: double;
    indexHisto,numeroHisto,nbreHisto: integer;
    DessinCourant:  Tdessin;
    posDessinCourant: TselectDessin;
    indexReticuleModele: integer;
    grapheParam: boolean;
    cCourant: integer;
    labelYcurseur:  Tlabel;
    optionCurseur:  TsetOptionCurseur;
    valeurCurseur:  array[ToptionCurseur] of double;
    borneVisible:   boolean; // sinon points de modélisation
    residuNormalise: boolean;
    identificationPages: boolean;
    zeroPolaire:    double;
    oldPen:         THandle;
    constructor Create;
    procedure Draw;
    procedure TraceCourbe(index: integer);
    procedure TraceFilDeFer;
    procedure raz;
    procedure ResetEquivalence;
    procedure WindowXY(xr, yr: double;m : TindiceMonde; var xi, yi: integer);
    procedure WindowRT(xr, yr: double; m: TindiceMonde; var xi, yi: integer);
    procedure RTversXY(var xr, yr: double; m: TindiceMonde);
    function WindowX(xr: double): integer;
    procedure MondeXY(xi, yi: integer; m: TindiceMonde; var xr, yr: double);
    procedure MondeRT(xi, yi: integer; m: TindiceMonde; var xr, yr: double);
    procedure ChercheMonde;
    procedure SetMonde(m: TindiceMonde; minX, minY, maxX, maxY: double);
    procedure AjoutePoint(m: TindiceMonde; XX, YY: double);
    procedure DrawAxis(initialisation: boolean);
    procedure TraceTitreAxe(g: Tgrandeur; m: TindiceMonde;
      indexCourbe: integer);
 //   procedure VersMetaFile(const NomFichier : string);
    procedure VersJpeg(const NomFichier : string);
    procedure VersPng(const NomFichier : string);
    procedure VersBitmap(const NomFichier : string);
    procedure VersFichier(NomFichier : string);
    procedure VersPressePapier(grapheCB : TgrapheClipBoard);
    procedure VersImprimante(HauteurGr: double; var bas: integer);
    destructor Destroy; override;
    procedure AffecteZoomAvant(rect: Trect; avecY: boolean);
    procedure AffecteZoomArriere;
    function affecteZoom(Location : TPoint;distance : integer;avecY : boolean) : boolean;
    procedure AffecteCentreRect(x, y: integer; var r: Trect);
    procedure SetDessinCourant(x, y: integer);
    procedure GetEquivalence(x, y: integer;
      var AEquivalence: Tequivalence; var selectEq: TselectEquivalence);
    procedure TraceDroite(x, y, pente: double; xMin, yMin, xMax, Ymax: double;mondePH : TindiceMonde);
    procedure TraceCourbeEquivalence(xvecteur,yvecteur : Tvecteur;N,N0 : integer);
    procedure AjouteEquivalence(i: integer; effaceDouble: boolean);
    procedure RemplitTableauEquivalence;
    procedure TraceCurseur(i: TindexCurseur);
    procedure TraceMotif(xi, yi: integer; motif: Tmotif);
    procedure TracePente;
    Procedure SetRepere;
    function GetReticuleModeleProche(x, y: integer) : boolean;
    procedure GetCurseurProche(x, y: integer; force: boolean);
    function GetBorne(x, y: integer; var Borne: Tborne): boolean;
    procedure SetBorne(x, y: integer; var Borne: Tborne);
    procedure InitReticule(x, y: integer);
    procedure SetSegmentInt(x, y: integer);
    procedure SetSegmentReal(i: integer);
 //   procedure SetReticuleModele(x, y: integer;selonX,selonY : boolean);
    procedure SetStatusReticuleData(var Agrid: TstringGrid);
    function PointProche(var x, y: integer; indexCourbe: integer;
      limite, Xseul: boolean): integer;
    procedure PointProcheNew(ax, ay: integer);
//    function PointProcheModele(var x, y: integer): integer;
//    function PointProcheModeleX(var x, y: integer): integer;
//    function PointProcheModeleY(var x, y: integer): integer;
    function MondeProche(x, y: integer): TindiceMonde;
    function CourbeProche(var x, y: integer): integer;
    function CourbeProcheLisse(var x, y: integer): integer;
    function CoordProche(var x, y: integer): integer;
    function CourbeModeleProche(var x, y: integer): integer;
    function SupprReticule(x, y: integer): boolean;
    procedure TraceReticule(index: TindexCurseur);
    procedure TraceEcart;
    function PointProcheReal(x, y: double; Acourbe: Tcourbe;
      m: TindiceMonde): integer;
    function isAxe(x, y: integer): integer;
    function isAxeX(x, y: integer; var adroite : boolean): boolean;
    function isAxeY(x, y: integer; var enhaut : boolean): boolean;
    function AjouteCourbe(AX, AY: Tvecteur; Am: TindiceMonde;
      Nbre: integer; grandeurX, grandeurY: Tgrandeur;
      Apage: integer): Tcourbe;
    procedure EncadreTitre(active: boolean);
    procedure RectangleGr(Arect: Trect);
    procedure LineGr(Arect: Trect);
    procedure MajNomGr(index: TcodeGrandeur);
    function AjusteMonde: boolean;
    procedure SetUnitePente(iMonde: TindiceMonde);
    procedure traceBorne(xi, yi: integer;
      style: TstyleBorne; couleur: Tcolor; indexM: integer);
    procedure traceBorneFFT;
    procedure setEchelle(ACanvas: Tcanvas);
    procedure setCourbeDerivee;
    procedure resetCourbeDerivee;
    procedure resetEchelle;
    procedure affecteIndicateur(AvecIndicateur: boolean;const nom: string);
    procedure chercheMinMax;
    procedure changeEchelleX(xnew, xold: integer;ismaxi : boolean);
    procedure changeEchelleY(ynew, yold: integer;isMaxi : boolean);
    procedure CreateSolidBrush(couleur : Tcolor);
    procedure createHatchBrush(aCode : TBrushStyle;couleur : Tcolor);
    procedure CreatePen(aStyle : TpenStyle;aWidth  : integer;couleur : Tcolor);
    procedure CreatePenFin(aStyle : TpenStyle;couleur : Tcolor);
    procedure SetTextAlign(aligne : integer);
    procedure MyTextOut(x,y : integer;const S : string);
    procedure MyTextOutFond(x,y : integer;const S : string;couleur : Tcolor);
    procedure Segment(x1, y1, x2, y2: integer);
    procedure GenereSon;
    procedure VersLatex(const NomFichier : string;suffixe : char);
    procedure getIndexSonagramme(t,f : double;var it,ifreq : integer;var freq : double);
    procedure TraceIdentPages;
    Function ChercheVpH(i : integer;var iApres : integer;var penteTg : double) : boolean;
  end;

  TtransfertGraphe = class
    Grad:       array[TindiceMonde] of Tgraduation;
    Zero:       array[TindiceMonde] of boolean;
    MinidB:     array[TindiceMonde] of double;
    AxeInverse: array[TindiceMonde] of boolean;
    Trace:      array[TindiceOrdonnee] of TsetTrace;
    Ligne:      array[TindiceOrdonnee] of Tligne;
    nomX, nomY: array[TindiceOrdonnee] of string;
    iMonde:     array[TindiceOrdonnee] of TindiceMonde;
    Couleur:    array[TindiceOrdonnee] of Tcolor;
    Style:      array[TindiceOrdonnee] of TpenStyle;
    Motif:      array[TindiceOrdonnee] of Tmotif;
    couleurPoint: array[TindiceOrdonnee] of string;
    codeCouleur: array[TindiceOrdonnee] of TcodeCouleur;
    optionGr:   TsetOptionGraphe;
    optionModele:  TsetOptionModele;
    SuperposePage:  boolean;
    ZeroPolaire : double;
    FilDeFer:   boolean;
    UseDefaut, UseDefautX: boolean;
    useZoom: boolean;
    PasPoint:   integer;
    AutoTick:   boolean;
    indicateur: Tindicateur;
    procedure AssignEntree(const Agraphe: TgrapheReg);
    procedure AssignSortie(var Agraphe: TgrapheReg);
    Procedure Ecrit(numero : integer);
    Procedure Lit;
    constructor Create;
  end;

function GetCouleurPages(index: integer): Tcolor;
function TriEquivalence(Item1, Item2: Pointer): integer;
function GetCouleurPale(Acolor: Tcolor): Tcolor;
function TraceToXML(trace : TsetTrace) : TsetTraceXML;
function TraceFromXML(trace : TsetTraceXML) : TsetTrace;

var
  MotifIdent:       TmotifTexte = mtFleche;
  hauteurIdent:     integer = 3;
  avecCadreIdent:   boolean = false;
  isOpaqueIdent:    boolean = false;
  couleurFondIdent: Tcolor = clWhite;
  penWidthGrid:     integer = 1;
  penWidthCourbe:   integer = 1;
  tailleTick:       integer = 1;
  LongueurTangente : real = 0.33;
  NbreVecteurVitesseMax: integer = 32;
  NbreTexteMax:     integer = 32;
  EchelleVecteur:   double = 0.06;
  ProlongeVecteur:  boolean = False;
  ProjeteVecteur:   boolean = False;
  TraceDefaut:      TtraceDefaut = tdPoint;
  GammaNiveauGris:  double = 1;
  DecadeDB:         integer = 2;
  UseSelect:        boolean = False;
  DecalageFFT:      integer = 2;
  CoeffDecalage:    integer = 1;
  CoeffSIpente:     double = 1;
  OptionGrapheDefault: TsetOptionGraphe = [];
  ImprimanteEnCours: boolean = False;
  ImprimanteMono:    boolean = False;
  WMFenCours:        boolean = False;
  ImageEnCours:      boolean = False;
  verifierLog:       boolean = False;
  GraphePageIndependante: boolean = false;
  AffichagePrecision:boolean = false;
  ModeleNumerique:   boolean = false;
  AffCoeffElarg:     boolean = false;

  ConfigGraphe : array[0..MaxPagesGr] of TtransfertGraphe;

implementation

uses lectText, optLine, options, valeurs;

const
    XmaxWMF          = 16000;
    YmaxWMF          = 9000; //16 cm x 9 cm en 0.01mm
    XmaxBitmap       = 800;
    YmaxBitmap       = 450; // 16/9
    LongNombreAxe    = 6;
    LongNombreAxeLog = 4;
    couleurCurseurs: array[1..5] of tColor = (clRed,clRed,clRed,clBlue,clBlue);
    MotifLatex : array[Tmotif] of string = ('+','x','o','square','diamond',
       '*','square*','star','asterik','pentagon','triangle','','','','','','');
    StyleLatex : array[TPenStyle] of string = ('',',dashed',',dotted',',dash dot',
      ',dash dot dot', '', '', '', '');
    intNan = -100;
    intPlusInf     = -200;
    intMoinsInf    = -300;
    MargeCurseur   = 5;
    MaxVecteurPoly = 1024;
    NbreGradMin    = 5;
    NbreGradMax    = 2 * NbreGradMin;
    NbreGradMaxMan = 2 * NbreGradMax;

function TraceToXML(trace : TsetTrace) : TsetTraceXML;
begin
    result := [];
    if trLigne in trace then include(result,trLigneX);
    if trPoint in trace then include(result,trPointX);
    if trResidus in trace then include(result,trResidusX);
    if trIntensite in trace then include(result,trIntensiteX);
    if trStat in trace then include(result,trStatX);
    if trVitesse in trace then include(result,trVitesseX);
    if trAcceleration in trace then include(result,trAccelerationX);
    if trIndicateur in trace then include(result,trIndicateurX);
    if trSonagramme in trace then include(result,trSonagrammeX);
    if trCouleursSpectre in trace then include(result,trCouleursSpectreX);
end;

function TraceFromXML(trace : TsetTraceXML) : TsetTrace;
begin
    result := [];
    if trLigneX in trace then include(result,trLigne);
    if trPointX in trace then include(result,trPoint);
    if trResidusX in trace then include(result,trResidus);
    if trIntensiteX in trace then include(result,trIntensite);
    if trStatX in trace then include(result,trStat);
    if trVitesseX in trace then include(result,trVitesse);
    if trAccelerationX in trace then include(result,trAcceleration);
    if trIndicateurX in trace then include(result,trIndicateur);
    if trSonagrammeX in trace then include(result,trSonagramme);
    if trCouleursSpectreX in trace then include(result,trCouleursSpectre);
end;


function GetCouleurPale(Acolor: Tcolor): Tcolor;
const decale = 64;
      minDecale = 255-decale;
      maxDecale = 255;
var
  R, G, B: byte;
begin
  case Acolor of
    clBlack: Result := clGray;
    clMaroon: Result := clPurple;
    clGreen: Result := clTeal;
    clOlive: Result := clYellow;
    clNavy: Result := clBlue;
    clPurple: Result := clRed;
    clTeal: Result := clLime;
    clGray: Result := clMedGray;
    clRed: Result  := clFuchsia;
    clLime: Result := clMoneyGreen;
    clYellow: Result := clCream;
    clBlue: Result := clAqua;
    clAqua: Result := clSkyBlue;
    clWhite: Result := clWhite;
    clMedGray: Result := clSilver;
    else begin
      B := getBvalue(Acolor);
      if B < minDecale
         then B := B + decale
         else B := maxDecale;
      R := getRvalue(Acolor);
      if R < minDecale
         then R := R + decale
         else R := maxDecale;
      G := getGvalue(Acolor);
      if G < minDecale
         then G := G + decale
         else G := maxDecale;
      Result := RGB(R, G, B);
    end;
  end;
end;

function GetFausseCouleur(Niveau: double): Tcolor; // Niveau entre 0 et 1

// bleu 255 vert 0   rouge 0 soit 0=Bleu
// bleu 255 vert ++  rouge 0
// bleu 255 vert 255 rouge 0 =0.25
// bleu --  vert 255 rouge 0
// bleu 0   vert 255 rouge 0 soit 0.5=Vert
// bleu 0   vert 255 rouge ++
// bleu 0   vert 255 rouge 255 =0.75
// bleu 0   vert --  rouge 255
// bleu 0   vert 0   rouge 255 soit 1=Rouge

// bleu  <1/4 => 1 >1/2 => 0
// rouge <1/2 => 0 >3.4 => 1
// vert  0   => 0 1/4 => 1
// vert  3/4 => 1 1   => 0

  function C(valeurR: double): integer;
  begin
    Result := round(255 * valeurR);
    if Result < 0 then
      Result := 0
    else if Result > 255 then
      Result := 255;
  end;

var
  R, G, B: integer;
begin
  if niveau < 0 then
    niveau := 0;
  if niveau > 1 then
    niveau := 1;
  B := C(2 - 4 * niveau);
  if niveau < 0.5
     then G := C(4 * niveau)
     else G := C(4 - 4 * niveau);
  R := C(4 * niveau - 2);
  Result := RGB(R, G, B);
end; //  GetFausseCouleur

procedure TgrapheReg.Segment(x1, y1, x2, y2: integer);
begin
   canvas.moveTo(x1, y1);
   canvas.lineTo(x2, y2);
end;

destructor Tmonde.Destroy;
begin
  TitreAxe.Free;
  inherited Destroy;
end;

procedure Tmonde.SetZoom(y0, zoom : integer);
begin
    az := zoom*a;
    bz := zoom*b+y0*(1-zoom);
end;

constructor Tmonde.Create;
begin
  inherited Create;
  MinidB := 1e-6; // -120 dB / 1 V
  Axe := nil;
  ZeroInclus := True;
  horizontal := False;
  MinDefaut := 0;
  MaxDefaut := 1;
  Orthonorme := False;
  Graduation := gLin;
  TitreAxe := TstrListe.Create;
  xtitre := 0;
  a := 1;
  raz(False);
end; // Tmonde.Create

procedure Tmonde.AffecteMinMax(x: double);
begin
  if x > Maxi
    then Maxi := x
    else if x < Mini
       then Mini := x;
end;

procedure Tmonde.SetDefaut;
begin
  if mini = maxReal then begin
    mini := 1;
    maxi := 2;
  end;
  case Graduation of
      gLog:  if (maxi - mini) < 0.1 then Maxi := Mini + 1;  // 1 décade
      gdB:  if (maxi - mini) < 1 then Maxi  := Mini + 20; // 20 dB
      gLin, gInv:  if (maxi - mini) < 1E-30 then Maxi := Mini + 1; // mini = masse d'un proton
      gBits:  if (maxi - mini) < 1 then Maxi := Mini + 8;
  end;
end;

function Tmonde.Trouve(V: Tvecteur; Debut, Fin: integer): boolean;
var
  VariabMin, VariabMax: double;
  Ajuste: boolean;
  margeR: double;
  maxnul,minnul : boolean;
begin
  Trouve := True;
  if debut > fin then exit;
  if fin>high(V) then fin := high(v);
  MaxiMini(V, variabMax, variabMin, Debut, Fin);
  if (graduation=gLog) and
     (variabMin < 1E-12) then begin
    Graduation  := gLin;
    verifierLog := True;
  end;
  Ajuste := False;
  case Graduation of
    gLog: begin
      if Log10(variabMin) < Mini then
        Mini := Log10(variabMin);
      if (Mini - floor(Mini)) < 0.1 then
        Mini := floor(Mini) - 0.05;
      if Log10(variabMax) > Maxi then
        Maxi := Log10(variabMax);
      if (ceil(Maxi) - Maxi) < 0.1 then
        Maxi := ceil(Maxi) + 0.05;
    end;
    gdB: begin
      if (variabMin < minidB) then
        variabMin := minidB;
      if 20 * Log10(variabMin) < Mini then
        Mini := Log10(variabMin) * 20;
      if (variabMax < minidB) then
        variabMax := minidB * 100;
      if 20 * Log10(variabMax) > Maxi then
        Maxi := Log10(variabMax) * 20;
      if Mini < (Maxi - 120) then
        Mini := Maxi - 120;
    end;
    gInv: begin
      if variabMin < Mini then
        Mini := variabMin;
      if variabMax > Maxi then
        Maxi := variabMax;
    end;
    gLin, gBits: begin
      if variabMin < Mini then begin
        Mini := variabMin;
        ajuste := True;
      end;
      if variabMax > Maxi then begin
        Maxi := variabMax;
        ajuste := True;
      end;
      if not ajuste then ajuste := avecEllipse;
    end;
  end;
  if ajuste then begin
    margeR := (maxi - mini) / 25;
    maxNul := maxi<=0;
    minNul := mini>=0;
    maxi := maxi + margeR;
    if maxNul and (maxi > 0) then maxi := 0;
    mini := mini - margeR;
    if minNul and (mini < 0) then mini := 0;
  end;
  trouve := True;
end; // Tmonde.Trouve

procedure Tmonde.SetMinMaxDefaut(min, max: double);
begin
  VerifMinMaxReal(Min, Max);
  MinDefaut := Min;
  MaxDefaut := Max;
  Defini := not((Min=0) and (Max=1));
  case Graduation of
    gLog: begin
      try
        Mini := Log10(MinDefaut);
        Maxi := Log10(MaxDefaut);
      except
        MaxDefaut := 100;
        Maxi := 2;
        MinDefaut := 1;
        Mini := 0;
      end;
      zeroInclus := False;
    end;
    gdB: begin
      try
        Mini := Log10(MinDefaut) * 20;
        Maxi := Log10(MaxDefaut) * 20;
        zeroInclus := False;
      except
        MaxDefaut := 100;
        Maxi := 40;
        MinDefaut := 1;
        Mini := 0;
      end;
    end;
    gInv: begin
      try
        Maxi := 1 / MinDefaut;
        Mini := 1 / MaxDefaut;
        zeroInclus := False;
      except
        MaxDefaut := 10;
        Mini := 0.1;
        MinDefaut := 0.1;
        Maxi := 10;
      end;
    end;
    gLin: begin
      Maxi := MaxDefaut;
      Mini := MinDefaut;
      zeroInclus := mini * maxi <= 0;
    end;
    gBits: begin
      Maxi := MaxDefaut;
      if MaxDefaut < 1024
         then Maxi := MaxDefaut
         else Maxi := 255;
      if MinDefaut >= 0
         then Mini := MinDefaut
         else Mini := 0;
      zeroInclus := True;
    end;
  end;
end;

procedure Tmonde.GetMinMaxDefaut;
begin
  case Graduation of
    gLog: begin
      try
        MinDefaut := power(10,Mini);
        MaxDefaut := power(10,Maxi);
      except
        MaxDefaut := 100;
        Maxi := 2;
        MinDefaut := 1;
        Mini := 0;
      end;
    end;
    gdB: begin
      try
        MinDefaut := Power(10,Mini/20);
        MaxDefaut := Power(10,Maxi/20);
      except
        MaxDefaut := 100;
        Maxi := 40;
        MinDefaut := 1;
        Mini := 0;
      end;
    end;
    gInv: begin
      try
        MaxDefaut := 1 / Mini;
        MinDefaut := 1 / Maxi;
      except
        MaxDefaut := 10;
        Mini := 0.1;
        MinDefaut := 0.1;
        Maxi := 10;
      end;
    end;
    else begin
      MaxDefaut := Maxi;
      MinDefaut := Mini;
    end;
  end;
end;

procedure Tmonde.Raz(isPolaire : boolean);
begin
  graduationPiActive := False;
  defini := False;
  autoTick := True;
  orthonorme := False;
  arrondiAxe := 1;
  Fexposant := 1;
  a := 1;
  b := 0;
  polaire := isPolaire;
  if isPolaire then begin
    ZeroInclus := True;
    AxeInverse := false;
  end;
  if Graduation <> gLin then
    ZeroInclus := False;
  if (axe <> nil) and (axe.formatU in [fDateTime, fDate, fTime]) then
    zeroInclus := False;
  if zeroInclus then begin
    Maxi := 0;
    Mini := 0;
  end
  else begin
    Maxi := -maxReal;
    Mini := maxReal;
  end;
  MinDefaut := 0;
  MaxDefaut := 1;
end; //  Tmonde.Reset

function Tmonde.affecteEntier(r: double): integer;
begin
  if isNan(r) or isInfinite(r)
  then Result := intNan
  else
    try
      Result := round(A * r + B);
      if (result>maxiInt)
          then result := intPlusInf
          else if (result<miniInt) then result := intMoinsInf;
    except
      Result := intNan
    end;
end;

constructor TmondeVecteur.Create;
begin
  inherited Create;
  defini  := False;
  vitesse := True;
  MondeOrd := mondeY;
end;

const
  Nbre125: array[1..3] of integer = (1, 2, 5);

procedure TmondeVecteur.Trouve(Vx, Vy: Tvecteur; Nbre: integer);

  procedure SetDelta;
  const
    indexMax = 4;
    coeff: array[0..indexMax] of double = (10, 5, 2, 1, 0.5);
  var
    largeur: double;
    LExposant, index: integer;
  begin
    LExposant := floor(Log10(Maxi));
    largeur := maxi * dix(-Lexposant);
    index := 0;
    while (largeur < coeff[index]) and (index < indexMax) do
      Inc(index);
    Echelle := coeff[index] * dix(Lexposant);
  end; // setDelta

var
  j: integer;
begin
  if (Vx = nil) or (Vy = nil) or (Nbre < 3) then
    exit;
  for j := 0 to pred(Nbre) do begin
    if isNan(vx[j]) or isNan(vy[j]) then continue;
    if abs(vx[j]) > maxi then
      maxi := abs(vx[j]);
    if abs(vy[j]) > maxi then
      maxi := abs(vy[j]);
  end;
  Defini := maxi > 0;
  if defini then setDelta;
end;

procedure TmondeVecteur.Raz;
begin
  defini := False;
  Ax := 0;
  Ay := 0;
  maxi := 0;
  echelleTrace := False;
end;

procedure TmondeVecteur.getEntier(x, y: double; var xi, yi: integer);
begin
  if isNan(x) then
    xi := intNan
  else
    try
      xi := round(Ax * x);
    except
      xi := intNan
    end;
  if isNan(y) then
    yi := intNan
  else
    try
      yi := round(Ay * y);
    except
      yi := intNan
    end;
end;

procedure TmondeVecteur.GetPolaire(r, teta, rp, tetap, rs, tetas: double; var x, y: double);
var
  ar, ateta: double;
begin
  if vitesse then begin
    ar := rp;
    ateta := r * tetap;
  end
  else begin
    ar := rs - r * sqr(tetap);
    ateta := 2 * rp * tetap + r * tetas;
  end;
  x := ar * cos(teta) - ateta * sin(teta);
  y := ar * sin(teta) + ateta * cos(teta);
end;

procedure TGrapheReg.MondeXY(xi, yi: integer; m: TindiceMonde; var xr, yr: double);
begin
  xr := (xi - monde[mondeX].B) / monde[mondeX].A;
  yr := (yi - monde[m].B) / monde[m].A;
end;

function GetCouleurPages(index: integer): Tcolor;
begin
   if ImprimanteMono
   then Result := clBlack
   else begin
      index  := index mod MaxPagesGr;
      Result := couleurPages[index];
      if Result = clWindow then begin
        couleurPages[index] := clActiveCaption;
        Result := clActiveCaption;
      end;
   end;
end;

procedure TGrapheReg.setEchelle (Acanvas: Tcanvas);
begin
  PixelsPerInchX := GetDeviceCaps(Acanvas.handle, LOGPIXELSX);
  PixelsPerInchY := GetDeviceCaps(Acanvas.handle, LOGPIXELSY);
end;

procedure TGrapheReg.ResetEchelle;
begin
  PixelsPerInchX := 1;
  PixelsPerInchY := 1;
end;

procedure TGrapheReg.MondeRT(xi, yi: integer; m: TindiceMonde; var xr, yr: double);
var
  Lrayon, Langle: double;
begin
  mondeXY(xi, yi, m, xr, yr);
  case monde[mondeX].graduation of
    gLog: xr := power(10,xr);
    gdB: xr  := power(10,xr/20);
    gInv: xr := 1 / xr;
  end;
  case monde[m].graduation of
    gLog: yr := power(10,yr);
    gdB: yr  := power(10,yr/20);
    gInv: yr := 1 / yr;
  end;
  if OgPolaire in OptionGraphe then begin
    Langle := atan2(yr, xr);
    Lrayon := sqrt(sqr(xr) + sqr(yr));
    xr := Langle;
    yr := Lrayon+zeroPolaire;
  end;
end;

procedure TGrapheReg.VersImprimante(hauteurGr: double; var bas: integer);
var
  margeI, hauteur: integer;
  rgnGraphe: Hrgn;
  sauveCanvas : Tcanvas;
begin
  sauveCanvas := canvas;
  try
  setEchelle(Printer.Canvas);
  limiteFenetre := Printer.Canvas.ClipRect;
  coeffDecalage := marge div 20;
  margeI := printerParam.margeTexte;
  if printer.orientation = poLandscape
    then with limiteFenetre do begin
      if bas > 3 * margeI then begin
        Printer.NewPage;
        bas := margeI div 2;
      end;
      top  := top + bas + (margeI div 2);
      bas  := bottom;
      bottom := bottom - margeI;
      right := right - margeI;
      left := left + margeI;
    end
    else with limiteFenetre do begin
      right := right - margeI;
      left := left + margeI;
      hauteur := round((bottom - top) * hauteurGr);
      top := bas + margeI div 2;
      bottom := top + hauteur;
      if bottom > Printer.PageHeight then begin
        Printer.NewPage;
        top := margeI;
        bottom := top + hauteur;
      end;
      bas := bottom + margeI div 2;
    end;
  with limiteFenetre do
       rgnGraphe := createRectRgn(left, top, right, bottom);
  selectClipRgn(Printer.Canvas.handle, rgnGraphe);
  ImprimanteEnCours := True;
  ImprimanteMono := (GetDeviceCaps(printer.Handle,NumColors) <= 2) or ImprimanteMonochrome;
  canvas := Printer.Canvas;
  Draw;
  printer.Canvas.textFlags := 0;
  ImprimanteEnCours := False;
  selectClipRgn(Printer.Canvas.handle, 0);{RàZ}
  DeleteObject(rgnGraphe);
  coeffDecalage := 1;
  ResetEchelle;
  except
    AfficheErreur(erPbImprimante,0)
  end;
  imprimanteMono := false;
  canvas := sauveCanvas;
end;

procedure TGrapheReg.RTversXY(var xr, yr: double; m: TindiceMonde);
var
  Langle: double;
begin
  if OgPolaire in OptionGraphe then
    if isNan(yr) then begin
      xr := 0;
      yr := 0;
    end
    else begin
      Langle := xr;
      AngleEnRadian(Langle);
      xr := (yr-zeroPolaire) * cos(Langle);
      yr := (yr-zeroPolaire) * sin(Langle);
    end
  else begin
    case monde[mondeX].graduation of
      gLog: xr := Log10(xr);
      gInv: xr := 1 / xr;
    end;
    case monde[m].graduation of
      gLog: yr := Log10(yr);
      gdB: if yr < monde[m].minidB
         then yr := 20 * log10(monde[m].minidB)
         else yr := 20 * Log10(yr);
      gInv: yr := 1 / yr;
    end;
  end;
end;

procedure TGrapheReg.WindowRT(xr, yr: double; m: TindiceMonde; var xi, yi: integer);
// raisonne suivant type de coordonnee
begin
  RTversXY(xr, yr, m);
  xi := monde[mondeX].affecteEntier(xr);
  yi := monde[m].affecteEntier(yr);
end; // windowRT

procedure TGrapheReg.WindowXY(xr, yr: double; m: TindiceMonde; var xi, yi: integer);
begin
  yi := monde[m].affecteEntier(yr);
  xi := monde[mondeX].affecteEntier(xr);
end;

procedure TGrapheReg.ChercheMonde;

  procedure FindWorld(m: TindiceMonde; XX, YY: Tvecteur; Debut, Fin: integer);

    procedure worldPolaire;
    var
      j: integer;
      Langle, Lrayon: double;
    begin
      if zeroPolaire<0 then begin
         for j := Debut to Fin do
            if YY[j]<zeroPolaire then zeroPolaire := YY[j];
         zeroPolaire := 10*floor(zeroPolaire/10);
      end;
      for j := Debut to Fin do begin
        Langle := XX[j];
        Lrayon := YY[j]-zeroPolaire;
        angleEnRadian(Langle);
        monde[mondeX].affecteMinMax(Lrayon * cos(Langle));
        monde[m].affecteMinMax(Lrayon * sin(Langle));
      end;
    end; // worldPolaire

  begin // findworld
    if OgPolaire in OptionGraphe
       then worldPolaire
       else grapheOK := monde[mondeX].Trouve(XX, debut, fin) and
                        monde[m].Trouve(YY, debut, fin);
  end; // findworld

  procedure chercheProjectionY(m: TindiceMonde);
  var margeLoc : integer;

    procedure ajusteOrthonorme;
    var
      rapport: double;
      acmX, acmY, aYnew: double;
      desactiverOrtho : boolean;
    begin
      if not (OgPolaire in OptionGraphe) and
         (monde[m].axe <> nil) and (monde[m].axe.nomUnite <> '') and
         (monde[mondeX].axe <> nil) and (monde[mondeX].axe.nomUnite <> '') then begin
          desactiverOrtho := (monde[m].axe.nomUnite <> monde[mondeX].axe.nomUnite) or
             (monde[m].graduation <> gLin) or
             (monde[mondeX].graduation <> gLin);
          if desactiverOrtho then begin
             verifierOrtho := false;
             exclude(optionGraphe,ogOrthonorme);
             exit;
          end;
      end;
      acmX := monde[mondeX].a / PixelsPerInchX;
      acmY := monde[m].a / PixelsPerInchY;
      rapport := abs(acmX / acmY);
      verifierOrtho := verifierOrtho or
        (((rapport > 100) or (rapport < 0.01)));
      if rapport > 1.002 then
        with monde[mondeX] do begin
          b := b + (maxi + mini) / 2 * (a - abs(monde[m].a));
          // On conserve la position du milieu
          a := abs(monde[m].a / pixelsPerInchY * pixelsPerInchX);
          miniOrtho := (limiteCourbe.left - b) / a;
          maxiOrtho := (limiteCourbe.right - b) / a;
          orthonorme := True;
          setDelta(grandAxeX);
        end;
      // 0.2 % pour éviter mise à jour intempestive durant animation
      if rapport < 0.998 then
        with monde[m] do begin
          aYnew := -monde[mondeX].a * pixelsPerInchY / pixelsPerInchX;
         // if axeYpositif then aYnew := -aYnew;
          b := b + (maxi + mini) / 2 * (a - aYnew);
          // On conserve le milieu
          a := aYnew;
          maxiOrtho := (CourbeTop - b) / a;
          miniOrtho  := (CourbeBottom - b) / a;
          orthonorme := True;
        end;
    end; // ajusteOrthonorme

  begin with monde[m] do begin
      if abs(Mini) < (Maxi - Mini) * 1e-2 then Mini := 0;
      case Graduation of
         gLog:  if (maxi - mini) < 0.1 then Maxi := Mini + 1;  // 1 décade
         gdB:  if (maxi - mini) < 1 then Maxi  := Mini + 20; // 20 dB
         gLin, gInv:  if (maxi - mini) < 1E-30 then Maxi := Mini + 1E-3;  // limite = masse d'un proton = 1e-27
         gBits:  if (maxi - mini) < 1 then Maxi := Mini + 8;
      end;
      A := (CourbeTop - CourbeBottom) / (Maxi - Mini);
      b := CourbeBottom - Mini * a;
      if axeInverse then begin
          a := -a;
          b := CourbeBottom - Maxi * a;
      end;
      maxiOrtho := maxi;
      miniOrtho := mini;
      margeLoc := (CourbeBottom-CourbeTop) div 32;
      maxiInt := CourbeBottom+margeLoc;
      miniInt := CourbeTop-margeLoc;
      if (OgPolaire in OptionGraphe) or (OgOrthonorme in OptionGraphe) then
        ajusteOrthonorme;
      setDelta(grandAxeY);
      if (graduation = gBits) and
         (mini > -512) and
         (maxi < 1536) then begin // 512 de marge
        NombreBits := ceil(ln(maxi) / ln(2));
        if NombreBits > 10 then NombreBits := 10; // 10 bits de GTS2
        if NombreBits < 1 then NombreBits := 1;
        ecartBit := (CourbeTop - CourbeBottom) div NombreBits;
        valeurBit := ecartBit * 3 div 4;
      end;
  end  end; // chercheProjectionY

  procedure chercheProjectionX;
  begin with monde[mondeX] do begin
      if abs(Mini) < (Maxi - Mini) * 1e-2 then Mini := 0;
      if (Maxi - Mini)<1E-12 then Maxi := Mini + 1e-9;
      if (axe <> nil) and (axe.formatU in [fDateTime, fDate, fTime]) then
        zeroInclus := False;
      A := (limiteCourbe.right - limiteCourbe.left) / (Maxi - Mini);
      B := limiteCourbe.left - Mini * A;
      if axeInverse then begin
          a := -a;
          B := limiteCourbe.left - Maxi * A;
      end;
      maxiOrtho := maxi;
      miniOrtho := mini;
      maxiInt := limiteCourbe.right+marge;
      miniInt := limiteCourbe.left-marge;
      setDelta(grandAxeX);
  end end;

  procedure AjusteZero;

    procedure ajusteYNeg(m: TindiceMonde; NouveauZero: integer);
    begin with monde[m] do begin
        b := NouveauZero;
        if (a * Mini + b) > CourbeBottom then
          a := (CourbeBottom - b) / Mini;
        if (a * Maxi + b) < CourbeTop then
          a := (CourbeTop - b) / Maxi;
        mini := (CourbeBottom - b) / a;
        maxi := (CourbeTop - b) / a;
    end end;

    procedure ajusteYPos(m: TindiceMonde; NouveauZero: integer);
    begin with monde[m] do begin
        b := NouveauZero;
        if (a * Mini + b) < CourbeBottom then
          a := (CourbeBottom - b) / Mini;
        if (a * Maxi + b) > CourbeTop then
          a := (CourbeTop - b) / Maxi;
        mini := (CourbeBottom - b) / a;
        maxi := (CourbeTop - b) / a;
    end end;

  var
    m: TindiceMonde;
    z, z1, n, zMilieu: integer;
  begin // ajusteZero
    n := 0;
    z := 0;
    for m := mondeY to high(TindiceMonde) do
      with monde[m] do
        if defini and (graduation = gLin) then begin
          z1 := round(b);
          if z1 < CourbeTop then
              z1 := CourbeTop;
          if z1 > CourbeBottom then
              z1 := CourbeBottom;
          z := z + z1;
          Inc(n);
        end;
    if n < 2 then
      exit;
    z := z div n;
    // On prend le zéro moyen
    with monde[mondeY] do
      zMilieu := (courbeTop + CourbeBottom) div 2;
    for m := mondeY to high(TindiceMonde) do
      with monde[m] do
        if defini and (graduation = gLin) and
          (abs(b - zMilieu) < abs(z - zMilieu)) then
          z := round(b);
    // On prend le zéro le plus proche du centre
    for m := mondeY to high(TindiceMonde) do
      with monde[m] do
        if defini and (graduation = gLin) then begin
             ajusteYNeg(m, z);
        end;
  end; // ajusteZero

  procedure ChercheMondeVecteur;
  var
    i, j, indexXvar, indexXder, indexYder, m: integer;
    xx, yy: Tvecteur;
  begin
    for m := 1 to 2 do
      mondeVecteur[m].raz;
    for i := 0 to pred(courbes.Count) do
      with courbes[i] do begin
        if (trVitesse in trace) then begin
          try
            indexXvar := varX.indexG;
            indexXder := indexVitesse(varX.nom);
            indexYder := indexVitesse(varY.nom);
            varder[mondeVitesse] := grandeurs[indexXder];
            if pages[page].valeurVar[indexXvar] = valX then begin
              valXder := pages[page].valeurVar[indexXder];
              valYder := pages[page].valeurVar[indexYder];
            end
            else begin
              valXder := pages[page].valeurLisse[indexXder];
              valYder := pages[page].valeurLisse[indexYder];
            end;
            if OgPolaire in OptionGraphe then begin
              setLength(xx, pages[page].nmes);
              for j := 0 to pred(pages[page].nmes) do
                  xx[j] := valXder[j] * valY[j]; { r d(theta)/dt }
              mondeVecteur[MondeVitesse].trouve(xx, valYder, pages[page].nmes);
              finalize(xx);
            end
            else
              mondeVecteur[MondeVitesse].trouve(valXder, valYder, pages[page].nmes);
            mondeVecteur[MondeVitesse].mondeOrd := iMondeC;
          except
            exclude(trace, trVitesse);
          end;
        end; // vitesse
        if trAcceleration in trace then begin
          try
            indexXvar := varX.indexG;
            indexXder := indexAcceleration(varX.nom);
            indexYder := indexAcceleration(varY.nom);
            varDer[mondeAcc] := grandeurs[indexXder];
            if pages[page].valeurVar[indexXvar] = valX then begin
              valXder2 := pages[page].valeurVar[indexXder];
              valYder2 := pages[page].valeurVar[indexYder];
            end
            else begin
              valXder2 := pages[page].valeurLisse[indexXder];
              valYder2 := pages[page].valeurLisse[indexYder];
            end;
            if OgPolaire in OptionGraphe then begin
              setLength(xx, pages[page].nmes);
              setLength(yy, pages[page].nmes);
              for j := 0 to pred(pages[page].nmes) do begin
                xx[j] := 2 * valXder[j] * valYder[j] + valYder[j] * valXder2[j];
                // 2.dr/dt.d(teta)/dt+rd2tezta/dt2
                yy[j] := valYder2[j] - valY[j] * sqr(valXder[j]);
                // d2r/dt2-r.d(teta)/dt
              end;
              mondeVecteur[mondeAcc].trouve(xx, yy, pages[page].nmes);
              finalize(xx);finalize(yy);
            end
            else
              mondeVecteur[mondeAcc].trouve(valXder2, valYder2, pages[page].nmes);
            mondeVecteur[mondeAcc].mondeOrd := iMondeC;
          except
            exclude(trace, trAcceleration);
          end;
        end; // acceleration
      end;// fot i
  end; // ChercheMondeVecteur

  procedure setGraduationZero;

  function testZero(m : TindiceMonde) : boolean;
  begin
      result := monde[m].mini*monde[m].maxi <= 0;
      if not result then
         if monde[m].maxi>0
            then begin
               result := monde[m].mini<monde[m].maxi/100;
               if result then monde[m].mini := 0;

            end
            else begin
              result := abs(monde[m].maxi)<abs(monde[m].mini)/100;
              if result then monde[m].maxi := 0;
            end;
  end;

  var
    m: TindiceMonde;
    gradZero: boolean;
  begin
    gradZero := (OgZeroGradue in OptionGraphe) and not
      (OgAnalyseurLogique in OptionGraphe) and not (OgPolaire in OptionGraphe);
    graduationZeroY := gradZero and (monde[mondeY].graduation = gLin) and
      testZero(mondeY);
    if graduationZeroY and not (OgMemeZero in OptionGraphe) then
      for m := mondeDroit to high(TIndiceMonde) do
        GraduationZeroY := GraduationZeroY and not (monde[m].defini);
    graduationZeroX := gradZero and (monde[mondeX].graduation = gLin) and
      testZero(mondeX);
  end;

var
  i, k, N: integer;
  m: TindiceMonde;
  margeCourbe, hauteurCourbe: integer;
  NbreMonde: integer;
  MiniCommun, MaxiCommun: double;
  pixelsX: integer;
  limite, decalage: integer;
  avecIndicateur: boolean;
  avecCouleursSpectre: boolean;
begin // ChercheMonde 
  grapheOK := True;
  for m := low(TindiceMonde) to high(TindiceMonde) do
      monde[m].autoTick := autoTick;
  if not monde[mondeX].Defini then begin
    if not useDefautX
       then monde[mondeX].raz(OgPolaire in OptionGraphe);
    if not useDefaut then
      for m := mondeY to high(TIndiceMonde) do
        monde[m].raz(OgPolaire in OptionGraphe);
    avecIndicateur := False;
    avecCouleursSpectre := False;
    for i := 0 to pred(courbes.Count) do
      with courbes[i] do
        if (indexModele = 0) or courbeExp or
          ((OmEchelle in OptionModele) and (indexModele > 0)) then begin
          if not useDefaut then
            if useDefautX
               then grapheOK := grapheOK and monde[iMondeC].Trouve(valY, debutC, finC)
               else findWorld(iMondeC, valX, valY, DebutC, FinC);
          monde[iMondeC].Defini := True;
          monde[mondeX].Defini := True;
          avecIndicateur := avecIndicateur or (trIndicateur in trace);
          avecCouleursSpectre := avecCouleursSpectre or (trCouleursSpectre in trace);
        end; // OmEchelle in OptionModele 
    if not avecIndicateur then
      indicateur := nil;
    grapheOK := grapheOK and (Courbes.Count > 0);
    for m := low(TIndiceMonde) to high(TIndiceMonde) do
      with monde[m] do
        if graduation = gInv then begin
          swap(mini, maxi);
          try
            maxi := 1 / maxi;
            mini := 1 / mini;
          except
            verifierInv := True;
            mini := 1;
            maxi := 10;
          end;
        end;
  end; // not(monde[mondeX].Defini)
  ChercheMondeVecteur;
  for m := low(TIndiceMonde) to high(TIndiceMonde) do
      monde[m].setDefaut;
  if OgAnalyseurLogique in OptionGraphe then begin
    NbreMonde  := 0;
    MondeDebut := 0;
    MiniCommun := +MaxReal;
    MaxiCommun := -MaxReal;
    for m := mondeY to high(TIndiceMonde) do
      with monde[m] do
        if defini then begin
          Inc(NbreMonde);
          if mini < miniCommun then
            miniCommun := mini;
          if maxi > maxiCommun then
            maxiCommun := maxi;
          if MondeDebut = 0 then
            MondeDebut := m;
        end;
    if OgMemeEchelle in optionGraphe then
      for m := mondeY to high(TIndiceMonde) do
        with monde[m] do
          if defini then begin
            mini := miniCommun;
            maxi := maxiCommun;
          end;
    if NbreMonde = 0 then NbreMonde := 1;
  end
  else NbreMonde := 1;
  with limiteFenetre do begin
    grapheOK  := (bottom - top) > succ(nbreMonde) * 20;
    avecAxeY  := not sansAxeY and
       ((bottom - top) div 5 > NbreGradMin * hautCarac * NbreMonde div 4);
    avecAxeX  := not sansAxeX and
       ((right - left) > NbreGradMin * 4 * largCarac);
    grandAxeY := (bottom - top) div 5 > NbreGradMax * HautCarac * NbreMonde div 4;
    grandAxeX := (right - left) > NbreGradMax * 4 * largCarac;
  end;
  limiteCourbe := limiteFenetre;
  Inc(limiteCourbe.left, Marge);
  Dec(limiteCourbe.bottom, Marge);
  if not (OgAnalyseurLogique in OptionGraphe) then
    Inc(limiteCourbe.top, hautCarac + Marge);
  Dec(limiteCourbe.right, Marge);
  if identificationPages and superposePage then
     Dec(limiteCourbe.right, 20*largCarac);
  setGraduationZero;
  decalage := succ(monde[mondeY].NbreChiffres) * largCarac;
  if avecAxeY then begin
    if monde[mondeY].defini and not (OgPolaire in OptionGraphe) and
      not (graduationZeroX) then
      Inc(limiteCourbe.left, decalage)
    else if GraduationZeroX then begin
      with monde[mondeX] do
        limite :=
          round((limiteCourbe.right - limiteCourbe.left) * mini /
          (mini - maxi)); { mini <=0 }
      if limite < decalage then
        Inc(limiteCourbe.left, decalage);
    end;
    if monde[mondeDroit].defini and not
      (OgAnalyseurLogique in OptionGraphe) then
      Dec(limiteCourbe.right, succ(monde[mondeDroit].NbreChiffres) * largCarac);
  end;
  if avecAxeX and not (OgPolaire in OptionGraphe) and not
    (GraduationZeroY) then
    Dec(limiteCourbe.bottom, 2 * HautCarac + marge)
  else if graduationZeroY then begin
    with monde[mondeY] do
      limite := round(
        (limiteCourbe.bottom - limiteCourbe.top) * mini /
        (mini - maxi));
    if limite < 2 * hautCarac then
      Dec(limiteCourbe.bottom, 2 * HautCarac);
  end;
  for m := mondeY to high(TIndiceMonde) do
     with monde[m] do begin
        CourbeTop := LimiteCourbe.top;
        CourbeBottom := LimiteCourbe.bottom;
     end;
  for m := 1 to 2 do
    with mondeVecteur[m], limiteCourbe do
      Dimension := (bottom - top) + (right - left);
  if OgAnalyseurLogique in OptionGraphe then begin
    i := 0;
    if superposePage
       then begin
          margeCourbe := marge;
          Inc(limiteCourbe.top, hautCarac + Marge);
       end
       else margeCourbe := hautCarac + marge;
    hauteurCourbe := (LimiteCourbe.bottom - LimiteCourbe.top) div
      NbreMonde - margeCourbe;
      for m := mondeY to high(TIndiceMonde) do
        with monde[m] do
          if defini then begin
            CourbeTop := LimiteCourbe.top + i * hauteurCourbe + succ(i) * margeCourbe;
            CourbeBottom := CourbeTop + hauteurCourbe;
            Inc(i);
          end;
  end;
  grapheOK := grapheOK and monde[mondeX].defini;
  if grapheOK then begin
    chercheProjectionX;
    for m := mondeY to high(TindiceMonde) do
        if monde[m].defini then
           chercheProjectionY(m);
    if (OgOrthonorme in OptionGraphe) then
      setGraduationZero;
    for m := 1 to 2 do with mondeVecteur[m] do
        if defini then begin
          if -monde[mondeY].a > monde[mondeX].a then begin
            ax := dimension * EchelleVecteur / maxi;
            ay := ax * monde[mondeOrd].a / monde[mondeX].a;
          end
          else begin
            ay := -dimension * EchelleVecteur / maxi;
            ax := ay * monde[mondeX].a / monde[mondeOrd].a;
          end;
          if imprimanteEnCours then begin // echelle multiple du cm
            try
              pixelsX := GetDeviceCaps(Printer.handle, LogPixelsX);
              k := 0;
              repeat
                Inc(k);
                N := floor(echelle * Nbre125[k] * ax * 2.54 / pixelsX);
              until (N > 0) or (k = 3);
              if N > 0 then begin
                ax := N * pixelsX / (echelle * Nbre125[k] * 2.54);
                ay := ax * monde[mondeOrd].a / monde[mondeX].a;
              end;
            except
            end;
          end; // defini
        end;
    if (OgMemeZero in OptionGraphe) and not
      (OgAnalyseurLogique in OptionGraphe) then
      ajusteZero;
  end;
end; // ChercheMonde

procedure TGrapheReg.SetMonde(m: TindiceMonde; minX, minY, maxX, maxY: double);

  procedure chercheProjection;
  begin
    with monde[mondeX] do begin
      defini := True;
      Maxi := MaxX;
      Mini := MinX;
      A := (limiteCourbe.right - limiteCourbe.left) / (Maxi - Mini);
      B := limiteCourbe.left - Mini * A;
      if axeInverse then begin
         a := -a;
         B := limiteCourbe.left - Maxi * A;
       end;
    end;
    with monde[m] do begin
      defini := True;
      Maxi := MaxY;
      Mini := MinY;
      A := (CourbeTop - CourbeBottom) / (Maxi - Mini);
      B := CourbeBottom - Mini * A;
      if axeInverse then begin
         a := -a; 
         B := CourbeBottom - Maxi * A;         
       end;
    end;
  end;

begin // setMonde
  with limiteFenetre do begin
    avecAxeY  := (bottom - top) > NbreGradMin * hautCarac * 5 div 4;
    avecAxeX  := (right - left) > NbreGradMin * 4 * largCarac;
    grandAxeY := (bottom - top) > NbreGradMax * hautCarac * 5 div 4;
    grandAxeX := (right - left) > NbreGradMax * 4 * largCarac;
  end;
  limiteCourbe := limiteFenetre;
  Inc(limiteCourbe.left, Marge);
  Dec(limiteCourbe.bottom, Marge);
  Inc(limiteCourbe.top, hautCarac + Marge);
  Dec(limiteCourbe.right, Marge);
  if avecAxeX then
    Dec(limiteCourbe.bottom, 2 * hautCarac);
  if avecAxeY and monde[mondeY].defini then
    Inc(limiteCourbe.left, succ(monde[mondeY].NbreChiffres) * largCarac);
  for m := mondeY to high(TIndiceMonde) do
    with monde[m] do begin
      CourbeTop := LimiteCourbe.top;
      CourbeBottom := LimiteCourbe.bottom;
    end;
  chercheProjection;
end; // SetMonde

procedure TGrapheReg.AjoutePoint(m: TindiceMonde; XX, YY: double);
begin
  with monde[mondeX] do begin
    case graduation of
      gLog: xx := Log10(xx);
      gInv: xx := 1 / xx;
    end;
    if XX > Maxi then
      Maxi := XX;
    if XX < Mini then
      Mini := XX;
  end;
  with monde[m] do begin
    case graduation of
      gLog: yy := Log10(yy);
      gdB: yy  := 20 * Log10(yy);
      gInv: yy := 1 / yy;
    end;
    if YY > Maxi then
      Maxi := YY;
    if YY < Mini then
      Mini := YY;
  end;
end;

procedure TGrapheReg.TraceCourbe(index: integer);
var
  couleurLoc: Tcolor;

  procedure TracePoint(Pixel: boolean);
  var
    x0, y0, decaleLoc: integer;
    xi, yi: integer;
    motifLoc: Tmotif;
    avecCouleurPoint : boolean;
    teinte : double;

    procedure InitSpectre;
    var zeroY : double;
    begin with courbes[index] do begin
        if monde[iMondeC].graduation = gLin
           then zeroY := 0
           else zeroY := monde[iMondeC].mini;
        WindowXY(valX[debutC], zeroY, iMondeC, x0, y0);
        if OgAnalyseurLogique in OptionGraphe
           then decaleLoc := 0
           else decaleLoc := decalage * coeffDecalage;
        WindowRT(valX[finC], zeroY, iMondeC, xi, yi);
        Segment(x0 + decaleLoc, y0 - decaleLoc, xi + decaleLoc, yi - decaleLoc);
       // ligne de base
        pixel := False;
    end end;

    procedure InitTeinte;
    var posErreur, LongErreur: integer;
        i : integer;
    begin
          avecCouleurPoint := false;
          if courbes[index].couleurPoint<>'' then begin
             grandeurImmediate.fonct.expression := courbes[index].couleurPoint;
             for i := 0 to pred(NbreGrandeurs) do
                 include(grandeurImmediate.fonct.depend, i);
             avecCouleurPoint := grandeurImmediate.fonct.compileF(posErreur, LongErreur,false,ParamNormal,0);
          end;
    end;

  var
    maxiY, miniY: integer;
    PolyLigne: array[1..5] of Tpoint;
    x1, y1: integer;
    x2, y2: integer;
    i, largeurHisto,taillePixel : integer;
    avecIndicateur: boolean;
    avecCouleursSpectre: boolean;

    procedure InitHisto;
    var
      i, larg: integer;
    begin with courbes[index] do begin
        if (monde[iMondeC].graduation = gLin) and
           (monde[MondeX].graduation = gLin) then begin
          WindowXY(0, monde[iMondeC].mini, iMondeC, x0, y0);
          WindowXY(valX[DebutC], valY[DebutC], iMondeC, x1, y1);
          WindowXY(valX[FinC], valY[FinC], iMondeC, x2, y2);
          largeurHisto := (abs(x2 - x1) div (FinC - debutC)) div 2;
          pixel := False;
          if (FinC - debutC) < 64 then begin
            for i := DebutC to pred(FinC) do begin
              WindowXY(valX[i], valY[i], iMondeC, x1, y1);
              WindowXY(valX[i + 1], valY[i + 1], iMondeC, x2, y2);
              larg := abs(x2 - x1) div 2;
              if larg < largeurHisto then
                largeurHisto := larg;
            end;
          end;
          if largeurHisto > 1 then
            largeurHisto := largeurHisto - 1;
        end
        else motif := mCroix;
        inc(numeroHisto);
    end end;

    procedure TraceUnPoint;
    var PoinTinactif : boolean;
    begin with courbes[index] do begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if avecIndicateur then begin
          couleurLoc := indicateur.couleurPH(valY[i]);
          CreateSolidBrush(couleurLoc);
          if motif in [mCerclePlein,mCarrePlein]
             then CreatePenFin(psSolid, clBlack)
             else CreatePen(psSolid, 1, couleurLoc);
        end;
        if avecCouleursSpectre then begin
           couleurLoc := couleurWL(valX[i]);
           CreateSolidBrush(couleurLoc);
           CreatePen(psSolid, 1, couleurLoc);
        end;
        if avecCouleurPoint then begin
           AffecteVariableE(i);
           teinte := calcule(grandeurImmediate.fonct.calcul);
           case codeCouleur of
                tHue: couleurLoc := teintetoRGB(teinte);
                tSigne: couleurLoc := SignetoRGB(teinte);
           end;
           CreateSolidBrush(couleurLoc);
           CreatePen(psSolid, 1, couleurLoc);
        end;
        if (xi > 0) and (yi >= miniY) and (yi <= maxiY) then
          if Pixel then begin
             if taillePixel=0
                then canvas.Pixels[xi, yi] := couleurLoc
                else canvas.ellipse(xi - taillePixel, yi - taillePixel, xi + taillePixel + 1, yi + taillePixel + 1);
          end
          else begin
            PointInactif := not pages[page].PointActif[i];
            if PointInactif then begin
               CreatePenFin(psSolid, clSilver);
               if motif in [mCerclePlein,mCarrePlein] then CreateSolidBrush(clSilver);
            end;
            case MotifLoc of
              mCroix: begin
                Segment(xi - dimPoint, yi, xi + dimPoint, yi);
                Segment(xi, yi - dimPoint, xi, yi + dimPoint);
              end;
              mCroixDiag: begin
                segment(xi - dimPoint, yi - dimPoint, xi + dimPoint, yi + dimPoint);
                segment(xi + dimPoint, yi - dimPoint, xi - dimPoint, yi + dimPoint);
              end;
              mCercle, mCerclePlein:
                canvas.ellipse(xi - dimPoint, yi - dimPoint, xi + dimPoint + 1, yi + dimPoint + 1);
              mCarre, mCarrePlein: canvas.rectangle(xi - dimPoint, yi -
                  dimPoint, xi + dimPoint, yi + dimPoint);
              mLosange: begin
                PolyLigne[1] := Point(xi - dimPoint, yi);
                PolyLigne[2] := Point(xi, yi - dimPoint);
                PolyLigne[3] := Point(xi + dimPoint, yi);
                PolyLigne[4] := Point(xi, yi + dimPoint);
                PolyLigne[5] := Point(xi - dimPoint, yi);
                canvas.polyLine(PolyLigne);
// polyLine ne remplit pas donc pas de LosangePlein
              end;
              mSpectre: begin
                segment(xi, y0, xi + decaleLoc, y0 - decaleLoc); // ligne de rappel
                canvas.lineTo(xi + decaleLoc, yi - decaleLoc); // harmonique
              end;
              mEchantillon: begin
                segment(xi, y0, xi, yi);
                canvas.ellipse(xi - dimPoint, yi - dimPoint, xi + dimPoint + 1, yi + dimPoint + 1);
              end;
              mBarreD: Segment(xi - 2, y0, xi - 2, yi);
              mBarreG: Segment(xi + 2, y0, xi + 2, yi);
              mHisto: if largeurHisto = 0
                 then segment(xi, y0, xi, yi) // sinon windows ne trace rien !
                 else canvas.rectangle(xi - largeurHisto, y0, xi + largeurHisto, yi);
              mReticule: begin
                WindowRT(monde[mondeX].mini,monde[iMondeC].mini, iMondeC, x0, y0);
//                WindowRT(monde[mondeX].maxi,monde[iMondeC].maxi, iMondeC, x1, y1);
                if yi<>y0 then Segment(x0, yi, xi, yi);
                if xi<>x0 then Segment(xi, y0, xi, yi);
                canvas.ellipse(xi - dimPoint, yi - dimPoint, xi + dimPoint + 1, yi + dimPoint + 1);
              end;
              mLigneH: Segment(xi - dimPoint, yi, xi + dimPoint, yi);
              mIncert: if (varX = nil) or
                          (IncertX = nil) or
                          (varY = nil) or
                          (IncertY = nil)
                then case traceIncert of
                   iRectangle : canvas.rectangle(xi - 1, yi - 1, xi + 1, yi + 1);
                   iCroix : begin
                      Segment(xi-1, yi, xi+1, yi);
                      Segment(xi, yi-1, xi, yi+1);
                   end;
                   iEllipse :  canvas.ellipse(xi - 1, yi - 1, xi + 1, yi + 1);
                end
                else begin
                  WindowRT(valX[i] + CoeffEllipse * IncertX[i],
                    valY[i] - CoeffEllipse * IncertY[i], iMondeC, x2, y2);
                  WindowRT(valX[i] - CoeffEllipse * IncertX[i],
                    valY[i] + CoeffEllipse * IncertY[i], iMondeC, x1, y1);
                  if ((x1 = x2) and (y2 = y1)) or
                    (x1 <0) or
                    (x2 <0) or
                    (y1 <0) or
                    (y2 <0)
                  then case traceIncert of
                     iRectangle : canvas.rectangle(xi - 1, yi - 1, xi + 1, yi + 1);
                     iEllipse : canvas.rectangle(xi - 1, yi - 1, xi + 1, yi + 1);
                     iCroix : begin
                          Segment(xi-1, yi, xi+1, yi);
                          Segment(xi, yi-1, xi, yi+1);
                     end;
                  end
                  else begin
                  case traceIncert of
                  iCroix : begin
                    Segment(x1, yi, x2, yi);
                    Segment(xi, y1, xi, y2);
                  end;
                  iEllipse : if (x1 = x2) or (y1 = y2)
                    then begin
                         Segment(x1, yi, x2, yi);
                         Segment(xi, y1, xi, y2);
                    end
                    else begin
                    Segment(xi, yi - 1, xi, yi + 1);
                    Segment(xi - 1, yi, xi + 1, yi);
                    canvas.ellipse(x1, y1, x2 + 1, y2 + 1);
                    // +1 nécessaire pour centrer mais pourquoi ??
                  end;
                  iRectangle : begin
                     Segment(xi, yi, xi, yi);
                     Segment(xi, yi, xi, yi);
                     canvas.rectangle(x1, y1, x2, y2);
                  end;
                  end; // case TraceIncert
                  if x1=x2 then Segment(x1-1, yi, x1+1, yi);
                  if y1=y2 then Segment(xi, y1-1, xi, y1+1);
                  end;
                end // Incertitude
            end; // case motif
          if PointInactif then begin // Mise en évidente et retour état initial
             canvas.brush.style := bsClear;
             canvas.ellipse(xi - 2 * dimPoint, yi - 2 * dimPoint, xi + 2 * dimPoint + 1, yi + 2 * dimPoint + 1);
             CreatePen(psSolid, canvas.pen.Width, couleurLoc);
             if motif in [mCerclePlein,mCarrePlein] then CreateSolidBrush(couleurLoc);
          end;
          end;
    end end; // traceUnPoint

  var largeur: integer;
      codeHatch : TbrushStyle;
      avecIncert : boolean;
      sauveMotif : Tmotif;
      pasLoc,iDebut,iFin : integer;
      penWidthMax : integer;
  begin with courbes[index] do begin
      sauveMotif := motif;
      avecIndicateur := (trIndicateur in trace) and
        (oiEchelleTeinte in OptionsIndicateur);
      avecCouleursSpectre := (trCouleursSpectre in trace);
      if motif in [mHisto, mBarreD, mBarreG] then
        initHisto;
      if avecIndicateur then begin
        canvas.pen.style := psClear;
        if indicateur.AcideBaseIncolore and not
          (motif in [mCerclePlein, mCarrePlein]) then
          motif := mCerclePlein;
      end;
      initTeinte;
      if avecCouleursSpectre then begin
          CreatePenFin(psClear, clWhite);
          motif := mCerclePlein;
      end;
      maxiY := monde[iMondeC].maxiInt;
      miniY := monde[iMondeC].miniInt;
      avecIncert := avecEllipse and
          (varY.incertDefinie or varX.incertDefinie);
      if avecIncert
         then begin
            if not (motif in [mSpectre, mEchantillon, mHisto, mBarreD, mBarreG])
               then motif := mIncert;
         end
         else if (motif = mIncert) then motif := motifInit[(index mod maxOrdonnee)+1];
      if (motif in [mCroix,mCroixDiag,mCercle,mCarre,mLosange]) and (finC<32)
         then CreatePen(psSolid, penWidthCourbe, couleurLoc)
         else CreatePen(psSolid, 1, couleurLoc);// par défaut
      if (motif=mSpectre) then begin
         x1 := windowX(valX[1]);
         x2 := windowX(valX[2]);
         penWidthMax := x2-x1;
         if penWidthMax = 0 then penWidthMax := 1;
         if penWidthCourbe<=penWidthMax
            then CreatePen(psSolid, penWidthCourbe, couleurLoc)
            else CreatePen(psSolid, penWidthMax, couleurLoc);
      end;
      motifLoc := motif;
      if not avecAnimTemporelle and
         superposePage and (motif <= mCarrePlein) and
         (page <> 0) and (SPmotif=reperePage)
              then motifLoc := motifPages[page mod MaxPagesGr];
      if pixel and (penwidth>1) then begin
         CreateSolidBrush(couleurLoc);
         taillePixel := penWidth div 2;
      end
      else taillePixel := 0;
      case MotifLoc of
        mCerclePlein, mCarrePlein: CreateSolidBrush(couleurLoc);
        mHisto: if largeurHisto < 11 then begin
            CreateSolidBrush(couleurLoc);
            Canvas.pen.Width := 1;
            if numeroHisto>1 then canvas.Pen.Mode := pmMerge;
          end
          else begin
            largeurHisto := largeurHisto - 2; // pour la taille du crayon
            if (indexModele = 0) or courbeExp then begin
              case indexHisto of
                0: codeHatch := bsFDIAGONAL; //  45-degree upward left-to-right hatch
                1: codeHatch := bsHORIZONTAL; //  Horizontal hatch
                2: codeHatch := bsVERTICAL; //  Vertical hatch
                //  3 : codeHatch := bsCROSS; //  Horizontal and vertical crosshatch
                //  4 : codeHatch := bsDIAGCROSS; // 45-degree crosshatch
                else codeHatch := bsBDIAGONAL; // 45-degree downward left-to-right hatch
              end;
              Inc(indexHisto);
              indexHisto := indexHisto mod 3;
              largeur := 3;
            end
            else begin // modélisation
              largeur := 1;
              codeHatch := bsHORIZONTAL; //  Horizontal hatch
            end;
            createHatchBrush(codeHatch, couleurLoc);
            canvas.pen.Width := largeur;
          end;
        mBarreD, mBarreG: CreatePen(psSolid, 3, couleurLoc);
        mEchantillon: begin
          if monde[iMondeC].graduation = gLin
             then WindowXY(0, 0, iMondeC, x0, y0)
             else WindowXY(0, monde[iMondeC].mini, iMondeC, x0, y0);
          CreateSolidBrush(couleurLoc);
          pixel := False;
        end;
        mLigneH: ;
        mSpectre: initSpectre;
        mIncert: pixel := False;
      end;
      iDebut := debutC;
      iFin := finC;
      if avecAnimTemporelle
         then begin
           i := NumAnim;
           traceUnPoint;
         end
         else begin
            if (grandeurs[indexTri] = varX) or
               (grandeurs[cFrequence] = varX)
             then begin
                pasLoc := (finC-debutC) div (2*limiteFenetre.width);
                if pasLoc=0 then pasLoc := 1;
                if pasLoc<pasPoint then pasLoc := pasPoint;
                // (grandeurs[indexTri] = varX) or (grandeurs[cFrequence] = varX)
                if (pasPoint=1) and (pasLoc>1) and not (OgPolaire in OptionGraphe) then begin
                   xi := windowX(valX[iDebut]);
                   while (xi<0) and (iDebut < finC) do begin
                       Inc(idebut);
                       xi := windowX(valX[iDebut]);
                   end;
                   xi := windowX(valX[iFin]);
                   while (xi<0) and (ifin > debutC) do begin
                      Dec(iFin);
                      xi := windowX(valX[iFin]);
                   end;
                   verifMinMaxInt(iDebut,iFin); // si l'axe des x est ordonné en sens inverse de la grandeur de tri
                   pasLoc := (iFin-iDebut+1) div (2*limiteFenetre.width);
                   if pasLoc=0 then pasLoc := 1;
                end;
             end
             else pasLoc := pasPoint; // mode XY
             for i := iDebut to iFin do
                if (i mod pasLoc) = 0 then
                    traceUnPoint;
         end;
         motif := sauveMotif;
    end;
    canvas.brush.style := bsClear;
  end; // tracePoint

  function TraceBits: boolean;
  var
    masque: integer;
    ligne: integer;
    maxi: double;

    procedure traceLigneBits;
    var
      xi, yi: integer;
      niveau: array[boolean] of integer;
      i, k: integer;
      PolyLigne: array[0..MaxVecteurPoly] of Tpoint;
    begin with courbes[index] do begin
        xi := monde[mondeX].affecteEntier(valX[debutC]);
        niveau[True] := monde[iMondeC].courbeBottom + ligne * monde[iMondeC].ecartBit;
        niveau[False] := niveau[True] + monde[iMondeC].valeurBit;
        try
        yi := round(valY[debutC]);
        if yi>255 then yi := 255;
        if yi<0 then yi := 0;
        except
        yi := 0;
        end;
        yi := niveau[(yi and masque) = 0];
        PolyLigne[0] := Point(xi, yi);
        k  := 0;
        for i := succ(debutC) to finC do begin
          xi := monde[mondeX].affecteEntier(valX[i]);
          Inc(k);
          PolyLigne[k] := Point(xi, yi);
          try
          yi := round(valY[i]);
          if yi>1023 then yi := 1023;
          if yi<0 then yi := 0;
          except
          yi := 0;
          end;
          yi := niveau[(yi and masque) = 0];
          Inc(k);
          PolyLigne[k] := Point(xi, yi);
          if k>(MaxVecteurPoly-2) then begin
             canvas.PolyLine(slice(PolyLigne,k));
             k := 0;
          end;
        end; // for i
        if k > 1 then
          canvas.PolyLine(slice(PolyLigne,k));
    end end; // traceLigneBits

  var
    i: integer;
  begin with courbes[index] do begin
      Result := False;
      maxi := 0;
      for i := succ(debutC) to finC do begin
        if valY[i] < 0 then
          exit;
        if valY[i] >= 256 then
          exit;
        if valY[i] > maxi then
          maxi := valY[i];
      end;
      masque := 1;
      for ligne := 0 to monde[iMondeC].NombreBits - 1 do begin
        traceLigneBits;
        masque := masque * 2;
      end;
      Result := True;
    end;
  end; // traceBits

  procedure TraceFaussesCouleurs;
  var
    i, i0:  integer;
    x1, x2: integer;
    k, kmax, pas: integer;
    couleurT: Tcolor;
  begin
    i0 := monde[mondeY].CourbeBottom;
    kMax := abs(monde[mondeY].CourbeBottom - monde[mondeY].CourbeTop);
    pas := succ(kMax div 256 div penwidth);
    kmax := kmax div pas;
    x1 := LimiteFenetre.Left;
    x2 := x1 + largCarac;
    for k := 0 to kmax do begin
      i := i0 - k * pas;
      couleurT := GetFausseCouleur(k / kmax);
      createPen(psSolid, pas, couleurT);
      Segment(x1, i, x2, i);
    end; {for k}
  end; // traceFaussesCouleurs

  procedure TraceCouleursSpectre;
  var
    i, i0:  integer;
    xi, yi: double;
    y1, y2: integer;
    k, kmax, pas: integer;
    couleurT: Tcolor;
  begin with courbes[index] do begin
        i0 := limiteCourbe.left;
        kMax := limiteCourbe.right - limiteCourbe.left;
        pas := succ(kmax div 256);
        kmax := kmax div pas;
        y1 := LimiteFenetre.Bottom;
        y2 := y1 - largCarac;
        if pas > 1 then begin
           createPen(psClear, 0, clWhite);
           CreateSolidBrush(clWhite);
        end;
        for k := 0 to kmax do begin
          i := i0 + pas * k;
          mondeXY(i, 0, MondeY, xi, yi);
          couleurT := couleurWL(xi);
          if pas = 1 then begin
            createPenFin(psSolid, couleurT);
            Segment(i, y1, i, y2);
          end
          else begin
            createSolidBrush(couleurT);
            canvas.rectangle(i + pas, y1, i - pas, y2);
          end;
        end; // for k
        if pas > 1 then begin
        end;
        canvas.brush.style := bsClear;
  end; end; // traceCouleursSpectre

  procedure TraceIndicateur;
  var
    i, i0:  integer;
    xi, yi: double;
    x1, x2: integer;
    y1, y2: integer;
    k, kmax, pas: integer;
    couleurT: Tcolor;
  begin with courbes[index] do begin
      if oiEchelleTeinte in optionsIndicateur then begin
        i0 := monde[imondeC].CourbeTop;
        kMax := abs(monde[imondeC].CourbeBottom - monde[imondeC].CourbeTop);
        pas := succ(kmax div 256);
        kmax := kmax div pas;
        x1 := LimiteFenetre.Left;
        x2 := x1 + largCarac;
        if pas > 1 then begin
          canvas.pen.style := psClear;
          createSolidBrush(clWhite);
        end
        else begin
        end;
        for k := 0 to kmax do begin
          i := i0 + pas * k;
          mondeXY(0, i, iMondeC, xi, yi);
          couleurT := indicateur.couleurPH(yi);
          if pas = 1 then begin
            createPenFin(psSolid, couleurT);
            Segment(x1, i, x2, i);
          end
          else begin
            createSolidBrush(couleurT);
            canvas.rectangle(x1, i + pas, x2, i - pas);
          end;
        end; // for k
        if pas > 1 then begin
        end;
      end;
      if oiBandeVirage in optionsIndicateur then
        with indicateur do begin
          WindowXY(monde[mondeX].mini, pKa + dpKa, iMondeC, x1, y1);
          WindowXY(monde[mondeX].maxi, pKa - dpKa, iMondeC, x2, y2);
          createHatchBrush(bsBDIAGONAL,indicateur.couleurPH(pKa));
          canvas.pen.style := psClear;
          canvas.rectangle(x1 + 2, y1, x2, y2);
        end;
      if oiNomIndicateur in optionsIndicateur then
        with indicateur do begin
          WindowXY(monde[mondeX].mini, pKa, iMondeC, x1, y1);
          canvas.font.color := indicateur.couleurPH(pKa);
          MyTextOutFond(x1 + largCarac, y1, ' ' + nom + ' ',clWindow);
        end;
    end;
    canvas.brush.style := bsClear;
  end; // traceIndicateur

  procedure TraceTexte;
  var
    i, h: integer;
    xi, yi: integer;
    maxiY, miniY,maxiX, miniX: integer;
    pas,oldH: integer;
  begin with courbes[index] do begin
      with limiteFenetre do h := bottom - top;
      h := round(h*TexteGrapheSize/100);
      oldH := canvas.font.height;
      canvas.font.height := h;
      canvas.font.color := couleurTexte;
      maxiY  := monde[iMondeC].courbeBottom;
      miniY  := monde[iMondeC].courbeTop;
      miniX := limiteCourbe.left;
      maxiX := limiteCourbe.right;

      canvas.font.color := couleurLoc;
      canvas.brush.style := bsClear; // transparent
      canvas.TextFlags := 0; // transparent ?
      setTextAlign(TA_center + TA_baseLine);
      pas := succ((finC - debutC) div NbreTexteMax);
      if pasPoint>pas then pas := pasPoint;
      for i := DebutC to FinC do
        if ((i mod pas) = 0) then begin
          WindowRT(valX[i], valY[i], iMondeC, xi, yi);
          if (xi > 0) and
             (yi > miniY) and (yi < maxiY) and
             (xi > miniX) and (xi < maxiX) then begin
// test haut bas : Windows est incapable de gérer une cloture dans un EMF
            if not pages[page].PointActif[i] then
               canvas.font.Color := clSilver;
            mYTextOut(xi, yi,texteC[i]);
            if not pages[page].PointActif[i] then
               canvas.font.Color := couleurLoc;
          end;
        end; // for i
        canvas.font.height := oldH;
  end end; // traceTexte

const
  IntensiteMinImpr = 16;
// pour éviter de trop forcer avec les jets d'encre

  procedure TraceIntensiteLignes;
  var
    i, IntC, IntMin, debutI: integer;
    j, j1, j2: integer;
    xi, yi: integer;
    y1, y2: integer;
    ecartMax, ecart, ecart1, ecart2: integer;
    IntRef, IntReal: double;
    k, kmax, pask: integer;
    couleurT: Tcolor;
  begin
    debutI := LimiteCourbe.left;
    ecartMax := LimiteCourbe.right - LimiteCourbe.left;
    IntRef := power(abs(Monde[courbes[index].iMondeC].maxi), gammaNiveauGris);
    y1 := Monde[courbes[index].iMondeC].CourbeBottom;
    y2 := Monde[courbes[index].iMondeC].CourbeTop;
    kmax := LimiteCourbe.right - marge - LimiteCourbe.left;
    pask := 1;
    if kmax >= 1024 then begin
      pask := succ(kmax div 1024 div penwidth);
      if not odd(pask) then
        Inc(pask, 1);
      kmax := kmax div pask;
      debutI := debutI + pask div 2;
    end;
    if imprimanteEnCours
       then IntMin := IntensiteMinImpr
       else IntMin := 0;
    with courbes[index] do
      for k := 0 to kmax do begin
        i  := debutI + k * pask;
        j1 := -1;
        j2 := -1;
        ecart1 := ecartMax;
        ecart2 := ecartMax;
        for j := debutC to finC do begin
          windowRT(valX[j], 0, MondeY, xi, yi);
          ecart := abs(xi - i);
          if (xi <= i) and (ecart < ecart1) then begin
            j1 := j;
            ecart1 := ecart;
          end;
          if (xi >= i) and (ecart < ecart2) then begin
            j2 := j;
            ecart2 := ecart;
          end;
        end;
        if (j1 = -1) or (j2 = -1) then
          continue;
        if j1 = j2 then
          IntReal := abs(valY[j2])
        else
          IntReal := abs(valY[j2] * ecart1 + valY[j1] * ecart2) / (ecart1 + ecart2);
        try
          IntReal := power(IntReal, GammaNiveauGris) / IntRef;
          IntC := round(255 * IntReal);
          if IntC < IntMin then
            IntC := IntMin;
          couleurT := RGB(IntC, IntC, 0);
        except
          couleurT := RGB(IntMin, IntMin, intMin);
        end;
        createPen(psSolid, pask, couleurT);
        Segment(i, y1, i, y2);
      end; {for k}
  end; // traceIntensiteLignes

  procedure TraceSonagramme;
  var
    i, j, IntC, NbreY: integer;
    x1, y1: integer;
    x2, y2: integer;
    IntReal, deltaY: double;
    couleurT: Tcolor;
  begin with courbes[index] do begin
      canvas.pen.style := psClear;
      deltaY := valY[1] / 2;
      NbreY  := 0;
      canvas.Brush.Style := bsSolid;
      repeat
        Inc(NbreY)
      until (valY[NbreY] = 0) or (NbreY = NbrePointsSonagramme div 2);
// valY = valeur de fréquence
      x1 := monde[mondeX].affecteEntier(valX[0])+4; // +4 pour axe Y visible
// départ de 1 pour axe Y visible
      for i := 0 to pred(NbreSonagramme) do begin
        x2 := monde[mondeX].affecteEntier(valX[(i + 1) * nbrePointsSonagrammeAff]); // point suivant
        y1 := monde[mondeY].affecteEntier(deltaY);
        for j := 1 to pred(NbreY) do begin
// départ de 1 pour axe X visible
          y2 := monde[mondeY].affecteEntier(valY[j] + deltaY);
          IntReal := son[i, j]; // entre 0 et 1
          if DecadeDB > 0 then begin // logarithmique sur x décades
            try
              IntReal := 1 + log10(IntReal) / DecadeDB;
              if IntReal < 0 then
                intReal := 0;
            except
              IntReal := 0;
            end;
          end;
          if useFaussesCouleurs then
            couleurT := GetFausseCouleur(IntReal)
          else begin
            IntC := 255 - round(255 * IntReal);
            CouleurT := RGB(IntC, IntC, IntC);
          end;
          canvas.Brush.Color := couleurT;
          createSolidBrush(couleurT);
          canvas.Rectangle(x1, y2, x2+1, y1+1); // Trace de x1 à x2 et de y2 à y1
          // y2 avant y1 toujours l'axe des écrans "à l'envers"
          // +1 à cause de ps_null
          y1 := y2;
        end; {j}
        x1 := x2;
      end; {i}
      canvas.brush.style := bsClear;
  end end; // traceSonagramme

  procedure TraceIntensiteImpr;
  const
    ecartMax = 512;
  var
    i, xi, IntC: integer;
    j, j1, j2: integer;
    ecart, ecart1, ecart2: integer;
    IntRef, IntReal: double;
    Abitmap: Tbitmap;
    LimiteBitmap: Trect;
  begin with courbes[index] do begin
      Abitmap := Tbitmap.Create;
      with Abitmap do begin
        Width  := ecartMax;
        Height := 10;
        pixelFormat := pf24bit;
      end;
      Abitmap.canvas.pen.style := psSolid;
      IntRef := power(abs(Monde[courbes[index].iMondeC].maxi), gammaNiveauGris);
      for i := 0 to pred(ecartMax) do begin
        j1 := -1;
        j2 := -1;
        ecart1 := ecartMax;
        ecart2 := ecartMax;
        for j := debutC to finC do begin
          with monde[mondeX] do
            xi := round((valX[j] - mini) / (maxi - mini) * ecartMax);
          ecart := abs(xi - i);
          if (xi <= i) and (ecart < ecart1) then begin
            j1 := j;
            ecart1 := ecart;
          end;
          if (xi >= i) and (ecart < ecart2) then begin
            j2 := j;
            ecart2 := ecart;
          end;
        end;{ for j}
        if (j1 = -1) or (j2 = -1) then
          continue;
        if j1 = j2 then
          IntReal := abs(valY[j2])
        else
          IntReal := abs(valY[j2] * ecart1 + valY[j1] * ecart2) / (ecart1 + ecart2);
        try
          IntReal := power(IntReal, GammaNiveauGris) / IntRef;
          IntC := round(255 * IntReal);
          if IntC < IntensiteMinImpr then
            IntC := IntensiteMinImpr;
        except
          IntC := IntensiteMinImpr
        end;
        Abitmap.canvas.pen.color := RGB(IntC, IntC, IntC);
        Abitmap.canvas.moveTo(i, 0);
        Abitmap.canvas.lineTo(i, 9);
      end; { i }
      Printer.canvas.copyMode := cmSrcCopy;
      LimiteBitmap := Rect(LimiteCourbe.left, Monde[iMondeC].CourbeTop,
        LimiteCourbe.right, Monde[iMondeC].CourbeBottom);
      Printer.Canvas.StretchDraw(LimiteBitmap, Abitmap);
      Abitmap.Free;
    end;
  end; // traceIntensiteImpr

  procedure traceLigne;
  var
    xi, yi, pas, Nvisible :  integer;
    idebut, ifin: integer;
    sincActif : boolean;

  type
    Tprecedent = (pOK, pHaut, pBas, pNone);
  var
    i, j: integer;
    Precedent, Courant: Tprecedent;
    maxiY, miniY: integer;
    PolyLigne: array[1..MaxVecteurPoly] of Tpoint;

procedure AffecteSplineSinc;
var
  k, ordreSinc : integer;
  iX, iY: integer;
  valeurX, valeurY : Tvecteur;
  codeDerivee : integer;
begin with courbes[index] do begin
        ordreSinc := limiteFenetre.width div Nvisible;
        if (optionLigne=liSinc) and (ordreSinc<3) then exit;
        iX := varX.indexG;
        iY := varY.indexG;
        setLength(valeurX,Nvisible+1);
        setLength(valeurY,Nvisible+1);
        i := 0;
        for k := iDebut to iFin do begin
            valeurX[i] := pages[page].valeurVar[iX][k];
            valeurY[i] := pages[page].valeurVar[iY][k];
            if isNan(valeurX[i]) or isNan(valeurY[i]) then else inc(i);
        end;
        case optionLigne of
           liSinc : InterpoleSinc(valeurX, valeurY, OrdreSinc, i, valx, valy);
           liSpline : CalculBspline(valeurX, valeurY, OrdreLissage,i, valx, valy);
        end;
        iDebut := 0;
        iFin := pred(i);
        finalize(valeurX);
        finalize(valeurY);
        if (valYder=nil) and (iX=indexTri) then begin
           codeDerivee := indexDerivee(varY,varX,true,true);
           if codeDerivee<>grandeurInconnue then
              valYder := pages[page].valeurVar[codeDerivee];
        end;
        if (valYder<>nil) and (iX=indexTri) then begin
           i := 0;
           for k := succ(DebutC) to pred(FinC) do begin
              while pages[page].valeurVar[iX][k]>valx[i] do inc(i);
              valYder[k] := DeriveePonctuelleSpline(valX,valY,i,pages[page].valeurVar[iX][k]);
           end;
        end;
        sincActif := true;
end end; // affecteSplineSinc

procedure RestaureSinc; // pour récupérer les points expérimentaux
begin with courbes[index] do begin
        CopyVecteur(valX, pages[page].valeurVar[varX.indexG]);
        CopyVecteur(valY, pages[page].valeurVar[varY.indexG]);
end end;

    procedure TracePolyLine;
    var
      i: integer;
      xcourant, ycourant: integer;

      procedure Nettoie(var idebut: integer);
      var
        k, ifin, Lecart: integer;
        Lmaxi, Lmini, entree, sortie: integer;
      begin // idebut et suivant sur la même verticale
        xCourant := PolyLigne[idebut].x;
        entree := PolyLigne[idebut].y;
        Lmaxi := entree;
        Lmini := entree;
        k := idebut + 1;
        repeat
          yCourant := PolyLigne[k].y;
          if yCourant > Lmaxi then
            Lmaxi := ycourant;
          if yCourant < Lmini then
            Lmini := ycourant;
          Inc(k);
        until (k = j) or (PolyLigne[k].x <> xCourant); // verticale différente
     // enlever points inutiles
        iFin := pred(k);
        sortie := PolyLigne[ifin].y;
        k := idebut; // on garde début
        if entree > sortie then begin
          if Lmini < sortie then begin
            Inc(k);
            PolyLigne[k].y := Lmini;
          end;
          if Lmaxi > entree then begin
            Inc(k);
            PolyLigne[k].y := Lmaxi;
          end;
        end
        else begin
          if Lmini < entree then begin
            Inc(k);
            PolyLigne[k].y := Lmini;
          end;
          if Lmaxi > sortie then begin
            Inc(k);
            PolyLigne[k].y := Lmaxi;
          end;
        end;
        Inc(k);
        PolyLigne[k].y := sortie;
        Lecart  := ifin - k;
        idebut := succ(k); // prochain debut
        Dec(j, Lecart);
        for k := idebut to j do
          PolyLigne[k] := PolyLigne[k + Lecart];
      end; // Nettoie

      procedure remplitInterpole;

      procedure affecteUnPoint(ax,ay : integer);
      begin with courbes[index] do begin
          if valXe=nil then begin
             setLength(valxE,256);
             setLength(valyE,256);
             lenvalxe := length(valXE);
          end;
          if lenvalXE<=finE then begin
             setLength(valxE,finE+256);
             setLength(valyE,finE+256);
             lenvalxe := length(valXE);
          end;
          valxE[finE] := ax;
          valyE [finE] := ay;
          inc(finE);
      end end;

      var pente : single;
          i,k : integer;
          x0,y0 : integer;
       // pas := screen.Width div 1024 ?
      begin with courbes[index] do begin
       for i := 0 to j-1 do begin
             x0 := PolyLigne[i].x;
             y0 := PolyLigne[i].y;
             pente := (PolyLigne[i+1].y-y0)/(PolyLigne[i+1].x-x0);
             if abs(pente)>1 then begin // selon y
                pente := 1/pente;
                if y0<PolyLigne[i+1].y
                   then for k := y0 to PolyLigne[i+1].y-1 do
                      affecteUnPoint(round(x0+pente*(k-y0)),k)
                   else for k := y0 downto PolyLigne[i+1].y-1 do
                      affecteUnPoint(round(x0+pente*(k-y0)),k)
             end
             else begin // selon x
                 if x0<PolyLigne[i+1].x
                   then for k := x0 to PolyLigne[i+1].x-1 do
                      affecteUnPoint(k,round(y0+pente*(k-x0)))
                   else for k := x0 downto PolyLigne[i+1].x-1 do
                      affecteUnPoint(k,round(y0+pente*(k-x0)))
             end;
         end;
      end end; // remplitInterpole

    begin // tracePolyLine
      if j<=1 then begin
         j := 0;
         precedent := pNone;
         exit;
      end;
      i := 1;
      repeat
        if (PolyLigne[i].x = PolyLigne[i + 1].x)
           then Nettoie(i)
           else Inc(i);
      until i > j - 2;
      canvas.PolyLine(slice(PolyLigne,j));
      if (CurseurActif in [curReticule,curReticuleData,curEquivalence,curReticuleDataNew,curReticuleModele]) and
         (pas=1) then remplitInterpole;
      j := 0;
      precedent := pNone;
    end;// TracePolyLigne

    procedure XYdirect;
    var i : integer;
    begin with courbes[index] do begin
      j := 0;
      for i := debutC to finC do begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if (xi<0) or (yi<0)
           then TracePolyLine
           else begin
              Inc(j);
              PolyLigne[j] := Point(xi, yi);
              if j>=MaxVecteurPoly then TracePolyLine;
           end;
      end; // boucle i
      if j > 1 then TracePolyLine;
    end end;

  begin with courbes[index] do begin
      sincActif := false;
      Nvisible := finC-debutC+1;
      finE := 0;
      maxiY := monde[iMondeC].maxiInt;
      miniY := monde[iMondeC].miniInt;
      Precedent := pNone;
      if (grandeurs[indexTri] = varX) or
         (grandeurs[cFrequence] = varX)
          then begin
             pas := Nvisible div (2*limiteFenetre.width);
             if pas=0 then pas := 1;
          end
          else begin
            pas := 1; // mode XY
            if Nvisible>limiteFenetre.width then begin
              XYdirect; // cas rapide XY si beaucoup de points
              exit;
            end;
          end;
      idebut := debutC;
      ifin := finC;
      if (pas > 1) and not (OgPolaire in OptionGraphe) then begin
        xi := windowX(valX[idebut]);
        while (xi<0) and (idebut < finC) do begin
          Inc(idebut);
          xi := windowX(valX[idebut]);
        end;
        xi := windowX(valX[ifin]);
        while (xi<0) and (ifin > debutC) do begin
          Dec(ifin);
          xi := windowX(valX[ifin]);
        end;
        verifMinMaxInt(iDebut,iFin); // si l'axe des x est ordonné en sens inverse de la grandeur de tri
        Nvisible := iFin-iDebut+1;
        pas := Nvisible div (2*limiteFenetre.width);
        if pas=0 then pas := 1;
      end;
      case OptionLigne of
           LiSinc : if grandeurs[indexTri] = varX then affecteSplineSinc;
           LiSpline : if Nvisible<(limiteFenetre.width div 2) then affecteSplineSinc;
      end;
      j := 0;
      i := iDebut;
      while i <= iFin do begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if (xi<0) or (yi=intNan)
        then begin
           tracePolyLine;
           Precedent := pNone;
           inc(i,pas);
        end
        else begin
        if yi=intMoinsInf
             then Courant := pHaut
             else if yi=intPlusInf
               then Courant := pBas
               else Courant := pOK;
        case Courant of
            pOK: case Precedent of
                pNone, pOK: begin
                  Inc(j);
                  PolyLigne[j] := Point(xi, yi);
                end;
                pHaut, pBas: begin
                  j := 1;
                  PolyLigne[1] := Point(xi, yi);
                end;
            end;
            pHaut: begin
            case Precedent of
                pOK: TracePolyLine;
                pHaut: ;
                pBas: begin
                  PolyLigne[2] := Point(xi, miniY);
                  canvas.PolyLine(slice(PolyLigne,2));
                  j := 0;
                end;
                pNone: ;
            end;
            PolyLigne[1] := Point(xi, miniY);
            end;
            pBas: begin
            case Precedent of
                pOK: TracePolyLine;
                pBas: ;
                pHaut: begin
                  PolyLigne[2] := Point(xi, maxiY);
                  canvas.PolyLine(slice(PolyLigne,2));
                  j := 0;
                end;
                pNone: ;
            end;
            PolyLigne[1] := Point(xi, maxiY);
            end;
            pNone :;
        end;// case courant
        Precedent := Courant;
        Inc(i, pas);
        if j>=MaxvecteurPoly then TracePolyLine;
        end;
      end; // boucle i
      if j > 1 then TracePolyLine;
      if sincActif then restaureSinc;
  end end; // traceLigne

  procedure traceLigneAvecDecalage;
  var
    xi, yi, pas:  integer;

  type
    Tprecedent = (pOK, pHaut, pBas, pNone);
  var
    i, j: integer;
    Precedent, Courant: Tprecedent;
    decaleLoc: integer;
    maxiY, miniY: integer;
    PolyLigne: array[1..MaxVecteurPoly] of Tpoint;
    iDebut, iFin: integer;
  begin with courbes[index] do begin
      maxiY := monde[iMondeC].maxiInt;
      miniY := monde[iMondeC].miniInt;
      Precedent := pNone;
      decaleLoc := decalage * coeffDecalage;
      j := 0;
      pas := (finc - debutC) div limiteFenetre.width;
      if pas=0 then pas := 1;
      idebut := debutC;
      ifin := finC;
      if not (OgPolaire in OptionGraphe) then begin
        xi := windowX(valX[idebut]);
        while (xi<0) and (idebut < finC) do begin
          Inc(idebut);
          xi := windowX(valX[idebut]);
        end;
        xi := windowX(valX[ifin]);
        while (xi<0) and (ifin > debutC) do begin
          Dec(ifin);
          xi := windowX(valX[ifin]);
        end;
        pas := (ifin - idebut) div limiteFenetre.width;
        if pas=0 then pas := 1;
      end;
      i := iDebut;
      while i <= iFin do begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if (xi<0) or (yi=intNan) then begin
          if j > 1 then
            canvas.polyLine(slice(PolyLigne,j));
          j := 0;
          precedent := pNone;
        end
        else begin
          if yi=intMoinsInf
             then Courant := pHaut
             else if yi=intPlusInf
                then Courant := pBas
                else Courant := pOK;
          case Courant of
            pOK: case Precedent of
                pNone, pOK: begin
                  Inc(j);
                  PolyLigne[j] := Point(xi + decaleLoc, yi - decaleLoc);
                end;
                pHaut, pBas: begin
                  j := 1;
                  PolyLigne[1] := Point(xi + decaleLoc, yi - decaleLoc);
                end;
              end;
            pHaut: begin
            case Precedent of
                pOK: begin
                  canvas.PolyLine(slice(PolyLigne,j));
                  j := 0;
                end;
                pHaut: ;
                pBas: begin
                  PolyLigne[2] := Point(xi + decaleLoc, miniY - decaleLoc);
                  canvas.PolyLine(slice(PolyLigne,2));
                  j := 0;
                end;
                pNone: ;
              end;
              PolyLigne[1] := Point(xi + decaleLoc, miniY - decaleLoc);
            end;
            pBas: begin
            case Precedent of
                pOK: begin
                  canvas.PolyLine(slice(PolyLigne,j));
                  j := 0;
                end;
                pBas: ;
                pHaut: begin
                  PolyLigne[2] := Point(xi + decaleLoc, maxiY - decaleLoc);
                  canvas.PolyLine(slice(PolyLigne,2));
                  j := 0;
                end;
                pNone: ;
              end;
              PolyLigne[1] := Point(xi + decaleLoc, maxiY - decaleLoc);
            end;
          end;// case courant
          Precedent := Courant;
        end;
        if j>=MaxVecteurPoly then begin
           canvas.polyLine(slice(PolyLigne,j));
           j := 0;
        end;
        Inc(i, pas);
      end;// boucle i
      if j > 1 then
        canvas.polyLine(slice(PolyLigne,j));
    end;
  end; // traceLigneAvecDecalage

  procedure traceVecteur(xx, yy: Tvecteur; m: integer);
  var
    xi, yi: integer;
    i: integer;
    h: integer; // dimension en pixel de la flèche tq 1% de la largeur
    couleurV: Tcolor;

    procedure TraceProlongement(dX, dY: double);
    var
      coeff: double;
      deltaX, deltaY: integer;
    begin
      createPenFin(psDash, couleurV);
      canvas.MoveTo(xi, yi);
      try
        if abs(dY) > abs(dX)
           then coeff := MondeVecteur[mondeAcc].maxi / dY
           else coeff := MondeVecteur[mondeAcc].maxi / dX;
        coeff := abs(coeff);
        if coeff > 1e+2 then coeff := 1e+2;
        coeff := coeff / EchelleVecteur;
        MondeVecteur[mondeAcc].getEntier(dX * coeff, dY * coeff, deltaX, deltaY);
        canvas.LineTo(xi + deltaX, yi + deltaY);
      except { dX=0 ou dY=0 }
      end;
      createPen(psSolid, 1, couleurV);
    end;

    procedure TraceFleche(dX, dY: double);
    var
      x, y, x1, y1, d: integer;
      deltaX, deltaY: integer;
      Points:  array[0..2] of Tpoint;
    begin
      MondeVecteur[m].getEntier(dX, dY, deltaX, deltaY);
      canvas.MoveTo(xi, yi);
      y1 := yi + deltaY;
      x1 := xi + deltaX;
 // x1,y1 = bout de la flèche
      canvas.LineTo(x1, y1);
      d := round(sqrt(sqr(deltaX) + sqr(deltaY)));
      if d<h then exit;
      deltaX := round(h * deltaX / d);
      deltaY := round(h * deltaY / d);
  // x,y = centre de la base de la flèche
      y := y1 - deltaY;
      x := x1 - deltaX;
      deltaX := deltaX div 4;
      deltaY := deltaY div 4;
      Points[0] := Point(x1, y1);
      Points[1] := Point(x - deltaY, y + deltaX);
      Points[2] := Point(x + deltaY, y - deltaX);
      canvas.Polygon(Points); // triangle 3 points
    end;

    Procedure TraceEchelle;
    var sauveax : double;
        S: string;
    begin
          with limiteFenetre do begin
             xi := m * (right - left) div 3;
             yi := top + (5 * HautCarac div 2);
          end;
          if (ogOrthonorme in optionGraphe) or
             (MondeVecteur[m].ax<MondeVecteur[m].ay)
             then traceFleche(MondeVecteur[m].echelle, 0)
             else begin
                sauveAx := MondeVecteur[m].ax;
                MondeVecteur[m].ax := abs(MondeVecteur[m].ay);
                traceFleche(MondeVecteur[m].echelle, 0);
                MondeVecteur[m].ax := sauveAx;
             end;
          canvas.font.Color := couleurV;
          S := courbes[index].varDer[m].formatValeurEtUnite(MondeVecteur[m].echelle);
          Dec(yi, 3 * HautCarac div 2);
          with limiteFenetre do
            xi := m * (right - left) div 3;
          canvas.Brush.Style := bsClear;
          canvas.TextOut(xi, yi,S);
          MondeVecteur[m].EchelleTrace := True;
      end;

  var
    pas: integer;
    iDebut, iFin: integer;
    dXr, dYr: double;

    function PointATracer(i: integer): boolean;
    begin with courbes[index] do begin
        if m=1
           then result := not isNan(valYder[i]) and not isNan(valXder[i])
           else result := not isNan(valYder2[i]) and not isNan(valXder2[i]);
        if not Result then exit;
        if avecAnimTemporelle
           then result := true
           else if UseSelect
              then if i < 256
                then Result := i in PointSelect
                else Result := False
              else Result := (i mod pas) = 0;
    end end;

  begin  with courbes[index] do begin // traceVecteur
    if (xx = nil) or (yy = nil) then exit;
    if OgPolaire in OptionGraphe then begin
       if (m=1) and ((valYder=nil) or (valXder=nil)) then exit;
       if (m=2) and ((valYder2=nil) or (valXder2=nil)) then exit;
    end;
      try
        couleurV := couleurLoc;
        if CouleurVitesseImposee then begin
          if (couleurMecanique[m]=clWindow) or
             (couleurMecanique[m]=clWhite) then
           if m=1
              then couleurMecanique[1] := clBlue
              else couleurMecanique[2] := clRed;
          couleurV := CouleurMecanique[m];
        end
        else if m > 1 then begin
          couleurV := RGB(GetRValue(couleurV) div 2,
            GetGValue(couleurV) div 2,
            GetBValue(couleurV) div 2);
        end;
        h := (limiteFenetre.Right - LimiteFenetre.Left) div 100;
        if h < 6 then h := 6;
        CreateSolidBrush(couleurV);
        createPen(psSolid, 1, couleurV);
        pas := succ((finC - debutC) div NbreVecteurVitesseMax);
        iDebut := debutC;
        iFin := finC;
        if avecAnimTemporelle then begin
           iDebut := NumAnim;
           iFin := NumAnim;
        end;
        for i := iDebut to iFin do
          if PointAtracer(i) then begin
            WindowRT(valX[i], valY[i], iMondeC, xi, yi);
            if (xi>0) and (yi>0) then begin
              if OgPolaire in OptionGraphe then
                MondeVecteur[m].getPolaire(
                  valY[i], valX[i],
                  valYder[i], valXder[i],
                  valYder2[i], valXder2[i], dXr, dYr)
              else begin
                dXr := xx[i];
                dYr := yy[i];
              end;
              traceFleche(dXr, dYr);
              if (m = mondeAcc) and prolongeVecteur then
                  traceProlongement(dXr, dYr);
              if (m = mondeVitesse) and projeteVecteur then begin
                  createPenFin(psSolid, couleurV);
                  traceFleche(0, dYr);
                  traceFleche(dXr, 0);
                  createPen(psSolid, 1, couleurV);
              end;
            end;
          end;{for i}
        if not MondeVecteur[m].EchelleTrace then traceEchelle;
      except
        if m = MondeVitesse then exclude(trace, trVitesse);
        if m = MondeAcc then exclude(trace, trAcceleration);
      end;
  end end; // traceVecteur

  procedure traceResidus;
  var
    i: integer;
    x0, y0, xi, yi, dxi, dyi: integer;
    TraceDeltaX, TraceDeltaY: boolean;
  begin with courbes[index] do begin
      WindowXY(0, 0, iMondeC, x0, y0);
      traceDeltaX := avecEllipse and (varX <> nil) and (IncertX <> nil);
      traceDeltaY := avecEllipse and (varY <> nil) and (IncertY <> nil);
      for i := debutC to finC do if pages[page].pointActif[i] then begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if TraceDeltaX
           then dxi := abs(round(CoeffEllipse * IncertX[i] * monde[MondeX].A))
           else dxi := 0;
        if TraceDeltaY
           then dyi := abs(round(CoeffEllipse * IncertY[i] * monde[iMondeC].A))
           else dyi := 0;
        if dxi + dyi = 0 then begin
          segment(xi, y0, xi, yi);
          canvas.rectangle(xi - dimPoint, yi - dimPoint, xi + dimPoint, yi + dimPoint);
        end
        else case TraceIncert of
        iCroix : begin
          segment(xi - dxi, yi, xi + dxi, yi);
          segment(xi, yi - dyi, xi, yi + dyi);
        end;
        iEllipse : begin
          canvas.Pixels[xi, yi] := couleurLoc;
          if dxi = 0
             then segment(xi, yi - dyi, xi, yi + dyi)
             else if dyi = 0
                then segment(xi - dxi, yi, xi + dxi, yi)
                else canvas.ellipse(xi - dxi, yi - dyi, xi + dxi + 1, yi + dyi + 1);
        end;
        iRectangle : begin
          canvas.Pixels[xi, yi] := couleurLoc;
          if dxi = 0
             then segment(xi, yi - dyi, xi, yi + dyi)
             else if dyi = 0
                then segment(xi - dxi, yi, xi + dxi, yi)
                else canvas.rectangle(xi - dxi, yi - dyi, xi + dxi, yi + dyi);
        end;
        end;
      end; // for i
    end;
  end; // traceResidus 

  procedure traceStat;
  var
    i: integer;
    xi, yi: integer;
    x0, y0, xpred: integer;
    x1,y1 : integer;
    largeur: integer;
    codeHatch: TBrushStyle;
  begin with courbes[index] do begin
      case indexHisto of
           0: codeHatch := bsBDIAGONAL;
           1: codeHatch := bsHORIZONTAL; //  Horizontal hatch
           2: codeHatch := bsVERTICAL; //  Vertical hatch
           else codeHatch := bsBDIAGONAL;
      end;
      inc(indexHisto);
      indexHisto := indexHisto mod 3;
      WindowRT(valX[debutC], 0, iMondeC, x0, y0);
      WindowRT(valX[debutC+1], 0, iMondeC, x1, y1);
      createHatchBrush(codeHatch, couleurLoc);
      WindowRT(valX[debutC], valY[debutC], iMondeC, xpred, yi);
      largeur := penWidth div 2 + 1;
      for i := succ(debutC) to finC do begin
        WindowRT(valX[i], valY[i], iMondeC, xi, yi);
        if xi>0 then begin
           if valY[i] > 0 then canvas.rectangle(xpred, yi, xi - largeur, y0);
           xpred := xi + largeur;
        end;
      end;
    end;
  end; // traceStat

var
  xi, yi: integer;
  // TGrapheReg.TraceCourbe(index)
begin with courbes[index] do begin
    if debutC<0 then debutC := 0;
    if finC<0 then finc := pages[page].nmes-1;
    if monde[mondeX].Axe = nil then
      monde[mondeX].Axe := varX;
    if monde[iMondeC].Axe = nil then
      monde[iMondeC].Axe := varY;
    if FinC < DebutC then
      exit;
    if superposePage and (page <> 0) and (SPcouleur=reperePage)
       then couleurLoc := GetCouleurPages(page)
       else if ImprimanteMono
          then couleurLoc := clBlack
          else couleurLoc := couleur;
  //  if trace * [trCouples, trStat] <> [] then exclude(trace, trPoint);
    if trace * [trStat] <> [] then
      exclude(trace, trPoint);
    if (monde[imondeC].graduation = gBits) and traceBits then
      exit;
    if trIntensite in trace then begin
      if ImprimanteEnCours
         then traceIntensiteImpr
         else traceIntensiteLignes; // en premier en fond d'écran
    end;
    if (trIndicateur in trace) and ((indicateur = nil) or
      (optionsIndicateur = []) or (optionsIndicateur = [oiNomIndicateur]))
    then
      exclude(trace, trIndicateur);
    if (trIndicateur in trace) then begin
      if pages[page].indicateurP <> nil then
         indicateur := pages[page].indicateurP;
      traceIndicateur; // en premier en fond d'écran
    end;
    if (trCouleursSpectre in trace) and not ImprimanteMono then
        traceCouleursSpectre; // en premier en fond d'écran
    if trSonagramme in trace then begin
        traceSonagramme;
        if useFaussesCouleurs then
           traceFaussesCouleurs;
        exit;
    end;
    if (trPoint in trace) then begin
      createPen(psSolid, 1, couleurLoc);
      tracePoint(((dimPointVGA = 1) and not avecEllipse) or (motif = mPixel));
    if (trIndicateur in trace) and
        superposePage and
        (page <> 0) and
        (SPcouleur=reperePage)
          then couleurLoc := GetCouleurPages(page);
    end;
    if superposePage and (page <> 0) and (SPstyle=reperePage)
       then createPen(stylePages[page mod MaxPagesGr], penWidthCourbe, couleurLoc)
       else createPen(styleT, penWidthCourbe, couleurLoc);
    if trLigne in trace then
      if decalage = 0
         then TraceLigne
         else TraceLigneAvecDecalage;
    if trStat in trace then TraceStat;
    if trTexte in trace then traceTexte;
    if trResidus in trace then traceResidus;
    if not (imVitesse in MenuPermis) then begin
       exclude(trace, trVitesse);
       exclude(trace, trAcceleration);
    end;
    if trVitesse in trace then traceVecteur(valXder, valYder, mondeVitesse);
    if trAcceleration in trace then traceVecteur(valXder2, valYder2, mondeAcc);
    if courbeExp and borneVisible and
      (imBornes in MenuPermis) and
      (page=pageCourante) and
       not (ImprimanteEnCours or WMFenCours or ImageEnCours) then begin
           WindowRT(valX[debutC], valY[debutC], iMondeC, xi, yi);
           traceBorne(xi, yi, bsDebut, couleurLoc, indexModele);
           WindowRT(valX[finC], valY[finC], iMondeC, xi, yi);
           traceBorne(xi, yi, bsFin, couleurLoc, indexModele);
    end; // bornes
    if not (OgPolaire in OptionGraphe) and (varY <> nil) then begin
      if avecAxeY and (Monde[iMondeC].TitreAxe.MyIndexOf(varY.nom) < 0) then
        TraceTitreAxe(varY, iMondeC, index);
      if empilePage and (iMondeC = mondeDebut) and
        (Monde[mondeDebut].TitreAxe.MyIndexOf(varY.nom) < 0) then
        TraceTitreAxe(varY, iMondeC, index);
      if avecAxeX and (varX <> nil) and
        (monde[mondeX].TitreAxe.MyIndexOf(varX.nom) < 0) then
        TraceTitreAxe(varX, mondeX, index);
    end;// not polaire
  end;
end;// TraceCourbe

procedure TGrapheReg.TraceFilDeFer;
var
  couleurLoc: TcolorRef;
  courbesAtracer: set of byte;
  PremiereCourbe, PremierPoint, DernierPoint : integer;

  procedure TracePoints;
  var
    i, j: integer;
    xi, yi: integer;
    PolyLigne: array[0..5] of Tpoint;
    maxiY, miniY, c: integer;
  begin
    with courbes[premiereCourbe] do begin
        maxiY := monde[iMondeC].maxiInt;
        miniY := monde[iMondeC].miniInt;
    end;
    for i := PremierPoint to dernierPoint do
      if ((i mod pasPoint) = 0) then begin
        j := 0;
        for c := 0 to pred(courbes.Count) do
          if c in CourbesATracer then
            with courbes[c] do begin
              WindowRT(valX[i], valY[i], iMondeC, xi, yi);
              if (xi > 0) and
                 (yi >= miniY) and (yi <= maxiY) then begin
                PolyLigne[j] := Point(xi, yi);
                Inc(j);
              end;
            end; //with courbes[c]
        canvas.polyLine(slice(PolyLigne,j));
      end;// for i
  end;// tracePoints

var
  c: integer;
  FilDeFerInterdit: boolean;
begin  // TGrapheReg.TraceFilDeFer(DC)
  CourbesAtracer := [];
  premiereCourbe := -1;
  couleurLoc := clBlue;
  FilDeFerInterdit := True;
  for c := 0 to pred(Courbes.Count) do
    with courbes[c] do
      if (trace * [trPoint, trLigne] <> []) and ((indexModele = 0) or
        courbeExp) then begin
        include(CourbesAtracer, c);
        if premiereCourbe < 0 then begin
          premiereCourbe := c;
          if avecAnimTemporelle then begin
            premierPoint := NumAnim;
            dernierPoint := NumAnim;
          end
          else begin
            premierPoint := DebutC;
            dernierPoint := FinC;
          end;
          couleurLoc := couleur;
          if FinC < DebutC then
            exit;
        end
        else if varX <> courbes[premiereCourbe].varX then
          FilDeFerInterdit := False;
      end;
  if FilDeFerInterdit then begin
    FilDeFer := False;
    exit;
  end;
  createPen(psSolid, 1, couleurLoc);
  tracePoints;
end;// TraceFilDeFer

procedure Tdessin.SetUnPointInt(ax,ay : integer);
begin
     Fgraphe.MondeXY(ax, ay, MondeY, x1, y1);
     x2 := x1;
     y2 := y1;
end;

procedure Tdessin.Draw;
const
  marge = 3;
var
  Haut, Larg: integer;
  x, y, h: integer;
  deltaX, deltaY: integer;
  selection : boolean;

  procedure TraceMotifTexte;
  var
    Points: array[0..2] of Tpoint;
    d: integer;

    procedure TraceVert;
    begin with Fgraphe.limiteCourbe do begin
        LigneMin := top; // +d ?
        LigneMax := bottom; // -d?
        Fgraphe.segment(x1i, LigneMin, x1i, LigneMax);
    end end;

    procedure TraceHoriz;
    begin with Fgraphe.limiteCourbe do begin
        LigneMin := left + d;
        LigneMax := right - d;
        Fgraphe.segment(LigneMin, y1i, LigneMax, y1i);
    end end;

    procedure TraceRappel;
    begin with Fgraphe.limiteCourbe do begin
        Fgraphe.segment(x1i, y1i, x1i, bottom);
        Fgraphe.segment(left, y1i, x1i, y1i);
    end end;

    procedure TraceFleche(x11i,y11i,x22i,y22i : integer);
    begin
        deltaX := x22i - x11i;
        deltaY := y22i - y11i;
        Fgraphe.segment(x11i, y11i, x22i, y22i);
        d := round(sqrt(sqr(deltaX) + sqr(deltaY)));
        if d < h * 3 then exit;
        deltaX := round(h * deltaX / d);
        deltaY := round(h * deltaY / d);
    // x,y = centre de la base de la flèche
        y := y11i + deltaY;
        x := x11i + deltaX;
        deltax := round(deltax / 3);
        deltay := round(deltay / 3);
        Points[0] := Point(x11i, y11i);
        Points[1] := Point(x - deltaY, y + deltaX);
        Points[2] := Point(x + deltaY, y - deltaX);
        CreateSolidBrush(pen.color);
        Fgraphe.canvas.polygon(Points);
        Fgraphe.canvas.brush.style := bsClear;
      end;

  begin  // TraceMotifTexte
    with cadre do
      if (bottom > y1i) and (top < y1i) and (left < x1i) and
        (right > x1i) then
        exit;
    d := Fgraphe.HautCarac;
    h := h div 2;
    case motifTexte of
      mtNone: ;
      mtFleche: traceFleche(x1i,y1i,x2i,y2i);
      mtDoubleFleche: begin
         traceFleche(x1i,y1i,x2i,y2i);
         traceFleche(x2i,y2i,x1i,y1i);
      end;
      mtCroix: begin
        Fgraphe.segment(x1i, y1i + d, x1i, y1i - d);
        Fgraphe.segment(x1i + d, y1i, x1i - d, y1i);
      end;
      mtVert: traceVert;
      mtHoriz: traceHoriz;
      mtLigneRappel: traceRappel;
    end;
  end; // TraceMotifTexte

  procedure TraceMotifLigne;
  var dX,dY : integer;

    procedure TraceFleche(x11i,y11i : integer);
    var Points: array[0..2] of Tpoint;
        dXX,dYY : integer;
    begin
        y := y11i + dY;
        x := x11i + dX;
        dxx := dx div 3;
        dyy := dy div 3;
        Points[0] := Point(x11i, y11i);
        Points[1] := Point(x - dYY, y + dXX);
        Points[2] := Point(x + dYY, y - dXX);
        CreateSolidBrush(pen.color);
        Fgraphe.canvas.polygon(Points);
        Fgraphe.canvas.brush.style := bsClear;
    end;

  begin
    if motifTexte=mtDoubleFleche then begin
         dX := (x2i - x1i)*8 div 100;
         dY := (y2i - y1i)*8 div 100;
         traceFleche(x1i,y1i);
         dX := -dX;
         dY := -dY;
         traceFleche(x2i,y2i);
    end;
  end; // TraceMotifLigne

  procedure TraceLigneRappel;
  begin
    Fgraphe.canvas.MoveTo(x1i, y1i);
    with cadre do
      if bottom < y1i then
        Fgraphe.canvas.LineTo((right + left) div 2, bottom)
      else if top > y1i then
        Fgraphe.canvas.LineTo((right + left) div 2, top)
      else if left > x1i then
        Fgraphe.canvas.LineTo(left, (top + bottom) div 2)
      else if right < x1i then
        Fgraphe.canvas.LineTo(right, (top + bottom) div 2);
  end;

var
  i, z, long: integer;
  a, b, dX, dY,coeff : double;
  indexX,indexY : integer;
  OKp : boolean;
  largeur,oldH : integer;
   TexteLoc:     TStringList;
begin // Tdessin.Draw
  TexteLoc := TStringList.Create;
  oldH := Fgraphe.canvas.font.height;
  NumeroPage := pageCourante;
  if (numPage > 0) then
  if isTexte then begin
     if (numPage <= NbrePages) then begin
       NumeroPage := numPage;
       if identification=identNone then begin
          if not pages[NumeroPage].active then exit;
          pen.color := GetCouleurPages(numeroPage);
       end;
     end;
  end // texte
  else begin // ligne
       OKp := numPage <= NbrePages;
       if OKp then if FGraphe.superposePage
          then OKp := pages[NumPage].active
          else OKp := NumPage=pageCourante;
       if not OKp then exit;
       if FGraphe.superposePage then
          pen.color := GetCouleurPages(numPage);
       NumeroPage := numPage;
  end;
  selection := Fgraphe.dessinCourant=self;
  if nomX<>'' then begin
     indexX := indexNom(nomX);
     if (indexX<>grandeurInconnue) and
        (grandeurs[indexX].genreG in [Constante,ConstanteGlb,ParamGlb,ParamNormal]) then begin
        x1 := grandeurs[indexX].valeurCourante;
     end
     else nomX := '';
  end;
  if nomY<>'' then begin
     indexY := indexNom(nomY);
     if (indexY<>grandeurInconnue) and
        (grandeurs[indexY].genreG in [Constante,ConstanteGlb,ParamGlb,ParamNormal]) then begin
        y1 := grandeurs[indexY].valeurCourante;
     end
     else nomY := '';
  end;
  if selection and not isTexte
     then if pen.Width<3
         then largeur := 2
         else largeur := 1
     else begin
        largeur := pen.Width div Fgraphe.penwidth;
        if largeur<1 then largeur := 1;
     end;
  Fgraphe.createPen(pen.style, largeur, pen.color);
  Fgraphe.canvas.pen.mode := pmCopy;
  if (identification = identCoord) then begin
    for i := 0 to pred(Fgraphe.courbes.Count) do
      with Fgraphe.courbes[i] do
        if (numCoord = indexNom(varY.nom)) then begin
          if (NumPoint < debutC) or (numPoint > finC) then
            numPoint := (debutC + finC) div 2;
          x1 := valX[numPoint];
          y1 := valY[numPoint];
          iMonde := iMondeC;
          break;
        end;
        motifTexte := MotifIdent;
        hauteur := hauteurIdent;
        avecCadre := avecCadreIdent;
        isOpaque := isOpaqueIdent;
        couleurFond := couleurFondIdent;
  end;
  if isTitre then
    with Fgraphe.limiteFenetre do begin // x = position en %
      x1i := round(left + (right - left) * x1);
      y1i := round(top + (top - bottom) * y1);
      x2i := round(left + (right - left) * x2);
      y2i := round(top + (top - bottom) * y2);
    end
  else begin
    Fgraphe.WindowRT(x1, y1, iMonde, x1i, y1i);
    Fgraphe.WindowRT(x2, y2, iMonde, x2i, y2i);
  end;
  Fgraphe.setTextAlign(alignement);
  if isTexte then begin // Vérifier texte visible
    with Fgraphe.LimiteFenetre do begin
      if x2i > right then
        x2i := (4 * right + left) div 5;
      if x2i < left then
        x2i := (4 * left + right) div 5;
      if y2i > bottom then
        y2i := (4 * bottom + top) div 5;
      if y2i < top then
        y2i := (4 * top + bottom) div 5;
    end;
    TexteLoc.Assign(texte);
    if IsOpaque and not(ImprimanteMono) then begin
       Fgraphe.canvas.TextFlags := ETO_opaque;
       Fgraphe.canvas.brush.style := bsSolid;
       Fgraphe.canvas.brush.color := couleurFond;
    end
    else Fgraphe.canvas.brush.style := bsClear;
    Fgraphe.canvas.font.Color := pen.color;
    with Fgraphe.limiteFenetre do
         h := (right - left + bottom - top) div 2;
    h := round(h * (hauteur / 100.0));
    Fgraphe.canvas.Font.Height := h;
    if vertical then Fgraphe.Canvas.font.orientation := 900;
    i := 0;
    while i<texteLoc.Count do begin
       setPourCent(i,TexteLoc);
       inc(i);
    end;
    if souligne then
       Fgraphe.canvas.Font.style := [fsUnderLine];
    cadre.right := x2i;
    cadre.left := x2i;
    i := 0;
    while i < texteLoc.Count do begin
      if texteLoc[i] = ''
         then texteLoc.Delete(i)
         else Inc(i);
    end;
    if centre and not vertical then begin
      Haut := Fgraphe.canvas.TextHeight('A');
      y2i := y2i - haut * pred(texteLoc.Count) div 2;
      with Fgraphe.limiteFenetre do
           if y2i < (top+haut) then y2i := top + haut;
    end;
    cadre.top := y2i;
    cadre.bottom := y2i;
    for i := 0 to pred(texteLoc.Count) do begin
      long := length(texteLoc[i]);
      if identification = identAnimation then begin // taille fixe
        if long < longAnim
           then texteLoc[i] := pad(texteLoc[i], longAnim)
           else longAnim := long;
      end;
      Haut := Fgraphe.canvas.TextHeight(texteLoc[i]);
      Larg := Fgraphe.canvas.TextWidth(texteLoc[i]);
      if centre then
        if vertical then begin
          deltaX := Haut div 2;
          x := x2i - deltaX + 2 * deltaX * i;
          if i = 0 then
            cadre.right := x - marge;
          if i = pred(texteLoc.Count) then
            cadre.left := x + 2 * deltaX + marge;
        end
        else begin
          deltaX := Larg div 2;
          x := x2i - deltaX;
          z := x - marge;
          if cadre.right > z then
            cadre.right := z;
          z := x2i + deltaX + marge;
          if cadre.left < z then
            cadre.left := z;
        end
      else begin
        x := x2i;
        z := x+Larg;
        if cadre.right<z then
           cadre.right := z;
      end;
      if centre then
        if vertical then begin
          deltaY := Larg div 2;
          y := y2i + deltaY;
          z := y2i - deltaY - marge;
          if cadre.top > z then
            cadre.top := z;
          z := y2i + deltaY + marge;
          if cadre.bottom < z then
            cadre.bottom := z;
        end
        else begin
          deltaY := Haut div 2;
          y := y2i + deltaY * (2 * i - 1);
          if i = 0 then cadre.top := y - marge;
          if i = pred(texteLoc.Count) then cadre.bottom := y + 2 * (deltaY + marge);
        end
      else begin
         deltaY := Haut;
         y := y2i+deltaY*i;
         z := y-deltaY;
         if cadre.top>z then cadre.top := z;
      end;
 //     if IsOpaque and not(ImprimanteMono) then agraphe.canvas.Rectangle(cadre);
      Fgraphe.canvas.TextOut(x,y,texteLoc[i]);
    end; // for i
    if (avecCadre and not isOpaque and not selection) then
    Fgraphe.canvas.Rectangle(cadre);
    if selection then begin
       Fgraphe.createPenFin(psSolid, clRed);
       Fgraphe.canvas.Rectangle(cadre);
    end;
    if avecLigneRappel then TraceLigneRappel;
    TraceMotifTexte;
  end  // texte
  else begin // ligne
    if nomX<>''
       then with Fgraphe.LimiteCourbe do begin
            y1i := bottom;
            y2i := (9 * top + bottom) div 10;
            x2i := x1i;
            Fgraphe.segment(x1i, y1i, x2i, y2i)
       end
       else if nomY<>''
         then with Fgraphe.LimiteCourbe do begin
            x1i := left;
            x2i := (9 * left + right) div 10;
            y2i := y1i;
            Fgraphe.segment(x1i, y1i, x2i, y2i)
         end
         else Fgraphe.segment(x1i, y1i, x2i, y2i);
       traceMotifLigne;
       if (texteLigne<>tlNone) and
          (sousDessin=nil) then begin
                  sousDessin := Tdessin.Create(Fgraphe);
                  sousDessin.avecLigneRappel := true;
                  sousDessin.isTexte := true;
                  sousDessin.proprietaire := self;
                  sousDessin.identification := identDroite;
                  if (x1i+x2i)>320 then coeff := 0.9 else coeff := 1.1;
                  sousDessin.x2 := coeff*(x1+x2)/2;
                  if (y1i+y2i)>240 then coeff := 0.9 else coeff := 1.1;
                  sousDessin.y2 := coeff*(y1+y2)/2;
                  Fgraphe.dessins.add(sousDessin);
        end;
    if (TexteLigne <> tlNone) and (sousDessin <> nil) then begin
      sousDessin.Texte.Clear;
      Fgraphe.MondeRT((x1i + x2i) div 2, (y1i + y2i) div 2, iMonde,
        sousDessin.x1, sousDessin.y1);
      sousDessin.pen.color := pen.color;
      case TexteLigne of
         tlEcartY: if y2i <> y1i then begin
            with Fgraphe.monde[mondeY] do
              case Graduation of
                gLog: dY := log10(y2 / y1);
                gInv: dY := 1 / y2 - 1 / y1;
                gLin: dY := y2 - y1;
                gdB: dY  := 20 * log10(y2 / y1);
                gBits: dY := y2 - y1;
                else dY := 0;
              end;
            sousDessin.Texte.Add(Fgraphe.monde[mondeY].axe.formatNomEtUnite(dY,true));
         end;
         tlEcartX: if x2i <> x1i then begin
            with Fgraphe.monde[mondeX] do
              case Graduation of
                gLog: dX := log10(x2 / x1);
                gInv: dX := 1 / x2 - 1 / x1;
                gLin: dX := x2 - x1;
                gBits: dX := x2 - x1;
                else dX := 0;
              end;
            sousDessin.Texte.Add(Fgraphe.monde[mondeX].axe.formatNomEtUnite(dX,true));
         end;
         tlPente: if x2i <> x1i then begin
            Fgraphe.setUnitePente(mondeY);
            with Fgraphe.monde[mondeY] do
              case Graduation of
                gLog: dY := log10(y2 / y1);
                gInv: dY := 1 / y2 - 1 / y1;
                gLin: dY := y2 - y1;
                gdB: dY  := 20 * log10(y2 / y1);
                gBits: dY := y2 - y1;
                else dY := 0;
              end;
            with Fgraphe.monde[mondeX] do
              case Graduation of
                gLog: dX := log10(x2 / x1);
                gInv: dX := 1 / x2 - 1 / x1;
                gLin: dX := x2 - x1;
                else dX := 1;
              end;
            sousDessin.Texte.Add(Fgraphe.unitePente.formatNomPente(dY / dX));
         end;
         tlEquation: if abs(x2i - x1i) < 2
            then sousDessin.Texte.Add(Fgraphe.monde[mondeX].axe.formatNomEtUnite((x1 + x2) / 2))
            else if abs(y2i - y1i) < 2
               then sousDessin.Texte.Add(Fgraphe.monde[mondeY].axe.formatNomEtUnite((y1 + y2) / 2))
               else begin
                  a := (y2 - y1) / (x2 - x1);
                  b := y2 - a * x2;
                  sousDessin.Texte.Add(Fgraphe.monde[mondeY].axe.nom + '=' +
                      formatReg(b) + '+' +
                      formatReg(a) + '*' + Fgraphe.monde[mondeX].axe.nom);
               end;
      end; // case TexteLigne
    end;
  end;
  with Fgraphe.canvas do begin
     Font.style  := [];
     Font.orientation := 0;
     TextFlags := 0;  // transparent
     brush.color := clWindow;
     font.height := oldH;
  end;
  TexteLoc.Free;
end; // Tdessin.Draw

procedure Tdessin.DrawLatex(var latexStr : TstringList);
var exposantX,exposantY : double;

    procedure TraceLigne;
    var code : string;
    begin with Fgraphe.limiteCourbe do begin
    case motifTexte of
         mtDoubleFleche : code :=  ',<->';
         mtFleche : code :=  ',->';
         else code :=  '';
    end;
    latexStr.add('\draw['+couleurLatex(pen.color)+styleLatex[pen.style]+code+',thick]'+
     '(axis cs:'+floatToStrLatex(x1/exposantX)+','+floatToStrLatex(y1/exposantY)+')'+
     ' -- '+
     '(axis cs:'+floatToStrLatex(x2/exposantX)+','+floatToStrLatex(y2/exposantY)+');');
    end end;

var
  a, b, dX, dY : double;
  Atexte : string;
  code : string;
begin // Tdessin.DrawLatex
  exposantX := Fgraphe.monde[mondeX].Fexposant;
  exposantY := FGraphe.monde[mondeY].Fexposant;
  if isTexte then begin
  end
  else begin // ligne
    traceLigne;
    Atexte := '';
    case TexteLigne of
         tlEcartY: if y2i <> y1i then begin
            with Fgraphe.monde[mondeY] do
              case Graduation of
                gLog: dY := log10(y2 / y1);
                gInv: dY := 1 / y2 - 1 / y1;
                gLin: dY := y2 - y1;
                gdB: dY  := 20 * log10(y2 / y1);
                gBits: dY := y2 - y1;
                else dY := 0;
              end;
              ATexte := Fgraphe.monde[mondeY].axe.formatNomEtUnite(dY,true);
         end;
         tlEcartX: if x2i <> x1i then begin
            with Fgraphe.monde[mondeX] do
              case Graduation of
                gLog: dX := log10(x2 / x1);
                gInv: dX := 1 / x2 - 1 / x1;
                gLin: dX := x2 - x1;
                gBits: dX := x2 - x1;
                else dX := 0;
              end;
            ATexte := Fgraphe.monde[mondeX].axe.formatNomEtUnite(dX,true);
         end;
         tlPente: if x2i <> x1i then begin
            Fgraphe.setUnitePente(mondeY);
            with Fgraphe.monde[mondeY] do
              case Graduation of
                gLog: dY := log10(y2 / y1);
                gInv: dY := 1 / y2 - 1 / y1;
                gLin: dY := y2 - y1;
                gdB: dY  := 20 * log10(y2 / y1);
                gBits: dY := y2 - y1;
                else dY := 0;
              end;
            with Fgraphe.monde[mondeX] do
              case Graduation of
                gLog: dX := log10(x2 / x1);
                gInv: dX := 1 / x2 - 1 / x1;
                gLin: dX := x2 - x1;
                else dX := 1;
              end;
            ATexte := Fgraphe.unitePente.formatNomPente(dY / dX);
         end;
         tlEquation: if abs(x2i - x1i) < 2
            then ATexte := Fgraphe.monde[mondeX].axe.formatNomEtUnite((x1 + x2) / 2)
            else if abs(y2i - y1i) < 2
               then Atexte := Fgraphe.monde[mondeY].axe.formatNomEtUnite((y1 + y2) / 2)
               else begin
                  a := (y2 - y1) / (x2 - x1);
                  b := y2 - a * x2;
                  ATexte := Fgraphe.monde[mondeY].axe.nom + '=' +
                    formatReg(b) + '+' +
                    formatReg(a) + '*' + Fgraphe.monde[mondeX].axe.nom;
               end;
      end; // case TexteLigne
      if Atexte<>'' then begin
          a := (x1+x2)/2;
          b := (y1+y2)/2;
          if a>(FGraphe.monde[mondeX].mini+FGraphe.monde[mondeX].maxi)/2
             then code := '[left]'
             else code := '[right]';
          latexStr.add('\draw['+couleurLatex(pen.color)+'] (axis cs:'+
                 floatToStrLatex(a/exposantX)+','+
                 floatToStrLatex(b/exposantY)+
                 ') node'+code+' {'+Atexte+'} ;');
      end;
    end;
end; // Tdessin.DrawLatex

procedure TgrapheReg.TraceIdentPages;
var hauteur : integer;

function DrawTextCentered(const R : TRect;const S : String): Integer;
var
  DrawRect: TRect;
  DrawFlags: Cardinal;
  DrawParams: TDrawTextParams;
begin
  DrawRect := R;
  DrawFlags := DT_END_ELLIPSIS or DT_NOPREFIX or DT_WORDBREAK or
    DT_EDITCONTROL; // or DT_CENTER;
  DrawText(Canvas.Handle, PChar(S), -1, DrawRect, DrawFlags or DT_CALCRECT);
  DrawRect.Right := R.Right;
  if DrawRect.Bottom < R.Bottom
     then OffsetRect(DrawRect, 0, (R.Bottom - DrawRect.Bottom) div 2)
     else DrawRect.Bottom := R.Bottom;
  ZeroMemory(@DrawParams, SizeOf(DrawParams));
  DrawParams.cbSize := SizeOf(DrawParams);
  DrawTextEx(Canvas.Handle, PChar(S), -1, DrawRect, DrawFlags, @DrawParams);
  Result := DrawParams.uiLengthDrawn;
end;
Procedure TraceMarque(p : TcodePage);
var prompt : string;
    i,j : integer;
    motif : Tmotif;
    x,y : integer;
    R: TRect;
    premierParam : boolean;
begin
      if reperePage=SPcouleur
        then canvas.pen.color := couleurPages[P mod NbreCouleur]
        else canvas.pen.color := courbes[0].couleur;
      canvas.font.color := canvas.pen.color;
      if reperePage=SPmotif
        then motif := motifPages[P mod MaxPagesGr]
        else motif := courbes[0].motif;
      if (ChoixIdentPagesDlg=nil) then
          Application.CreateForm(TChoixIdentPagesDlg, ChoixIdentPagesDlg);
      y := (p-1)*hauteur+hautCarac;
      x := LimiteCourbe.right+marge;
      if choixIdentPagesDlg.commentaireCB.checked
         then prompt := Pages[P].commentaireP+crCR+crLF
         else prompt := '';
      try
      premierParam := true;
      for i := 0 to pred(NbreConst) do
          if choixIdentPagesDlg.ListeConstBox.checked[i] then begin
             if not premierParam then prompt := prompt +' ; ';
             premierParam := false;
             j := indexConst[i];
             prompt := prompt +
                Grandeurs[j].formatNomEtUnite(Pages[P].ValeurConst[j]);
          end;
      for i := 1 to NbreParam[paramNormal] do
          if choixIdentPagesDlg.ListeConstBox.checked[NbreConst+i-1] then begin
             if not premierParam then prompt := prompt +' ; ';
             premierParam := false;
             prompt := prompt +
                Parametres[paramNormal,i].formatNomEtUnite(Pages[P].ValeurParam[paramNormal,i]);
          end;
      if prompt='' then prompt := Pages[P].commentaireP;
      case reperePage of    // espace pour les marques
         SPmotif : prompt := '      '+prompt;
         SPstyle : prompt := '         '+prompt;
      end;
      SetRect(R, x, y, limiteFenetre.right, y+hauteur);
    //   Canvas.Rectangle(R);
      InflateRect(R, -1, -1);
      Canvas.MoveTo(x,y);
      Canvas.LineTo(limiteFenetre.right,y);
      DrawTextCentered(R, prompt);
      case reperePage of
         SPmotif : traceMotif(x+largCarac,y+2*hautCarac div 3,motif);
         SPstyle : begin
           createPen(stylePages[P mod maxPagesGr],1,canvas.Pen.color);
           y := y+hautCarac div 2;
           segment(x,y,x+3*largCarac,y);
           canvas.pen.style := psSolid;
         end;
      end;
      except // protection ListConstBox
        choixIdentPagesDlg.initParam;
      end;
end; // TraceMarque

var p : integer;
begin
    hauteur := limiteCourbe.height div NbrePages;
    for p := 1 to NbrePages do
        if Pages[p].active then traceMarque(p);
end;

procedure TGrapheReg.Draw;

  procedure TraceEquivalence(p: TcodePage);
  const
    maxTexte = 16;
  var
    c, NbreTexteX,nbreTexteY, i: integer;
    xi, yi : integer;
    chaine: string;
    NumEquX,NumEquY: array[1..MaxTexte] of integer;
    affiche: boolean;
    dx, dy: double;
  begin
    for c := 1 to maxTexte do begin
       numEquX[c] := -1; numEquY[c] := -1;
    end;
    NbreTexteX := 0; NbreTexteY := 0;
//    canvas.font.Height := HautCarac;
    with limiteCourbe do begin
       dy := canvas.TextHeight('0')+4;
       dx := canvas.TextWidth('000000');
    end;
    for c := 0 to pred(equivalences[p].Count) do begin
     // if (gmEquivalence in modif) then equivalences[p].items[c].modifDerivee(self);
      equivalences[p].items[c].draw;
      affiche := (p=pageCourante) and (equivalences[p].items[c].correcte);
      if affiche then case equivalences[p].items[c].ligneRappel of
         lrX : for i := 1 to NbreTexteX do
           affiche := abs(equivalences[p].items[c].x2i -
              equivalences[p].items[numEquX[i]].x2i) > dx;
         lrY,lrPente : affiche := false;
         lrTangente : for i := 1 to NbreTexteX do
           affiche := abs(equivalences[p].items[c].vei -
              equivalences[p].items[numEquX[i]].vei) > dx;
         else for i := 1 to NbreTexteX do // lrXdeY lrReticule lrEquivalence
           affiche := abs(equivalences[p].items[c].vei -
              equivalences[p].items[numEquX[i]].vei) > dx;
      end;
      if affiche and (NbreTexteX < maxTexte) then begin
        Inc(NbreTexteX);
        numEquX[NbreTexteX] := c;
      end;
      affiche := (p=pageCourante) and (equivalences[p].items[c].correcte);
      if affiche then case equivalences[p].items[c].ligneRappel of
         lrX,lrPente : affiche := false;
         lrY : for i := 1 to NbreTexteY do
            affiche := abs(equivalences[p].items[c].y1i -
                           equivalences[p].items[numEquY[i]].y1i) > dy;
         lrTangente : for i := 1 to NbreTexteY do
           affiche := abs(equivalences[p].items[c].phei -
              equivalences[p].items[numEquY[i]].phei) > dy;
         else for i := 1 to NbreTexteY do // lrXdeY lrReticule lrEquivalence
           affiche := abs(equivalences[p].items[c].pHei -
              equivalences[p].items[numEquY[i]].pHei) > dy;
      end;
      if affiche and (NbreTexteY < maxTexte) then begin
        Inc(NbreTexteY);
        numEquY[NbreTexteY] := c;
      end;
    end; // equivalences
    c := pred(equivalences[pageCourante].Count);
    while c>0 do begin
        if not equivalences[pageCourante].items[c].correcte then
           equivalences[pageCourante].Delete(c);
        dec(c);
    end;
    exclude(modif,gmEquivalence);
    canvas.font.style := [fsBold];
    for i := 1 to NbreTexteY do with equivalences[p].items[numEquY[i]] do begin
        canvas.font.Color := colorToRGB(pen.color);
        WindowRT(ve, pHe, mondepH, xi, yi);
        chaine := '';
        case LigneRappel of
            lrTangente : begin
               setUnitePente(mondepH);
               chaine := unitePente.formatNomPenteUnite(pente);
            end;
            lrX,lrPente : ;
            lrY : begin
                 if monde[mondepH].axe<>nil
                    then chaine := monde[mondepH].axe.formatNombre((y2-y1)/ monde[mondepH].Fexposant) + ' '
                    else chaine := formatReg((y2-y1)/ monde[mondepH].Fexposant) + ' ';
                 xi := LimiteCourbe.right - marge;
                 yi := (y1i+y2i) div 2;
            end;
            else begin  // lrXdeY lrReticule lrEquivalence
              if monde[mondepH].axe = nil
                 then chaine := formatReg(pHe / monde[mondepH].Fexposant) + ' '
                 else chaine := monde[mondepH].axe.formatNombre(pHe / monde[mondepH].Fexposant) + ' ';
              yi := yi + margeCaracY;
              case mondepH of
                 mondeY: xi := limiteCourbe.left + marge;
                 mondeDroit: xi := limiteCourbe.right - marge;
              end;// case monde
              if commentaire <> '' then
                 MyTextOut(xi + largCarac, yi - hautCarac, commentaire);
            end;
        end;// case ligneRappel
        if (xi > limiteCourbe.right div 2)
           then SetTextAlign(TA_right + TA_top)
           else SetTextAlign(TA_left + TA_top);
        if chaine<>'' then MyTextOutFond(xi, yi, chaine,FondReticule);
    end;
    SetTextAlign(TA_left + TA_top);
    for i := 1 to NbreTexteX do with equivalences[p].items[numEquX[i]] do begin
          canvas.font.Color := colorToRGB(pen.color);
          chaine := '';
          case LigneRappel of
            lrX : begin
                 if monde[mondeX].axe=nil
                    then chaine := formatReg((x2-x1)/ monde[mondeX].Fexposant) + ' '
                    else chaine := monde[mondeX].axe.formatNombre((x2-x1)/ monde[mondeX].Fexposant) + ' ';
                 xi := (x2i+x1i) div 2;
                 yi := limiteCourbe.top;
            end;
            lrY,lrPente,lrTangente : ;
            else begin  // lrXdeY lrReticule lrEquivalence
              if monde[mondeX].axe = nil
                 then chaine := formatReg(ve / monde[mondeX].Fexposant) + ' '
                 else chaine := monde[mondeX].axe.formatNombre(ve / monde[mondeX].Fexposant) + ' ';
              WindowRT(ve, pHe, mondepH, xi, yi);
              xi := xi + marge;
              yi := limiteCourbe.bottom + margeCaracY;
            end;
         end;// case ligneRappel
         if chaine<>'' then MyTextOutFond(xi-(canvas.textWidth(chaine) div 2), yi, chaine,FondReticule);
    end;
    SetTextAlign(TA_left + TA_top);
    canvas.font.style := [];
  end; // TraceEquivalence

  procedure TraceEquivalenceParam;
  var
    c: integer;
    xi,yi: integer;
    chaine: string;
  begin
    for c := 0 to pred(equivalences[0].Count) do
      with equivalences[0].items[c] do begin
        draw;
        canvas.font.Color := colorToRGB(pen.color);
 //       canvas.font.Height := HautCarac;
        WindowRT(ve, pHe, mondepH, xi, yi);
        if (xi > (2 * limiteCourbe.right div 3)) then
          SetTextAlign(TA_right + TA_top);
        if LigneRappel=lrReticule then begin
               if monde[mondepH].axe = nil
                  then chaine := formatReg(pHe / monde[mondepH].Fexposant) + ' '
                  else chaine := monde[mondepH].axe.formatNombre(pHe / monde[mondepH].Fexposant) + ' ';
               case mondepH of
                  mondeY: MyTextOutFond(limiteCourbe.left +
                       marge, yi + margeCaracY, chaine,FondReticule);
                  mondeDroit: MyTextOutFond(
                     limiteCourbe.right - succ(
                     monde[mondeDroit].NbreChiffres) * largCarac,
                     yi + margeCaracY, chaine,FondReticule);
               end;// case monde
               if monde[mondeX].axe = nil
                   then chaine := formatReg(ve / monde[mondeX].Fexposant) + ' '
                   else chaine := monde[mondeX].axe.formatNombre(ve / monde[mondeX].Fexposant) + ' ';
               myTextOutFond(xi + marge, limiteCourbe.bottom + margeCaracY, chaine, FondReticule);
               SetTextAlign(TA_left + TA_top);
        end;
      end;
  end; // TraceEquivalenceParam

  procedure AfficheEtiquetteSegment;
  var
    couleurCurseur: TcolorRef;

    procedure DebutSegment;

      procedure InitCurseur(Acurseur : integer);
      var ecart: integer;
      begin with curseurOsc[Acurseur] do begin
          if mondeC = mondeX then exit;
          with courbes[indexCourbe] do begin
            ecart := (finC + debutC) div 3;
            if (Ic <= debutC) or (Ic >= finC) then
              Ic := (Acurseur - curseurData1 + 1)* ecart;
            if (acurseur = curseurData2) and (curseurOsc[curseurData1].Ic = curseurOsc[curseurData2].Ic) then
              if curseurOsc[curseurData1].ic > ((finC + debutC) div 2)
                 then curseurOsc[curseurData2].ic := ecart
                 else curseurOsc[curseurData2].ic := 2 * ecart;
            Xr := valX[Ic];
            Yr := valY[Ic];
            windowRT(Xr, Yr, iMondeC, Xc, Yc);
            CCourant := acurseur;
  // Attention au zoom
            if ogPolaire in optionGraphe
               then
               else if (Xr<monde[mondeX].Mini) or (Xr>monde[mondeX].Maxi) then begin
                  Xr:= monde[mondeX].Mini + (monde[mondeX].Maxi-monde[mondeX].Mini)*(aCurseur-CurseurData1+1)/3;
                  Ic := PointProcheReal(Xr, 0,courbes[indexCourbe], MondeX);
                  Yr := valY[Ic];
                  windowRT(Xr, Yr, iMondeC, Xc, Yc);
               end;
          end;
      end end;

    var
      j: integer;
      i: integer;
    begin with canvas do begin
        for j := curseurData1 to curseurData2 do begin
            CurseurOsc[j].mondeC := mondeX;
            CurseurOsc[j].indexCourbe := -1;
        end;
        for i := 0 to pred(courbes.Count) do
          with courbes[i] do
            if page = pageCourante then
              for j := curseurData1 to curseurData2 do
                if (CurseurOsc[j].grandeurCurseur <> nil) and
                   (CurseurOsc[j].indexCourbe = -1) and
                  (CurseurOsc[j].grandeurCurseur = varY) then begin
                  CurseurOsc[j].mondeC := iMondeC;
                  CurseurOsc[j].indexCourbe := i;
                end;
        InitCurseur(curseurData1);
        InitCurseur(curseurData2);
        if CurseurOsc[curseurData1].mondeC <> CurseurOsc[curseurData2].mondeC then
          exclude(optionCurseur, coPente);
        if not(coPente in optionCurseur) then exit;
        setUnitePente(CurseurOsc[curseurData1].mondeC);
    end end; // DebutSegment

    procedure TraceString(i: integer);
    var
      st: string;
      xi, yi: integer;
      x0,y0 : integer;
      xx,yy : double;
    begin
    with curseurOsc[i] do begin
        if mondeC = mondeX then exit;
        traceCurseur(i);
        windowRT(xr, yr, mondeC, xi, yi);
        if coY in OptionCurseur then begin
            if monde[mondeC].graduation = gdB
               then st := GrandeurCurseur.nom + '=' + formatGeneral(
                  20 * log10(yr), precisionMin) + ' dB'
               else st := GrandeurCurseur.formatValeurEtUnite(Yr);
            if OgPolaire in optionGraphe
               then begin
                    windowRT(0,0,mondeC,x0,y0);
                    MyTextOutFond((x0 + xi) div 2,
                                  (y0 + yi) div 2,
                                  st,FondReticule);
               end
               else MyTextOutFond(LimiteCourbe.left + marge,
                        yi + margeCaracY div 2,st,FondReticule);
               valeurCurseur[coY] := yr;
        end;
        if coX in OptionCurseur then begin
            st := monde[mondeX].Axe.formatValeurEtUnite(Xr);
            if OgPolaire in optionGraphe
               then begin
                   windowRT(0,0,mondeC,x0,y0);
                   mondeRT(xi, yi, mondeC, xx, yy);
                   MyTextOutFond(x0+round(rayonArcAngle*cos(xx/2)),
                                 y0-round(rayonArcAngle*sin(xx/2)),
                                 st,FondReticule);
               end
               else MyTextOutFond(xi - largCarac*length(st) div 2,
                        limiteCourbe.bottom + margeCaracY,st,FondReticule);
            valeurCurseur[coX] := xr;
        end;
    end end; // TraceString

    procedure setPente;
    var
      st: string;
      dx, dy: double;
      dxNul: boolean;
      largeur: integer;
      xi, yi, x1, y1, x2, y2: integer;
      posTrait, signe: integer;
    begin
        dxNul := CurseurOsc[curseurData1].Xc = CurseurOsc[curseurData2].Xc;
        dx := 1;
        dy := 1;
        tracePente;
        createPen(psSolid, 1, couleurCurseur);
        try
          windowRT((CurseurOsc[curseurData1].xr + CurseurOsc[curseurData2].xr) / 2,
                   (CurseurOsc[curseurData1].yr + CurseurOsc[curseurData2].yr) / 2,
                    curseurOsc[curseurData1].mondeC, xi, yi);
          with CurseurOsc[curseurData2] do windowRT(xr, yr, mondeC, x2, y2);
          with CurseurOsc[curseurData1] do windowRT(xr, yr, mondeC, x1, y1);
          if ((coDeltaY in optionCurseur) or (coPente in optionCurseur)) and
            (CurseurOsc[curseurData1].mondeC = CurseurOsc[curseurData2].mondeC) then begin
            with monde[CurseurOsc[curseurData1].mondeC] do
              case Graduation of
                gLog: begin
                  dY := abs(CurseurOsc[curseurData1].yr / CurseurOsc[curseurData2].yr);
                  st := ' ' + axe.nom + '*' + formatReg(dY);
                  dY := log10(dY);
                end;
                gInv: begin
                  dY := abs(1 / CurseurOsc[curseurData1].yr - 1 / CurseurOsc[curseurData2].yr);
                  st := ' d(' + axe.nom + ')=' + formatReg(dY);
                end;
                gLin: begin
                  dY := abs(CurseurOsc[curseurData1].yr - CurseurOsc[curseurData2].yr);
                  st := axe.FormatValeurEtUnite(dY);
                end;
                gdB: begin
                  dY := 20 * abs(log10(curseurOsc[2].Yr / curseurOsc[1].Yr));
                  st := formatGeneral(dY, precisionMin) + ' dB';
                end;
                gBits: begin
                  dY := 1;
                  st := '';
                end;
              end;// case graduation
            if (coDeltaY in optionCurseur) and
               (CurseurOsc[curseurData1].mondeC = CurseurOsc[curseurData2].mondeC) then begin
              largeur  := length(st) * largCarac div 2;
              posTrait := LimiteCourbe.right - largeur;
              if OgPolaire in optionGraphe
                 then begin
                     dY := sqrt(sqr(CurseurOsc[curseurData1].yr)+sqr(CurseurOsc[curseurData2].yr)-
                        2*CurseurOsc[curseurData1].yr*CurseurOsc[curseurData2].yr*
                        cos(CurseurOsc[curseurData1].xr-CurseurOsc[curseurData2].xr));
                     st := monde[CurseurOsc[curseurData1].mondeC].axe.FormatValeurEtUnite(dY);
                     MyTextOutFond((x1+x2) div 2, (y1+y2) div 2,st,fondReticule);
                 end
                 else begin
                    segment(posTrait, y1, posTrait, y2);
                     // fléches
                    if y1 < y2
                       then signe := 1
                       else signe := -1;
                    Segment(posTrait - marge, y1 + 3 * signe * marge, posTrait, y1);
                    Segment(posTrait + marge, y1 + 3 * signe * marge, posTrait, y1);
                    signe := -signe;
                    Segment(posTrait - marge, y2 + 3 * signe * marge, posTrait, y2);
                    Segment(posTrait + marge, y2 + 3 * signe * marge, posTrait, y2);
                    MyTextOutFond(LimiteCourbe.right - largeur * 2, yi,st,fondReticule);
                 end;
              valeurCurseur[coDeltaY] := dY;
            end;
          end;
          if (coDeltaX in optionCurseur) or (coPente in optionCurseur) then begin
            with monde[mondeX] do
              case Graduation of
                gLog: begin
                  dX := abs(CurseurOsc[curseurData2].xr / CurseurOsc[curseurData1].xr);
                  st := ' ' + axe.nom + '*' + formatReg(dX);
                  dX := log10(dX); { décade }
                end;
                gInv: begin
                  dX := abs(1 / CurseurOsc[curseurData1].xr - 1 / CurseurOsc[curseurData2].xr);
                  st := formatReg(dX);
                end;
                gLin: begin
                  dX := abs(CurseurOsc[curseurData1].xr - CurseurOsc[curseurData2].xr);
                  st := Axe.FormatValeurEtUnite(dX);
                end;
              end; // case graduation
            if (coDeltaX in optionCurseur) then begin
              posTrait := limiteCourbe.top + hautCarac div 2;
              if OgPolaire in optionGraphe
                 then begin
                    windowRT(0, 0, mondeY, x2, y2);
                    MyTextOutFond(x2 - length(st) * largCarac div 2,y2,st,FondReticule);
                 end
                 else begin
                    segment(x1, posTrait, x2, posTrait);
                    if x1 < x2 // fléche
                       then signe := 1
                       else signe := -1;
                    Segment(x1 + signe * marge * 3, posTrait + marge, x1, posTrait);
                    Segment(x1 + signe * marge * 3, posTrait - marge, x1, posTrait);
                    signe := -signe;
                    Segment(x2 + signe * marge * 3, posTrait + marge, x2, posTrait);
                    Segment(x2 + signe * marge * 3, posTrait - marge, x2, posTrait);
                    MyTextOutFond( xi - length(st) * largCarac div 2,
                             limiteCourbe.top,st,FondReticule);
                 end;
              valeurCurseur[coDeltaX] := dX;
            end;// deltaX
          end;
          if not dxNul and (coPente in OptionCurseur) and not(OgPolaire in optionGraphe) then begin
            st := unitePente.formatNomPente(dY / dX);
            largeur := length(st) * largCarac div 2;
            MyTextOutFond(xi - largeur, yi,st,FondReticule);
            valeurCurseur[coPente] := dY / dX;
          end;
        except
        end;
    end; // setPente

  begin
    if not(monde[mondeX].defini) then exit;
    if not(monde[mondeY].defini) and
       not(monde[mondeDroit].defini) then exit;
    DebutSegment;
    setTextAlign( TA_top + TA_left);
    if cCourant=0
       then if curseurOsc[curseurData1].indexCourbe >= 0
          then couleurCurseur := courbes[curseurOsc[curseurData1].indexCourbe].couleur
          else couleurCurseur := pColorReticule
       else couleurCurseur := CouleurCurseurs[cCourant];
    canvas.font.Color := couleurCurseur;
    if (([coPente, coDeltaX, coDeltaY] * optionCurseur) <> []) or
         (CurseurOsc[curseurData1].mondeC <> mondeX) then
        setPente;
    traceString(curseurData1);
    traceString(curseurData2);
  end; // AfficheEtiquetteSegment

    procedure AfficheEtiquetteReticule;

    procedure DebutSegment;
    var
      i: integer;
    begin with canvas, CurseurOsc[1] do begin
        mondeC := mondeY;
        indexReticuleModele := -1;
        for i := 0 to pred(courbes.Count) do
            with courbes[i] do
            if (page=pageCourante) and (indexModele=1) and not courbeExp then
                if indexReticuleModele=-1 then begin
                      indexReticuleModele := i;
                      mondeC := iMondeC;
                      grandeurCurseur := varY;
                end;
        if indexReticuleModele<0 then exit; // ne devrait pas arriver !
        with courbes[indexReticuleModele] do begin
            if (Ic <= debutC) or (Ic >= finC) then
                Ic := (debutC+finC) div 2;
            Xr := valX[Ic];
            Yr := valY[Ic];
            windowRT(Xr, Yr, mondeC, Xc, Yc);
        end;
    end; end;// DebutSegment

    procedure TraceString;
    var
      st: string;
      xi, yi: integer;
    begin with curseurOsc[1] do begin
        traceCurseur(1);
        windowRT(xr, yr, mondeC, xi, yi);
        if monde[mondeC].graduation = gdB
           then st := GrandeurCurseur.nom + '=' + formatGeneral(
              20 * log10(yr), precisionMin) + ' dB'
           else st := GrandeurCurseur.formatValeurEtUnite(Yr);
        MyTextOutFond(LimiteCourbe.left + marge,
                      yi + margeCaracY div 2,st,FondReticule);
        valeurCurseur[coY] := Yr;
        st := monde[mondeX].Axe.formatValeurEtUnite(Xr);
        MyTextOutFond(xi - largCarac * length(st) div 2,
                      limiteCourbe.bottom + margeCaracY,st,FondReticule);
        valeurCurseur[coX] := Xr;
    end end; // TraceString

  begin
    if not (monde[mondeX].defini) or not grapheOK then exit;
    DebutSegment;
    setTextAlign(TA_top + TA_left);
    canvas.font.Color := pColorReticule;
    traceString;
  end; // AfficheEtiquetteReticule

var
  c, i: integer;
  p:  TcodePage;
  SupprDessin,CoordTrouve: boolean;
  nX: string;
  m: TindiceMonde;
begin // graphe.draw
  margeBorne := 4*Screen.PixelsPerInch div 96;
  dimBorne := 2*margeBorne;
  with limiteFenetre do begin
    if (right - left) < 50 then exit;
    dimPoint := screen.width * dimPointVGA div 1280; // HD 1280 ; FullHD = 1920 ; UHD 3840 ; Mac 5120
     // soit HD 1 ; FullHD 1 ; UHD 3 ; Mac 4
    if dimPoint<1 then dimPoint := 1;
    marge := (bottom-top);
    BorneFenetre.top := top-marge;
    BorneFenetre.bottom := bottom+marge;
    marge := (right-left) div 16;
    BorneFenetre.right := right+marge;
    BorneFenetre.left := left-marge;
  end;
  monde[mondeX].miniInt := borneFenetre.left-marge;
  monde[mondeX].maxiInt := borneFenetre.right+marge;
  for m := mondeY to high(TindiceMonde) do begin
      monde[m].miniInt := borneFenetre.top-marge;
      monde[m].maxiInt := borneFenetre.bottom+marge;
  end;
  canvas.font.Name := FontName;
  with limiteFenetre do begin
       if imprimanteEnCours or ImageEnCours or WMFEnCours
          then canvas.Font.Height := height div 20
          else canvas.Font.Height := width div 50;
       if abs(canvas.Font.Size)<10 then
           canvas.Font.Height := 10*canvas.Font.PixelsPerInch div 72;
       if (abs(canvas.Font.Size)>18) and not WMFEnCours then
           canvas.Font.Height := 18*canvas.Font.PixelsPerInch div 72;
       if wmfEnCours
          then penWidth := xMaxWMF div 1920
          else penWidth := screen.width div 1500;  // HD 1280 ; FullHD = 1920 ; UHD 3840 ; Mac 5120
          // soit HD 1 ; FullHD 1 ; UHD 2 ; Mac 3
       // Font.Size = -Font.Height * 72 / Font.PixelsPerInch
       if penWidth<1 then penWidth := 1;
  end;
  CreatePen(psDot, 1, clBlack);
  canvas.brush.style := bsClear;
  canvas.pen.mode := pmCopy;
  LargCarac := canvas.textWidth('A');
  HautCarac := canvas.textHeight('A');
  Marge := largCarac div 2;
  MargeHautBas := hautCarac div 2;
  margeCaracY := -hautCarac - marge;
  EmpilePage := (OgAnalyseurLogique in optionGraphe) and SuperposePage;
  if (OgOrthonorme in OptionGraphe) and not
    (OgPolaire in OptionGraphe) and (monde[mondeY].axe <> nil) and
    (monde[mondeX].axe <> nil) and
    (monde[mondeY].axe.nomUnite <> monde[mondeX].axe.nomUnite) then
    exclude(OptionGraphe, ogOrthonorme);
  chercheMonde;
  if not grapheOK then exit;
  setRepere;
  UnAxeX := True;
  if (courbes.Count > 0) and (courbes[0].varx <> nil) then begin
    nX := courbes[0].varx.nom;
    for c := 1 to pred(Courbes.Count) do
      with courbes[c] do
        if (varX <> nil) and (varX.nom <> nX) then
          unAxeX := False;
  end;
  if (courbes.Count > 0) and
     not (trIntensite in courbes[0].trace) then
       drawAxis(true);
//   drawAxis(graduationZeroX or graduationZeroY);
  indexHisto := 0;
  if withDebutFin then TraceBorneFFT;
  NbreHisto := 0;
  numeroHisto := 0;
  for c := 0 to pred(Courbes.Count) do
      if courbes[c].motif=mHisto then inc(NbreHisto);
  for c := 0 to pred(Courbes.Count) do
    traceCourbe(c);
  c := 0;
  while (c < Dessins.Count) do
    with dessins[c] do
      if isTexte then begin
        SupprDessin := True;
        for i := 0 to pred(texte.Count) do
          if length(texte[i]) > 0 then
             SupprDessin := False;
        if motifTexte<>mtNone then SupprDessin := False;
        if (identification = identCoord) then begin
            CoordTrouve := false;
            for i := 0 to pred(courbes.Count) do begin
                CoordTrouve := numCoord = indexNom(courbes[i].varY.nom);
                if CoordTrouve then break;
            end;
            SupprDessin := not CoordTrouve;
        end;
        if SupprDessin and (identification<>identDroite)
            then Dessins.remove(dessins[c])
            else Inc(c);
      end
      else Inc(c);
  for c := pred(Dessins.Count) downto 0 do
    if (dessins[c].identification=identNone) and
      (dessins[c].numPage > NbrePages) then
      dessins.remove(dessins[c]);
  c := 0;
  while c<Dessins.Count do begin
    dessins[c].draw;
    inc(c);
  end;
  if graduationZeroX or graduationZeroY then drawAxis(False);
  if grapheParam
  then traceEquivalenceParam
  else if superposePage
     then for p := 1 to NbrePages do
        traceEquivalence(p)
     else if pageCourante>0 then traceEquivalence(pageCourante);
  case curseurActif of
      curReticuleData : AfficheEtiquetteSegment;
      curReticuleModele : AfficheEtiquetteReticule;
  end;
 // if withDebutFin then TraceBorneFFT;
  if FilDeFer then traceFilDeFer;
  canvas.TextFlags := 0; // transparent
  setTextAlign(TA_left + TA_top);
  if identificationPages and superposePage
     then traceIdentPages
end; // graphe.draw

procedure TGrapheReg.ResetEquivalence;
var
  p: TcodePage;
begin
  for p := 0 to MaxPages do
      equivalences[p].Clear;
end;

procedure TGrapheReg.raz;
begin
  courbes.Clear;
  monde[mondeX].defini := False;
  GrapheOK  := False;
  AutoTick  := True;
  UseDefaut := False;
  useZoom := false;
  useDefautX := false;
  borneVisible := true;
end;

destructor TGrapheReg.Destroy;
var
  m: TindiceMonde;
  p: TcodePage;
begin
  courbes.Clear;
  courbes.Free;
  dessins.Clear;
  dessins.Free;
  for p := 0 to MaxPages do begin
    equivalences[p].Clear;
    equivalences[p].Free;
  end;
  equivalenceTampon.Free;
  statusSegment[0].Free;
  statusSegment[1].Free;
  for m := low(TindiceMonde) to high(TIndiceMonde) do
    monde[m].Free;
  for m := 1 to 2 do
    mondeVecteur[m].Free;
  for m := 1 to MaxOrdonnee do
    if coordonnee[m].regionTitre <> 0 then
      DeleteObject(coordonnee[m].regionTitre);
  UnitePente.Free;
  inherited Destroy;
end;

constructor TGrapheReg.Create;
var
  m: TindiceMonde;
  i: TindiceOrdonnee;
  k: integer;
  p: TcodePage;
begin
  inherited Create;
  grapheParam := false;
  modif := [gmXY];
  mondeDerivee := mondeY;
  UnitePente := Tunite.Create;
  for m := low(TindiceMonde) to high(TIndiceMonde) do
    monde[m] := Tmonde.Create;
  monde[mondeX].horizontal := True;
  for m := 1 to 2 do
    mondeVecteur[m] := TmondeVecteur.Create;
  mondeVecteur[2].vitesse := False;
  for i := 1 to maxOrdonnee do
    with Coordonnee[i] do begin
      nomX  := '';
      nomY  := '';
      iMondeC := mondeY;
      Couleur := couleurInit[i];
      StyleT := psSolid;
      motif := motifInit[i];
      RegionTitre := 0;
      trace := [];
      couleurPoint := '';
      codeCouleur := tSigne;
    end;
  for k := 1 to maxCurseur do with curseurOsc[k] do begin
      grandeurCurseur := nil;
      indexCourbe := 0;
      mondeC := mondeY;
  end;
  zeroPolaire := 0;
  optionCurseur := [coX, coY, coDeltaX, coDeltaY];
  OptionGraphe := OptionGrapheDefault;
  OptionModele := [OmExtrapole];
  courbes := TlisteCourbe.Create;
  dessins := TlisteDessin.Create;
  for p := 0 to MaxPages do
    equivalences[p] := TlisteEquivalence.Create;
  equivalenceTampon := Tequivalence.Create(0, 0, 0, 0, 0, 0, 0, self);
  statusSegment[0] := TStringList.Create;
  statusSegment[1] := TStringList.Create;
  for k := 1 to 3 do
      curseurOsc[k].Ic := 10 + 10 * k;
  curseurActif := curSelect;
  FilDeFer := False;
  PasPoint := 1;
  PixelsPerInchX := 1;
  PixelsPerInchY := 1;
  UnAxeX := True;
  BitmapReg := TBitmap.Create;
  raz;
  avecAxeX := True;
  avecAxeY := True;
  AutoTick := True;
  borneVisible := true;
end;

procedure Tcourbe.setStyle(Acouleur: Tcolor; Astyle: TpenStyle; Amotif: Tmotif);
begin
  couleur := ACouleur;
  styleT := Astyle;
  motif := AMotif;
end;

procedure Tcourbe.setStylePoint(AcouleurPoint : string;AcodeCouleur : TcodeCouleur);
begin
  couleurPoint := AcouleurPoint;
  codeCouleur := AcodeCouleur;
end;

constructor Tcourbe.Create(AX, AY: Tvecteur; D, F: integer; VX, VY: tgrandeur);
begin
  valX  := AX;
  valY  := AY;
  incertX := nil;
  incertY := nil;
  DebutC := D;
  FinC  := F;
  Decalage := 0;
  case TraceDefaut of
      tdPoint : Trace := [trPoint];
      tdLigne : Trace := [trLigne];
      tdLissage : Trace := [trLigne,trPoint];
  end;
  varY  := VY;
  varX  := VX;
  texteC := nil;
  OptionLigne := LiDroite;
  couleur := CouleurPages[1];
  styleT := stylePages[1];
  Motif := MotifPages[1];
  IndexModele := 0;
  IndexBande := 0;
  Adetruire := False;
  DetruireIncert := False;
  CourbeExp := False;
  iMondeC := MondeY;
  ModeleParametrique := False;
  PortraitDePhase := False;
  valXder := nil;
  valYder := nil;
  valXder2 := nil;
  valYder2 := nil;
  valXe := nil;
  valYe := nil;
  lenvalxe := 0;
  pointSelect := [];
end;

destructor Tcourbe.Destroy;
begin
  if Adetruire then begin
     finalize(valX);
     finalize(valY);
  end;
  if DetruireIncert then begin
    finalize(incertX);
    finalize(incertY);
  end;
  if valxe<>nil then begin
     finalize(valXe);
     finalize(valYe);
  end;
  texteC.Free;
  inherited Destroy;
end;

function TGrapheReg.AffecteZoom(Location : Tpoint;distance : integer;avecY : boolean) : boolean;
 var centre : TPointF;

  procedure AffecteZoomY(m : integer);
  var minY, maxY,y0: double;
      coeffY : single;
  begin with monde[m] do begin
      coeffY := 1-distance/limiteCourbe.height;
      y0 := (centre.y-B) / A;
      A := A*coeffY;
      B := centre.Y-A*y0;
      maxY := (limiteCourbe.top-B)/ A;
      minY := (limiteCourbe.bottom-B) / A;
      VerifMinMaxReal(MinY, MaxY);
      Mini := MinY;
      Maxi := MaxY;
      defini := true;
  end end;

  procedure AffecteZoomX;
  var minX, maxX, x0: double;
      coeffX : single;
  begin with monde[mondeX] do begin
      coeffX := 1-distance/limiteCourbe.width;
      x0 := (centre.x-B) / A;
      A := A*coeffX;
      B := centre.X-A*x0;
      minX := (limiteCourbe.left-B) / A;
      maxX := (limiteCourbe.right-B) / A;
      VerifMinMaxReal(MinX, MaxX);
      Mini := MinX;
      Maxi := MaxX;
      defini := true;
  end end;

begin
  result := false;
  if abs(distance)>(limiteCourbe.width+limiteCourbe.height)/4 then exit;
  if abs(distance)<12 then exit;
  centre := Location;
  centre.Offset(-distance/2,-distance/2);
  affecteZoomX;
  if avecY then begin
     affecteZoomY(mondeY);
     if monde[mondeDroit].defini then affecteZoomY(mondeDroit);
  end;
  result := true;
  //useDefault := true;
  useZoom := true;
  useDefaut := false;
  useDefautX := false;
end; // AffecteZoomAvant

procedure TGrapheReg.AffecteZoomArriere;

  procedure CalcMinMax(newMin,newMax : integer;m: TindiceMonde);
// A l'entrée MinInt est l'entier représentant Mini
// A la sortie Mini est le réel correspondant à NewMin
  var
      absMax, absMin:  double;
  begin with monde[m] do begin
      a := a/2;
      b := b+a*(Mini+Maxi)/2;
      Mini := (newMin-b)/a;
      Maxi := (newMax-b)/a;
      absMax := abs(maxi);
      absMin := abs(mini);
      if absMax < absMin then absMax := absMin;
      graduationPiActive := graduationPiActive and
        ((not (AngleEnDegre) and (absMax > 0.8) and (absMax < 13)) or
        (AngleEnDegre and (absMax > 45) and (absMax < 720)));
  end end;

var
  m: TindiceMonde;
begin
  useDefaut := false;
  useDefautX := false;
  useZoom := true;
  CalcMinMax(limiteCourbe.left,limiteCourbe.right,mondeX);
  if OgAnalyseurLogique in OptionGraphe then exit;
  for m := mondeY to high(TIndiceMonde) do
     if monde[m].defini then
        CalcMinMax(limiteCourbe.bottom,limiteCourbe.top, m);
end;// AffecteZoomArriere

procedure TGrapheReg.AffecteZoomAvant(rect: Trect; avecY: boolean);
var
  minX, maxX, minY, maxY: double;

  procedure AffecteZoomLoc(m: TindiceMonde);
  begin
    with monde[m], rect do begin
      MondeXY(left, top, m, minX, maxY);
      MondeXY(right, bottom, m, maxX, minY);
      VerifMinMaxReal(MinY, MaxY);
      if MinY > Mini then
        Mini := MinY;
      if MaxY < Maxi then
        Maxi := MaxY;
    end;
  end;

var
  m: TindiceMonde;
begin
  with monde[mondeX], rect do begin
    MondeXY(left, top, mondeY, minX, maxY);
    MondeXY(right, bottom, mondeY, maxX, minY);
    verifMinMaxReal(MinX, maxX);
    if MinX > Mini then
      Mini := MinX;
    if MaxX < Maxi then
      Maxi := MaxX;
    useDefautX := true;
  end;
  if avecY then begin
    for m := mondeY to high(TindiceMonde) do
      if monde[m].defini then begin
        affecteZoomLoc(m);
        break;
      end;
    useZoom := true;
  end;
end; // AffecteZoomAvant

destructor Tdessin.Destroy;
begin
  Texte.Free;
  Pen.Free;
  inherited Destroy;
end;

constructor Tdessin.Create(gr : TgrapheReg);
begin
  inherited Create;
  x1  := 0;
  y1  := 0;
  x2  := 0;
  y2  := 0;
  x1i := 0;
  y1i := 0;
  x2i := 0;
  y2i := 0;
  pen := Tpen.Create;
  pen.color := clBlue;
  vertical := False;
  centre := True;
  IsOpaque := False;
  hauteur := 3;
  isTexte := True;
  repere := nil;
  avecLigneRappel := False;
  motifTexte := mtNone;
  TexteLigne := tlNone;
  souligne := False;
  Texte := TStringList.Create;
  NumPage := 0;
  Identification := identNone;
  CouleurFond := colorToRGB(FondReticule);
  iMonde := MondeY;
  deplacable := True;
  alignement := TA_left + TA_top;
  sousDessin := nil;
  proprietaire := nil;
  Fgraphe := gr;
end; // Tessin.create

procedure TgrapheReg.RectangleGr(Arect: Trect);
begin
  canvas.pen.mode := pmNotXor;
  with Arect do
    canvas.Polygon([point(left, top), point(left, bottom), point(
        right, bottom), point(right, top)]);
  canvas.pen.mode := pmCopy;
end;

procedure TgrapheReg.LineGr(Arect: Trect);
begin
  Canvas.MoveTo(Arect.left, Arect.top);
  Canvas.LineTo(Arect.right, Arect.bottom);
end;

procedure Tdessin.AffectePosition(x, y: integer;
  posDessin: TselectDessin; Shift: TShiftState);

  procedure Affecte1;
  begin
    with Fgraphe do
      if isTexte and isTitre
        then with limiteFenetre do begin
          x1 := (x1i - left) / (right - left);
          y1 := (y1i - top) / (top - bottom);
        end
        else MondeRT(x1i, y1i, iMonde, x1, y1);
  end;

  procedure Affecte2;
  begin
    with Fgraphe do
      if isTexte and isTitre
         then with limiteFenetre do begin
            x2 := (x2i - left) / (right - left);
            y2 := (y2i - top) / (top - bottom);
         end
         else MondeRT(x2i, y2i, iMonde, x2, y2);
  end;

var dx, dy: integer;
    i : integer;
    newPoint : integer;
begin // AffectePosition
with Fgraphe do begin
    if not isTexte and
      ((abs(x1i - x2i) + abs(y1i - y2i)) < 3) then begin
      x2i := x1i + 2;
      y2i := y1i + 2;
    end;
    if (posDessin in [sdPoint1, sdHoriz, sdVert]) and
       (identification = identCoord) then begin
          for i := 0 to pred(Fgraphe.courbes.Count) do
            with Fgraphe.courbes[i] do
              if (numCoord = IndexNom(varY.nom)) then begin
                newPoint := pointProche(x, y, i, True, False);
                if newPoint > 0 then numPoint := newPoint;
                break;
              end;
    end;
    case posDessin of
      sdCadre: begin
        x2i := x;
        y2i := y;
        Affecte2;
      end;
      sdPoint2: begin
        if ssShift in Shift then
          if abs(x - x1i) > abs(y - y1i)
             then y := y1i
             else x := x1i;
        x2i := x;
        y2i := y;
        Affecte2;
      end;
      sdPoint1, sdHoriz, sdVert: begin
        x1i := x;
        y1i := y;
        Affecte1;
      end;
      sdCentre: begin
        dx  := x - ((x1i + x2i) div 2);
        dy  := y - ((y1i + y2i) div 2);
        x1i := x1i + dx;
        x2i := x2i + dx;
        y1i := y1i + dy;
        y2i := y2i + dy;
        Affecte1;
        Affecte2;
      end;
      sdNone: ;
    end;
end end; // AffectePosition

procedure TGrapheReg.AffecteCentreRect(x, y: integer; var r: Trect);
var
  maxi: integer;
begin with r do begin
    maxi := limiteFenetre.right;
    x := x + (right - left) div 2;
    if x > maxi then
      x := maxi;
    maxi := limiteFenetre.left;
    x := x - (right - left);
    if x < maxi then
      x := maxi;
    maxi := limiteFenetre.bottom;
    y := y + (bottom - top) div 2;
    if y > maxi then
      y := maxi;
    maxi := limiteFenetre.top;
    y := y - (bottom - top);
    if y < maxi then
      y := maxi;
    r := rect(x, y, x + right - left, y + bottom - top);
end end;

function Tdessin.LitOption(grapheC: TgrapheReg): boolean;
begin
  Fgraphe := grapheC;
  if isTexte then begin
    if LectureTexteDlg = nil then
      Application.createForm(TLectureTexteDlg, LectureTexteDlg);
    lectureTexteDlg.DessinLoc := self;
    lectureTexteDlg.grapheLoc := Fgraphe;
    litOption := lectureTexteDlg.showModal = mrOk;
  end
  else begin
    if OptionLigneDlg = nil then
      Application.createForm(TOptionLigneDlg, OptionLigneDlg);
    OptionLigneDlg.DessinLoc := self;
    OptionLigneDlg.Agraphe := Fgraphe;
    litOption := OptionLigneDlg.showModal = mrOk;
  end;
end;

procedure TGrapheReg.SetDessinCourant(x, y: integer);
var
  longueur: integer;

  function distance(i : integer) : integer;
  var
    a, b, c: integer;
  begin with dessins[i] do begin
      A := y1i - y2i;
      B := x2i - x1i;
      C := y2i * x1i - y1i * x2i;
      Longueur := round(sqrt(A * A + B * B));
      if longueur<1 then longueur := 1;
      Result := abs(A * x + B * y + C) div longueur;
  end end;

var
  i: integer;
  multX, multY: integer;
  x0i, y0i: integer; // 32 bits => pas de débordement
  d1, d2, d0, dmin: integer;
begin
  posDessinCourant := sdNone;
  dessinCourant := nil;
  for i := 0 to pred(dessins.Count) do with dessins[i] do begin
      if deplacable then
        if isTexte then begin
           with cadre do
             MultX := (x - left) * (x - right);
           with cadre do
             MultY := (y - top) * (y - bottom);
           if (MultX <= 0) and (MultY <= 0)
           then posDessinCourant := sdCadre
           else
           case motifTexte of
              mtHoriz: if abs(y - y1i) < 5 then
                  posDessinCourant := sdHoriz;
              mtVert: if abs(x - x1i) < 5 then
                  posDessinCourant := sdVert;
              else if (abs(x - x1i) + abs(y - y1i)) < 16 then
                  posDessinCourant := sdPoint1;
           end
        end // texte
        else // ligne
        if distance(i) < 16 then  begin
          x0i := (x1i + x2i) div 2;
          y0i := (y1i + y2i) div 2;
          d1  := abs(x - x1i) + abs(y - y1i);
          d2  := abs(x - x2i) + abs(y - y2i);
          d0  := abs(x - x0i) + abs(y - y0i);
          dmin := longueur div 3;
          if d1 < dmin then begin
            posDessinCourant := sdPoint1;
            dmin := d1;
          end;
          if d2 < dmin then begin
            posDessinCourant := sdPoint2;
            dmin := d2;
          end;
          if d0 < dmin then
             posDessinCourant := sdCentre;
        end; // ligne distance<16
    if posDessinCourant <> sdNone then begin
        dessinCourant := dessins[i];
        break;
    end;
  end; // for i
end; // setDessinCourant

procedure TGrapheReg.GetCurseurProche(x, y: integer; Force: boolean);
var i : integer;
begin
    cCourant := 0;
    for i := curseurData1 to curseurData2 do with curseurOsc[i] do
      if (indexCourbe >= 0) and
         (abs(x - xc) + abs(y - yc) < margeCurseur)
            then cCourant := i;
    if Force and (cCourant = 0) then
      if (CurseurOsc[curseurData2].indexCourbe >= 0) and
         ((abs(x - CurseurOsc[curseurData1].Xc) + abs(y - CurseurOsc[curseurData1].yc)) >
           (abs(x - CurseurOsc[curseurData2].Xc) + abs(y - CurseurOsc[curseurData2].yc)))
            then cCourant := curseurData2
            else cCourant := curseurData1;
end;

function TGrapheReg.GetReticuleModeleProche(x, y: integer) : boolean;
begin
    with CurseurOsc[1] do
    result :=  (abs(x - xc) + abs(y - yc) < margeCurseur)
end;

procedure Tmonde.SetDelta(grandAxe: boolean);
// FExposant=puissance de 10 multiple de 3 de manière à avoir entre
// NbreGradMax (10) et N/2.5 (4) graduations sur l'axes.
// ou NbreGradMin (5) et N/2.5 (2) graduations sur l'axes.
// Delta est l'intervalle entre les graduations qui commencent à PremiereGraduation

  procedure setDeltaLongueDuree;
  var
    N: integer;
  begin
    DeltaAxe := (maxi - mini) / 6;
    if DeltaAxe > UnMois then begin
      DeltaAxe := ceil(DeltaAxe / UnMois) * UnMois;
      FormatDuree := 'dd/mmm';
      ArrondiAxe  := UnJour;
    end
    else if DeltaAxe > UnJour then begin
      DeltaAxe := ceil(DeltaAxe / UnJour) * UnJour;
      FormatDuree := 'dd"j"';
      ArrondiAxe  := UnJour;
    end
    else if DeltaAxe > UneHeure then begin
      N := trunc(DeltaAxe / UneHeure);
      case N of
        1, 2, 3, 4: ;
        5: N := 6;
        6: ;
        7: N := 8;
        8: ;
        9, 10, 11: N := 12;
        12: ;
        13, 14, 15, 16, 17: N := 12;
        18, 19, 20, 21, 22, 23, 24: N := 24;
      end;
      DeltaAxe := N * UneHeure;
      FormatDuree := 'dd"j "hh';
      ArrondiAxe  := UneHeure;
    end
    else begin
      if DeltaAxe > QuartdHeure
         then DeltaAxe := ceil(DeltaAxe / QuartdHeure) * QuartdHeure
         else DeltaAxe := ceil(DeltaAxe / UneMinute) * UneMinute;
      FormatDuree := 'hh:mm';
      ArrondiAxe := UneMinute;
    end;
    PointDebut := round(Mini / DeltaAxe) * deltaAxe;
    FExposant := 1;
    NbreChiffres := length(FormatDuree);
  end; // setDeltaLongueDuree

  procedure setDeltaDateTime; // Windows compte en jour
  begin
    DeltaAxe := (Maxi - Mini);
    ArrondiAxe  := 1;
    if deltaAxe > 365 { 1 an } then begin
      FormatDuree := 'dd/mmm';
      deltaAxe := UnMoisWin*ceil(deltaAxe / 6 / UnMoisWin);
      if DeltaAxe>UnAnWin then deltaAxe := UnAnWin*round(deltaAxe/UnAnWin);
      ArrondiAxe := UnJourWin;
    end
    else if deltaAxe > 60 { 2 mois } then begin
      FormatDuree := 'dd/mmm';
      deltaAxe := ceil(deltaAxe / 6);
      if DeltaAxe>10 then deltaAxe := 10*round(deltaAxe/10);
      if DeltaAxe>UnMoisWin then deltaAxe := UnMoisWin*round(deltaAxe/UnMoisWin);
      ArrondiAxe := UnJourWin;
    end
    else if deltaAxe > 6 { 6 jours } then begin
      FormatDuree := 'dd"j" hh';
      deltaAxe := ceil(deltaAxe / 6);
      ArrondiAxe := UneHeureWin;
    end
    else if deltaAxe > 6 * UneHeureWin { 6 heures } then begin
      deltaAxe := UneHeureWin * ceil(deltaAxe / 6 / UneHeureWin);
      FormatDuree := 'hh:mm';
      ArrondiAxe := UneMinuteWin;
    end
    else if deltaAxe > UneHeureWin { 1 heure } then begin
      deltaAxe := QuartdHeureWin * ceil(deltaAxe / 6 / QuartdHeureWin);
      FormatDuree := 'hh:mm';
      ArrondiAxe := UneMinuteWin;
    end
    else begin
      deltaAxe := UneMinuteWin * ceil(deltaAxe / 6 / UneMinuteWin);
      FormatDuree := 'mm:ss';
      ArrondiAxe := UneSecondeWin;
    end;
    PointDebut := round(Mini / DeltaAxe) * deltaAxe;
    NbreChiffres := length(formatDuree);
    FExposant := 1;
  end; // setDeltaDateTime

  procedure setDeltaDegre;
  var
    largeur: double;
    coeff: integer;
  begin
    largeur := (maxi - mini) / 9; { 9 graduations }
    coeff := 15 * ceil(largeur / 15);
    if (coeff = 75) or (coeff = 105) then
      coeff := 90;
    NbreChiffres := 3;
    DeltaAxe := coeff;
    if orthonorme
       then PointDebut := ceil(miniOrtho / deltaAxe) * deltaAxe
       else PointDebut := ceil(mini / deltaAxe) * deltaAxe;
    FExposant := 1;
  end; // setDeltaDegre

  procedure setDeltaRadian;
  var
    largeur: double;
    coeff, reste: integer;
  begin
    largeur := (maxi - mini) / 9;
    coeff := ceil(largeur * 12 / pi);
    reste := coeff mod 12;
    if (reste = 5) or (reste = 7) then
      coeff := 6 * ceil(largeur * 2 / pi);
    { pi/2 plutôt que 5pi/12 ou 7pi/12 }
    if (reste = 10) or (reste = 11) then
      coeff := 12 * ceil(largeur / pi);
    { pi plutôt que 11pi/12 ou 5pi/6 }
    deltaAxe := pi / 12 * coeff;
    NbreChiffres := 5;
    if orthonorme then
      PointDebut := ceil(miniOrtho / deltaAxe) * deltaAxe
    else
      PointDebut := ceil(mini / deltaAxe) * deltaAxe;
    FExposant := 1;
    GraduationPiActive := True;
  end; // setDeltaRadian

const
  indexMax = 5;
  coeff: array[0..indexMax] of double = (0.1, 0.2, 0.5, 1, 2, 5);
var
  absMax, absMin, largeur, deltaGrandAxe : double;
  Expo, N, index, indexGrad: integer;
begin // setDelta
  graduationPiActive := False;
  NbreDecimal := 0;
  Expo := 0;
  FExposant := 1;
  if (axe=nil) or axe.UniteGrapheImposee then begin
     setDeltaImpose;
     exit;
  end;
  if Graduation = gInv then
    if maxi > 0
      then absMax := abs(1 / maxi)
      else absMax := abs(1 / mini)
  else begin
    if orthonorme then begin
      absMax := abs(maxiOrtho);
      absMin := abs(miniOrtho);
    end
    else begin
      absMax := abs(maxi);
      absMin := abs(mini);
    end;
    if absMax < AbsMin then
      absMax := absMin;
  end;
  // Nticks := 1;
  try
    if (axe.formatU = fLongueDuree) then begin
      Nticks := 1;
      setDeltaLongueDuree;
      exit;
    end;
    if (axe.formatU in [fDateTime, fDate, fTime]) then begin
      Nticks := 1;
      setDeltaDateTime;
      exit;
    end;
  except
  end;
  indexGrad := 0;
  AutoTick  := AutoTick or (graduation = gLog) or (graduation = gInv);
  if not (AutoTick) then begin
    deltaAxe := abs(deltaAxe);
    N := round((maxi - mini) / deltaAxe);
    AutoTick := (N > 64) or (N < 2);
    if AutoTick
    then afficheErreur(erNbreGradManuel, 0)
    else begin
      Expo := floor(Log10(deltaAxe));
//      index := 0;
      largeur := (maxi - mini) * dix(-expo);
      if largeur > NbreGradMaxMan * coeff[indexMax] then begin
//        largeur := largeur / 10;
        Inc(expo);
      end;
  (*
      while ((largeur / coeff[index]) >= NbreGradMaxMan) and
        (index < indexMax) do
        Inc(index);
   *)
      if NTicks<1 then NTicks := 1;
      if NTicks>5 then NTicks := 5;
     // NTicks := ceil(coeff[index] * dix(exponent) / DeltaAxe);
    end;
  end;
  if AutoTick then begin
    if GraduationPi and (axe <> nil) and
      (axe.nomUnite = 'rad') and
      not polaire and
      (absMax > 0.8) and (absMax < 100) then begin
      Nticks := 1;
      setDeltaRadian;
      exit;
    end;
    if GraduationPi and (axe <> nil) and
       (axe.nomUnite = '°') and
       not polaire and
       (absMax > 45) and (absMax < 720) then begin
      Nticks := 1;
      setDeltaDegre;
      exit;
    end;
    if Graduation = gInv then begin
      Expo := floor(Log10(absMax));
      largeur  := (1 / mini - 1 / maxi) * dix(-expo); // ??
    end
    else if orthonorme then begin
      Expo := floor(Log10(MaxiOrtho - MiniOrtho));
      largeur  := (maxiOrtho - miniOrtho) * dix(-expo);
    end
    else begin
      Expo := floor(Log10(Maxi - Mini));
      largeur  := (maxi - mini) * dix(-expo);
    end;
    index := 0;
    if grandAxe
       then while ((largeur / coeff[index]) >= NbreGradMax) and (index < indexMax) do
        Inc(index)
       else while ((largeur / coeff[index]) >= NbreGradMin) and (index < indexMax) do
        Inc(index);
    DeltaAxe  := coeff[index] * dix(expo);
    indexGrad := index mod 3;
  end;// autoTick
  NbreChiffres := ceil(Log10(AbsMax)) - floor(Log10(DeltaAxe));
  NbreDecimal := NbreChiffres-ceil(Log10(absMax));
  if NbreDecimal<0 then NbreDecimal := 0;
  if autoTick then begin
    case indexGrad of
      0: Nticks := 5; { 1 -> 0.2 }
      1: Nticks := 4; { 2 -> 0.5 }
      2: Nticks := 5; { 5 -> 1 }
      else Nticks := 1; // pour le compilateur
    end;
    deltaAxe  := deltaAxe / Nticks;
  end;
  if expo = -1 then expo := 0;
// nombre <~1 écrit sous forme 0.8 plutôt que 800.10-3
  Index := Expo div 3;
  if ((Expo mod 3) < 0) then Dec(index);
//la division euclidienne des informaticiens <> div des maths !
  FExposant := Dix(3 * Index);
  if Graduation = gLog then begin
     NbreChiffres := longNombreAxeLog;
     FExposant := 1;
  end
  else begin
    N := ceil(Log10(absMax / FExposant));
    if N > NbreChiffres then NbreChiffres := N;
    if NbreChiffres < 3 then NbreChiffres := 3;
    if NbreChiffres > longNombreAxe then
      NbreChiffres := longNombreAxe;
  end;
  if Polaire then begin
     PointDebut := deltaAxe;
     TickDebut  := 1;
  end
  else begin
    deltaGrandAxe := NTicks*deltaAxe;
    if Graduation = gInv then
      PointDebut := ceil(1 / deltaGrandAxe / maxi) * deltaGrandAxe
    else if Orthonorme
       then PointDebut := floor(miniOrtho / deltaAxe) * deltaAxe
       else PointDebut := floor(mini / deltaAxe) * deltaAxe;
    TickDebut := round(frac(PointDebut / deltaGrandAxe)*NTicks);
  end;
end; // setDelta

procedure Tmonde.SetDeltaImpose;
// FExposant=puissance de 10 multiple de 3 de manière à avoir entre
// NbreGradMax (10) et N/2.5 (4) graduations sur l'axes.
// ou NbreGradMin (5) et N/2.5 (2) graduations sur l'axes.
// Delta est l'intervalle entre les graduations qui commencent à PremiereGraduation
const
  indexMax = 5;
  coeff: array[0..indexMax] of double = (0.1, 0.2, 0.5, 1, 2, 5);
var
  absMax, largeur, deltaGrandAxe : double;
  Expo, N, index, indexGrad: integer;
  uniteLoc : TUnite;
begin
  if axe=nil
  then Fexposant := 1
  else begin
     uniteLoc := Tunite.Create;
     uniteLoc.NomUnite := axe.uniteGraphe;
     if uniteLoc.UniteEgale(axe)
        then FExposant := uniteLoc.coeffSI/axe.coeffSI
        else FExposant := 1;
     uniteLoc.Free;
  end;
  absMax := abs(maxi);
  Expo := floor(Log10(Maxi - Mini));
  largeur  := (maxi - mini) * dix(-expo);
  index := 0;
  while ((largeur / coeff[index]) >= NbreGradMax) and (index < indexMax) do
        Inc(index);
  DeltaAxe  := coeff[index] * dix(expo);
  indexGrad := index mod 3;
  NbreChiffres := ceil(Log10(AbsMax)) - floor(Log10(DeltaAxe));
  NbreDecimal := NbreChiffres-ceil(Log10(absMax));
  if NbreDecimal<0 then NbreDecimal := 0;
  case indexGrad of
      0: Nticks := 5; { 1 -> 0.2 }
      1: Nticks := 4; { 2 -> 0.5 }
      2: Nticks := 5; { 5 -> 1 }
      else Nticks := 1; // pour le compilateur
  end;
  deltaAxe  := deltaAxe / Nticks;
  N := ceil(Log10(absMax / FExposant));
  if N > NbreChiffres then NbreChiffres := N;
  if NbreChiffres < 3 then NbreChiffres := 3;
  if NbreChiffres > longNombreAxe then
      NbreChiffres := longNombreAxe;
  deltaGrandAxe := NTicks*deltaAxe;
  PointDebut := floor(mini / deltaAxe) * deltaAxe;
  TickDebut := round(frac(PointDebut / deltaGrandAxe)*NTicks);
end; // setDeltaImpose

function Tmonde.FormatMonde(x: double): string;

  function FormatAxeLog: string;
  var
    unite: TcoefUnite;
  begin
    x := abs(x);
    unite := nulle;
    while (x >= 1000) and (unite < infini) do begin
      x := x / 1000;
      Inc(unite);
    end; // x<1000 ou infini
    while (x < 1) and (unite > zero) do begin
      x := x * 1000;
      Dec(unite);
    end; // x>=1 ou zero
    case unite of
       infini, zero: Result := '';
       nulle : Result := IntToStr(round(x));
       milli : Result := FloatToStrF(x/1000,ffGeneral,3,3);
       else Result := IntToStr(round(x)) + pointMedian+'10'+powerToStr(puissanceUnite[unite])
    end;
  end;

  function FormatAxeLogNew: string;
  var
    Lexposant,mantisse : integer;
  begin
    x := abs(x);
    Lexposant := floor(log10(x));
    mantisse := round(x/power(10,Lexposant));
    Result := IntToStr(mantisse);
    if Lexposant=0
       then
       else if Lexposant=-1 then Result := '0,'+Result
       else if Lexposant=1 then Result := Result+'0'
       else if Lexposant=-2 then Result := '0,0'+Result
       else if Lexposant=2 then Result := Result+'00'
       else Result := Result + pointMedian +'10'+powerToStr(Lexposant)
  end;

begin
  if (graduation = gLog)
    then Result := FormatAxeLogNew
    else if axe = nil
       then Result := FloatToStrF(x / Fexposant, ffGeneral, NbreChiffres, 0)
       else case axe.FormatU of
          fLongueDuree: Result := FormatLongueDureeAxe(x);
          fDateTime, fDate, fTime: Result :=
              FormatDateTime(FormatDuree, ArrondiAxe * round(x / ArrondiAxe));
          else if abs(x / deltaAxe) < 1e-5
             then Result := '0'
             else Result := FloatToStrF(x / Fexposant, ffGeneral, NbreChiffres, NbreDecimal)
       end; // case
end; // FormatMonde

procedure TtransfertGraphe.AssignEntree(const Agraphe: TgrapheReg);
var
  i: TindiceOrdonnee;
  m: TindiceMonde;
begin
  for i := 1 to MaxOrdonnee do begin
    nomY[i]  := Agraphe.Coordonnee[i].nomY;
    nomX[i]  := Agraphe.Coordonnee[i].nomX;
    iMonde[i] := Agraphe.Coordonnee[i].iMondeC;
    Trace[i] := Agraphe.Coordonnee[i].Trace;
    Ligne[i] := Agraphe.Coordonnee[i].Ligne;
    Couleur[i] := Agraphe.Coordonnee[i].couleur;
    Style[i] := Agraphe.Coordonnee[i].styleT;
    Motif[i] := Agraphe.Coordonnee[i].Motif;
    couleurPoint[i] := Agraphe.Coordonnee[i].couleurPoint;
    codeCouleur[i] := Agraphe.Coordonnee[i].codeCouleur;
  end;
  for m := low(TIndiceMonde) to high(TIndiceMonde) do begin
    Grad[m] := Agraphe.monde[m].Graduation;
    Zero[m] := Agraphe.monde[m].ZeroInclus;
    minidB[m] := Agraphe.monde[m].minidB;
    axeInverse[m] := Agraphe.monde[m].axeInverse;
  end;
  zeroPolaire := Agraphe.zeroPolaire;
  OptionGr  := Agraphe.OptionGraphe;
  OptionModele := Agraphe.OptionModele;
  SuperposePage := Agraphe.superposePage;
  FilDeFer  := Agraphe.filDeFer;
  UseDefaut := Agraphe.UseDefaut;
  UseDefautX := Agraphe.UseDefautX;
  UseZoom := Agraphe.UseZoom;
  AutoTick  := Agraphe.AutoTick;
  PasPoint  := Agraphe.PasPoint;
  Indicateur := Agraphe.Indicateur;
end;

constructor TtransfertGraphe.Create;
var
  i: TindiceOrdonnee;
  m: TindiceMonde;
begin
  for i := 1 to MaxOrdonnee do begin
    nomY[i]  := 'Y';
    nomX[i]  := 'X';
    iMonde[i] := mondeY;
    Trace[i] := [trLigne];
    Ligne[i] := liDroite;
    Couleur[i] := couleurInit[i];
    Style[i] := psSolid;
    Motif[i] := motifInit[i];
    couleurPoint[i] := '';
    codeCouleur[i] := tSigne;
  end;
  for m := low(TIndiceMonde) to high(TIndiceMonde) do begin
    Grad[m] := gLin;
    Zero[m] := True;
    minidB[m] := 0;
    axeInverse[m] := false;
  end;
  zeroPolaire := 0;
  OptionGr  := [];
  OptionModele := [];
  SuperposePage := False;
  FilDeFer  := False;
  UseDefaut := False;
  UseDefautX := False;
  UseZoom := false;
  AutoTick  := True;
  PasPoint  := 1;
  Indicateur := nil;
end;

procedure TtransfertGraphe.AssignSortie(var Agraphe: TgrapheReg);
var
  i: TindiceOrdonnee;
  m: TindiceMonde;
begin
  for i := 1 to MaxOrdonnee do begin
    Agraphe.Coordonnee[i].nomY  := nomY[i];
    Agraphe.Coordonnee[i].nomX  := nomX[i];
    Agraphe.Coordonnee[i].iMondeC := iMonde[i];
    Agraphe.Coordonnee[i].Trace := Trace[i];
    Agraphe.Coordonnee[i].Ligne := Ligne[i];
    Agraphe.Coordonnee[i].Motif := Motif[i];
    Agraphe.Coordonnee[i].couleur := couleur[i];
    Agraphe.Coordonnee[i].styleT := Style[i];
    Agraphe.Coordonnee[i].couleurPoint := couleurPoint[i];
    Agraphe.Coordonnee[i].codeCouleur := codeCouleur[i];
  end;
  for m := low(TindiceMonde) to high(TindiceMonde) do begin
    Agraphe.monde[m].Graduation := Grad[m];
    zero[m] := zero[m] and (Grad[m] = gLin);
    Agraphe.monde[m].ZeroInclus := zero[m];
    Agraphe.monde[m].minidB := minidB[m];
    if (ogOrthonorme in optionGr) or (ogMemeZero in optionGr)
       then Agraphe.monde[m].axeInverse := false
       else Agraphe.monde[m].axeInverse := axeInverse[m];
  end;
  Agraphe.zeroPolaire := zeroPolaire;
  Agraphe.OptionGraphe := OptionGr;
  Agraphe.OptionModele := OptionModele;
  Agraphe.SuperposePage := SuperposePage;
  Agraphe.UseDefaut := UseDefaut;
  Agraphe.UseDefautX := UseDefautX;
  Agraphe.UseZoom := UseZoom;
  Agraphe.AutoTick := AutoTick;
  Agraphe.FilDeFer := FilDeFer;
  Agraphe.PasPoint := PasPoint;
  Agraphe.Indicateur := Indicateur;
  Pages[pageCourante].IndicateurP := Indicateur;
end;

function TgrapheReg.AjouteCourbe(AX, AY: Tvecteur; Am: TindiceMonde;
  Nbre: integer; grandeurX, grandeurY: Tgrandeur; Apage: integer): Tcourbe;
var
  Acourbe: Tcourbe;
begin
  Acourbe := Tcourbe.Create(AX, AY, 0, pred(Nbre), grandeurX, grandeurY);
  Acourbe.page := Apage;
  Acourbe.couleur := GetCouleurPages(Apage);
  Acourbe.styleT := stylePages[Apage mod MaxPagesGr];
  Acourbe.Motif := MotifPages[Apage mod MaxPagesGr];
  if Am <= maxMonde then
    Acourbe.iMondeC := Am;
  courbes.Add(Acourbe);
  monde[Am].defini := False;
  monde[mondeX].defini := False;
  monde[Am].axe := grandeurY;
  monde[mondeX].axe := grandeurX;
  Result := Acourbe;
end;

procedure TgrapheReg.TraceCurseur(i: TindexCurseur);
var
  x0,y0,rayon : integer;
begin with CurseurOsc[i] do begin
    if mondeC = mondeX then exit;
    createPen(PstyleReticule, 1, PColorReticule);
    if (i>3) and (Ic>0) then begin
       Yr := courbes[indexCourbe].valY[Ic];
       Xr := courbes[indexCourbe].valX[Ic];
       WindowRT(Xr, Yr, mondeC, xC, yC);
    end;
    if ReticuleComplet or (i<4) then begin
      canvas.pen.mode := pmNOTXOR;
      if (OgPolaire in OptionGraphe) then
         begin
            windowRT(0,0,mondeC,x0,y0);
            rayon := round(sqrt(sqr(xC-x0)+sqr(yc-y0)));
         //   if ReticuleComplet then
               canvas.ellipse(x0 - rayon, y0 - rayon, x0 + rayon, y0 + rayon);
            segment(x0, y0, xC, yC);
            rayon := rayonArcAngle - 10;
            if yC<y0
              then canvas.arc(x0-rayon, y0-rayon, x0+rayon, y0+rayon, x0+rayon, y0, xC, yC)
              else canvas.arc(x0-rayon, y0-rayon, x0+rayon, y0+rayon, xC, yC, x0+rayon, y0);
         end
         else begin
          segment(limiteCourbe.left + labelYcurseur.Width, Yc, LimiteFenetre.right, Yc);
          if Xc > labelYcurseur.Width
              then segment(Xc, 0, Xc, limiteCourbe.bottom)
              else begin
                segment(Xc, 0, Xc, labelYcurseur.Top - PaintBox.top - 2);
                segment(Xc, labelYcurseur.top - PaintBox.top + labelYcurseur.Height +
                      2, Xc, limiteCourbe.bottom);
              end;
         end;
      canvas.pen.mode := pmCOPY;
    end;
    if (i>3) and not ReticuleComplet then begin
      CreateSolidBrush(PColorReticule);
      canvas.Rectangle(Xc - dimBorne, Yc - dimBorne, Xc + dimBorne, Yc + dimBorne);
      canvas.brush.style := bsClear;
    end;
end end; // TraceCurseur

procedure TgrapheReg.TracePente;
var xi, yi: integer;
begin
    if (CurseurOsc[curseurData2].indexCourbe <> curseurOsc[curseurData1].indexCourbe) or
       (CurseurOsc[curseurData1].mondeC = mondeX) or
       (CurseurOsc[curseurData2].mondeC = mondeX)
          then exit;
    if (OgPolaire in OptionGraphe)
        then begin if not(coDeltaY in optionCurseur) then exit end
        else begin if not(coPente in optionCurseur) then exit end;
    createPen(PstyleTangente, 1, PColorTangente);
    with CurseurOsc[curseurData1] do windowRT(xr, yr, mondeC, xi, yi);
    if (xi<0) or (yi<0) then exit;
    canvas.MoveTo(Xi, Yi);
    with CurseurOsc[curseurData2] do windowRT(xr, yr, mondeC, xi, yi);
    if (xi<0) or (yi<0) then exit;
    canvas.LineTo(Xi, Yi);
end;

procedure TgrapheReg.InitReticule(x, y: integer);
var mondeLoc : TindiceMonde;
    i : integer;
begin
  with canvas do begin
    if not (monde[mondeX].defini) then exit;
    if monde[mondeY].defini
       then mondeLoc := mondeY
       else if monde[mondeDroit].defini
          then mondeLoc := mondeDroit
          else exit;
    for i := 1 to 3 do with curseurOsc[i] do begin
       xc := x;
       yc := y;
       mondeC := mondeLoc;
       grandeurCurseur := monde[mondeLoc].axe;
    end;
    cCourant := 1;
    traceReticule(1);
  end;
end;

function TgrapheReg.MondeProche(x, y: integer): TindiceMonde;
var
  m: TindiceMonde;
begin
  Result := mondeY;
  for m := mondeY to high(TindiceMonde) do
    with monde[m] do
      if defini and (y > courbeTop) and (y < courbeBottom) then
        Result := m;
end;

function TgrapheReg.PointProche(var x, y: integer; indexCourbe: integer;
  limite, Xseul: boolean): integer;
var
  i, idebut, ifin: integer;
  Xi, Yi, newX, newY: integer;
  distance, distanceMin: integer;
begin
  Result := -1;
  if indexCourbe < 0 then exit;
  newX := x;
  newY := y;
  with courbes[indexCourbe] do begin
    if Limite then begin
      iDebut := DebutC;
      iFin := FinC;
    end
    else begin
      iDebut := 0;
      iFin := pred(pages[pageCourante].nmes);
    end;
    distanceMin := 64;
    for i := idebut to ifin do begin
      windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
      if Xseul then
        distance := abs(X - Xi)
      else
        distance := abs(X - Xi) + abs(Y - Yi);
      if distance < distanceMin then begin
        distanceMin := distance;
        Result := i;
        newX := Xi;
        newY := Yi;
      end;
    end;
    if Result >= 0 then begin
      x := newX;
      y := newY;
    end;
  end;
end;

procedure TgrapheReg.PointProcheNew(ax, ay: integer);
var
  LindexCourbe : integer;

Function Trouve(aIndexCourbe : integer) : boolean;
var distanceMin : integer;
    i,iMin : integer;
    distance : integer;
begin with courbes[aIndexCourbe] do begin
    distanceMin := limiteCourbe.width div 4;
    iMin := finE div 2;
    for i := 0 to finE-1 do begin
        distance := abs(aX - valXe[i]) + abs(aY - valYe[i]);
        if distance < distanceMin then begin
           distanceMin := distance;
           iMin := i;
        end;
    end;
    result := distanceMin<(limiteCourbe.width div 8);
    if result then with curseurOsc[curseurData1] do begin
       xC := valXe[iMin];
       yC := valYe[iMin];
       MondeRT(xc, yc, mondeC, xr, yr);
    end;
end end;

begin
  traceReticule(curseurData1); // efface
  if not Trouve(curseurOsc[curseurData1].indexCourbe) then begin
     for LindexCourbe := 0 to pred(courbes.Count) do
     with courbes[LindexCourbe] do
          if (page = pageCourante) and
             (trLigne in trace) and
             (finE>0) and
             (LindexCourbe<>curseurOsc[curseurData1].indexCourbe) and
             trouve(LindexCourbe) then begin
                curseurOsc[curseurData1].indexCourbe := LindexCourbe;
                curseurOsc[curseurData1].mondeC := iMondeC;
                break;
             end;
  end;
  traceReticule(curseurData1); // retrace
end; // PointProcheNew

(*
function TgrapheReg.PointProcheModele(var x, y: integer): integer;
var
  i: integer;
  Xi, Yi, newX, newY: integer;
  distance, distanceMin: integer;
begin
  Result := -1;
  newX := x;
  newY := y;
  with courbes[indexReticuleModele] do begin
    distanceMin := 64;
    for i := debutC to finC do begin
      windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
      distance := abs(X - Xi) + abs(Y - Yi);
      if distance < distanceMin then begin
         distanceMin := distance;
         Result := i;
         newX := Xi;
         newY := Yi;
      end; // distance
    end; // for i
  if Result >= 0 then begin
      x := newX;
      y := newY;
  end
  else begin // X seul
      for i := debutC to finC do begin
      windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
      distance := abs(X - Xi);
      if distance < distanceMin then begin
        distanceMin := distance;
        Result := i;
        newX := Xi;
        newY := Yi;
      end;
    end;
    if Result >= 0 then begin
      x := newX;
      y := newY;
     end;
  end; // for i
  end; // with
end;

function TgrapheReg.PointProcheModeleX(var x, y: integer): integer;
var
  i: integer;
  Xi, Yi, newX, newY: integer;
  distance, distanceMin: integer;
begin
  Result := -1;
  newX := x;
  newY := y;
  with courbes[indexReticuleModele] do begin
    distanceMin := abs(X-curseurOsc[1].Xc);
    for i := debutC to finC do begin
      windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
      distance := abs(X - Xi);
      if distance < distanceMin then begin
         distanceMin := distance;
         Result := i;
         newX := Xi;
         newY := Yi;
      end; // distance
    end; // for i
  if Result >= 0 then begin
      x := newX;
      y := newY;
  end
  end; // with
end;

function TgrapheReg.PointProcheModeleY(var x,y: integer): integer;
var
  i: integer;
  Xi, Yi, newX, newY: integer;
  distance, distanceMin: integer;
begin
  Result := -1;
  newX := x;
  newY := y;
  with courbes[indexReticuleModele] do begin
    distanceMin := abs(Y - curseurOsc[1].Yc);
    for i := debutC to finC do begin
      windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
      distance := abs(Y - Yi);
      if distance < distanceMin then begin
         distanceMin := distance;
         Result := i;
         newX := Xi;
         newY := Yi;
      end; // distance
    end; // for i
  if Result >= 0 then begin
      x := newX;
      y := newY;
  end
  end; // with
end; // PointProcheModeleY
*)

function TgrapheReg.CourbeProche(var x, y: integer): integer;
var
  i: integer;
  Xi, Yi: integer;
  distance, distanceMin: integer;
  indexCourbe: integer;
begin
  Result := -1;
  distanceMin := limiteCourbe.height div 6;
  for indexCourbe := 0 to pred(courbes.Count) do
    with courbes[indexCourbe] do
      if page = pageCourante then begin
        for i := debutC to finC do begin
          windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
          distance := abs(X - Xi) + abs(Y - Yi);
          if distance < distanceMin then begin
            distanceMin := distance;
            Result := indexCourbe;
          end;
        end;
      end;
end;

function TgrapheReg.CourbeProcheLisse(var x, y: integer): integer;
var
  i: integer;
  Xi, Yi: integer;
  distance, distanceMin: integer;
  indexCourbe: integer;
begin
  Result := -1;
  distanceMin := limiteCourbe.height div 6;
  for indexCourbe := 0 to pred(courbes.Count) do
    with courbes[indexCourbe] do
      if page = pageCourante then begin
        for i := debutC to finC do begin
          windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
          distance := abs(X - Xi) + abs(Y - Yi);
          if distance < distanceMin then begin
            distanceMin := distance;
            Result := indexCourbe;
          end;
        end;
      end;
end;

function TgrapheReg.CoordProche(var x, y: integer): integer;
var i,iCourbe : integer;
begin
    result := 1;
    iCourbe := CourbeProche(x,y);
    if iCourbe<0 then exit;
    for I := 1 to NbreOrdonnee do
        if (courbes[iCourbe].varX=grandeurs[coordonnee[i].codeX]) and
           (courbes[iCourbe].varY=grandeurs[coordonnee[i].codeY])
        then begin
        result := i;break
        end;
end;

function TgrapheReg.CourbeModeleProche(var x, y: integer): integer;
var
  i: integer;
  Xi, Yi: integer;
  distance, distanceMin: integer;
  indexCourbe: integer;
begin
  Result := -1;
  distanceMin := 64;
  for indexCourbe := 0 to pred(courbes.Count) do
    with courbes[indexCourbe] do
      if (indexModele=1) and (page = pageCourante) and not courbeExp then begin
        for i := debutC to finC do begin
          windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
          distance := abs(X - Xi) + abs(Y - Yi);
          if distance < distanceMin then begin
            distanceMin := distance;
            Result := indexCourbe;
          end;
        end;
      end;
end;

function TgrapheReg.SupprReticule(x, y: integer): boolean;
var
  i, ii:  integer;
  Xi, Yi: integer;
  distance, distanceMin: integer;
begin with equivalences[pageCourante] do begin
    Result := True;
    ii := -1;
    distanceMin := 16;
    for i := 0 to pred(Count) do begin
      with items[i] do
        windowRT(Ve, pHe, MondeY, Xi, Yi);
      distance := abs(X - Xi) + abs(Y - Yi);
      if distance < distanceMin then begin
        distanceMin := distance;
        ii := i;
      end;
    end;
    if ii >= 0 then
      remove(items[ii]);
end; end;

procedure TgrapheReg.SetSegmentInt(x, y: integer);
var
  zz, newCourbe: integer;
begin
    if cCourant=0 then exit;
    if not(monde[mondeX].defini) then exit;
    if not(monde[mondeY].defini) and
       not(monde[mondeDroit].defini)
           then exit;
    with CurseurOsc[cCourant] do begin
      TraceCurseur(cCourant); TracePente; // efface
      zz := PointProche(x, y, indexCourbe, True, False);
      if zz < 0 then begin
        newCourbe := courbeProche(x, y);
        if newCourbe >= 0 then begin
          zz := PointProche(x, y, newCourbe, True, False);
          if zz >= 0 then begin
            indexCourbe := newCourbe;
            mondeC := courbes[newCourbe].iMondeC;
            grandeurCurseur := courbes[newCourbe].varY;
          end;
        end;
      end;
      if zz >= 0 then begin
        Ic := zz;
        Xc := x;
        Yc := y;
      end;
      TraceCurseur(cCourant); // retrace
      TracePente; // retrace
end end; // setSegmentInt

(*
procedure TgrapheReg.SetReticuleModele(x, y: integer;selonX,selonY : boolean);
var
  zz: integer;
begin with CurseurOsc[1] do
    if (monde[mondeX].defini) and
       (monde[mondeC].defini) then begin
      TraceCurseur(1); // efface
      if selonX
         then if selonY
            then zz := PointProcheModele(x, y)
            else zz := PointProcheModeleX(x, y)
         else zz := PointProcheModeleY(x, y);
      if zz >= 0 then begin
        Ic := zz;
        Xc := x;
        Yc := y;
      end;
      TraceCurseur(1); // retrace
    end;
end; // setReticuleModele
*)

procedure TgrapheReg.SetSegmentReal(i: integer);
begin
   if cCourant=0 then exit;
   if not(monde[mondeX].defini) then exit;
   if not(monde[mondeY].defini) and
      not(monde[mondeDroit].defini) then exit;
  with CurseurOsc[cCourant] do begin
      TraceCurseur(cCourant); TracePente; // efface
      Ic := i;
      with courbes[indexCourbe] do
        windowRT(valX[Ic], valY[Ic], iMondeC, Xc, Yc);
      TraceCurseur(cCourant); TracePente; // retrace
    end;
end; // setSegmentReal

procedure TgrapheReg.SetStatusReticuleData(var Agrid: TstringGrid);
var
  AutreCurseur: integer;

  procedure AffecteString(i: integer);
  var
    st: string;
  begin with curseurOsc[i] do begin
      if mondeC = mondeX then exit;
      statusSegment[0].Add('n°');
      statusSegment[1].Add(IntToStr(Ic));
      if coY in OptionCurseur then begin
        if monde[mondeC].graduation = gdB then
          st := formatGeneral(20 * log10(yr), precisionMin) + ' dB'
        else
          st := GrandeurCurseur.formatValeurEtUnite(Yr);
        statusSegment[0].Add(GrandeurCurseur.nom);
        statusSegment[1].Add(st);
      end;
      if coX in OptionCurseur then begin
        st := monde[mondeX].Axe.formatValeurEtUnite(Xr);
        statusSegment[0].Add(monde[mondeX].Axe.nom);
        statusSegment[1].Add(st);
      end;
  end; end; // AffecteString

  procedure SetVecteur(i: integer);
  var
    v, vx, vy: double;
  begin
    if curseurOsc[i].mondeC = mondeX then exit;
    with curseurOsc[i] do begin
      if trVitesse in courbes[indexCourbe].Trace then begin
        vx := courbes[indexCourbe].ValXder[ic];
        vy := courbes[indexCourbe].ValYder[ic];
        v  := sqrt(vx * vx + vy * vy);
        statusSegment[0].Add('v');
        statusSegment[1].Add(FormatReg(v));
      end;
      if trAcceleration in courbes[indexCourbe].Trace then begin
        vx := courbes[indexCourbe].ValXder2[ic];
        vy := courbes[indexCourbe].ValYder2[ic];
        v  := sqrt(vx * vx + vy * vy);
        statusSegment[0].Add('a');
        statusSegment[1].Add(FormatReg(v));
      end;
    end;
  end; // SetVecteur

  procedure AffectePente;
  var
    tit,st: string;
    dx, dy: double;
    dxNul: boolean;
  begin with curseurOsc[cCourant] do begin
      dxNul := curseurOsc[autreCurseur].xc = Xc;
      dX := 0;dY := 0;// pour le compilateur
      try
        with monde[CurseurOsc[curseurData1].mondeC] do begin
          tit := DeltaMaj + axe.nom;
          st := '';
          case Graduation of
            gLog: begin
              dY := curseurOsc[autreCurseur].yr / Yr;
              tit := axe.nom + '*';
              st :=  formatReg(dY);
              dY := log10(dY);
            end;
            gInv: begin
              dY := 1 / curseurOsc[autreCurseur].yr - 1 / Yr;
              st := formatReg(dY);
            end;
            gLin: begin
              dY := Yr - curseurOsc[autreCurseur].yr;
              st := axe.FormatValeurEtUnite(dY);
            end;
            gdB: begin
              dY := 20 * log10(Yr/curseurOsc[autreCurseur].yr);
              st := formatGeneral(dY, precisionMin) + ' dB';
            end;
            gBits: begin
              dY := 1;
              tit := axe.nom
            end;
            else dxNul := true;
          end;
        end;
        if (coDeltaY in optionCurseur) and
           (CurseurOsc[curseurData1].mondeC = CurseurOsc[curseurData2].mondeC) then begin
          statusSegment[1].Add(st);
          statusSegment[0].Add(tit);
        end;
        with monde[mondeX] do begin
          tit := DeltaMaj + axe.nom;
          st := '';
          case Graduation of
            gLog: begin
              dX := Xr / curseurOsc[autreCurseur].xr;
              tit := axe.nom + '*';
              st := formatReg(dX);
              dX := log10(dX);// décade
            end;
            gInv: begin
              dX := 1 / curseurOsc[autreCurseur].xr - 1 / Xr;
              st := formatReg(dX);
            end;
            gLin: begin
              dX := Xr - curseurOsc[autreCurseur].xr;
              st := Axe.FormatValeurEtUnite(dX);
            end;
            else dxNul := true;
          end;
        end;
        if (coDeltaX in optionCurseur) then begin
          statusSegment[1].Add(st);
          statusSegment[0].Add(tit);
        end;
        if not dxNul and (coPente in OptionCurseur) then begin
          st := unitePente.formatNomPente(dY / dX);
          statusSegment[1].Add(st);
          statusSegment[0].Add('');
        end;
      except
      end;
    end;
  end; // affectePente

var
  i,j: integer;
begin
    if cCourant=4 then AutreCurseur := 3 else autreCurseur := 4;
    StatusSegment[0].Clear;
    StatusSegment[1].Clear;
    if not (monde[mondeX].defini) or
       not (monde[curseurOsc[cCourant].mondeC].defini) then
      exit;
    affecteString(curseurData1);
    affecteString(curseurData2);
    if (cCourant = 0) then exit;
    if (([coPente, coDeltaX, coDeltaY] * optionCurseur) <> []) or
      (curseurOsc[autreCurseur].mondeC <> mondeX) then
      affectePente;
    setVecteur(curseurData1);
    setVecteur(curseurData2);
    if StatusSegment[0].Count > Agrid.RowCount then begin
        Agrid.rowCount := StatusSegment[0].Count;
        Agrid.Height := Agrid.rowCount*Agrid.DefaultRowHeight+4;
    end;
    for i := 0 to pred(StatusSegment[1].Count) do
        Agrid.Cells[1,i] := StatusSegment[1].strings[i];
    for i := 0 to pred(StatusSegment[0].Count) do
        Agrid.Cells[0,i] := StatusSegment[0].strings[i];
    for i := StatusSegment[0].Count to pred(Agrid.RowCount) do
        for j := 0 to Agrid.ColCount - 1 do
            Agrid.Cells[i,j] := '';
    for i := StatusSegment[1].Count to pred(Agrid.RowCount) do
        for j := 0 to Agrid.ColCount - 1 do
            Agrid.Cells[i,j] := '';
end; // SetStatusReticuleData

function TlisteDessin.Add(Item: Tdessin): integer;
begin
  Result := inherited Add(Item);
end;

function TlisteDessin.Get(Index: integer): Tdessin;
begin
  Result := Tdessin(inherited Get(Index));
end;

procedure TlisteDessin.Put(Index: integer; Item: Tdessin);
begin
  inherited Put(Index, Item);
end;

function TlisteDessin.Remove(Item: Tdessin): integer;
begin
  Result := inherited Remove(Item);
  Item.Free;
end;

procedure TlisteDessin.Clear;
var
  i: integer;
begin
  for i := 0 to pred(Count) do
    items[i].Free;
  inherited Clear;
end;

procedure TlisteCourbe.Clear;
var
  i: integer;
begin
  for i := 0 to pred(Count) do
    items[i].Free;
  inherited Clear;
end;

procedure TlisteEquivalence.Clear;
var
  i: integer;
begin
  for i := 0 to pred(Count) do
    items[i].Free;
  inherited Clear;
end;

function TlisteEquivalence.Remove(Item: Tequivalence): integer;
begin
  Result := inherited Remove(Item);
  Item.Free;
end;

function TlisteCourbe.Add(Item: Tcourbe): integer;
begin
  Result := inherited Add(Item);
end;

function TlisteCourbe.Get(Index: integer): Tcourbe;
begin
  Result := Tcourbe(inherited Get(Index));
end;

procedure TlisteCourbe.Put(Index: integer; Item: Tcourbe);
begin
  inherited Put(Index, Item);
end;

function TlisteCourbe.Remove(Item: Tcourbe): integer;
begin
  Result := inherited Remove(Item);
  Item.Free;
end;

function TlisteEquivalence.Add(Item: Tequivalence): integer;
begin
  Result := inherited Add(Item);
end;

function TlisteEquivalence.Get(Index: integer): Tequivalence;
begin
  Result := Tequivalence(inherited Get(Index));
end;

procedure TlisteEquivalence.Put(Index: integer; Item: Tequivalence);
begin
  inherited Put(Index, Item);
end;

function TgrapheReg.GetBorne(x, y: integer; var Borne: Tborne): boolean;
var
  xi, yi: integer;
  i: integer;

  procedure Affecte(st: TstyleBorne; indexM: TcodeIntervalle);
  begin
    GetBorne := True;
    with Borne do begin
      indexCourbe := i;
      xb := xi;
      yb := yi;
      IndexModele := indexM;
      Style := st;
    end;
  end;

begin // GetBorne
  Borne.style := bsAucune;
  Result := False;
  if (NbreModele = 0) or
     not (imBornes in menuPermis) or
     not BorneVisible then exit;
  for i := 0 to pred(courbes.Count) do
    with courbes[i] do
      if courbeExp and
         (page = pageCourante) and
         (FinC > DebutC) then begin
        windowRT(valX[debutC], valY[debutC], iMondeC, xi, yi);
        if (abs(xi - x) + abs(yi - y)) < 2*margeBorne then begin
          Affecte(bsDebut, indexModele);
          break;
        end;
        if abs(xi - x) < margeBorne then begin
          Affecte(bsDebutVert, indexModele);
          break;
        end;
        windowRT(valX[finC], valY[finC], iMondeC, xi, yi);
        if (abs(xi - x) + abs(yi - y)) < 2*margeBorne then begin
          Affecte(bsFin, indexModele);
          break;
        end;
        if abs(xi - x) < margeBorne then begin
          Affecte(bsFinVert, indexModele);
          break;
        end;
      end;
end; // GetBorne

function TgrapheReg.isAxe(x, y: integer): integer;
var
  c: integer;
begin
  Result := -1;
  for c := 1 to NbreOrdonnee do
    if PtInRegion(coordonnee[c].RegionTitre, x, y) then begin
      Result := c;
      break;
    end;
end; // isAxe

procedure TgrapheReg.setBorne(x, y: integer; var borne: Tborne);

  function LigneProche: integer;
  var
    i: integer;
    Xi, Yi, newX, newY: integer;
    distance, distanceMin: integer;
  begin
    Result := -1;
    newX := x;
    newY := y;
    with courbes[borne.indexCourbe] do begin
      distanceMin := 32;
      for i := 0 to pred(pages[pageCourante].nmes) do begin
        windowRT(valX[i], valY[i], iMondeC, Xi, Yi);
        distance := abs(X - Xi);
        if distance < distanceMin then begin
          distanceMin := distance;
          Result := i;
          newX := Xi;
          newY := Yi;
        end;
      end;
      if Result > 0 then begin
        X := newX;
        Y := newY;
      end;
    end;
  end;

var
  i: integer;
begin with borne do begin
    TraceBorne(xb, yb, style, courbes[indexCourbe].couleur, indexModele);
    // efface
    if style in [bsDebutVert, bsFinVert]
       then i := LigneProche
       else i := PointProche(x, y, indexCourbe, False, False);
    if i >= 0 then begin
      case style of
        bsDebut, bsDebutVert: courbes[indexCourbe].debutC := i;
        bsFin, bsFinVert: courbes[indexCourbe].finC := i;
      end;
      xb := x;
      yb := y;
      for i := courbes[indexCourbe].debutC to courbes[indexCourbe].finC do
          pages[courbes[indexCourbe].page].PointActif[i] := true;
    end;
    TraceBorne(xb, yb, style, courbes[indexCourbe].couleur, indexModele);
    // retrace
end end; // setBorne

procedure TgrapheReg.EncadreTitre(Active: boolean);
begin
  if canvas = nil then exit; { ??? }
  with canvas do begin
    if active
       then pen.color := clActiveCaption
       else pen.color := clWindow;
    pen.mode := pmCopy;
    pen.Width := 3;
    with limiteFenetre do begin
      moveTo(left, top);
      lineTo(right, top);
    end;
    pen.Width := 1;
  end;
end;

function TgrapheReg.PointProcheReal(x, y: double; Acourbe: Tcourbe;m: TindiceMonde): integer;
var
  distanceMin, delta: double;

  function PointProcheX: integer;
  var
    i: integer;
  begin with Acourbe, monde[mondeX] do begin
      Result := -1;
      case Graduation of
        gLog: distanceMin := power(10,maxi - 0.5);
        gInv: distanceMin := (1 / mini - 1 / maxi) / 4;
        gLin: distanceMin := (maxi - mini) / 4;
      end;
      for i := DebutC to FinC do begin
        delta := abs(valX[i] - x);
        if delta < distanceMin then begin
          distanceMin := delta;
          Result := i;
        end;
      end;
    end;
  end;

  function PointProcheY(m : TindiceMonde): integer;
  var
    i: integer;
  begin with Acourbe, monde[m] do begin
      Result := -1;
      case Graduation of
        gLog: distanceMin := power(10,maxi - 0.5);
        gdB: distanceMin  := power(10,maxi / 20 - 0.5) - power(10,mini / 20 - 0.5);
        gInv: distanceMin := (1 / mini - 1 / maxi) / 4;
        gLin: distanceMin := (maxi - mini) / 4;
        gBits: exit;
      end;
      for i := DebutC to FinC do begin
        delta := abs(valY[i] - y);
        if delta < distanceMin then begin
          distanceMin := delta;
          Result := i;
        end;
      end;
    end;
  end;

begin
   if m=mondeX
      then Result := pointProcheX
      else Result := pointProcheY(m)
end;

procedure TgrapheReg.TraceMotif(xi, yi: integer; motif: Tmotif);
var
  PolyLigne: array[1..5] of Tpoint;
  sauveWidth : integer;
  sauveStyle : TpenStyle;
begin
  sauveWidth := canvas.pen.width div penwidth;
  sauveStyle := canvas.pen.style;
  CreatePen(psSolid, 1, canvas.pen.color);
  case Motif of
    mCroix: begin
      segment(xi - dimPoint, yi, xi + dimPoint, yi);
      segment(xi, yi - dimPoint, xi, yi + dimPoint);
    end;
    mCroixDiag: begin
      segment(xi - dimPoint, yi - dimPoint, xi + dimPoint, yi + dimPoint);
      segment(xi + dimPoint, yi - dimPoint, xi - dimPoint, yi + dimPoint);
    end;
    mCercle, mCerclePlein: canvas.ellipse(xi - dimPoint, yi - dimPoint,
        xi + dimPoint + 1, yi + dimPoint + 1);
    mCarre, mCarrePlein: canvas.rectangle(xi - dimPoint, yi - dimPoint,
        xi + dimPoint, yi + dimPoint);
    mLosange: begin
      PolyLigne[1] := Point(xi - dimPoint, yi);
      PolyLigne[2] := Point(xi, yi - dimPoint);
      PolyLigne[3] := Point(xi + dimPoint, yi);
      PolyLigne[4] := Point(xi, yi + dimPoint);
      PolyLigne[5] := Point(xi - dimPoint, yi);
      canvas.PolyLine(PolyLigne);
    end;
  end;
  createPen(sauveStyle, sauveWidth, canvas.pen.color);
end;

const
  NbreLigneDessin = 14;

function Tdessin.NbreData: integer;
begin
  NbreData := NbreLigneDessin + texte.Count;
end;

procedure Tdessin.Store;
var
  i: integer;
begin
  writeln(fichier,x1);
  writeln(fichier,y1);
  writeln(fichier,x2);
  writeln(fichier,y2);
  writeln(fichier, hauteur);{5}
  writeln(fichier, numPage, ' ', iMonde,
    ' ', Ord(identification),
    ' ', Ord(TexteLigne),
    ' ', numPoint,
    ' ', couleurFond,
    ' ', numCoord
    );{6}
  writeln(fichier, pen.color, ' ', Ord(pen.style), ' ', pen.Width,
    ' ', Ord(isTitre), ' ', Ord(isOpaque));{7}
  writeln(fichier, Ord(Souligne));{8}
  writeln(fichier, Ord(vertical));{9}
  writeln(fichier, Ord(avecCadre));{10}
  writeln(fichier, Ord(centre)); {11}
  writeln(fichier, Ord(isTexte));{12}
  writeln(fichier, Ord(avecLigneRappel));
  writeln(fichier, Ord(MotifTexte));{14}
  for i := 0 to pred(texte.Count) do
      ecritChaineRW3(Texte[i]);
end;

procedure Tdessin.StoreXML(ANode : IXMLNode);
begin
  writeFloatXML(ANode,'x1',x1);
  writeFloatXML(ANode,'y1',y1);
  writeFloatXML(ANode,'x2',x2);
  writeFloatXML(ANode,'y2',y2);
  writeIntegerXML(ANode,'H',hauteur);
  writeIntegerXML(ANode,stPage,numPage);
  writeIntegerXML(ANode,stMonde,iMonde);
  writeIntegerXML(ANode,'Ident',ord(identification));
  writeIntegerXML(ANode,'TexteLigne',ord(TexteLigne));
  writeColorXML(ANode,'CouleurFond',couleurFond);
  writeColorXML(ANode,stCouleur,pen.color);
  writeIntegerXML(ANode,stPenStyle,ord(pen.style));
  writeIntegerXML(ANode,'PenWidth',pen.Width);
  if identification=identCoord then begin
     writeIntegerXML(ANode,'NumCoord',NumCoord);
     writeIntegerXML(ANode,'NumPoint',NumPoint);
  end;
  writeBoolXML(ANode,'isTitre',isTitre);
  writeBoolXML(ANode,'isOpaque',isOpaque);
  writeBoolXML(ANode,'isSouligne',Souligne);
  writeBoolXML(ANode,'isVertical',vertical);
  writeBoolXML(ANode,'withCadre',avecCadre);
  writeBoolXML(ANode,'isCentre',centre);
  writeBoolXML(ANode,'isTexte',isTexte);
  writeBoolXML(ANode,'withRappel',avecLigneRappel);
  writeIntegerXML(ANode,'Motif',Ord(MotifTexte));
  Texte.Delimiter := crCR;
  writeStringXML(ANode,'Texte',Texte.delimitedText);
end; // dessin.storexml

procedure Tdessin.LoadXML(ANode : IXMLNode);

procedure LitEnfant(Anode : IXMLNode);
begin
   if ANode.NodeName='x1' then begin
      x1 := getFloatXML(ANode);
      exit;
   end;
   if ANode.NodeName='y1' then begin
      y1 := getFloatXML(ANode);
      exit;
   end;
   if ANode.NodeName='x2' then begin
       x2 := getFloatXML(ANode);
       exit;
   end;
   if ANode.NodeName='y2' then begin
      y2 := getFloatXML(ANode);
      exit;
   end;
   if ANode.NodeName='H' then begin
      hauteur := getIntegerXML(ANode);
      exit;
   end;
   if ANode.NodeName=stPage then begin
      numPage := getIntegerXML(ANode);
      exit;
   end;
   if ANode.NodeName=stMonde then begin
     iMonde := getIntegerXML(ANode);
     exit;
   end;
   if ANode.NodeName='NumCoord' then begin
     numCoord := getIntegerXML(ANode);
     exit;
   end;
   if ANode.NodeName='NumPoint' then begin
     numPoint := getIntegerXML(ANode);
     exit;
   end;
   if ANode.NodeName='Ident' then begin
       identification := Tidentification(getIntegerXML(ANode));
       exit;
   end;
   (*
   if ANode.NodeName='Ident' then begin
       TexteLigne := TtexteLigne(getIntegerXML(ANode));
       exit;
   end;
   *)
   if ANode.NodeName='CouleurFond' then begin
      couleurFond := getColorXML(ANode);
      exit;
   end;
   if ANode.NodeName=stCouleur then begin
     pen.color := getColorXML(ANode);
     exit;
   end;
   if ANode.NodeName=stPenStyle then begin
     pen.style := TpenStyle(getIntegerXML(ANode));
     exit;
   end;
   if ANode.NodeName='PenWidth' then begin
       pen.Width := getIntegerXML(ANode);
       exit;
   end;
   if ANode.NodeName='TexteLigne' then begin
       texteLigne := TTexteLigne(getIntegerXML(ANode));
       exit;
   end;
   if ANode.NodeName='isTitre' then begin
     isTitre := getBoolXML(ANode);
     exit;
   end;
   if ANode.NodeName='isOpaque' then begin
     isOpaque := getBoolXML(ANode);
     exit;
   end;
   if ANode.NodeName='isSouligne' then begin
      Souligne := getBoolXML(ANode);
      exit;
   end;
   if ANode.NodeName='isVertical' then begin
      vertical := getBoolXML(ANode);
      exit;
   end;
    if ANode.NodeName='isCadre' then begin
      avecCadre := getBoolXML(ANode);
      exit;
    end;
    if ANode.NodeName='isCentre' then begin
        centre  := getBoolXML(ANode);
        exit;
    end;
    if ANode.NodeName='isTexte' then begin
      isTexte := getBoolXML(ANode);
      exit;
    end;
    if ANode.NodeName='withRappel' then begin
        avecLigneRappel := getBoolXML(ANode);
        exit;
    end;
    if ANode.NodeName='Motif' then begin
        MotifTexte := TmotifTexte(getIntegerXML(ANode));
        exit;
    end;
    if ANode.NodeName='Texte' then begin
       Texte.Delimiter := crCR;
       Texte.DelimitedText := ANode.text;
       exit;
    end;
end;

var i : integer;
begin
   if ANode.HasChildNodes then
      for I := 0 to ANode.ChildNodes.Count - 1 do
          LitEnfant(ANode.ChildNodes.Nodes[I]);
end; // Dessin.loadXML

procedure Tdessin.Load;
var
  i, imax: integer;
  z:  integer;
begin
  imax := NbreLigneWin(ligneWin) - NbreLigneDessin;
  readln(fichier, x1); {1}
  readln(fichier, y1); {2}
  readln(fichier, x2); {3}
  readln(fichier, y2); {4}
  readln(fichier, hauteur);{5}
  Read(fichier, numPage); // début 6
  if not eoln(fichier) then
    Read(fichier, iMonde);
  if not eoln(fichier) then begin
    Read(fichier, z);
    identification := Tidentification(z);
  end;
  if not eoln(fichier) then begin
    Read(fichier, z);
    TexteLigne := TtexteLigne(z);
  end;
  if not eoln(fichier) then
     Read(fichier, numPoint);
  if not eoln(fichier) then
     Read(fichier, couleurFond);
  if not eoln(fichier) then
     Read(fichier, numCoord);
  readln(fichier); // fin 6
  Read(fichier, z); // debut 7
  pen.color := z;
  if not eoln(fichier) then begin
    Read(fichier, z);
    pen.style := TpenStyle(z);
    Read(fichier, z);
    pen.Width := z;
  end;
  if not eoln(fichier) then begin
    Read(fichier, z);
    isTitre := z <> 0;
  end;
  if not eoln(fichier) then begin
    Read(fichier, z);
    isOpaque := z <> 0;
  end;
  readln(fichier);{fin 7}
  Souligne := litBooleanWin;{8}
  vertical := litBooleanWin;{9}
  avecCadre := litBooleanWin;{10}
  centre  := litBooleanWin;{11}
  isTexte := litBooleanWin;{12}
  avecLigneRappel := litBooleanWin; {13}
  readln(fichier, z); {14}
  MotifTexte := TmotifTexte(z);
  for i := 1 to imax do begin {15 sqq}
    litLigneWinU;
    Texte.add(ligneWin);
  end;
  if identification = identCoord then
     pen.color := couleurInit[numCoord];
end;

procedure TgrapheReg.majNomGr(index: TcodeGrandeur);
var
  i: TindiceMonde;
begin
  for i := 1 to maxOrdonnee do
    with coordonnee[i] do begin
      if codeY = index then
        nomY := grandeurs[index].nom;
      if codeX = index then
        nomX := grandeurs[index].nom;
    end;
end;

function TgrapheReg.AjusteMonde: boolean;

  procedure AjusteMondeCartesien;

    procedure AjusteMondeLoc(amonde: TindiceMonde; valeur: Tvecteur; Nbre: integer);
    var
      min, max: double;
    begin
      GetMinMax(valeur, Nbre, min, max);
      case monde[amonde].graduation of
        gLin: begin
          if monde[amonde].mini > min then begin
            monde[amonde].Mini := Min;
            Result := True;
          end;
          if monde[amonde].maxi < max then begin
            monde[amonde].Maxi := Max;
            Result := True;
          end;
        end;// linéaire
        gLog: begin
          try
            min := log10(min);
            if monde[amonde].mini > min then begin
              monde[amonde].Mini := Min;
              Result := True;
            end;
          except
          end;
          try
            max := log10(max);
            if monde[amonde].maxi < max then
            begin
              monde[amonde].Maxi := Max;
              Result := True;
            end;
          except
          end;
        end;{log}
        gInv: ;
        gdB: begin
          try
            min := log10(min) * 20;
            if monde[amonde].mini > min then begin
              monde[amonde].Mini := Min;
              Result := True;
            end;
          except
          end;
          try
            max := log10(max) * 20;
            if monde[amonde].maxi < max then begin
              monde[amonde].Maxi := Max;
              Result := True;
            end;
          except
          end;
        end;{décibel}
      end; // case graduation
    end;

  var
    j: integer;
  begin
    for j := 0 to pred(Courbes.Count) do
      with courbes[j] do begin
        AjusteMondeLoc(imondeC, valY, finC - debutC + 1);
        AjusteMondeLoc(mondeX, valX, finC - debutC + 1);
      end;{j}
  end; // AjusteMondeCartesien

  procedure AjusteMondePolaire;
  var
    j, i: integer;
    Lrayon, Langle, x, y: double;
  begin
    for j := 0 to pred(Courbes.Count) do
      with courbes[j] do begin
        for i := debutC to finC do begin
          Langle := valX[i];
          Lrayon := valY[i]-zeroPolaire;
          angleEnRadian(Langle);
          x := Lrayon * cos(Langle);
          with monde[mondeX] do
            if x > Maxi then begin
              Maxi := x;
              Result := True;
            end
            else if x < Mini then begin
              Mini := x;
              Result := True;
            end;
          y := Lrayon * sin(Langle);
          with monde[iMondeC] do
            if y > Maxi then begin
              Maxi := y;
              Result := True;
            end
            else if y < Mini then begin
              Mini := y;
              Result := True;
            end;
        end;// for i
      end;// for j
  end; // AjusteMondePolaire

var
  margeMonde: double;
  j: TindiceMonde;
begin
  Result := False;
  if OgPolaire in OptionGraphe
     then AjusteMondePolaire
     else AjusteMondeCartesien;
  if Result then
    for j := MondeY to High(TindiceMonde) do begin
      MargeMonde := (monde[j].Maxi - monde[j].Mini) / 64;
      if monde[j].Mini * (monde[j].Mini - MargeMonde) > 0 then
        monde[j].Mini := monde[j].Mini - MargeMonde;
      if monde[j].Maxi * (monde[j].Maxi + MargeMonde) > 0 then
        monde[j].Maxi := monde[j].Maxi + MargeMonde;
    end;
end; // AjusteMonde

procedure TgrapheReg.traceBorne(xi, yi: integer;
  style: TstyleBorne; couleur: Tcolor; indexM: integer);
var
  y1,dB: integer;
  Points:  array[0..2] of Tpoint;
begin
  if not avecBorne or (indexM = 0) or
    ((xi = limiteCourbe.left) and (style = bsDebutVert)) or
    (xi<0) or (yi<0) then exit;
  createSolidBrush(couleur);
  createPenFin(psSolid, couleur);
  canvas.pen.mode := pmNotXor;
  if style in [bsFin, bsFinVert]
     then dB := -dimBorne
     else dB := dimBorne;
 // symbole de borne=triangle
  if fonctionTheorique[indexM].variableEgalAbscisse and
    (fonctionTheorique[indexM].indexX = indexTri) and
    (style<>bsAucune) then begin
    y1 := (LimiteCourbe.top + LimiteCourbe.bottom) div 2;
    Points[0] := Point(xi - 2*dB, y1 + dB);
    Points[1] := Point(xi - 2*dB, y1 - dB);
    Points[2] := Point(xi, y1);
    canvas.Polygon(Points);
    createPen(psDash, 2, couleur);
    segment(xi, LimiteCourbe.top, xi, LimiteCourbe.bottom);
  end
  else if not (ImprimanteEnCours or WMFenCours or ImageEnCours) then begin
    Points[0] := Point(xi - dB, yi + dB);
    Points[1] := Point(xi - dB, yi - dB);
    Points[2] := Point(xi + dB, yi);
    canvas.Polygon(Points);
  end;
  canvas.pen.mode := pmCopy;
  canvas.brush.style := bsClear;
end; // traceBorne

procedure TGrapheReg.TraceReticule(index: TindexCurseur);
var x0,y0,rayon : integer;
begin with CurseurOsc[index], paintBox.Canvas do begin
    if not monde[mondeX].defini or
       not monde[mondeC].defini then exit;
    mondeRT(xc, yc, mondeC, Xr, Yr);
    createPen(PstyleReticule, 1, PColorReticule);
    Pen.mode := pmNOTXOR;
    if OgPolaire in OptionGraphe
      then begin
         windowRT(0,0,mondeC,x0,y0);
         rayon := round(sqrt(sqr(xC-x0)+sqr(yc-y0)));
         ellipse(x0 - rayon, y0 - rayon, x0 + rayon, y0 + rayon);
         moveTo(x0, y0);
         lineTo(xC, yC);
         rayon := rayonArcAngle-10;
         if yC<y0
            then arc(x0-rayon, y0-rayon, x0+rayon, y0+rayon, x0+rayon, y0, xC, yC)
            else arc(x0-rayon, y0-rayon, x0+rayon, y0+rayon, xC, yC, x0+rayon, y0);
      end
      else begin
         moveTo(0, Yc);
         lineTo(PaintBox.Width, Yc);
         moveTo(Xc, 0);
         lineTo(Xc, PaintBox.Height);
      end;
    Pen.mode := pmCopy;
end; end;

procedure TGrapheReg.TraceEcart;
var
  x0, y0, x1, y1, x2, y2 : integer;
begin with paintBox.Canvas do begin
    if not monde[mondeX].defini or
       not monde[curseurOsc[1].mondeC].defini then exit;
    createPen(PstyleReticule, 1, PColorReticule);
    x1 := curseurOsc[2].Xc;
    y1 := curseurOsc[2].Yc;
    x2 := curseurOsc[1].Xc;
    y2 := curseurOsc[1].Yc;
    x0 := limiteFenetre.left+1;
    y0 := limiteFenetre.Top+1;
    Pen.mode  := pmNOTXOR;
    Pen.color := clHighLight;
    if y1<>y2 then begin
       moveTo(x0, y1);
       lineTo(x0, y2);
    end;
    if x1<>x2 then begin
       moveTo(x1, y0);
       lineTo(x2, y0);
    end;
    moveTo(x1, y1);
    lineTo(x2, y2);
    Pen.mode := pmCopy;
end; end;

procedure TgrapheReg.SetUnitePente(iMonde: TindiceMonde);
begin
  UnitePente.UniteDerivee(monde[mondeX].axe, monde[iMonde].axe,
                          monde[mondeX].graduation, monde[iMonde].graduation);
  UnitePente.CoeffAff := monde[mondeX].Fexposant / monde[iMonde].Fexposant;
end;

procedure TgrapheReg.TraceBorneFFT;
var
  XdebutInt, XfinInt, zut: integer;
begin
  with pages[pageCourante] do begin
    if (debutFFT = 0) and (finFFT > nmes - 8) then
      exit;
    windowXY(valeurVar[0, finFFT], 0, mondeY, XfinInt, zut);
    windowXY(valeurVar[0, debutFFT], 0, mondeY, XdebutInt, zut);
  end;
  if XdebutInt < LimiteCourbe.left then
     XdebutInt := LimiteCourbe.left;
  if XfinInt >= LimiteCourbe.right then
     XfinInt := pred(LimiteCourbe.right);
  if (XfinInt-XdebutInt)<(3*LimiteCourbe.right div 4)
     then begin
        canvas.pen.Width := 3*penWidth;
        canvas.Pen.Color := clGray;
        canvas.Brush.color := clCream;
        canvas.Brush.style := bsSolid;
        canvas.Rectangle(XdebutInt,LimiteCourbe.bottom-marge,XfinInt,LimiteFenetre.top+marge);
     end
     else begin
        createPen(psSolid, 3, GetCouleurPages(1));
        segment(XdebutInt, LimiteCourbe.bottom, XdebutInt, LimiteCourbe.top);
        segment(XfinInt, LimiteCourbe.bottom, XfinInt, LimiteCourbe.top);
     end;
  canvas.Brush.style := bsClear;
  canvas.Pen.Width := 1;
end;

procedure TgrapheReg.affecteIndicateur(AvecIndicateur: boolean;const nom : string);
var
  i: integer;
begin
  for i := 0 to pred(courbes.Count) do
    with courbes[i] do
      if varY.nom = nom then
        if avecIndicateur
           then include(trace, trIndicateur)
           else exclude(trace, trIndicateur);
end;

procedure TgrapheReg.setCourbeDerivee;
var
  i: integer;
begin
  if ligneRappelCourante in [lrEquivalence, lrTangente] then begin
    equivalenceCourante := equivalenceTampon;
    equivalenceCourante.ligneRappel := lrTangente;
  end
  else EquivalenceCourante := nil;
  indexCourbeEquivalence := -1;
  mondeDerivee := mondeY;
  for i := 0 to pred(courbes.Count) do with courbes[i] do
      if (page = pageCourante) and (iMondeC = mondeY) then begin
        indexCourbeEquivalence := i;
        break;
      end;
  resetCourbeDerivee;
end;

procedure TgrapheReg.resetCourbeDerivee;
var
  i: integer;
  codeDerivee: TcodeGrandeur;
  nomDer: string;
  varYloc: tGrandeur;
  sauveIndex: integer;
begin
  if indexCourbeEquivalence < 0 then exit;
  mondeDerivee := courbes[indexCourbeEquivalence].iMondeC;
  if courbes[indexCourbeEquivalence].courbeExp then
// recherche courbe modélisée ou lissée correspondante
    for i := 0 to pred(courbes.Count) do with courbes[i] do
        if (page=pageCourante) and (valYder <> nil) and
           (varY=courbes[indexCourbeEquivalence].varY) then begin
          if (indexModele=1) and not (courbeExp) then begin
            indexCourbeEquivalence := i;
           // equivalenceTampon.modelisee := True;
            break;
          end;
          if (optionLigne = LiSpline) or (optionLigne = LiSinc) then begin
             indexCourbeEquivalence := i;
            // equivalenceTampon.withSpline := True;
             break;
          end;
        end;
  varYloc := monde[mondeDerivee].axe;
  if courbes[indexCourbeEquivalence].varY <> nil then begin
     varYloc := courbes[indexCourbeEquivalence].varY;
     equivalenceTampon.vary := varYloc;
  end;
  codeDerivee := indexDerivee(varYloc, monde[mondeX].axe, False, False);
  if codeDerivee = grandeurInconnue then begin
    if not nomCorrect(varYloc.nom,indexNomVariab(varYloc.nom)) then varYloc.nom := 'aze';
    nomDer := 'der' + varYloc.nom;
    i := 0;
    while not nomCorrect(nomDer, grandeurInconnue) do begin
      nomDer := 'der' + varYloc.nom + IntToStr(i);
      Inc(i);
    end;
    Fvaleurs.memo.Lines.add(nomDer + '=d(' +
      monde[mondeDerivee].axe.nom + ')/d(' + monde[mondeX].axe.nom + ')');
    ajoutGrandeurNonModele := True;
    sauveIndex := indexCourbeEquivalence;
    Fvaleurs.MajBtnClick(nil); // RàZ indexCourbeEquivalence
    Application.ProcessMessages;
    indexCourbeEquivalence := sauveIndex;
  end;
  UnitePente.UniteDerivee(monde[mondeX].axe, varYloc, gLin, gLin);
  if uniteSIGlb
     then coeffSIpente := dix(monde[mondeX].axe.puissance - varYloc.puissance)
     else coeffSIpente := 1;
end;  // resetCourbeDerivee

procedure TgrapheReg.chercheMinMax;
begin
  if OgPolaire in OptionGraphe then begin
    miniMod := 0;
    if angleEnDegre
       then maxiMod := 360
       else maxiMod := 2 * pi;
  end
  else with monde[mondeX] do
      case Graduation of
        gLog: begin
          maxiMod := power(10,Maxi);
          miniMod := power(10,Mini);
        end;
        gInv: begin
          maxiMod := 1 / Mini;
          miniMod := 1 / Maxi;
        end;
        else begin
          maxiMod := Maxi;
          miniMod := Mini;
        end;
      end;// case graduation
end; // chercheMinMax

function TgrapheReg.isAxeX(x, y: integer;var adroite : boolean): boolean;
begin
  Result := (y > limiteCourbe.bottom) and
    (y < limiteFenetre.bottom) and
    (x > limiteCourbe.left) and
    (x < (limiteFenetre.right - 8 * largCarac));
  adroite := x>((limiteCourbe.left+limiteCourbe.right) div 2);
end;

function TgrapheReg.isAxeY(x, y: integer;var enHaut : boolean): boolean;
begin
  Result := (x > limiteFenetre.left) and
    (x < (limiteCourbe.left)) and
    (y > limiteCourbe.top) and
    (y < limiteCourbe.bottom);
  enHaut := y<((limiteCourbe.top+limiteCourbe.bottom) div 2);
end;

Procedure TTransfertGraphe.Ecrit(numero : integer);
var i : integer;
    codeY,Nbre : integer;
begin
    nbre := 0;
    for i := 1 to maxOrdonnee do begin
        codeY := indexNom(nomY[i]);
        if (codeY<>grandeurInconnue) and
           (grandeurs[codeY].genreG=variable)
           then begin
        codeY := indexNom(nomX[i]);
        if (codeY<>grandeurInconnue) and
           (grandeurs[codeY].genreG=variable)
           then inc(Nbre);
           end;
    end;
    if nbre=0 then exit;
    writeln(fichier,symbReg2,'1 DEBUT PAGE'+intTostr(numero));
    writeln(fichier,numero);
    writeln(fichier,symbReg2,Nbre,' '+stLigne);
    for i := 1 to Nbre do
       writeln(fichier,ord(ligne[i]));
    writeln(fichier,symbReg2,Nbre,' '+stCouleur);
    for i := 1 to Nbre do
       writeln(fichier,couleur[i]);
    writeln(fichier,symbReg2,Nbre,' MOTIF');
    for i := 1 to Nbre do
       writeln(fichier,ord(motif[i]));
    writeln(fichier,symbReg2,Nbre,' '+stCouleurPoint);
    for i := 1 to Nbre do
       writeln(fichier,couleurPoint[i]);
    writeln(fichier,symbReg2,Nbre,' X');
    for i := 1 to Nbre do
       ecritChaineRW3(nomX[i]);
    writeln(fichier,symbReg2,Nbre,' Y');
    for i := 1 to Nbre do
       ecritChaineRW3(nomY[i]);
    writeln(fichier,symbReg2,Nbre,' TRACE');
    for i := 1 to Nbre do
       writeln(fichier,word(trace[i]));
    writeln(fichier,symbReg2,Nbre,' '+stMonde);
    for i := 1 to Nbre do
       writeln(fichier,ord(iMonde[i]));
    writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' GRADUATION');
    for i := mondeX to MondeDroit do
       writeln(fichier,ord(grad[i]));
    writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' ZERO');
    for i := mondeX to MondeDroit do
       writeln(fichier,ord(zero[i]));
    writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' INVERSE');
    for i := mondeX to MondeDroit do
       writeln(fichier,ord(axeInverse[i]));
    writeln(fichier,symbReg2,'13 '+stOptions);
    writeln(fichier,byte(optionGr));{1}
    writeln(fichier,byte(optionModele));{2}
    writeln(fichier,ord(traceDefaut));{3}
    writeln(fichier,OrdreLissage);{4}
    writeln(fichier,DimPointVGA);{5}
    writeln(fichier,ord(UseDefaut));{6}
    writeln(fichier,ord(UseDefautX));{7}
    writeln(fichier,ord(SuperposePage));{8}
    writeln(fichier,ord(avecEllipse));{9}
    if (indicateur<>nil) and (indicateurDlg<>nil)
      then writeln(fichier,indicateurDlg.indicateurs.indexOf(indicateur))
      else writeln(fichier,-1);{10}
    writeln(fichier,ord(FilDeFer));{11}
    writeln(fichier,ord(false));{12}
    writeln(fichier,pasPoint);{13}
    writeln(fichier,symbReg2,'1 FIN');
    writeln(fichier,numero);
end;

Procedure TTransfertGraphe.Lit;
var imax : integer;
    i : integer;
    choix : integer;
    zWord : word;
    zByte : byte;
    zInt : integer;
    lectureOK,termine : boolean;
begin // lit
    termine := false;
    while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) and not termine do begin
      choix := 0;
      imax := NbreLigneWin(ligneWin);
      if pos('X',ligneWin)<>0 then choix := 1;
      if pos('Y',ligneWin)<>0 then choix := 2;
      if pos(stMonde,ligneWin)<>0 then choix := 3;
      if pos('GRADUATION',ligneWin)<>0 then choix := 4;
      if pos(stCouleurPoint,ligneWin)<>0 then choix := 25;
      if pos(stOptions,ligneWin)<>0 then choix := 5;
      if pos('ZERO',ligneWin)<>0 then choix := 6;
      if pos('TRACE',ligneWin)<>0 then choix := 13;
      if pos(stCouleur,ligneWin)<>0 then choix := 16;
      if pos(stLigne,ligneWin)<>0 then choix := 17;
      if pos('MOTIF',ligneWin)<>0 then choix := 18;
      if pos('INVERSE',ligneWin)<>0 then choix := 23;
      if pos('FIN PAGE',ligneWin)<>0 then choix := 24;
      lectureOK := true;
      case choix of
           0 : for i := 1 to imax do readln(fichier);
           1 : for i := 1 to imax do begin
                litLigneWinU;
                nomX[i] := LigneWin;
           end;
           2 : for i := 1 to imax do begin
                litLigneWinU;
                nomY[i] := LigneWin;
           end;
           3 : for i := 1 to imax do begin
                litLigneWin;
                if ligneWin[1]=symbReg2
                   then begin
                       lectureOK := false;
                       break;
                   end
                   else begin
                       zByte := StrToInt(ligneWin);
                       iMonde[i] := TindiceMonde(zByte);
                   end
           end;
           4 : for i := 1 to imax do begin
                litLigneWin;
                if ligneWin[1]=symbReg2
                   then begin
                       lectureOK := false;
                       break;
                   end
                   else begin
                       zByte := StrToInt(ligneWin);
                       grad[pred(i)] := Tgraduation(zByte);
                   end;    
           end;
           5 : begin
             litLigneWin; {1}
             optionGr := TsetOptionGraphe(byte(strToInt(ligneWin)));
             litLigneWin; {2}
             optionModele := TsetOptionModele(byte(strToInt(ligneWin)));
             litLigneWin; {3}
             try
             TraceDefaut := TtraceDefaut(strToInt(ligneWin));
             except
             TraceDefaut := tdPoint;
             end;
             litLigneWin; {4}
             OrdreLissage := strToInt(ligneWin);
             litLigneWin; {5}
             DimPointVGA := strToInt(ligneWin);
             useDefaut := litBooleanWin; {6}
             useDefautX := litBooleanWin; {7}
             superposePage := litBooleanWin; {8}
             avecEllipse := litBooleanWin; {9}
             litLigneWin;{10}
                zInt := strToInt(ligneWin);
                try
                if (zInt>=0) and (zint<indicateurDlg.indicateurs.count)
                   then indicateur := Tindicateur(indicateurDlg.indicateurs[zInt])
                   else indicateur := nil;
                except
                indicateur := nil;
                end;
             FilDeFer := litBooleanWin; {11}
             litBooleanWin; {12}
             readln(fichier,PasPoint); {13 }
             for i := 14 to imax do readln(fichier);
           end;
           6 : for i := 1 to imax do
                zero[pred(i)] := litBooleanWin;
           13 : for i := 1 to imax do begin
                 readln(fichier,zWord);
                 trace[i] := TsetTrace(zWord);
           end;
           16 : for i := 1 to imax do
               readln(fichier,couleur[i]);
           17 : for i := 1 to imax do begin
               readln(fichier,zByte);
               ligne[i] := Tligne(zByte);
           end;
           18 : for i := 1 to imax do begin
               readln(fichier,zByte);
               motif[i] := Tmotif(zByte);
           end;
           23 : for i := 1 to imax do
                axeInverse[pred(i)] := litBooleanWin;
           24 : begin
                litLigneWin;
                termine := true;
           end;
           25 : for i := 1 to imax do begin
                litLigneWin;
                couleurPoint[pred(i)] := ligneWin;
           end;
      end; { case }
      if lectureOK then litLigneWin;
    end;
end; // lit

function TgrapheReg.WindowX(xr: double): integer;
begin
  case monde[mondeX].graduation of
    gLog: xr := Log10(xr);
    gInv: xr := 1 / xr;
  end;
  Result := monde[mondeX].affecteEntier(xr);
end;

procedure TgrapheReg.CreateSolidBrush(couleur : Tcolor);
begin
     canvas.Brush.Style := bsSolid;
     canvas.Brush.Color := couleur;
end;

procedure TgrapheReg.MyTextOut(x,y : integer;const S : string);
begin
     if Canvas.font.orientation=900 then begin
     // normal TA_TOP
        if (alignement and TA_BOTTOM)= TA_BOTTOM
           then x := x - canvas.textHeight(S)
            else if (alignement and TA_BASELINE)= TA_BASELINE
               then x := x - (canvas.textHeight(S) div 2);
     // normal TA_LEFT
        if (alignement and TA_CENTER)= TA_CENTER
            then y := y - (canvas.textWidth(S) div 2)
            else if (alignement and TA_RIGHT)= TA_RIGHT
                 then y := y - canvas.textWidth(S);
     end
     else begin
         if (alignement and TA_BOTTOM)= TA_BOTTOM
            then (*if axeYpositif
               then y := y + canvas.textHeight(S)
               else *)y := y - canvas.textHeight(S)
            else if (alignement and TA_BASELINE)= TA_BASELINE then
              (* if axeYpositif
                  then y := y + (canvas.textHeight(S) div 2)
                  else *)y := y - (canvas.textHeight(S) div 2);
         if (alignement and TA_CENTER)= TA_CENTER
             then x := x - (canvas.textWidth(S) div 2)
             else if (alignement and TA_RIGHT)= TA_RIGHT
                 then x := x - canvas.textWidth(S);
     end;
     canvas.TextOut(x,y,S);
end;

procedure TgrapheReg.MyTextOutFond(x,y : integer;const S : string;couleur : Tcolor);
begin
     if ImprimanteEnCours and ImprimanteMono
     then begin
        canvas.TextFlags := 0;
        canvas.Brush.Color := clWindow;
        myTextOut(x,y,S);
     end
     else begin
        canvas.Brush.Color := couleur;
        canvas.TextFlags := eto_opaque;
        MyTextOut(x,y,S);
        canvas.TextFlags := 0;
        canvas.Brush.Color := clWindow;
     end;
end;

procedure TgrapheReg.SetTextAlign(aligne : integer);
begin
   Alignement := aligne
// TA_BASELINE The reference point will be on the base line of the text.
// TA_BOTTOM The reference point will be on the bottom edge of the bounding rectangle.
// TA_TOP The reference point will be on the top edge of the bounding rectangle.
// TA_CENTER The reference point will be aligned horizontally with the center of the bounding rectangle.
// TA_LEFT The reference point will be on the left edge of the bounding rectangle.
// TA_RIGHT The reference point will be on the right edge of the bounding rectangle.
end;

procedure TgrapheReg.createHatchBrush(aCode : TbrushStyle;couleur : Tcolor);
begin
     canvas.Brush.Style := aCode;
     canvas.Brush.Color := couleur;
end;

procedure TgrapheReg.CreatePen(aStyle : TpenStyle;aWidth  : integer;couleur : Tcolor);

procedure MyExtCreatePen;
VAR
    BrushInfo:  TLogBrush;
    PenStyle :  DWORD;
begin
  if oldPen<>0 then deleteObject(oldPen);
  WITH BrushInfo DO BEGIN
    lbStyle := BS_SOLID;
    lbColor := couleur;
    lbHatch := 0
  END;
  PenStyle := PS_GEOMETRIC OR PS_ENDCAP_SQUARE OR PS_JOIN_MITER;
  PenStyle := PenStyle + DWord(aStyle);
  canvas.Pen.Handle := ExtCreatePen(PenStyle, aWidth, BrushInfo, 0, NIL);
  oldPen :=  canvas.Pen.Handle;
end;

begin
     awidth := awidth*penwidth;
     if imprimanteMono
        then canvas.pen.Color := clBlack
        else canvas.pen.Color := couleur;
     if (aStyle<>psSolid) and (aWidth>1)
     then MyExtCreatePen
     else begin
        canvas.pen.Style := astyle;
        canvas.pen.Width := awidth;
     end;
end;

procedure TgrapheReg.CreatePenFin(aStyle : TpenStyle;couleur : Tcolor);
begin
     if imprimanteMono
        then canvas.pen.Color := clBlack
        else canvas.pen.Color := couleur;
     canvas.pen.Style := astyle;
     canvas.pen.Width := 1;
end;

procedure TgrapheReg.changeEchelleX(xnew, xold: integer;ismaxi : boolean);
begin with monde[mondeX] do begin
    if ismaxi then begin
       xnew := xnew - limiteCourbe.left;
       if xnew < 16 then exit;
       xold := xold - limiteCourbe.left;
       A := A * xnew / xold;
       Maxi := Mini + (limiteCourbe.right - limiteCourbe.left) / A;
       B := limiteCourbe.left - Mini * A;
    end
    else begin
       xnew := limiteCourbe.right-xnew;
       if xnew < 16 then exit;
       xold := limiteCourbe.right - xold;
       A := A * xnew / xold;
       Mini := Maxi - (limiteCourbe.right - limiteCourbe.left) / A;
       B := limiteCourbe.left - Mini * A;
    end;
    useDefautX := true;
    useZoom := false;
    getMinMaxDefaut;
end end;

procedure TgrapheReg.changeEchelleY(ynew, yold: integer;isMaxi : boolean);
begin with monde[mondeY] do begin
    if ismaxi then begin
       ynew := limiteCourbe.bottom - ynew;
       if ynew < 16 then exit;
       yold := limiteCourbe.bottom - yold;
       A := A * ynew / yold;
       Maxi := Mini + (limiteCourbe.top - limiteCourbe.bottom) / A;
       B := limiteCourbe.bottom - Maxi * A;
    end
    else begin
       ynew := ynew - limiteCourbe.top;
       if ynew < 16 then exit;
       yold := yold - limiteCourbe.top;
       A := A * ynew / yold;
       Mini := Maxi + (limiteCourbe.bottom - limiteCourbe.top) / A;
       B := limiteCourbe.bottom - Maxi * A;
    end;
    useDefaut := true;
    useZoom := false;
    getMinMaxDefaut;
end end;

procedure TgrapheReg.GenereSon;
const FreqEchWav = 11025;
      FreqEchWavMax = 44100;
var Hfichier : integer;
    indexCourbe : integer;

Procedure EcritFichier;
var NbrePoints,NbrePointsWav : longInt;
    freqEch : longWord;

Procedure EcritTexte(const texte : shortString);
var i,z : byte;
begin
   for i := 1 to length(texte) do begin
       z := ord(texte[i]);
       FileWrite(Hfichier,z,1)
   end
end;

Procedure EcritOctet(octet : byte);
begin
   FileWrite(Hfichier,octet,1)
end;

Procedure EcritLongMot(mot : longWord);
begin
   FileWrite(Hfichier,mot,4)
end;

Procedure EcritMot(mot : Word);
begin
   FileWrite(Hfichier,mot,2)
end;

var coeffVal,coeffN,mini,maxi,milieu : double;
    i,j : LongInt;
    entier : smallInt;
{
44.100 kHz Qualité CD
22.050 kHz taux d'échantillonnage habituel Windows
11.025 kHz lecture Windows
8.000 kHz lecture/écriture de base
x.000  kHz ??
}

var NewFreqEch : integer;
    DebutWav,FinWav : integer;
    sampleSize : word;
    valeur : double;
begin
     sampleSize := 2;
     with pages[pageCourante] do begin
        NbrePoints := finFFT-debutFFT;
        DebutWav := debutFFT;
        FinWav := finFFT;
     end;
     FreqEch := round(NbrePoints/(courbes[indexCourbe].valX[pred(NbrePoints)]-courbes[indexCourbe].valX[0]));
     if FreqEch<10000
        then NewFreqEch := 2000*round(FreqEch/2000) // donc en pratique 2000 .. 8000
        else if freqEch<49000
             then NewFreqEch := FreqEchWav*round(FreqEch/FreqEchWav) // donc en pratique 11025, 22050, 44100
             else NewFreqEch := FreqEchWavMax;
     NbrePointsWav := round(NbrePoints*NewFreqEch/FreqEch);
     coeffN := NbrePoints/NbrePointsWav;
     if CoeffN<0.1 then begin { Echantillonnage < 1,1 kHz }
          NbrePointsWav := NbrePoints;
          CoeffN := 1;
     end;
     if CoeffN>10 then begin { Echantillonnage > 500 kHz }
          NbrePointsWav := NbrePoints;
          CoeffN := 1;
     end;
     FreqEch := NewFreqEch;
{ 0..3 riff }
     ecritTexte('RIFF');
{ 4..7 taille en octets poids faible en premier }
     ecritLongMot(LongWord(NbrePointsWav*sampleSize+36));
{ taille de ce qui suit d'où
  +36 = 44 octets de codage - les 8 précédents
  *sampleSize = octets par échantillon }
{ 8..15 WAVEFMT }
     ecritTexte('WAVEfmt ');
{ 16..19 16,0,0,0 : size les 16 octets qui suivent }
     ecritLongMot(16);
{ 20..23 1,0,1 ou 2,0 (4) }
     ecritOctet(1); { formatTag }
     ecritOctet(0);
     ecritOctet(1); { formatTag }
     ecritOctet(0);
{ 24..27 fréquence poids faible en premier en échantillons }
     ecritLongMot(FreqEch);
     freqEchWave := FreqEch;
{ 28..31 fréquence poids faible en premier en octets }
     ecritLongMot(LongWord(FreqEch*sampleSize));
{ 32..33  block align sur sampleSize octets }
     ecritMot(sampleSize);
{ 34..35 8 ou 16 Nombre de bits }
     ecritMot(16);
{ 36 39 "data" }
     EcritTexte('data');
{ 40..43 nbre échantillon }
     ecritLongMot(LongWord(NbrePointsWav*sampleSize));
     maxi := courbes[indexCourbe].valY[debutWav];
     mini := courbes[indexCourbe].valY[debutWav];
     for i := succ(debutWav) to finWav do begin
         valeur := courbes[indexCourbe].valY[i];
         if valeur>maxi
            then maxi := valeur
            else if valeur<mini then mini := valeur;
     end;
     if ((maxi-mini)>65000) or
        ((maxi-mini)<8000)
          then coeffVal := 58000/(maxi-mini)
          else coeffVal := 1;
     milieu := (maxi+mini)/2;
     for j := 0 to pred(NbrePointsWav) do begin
         i := debutWav+trunc(j*coeffN);
         entier := round((courbes[indexCourbe].valY[i]-milieu)*coeffVal);
         FileWrite(Hfichier,entier,2);
     end;
end;

var F : TextFile;
begin
     FichierSon := TPath.Combine(tempDirReg,'regson'+intToStr(pageCourante)+'.WAV');
     Pages[pageCourante].NomFichierBitmap := FichierSon;
     if not FileExists(FichierSon) then begin
        AssignFile(F,FichierSon);
        Rewrite(F);
        write(F,'RIFF');
        CloseFile(F);
     end;
     indexCourbe := 0;
     while (indexCourbe<(courbes.count-1)) and
           (courbes[indexCourbe].page<>pageCourante) do inc(indexCourbe);
     if   (indexCourbe<(courbes.count-1)) and
          (trPoint in courbes[indexCourbe].trace) and
          (courbes[indexCourbe].motif=mPixel) and
          (trLigne in courbes[indexCourbe+1].trace)
        then inc(indexCourbe);
     Hfichier := FileOpen(FichierSon,fmOpenWrite);
     if HFichier>0 then begin
         EcritFichier;
         FileClose(Hfichier);
     end
end; // genereSon

procedure TgrapheReg.VersLatex(const NomFichier : string;suffixe : char);
var NomFichierDebut : string;

 procedure TraceMonde(m : TindiceMonde);
 const NbreMaxLatex = 256;
       separe = crTab;
 var FichierAsc : textFile;
     exposantX,exposantY : double;

 procedure Extrait(index : integer); // enlever les points inutiles
    var
      idebut: integer;
      deltaX : double;

      procedure Nettoie;

      procedure ecritxy(x,y : double);
      begin
            if not isNan(x) and not isNan(y) then
            writeln(fichierAsc,FloatToStrLatex(x/exposantX)+separe+
                               FloatToStrLatex(y/exposantY));
      end;

      var
        ifin: integer;
        maxiY, miniY, maxiX, miniX: double;
        xdebut,xcourant, ycourant: double;
      begin with courbes[index] do begin
        xdebut := valX[idebut];
        yCourant := valY[idebut];
        maxiY := ycourant;
        miniY := ycourant;
        maxiX := xdebut;
        miniX := xdebut;
        iFin := iDebut + 1;
        repeat
          yCourant := valY[iFin];
          xCourant := valX[iFin];
          if yCourant > maxiY then begin
            maxiY := ycourant;
            maxiX := xCourant;
          end;
          if yCourant < miniY then begin
            miniY := ycourant;
            miniX := xCourant;
          end;
          Inc(iFin);
        until (iFin>finC) or ((xCourant-xDebut)>deltaX); // verticale différente
        ecritxy(valX[iDebut],valY[iDebut]);
// on garde début
        if (miniY-valY[iDebut])*(miniY-valY[iFin])>0 then
            ecritxy(miniX,miniY);
// on garde mini si en dehors de debut fin
        if (maxiY-valY[iDebut])*(maxiY-valY[iFin])>0 then
            ecritxy(maxiX,maxiY);
        ecritxy(valX[iFin],valY[iFin]);
// on garde fin
        idebut := iFin+1; // prochain debut
      end end;

    begin
      deltaX := 2*(monde[mondeX].maxi-monde[mondeX].mini)/NbreMaxLatex;
      idebut := courbes[index].debutC;
      repeat
           Nettoie
      until idebut >= courbes[index].finC;
    end; // extrait

 var i,j,i1 : integer;
     Nx,Ny : string;
     NomFichierCourant : string;
     prefixe : string;
     lignePlot : string;
     latexStr : TstringList;
     couleurLoc : TColor;
     motifLoc : Tmotif;
     samples : integer;
     exposantXstr,exposantYstr : string;
 begin  // traceMonde
      prefixe := '';
      i1 := 0;
      for i := 0 to Courbes.Count - 1 do
          if courbes[i].iMondeC=m then begin
              i1 := i;
              break;
          end;
      if monde[mondeX].graduation=gLog
         then if monde[m].graduation=gLog
              then prefixe := 'loglog'
              else prefixe := 'semilogx'
         else if monde[m].graduation=gLog
              then prefixe := 'semilogy';
// else if (OgPolaire in options) then prefixe := 'polar';
// en cours d'installation dans pgfPlots
      ajouteLigneLatex('\begin{'+prefixe+'axis}[');
      ajouteLigneLatex('height=10cm,width=15cm');
      exposantX := monde[mondeX].Fexposant;
      if exposantX=1
         then exposantXStr := ''
         else exposantXStr := '*10^('+intToStr(round(Log10(exposantX)))+')';
      exposantY := monde[m].Fexposant;
      if exposantY=1
         then exposantYStr := ''
         else exposantYStr := '*10^('+intToStr(round(-Log10(exposantY)))+')';
// title p 177
// barre d'erreur p 160
//     ajouteLigneLatex('xscale=0.7, yscale=0.2');
//     ajouteLigneLatex(',scale only axis');
      if m=mondeY then if (ogZeroGradue in OptionGraphe)
         then ajouteLigneLatex(',axis x line=center,axis y line=center')
         else ajouteLigneLatex(',axis x line=bottom,axis y line=left');
      if m=mondeDroit then
         ajouteLigneLatex(',axis x line=none,axis y line=right');
      with monde[mondeX] do
          case Graduation of
             gLog: ajouteLigneLatex(',xmin='+FloatToStrLatex(power(10,mini/exposantX))+
                            ',xmax='+FloatToStrLatex(power(10,maxi/exposantX)));
             gLin: ajouteLigneLatex(',xmin='+FloatToStrLatex(mini/exposantX)+
                            ',xmax='+FloatToStrLatex(maxi/exposantX));
             gInv: ;
             gBits: ;
             gdB: ;
      end;
      with monde[m] do case Graduation of
             gLog: ajouteLigneLatex(',ymin='+FloatToStrLatex(power(10,mini/exposantY))+
                            ',ymax='+FloatToStrLatex(power(10,maxi/exposantY)));
             gdB: ajouteLigneLatex(',ymin='+FloatToStrLatex(power(10,mini/exposantY/20))+
                            ',ymax='+FloatToStrLatex(power(10,maxi/exposantY/20)));
             gLin: ajouteLigneLatex(',ymin='+FloatToStrLatex(mini/exposantY)+
                            ',ymax='+FloatToStrLatex(maxi/exposantY));
             gInv: ;
             gBits: ;
      end;
      if OgQuadrillage in OptionGraphe then ajouteLigneLatex(',grid=major');
      if m=mondeY then begin
         Nx := courbes[i1].varX.titreAff;
         Nx := Nx+courbes[i1].varX.UniteAxe(exposantX,monde[mondeX].arrondiAxe);
      end;
      Ny := courbes[i1].varY.titreAff;
      with monde[m] do
        if graduation=gdB
           then Ny := Ny+' (dB)'
           else Ny := Ny+courbes[i1].varY.UniteAxe(exposantY,arrondiAxe);
      ajouteLigneLatex(',title={'+translateNomTexte(pages[courbes[i1].page].titrePage)+'}');
      if m=mondeY then ajouteLigneLatex(',xlabel={$'+translateNomMath(Nx)+'$}');
      ajouteLigneLatex(',ylabel={$'+translateNomMath(Ny)+'$}');
      ajouteLigneLatex(']');
// enlever blanc et carac spéciaux
      for i := 0 to Courbes.Count - 1 do with courbes[i] do if iMondeC=m
          then begin
          NomFichierCourant := NomFichierDebut+intToStr(i)+'.txt';
          AssignFile(fichierAsc,NomFichierCourant);
          Rewrite(fichierAsc);
          samples := NbreMaxLatex;
          if (finC-debutC)>NbreMaxLatex
          then extrait(i)
          else if (trPoint in trace) and (motif=mIncert)
          then begin
              for j := debutC to finC do
              writeln(fichierAsc,FloatToStrLatex(valX[j]/exposantX)+separe+
                                 FloatToStrLatex(valY[j]/exposantY)+separe+
                                 FloatToStrLatex(incertX[j]/exposantX)+separe+
                                 FloatToStrLatex(incertY[j]/exposantY));
                                 // incertitude non définie ?
              samples := finC-debutC;
          end
          else begin
              for j := debutC to finC do
              writeln(fichierAsc,FloatToStrLatex(valX[j]/exposantX)+separe+
                                 FloatToStrLatex(valY[j]/exposantY));
              samples := finC-debutC;
          end;
          closeFile(FichierAsc);
          if superposePage and (SPcouleur=reperePage)
              then couleurLoc := GetCouleurPages(page)
              else couleurLoc := couleur;
          if (trLigne in trace) and (indexModele<>0) then begin
          // traçage de la courbe par Tikz
             if indexModele>0
                then lignePlot := fonctionTheorique[indexModele].expressionLatex(exposantXstr)
                else lignePlot := fonctionSuperposee[-indexModele].expressionLatex(exposantXstr);
             if lignePlot<>'' then begin
                 if exposantYstr<>''  then lignePlot := '('+lignePlot+')'+exposantYStr;  // + /10^(exposantY)
                 lignePlot := '\addplot['+
                 'domain='+floatToStrLatex(valX[debutC]/exposantX)+':'+floatToStrLatex(valX[finc]/exposantX)+
                 ','+couleurLatex(couleurLoc)+',samples='+intToStr(samples)+']{'+lignePlot+'};';
                 ajouteLigneLatex(lignePlot);
                 ajouteLigneLatex('% En cas de problème avec la ligne précédente décommenter la ligne suivante');
                 lignePlot := '%';
             end;
          end
          else lignePlot := '';
          lignePlot := lignePlot+'\addplot[draw='+couleurLatex(couleurLoc);
          if (trLigne in trace)
             then if (trPoint in trace)
                then
                else lignePlot := lignePlot+',mark=none,smooth'
             else lignePlot := lignePlot+',only marks';
          if superposePage and (motif <= mCarrePlein) and (SPmotif=reperePage)
              then motifLoc := motifPages[page mod MaxPagesGr]
              else motifLoc := motif;
          if trPoint in trace then begin
               case motifLoc of
                    mCroix, mCroixDiag, mCercle, mCarre, mLosange,
                    mCerclePlein, mCarrePlein,mPixel : begin
                       lignePlot := lignePlot+',mark='+MotifLatex[motif];
                       if motif in [mcerclePlein,mcarrePlein] then
                          lignePlot := lignePlot+',mark options={fill='+couleurLatex(couleur)+'}';
                       if motif=mPixel then
                          lignePlot := lignePlot+',mark options={xscale=1,yscale=1}';
                    end;
                    mIncert : lignePlot := lignePlot+',error bars/.cd'+
                              ',y dir=both, y explicit'+
                              ',x dir=both, x explicit'+
                              ',error mark=none';
                    mEchantillon : lignePlot := lignePlot+',ycomb,mark=*';
                    mHisto : lignePlot := lignePlot+',ybar,bar width=5pt,ybar interval=0';
                    mSpectre : lignePlot := lignePlot + ',ycomb';
                    else lignePlot := lignePlot+',mark=*';
                end; // case
          end; // trPoint
          if (trPoint in trace) and (motif=mIncert)
             then lignePlot := lignePlot+'] table[x error index=2,y error index=3]'
             else lignePLot := lignePlot+'] file';
          lignePlot := lignePlot+' {'+ExtractFileName(NomFichierCourant)+'};';
          ajouteLigneLatex(lignePlot);
      end;
      latexStr := TStringList.create;
      for i := 0 to pred(equivalences[pageCourante].Count) do begin
          equivalences[pageCourante].items[i].drawLatex(latexStr);
          if latexStr.Count>0 then
             for j := 0 to pred(latexStr.Count) do
                 ajouteLigneLatex(latexStr[j]);
      end;
      latexStr.Clear;
      for i := 0 to pred(Dessins.Count) do dessins[i].drawLatex(latexStr);
      if latexStr.Count>0 then
         for i := 0 to pred(latexStr.Count) do
             ajouteLigneLatex(latexStr[i]);
      latexStr.free;
      ajouteLigneLatex('\end{'+prefixe+'axis}');
 end; // traceMonde

 var avecAxeDroit : boolean;
     i : integer;
  begin
      if not grapheOK then exit;
      NomFichierDebut := ChangeFileExt(ExtractFileName(NomFichier),'');
      trimAscii127(NomFichierDebut);
      NomFichierDebut := ExtractFilePath(NomFichier)+NomFichierDebut+suffixe;
      ajouteLigneLatex('');
      ajouteLigneLatex('\begin{tikzpicture}');
      avecAxeDroit := false;
      for i := 0 to Courbes.Count - 1 do
          with courbes[i] do if iMondeC=mondeDroit then begin
               avecAxeDroit := true;
               break;
          end;
      traceMonde(mondeY);
      if avecAxeDroit then traceMonde(mondeDroit);
      ajouteLigneLatex('\end{tikzpicture}');
      ajouteLigneLatex('');
  end;// versLatex

procedure TGrapheReg.VersJPEG(const NomFichier: string);
var
  Abitmap: TbitMap;
  Ajpeg: TjpegImage;
  sauveLimite: Trect;
  sauveCanvas : Tcanvas;
begin
  sauveLimite := limiteCourbe; // écran
  Abitmap := TbitMap.Create;
  Abitmap.Height := YmaxBitmap;
  Abitmap.Width := XmaxBitmap;
  Abitmap.pixelFormat := pf24bit;
  setRect(limiteFenetre, 0, 0, XmaxBitmap, YmaxBitmap);
  sauveCanvas := canvas;
  imageEnCours := True;
  canvas := Abitmap.Canvas;
  Draw;
  imageEnCours := False;
  Ajpeg := TjpegImage.Create;
  Ajpeg.Assign(Abitmap);
  Ajpeg.compress;
  if NomFichier = ''
     then ClipBoard.Assign(Ajpeg)
     else Ajpeg.saveToFile(NomFichier);
  Ajpeg.Free;
  AbitMap.Free;
  LimiteCourbe := sauveLimite;
  canvas := sauveCanvas;
end;

procedure TGrapheReg.VersPng(const NomFichier: string);
var
  Abitmap: TbitMap;
  Apng: TpngImage;
  sauveLimite: Trect;
  sauveCanvas : Tcanvas;
begin
  sauveLimite := limiteCourbe; // écran
  Abitmap := TbitMap.Create;
  Abitmap.Height := YmaxBitmap;
  Abitmap.Width := XmaxBitmap;
  Abitmap.pixelFormat := pf24bit;
  setRect(limiteFenetre, 0, 0, XmaxBitmap, YmaxBitmap);
  sauveCanvas := canvas;
  imageEnCours := True;
  canvas := AbitMap.Canvas;
  Draw;
  imageEnCours := False;
  Apng := TpngImage.Create;
  Apng.Assign(Abitmap);
  if NomFichier = ''
     then ClipBoard.Assign(Apng)
     else Apng.saveToFile(NomFichier);
  Apng.Free;
  Abitmap.Free;
  LimiteCourbe := sauveLimite;
  canvas := sauveCanvas;
end;

procedure TGrapheReg.VersBitmap(const NomFichier : string);
var
  Abitmap: TbitMap;
  sauveLimite: Trect;
  sauveCanvas : Tcanvas;
begin
  sauveLimite := limiteCourbe; // écran
  Abitmap := TbitMap.Create;
  Abitmap.Height := YmaxBitmap;
  Abitmap.Width := XmaxBitmap;
  Abitmap.pixelFormat := pf24bit;
  setRect(limiteFenetre, 0, 0, XmaxBitmap, YmaxBitmap);
  sauveCanvas := canvas;
  imageEnCours := True;
  canvas := Abitmap.Canvas;
  Draw;
  imageEnCours := False;
  if NomFichier = ''
     then ClipBoard.Assign(Abitmap)
     else Abitmap.saveToFile(NomFichier);
  AbitMap.Free;
  LimiteCourbe := sauveLimite;
  canvas := sauveCanvas;
end;

Procedure TgrapheReg.SetRepere;
var Dessin : Tdessin;
    i,cY : integer;
    y : double;
begin
   i := 0;
   while (i<dessins.count) do begin
       if (dessins[i].repere<>nil)
           then Dessins.remove(dessins[i])
           else inc(i);
   end;
   if pageCourante=0 then exit;
   with pages[pageCourante] do begin
   if coordonnee[1].codeX<>0 then exit;  // temps en abscisse obligatoire ?
   cY := coordonnee[1].codeY;
   if (cY=grandeurInconnue) or
      (grandeurs[cY].genreG<>variable) then exit;
   y := monde[coordonnee[1].iMondeC].maxi;
   for i := 0 to pred(ListeRepere.count) do begin
      Dessin := Tdessin.create(self);
      with Dessin do begin
        y1 := y;
        y2 := y;
        x1 := ListeRepere[i].valeur;
        x2 := x1;
        pen.style := TpenStyle(PstyleRepere);
        isTexte := true;
        IsOpaque := true;
        MotifTexte := mtVert;
        vertical := false;
        texte.add(ListeRepere[i].texte);
        pen.color := PColorRepere;
        repere := ListeRepere[i];
        numPage := pageCourante;
      end;
      dessins.add(Dessin);
   end;
end end;

procedure TDessin.SetPourCent(var i: integer;TexteLoc : TstringList);
  var
    posPourCent: integer;
    LigneTexte:  string;

    procedure SetLoc(Agrandeur: Tgrandeur; valeur: double; Nbre: integer);
    begin
      Delete(LigneTexte, posPourCent, Nbre);
      Insert(Agrandeur.formatNomEtUnite(valeur), LigneTexte, posPourCent);
    end;

    procedure SetParam(i,nbre : integer);
    begin
      Delete(LigneTexte, posPourCent, Nbre);
      Insert(pages[numeroPage].paramEtPrec(i,true), LigneTexte, posPourCent);
    end;

    procedure PosCode(code: string; numero: integer);
    begin
      code := '%' + code;
      if numero >= 0 then
         code := code + intToStr(numero);
      posPourCent := pos(code, AnsiUpperCase(LigneTexte));
    end;

  var
   j: integer;
   posEt: integer;
   LignePrec: string;
  begin
    LigneTexte := texteLoc[i];
    posCode('X', -1);
    if posPourCent > 0 then
      SetLoc(Fgraphe.monde[mondeX].Axe, x1, 2);
    posCode('Y', -1);
    if posPourCent > 0 then
      SetLoc(Fgraphe.monde[iMonde].Axe, y1, 2);
    posCode('S', -1);
    if posPourCent > 0 then begin
      Delete(LigneTexte, posPourCent, 3);
      Insert(pages[NumeroPage].commentaireP, LigneTexte, posPourCent);
    end;
    for j := 1 to NbreParam[ParamNormal] do begin
      posCode('P', j);
      if posPourCent > 0 then
        SetParam(j,3);
    end;
    for j := 1 to NbreModele do with FonctionTheorique[j] do begin
      posCode('M', j);
      if posPourCent > 0 then begin
         Delete(LigneTexte, posPourCent, 3);
         if ModeleNumerique
         then Insert(expressionNumerique, LigneTexte, posPourCent)
         else begin
         Insert(grandeurs[indexY].nom+'('+grandeurs[indexX].nom+')='+expression, LigneTexte, posPourCent);
         // cdot nécessite Arial Unicode
         // mais les lettres grecques sont atroces
         repeat
               posEt := pos('*',ligneTexte);
               if posEt>0 then ligneTexte[posEt] := pointMedian;
         until posEt=0;
         repeat
               posEt := pos('+',ligneTexte);
               if posEt>0 then  ligneTexte[posEt] := '@';
         until posEt=0;
         repeat
               posEt := pos('@',ligneTexte);
               if posEt>0 then begin
                  delete(ligneTexte,posET,1);
                  insert(' + ',ligneTexte,posEt);
               end;
         until posEt=0;
         end;
         if affichagePrecision
            then with pages[pageCourante] do LignePrec := stSigmaY+
                        addrY.formatNomEtUnite(sigmaY)
            else LignePrec := '';
      end;
    end;
    for j := 1 to NbreModeleGlb do with FonctionTheoriqueGlb[j] do begin
      posCode('M', j+decalageModeleGlb);
      if posPourCent > 0 then begin
         Delete(LigneTexte, posPourCent, 3);
         if ModeleNumerique
         then Insert(expressionNumerique, LigneTexte, posPourCent)
         else begin
         Insert(grandeurs[indexY].nom+'('+grandeurs[indexX].nom+')='+expression, LigneTexte, posPourCent);
         // cdot nécessite Arial Unicode
         // mais les lettres grecques sont atroces
         repeat
               posEt := pos('*',ligneTexte);
               if posEt>0 then ligneTexte[posEt] := pointMedian;
         until posEt=0;
         repeat
               posEt := pos('+',ligneTexte);
               if posEt>0 then  ligneTexte[posEt] := '@';
         until posEt=0;
         repeat
               posEt := pos('@',ligneTexte);
               if posEt>0 then begin
                  delete(ligneTexte,posET,1);
                  insert(' + ',ligneTexte,posEt);
               end;
         until posEt=0;
         end;
      end;
    end;
    for j := 0 to pred(NbreConst) do begin
      posCode('C', j + 1);
      if posPourCent > 0 then
        setLoc(
          Grandeurs[indexConst[j]],
          Pages[NumeroPage].ValeurConst[indexConst[j]], 3);
    end;
    posPourCent := pos('%',LigneTexte);
    if (posPourCent > 0) and
       charInSet(LigneTexte[posPourCent+1],['P','M','C']) then Delete(LigneTexte, posPourCent, 3);
    texteLoc[i] := LigneTexte;
    if lignePrec<>'' then begin
       inc(i);
       TexteLoc.insert(i,lignePrec)
    end;
end; // SetPourCent

procedure TGrapheReg.VersFichier(NomFichier : string);
var extension : string;
begin
  try
     extension := AnsiUpperCase(extractFileExt(nomFichier));
     if extension='' then begin
         nomFichier := ChangeFileExt(nomFichier,'.PNG');
         extension := '.PNG';
     end;
     if extension='.BMP'
        then versBitmap(nomFichier)
        else if extension='.PNG'
             then VersPng(nomFichier)
             else if (extension='.JPG')
                  then VersJpeg(nomFichier)
  except
  end;
end;

procedure TgrapheReg.VersPressePapier(grapheCB : TgrapheClipBoard);
begin
     case grapheCB of
          gcBitmap : VersBitmap('');
          gcJpeg : VersJpeg('');
          gcPng : VersPng('');
     end;
end;

procedure TgrapheReg.getIndexSonagramme(t,f : double;var it,ifreq : integer;var freq : double);
var tmax,tmin : double;
    iMax,k : integer;
begin with courbes[0] do begin
      iMax := NbreSonagramme*nbrePointsSonagrammeAff;
      tmax := valX[imax];
      tmin := valX[0];
      it := round(imax*t/(tmax-tmin)/NbrePointsSonagrammeAff);
      iMax := round(FreqMaxSonagramme/pasFreqSonagramme);
      tmax := valY[iMax];
      tmin := 0;
      ifreq := round(imax*f/(tmax-tmin));
      // pointe sur son[it,ifreq]
      tmax := son[it,ifreq];
      freq := valY[ifreq];
      for k := 1 to 3 do begin
          if (iFreq+k<imax) and (son[it,ifreq+k]>tmax) then begin
             tmax :=  son[it,ifreq+k];
             freq := valY[ifreq+k];
          end;
          if (iFreq-k>0) and (son[it,ifreq-k]>tmax) then begin
             tmax :=  son[it,ifreq-k];
             freq := valY[ifreq-k];
          end;
      end;
end end;

{$I equival}
{$I axes}

end.
