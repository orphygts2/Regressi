unit optionsUU;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, sysUtils, ComCtrls, Dialogs,
  ImgList, CheckLst, inifiles, Regutil, maths;

const
  imFFT = 0;
  imGrapheConst = 1;
  imStat = 2;
  imModeleGr = 3;
  imLycee = 4;
  imBornes = 5;
  imAnimation = 6;
  imUnite = 7;
  imTableauImpr = 8;
  imPrinterSetUp = 9;
  imBoutonImpr = 10;
  imAcqFond = 11;
  imCornish = 12;
  imVitesse = 13;
  imOptique = 14;
  imInitiationModele = 15;
  imMRU = 16;

  NbreCouleur = 17;

type
  setMenu = set of 0..31;

  TCfgOptionsDlg = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DegreRG: TRadioGroup;
    Panel1: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    FontSizeRG: TRadioGroup;
    TestEdit: TEdit;
    TabSheet7: TTabSheet;
    FontSizeImprRG: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    PbMemoirePrintCB: TCheckBox;
    TabSheet5: TTabSheet;
    AcqListBox: TListBox;
    AddAcqBtn: TBitBtn;
    DelAcqBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    PermuteCB: TCheckBox;
    TabSheet8: TTabSheet;
    ToutModuleBtn: TBitBtn;
    AucunBtn: TBitBtn;
    GraduationPiCB: TCheckBox;
    Label2: TLabel;
    MaxCopiesSE: TSpinEdit;
    MenuPermisCLB: TCheckListBox;
    OptionsFichierCB: TCheckBox;
    PrintGridCB: TCheckBox;
    Label3: TLabel;
    ChiffresSignifSE: TSpinEdit;
    LissageLabel: TLabel;
    OrdreLissageSE: TSpinEdit;
    Label1: TLabel;
    NbreEdit: TEdit;
    NbreSpinButton: TSpinButton;
    GroupBox1: TGroupBox;
    YmaxBmpSE: TSpinEdit;
    XmaxBmpSE: TSpinEdit;
    Label12: TLabel;
    Label14: TLabel;
    GridPrintCB: TCheckBox;
    DataCanModifCB: TCheckBox;
    Label16: TLabel;
    GroupePathLabel: TLabel;
    Label13: TLabel;
    GroupePathEdit: TEdit;
    DataPathEdit: TEdit;
    GroupePathBtn: TSpeedButton;
    RepertoireDataBtn: TSpeedButton;
    RazRepDataBtn: TSpeedButton;
    BitBtn1: TBitBtn;
    PanelHint: TPanel;
    Panel2: TPanel;
    NomColor: TColorBox;
    CommentaireColor: TColorBox;
    ExpressionColor: TColorBox;
    UniteColor: TColorBox;
    ResultatColor: TColorBox;
    NonExpColor: TColorBox;
    AngleEnDegreCB: TCheckBox;
    TabSheet4: TTabSheet;
    IncertitudeCB: TCheckBox;
    Label11: TLabel;
    SpinEdit1: TSpinEdit;
    Label17: TLabel;
    DimPointSE: TSpinEdit;
    Label18: TLabel;
    AxeColorCombo: TColorBox;
    OptionsBtn: TSpeedButton;
    GraduationZeroCB: TCheckBox;
    TraceDefautRG: TRadioGroup;
    SaveCfgAcqCB: TCheckBox;
    GrilleCB: TCheckBox;
    TabSheet6: TTabSheet;
    FenetreRG: TRadioGroup;
    GradCmCB: TCheckBox;
    TriCB: TCheckBox;
    LevenbergCB: TCheckBox;
    AjustageAutoLinCB: TCheckBox;
    AjustageAutoGrCB: TCheckBox;
    UseChi2CB: TCheckBox;
    BandeConfianceCB: TCheckBox;
    AfficheCorrel: TCheckBox;
    MonochromeCB: TCheckBox;
    BiochimieBtn: TBitBtn;
    PhysiqueBtn: TBitBtn;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    WidthGradSE: TSpinEdit;
    WidthAxeSE: TSpinEdit;
    WidthCourbeSE: TSpinEdit;
    Label21: TLabel;
    OptionsCB: TCheckBox;
    ModeleManuelCB: TCheckBox;
    CoeffEllipseRG: TRadioGroup;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    NbreLabel: TLabel;
    NbreSE: TSpinEdit;
    ExtrapoleDerCB: TCheckBox;
    BitBtn2: TBitBtn;
    UseMPCB: TCheckBox;
    IncertitudeRG: TRadioGroup;
    UniteParCB: TCheckBox;
    ClavierAvecGrapheCB: TCheckBox;
    ModeVideoRG: TRadioGroup;
    ModelePourCentCB: TCheckBox;
    SauvegardeCB: TCheckBox;
    Label22: TLabel;
    VideoDirBtn: TSpeedButton;
    VideoPathEdit: TEdit;
    WidthEcranSE: TSpinEdit;
    LabelWidth: TLabel;
    Label23: TLabel;
    TempDirEdit: TEdit;
    SpeedButton1: TSpeedButton;
    FontDialog: TFontDialog;
    FontBtn: TSpeedButton;
    ChiffreCorrelSE: TSpinEdit;
    LabelCorrel: TLabel;
    configRepertoireCB: TCheckBox;
    BandePredictionCB: TCheckBox;
    procedure NbreSpinButtonDownClick(Sender: TObject);
    procedure NbreSpinButtonUpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DegreRGClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FontSizeRGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AddAcqBtnClick(Sender: TObject);
    procedure DelAcqBtnClick(Sender: TObject);
    procedure ToutModuleBtnClick(Sender: TObject);
    procedure AucunBtnClick(Sender: TObject);
    procedure MenuPermisCLBClickCheck(Sender: TObject);
    procedure RazRepDataBtnClick(Sender: TObject);
    procedure RepertoireDataBtnClick(Sender: TObject);
    procedure GroupePathBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure BiochimieBtnClick(Sender: TObject);
    procedure PhysiqueBtnClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure VideoDirBtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure ChiffreCorrelSEChange(Sender: TObject);
  private
    MenuW : LongInt;
    nomFichier : string;
    procedure setBoutonsAcq;
    procedure ShowHint(Sender: TObject);
  public
  end;

const
        couleurAxeX : Tcolor = clBlack;
        PStyleTangente : TpenStyle = psSolid;
        PStyleReticule : TpenStyle = psSolid;
        PcolorTangente : Tcolor = clBlack;
        PcolorReticule : Tcolor = clBlack;
        FondReticule : Tcolor = clYellow;

var
  CfgOptionsDlg: TCfgOptionsDlg;
  MenuPermis : setMenu;
  OptionsMenuFichier : boolean;

implementation

uses optcolorUU, AideConfig;

const
     MaxAcq = 9;
     NbrePointDerivee : integer = 5;
     DegreDerivee : integer = 2;
     MinPoint : array[0..2] of integer = (3,3,5);
     TailleFonte : array[0..1] of integer = (10,12);
     XmaxBitmap : integer = 640;
     YmaxBitmap : integer = 360; {16/9}
     ImpressionGrandTableau : boolean = false;

var
     fontSizeImpr : integer;
     fontSize : integer;
     couleurCommentaire,couleurUnite,couleurResultat,couleurIncertitude,
     couleurNonExp,couleurBoucle,couleurExp,couleurNom : Tcolor;
     AcqList : TStringList;
     RepertoireData,RepertoireGroupe,RepertoireVideo : string;

{$R *.DFM}

procedure TCfgOptionsDlg.NbreSpinButtonDownClick(Sender: TObject);
begin
     if NbrePointDerivee>MinPoint[degreRG.itemIndex] then begin
        dec(NbrePointDerivee,2);
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TCfgOptionsDlg.NbreSpinButtonUpClick(Sender: TObject);
begin
     if NbrePointDerivee<11 then begin
        inc(NbrePointDerivee,2);
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TCfgOptionsDlg.FormActivate(Sender: TObject);
var i : integer;
    nom : String;
begin
       AxeColorCombo.selected := couleurAxeX;
       XmaxBmpSE.value := XmaxBitmap;
       YmaxBmpSE.value := YmaxBitmap;
       OptionsFichierCB.checked := OptionsMenuFichier;
       NbreEdit.text := IntToStr(NbrePointDerivee);
       DegreRG.itemIndex := DegreDerivee-1;
       PrintGridCB.checked := impressionGrandTableau;
       case fontSize of
            10 : FontSizeRG.itemIndex := 0;
            12 : FontSizeRG.itemIndex := 1;
            else FontSizeRG.itemIndex := 1;
       end;
       case fontSizeImpr of
            10 : FontSizeImprRG.itemIndex := 0;
            12 : FontSizeImprRG.itemIndex := 1;
            else FontSizeImprRG.itemIndex := 1;
       end;
       for i := 0 to pred(menuPermisCLB.items.count) do
           menuPermisCLB.checked[i] := i in menuPermis;
       CommentaireColor.selected := couleurCommentaire;
       UniteColor.selected := couleurUnite;
       ResultatColor.selected := couleurResultat;
       NonExpColor.selected := couleurNonExp;
       ExpressionColor.selected := couleurExp;
       NomColor.selected := couleurNom;
       if repertoireData='' then RepertoireData := MesDocsDir;
       DataPathEdit.text := RepertoireData;
       VideoPathEdit.text := RepertoireVideo;
       GroupePathEdit.text := RepertoireGroupe;
       TempDirEdit.Text := TempDirReg;
       AcqListBox.clear;
       for i := 0 to pred(AcqList.count) do begin
           Nom := ChangeFileExt(ExtractFileName(AcqList[i]),'');
           AcqListBox.items.Add(Nom);
       end;
end;

procedure TCfgOptionsDlg.DegreRGClick(Sender: TObject);
begin
      DegreDerivee := 1+DegreRG.itemIndex;
      if NbrePointDerivee<MinPoint[degreRG.itemIndex] then
         NbreSpinButtonUpClick(Sender);
end;

procedure TCfgOptionsDlg.OKBtnClick(Sender: TObject);

procedure Sauve(const nom : string);
var i : integer;
    ini : TMemIniFile;
begin
    Ini := TmemIniFile.create(nom);
    try
    Ini.WriteInteger('Regressi','IncertRect',IncertitudeRG.itemIndex);
    Ini.writeBool('Graphe','Clavier',ClavierAvecGrapheCB.checked);
    Ini.writeBool('Sauvegarde','Active',SauvegardeCB.checked);
    Ini.WriteInteger('Fenetre','Disposition',fenetreRG.itemIndex);
    Ini.writeInteger('Dérivée','Nombre',NbrePointDerivee);
    Ini.writeInteger('Point','Taille',DimPointSE.value);
    Ini.writeInteger('Graphe','WidthEcran',WidthEcranSE.value);
    Ini.writeInteger('Graphique','OrdreLissage',OrdreLissageSE.value);
    Ini.writeInteger('Dérivée','Degré',DegreDerivee);
    Ini.writeInteger('Format','Chiffres',ChiffresSignifSE.value);
    Ini.writeInteger('Fonte','Taille',FontSize);
    Ini.writeBool('Calcul','ModelePourCent',ModelePourCentCB.checked);
    Ini.WriteBool('Regressi','UnitePar',UniteParCB.Checked);
    Ini.WriteInteger('Graphe','CoeffEllipse',CoeffEllipseRG.itemIndex);
    Ini.WriteBool('Modele','Manuel',ModeleManuelCB.checked);
    Ini.WriteBool('Graphe','OptionsPermises',not OptionsCB.checked);
    Ini.writeBool('Printer','Mono',MonochromeCB.checked);
    Ini.writeBool('Imprimante','NB',MonochromeCB.checked);
    Ini.WriteBool('Regressi','DataTrie',TriCB.checked);
    Ini.WriteBool('Calcul','Degre',AngleEnDegreCB.checked);
// Modélisation
    Ini.WriteBool('Regressi','Levenberg',LevenbergCB.checked);
    Ini.WriteBool('Regressi','AjusteAutoLin',AjustageAutoLinCB.checked);
    Ini.WriteBool('Regressi','AjusteAutoGr',AjustageAutoGrCB.checked);
    Ini.WriteBool('Regressi','Chi2',UseChi2CB.checked);
    Ini.WriteBool('CoeffCorrel','Affiche',AfficheCorrel.checked);
    Ini.WriteBool('Graphe','BandeConfiance',BandeConfianceCB.checked);
    Ini.writeBool('Graphe','BandePrediction',BandePredictionCB.checked);
// graphique
    Ini.WriteString('Graphe','Font',FontName);
    Ini.WriteBool('Graphe','Ellipse',IncertitudeCB.checked);
    Ini.WriteBool('Graphe','Grille',GrilleCB.checked);
    Ini.WriteBool('Graphe','ZeroGradue',GraduationZeroCB.checked);
    Ini.WriteBool('Regressi','GraduationPi',GraduationPiCB.checked);
    Ini.writeBool('Graphe','GraduationCm',GradCmCB.checked);
    Ini.WriteInteger('PenStyle','Tangente',ord(PstyleTangente));
    Ini.WriteInteger('Color','Tangente',pcolorTangente);
    Ini.WriteInteger('PenStyle','Reticule',ord(PstyleReticule));
    Ini.WriteInteger('Color','Reticule',pcolorReticule);
    Ini.WriteInteger('Color','FondMarque',FondReticule);
// acquisition
    Ini.EraseSection('Acquisition');
    for i := 0 to pred(AcqList.count) do
        Ini.writeString('Acquisition',IntToStr(i),AcqList[i]);
    Ini.writeInteger('Impression','Copies',MaxCopiesSE.value);
    Ini.writeInteger('Impression','Fonte',FontSizeImpr);
    Ini.writeBool('Impression','Grid',GridPrintCB.checked);
    Ini.writeBool('Impression','PbMemoire',PbMemoirePrintCB.checked);
    Ini.writeInteger('Graphe','XmaxBitmap',XmaxBitmap);
    Ini.writeInteger('Graphe','YmaxBitmap',YmaxBitmap);
    Ini.WriteBool('Regressi','Permute',PermuteCB.checked);
    Ini.WriteBool('Regressi','DataModif',DataCanModifCB.checked);
    Ini.WriteBool('Regressi','SaveCfgAcq',SaveCfgAcqCB.checked);
    Ini.WriteInteger('Regressi','Menus',longInt(MenuPermis));
    Ini.WriteBool('Regressi','MathPlayer',UseMPCB.checked);
    Ini.WriteBool('Regressi','Users',true);
    Ini.writeBool('Dérivée','Extrapole',ExtrapoleDerCB.checked);
    Ini.WriteInteger('Graphe','TracePoint',TraceDefautRG.itemIndex);
    if configRepertoireCB.Checked then begin
      Ini.WriteString('Repertoire','Data',RepertoireData);
      Ini.WriteString('Repertoire','Video',RepertoireVideo);
      Ini.WriteString('Repertoire','Temp',TempDirReg);
      Ini.WriteString('Repertoire','Groupe',RepertoireGroupe);
    end
    else Ini.eraseSection('Repertoire');
    Ini.WriteInteger('Color','Nom',couleurNom);
    Ini.WriteInteger('Color','Incert',couleurIncertitude);
    Ini.WriteInteger('Color','Boucle',couleurBoucle);
    Ini.WriteInteger('Color','Exp.',couleurExp);
    Ini.writeInteger('Fonte','TexteGraphe',spinEditHauteur.value);
    Ini.writeInteger('Graphe','NbreTexte',NbreSE.value);    
    Ini.WriteInteger('Color','Comm.',couleurCommentaire);
    Ini.WriteInteger('Color','Unite',couleurUnite);
    Ini.WriteInteger('Color','Resultat',couleurResultat);
    Ini.WriteInteger('Color','Exp',couleurExp);
    Ini.WriteInteger('Color','NonExp',couleurNonExp);
    Ini.writeInteger('Impression','WidthAxe',WidthAxeSE.value);
    Ini.writeInteger('Impression','WidthGrad',WidthGradSE.value);
    Ini.writeInteger('Impression','WidthCourbe',WidthCourbeSE.value);
    Ini.WriteInteger('Acquisition','Video',ModeVideoRG.itemIndex);
    Ini.WriteBool('Calcul','ModelePourCent',ModelePourCentCB.checked);
    Ini.WriteInteger('CoeffCorrel','Nchiffres',precisionCorrel);
    for i := 0 to pred(NbreCouleur) do begin
        Ini.WriteInteger('Color','C'+IntToStr(i),couleurPages[i]);
        Ini.WriteInteger('PenStyle','C'+IntToStr(i),ord(stylePages[i]));
        Ini.WriteInteger('PointStyle','C'+IntToStr(i),ord(MotifPages[i]));
    end;
    for i := 1 to MaxOrdonnee do begin
        Ini.WriteInteger('Color','O'+IntToStr(i),couleurInit[i]);
        Ini.WriteInteger('PointStyle','O'+IntToStr(i),ord(MotifInit[i]));
    end;
    for i := -MaxIntervalles to MaxIntervalles do
        Ini.WriteInteger('Color','M'+IntToStr(i),couleurModele[i]);
    finally
    Ini.updateFile;
    Ini.free;
    end;
end;

begin
     CouleurAxeX := AxeColorCombo.selected;
     CouleurAxeX := AxeColorCombo.selected;
     XmaxBitmap := XmaxBmpSE.value;
     YmaxBitmap := YmaxBmpSE.value;
     fontSize := tailleFonte[FontSizeRG.itemIndex];
     fontSizeImpr := tailleFonte[FontSizeImprRG.itemIndex];
     couleurCommentaire := CommentaireColor.selected;
     couleurUnite := UniteColor.selected;
     couleurResultat := ResultatColor.selected;
     couleurNonExp := NonExpColor.selected;
     couleurExp := ExpressionColor.selected;
     couleurNom := NomColor.selected;
     RepertoireData := DataPathEdit.text;
     RepertoireVideo := VideoPathEdit.text;
     TempDirReg := TempDirEdit.Text;
     if repertoireData=MesDocsDir then RepertoireData := '';
     RepertoireGroupe := GroupePathEdit.text;
     try
     Sauve(nomFichier);
     except
     end;
     try
     Sauve(nomFichierIni);
     except
     end;
     Close;
end;

procedure TCfgOptionsDlg.FontBtnClick(Sender: TObject);
begin
    FontDialog.font.name := FontName;
    if FontDialog.execute then begin
        testEdit.font.name := FontDialog.font.name;
        FontName := FontDialog.font.name;
    end;
end;

procedure TCfgOptionsDlg.FontSizeRGClick(Sender: TObject);
begin
     TestEdit.font.Size := tailleFonte[FontSizeRG.itemIndex]
end;

procedure TCfgOptionsDlg.FormCreate(Sender: TObject);

Procedure LitFichier(nom : string);
var ini : TmemIniFile;
    i : integer;
    nomComplet : String;
begin
  Ini := TMemIniFile.create(nom);
  ClavierAvecGrapheCB.checked := Ini.readBool('Graphe','Clavier',true);
  ModeVideoRG.itemIndex := Ini.ReadInteger('Acquisition','Video',0);
  IncertitudeRG.itemIndex := ini.ReadInteger('Regressi','IncertRect',0);
  UniteParCB.checked := ini.ReadBool('Regressi','UnitePar',false);
  SauvegardeCB.checked := ini.ReadBool('Sauvegarde','Active',false);
  fenetreRG.itemIndex := Ini.ReadInteger('Fenetre','Disposition',0);
  ModeleManuelCB.checked := Ini.ReadBool('Modele','Manuel',true);
  FontName := Ini.ReadString('Graphe','Font',FontName);
  ModelePourCentCB.Checked := Ini.readBool('Calcul','ModelePourCent',false);
  OptionsCB.checked := not Ini.ReadBool('graphe','OptionsPermises',true);  
  GradCmCB.checked := ini.ReadBool('Graphe','GraduationCm',false);
  MonochromeCB.checked := ini.ReadBool('Imprimante','NB',false);
  MonochromeCB.checked :=  MonochromeCB.checked or ini.ReadBool('Printer','Mono',false);
  AngleEnDegreCB.checked := Ini.ReadBool('Calcul','Degre',true);
  SpinEditHauteur.value := Ini.ReadInteger('Fonte','TexteGraphe',10);
  NbreSE.value := Ini.ReadInteger('Graphe','NbreTexte',32);  
  XmaxBitmap := Ini.ReadInteger('Graphe','XmaxBitmap',640);
  CoeffEllipseRG.itemIndex := ini.ReadInteger('Graphe','CoeffEllipse',0);
  DimPointSE.value := Ini.ReadInteger('Point','Taille',3);
  WidthEcranSE.value := Ini.ReadInteger('Graphe','WidthEcran',1);
  YmaxBitmap := Ini.ReadInteger('Graphe','YmaxBitmap',360);
  GrilleCB.checked := Ini.ReadBool('Graphe','Grille',true);
  TriCB.checked := Ini.ReadBool('Regressi','DataTrie',false);
// Modélisation
  BandeConfianceCB.checked := Ini.ReadBool('Graphe','BandeConfiance',false);
  BandePredictionCB.checked := Ini.ReadBool('Graphe','BandePrediction',false);
  LevenbergCB.checked := Ini.ReadBool('Regressi','Levenberg',false);
  AfficheCorrel.checked := Ini.ReadBool('CoeffCorrel','Affiche',false);
  AjustageAutoLinCB.checked := Ini.ReadBool('Regressi','AjusteAutoLin',true);
  AjustageAutoGrCB.checked := Ini.ReadBool('Regressi','AjusteAutoGr',false);
  UseChi2CB.checked := Ini.ReadBool('Regressi','Chi2',false);
  ModelePourCentCB.checked := Ini.ReadBool('Calcul','ModelePourCent',true);
// graphique
  IncertitudeCB.checked := Ini.ReadBool('Graphe','Ellipse',false);
  GraduationPiCB.checked := Ini.ReadBool('Regressi','GraduationPi',false);
  GraduationZeroCB.checked := Ini.ReadBool('Graphe','ZeroGradue',false);
  ChiffresSignifSE.value := Ini.ReadInteger('Format','Chiffres',4);
  PstyleTangente := TpenStyle(ini.ReadInteger('PenStyle','Tangente',0));
  PcolorTangente := ini.ReadInteger('Color','Tangente',clBlack);
  PstyleReticule := TpenStyle(ini.ReadInteger('PenStyle','Reticule',0));
  PcolorReticule := ini.ReadInteger('Color','Reticule',clBlack);
  FondReticule := ini.ReadInteger('Color','FondMarque',clYellow);
  NbrePointDerivee := Ini.ReadInteger('Dérivée','Nombre',5);
  WidthAxeSE.value := Ini.readInteger('Impression','WidthAxe',1);
  WidthGradSE.value := Ini.readInteger('Impression','WidthGrad',1);
  WidthCourbeSE.value := Ini.readInteger('Impression','WidthCourbe',3);  
  DegreDerivee := Ini.ReadInteger('Dérivée','Degré',2);
  OrdreLissageSE.value := Ini.ReadInteger('Graphique','OrdreLissage',3);
  MaxCopiesSE.value := Ini.ReadInteger('Impression','Copies',MaxCopiesSE.value);
  GridPrintCB.checked := Ini.ReadBool('Impression','Grid',true);
  PbMemoirePrintCB.checked := Ini.ReadBool('Impression','PbMemoire',false);
  fontSizeImpr := Ini.ReadInteger('Impression','Fonte',10);
  fontSizeImpr := 2*(fontSizeImpr div 2);
  if (fontSizeImpr<8) or (fontSizeImpr>12) then fontSizeImpr := 10;
  fontSize := Ini.ReadInteger('Fonte','Taille',10);
  fontSize := 2*(fontSize div 2);
  if (fontSize<8) or (fontSize>12) then fontSize := 10;
  ExtrapoleDerCB.checked := ini.ReadBool('Dérivée','Extrapole',true);
  SaveCfgAcqCB.checked := Ini.ReadBool('Regressi','SaveCfgAcq',true);
  UseChi2CB.checked := Ini.ReadBool('Regressi','Chi2',UseChi2CB.checked);
  DataCanModifCB.checked := Ini.ReadBool('Regressi','DataModif',false);
  PermuteCB.checked := Ini.ReadBool('Regressi','Permute',false);
  UseMPCB.checked := Ini.ReadBool('Regressi','MathPlayer',true);
  MenuW := High(LongInt);
  menuW := Ini.ReadInteger('Regressi','Menus',MenuW);
  MenuPermis := SetMenu(menuW);
  traceDefautRG.itemIndex := Ini.ReadInteger('Graphe','TracePoint',1);
  configRepertoireCB.checked := Ini.SectionExists('Repertoire');
  RepertoireData := Ini.ReadString('Repertoire','Data','');
  RepertoireVideo := Ini.ReadString('Repertoire','Video','');
  RepertoireGroupe := Ini.ReadString('Repertoire','Groupe','');
  couleurNom := Ini.ReadInteger('Color','Nom',clBlack);
  couleurExp := Ini.ReadInteger('Color','Exp.',clBlack);
  couleurBoucle := Ini.ReadInteger('Color','Boucle',clRed);
  couleurCommentaire := Ini.ReadInteger('Color','Comm.',clRed);
  couleurIncertitude := Ini.ReadInteger('Color','Incert',clBlue);
  couleurUnite := Ini.ReadInteger('Color','Unite',clRed);
  couleurResultat := Ini.ReadInteger('Color','Resultat',clBlue);
  couleurExp := Ini.ReadInteger('Color','Exp',clBlack);
  couleurNonExp :=  Ini.ReadInteger('Color','NonExp',clGray);
  TempDirReg := Ini.ReadString('Repertoire','Temp',TempDirReg);
  PrecisionCorrel := Ini.ReadInteger('CoeffCorrel','Nchiffres',5);
  for i := 1 to MaxOrdonnee do begin
      couleurInit[i] := Ini.ReadInteger('Color','O'+IntToStr(i),couleurInit[i]);
      MotifInit[i] := Tmotif(Ini.ReadInteger('PointStyle','O'+IntToStr(i),0));
  end;
  for i := -maxIntervalles to MaxIntervalles do
      couleurModele[i] := Ini.ReadInteger('Color','M'+IntToStr(i),couleurModele[i]);
  for i := 0 to pred(NbreCouleur) do begin
      couleurPages[i] := Ini.ReadInteger('Color','C'+IntToStr(i),couleurPages[i]);
      stylePages[i] := TpenStyle(Ini.ReadInteger('PenStyle','C'+IntToStr(i),0));
      MotifPages[i] := Tmotif(Ini.ReadInteger('PointStyle','C'+IntToStr(i),0));
  end;
  for i := 0 to MaxAcq do begin
      nomComplet := Ini.ReadString('Acquisition',IntToStr(i),'');
      nomComplet := AnsiUpperCase(nomComplet);
      if fileExists(nomComplet) and
        (AcqList.indexOf(nomComplet)<0)
             then AcqList.Add(nomComplet);
  end;
  Ini.free;
end;

begin
  NomFichier := ExtractFilePath(application.exeName)+'regressi.exe';
  if not FileExists(NomFichier) then begin
     showMessage('Placer ConfigRegressi dans le répertoire de regressi.exe');
     halt;
  end;
  nomFichier := changeFileExt(nomFichier,'.ini');
  AcqList := TStringList.Create;
  AcqList.Duplicates := dupIgnore;
  AcqList.Sorted := true;
  OptionsMenuFichier := false;
  try
  if FileExists(nomFichier)
     then LitFichier(nomFichier)
     else if FileExists(nomFichierIni) then LitFichier(nomFichierIni);
  except
  end;
  Application.OnHint := ShowHint;
  Application.ShowHint := true;
end;  // FormCreate

procedure TCfgOptionsDlg.HelpBtnClick(Sender: TObject);
begin
     Application.HelpContext(806)
end;

procedure TCfgOptionsDlg.AddAcqBtnClick(Sender: TObject);
var Nom : String;
    i : integer;
begin
     if OpenDialog.execute then begin
        Nom := AnsiUpperCase(OpenDialog.FileName);
        i := AcqList.indexOf(nom);
        if i<0 then begin
             if AcqList.count=MaxAcq+1 then AcqList.delete(MaxAcq);
             AcqList.Add(Nom);
             AcqListBox.Items.Add(ChangeFileExt(ExtractFileName(Nom),''));
        end;
        setBoutonsAcq;
     end;
end;

procedure TCfgOptionsDlg.DelAcqBtnClick(Sender: TObject);
var numero : integer;
begin
     Numero := AcqListBox.itemIndex;
     if Numero>=0 then begin
        AcqListBox.Items.Delete(Numero);
        AcqList.Delete(Numero);
        SetBoutonsAcq;
     end;
end;

procedure TCfgOptionsDlg.SetBoutonsAcq;
begin
    AddAcqBtn.enabled := AcqList.count<=MaxAcq;
    DelAcqBtn.enabled := AcqList.count>0;
end;

procedure TCfgOptionsDlg.ToutModuleBtnClick(Sender: TObject);
var i : integer;
begin
     MenuW := High(longInt);
     MenuPermis := setMenu(MenuW);
     for i := 0 to pred(MenuPermisCLB.items.Count) do
           MenuPermisCLB.checked[I] := true;
end;

procedure TCfgOptionsDlg.VideoDirBtnClick(Sender: TObject);
begin
  if SelectDir(RepertoireVideo) then
        VideoPathEdit.text := RepertoireVideo;
end;

procedure TCfgOptionsDlg.AucunBtnClick(Sender: TObject);
var i : integer;
begin
     MenuPermis := [];
     for i := 0 to pred(MenuPermisCLB.items.Count) do
            MenuPermisCLB.checked[i] := false;
end;

procedure TCfgOptionsDlg.MenuPermisCLBClickCheck(Sender: TObject);
var i : integer;
begin
     for i := 0 to pred(menuPermisCLB.items.count) do
         if menuPermisCLB.checked[i]
            then include(MenuPermis,i)
            else exclude(MenuPermis,i)
end;

procedure TCfgOptionsDlg.RazRepDataBtnClick(Sender: TObject);
begin
     RepertoireData := MesDocsDir;
     DataPathEdit.Text := MesDocsDir;
     VideoPathEdit.text := '';
end;

procedure TCfgOptionsDlg.RepertoireDataBtnClick(Sender: TObject);
begin
     if SelectDir(RepertoireData) then
        DataPathEdit.text := RepertoireData;
end;

procedure TCfgOptionsDlg.GroupePathBtnClick(Sender: TObject);
begin
     if SelectDir(repertoireGroupe) then
        GroupePathEdit.text := RepertoireGroupe
end;

procedure TCfgOptionsDlg.ShowHint(Sender: TObject);
begin
   PanelHint.Caption := Application.Hint
end;

procedure TCfgOptionsDlg.SpeedButton1Click(Sender: TObject);
begin
     if SelectDir(TempDirReg) then
        tempDirEdit.text := TempDirReg
end;

procedure TCfgOptionsDlg.CancelBtnClick(Sender: TObject);
begin
     close
end;

procedure TCfgOptionsDlg.ChiffreCorrelSEChange(Sender: TObject);
begin
    precisionCorrel := chiffreCorrelSE.value
end;

procedure TCfgOptionsDlg.BitBtn1Click(Sender: TObject);
begin
     if fileExists(nomFichier) then DeleteFile(nomFichier);
     Close;
end;

procedure TCfgOptionsDlg.OptionsBtnClick(Sender: TObject);
begin
    CfgOptionCouleurDlg.ShowModal
end;

procedure TCfgOptionsDlg.BiochimieBtnClick(Sender: TObject);
var i : integer;
begin
    ToutModuleBtnClick(Sender);
    exclude(MenuPermis,imFFT);
    exclude(MenuPermis,imAcqFond);
    exclude(MenuPermis,imVitesse);
    exclude(MenuPermis,imOptique);
    for i := 0 to pred(menuPermisCLB.items.count) do
        menuPermisCLB.checked[i] := i in menuPermis;
end;

procedure TCfgOptionsDlg.PhysiqueBtnClick(Sender: TObject);
var i : integer;
begin
  ToutModuleBtnClick(Sender);
  exclude(MenuPermis,imCornish);
  for i := 0 to pred(menuPermisCLB.items.count) do
      menuPermisCLB.checked[i] := i in menuPermis;
end;

procedure TCfgOptionsDlg.BitBtn2Click(Sender: TObject);
begin
  aideDlg.showModal
end;


end.
