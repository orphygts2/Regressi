unit graphvar;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     Dialogs, ComCtrls, ToolWin, Spin, ImgList, math, system.sysutils,
     system.Types, system.UITypes, system.Contnrs, System.Actions, System.ImageList,
     StdCtrls, Grids, Messages, printers, actnList,
     Vcl.htmlHelpViewer,
     indicateurU, constreg, maths, regutil, uniteKer, statCalc,
     compile, graphKer, modeleGr, aidekey, GripSplitter,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     Vcl.Buttons, Vcl.BaseImageCollection, Vcl.ImageCollection,
     Vcl.VirtualImageList;

type
  TnbreGraphe = (UnGr,DeuxGrVert,DeuxGrHoriz);

  TFgrapheVariab = class(TForm)
    PanelModele: TPanel;
    PaintBox2: TPaintBox;
    PanelAjuste: TPanel;
    MenuAxes: TPopupMenu;
    CoordonneesItem: TMenuItem;
    identifierPagesItemA: TMenuItem;
    PopupMenuModele: TPopupMenu;
    FermerItem: TMenuItem;
    TableauXYItem: TMenuItem;
    ViderXYItem: TMenuItem;
    MemoModeleGB: TGroupBox;
    ResultatGB: TGroupBox;
    HeaderXY: TStatusBar;
    TitreModeleItem: TMenuItem;
    PanelCentral: TPanel;
    BornesMenu: TPopupMenu;
    Inter1: TMenuItem;
    Inter2: TMenuItem;
    Inter3: TMenuItem;
    Inter4: TMenuItem;
    RazBornes: TMenuItem;
    ResidusItem: TMenuItem;
    SaveDialog: TSaveDialog;
    MenuDessin: TPopupMenu;
    DessinSupprimerItem: TMenuItem;
    ProprietesDessin: TMenuItem;
    memoResultat: TRichEdit;
    PanelPrinc: TPanel;
    PanelBis: TPanel;
    PanelAnimation : TPanel;
    DebutBtn: TSpeedButton;
    RetourRapideBtn: TSpeedButton;
    RetourBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    AvanceBtn: TSpeedButton;
    AvanceRapideBtn: TSpeedButton;
    FinBtn: TSpeedButton;
    GroupBox6: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    BoucleCB: TCheckBox;
    TraceCB: TCheckBox;
    LabelTempsAnim: TLabel;
    TitreAnimCB: TCheckBox;
    OptionsAnimBtn: TSpeedButton;
    LignePointCB: TCheckBox;
    RaZModele: TMenuItem;
    SaveParamItem: TMenuItem;
    ParamScrollBox: TScrollBox;
    Panel1: TPanel;
    AjusteBtn: TSpeedButton;
    Panel10: TPanel;
    MoinsRapideBtn: TSpeedButton;
    MoinsBtn: TSpeedButton;
    PlusRapideBtn: TSpeedButton;
    PlusBtn: TSpeedButton;
    SigneBtn: TSpeedButton;
    EditValeur10: TEdit;
    TimerAnim: TTimer;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Edit1: TEdit;
    Panel4: TPanel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Edit2: TEdit;
    Panel5: TPanel;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    Edit3: TEdit;
    Panel6: TPanel;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    Edit4: TEdit;
    Panel7: TPanel;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    Edit5: TEdit;
    Panel8: TPanel;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    Edit6: TEdit;
    Panel9: TPanel;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    Edit7: TEdit;
    Panel11: TPanel;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    Edit8: TEdit;
    PanelParam1: TPanel;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    EditValeur1: TEdit;
    TraceAutoCB: TCheckBox;
    RepeatTimer: TTimer;
    NbreTickBar: TTrackBar;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    AffIncertBis: TMenuItem;
    OptionsModeleItem: TMenuItem;
    ModeleToolBar: TToolBar;
    OptionsModeleBtn: TToolButton;
    ModeleGrBtn: TToolButton;
    BornesBtn: TToolButton;
    InitEquaDiffBtn: TToolButton;
    ToolBarGraphe: TToolBar;
    CurseurBtn: TToolButton;
    CoordonneesBtn: TToolButton;
    NGraphesBtn: TToolButton;
    CopierBtn: TToolButton;
    Separe2: TToolButton;
    AnimBtn: TToolButton;
    VecteursBtn: TToolButton;
    CurseurMenu: TPopupMenu;
    SelectItem: TMenuItem;
    CurTexteItem: TMenuItem;
    CurLigneItem: TMenuItem;
    CurGommesItem: TMenuItem;
    CurReticuleItem: TMenuItem;
    curDataItem: TMenuItem;
    CurTangenteItem: TMenuItem;
    CurOrigineItem: TMenuItem;
    CurModeleItem: TMenuItem;
    AnimationMenu: TPopupMenu;
    AnimationNone: TMenuItem;
    AnimationTemps: TMenuItem;
    AnimationParam: TMenuItem;
    HelpAnimBtn: TSpeedButton;
    MenuIndicateur: TPopupMenu;
    NgraphesMenu: TPopupMenu;
    UngrapheItem: TMenuItem;
    DeuxGraphesVert: TMenuItem;
    DeuxGraphesHoriz: TMenuItem;
    PaintBox3: TPaintBox;
    Bevel: TBevel;
    GroupBox7: TGroupBox;
    TrackBar7: TTrackBar;
    GroupBox8: TGroupBox;
    TrackBar8: TTrackBar;
    LabelY: TLabel;
    LabelX: TLabel;
    CornishBtn: TToolButton;
    ModelePagesIndependantesMenu: TMenuItem;
    memoModele: TRichEdit;
    SavePosItem: TMenuItem;
    ProprieteCourbe: TMenuItem;
    RandomBtn: TToolButton;
    TimerModele: TTimer;
    IntersectionItem: TMenuItem;
    ToolBarGrandeurs: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    VecteursMenu: TPopupMenu;
    VitesseItem: TMenuItem;
    AccelerItem: TMenuItem;
    VitesseAccItem: TMenuItem;
    NoVecteursItem: TMenuItem;
    SplitterModele: TGripSplitter;
    IdentifierPagesItemN: TMenuItem;
    CurReticuleModeleItem: TMenuItem;
    OptionsItem: TMenuItem;
    FildeferItem: TMenuItem;
    TrigoBtn: TToolButton;
    EnregistrerGrapheItem: TMenuItem;
    Imprimergraphe1: TMenuItem;
    ImprimeModeleItem: TMenuItem;
    MajBtn: TSpeedButton;
    ZoomAutoBtn: TToolButton;
    ZoomAvBtn: TToolButton;
    ZoomArBtn: TToolButton;
    ZoomManuelBtn: TToolButton;
    Separe1: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    LabelDeltaX: TLabel;
    LabelDeltaY: TLabel;
    VideoTrackBar: TTrackBar;
    MenuReticule: TPopupMenu;
    tableauXYItemBis: TMenuItem;
    ViderXYItemBis: TMenuItem;
    SavePosItemBis: TMenuItem;
    FinReticuleItem: TMenuItem;
    intersectionTer: TMenuItem;
    TimerSizing: TTimer;
    CopyMenu: TPopupMenu;
    metafile2: TMenuItem;
    bitmap2: TMenuItem;
    Jpeg2: TMenuItem;
    Png1: TMenuItem;
    addModeleItem: TMenuItem;
    TrigoLabel: TLabel;
    GroupBox9: TGroupBox;
    TrackBar9: TTrackBar;
    ModeleItem: TMenuItem;
    ResidusItemBis: TMenuItem;
    N1: TMenuItem;
    ModeleSepare: TMenuItem;
    clipEPSitem: TMenuItem;
    PaintBox1: TPaintBox;
    IncertChi2Item: TMenuItem;
    AffIncert: TMenuItem;
    IncertBtn: TToolButton;
    IdentifierPagesItemC: TMenuItem;
    ActionList1: TActionList;
    IdentAction: TAction;
    GroupBox10: TGroupBox;
    TrackBar10: TTrackBar;
    GroupBox11: TGroupBox;
    TrackBar11: TTrackBar;
    GroupBox12: TGroupBox;
    TrackBar12: TTrackBar;
    GroupBox13: TGroupBox;
    TrackBar13: TTrackBar;
    CurseurGrid: TStringGrid;
    ModeleBtn: TToolButton;
    ModeleMenu: TPopupMenu;
    LineaireItem: TMenuItem;
    AffineItem: TMenuItem;
    EchelonItem: TMenuItem;
    RadioItem: TMenuItem;
    ParaboleItem: TMenuItem;
    ModelesAutresItem: TMenuItem;
    SauverModeleItem: TMenuItem;
    AbscisseCB: TComboBox;
    LabelToolBar: TLabel;
    ProprieteCourbeBis: TMenuItem;
    MonteCarloItem: TMenuItem;
    hintResultatLabel: TLabel;
    LabelDistance: TLabel;
    ImageCollection1: TImageCollection;
    ImageList1: TVirtualImageList;
    OptionsItemBis: TMenuItem;
    Enregistrergraphe1: TMenuItem;
    CurReticuleDataNewItem: TMenuItem;
    ViderTangenteItem: TMenuItem;
    ResidusNormalisesCB: TCheckBox;
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ZoomAvantItemClick(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CoordonneesItemClick(Sender: TObject);
    procedure ZoomAutoItemClick(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure AjusteBtnClick(Sender: TObject);
    procedure MemoModeleChange(Sender: TObject);
    procedure ZoomArriereItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure ValideParam(paramCourant : integer;maj : boolean);
    procedure ValeursParamKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure ZoomManuelItemClick(Sender: TObject);
    procedure CopierModeleItemClick(Sender: TObject);
    procedure InitEquaDiffBtnClick(Sender: TObject);
    procedure MemoResultatKeyPress(Sender: TObject; var Key: Char);
    procedure MenuAxesPopup(Sender: TObject);
    procedure TableauXYItemClick(Sender: TObject);
    procedure ModelGrClick(Sender: TObject);
    procedure ViderXYItemClick(Sender: TObject);
    procedure TraceAutoBtnClick(Sender: TObject);
    procedure MemoModeleClick(Sender: TObject);
    procedure MajBtnClick(Sender: TObject);
    procedure ImprimeGrItemClick(Sender: TObject);
    procedure MemoModeleKeyPress(Sender: TObject; var Key: Char);
    procedure BornesClick(Sender: TObject);
    procedure BornesMenuPopup(Sender: TObject);
    procedure RazBornesClick(Sender: TObject);
    procedure ResidusItemClick(Sender: TObject);
    procedure ImprModeleBtnClick(Sender: TObject);
    procedure BornesDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DessinDeleteItemClick(Sender: TObject);
    procedure DessinOptionsItemClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure identifierPages(Sender: TObject);
    procedure HelpAnimBtnClick(Sender: TObject);
    procedure TimerAnimTimer(Sender: TObject);
    procedure DebutBtnClick(Sender: TObject);
    procedure RetourRapideBtnClick(Sender: TObject);
    procedure FinBtnClick(Sender: TObject);
    procedure AvanceRapideBtnClick(Sender: TObject);
    procedure AvanceBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure RetourBtnClick(Sender: TObject);
    procedure AnimSliderChange(Sender: TObject);
    procedure PanelCourbeResize(Sender: TObject);
    procedure GroupBoxAnimClick(Sender: TObject);
    procedure GroupBoxAnimDblClick(Sender: TObject);
    procedure TitreAnimCBClick(Sender: TObject);
    procedure OptionsAnimBtnClick(Sender: TObject);
    procedure RaZModeleClick(Sender: TObject);
    procedure SaveParamItemClick(Sender: TObject);
    procedure EditValeurExit(Sender: TObject);
    procedure EditValeurKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditValeurKeyPress(Sender: TObject; var Key: Char);
    procedure MoinsRapideBtnClick(Sender: TObject);
    procedure MoinsBtnClick(Sender: TObject);
    procedure PlusBtnClick(Sender: TObject);
    procedure PlusRapideBtnClick(Sender: TObject);
    procedure SigneBtnClick(Sender: TObject);
    procedure ModifParam(paramCourant : integer;coeff : double);
    procedure ParamBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParamBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RepeatTimerTimer(Sender: TObject);
    procedure OrigineBtnClick(Sender: TObject);
    procedure VecteursItemClick(Sender: TObject);
    procedure OptionsModeleBtnClick(Sender: TObject);
    procedure ChoixCurseurClick(Sender: TObject);
    procedure AnimationNoneClick(Sender: TObject);
    procedure AnimationTempsClick(Sender: TObject);
    procedure AnimationParamClick(Sender: TObject);
    procedure CurseurBtnClick(Sender: TObject);
    procedure AnimationMenuPopup(Sender: TObject);
    procedure LabelYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MenuIndicateurPopup(Sender: TObject);
    procedure DeuxGraphesVertClick(Sender: TObject);
    procedure PaintBoxClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ModelisationItemClick(Sender: TObject);
    procedure FermerItemClick(Sender: TObject);
    procedure SavePosItemClick(Sender: TObject);
    procedure ProprieteCourbeClick(Sender: TObject);
    procedure RandomBtnAnimClick(Sender: TObject);
    procedure PopupMenuModelePopup(Sender: TObject);
    procedure RandomBtnClick(Sender: TObject);
    procedure TimerModeleTimer(Sender: TObject);
    procedure PaintBox2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CurseurMenuPopup(Sender: TObject);
    procedure OptionsItemClick(Sender: TObject);
    procedure VecteursMenuPopup(Sender: TObject);
    procedure FildeferItemClick(Sender: TObject);
    procedure TrigoBtnClick(Sender: TObject);
    procedure EnregistrerGrapheItemClick(Sender: TObject);
    procedure CurseurGridEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure VideoTrackBarChange(Sender: TObject);
    procedure FinReticuleItemClick(Sender: TObject);
    procedure MenuReticulePopup(Sender: TObject);
    procedure IntersectionItemClick(Sender: TObject);
    procedure TimerSizingTimer(Sender: TObject);
    procedure metafile2Click(Sender: TObject);
    procedure addModeleItemClick(Sender: TObject);
    procedure ModeleItemClick(Sender: TObject);
    procedure PanelModeleResize(Sender: TObject);
    procedure IncertChi2ItemClick(Sender: TObject);
    procedure ResidusNormalisesCBClick(Sender: TObject);
    procedure AffIncertClick(Sender: TObject);
    procedure IncertBtnClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ModeleBtnClick(Sender: TObject);
    procedure LineaireItemClick(Sender: TObject);
    procedure AffineItemClick(Sender: TObject);
    procedure EchelonItemClick(Sender: TObject);
    procedure ParaboleItemClick(Sender: TObject);
    procedure RadioItemClick(Sender: TObject);
    procedure SauverModeleItemClick(Sender: TObject);
    procedure AbscisseCBClick(Sender: TObject);
    procedure ToolButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure MonteCarloItemClick(Sender: TObject);
    procedure memoResultatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ViderTangenteItemClick(Sender: TObject);
   // procedure Convergence(Sender: TObject);
  private
      Sizing : boolean;
      MonteCarloActif : boolean;
      grandeurBoutonDroit : boolean; // clic sur TButton avec bouton droit
      oldCursorPos : Tpoint;
      mouseMoving : boolean;
      indexPointCourant : integer;
      iPropCourbe : integer;
      courbePointCourant : integer;
      ValeursParamChange : boolean;
      InitiationAfaire : boolean;
      GrapheCourant,GrapheResidu : TgrapheReg;
      indexGrCourant : integer;
      selectEqCourant : TselectEquivalence;
      IndexPointModeleGr : integer;
      IndexModeleGr : integer;
      Curseur : Tcurseur;
      zoneZoom : Trect;
      EntreeValidee : boolean;
      nbreGraphe : TnbreGraphe;
      derf : TmatriceFonction; // Dérivées premières / aux paramètres
      erreurCalcul,erreurParam : boolean;
      BorneSelect : Tborne;
      verifGraphe : boolean;
      xOrigine : double;
      dXresidu,dYresidu : Tvecteur;
      BorneActive : TcodeIntervalle;
      ValeurDeriveeX,ValeurYDiff,ValeurYpDiff : TvecteurExtrapole;
      ModeleCalc : array[TcodePage] of boolean; // tampon pour mise à jour fichier
      ValeurXDiff : Tvecteur;
      IsModeleSysteme : boolean;
      IsModeleMagnum : boolean;
      DeltaXcadre,DeltaYcadre : integer; // écart Pointeur souris centre du cadre
      MajModelePermis : boolean;
      editValeur : array[TcodeParam] of Tedit;
      panelParam : array[TcodeParam] of Tpanel;
      TimerButton : TSpeedButton;
      OldPlacement : TWindowPlacement;
      CurMovePermis : boolean;
      Ydrag : integer;
      orthoAverifier : boolean;
      xCurseur,yCurseur : integer;
      Effaces : boolean;
      XorigineInt : integer;
      hintMemoResultat : TStringList;
// gesture
      panEffect : TpanEffect;
      FLastDistance : integer;
      debutZoom : Tpoint;
      panEnCours : boolean;
// Animation
      ModifMonde : boolean;
      Avance : boolean;
      ClearGrapheAnim : boolean;
      ActiverTimerAnim : boolean;
      tempsCourant,debutTemps,finTemps,pasTemps : double;
      codeTemps : integer;
      InitManuelleAfaire : boolean;
      ParamAnimCourant : integer;
      ParamEditCourant : integer;
// Fin data animation
   //   suiteValeurParam : array[1..2] of array[0..maxValeurParam] of double;
   //   NbreSuiteValeurParam : integer;
// pour tracé de convergence de modélisation
      prevenirTri : boolean;
      procedure SetAnimTemporelle;
      Procedure SetAnimManuelle;
      procedure CalculeAnimTemporelle;
      procedure CalculeAnimManuelle;
      procedure AfficheAnimationManuelle;
      procedure AfficheAnimationTemporelle;
      procedure paramPrecedent;
      procedure paramSuivant;
      procedure SetCoordAnim;
      Procedure ModifGraphe(indexGr : integer);
      procedure AddCourbesAnim;
      procedure CacheAnim;
// Fin procedure animation
      Procedure VerifCoordonnee(indexGr : integer);
      procedure SetPenBrush(c : Tcurseur);
      procedure MajParametres;
      Procedure LanceModele(ajuste : boolean);
      procedure CompileModele(var PosErreur,LongErreur : integer);
      procedure ConstruitModele;
      procedure SetUniteParametre;
      Procedure CalcIntersection;
      Procedure EffectueModele(Ajuste : boolean);
      Procedure EffectueModeleMono(m : integer);
      Procedure LanceCompile;
      Procedure EffectueCompile;
      Procedure MajModeleGr(NumeroGr : integer);
      Procedure InitCurseurModele;
      procedure TraceCurseurCourant(indexGr : integer);
      procedure setPointCourant(i,c : integer);
      Procedure ResetHeaderXY;
      procedure ModeleMagnum(indiceCoord : integer;direct : boolean);
      procedure MajIdentPage;
      procedure MajIdentCoord(indexGr : integer);
      procedure verifParametres;
      procedure AjustePanelModele;
      procedure IndicateurClick(Sender: TObject);
      procedure SetCoordonneeResidu;
      procedure SetBoutonAnim(actif : boolean);
      procedure AffecteModele(indexGr : integer);
      procedure ZoomSuperpose(indexGr : integer);
      procedure ZoomModele(indexGr : integer);
      procedure SetTaillePolice;
      procedure SetPanelModele(avecModele : boolean);
      procedure SetPanelParam;
      procedure SetParamEdit;
      procedure setModeleGR(index : TgenreModeleGr);
      procedure identPages;
      procedure AffecteEfface(x,y : integer);
      procedure AffecteBorne;
      procedure AffecteBornes(x,y : integer);
      procedure AffecteDeplace(x,y : integer);
      procedure verifTri;
      procedure ToucheEspace;
      procedure MajResultat;
  protected
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
      procedure WMRegCalcul(var Msg : TWMRegMessage); message WM_Reg_Calcul;
      procedure WMRegModele(var Msg : TWMRegMessage); message WM_Reg_Modele;
      procedure WMRegOrigine(var Msg : TWMRegMessage); message WM_Reg_Origine;
      procedure WMRegInitMagnum(var Msg : TWMRegMessage); message WM_Reg_InitMagnum;
      procedure WMRegAnimation(var Msg : TWMRegMessage); message WM_Reg_Animation;
      procedure WMSizing(var Msg: Tmessage); message WM_Sizing;
// WM_Size ... sent repeatedly while window edges are dragged
// WM_Sizing ... sent once at the beginning of a sizing event
// WM_LButtonUp ... sent when the user releases the mouse button
  public
      Graphes : array[1..3] of TgrapheReg;
      configCharge,majFichierEnCours : boolean;
      etatModele : TsetEtatModele;
      nbrePasAnim : integer;
      varYPos,varXPos : Tgrandeur;
      mesureDelta : boolean;
      Procedure SetCoordonnee(indexGr : integer);
      procedure EcritConfig;
      procedure LitConfig;
      procedure EcritConfigXML(ANode : IXMLNOde);
      procedure LitConfigXML(ANode : IXMLNOde);
      procedure CalculCurseurModele;
      procedure ImprimerGraphe(var bas : integer);
      procedure VersLatex(const NomFichier : string);
      procedure MajResultatLatex(p : TcodePage);
  end;

var FgrapheVariab : TFgrapheVariab;

implementation

uses
     zoomMan, ClipBrd, fspec,
     choixModele, curModel, regmain, cursData, options,
     systDiff, identPagesU, Regdde,
     SaveParam, ChoixParamAnim, 
     CoordPhys, ChoixTang, Graphfft, Valeurs,
     OrigineU, optModele, savePosition, PropCourbe,
     optionsvitesse, modif, latex, OptionsAffModeleU, savemodele;

{$R *.DFM}


{$I modele.pas}
{$I modeleMono.pas}

const
   CoeffParam = 1.023;
   CoeffParamRapide = 2;
   InitRepeatPause = 400; // pause before repeat timer (ms)
   RepeatPause     = 100; // pause before hint window displays (ms)
   NcurseurModeleMax = 16;
   IncertNobitmap = 54;
   IncertYesbitmap = 52;
   grResidu = 3;

var
   courbeModele : Tcourbe;
   indexCourbeModele : integer;

 procedure TFgrapheVariab.VersLatex(const NomFichier : string);
 var i : integer;
 begin
     for i := 1 to 3 do
         if graphes[i].paintBox.visible and graphes[i].grapheOK then
            graphes[i].versLatex(NomFichier,char(ord('0')+i));
end;

Procedure TfgrapheVariab.InitCurseurModele;
begin
   pages[pageCourante].affecteConstParam(true);
   ligneRappelCourante := lrXdeY;
   graphes[1].RemplitTableauEquivalence;
   if curseurModeleDlg=nil then
      curseurModeleDlg := TcurseurModeleDlg.create(self);
   curseurModeleDlg.show; // showModal ?
end;

Procedure TfgrapheVariab.CalculCurseurModele;
var xr,yr : double;
    LindexCourbe : integer;

procedure chercheCourbe;
var i : integer;
begin
   LindexCourbe := -1;
   if (curseur=curReticuleDataNew)
       then LindexCourbe := graphes[1].curseurOsc[curseurData1].indexCourbe
       else for i := 0 to graphes[1].courbes.Count-1 do
         if (trLigne in graphes[1].courbes[i].trace) and
            (graphes[1].courbes[i].page=pageCourante) then begin
                   LindexCourbe := i;
                   break;
         end;
end;

Procedure AffecteCurseurModele;
var NewEquivalence : Tequivalence;
    i : integer;
begin with graphes[1],CurseurModeleDlg do
  if (LigneXdeY-2)>=equivalences[pageCourante].count
    then begin
       NewEquivalence := Tequivalence.Create(0,0,0,0,xr,yr,0,graphes[1]);
       NewEquivalence.ligneRappel := lrXdeY;
       equivalences[pageCourante].Add(NewEquivalence);
       with Tableau do
            if ligneXdeY=pred(rowCount) then begin
                rowCount := rowCount+1;
                for i := 0 to 2 do cells[i,pred(rowCount)] := '';
                row := rowCount-1;
            end;
    end
    else begin
       NewEquivalence := equivalences[pageCourante].items[LigneXdeY-2];
       NewEquivalence.ve := xr;
       NewEquivalence.ligneRappel := lrXdeY;
       NewEquivalence.pHe := yr;
    end;
  paintBox1.invalidate;
end;

Function CalculExp(expr : string) : double;
var posErreur,longErreur : integer;
    i : integer;
begin
   if expr=''
     then result := Nan
     else begin
        PrevenirFonctionDeParam := false;
        for i := 2 to length(expr)-1 do begin
            if (expr[i]=',') and
                charInSet(expr[i-1],['0'..'9']) and
                charInSet(expr[i+1],['0'..'9'])
                then expr[i] := '.';
        end;
        grandeurImmediate.fonct.expression := expr;
        if grandeurImmediate.fonct.compileF(posErreur,longErreur,false,paramNormal,0)
           then begin
              try
              result := calcule(grandeurImmediate.fonct.calcul);
              except
              result := Nan;
              end;
           end
           else result := Nan
     end;
end;

procedure InterpoleX;
var distanceMin,distance : integer;
    i : integer;
    xi,yi : integer;
    Lyr : double;
begin
          chercheCourbe;
          if LindexCourbe<0 then exit;
          xr := 1;
          yr := calculExp(curseurModeleDlg.tableau.cells[1,curseurModeleDlg.ligneXdeY]);
          with graphes[1].courbes[LindexCourbe] do begin
               if finE>0 then begin
                 graphes[1].windowRT(xr, yr,graphes[1].courbes[LindexCourbe].imondeC,xi, yi);
                 distanceMin := 16;
                 for i := 0 to finE-1 do begin
                    distance := abs(yi - valYe[i]);
                    if distance < distanceMin then begin
                       distanceMin := distance;
                       xi := valXe[i];
                    end;
                 end;
                 graphes[1].mondeRT(xi, yi,graphes[1].courbes[LindexCourbe].imondeC,xr, Lyr);
                 curseurModeleDlg.tableau.cells[0,curseurModeleDlg.ligneXdeY] := FormatReg(xr);
               end
               else begin
                    xr := Nan;
                    curseurModeleDlg.tableau.cells[0,curseurModeleDlg.ligneXdeY] := '?';
               end;
          end;
end;

procedure InterpoleModeles;

function InterpoleModele(iC : integer) : boolean;
var i,i1 : integer;
    ecartY,deltaY,deltaX : double;
begin
       result := false;
       LindexCourbe := iC;
       courbeModele := graphes[1].courbes[iC];
       i := graphes[1].pointProcheReal(xr,yr,courbeModele,courbeModele.imondeC);
       if i<0 then exit;
       ecartY := yr-courbeModele.valY[i];
       if i<courbeModele.finC then i1 := succ(i) else i1 := pred(i);
       deltaY := courbeModele.valY[i1]-courbeModele.valY[i];
       deltaX := courbeModele.valX[i1]-courbeModele.valX[i];
       try
          xr := courbeModele.valX[i]+deltaX*ecartY/deltaY;
       except
          xr := courbeModele.valX[i];
       end;
       curseurModeleDlg.tableau.cells[0,curseurModeleDlg.ligneXdeY] := FormatReg(xr);
       result := true;
end;

var i : integer;
    iModele : shortInt;
begin
     yr := calculExp(curseurModeleDlg.tableau.cells[1,curseurModeleDlg.ligneXdeY]);
     xr := Nan;
     if nbreModele=1
        then InterpoleModele(indexCourbeModele)
        else begin
             for i := 0 to pred(graphes[1].courbes.count) do begin
                 iModele := graphes[1].courbes[i].indexModele;
                 if (iModele>0) and InterpoleModele(i) then begin
                     if (xr>courbeModele.varX.valeur[pages[pageCourante].Debut[iModele]]) and
                        (xr<courbeModele.varX.valeur[pages[pageCourante].Fin[iModele]])
                     then begin
                          indexCourbeModele := i;
                          break;
                     end;
                 end;
             end;
        end;
end;

procedure InterpoleY;
var distanceMin,distance : integer;
    i : integer;
    xi,yi : integer;
    Lxr : double;
begin
          chercheCourbe;
          if LindexCourbe<0 then exit;
          yr := 1;
          xr := calculExp(curseurModeleDlg.tableau.cells[0,curseurModeleDlg.ligneXdeY]);
          graphes[1].windowRT(xr, yr,graphes[1].courbes[LindexCourbe].imondeC,xi, yi);
          distanceMin := 16;
          with graphes[1].courbes[LindexCourbe] do begin
             for i := 0 to finE-1 do begin
                 distance := abs(xi - valXe[i]);
                 if distance < distanceMin then begin
                    distanceMin := distance;
                    yi := valYe[i];
                 end;
             end;
          end;
          graphes[1].mondeRT(xi, yi,graphes[1].courbes[LindexCourbe].imondeC,Lxr, yr);
          curseurModeleDlg.tableau.cells[1,curseurModeleDlg.ligneXdeY] := FormatReg(yr);
end;

procedure CalculModeles;

procedure CalculModele(iC : integer;im : TcodeIntervalle);
var Lxr : double;
    grX,grY : Tgrandeur;
begin
         LindexCourbe := iC;
         courbeModele := graphes[1].courbes[iC];
         grY := courbeModele.varY;
         grX := courbeModele.varX;
         Lxr := xr;
         if uniteSIGlb and (grX.puissance<>0) then Lxr := Lxr*grX.coeffSI;
         grandeurs[fonctionTheorique[im].indexX].valeurCourante := Lxr;
         yr := calcule(fonctionTheorique[im].calcul);
         if uniteSIGlb and (grY.puissance<>0) then yr := yr/grY.coeffSI;
         curseurModeleDlg.tableau.cells[1,curseurModeleDlg.ligneXdeY] := FormatReg(yr);
end;

var i : integer;
    iModele : shortInt;
begin
     xr := calculExp(curseurModeleDlg.tableau.cells[0,curseurModeleDlg.ligneXdeY]);
     if nbreModele=1
        then calculModele(indexCourbeModele,1)
        else begin
             for i := 0 to pred(graphes[1].courbes.count) do begin
                 iModele := graphes[1].courbes[i].indexModele;
                 if (iModele>0) then begin
                     CalculModele(i,iModele);
                     if (xr>courbeModele.varX.valeur[pages[pageCourante].Debut[iModele]]) and
                        (xr<courbeModele.varX.valeur[pages[pageCourante].Fin[iModele]])
                     then begin
                          indexCourbeModele := i;
                          break;
                     end;
                 end;
             end;
        end;
end;

begin with curseurModeleDlg do begin
    if (nbreModele=0) or (indexCourbeModele<0)
    then if isEquation
        then interpoleX  // on a donné y
        else interpoleY  // on a donné x
    else if isEquation
       then interpoleModeles
       else calculModeles;
    if (LindexCourbe>=0) and not(iSNan(xr)) then affecteCurseurModele;
end end; // CalculCurseurModele 

procedure TFgrapheVariab.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);

procedure AffichePosition;
var Xr,Yr : double;
    YNom,YVal,XNom,XVal : string;
    icourbe : integer;
    x0,y0 : integer;
begin with GrapheCourant do begin
    if not(monde[mondeX].defini) then exit;
    iCourbe := courbeProche(x,y);
    if iCourbe<0 then
       if courbes.count>0
          then iCourbe := 0
          else exit;
    with courbes[iCourbe] do begin
       if curseur=curReticuleDataNew
          then begin
             xr := curseurOsc[curseurData1].xr;
             yr := curseurOsc[curseurData1].yr;
          end
          else MondeRT(x,y,iMondeC,xr,yr);
       ValeurCurseur[coX] := xr;
       ValeurCurseur[coY] := yr;
       varYPos := varY;
       varXPos := varX;
       if varY<>nil then YNom := varY.nom else YNom := monde[imondeC].axe.nom;
       if varX<>nil then XNom := varX.nom else XNom := monde[mondeX].axe.nom;
       if monde[iMondeC].graduation=gdB
         then begin
            yr := 20*log10(yr);
            if (varY<>nil) and (curseur=curReticule) then begin
               curseurOsc[1].grandeurCurseur := varY;
               curseurOsc[1].mondeC := iMondeC;
            end;
            YVal := FloatToStrF(Yr,ffGeneral,3,0)+' dB';
         end
         else if varY<>nil
            then YVal := varY.formatValeurEtUnite(Yr)
            else YVal := monde[iMondeC].axe.formatValeurEtUnite(Yr);
       if varX<>nil
          then XVal := varX.formatValeurEtUnite(Xr)
          else XVal := monde[mondeX].axe.formatValeurEtUnite(Xr);
    end;
    if curseur in [curReticule,curReticuleDataNew] then begin
        labelX.transparent := false;
        labelY.transparent := false;
        labelX.caption := XNom+'='+XVal+' ';
        labelY.caption := YNom+'='+YVal+' ';
        if curseur=curReticuleDataNew then begin
           x := curseurOsc[curseurData1].xc;
           y := curseurOsc[curseurData1].yc;
        end;
        if OgPolaire in OptionGraphe
          then begin
               windowRT(0,0,courbes[iCourbe].imondeC,x0,y0);
               labelX.top := y0-round(rayonArcAngle*sin(xr/2));
               labelY.top := (y+y0) div 2;
               labelY.left := (x+x0) div 2;
               labelX.left := x0+round(rayonArcAngle*cos(xr/2));
          end
          else begin
            labelX.top := limiteFenetre.top+5+hautCarac;
            labelY.top := y-8;
            labelY.left := limiteFenetre.left+5;
            labelX.left := x-(labelX.width div 2);
          end;
     end
     else begin
        ResetHeaderXY;
        AffecteStatusPanel(HeaderXY,1,XNom+'='+XVal);
        AffecteStatusPanel(HeaderXY,2,YNom+'='+YVal);
     end;
     if curseurGrid.visible then begin
           CurseurGrid.cells[0,0] := XNom;
           CurseurGrid.cells[0,1] := YNom;
           CurseurGrid.cells[1,0] := XVal;
           CurseurGrid.cells[1,1] := YVal;
           CurseurGrid.RowCount := 4;
           CurseurGrid.Height := 4*CurseurGrid.defaultRowHeight+4;
      end;
end end; // AffichePosition

procedure AfficheResidu;
var i : integer;
    ecart,ref95,residu : double;
    XX,YY,titre : string;
begin with pages[pageCourante],GrapheCourant do begin
    if not(monde[mondeX].defini) then exit;
    i := pointProche(x,y,indexCourbeModele,true,false);
    if (i<debut[1]) or (i>fin[1]) then exit;
    XX := '';
try
    if courbes[indexCourbeModele].IncertY<>nil
       then begin
          ecart := courbes[indexCourbeModele].incertY[i];
          ecart := (valeurVar[fonctionTheorique[1].indexY,i]-valeurTheorique[1,i])/ecart;
          YY := stEcart+FloatToStrF(ecart,ffGeneral,3,1)+' * '+stIncertitude;
       end
       else if modeleCalcule and fonctionTheorique[1].residuStat.statOK
          then begin
             ref95 := fonctionTheorique[1].residuStat.t95;
             if fonctionTheorique[1].residuStat.avecIncert
                then residu := fonctionTheorique[1].residuStat.residusNormalises[i-debut[1]]
                else residu := fonctionTheorique[1].residuStat.residus[i-debut[1]];
             if residusNormalisesCB.checked and fonctionTheorique[1].residuStat.avecIncert
                then titre := stResidusNormalises
                else titre := stResidus;
             XX := titre+FloatToStrF(residu,ffGeneral,3,1)+
                   stLimiteStudent95+FloatToStrF(ref95,ffGeneral,3,1)+')';
             ecart := valeurVar[fonctionTheorique[1].indexY,i]-valeurTheorique[1,i];
             YY := stEcart+FloatToStrF(ecart,ffGeneral,3,1);
          end
          else begin
             ecart := valeurVar[fonctionTheorique[1].indexY,i]-valeurTheorique[1,i];
             YY := stEcart+FloatToStrF(ecart,ffGeneral,3,1);
          end;
except
      YY := '';
end;
    AffecteStatusPanel(HeaderXY,0,YY);
    AffecteStatusPanel(HeaderXY,1,XX);
end end; // AfficheResidu

procedure AfficheResiduGr;
const inegaliteResidu : array[boolean] of string = ('<','>');
var i : integer;
    ecart,ref95,residu : double;
    XX,YY,titre : string;
begin with pages[pageCourante],GrapheCourant do begin
    if not(monde[mondeX].defini) then exit;
    i := pointProche(x,y,0,true,false);
    if (i<0) then exit;
    XX := '';
try
    if modeleCalcule and fonctionTheorique[1].residuStat.statOK
          then begin
             ref95 := fonctionTheorique[1].residuStat.t95;
             if fonctionTheorique[1].residuStat.avecIncert
                then residu := fonctionTheorique[1].residuStat.residusNormalises[i]
                else residu := fonctionTheorique[1].residuStat.residus[i];
             if fonctionTheorique[1].residuStat.avecIncert
                then titre := stResiduNormalise
                else titre := stResidu;
             XX := titre+FloatToStrF(residu,ffGeneral,3,1)+
                   inegaliteResidu[residu<ref95]+
                   FloatToStrF(ref95,ffGeneral,3,1)+stLimiteStudent95;
             ecart := fonctionTheorique[1].residuStat.residus[i];
             YY := stEcart+FloatToStrF(ecart,ffGeneral,3,1);
          end
          else YY := ''
except
      YY := '';
end;
    AffecteStatusPanel(HeaderXY,0,YY);
    AffecteStatusPanel(HeaderXY,1,XX);
end end; // AfficheResiduGr

procedure AfficheDelta;
var Xval,Yval,Xnom,Ynom : string;
    dX : double;
    margeCarac : integer;
begin with GrapheCourant,curseurOsc[1] do begin
    if not(monde[mondeX].defini) or not(monde[mondeC].defini) then exit;
    case monde[mondeC].graduation of
         gdB : begin
            dX := 20*log10(curseurOsc[2].yr/yr);
            YNom := deltaMaj+monde[curseurOsc[1].mondeC].Axe.nom;
            YVal := floatToStrF(dX,ffGeneral,3,0)+' dB';
         end;
         gLog : begin
            dX := curseurOsc[2].yr/yr;
            YNom := '÷'+monde[mondeC].Axe.nom;
            YVal := floatToStrF(dX,ffGeneral,3,0);
         end;
         else begin
             dX := curseurOsc[2].yr-yr;
             YNom := deltaMaj+monde[mondeC].Axe.nom;
             YVal := monde[mondeC].Axe.formatValeurEtUnite(dX);
         end;
    end;
    valeurCurseur[coDeltay] := dX;
    if monde[mondeX].graduation=gLog
       then begin
            dX := curseurOsc[2].xr-xr;
            XNom := '÷'+monde[mondeX].Axe.nom;
            XVal := floatToStrF(dX,ffGeneral,3,0);
       end
       else begin
           dX := curseurOsc[2].xr-xr;
           XNom := deltaMaj+monde[mondeX].Axe.nom;
           XVal := monde[mondeX].Axe.formatValeurEtUnite(dX);
       end;
    ValeurCurseur[coDeltax] := dX;
    if curseur=curReticule then begin
        LabelDeltaX.visible := true;
        LabelDeltaY.visible := true;
        labelDeltaX.transparent := false;
        labelDeltaY.transparent := false;
        labelDeltaX.caption := XNom+'='+XVal+' ';
        labelDeltaY.caption := YNom+'='+YVal+' ';
        labelDeltaX.top := limiteFenetre.top+5;
        if OgPolaire in OptionGraphe
            then begin
              LabelDistance.visible := true;
              labelDeltaY.top := limiteFenetre.top+25;
              margeCarac := largCarac*(length(labelDeltaX.caption)+2);
              dX := sqrt(sqr(CurseurOsc[1].yr)+sqr(CurseurOsc[2].yr)-
                        2*CurseurOsc[1].yr*CurseurOsc[2].yr*
                        cos(CurseurOsc[1].xr-CurseurOsc[2].xr));
              XVal := monde[CurseurOsc[curseurData1].mondeC].axe.FormatValeurEtUnite(dX);
              labelDistance.Caption := XVal;
              labelDeltaY.left := limiteFenetre.right-margeCarac;
              labelDeltaX.left := limiteFenetre.right-margeCarac;
              labelDistance.top := (curseurOsc[2].yc+curseurOsc[1].yc) div 2;
              labelDistance.left := (curseurOsc[2].xc+curseurOsc[1].xc) div 2;
            end
            else begin
              LabelDistance.visible := false;
              labelDeltaY.top := (yc+curseurOsc[2].yc) div 2;
              if abs(labelDeltaY.top-labelY.Top)<hautCarac then
                 if labelDeltaY.top>labelY.top
                    then labelDeltaY.top := labelY.top+hautCarac
                    else labelDeltaY.top := labelY.top-hautCarac;
              labelDeltaY.left := limiteFenetre.left+4;
              labelDeltaX.left := (xc+curseurOsc[2].xc-labelX.width) div 2;
            end;
    end;
    if curseurGrid.visible then begin
       CurseurGrid.cells[0,2] := XNom;
       CurseurGrid.cells[0,3] := YNom;
       CurseurGrid.cells[1,2] := XVal;
       CurseurGrid.cells[1,3] := YVal;
    end;
    mesureDelta := true;
end end; // AfficheDelta

procedure EffaceDelta;
begin
    if curseurGrid.visible then begin
       CurseurGrid.cells[0,2] := '';
       CurseurGrid.cells[0,3] := '';
       CurseurGrid.cells[1,2] := '';
       CurseurGrid.cells[1,3] := '';
    end;
    LabelDeltaX.visible := false;
    LabelDeltaY.visible := false;
    LabelDistance.visible := false;
end;

Procedure DeplaceDessin;
begin with grapheCourant,dessinCourant do
                 if posDessinCourant=sdCadre
                    then begin
                       RectangleGr(zoneZoom); { efface }
                       AffecteCentreRect(x+deltaXcadre,y+deltaYcadre,zoneZoom);
                       RectangleGr(zoneZoom);
                    end
                    else begin
                       LineGr(zoneZoom); { efface }
                       affectePosition(x+deltaXcadre,y+deltaYcadre,posDessinCourant,shift);
                       case posDessinCourant of
                            sdVert : zoneZoom := rect(x1i,LigneMin,x1i,ligneMax);
                            sdHoriz : zoneZoom := rect(ligneMin,y1i,ligneMax,y1i);
                            else zoneZoom := rect(x1i,y1i,x2i,y2i);
                       end; {case}
                       LineGr(zoneZoom);
                    end
end; // DeplaceDessin

var deplacement : boolean;
    borneLoc : Tborne;
    selectEqLoc : TselectEquivalence;
    indexLoc : integer;
    iProche : integer;
    indexGr : integer;
    hintLoc : string;
    margeX,margeY : integer;
begin // PaintBoxMouseMove
   indexGr := (sender as tcontrol).tag;
   if indexGr<1 then indexGr := 1;
   grapheCourant := Graphes[indexGr];
   if not grapheCourant.grapheOK then exit;
   if ssRight in Shift then exit; // clic droit
with grapheCourant do begin
   hintLoc := '';
   deplacement := ssLeft in Shift;
   mesureDelta := false;
   case curseur of
        curModele : ;
        curXMaxi,curXMini : if abs(x-xCurseur)>8 then begin
             changeEchelleX(x,xCurseur,curseur=curXMaxi);
             xCurseur := x;
             (sender as TPaintBox).invalidate;
        end;
        curYMaxi,curYMini : if abs(y-yCurseur)>8 then begin
             changeEchelleY(y,yCurseur,curseur=curYMaxi);
             yCurseur := y;
             (sender as TPaintBox).invalidate;
        end;
        curZoomAv,curBornes,curEfface : if deplacement
           then with canvas,zoneZoom do begin
               Rectangle(left,top,right,bottom);// efface l'ancien
               right := X;
               bottom := Y;
               Rectangle(left,top,right,bottom);
               hintLoc := stFinZoom;
           end
           else hintLoc := stDebutZoom;
        curSelect : if deplacement
              then if dessinCourant<>nil
                 then deplaceDessin
                 else if borneSelect.style<>bsAucune
                    then SetBorne(x,y,BorneSelect)
                    else begin
                       margeX := PaintBox.Width div 16;
                       margeY := PaintBox.Height div 32;
                       if (ligneRappelCourante=lrEquivalenceManuelle) and
                          (equivalenceCourante<>nil) and
                          (x>2*margeX) and
                          (x<paintBox.Width-margeX) and
                          (y>margeY) and
                          (y<paintBox.Height-2*margeY)
                          then begin
                                  equivalenceCourante.draw; // efface
                                  equivalenceCourante.Modif(x+deltaXcadre,y+deltaYcadre,selectEqCourant);
                                  equivalenceCourante.draw; // retrace
                            end;
                    end
                else begin // pas déplacement
                   SetDessinCourant(x,y);
                   if (posDessinCourant=sdNone) and
                      (ligneRappelCourante=lrEquivalenceManuelle)
                        then GetEquivalence(x,y,equivalenceCourante,selectEqLoc)
                        else selectEqLoc := seNone;
                   if (posDessinCourant<>sdNone) or
                       GetBorne(x,y,BorneLoc) or
                      (selectEqLoc<>seNone)
                   then begin
                     TgraphicControl(sender).cursor := crHandPoint;
                     hintLoc := hGlisser+' ; ';
                     if posDessinCourant=sdCadre
                        then hintLoc := hintLoc+hDbleTexte
                        else if posDessinCourant<>sdNone
                           then hintLoc := hintLoc+hDbleCouleur
                           else if selectEqLoc=seNone
                              then with borneLoc do begin
                                case style of
                                    bsDebut : hintLoc := hintLoc+stDebutDe;
                                    bsFin : hintLoc := hintLoc+stFinDe;
                                    bsDebutVert : hintLoc := hintLoc+stDebutDe;
                                    bsFinVert : hintLoc := hintLoc+stFinDe;
                                end; // case style
                                if indexModele>0 then
                                   hintLoc := hintLoc+FonctionTheorique[indexModele].expression;
                              end; // with borne
                   end
                   else begin // pas borne
                     if UseSelect then hintLoc := stClicVecteur;
                     if (indicateur<>nil) and (x<largCarac)
                         then hintLoc := stClicIndicateur;
                     TgraphicControl(sender).cursor := crDefault;
                     if indexPointCourant>=0
                        then if Pages[pageCourante].PointActif[indexPointCourant]
                            then hintLoc := hSupprPointActif
                            else  hintLoc := hSupprPointNonActif
                        else if curMovePermis then hintLoc := hMove;
                   end;
                end;
        curLigne,curTexte : if deplacement then with canvas,dessinCourant do begin
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i); // efface l'ancienne
                AffectePosition(x,y,sdPoint2,shift);
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i);
        end;
        curReticule : begin
           TraceReticule(cCourant); if cCourant>1 then traceEcart; // efface
           curseurOsc[cCourant].xc := x;
           curseurOsc[cCourant].yc := y;
           TraceReticule(cCourant); if cCourant>1 then traceEcart;// retrace
           AffichePosition;
           case cCourant of
                1 : hintLoc := stBarreReticule1;
                2 : hintLoc := stBarreReticule2;
                3 : hintLoc := stBarreReticule3;
           end;
           if cCourant>1
              then afficheDelta
              else effaceDelta;
        end;
        curMove : if deplacement
           then affecteDeplace(x,y)
           else setPenBrush(curSelect);
        curOrigine : begin
           TraceCurseurCourant(indexGr); // efface précédent
           XorigineInt := X;
           TraceCurseurCourant(indexGr);
           hintLoc := hOrigineGraphe;
        end;
        curReticuleData : begin
           if deplacement and (cCourant>0)
           then begin
               setSegmentInt(x,y);
               setPointCourant(curseurOsc[cCourant].Ic,0);
               if curseurGrid.visible then setStatusReticuleData(curseurGrid);
           end
           else begin
                GetCurseurProche(x,y,false);
                if cCourant=0
                   then TgraphicControl(sender).cursor := crDefault
                   else TgraphicControl(sender).cursor := crHandPoint;
                hintLoc := hSegment;
           end;
        end;
        curReticuleDataNew : begin
              PointProcheNew(x,y);
              affichePosition;
              hintLoc := hBarreDataNew;
        end;
        (*
        curReticuleModele : begin
              if GetReticuleModeleProche(x,y)
                 then TgraphicControl(sender).cursor := crHandPoint
                 else TgraphicControl(sender).cursor := crCross;
              hintLoc := hSegment;
        end;
        *)
        curEquivalence : if (equivalenceCourante<>nil) then begin
           equivalenceCourante.drawFugitif; // efface
           equivalenceCourante.mondepH := mondeDerivee;
           iProche := PointProche(x,y,indexCourbeEquivalence,true,ligneRappelCourante=lrTangente);
           if iProche>=0 then with equivalenceCourante do begin
              SetValeurEquivalence(iProche);
              ResetHeaderXY;
              if curseurGrid.visible then begin
                 CurseurGrid.cells[0,0] := 'n°';
                 CurseurGrid.cells[0,1] := monde[mondeX].Axe.Nom;
                 CurseurGrid.cells[0,2] := monde[mondeY].Axe.Nom;
                 CurseurGrid.cells[0,3] := unitePente.Nom;
                 CurseurGrid.cells[1,0] := IntToStr(iProche);
                 CurseurGrid.cells[1,1] := monde[mondeX].Axe.formatValeurEtUnite(ve);
                 CurseurGrid.cells[1,2] := monde[mondeY].Axe.FormatValeurEtUnite(phe);
                 CurseurGrid.cells[1,3] := unitePente.formatValeurPente(pente);
                 CurseurGrid.RowCount := 4;
                 CurseurGrid.Height := 4*CurseurGrid.defaultRowHeight;
              end;
           end;
           equivalenceCourante.drawFugitif; // trace
        end;
        curModeleGr :
           if deplacement
              then if dessinCourant<>nil
                 then deplaceDessin
                 else if (indexPointModeleGr>0)
                   then with modeleGraphique[IndexModeleGr] do begin
                      DessineUnPoint(indexPointModeleGr); // efface
                      AffecteUnPoint(indexPointModeleGr,x,y);
                      DessineUnPoint(indexPointModeleGr);
                      mouseMoving := true;
              //  La mise à jour du modele se fait par timerModele
                      exit;
                   end
                   else if borneSelect.style<>bsAucune
                       then SetBorne(x,y,BorneSelect)
                       else
              else with modeleGraphique[1] do begin // pas de déplacement
                 indexLoc := GetIndex(x,y);
                 if indexLoc=0
                    then if GetBorne(x,y,BorneLoc)
                        then begin
                           TgraphicControl(sender).cursor := crHandPoint;
                           hintLoc := hGlisser;
                        end
                        else TgraphicControl(sender).cursor := crDefault
                    else begin
                        TgraphicControl(sender).cursor := crHandPoint;
                        hintLoc := GetHint(indexLoc);
                    end;
             end;
   end;
   if hintLoc=''
      then TgraphicControl(sender).hint := hClicDroit
      else TgraphicControl(sender).hint := hintLoc;
   AffecteStatusPanel(headerXY,3,hintLoc);
   if curseur in [curBornes,curSelect]
      then for iProche := 0 to 2 do videStatusPanel(HeaderXY,iProche)
      else if not (curseur in [curEquivalence,curReticuleData,curReticule,curReticuleDataNew]) then  // curReticuleModele
         affichePosition;
   if (curseur in [curModeleGr,curSelect]) and
       not(splitterModele.snapped) and
      (indexCourbeModele>=0) and
      (indexGr=1) then afficheResidu;
   if (curseur=curSelect) and (indexGr=3) then afficheResiduGr;
end end; // PaintBoxMouseMove

procedure TFgrapheVariab.ZoomAvantItemClick(Sender: TObject);
begin
    if grapheCourant.grapheOK then setPenBrush(curZoomAv)
end; // zoomAvant

procedure TFgrapheVariab.SetPenBrush(c : Tcurseur);

Procedure SetPenLoc(indexGr : integer);
begin
  if graphes[indexGr].paintBox.Visible then
with graphes[indexGr],canvas,paintBox do begin
  Pen.Color := PColorReticule;
  Pen.style := PstyleReticule; 
  Pen.mode := pmNotXor;
  Brush.style := bsClear;
  Brush.color := ColorToRGB(clWindow);
  cursor := crDefault;
  case c of
       curZoomAv : begin
          Brush.color := BrushCouleurZoom;
          cursor := crZoom;
          Brush.style := bsSolid;
       end;
       curBornes : begin
          Brush.color := BrushCouleurZoom;
          cursor := crRectangle;
          Brush.style := bsSolid;
       end;
       curTexte : cursor := crLettre;
       curLigne : cursor := crPencil;
       curReticule,curOrigine : cursor := crCross;//crNone;
       curEfface : cursor := crGomme;
       curEquivalence : begin
          if ligneRappelCourante=lrEquivalence then begin
             NbrePointDerivee := pages[pageCourante].nmes div 10;
             if not odd(NbrePointDerivee) then inc(NbrePointDerivee);
             if NbrePointDerivee<3 then NbrePointDerivee := 3;
             if NbrePointDerivee>7 then NbrePointDerivee := 7;
             if NbrePointDerivee=3
                then degreDerivee := 1
                else degreDerivee := 2;
          end;
          if ((indexCourbeEquivalence<0) or
              (indexCourbeEquivalence>=courbes.count))
              then setCourbeDerivee;
          cursor := crDefault;
          Pen.style := PstyleTangente;
       end;
       curModeleGr : begin
            cursor := crCross;
            Brush.color := BrushCouleurSelect;
            Brush.style := bsSolid;
       end;
       curModele : ;
       (*
       curModele : if (pages[pageCourante].modeleCalcule) and
       (ModeleConstruit in etatModele) and
       (monde[mondeX].axe=grandeurs[fonctionTheorique[1].indexX]) and
       (monde[mondeY].axe=grandeurs[fonctionTheorique[1].indexY])
          then cursor := crCross
          else begin
             afficheErreur(ErCurseurModele,0);
             curseur := curSelect
          end;
          *)
       curReticuleDataNew : cursor := crCross;
       curMove : cursor := crSizeAll;
       curXmaxi,curXmini : cursor := crSizeWE;
       curYmaxi,curYMini : cursor := crSizeNS;
       else cursor := crDefault;
    end; // case c
    panelPrinc.Cursor := cursor;
end end; // setPenLoc

var i : integer;
begin // SetPenBrush
    if c=curOrigine then begin
       if graphes[1].monde[mondeX].axe.fonct.genreC<>g_experimentale then begin
          AfficheErreur(erOrigineExp,0);
          c := curSelect;
       end;
       if graphes[1].superposePage then begin
          AfficheErreur(erOriginePage,0);
          c := curSelect;
       end;
     end;
     if (c=curModeleGr) and (NbreModele>2) then c := curSelect;
     if (c=curOrigine) and (curseur<>curOrigine) then
        showMessage(hCurseurOrigine);
     if (curseur in [curReticuleData,curReticuleDataNew]) and
        not (c in [curReticuleData,curReticuleDataNew]) then
         graphes[1].paintBox.invalidate;
     curseur := c;
     CurseurGrid.visible := (c in [curReticuleData, curEquivalence]) and avecTableau;
     for i := 1 to 3 do SetPenLoc(i);
     CurseurBtn.ImageIndex := iconCurseur[curseur];
     HeaderXY.visible := c in
          [curSelect,curTexte,curLigne,curOrigine,curReticuleDataNew]; // curModele
     LabelX.visible := c in [curReticule,curReticuleDataNew];
     LabelY.visible := c in [curReticule,curReticuleDataNew];
     LabelX.Color := fondReticule;
     LabelY.Color := fondReticule;
     LabelDeltaX.visible := (c=curReticule) and
                            (graphes[1].cCourant>1);
     LabelDeltaY.visible := (c=curReticule) and
                            (graphes[1].cCourant>1);
     LabelDeltaX.Color := fondReticule;
     LabelDeltaY.Color := fondReticule;
     if curseur=curSelect then SelectItem.checked := true;
end; // SetPenBrush

procedure TFgrapheVariab.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure GetDessinLoc;
begin with grapheCourant do begin
          SetDessinCourant(x,y);
          canvas.Brush.color := colorToRGB(clWindow);
          if dessinCourant<>nil
              then with dessinCourant do begin
                  case posDessinCourant of
                       sdCadre : zoneZoom := cadre;
                       sdVert : zoneZoom := rect(x1i,ligneMin,x1i,ligneMax);
                       sdHoriz : zoneZoom := rect(ligneMin,y1i,ligneMax,y1i);
                       else zoneZoom := rect(x1i,y1i,x2i,y2i);
                  end; // case posdessin
         // Pour éviter déplacement du dessin par le clic
                  case posDessinCourant of
                       sdCadre : begin
                          RectangleGr(zoneZoom);
                          with cadre do begin
                               DeltaXcadre := (right+left) div 2-X;
                               DeltaYcadre := (bottom+top) div 2-Y;
                          end;
                       end; {cadre}
                       sdPoint1 : begin
                             DeltaXcadre := X1i-X;
                             DeltaYcadre := Y1i-Y;
                       end;
                       sdPoint2 : begin
                             DeltaXcadre := X2i-X;
                             DeltaYcadre := Y2i-Y;
                       end;
                       sdCentre : begin
                             DeltaXcadre := (X2i+X1i) div 2 -X;
                             DeltaYcadre := (Y2i+Y1i) div 2 -Y;
                       end;
                       else begin
                             DeltaXcadre := 0;
                             DeltaYcadre := 0;
                       end;
                  end; {case posdessin}
                  if posDessinCourant<>sdCadre then LineGr(zoneZoom);
               end // with dessinCourant
end end;

var j,iProche : integer;
    icourbe : integer;
    grandeurRef : Tgrandeur;
    indexCoord,newIndex : integer;
    isMaxi : boolean;
begin // MouseDown
   indexGrCourant := (sender as Tcontrol).tag;
   grapheCourant := Graphes[indexGrCourant];
   if not grapheCourant.grapheOK then exit;
   if (Button=mbRight) then begin
      grapheCourant.SetDessinCourant(x,y);
      exit; // clic droit donc menu contextuel
   end;
   Ydrag := 0;
   if DeuxGraphesVert.checked or
      DeuxGraphesHoriz.checked
        then for j := 1 to 3 do
             if Graphes[j].paintBox.Visible then
                graphes[j].EncadreTitre(indexGrCourant=j);
   if (curseur=curSelect) and
      (ssDouble in shift) then
       if grapheCourant.DessinCourant<>nil
          then begin
             grapheCourant.DessinCourant.litOption(grapheCourant);
             grapheCourant.DessinCourant := nil;
             grapheCourant.paintBox.invalidate;
             exit;
          end
          else if grapheCourant.isAxe(x,y)>0
              then CoordonneesItemClick(nil)
              else if grapheCourant.isAxeX(x,y,isMaxi) or 
                      grapheCourant.isAxeY(x,y,isMaxi)
                 then begin
                    zoomManuelItemClick(sender);
                    exit;
                 end;
   if (curseur=curSelect) and (grapheCourant.DessinCourant=nil) then begin
          indexCoord := grapheCourant.isAxe(x,y);
          if indexCoord>0 then
              if grapheCourant.Coordonnee[indexCoord].iMondeC>=mondeSans
              then begin
                    grandeurRef := grandeurs[grapheCourant.Coordonnee[indexCoord].codeY];
                    for j := 1 to maxOrdonnee do with grapheCourant.Coordonnee[j] do
                        if (codeY=grandeurInconnue) or
                           (j=indexCoord) or
                           grandeurs[codeY].uniteEgale(grandeurRef)
                              then iMondeC := mondeY
                              else iMondeC := mondeSans;
                    include(grapheCourant.modif,gmXY);
                    ModifGraphe(indexGrCourant);
              end
          end;
   if (curseur=curEquivalence) and
      (ligneRappelCourante=lrTangente) then with grapheCourant do begin
           indexCoord := isAxe(x,y);
           if indexCoord>0 then begin
               newIndex := Coordonnee[indexCoord].iCourbe;
               if indexCourbeEquivalence<>newIndex then begin
                  indexCourbeEquivalence := newIndex;
//                  equivalenceCourante := nil;
                  resetCourbeDerivee;
                  exit;
               end;
           end;
   end;
   with grapheCourant do begin
   case curseur of
       curModele,curXmaxi,curXMini,curYmaxi,curYMini : ;
       curZoomAv,curBornes : zoneZoom := rect(X,Y,X,Y);
       curLigne,curTexte : with dessinCourant do  begin
           if (ogAnalyseurLogique in optionGraphe)
              then iMonde := mondeProche(x,y)
              else iMonde := mondeY;
           affectePosition(x,y,sdPoint1,shift);
           x2i := x1i;
           y2i := y1i;
       end;
       curReticule : if not(ssDouble in shift) then begin
       // active deuxième curseur pour différence
                for j := 1 to cCourant do traceReticule(j);
                if cCourant>1 then traceEcart; // efface
                curseurOsc[cCourant+1].xc := curseurOsc[cCourant].xc;
                curseurOsc[cCourant+1].xr := curseurOsc[cCourant].xr;
                curseurOsc[cCourant+1].yc := curseurOsc[cCourant].yc;
                curseurOsc[cCourant+1].yr := curseurOsc[cCourant].yr;
                curseurOsc[2].mondeC := curseurOsc[1].mondeC;
                inc(cCourant);
                if cCourant>3 then cCourant := 1;
                if cCourant>1 then traceEcart; //retrace
                for j := 1 to cCourant do traceReticule(j);
       end;
       curSelect : begin
          GetDessinLoc;
          if dessinCourant=nil then if not getBorne(x,y,BorneSelect)
                    then if (ligneRappelCourante=lrEquivalenceManuelle)
                         then begin
                            GetEquivalence(x,y,equivalenceCourante,selectEqCourant);
                            case selectEqCourant of
                                 sePoint1 : begin
                                     DeltaXcadre := equivalenceCourante.X1i-X;
                                     DeltaYcadre := equivalenceCourante.Y1i-Y;
                                 end;
                                 sePoint2 : begin
                                     DeltaXcadre := equivalenceCourante.X2i-X;
                                     DeltaYcadre := equivalenceCourante.Y2i-Y;
                                 end;
                                 else begin
                                     DeltaXcadre := 0;
                                     DeltaYcadre := 0;
                                 end;
                              end;{case}
                         end // equivalence
                    else begin
                        if isModeleMagnum then begin
                           iCourbe := CourbeProche(x,y);
                           if (iCourbe>=0) and
                            (courbes[iCourbe].indexModele>0) and
                             not courbes[iCourbe].courbeExp then begin
                            // réactiver CurModeleGr
                             modeleGraphique[1].setParametres(pages[pageCourante].valeurParam[paramNormal]);
                             setPenBrush(CurModeleGr);
                             paintBox.invalidate;
                             exit;
                         end;
                       end;
                       for j := 0 to pred(courbes.count) do begin
                           if ((courbes[j].indexModele=0) or courbes[j].courbeExp) and
                              (courbes[j].page=pageCourante) then begin
                              iProche := PointProche(x,y,j,true,false);
                              if iProche>=0 then begin
                                 if Pages[pageCourante].PointActif[iProche]
                                    then TgraphicControl(sender).hint := hSupprPointActif
                                    else TgraphicControl(sender).hint := hSupprPointNonActif;
                                 setPointCourant(iProche,j);
                                 break;
                              end;
                           end;
                    end;
                    end;
           if curMovePermis and
              (dessinCourant=nil) and
              (BorneSelect.style=bsAucune) then begin
                  setPenBrush(curMove);
                  zoneZoom := rect(X,Y,X,Y);
              end;
           if (curSelect=curseur) and isAxeX(x,y,isMaxi) then begin
                 xCurseur := x;
                 if isMaxi
                    then SetPenBrush(curXmaxi)
                    else SetPenBrush(curXmini);
           end;
           if (curSelect=curseur) and isAxeY(x,y,isMaxi) then begin
                 yCurseur := y;
                 if ismaxi
                    then SetPenBrush(curYmaxi)
                    else SetPenBrush(curYmini);
           end;
       end; // curSelect                                          }
       curEfface : begin
           SetDessinCourant(x,y);
           if dessinCourant<>nil then with dessins do begin
                  Remove(DessinCourant);
                  curseur := curSelect;
                  paintBox.invalidate;
           end;
           if (ligneRappelCourante=lrEquivalenceManuelle) then begin
                 GetEquivalence(x,y,equivalenceCourante,selectEqCourant);
                 if equivalenceCourante<>nil then begin
                    equivalences[pageCourante].remove(equivalences[pageCourante].Items[0]);
                    curseur := curSelect;
                    paintBox.invalidate;
                 end;
           end;
           zoneZoom := rect(X,Y,X,Y);
       end;
       curEquivalence : begin
           iproche := PointProche(x,y,indexCourbeEquivalence,true,ligneRappelCourante=lrTangente);
           if iProche>=0 then begin
              AjouteEquivalence(iProche,true);
              TgraphicControl(sender).invalidate;
           end;
           setPointCourant(iProche,indexCourbeEquivalence);
           ResetHeaderXY;
           if curseurGrid.visible then begin
              for j := 0 to pred(statusSegment[1].count) do
                 CurseurGrid.cells[1,j] := statusSegment[1].strings[j];
              for j := 0 to pred(statusSegment[0].count) do
                 CurseurGrid.cells[0,j] := statusSegment[0].strings[j];
              CurseurGrid.RowCount := statusSegment[0].count;
              CurseurGrid.Height := CurseurGrid.RowCount*CurseurGrid.DefaultRowHeight+4;
           end;
       end;
       curReticuleData : begin
          GetCurseurProche(x,y,true);
          setSegmentInt(x,y);
          if curseurGrid.visible then setStatusReticuleData(curseurGrid);
          SetPointCourant(curseurOsc[cCourant].Ic,0);
       end;
       curReticuleDataNew : ;
       curReticuleModele : ; // setReticuleModele(x,y,true,true);
       curModeleGr : begin
            indexModeleGR := 0;
            for j := 1 to NbreModele do begin
                indexPointModeleGr := modeleGraphique[j].GetIndex(x,y);
                if indexPointModeleGr>0 then begin
                   indexModeleGR := j;
                   break;
                end;
            end;
            timerModele.enabled := true;
            if indexPointModeleGr=0
               then getBorne(x,y,BorneSelect)
               else BorneSelect.style := bsAucune;
            if (indexPointModeleGr=0) and (BorneSelect.style=bsAucune)
                then getDessinLoc
                else dessinCourant := nil;
            if dessinCourant=nil then
               canvas.Brush.color := BrushCouleurSelect
       end;
   end // case
end end; // PaintBoxMouseDown

procedure TFgrapheVariab.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure affecteZoomAv;
begin
   with zoneZoom do begin
        grapheCourant.canvas.Rectangle(left,top,right,bottom);// efface
        right := X;
        bottom := Y;
        setPenBrush(curSelect);
        if (left=right) or (bottom=top) then exit;
   end;
   grapheCourant.affecteZoomAvant(zoneZoom,true);
   curMovePermis := true;
   include(grapheCourant.modif,gmEchelle);
   grapheCourant.paintBox.invalidate;
   if residusItem.checked then begin
      include(grapheResidu.modif,gmEchelle);
      grapheResidu.paintBox.invalidate;
   end;
end; // affecteZoomAv

Procedure affecteOrigine;
var y0 : double;
begin
   grapheCourant.canvas.MoveTo(XorigineInt,0);
   grapheCourant.canvas.LineTo(XorigineInt,height);{ efface }
   grapheCourant.MondeRT(x,0,mondeY,xOrigine,y0);
   setPenBrush(curSelect);
   PostMessage(handle,Wm_Reg_Origine,0,0);
end; // affecteOrigine

procedure AffecteDessin;
label fin;
begin
if grapheCourant.dessinCourant<>nil then
with grapheCourant.dessinCourant do begin
   with grapheCourant.canvas do begin
        MoveTo(x1i,y1i);
        LineTo(x2i,y2i); // efface
   end;
   if isTexte
      then begin
          if not litOption(grapheCourant) then begin
              grapheCourant.dessinCourant.free;
              goto fin;
          end;
      end
      else begin
           if (curseur=curLigne) and
              ((abs(x1i-x2i)+abs(y1i-y2i))<3) then begin
              afficheErreur(erLigneNulle,0);
              grapheCourant.dessinCourant.free;
              goto fin;
           end;
      end;
   AffectePosition(x,y,sdPoint2,shift);
   grapheCourant.dessins.Add(grapheCourant.DessinCourant);
   ModifFichier := true;
   draw;
end;
   fin :
   grapheCourant.dessinCourant := nil;
   setPenBrush(curSelect);
end; // AffecteDessin

procedure AffecteVecteurMeca;
var j,iProche : integer;
    ib : integer;
begin
    for j := 0 to pred(grapheCourant.courbes.count) do with grapheCourant.courbes[j] do
        if (trVitesse in trace) or (trAcceleration in trace) then begin
             iProche := grapheCourant.PointProche(x,y,j,true,false);
             include(menuPermis,imVitesse);
             if (iProche>=0) and (iProche<256) then begin
                ib := byte(iProche);
                if ib in PointSelect
                   then exclude(PointSelect,ib)
                   else include(PointSelect,ib);
                grapheCourant.paintBox.invalidate;
                break;
             end;
    end;
end; // AffecteVecteur

procedure finDeplaceDessin;
begin with grapheCourant do begin
     if posDessinCourant=sdCadre
           then begin
                RectangleGr(zoneZoom);
                dessinCourant.AffectePosition(x+deltaXcadre,y+deltaYcadre,posDessinCourant,shift);
           end
           else dessinCourant.AffectePosition(x+deltaXcadre,y+deltaYcadre,posDessinCourant,shift);
     paintBox.invalidate;
     dessinCourant := nil;
end end;

var P : Tpoint;
    j : integer;
begin // MouseUp
  indexGrCourant := (sender as tcontrol).tag;
  if indexGrCourant<1 then indexGrCourant := 1;
  grapheCourant := Graphes[indexGrCourant];
  mouseMoving := false;
  if (x<0) or (y<0) or not(grapheCourant.grapheOK) then exit;
  if Button=mbRight then begin
     if grapheCourant.DessinCourant=nil then
        grapheCourant.setDessinCourant(x,y);
     P := (sender as TgraphicControl).ClientToScreen(point(X,Y));
     if grapheCourant.dessinCourant<>nil
         then MenuDessin.popUp(P.x,P.y)
         else if (grapheCourant.indicateur<>nil) and (x<grapheCourant.largCarac)
             then MenuIndicateur.popUp(P.x,P.y)
             else if curseur in [curReticule,curReticuleData,curEquivalence,curReticuleDataNew] // ,curReticuleModele
             then MenuReticule.popUp(P.x,P.y)
             else MenuAxes.popUp(P.x,P.y);
     exit;
  end; // bouton droit
  case curseur of
       curZoomAv : affecteZoomAv;
       curBornes : affecteBornes(x,y);
       curEfface : affecteEfface(x,y);
       curXmaxi,curXMini : begin
           GrapheCourant.changeEchelleX(x,xCurseur,curseur=curXmaxi);
           setPenBrush(curSelect);
           (sender as TPaintBox).invalidate;
       end;
       curYmaxi,curYmini : begin
           GrapheCourant.changeEchelleY(y,yCurseur,curseur=curYmaxi);
           setPenBrush(curSelect);
           (sender as TPaintBox).invalidate;
       end;
       curTexte,curLigne : affecteDessin;
       curSelect : if grapheCourant.dessinCourant<>nil
            then finDeplaceDessin
            else if (ligneRappelCourante=lrEquivalenceManuelle) and
                    (grapheCourant.EquivalenceCourante<>nil)
            then if grapheCourant.EquivalenceCourante.modif(x+deltaXcadre,y+deltaYcadre,selectEqCourant)
                 then grapheCourant.paintBox.invalidate
                 else
            else if borneSelect.style=bsAucune
               then if UseSelect
                  then affecteVecteurMeca
                  else
               else AffecteBorne;
       curReticuleData : grapheCourant.paintbox.invalidate;
       curReticuleDataNew : ;
       curReticuleModele : ;
       curReticule : ;
       curEquivalence : if Ydrag>0 then begin
             (sender as Tcontrol).endDrag(false);
             if (ligneRappelCourante=lrTangente) then with grapheCourant do begin
               j := Coordonnee[Ydrag].iCourbe;
               if indexCourbeEquivalence<>j then begin
                  indexCourbeEquivalence := j;
                  resetCourbeDerivee;
               end;
             end;
             Ydrag := 0;
       end;
       curModele : ;
       curMove : setPenBrush(curSelect);
       curOrigine : affecteOrigine;
       curModeleGr : if indexPointModeleGr>0 then
          with modeleGraphique[indexModeleGr] do begin
               DessineUnPoint(indexPointModeleGr);
               AffecteUnPoint(indexPointModeleGr,x,y);
               DessineUnPoint(indexPointModeleGr);
               MajModeleGr(indexModeleGr);
               TimerModele.enabled := false;
               indexPointModeleGr := 0;
               indexModeleGr := 0;
          end
          else if grapheCourant.dessinCourant<>nil
            then finDeplaceDessin
            else AffecteBorne;
  end;
//  grapheCourant.dessinCourant := nil;
end; // MouseUp

procedure TFgrapheVariab.FormCreate(Sender: TObject);

procedure CreateAnim;
var i,j : integer;
begin
     InitManuelleAfaire := true;
     ActiverTimerAnim := false;
     for i := 0 to maxParamAnim do
         paramAnimManuelle[i] := TparamAnimation.create;
     with PanelAnimation do
        for i := 0 to pred(controlCount) do begin
           if controls[i] is TgroupBox then begin
              j := TGroupBox(controls[i]).tag;
              paramAnimManuelle[j].GroupBoxA := TgroupBox(controls[i]);
              paramAnimManuelle[j].SliderA := TtrackBar(TGroupBox(controls[i]).controls[0]);
              paramAnimManuelle[j].SliderA.Tag := j;
           end;
     end;
     NbrePasAnim := 100;
     paramAnimCourant := 0;
     ClearGrapheAnim := true;
     OldPlacement.Length := SizeOf(TWindowPlacement);
end;

var m : TcodeIntervalle;
    i,j,k : integer;
begin
  MajFichierEnCours := true;
  PanelAjuste.enabled := true;
  CurseurGrid.ColWidths[0] := largeurUnCarac*6;
  CurseurGrid.ColWidths[1] := largeurUnCarac*12;
  CurseurGrid.Width := largeurUnCarac*19;
  InitiationAfaire := imInitiationModele in menuPermis;
  for i := 1 to 3 do Graphes[i] := TgrapheReg.create;
  with Graphes[2] do begin
     paintBox := paintBox2;
     panel := panelBis;
     canvas := paintBox2.canvas;
     labelYcurseur := labelY;
  end;
  with Graphes[1] do begin
     paintBox := paintBox1;
     panel := panelPrinc;
     canvas := paintBox1.canvas;
     labelYcurseur := labelY;
  end;
  with Graphes[3] do begin
     paintBox := paintBox3;
     panel := panelPrinc;
     canvas := paintBox3.canvas;
     labelYcurseur := labelY;
  end;
  indexGrCourant := 1;
  GrapheCourant := graphes[1];
  GrapheResidu := graphes[grResidu];
  curseur := curSelect;
  selectItem.Checked := true;
  entreeValidee := false;
  for m := 1 to maxIntervalles do
      valeurDeriveeX[m] := nil;
  VerifGraphe := true;
  with ParamScrollBox do
        for i := 0 to pred(controlCount) do begin
           if controls[i] is Tpanel then begin
              j := TPanel(controls[i]).tag;
              PanelParam[j] := TPanel(controls[i]);
              with PanelParam[j] do
                   for k := 0 to pred(controlCount) do begin
                       if controls[k] is Tedit then
                          EditValeur[j] := TEdit(controls[k]);
                   end;
           end;
  end;
  setTaillePolice;
  hintMemoResultat := TstringList.Create;
  ImageList1.height := VirtualImageListSize;
  ImageList1.width := VirtualImageListSize;
  CreateAnim;
end; // formCreate

procedure TFgrapheVariab.SetCoordonnee(indexGr : integer);

var CourbeExpAffectee,SimulationAffectee,withModele : boolean;

Procedure AjouteVariab(m : TindiceMonde;i : TindiceOrdonnee;p : TcodePage);
var xV,yV : Tvecteur;
    c : shortInt;
    avecModele : boolean;
    courbeVariab,courbeAdd : Tcourbe;
    iX,iY : integer;
    traceV : TsetTrace;
    ligneV : Tligne;
    couleurModeleCourant : Tcolor;

Procedure AddIncert(Acourbe : Tcourbe);
var avecIncertX,avecIncertY : boolean;
begin
      with pages[p] do begin
         avecIncertX := isCorrect(incertVar[iX,acourbe.debutC]);
         if avecIncertX
            then Acourbe.IncertX := incertVar[iX]
            else Acourbe.IncertX := nil;
         avecIncertY := not isNan(incertVar[iY,acourbe.debutC]);
         if avecIncertY
            then Acourbe.IncertY := incertVar[iY]
            else Acourbe.IncertY := nil;
         if avecIncertY and not avecIncertX then Acourbe.IncertX := incertNulle;
         if avecIncertX and not avecIncertY then Acourbe.IncertY := incertNulle;
      end;
end;

procedure SetCouleurTexte(m : TcodeIntervalle);
begin with memoModele,fonctionTheorique[m] do begin
    MajModelePermis := false;
    selStart := findText(expression,0,length(text),[]);
    if selStart<0 then exit;
    selLength := length(expression);
    if graphes[indexGr].superposePage
        then Couleur := clBlack
        else Couleur := couleurModeleCourant;
    selAttributes.color := Couleur;
    selLength := 0;
    selAttributes.color := clBlack;
    MajModelePermis := true;
    ModeleGraphique[m].couleur := couleurModeleCourant; 
end end;

const NbandeDefault = 256;

var j,cc,b : integer;
    CouleurModeleActive : boolean;
begin with graphes[indexGr],pages[p] do begin
      if m>=MaxMonde then exit;
      with Coordonnee[i] do begin
           iX := CodeX;
           iY := CodeY;
           if (trIndicateur in trace) and
              ((indicateur=nil) or
               (optionsIndicateur=[]) or
               (optionsIndicateur=[oiNomIndicateur]))
                  then exclude(trace,trIndicateur);
           exclude(trace,trSonagramme);
           TraceV := trace;
           LigneV := ligne;
           if (LigneV=LiModele) and (NbreModele=0) then LigneV := LiDroite;
           couleurModeleCourant := couleur;
           if (motif=mIncert) and
              ((not grandeurs[iY].incertDefinie) or (not grandeurs[iX].incertDefinie))
                 then motif := TMotif(i);
      end;
      if grandeurs[iY].fonct.genreC=g_texte then begin
            for c := 0 to pred(courbes.count) do
                if courbes[c].page=p then begin
                   include(courbes[c].trace,trTexte);
                   courbes[c].couleurTexte := couleurModeleCourant;
                   courbes[c].texteC := TstringList.create;
                   for j := 0 to pred(pages[p].nmes) do
                       courbes[c].texteC.add(texteVar[iY,j]);
                   exit;
                end;
     end;
     if (grandeurs[iY].genreG in [constante,constanteGlb]) or
        (grandeurs[iX].genreG in [constante,constanteGlb]) then begin
              setLength(yV,nmes);
              case grandeurs[iY].genreG of
                   constante : for j := 0 to pred(nmes) do yV[j] := valeurConst[iY];
                   variable : copyVecteur(yV,valeurVar[iY]);
                   constanteGlb : for j := 0 to pred(nmes) do yV[j] := grandeurs[iY].valeurCourante;
              end;
              setLength(xV,nmes);
              case grandeurs[iX].genreG of
                   constante : for j := 0 to pred(nmes) do xV[j] := valeurConst[iX];
                   variable : copyVecteur(xV,valeurVar[iX]);
                   constanteGlb : for j := 0 to pred(nmes) do xV[j] := grandeurs[iX].valeurCourante;
              end;
              courbeVariab := AjouteCourbe(xV,yV,m,nmes,
                   grandeurs[iX],grandeurs[iY],p);
              if (grandeurs[iY].genreG in [constante,constanteGlb]) and
                 (grandeurs[iX].genreG in [constante,constanteGlb])
                   then courbeVariab.Trace := [trPoint]
                   else courbeVariab.Trace := [trLigne];
              courbeVariab.Adetruire := true;
              with Coordonnee[i] do
                   courbeVariab.setStyle(couleur,styleT,motif);
              exit;
      end;
      courbeVariab := AjouteCourbe(valeurVar[iX],valeurVar[iY],m,nmes,
              grandeurs[iX],grandeurs[iY],p);
      with coordonnee[i] do begin
           courbeVariab.setStyle(couleur,styleT,motif);
           if couleurPoint<>'' then
              courbeVariab.setStylePoint(couleurPoint,codeCouleur);
      end;
      AddIncert(courbeVariab);
      avecModele := false;
      if traceV=[] then if modeAcquisition=AcqSimulation
      then begin
          TraceV := [trLigne];
          LigneV := LiDroite
      end
      else case TraceDefaut of
          tdPoint : TraceV := [trPoint];
          tdLigne : begin
                 TraceV := [trLigne];
                 LigneV := LiDroite
          end;
          tdLissage : begin
                 TraceV := [trLigne,trPoint];
                 LigneV := LiSpline;
          end;
      end;
      courbeVariab.Trace := TraceV;
      CouleurModeleActive := false;
// 2 modeles différents => on force des couleurs différentes
      for c := 2 to NbreModele do
          for cc := 1 to pred(c) do
              if (fonctionTheorique[c].indexY)=
                 (fonctionTheorique[cc].indexY) then begin
                     CouleurModeleActive := true;
                     break;
               end;
      courbeVariab.optionLigne := LiDroite; // par défaut
      if TrLigne in TraceV then case LigneV of
           LiModele : begin
                exclude(courbeVariab.Trace,trLigne);
                exclude(traceV,trPoint);
                exclude(traceV,trLigne);
                exclude(traceV,trIndicateur);
                if ModeleDefini in etatModele then begin
                   for c := 1 to NbreModele do with fonctionTheorique[c] do
                      if (iY=indexY) and (iX=indexX) and not(implicite) then begin
                            if (debut[c]>0) or
                               (fin[c]<pred(nmes)) or
                               CouleurModeleActive then begin
                                courbeAdd := AjouteCourbe(valeurVar[iX],valeurVar[iY],
                                   m,nmes,grandeurs[iX],grandeurs[iY],p);
                                courbeAdd.debutC := debut[c];
                                courbeAdd.finC := fin[c];
                                courbeAdd.trace := [trPoint];
                                courbeAdd.courbeExp := true;
                                courbeAdd.IndexModele := c;
                                AddIncert(courbeAdd);
                                CourbeExpAffectee := true;
                                couleurModeleCourant := couleurModele[c];
                                with coordonnee[i] do begin
                                     courbeAdd.setStyle(couleurModeleCourant,styleT,motif);
                                     if couleurPoint<>'' then
                                        courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                                end;
                                setCouleurTexte(c);
                            end
                            else begin // UN modele sur toute les donnees
                               courbeVariab.courbeExp := true;
                               courbeVariab.IndexModele := c;
                               courbeExpAffectee := true; { ?? }
                               if NbreModele>1 then couleurModeleCourant := couleurModele[c];
                               SetCouleurTexte(c);
                            end; // modele sur toute les donnees
                            if modeleCalcule then begin
                               setlength(xV,NmesMax+1);
                               setLength(yV,NmesMax+1);
                               if c=1 then begin
                                  indexCourbeModele := courbes.count-1;
                                  indexReticuleModele := courbes.count;
                               end;
                               courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                                  grandeurs[iX],grandeurs[iY],p);
                               courbeAdd.IndexModele := c;
                               AvecModele := true;
                               if coordonnee[i].motif=mHisto
                                  then begin
                                      courbeAdd.Trace := [trPoint];
                                      courbeAdd.setStyle(couleurModele[c],psSolid,mHisto);
                                      couleurModeleCourant := courbeAdd.couleur;
                                  end
                                  else begin
                                      courbeAdd.Trace := [trLigne];
                                      with coordonnee[i] do begin
                                           courbeAdd.setStyle(couleurModeleCourant,styleT,motif);
                                           if couleurPoint<>'' then
                                              courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                                      end;
                                  end;
                               courbeAdd.Adetruire := true;
                               setCouleurTexte(c);
                               if c=1 then courbeModele := courbeAdd;
                               // lineaireVar
                               if lineaire and (withBandeConfiance or withBandePrediction) then for b := 1 to 4 do
                               if ((b in [1,2]) and withBandeConfiance) or
                                  ((b in [3,4]) and withBandePrediction) then
                               begin // min et max ; 1-2 confiance et 3-4 prédiction
                                  // nouveaux vecteurs
                                  setlength(xV,NbandeDefault);
                                  setlength(yV,NbandeDefault);
                                  courbeAdd := AjouteCourbe(xV,yV,m,NbandeDefault,
                                     grandeurs[iX],grandeurs[iY],p);
                                  courbeAdd.IndexModele := c;
                                  courbeAdd.IndexBande := b;
                                  courbeAdd.courbeExp := false;
                                  courbeAdd.Trace := [trLigne];
                                  courbeAdd.Adetruire := true;
                                  if (b in [1,2])
                                     then courbeAdd.setStyle(couleurBandeConfiance,psDot,mCroix)
                                     else courbeAdd.setStyle(couleurBandePrediction,psDash,mCroix);
                               end;
                            end;
           end; // for c de ModeleDefini
           if not(avecModele) and
                  (ModeleDefini in etatModele) and
                   modeleCalcule and
                   (NbreModele=2) and
                   (fonctionTheorique[1].genreC=g_fonction) and
                   (fonctionTheorique[1].indexX=0) and
                   (fonctionTheorique[2].indexX=0) and
                   (((fonctionTheorique[1].indexY=iY) and
                     (fonctionTheorique[2].indexY=iX)) or
                    ((fonctionTheorique[1].indexY=iX) and
                     (fonctionTheorique[2].indexY=iY))) then begin
                               setLength(xV,NmesMax+1);
                               setLength(yV,NmesMax+1);
                               courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                                  grandeurs[iX],grandeurs[iY],p);
                               AvecModele := true;
                               courbeAdd.ModeleParametrique := true;
                               CourbeAdd.ModeleParamX1 := fonctionTheorique[1].indexY=iX;
                               courbeAdd.Trace := [trLigne];
                               courbeAdd.Adetruire := true;
                               with coordonnee[i] do begin
                                    courbeAdd.setStyle(couleurModeleCourant,styleT,motif);
                                    if couleurPoint<>'' then
                                       courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                               end;
                               setCouleurTexte(2);
                               setCouleurTexte(1);
                end; // Modele parametrique
           if not(avecModele) and
                  (ModeleDefini in etatModele) and
                   modeleCalcule and
                   (NbreModele=1) and
                   (fonctionTheorique[1].genreC=g_fonction) and
                   (fonctionTheorique[1].indexX=0) and
                   (((fonctionTheorique[1].indexY=iY) and
                     (fonctionTheorique[1].indexYp=iX)) or
                    ((fonctionTheorique[1].indexY=iX) and
                     (fonctionTheorique[1].indexYp=iY))) then begin
                               setlength(xV,NmesMax+1);
                               setlength(yV,NmesMax+1);
                               courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                                  grandeurs[iX],grandeurs[iY],p);
                               AvecModele := true;
                               courbeAdd.PortraitDePhase := true;
                               CourbeAdd.ModeleParamX1 := fonctionTheorique[1].indexY=iX;
                               courbeAdd.Trace := [trLigne];
                               with coordonnee[i] do begin
                                    courbeAdd.setStyle(couleurModeleCourant,styleT,motif);
                                    if couleurPoint<>'' then
                                       courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                               end;
                               courbeAdd.Adetruire := true;
                               setCouleurTexte(1);
                end; // Portrait de phase avec fonction
          if not(avecModele) and
                (ModeleDefini in etatModele) and
                   modeleCalcule and
                   (NbreModele=1) and
                   (fonctionTheorique[1].genreC=g_diff2) and
                   (fonctionTheorique[1].indexX=0) and
                   (((fonctionTheorique[1].indexYp=iY) and
                     (fonctionTheorique[1].indexY=iX)) or
                    ((fonctionTheorique[1].indexYp=iX) and
                     (fonctionTheorique[1].indexY=iY))) then begin
                               setlength(xV,nmesMax+1);
                               setlength(yV,nmesMax+1);
                               courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                                  grandeurs[iX],grandeurs[iY],p);
                               AvecModele := true;
                               courbeAdd.PortraitDePhase := true;
                               CourbeAdd.ModeleParamX1 := fonctionTheorique[1].indexY=iX;
                               courbeAdd.Trace := [trLigne];
                               with coordonnee[i] do begin
                                   courbeAdd.setStyle(couleurModeleCourant,styleT,motif);
                                   if couleurPoint<>'' then
                                      courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                               end;
                               courbeAdd.Adetruire := true;
                               setCouleurTexte(1);
                         end; // Portrait de phase équa diff 
                end; // modeleDefini
                if not(avecModele) and
                   (NbreModele>0) and
                   fonctionTheorique[1].implicite then begin
                   setlength(xV,NmesMax+1);
                   setLength(yV,NmesMax+1);
                   courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                      grandeurs[iX],grandeurs[iY],p);
                   courbeAdd.IndexModele := 1;
                   AvecModele := true;
                   courbeAdd.Trace := [trLigne];
                   courbeAdd.Adetruire := true;
                   with coordonnee[i] do begin
                        courbeAdd.setStyle(couleurModele[1],styleT,motif);
                        if couleurPoint<>'' then
                           courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                   end;
                   courbeModele := courbeAdd;
//                   indexCourbeModele := courbes.count-1;
                end;
                if not(avecModele) and
                   ((valeurLisse[iX]<>valeurVar[iX]) or
                    (valeurLisse[iY]<>valeurVar[iY]))
                       then begin
                            courbeAdd := AjouteCourbe(valeurLisse[iX],valeurLisse[iY],
                                m,nmes,grandeurs[iX],grandeurs[iY],p);
                            with coordonnee[i] do begin
                                courbeAdd.setStyle(couleur,styleT,motif);
                                if couleurPoint<>'' then
                                   courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                            end;
                            courbeAdd.Trace := [trLigne];
                        end;
           if not(avecModele) and not(pasDeModele in etatModele) then
                   if (valeurLisse[iX]<>valeurVar[iX]) or
                      (valeurLisse[iY]<>valeurVar[iY])
                       then begin
                           courbeAdd := AjouteCourbe(valeurLisse[iX],valeurLisse[iY],
                                m,nmes,grandeurs[iX],grandeurs[iY],p);
                            with coordonnee[i] do begin
                                courbeAdd.setStyle(couleur,styleT,motif);
                                if couleurPoint<>'' then
                                   courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                            end;
                            courbeAdd.Trace := [trLigne];
                        end;
        end;
        LiSpline : begin
              courbeVariab.courbeExp := true;
              courbeVariab.optionLigne := LiSpline;
              exclude(traceV,trPoint);
              exclude(traceV,trIndicateur);
              exclude(traceV,trLigne);
        end;
        LiSinc : begin
              courbeVariab.courbeExp := true;
              courbeVariab.optionLigne := LiSinc;
              exclude(traceV,trPoint);
              exclude(traceV,trIndicateur);
              exclude(traceV,trLigne);
        end;
    end; // case ligneV
    if (SimulationDefinie in etatModele) and
        not(splitterModele.snapped) then
       for c := 1 to NbreFonctionSuper do with fonctionSuperposee[c] do
           if (iY=indexY) and (iX=indexX) then begin
                 setLength(xV,nmesMax+1);
                 setLength(yV,nmesMax+1);
                 courbeAdd := AjouteCourbe(xV,yV,m,nmes,
                    grandeurs[iX],grandeurs[iY],p);
                 courbeAdd.IndexModele := -c;
                 with coordonnee[i] do begin
                      courbeAdd.setStyle(couleurModele[-c],styleT,motif);
                      if couleurPoint<>'' then
                         courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                 end;
                 courbeAdd.Trace := [trLigne];
                 courbeAdd.Adetruire := true;
                 SimulationAffectee := true;
           end; // for c de SimulationDefini
    if TraceV<>[] then begin
       courbeVariab.trace := courbeVariab.trace+traceV;
       if avecModele and ([trVitesse,trAcceleration]*traceV<>[]) then begin
          include(menuPermis,imVitesse);
          courbeAdd := AjouteCourbe(valeurLisse[iX],valeurLisse[iY],
                         m,nmes,grandeurs[iX],grandeurs[iY],p);
          with coordonnee[i] do begin
               courbeAdd.setStyle(couleur,styleT,motif);
               if couleurPoint<>'' then
                  courbeAdd.setStylePoint(couleurPoint,codeCouleur);
          end;
          courbeAdd.Trace := [];
          if trVitesse in traceV then begin
             include(courbeAdd.Trace,trVitesse);
             exclude(courbeVariab.Trace,trVitesse);
          end;
          if trAcceleration in traceV then begin
             include(courbeAdd.Trace,trAcceleration);
             exclude(courbeVariab.Trace,trAcceleration);             
          end;
       end;
    end;
    withModele := withModele or avecModele;
end end; // AjouteVariab

Function indexVariable(const nomX : string) : integer;
// Renvoie le code de la variable de nom : nomX
var i : integer;
begin
   result := -1;
   for i := 0 to pred(NbreVariab) do
       if grandeurs[indexVariab[i]].nom=nomX then begin
         result := i;
         exit;
       end;
end;

var
  i : integer;
  p : TcodePage;
  courbeAdd : Tcourbe;
  x,y : Tvecteur;
  mondeLoc : TindiceMonde;
begin // SetCoordonnee
with graphes[indexGr] do begin
   indexReticuleModele := -1;
   ResiduNormalise := false;
   VerifCoordonnee(indexGr);
   courbeModele := nil;
   indexCourbeModele := -1;
   indexCourbeEquivalence := -1;
   CourbeExpAffectee := false;
   SimulationAffectee := false;
   mondeLoc := mondeY;
   withModele := not(splitterModele.snapped);
   for p := 1 to NbrePages do Pages[p].tri;
   for i := 1 to maxOrdonnee do with Coordonnee[i] do
     if codeX<>grandeurInconnue then begin
        if superposePage and
           (NbrePages>1) and
           (OgAnalyseurLogique in OptionGraphe) then mondeLoc := mondeY;
        if OgPolaire in OptionGraphe then begin
            iMondeC := mondeY;
            if (i=1) then if codeY=grandeurInconnue
                  then monde[mondeY].Axe := nil
                  else monde[iMondeC].Axe := grandeurs[codeY];
        end;
        if not(splitterModele.snapped) then begin
              include(trace,trLigne);
              ligne := liModele;
              include(trace,trPoint);
        end;
        if superposePage and (NbrePages>1)
           then for p := 1 to NbrePages do begin
              if pages[p].active then 
                 if OgAnalyseurLogique in OptionGraphe
                      then begin
                          AjouteVariab(mondeLoc,i,p);
                          inc(mondeLoc);
                      end
                      else AjouteVariab(iMondeC,i,p)
           end
           else AjouteVariab(iMondeC,i,pageCourante);
     end;
   if (ModeleDefini in etatModele) and
      withModele and
      not(CourbeExpAffectee) then with courbes[0] do begin
              courbeAdd := AjouteCourbe(
                   valX,valY,iMondeC,pages[page].nmes,
                   varX,varY,page);
              courbeAdd.debutC := pages[page].debut[1];
              courbeAdd.finC := pages[page].fin[1];
              courbeAdd.trace := [trPoint];
              with pages[page] do begin
                 courbeAdd.IncertX := incertVar[varX.indexG];
                 courbeAdd.IncertY := incertVar[varY.indexG];
              end;
              with Coordonnee[1] do begin
                   courbeAdd.setStyle(couleur,styleT,motif);
                   if couleurPoint<>'' then
                      courbeAdd.setStylePoint(couleurPoint,codeCouleur);
              end;
              courbeAdd.courbeExp := true;
              courbeAdd.indexModele := 1;
   end;
   if (SimulationDefinie in etatModele) and
       not(splitterModele.snapped) and
       not(SimulationAffectee) and
       (courbes.count>0) then begin
                 i := courbes.count;
                 repeat dec(i)
                 until (i<0) or
                       (fonctionSuperposee[1].indexY=courbes[i].varY.indexG);
                 if i>=0 then begin
                    setLength(x,pages[pageCourante].nmesMax+1);
                    setLength(y,pages[pageCourante].nmesMax+1);
                    courbeAdd := AjouteCourbe(x,y,
                         courbes[i].iMondeC,pages[pageCourante].nmes,
                         courbes[i].varX,courbes[i].varY,pageCourante);
                    courbeAdd.IndexModele := -1;
                    fonctionSuperposee[1].indexX := courbes[i].varX.indexG;
                    with coordonnee[i] do begin
                        courbeAdd.setStyle(couleurModele[-1],styleT,motif);
                        if couleurPoint<>'' then
                           courbeAdd.setStylePoint(couleurPoint,codeCouleur);
                    end;
                    courbeAdd.Trace := [trLigne];
                    courbeAdd.Adetruire := true;
                 end;   
   end;
   include(modif,gmEchelle);
   grapheOK := true;
   if indexGr=1 then
      AbscisseCB.itemIndex := indexVariable(graphes[1].coordonnee[1].nomX);
end end; // SetCoordonnee 

procedure TFgrapheVariab.VerifCoordonnee(indexGr : integer);

procedure VerifVotable;
var i : integer;
begin
    for i := 0 to NbreVariab do begin
        if grandeurs[indexVariab[i]].nom = stLongitude then begin
            graphes[1].optionGraphe := [OgOrthonorme,OgPolaire];
            graphes[1].optionModele := [];
            graphes[1].coordonnee[1].Trace := [trPoint];
            ordreLissage := 3;
            dimPointVGA := 4;
            graphes[1].coordonnee[1].nomX := stLongitude;
            graphes[1].coordonnee[1].codeX := indexNom(stLongitude);
            graphes[1].coordonnee[1].nomY := 'Distance';
            graphes[1].coordonnee[1].codeY := indexNom('Distance');
            graphes[1].nbreOrdonnee := 1;
            break;
        end;
    end;
end;

var i : integer;
    avecAxe : boolean;
    avecIncert : boolean;
begin with graphes[indexGr] do begin
    avecIncert := false;
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        if (codeY>maxGrandeurs) or
           not (grandeurs[codeY].genreG in [variable,constante,constanteGlb])
           then codeY := grandeurInconnue;
        codeX := indexNom(nomX);
        if (codeX<>grandeurInconnue) and
           not (grandeurs[codeX].genreG in [variable,constante,constanteGlb])
           then codeX := grandeurInconnue;
    end;
    nbreOrdonnee := 0;
    for i := 1 to maxOrdonnee do with coordonnee[i] do
        if (codeX<>grandeurInconnue) and
           (codeY<>grandeurInconnue)
           then begin
              inc(nbreOrdonnee);
              coordonnee[nbreOrdonnee] := coordonnee[i];
              avecIncert := avecIncert or
                 grandeurs[codeY].incertDefinie or
                 grandeurs[codeX].incertDefinie;
           end;
    for i := succ(NbreOrdonnee) to maxOrdonnee do with coordonnee[i] do begin
           codeX := grandeurInconnue;
           codeY := grandeurInconnue;
           iMondeC := mondeY;
           nomX := '';
           nomY := '';
           couleurPoint := '';
           ligne := liDroite;
    end;
    if nbreOrdonnee=0 then verifVotable;
    if nbreOrdonnee=0 then begin
       Dessins.clear;
       for i := mondeX to MaxOrdonnee do Monde[i].graduation := gLin;
       with coordonnee[1] do begin
          codeX := indexVariab[0];
          nomX := grandeurs[codeX].nom;
          curseur := curSelect;
          codeY := indexVariab[1];
          nomY := grandeurs[codeY].nom;
          iMondeC := mondeY;
          nbreOrdonnee := 1;
       end;
       with coordonnee[2] do begin
          codeY := indexVariab[2];
          if (codeY<>grandeurInconnue) and
             (grandeurs[codeY].fonct.genreC=g_experimentale) then begin
             codeX := indexVariab[0];
             nomX := grandeurs[codeX].nom;
             nomY := grandeurs[codeY].nom;
             if unitesEgales(grandeurs[codeY],grandeurs[coordonnee[1].codeY])
                then iMondeC := mondeY
                else iMondeC := mondeDroit;
             nbreOrdonnee := 2;
          end;
       end;
    end // nbreOrdonnee=0
    else begin
        AvecAxe := false;
        for i := 1 to NbreOrdonnee do with coordonnee[i] do
            if iMondeC<>mondeSans then avecAxe := true;
        if not AvecAxe then coordonnee[1].iMondeC := mondeY;
    end;
    incertBtn.enabled := avecIncert;
    AffIncert.enabled := avecIncert;
    if not avecIncert then begin
       avecEllipse := false;
       incertBtn.down := false;
       incertBtn.ImageIndex := incertNobitmap;
       AffIncert.checked := false;
    end;
end end; // VerifCoordonnee(indexGr : integer);

procedure TFgrapheVariab.FormResize(Sender: TObject);
var i : integer;
begin  // arrive après le dimensionnement
    if not(splitterModele.snapped) then AjustePanelModele;
    if PanelBis.visible
        then if residusItem.checked
            then PanelBis.Width := PanelCentral.width div 3
            else PanelBis.Width := PanelCentral.width div 2
        else PanelBis.Width := 0;
    if PaintBox3.visible
        then if not(splitterModele.snapped) and residusItem.checked
            then PaintBox3.height := panelPrinc.height div 3
            else PaintBox3.height := panelPrinc.height div 2
        else PaintBox3.height := 0;
    if not animationNone.checked and not majFichierEnCours then begin
       clearGrapheAnim := true;
       for i := 1 to 3 do modifGraphe(i);
    end;
    if RandomBtn.visible then
       ToolBarGraphe.List := (RandomBtn.Left+randomBtn.Width)<PanelCentral.width
       else if CornishBtn.visible then
       ToolBarGraphe.List := (CornishBtn.Left+CornishBtn.width)<PanelCentral.width
       else if CopierBtn.visible then
       ToolBarGraphe.List := (CopierBtn.Left+CopierBtn.width)<PanelCentral.width
end;

procedure TFgrapheVariab.CoordonneesItemClick(Sender: TObject);
var oldnomx,oldnomy : string;
begin
if FcoordonneesPhys=nil then
   Application.CreateForm(TFcoordonneesPhys, FcoordonneesPhys);
with FcoordonneesPhys do begin
        grapheCourant := graphes[indexGrCourant];
        if not grapheCourant.grapheOK then exit;
        Agraphe := grapheCourant;
        ListeConst := false;
        oldNomX := grapheCourant.coordonnee[1].nomX;
        oldNomY := grapheCourant.coordonnee[1].nomY;
        modeleEnCours := not(splitterModele.snapped) and (NbreModele>0);
        modelePermis := NbreModele>0;
        Transfert.AssignEntree(grapheCourant);
        if FcoordonneesPhys.ShowModal=mrOK then begin
           Curseur := curSelect;
           orthoAverifier := true;
           Transfert.AssignSortie(grapheCourant);
           include(grapheCourant.modif,gmXY);
           if (grapheCourant.coordonnee[1].nomX<>oldNomX) or
              (grapheCourant.coordonnee[1].nomY<>oldNomY) then begin
              if not grapheCourant.UseDefaut then grapheCourant.Dessins.clear;
              if curseur in [curReticuleData,curReticuleDataNew,curModele] then curseur := curSelect;
           end;
           ModifGraphe(indexGrCourant);
           if indexGrCourant>1 then begin
             graphes[1].pasPoint := grapheCourant.pasPoint;
             OptionGrapheDefault := grapheCourant.OptionGraphe;
           end;
           if PanelAnimation.visible then ZoomAutoItemClick(sender);
           if not(splitterModele.snapped) and
              not modeleEnCours then begin
                nbreModele := 0;
                etatModele := [];
                setPanelModele(false);
           end;
        end;// OK
end end; // CoordonneesItemClick

procedure TFgrapheVariab.ZoomAutoItemClick(Sender: TObject);
begin
     curMovePermis := false;
     if not grapheCourant.grapheOK then exit;
     include(grapheCourant.modif,gmEchelle);
     grapheCourant.monde[mondeX].defini := false;
     grapheCourant.useDefaut := false;
     grapheCourant.useDefautX := false;
     grapheCourant.useZoom := false;
     grapheCourant.autoTick := true;
     modifGraphe(indexGrCourant);
end; // ZoomAutoItemClick

procedure TFgrapheVariab.CopierItemClick(Sender: TObject);
begin
     GrapheCourant.VersPressePapier(grapheClip)
end;

procedure TFgrapheVariab.WMRegMaj(var Msg : TWMRegMessage);

procedure RazCoord;
var i,j,m : integer;
    UnitePrec : string;
begin
    Curseur := curSelect;
    IsModeleMagnum := false;
    j := 1;
    m := mondeY;
    UnitePrec := '';
    IntersectionItem.visible := false;
    IntersectionTer.visible := false;
    for i := 1 to pred(NbreVariab) do with graphes[1].Coordonnee[j] do begin
        codeY := indexVariab[i];
        ligne := LiDroite;
        trace := [trLigne];
        if grandeurs[codeY].fonct.genreC=g_experimentale then begin
             codeX := indexVariab[0];
             nomX := grandeurs[codeX].nom;
             nomY := grandeurs[codeY].nom;
             if (j>1) and (UnitePrec<>grandeurs[codeY].nomUnite) then inc(m);
             UnitePrec := grandeurs[codeY].nomUnite;
             iMondeC := m;
             graphes[1].monde[m].graduation := gLin;
             inc(j);
             if (j>maxOrdonnee) or (m>mondeSans) then break;
        end
    end;
    for i := 1 to 3 do with graphes[i] do if paintBox.visible then begin
        useDefaut := false;
        useZoom := false;
        useDefautX := false;
        Dessins.clear;
    end;
    IdentAction.checked := false;
    for i := 1 to MaxPages do ModeleCalc[i] := false;
end; // RazCoord

Procedure FaireMajFichier;

(*
{$IFDEF Debug}
procedure creerFichierConfig;
var sauveNom : string;
begin
     sauveNom := nomFichierIni;
     nomFichierIni := mesDocsDir+'Regressi0.ini';
     optionsDlg.sauveOptions;
     nomFichierIni := sauveNom;
end;
{$ENDIF}
*)

var i : integer;
    ouvrirModele : boolean;
begin
{$IFDEF Debug}
   ecritDebug('Début FaireMajFichier');
 //  creerFichierConfig;
{$ENDIF}
       etatModele := [];
       setPenBrush(curSelect);
       Fvaleurs.prevenirPi := true;
       PrevenirTri := true;
       InitManuelleAfaire := true;
       if dispositionFenetre=dMaxi
          then WindowState := wsMaximized
          else WindowState := wsNormal;
       MajFichierEnCours := false;
       monteCarloActif := false;
       MajModelePermis := false;
       OuvrirModele := false;
       MemoModele.Clear;
//       MemoModele.Text := TexteModele.text;
       for i := 0 to pred(TexteModele.count) do begin
           MemoModele.Lines.Add(TexteModele[i]);
           if TexteModele[i]<>'' then OuvrirModele := true;
       end;
       MajModelePermis := true;
       MemoModeleChange(nil);
       if configCharge
         then begin
              for i := 1 to NbrePages do begin
                    pages[i].modeleCalcule := ModeleCalc[i];
                    pages[i].modeleErrone := false;
              end
         end
         else RazCoord;
       if choixIdentPagesDlg<>nil then choixIdentPagesDlg.initParam;
       case nbreGraphe of
            UnGr : DeuxGraphesVertClick(UnGrapheItem);
            DeuxGrVert : DeuxGraphesVertClick(DeuxGraphesVert);
            DeuxGrHoriz : DeuxGraphesVertClick(DeuxGraphesHoriz);
       end;
       if (ModeleCalc[1] or OuvrirModele) and splitterModele.enabled then
           setPanelModele(true);
       if ModeleCalc[1] then PostMessage(handle,WM_Reg_Calcul,CalculAjuste,0);
       if animationTemps.checked
          then AnimationTempsClick(nil)
          else if animationParam.checked
             then AnimationParamClick(nil)
             else begin
                videoTrackBar.Visible := false;
             end;
{$IFDEF Debug}
   ecritDebug('Fin FaireMajFichier');
{$ENDIF}
end;  // FaireMajFichier

procedure ResetForme;
var i,j : integer;
begin
    for i := 1 to MaxParametres do
        PanelParam[i].visible := false;
    majFichierEnCours := true;
    configCharge := false;
    animationNone.checked := true;
    setPenBrush(curSelect);
    for i := 1 to 3 do with graphes[i] do if paintBox.Visible then begin
        include(Modif,gmXY);
        Dessins.clear;
        grapheOK := false;
        curseurActif := curSelect;
        for j := mondeX to mondeSans do monde[j].axe := nil;
        ResetEquivalence;
        OptionGraphe := OptionGrapheDefault;(***)
        Raz;
    end;
    IntersectionItem.visible := false;
    IntersectionTer.visible := false;
    Fvaleurs.prevenirPi := true;
    PrevenirTri := true;
    UnGrapheItem.checked := true;
    MemoModele.Clear;
    MemoResultat.Clear;
    etatModele := [];
    VerifGraphe := true;
    monteCarloActif := false;
    if not(splitterModele.snapped) then setPanelModele(false);
    if PanelAnimation.visible then cacheAnim;
    videoTrackBar.visible := false;
    for i := 0 to maxParamAnim do
        paramAnimManuelle[i].init;
    InitManuelleAfaire := true;
    nbreGraphe := UnGr;
    PanelBis.visible := false;
    PaintBox2.visible := false;
    PaintBox3.visible := false;
    residusNormalisesCB.visible := false;
    ModelePagesIndependantesMenu.checked := false;
    ModelePagesIndependantes := false;
    RepeatTimer.enabled := false;
    TimerAnim.enabled := false;
    IsModeleMagnum := false;
    for i := 1 to MaxPagesGr do
        if ConfigGraphe[i]<>nil then begin
           ConfigGraphe[i].free;
           ConfigGraphe[i] := nil;
        end;
end;

procedure MajOrdreGrandeurs;
var i,iVar : integer;
begin
    for i := 0 to (ToolBarGrandeurs.ButtonCount-2) do begin
        // le dernier est l'aide : labelToolBar
        ToolBarGrandeurs.Buttons[i].visible := i<NbreVariab;
        if i<NbreVariab then begin
              iVar :=  indexVariab[i];
              ToolBarGrandeurs.Buttons[i].caption := grandeurs[iVar].nom;
              ToolBarGrandeurs.Buttons[i].tag := iVar;
              ToolBarGrandeurs.Buttons[i].Hint := 'Clic '+grandeurs[iVar].nom+'=ordonnée ; clic droit : à droite'
        end;
    end;
    if NbreVariab>0 then begin
       abscisseCB.Items.Clear;
       for i := 0 to pred(NbreVariab) do
              abscisseCB.Items.Add(grandeurs[indexVariab[i]].nom)
    end;
end;

procedure resetEtatModele;
var i : integer;
begin
    if etatModele<>[] then begin
         etatModele := [];
         majBtn.Enabled := true;
         hintMemoResultat.clear;
         hintResultatLabel.visible := false;
         for i := 1 to NbrePages do begin
            pages[i].ModeleCalcule := false;
            pages[i].ModeleErrone := false;
            pages[i].paramAjustes := false;
         end;
         MajResultat;
    end;
end;

var i,j : integer;
    m : shortInt;
    LmodifParam : boolean;
begin // WMRegMaj
      include(Graphes[1].Modif,gmXY); // le + général
      case msg.TypeMaj of
          MajNom : for i := 1 to 3 do
              graphes[i].MajNomGr(msg.codeMaj);
          MajSauvePage : begin
              if not(splitterModele.snapped) and ModelePagesIndependantesMenu.checked then begin
                 ModelePagesIndependantes := true;
                 Pages[pageCourante].TexteModeleP.text := texteModele.text;
              end;
              Graphes[1].Modif := [];
          end;
          MajChangePage,MajSupprPage : begin
              if (curseur in [curReticuleData,curReticuleDataNew]) or // curReticuleModele
                 not graphes[1].superposePage
                    then include(graphes[1].Modif,gmPage)
                    else graphes[1].Modif := [];
              if GraphePageIndependante and
                 (ConfigGraphe[pageCourante mod maxPagesGr]<>nil) then begin
                   ConfigGraphe[pageCourante mod MaxPagesGr].AssignSortie(graphes[1]);
                   include(Graphes[1].modif,gmXY);
                   include(Graphes[1].modif,gmOptions);
              end;
              if not(splitterModele.snapped) then begin
                 MajParametres;
                 include(graphes[1].Modif,gmValeurModele);
                 if ([ModeleDefini,ModeleConstruit] <= etatModele) and
                    (pages[pageCourante].ModeleCalcule) then MajResultat;
              end;
              if not(splitterModele.snapped) and
                 ModelePagesIndependantesMenu.checked and
                 (Pages[pageCourante].TexteModeleP.count>0) then begin
                    MajModelePermis := false;
                    ModelePagesIndependantes := true;
                    MemoModele.clear;
                    MemoModele.Lines := pages[pageCourante].TexteModeleP;
                    MajModelePermis := true;
                    etatModele := [];
                    LanceModele(true); // RàZ Modéle
              end;
              if ([ModeleDefini,ModeleConstruit] <= etatModele)
                 and not(pages[pageCourante].ModeleCalcule)
                 and not(pages[pageCourante].ModeleErrone)
                 and not ModelePagesIndependantes
                 and not(splitterModele.snapped)
                 then if isModeleMagnum
                     then PostMessage(handle,Wm_Reg_InitMagnum,0,0)
                     else if pages[1].ModeleCalcule
                          then PostMessage(handle,Wm_Reg_Calcul,CalculAjuste,0)
          end;
          MajAjoutPage : begin
              if (curseur in [curReticuleData,curReticuleDataNew]) or // curReticuleModele
                  not graphes[1].superposePage
                    then include(graphes[1].Modif,gmPage)
                    else graphes[1].Modif := [];
              pages[PageCourante].modeleErrone := pages[1].modeleErrone;
              if not(splitterModele.snapped) then begin
                 MajParametres;
                 include(graphes[1].Modif,gmValeurModele);
              end;
              if ModelePagesIndependantes then etatModele := [];
              if ([ModeleDefini,ModeleConstruit] <= etatModele) and
                 not(pages[1].ModeleErrone) and
                 not(splitterModele.snapped)
                 then if isModeleMagnum
                     then PostMessage(handle,Wm_Reg_InitMagnum,0,0)
                     else if pages[1].ModeleCalcule
                         then PostMessage(handle,Wm_Reg_Calcul,CalculAjuste,0)
          end;
          MajSelectPage : with Graphes[1] do begin
                include(modif,gmXY);
                include(modif,gmOptions);
                if msg.codeMaj<>0 then SuperposePage := msg.codeMaj>1;
          end;
          MajGroupePage : include(Graphes[1].modif,gmOptions);
          MajValeurAcq,MajValeur,MajIncertitude : begin
              include(Graphes[1].Modif,gmValeurs);
              MemoModeleChange(nil);
          end;
          MajEquivalence : Graphes[1].Modif := [gmEquivalence];
          MajValeurConst : begin
              include(Graphes[1].Modif,gmValeurs);
              InitManuelleAfaire := true;
              if AnimationParam.checked then setAnimManuelle;
          end;
          MajSupprPoints : Graphes[1].Modif := [gmValeurs];
          MajValeurGr : begin
              include(Graphes[1].Modif,gmValeurs);
              MemoModeleChange(nil);
          end;
          MajAjoutValeur : begin
              Graphes[1].Modif := [gmValeurs];
              MemoModeleChange(nil);
              for m := 1 to NbreModele do with pages[pageCourante] do
                  if (debut[m]=0) and
                     ((fin[m]=-1) or (fin[m]=nmes-2)) then
                     fin[m] := pred(nmes)
          end;
          MajTri : begin
              MajOrdreGrandeurs;
              if active then exit;
          end;
          MajPolice : begin
             setTaillePolice;
             Graphes[1].Modif := [];
             exit;
          end;
          MajPreferences : begin
             InitiationAfaire := imInitiationModele in menuPermis;
             ModeleGrBtn.visible := imModeleGr in menuPermis;
             AnimBtn.visible := imAnimation in menuPermis;
             BornesBtn.visible := imBornes in menuPermis;
             VecteursBtn.Visible := imVitesse in menuPermis;
             Graphes[1].Modif := [];
          end;
          MajModele : if not(splitterModele.snapped) and
                         residusItem.checked and
                         UnGrapheItem.checked then
             setCoordonneeResidu;
          MajVide : begin
             ResetForme;
             exit;
          end;
          MajGrandeur : begin
              if majFichierEnCours
                 then FaireMajFichier
                 else if (etatModele<>[]) and not ajoutGrandeurNonModele
                      then resetEtatModele;
              if NbreVariab>0 then begin
                    AnimationTemps.caption := stAnimation+'=f('+grandeurs[indexTri].nom+')';
                    InitManuelleAfaire := true;
                    if AnimationParam.checked then setAnimManuelle;
              end;
              MajOrdreGrandeurs;
              LabelToolBar.Visible := true;
          end;
          MajUnites : exclude(etatModele,UniteParamDefinie);
          MajUnitesParam : MajResultat;
          MajFichier : if majFichierEnCours then FaireMajFichier else exit;
          MajNumeroMesure : exit;
          MajOptionsGraphe : for i := 1 to 3 do begin
                if OgQuadrillage in optionGrapheDefault
                     then include(graphes[i].optionGraphe,OgQuadrillage)
                     else exclude(graphes[i].optionGraphe,OgQuadrillage);
                if OgZeroGradue in optionGrapheDefault
                     then include(graphes[i].optionGraphe,OgZeroGradue)
                     else exclude(graphes[i].optionGraphe,OgZeroGradue);
          end;
      end;
      LModifParam := msg.TypeMaj in [MajGroupePage,MajSupprPage,MajModele];
      if msg.TypeMaj in [MajIncertitude,MajValeur,MajValeurAcq]
          then begin
             pages[PageCourante].modeleCalcule := false;
             pages[PageCourante].modeleErrone := false;
          end;
      if LModifParam and not(splitterModele.snapped) then begin
           MajParametres;
           MajResultat;
           include(graphes[1].Modif,gmValeurModele);
      end;
      if monteCarloActif then Graphes[1].Modif := []; //??
      if (Graphes[1].Modif<>[]) and not MajFichierEnCours then begin
         if (curseur=curModeleGr) and
            (PageCourante>0) then
               for j := 1 to NbreModele do
                   modeleGraphique[j].setParametres(pages[pageCourante].valeurParam[paramNormal]);
         for i := 2 to 3 do
             (*if residusItem.checked
                then graphes[i].Modif := []
                else *) graphes[i].Modif := graphes[1].Modif;
         for i := 1 to 3 do modifGraphe(i);
      end;
      if not AnimationNone.checked and
         (msg.TypeMaj in [MajChangePage,MajGroupePage,MajSupprPage,MajAjoutPage,MajOptionsGraphe])
          then begin
               for i := 1 to 3 do with graphes[i] do if paintBox.Visible then begin
                   include(Modif,gmPage);
                   grapheOK := false;
               end;
               initManuelleAfaire := true;
               if AnimationParam.checked then setAnimManuelle;
               debutBtnClick(nil);
      end;
      case msg.typeMaj of
           MajSupprPoints : if [ModeleConstruit,ModeleLineaire] <= etatModele
               then LanceModele(true);
           MajChangePage,MajAjoutPage,MajModele,MajSauvePage : ; // déjà fait
           else if not ajoutGrandeurNonModele then begin
                pages[pageCourante].ModeleCalcule := false;
                ResetEtatModele;
          end;
      end;
end; // WMRegMaj

procedure TFgrapheVariab.ImprimerGraphe(var bas : integer);
var i : integer;
begin
    for i := 1 to 3 do if graphes[i].paintBox.Visible then
        if printer.orientation=poLandscape
           then graphes[i].versImprimante(HautGraphePaysage,bas)
           else graphes[i].versImprimante(HautGrapheTxt,bas);
end;

procedure TFgrapheVariab.PaintBoxPaint(Sender: TObject);
var Agraphe : TgrapheReg;

procedure BandeConfiance;
var i,j,im,p,Nbande : integer;
    courbeMax,courbeMin : Tcourbe;
    valeurXmax,valeurYmax,valeurXmin,valeurYmin : Tvecteur;
begin
  Agraphe.ChercheMinMax;
  for i := 0 to pred(Agraphe.courbes.count) do begin
      if Agraphe.courbes[i].indexBande=MaxConfiance then begin
          CourbeMax := Agraphe.courbes[i];
          CourbeMin := Agraphe.courbes[i]; // pour le compilateur
          im := Agraphe.courbes[i].indexModele;
          p := Agraphe.courbes[i].page;
          for j := succ(i) to pred(Agraphe.courbes.count) do begin
                  if (Agraphe.courbes[j].indexBande=MinConfiance) and
                     (Agraphe.courbes[j].page=p) and
                     (Agraphe.courbes[j].indexModele=im) then
                        CourbeMin := Agraphe.courbes[j];
          end;
          with fonctionTheorique[im] do begin
                    valeurXmax := courbeMax.valX;
                    valeurYmax := courbeMax.valY;
                    valeurXmin := courbeMin.valX;
                    valeurYmin := courbeMin.valY;
                    GenereM(valeurXmax,valeurYmax,Agraphe.miniMod,Agraphe.maxiMod,false,Nbande);
                    pages[p].stat2.init(pages[p].valeurVar[indexX],
                                        pages[p].valeurVar[indexY],
                                        pages[p].debut[im],pages[p].fin[im]);
                    pages[p].stat2.genereBande(valeurXmin,valeurYmin,valeurXmax,valeurYMax,Nbande,true);
                    CourbeMax.FinC := Nbande;
                    CourbeMin.FinC := Nbande;
          end;// fonctionTheorique
      end;
      if Agraphe.courbes[i].indexBande=MaxPrediction then begin
          CourbeMax := Agraphe.courbes[i];
          CourbeMin := Agraphe.courbes[i]; // pour le compilateur
          im := Agraphe.courbes[i].indexModele;
          p := Agraphe.courbes[i].page;
          for j := succ(i) to pred(Agraphe.courbes.count) do begin
                  if (Agraphe.courbes[j].indexBande=MinPrediction) and
                     (Agraphe.courbes[j].page=p) and
                     (Agraphe.courbes[j].indexModele=im) then
                        CourbeMin := Agraphe.courbes[j];
          end;
          with fonctionTheorique[im] do begin
                    valeurXmax := courbeMax.valX;
                    valeurYmax := courbeMax.valY;
                    valeurXmin := courbeMin.valX;
                    valeurYmin := courbeMin.valY;
                    GenereM(valeurXmax,valeurYmax,Agraphe.miniMod,Agraphe.maxiMod,false,Nbande);
                    pages[p].stat2.init(pages[p].valeurVar[indexX],
                                        pages[p].valeurVar[indexY],
                                        pages[p].debut[im],pages[p].fin[im]);
                    pages[p].stat2.genereBande(valeurXmin,valeurYmin,valeurXmax,valeurYMax,Nbande,false);
                    CourbeMax.FinC := Nbande;
                    CourbeMin.FinC := Nbande;
          end;// fonctionTheorique
      end;
  end;
end; // BandeConfiance

Procedure TestModif(indexGr : integer);
(*
{$IFDEF Debug}
procedure creerFichierConfig(numero : integer);
var nomFichier : string;
begin
     nomFichier := mesDocsDir+'RegressiconfigGraphe'+intToStr(numero)+'.txt';
     AssignFile(fichier,NomFichier);
     Rewrite(fichier);
     ecritConfig;
     CloseFile(fichier);
end;
{$ENDIF}
*)

var i : integer;
begin
{$IFDEF Debug}
   ecritDebug('Appel testModif');
  // creerFichierConfig(1);
{$ENDIF}
        if (([gmXY,gmModele,gmPage,gmValeurs]*Agraphe.modif)<>[]) or
           (Agraphe.courbes.count=0)
            then begin
               if ([gmValeurs]=Agraphe.modif) or Agraphe.UseDefaut or Agraphe.UseZoom
                   then Agraphe.courbes.clear
                   else begin
                       Agraphe.raz;
                       if not (gmPage in Agraphe.modif) and
                          not (gmValeurs in Agraphe.modif) and
                          not configCharge then
                             Agraphe.resetEquivalence;
                   end;
              if (indexGr<>1) and residusItem.checked
                  then setCoordonneeResidu
                  else setCoordonnee(indexGr);
              if Agraphe.UseDefaut or Agraphe.useZoom then with Agraphe do begin
                  monde[mondeX].defini := true;
                  for i := 1 to maxOrdonnee do with Coordonnee[i] do
                      if codeX<>grandeurInconnue then
                         monde[iMondeC].defini := true;
               end;
               {$IFDEF Debug}
                   ecritDebug('Sortie testModif');
              //     creerFichierConfig(2);
               {$ENDIF}
            end;
end;

procedure MajIntersection;

procedure Supprime(i : integer);
var
    j : integer;
    equ : Tequivalence;
begin
    j := 0;
    while j<Agraphe.equivalences[pageCourante].count do begin
        equ := Agraphe.equivalences[pageCourante].items[j];
        if (equ.ligneRappel=lrReticule) and (equ.indexModele=i)
            then Agraphe.equivalences[pageCourante].Delete(j)
            else inc(j);
    end;
end;

var i,j : integer;
    equ : Tequivalence;
    trouve : boolean;
begin
  if not intersectionItem.visible or
     not intersectionItem.checked or
     (NbreModele<2)
     then begin // suppression
         for i := 2 to maxIntervalles do Supprime(i);
         exit;
     end;
  for i := 2 to nbreModele do begin
     if isIncorrect(pages[pageCourante].X_inter[i]) or
        isIncorrect(pages[pageCourante].Y_inter[i])
     then supprime(i)
     else begin
        trouve := false;
        for j := 0 to Pred(Agraphe.equivalences[pageCourante].count) do begin
             equ := Agraphe.equivalences[pageCourante].items[j];
             if (equ.ligneRappel=lrReticule) and (equ.indexModele=i) then begin
                trouve := true;
                equ.ve := pages[pageCourante].X_inter[i];
                equ.phe := pages[pageCourante].Y_inter[i];
                break;
             end;
        end;
        if not trouve then begin
             equ := Tequivalence.create(0,0,0,0,
                 pages[pageCourante].X_inter[i],
                 pages[pageCourante].Y_inter[i],
                 0,agraphe);
             equ.mondepH := mondeY;
             equ.varY := Agraphe.monde[mondeY].axe;
             equ.indexModele := i;
             equ.ligneRappel := lrReticule;
             ligneRappelCourante := lrReticule;
             Agraphe.Equivalences[pageCourante].Add(equ);
        end;
     end;
  end;
  for i := succ(nbreModele) to maxIntervalles do supprime(i);
end; // MajIntersection

var i,j : integer;
    indexGr : integer;
label finProc;
begin // PaintBoxPaint
        if (pageCourante=0)
           or majFichierEnCours
           or lecturePage
           or sizing
              then exit;
{$IFDEF Debug}
   ecritDebug('Début paintBoxPaint');
{$ENDIF}
        indexGr := (sender as Tcontrol).tag;
        if indexGr<1 then indexGr := 1;
        Agraphe := graphes[indexGr];
        Agraphe.grapheOK := (NbreVariab>1) and (NbrePages>0);
        if (indexGr<>1) and residusItem.checked and
           not (Agraphe.grapheOK and
                pages[pageCourante].modeleCalcule and
                (ModeleDefini in etatModele) and
                (ModeleConstruit in etatModele)) then begin
                   Agraphe.canvas.TextOut(Agraphe.paintBox.clientRect.right div 2,
                                          Agraphe.paintBox.clientRect.bottom div 2,
                                          'Non disponible ; cliquer sur ajuster');
                   goto finProc;
        end;
        if not Agraphe.grapheOK then begin
           Agraphe.raz;
           Agraphe.resetEquivalence;
           Agraphe.optionGraphe := optionGrapheDefault;
           setBoutonAnim(false);
           goto finProc;
        end;
        if paintBox1=sender then begin
           AbscisseCB.Top := paintBox1.top+graphes[1].monde[mondeX].yTitre;
           AbscisseCB.left := paintBox1.left+graphes[1].monde[mondeX].xTitre-abscisseCB.width;
        end;
        incertBtn.down := avecEllipse;
        if avecEllipse
           then incertBtn.ImageIndex := incertYesbitmap
           else begin
              incertBtn.ImageIndex := incertNobitmap;
              for j := 0 to Agraphe.courbes.count-1 do
                  with Agraphe.courbes[j] do
                    if (motif=mIncert) then motif := TMotif(j);
           end;
        Agraphe.canvas := Agraphe.paintBox.canvas;
        Agraphe.limiteFenetre := Agraphe.paintBox.clientRect;
        Agraphe.avecAnimTemporelle := false;
        setBoutonAnim(true);
        if AnimationTemps.checked then begin
           AfficheAnimationTemporelle;
           goto finProc;
        end;
        if AnimationParam.checked then begin
           AfficheAnimationManuelle;
           goto finProc;
        end;
        ZoomManuelBtn.down := Agraphe.UseDefaut;
        if ZoomManuelBtn.down
           then begin
              ZoomManuelBtn.imageIndex := 38;
              ZoomManuelBtn.hint := hZoomManuelDebloq;
              ZoomAutoBtn.imageIndex := 38;
              ZoomAutoBtn.hint := hZoomAutoBloq;
           end
           else begin
              ZoomManuelBtn.imageIndex := 17;
              ZoomManuelBtn.hint := hZoomManuelBloq;
              ZoomAutoBtn.imageIndex := 18;
              ZoomAutoBtn.hint := 'Echelle automatique';
           end;
        Agraphe.curseurActif := curseur;
        PanelAjuste.enabled := false;
        TestModif(indexGr);
        if not Agraphe.useDefaut and (Pages[pageCourante].nmes>0) then begin
           Agraphe.miniTemps := Pages[pageCourante].valeurVar[0,0];
           Agraphe.maxiTemps := Pages[pageCourante].valeurVar[0,pred(Pages[pageCourante].nmes)];
        end;
        IdentAction.enabled :=
           (grapheCourant.superposePage
            and (NbrePages>1) )  or
           (grapheCourant.NbreOrdonnee>1);
        if ((gmEchelle in Agraphe.modif) or
            (gmValeurModele in Agraphe.modif) or
            ((gmPage in Agraphe.modif) and
              pages[pageCourante].modeleCalcule)) then
                AffecteModele(indexGr);
        if ([ModeleConstruit,ModeleLineaire] <= etatModele) and
            (withBandeConfiance or withBandePrediction) then BandeConfiance;
        Agraphe.chercheMonde;
        if not Agraphe.grapheOK then goto finProc;
        if (curseur=curModeleGr) and (NbreModele>2) then curseur := curSelect;
        if curseur=curModeleGr then for j := 1 to NbreModele do
           with ModeleGraphique[j] do
                for i := 1 to indexPointMax[genre] do
                    Agraphe.AjoutePoint(mondeY,xs[i],ys[i]);
        if ((gmEchelle in Agraphe.modif) or (pages[pageCourante].nmes<128)) and
           (omExtrapole in Agraphe.OptionModele) then begin
              ZoomModele(indexGr);
              ZoomSuperpose(indexGr);
        end;
        Agraphe.canvas.Pen.mode := pmCopy;
        MajIdentPage;
        Agraphe.setEchelle(Agraphe.canvas);
        Agraphe.canvas.brush.Color := clWindow;
        Agraphe.canvas.brush.style := bsSolid;
        Agraphe.canvas.FillRect(Agraphe.paintBox.clientRect);
        Agraphe.avecBorne := not(splitterModele.snapped);
        MajIntersection;
{$IFDEF Debug}
   ecritDebug('Appel graphe.draw');
{$ENDIF}
        Agraphe.draw;
{$IFDEF Debug}
   ecritDebug('sortie graphe.draw');
{$ENDIF}
        Agraphe.resetEchelle;
        if active then begin
           setPenBrush(curseur);
           if curseur=curModeleGr
              then for j := 1 to NbreModele do modeleGraphique[j].DessineTout
              else traceCurseurCourant(indexGr);
        end;
        if (curseur=curEquivalence) and
           ((Agraphe.indexCourbeEquivalence<0) or
            (Agraphe.indexCourbeEquivalence>=Agraphe.courbes.count))
              then Agraphe.setCourbeDerivee;
        Agraphe.modif := [];
        if DeuxGraphesVert.checked or
           DeuxGraphesHoriz.checked
           then Agraphe.EncadreTitre(Agraphe=grapheCourant);
        if orthoAverifier and Agraphe.VerifierOrtho then begin
             afficheErreur(erOrtho,0);
             Agraphe.verifierOrtho := false;
             orthoAverifier := false;
        end;
        if Agraphe.VerifierInv then begin
             afficheErreur(erInv,0);
             Agraphe.verifierInv := false;
        end;
        if VerifierLog then begin
             afficheErreur(erAxeLog,0);
             verifierLog := false;
        end;
        if GraphePageIndependante then begin
           if ConfigGraphe[pageCourante mod maxPagesGr]=nil then
              ConfigGraphe[pageCourante mod maxPagesGr] := TtransfertGraphe.Create;
           ConfigGraphe[pageCourante mod maxPagesGr].AssignEntree(graphes[1]);
        end;
        finProc :
        VecteursBtn.visible := (agraphe.courbes.Count>0) and agraphe.grapheOK;
        if vecteursBtn.Visible then with agraphe.courbes[0] do VecteursBtn.visible :=
            (varX<>nil) and (varY<>nil) and
            (varX<>grandeurs[0]) and (varY<>grandeurs[0]);
        borneSelect.style := bsAucune;
        PanelAjuste.enabled := true;
        if curseur<>curMove then begin
           IndexPointCourant := -1;
           CourbePointCourant := 0;
        end;
        if (PropCourbeForm<>nil) and
           PropCourbeForm.visible and
           Agraphe.grapheOK then begin
            if (iPropCourbe>Agraphe.NbreOrdonnee) or
               (iPropCourbe<1) then iPropCourbe := 1;
            PropCourbeForm.Acourbe := Agraphe.coordonnee[iPropCourbe];
            PropCourbeForm.MaJ;
        end;
        if Agraphe.curseurActif=CurReticuleDataNew then with Agraphe.curseurOsc[curseurData1] do begin
           for i := 0 to Agraphe.courbes.Count-1 do
               if (trLigne in Agraphe.courbes[i].trace) and
                  (Agraphe.courbes[i].page=pageCourante) then begin
                     indexCourbe := i;
                     mondeC := Agraphe.courbes[i].imondeC;
                     break;
               end;
           mondeC := Agraphe.courbes[indexCourbe].iMondeC;
           grandeurCurseur := Agraphe.courbes[indexCourbe].varY;
        end;
{$IFDEF Debug}
   ecritDebug('Fin paintBoxPaint');
{$ENDIF}
end; // PaintBoxPaint

procedure TFgrapheVariab.SetPanelModele(avecModele : boolean);
begin
   if not splitterModele.enabled or not grapheCourant.grapheOK then avecModele := false;
   SplitterModele.snapped := not avecModele;
   setPanelParam;
end;

procedure TFgrapheVariab.SetPanelParam;
var i : integer;
begin
   if splitterModele.snapped
      then begin
        ModeleItem.checked := false;
        if ModeleDefini in etatModele then
        for i := 1 to Graphes[1].NbreOrdonnee do
            with Graphes[1].Coordonnee[i] do begin
                 include(trace,trLigne);
                 ligne := liModele;
                 include(trace,trPoint);
            end;
      end
      else begin
           ModeleGrBtn.visible := imModeleGr in MenuPermis;
           BornesBtn.visible := imBornes in menuPermis;
           TraceAutoCB.checked := not(OmManuel in Graphes[1].OptionModele);
           PanelModele.invalidate;
           VerifGraphe := false;
           ModeleItem.checked := true;
           AnimationNone.checked := true;
           if not(ModeleDefini in etatModele)
               then LanceCompile;
           MajParametres;
           Resize;
           MemoModele.setFocus;
     end;
     setBoutonAnim(true);
end;

procedure TFgrapheVariab.AjusteBtnClick(Sender: TObject);
begin
// vérification : entrée dans éditeur paramètres à valider
     if (activeControl<>nil) and
        (activeControl.width=editValeur1.width) and
        (activeControl.height=editValeur1.height) and
        (activeControl.tag>0)
            then ValideParam(activeControl.tag,false);
     LanceModele(true)
end;

procedure TFgrapheVariab.MemoModeleChange(Sender: TObject);
var i : TcodePage;
begin
if monteCarloActif then exit;
if MajModelePermis then begin
     MajModelePermis := false;
     etatModele := [];
     if NbrePages=0 then begin
        MemoModele.clear;
        MajModelePermis := true;
        exit;
     end;
     MemoResultat.clear;
     hintMemoResultat.clear;
     hintResultatLabel.visible := false;
     if length(MemoModele.text)>5 then begin
        memoResultat.selAttributes.color := clRed;
        MemoResultat.Lines.Add(stTest4);
        memoResultat.selAttributes.color := clRed;
        MemoResultat.Lines.Add(stTest5);
        memoResultat.selAttributes.color := clRed;
        MemoResultat.Lines.Add(stTest6);
        MajBtn.enabled := true;
     end
     else MajBtn.enabled := false;
     for i := 1 to NbrePages do begin
         pages[i].ModeleCalcule := false;
         pages[i].ModeleErrone := false;
     end;
     if curseur=curModeleGr then setPenBrush(curSelect);
     MajModelePermis := true;
end end;

Procedure TFgrapheVariab.MajParametres;
var i : integer;
begin with pages[pageCourante] do begin
       VerifIntervalles;
       verifParametres;
       for i := 1 to NbreParam[paramNormal] do begin
           PanelParam[i].visible := true;
           PanelParam[i].caption := Parametres[paramNormal,i].nom;
           EditValeur[i].text := formatGeneral(valeurParam[paramNormal,i],3);
       end;
       for i := succ(NbreParam[paramNormal]) to MaxParametres do
           PanelParam[i].visible := false;
end end; // MajParametres

procedure TFgrapheVariab.MajResultat;
var couleurM : Tcolor;

Procedure Ajoute(const Aligne : string);
begin
    memoResultat.selAttributes.color := couleurM;
    MemoResultat.Lines.add(Aligne);
    Pages[pageCourante].TexteResultatModele.add(Aligne);
end;

procedure verifAleatoire;
var m,i : integer;
    curneg,prevneg,probleme : boolean;
    runs,npos,nneg : integer;
    hintAleatoire : string;
begin
      for m := 1 to NbreModele do with fonctionTheorique[m],pages[pageCourante] do begin
          if (fin[m]<(debut[m]+256)) and (fin[m]>(debut[m]+8)) then begin
            runs := 0;
            npos := 0;
            nneg := 0;
            prevneg := true; // pour le compilateur
            for i := debut[m] to fin[m] do begin
               if uniteSIGlb
                  then curneg := valeurTheorique[m,i]<valeurVar[indexY,i]*coeffSI
                  else curneg := valeurTheorique[m,i]<grandeurs[indexY].valeur[i];
               if curneg
                  then begin
                    inc(nneg);
                    if (i>debut[m]) and not prevneg then inc(runs);
                    prevneg := true;
                  end
                  else begin
                    inc(npos);
                    if (i>debut[m]) and prevneg then inc(runs);
                    prevneg := false;
                  end;
            end;
            inc(runs);
            probleme := (runs<2) or (nneg<2) or (npos<2);
            if probleme then begin
                 couleurM := clRed;
                 Ajoute('Résidus aléatoires ?');
            end
            else begin
              pvalueWald := pValue_Wald(runs,nneg,npos);
              if pvalueWald<0.05 then begin
                 couleurM := clRed;
                 Ajoute('Résidus aléatoires ?');
                 hintAleatoire := 'H0 : les résidus sont aléatoires'+crCR+crLF+
                                'Proba(modélisation|H0) = '+chainePrec(pValueWald);
                 hintMemoresultat.add(hintAleatoire);
            end;
            end;
          end;
      end;
end;

var m : shortInt;
    i : integer;
    indexP : integer;
    DebutCalcul : integer;
    setParam : TsetGrandeur;
    testOrigine : double;
    hintOrigine : string;
begin
if monteCarloActif then exit;
with pages[pageCourante] do begin
   MemoResultat.Clear;
   hintMemoResultat.clear;
   hintResultatLabel.visible := false;
   TexteResultatModele.clear;
   setParam := [];
   couleurM := clBlack;
   if ModeleCalcule and modelePourCent then begin
      Ajoute(stEcartRelatif);
      for m := 1 to NbreModele do with fonctionTheorique[m] do begin
         couleurM := couleur;
         Ajoute('  '+enTete+' : '+chainePrec(PrecisionModele[m]));
      end;
   end;
   if ModeleCalcule and not chi2Actif then begin
      couleurM := clBlack;
      Ajoute(stEcartTypeModele);
      for m := 1 to NbreModele do with fonctionTheorique[m] do begin
          couleurM := couleur;
          Ajoute(addrY.formatNomEtUnite(sigmaY));
      end;
   end;
   if ModeleCalcule then begin
      for m := 1 to NbreModele do with fonctionTheorique[m] do begin
         couleurM := couleur;
         if Chi2Actif
            then begin
                Ajoute('Chi2/(N-p)='+formatGeneral(chi2Relatif,precisionMin));
                hintMemoResultat.add('Devrait être proche de 1');
            end
            else begin
                if Lineaire then begin
                   if withCoeffCorrel then begin
                      stat2.init(valeurVar[indexX],valeurVar[indexY],debut[m],fin[m]);
                      Ajoute(stCoeffCorrel+'='+FormatGeneral(stat2.Correlation,precisionCorrel));
                   end;
                   if withPvaleur then begin
                  //   stat2.init(valeurVar[indexX],valeurVar[indexY],debut[m],fin[m]);
                  //   Ajoute('F='+FormatGeneral(stat2.Fisher,5));
                  //   Ajoute(stPvaleur+'Fisher)'+chainePrec(pValueFisher));
//                         chainePrec(PSnedecor(1,NbrePointsModele,Fisher)));
// function PSnedecor(Nu1, Nu2 : Integer; X : Float) : Float; // Prob(F >= X)
                     if ParamAjustes then for i := 1 to NbreParam[paramNormal] do begin
                        indexP := ParamToIndex(paramNormal,i);
                        try
                        if indexP in depend then Ajoute(stPvaleur+parametres[paramNormal,i].nom+')'+
                                chainePrec(PStudent(NbrePointsModele-1,
                                      abs(ValeurParam[paramNormal,i]/incertParam[i]))));
// FStudent(Nu : Integer; X : Float) : Float; // Prob(|t| >= X)
// P-valeur = Prob(t(n-p-1)>valeur/ecarttype)
                        except
                        end;
                     end; // paramAjustes
                   end // Pvaleur
                end; // lineaire
            end; // non Chi2
         if (PrecisionModele[m]>0.5) and InitiationAfaire then begin
            InitiationAfaire := false;
            afficheErreur(erEcart,HELP_EcartModelisationExperience);
         end;
         if ErreurModele then Ajoute(erPointModele+IntToStr(PosErreurModele));
      end; // for m
      IntersectionItem.visible := false;
      for m := 2 to NbreModele do with fonctionTheorique[m] do
         if isCorrect(Y_inter[m]) and isCorrect(X_inter[m]) then begin
             couleurM := clBlue;
             Ajoute(stIntersection+
                    IntToStr(pred(m))+'-'+IntToStr(m)+' : ');
             if sigmaX_inter[m]>0
                then Ajoute(grandeurs[indexX].formatNomPrecisionUnite(X_inter[m],sigmaX_inter[m]))
                else Ajoute(grandeurs[indexX].formatNomEtUnite(X_inter[m]));
             if sigmaY_inter[m]>0
                then Ajoute(grandeurs[indexY].formatNomPrecisionUnite(Y_inter[m],sigmaY_inter[m]))
                else Ajoute(grandeurs[indexY].formatNomEtUnite(Y_inter[m]));
             Ajoute('');
             IntersectionItem.visible := true;
         end;
      IntersectionTer.visible := IntersectionItem.visible;
      if ParamAjustes
         then begin
            for i := 1 to NbreParam[paramNormal] do begin
              EditValeur[i].text := FormatGeneral(ValeurParam[paramNormal,i],3);
              include(setParam,ParamToIndex(paramNormal,i));
            end;
            if AffIncertParam in [i95,iBoth] then begin
               couleurM := clBlack;
               Ajoute(stIntervalle95);
               for i := 1 to NbreParam[paramNormal] do begin
                  Ajoute(ParamEtPrec(i,false));
                  if abs(incert95Param[i]/ValeurParam[paramNormal,i])<PrecisionMaxParam then begin
                     couleurM := clRed;
                     Ajoute(stTropPrecis);
                  end;
               end;
            end;
            if not withPvaleur then begin
                couleurM := clRed;
                for i := 1 to NbreParam[paramNormal] do begin
             //  if isOrigine[i] then begin
             // test origine=0 pour régression linéaire
             // On peut considérer origine=0 avec un seuil critique de x%
       (*          if ParamToIndex(paramNormal,i) in FonctionTheorique[1].depend
                    then begin  *)
                    testOrigine := PStudent(FonctionTheorique[1].NbrePointsModele-1,
                                            abs(ValeurParam[paramNormal,i]/incertParam[i]));
                    if testOrigine>0.05 then begin
                       hintOrigine := 'H0 : '+parametres[paramNormal,i].nom+'=0'+crCR+crLF+
                                      'Proba(modélisation|H0) = '+chainePrec(testOrigine);
                       Ajoute(parametres[paramNormal,i].nom+'=0 ?');
                       hintmemoResultat.Add(hintOrigine);
                    end
                    else if testOrigine=0 then begin
                         testOrigine :=  abs(ValeurParam[paramNormal,i]/incertParam[i]);
                         if testOrigine<1 then begin // Zscore<1
                              hintOrigine := parametres[paramNormal,i].nom+' : incertitude>valeur !';
                              Ajoute(parametres[paramNormal,i].nom+'=0 ?');
                              hintmemoResultat.Add(hintOrigine);
                         end
                    end;
                end; // for i
            end; // not Pvaleur
            if AffIncertParam in [iType,iBoth] then begin
               couleurM := clBlack;
               Ajoute(stIncertitudeType);
               for i := 1 to NbreParam[paramNormal] do begin
                  Ajoute(ParamEtPrec(i,true));
                  if abs(incertParam[i]/ValeurParam[paramNormal,i])<PrecisionMaxParam then begin
                     couleurM := clRed;
                     Ajoute(stTropPrecis);
                  end;
               end;
            end;
            verifAleatoire;
       end
       else begin
           couleurM := clRed;
           Ajoute(stTest1);
           Ajoute(stTest2);
           Ajoute(stTest3);
           MajBtn.Enabled := true;
       end;
     debutCalcul := 0;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
        if (fonct.genreC<>g_experimentale) and
           ((setParam * fonct.depend) <> [] ) then begin
           debutCalcul := i;
           break;
        end;
     end;
     if debutCalcul>0 then RecalculP;
   end; // ModeleCalcule
end end; // MajResultat

procedure TFgrapheVariab.MajResultatLatex(p : TcodePage);

Procedure Ajoute(Aligne : string;Acolor : Tcolor);
begin
    if (Acolor<>clBlack) and (NbreModele>1) then Aligne := '{\color{'+couleurLatex(Acolor)+'} '+Aligne+'}';
    Pages[pageCourante].TexteResultatModele.add(Aligne);
end;

var m : shortInt;
    i : integer;
    testOrigine : double;
    hintOrigine : string;
begin with pages[p] do begin
   TexteResultatModele.clear;
   if ModeleCalcule and modelePourCent then
      for m := 1 to NbreModele do with fonctionTheorique[m] do
         Ajoute(stEcartRelatif+'  '+enTete+' : '+chainePrec(PrecisionModele[m]),couleur);
   if ModeleCalcule and not chi2Actif then
      for m := 1 to NbreModele do with fonctionTheorique[m] do
          Ajoute(stEcartTypeModele+' '+addrY.formatNomEtUnite(sigmaY),couleur);
   if ModeleCalcule then begin
      for m := 1 to NbreModele do with fonctionTheorique[m] do begin
         if Chi2Actif
            then Ajoute('Chi2/(N-p)='+formatGeneral(chi2Relatif,precisionMin),couleur)
            else if Lineaire and withCoeffCorrel then begin
                   stat2.init(valeurVar[indexX],valeurVar[indexY],debut[m],fin[m]);
                   Ajoute(stCoeffCorrel+'='+FormatGeneral(stat2.Correlation,precisionCorrel),couleur);
            end; // lineaire
         if ErreurModele then Ajoute(erPointModele+IntToStr(PosErreurModele),couleur);
      end; // for m
      for m := 2 to NbreModele do with fonctionTheorique[m] do
         if isCorrect(Y_inter[m]) and isCorrect(X_inter[m]) then begin
             hintOrigine := stIntersection+IntToStr(pred(m))+'-'+IntToStr(m)+' : ';
             if sigmaX_inter[m]>0
                then hintOrigine := hintOrigine+grandeurs[indexX].formatNomPrecisionUnite(X_inter[m],sigmaX_inter[m])
                else hintOrigine := hintOrigine+grandeurs[indexX].formatNomEtUnite(X_inter[m]);
             hintOrigine := hintOrigine+', ';
             if sigmaY_inter[m]>0
                then hintOrigine := hintOrigine+grandeurs[indexY].formatNomPrecisionUnite(Y_inter[m],sigmaY_inter[m])
                else hintOrigine := hintOrigine+grandeurs[indexY].formatNomEtUnite(Y_inter[m]);
             Ajoute(hintOrigine,clBlack);
         end;
      if ParamAjustes
         then begin
            if AffIncertParam in [i95,iBoth] then begin
               Ajoute('Les incertitude sont des incertitudes élargies à \95%',clBlack);
               for i := 1 to NbreParam[paramNormal] do begin
                  hintOrigine := ParamEtPrec(i,false);
                  if abs(incert95Param[i]/ValeurParam[paramNormal,i])<PrecisionMaxParam
                     then Ajoute(hintOrigine+' '+stTropPrecis,clred)
                     else Ajoute(hintOrigine,clBlack);
               end;
            end;
            if not withPvaleur then begin
               for i := 1 to NbreParam[paramNormal] do
                 if ParamToIndex(paramNormal,i) in FonctionTheorique[1].depend
                    then begin
                       testOrigine := PStudent(FonctionTheorique[1].NbrePointsModele-1,
                                abs(ValeurParam[paramNormal,i]/incertParam[i]));
                       if testOrigine>0.05 then begin
                          hintOrigine := 'H0 : '+parametres[paramNormal,i].nom+'=0';
                          hintOrigine := hintOrigine+' Proba(modélisation|H0) = '+chainePrec(testOrigine);
                          hintOrigine := hintOrigine+' ; '+parametres[paramNormal,i].nom+'=0 ?';
                          Ajoute(hintOrigine,clRed);
                       end
                       else if testOrigine=0 then begin
                            testOrigine :=  abs(ValeurParam[paramNormal,i]/incertParam[i]);
                            if testOrigine<1 then begin // Zscore<1
                               hintOrigine := parametres[paramNormal,i].nom+' : incertitude>valeur !';
                               hintOrigine := hintOrigine+' ; '+parametres[paramNormal,i].nom+'=0 ?';
                               Ajoute(hintOrigine,clred);
                            end
                       end
                    end
            end;
            if AffIncertParam in [iType,iBoth] then begin
               Ajoute('Les incertitudes sont des incertitudes types',clBlack);
               for i := 1 to NbreParam[paramNormal] do begin
                  hintOrigine := ParamEtPrec(i,true);
                  if abs(incertParam[i]/ValeurParam[paramNormal,i])<PrecisionMaxParam
                     then Ajoute(hintOrigine+ ' '+stTropPrecis,clRed)
                     else Ajoute(hintOrigine,clBlack);
               end;
            end;
       end;
   end; // ModeleCalcule
end end; // MajResultatLatex

procedure TFgrapheVariab.LanceModele(ajuste : boolean);
var k : TcodePage;
    m : integer;
label finProc;
begin
     if not(ajuste) and
       ( (OmManuel in Graphes[1].OptionModele) or
         splitterModele.snapped) then exit;
//     if ajuste then NbreSuiteValeurParam := 0;
     Screen.cursor := crHourGlass;
     PanelAjuste.enabled := true;
     if not (ModeleDefini in etatModele) then begin
        lanceCompile;
        if not (ModeleDefini in etatModele) then begin
           if MemoModele.showing then MemoModele.setFocus;
           goto finProc;
        end;
     end;
     if not (ModeleConstruit in etatModele) then begin
        ConstruitModele;
        if not (ModeleConstruit in etatModele) then begin { erreur ? }
           if MemoModele.showing then MemoModele.setFocus;
           goto finProc;
        end;
     end;
     if not (UniteParamDefinie in etatModele) then setUniteParametre;
     pages[pageCourante].VerifIntervalles;
     VerifParametres;
     ajoutGrandeurNonModele := False;
     if modeleDependant or not ajuste
        then EffectueModele(ajuste)
        else begin
          for m := 1 to NbreModele do
              EffectueModeleMono(m);
          calcIntersection;
        end;
     if ajuste and
        (OmManuel in Graphes[1].OptionModele)
        and not pages[pageCourante].modeleCalcule then EffectueModele(false);
     MajBtn.enabled := false;
     if (OmEchelle in graphes[1].OptionModele) then
        graphes[1].monde[mondeX].Defini := false;
     finProc :
     PanelAjuste.enabled := true;
//     if active then SetFocus;
     if ajuste then ModifFichier := true;
     Screen.cursor := crDefault;
     if not(splitterModele.snapped) then setParamEdit;
     for k := 1 to NbrePages do ModeleCalc[k] := false;
     if not monteCarloActif then Application.MainForm.Perform(WM_Reg_Maj,MajModele,0);
end;// LanceModele

procedure TFgrapheVariab.LanceCompile;
var PosErreur,longErreur,i : integer;
begin
     MajModelePermis := false;
     etatModele := [];
     NbreModele := 0;
     NbreFonctionSuper := 0;
     NbreParam[paramNormal] := 0;
     PosErreur := 0;
     LongErreur := 0;
     while (MemoModele.lines.count>0) and
           (MemoModele.lines[0]='') do MemoModele.lines.delete(0);
     while (MemoModele.lines.count>2) and
           (MemoModele.lines[MemoModele.lines.count-1]='') and
           (MemoModele.lines[MemoModele.lines.count-2]='')
          do MemoModele.lines.delete(MemoModele.lines.count-1);
     compileModele(posErreur,longErreur);
     if ModeleDefini in etatModele
        then begin
             ConstruitModele;
             InitEquaDiffBtn.visible := (fonctionTheorique[1].genreC=g_diff2) or
              ( ajusteOrigine and (fonctionTheorique[1].genreC=g_diff1) );
             if InitEquaDiffBtn.visible then InitEquaDiffBtn.hint :=
                 hInitialise+fonctionTheorique[1].addrYp.nom+'0 ';
             MajBtn.enabled := false;
             for i := 1 to NbreParam[ParamNormal] do
                 pages[pageCourante].nomParam[i] := parametres[ParamNormal,i].nom;
             for i := succ(NbreParam[ParamNormal]) to maxParametres do
                 pages[pageCourante].nomParam[i] := '';
        end
        else if not (PasDeModele in etatModele) then with memoModele do begin
             selStart := pred(posErreur);
             selLength := longErreur;
             InitEquaDiffBtn.visible := false;
             MajBtn.enabled := true;
             if showing then setFocus;
        end;
    MajModelePermis := true;
    TrigoLabel.Visible := fonctionTheorique[1].isSinusoide;
    if PrevenirTri then verifTri;
    AjustePanelModele;
end; // LanceCompile

procedure TFgrapheVariab.ZoomArriereItemClick(Sender: TObject);
begin
    if not grapheCourant.grapheOK then exit;
    with grapheCourant.paintBox do begin
        grapheCourant.affecteZoomArriere;
        include(grapheCourant.modif,gmEchelle);
        invalidate;
    end;
end; // zoomArriere

procedure TFgrapheVariab.FormDestroy(Sender: TObject);
var m : TcodeIntervalle;
    i : integer;                                
begin
     for i := 0 to maxParamAnim do
         paramAnimManuelle[i].free;
     for i := 1 to 3 do Graphes[i].Free;
     for m := 1 to maxIntervalles do begin
         finalize(ValeurDeriveeX[m]);
         finalize(ValeurYDiff[m]);
         finalize(ValeurYpDiff[m]);
         for i := 1 to maxParametres do
             libere(derf[m,i]);
     end;
     hintMemoResultat.Free;
     ValeurXDiff := nil;
     FGrapheVariab := nil;
     dXresidu := nil; dYresidu := nil;
end;

Procedure TFgrapheVariab.ecritConfig;

procedure ecritDefaut;

procedure ecritMonde(m : TindiceMonde);
begin with graphes[1].monde[m] do begin
       if graphes[1].useZoom then getMinMaxdefaut;
       writeln(fichier,minDefaut);
       writeln(fichier,maxDefaut);
       writeln(fichier,deltaAxe);
       writeln(fichier,NTicks);
end end;

begin
    if (graphes[1].useDefaut) or
       (graphes[1].useDefautX) or
       (graphes[1].useZoom) then begin
       writeln(fichier,symbReg2,'13 '+stDefaut);
       ecritMonde(mondeX);
       ecritMonde(mondeY);
       if not graphes[1].monde[mondeDroit].defini then begin
           graphes[1].monde[mondeDroit].minDefaut := 0;
           graphes[1].monde[mondeDroit].maxDefaut := 1;
       end;
       ecritMonde(mondeDroit);
       writeln(fichier,ord(graphes[1].autoTick));
    end;
end;

Procedure ecritAnimation;
var i : integer;
begin
   if AnimationTemps.checked then begin
      writeln(fichier,symbReg2,'2 ANIMATION temporelle');
      writeln(fichier,NbreTickbar.position);
      writeln(fichier,LignePointCB.checked);
   end;
   if AnimationParam.checked or
     (AnimationNone.checked and (NbreParamAnim>0)) then begin
      write(fichier,symbReg2,intToStr(3+NbreParamAnim*NbreItemParamAnim),' ANIMATION ');
      if animationNone.checked
         then writeln(fichier,'valeurs')
         else writeln(fichier,'manuelle');
      writeln(fichier,NbreItemParamAnim);
      for i := 0 to pred(NbreParamAnim) do
          paramAnimManuelle[i].ecritFichier;
      writeln(fichier,NbreTickbar.position);
      writeln(fichier,ord(titreAnimCB.checked));
   end;
end;

Procedure EcritGraphe(indexGr : integer;const code : string);
var i,p : integer;
    utile : boolean;
begin with Graphes[indexGr] do begin
   writeln(fichier,symbReg2,NbreOrdonnee,' LIGNE'+Code);
   for i := 1 to NbreOrdonnee do
       writeln(fichier,ord(coordonnee[i].ligne));
   writeln(fichier,symbReg2,NbreOrdonnee,' COULEUR'+Code);
   for i := 1 to NbreOrdonnee do
       writeln(fichier,coordonnee[i].couleur);
   writeln(fichier,symbReg2,NbreOrdonnee,' MOTIF'+Code);
   for i := 1 to NbreOrdonnee do
       writeln(fichier,ord(coordonnee[i].Motif));
   writeln(fichier,symbReg2,NbreOrdonnee,' X'+Code);
   for i := 1 to NbreOrdonnee do
       ecritChaineRW3(coordonnee[i].nomX);
   writeln(fichier,symbReg2,NbreOrdonnee,' Y'+Code);
   for i := 1 to NbreOrdonnee do
       ecritChaineRW3(coordonnee[i].nomY);
   writeln(fichier,symbReg2,NbreOrdonnee,' TRACE'+Code);
   for i := 1 to NbreOrdonnee do
       writeln(fichier,word(coordonnee[i].Trace));
   utile := false;
   for i := 1 to NbreOrdonnee do
       utile := coordonnee[i].couleurPoint<>'';
   if utile then begin
      writeln(fichier,symbReg2,NbreOrdonnee,' '+stCouleurPoint+Code);
      for i := 1 to NbreOrdonnee do
          writeln(fichier,coordonnee[i].couleurPoint);
      writeln(fichier,symbReg2,NbreOrdonnee,' '+stCodeCouleurPoint+Code);
      for i := 1 to NbreOrdonnee do
          writeln(fichier,ord(coordonnee[i].codeCouleur));
   end;
   writeln(fichier,symbReg2,NbreOrdonnee,' MONDE'+Code);
   for i := 1 to NbreOrdonnee do
       writeln(fichier,ord(coordonnee[i].iMondeC));
   writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' GRADUATION'+Code);
   for i := mondeX to MondeDroit do
       writeln(fichier,ord(monde[i].Graduation));
   writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' ZERO'+Code);
   for i := mondeX to MondeDroit do
       writeln(fichier,ord(monde[i].ZeroInclus));
   writeln(fichier,symbReg2,succ(mondeDroit-mondeX),' INVERSE'+Code);
   for i := mondeX to MondeDroit do
       writeln(fichier,ord(monde[i].axeInverse));
   writeln(fichier,symbReg2,'26 '+stOptions+Code);
   writeln(fichier,byte(optionGraphe));{1}
   writeln(fichier,byte(optionModele));{2}
   writeln(fichier,ord(traceDefaut));{3}
   writeln(fichier,OrdreLissage);{4}
   writeln(fichier,DimPointVGA);{5}
   writeln(fichier,ord(false));{6}
   writeln(fichier,ord(SuperposePage));{7}
   writeln(fichier,ord(avecEllipse));{8}
   writeln(fichier,ord(projeteVecteur)); {9}
   if (indicateur<>nil) and (indicateurDlg<>nil)
      then writeln(fichier,indicateurDlg.indicateurs.indexOf(indicateur))
      else writeln(fichier,-1);{10}
   writeln(fichier,ord(FilDeFer));{11}
   writeln(fichier,ord(IdentAction.checked));{12}
   writeln(fichier,trunc(Echellevecteur*100));{13}
   writeln(fichier,ord(ProlongeVecteur));{14}
   writeln(fichier,round(gammaNiveauGris));{15 entier pour rétro compatibilité}
   writeln(fichier,pasPoint);{16}
   writeln(fichier,ord(CouleurVitesseImposee));{17}
   writeln(fichier,ord(ajusteOrigine));{18}
   writeln(fichier,ord(UseSelect));{19}
   writeln(fichier,NbreVecteurVitesseMax);{20}
   writeln(fichier,NbreTexteMax);{21}
   writeln(fichier,PenWidthCourbe);{22}
   writeln(fichier,zeroPolaire);{23}
   writeln(fichier,ord(withBandeConfiance));{24}
   writeln(fichier,ord(withBandePrediction));{25}
   writeln(fichier,ord(reperePage));{26}
   for i := 0 to pred(Dessins.count) do
       if not(dessins[i].identification in [identDroite,identRaie,identAnimation]) and
         (dessins[i].repere=nil) then begin
         writeln(fichier,symbReg2,IntToStr(dessins[i].NbreData)+' '+stDessin+Code);
         dessins[i].Store;
   end;
   for p := 1 to nbrePages do
       for i := 0 to pred(Equivalences[p].count) do begin
          writeln(fichier,symbReg2,IntToStr(NbreDataEquiv)+' TANGENTE'+intToStr(p));
          equivalences[p][i].Store;
       end;
   if curseur=curReticuleData then begin // TODO
      writeln(fichier,symbReg2,'17 CURSEUR');
      for i := curseurData1 to curseurData2 do with curseurOsc[i] do begin // 8*2=16
          writeln(fichier,xc);
          writeln(fichier,yc);
          writeln(fichier,ic);
          writeln(fichier,xr);
          writeln(fichier,yr);
          writeln(fichier,indexCourbe);
          writeln(fichier,mondeC);
          if grandeurCurseur<>nil
             then ecritChaineRW3(grandeurCurseur.nom)
             else writeln(fichier,'zzzzz');
       end;
       writeln(fichier,byte(optionCurseur)); // 17
   end;
end end;// ecritGraphe

var i : integer;
    p : TcodePage;
begin  // ecritConfig
   ecritGraphe(1,'');
   ecritDefaut;
   if paintBox2.visible and
      not residusItem.Checked then ecritGraphe(2,'Bis');
   if paintBox3.visible and
      not residusItem.Checked then ecritGraphe(3,'Ter');
   if not animationNone.checked or
     (NbreParamAnim>0) then ecritAnimation;
   if dispositionFenetre=dNone then begin
      writeln(fichier,symbReg2,'5 '+stFenetre);
      writeln(fichier,ord(windowState));
      writeln(fichier,top);
      writeln(fichier,left);
      writeln(fichier,width);
      writeln(fichier,height);
   end;
   if graphePageIndependante then begin
       for p := 1 to maxPagesGr do
           if configGraphe[p]<>nil then
              configGraphe[p].ecrit(p);
   end;
   if (ModeleDefini in etatModele) and
       not(splitterModele.snapped) then begin
      writeln(fichier,symbReg2,IntToStr(NbrePages)+' MODELECALC');
      for i := 1 to NbrePages do
          writeln(fichier,ord(Pages[i].ModeleCalcule));
   end;
end; // ecritConfig

Procedure TFGrapheVariab.EcritConfigXML(Anode : IXMLNode);

procedure ecritDefaut;

procedure ecritMonde(m : TindiceMonde);
var  DefautXML : IXMLNode;
begin with graphes[1].monde[m] do begin
       if graphes[1].useZoom then getMinMaxdefaut;
       DefautXML := ANode.AddChild(stDefaut);
       DefautXML.Attributes['Index'] := intToStr(ord(m));
       writeFloatXML(DefautXML,'MinD',minDefaut);
       writeFloatXML(DefautXML,'MaxD',maxDefaut);
       writeFloatXML(DefautXML,'Delta',deltaAxe);
       writeIntegerXML(DefautXML,'NTicks',NTicks);
end end;

var m : TIndiceMonde;
begin
    if (graphes[1].useDefaut) or
       (graphes[1].useDefautX) or
       (graphes[1].useZoom) then begin
       for m := mondeX to mondeDroit do
           ecritMonde(m);
    end;
end; // ecritDefaut

Procedure ecritAnimation;
var i : integer;
    AnimXML,ParamXML : IXMLNode;
begin
   AnimXML := Anode.AddChild('ANIMATION');
   writeBoolXML(AnimXML,'AnimationTemporelle',AnimationTemps.checked);
   writeBoolXML(AnimXML,'AnimationManuelle',AnimationParam.checked);
   writeBoolXML(AnimXML,'TitreAnimation',titreAnimCB.checked);
   writeIntegerXML(AnimXML,'NbreTick',NbreTickbar.position);
   writeBoolXML(AnimXML,'LignePoint',LignePointCB.checked);
   writeIntegerXML(AnimXML,'NbreParamAnim',NbreParamAnim);
   for i := 0 to pred(NbreParamAnim) do begin
       ParamXML := AnimXML.AddChild('ParamAnim');
       ParamXML.Attributes['Index'] := intToStr(i);
       paramAnimManuelle[i].storeXML(ParamXML);
   end;
end;

var i,p : integer;
    OptionsXML,CoordXML : IXMLNode;
begin with Graphes[1] do begin
   for i := 1 to NbreOrdonnee do with coordonnee[i] do begin
       CoordXML := ANode.AddChild('COORD');
       CoordXML.Attributes['Index'] := intToStr(i);
       writeIntegerXML(CoordXML,stLigne,ord(ligne));
       writeIntegerXML(CoordXML,stCouleur,couleur);
       writeIntegerXML(CoordXML,'MOTIF',ord(Motif));
       writeStringXML(CoordXML,'X',coordonnee[i].nomX);
       writeStringXML(CoordXML,'Y',nomY);
       writeIntegerXML(CoordXML,'TRACE',word(TraceToXML(Trace)));
       writeIntegerXML(CoordXML,stMonde,ord(iMondeC));
       writeIntegerXML(CoordXML,'GRADUATION',ord(monde[iMondeC].Graduation));
       writeIntegerXML(CoordXML,'ZERO',ord(monde[iMondeC].ZeroInclus));
       writeIntegerXML(CoordXML,'INVERSE',ord(monde[i].axeInverse));
   end;
   OptionsXML := ANode.addChild(stOptions);
   writeIntegerXML(optionsXML,'OptGraphe',byte(optionGraphe));{1}
   writeIntegerXML(optionsXML,'OptModele',byte(optionModele));{2}
   writeBoolXML(optionsXML,'SuperPage',SuperposePage);
   writeBoolXML(optionsXML,stEllipse,avecEllipse);
   writeBoolXML(optionsXML,'ProjeteVecteur',projeteVecteur);
   writeBoolXML(optionsXML,stFilDeFer,FilDeFer);
   writeBoolXML(optionsXML,'ProlongeVect',ProlongeVecteur);
   writeBoolXML(optionsXML,'CouleurVitesseImposee',couleurVitesseImposee);
   writeIntegerXML(optionsXML,'ReperePage',ord(reperePage));
   writeIntegerXML(optionsXML,'OrdreLissage',OrdreLissage);
   writeIntegerXML(optionsXML,'NvecteurMax',NbreVecteurVitesseMax);
   writeIntegerXML(optionsXML,'NtexteMax',NbreTexteMax);
   writeBoolXML(optionsXML,'AutoTick',graphes[1].autoTick);
 //  writeFloatXML(optionsXML,'ZeroPolaire',zeroPolaire);
   ecritDefaut;
   for i := 0 to pred(Dessins.count) do begin
         if dessins[i].isTexte
            then OptionsXML := ANode.addChild('TEXTE')
            else OptionsXML := ANode.addChild('SHAPE');
         dessins[i].StoreXML(OptionsXML);
   end;
   for p := 1 to nbrePages do begin
       for i := 0 to pred(Equivalences[p].count) do begin
           OptionsXML := ANode.addChild(stTangente);
           OptionsXML.Attributes[stPage] := intToStr(p);
           equivalences[p][i].StoreXML(OptionsXML);
       end;
       OptionsXML := writeBoolXML(ANode,'MODELECALC',Pages[p].ModeleCalcule);
       OptionsXML.Attributes[stPage] := intToStr(p);
    end;
    if not animationNone.checked or
       (NbreParamAnim>0) then ecritAnimation;
end end;  // ecritConfigXML

Procedure TFgrapheVariab.litConfig;
var imax : integer;

procedure litDefaut;

Procedure litMonde(amonde : TindiceMonde);
var min, max : double;
begin with graphes[1].monde[aMonde] do begin
    readLnNombreWin(min);
    readLnNombreWin(max);
    readLnNombreWin(deltaAxe);
    readLn(fichier,NTicks);
    SetMinMaxDefaut(min, max);
end end;

var i : integer;
begin
    graphes[1].useDefaut := true;
    graphes[1].useDefautX := true;
    graphes[1].useZoom := false;
    graphes[1].monde[mondeX].defini := true;
    litMonde(mondeX);
    litMonde(mondeY);
    litMonde(mondeDroit);
    graphes[1].autoTick := litBooleanWin;
    for i := 14 to imax do readln(fichier);
end;

procedure VerifCoord(indexGr : integer);
var i : integer;
begin with graphes[indexGr] do begin
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        if codeY<>grandeurInconnue
           then monde[iMondeC].axe := grandeurs[codeY];
        codeX := indexNom(nomX);
        if codeX<>grandeurInconnue then
           monde[mondeX].axe := grandeurs[codeX];
        exclude(trace,trSonagramme);
    end;
end end;

Procedure litAnimationTemporelle;
var i,N : integer;
begin
     readln(fichier,N);
     NbreTickBar.position := N;{1}
  //   AnimationTemps.checked := true;
     if imax>=2 then LignePointCB.checked := litBooleanWin;{2}
     for i := 3 to imax do readln(fichier);
end;

Procedure litAnimationManuelle(check : boolean);
var i,Nparam,Nitem,supplement,N : integer;
begin
     readln(fichier,Nitem);
     if Nitem=0 then exit;
     Nparam := imax div Nitem;
     supplement := imax mod Nitem;
     for i := 0 to pred(Nparam) do with paramAnimManuelle[i] do begin
         litFichier(Nitem);
         sliderA.max := sliderMaxValue;
         SliderA.lineSize := succ(sliderA.max div 8);
         SliderA.pageSize := succ(sliderA.max div 32);
     end;
     if supplement>1 then begin
         readln(fichier,N);
         NbreTickBar.position := N;
     end;
     if supplement>2 then
         titreAnimCB.checked := litBooleanWin;
     for i := (Nparam*Nitem+supplement+1) to imax do readln(fichier);
     AnimationParam.checked := check;
     include(graphes[1].modif,gmEchelle);
     graphes[1].useDefaut := false;
     graphes[1].useDefautX := false;
     graphes[1].useZoom := false;
     graphes[1].autoTick := true;
     initManuelleAfaire := true;
end;

Function chercheChoix() : integer;
begin
      result := 0;
      if pos('X',ligneWin)<>0 then begin
         result := 1;
         exit
      end;
      if pos('Y',ligneWin)<>0 then begin
         result := 2;
         exit;
      end;
      if pos(stMonde,ligneWin)<>0 then begin
         result := 3;
         exit
      end;
      if pos('GRADUATION',ligneWin)<>0 then begin
         result := 4;
         exit;
      end;
      if pos(stOptions,ligneWin)<>0 then begin
         result := 5;
         exit
      end;
      if pos('ZERO',ligneWin)<>0 then begin
         result := 6;
         exit
      end;
      if pos(stMaxi,ligneWin)<>0 then begin
         result := 7;
         exit;
      end;
      if pos('MINI',ligneWin)<>0 then begin
         result := 8;
         exit
      end;
      if pos(stDESSIN,ligneWin)<>0 then begin
         result := 9;
         exit;
      end;
      if pos('MODELECALC',ligneWin)<>0 then begin
         result := 10;
         exit
      end;
      if pos('TEMPSMINMAX',ligneWin)<>0 then begin
         result := 11;
         exit
      end;
      if pos('CURSEUR',ligneWin)<>0 then begin
         result := 12;
         exit;
      end;
      if pos('TRACE',ligneWin)<>0 then begin
         result := 13;
         exit;
      end;
      if pos(stCouleurPoint,ligneWin)<>0 then begin
         result := 27;
         exit;
      end;
      if pos(stCodeCouleurPoint,ligneWin)<>0 then begin
         result := 29;
         exit;
      end;
      if pos('ANIMATION',ligneWin)<>0 then begin
         if pos('temporelle',ligneWin)<>0 then begin
            result := 14;
            exit;
         end;
         if pos('manuelle',ligneWin)<>0 then begin
            result := 15;
            exit
         end;
         if pos('valeurs',ligneWin)<>0 then begin
            result := 20;
            exit
         end;
      end;
      if pos(stCouleur,ligneWin)<>0 then begin
         result := 16;
         exit
      end;
      if pos(stLigne,ligneWin)<>0 then begin
         result := 17;
         exit
      end;
      if pos('MOTIF',ligneWin)<>0 then begin
         result := 18;
         exit;
      end;
      if pos(stFenetre,ligneWin)<>0 then begin
         result := 21;
         exit;
      end;
      if pos(stTangente,ligneWin)<>0 then begin
         result := 22;
         exit
      end;
      if pos('INVERSE',ligneWin)<>0 then begin
         result := 23;
         exit
      end;
      (*
      if pos('MAGNUM',ligneWin)<>0 then begin
         result := 24;
         exit;
      end;
      *)
      if pos('RetModele',ligneWin)<>0 then begin
         result := 25;
         exit;
      end;
      if pos(stDefaut,ligneWin)<>0 then begin
         result := 28;
         exit;
      end;
//      if pos('Identification',ligneWin)<>0 then choix := 26;

end;

var i,j : integer;
    choix : integer;
    Agraphe : TgrapheReg;
    Adessin : Tdessin;
    AEquivalence : Tequivalence;
    zNom : string;
    zWord : word;
    zByte : byte;
    zInt : integer;
    zFloat : double;
    lectureOK : boolean;
begin // litConfig
   UnGrapheItem.checked := true;
   TitreAnimCB.checked := false;
   majFichierEnCours := true;
   Curseur := curSelect;
   for i := mondeX to mondeSans do
       for j := 1 to 3 do begin
           graphes[j].monde[i].axe := nil;
           graphes[j].monde[i].defini := false;
       end;
   for i := 1 to MaxPages do ModeleCalc[i] := false;
   animationNone.checked := true;
   nbreGraphe := UnGr;
   penWidthCourbe := 1;
   while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
      configCharge := true;
      imax := NbreLigneWin(ligneWin);
      Agraphe := graphes[1];
      if pos('DEBUT PAGE',ligneWin)<>0 then begin
         litLigneWin;
         zInt := strToInt(ligneWin); // numéro de page
         if (zint>0) and (zint<=maxPagesGr) then begin
            if ConfigGraphe[zint]=nil then
               ConfigGraphe[zint] := TTransfertGraphe.create;
            litLigneWin;
            ConfigGraphe[zint].Lit;
            GraphePageIndependante := true;
         end
         else litLigneWin;
         continue;
      end;
      if pos('Bis',ligneWin)<>0 then begin
          Agraphe := graphes[2];
          nbreGraphe := DeuxGrVert;
      end;
      if pos('Ter',ligneWin)<>0 then begin
          Agraphe := graphes[3];
          nbreGraphe := DeuxGrHoriz;
      end;
      choix := chercheChoix;
      lectureOK := true;
      case choix of
           0 : for i := 1 to imax do readln(fichier);
           1 : with Agraphe do for i := 1 to imax do begin
                coordonnee[i].nomX := litLigneWinU;
                if coordonnee[i].nomX='Longueur d''''onde' then coordonnee[i].nomX := lambdaMin;
           end;
           2 : with Agraphe do for i := 1 to imax do
                coordonnee[i].nomY := litLigneWinU;
           3 : with Agraphe do for i := 1 to imax do begin
                litLigneWin;
                if ligneWin[1]=symbReg2
                   then begin
                       lectureOK := false;
                       break;
                   end
                   else begin
                       zByte := StrToInt(ligneWin);
                       coordonnee[i].iMondeC := TindiceMonde(zByte);
                   end
           end;
           4 : with Agraphe do for i := 1 to imax do begin
                litLigneWin;
                if ligneWin[1]=symbReg2
                   then begin
                       lectureOK := false;
                       break;
                   end
                   else begin
                       zByte := StrToInt(ligneWin);
                       monde[pred(i)].graduation := Tgraduation(zByte);
                   end;
           end;
           5 : with Agraphe do begin
             litLigneWin; {1}
             optionGraphe := TsetOptionGraphe(byte(strToInt(ligneWin)));
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
             if imax>=6 then begin
                useDefaut := litBooleanWin; {6}
                useDefaut := false;
             end;
             if imax>=7 then superposePage := litBooleanWin; {7}
             if imax>=8 then avecEllipse := litBooleanWin; {8}
             if imax>=9 then ProjeteVecteur := litBooleanWin;{9}
             if imax>=10 then begin
                litLigneWin;{10}
                zInt := strToInt(ligneWin);
                try
                if (zInt>=0) and (zint<indicateurDlg.indicateurs.count)
                   then indicateur := Tindicateur(indicateurDlg.indicateurs[zInt])
                   else indicateur := nil;
                except
                indicateur := nil;
                end;
             end;
             if imax>=11 then FilDeFer := litBooleanWin; {11}
             if imax>=12 then begin
                IdentAction.checked := litBooleanWin;{12}
                for i := 1 to 3 do graphes[i].identificationPages := IdentAction.checked;
             end;
             if imax>=13 then begin
                readln(fichier,echelleVecteur);{13}
                echelleVecteur := echelleVecteur/100;
             end;
             if imax>=14 then ProlongeVecteur := litBooleanWin; {14 }
             if imax>=15 then begin
                readln(fichier,gammaNiveauGris); {15 autrefois entier }
                if gammaNiveauGris<0.4 then gammaNiveauGris := 0.4;
                if gammaNiveauGris<2.7 then gammaNiveauGris := 2.7;
             end;
             if imax>=16 then readln(fichier,PasPoint); {16 }
             if imax>=17 then couleurVitesseImposee := litBooleanWin; {17 }
             if imax>=18 then ajusteOrigine := litBooleanWin; {18 }
             if imax>=19 then useSelect := litBooleanWin; {19 }
             if imax>=20 then readln(fichier,NbreVecteurVitesseMax); {20 }
             if imax>=21 then readln(fichier,NbreTexteMax); {21 }
             if imax>=22 then begin
                readln(fichier,zFloat);{22}
                PenWidthCourbe := round(zFloat);
             end;
             if imax>=23 then readln(fichier,zeroPolaire);{23}
             if imax>=24 then withBandeConfiance := litBooleanWin;{24}
             if imax>=25 then withBandePrediction := litBooleanWin;{25}
             if imax>=26 then begin {26}
                 litLigneWin;
                 zint := strToInt(ligneWin);
                 reperePage := TreperePage(zint);
             end;
             for i := 27 to imax do readln(fichier);
           end;
           6 : for i := 1 to imax do
                Agraphe.monde[pred(i)].zeroInclus := litBooleanWin;
           7 : for i := 1 to imax do
               readln(fichier,Agraphe.monde[pred(i)].maxDefaut);
           8 : for i := 1 to imax do
               readln(fichier,Agraphe.monde[pred(i)].minDefaut);
           9 : begin
               Adessin := Tdessin.create(agraphe);
               Adessin.load;
               Agraphe.dessins.add(Adessin);
           end;
           10 : for i := 1 to imax do modeleCalc[i] := litBooleanWin;
           11 : with Agraphe do begin
                readlnNombreWin(miniTemps);
                readlnNombreWin(maxiTemps);
           end;
           12 : with Agraphe do begin
               for i := curseurData1 to curseurData2 do with curseurOsc[i] do begin // 8*2=16
                  readln(fichier,xc);
                  readln(fichier,yc);
                  readln(fichier,ic);
                  readlnNombreWin(xr);
                  readlnNombreWin(yr);
                  readln(fichier,indexCourbe);
                  readln(fichier,mondeC);
                  zNom := litLigneWinU;
                  zByte := indexNom(zNom);
                  if zByte=grandeurInconnue
                      then begin
                         grandeurCurseur := nil;
                         mondeC := mondeX;
                      end
                      else grandeurCurseur := grandeurs[zByte];
               end;
               readln(fichier,zByte); // 17
               agraphe.optionCurseur := TsetOptionCurseur(zByte);
           end;
           13 : with Agraphe do for i := 1 to imax do begin
                 readln(fichier,zWord);
                 coordonnee[i].Trace := TsetTrace(zWord);
                 exclude(coordonnee[i].trace,trTexte);
                 exclude(coordonnee[i].trace,trSonagramme);
           end;
           14 : litAnimationTemporelle;
           15 : litAnimationManuelle(true);
           16 : with Agraphe do for i := 1 to imax do
               coordonnee[i].couleur := litColor(couleurInit[i]);
           17 : with Agraphe do for i := 1 to imax do begin
               readln(fichier,zByte);
               coordonnee[i].ligne := Tligne(zByte);
           end;
           18 : with Agraphe do for i := 1 to imax do begin
               readln(fichier,zByte);
               coordonnee[i].motif := Tmotif(zByte);
           end;
           20 : litAnimationManuelle(false);
           21 : begin
              readln(fichier,zByte);
              windowState := TwindowState(zByte);
              readln(fichier,zint);
              top := zint;
              readln(fichier,zint);
              left := zint;
              readln(fichier,zint);
              width := zint;
              readln(fichier,zint);
              height := zint;
              position := poDesigned;
              dispositionFenetre := dNone;
           end;
           22 : begin
               zWord := pos(stTangente,ligneWin)+length(stTangente);
               try
               zNom := copy(LigneWin,zWord,length(ligneWin)-zword+1);
               j := StrToInt(zNom);
               except
               j := 0;
               end;
               Aequivalence := Tequivalence.createVide(agraphe);
               AEquivalence.load;
               if (j>0) and (j<MaxPages) then
                  Agraphe.equivalences[j].Add(AEquivalence);
           end;
           23 : with Agraphe do for i := 1 to imax do
                monde[pred(i)].axeInverse := litBooleanWin;
           24 : begin
              isModeleMagnum := true;
              modeleGraphique[1].load;
              modeleGraphique[1].graphe := graphes[1];
           end;
           25 : with Agraphe.CurseurOsc[curseurData2] do begin
                 // curseur := curReticuleModele;
                  curseur := curSelect;
                  readln(fichier,xc);
                  readln(fichier,yc);
                  readln(fichier,ic);
                  readlnNombreWin(xr);
                  readlnNombreWin(yr);
                  readln(fichier,indexCourbe);
                  readln(fichier,mondeC);
                  zNom := litLigneWinU;
                  zByte := indexNom(zNom);
                  if zByte=grandeurInconnue
                      then begin
                         grandeurCurseur := nil;
                         mondeC := mondeX;
                      end
                      else grandeurCurseur := grandeurs[zByte];
               readln(fichier,zByte); {9}
               agraphe.optionCurseur := TsetOptionCurseur(zByte);
           end;
           27 : for i := 1 to imax do
                Agraphe.coordonnee[i].couleurPoint := litLigneWinU;
           28 : litDefaut;
           29 : for i := 1 to imax do begin
                readln(fichier,zWord);
                Agraphe.coordonnee[i].codeCouleur := TcodeCouleur(zWord);
           end;
       end; // case
       if lectureOK then litLigneWinU;
    end;
    for j := 1 to 3 do verifCoord(j);
    for i := 0 to pred(graphes[1].dessins.count) do
        if graphes[1].dessins[i].identification=identAnimation then
             titreAnimCB.checked := true;
end; // litConfig

Procedure TFgrapheVariab.litConfigXML(ANode : IXMLNode);
var CoordCourante : integer;
    mondeCourant : TIndiceMonde;
    avecDefaut : boolean;

procedure ResetCoord(g : integer);
var i : integer;
begin with graphes[g] do begin
    for i := mondeX to mondeSans do begin
        monde[i].axe := nil;
        monde[i].defini := false;
    end;
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        nomY := '';
        nomX := '';
        couleurPoint := '';
        exclude(trace,trSonagramme);
    end;
end end;

procedure VerifCoord;

procedure affecteDefaut;
var m : TindiceMonde;
begin
    graphes[1].useDefaut := true;
    graphes[1].useDefautX := true;
    graphes[1].useZoom := false;
    graphes[1].monde[mondeX].defini := true;
    for m := mondeX to mondeDroit do with graphes[1].monde[m] do
        SetMinMaxDefaut(mini, maxi);
end;

var i : integer;
begin with graphes[1] do begin
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        if codeY<>grandeurInconnue
           then monde[iMondeC].axe := grandeurs[codeY];
        codeX := indexNom(nomX);
        if codeX<>grandeurInconnue then
           monde[mondeX].axe := grandeurs[codeX];
    end;
    if avecDefaut then affecteDefaut;
end end;

Procedure AffecteAnimation;
var i : integer;
begin
     for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
         sliderA.max := sliderMaxValue;
         SliderA.lineSize := succ(sliderA.max div 8);
         SliderA.pageSize := succ(sliderA.max div 32);
     end;
     include(graphes[1].modif,gmEchelle);
     graphes[1].useDefaut := false;
     graphes[1].useDefautX := false;
     graphes[1].useZoom := false;
     graphes[1].autoTick := true;
     initManuelleAfaire := true;
end;

procedure LoadXMLInReg(ANode: IXMLNode);

procedure Suite;
var i: Integer;
begin
if ANode.HasChildNodes then
   for I := 0 to ANode.ChildNodes.Count - 1 do
       LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
end;

var Adessin : Tdessin;
    zWord : word;
    zByte : byte;
    aTrace : TsetTraceXML;
    p : integer;
    NewEquivalence : Tequivalence;
begin // loadXMLInReg
      with graphes[1] do begin
      if ANode.NodeName='AnimationTemporelle' then begin
         AnimationTemps.checked := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='AnimationManuelle' then begin
         AnimationParam.checked := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='TitreAnimation' then begin
         titreAnimCB.checked := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='NbreTick' then begin
         NbreTickbar.position := GetIntegerXML(ANode);
         exit;
      end;
      if ANode.NodeName='LignePoint' then begin
         LignePointCB.checked := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='NbreParamAnim' then begin
         NbreParamAnim := GetIntegerXML(ANode);
         exit;
      end;
      if ANode.NodeName='COORD' then begin
         coordCourante := ANode.Attributes['Index'];
         suite;
         exit;
      end;
      if ANode.NodeName='ANIMATION' then begin
         suite;
         exit;
      end;
      if ANode.NodeName='ParamAnim' then begin
         p := ANode.Attributes['Index'];
         paramAnimManuelle[p].loadXML(ANode);
         exit;
      end;
      if ANode.NodeName='X' then begin
         coordonnee[coordCourante].nomX := ANode.Text;
         exit;
      end;
      if ANode.NodeName='Y' then  begin
         coordonnee[coordCourante].nomY := ANode.Text;
         exit;
      end;
      if ANode.NodeName=stMonde then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].iMondeC := TindiceMonde(zByte);
         exit;
      end;
      if ANode.NodeName='GRADUATION' then begin
         zByte := GetIntegerXML(ANode);
         monde[coordCourante].graduation := Tgraduation(zByte);
         exit;
      end;
      if ANode.NodeName=stOptions then begin
         suite;
         exit;
      end;
      if ANode.NodeName=stDefaut then begin
         mondeCourant := TIndiceMonde(ANode.Attributes['Index']);
         suite;
         exit;
      end;
      if ANode.NodeName='ZERO' then begin
         monde[coordCourante].zeroInclus := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='MAXIT' then begin
         maxiTemps := GetFloatXML(ANode);
         exit;
      end;;
      if ANode.NodeName='MINIT' then begin
         miniTemps := GetFloatXML(ANode);
         exit;
      end;;
      if ANode.NodeName='OptGraphe' then begin
         zByte := GetIntegerXML(ANode);
         optionGraphe := TsetOptionGraphe(zByte);
         exit;
      end;
      if ANode.NodeName='OptModele' then begin
         zByte := GetIntegerXML(ANode);
         optionModele := TsetOptionModele(zByte);
         exit;
      end;
      if ANode.NodeName='TEXTE' then begin
          Adessin := Tdessin.create(graphes[1]);
          Adessin.loadXML(ANode);
          dessins.add(Adessin);
          exit;
      end;
      if ANode.NodeName='SHAPE' then begin
          Adessin := Tdessin.create(graphes[1]);
          Adessin.loadXML(ANode);
          dessins.add(Adessin);
          exit;
      end;
      if ANode.NodeName='MODELECALC' then begin
         p := ANode.Attributes[stPage];
         modeleCalc[p] := getBoolXML(ANode);
      end;
      if ANode.NodeName='TRACE' then begin
         zWord := GetIntegerXML(ANode);
         aTrace := TsetTraceXML(zWord);
         coordonnee[coordCourante].Trace := traceFromXML(aTrace);
         exclude(coordonnee[coordCourante].trace,trSonagramme);
         exit;
      end;
      if ANode.NodeName=stCouleur then begin
         zWord := GetIntegerXML(ANode);
         coordonnee[coordCourante].couleur := TColor(zWord);
         exit;
      end;
      if ANode.NodeName='CouleurVitesseImposee' then begin
         CouleurVitesseImposee := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ReperePage' then begin
         reperePage := TreperePage(GetIntegerXML(ANode));
         exit;
      end;
      if ANode.NodeName='SuperPage' then begin
         superposePage := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='AutoTick' then begin
         autoTick := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='NTicks' then begin
         graphes[1].monde[mondeCourant].NTicks := GetIntegerXML(ANode);
         exit;
      end;
      if ANode.NodeName='MinD' then begin
         graphes[1].monde[mondeCourant].Mini := GetFloatXML(ANode);
         avecDefaut := true;
         exit;
      end;
      if ANode.NodeName='MaxD' then begin
         graphes[1].monde[mondeCourant].Maxi := GetFloatXML(ANode);
         exit;
      end;
      if ANode.NodeName='Delta' then begin
         graphes[1].monde[mondeCourant].DeltaAxe := GetFloatXML(ANode);
         exit;
      end;
      if Anode.NodeName='NvecteurMax' then begin
          NbreVecteurVitesseMax := GetIntegerXML(ANode);
          exit;
      end;
      if ANode.NodeName='UseDefaut' then begin
         useDefaut := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ProjeteVect' then begin
         ProjeteVecteur := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName=stFilDeFer then begin
         FilDeFer := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName=stEllipse then begin
         AvecEllipse := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ProlongeVect' then begin
         ProlongeVecteur := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName=stLigne then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].ligne := Tligne(zByte);
         exit;
      end;
      if ANode.NodeName='MOTIF' then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].motif := Tmotif(zByte);
         exit;
      end;
      if ANode.NodeName='OrdreLissage' then begin
         ordreLissage := GetIntegerXML(ANode);
         exit;
      end;
      if ANode.NodeName=stTangente then begin
         p := ANode.Attributes[stPage];
         include(modif,gmEquivalence);
         NewEquivalence := Tequivalence.CreateVide(graphes[1]);
         newEquivalence.loadXML(ANode);
         if (p>0) and (p<MaxPages) then
            equivalences[p].Add(NewEquivalence);
         exit;
      end;
end end; // LoadXMLInReg

var i,j: Integer;
begin
   UnGrapheItem.checked := true;
   TitreAnimCB.checked := false;
   majFichierEnCours := true;
   Curseur := curSelect;
   for j := 1 to 3 do
       resetCoord(j);
   for i := 1 to MaxPages do ModeleCalc[i] := false;
   animationNone.checked := true;
   nbreGraphe := UnGr;
   penWidthCourbe := 1;
   configCharge := true;
   avecDefaut := false;
   if ANode.HasChildNodes then
      for I := 0 to ANode.ChildNodes.Count - 1 do
          LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
   verifCoord;
   if AnimationTemps.Checked or AnimationParam.Checked then affecteAnimation;
end; // litConfigXML

procedure TFgrapheVariab.LineaireItemClick(Sender: TObject);
begin
  setModeleGr(mgLineaire)
end;

Procedure TFgrapheVariab.ValideParam(paramCourant : integer;maj : boolean);
var valeurLoc : double;
begin
     if ValeursParamChange then begin
        try
          valeurLoc := GetFloat(editValeur[paramCourant].text);
          Pages[pageCourante].valeurParam[paramNormal,paramCourant] := valeurLoc;
          if maj then PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
          ValeursParamChange := false;
        except
          EditValeur[paramCourant].SetFocus
        end;
     end
end;

procedure TFgrapheVariab.ValeursParamKeyPress(Sender: TObject; var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then begin
           ValeursParamChange := true;
           TraceAutoCB.checked := false;
     end;
end;

procedure TFgrapheVariab.FormActivate(Sender: TObject);
begin
     inherited;
     InitiationAfaire := InitiationAFaire and
          (imInitiationModele in MenuPermis);
     AnimBtn.visible := imAnimation in menuPermis;
     BornesBtn.visible := imBornes in menuPermis;
     ModeleGrBtn.visible := imModeleGr in menuPermis;
     FregressiMain.GrapheBtn.down := true;
     SplitterModele.Width := Screen.PixelsPerInch div 6;
end;

procedure TFgrapheVariab.ZoomManuelItemClick(Sender: TObject);
var reponse : integer;
begin
     if not grapheCourant.grapheOK then exit;
     if ZoomManuelDlg=nil then
        Application.CreateForm(TzoomManuelDlg, ZoomManuelDlg);
     zoomManuelDlg.Echelle := grapheCourant;
     reponse := ZoomManuelDlg.showModal;
     if reponse in [mrOK,mrNo] then begin
        include(grapheCourant.modif,gmEchelle);
        grapheCourant.monde[mondeX].defini := reponse=mrOK;
        modifGraphe(indexGrCourant);
     end;
end;

Procedure TFgrapheVariab.SetUniteParametre;
begin
    if chercheUniteParam then chercheUniteParametre;
    include(etatModele,UniteParamDefinie);
end;

procedure TFgrapheVariab.EffectueCompile;
var memoActif : boolean;
    i,posFin : integer;
begin
     memoActif := memoModele=activeControl;
     LanceCompile;
     if ModeleDefini in etatModele
        then begin if OptionsDlg.AjustageAutoLinCB.checked and
                    (ModeleLineaire in etatModele)
          then lanceModele(true)
          else begin
             Application.MainForm.Perform(WM_Reg_Maj,MajModele,0);
             if memoActif then begin
                posFin := 0;
                for i := 0 to pred(MemoModele.Lines.count) do
                   posFin := posFin+Length(MemoModele.Lines[i])+2;
                memoModele.selStart := posFin;
                memoModele.selLength := 0;
                MemoModele.setFocus;
             end
             else if not(splitterModele.snapped) then begin
                    setParamEdit;
             end;
          end;
      end
      else if PasDeModele in etatModele then
           Application.MainForm.Perform(WM_Reg_Maj,MajModele,0);
end;

procedure TFgrapheVariab.WMRegAnimation(var Msg : TWMRegMessage);
begin
    Avance := msg.typeMaj=0;
    TimerAnim.enabled := true;
end;

procedure TFgrapheVariab.WMRegModele(var Msg : TWMRegMessage);
begin
     if not(splitterModele.snapped) and
        VisualisationAjustement then begin
        MajParametres;
        MajResultat;
        include(graphes[1].modif,gmModele);
        include(Graphes[1].modif,gmValeurModele);
        PaintBox1.invalidate;
        if paintBox3.visible and residusItem.checked then
           PaintBox3.invalidate;
        if paintBox2.visible and residusItem.checked then
           PaintBox2.invalidate;
    end;
end;

procedure TFgrapheVariab.WMRegCalcul(var Msg : TWMRegMessage);
begin
     case msg.typeMaj of
          calculCompile : effectueCompile;
          calculModele : lanceModele(false);
          calculAjuste : lanceModele(true);
     end;
end;

procedure TFgrapheVariab.CopierModeleItemClick(Sender: TObject);
var p : TcodePage;
begin
     formDDE.RazRTF;
     formDDE.AjouteMemo(memoModele);
     for p := 1 to NbrePages do with pages[p] do begin
         formDDE.Editor.lines.Add(commentaireP);
         formDDE.ajouteStringList(TexteResultatModele);
     end;
     formDDE.envoieRTF;
end;

Procedure TFgrapheVariab.MajIdentPage;
begin
    if ChoixIdentPagesDlg=nil then
         Application.CreateForm(TChoixIdentPagesDlg, ChoixIdentPagesDlg);
    ChoixIdentPagesDlg.InitParam;
end; // MajIdentPage

procedure TFgrapheVariab.InitEquaDiffBtnClick(Sender: TObject);
const Maxi = 2;
var pente : double;
    k,j : integer;
    i,iDebut,iFin : integer;
begin with pages[pageCourante] do begin
     if FonctionTheorique[1].genreC in [g_diff1,g_diff2] then begin
          for k := 1 to NbreModele do with FonctionTheorique[k] do begin
               if calcul^.varx<>nil
                  then j := calcul^.varx.indexG
                  else j := 0;
               if (j>parametre0) then begin // origine est bien un paramètre
                     j := IndexToParam(paramNormal,j);
                     if j<>grandeurInconnue then
                        ValeurParam[paramNormal,j] := valeurVar[indexY,debut[k]]; // inverse ?
               end;
          end; // origine
          if FonctionTheorique[1].genreC=g_diff2 then
             for k := 1 to NbreModele do with FonctionTheorique[k] do begin
                 if calcul^.vary<>nil
                    then j := calcul^.vary.indexG
                    else j := 0;
                 if (j>parametre0) and (j<=parametre0+maxParametres) then begin
                 // pente est bien un paramètre
                       j := IndexToParam(paramNormal,j);
                       Pente := 0;
                       i := 0;
                       iDebut := debut[k];
                       iFin := debut[k]+Maxi;
                       while (i<Maxi) and (iDebut>0) do begin dec(iDebut);inc(i) end;
                         { on essaye de centrer }
                       for i := iDebut to iFin do
                           Pente := Pente + valeurVar[indexYp,i];
                       Pente := Pente/succ(iFin-iDebut);
                       ValeurParam[paramNormal,j] := pente;
                       EditValeur[j].text := formatGeneral(valeurParam[paramNormal,j],3);
                  end;
          end; // pente initiale
     end;// diff
end end;

procedure TFgrapheVariab.IntersectionItemClick(Sender: TObject);
var i,j : integer;
begin
  if (sender as TmenuItem).Checked then // suppression
  for i := 2 to MaxIntervalles do begin
      j := 0;
      while j<graphes[1].equivalences[pageCourante].count do begin
      with graphes[1].equivalences[pageCourante].items[j] do
           if (ligneRappel=lrReticule) and (indexModele=i)
              then graphes[1].equivalences[pageCourante].Delete(j)
              else inc(j);
      end;
  end;
  IntersectionItem.Checked := not (sender as TmenuItem).Checked;
  IntersectionTer.Checked := IntersectionItem.Checked;
  graphes[1].paintBox.invalidate;
end;

procedure TFgrapheVariab.MemoResultatKeyPress(Sender: TObject; var Key: Char);
begin
    key := #0
end;

procedure TFgrapheVariab.memoResultatMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);

function ClientPosToLigne(aEdit: TRichEdit; ClientPos: TPoint): Integer;
var
  charPos : integer;
begin
    (*
     Dans le cas d'un RichEdit, le paramètre représente l'adresse d'une
     structure de type TRect contenant la position en coordonnées écran
     relative au composant.
    *)
    (* La valeur retournée correspond à l'index absolu du caractère le plus
     près du point ou du dernier caractère si le point est plus bas que le
     dernier caractère du contrôle.
    *)
{$IFDEF Win32}
    charPos := aEdit.Perform(EM_CHARFROMPOS, 0, Integer(@ClientPos));
{$ELSE}
    charPos := aEdit.Perform(EM_CHARFROMPOS, 0, LPARAM(@ClientPos));
{$ENDIF}
    result := aEdit.Perform(EM_LINEFROMCHAR, charPos, 0);
end;

var lLigne : integer;
begin
    lLigne := ClientPosToLigne(sender as TRichEdit, Tpoint.Create(x,y));
    if (lLigne<hintMemoResultat.count) and (hintMemoResultat[lLigne]<>'')
       then begin
           hintResultatLabel.top := y+resultatGB.top-toolBarGraphe.height;
           hintResultatLabel.left := 0;
           hintResultatLabel.caption := hintMemoResultat[lLigne];
           memoResultat.Hint := hintMemoResultat[lLigne];
           hintResultatLabel.visible := true;
       end
       else begin
          hintResultatLabel.visible := false;
          memoResultat.Hint := '';
       end;
end;

procedure TFgrapheVariab.MenuAxesPopup(Sender: TObject);
var P : Tpoint;
begin
     TableauXYItem.visible := graphes[1].equivalences[pageCourante].count>0;
     if  TableauXYItem.visible and
        (graphes[1].equivalences[pageCourante][0].ligneRappel in [lrXdeY,lrReticule])
           then begin
                TableauXYItem.caption := stGridValeurs;
                ViderXYItem.caption := stRazValeurs;
           end
           else begin
                TableauXYItem.caption := stGridTangente;
               ViderXYItem.caption := stRazTangente;
           end;
     GetCursorPos(P);
     P := grapheCourant.PaintBox.ScreenToClient(P);
     iPropCourbe := grapheCourant.CoordProche(P.x,P.y);
     with grapheCourant.coordonnee[iPropCourbe] do
          ProprieteCourbe.caption := stCaracDe+' '+nomY+'=f('+nomX+')'; // ' Y=f(X)'
     ViderXYItem.visible := TableauXYItem.visible;
     AffIncertBis.checked := avecEllipse;
     identAction.enabled := (grapheCourant.superposePage and (NbrePages>1)) or
                            (grapheCourant.NbreOrdonnee>1);
     identAction.visible := identAction.enabled;
     SavePosItem.visible := curseur in [curReticule,curEquivalence,curReticuleData,curReticuleDataNew];  // curReticuleModele
end;

procedure TFgrapheVariab.TableauXYItemClick(Sender: TObject);
begin
    graphes[1].RemplitTableauEquivalence;
    if curseurModeleDlg=nil then
       curseurModeleDlg := TcurseurModeleDlg.create(self);
    CurseurModeleDlg.show; // CurseurModeleDlg.showModal ?
    PaintBox1.invalidate;
end;

procedure TFgrapheVariab.ModelGrClick(Sender: TObject);
var p : TcodePage;
    m : TindiceMonde;
begin
    if NbreModele=maxIntervalles then NbreModele := maxIntervalles-1;
    with fonctionTheorique[succ(NbreModele)] do begin
       if grapheCourant.monde[mondeX].axe<>nil then
           indexX := indexNom(grapheCourant.monde[mondeX].axe.nom);
       for m := mondeY to mondeSans do
           if grapheCourant.monde[m].axe<>nil then begin
              indexY := indexNom(grapheCourant.monde[m].axe.nom);
              break;
           end;
    end;
    ChoixModeleDlg.appelMagnum := true;
    ChoixModeleDlg.coordonnee := grapheCourant.coordonnee;
    ChoixModeleDlg.PageControl.ActivePage := ChoixModeleDlg.ModMagnum;
    if ChoixModeleDlg.showModal=mrOk then begin
       for p := 1 to NbrePages do
                pages[p].resetDebutFin(NbreModele);
       if ChoixModeleDlg.modeleChoisi=mgManuel
           then begin
              IsModeleMagnum := false;
              if ChoixModeleDlg.effaceModele then MemoModele.clear;
              with FonctionTheorique[NbreModele] do
                if enTete<>'' then begin
                      MemoModele.lines.Add(enTete+'='+expression);
                      etatModele := [];
                      lanceModele(genreC=g_fonction);
                      TPaintBox(sender).invalidate;
                      exit;
                end
           end
           else ModeleMagnum(ChoixModeleDlg.CoordRG.itemIndex+1,true);
    end;
end;

procedure TFgrapheVariab.ModeleMagnum(indiceCoord : integer;direct : boolean);
var t0 : double;

Procedure setOrigineTemps;
var j : integer;
    indexX : integer;
begin
     indexX := grapheCourant.coordonnee[1].codeX;
     with pages[pageCourante] do
          for j := 0 to pred(nmes) do
              valeurVar[indexX,j] := valeurVar[indexX,j]-t0;
     Application.MainForm.Perform(WM_Reg_Maj,MajValeurGr,0);
end; // setOrigineTemps

var j : integer;
begin with ModeleGraphique[NbreModele] do begin
     init(ChoixModeleDlg.ModeleChoisi,graphes[1],NbreModele,indiceCoord);
     initialiseParametre(
        Pages[pageCourante].debut[NbreModele],
        Pages[pageCourante].fin[NbreModele],
        t0,
        direct);
     if not ModeleOK then begin
        afficheErreur(erModeleGr,0);
        NbreModele := 0;
        exit;
     end;
     if t0<>0 then setOrigineTemps;
     MajModelePermis := false;
     if ChoixModeleDlg.effaceModele then MemoModele.clear;
     for j := 0 to pred(expression.count) do
         MemoModele.lines.Add(expression[j]);
     MajModelePermis := true;
     MemoModeleChange(nil);
     etatModele := [];
     IsModeleMagnum := true;
     Resize;
     LanceCompile;
     for j := 1 to 3 do if graphes[j].paintBox.Visible then
         include(Graphes[j].modif,gmModele);
     if not avecModeleManuel
        then setPenBrush(curModeleGr)
        else setPenBrush(curSelect);
     if direct and not(ModeleGraphique[1].genre in [mgEchelon,mgRadio])
        then pages[pageCourante].resetDebutFin(NbreModele);
     MajModeleGr(NbreModele);
     LanceModele(OptionsDlg.AjustageAutoGrCB.checked);
end end; // modeleMagnum

procedure TFgrapheVariab.MajModeleGr(NumeroGr : integer);
var sauveParam : tableauParam;
begin with pages[pageCourante] do begin
     sauveParam := valeurParam[paramNormal];
     ModeleGraphique[NumeroGr].GetParametres(valeurParam[paramNormal]);
     if ModeleGraphique[NumeroGr].ModeleOK
        then begin
            EffectueModele(false);
            MajParametres;
            MajResultat;
        end
        else valeurParam[paramNormal] := sauveParam;
     include(etatModele,ajustementGraphique);
     include(Graphes[1].modif,gmEchelle);
     include(Graphes[1].Modif,gmValeurModele); {?}
     PaintBox1.invalidate;
end end;

procedure TFgrapheVariab.VideoTrackBarChange(Sender: TObject);
begin
   tempsCourant := pages[pageCourante].ValeurVar[0,VideoTrackBar.Position];
   calculeAnimTemporelle;
   VideoTrackBar.hint := grandeurs[0].formatNomEtUnite(tempsCourant);
//   setToolTip ?
end;

procedure TFgrapheVariab.ViderTangenteItemClick(Sender: TObject);
var p : TcodePage;
    i,j : integer;
begin
     for i := 1 to 3 do with graphes[i] do
         if paintBox.Visible then begin
            for p := 1 to maxPages do
                for j := pred(equivalences[p].count) downto 0 do
                    if equivalences[p][j].ligneRappel in [lrEquivalence,lrEquivalenceManuelle,lrTangente] then
                       equivalences[p].remove(equivalences[p][j]);
            PaintBox.refresh;
         end;
end;

procedure TFgrapheVariab.ViderXYItemClick(Sender: TObject);
var p : TcodePage;
    i,j : integer;
begin
     for i := 1 to 3 do with graphes[i] do
         if paintBox.Visible then begin
            for p := 1 to maxPages do
                for j := pred(equivalences[p].count) downto 0 do
                    if equivalences[p][j].ligneRappel in [lrXdeY,lrX,lrY,lrReticule,lrPente] then
                       equivalences[p].remove(equivalences[p][j]);
            PaintBox.refresh;
         end;
end;

procedure TFgrapheVariab.SetPointCourant(i,c : integer);

Procedure AffichePointCourant;
var xi,yi,dimP : Integer;
begin if indexPointCourant>=0 then
with PaintBox1.canvas,graphes[1].courbes[courbePointCourant] do begin
        Pen.color := color;
        Pen.mode := pmNotXor;
        Pen.style := psSolid;
        Brush.color := pen.color;
        Brush.style := bsSolid;
        graphes[1].WindowRT(valX[indexPointCourant],valY[indexPointCourant],iMondeC,Xi,Yi);
        DimP := graphes[1].dimPoint+2;
        Ellipse(xi-dimP,yi-dimP,xi+dimP+1,yi+dimP+1);
        Brush.style := bsClear;
        canvas.pen.mode := pmCopy;
end end;

begin
     AffichePointCourant; // efface
     if curseur in [curSelect,curReticule,curReticuleData,curEquivalence,curMove]
        then indexPointCourant := i
        else indexPointCourant := -1;
     courbePointCourant := c;
     if indexPointCourant>=0 then
        Application.MainForm.perform(WM_Reg_Maj,MajNumeroMesure,i);
     AffichePointCourant; // retrace
end;

procedure TFgrapheVariab.TraceCurseurCourant(indexGr : integer);
var i : integer;
begin with graphes[indexGr] do
     case curseur of
          curReticule : begin
            for i := 1 to cCourant do traceReticule(i);
            if cCourant>1 then traceEcart;
          end;
          curReticuleData : if curseurGrid.visible then setStatusReticuleData(curseurGrid);
          curReticuleDataNew : traceReticule(curseurData1);
          curReticuleModele : ;
          curEquivalence : if equivalenceCourante<>nil then
               equivalenceCourante.drawFugitif;
          curOrigine : with canvas do begin
               pen.Width := 3;
               pen.Style := psDash;
               pen.Color := clRed;
               moveTo(XorigineInt,0);
               lineTo(XorigineInt,height);
          end;
    end;
end;

procedure TFgrapheVariab.TrigoBtnClick(Sender: TObject);
begin
     if OKreg(labelCaptionAngle[not angleEnDegre],0) then Fvaleurs.ChangeAngle(not AngleEnDegre);
end;

procedure TFgrapheVariab.ToolButton1Click(Sender: TObject);
var indexV,j,k,numO : integer;
    couleursUtilisees : set of TindiceOrdonnee;
begin with grapheCourant do begin
     indexV := (sender as TtoolButton).tag;
     numO := 0;
     couleursUtilisees := [];
     for j := 1 to NbreOrdonnee do // test existe déjà  ?
         if indexV=coordonnee[j].codeY then numO := j;
     if numO>0 then begin // supprime
        coordonnee[numO].nomX := '';
        coordonnee[numO].nomY := '';
     end
     else begin // ajoute
         if NbreOrdonnee<MaxOrdonnee
           then begin
              for j := 1 to NbreOrdonnee do
                  for k := 1 to MaxOrdonnee do
                      if coordonnee[j].couleur=couleurInit[k] then
                         include(couleursUtilisees,k);
              inc(NbreOrdonnee);
              numO := NbreOrdonnee;
           end
           else begin
              numO := 1;
              for j := 2 to MaxOrdonnee do
                  for k := 1 to MaxOrdonnee do
                      if coordonnee[j].couleur=couleurInit[k] then
                         include(couleursUtilisees,k);
           end;
         coordonnee[numO].codeY := indexV;
         coordonnee[numO].nomY := grandeurs[indexV].nom;
         coordonnee[numO].codeX := coordonnee[1].codeX;
         coordonnee[numO].nomX := coordonnee[1].nomX;
         if grandeurBoutonDroit
              then coordonnee[numO].iMondeC := mondeDroit
              else coordonnee[numO].iMondeC := mondeY;
         if numO>1 then begin
             coordonnee[numO].trace := coordonnee[1].trace;
             coordonnee[numO].ligne := coordonnee[1].ligne;
         end;
         for j := 1 to MaxOrdonnee do
             if not(j in couleursUtilisees) then begin
                 coordonnee[numO].couleur := couleurInit[j];
                 coordonnee[numO].motif := motifInit[j];
                 break;
             end;
     end;
  include(modif,gmXY);
  ModifGraphe(indexGrCourant);
  GrandeurBoutonDroit := false;
end end;

procedure TFgrapheVariab.ToolButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    GrandeurBoutonDroit := (button=mbRight);
    if GrandeurBoutonDroit then ToolButton1Click(sender);
end;

procedure TFgrapheVariab.TraceAutoBtnClick(Sender: TObject);
begin
     if TraceAutoCB.checked
        then exclude(Graphes[1].OptionModele,OmManuel)
        else include(Graphes[1].OptionModele,OmManuel)
end;


procedure TFgrapheVariab.MemoModeleClick(Sender: TObject);
begin
     if curseur=curModeleGr then setPenBrush(curSelect)
end;

procedure TFgrapheVariab.MajBtnClick(Sender: TObject);
begin
     PostMessage(handle,WM_Reg_Calcul,CalculCompile,0)
end;

procedure TFgrapheVariab.ImprimeGrItemClick(Sender: TObject);
var i,bas : integer;
    hg : double;
begin
     if not graphes[1].grapheOK then exit;
     try
     if PaintBox2.visible
        then begin if OKreg(OkImprGr,0) then begin
              debutImpressionGr(poPortrait,bas);
              for i := 1 to 3 do
                  if graphes[i].paintBox.visible then
                     graphes[i].versImprimante(HautGrapheGr,bas);
              finImpressionGr;
        end end
        else begin
              debutImpressionGr(printer.orientation,bas);
              if printer.orientation=poLandscape
                 then HG := HautGraphePaysage
                 else HG := HautGrapheGr;
              graphes[1].versImprimante(HG,bas);
              finImpressionGr;
        end;
        except
             on E: Exception do begin
                 showMessage(E.message);
                 try
                 printer.abort;
                 except
                 end;
             end;
        end;
end;

Procedure TFgrapheVariab.WmRegOrigine;
var j,indexX : integer;
    nom : string;
    indexDelta,indexNewTime : integer;
    gdelta,gNewTime : tgrandeur;
    GrandeursModifiees : boolean;
    posErreur,longErreur : integer;
begin
     indexX := grapheCourant.coordonnee[1].codeX;
     if OrigineDlg=nil then
        Application.CreateForm(TOrigineDlg, OrigineDlg);
     OrigineDlg.index := indexX;
     GrandeursModifiees := false;
     case OrigineDlg.showModal of
        mrYes : with pages[pageCourante] do
            for j := 0 to pred(nmes) do
                valeurVar[indexX,j] := valeurVar[indexX,j]-xOrigine;
        mrNo : begin
            nom := deltaMaj+grandeurs[indexX].nom;
            indexDelta := indexNom(nom);
            if indexDelta=grandeurInconnue then begin
               gDelta := Tgrandeur.create;
               gdelta.Init(nom,grandeurs[indexX].NomUnite,'',constante);
               indexDelta := ajouteGrandeurE(gDelta);
               GrandeursModifiees := true;
               ModifFichier := true;
            end;
            pages[pageCourante].valeurConst[indexDelta] := xOrigine;
            nom := grandeurs[indexX].nom+'0';
            indexNewTime := indexNom(nom);
            if indexNewTime=grandeurInconnue then begin
               gNewTime := Tgrandeur.create;
               gNewTime.Init(nom,grandeurs[indexX].NomUnite,OrigineDlg.ligneCompile,variable);
               gNewTime.fonct.depend := [indexX,indexDelta];
               gNewTime.compileG(posErreur,longErreur,0);
               indexNewTime := ajouteGrandeurE(gNewTime);
               grandeurs[indexNewTime].fonct.genreC := g_fonction;
               ModifFichier := true;
               Fvaleurs.Memo.Lines.Add(OrigineDlg.ligneCompile);
               GrandeursModifiees := true;
            end;
            with pages[pageCourante] do
                 for j := 0 to pred(nmes) do
                     valeurVar[indexNewTime,j] := valeurVar[indexX,j]-xOrigine;
        end;
        mrCancel : exit;
      end;
      if grandeursModifiees then
         Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
      Application.MainForm.Perform(WM_Reg_Maj,MajValeurGr,0);
end; // WMRegOrigine

procedure TFgrapheVariab.MemoModeleKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (key=crCR) and (FregressiMain.KeypadReturn)
       then begin
           key := #0;
           MajBtnClick(Sender);
       end;
     etatModele := []; // ??
end;

procedure TFgrapheVariab.BornesClick(Sender: TObject);
begin
     BorneActive := (sender as Tcomponent).tag;
     AffecteStatusPanel(HeaderXY,0,(sender as TmenuItem).hint);
     setPenBrush(curBornes);
     activeControl := panelPrinc;
end;

procedure TFgrapheVariab.BornesMenuPopup(Sender: TObject);
var i : integer;
begin
     if not (ModeleDefini in etatModele) then LanceCompile;
     pages[pageCourante].VerifIntervalles;
     for i := 1 to NbreModele do
         with BornesMenu.items[pred(i)] do begin
            caption := stBorne+fonctionTheorique[i].enTete+'='+copy(fonctionTheorique[i].expression,1,10);
            hint := stBorneSelect;
            visible := true;
         end;
     if NbreModele<MaxIntervalles then
         with BornesMenu.items[NbreModele] do begin
            hint := hBornes;
            caption := trBornesModele;
            visible := true;
         end;
     for i := NbreModele+2 to MaxIntervalles do
         BornesMenu.items[pred(i)].visible := false;
end;

procedure TFgrapheVariab.RazBornesClick(Sender: TObject);
var i : integer;
begin with pages[pageCourante] do begin
         ModeleCalcule := false;
         ModeleErrone := false;
         for i := 1 to maxIntervalles do resetDebutFin(i);
         include(graphes[1].modif,gmModele);
         graphes[1].borneVisible := true;
         resetPointActif;
         PaintBox1.invalidate;
end end;

procedure TFgrapheVariab.ResidusItemClick(Sender: TObject);
begin
     ResidusItem.checked := not ResidusItem.checked;
     ResidusItemBis.checked := ResidusItem.checked;
     if ResidusItem.checked then begin
        residusNormalisesCB.visible := fonctionTheorique[1].residuStat.avecIncert;
        if (fonctionTheorique[1].residuStat.avecIncert)
           then residusNormalisesCB.checked := true;
        Application.MainForm.Perform(WM_Reg_Maj,MajModele,0);
        PaintBox3.height := panelPrinc.height div 3;
     end
     else if UnGrapheItem.checked then begin
          paintBox3.Visible := false;
          panelBis.visible := false;
          paintBox2.Visible := false;
     end;
     indexGrCourant := 1;
     grapheCourant := Graphes[1];
     invalidate;
end;

procedure TFgrapheVariab.ResidusNormalisesCBClick(Sender: TObject);
begin
  setCoordonneeResidu;
end;

procedure TFgrapheVariab.ImprModeleBtnClick(Sender: TObject);
var bas : integer;

procedure ImprimeModele;
var i : integer;
    p : TcodePage;

Procedure ImprimePage(p : TcodePage);
var i : integer;
begin with pages[p] do begin
      ImprimerLigne(TitrePage,bas);
      for i := 0 to pred(TexteResultatModele.Count) do
          ImprimerLigne(TexteResultatModele[i],bas);
end end;

begin
         DebutImpressionTexte(bas);
         ImprimerLigne(stModelisation,bas);
         for i := 0 to pred(TexteModele.count) do
             if TexteModele[i]<>'' then ImprimerLigne(TexteModele[i],bas);
         if graphes[1].superposePage
            then begin
               for p := 1 to NbrePages do if pages[p].active
                   then ImprimePage(p)
            end
            else imprimePage(pageCourante);
end;

begin
     if OKreg(OkImprModele,0) then begin
           try
           debutImpressionGr(poPortrait,bas);
           bas := 0;
           graphes[1].versImprimante(HautGrapheGr,bas);
           ImprimeModele;
           finImpressionGr;
           except
           end;
     end;
end;

Procedure TFgrapheVariab.ResetHeaderXY;
var i : integer;
begin
     for i := 0 to pred(HeaderXY.panels.count) do VideStatusPanel(HeaderXY,i)
end;

procedure TFgrapheVariab.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
    paintBoxC : TpaintBox;
    i : integer;
    xi,yi : Integer;

Function Supprime(posSouris : Tpoint) : boolean;
var i : integer;
    aEquivalence : Tequivalence;
    xi,yi : integer;
    trouve,trouveI : boolean;
begin with grapheCourant do begin
     trouve := false;
     i := 0;
     while i<equivalences[pageCourante].count do begin
            AEquivalence := equivalences[pageCourante].items[i];
            with AEquivalence do begin
               WindowRT(x1,y1,mondeY,xi,yi);
               trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               if not trouveI then begin
                  WindowRT(x2,y2,mondeY,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
               if not trouveI then begin
                  WindowRT(ve,pHe,mondeY,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
                // supprime
               if trouveI then begin
                  equivalences[pageCourante].Remove(AEquivalence);
                  trouve := true;
               end
               else inc(i);
            end;// with newEq
      end; // while
      if trouve then PaintBox.invalidate;
      result := trouve;
end end;

Function MajI  : boolean;
begin with pages[pageCourante] do begin
      result := true;
      case key of
           vk_left,vk_down : dec(i);
           vk_return : ;
           vk_right,vk_up : inc(i);
           vk_prior : dec(i,10);
           vk_home : i := 0;
           vk_end : i := pred(nmes);
           vk_next : inc(i,10);
           else result := false;
       end;
       if i<0 then i := 0;
       if i>=nmes then i := pred(nmes);
       if result then key := 0;
end end;

(*
Function MajImodele  : boolean;
var xc,yc : integer;
begin with grapheCourant do begin
      result := true;
      xc := curseurOsc[1].xc;
      yc := curseurOsc[1].yc;
      case key of
           vk_left : if ssShift in Shift
              then setReticuleModele(Xc-8,Yc,true,false)
              else setReticuleModele(Xc-2,Yc,true,false);
           vk_down : if ssShift in Shift
              then setReticuleModele(Xc,Yc+8,false,true)
              else setReticuleModele(Xc,Yc+2,false,true);
           vk_return : ;
           vk_right : if ssShift in Shift
              then setReticuleModele(Xc+8,Yc,true,false)
              else setReticuleModele(Xc+2,Yc,true,false);
           vk_up : if ssShift in Shift
              then setReticuleModele(Xc,Yc-8,false,true)
              else setReticuleModele(Xc,Yc-2,false,true);
           vk_prior : setReticuleModele(Xc-8,Yc,true,false);
           vk_home : ;
           vk_end : ;
           vk_next : setReticuleModele(Xc+8,Yc,true,false);
           else result := false;
       end;
       if result then key := 0;
end end;
*)

Function MajParamAnim: boolean;

procedure setValeur(code : integer);
begin with ParamAnimManuelle[paramAnimCourant] do
     sliderA.Position := sliderA.position+code;
end;

begin
     result := true;
     case key of
           vk_left,vk_down : if ssShift in Shift
              then setValeur(-8)
              else setValeur(-1);
           vk_right,vk_up : if ssShift in Shift
              then setValeur(8)
              else setValeur(1);
           vk_prior : setValeur(8);
           vk_home : ParamAnimManuelle[paramAnimCourant].sliderA.position := 0;
           vk_end : ParamAnimManuelle[paramAnimCourant].sliderA.position :=
                    ParamAnimManuelle[paramAnimCourant].sliderA.Max;
           vk_next : setValeur(-8);
           else result := false;
       end;
       if result then key := 0;
end;

begin // FormKeyDown
     if ssAlt in Shift then begin
        case key of
             ord('C') : CoordonneesItemClick(nil);
             ord('I') : ImprimeGrItemClick(nil);
        end;
        exit;
     end;
     if AnimationParam.checked and MajParamAnim then exit;
     paintBoxC := grapheCourant.PaintBox;
     P := mouse.CursorPos;
     P := PaintBoxC.ScreenToClient(P);
     if (P.X<0) or (P.X>paintBoxC.width) or
        (P.Y<0) or (P.Y>paintBoxC.height) then exit;
     with pages[pageCourante] do case curseur of
       curXmaxi,curYMini,curXMini,curYmaxi : exit;
       curReticuleData : begin
            if key=vk_escape then begin
               setPenBrush(CurSelect);
               exit;
            end;
            grapheCourant.GetCurseurProche(P.x,P.y,true);
            i := grapheCourant.curseurOsc[grapheCourant.cCourant].Ic;
            if MajI then begin
                 setPointCourant(i,0);
                 grapheCourant.setSegmentReal(i);
                 if curseurGrid.visible then grapheCourant.setStatusReticuleData(curseurGrid);
                 exit;
            end;
        end;
        curTexte,curLigne : if key=vk_escape then begin
           grapheCourant.dessinCourant.free;
           grapheCourant.dessinCourant := nil;
           exit;
        end;
        curReticuleModele : ;
         (*
        curReticuleModele : begin
           if key=vk_escape then begin
              setPenBrush(CurSelect);
              exit;
           end;
           if MajImodele then exit;
        end;
        *)
        curEfface,curReticule,curReticuleDataNew : if key=vk_escape then begin
           setPenBrush(CurSelect);
           exit;
        end;
        curEquivalence : if grapheCourant.equivalenceCourante<>nil then
        with grapheCourant.equivalenceCourante do begin
           grapheCourant.windowRT(Ve,pHe,mondeY,xi,yi);
           P := Point(xi,yi);
           i := grapheCourant.PointProche(P.x,P.y,grapheCourant.indexCourbeEquivalence,true,ligneRappel=lrTangente);
           if (key=vk_return) and (i>=0) then begin
              grapheCourant.AjouteEquivalence(i,true);
              if (grapheCourant.indexCourbeEquivalence>=0) then setPointCourant(i,grapheCourant.indexCourbeEquivalence);
              ResetHeaderXY;
              if curseurGrid.visible then begin
                 for i := 0 to pred(grapheCourant.statusSegment[1].count) do
                    CurseurGrid.cells[1,i] := grapheCourant.statusSegment[1].strings[i];
                 for i := 0 to pred(grapheCourant.statusSegment[0].count) do
                    CurseurGrid.cells[0,i] := grapheCourant.statusSegment[0].strings[i];
                 CurseurGrid.rowCount := grapheCourant.statusSegment[0].count;
                 CurseurGrid.height := CurseurGrid.RowCount*CurseurGrid.DefaultRowHeight;
              end;
              exit;
           end;
           if majI then begin
              grapheCourant.equivalenceCourante.drawFugitif; // efface
              SetValeurEquivalence(i);
              ResetHeaderXY;
              if curseurGrid.visible then begin
                 CurseurGrid.cells[1,0] := 'n°'+IntToStr(i);
                 CurseurGrid.cells[1,1] := grapheCourant.monde[mondeX].Axe.formatNomEtUnite(ve);
                 CurseurGrid.cells[1,2] := grapheCourant.monde[mondeY].Axe.FormatNomEtUnite(phe);
                 CurseurGrid.cells[1,3] := grapheCourant.unitePente.formatValeurPente(pente);
                 CurseurGrid.rowCount := 4;
                 CurseurGrid.height := 4*CurseurGrid.DefaultRowHeight;
              end;
              grapheCourant.equivalenceCourante.drawFugitif; // trace
              exit;
           end;
        end;
     end; // case curseur
     case key of
          vk_left,vk_numpad4: if ssShift in Shift then dec(P.X,4)else dec(P.X);
          vk_right,vk_numpad6: if ssShift in Shift then inc(P.X,4)else inc(P.X);
          vk_down,vk_numpad2 : if ssShift in Shift then inc(P.Y,4)else inc(P.Y);
          vk_up,vk_numpad8 : if ssShift in Shift then dec(P.Y,4) else dec(P.Y);
          vk_prior : dec(P.X,16);
          vk_next : inc(P.X,16);
          vk_escape : ;
          vk_delete,vk_back,110 : begin
             if curseur=curSelect then begin
                if supprime(P) then exit;
                grapheCourant.SetDessinCourant(P.x,P.y);
                if grapheCourant.posDessinCourant<>sdNone
                   then with grapheCourant.dessins do begin
                      Remove(grapheCourant.DessinCourant);
                      PaintBoxC.invalidate;
                      key := 0;
                      exit;
                   end;
             end;
             if (curseur in [curSelect,curReticule,curReticuleData,curEquivalence]) and
                (indexPointCourant>=0) then begin
                   Pages[pageCourante].SupprimeLignes(indexPointCourant,indexPointCourant);
                   Application.MainForm.Perform(WM_Reg_Maj,MajSupprPoints,0);
                   key := 0;
                   exit;
             end;
             exit;
          end
          else exit;
     end; // case key
     P := PaintBoxC.ClientToScreen(P);
     mouse.CursorPos := P;
end; // FormKeyDown

procedure TFgrapheVariab.DessinDeleteItemClick(Sender: TObject);
var P : Tpoint;
begin
      if grapheCourant.DessinCourant=nil then begin
         P := menuDessin.PopupPoint;
         P := grapheCourant.paintBox.ScreenToClient(P);
         grapheCourant.setDessinCourant(P.x,P.y);
      end;
      if grapheCourant.DessinCourant=nil then exit;
      if (grapheCourant.dessinCourant.identification=identDroite) and
         (grapheCourant.dessinCourant.proprietaire<>nil) then begin
         grapheCourant.DessinCourant.proprietaire.sousDessin := nil;
         grapheCourant.DessinCourant.proprietaire.TexteLigne := tlNone;
      end;
      graphes[indexGrCourant].dessins.Remove(grapheCourant.DessinCourant);
      ModifGraphe(indexGrCourant);
      grapheCourant.DessinCourant := nil;
end;

procedure TFgrapheVariab.DessinOptionsItemClick(Sender: TObject);
var P : Tpoint;
begin
    if grapheCourant.DessinCourant=nil then begin
         P := menuDessin.PopupPoint;
         P := grapheCourant.paintBox.ScreenToClient(P);
         grapheCourant.setDessinCourant(P.x,P.y);
    end;
    if grapheCourant.DessinCourant=nil then exit;
    grapheCourant.dessinCourant.litOption(grapheCourant);
    grapheCourant.paintBox.invalidate;
    grapheCourant.DessinCourant := nil;
end;

procedure TFgrapheVariab.FormShortCut(var Msg: TWMKey;var Handled: Boolean);

function SupprEquivalence : boolean;
var posSouris : Tpoint;
    i,xi,yi : integer;
    EquivalenceLoc : Tequivalence;
begin
    result := false;
    if not (curseur in [curReticule,curReticuleData,curReticuleDataNew,curSelect]) then exit;
    GetCursorPos(PosSouris);
    PosSouris := grapheCourant.PaintBox.ScreenToClient(PosSouris);
    if (PosSouris.X<0) or (PosSouris.X>grapheCourant.paintBox.width) or
       (PosSouris.Y<0) or (PosSouris.Y>grapheCourant.paintBox.height) then exit;
    for i := 0 to pred(grapheCourant.equivalences[pageCourante].count) do begin
        EquivalenceLoc := grapheCourant.equivalences[pageCourante].items[i];
        with EquivalenceLoc do begin
             grapheCourant.WindowRT(ve,pHe,mondeY,xi,yi);
             if (ligneRappel=lrReticule) and
                ((abs(posSouris.x-xi)+abs(posSouris.y-yi))<12) then begin // supprime
                     grapheCourant.equivalences[pageCourante].Remove(EquivalenceLoc);
                     grapheCourant.PaintBox.invalidate;
                     result := true;
                     handled := true;
                     break;
              end; // supprime
        end;// with Equivalence
   end;//for i
end;

begin
     case msg.charCode of
          vk_delete : if (curseur=curSelect) and (grapheCourant.dessinCourant<>nil)
            then with grapheCourant.dessins do begin
                Remove(grapheCourant.DessinCourant);
                grapheCourant.PaintBox.invalidate;
                handled := true;
            end
            else if not SupprEquivalence then
            if (curseur in [curSelect,curReticule,curReticuleData,curEquivalence]) and
                    (indexPointCourant>=0) then begin
                Pages[pageCourante].SupprimeLignes(indexPointCourant,indexPointCourant);
                Application.MainForm.Perform(WM_Reg_Maj,MajSupprPoints,0);
                handled := true;
          end; // vk_delete
          vk_F2 : if not(splitterModele.snapped) and
                MajBtn.enabled then begin
                   MajBtnClick(nil);
                   handled := true;
          end;
          vk_F3 : if not(splitterModele.snapped) then begin
                AjusteBtnClick(nil);
                handled := true;
          end;
          vk_F4 : if bruitPresentGlb then begin
                randomBtnClick(nil);
                handled := true;
          end;
          vk_F9 : begin
              setPanelModele(splitterModele.snapped);
              handled := true;
          end;
          vk_F10 : if curseur in [curReticule,curEquivalence,
                                  curReticuleData,curReticuleDataNew] then begin //  curReticuleModele
              SavePosItemClick(nil);
              handled := true;
          end;
          vk_cancel :  if curseur<>curSelect then begin
                setPenBrush(curSelect);
                grapheCourant.PaintBox.invalidate;
                handled := true;
          end;
          vk_space : begin
             toucheEspace;
             handled := true;
          end;
     end;
end;  // FormShortCut

procedure TFgrapheVariab.identPages;
var Deltax : integer;

Procedure TraceMarque(p : TcodePage);
var Dessin : Tdessin;
    prompt : string;
    i : integer;
begin
      Dessin := nil;
      with grapheCourant.dessins do
           for i := 0 to pred(count) do
               if items[i].numPage=p then begin
                    Dessin := items[i];
                    if not pages[p].active then remove(dessin);
                    break;
               end;
      if not pages[p].active then exit;
      if Dessin=nil then begin
         Dessin := Tdessin.create(graphes[1]);
         with Dessin do begin
            isTexte := true;
            hauteur := 3;
            NumPage := p;
            vertical := false;
            pen.color := couleurPages[P mod NbreCouleur];
            motifCourbe := motifPages[P mod NbreCouleur];
            setUnPointInt((deltax div 2)+deltax*(p-1),32);
            graphes[1].dessins.add(Dessin);
         end;
      end;
      with Dessin do begin
         try
         dessin.Texte.clear;
         if choixIdentPagesDlg.commentaireCB.checked then texte.Add('%S');
         prompt := '';
         for i := 0 to pred(NbreConst) do
             if choixIdentPagesDlg.ListeConstBox.checked[i] then
                if prompt=''
                   then prompt:='%C'+intToStr(1+i)
                   else prompt:=prompt+' ; %C'+intToStr(1+i);
         if prompt<>'' then texte.add(prompt);
         if ModeleDefini in etatModele then begin
            prompt := '';
            for i := 1 to NbreParam[ParamNormal] do
                if choixIdentPagesDlg.ListeConstBox.checked[NbreConst+pred(i)] then
                    if prompt=''
                       then prompt:='%P'+intToStr(i)
                       else prompt:=prompt+' ; %P'+intToStr(i);
            if prompt<>'' then texte.add(prompt);
         end;
         except // protection ListConstBox
             choixIdentPagesDlg.initParam;
         end;
      end;
end; // TraceMarque

Procedure SupprIdentPage;
var i : integer;
begin
    i := 0;
    with grapheCourant do
    while (i<dessins.count) do begin
       if (dessins[i].numPage>0)
          then Dessins.remove(dessins[i])
          else inc(i);
    end;
end; // SupprIdentPage

var i : integer;
    withPanneau : boolean;
    p : TcodePage;
begin
    if not grapheCourant.grapheOK then exit;
    withPanneau := IdentAction.enabled and IdentAction.checked;
    if withPanneau then begin
          if (ChoixIdentPagesDlg=nil) then
             Application.CreateForm(TChoixIdentPagesDlg, ChoixIdentPagesDlg);
          choixIdentPagesDlg.initParam;
          choixIdentPagesDlg.showModal;
          withPanneau := choixIdentPagesDlg.newIdentPageCB.checked;
          if not withPanneau then begin
               deltax := paintBox1.Width div NbrePages;
               for p := 1 to NbrePages do
                   traceMarque(p);
          end;
    end
    else SupprIdentPage;
    for i := 1 to 3 do begin
       graphes[i].identificationPages := withPanneau;
       modifGraphe(i);
    end;
end; // IdentPages

procedure TFgrapheVariab.identifierPages(Sender : TObject);
begin
     if grapheCourant.superposePage and (nbrePages>1)
        then IdentPages
        else MajIdentCoord(indexGrCourant);
end;

Procedure TFgrapheVariab.MajIdentCoord(indexGr : integer);

Procedure IdentifierCoord;
var Xcoord,Y1c,Y2c : double;
    Jc : integer;

Procedure MarqueCoord(coord : TindiceOrdonnee);
var Dessin : Tdessin;
    i,codeLoc : integer;
    aTexte : string;
begin with graphes[indexGr] do begin
      codeLoc := Coordonnee[coord].codeY;
      with dessins do
           for i := 0 to pred(count) do
               if (items[i].identification=identCoord) and
                  (items[i].numCoord=codeLoc) then
                    exit;
      Dessin := Tdessin.create(graphes[indexGr]);
      with Dessin do begin
           isTexte := true;
           avecLigneRappel := false;
           iMonde := Coordonnee[coord].iMondeC;
           vertical := false;
           pen.color := Coordonnee[coord].couleur;
           motifCourbe := Coordonnee[coord].motif;
           identification := identCoord;
           x1 := Xcoord;
           y1 := Y1c;
           x2 := Xcoord;
           y2 := Y2c;
           numPoint := Jc;
           numCoord := codeLoc;
           numPage := pageCourante;
           aTexte := grandeurs[numCoord].nom;
           if not UnAxeX then
              aTexte := aTexte+'('+grandeurs[coordonnee[coord].codeX].nom+')';
           with grandeurs[numCoord] do if fonct.expression<>'' then
                 aTexte := aTexte+' : '+fonct.expression;
           texte.add(aTexte);
      end;
      dessins.add(Dessin);
end end; // MarqueCoord

var coord : TindiceOrdonnee;
    deltaY,minY,maxY : double;
    pasJ : integer;
begin with graphes[indexGr] do begin
    pasJ := 2*pages[pageCourante].nmes div NbreOrdonnee div 3;
    for coord := 1 to NbreOrdonnee do with Coordonnee[coord] do begin
          if (grandeurs[codeX].fonct.genreC=g_Texte) or
             (grandeurs[codeY].fonct.genreC=g_Texte) then continue;
          Jc := pasJ*coord;
          deltaY := (monde[iMondeC].maxi-monde[iMondeC].mini)/10;
          MaxY := monde[iMondeC].maxi-deltaY;
          MinY := monde[iMondeC].mini+deltaY;
          Xcoord := pages[pageCourante].valeurVar[codeX,Jc];
          if grandeurs[codeY].genreG=variable
              then Y1c := pages[pageCourante].valeurVar[codeY,Jc]
              else Y1c := pages[pageCourante].valeurConst[codeY];
          if Y1c>maxY then Y1c := maxY;
          if Y1c<minY then Y1c := minY;
          if Y1c>(maxY+minY)/2
             then Y2c := Y1c-deltaY
             else Y2c := Y1c+deltaY;
          MarqueCoord(coord);
    end;
end end; // IdentifierCoord

Procedure SupprTout;
var i : integer;
begin with graphes[indexGr] do begin
    i := 0;
    while (i<dessins.count) do
       if dessins[i].identification=identCoord
          then Dessins.remove(dessins[i])
          else inc(i);
end end;

begin
    if IdentAction.checked
        then IdentifierCoord
        else SupprTout;
    graphes[indexGrCourant].identificationPages := false;
    modifGraphe(indexGrCourant);
end; // MajIdentCoord

procedure TFgrapheVariab.ToucheEspace;

Procedure affecteXY(x,y : double);
var Lligne : integer;
begin
     if curseurModeleDlg=nil then
        curseurModeleDlg := TcurseurModeleDlg.create(self);
     if curseurModeleDlg.visible then begin
         Lligne := grapheCourant.equivalences[pageCourante].count+1; // ligne 0 : nom, 1 : unité
         if Lligne>(curseurModeleDlg.tableau.rowCount-2) then
            curseurModeleDlg.tableau.rowCount := Lligne+2;
         curseurModeleDlg.tableau.cells[0,Lligne] := FormatReg(x);
         curseurModeleDlg.tableau.cells[1,Lligne] := FormatReg(y);
     end;
end;

procedure CreerXYdata(typeXY : TligneRappel);
var NewEquivalence : Tequivalence;
begin with grapheCourant,curseurOsc[curseurData1] do begin
     NewEquivalence := Tequivalence.Create(
                 xr,yr,curseurOsc[curseurData2].xr,curseurOsc[curseurData2].yr,
                 0,0,0,grapheCourant);
     NewEquivalence.mondepH := mondeC;
     NewEquivalence.ligneRappel := typeXY;
     equivalences[pageCourante].Add(NewEquivalence);
     affecteXY(xr,yr);
end end;

procedure CreerXY(typeXY : TligneRappel);
var NewEquivalence : Tequivalence;
begin with grapheCourant,curseurOsc[1] do begin
     NewEquivalence := Tequivalence.Create(
                 xr,yr,curseurOsc[2].xr,curseurOsc[2].yr,
                 0,0,0,grapheCourant);
     NewEquivalence.mondepH := mondeC;
     NewEquivalence.ligneRappel := typeXY;
     equivalences[pageCourante].Add(NewEquivalence);
     affecteXY(xr,yr);
end end;

Function Supprime(posSouris : Tpoint;aMonde : TindiceMonde) : boolean;
var i : integer;
    AEquivalence : Tequivalence;
    xi,yi : integer;
    trouve,trouveI : boolean;
begin with grapheCourant do begin
     trouve := false;
     i := 0;
     while i<equivalences[pageCourante].count do begin
            AEquivalence := equivalences[pageCourante].items[i];
            with AEquivalence do if (ligneRappel in [lrReticule,lrX,lrY,lrPente]) then begin
               WindowRT(x1,y1,aMonde,xi,yi);
               trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               if not trouveI then begin
                  WindowRT(x2,y2,aMonde,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
               if not trouveI then begin
                  WindowRT(ve,pHe,aMonde,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
                // supprime
               if trouveI then begin
                  equivalences[pageCourante].Remove(AEquivalence);
                  trouve := true;
               end
               else inc(i);
            end// with AEquivalence
            else inc(i);
         end; // while
         if trouve then PaintBox.invalidate;
         result := trouve;
end end;

var posSouris : Tpoint;
    j : integer;
    xrS,yrS : double;
    NewEquivalence : Tequivalence;
    icourbe,mondeLoc : integer;
begin // ToucheEspace
   case curseur of
    curReticule : with grapheCourant do begin
        GetCursorPos(PosSouris);
        PosSouris := PaintBox.ScreenToClient(PosSouris);
        if (PosSouris.X<0) or (PosSouris.X>paintBox.width) or
           (PosSouris.Y<0) or (PosSouris.Y>paintBox.height) then exit;
        with posSouris do iCourbe := courbeProche(x,y);
        if iCourbe<0
            then mondeLoc := mondeY
            else mondeLoc := courbes[iCourbe].iMondeC;
        if supprime(posSouris,mondeLoc) then exit;
        if cCourant=3 then begin
              CreerXY(lrX);
              CreerXY(lrY);
              CreerXY(lrPente);
         end
         else begin
            mondeRT(posSouris.x,posSouris.y,mondeLoc,xrS,yrS);
            NewEquivalence := Tequivalence.Create(0,0,0,0,xrS,yrS,
                   0,grapheCourant);
            NewEquivalence.mondepH := mondeLoc;
            NewEquivalence.ligneRappel := lrReticule;
            equivalences[pageCourante].Add(NewEquivalence);
            affecteXY(xrS,yrS);
         end;
         PaintBox.invalidate;
   end;// curReticule
   curReticuleData : with grapheCourant do begin
        if supprime(posSouris,curseurOsc[curseurData1].mondeC) then exit;
        for j := curseurData1 to curseurData2 do with curseurOsc[j] do
        if mondeC<>mondeX then begin
            NewEquivalence := Tequivalence.Create(0,0,0,0,
                         xr,yr,0,grapheCourant);
            NewEquivalence.mondepH := mondeC;
            NewEquivalence.ligneRappel := lrReticule;
            equivalences[pageCourante].Add(NewEquivalence);
            affecteXY(xr,yr);
         end;
         if ([coPente, coDeltaX, coDeltaY] * optionCurseur <> []) and
            (curseurOsc[curseurData1].mondeC=curseurOsc[curseurData2].mondeC) then begin
                if coDeltax in optionCurseur then CreerXYdata(lrX);
                if coDeltay in optionCurseur then CreerXYdata(lrY);
                if coPente in optionCurseur then CreerXYdata(lrPente);
         end;
         PaintBox.invalidate;
   end;// curReticuleData
   curReticuleDataNew : with grapheCourant do begin
        if supprime(posSouris,curseurOsc[curseurData1].mondeC) then exit;
        with curseurOsc[curseurData1] do begin
            NewEquivalence := Tequivalence.Create(0,0,0,0,
                         xr,yr,0,grapheCourant);
            NewEquivalence.mondepH := mondeC;
            NewEquivalence.ligneRappel := lrXdeY;
            equivalences[pageCourante].Add(NewEquivalence);
            affecteXY(xr,yr);
         end;
         PaintBox.invalidate;
   end;// curReticuleDataNew
   curReticuleModele : ;
   (*
   curReticuleModele : with grapheCourant.curseurOsc[1] do begin
        posSouris.X := xc;posSouris.y := yc;
        if supprime(posSouris,mondeC) then exit;
        NewEquivalence := Tequivalence.Create(0,0,0,0,xr,yr,
                   0,grapheCourant);
        NewEquivalence.mondepH := mondeC;
        NewEquivalence.ligneRappel := lrReticule;
        grapheCourant.equivalences[pageCourante].Add(NewEquivalence);
        affecteXY(xr,yr);
        grapheCourant.PaintBox.invalidate;
   end;// curReticuleModele
   *)
   curSelect : if (indexPointCourant>=0) then begin
         Pages[pageCourante].PointActif[indexPointCourant] :=
              not Pages[pageCourante].PointActif[indexPointCourant];
         Application.MainForm.Perform(WM_Reg_Maj,MajSupprPoints,0);
   end;
   end;// case curseur
end; // ToucheEspace

procedure TFgrapheVariab.HelpAnimBtnClick(Sender: TObject);
begin
    Aide(Help_animation)
end;

procedure TFgrapheVariab.TimerAnimTimer(Sender: TObject);
begin
    timerAnim.enabled := false;
    ActiverTimerAnim := true;
    timerAnim.interval := (1+(NbreTickBar.Max-NbreTickBar.position))*55;
    if avance
        then paramSuivant
        else paramPrecedent;
    timerAnim.enabled := ActiverTimerAnim;
end;

procedure TFgrapheVariab.TimerModeleTimer(Sender: TObject);
var newCursorPos : Tpoint;
begin
    newCursorPos := mouse.CursorPos;
    if ((abs(OldCursorPos.x-newCursorPos.x)+
         abs(OldCursorPos.y-newCursorPos.y))>2) and
        (indexGrCourant=1) and
        mouseMoving then MajModeleGr(1);
    TimerModele.enabled := (curseur=curModeleGr);
    OldCursorPos := newCursorPos;
end;

procedure TFgrapheVariab.TimerSizingTimer(Sender: TObject);
var i : integer;
begin
  TimerSizing.Enabled := false;
  Sizing := false;
  for i := 1 to 3 do modifGraphe(i);
end;

procedure TFgrapheVariab.ParamSuivant;
begin
if AnimationTemps.checked
    then begin
         if tempsCourant<finTemps
            then tempsCourant := tempsCourant+pasTemps
            else if boucleCB.checked
                then begin
                  tempsCourant := debutTemps;
                  ClearGrapheAnim := true;
                end
                else begin
                   ActiverTimerAnim := false;
                   exit;
                end;
        calculeAnimTemporelle;
    end
    else with paramAnimManuelle[paramAnimCourant].sliderA do
       if position<max
       then position := position+1
       else if boucleCB.checked
          then begin
             position := 0;
             ClearGrapheAnim := true;
          end
          else begin
             ActiverTimerAnim := false;
          end;
end;

procedure TFgrapheVariab.ParamPrecedent;
begin
if AnimationTemps.checked
   then begin
     if tempsCourant>debutTemps
       then tempsCourant := tempsCourant-pasTemps
       else if boucleCB.checked
           then begin
              tempsCourant := finTemps;
              ClearGrapheAnim := true
           end
           else begin
              ActiverTimerAnim := false;
              exit;
           end;
       calculeAnimTemporelle;
    end
    else with paramAnimManuelle[paramAnimCourant].sliderA do
       if position>0
       then position := position-1
       else if boucleCB.checked
          then begin
             position := max;
             ClearGrapheAnim := true;
          end
          else begin
             ActiverTimerAnim := false;
          end;
end;

procedure TFgrapheVariab.CalculeAnimTemporelle;
begin
if pageCourante=0 then exit;
if not graphes[1].grapheOK then setCoordAnim;
with pages[pageCourante] do begin
      if tempsCourant>finTemps then tempsCourant := finTemps;
      if tempsCourant<debutTemps then tempsCourant := debutTemps;
      if codeTemps>0
         then begin
             Screen.cursor := crHourGlass;
             valeurConst[codeTemps] := TempsCourant;
             grandeurs[codeTemps].valeurCourante := TempsCourant;
             RecalculP;
             if graphes[1].useDefaut
                then modifMonde := false
                else modifMonde := graphes[1].AjusteMonde;
             Screen.cursor := crDefault;
         end
         else begin
             NumeroAnim := 0;
             while (NumeroAnim<pred(nmes)) and
                (valeurVar[0,NumeroAnim]<tempsCourant) do inc(NumeroAnim);
             if (NumeroAnim>0) and
                ((tempsCourant-valeurVar[0,pred(NumeroAnim)])<
                (valeurVar[0,NumeroAnim]-tempsCourant))
                then dec(NumeroAnim);
         end;
      afficheAnimationTemporelle;
end end; // CalculeAnimTemporelle

procedure TFgrapheVariab.AfficheAnimationManuelle;

Procedure TestModif;
begin
        if (([gmXY,gmModele,gmPage,gmValeurs]*graphes[1].modif)<>[]) or
           (graphes[1].courbes.count=0)
            then begin
               if ([gmValeurs]=graphes[1].modif)
                   then graphes[1].courbes.clear
                   else graphes[1].raz;
                setCoordonnee(1);
            end;
end;

procedure AfficheLoc;
begin with graphes[1] do begin
      if not grapheOK or
         not paintBox.visible then exit;
      TestModif;
      if (bitmapReg.height<>paintBox.clientRect.bottom) or
         (bitmapReg.width<>paintBox.clientRect.right) then begin
            bitmapReg.height := paintBox.clientRect.bottom;
            bitmapReg.width := paintBox.clientRect.right;
            clearGrapheAnim := true;
      end;
      bitmapReg.canvas.Pen.mode := pmCopy;
      canvas.Pen.mode := pmCopy;
      limiteFenetre := paintBox.clientRect; // non à jour au début ?
      if modifMonde or
         ClearGrapheAnim or
         not traceCB.checked
            then begin
               bitmapReg.canvas.brush.Style := bsSolid;
               bitmapReg.canvas.brush.color := clWindow;
               bitmapReg.canvas.FillRect(LimiteFenetre);
            end;
      canvas := bitmapReg.canvas;
      draw;
      paintBox.Canvas.Draw(0,0,bitmapReg);
      modif := [];
end end;

var i : integer;
begin
     if InitManuelleAfaire or
        MajFichierEnCours or lecturePage or
        (NbreVariab<2) or
        (pageCourante=0) then exit;
     AfficheLoc;
     for i := 0 to pred(NbreParamAnim) do
         with ParamAnimManuelle[i] do begin
               if (codeA<NbreGrandeurs) then
                  GroupBoxA.caption := grandeurs[codeA].formatNomEtUnite(valeurA)
                   +' ['+formatCourt(debutA)+';'+formatCourt(finA)+']';
         end;
     ClearGrapheAnim := false;
     if FgrapheFFT<>nil then FgrapheFFT.Perform(WM_Reg_Maj,MajChangePage,0);
end; // AfficheAnimation

procedure TFgrapheVariab.DebutBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     ClearGrapheAnim := true;
     if AnimationTemps.checked
        then begin
           tempsCourant := debutTemps;
           calculeAnimTemporelle;
        end
        else paramAnimManuelle[paramAnimCourant].sliderA.position := 0;
end;

procedure TFgrapheVariab.FildeferItemClick(Sender: TObject);
begin
  inherited;
  grapheCourant.filDeFer := FilDeFerItem.checked;
  grapheCourant.paintBox.invalidate;
end;

procedure TFgrapheVariab.FinReticuleItemClick(Sender: TObject);
begin
  inherited;
  setPenBrush(curSelect);
end;

procedure TFgrapheVariab.FinBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     ClearGrapheAnim := true;
     if AnimationTemps.checked
        then begin
           tempsCourant := finTemps;
           calculeAnimTemporelle;
        end
        else with paramAnimManuelle[paramAnimCourant].sliderA do position := max;
end;

procedure TFgrapheVariab.AvanceRapideBtnClick(Sender: TObject);
begin
     DebutBtnClick(sender);
     Perform(WM_Reg_Animation,0,0)
end;

procedure TFgrapheVariab.AvanceBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     paramSuivant;
end;

procedure TFgrapheVariab.RetourRapideBtnClick(Sender: TObject);
begin
     FinBtnClick(sender);
     Perform(WM_Reg_Animation,1,0)
end;

procedure TFgrapheVariab.RetourBtnClick(Sender: TObject);
begin
    TimerAnim.enabled := false;
    paramPrecedent
end;

procedure TFgrapheVariab.StopBtnClick(Sender: TObject);
begin
    TimerAnim.enabled := false
end;

procedure TFgrapheVariab.SetAnimTemporelle;
// var i : integer;
begin
    if pageCourante=0 then exit;
    if NbreConstExp>maxParamAnim
        then NbreParamAnim := MaxParamAnim+1
        else NbreParamAnim := NbreConstExp;
    codeTemps := indexNom('t');
    if (codeTemps<>grandeurInconnue) and
       (codeTemps>0) and
       (grandeurs[codeTemps].genreG=constante) and
       (grandeurs[codeTemps].fonct.genreC=g_experimentale)
       then begin
            debutTemps := pages[1].valeurConst[codeTemps];
            finTemps := pages[NbrePages].valeurConst[codeTemps];
            pasTemps := (finTemps-debutTemps)/NbrePasAnim;
       end
       else with pages[pageCourante] do begin
            codeTemps := 0;
            debutTemps := valeurVar[0,0];
            finTemps := valeurVar[0,pred(nmes)];
            NbrePasAnim := nmes;
            if NbrePasAnim>MaxPasAnimTemps then
               NbrePasAnim := MaxPasAnimTemps;
            if NbrePasAnim<MinPasAnimTemps then
               NbrePasAnim := MinPasAnimTemps;
            pasTemps := (finTemps-debutTemps)/NbrePasAnim;
       end;
     AnimationTemps.caption := 'f('+grandeurs[codeTemps].nom+')';
end; // setAnimTemporelle

procedure TFgrapheVariab.CacheAnim;
begin
        PanelAnimation.visible := false;
        TimerAnim.enabled := false;
        AnimationNone.checked := true;
        SplitterModele.enabled := true;
        ModeleBtn.enabled := true;
        videoTrackBar.Visible := false;
end;

procedure TFgrapheVariab.SetCoordAnim;
var j : integer;
begin with graphes[1] do begin
     raz;
     resetEquivalence;
     VerifCoordonnee(1);
     grapheOK := true;
     for j := 1 to NbreOrdonnee do with Coordonnee[j] do begin
         if trace=[] then
            if (TraceDefaut=tdPoint) and
               (AnimationTemps.checked)
                then trace := [trPoint]
                else if (modeAcquisition=AcqSimulation) or
                        (TraceDefaut=tdLigne)
                    then trace := [trLigne]
                    else begin
                         trace := [trLigne,trPoint];
                         ligne := liSpline;
                    end;
         codeX := indexNom(nomX);
         codeY := indexNom(nomY);
     end;
     AddCourbesAnim;
     for j := 1 to NbreOrdonnee do with Coordonnee[j] do begin
         if monde[iMondeC].axe=nil then
            monde[iMondeC].axe := grandeurs[codeY];
         if monde[MondeX].axe=nil then
            monde[MondeX].axe := grandeurs[codeX];
     end;
     ClearGrapheAnim := true;
     graphes[1].monde[mondeX].defini := false; // ??
end end;// setCoordAnim 

procedure TFgrapheVariab.AnimSliderChange(Sender: TObject);
var Aslider : TtrackBar;
    newValeur : double;
begin
    Aslider := (sender as  TtrackBar);
    GroupBoxAnimClick(Aslider.parent as TgroupBox);
    with ParamAnimManuelle[paramAnimCourant] do begin
        if variationLog
           then newValeur := debutA*power(pasA,Aslider.position)
           else newValeur := debutA+Aslider.position*pasA;
        if newValeur<>valeurA then begin
           valeurA := newValeur;
           calculeAnimManuelle;
           FRegressiMain.AffValeurParametre;
        end;
    end;
end;

Procedure TFgrapheVariab.SetAnimManuelle;
var i : integer;
    avecVerif,UnActif : boolean;
    valDebut,valFin,valC : double;
begin
    if NbreConstExp>maxParamAnim
       then NbreParamAnim := MaxParamAnim+1
       else NbreParamAnim := NbreConstExp;
    AnimationParam.visible := NbreParamAnim>0;
    if not AnimationParam.visible then
       AnimationParam.checked := false;
    if AnimationParam.checked then begin
       avecVerif := false;
       for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
           codeA := indexConstExp[i];
           if (nomA<>grandeurs[codeA].nom) or Ainitialiser then begin
              nomA := grandeurs[codeA].nom;
              valDebut := pages[1].valeurConst[codeA];
              valFin := pages[NbrePages].valeurConst[codeA];
              Ainitialiser := isNan(valDebut) or isNan(valFin);
              if isNan(valDebut) then valDebut := 1;
              if isNan(valFin) then valFin := valDebut+1;
              debutA := valDebut;
              finA := valFin;
              VerifMinMaxReal(debutA,finA);
              variationLog := false;
              if finA=debutA then finA := debutA+1;
              pasA := (finA-debutA)/sliderA.max;
              valC := pages[PageCourante].valeurConst[codeA];
              if not isCorrect(valC) then valC := (valDebut+valFin)/2;
              valeurA := valC;
              //sauveValeurA := valeurA;
              avecVerif := avecVerif or not Ainitialiser;
              active := ((ModeAcquisition<>AcqSimulation) or
                         (i>0) or
                         (NbreParamAnim=1)) and
                         not Ainitialiser;
           end;
           GroupBoxA.caption := grandeurs[codeA].formatNomEtUnite(valeurA)+
                  ' ['+formatReg(debutA)+','+formatReg(finA)+']';
           SliderA.visible := active;
           if active
              then GroupBoxA.height := 48
              else GroupBoxA.height := 24;
           if variationLog
              then SliderA.position := round(log10(valeurA/debutA)/log10(pasA))
              else SliderA.position := round((valeurA-debutA)/pasA);
           GroupBoxA.visible := true;
       end;
       UnActif := false;
       for i := 0 to pred(NbreParamAnim) do
           UnActif := UnActif or paramAnimManuelle[i].active;
       if not UnActif then with paramAnimManuelle[pred(NbreParamAnim)] do begin
           active := true;
           SliderA.visible := true;
           GroupBoxA.height := 48;
       end;
       for i := NbreParamAnim to maxParamAnim do
           paramAnimManuelle[i].GroupBoxA.visible := false;
       if (paramAnimCourant>=NbreParamAnim) or
          not(paramAnimManuelle[ParamAnimCourant].active) then begin
          paramAnimCourant := 0;
          for i := 0 to pred(NbreParamAnim) do begin
             if paramAnimManuelle[i].active then
                paramAnimCourant := i;
                break;
             end;
       end;
       if avecVerif
          then GroupBoxAnimDblClick(nil)
          else AnimSliderChange(paramAnimManuelle[paramAnimCourant].sliderA);
    end;
    InitManuelleAfaire := false;
end;

procedure TFgrapheVariab.CalculeAnimManuelle;
var i,j : integer;
    modifNmes : boolean;
    code : integer;
begin
if (pageCourante=0) or not PanelAnimation.visible then exit;
with graphes[1] do begin
      if not grapheOK then setCoordAnim;
      modifNmes := false;
      for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do
          if active then begin
             codeA := indexNom(nomA);
             pages[pageCourante].valeurConst[codeA] := valeurA;
             grandeurs[codeA].valeurCourante := pages[pageCourante].valeurConst[codeA];
          end;
          Screen.cursor := crHourGlass;
          pages[pageCourante].RecalculP;
          if ModifNmes or pages[pageCourante].changeAdresse
             then addCourbesAnim
             else for j := 0 to pred(Courbes.count) do with Courbes[j] do
                if (courbes[j].page=pageCourante) then begin
                debutC := 0;
                finC := pred(pages[pageCourante].nmes);
                if varY.genreG=constante then begin
                   code := varY.indexG;
                   if high(valy)<pages[pageCourante].nmes then setLength(valY,pages[pageCourante].nmes);
                   for i := 0 to pred(pages[pageCourante].nmes) do valy[i] := pages[pageCourante].valeurConst[code];
                end;
                if varX.genreG=constante then begin
                   code := varX.indexG;
                   if high(valx)<pages[pageCourante].nmes then setLength(valX,pages[pageCourante].nmes);
                   for i := 0 to pred(pages[pageCourante].nmes) do valx[i] := pages[pageCourante].valeurConst[code];
                end;
                if varY.genreG=constanteGlb then begin
                   if high(valy)<pages[pageCourante].nmes then setLength(valY,pages[pageCourante].nmes);
                   for i := 0 to pred(pages[pageCourante].nmes) do valy[i] := varY.valeurCourante;
                end;
                if varX.genreG=constanteGlb then begin
                   if high(valx)<pages[pageCourante].nmes then setLength(valX,pages[pageCourante].nmes);
                   for i := 0 to pred(pages[pageCourante].nmes) do valx[i] := varX.valeurCourante;
                end;
             end;
          if (ModeleDefini in etatModele) then EffectueModele(true);
          affecteModele(1);
          zoomModele(1);
          zoomSuperpose(1);
          Screen.cursor := crDefault;
      if useDefaut
         then modifMonde := false
         else modifMonde := AjusteMonde;
      afficheAnimationManuelle;
end end; // CalculeAnimManuelle

procedure TFgrapheVariab.PanelCourbeResize(Sender: TObject);
begin
  if AnimationTemps.checked then begin
     ClearGrapheAnim := true;
     AfficheAnimationTemporelle;
  end;
  if AnimationParam.checked then begin
     ClearGrapheAnim := true;
     AfficheAnimationManuelle;
  end;
end;

procedure TFgrapheVariab.PanelModeleResize(Sender: TObject);
begin
  if (pageCourante=0)
           or majFichierEnCours
           or lecturePage
           or sizing
              then exit;
  setPanelParam
end;

Procedure TFgrapheVariab.ModifGraphe(indexGr : integer);
begin
    if majFichierEnCours
       or lecturePage
       or not graphes[indexGr].paintBox.visible
       or Sizing
          then exit;
    if not animationNone.checked then begin
       if ([gmXY,gmOptions,gmPage,gmValeurs]*graphes[indexGr].modif)<>[]
            then begin
                 if indexGr=1 then setCoordAnim;
                 if AnimationTemps.checked
                     then calculeAnimTemporelle
                     else calculeAnimManuelle;
            end;
            ClearGrapheAnim := true;
    end;
    graphes[indexGr].paintBox.invalidate;
end;

procedure TFgrapheVariab.GroupBoxAnimClick(Sender: TObject);
var AgroupBox : TgroupBox;
    i : integer;
begin
    AgroupBox := (sender as  TgroupBox);
    i := AgroupBox.tag;
    if paramAnimManuelle[i].active then begin
       paramAnimCourant := i;
       for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do
           if i=paramAnimCourant
              then groupBoxA.color := clBtnHighLight
              else groupBoxA.color := clBtnFace;
    end;
end;

procedure TFgrapheVariab.GroupBoxAnimDblClick(Sender: TObject);
var i : integer;
begin
     TimerAnim.enabled := false;
     if AnimParamDlg=nil then
        Application.CreateForm(TAnimParamDlg, AnimParamDlg);
     if AnimParamDlg.ShowModal=mrOK then begin
        if (paramAnimCourant>=NbreParamAnim) then paramAnimCourant := 0;
        if not paramAnimManuelle[paramAnimCourant].active then
          for i := 0 to pred(NbreParamAnim) do
              if paramAnimManuelle[i].active then begin
                 paramAnimCourant := i;
                 break;
              end;
        for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
           codeA := indexConstExp[i];
           if (codeA<NbreGrandeurs) then
                GroupBoxA.caption := grandeurs[codeA].formatNomEtUnite(valeurA)+
                    ' ['+formatReg(debutA)+','+formatReg(finA)+']';
           SliderA.visible := active;
           if active
              then GroupBoxA.height := 48
              else GroupBoxA.height := 24;
           SliderA.max := sliderMaxValue;
           SliderA.lineSize := succ(sliderA.max div 8);
           SliderA.pageSize := succ(sliderA.max div 32);
      end;
    end;
end;

procedure TFgrapheVariab.TitreAnimCBClick(Sender: TObject);
var indexCourant : integer;

procedure AjouteTitre;
var Dessin : Tdessin;
    i : integer;
    atexte : string;
begin
       Dessin := Tdessin.create(grapheCourant);
       aTexte := '';
       with Dessin do begin
          isTexte := true;
          avecCadre := true;
          hauteur := 6;
          identification := identAnimation;
          longAnim := 0;
          isOpaque := true;
          with grapheCourant do begin
               x1i := paintBox.width div 2;
               y1i := paintBox.height div 20;
               x2i := x1i;y2i := y1i;
               x2 := 0;y2 := 0;
               try
               if pageCourante>0
                  then MondeRT(x1i,y1i,mondeY,x2,y2)
               except
               end;
          end;
          x1 := x2;
          y1 := y2;
          vertical := false;
          pen.color := couleurPages[1];
       end;
       for i := 0 to pred(NbreParamAnim) do
           if paramAnimManuelle[i].active then
              if aTexte=''
                 then aTexte := '%C'+intToStr(succ(i))
                 else aTexte := aTexte+' ; %C'+intToStr(succ(i));
       dessin.texte.add(aTexte);
       grapheCourant.dessins.add(Dessin);
end; // ajouteTitre

var i : integer;
begin
     indexCourant := -1;
     i := 0;
     while (i<grapheCourant.dessins.count) and (indexCourant=-1) do
       if (grapheCourant.dessins[i].identification=identAnimation)
          then indexCourant := i
          else inc(i);
     if not titreAnimCB.enabled then exit;
     if (indexCourant>=0) and not titreAnimCB.checked
        then with grapheCourant do
              Dessins.remove(dessins[indexCourant]);
     if (indexCourant<0) and titreAnimCB.checked
        then ajouteTitre;
     if (pageCourante>0) then ModifGraphe(indexGrCourant);
end; // TitreAnimCBClick

procedure TFgrapheVariab.OptionsItemClick(Sender: TObject);
var code : integer;
    num : integer;
begin
     num := (sender as TMenuItem).tag;
     OptionsVitesseDlg := TOptionsVitesseDlg.create(self);
     code := grapheCourant.coordonnee[num].codeX;
     OptionsVitesseDlg.grandeurX := grandeurs[code];
     code := grapheCourant.coordonnee[num].codeY;
     OptionsVitesseDlg.grandeurY := grandeurs[code];
     if OptionsVitesseDlg.showModal=mrOK then PaintBox1.invalidate;
     OptionsVitesseDlg.free;
end;

procedure TFgrapheVariab.OptionsAnimBtnClick(Sender: TObject);
begin
    GroupBoxAnimDblClick(sender)
end;

procedure TFgrapheVariab.RaZModeleClick(Sender: TObject);
var p : TcodePage;
    i : integer;
begin
     if OKreg(okRazParam,0) then
     for p := 1 to NbrePages do with pages[p] do begin
         ModeleCalcule := false;
         ModeleErrone := false;
         TexteResultatModele.clear;
         for i := 1 to MaxParametres do
             ValeurParam[paramNormal,i] := parametres[paramNormal,i].ordreDeGrandeur;
     end;
     if OKreg(okRazModele,0) then begin
           MemoModele.clear;
           MemoResultat.clear;
           IsModeleMagnum := false;
           EtatModele := [PasDeModele];
           for i := 1 to 3 do
               exclude(Graphes[i].modif,gmModele);
     end;
end;

Procedure TFgrapheVariab.WmRegInitMagnum;
var i : integer;
    t0 : double;
begin
     if ModeleGraphique[1].nX='' then
        ModeleGraphique[1].nX := graphes[1].monde[mondeX].axe.nom;
     if ModeleGraphique[1].nY='' then
        ModeleGraphique[1].nY := graphes[1].monde[mondeY].axe.nom;
     for i := 1 to NbreModele do begin
        ModeleGraphique[i].initialiseParametre(
           Pages[pageCourante].debut[i],
           Pages[pageCourante].fin[i],t0,true);
        if not ModeleGraphique[i].ModeleOK then begin
           afficheErreur(erModeleGr,0);
           NbreModele := i-1;
           exit;
        end;
        MajModeleGr(i);
     end;
     LanceModele(OptionsDlg.AjustageAutoGrCB.checked);
end;

procedure TFgrapheVariab.VerifParametres;
var i : integer;
begin with pages[pageCourante] do
    for i := 1 to NbreParam[paramNormal] do begin
        if isIncorrect(valeurParam[paramNormal,i]) and
           (pageCourante>1) then
               valeurParam[paramNormal,i] := pages[pred(pageCourante)].valeurParam[paramNormal,i];
        if isIncorrect(valeurParam[paramNormal,i])
           then valeurParam[paramNormal,i] := pages[1].valeurParam[paramNormal,i];
        if isIncorrect(valeurParam[paramNormal,i])
           then valeurParam[paramNormal,i] := parametres[paramNormal,i].ordreDeGrandeur;
   end;
end;

procedure TFgrapheVariab.SauverModeleItemClick(Sender: TObject);
begin
   SaveModeleDlg := TSaveModeleDlg.create(self);
   SaveModeleDlg.showModal;
   SaveModeleDlg.free;
end;

procedure TFgrapheVariab.SaveParamItemClick(Sender: TObject);
begin
   SaveParamDlg := TSaveParamDlg.create(self);
   SaveParamDlg.showModal;
   SaveParamDlg.free;
end;

procedure TFgrapheVariab.EditValeurExit(Sender: TObject);
begin
   ValideParam((sender as Tcomponent).tag,true)
end;

procedure TFgrapheVariab.EditValeurKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var paramCourant : integer;
begin
     paramCourant := (sender as Tcomponent).tag;
     if toucheValidation(key)
        then begin
           valideParam(paramCourant,true);
           case key of
                vk_up,vk_prior : begin
                   dec(paramCourant);
                   if paramCourant>0 then
                       EditValeur[paramCourant].setFocus;
                end;
                vk_down,vk_next,vk_tab,vk_return : begin
                   inc(paramCourant);
                   if paramCourant<=NbreParam[paramNormal] then
                       EditValeur[paramCourant].setFocus;
                end;
           end;
        end
        else if (key=vk_F9) then setPanelModele(splitterModele.snapped);
end;

procedure TFgrapheVariab.EditValeurKeyPress(Sender: TObject;
  var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then ValeursParamChange := true;
end;

procedure TFgrapheVariab.EnregistrerGrapheItemClick(Sender: TObject);

function nomFichier(const carac : string) : string;
var posP : integer;
begin
    result := saveDialog.fileName;
    posP := pos('.',result);
    insert(carac,result,posP);
end;

begin
    saveDialog.options := saveDialog.options-[ofOverwritePrompt];
    if saveDialog.Execute then begin
       Graphes[1].VersFichier(saveDialog.fileName);
       if unGrapheItem.checked and
          residusItem.checked then
             Graphes[3].VersFichier(nomFichier('R'));
       if deuxGraphesVert.checked then
           Graphes[2].VersFichier(nomFichier('2'));
       if deuxGraphesHoriz.checked then
          Graphes[3].VersFichier(nomFichier('3'));
    end;
end;

procedure TFgrapheVariab.EchelonItemClick(Sender: TObject);
begin
    setModeleGr(mgEchelon)
end;

procedure TFgrapheVariab.MoinsRapideBtnClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,1/CoeffParamRapide)
end;

procedure TFgrapheVariab.MonteCarloItemClick(Sender: TObject);
var i,j,k,m : integer;
    StatParam : array of TcalculStatistique;
    sauveVisu : boolean;
    sauveValeur : array[0..8] of Tvecteur;
    g : TGrandeur;
    z,somme,coeffChi2 : double;
    incertitudeConnue : array[TcodeGrandeur] of boolean;
    dy,dt : double;
    indexG : TcodeGrandeur;
begin
    for j := 0 to pred(NbreVariab) do
        incertitudeConnue[j] := grandeurs[j].incertDefinie;
    for j := 1 to NbreModele do with fonctionTheorique[j] do begin
        if not(incertitudeConnue[indexY] or
               grandeurs[indexY].fonct.bruitPresent or
               incertitudeConnue[indexX] or
               grandeurs[indexX].fonct.bruitPresent) then begin
               afficheErreur('Incertitudes non définies',0);
               exit;
         end;
    end;
    sauveVisu := VisualisationAjustement;
    VisualisationAjustement := false;
    MonteCarloActif := true;
    setLength(statParam,NbreParam[paramNormal]+1);
    for j := 1 to NbreParam[paramNormal] do begin
        statParam[j] := TcalculStatistique.create;
        statParam[j].nbre := NbreMC;
        setLength(statParam[j].Donnees,NbreMC);
    end;
    pages[pageCourante].affecteVariableP(false);
    for j := 0 to pred(NbreVariabExp) do begin
        indexG := indexVariabExp[j];
        copyVecteur(sauveValeur[indexG],grandeurs[indexG].valeur);
    end;
    for i := 0 to pred(NbreMC) do begin
       if not bruitPresentGlb then begin
          for j := 0 to pred(NbreVariabExp) do begin
             indexG := indexVariabExp[j];
             if incertitudeConnue[indexG] then begin
                G := grandeurs[indexG];
                for k := 0 to pred(pages[pageCourante].nmes) do
                    G.valeur[k] := randG(sauveValeur[indexG][k],G.ValIncert[k]);
             end;
          end;
       end;
       pages[pageCourante].recalculP; // MonteCarlo sur grandeurs calculées
       LanceModele(true);
       for j := 1 to NbreParam[paramNormal] do
           statParam[j].donnees[i] := parametres[paramNormal,j].valeurCourante;
    end;
    for j := 0 to pred(NbreVariabExp) do begin
        indexG := indexVariabExp[j];
        for k := 0 to pred(pages[pageCourante].nmes) do
            grandeurs[indexG].valeur[k] := sauveValeur[indexG][k];
        sauveValeur[indexG] := nil;
    end;
    pages[pageCourante].recalculP; // les grandeurs calculées reprennent leur valeurs iniitiales
    memoResultat.Lines.Clear;
    memoResultat.Lines.Add('Méthode de Monte-Carlo');
    memoResultat.Lines.Add(intToStr(NbreMC)+' itérations');
    memoResultat.Lines.Add('u(x)=incertitude-type sur x');
    for j := 1 to NbreParam[paramNormal] do begin
        statParam[j].calcul;
        memoResultat.Lines.add(parametres[paramNormal,j].nom+'='+parametres[paramNormal,j].formatValeurEtUnite(statParam[j].moyenne));
        memoResultat.Lines.add('u('+parametres[paramNormal,j].nom+')='+parametres[paramNormal,j].formatValeurEtUnite(statParam[j].sigma));
        pages[pageCourante].valeurParam[paramNormal,j] := statParam[j].moyenne;
        parametres[paramNormal,j].valeurCourante := statParam[j].moyenne;
        statParam[j].free;
    end;
    for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        somme := 0;
        for k := pages[pageCourante].debut[m] to pages[pageCourante].fin[m] do begin
           AffecteVariableE(k);
           z := calcule(calcul);
           try
              dy := grandeurs[indexY].ValIncert[k];
              if isNan(dy)
                 then dy := 0
                 else if uniteSIglb then dy := dy*grandeurs[indexY].coeffSI;
              dt := grandeurs[indexX].ValIncert[k];
              if isNan(dt)
                 then dt := 0
                 else begin
                    dt := dt*valeurDeriveeX[m,k];
                    if uniteSIglb then dt := dt*grandeurs[indexX].coeffSI;
                 end;
              coeffChi2 := 1/(sqr(dy)+sqr(dt));
           except
              coeffChi2 := 1;
           end;
           z := sqr(z-grandeurs[indexY].valeur[k])*coeffChi2;
           somme := somme+z;
        end;
        somme := somme/NbrePointsModele;
        memoResultat.Lines.add('Chi2/(N-p)='+formatGeneral(somme,precisionMin))
    end;
    MonteCarloActif := false;
    VisualisationAjustement := sauveVisu;
end;

procedure TFgrapheVariab.MoinsBtnClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,1/CoeffParam)
end;

procedure TFgrapheVariab.PlusBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,CoeffParam)
end;

procedure TFgrapheVariab.PlusRapideBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,CoeffParamRapide)
end;

procedure TFgrapheVariab.PopupMenuModelePopup(Sender: TObject);

function incertConnue : boolean;
var j : integer;
begin
    result := nbreModele>0;
    for j := 1 to NbreModele do with fonctionTheorique[j] do begin
        if not(grandeurs[indexY].incertDefinie or
               grandeurs[indexY].fonct.bruitPresent or
               grandeurs[indexX].incertDefinie or
               grandeurs[indexX].fonct.bruitPresent) then begin
               result := false;
               break;
         end;
    end;
end;

begin
  inherited;
  residusItem.visible := UnGrapheItem.checked and fonctionTheorique[1].residuStat.statOK;
  residusItem.checked := residusItem.checked and residusItem.Visible;
  ResidusItemBis.visible := residusItem.visible;
  ResidusItemBis.checked := residusItem.checked;
  SaveParamItem.enabled := pages[pageCourante].ModeleCalcule;
  TitreModeleItem.enabled := ModeleDefini in etatModele;
  Incertchi2Item.checked := avecChi2;
  AffIncert.checked := avecEllipse;
  monteCarloItem.visible := (modeleDefini in etatModele) and
                            (ModeleConstruit in etatModele) and
                            pages[pageCourante].modeleCalcule and incertConnue;
end;

procedure TFgrapheVariab.SigneBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,-1)
end;

procedure TFGrapheVariab.ModifParam(paramCourant : integer;coeff : double);
begin
     ParamEditCourant := paramCourant;
     if valeursParamChange then valideParam(paramCourant,true);
     with pages[pageCourante] do
         ValeurParam[paramNormal,paramCourant] :=
              ValeurParam[paramNormal,paramCourant]*coeff;
     if TraceAutoCB.checked
        then PostMessage(handle,WM_Reg_Calcul,CalculModele,0)
        else MajParametres
end;

procedure TFgrapheVariab.ModeleBtnClick(Sender: TObject);
begin
   if splitterModele.enabled and splitterModele.Snapped
      then setPanelModele(true)
      else setPanelModele(false)
end;

procedure TFgrapheVariab.ModeleItemClick(Sender: TObject);
begin
    setPanelModele(not ModeleItem.checked);
end;

procedure TFgrapheVariab.ParaboleItemClick(Sender: TObject);
begin
  setModeleGr(mgParabolique)
end;

procedure TFgrapheVariab.ParamBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RepeatTimer.Interval := InitRepeatPause;
  RepeatTimer.Enabled  := True;
  TimerButton := sender as TspeedButton;
end;

procedure TFgrapheVariab.ParamBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RepeatTimer.Enabled  := False
end;

procedure TFgrapheVariab.RepeatTimerTimer(Sender: TObject);
begin
  RepeatTimer.Interval := RepeatPause;
  if csLButtonDown in TimerButton.ControlState
     then begin
        TimerButton.onClick(timerButton);
        Application.processMessages;
     end
     else RepeatTimer.Enabled := False
end;

procedure TFgrapheVariab.OrigineBtnClick(Sender: TObject);
var i : integer;
    Origin : Tpoint;
begin
     exclude(etatModele,ajustementGraphique);
     for i := 1 to 3 do
         if graphes[i].paintBox.Visible then
            traceCurseurCourant(i); // efface l'actuel
     setPenBrush(curOrigine);
     for i := 1 to 3 do with graphes[i].paintBox do if visible then begin
            curseur := curOrigine;
            GetCursorPos(Origin);
            Origin := ScreenToClient(Origin);
            XOrigineInt := Origin.X;
            TraceCurseurCourant(i);
     end;
end; // OrigineBtnClick

procedure TFgrapheVariab.AjustePanelModele;
const HauteurMini = 76;
var hauteurAjuste,hauteurPanel,hauteurMemo,
    hauteurResultat,i : integer;
begin
     if TrigoLabel.Visible
        then panel1.Height := Screen.PixelsPerInch div 2
        else panel1.Height := 2*Screen.PixelsPerInch div 7;
     hauteurPanel := PanelModele.Height-ModeleToolbar.height;
// valeurs par défaut
     i := MemoModele.lines.count+4;  // tenir compte titre GroupBox et scrollBar
     if i<6 then i := 6;
     hauteurMemo := abs(memoModele.Font.height)*i*5 div 4;
     i := NbreParam[paramNormal]+1;
     if i<3 then i := 3;
     HauteurAjuste := PanelParam1.height*i+Panel1.height;
     hauteurResultat := hauteurPanel-hauteurMemo-HauteurAjuste;
// on teste si résultat pas trop petit
     if (hauteurResultat<HauteurMini) then
        if ((HauteurPanel-HauteurMemo-HauteurMini)>HauteurMini)
           then begin
              HauteurAjuste := HauteurPanel-HauteurMemo-HauteurMini;
              // on ajuste panelAjuste résultat à mini
           end
           else begin // on divise en trois
              HauteurMemo := HauteurPanel div 3;
              HauteurAjuste := hauteurMemo;
           end;
// on affecte
     MemoModeleGB.Height := hauteurMemo;
     PanelAjuste.height := hauteurAjuste;
end;

procedure TFgrapheVariab.VecteursItemClick(Sender: TObject);
var recalcul : boolean;

procedure SetVecteurs(j : integer);
var nomVitesseX,nomVitesseY : string;
    nomAccelerationX,nomAccelerationY : string;
    complement : string;

Function AddVitesse(y : string) : string;
begin
    if y[length(y)]='''' then delete(y,length(y),1);
    result := 'v'+y;
    Fvaleurs.memo.lines.add('v'+y+'=Diff('+y+','+grandeurs[0].nom+')');
    recalcul := true;
end;

Function AddAcceleration(y : string;const v : string) : string;
begin
    if y[length(y)]='''' then delete(y,length(y),1);
    result := 'a'+y;
    Fvaleurs.memo.lines.add('a'+y+'=Diff('+v+','+grandeurs[0].nom+')');
    recalcul := true;
end;

Procedure AddNorme(const x,y : string);
begin
    Fvaleurs.memo.lines.add(x[1]+complement+'=Sqrt('+x+'^2+'+y+'^2)');
    recalcul := true;
end;

var indexvX,indexvY : integer;
    indexX,indexY : integer;
    indexaX,indexaY : integer;
    creationvx,creationvy,creationax,creationay : boolean;
begin with grapheCourant do begin
      include(menuPermis,imVitesse);
      complement := '';
      indexX := indexNom(coordonnee[j].nomX);
      if (indexX=0) and (NbreOrdonnee=2) and (j=1) then begin // x(t),y(t) transformé en y(x)
          coordonnee[1].nomX := coordonnee[1].nomY;
          indexX := indexNom(coordonnee[1].nomX);
          coordonnee[1].nomY := coordonnee[2].nomY;
          NbreOrdonnee := 1;
          coordonnee[2].nomX := '';
          coordonnee[2].nomY := '';
          include(OptionGraphe,OgOrthonorme);
      end;
      if (indexX=grandeurInconnue) or (indexX=0) then begin
         exclude(coordonnee[j].trace,trVitesse);
         exclude(coordonnee[j].trace,trAcceleration);
         exit;
      end;
      indexY := indexNom(coordonnee[j].nomY);
      if indexY=grandeurInconnue then begin
         exclude(coordonnee[j].trace,trVitesse);
         exclude(coordonnee[j].trace,trAcceleration);
         exit;
      end;
      indexvX := IndexVitesse(coordonnee[j].nomX);
      creationvX := indexvX=GrandeurInconnue;
      if creationvX
         then nomVitesseX := AddVitesse(coordonnee[j].nomX)
         else nomVitesseX := grandeurs[indexvX].nom;
      if length(nomVitesseX)>2 then
         complement := copy(nomVitesseX,3,length(nomVitesseX)-2);
      indexvY := IndexVitesse(grandeurs[indexY].nom);
      creationvY := indexvY=GrandeurInconnue;
      if creationvY
         then nomVitesseY := AddVitesse(coordonnee[j].nomY)
         else nomVitesseY := grandeurs[indexvY].nom;
      if creationvX and creationvY then AddNorme(nomVitesseX,nomVitesseY);
      if trAcceleration in grapheCourant.coordonnee[1].trace then begin
         indexaX := IndexAcceleration(grandeurs[indexX].nom);
         creationaX := indexaX=GrandeurInconnue;
         if creationaX
            then nomAccelerationX := AddAcceleration(coordonnee[j].nomX,nomVitesseX)
            else nomAccelerationX := grandeurs[indexaX].nom;
         indexaY := IndexAcceleration(grandeurs[indexY].nom);
         creationaY := indexaY=GrandeurInconnue;
         if creationaY
            then nomAccelerationY := AddAcceleration(coordonnee[j].nomY,nomVitesseY)
            else nomAccelerationY := grandeurs[indexaY].nom;
         if creationaX and creationaY then AddNorme(nomAccelerationX,nomAccelerationY);
      end;
end end; // setVecteurs

var j : integer;
begin // VecteursItemClick
     (sender as TmenuItem).checked := true;
     if AccelerItem.checked or NoVecteursItem.checked
        then exclude(grapheCourant.coordonnee[1].trace,trVitesse);
     if VitesseItem.checked or NoVecteursItem.checked
        then exclude(grapheCourant.coordonnee[1].trace,trAcceleration);
     if AccelerItem.checked or VitesseAccItem.checked
        then include(grapheCourant.coordonnee[1].trace,trAcceleration);
     if VitesseItem.checked or VitesseAccItem.checked
        then include(grapheCourant.coordonnee[1].trace,trVitesse);
     for j := 2 to grapheCourant.NbreOrdonnee do
         grapheCourant.coordonnee[j].trace := grapheCourant.coordonnee[1].trace;         
     if (trVitesse in grapheCourant.coordonnee[1].trace) or
        (trAcceleration in grapheCourant.coordonnee[1].trace)
        then begin
           recalcul := false;
           for j := 1 to grapheCourant.NbreOrdonnee do setVecteurs(j);
           if recalcul then begin
               Fvaleurs.MajBtnClick(nil);
               Application.processMessages;
           end;
        end;
     include(grapheCourant.modif,gmXY);
     ModifGraphe(indexGrCourant);
end;// VecteursItemClick

procedure TFgrapheVariab.VecteursMenuPopup(Sender: TObject);
var codeX,codeY : integer;
begin
  inherited;
  with grapheCourant do begin
       filDeFerItem.visible := (courbes.Count>1) and
       (coordonnee[1].nomX<>coordonnee[2].nomX) and
       (coordonnee[2].codeX<>grandeurInconnue);
       filDeFerItem.checked := filDeFer;
       if filDeFerItem.visible then begin
            codeX := coordonnee[1].codeX;
            codeY := coordonnee[1].codeY;
            OptionsItem.Caption := 'Options '+grandeurs[codeX].nom+','+grandeurs[codeY].nom;
            codeX := coordonnee[2].codeX;
            codeY := coordonnee[2].codeY;
            OptionsItemBis.Caption := 'Options '+grandeurs[codeX].nom+','+grandeurs[codeY].nom;
            OptionsItemBis.visible := true;
       end
       else begin
            OptionsItem.Caption := 'Options';
            OptionsItemBis.visible := false;
       end;
end end;

procedure TFgrapheVariab.AbscisseCBClick(Sender: TObject);
var indexV,j : integer;
begin with graphes[1] do begin
     indexV := indexNomVariab(abscisseCB.text);
     if indexV=coordonnee[1].codeX then exit; // pas de changement
     for j := 1 to NbreOrdonnee do begin
         coordonnee[j].codeX := indexV;
         coordonnee[j].nomX := grandeurs[indexV].nom;
     end;
     include(modif,gmXY);
     ModifGraphe(indexGrCourant);
end end;

procedure TFgrapheVariab.AddCourbesAnim;
var j : integer;

Procedure AddLoc;
var courbeVariab : Tcourbe;

Procedure AddModele(p : integer);
var c : integer;
    x,y : Tvecteur;
    courbeAdd : Tcourbe;
begin with graphes[1].Coordonnee[j] do begin
    if (ModeleDefini in etatModele) and
       (pages[p].modeleCalcule) then
            for c := 1 to NbreModele do with fonctionTheorique[c] do
                  if (codeY=indexY) and (codeX=indexX) and not(implicite) then begin
                        exclude(courbeVariab.Trace,trLigne); // on trace le modèle à la place
                        setlength(x,pages[p].NmesMax+1);
                        setLength(y,pages[p].NmesMax+1);
                        courbeAdd := graphes[1].AjouteCourbe(x,y,iMondeC,pages[p].nmes,
                                           grandeurs[codeX],grandeurs[codeY],p);
                        courbeAdd.IndexModele := c;
                        courbeAdd.Trace := [trLigne];
                        courbeAdd.Adetruire := true;
            end; // modéle actif
    if (SimulationDefinie in etatModele) then
       for c := 1 to NbreFonctionSuper do with fonctionSuperposee[c] do
           if (codeY=indexY) and (codeX=indexX) then begin
                 exclude(courbeVariab.Trace,trLigne); // on trace le modèle à la place
                 setLength(x,pages[p].nmesMax+1);
                 setLength(y,pages[p].nmesMax+1);
                 courbeAdd := graphes[1].AjouteCourbe(x,y,iMondeC,pages[p].nmes,
                    grandeurs[codeX],grandeurs[codeY],p);
                 courbeAdd.IndexModele := -c;
                 courbeAdd.Trace := [trLigne];
                 courbeAdd.Adetruire := true;
           end; // simulation active
       if (ModeleDefini in etatModele) and
        pages[p].modeleCalcule and
       (NbreModele=2) and
       (fonctionTheorique[1].genreC=g_fonction) and
       (fonctionTheorique[1].indexX=0) and
       (fonctionTheorique[2].indexX=0) and
       (((fonctionTheorique[1].indexY=codeY) and
         (fonctionTheorique[2].indexY=codeX)) or
       ((fonctionTheorique[1].indexY=codeX) and
        (fonctionTheorique[2].indexY=codeY))) then begin
                  exclude(courbeVariab.Trace,trLigne); // on trace le modèle à la place
                  setLength(x,pages[p].NmesMax+1);
                  setLength(y,pages[p].NmesMax+1);
                  courbeAdd := graphes[1].AjouteCourbe(x,y,iMondeC,pages[p].nmes,
                                 grandeurs[codeX],grandeurs[codeY],p);
                  courbeAdd.ModeleParametrique := true;
                  courbeAdd.ModeleParamX1 := fonctionTheorique[1].indexY=codeX;
                  courbeAdd.Trace := [trLigne];
                  courbeAdd.Adetruire := true;
        end; // Modele parametrique
end end; //  AddModele

procedure AddPage(p : integer);
begin with graphes[1],pages[p],Coordonnee[j] do begin
             courbeVariab := AjouteCourbe(valeurVar[codeX],valeurVar[codeY],
                    iMondeC,nmes,grandeurs[codeX],grandeurs[codeY],p);
             courbeVariab.trace := trace;
             if (trLigne in Trace) and (ligne=liModele) then AddModele(p);
end end;

var x,y : Tvecteur;
    i,p : integer;
begin with graphes[1],pages[pageCourante],Coordonnee[j]  do begin
     if (grandeurs[codeY].genreG in [constante,constanteGlb]) or
        (grandeurs[codeX].genreG in [constante,constanteGlb])
        then begin
              setLength(y,nmes);
              case grandeurs[codeY].genreG of
                   constante : for i := 0 to pred(nmes) do y[i] := valeurConst[codeY];
                   variable : copyVecteur(y,valeurVar[codeY]);
                   constanteGlb : for i := 0 to pred(nmes) do y[i] := grandeurs[codeY].valeurCourante;
              end;
              setLength(x,nmes);
              case grandeurs[codeX].genreG of
                   constante : for i := 0 to pred(nmes) do x[i] := valeurConst[codeX];
                   variable : copyVecteur(x,valeurVar[codeX]);
                   constanteGlb : for i := 0 to pred(nmes) do x[i] := grandeurs[codeX].valeurCourante;
              end;
              courbeVariab := AjouteCourbe(x,y,iMondeC,nmes,
                   grandeurs[codeX],grandeurs[codeY],pageCourante);
              courbeVariab.Adetruire := true;
              courbeVariab.trace := trace;
        end
        else begin
             AddPage(pageCourante);
             if graphes[1].superposePage then
             for p := 1 to NbrePages do
                 if pages[p].Active and (p<>pageCourante) then begin
                    AddPage(p);
                    continue;
                 end;
        end;
        courbeVariab.setStyle(couleur,styleT,motif);
        if couleurPoint<>'' then
           courbeVariab.setStylePoint(couleurPoint,codeCouleur);
     monde[iMondeC].defini := true;
end end;

begin with graphes[1] do begin
     courbes.clear;
     if not grapheOK then setCoordAnim;
     for j := 1 to NbreOrdonnee do AddLoc;
     monde[mondeX].defini := true;
end end; // AddCourbeAnim

procedure TFgrapheVariab.OptionsModeleBtnClick(Sender: TObject);
begin
   OptionModeleDlg := TOptionModeleDlg.create(self);
   OptionModeleDlg.DlgGraphique := grapheCourant;
   OptionModeleDlg.ModelePagesIndependantesCB.checked := ModelePagesIndependantesMenu.checked;
   if optionModeleDlg.ShowModal=mrOK then begin
       include(grapheCourant.modif,gmOptions);
       ModelePagesIndependantesMenu.checked := OptionModeleDlg.ModelePagesIndependantesCB.checked;
       ModelePagesIndependantes := OptionModeleDlg.ModelePagesIndependantesCB.checked;
       ModifGraphe(indexGrCourant);
       PostMessage(handle,WM_Reg_Calcul,CalculCompile,0)
   end;
   OptionModeleDlg.free;
end;

procedure TFgrapheVariab.IncertBtnClick(Sender: TObject);
var i : integer;
begin
    avecEllipse := incertBtn.down;
    if avecEllipse then avecChi2 := true; // forçage
    for i := 1 to 3 do modifGraphe(i);
    affIncert.Checked := avecEllipse;
    affIncertBis.Checked := avecEllipse;
end;

procedure TFgrapheVariab.IncertChi2ItemClick(Sender: TObject);
begin
    avecChi2 := Incertchi2Item.Checked;
    PostMessage(handle,WM_Reg_Calcul,CalculCompile,0)
end;

procedure TFgrapheVariab.AffIncertClick(Sender: TObject);
var i : integer;
begin
    avecEllipse := (sender as Tmenuitem).Checked;
    incertBtn.Down := avecEllipse;
    for i := 1 to 3 do modifGraphe(i);
end;

procedure TFgrapheVariab.AffineItemClick(Sender: TObject);
begin
    setModeleGr(mgAffine)
end;

procedure TFgrapheVariab.ChoixCurseurClick(Sender: TObject);
var newCurseur : Tcurseur;
    i : integer;

Procedure ChangeGraphe(indexGr : integer);
var Origin : Tpoint;
begin with graphes[indexGr],paintBox do begin
      case curseur of
          curReticule : begin
              GetCursorPos(Origin);
              Origin := ScreenToClient(Origin);
              InitReticule(Origin.x,Origin.y);
              pages[pageCourante].affecteConstParam(true);
              ligneRappelCourante := lrReticule;
          end;
          curReticuleData,curSelect : paintBox.invalidate; //   curReticuleModele
          curReticuleDataNew : begin
             paintBox.invalidate;
             if indexCourbeModele>=0 then initCurseurModele;
          end;
   //       curModele : initCurseurModele;
          curEquivalence : begin
              if (monde[mondeX].graduation<>gLin) or
                 (monde[mondeY].graduation<>gLin)
                  then begin
                     afficheErreur(erGradNonLineaire,0);
                     setPenBrush(curSelect);
                  end;
              if (monde[mondeY].axe=nil)
                  then begin
                     afficheErreur(erTangenteAGauche,0);
                     setPenBrush(curSelect);
                  end;
              TraceCurseurCourant(indexGr);
          end;
      end;
end end;

Function SetEquivalence : boolean;
var reponse,i,imax,i2,imax2 : integer;
    codeDerivee,codeX : integer;
    maxi,max2,valCourante : double;
begin
         setEquivalence := false;
         if ChoixTangenteDlg=nil then
            ChoixTangenteDlg := TChoixTangenteDlg.create(self);
         reponse := ChoixTangenteDlg.showModal;
         if reponse<>mrOK then begin
            setPenBrush(curSelect);
            setEquivalence := true;
            exit;
         end;
         if ChoixTangenteDlg.SupprCB.checked then
            graphes[1].equivalences[pageCourante].clear;
         with Graphes[1] do begin
            setCourbeDerivee;
            codeDerivee :=
                 indexDerivee(monde[mondeY].axe,monde[mondeX].axe,false,false);
            if codeDerivee=grandeurInconnue then begin
                setPenBrush(curSelect);
                setEquivalence := true;
                exit;
            end;
         end;
         curTangenteItem.checked := true;
         if ligneRappelCourante=lrEquivalenceManuelle then with Graphes[1] do begin
 // recherche indice du point d'équivalence
            with pages[pageCourante] do begin
                maxi := 0;
                imax := 0;
                for i := 0 to pred(nmes) do begin
                    valCourante := abs(valeurVar[codeDerivee,i]);
                    if valCourante>maxi then begin
                       imax := i;
                       maxi := valCourante;
                    end;
                end;
                codeX := monde[mondeX].axe.indexG;
                valCourante := valeurVar[codeX,imax]*0.9;
                equivalences[pageCourante].clear;
                with courbes[indexCourbeEquivalence] do
                     if (IndexModele<>0) then begin
                         imax := round(imax*(finC-debutC)/nmes);
                         while (imax>0) and (valX[imax]>valCourante) do dec(imax);
                     end
                     else begin
                          while (imax>0) and (valeurVar[codeX,imax]>valCourante) do dec(imax);
                     end;
                // imax = 10 % avant l'équivalence
                AjouteEquivalence(imax,false);
                // détecte deuxième équivalence
                max2 := maxi/2;
                i2 := imax - (nmes div 5);
                imax2 := 0;
                for i := 0 to i2 do begin
                    valCourante := abs(valeurVar[codeDerivee,i]);
                    if valCourante>max2 then begin
                       imax2 := i;
                       max2 := valCourante;
                    end;
                end;
                if imax2>0 then begin
                     valCourante := valeurVar[codeX,imax2]*0.9;
                     while (imax2>0) and (valeurVar[codeX,imax2]>valCourante) do dec(imax2);
                     if imax2>0 then AjouteEquivalence(imax2,false);
                end;
               // vérifier n'efface pas la première
                i2 := imax + (nmes div 5);
                imax2 := 0;
                max2 := maxi/3;
                for i := i2 to pred(nmes) do begin
                    valCourante := abs(valeurVar[codeDerivee,i]);
                    if valCourante>max2 then begin
                       imax2 := i;
                       max2 := valCourante;
                    end;
                end;
                if imax2>0 then begin
                   valCourante := valeurVar[codeX,imax2]*0.9;
                   while (imax2>i2) and (valeurVar[codeX,imax2]>valCourante) do dec(imax2);
                   if (imax2>i2) then AjouteEquivalence(imax2,false);
                end;
            end;  // with pageCourante
            PaintBox1.invalidate;
            setPenBrush(curSelect);
            selectItem.checked := true;
            setEquivalence := true;
            exit;
         end; // equivalence manuelle
end;

procedure InitCurseurDataNew;
begin with graphes[1] do begin
      ReticuleComplet := true;
      curseurOsc[curseurData1].grandeurCurseur := courbes[0].varY;
      curseurOsc[curseurData1].mondeC := courbes[0].imondeC;
      avecTableau := false;
    //  PstyleReticule := psSolid;
      optionCurseur := [];
      ligneRappelCourante := lrXdeY;
   //   pColorReticule := clRed;
      include(optionCurseur,coX);
      include(optionCurseur,coY);
end end;

procedure InitCurseurData;
var i : integer;
begin
        ReticuleDataDlg := TReticuleDataDlg.create(self);
        ReticuleDataDlg.Agraphe := graphes[1];
        if ReticuleDataDlg.showModal<>mrOK then begin
           setPenBrush(curSelect);
           for i := 1 to 3 do modifGraphe(i);
           NewCurseur := curSelect;
        end;
        if PaintBox2.visible then begin
           ReticuleDataDlg.Agraphe := graphes[2];
           ReticuleDataDlg.showModal;
        end;
        ReticuleDataDlg.free;
end;

procedure InitCurReticuleModele;
begin
        graphes[1].curseurOsc[curseurData1].mondeC := mondeX;
        graphes[1].curseurOsc[curseurData2].mondeC := mondeX;
        ReticuleComplet := true;
        graphes[1].curseurOsc[curseurData1].grandeurCurseur := nil;
        graphes[1].curseurOsc[curseurData2].grandeurCurseur := nil;
end;

begin // ChoixCurseurClick
     newCurseur := Tcurseur((sender as Tcomponent).tag);
     if (newCurseur=curEquivalence) and
         setEquivalence then exit;
     if NewCurseur=curReticuleData then initCurseurData;
     if NewCurseur=curReticuleDataNew then initCurseurDataNew;
  //   if NewCurseur=curReticuleModele then initCurReticuleModele;
     exclude(etatModele,ajustementGraphique);
     for i := 1 to 3 do
         if graphes[i].paintBox.Visible then
            traceCurseurCourant(i); // efface l'actuel
     (sender as TmenuItem).checked := true;
     Effaces := (newCurseur=curEfface) and
                ((GetAsyncKeyState(VK_Control) And $8000)<>0);
     setPenBrush(NewCurseur);
     grapheCourant.dessinCourant := nil;
     if curseur in [curLigne,curTexte] then begin
           grapheCourant.DessinCourant := Tdessin.create(grapheCourant);
           grapheCourant.DessinCourant.isTexte := curseur=curTexte;
           if curseur=curLigne
              then grapheCourant.DessinCourant.pen.color := couleurLigne
              else grapheCourant.DessinCourant.pen.color := clBlue;//couleurTexte;
     end;
     if curseur=curEquivalence then with graphes[1] do
        UnitePente.UniteDerivee(monde[mondeX].axe,monde[mondeY].axe,gLin,gLin);
     for i := 1 to 3 do
         if graphes[i].paintBox.Visible then
            ChangeGraphe(i);
end;  // ChoixCurseurClick

procedure TFgrapheVariab.AnimationNoneClick(Sender: TObject);
var i : integer;
begin
     if pageCourante=0 then exit;
     if PanelAnimation.visible then begin // pas le même ordre !
             CacheAnim;
             for i := 1 to 3 do with graphes[i] do if paintBox.Visible then begin
                 modif := [gmXY];
                 paintBox.invalidate;
             end;
             try
             except
             end;
             paintBox2.Visible := false;
             panelBis.Visible := false;
             Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
             AnimationNone.checked := true;
     end
end;

procedure TFgrapheVariab.AnimationTempsClick(Sender: TObject);
var i,j : integer;
begin
   if pageCourante=0 then exit;
   VideoTrackBar.visible := true;
   if not PanelAnimation.visible then begin
        PanelAnimation.visible := true;
        splitterModele.enabled := false;
        ModeleBtn.Enabled := false;
        NbrePasAnim := pages[pageCourante].Nmes;
        VideoTrackBar.max := pages[pageCourante].Nmes;
        VideoTrackBar.lineSize :=pages[pageCourante].Nmes div 64;
        VideoTrackBar.pageSize :=pages[pageCourante].Nmes div 16;
        VideoTrackBar.frequency :=pages[pageCourante].Nmes div 16;
        setAnimTemporelle;
   end;
   timerAnim.enabled := false;
   LabelTempsAnim.visible := true;
   TitreAnimCB.visible := false;
   LignePointCB.visible := true;
   RandomBtn.visible := bruitPresentGlb;
   AnimationTemps.checked := true;
   OptionsAnimBtn.visible := false;
   if pages[pageCourante].nmes<MaxPasAnimTemps then
      NbrePasAnim := pages[pageCourante].nmes;
   for i := 0 to maxParamAnim do
       paramAnimManuelle[i].GroupBoxA.visible := false;
   modifMonde := false;    
   for i := 1 to 3 do begin
       graphes[i].monde[mondeX].defini := true;
       graphes[i].superposePage := false;       
       with Graphes[i].courbes do for j := 0 to pred(count) do begin
            include(items[j].trace,trPoint);
            graphes[i].monde[items[j].iMondeC].defini := true;
       end;
       graphes[i].modif := [gmXY]; // ??
   end;
   if pages[pageCourante].acquisitionAVI then begin
      if not panelBis.Visible then begin
         panelBis.visible := true;
         paintBox2.Visible := true;
         PanelBis.Width := PanelCentral.width div 2;
      end;
   end;
   DebutBtnClick(nil);
end;  // AnimationTempsClick

procedure TFgrapheVariab.AnimationParamClick(Sender: TObject);
var i : integer;
    appel : boolean;
begin
   if (pageCourante=0) or (NbreConstExp=0) then exit;
   appel := not AnimationParam.Checked or initManuelleAfaire;
   AnimationParam.checked := true;
   if appel then setAnimManuelle;
   OptionsAnimBtn.visible := true;
   if not PanelAnimation.visible then begin
       PanelAnimation.visible := true;
       splitterModele.enabled := false;
       modeleBtn.Enabled := false;
   end;
   timerAnim.enabled := false;
   LabelTempsAnim.visible := false;
   videoTrackBar.Visible := false;
   TitreAnimCB.visible := true;
   RandomBtn.visible := bruitPresentGlb;
   LignePointCB.visible := false;
   for i := 1 to 3 do
       graphes[i].modif := [gmXY];
   invalidate;
end; // AnimationParamClick

procedure TFgrapheVariab.CurseurBtnClick(Sender: TObject);
begin
   (sender as TtoolButton).CheckMenuDropdown
end;

procedure TFgrapheVariab.CurseurGridEndDock(Sender, Target: TObject; X,
  Y: Integer);
var dragPoint : Tpoint;
begin
   inherited;
   dragPoint := PanelCentral.screenToClient(point(x,y));
end;

procedure TFgrapheVariab.CurseurMenuPopup(Sender: TObject);
var i : integer;
    mC : boolean;
begin
  inherited;
  ModeleSepare.Visible := true;
  mC := pages[pageCourante].modeleCalcule;
  curModeleItem.Visible := mC;
  addModeleItem.Visible := mC;
  curReticuleModeleItem.Visible := false; // mC
  curReticuleDataNewItem.Visible := mc;
  curModeleItem.Visible := false;
  if not mc then
  for i := 0 to grapheCourant.courbes.Count-1 do
     if trLigne in grapheCourant.courbes[i].trace then
        curReticuleDataNewItem.Visible := true;
  if mc and (indexCourbeModele>=0)
     then curReticuleDataNewItem.caption := 'Réticule modèle'
     else curReticuleDataNewItem.caption := 'Réticule lissage'

end;

procedure TFgrapheVariab.AnimationMenuPopup(Sender: TObject);
begin
   AnimationParam.Visible := (NbreConstExp>0) and
      //        not(graphes[1].superposePage) and
              UnGrapheItem.checked;
   AnimationTemps.Visible := not(graphes[1].superposePage) and
                             UnGrapheItem.checked;   
end;

procedure TFgrapheVariab.LabelYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var P : Tpoint;
begin
     P := (sender as Tlabel).ClientToScreen(point(X,Y));
     P := paintBox1.ScreenToClient(P);
     PaintBoxMouseMove(paintBox1,shift,P.x,P.Y);
end;

procedure TFgrapheVariab.MenuIndicateurPopup(Sender: TObject);
var i : integer;
    MenuI : TmenuItem;
    indic : Tindicateur;
begin
      menuIndicateur.Items.clear;
      for i := 0 to pred(indicateurDlg.indicateurs.count) do begin
          indic := Tindicateur(indicateurDlg.indicateurs[i]);
          menuI := TmenuItem.Create(self);
          menuI.Caption := indic.nom+' ('+floatToStr(indic.pka)+')';
          menuI.Tag := i;
          menuI.OnClick := indicateurClick;
          menuIndicateur.Items.Add(menuI);
      end;
end;

procedure TFgrapheVariab.MenuReticulePopup(Sender: TObject);
var P : TPoint;
    avecTangente : boolean;
    i : integer;
begin
     avecTangente := false;
     TableauXYItemBis.visible := (graphes[1].equivalences[pageCourante].count>0) or (curseur=curReticuleDataNew);
     if graphes[1].equivalences[pageCourante].count>0
        then for i := 0 to pred(graphes[1].equivalences[pageCourante].count) do
             if graphes[1].equivalences[pageCourante][i].ligneRappel in [lrEquivalence,lrTangente,lrEquivalenceManuelle] then avecTangente := true;
     ViderTangenteItem.visible := avectangente;
     case curseur of
          curReticule : FinReticuleItem.caption := 'réticule libre';
          curReticuleModele : FinReticuleItem.caption := 'réticule modèle';
          curReticuleData : FinReticuleItem.caption := 'réticule données';
          curReticuleDataNew : if indexCourbeModele<0
              then FinReticuleItem.caption := 'réticule lissage'
              else FinReticuleItem.caption := 'réticule modèle';
          curEquivalence : FinReticuleItem.caption := 'équivalence';
          else FinReticuleItem.caption := '' // pour le compilateur
     end;
     FinReticuleItem.caption := 'Terminez '+FinReticuleItem.caption+' (ESC)';
     ViderXYItemBis.visible := TableauXYItem.visible;
     P := grapheCourant.PaintBox.ScreenToClient(P);
     iPropCourbe := grapheCourant.CoordProche(P.x,P.y);
     with grapheCourant.coordonnee[iPropCourbe] do
          ProprieteCourbeBis.caption := stCaracDe+' '+nomY+'=f('+nomX+')'; // ' Y=f(X)'
end;

procedure TFgrapheVariab.metafile2Click(Sender: TObject);
begin
  inherited;
  grapheClip := TgrapheClipBoard((sender as TMenuItem).tag);
  CopierItemClick(sender);
end;

procedure TFgrapheVariab.IndicateurClick(Sender: TObject);
begin
     graphes[1].indicateur :=
         Tindicateur(indicateurDlg.indicateurs[(sender as TmenuItem).tag]);
     pages[pageCourante].indicateurP := graphes[1].indicateur;
     PaintBox1.invalidate;
end;

procedure TFgrapheVariab.BornesDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var x : integer;
begin
     ACanvas.FillRect(ARect);
     with sender as TmenuItem do begin
          x := Arect.left;
          Acanvas.TextOut(x,Arect.top,caption);
     end;
end;

procedure TFgrapheVariab.DeuxGraphesVertClick(Sender: TObject);
begin
     if MajFichierEnCours then exit;
     (sender as TmenuItem).checked := true;
     if DeuxGraphesVert.checked
        then PanelBis.Width := PanelCentral.width div 2
        else PanelBis.Width := 0;
     if DeuxGraphesHoriz.checked
        then PaintBox3.height := panelPrinc.height div 2
        else PaintBox3.height := 0;
     if sender=UnGrapheItem then NGraphesBtn.ImageIndex := 31;
     if sender=DeuxGraphesHoriz then NGraphesBtn.ImageIndex := 33;
     if sender=DeuxGraphesVert then NGraphesBtn.ImageIndex := 34;
     PanelBis.visible := DeuxGraphesVert.checked;
     PaintBox2.visible := PanelBis.visible;
     PaintBox3.visible := DeuxGraphesHoriz.checked;
     indexGrCourant := 1;
     grapheCourant := Graphes[1];
     invalidate;
end;

procedure TFgrapheVariab.SetCoordonneeResidu;
var iX,iY : integer;
    ValeurX,ValeurY : Tvecteur;

procedure TraceSigma;
var Xlegende : double;

Procedure traceH(yr : double;const titre : string);
var dessin : Tdessin;
begin with grapheResidu do begin
     Dessin := Tdessin.create(grapheResidu);
     with Dessin do begin
        isTexte := false;
        pen.color := clNavy;
        pen.style := psSolid;
        x1 := monde[mondeX].mini;
        y1 := yr;
        x2 := monde[mondeX].maxi;
        y2 := yr;
     end;
     dessins.Add(Dessin);
     if titre='' then  exit;
     Dessin := Tdessin.create(grapheResidu);
     with Dessin do begin
        isTexte := true;
        isOpaque := true;
        couleurFond := colorToRGB(clWindow);
        texte.add(titre);
        pen.color := clNavy;
        x1 := xLegende;x2 := x1;
        y1 := yr;y2 := y1;
     end;
     dessins.Add(Dessin);
end end; // traceH

var valeur : double;
begin
      with grapheResidu.monde[mondeX] do
           xLegende := (mini+maxi)/3;
      valeur := fonctionTheorique[1].residuStat.sigma*fonctionTheorique[1].residuStat.t95;
      traceH(-valeur,'95%');
      traceH(+valeur,'95%');
end; // TraceSigma

(*
procedure TraceResidusStudent;
var Acourbe : Tcourbe;
    mini,maxi : double;
    i,j : integer;
begin with pages[pageCourante],grapheResidu do begin
        j := 0;
        for i := debut[1] to fin[1] do begin
            valeurX[j] := valeurVar[iX,i];
            valeurY[j] := fonctionTheorique[1].residuStat.residusStudent[j];
            inc(j);
        end;
        Acourbe := Tcourbe.create(valeurX,valeurY,0,pred(j),
                  grandeurs[iX],grandeurs[iY]);
        Acourbe.page := pageCourante;
        Acourbe.setStyle(clRed,psSolid,mCroix,'');
        Acourbe.trace := [trResidus];
        monde[mondeX].mini := Graphes[1].monde[mondeX].mini;
        monde[mondeX].maxi := Graphes[1].monde[mondeX].maxi;
        monde[mondeX].Axe := grandeurs[iX];
        GetMinMax(valeurY,j,mini,maxi);
        monde[mondeY].Axe := grandeurs[iY];
        with fonctionTheorique[1] do begin
           if maxi<(residuStat.t95*1.1) then maxi := residuStat.t95*1.1;
           if mini>(-residuStat.t95*1.1) then mini := -residuStat.t95*1.1;
        end;
        if maxi>abs(mini)
            then mini := -maxi
            else maxi := abs(mini);
        monde[mondeY].mini := mini;
        monde[mondeY].maxi := maxi;
        monde[mondeY].Axe := grandeurs[iY];
        courbes.Add(Acourbe);
        Acourbe.aDetruire := true;
        typeResidu := ResiduStudent;
        TraceSigma(fonctionTheorique[1].residuStat.t95);
end end; // traceResidusStudent
*)

procedure TraceResidusNormalises;
var Acourbe : Tcourbe;
    mini,maxi : double;
    i,j : integer;
begin with pages[pageCourante],grapheResidu do begin
        j := 0;
        for i := debut[1] to fin[1] do begin
            valeurX[j] := valeurVar[iX,i];
            valeurY[j] := fonctionTheorique[1].residuStat.residusNormalises[j];
            inc(j);
        end;
        Acourbe := Tcourbe.create(valeurX,valeurY,0,pred(j),
                  grandeurs[iX],grandeurs[iY]);
        Acourbe.page := pageCourante;
        Acourbe.setStyle(clRed,psSolid,mCroix);
        Acourbe.trace := [trResidus];
        monde[mondeX].mini := Graphes[1].monde[mondeX].mini;
        monde[mondeX].maxi := Graphes[1].monde[mondeX].maxi;
        monde[mondeX].Axe := grandeurs[iX];
        GetMinMax(valeurY,j,mini,maxi);
        monde[mondeY].Axe := grandeurs[iY];
        if maxi>abs(mini)
            then mini := -maxi
            else maxi := abs(mini);
        monde[mondeY].mini := mini;
        monde[mondeY].maxi := maxi;
        monde[mondeY].Axe := grandeurs[iY];
        courbes.Add(Acourbe);
        Acourbe.aDetruire := true;
        ResiduNormalise := true;
end end; // traceResidusNormalises

procedure TraceResidus;
var Acourbe : Tcourbe;
    mini,maxi : double;
    i,j : integer;
    Vminmax : Tvecteur;
    tampon : double;
begin with pages[pageCourante],grapheResidu do begin
        j := 0;
        if avecEllipse then begin
           setLength(dXresidu,NmesMax+1);
           setLength(dYresidu,NmesMax+1);
        end;
        for i := debut[1] to fin[1] do begin
            valeurX[j] := valeurVar[iX,i];
            valeurY[j] := fonctionTheorique[1].residuStat.residus[j];
            if avecEllipse then begin
               dXresidu[j] := incertVar[iX,i];
               dYresidu[j] := incertVar[iY,i];
            end;
            inc(j);
        end;
        Acourbe := Tcourbe.create(valeurX,valeurY,0,pred(j),
                  grandeurs[iX],grandeurs[iY]);
        Acourbe.page := pageCourante;
        Acourbe.setStyle(clRed,psSolid,mCroix);
        Acourbe.trace := [trResidus];
        monde[mondeX].mini := Graphes[1].monde[mondeX].mini;
        monde[mondeX].maxi := Graphes[1].monde[mondeX].maxi;
        monde[mondeX].Axe := grandeurs[iX];
        GetMinMax(valeurY,j,mini,maxi);
        monde[mondeY].Axe := grandeurs[iY];
        if avecEllipse then begin
           Acourbe.IncertX := dXresidu;
           Acourbe.IncertY := dYresidu;
           setLength(Vminmax,NmesMax+1);
           for i := 0 to pred(fonctionTheorique[1].residuStat.Nbre) do begin
               Vminmax[i] := fonctionTheorique[1].residuStat.residus[i]+dyResidu[i];
           end;
           GetMinMax(Vminmax,j,tampon,maxi);
           for i := 0 to pred(fonctionTheorique[1].residuStat.nbre) do begin
               Vminmax[i] := fonctionTheorique[1].residuStat.residus[i]-dyResidu[i];
           end;
           GetMinMax(Vminmax,j,mini,tampon);
           VminMax := nil;
        end;
        if maxi>abs(mini)
            then mini := -maxi
            else maxi := abs(mini);
        monde[mondeY].mini := mini;
        monde[mondeY].maxi := maxi;
        monde[mondeY].Axe := grandeurs[iY];
        courbes.Add(Acourbe);
        Acourbe.aDetruire := true;
        ResiduNormalise := false;
        traceSigma;
end end; // traceResidus

begin with pages[pageCourante],grapheResidu do begin
        panelBis.visible := false;
        paintBox2.Visible := false;
        paintBox3.Visible := false;
        residusNormalisesCB.Visible := false;
        if not fonctionTheorique[1].residuStat.statOK then exit;
        grapheOK := (NbreVariab>1) and (NbrePages>0) and
              pages[pageCourante].modeleCalcule and
                (ModeleDefini in etatModele) and
                (ModeleConstruit in etatModele);
        if not grapheOK  then exit;
        residusNormalisesCB.Visible := fonctionTheorique[1].residuStat.avecIncert;
        paintBox3.Visible := true;
        optionGraphe := [];
        iX := fonctionTheorique[1].indexX;
        iY := fonctionTheorique[1].indexY;
        setLength(valeurX,MaxVecteurDefaut+1);
        setLength(valeurY,MaxVecteurDefaut+1);
        superposePage := false;
        Raz;
        Dessins.clear;
        if residusNormalisesCB.checked and fonctionTheorique[1].residuStat.avecIncert
           then traceResidusNormalises
           else traceResidus;
        monde[mondeY].defini := true;
        monde[mondeX].defini := true;
        with PaintBox3.Canvas do begin
           pen.mode := pmCopy;
           pen.color := couleurAxeX;
           pen.style := psSolid;
        end;
        modif := [];
        residusNormalisesCB.Caption := stResidusNormalises
end end; // setCoordonneeResidu

procedure TFgrapheVariab.PaintBoxClick(Sender: TObject);
var j : integer;
begin
 if DeuxGraphesVert.checked or
     DeuxGraphesHoriz.checked
     then begin
       indexGrCourant := (sender as TpaintBox).tag;
       grapheCourant := graphes[indexGrCourant];
       for j := 1 to 3 do
           if graphes[j].paintBox.visible then
              graphes[j].EncadreTitre(indexGrCourant=j)
     end;
end;

procedure TFgrapheVariab.FormPaint(Sender: TObject);
begin
  PanelBis.visible := DeuxGraphesVert.checked;
  PaintBox2.visible := PanelBis.visible;
  ResidusNormalisesCB.Visible := residusItem.checked and not(splitterModele.snapped);
  PaintBox3.visible := DeuxGraphesHoriz.checked or
                     (residusItem.checked and not(splitterModele.snapped));
end;

procedure TFgrapheVariab.SetBoutonAnim(actif : boolean);
begin
    actif := actif and
             splitterModele.snapped and
  //           not(graphes[1].superposePage) and
             UnGrapheItem.checked;
    if not actif and PanelAnimation.Visible then AnimationNoneClick(nil);
    AnimBtn.Enabled := actif;
    if not(splitterModele.snapped)
       then AnimBtn.hint := '|Modélisation active => pas d''animation'
       else if actif
            then AnimBtn.hint := stAnimation
            else AnimBtn.hint := '|Plus d''une page ou d''un graphe => pas d''animation';
end;

procedure TFgrapheVariab.addModeleItemClick(Sender: TObject);
var Dessin : Tdessin;
    i : integer;
    nouveauDessin : boolean;
begin with graphes[1] do begin
      if OptionsAffModeleDlg=nil then
         Application.createForm(TOptionsAffModeleDlg,OptionsAffModeleDlg);
      OptionsAffModeleDlg.isGlobal := false;
      if OptionsAffModeleDlg.showModal=mrOK then begin
         nouveauDessin := true;
         dessin := nil;// pour le compilateur
         for i := 0 to pred(Dessins.count) do
           if dessins[i].isTexte and
              (pos('%M',dessins[i].texte[0])>0) then begin
                dessin := dessins[i];
                nouveauDessin := false;
                break;
              end;
         if nouveauDessin then Dessin := Tdessin.create(graphes[1]);
         with Dessin do begin
            texte.Clear;
            isTexte := true;
            //centre := false;
            avecCadre := true;
            avecLigneRappel := false;
            hauteur := 4;
            vertical := false;
            pen.color := couleurModele[1];
            identification := identNone;
            paramModeleBrut := true;
            with monde[mondeX] do x1 := (mini+maxi)/2;
            with monde[mondeY] do y1 := maxi-(maxi-mini)/32;
            x2 := x1;
            y2 := y1;
            numPage := 0; // pageCourante
            for i := 1 to NbreModele do
               if OptionsAffModeleDlg.listeModeleBox.checked[i-1] then
                  texte.Add('%M'+intToStr(i));
            if pages[pageCourante].ModeleCalcule and (NbreParam[paramNormal]>0) then begin
               for i := 1 to NbreParam[paramNormal] do
                   if OptionsAffModeleDlg.listeParamBox.checked[i-1] then
                      texte.Add('%P'+intToStr(i));
            end;
         end;
         if nouveauDessin then dessins.add(Dessin);
      end
      else begin
          i := 0;
          while (i<dessins.count) do
              if dessins[i].isTexte and
                 (pos('%M',dessins[i].texte[0])>0)
                 then Dessins.remove(dessins[i])
                 else inc(i);
      end;
      PaintBox1.invalidate;
end end; // addModele

procedure TFgrapheVariab.AffecteModele(indexGr : integer);
var i : integer;
    Agraphe : TgrapheReg;
begin
if not(ModeleDefini in etatModele) and
   not(SimulationDefinie in etatModele) then exit;
Agraphe := graphes[indexGr];
for i := 0 to pred(Agraphe.courbes.count) do
   with Agraphe.courbes[i] do begin
    if (indexModele<0) and (-indexModele<=NbreFonctionSuper) then
        with fonctionSuperposee[-indexModele],Pages[page] do begin
             DebutC := 0;
             AffecteConstParam(true);
             AffecteVariableP(false);
             if genreC=g_fonction then GenereM(valX,valY,
                   valeurVar[indexX,0],valeurVar[indexX,pred(nmes)],
                   Agraphe.monde[mondeX].graduation=gLog,FinC);
             if genreC=g_equation then GenereEquation(valX,valY,
                          Agraphe.monde[mondeX].axe,
                          Agraphe.monde[mondeY].axe,page,FinC);
        end;
    if (indexModele>0) and (indexBande=0) and
        not courbeExp and
       (indexModele<=NbreModele) then
        with fonctionTheorique[indexModele],Pages[page] do begin
               DebutC := debut[indexModele];
               FinC := fin[indexModele];
               copyVecteur(valX,valeurVar[indexX]);
               if ModeleCalcule
                    then copyVecteur(valY,valeurTheorique[indexModele])
                    else copyVecteur(valY,valeurVar[indexY]);
               continue;
        end; // with
    if ModeleParametrique and (NbreModele=2) then
       with Pages[page] do begin
               DebutC := debut[1];
               FinC := fin[1];
               if ModeleCalcule
                    then if ModeleParamX1
                           then begin
                               copyVecteur(valX,valeurTheorique[1]);
                               copyVecteur(valY,valeurTheorique[2]);
                           end
                           else begin
                               copyVecteur(valY,valeurTheorique[1]);
                               copyVecteur(valX,valeurTheorique[2]);
                           end
                    else if ModeleParamX1
                          then begin
                             copyVecteur(valX,valeurVar[fonctionTheorique[1].indexY]);
                             copyVecteur(valY,valeurVar[fonctionTheorique[2].indexY]);
                           end
                           else begin
                             copyVecteur(valX,valeurVar[fonctionTheorique[2].indexY]);
                             copyVecteur(valY,valeurVar[fonctionTheorique[1].indexY]);
                           end;
                continue;
       end; // with pages
       if PortraitDePhase and (NbreModele=1) then with Pages[page] do begin
               DebutC := debut[1];
               FinC := fin[1];
               if ModeleCalcule
                    then if ModeleParamX1
                           then begin
                               copyVecteur(valX,valeurTheorique[1]);
                               copyVecteur(valY,valeurLisse[fonctionTheorique[1].indexYp]);
                           end
                           else begin
                               copyVecteur(valY,valeurTheorique[1]);
                               copyVecteur(valX,valeurLisse[fonctionTheorique[1].indexYp]);
                           end
                    else if ModeleParamX1
                          then begin
                             copyVecteur(valX,valeurVar[fonctionTheorique[1].indexY]);
                             copyVecteur(valY,valeurVar[fonctionTheorique[1].indexYp]);
                           end
                           else begin
                             copyVecteur(valX,valeurVar[fonctionTheorique[1].indexY]);
                             copyVecteur(valY,valeurVar[fonctionTheorique[1].indexYp]);
                           end;
              continue;
       end;// with
   end // i
end; // affecteModele

procedure TFgrapheVariab.ZoomModele(indexGr : integer);
var i : integer;
    valT : Tvecteur;
begin
with graphes[indexGr] do begin
    if (NbreModele=0) or not(ModeleDefini in etatModele) then exit;
    ChercheMinMax;
    for i := 0 to pred(courbes.count) do with courbes[i] do begin
        if pages[page].modeleErrone then continue;
        pages[page].AffecteConstParam(true);
        pages[page].AffecteVariableP(false);
        if (indexModele>0) and
           (indexBande=0) and
            not courbeExp and
           (indexModele<=NbreModele) and
           (motif<>mHisto) then
              with fonctionTheorique[indexModele] do
                case genreC of
                  g_fonction : begin
                     debutC := 0;
                     if varX.indexG=indexX
                        then GenereM(valX,valY,miniMod,maxiMod,
                           monde[mondeX].graduation=gLog,FinC)
                        else begin
                            if (indexX=0) and useDefaut
                               then begin
                                    maxiMod := maxiTemps;
                                    miniMod := miniTemps;
                               end
                               else GetMinMax(ValX,succ(FinC),miniMod,maxiMod);
                            GenereM(valX,valY,miniMod,maxiMod,false,FinC);
                        end;
                  end;// fonction
                  g_equation : GenereEquation(valX,valY,
                          monde[mondeX].axe,
                          monde[mondeY].axe,page,FinC);
                  g_diff2 : begin
                        if isModeleSysteme
                           then begin if indexModele=1 then
                               ExtrapoleDiff2(page,Pages[page].debut[1],
                                         monde[mondeX].mini,monde[mondeX].maxi,
                                         ValeurXDiff,ValeurYDiff,valeurYpDiff,1,NbreModele);
                            end
                            else ExtrapoleDiff2(page,Pages[page].debut[indexModele],
                                         monde[mondeX].mini,monde[mondeX].maxi,
                                         ValeurXDiff,ValeurYDiff,valeurYpDiff,indexModele,indexModele);
                        copyVecteur(valX,valeurXDiff);
                        copyVecteur(valY,ValeurYDiff[indexModele]);
                        debutC := 0;
                        finC := pred(Pages[page].NmesMax);
                   end;// diff2
                   g_diff1 : begin
                        if isModeleSysteme
                           then begin if indexModele=1 then
                               ExtrapoleDiff1(page,Pages[page].debut[1],
                                         monde[mondeX].mini,monde[mondeX].maxi,
                                         ValeurXDiff,ValeurYDiff,1,NbreModele);
                           end
                           else ExtrapoleDiff1(page,Pages[page].debut[indexModele],
                                         monde[mondeX].mini,monde[mondeX].maxi,
                                         ValeurXDiff,ValeurYDiff,indexModele,indexModele);
                        copyVecteur(valX,valeurXDiff);
                        copyVecteur(valY,ValeurYDiff[indexModele]);
                        debutC := 0;
                        finC := pred(pages[page].NmesMax);
                   end; // diff1
                end;// case
                if modeleParametrique and (NbreModele=2) then begin // Fonction
                      if useDefaut
                         then begin
                              maxiMod := maxiTemps;
                              miniMod := miniTemps;
                         end
                         else GetMinMax(Pages[page].ValeurVar[0],pages[page].nmes,miniMod,maxiMod);
                      GenereModeleParametrique(valY,valX,miniMod,maxiMod,finC);
                      if ModeleParamX1 then swap(valX,valY);
                      debutC := 0;
                      continue;
                end;
                if portraitDePhase and
                   (fonctionTheorique[1].genreC=g_fonction) and
                   (NbreModele=1) then begin
                     if useDefaut
                         then begin
                              maxiMod := maxiTemps;
                              miniMod := miniTemps;
                         end
                         else GetMinMax(Pages[page].ValeurVar[0],pages[page].nmes,miniMod,maxiMod);
                      FonctionTheorique[1].GenereM(valX,valY,miniMod,maxiMod,false,FinC);
                      copyVecteur(valT,valX);
                      DeriveeGauss(valT,valY,finC+1,valX,degreDerivee,NbrePointDerivee);
                      valT := nil;
                      if ModeleParamX1 then swap(valX,valY);
                      debutC := 0;
                      continue;
                end;
                if portraitDePhase and
                   (fonctionTheorique[1].genreC=g_diff2) and
                   (NbreModele=1) then begin
                     if useDefaut
                         then begin
                              maxiMod := maxiTemps;
                              miniMod := miniTemps;
                         end
                         else GetMinMax(Pages[page].ValeurVar[0],pages[page].nmes,miniMod,maxiMod);
                       ExtrapoleDiff2(page,Pages[page].debut[1],
                              miniMod,maxiMod,
                              ValeurXDiff,ValeurYDiff,valeurYpDiff,1,1);
                       if ModeleParamX1
                          then begin
                              copyVecteur(valX,valeurYDiff[1]);
                              copyVecteur(valY,valeurYpDiff[1]);
                          end
                          else begin
                              copyVecteur(valX,valeurYpDiff[1]);
                              copyVecteur(valY,valeurYDiff[1]);
                          end;
                       debutC := 0;
                       finC := pred(pages[page].NmesMax);
                       continue;
                end; // case
                if (indexModele=1) and
                   (indexBande=0) and
                   not(courbeExp) and
                   (valYder<>nil) then begin
                       setLength(valYder,finC); // pb mémoire
                       DeriveeGauss(valX,valY,finC,valYder,degreDerivee,NbrePointDerivee);
                end;
          end; // for i
end end; // zoomModele

procedure TFgrapheVariab.ZoomSuperpose(indexGr : integer);
var i : integer;
begin with graphes[indexGr] do begin
    if (NbreFonctionSuper=0) or not(SimulationDefinie in etatModele) then exit;
    chercheMinMax;
    for i := 0 to pred(courbes.count) do with courbes[i] do begin
        if (indexModele<0) and (-indexModele<=NbreFonctionSuper) then
            with fonctionSuperposee[-indexModele] do begin
                 pages[page].AffecteConstParam(true);
                 pages[page].AffecteVariableP(false);
                 debutC := 0;
                 if genreC=g_equation
                    then GenereEquation(valX,valY,
                          monde[mondeX].axe,
                          monde[mondeY].axe,page,FinC)
                    else if indexX=varX.indexG
                    then GenereM(valX,valY,
                                 miniMod,maxiMod,monde[mondeX].Graduation=gLog,FinC)
                    else begin
                         if (varX=grandeurs[0]) and useDefaut
                            then begin
                                 maxiMod := maxiTemps;
                                 miniMod := miniTemps;
                            end
                            else GetMinMax(ValX,succ(FinC),miniMod,maxiMod);
                         GenereM(valX,valY,miniMod,maxiMod,false,FinC);
                    end; // not mondeX
         end; // boucle i
    end;
end end; // zoomSuperpose

procedure TFgrapheVariab.SetTaillePolice;
begin
         majModelePermis := false;
         VerifMemo(MemoModele);
         majModelePermis := true;
         verifMemo(memoResultat);
         panelModele.width := 18*abs(Font.Height);
         AjustePanelModele;
end;

procedure TFgrapheVariab.ModelisationItemClick(Sender: TObject);
begin
        setPanelModele(splitterModele.snapped)
end;

procedure TFgrapheVariab.FermerItemClick(Sender: TObject);
begin
     setPanelModele(false)
end;

procedure TFgrapheVariab.SavePosItemClick(Sender: TObject);
var i : integer;
begin with grapheCourant do begin
              if savePositionDlg=nil then
                 Application.CreateForm(TsavePositionDlg, savePositionDlg);
              varXPos := monde[mondeX].axe;
              varYpos := nil;
              case curseur of
                 curReticuleData,curReticuleDataNew : varYPos := curseurOsc[curseurData1].grandeurCurseur;
                 curReticule,curReticuleModele : varYPos := curseurOsc[1].grandeurCurseur;
                 curEquivalence : begin
                     varYPos := equivalenceCourante.varY;
                     if (equivalenceCourante<>nil) then begin
                       valeurCurseur[coX] := equivalenceCourante.ve;
                       valeurCurseur[coY] := equivalenceCourante.phe;
                       valeurCurseur[coPente] := equivalenceCourante.pente;
                     end;
                 end;
              end;
              if varYpos=nil then varYPos := monde[mondeY].axe;
              savePositionDlg.curseur := curseur;
              for i := 1 to 5 do
                  savePositionDlg.curseurData[i] := curseurOsc[i];
              savePositionDlg.unitePente := unitePente;
              savePositionDlg.graphe := grapheCourant;
              if savePositionDlg.showModal=mrOK then begin
                 AjoutGrandeurNonModele := true;
                 Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
              end;
end end;

procedure TFgrapheVariab.SetParamEdit;
begin
    if PanelParam1.visible then begin
       if NbreParam[paramNormal]<1 then exit;
       if (etatModele=[]) or (pasdeModele in etatModele ) then exit;
       if paramEditCourant<1 then paramEditCourant := 1;
       if paramEditCourant>NbreParam[paramNormal] then paramEditCourant := NbreParam[paramNormal];
       EditValeur[paramEditCourant].setFocus;
    end;
end;

procedure TFgrapheVariab.ProprieteCourbeClick(Sender: TObject);
begin
  if PropCourbeForm=nil then
     PropCourbeForm := TPropCourbeForm.create(self);
  with PropCourbeForm do begin
     Acourbe := grapheCourant.coordonnee[iPropCourbe];
     Agraphe := grapheCourant;
     tangenteEnCours := (curseur=curEquivalence) or
                        (grapheCourant.equivalences[pageCourante].count>0);
     maj;
  end;
  PropCourbeForm.show;
end;

procedure TFgrapheVariab.RadioItemClick(Sender: TObject);
begin
  setModeleGr(mgRadio)
end;

procedure TFgrapheVariab.RandomBtnAnimClick(Sender: TObject);
begin
   if AnimationTemps.checked
      then calculeAnimTemporelle
      else calculeAnimManuelle;
end;

procedure TFgrapheVariab.RandomBtnClick(Sender: TObject);
begin
   if AnimationTemps.checked
      then calculeAnimTemporelle
      else if AnimationParam.checked
         then calculeAnimManuelle
         else Fvaleurs.RandomBtnClick(sender);
end;

procedure TFgrapheVariab.PaintBox1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var x,y : integer;

(*
TGestureEventInfo = record
    GestureID: TGestureID;
    Location: TPoint;
    Flags: TInteractiveGestureFlags;
    Angle: Double;
    InertiaVector: TSmallPoint;
      Distance: Integer;
      TapLocation: TPoint;
  end;

GID_ZOOM Indicates the distance between the two points. Indicates the center of the zoom.
GID_PAN	Indicates the distance between the two points. Indicates the current position of the pan.
GID_ROTATE Indicates the angle of rotation if If the GF_BEGIN flag is set.
   Otherwise, this is the angle change since the rotation has started.
   This is signed to indicate the direction of the rotation.
   Use the GID_ROTATE_ANGLE_FROM_ARGUMENT and GID_ROTATE_ANGLE_TO_ARGUMENT macros to get and set the angle value.
   This indicates the center of the rotation which is the stationary point that the target object is rotated around.
GID_TWOFINGERTAP	Indicates the distance between the two fingers.	Indicates the center of the two fingers.
GID_PRESSANDTAP	Indicates the delta between the first finger and the second finger.
This value is stored in a POINT structure in the lower 32 bits of the ullArguments member.
Indicates the position that the first finger comes down on.
*)

procedure affecteBorneCourante;
var iCourbe,indexPoint : integer;
begin
      iCourbe := BorneSelect.indexCourbe;
      indexPoint := grapheCourant.PointProche(x,y,iCourbe,true,false);
      if (indexPoint>0) then begin
            if BorneSelect.style=bsDebut
            then begin
               pages[pageCourante].debut[BorneActive] := indexPoint;
               grapheCourant.courbes[iCourbe].debutC := indexPoint;
            end
            else begin
               pages[pageCourante].fin[borneActive] := indexPoint;
               grapheCourant.courbes[iCourbe].finC := indexPoint;
            end;
            grapheCourant.SetBorne(x,y,BorneSelect);
      end;
end;

procedure AffecteSelection;
begin
    grapheCourant.rectangleGr(zoneZoom); // efface
    zoneZoom.Width := abs(eventInfo.Location.x-debutZoom.x);
    zoneZoom.Height := abs(eventInfo.Location.y-debutZoom.y);
    if eventInfo.Location.x<debutZoom.x then zoneZoom.left := x;
    if eventInfo.Location.y<debutZoom.y then zoneZoom.top := x;
    grapheCourant.rectangleGr(zoneZoom); // retrace
end;
var aPoint : TPoint;
    iG : integer;
begin
    iG := 0;
    if sender=PaintBox1 then iG := 1;
    if sender=PaintBox2 then iG := 2;
    if iG>0 then begin
       indexGrCourant := iG;
       grapheCourant := graphes[iG];
    end
    else exit;
    aPoint := point(eventInfo.Location.x,eventInfo.Location.y);
    aPoint := grapheCourant.paintBox.screenToClient(Apoint);
    x := aPoint.x;
    y := aPoint.y;
    case EventInfo.GestureId of
         igiPressAndTap :;
         igiDoubleTap :;
         igiLongTap :;
         igiRotate :;
         igiTwoFingerTap :;
         igiZoom : begin
            if (TInteractiveGestureFlag.gfBegin in EventInfo.Flags)
            then begin
              FLastDistance := EventInfo.Distance;
              grapheCourant.RectangleGr(zoneZoom); // efface
              panEnCours := false;
            end
            else if TInteractiveGestureFlag.gfEnd in EventInfo.Flags
            then grapheCourant.useDefaut := true
            else begin
                if grapheCourant.affecteZoom(EventInfo.location,(EventInfo.Distance - FLastDistance),true)
                then begin
                   include(grapheCourant.modif,gmEchelle);
                   modifGraphe(indexGrCourant);
                   FLastDistance := EventInfo.Distance;
                end;
            end;
            handled := true;
         end;
         igiPan : begin
              if (TInteractiveGestureFlag.gfBegin in EventInfo.Flags)
                 then begin
                      if grapheCourant.GetBorne(x,y,BorneSelect)
                          then panEffect := panDragBorne
                          else if curseur=curZoomAv
                             then panEffect := panZoom
                             else if SplitterModele.snapped
                                then panEffect := panBornes
                                else panEffect := panDeplace;
                      if panEffect<>panDragBorne then grapheCourant.rectangleGr(zoneZoom);
                      zoneZoom.left := x;
                      zoneZoom.top := y;
                      panEnCours := true;
                      //panTimer.enabled := true;
                      debutZoom := EventInfo.Location;
                 end
              else if (TInteractiveGestureFlag.gfEnd in EventInfo.Flags)
                 then begin   // arrive parfois ?
                      OKreg('fin gesture',0);
                      case panEffect of
                          panZoom : grapheCourant.affecteZoomAvant(zoneZoom,true);
                          panEfface : affecteEfface(x,y);
                          panBornes : affecteBornes(x,y);
                          panDragBorne : AffecteBorne;
                          panDeplace : affecteDeplace(x,y);
                      end;
                      grapheCourant.rectangleGr(zoneZoom); // efface
                      panEnCours := false;
                      include(grapheCourant.modif,gmEchelle);
                      modifGraphe(indexGrCourant);
                 end
              else begin
                   if panEffect=panDragBorne
                      then affecteBorneCourante
                      else affecteSelection;
                   panEnCours := true;
              end;
              handled := true;
         end;
    end;
end;

procedure TFgrapheVariab.PaintBox2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if source is TStringGrid then (source as TstringGrid).EndDrag(true); // ??
end;

procedure TFgrapheVariab.AfficheAnimationTemporelle;
var j : integer;
begin with graphes[1] do begin
      if not grapheOK then exit;
      avecAnimTemporelle := true;
      if (bitmapReg.height<>paintBox1.clientRect.bottom) or
         (bitmapReg.width<>paintBox1.clientRect.right) then begin
            bitmapReg.height := paintBox1.clientRect.bottom;
            bitmapReg.width := paintBox1.clientRect.right;
            clearGrapheAnim := true;
      end;
      bitmapReg.canvas.Pen.mode := pmCopy;
      canvas.Pen.mode := pmCopy;
      limiteFenetre := paintBox1.clientRect; // non à jour au début ?
      LabelTempsAnim.caption := grandeurs[0].formatNomEtUnite(tempsCourant);
      for j := 0 to pred(graphes[1].Courbes.count) do with graphes[1].Courbes[j] do
         if page=pageCourante then begin
               finC := pages[pageCourante].NumeroAnim;
               debutC := finC;
               NumAnim := finC;
               if traceCB.checked then if avance
                   then debutC := 0
                   else finC := pred(pages[pageCourante].nmes);
               if LignePointCB.checked then begin
                   include(trace,trLigne);
                   debutC := 0;
                   finC := pred(pages[pageCourante].nmes);
               end;
      end;
      if modifMonde or
         ClearGrapheAnim or
         not traceCB.checked
            then begin // on efface
               bitmapReg.canvas.brush.Style := bsSolid;
               bitmapReg.canvas.brush.color := clWindow;
               bitmapReg.canvas.FillRect(LimiteFenetre);
            end;
      canvas := bitmapReg.canvas;
      draw;
      paintBox1.Canvas.Draw(0,0,bitmapReg);
      modif := [];
      ClearGrapheAnim := false;
end end; // AfficheAnimationTemporelle

procedure TFgrapheVariab.WMSizing(var Msg: Tmessage);
begin
    Sizing := true;
    TimerSizing.Enabled := false; // arrêt
    TimerSizing.Enabled := true;  // on relance
end;

procedure TFgrapheVariab.setModeleGR(index : TgenreModeleGr);
var m : integer;
begin
   with grapheCourant,fonctionTheorique[1] do begin
       if monde[mondeX].axe<>nil then
           indexX := indexNom(monde[mondeX].axe.nom);
       for m := mondeY to mondeSans do
           if monde[m].axe<>nil then begin
              indexY := indexNom(monde[m].axe.nom);
              break;
           end;
   end;
   NbreModele := 1;
   ChoixModeleDlg.EffaceModele := true;
   ChoixModeleDlg.modeleChoisi := index;
   ModeleMagnum(1,true);
end;

procedure TFgrapheVariab.AffecteEfface(x,y : integer);
var xfin,xdebut,yfin,ydebut : double;
    indexPoint : integer;
    modifNbre : boolean;
    p : TcodePage;
begin with zoneZoom,grapheCourant do begin
    canvas.Rectangle(left,top,right,bottom);// efface
    right := X;
    bottom := Y;
    if (left=right) or (bottom=top)
        then begin
            indexPoint := PointProche(x,y,0,true,false);
            modifNbre := indexPoint>=0;
            if modifNbre then Pages[pageCourante].SupprimeLignes(indexPoint,indexPoint);
        end
        else begin
            MondeRT(right,top,mondeY,xfin,yfin);
            MondeRT(left,bottom,mondeY,xdebut,ydebut);
            with coordonnee[1] do
                 ModifNbre := pages[pageCourante].EffacePage(xdebut,ydebut,xfin,yfin,codeX,codeY);
            if superposePage and (NbrePages>1) and OKreg(okSupprAutresPages,0) then
                 for p := 1 to NbrePages do if p<>pageCourante then with pages[p] do
                     if active then with coordonnee[1] do
                        EffacePage(xdebut,ydebut,xfin,yfin,codeX,codeY);
        end;
   if modifNbre
      then Application.MainForm.Perform(WM_Reg_Maj,MajSupprPoints,0)
      else if SupprReticule(x,y) then begin
          paintBox.invalidate;
      end;
   if not effaces then setPenBrush(curSelect);
end end;

procedure  TFgrapheVariab.AffecteBorne;
begin with borneSelect,grapheCourant do
   if (courbes[indexCourbe].debutC<
       courbes[indexCourbe].finC)
   then begin
      case style of
         bsDebut,bsDebutVert : pages[pageCourante].debut[indexModele] :=
             courbes[indexCourbe].debutC;
         bsFin,bsFinVert : pages[pageCourante].fin[indexModele] :=
             courbes[indexCourbe].finC;
      end;
      if [ModeleConstruit,ModeleLineaire] <= etatModele
           then lanceModele(true)
   end;
end;// AffecteBorne

procedure TFgrapheVariab.AffecteBornes(x,y : integer);
var x1,x2,y1,y2 : double;
    i : integer;
    indexX,indexY : integer;
    mSelect,m : TindiceMonde;
    t0 : double;
begin with zoneZoom,grapheCourant do begin
        VideStatusPanel(HeaderXY,0);
        canvas.Rectangle(left,top,right,bottom);// efface
        right := X;
        bottom := Y;
        setPenBrush(curSelect);
        if (left=right) or (bottom=top) then exit;
        with pages[pageCourante] do begin
             debut[BorneActive] := pred(nmes);
             fin[BorneActive] := 0;
             indexX := indexNom(monde[mondeX].axe.nom);
             indexY := grandeurInconnue;
             mSelect := mondeY;
             if BorneActive<=NbreModele then
                for m := mondeY to mondeSans do
                  if (monde[m].axe<>nil) and
                     (fonctionTheorique[BorneActive].indexY=
                      indexNom(monde[m].axe.nom))
                  then begin
                     indexY := indexNom(monde[m].axe.nom);
                     mSelect := m;
                     break;
                  end;
             if indexY=grandeurInconnue then
                for m := mondeY to mondeSans do
                    if monde[m].axe<>nil then begin
                       indexY := indexNom(monde[m].axe.nom);
                       mSelect := m;
                       break;
                  end;
             MondeRT(right,top,mSelect,x1,y1);
             MondeRT(left,bottom,mSelect,x2,y2);
             for i := 0 to pred(nmes) do
                 if ((valeurVar[indexX,i]-x1)*(valeurVar[indexX,i]-x2)<0) and
                    ((valeurVar[indexY,i]-y1)*(valeurVar[indexY,i]-y2)<0) then begin
                    if debut[BorneActive]>i then debut[BorneActive] := i;
                    if fin[BorneActive]<i then fin[BorneActive] := i;
                 end;
             borneVisible := true;
             if (nmes<MaxVecteurDefaut) and (NbreModele<=1) and (borneActive=1)
               then begin
                  for i := 0 to debut[borneActive]-1 do
                      PointActif[i] := false;
                  for i := debut[borneActive] to fin[borneActive] do begin
                      PointActif[i] :=
                     ((valeurVar[indexX,i]-x1)*(valeurVar[indexX,i]-x2)<0) and
                     ((valeurVar[indexY,i]-y1)*(valeurVar[indexY,i]-y2)<0);
                     if not PointActif[i] then borneVisible := false;
                  end;
                  for i := fin[borneActive]+1 to pred(nmes) do
                     PointActif[i] := false;
               end
               else begin
                    for i := 0 to pred(MaxVecteurDefaut) do PointActif[i] := true;
               end;
             if BorneActive=succ(NbreModele)
                then begin
                   FonctionTheorique[succ(NbreModele)].indexX := indexX;
                   FonctionTheorique[succ(NbreModele)].indexY := indexY;
                   ChoixModeleDlg.coordonnee := coordonnee;
                   ChoixModeleDlg.appelMagnum := false;
                   ChoixModeleDlg.PageControl.ActivePage := ChoixModeleDlg.ModManuel;
                   if ChoixModeleDlg.showModal=mrOk then
                      if ChoixModeleDlg.modeleChoisi=mgManuel
                         then begin
                           if ChoixModeleDlg.effaceModele then MemoModele.clear;
                           with FonctionTheorique[NbreModele] do
                           if enTete<>'' then begin
                              MemoModele.lines.Add(enTete+'='+expression);
                              lanceModele(genreC=g_fonction);
                              paintBox.invalidate;
                              exit;
                           end
                        end
                        else ModeleMagnum(ChoixModeleDlg.CoordRG.itemIndex+1,false);
               end
               else if (curseur=curModeleGr) and (indexModeleGr>0) then begin
                   ModeleGraphique[indexModeleGr].initialiseParametre(
                       Pages[pageCourante].debut[indexModeleGr],
                       Pages[pageCourante].fin[indexModeleGr],t0,false);
               end;
        end;
        if ModeleDefini in etatModele then
           if [ModeleConstruit,ModeleLineaire] <= etatModele
               then lanceModele(true)
               else begin
                  pages[pageCourante].ModeleCalcule := false;
                  pages[pageCourante].ModeleErrone := false;
                  include(modif,gmModele);
                  if not(splitterModele.snapped) then setParamEdit;
               end;
       paintbox.invalidate;
end end;


procedure TFgrapheVariab.AffecteDeplace(x,y : integer);

var deltaM : double;

begin with grapheCourant do begin

            with monde[mondeX] do begin
                 deltaM := (x-zoneZoom.left)/a;
                 mini := mini+deltaM;
                 maxi := maxi+deltaM;
                 defini := true;
            end;
            with monde[mondeY] do begin
                 deltaM := (y-zoneZoom.top)/a;
                 mini := mini+deltaM;
                 maxi := maxi+deltaM;
                 defini := true;
            end;
            with monde[mondeDroit] do begin
                 deltaM := (y-zoneZoom.top)/a;
                 mini := mini+deltaM;
                 maxi := maxi+deltaM;
                 defini := true;
            end;
            if (abs(x-zoneZoom.left)+abs(y-zoneZoom.Top)>8) then begin
               paintBox.invalidate;
               zoneZoom := rect(X,Y,X,Y);
            end;
end end;

procedure TFgrapheVariab.verifTri;
var indexTriNew : integer;

procedure effectuerTri;
var i,m : integer;
    xdebut,xfin : array[1..MaxIntervalles] of double;
    Boutons : TMsgDlgButtons;
begin with pages[pageCourante] do begin
       for m := 1 to NbreModele do with fonctionTheorique[m] do
           if (indexX=indexTriNew) then begin
              xdebut[m] := valeurVar[indexX,debut[m]];
              xfin[m] := valeurVar[indexX,fin[m]];
           end;
       Fvaleurs.trierVariables(indexTriNew);
       for m := 1 to NbreModele do with fonctionTheorique[m] do
           if (indexX=indexTriNew) then begin
              for i := 0 to pred(nmes) do begin
                  if xdebut[m] = valeurVar[indexX,i] then debut[m] := i;
                  if xfin[m] = valeurVar[indexX,i] then fin[m] := i;
              end;
           end;
       PostMessage(FgrapheVariab.handle,WM_Reg_Maj,MajGrandeur,0);
    //  mtWarning  mtInformation
       boutons := [mbOK];
       MessageDlg('Cliquer sur le bouton "Ajuster"',mtWarning,boutons,0);
end end;

var m,j : integer;
    atrier : boolean;
    xdebut,xfin,xcourant : double;
begin with pages[pageCourante] do begin
    if nmes>512 then exit;
    atrier := false;
    for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        if (indexX<>indexTri) and ((debut[m]>0) or (fin[m]<(nmes-1))) then begin
            xdebut := valeurVar[indexX,debut[m]];
            xfin := valeurVar[indexX,fin[m]];
            verifMinMaxReal(xdebut,xfin);
            for j := 0 to debut[m]-1 do begin
                xcourant := valeurVar[indexX,j];
                if (xcourant>xdebut) or (xcourant<xfin) then begin
                   atrier := true;
                   indexTriNew := indexX;
                   break; // boucle j
                end;
            end;
            if not atrier then for j := debut[m]+1 to fin[m]-1 do begin
                xcourant := valeurVar[indexX,j];
                if (xcourant<xdebut) or (xcourant>xfin) then begin
                   atrier := true;
                   indexTriNew := indexX;
                   break;
                end;
            end;
            if not atrier then for j := fin[m]+1 to pred(nmes) do begin
                xcourant := valeurVar[indexX,j];
                if (xcourant>xdebut) or (xcourant<xfin) then begin
                   atrier := true;
                   indexTriNew := indexX;
                   break;
                end;
            end;
        end;
        if aTrier then break; // boucle m
    end;
    if atrier then
        if OKReg('Données à trier selon '+Grandeurs[indexTriNew].nom+' ?',0)
           then effectuerTri
           else prevenirTri := false;
end end;

end.

