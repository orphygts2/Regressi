unit options;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, sysUtils, ComCtrls, Dialogs,
  ImgList, Mask, inifiles, CheckLst, constreg,
  Vcl.htmlHelpViewer,
  maths, regutil, uniteker, compile, shlObj,
  graphker, coordphys, aidekey;

const
  imGrapheConst = 1; // toujours
  imStat = 2;
  imModeleGr = 3;
  imLycee = 4;
  imBornes = 5;
  imAnimation = 6;
  imUnite = 7;
  imTableauImpr = 8;
  imPrinterSetUp = 9;
  imBoutonImpr = 10;
  imCornish = 12;
  imVitesse = 13;
  imOptique = 14;
  imInitiationModele = 15;
  imMRU = 16;
  imEuler = 17;

type
  TsetMenu = set of 0..31;

  TOptionsDlg = class(TForm)
    PageControl: TPageControl;
    CalculTS: TTabSheet;
    AffichageTS: TTabSheet;
    DirTS: TTabSheet;
    DegreRG: TRadioGroup;
    Panel1: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    TestEdit: TEdit;
    PrintTS: TTabSheet;
    FontSizeImprRG: TRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    AcquisitionTS: TTabSheet;
    AcqListBox: TListBox;
    AddAcqBtn: TBitBtn;
    DelAcqBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    PermuteCB: TCheckBox;
    PrefTS: TTabSheet;
    ToutModuleBtn: TBitBtn;
    AucunBtn: TBitBtn;
    Label2: TLabel;
    MaxCopiesSE: TSpinEdit;
    MenuPermisCLB: TCheckListBox;
    GroupePathLabel: TLabel;
    GroupePathEdit: TEdit;
    GroupePathBtn: TSpeedButton;
    OptionsFichierCB: TCheckBox;
    UseMilliCB: TCheckBox;
    Label3: TLabel;
    ChiffresSignifSE: TSpinEdit;
    LissageLabel: TLabel;
    OrdreFiltrageSE: TSpinEdit;
    Label1: TLabel;
    NbreEdit: TEdit;
    NbreSpinButton: TSpinButton;
    GridPrintCB: TCheckBox;
    DataCanModifCB: TCheckBox;
    Label16: TLabel;
    GrapheTS: TTabSheet;
    TraceDefautRG: TRadioGroup;
    GrilleCB: TCheckBox;
    IncertitudeCB: TCheckBox;
    Label11: TLabel;
    Label17: TLabel;
    OrdreSplineSE: TSpinEdit;
    DimPointSE: TSpinEdit;
    OptionsBtn: TSpeedButton;
    NomColor: TColorBox;
    NonExpColor: TColorBox;
    ResultatColor: TColorBox;
    UniteColor: TColorBox;
    ExpressionColor: TColorBox;
    CommentaireColor: TColorBox;
    GraduationZeroCB: TCheckBox;
    AngleEnDegreCB: TCheckBox;
    SaveCfgAcqCB: TCheckBox;
    GraduationPiCB: TCheckBox;
    IncertitudeRG: TRadioGroup;
    TriCB: TCheckBox;
    ConstUniversBtn: TBitBtn;
    BiochimieBtn: TBitBtn;
    PhysiqueBtn: TBitBtn;
    GeneralLabel: TLabel;
    Memo1: TMemo;
    CoeffEllipseRG: TRadioGroup;
    GroupBox3: TGroupBox;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    NbreLabel: TLabel;
    NbreSE: TSpinEdit;
    ExtrapoleDerCB: TCheckBox;
    fontSizeMemoRG: TRadioGroup;
    FenetreRG: TRadioGroup;
    UseItalicCB: TCheckBox;
    UseMPCB: TCheckBox;
    Label12: TLabel;
    grapheClipRG: TRadioGroup;
    ImpMonoCB: TCheckBox;
    UniteParCB: TCheckBox;
    IncertitudeHelpBtn: TSpeedButton;
    GroupBox1: TGroupBox;
    AjustageAutoGrCB: TCheckBox;
    AjustageAutoLinCB: TCheckBox;
    UseChi2CB: TCheckBox;
    LevenbergCB: TCheckBox;
    FontDialog: TFontDialog;
    FontBtn: TSpeedButton;
    UniteSICB: TCheckBox;
    TempDirEdit: TEdit;
    TempDirBtn: TSpeedButton;
    GenerallabelBis: TLabel;
    Label14: TLabel;
    IndexRG: TRadioGroup;
    Label13: TLabel;
    DataPathEdit: TEdit;
    RepertoireDataBtn: TSpeedButton;
    RazRepDataBtn: TSpeedButton;
    ClavierAvecGrapheCB: TCheckBox;
    VideoPathEdit: TEdit;
    VideoDirBtn: TSpeedButton;
    wavpathEdit: TEdit;
    wavDirBtn: TSpeedButton;
    ImagesPathEdit: TEdit;
    ImagesDirBtn: TSpeedButton;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    RazWavDirBtn: TSpeedButton;
    RazImagesDirBtn: TSpeedButton;
    RazVideoDirBtn: TSpeedButton;
    Label20: TLabel;
    PythonPathEdit: TEdit;
    PythonDirBtn: TSpeedButton;
    RazPythonDirBtn: TSpeedButton;
    Label21: TLabel;
    PythonDllPathEdit: TEdit;
    PythonDllPathBtn: TSpeedButton;
    RazDllPythonPath: TSpeedButton;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    procedure NbreSpinButtonDownClick(Sender: TObject);
    procedure NbreSpinButtonUpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DegreRGClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure NbreEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AddAcqBtnClick(Sender: TObject);
    procedure DelAcqBtnClick(Sender: TObject);
    procedure UniteSICBClick(Sender: TObject);
    procedure ToutModuleBtnClick(Sender: TObject);
    procedure AucunBtnClick(Sender: TObject);
    procedure GroupePathBtnClick(Sender: TObject);
    procedure MenuPermisCLBClickCheck(Sender: TObject);
    procedure MenuPermisCLBClick(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure ModifGrapheClick(Sender: TObject);
    procedure ConstUniversBtnClick(Sender: TObject);
    procedure BiochimieBtnClick(Sender: TObject);
    procedure PhysiqueBtnClick(Sender: TObject);
    procedure CoeffEllipseRGClick(Sender: TObject);
    procedure SpinEditHauteurChange(Sender: TObject);
    procedure UseMPCBClick(Sender: TObject);
    procedure IncertitudeHelpBtnClick(Sender: TObject);
    procedure UseChi2CBClick(Sender: TObject);
    procedure IncertitudeCBClick(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure TempDirBtnClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure fontSizeMemoRGClick(Sender: TObject);
    procedure RazRepDataBtnClick(Sender: TObject);
    procedure RepertoireDataBtnClick(Sender: TObject);
    procedure ImagesDirBtnClick(Sender: TObject);
    procedure wavDirBtnClick(Sender: TObject);
    procedure VideoDirBtnClick(Sender: TObject);
    procedure PythonDirBtnClick(Sender: TObject);
    procedure PythonDllPathBtnClick(Sender: TObject);
  private
    configGeneraleChargee,modifConfig : boolean;
    MenuW : LongInt;
    pagePrecedente : TTabSheet;
    procedure setBoutonsAcq;
    function AjouteAcq(nomFichier : string;force : boolean) : boolean;
    Procedure LitConfigGenerale;
    procedure LitConfigUtilisateur;
    procedure initConfig;
    procedure litRepertoire(ini : TMemIniFile;stIdent : string;var repDefaut : string);
  public
    modifPreferences,modifDerivee,modifUniteSI,
    modifPolice,modifGraphe : boolean;
    procedure ResetConfig;
    procedure sauveOptions;
  end;

var
  OptionsDlg: TOptionsDlg;
  MenuPermis : TsetMenu;

implementation

uses Regmain, fft, optcolordlg, graphvar, valeurs, constante;

{$R *.DFM}

const TailleFonte : array[0..2] of integer = (10,12,14);
      imFFT = 0; // toujours
      imAcqFond = 11;
      sectionDerivee = 'Dérivée';
      identDegre = 'Degré';

var  OptionsMenuFichier : boolean;

function TOptionsDlg.AjouteAcq(nomFichier : string;force : boolean) : boolean;
var nomCourt,nomCourtBis : string;
    posEgal : integer;
    j : integer;
begin
    result := false;
    if nomFichier='' then exit;
    posEgal := pos('=',nomFichier);
    if posEgal>0 then delete(nomFichier,1,posEgal);
    nomFichier := AnsiUpperCase(nomFichier);
    nomCourt := ChangeFileExt(ExtractFileName(nomFichier),'');
    if not force then begin
       nomCourtBis := '';
       for j := 0 to AcqList.Count - 1 do begin
           nomCourtBis := ChangeFileExt(ExtractFileName(AcqList[j]),'');
           if nomCourt=nomCourtBis then break;
       end;
       if nomCourt=nomCourtBis then exit;
    end;
    result := fileExists(nomFichier) and
        (AcqList.indexOf(nomFichier)<0) and
        (nomCourt<>'CONFIGREGRESSI');
    if result then AcqList.Add(nomFichier);
end;

procedure TOptionsDlg.NbreSpinButtonDownClick(Sender: TObject);
begin
     if NbrePointDerivee>MinPointsDerivee then begin
        dec(NbrePointDerivee,2);
        ModifDerivee := true;
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TOptionsDlg.NbreSpinButtonUpClick(Sender: TObject);
begin
     if NbrePointDerivee<MaxPointsDerivee then begin
        inc(NbrePointDerivee,2);
        ModifDerivee := true;
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TOptionsDlg.FontBtnClick(Sender: TObject);
begin
    FontDialog.font.name := FontName;
    if FontDialog.execute then begin
        testEdit.font.name := FontDialog.font.name;
        FontName := FontDialog.font.name;
    end;
end;

procedure TOptionsDlg.fontSizeMemoRGClick(Sender: TObject);
begin
    ModifPolice := true;
end;

procedure TOptionsDlg.FormActivate(Sender: TObject);
var i : integer;
    nom : string;
begin
       inherited;
       indexRG.ItemIndex := ord(NonDefinieNulle);
       ClavierAvecGrapheCB.checked :=  ClavierAvecGraphe;
       FenetreRG.itemIndex := ord(dispositionFenetre);
       TriCB.Checked := DataTrieGlb;
       IncertitudeRG.itemIndex := ord(TraceIncert);
       uniteParCB.checked := UniteParenthese;
       LevenbergCB.checked := LevenbergMarquardt;
       ExtrapoleDerCB.checked := ExtrapoleDerivee;
       GridPrintCB.checked := GridPrint;
       DataCanModifCB.checked := DataCanModifiable;
       SaveCfgAcqCB.checked := SaveConfigAcq;       
       OptionsFichierCB.checked := OptionsMenuFichier;
       GraduationPiCB.checked := GraduationPi;
       NbreEdit.text := IntToStr(NbrePointDerivee);
       DegreRG.itemIndex := DegreDerivee-1;
       MaxCopiesSE.value := MaxCopiesPrinter;
       TraceDefautRG.itemIndex := ord(TraceDefaut);
       GrilleCB.checked := OgQuadrillage in OptionGrapheDefault;
       grapheClipRG.ItemIndex := ord(grapheClip);
       OrdreSplineSE.Value := OrdreLissage;
       OrdreFiltrageSE.Value := OrdreFiltrage;
       DimPointSE.Value := DimPointVGA;
       IncertitudeCB.checked := avecEllipse;
       UseChi2CB.checked := avecChi2;
       UniteSICB.checked := uniteSIglb;
       impmonocb.checked := imprimanteMonochrome;
       ModifDerivee := false;
       ModifPolice := false;
       ModifUniteSI := false;
       ModifPreferences := false;
       ModifGraphe := false;
       PermuteCB.checked := permuteColRow;
       OrdreSplineSE.Value := OrdreLissage;
       OrdreFiltrageSE.Value := OrdreFiltrage;
       UseItalicCB.checked := useItalic;
       AngleEnDegreCB.checked := angleEnDegre;       
       UseMPCB.checked := useMathPlayer;
       ChiffresSignifSE.value := precision;
       if coeffEllipse<1.1
          then CoeffEllipseRG.ItemIndex := 0
          else if coeffEllipse<2
              then CoeffEllipseRG.ItemIndex := 1
              else CoeffEllipseRG.ItemIndex := 2;
       spinEditHauteur.Value := texteGrapheSize;
       NbreSE.Value := NbreTexteMax;              
       case fontSizeMemo of
            10 : FontSizeMemoRG.itemIndex := 0;
            12 : FontSizeMemoRG.itemIndex := 1;
            14 : FontSizeMemoRG.itemIndex := 2;
            else FontSizeMemoRG.itemIndex := 1;
       end;
       case fontSizeImpr of
            10 : FontSizeImprRG.itemIndex := 0;
            12 : FontSizeImprRG.itemIndex := 1;
            else FontSizeImprRG.itemIndex := 0;
       end;
       for i := 0 to pred(menuPermisCLB.items.count) do
           menuPermisCLB.checked[i] := i in menuPermis;
       NonExpColor.selected := couleurNonExp;
       ExpressionColor.selected := couleurExp;
       GroupePathEdit.text := GroupeDir;
       tempDirEdit.text := TempDirReg;
       datapathEdit.text := DataDir;
       WavPathEdit.text := WavDir;
       VideoPathEdit.text := VideoDir;
       imagesPathEdit.text := ImagesDir;
       pythonPathEdit.text := pythonDir;
       pythonDllPathEdit.text := pythonDllDir;
       AcqListBox.clear;
       for i := 0 to pred(AcqList.count) do begin
           Nom := ChangeFileExt(ExtractFileName(AcqList[i]),'');
           AcqListBox.items.Add(Nom);
       end;
       AcquisitionTS.Visible := true;
       AcquisitionTS.Enabled := true;
       GraduationZeroCB.checked := OgZeroGradue in optionGrapheDefault;
       pageControl.activePage := calculTS;
       pagePrecedente := calculTS;
end;

procedure TOptionsDlg.DegreRGClick(Sender: TObject);
begin
      DegreDerivee := 1+DegreRG.itemIndex;
      if (degreDerivee=3) and (NbrePointDerivee<5)
         then begin
              NbrePointDerivee := 5;
              NbreEdit.Text := '5';
         end;
      ModifDerivee := true;
end;

procedure TOptionsDlg.SauveOptions;
var i : integer;
    Rini : TMemIniFile;
begin
    try
    Rini := TMemIniFile.create(NomFichierIni);
    try
    if dispositionFenetre<>dNone then
       Rini.WriteInteger(stFenetre,'Disposition',ord(dispositionFenetre));
    RIni.writeInteger(stGraphe,'Clip',ord(grapheClip));
    RIni.writeString(stGraphe,stFonte,FontName);
    Rini.WriteInteger(stPenStyle,stTangente,ord(PstyleTangente));
    Rini.WriteInteger(stColor,stTangente,pcolorTangente);
    Rini.WriteInteger(stColor,stMethTangente,CouleurMethodeTangente);
    Rini.WriteInteger(stPenStyle,stReticule,ord(PstyleReticule));
    Rini.WriteInteger(stColor,stReticule,pcolorReticule);
    Rini.WriteInteger(stColor,'FondReticule',FondReticule);
    Rini.writeInteger(sectionDerivee,'Nombre',NbrePointDerivee);
    Rini.writeBool(stCalcul,'NonDefNulle',NonDefinieNulle);
    Rini.writeBool(sectionDerivee,'Extrapole',ExtrapoleDerivee);
    Rini.WriteBool(stGraphe,stGrille,OgQuadrillage in OptionGrapheDefault);
    Rini.WriteBool(stGraphe,'ZeroIdem',OgMemeZero in OptionGrapheDefault);
    Rini.writeInteger(stCalcul,'OrdreFiltrage',OrdreFiltrage);
    Rini.WriteBool(stCalcul,'UniteSI',UniteSIglb);
    Rini.writeBool(stCalcul,'Cosinus',ModeleCosinus);
    Rini.writeBool(stGraphe,'Clavier',ClavierAvecGraphe);
    Rini.writeInteger('Point','Taille',dimPointVGA);
    Rini.writeInteger(stColor,stAxes,couleurGrille);
    Rini.writeInteger(sectionDerivee,identDegre,DegreDerivee);
    Rini.writeInteger(stGraphe,'ReperePage',ord(reperePage));
    Rini.writeInteger(stFormat,'Chiffres',Precision);
    Rini.writeInteger(stFonte,'TailleMemo',FontSizeMemo);
    Rini.writeInteger(stFonte,'TexteGraphe',TexteGrapheSize);
    Rini.writeInteger(stGraphe,'NbreTexte',NbreTexteMax);
    Rini.writeBool(stGraphe,'ZeroGradue',OgZeroGradue in OptionGrapheDefault);
    Rini.writeBool(stCalcul,'ModelePourCent',ModelePourCent);
    Rini.writeBool('CoeffCorrel','Affiche',WithCoeffCorrel);
    Rini.writeBool(stGraphe,'Pvaleur',WithPvaleur);
    Rini.writeInteger(stGraphe,'AffIncertParam',ord(AffIncertParam));
    Rini.writeBool(stGraphe,'BandeConfiance',WithBandeConfiance);
    Rini.writeBool(stGraphe,'BandePrediction',WithBandePrediction);
    Rini.writeBool(stFFT,'Optimise',NbreHarmoniqueOptimise);
    Rini.writeInteger(stFFT,'Precision',round(precisionFFT*1000));
    Rini.writeBool(stFFT,'HarmAff',HarmoniqueAff);
    Rini.writeBool(stFFT,'Periodique',FFTperiodique);
    Rini.writeBool(stGraphe,'VisuAjuste',VisualisationAjustement);
    Rini.writeBool(stGraphe,stEllipse,avecEllipse);
    Rini.writeBool(stRegressi,'Chi2',avecChi2);
    Rini.WriteBool(stRegressi,'AjusteAutoLin',AjustageAutoLinCB.checked);
    Rini.WriteBool(stRegressi,'Levenberg',LevenbergMarquardt);
    Rini.WriteBool(stRegressi,'AjusteAutoGr',AjustageAutoGrCB.checked);
    Rini.WriteBool(stRegressi,'Permute',PermuteColRow);
    Rini.WriteBool(stRegressi,'DataTrie',DataTrieGlb);
    Rini.WriteBool(stRegressi,'UnitePar',UniteParenthese);
    Rini.WriteInteger(stRegressi,'IncertRect',ord(TraceIncert));
    Rini.WriteBool(stRegressi,'GraduationPi',GraduationPi);
    Rini.WriteInteger(stGraphe,'CoeffEllipse',CoeffEllipseRG.itemIndex);
    Rini.WriteBool(stGraphe,'Rappel3',RappelTroisGraphes);
    Rini.WriteBool(stCalcul,identDegre,AngleEnDegre);
    Rini.WriteBool(stCalcul,'Decibel',ModeleDecibel);
    Rini.WriteBool(stCalcul,'Qualite',ModeleFacteurQualite);
    Rini.writeBool(stCalcul,'Cosinus',ModeleCosinus);
    Rini.WriteBool(stRegressi,'Italique',UseItalic);
    Rini.WriteBool(stRegressi,'MathPlayer',UseMathPlayer);
    Rini.writeInteger(stPrint,stFonte,FontSizeImpr);
    Rini.writeInteger(stGraphe,'WidthEcran',penWidthCourbe);
    Rini.writeInteger(stGraphe,'WidthGrid',penWidthGrid);
    Rini.writeInteger(stGraphe,'TailleTick',tailleTick);
    Rini.DeleteKey(stPrint,'Bold');
    Rini.writeBool(stRegressi,'DataModif',DataCanModifiable);
    Rini.writeBool(stRegressi,'SaveCfgAcq',SaveConfigAcq);
    Rini.EraseSection('Acquisition');
    for i := 0 to pred(AcqList.count) do
        Rini.writeString('Acquisition',IntToStr(i),AcqList[i]);
    Rini.WriteInteger(stRegressi,'Menus',LongInt(MenuPermis));
    Rini.WriteString(stRepertoire,'Groupe',GroupeDir);
    Rini.WriteString(stRepertoire,'Data',DataDir);
    Rini.WriteString(stRepertoire,'Temp',TempDirReg);
    Rini.writeString(stRepertoire,stWav,wavDir);
    Rini.writeString(stRepertoire,stAVI,VideoDir);
    Rini.writeString(stRepertoire,'Images',imagesDir);
    Rini.writeString(stRepertoire,'Python',pythonDir);
    Rini.writeString(stRepertoire,'PythonDll',pythonDllDir);
    Rini.WriteString(stFonte,'Name',FontName);
    Rini.WriteInteger(stGraphe,'TracePoint',ord(traceDefaut));
    Rini.WriteInteger(stRegressi,'LargeurColText',largeurColonneTexte);
    Rini.writeInteger(stCalcul,'NMC',NbreMC);
    for i := 0 to pred(NbreCouleur) do begin
        Rini.writeInteger(stColor,'C'+IntToStr(i),couleurPages[i]);
        Rini.writeInteger(stPenStyle,'C'+IntToStr(i),ord(stylePages[i]));
        Rini.writeInteger(stPointStyle,'C'+IntToStr(i),ord(MotifPages[i]));
    end;
    for i := 1 to MaxOrdonnee do begin
       Rini.writeInteger(stColor,'O'+IntToStr(i),couleurInit[i]);
       Rini.writeInteger(stPointStyle,'O'+IntToStr(i),ord(MotifInit[i]));
    end;
    Rini.UpdateFile;
    finally
    Rini.free;
    end;
    except
    end;
end;


procedure TOptionsDlg.OKBtnClick(Sender: TObject);
begin
     modifConfig := true;
     UniteParenthese := uniteParCB.checked;
     DataTrieGlb := TriCB.Checked;
     NonDefinieNulle := indexRG.ItemIndex=1;
     ClavierAvecGraphe := ClavierAvecGrapheCB.checked;
     FichierTrie := DataTrieGlb;
     dispositionFenetre := TdispositionFenetre(FenetreRG.itemIndex);
     TraceDefaut := TtraceDefaut(TraceDefautRG.itemIndex);
     if GraduationZeroCB.checked
        then include(optionGrapheDefault,OgZeroGradue)
        else exclude(optionGrapheDefault,OgZeroGradue);
     avecEllipse := IncertitudeCB.checked;
     DimPointVGA := DimPointSE.value;
     imprimanteMonochrome := impmonocb.checked;
     grapheClip := TgrapheClipBoard(grapheClipRG.itemIndex);
     OrdreLissage := OrdreSplineSE.Value;
     OrdreFiltrage := OrdreFiltrageSE.Value;     
     ModifDerivee := ModifDerivee or (ExtrapoleDerivee<>ExtrapoleDerCB.checked);
     ExtrapoleDerivee := ExtrapoleDerCB.checked;
     LevenbergMarquardt := LevenbergCB.checked;
     if GrilleCB.checked
         then include(OptionGrapheDefault,OgQuadrillage)
         else exclude(OptionGrapheDefault,OgQuadrillage);
     MaxCopiesPrinter := MaxCopiesSE.value;
     GraduationPi := GraduationPiCB.checked;
     DataCanModifiable := DataCanModifCB.checked;
     SaveConfigAcq := SaveCfgAcqCB.checked;
     GridPrint := GridPrintCB.checked;
     fontSizeMemo := tailleFonte[FontSizeMemoRG.itemIndex];
     TexteGrapheSize := spinEditHauteur.value;
     NbreTexteMax := NbreSE.value;
     fontSizeImpr := tailleFonte[FontSizeImprRG.itemIndex];
     precision := chiffresSignifSE.value;
     permuteColRow := PermuteCB.checked;
     UseItalic := UseItalicCB.checked;
     AngleEnDegre := AngleEnDegreCB.checked;
     UniteSIglb := UniteSICB.checked;
     UseMathPlayer := UseMPCB.checked;
     avecChi2 := UseChi2CB.checked;
     if avecChi2 then avecEllipse := true;
     couleurNonExp := NonExpColor.selected;
     couleurExp := ExpressionColor.selected;
     OrdreLissage := OrdreSplineSE.Value;
     OrdreFiltrage := OrdreFiltrageSE.Value;     
     TraceIncert := Tincertitude(IncertitudeRG.itemIndex);
     tempDirReg := tempDirEdit.text;
     dataDir := datapathEdit.text;
     wavDir := wavpathEdit.text;
     videoDir := videoPathEdit.text;
     pythonDir := pythonPathEdit.text;
     pythonDllDir := pythonDllPathEdit.text;
     if not SysUtils.DirectoryExists(TempDirReg) then TempDirReg := 'c:\Temp';
     groupeDir := groupePathEdit.text;
     removeBackSlash(groupeDir);
     case CoeffEllipseRG.ItemIndex of
         0 : coeffEllipse := 1; // 68 %
         1 : coeffEllipse := 1.96; // 95 %
         2 : coeffEllipse := 2.58; // 99 %
     end;
     try
     SauveOptions;
     except
     end;
end; // OKBtnClick

procedure TOptionsDlg.NbreEditChange(Sender: TObject);
begin
     ModifDerivee := true
end;

procedure TOptionsDlg.FormCreate(Sender: TObject);
var cheminReg : string;
    cheminReg1,cheminReg2 : string;

procedure ChercheAcq(nom : string);
var nomFichier : string;
begin
     if AcqList.count<=MaxAcq then begin
         nom := Nom+'.exe';
         nomFichier := cheminReg+Nom;
         if AjouteAcq(nomFichier,false) then exit;
         if cheminReg1<>cheminReg then begin
            nomFichier := cheminReg1+Nom;
            if AjouteAcq(nomFichier,false) then exit;
         end;
         if cheminReg2<>cheminReg then  begin
            nomFichier := cheminReg2+Nom;
            if AjouteAcq(nomFichier,false) then exit;
         end;
     end;
end;

begin
{$IFDEF Debug}
   ecritDebug('Début formCreate Options');
{$ENDIF}
  OptionsMenuFichier := false;
  ModifConfig := false;
  MenuW := High(LongInt);
  MenuPermis := TSetMenu(MenuW);
  exclude(MenuPermis,imCornish);
  exclude(MenuPermis,imEuler);
  ConfigGeneraleChargee := false;
  cheminReg := extractFilePath(paramstr(0));
  cheminReg1 := ProgramDir+'Evariste\Regressi\';
  cheminReg2 := ProgramDir+stRegressi+'\';
  initConfig;
  try
  litConfigUtilisateur;
  except
  end;
  try
  litConfigGenerale;  // prédomine
  except
// Erreur lecture regressi.ini
  end;
// vérification de l'existence du répertoire
  if (VideoDir<>'') and
     not(SysUtils.DirectoryExists(VideoDir))
        then VideoDir := '';
  if not(ConfigGeneraleChargee) or (AcqList.count=0) then begin
  // Orphy
       ChercheAcq('GTI2_GTS2');ChercheAcq('GTI2_Oscillo');
       ChercheAcq('Portab2');ChercheAcq('OrphyLab');ChercheAcq('ECaptoo');
  // autres
       ChercheAcq('RS232');ChercheAcq('ESAO3');ChercheAcq('Table');
  // spectro
       ChercheAcq('S250');ChercheAcq('CECIL');ChercheAcq('Biochrom');
       ChercheAcq('JENWAY6300');ChercheAcq('JENWAY6500');ChercheAcq('JENWAY7300');
       ChercheAcq('EasySpec');ChercheAcq('SpectroCCD');ChercheAcq('shimadzu');
 // oscillo
       ChercheAcq('Metrix');
       ChercheAcq('HM407');ChercheAcq('HM305');
       ChercheAcq('TDS200');ChercheAcq('TDS2000');
       ChercheAcq('AgilentDSO');ChercheAcq('HP54600');
 // Descartes
       ChercheAcq('WebcamIntensite');
       ChercheAcq('PhidgetForce');ChercheAcq('ieOrphy');
  end;
  GeneralLabel.Visible := ConfigGeneraleChargee;
  GeneralLabelBis.Visible := ConfigGeneraleChargee;
  ChiffresSignifSE.minValue := precisionMin;
  ChiffresSignifSE.maxValue := precisionMax;
{$IFDEF Debug}
   ecritDebug('Fin formCreate Options');
{$ENDIF}
end; // FormCreate

procedure TOptionsDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Options)
end;

procedure TOptionsDlg.ImagesDirBtnClick(Sender: TObject);
begin
     if SelectDir(ImagesDir)
        then ImagesPathEdit.text := imagesDir;
end;

procedure TOptionsDlg.IncertitudeCBClick(Sender: TObject);
begin
    ModifGraphe := true;
    usechi2CB.checked := incertitudeCB.checked;
end;

procedure TOptionsDlg.IncertitudeHelpBtnClick(Sender: TObject);
begin
   Aide(Help_Incertitudes);
end;

procedure TOptionsDlg.UseChi2CBClick(Sender: TObject);
begin
    incertitudeCB.Checked := usechi2CB.checked;
end;

procedure TOptionsDlg.UseMPCBClick(Sender: TObject);
begin
  inherited;
  modifPreferences := true;
end;

procedure TOptionsDlg.VideoDirBtnClick(Sender: TObject);
begin
     if SelectDir(VideoDir)
        then VideoPathEdit.text := videoDir;
end;

procedure TOptionsDlg.wavDirBtnClick(Sender: TObject);
begin
     if SelectDir(WavDir)
        then wavPathEdit.text := wavDir;
end;

procedure TOptionsDlg.AddAcqBtnClick(Sender: TObject);
var NomFichier : String;
    i : integer;
begin
     if OpenDialog.execute then begin
        NomFichier := AnsiUpperCase(OpenDialog.FileName);
        i := AcqList.indexOf(NomFichier);
        if i<0 then begin
             if AcqList.count=MaxAcq+1 then AcqList.delete(MaxAcq);
             AcqList.Add(NomFichier);
             AcqListBox.Items.Add(ChangeFileExt(ExtractFileName(NomFichier),''));
        end;
        setBoutonsAcq;
     end;
end;

procedure TOptionsDlg.DelAcqBtnClick(Sender: TObject);
var numero : integer;
begin
     Numero := AcqListBox.itemIndex;
     if Numero>=0 then begin
        AcqListBox.Items.Delete(Numero);
        AcqList.Delete(Numero);
        SetBoutonsAcq;
     end;
end;

procedure TOptionsDlg.SetBoutonsAcq;
begin
    AddAcqBtn.enabled := AcqList.count<=MaxAcq;
    DelAcqBtn.enabled := AcqList.count>0;
end;

procedure TOptionsDlg.UniteSICBClick(Sender: TObject);
begin
    ModifUniteSI := true
end;

procedure TOptionsDlg.TempDirBtnClick(Sender: TObject);
begin
     if SelectDir(TempDirReg)
        then TempDirEdit.text := tempDirReg;
end;

procedure TOptionsDlg.ToutModuleBtnClick(Sender: TObject);
var i : integer;
begin
     MenuW := High(LongInt);
     MenuPermis := TsetMenu(MenuW);
     for i := 0 to pred(MenuPermisCLB.items.Count) do
           MenuPermisCLB.checked[I] := true;
end;

procedure TOptionsDlg.AucunBtnClick(Sender: TObject);
var i : integer;
begin
     MenuPermis := [];
     for i := 0 to pred(MenuPermisCLB.items.Count) do
         MenuPermisCLB.checked[i] := false;
end;

procedure TOptionsDlg.GroupePathBtnClick(Sender: TObject);
begin
     if SelectDir(GroupeDir)
        then GroupePathEdit.text := groupeDir;
end;

procedure TOptionsDlg.MenuPermisCLBClickCheck(Sender: TObject);
var i : integer;
begin
     for i := 0 to pred(menuPermisCLB.items.count) do
         if menuPermisCLB.checked[i]
            then include(MenuPermis,i)
            else exclude(MenuPermis,i)
end;

procedure TOptionsDlg.MenuPermisCLBClick(Sender: TObject);
begin
     modifPreferences := true
end;

procedure TOptionsDlg.OptionsBtnClick(Sender: TObject);
begin
   OptionCouleurDlg := TOptionCouleurDlg.create(self);
   OptionCouleurDlg.DlgGraphique := nil;
   OptionCouleurDlg.ShowModal;
   OptionCouleurDlg.free;
   ModifGraphe := true;
end;

procedure TOptionsDlg.ModifGrapheClick(Sender: TObject);
begin
    ModifGraphe := true;
end;

procedure TOptionsDlg.litRepertoire(ini : TMemIniFile;stIdent : string;var repDefaut : string);
var repTampon : string;
begin
    repTampon := ini.ReadString(stRepertoire,stIdent,repDefaut);
    if repTampon<>'' then repDefaut := repTampon;
end;

Procedure TOptionsDlg.LitConfigGenerale;
var ini : TMemIniFile;
    i,z : integer;
    nomFichier : string;
begin
  nomFichier := changeFileExt(application.exeName,'.ini');
  ConfigGeneraleChargee := FileExists(NomFichier);
  if not ConfigGeneraleChargee then exit;
  ini := TMemIniFile.create(NomFichier);
  try
  SauvegardePermise := Ini.ReadBool(stSauvegarde,'Active',true);
  AvecModeleManuel := Ini.ReadBool(stModele,'Manuel',AvecModeleManuel);
  ClavierAvecGraphe := ini.readBool(stGraphe,'Clavier',true);
  GraduationZeroCB.checked := Ini.ReadBool(stGraphe,'ZeroGradue',false);
  if GraduationZeroCB.checked then include(OptionGrapheDefault,ogZeroGradue);
  ModeleCosinus := ini.ReadBool(stCalcul,'Cosinus',ModeleCosinus);
  PstyleTangente := TpenStyle(ini.ReadInteger(stPenStyle,stTangente,ord(PstyleTangente)));
  grapheClip := TgrapheClipBoard(ini.ReadInteger(stGraphe,'Clip',0));
  OrdreFiltrage := ini.ReadInteger(stCalcul,'OrdreFiltrage',OrdreFiltrage);
  CoeffEllipseRG.itemIndex := ini.ReadInteger(stGraphe,'CoeffEllipse',0);
  PcolorTangente := ini.ReadInteger(stColor,stTangente,PcolorTangente);
  CouleurMethodeTangente := ini.ReadInteger(stColor,stMethTangente,CouleurMethodeTangente);
  PstyleReticule := TpenStyle(ini.ReadInteger(stPenStyle,stReticule,ord(PstyleReticule)));
  PcolorReticule := ini.ReadInteger(stColor,stReticule,PcolorReticule);
  FondReticule := ini.ReadInteger(stColor,'FondReticule',FondReticule);
  precision := ini.ReadInteger(stFormat,'Chiffres',precision);
  modelePourCent := ini.ReadBool(stCalcul,'ModelePourCent',false);
  UniteSIglb := ini.ReadBool(stCalcul,'UniteSI',UniteSIglb);
  //Non général, option sauvée dans le fichier de données
  if precision<precisionMin then precision := precisionMin;
  if precision>precisionMax then precision := precisionMax;
  LevenbergMarquardt := ini.ReadBool(stRegressi,'Levenberg',LevenbergMarquardt);
  AngleEnDegre := ini.ReadBool(stCalcul,identDegre,AngleEnDegre);
  ModeleDecibel := ini.ReadBool(stCalcul,'Decibel',ModeleDecibel);
  ModeleFacteurQualite := ini.ReadBool(stCalcul,'Qualite',ModeleFacteurQualite);
  NbreHarmoniqueOptimise := ini.ReadBool(stFFT,'Optimise',NbreHarmoniqueOptimise);
  NbreMC := ini.ReadInteger(stCalcul,'NMC',NbreMC);
  z := ini.readInteger(stFFT,'Precision',5);
  largeurColonneTexte := ini.ReadInteger(stRegressi,'LargeurColText',largeurColonneTexte);
  if z<3 then z := 3; if z>100 then z := 100;
  precisionFFT := z/1000;
  HarmoniqueAff := ini.ReadBool(stFFT,'HarmAff',HarmoniqueAff);
  FFTperiodique := ini.readBool(stFFT,'Periodique',FFTperiodique);
  litRepertoire(ini,stAVI,VideoDir);
  litRepertoire(ini,'Data',DataDir);
  litRepertoire(ini,'Images',imagesDir);
  litRepertoire(ini,'Python',pythonDir);
  litRepertoire(ini,stWav,wavDir);
  litRepertoire(ini,'Temp',TempDirReg);
   litRepertoire(ini,'Groupe',GroupeDir);
  FontName := ini.ReadString(stFonte,'Name',FontName);
  FontName := Ini.ReadString(stGraphe,stFonte,FontName);
  DispositionFenetre := TDispositionFenetre(ini.ReadInteger(stFenetre,'Disposition',ord(DispositionFenetre)));
  NbrePointDerivee := ini.ReadInteger(sectionDerivee,'Nombre',NbrePointDerivee);
  ExtrapoleDerivee := ini.ReadBool(sectionDerivee,'Extrapole',true);
  DegreDerivee := ini.ReadInteger(sectionDerivee,identDegre,DegreDerivee);
  if degreDerivee<1 then degreDerivee := 1;
  if degreDerivee>3 then degreDerivee := 3;
  TraceDefaut := TtraceDefaut(ini.ReadInteger(stGraphe,'TracePoint',ord(TraceDefaut)));
  if ini.ReadBool(stGraphe,stGrille,true)
      then include(OptionGrapheDefault,OgQuadrillage)
      else exclude(OptionGrapheDefault,OgQuadrillage);
  if ini.ReadBool(stGraphe,'ZeroIdem',true)
      then include(OptionGrapheDefault,OgMemeZero)
      else exclude(OptionGrapheDefault,OgMemeZero);
  VisualisationAjustement := ini.ReadBool(stGraphe,'VisuAjuste',VisualisationAjustement);
  avecEllipse := ini.ReadBool(stGraphe,stEllipse,avecEllipse);
  MaxCopiesPrinter := ini.ReadInteger(stPrint,'Copies',MaxCopiesPrinter);
  GridPrint := ini.ReadBool(stPrint,stGrille,GridPrint);
  fontSizeMemo := ini.ReadInteger(stFonte,'TailleMemo',fontSizeMemo);
  TexteGrapheSize := ini.ReadInteger(stFonte,'TexteGraphe',TexteGrapheSize);
  if texteGrapheSize>8 then texteGrapheSize := 3;
  NbreTexteMax := ini.ReadInteger(stGraphe,'NbreTexte',NbreTexteMax);
  DimPointVGA := ini.ReadInteger('Point','Taille',3);
  penWidthCourbe := 1;
  penWidthGrid := ini.readInteger(stGraphe,'WidthGrid',penWidthGrid);
  tailleTick := ini.readInteger(stGraphe,'TailleTick',tailleTick);
  fontSizeImpr := ini.ReadInteger(stPrint,stFonte,fontSizeImpr);
  DataCanModifiable := ini.ReadBool(stRegressi,'DataModif',DataCanModifiable);
  SaveConfigAcq := ini.ReadBool(stRegressi,'SaveCfgAcq',SaveConfigAcq);
  avecChi2 := ini.ReadBool(stRegressi,'Chi2',avecChi2);
  avecEllipse := ini.ReadBool(stGraphe,stEllipse,avecEllipse);
  if avecChi2 then avecEllipse := true;
  TraceIncert := Tincertitude(ini.ReadInteger(stRegressi,'IncertRect',ord(TraceIncert)));
  UniteParenthese := ini.ReadBool(stRegressi,'UnitePar',UniteParenthese);
  DataTrieGlb := ini.ReadBool(stRegressi,'DataTrie',DataTrieGlb);
  GraduationPi := ini.ReadBool(stRegressi,'GraduationPi',GraduationPi);
  UseItalic := ini.ReadBool(stRegressi,'Italique',UseItalic);
  UseMathPlayer := ini.ReadBool(stRegressi,'MathPlayer',UseMathPlayer);
  RappelTroisGraphes := ini.ReadBool(stGraphe,'Rappel3',RappelTroisGraphes);
  couleurExp := Ini.ReadInteger(stColor,'Exp.',couleurExp);
  WithCoeffCorrel := Ini.ReadBool('CoeffCorrel','Affiche',WithCoeffCorrel);
  WithPvaleur := Ini.ReadBool(stGraphe,'Pvaleur',WithPvaleur);
  AffIncertParam := TAffIncertParam(Ini.readInteger(stGraphe,'AffIncertParam',ord(i95)));
  ReperePage := TreperePage(Ini.ReadInteger(stGraphe,'ReperePage',ord(SPcouleur)));
  WithBandeConfiance := Ini.ReadBool(stGraphe,'BandeConfiance',false);
  WithBandePrediction := Ini.ReadBool(stGraphe,'BandePrediction',false);
  couleurNonExp :=  Ini.ReadInteger(stColor,'NonExp',couleurNonExp);
  TraceDefaut := TTraceDefaut(Ini.ReadInteger(stGraphe,'TracePoint',ord(traceDefaut)));
  for i := 0 to pred(NbreCouleur) do begin
      couleurPages[i] := Ini.ReadInteger(stColor,'C'+IntToStr(i),couleurPages[i]);
      stylePages[i] := TpenStyle(Ini.ReadInteger(stPenStyle,'C'+IntToStr(i),ord(stylePages[i])));
      MotifPages[i] := Tmotif(Ini.ReadInteger(stPointStyle,'C'+IntToStr(i),ord(MotifPages[i])));
  end;
  for i := 1 to MaxOrdonnee do begin
      couleurInit[i] := Ini.ReadInteger(stColor,'O'+IntToStr(i),couleurInit[i]);
      MotifInit[i] := Tmotif(Ini.ReadInteger(stPointStyle,'O'+IntToStr(i),ord(MotifInit[i])));
  end;
  for i := 1 to MaxIntervalles do begin
      couleurModele[i] := Ini.ReadInteger(stColor,'M'+IntToStr(i),couleurModele[i]);
      couleurModele[-i] := Ini.ReadInteger(stColor,'S'+IntToStr(i),couleurModele[-i]);
  end;
  couleurGrille := Ini.ReadInteger(stColor,stAxes,couleurGrille);
  finally
  ini.free;
  end;
end; // litConfigGenerale

procedure TOptionsDlg.LitConfigUtilisateur;
var Rini : TMemIniFile;
    z : integer;
begin
  try
  Rini := TMemIniFile.create(NomFichierIni);
  try
  grapheClip := TgrapheClipBoard(Rini.ReadInteger(stGraphe,'Clip',0));
  ModeleCosinus := Rini.ReadBool(stCalcul,'Cosinus',ModeleCosinus);
  NonDefinieNulle := Rini.ReadBool(stCalcul,'NonDefNulle',NonDefinieNulle);
  ClavierAvecGraphe := Rini.readBool(stGraphe,'Clavier',ClavierAvecGraphe);
  PstyleTangente := TpenStyle(Rini.ReadInteger(stPenStyle,stTangente,ps_Dot));
  PcolorTangente := Rini.ReadInteger(stColor,stTangente,clBlack);
  PstyleReticule := TpenStyle(Rini.ReadInteger(stPenStyle,stReticule,ord(PstyleReticule)));
  PcolorReticule := Rini.ReadInteger(stColor,stReticule,pColorReticule);
  FondReticule := Rini.ReadInteger(stColor,'FondReticule',clInfoBk);
  OrdreFiltrage := Rini.ReadInteger(stCalcul,'OrdreFiltrage',OrdreFiltrage);
  CoeffEllipseRG.itemIndex := Rini.ReadInteger(stGraphe,'CoeffEllipse',0);
  ModelePourCent := Rini.readBool(stCalcul,'ModelePourCent',ModelePourCent);
  UniteSIglb := Rini.ReadBool(stCalcul,'UniteSI',UniteSIglb);
  GraduationZeroCB.checked := Rini.ReadBool(stGraphe,'ZeroGradue',ogZeroGradue in OptionGrapheDefault);
  if GraduationZeroCB.checked then
     include(OptionGrapheDefault,ogZeroGradue);
  LevenbergMarquardt := Rini.ReadBool(stRegressi,'Levenberg',false);
  if Rini.ReadBool(stGraphe,stGrille,true)
      then include(OptionGrapheDefault,OgQuadrillage)
      else exclude(OptionGrapheDefault,OgQuadrillage);
  if Rini.ReadBool(stGraphe,'ZeroIdem',true)
      then include(OptionGrapheDefault,OgMemeZero)
      else exclude(OptionGrapheDefault,OgMemeZero);
  DispositionFenetre := TDispositionFenetre(Rini.ReadInteger(stFenetre,
                  'Disposition',ord(DispositionFenetre)));
  AngleEnDegre := Rini.ReadBool(stCalcul,identDegre,true);
  ModeleDecibel := Rini.ReadBool(stCalcul,'Decibel',false);
  ModeleFacteurQualite := Rini.ReadBool(stCalcul,'Qualite',true);
  ExtrapoleDerivee := Rini.ReadBool(sectionDerivee,'Extrapole',true);
  NbreHarmoniqueOptimise := Rini.ReadBool(stFFT,'Optimise',false);
  HarmoniqueAff := Rini.ReadBool(stFFT,'HarmAff',HarmoniqueAff);
  FFTperiodique := Rini.readBool(stFFT,'Periodique',FFTperiodique);
  z := Rini.readInteger(stFFT,'Precision',5);
  if z<3 then z := 3; if z>100 then z := 100;
  precisionFFT := z/1000;
  DimPointVGA := Rini.ReadInteger('Point','Taille',3);
  DataTrieGlb := Rini.ReadBool(stRegressi,'DataTrie',false);
  TraceIncert := Tincertitude(Rini.ReadInteger(stRegressi,'IncertRect',ord(TraceIncert)));
  UniteParenthese := Rini.ReadBool(stRegressi,'UnitePar',UniteParenthese);
  VisualisationAjustement := Rini.ReadBool(stGraphe,'VisuAjuste',false);
  fontSizeImpr := Rini.ReadInteger(stPrint,stFonte,10);
  couleurExp := Rini.ReadInteger(stColor,'Exp.',couleurExp);
  fontSizeImpr := 2*(fontSizeImpr div 2);
  penWidthCourbe := 1;
  penWidthGrid := Rini.readInteger(stGraphe,'WidthGrid',1);
  tailleTick := Rini.readInteger(stGraphe,'TailleTick',1);
  if (fontSizeImpr<8) or (fontSizeImpr>12) then fontSizeImpr := 10;
  Precision := Rini.ReadInteger(stFormat,'Chiffres',4);
  if precision<precisionMin then precision := precisionMin;
  if precision>precisionMax then precision := precisionMax;
  NbrePointDerivee := Rini.ReadInteger(sectionDerivee,'Nombre',5);
  DegreDerivee := Rini.ReadInteger(sectionDerivee,identDegre,2);
  if degreDerivee<1 then degreDerivee := 1;
  if degreDerivee>3 then degreDerivee := 3;
  NbreMC := Rini.ReadInteger(stCalcul,'NMC',NbreMC);
  TraceDefaut := TTraceDefaut(Rini.ReadInteger(stGraphe,'TracePoint',ord(tdPoint)));
  AjustageAutoLinCB.checked := Rini.ReadBool(stRegressi,'AjusteAutoLin',true);
  AjustageAutoGrCB.checked := Rini.ReadBool(stRegressi,'AjusteAutoGr',false);
  GraduationPi := Rini.ReadBool(stRegressi,'GraduationPi',true);
  WithCoeffCorrel := Rini.ReadBool('CoeffCorrel','Affiche',false);
  WithPvaleur := Rini.ReadBool(stGraphe,'Pvaleur',false);
  AffIncertParam := TAffIncertParam(Rini.readInteger(stGraphe,'AffIncertParam',ord(i95)));
  WithBandeConfiance := Rini.ReadBool(stGraphe,'BandeConfiance',false);
  WithBandePrediction := Rini.ReadBool(stGraphe,'BandePrediction',false);
  DataCanModifiable := Rini.ReadBool(stRegressi,'DataModif',false);
  SaveConfigAcq := Rini.ReadBool(stRegressi,'SaveCfgAcq',true);
  PermuteColRow := Rini.ReadBool(stRegressi,'Permute',false);
  avecEllipse := Rini.ReadBool(stGraphe,stEllipse,false);
  UseItalic := Rini.ReadBool(stRegressi,'Italique',false);
  UseMathPlayer := Rini.ReadBool(stRegressi,'MathPlayer',true);
  RappelTroisGraphes := Rini.ReadBool(stGraphe,'Rappel3',false);
  FontName := RIni.ReadString(stGraphe,stFonte,FontName);
  avecChi2 := Rini.ReadBool(stRegressi,'Chi2',false);
  if avecChi2 then avecEllipse := true;
  fontSizeMemo := Rini.ReadInteger(stFonte,'TailleMemo',12);
  reperePage := TreperePage(Rini.ReadInteger(stGraphe,'ReperePage',ord(SPcouleur)));
  TexteGrapheSize := Rini.ReadInteger(stFonte,'TexteGraphe',3);
  NbreTexteMax := Rini.ReadInteger(stGraphe,'NbreTexte',NbreTexteMax);
  MaxCopiesPrinter := Rini.ReadInteger(stPrint,'Copies',1);
  GridPrint := Rini.ReadBool(stPrint,stGrille,false);
  litRepertoire(Rini,stAVI,videoDir);
  litRepertoire(Rini,'Temp',TempDirReg);
  litRepertoire(Rini,stWav,wavDir);
  litRepertoire(Rini,'Images',ImagesDir);
  litRepertoire(Rini,'Python',pythonDir);
  litRepertoire(Rini,'PythonDll',pythonDllDir);
  litRepertoire(Rini,'Data',DataDir);
  litRepertoire(Rini,'Groupe',groupeDir);
  FontName := Rini.ReadString(stFonte,'Name',FontName);
  couleurNonExp := Rini.ReadInteger(stColor,'NonExp',couleurNonExp);
  largeurColonneTexte := Rini.ReadInteger(stRegressi,'LargeurColText',largeurColonneTexte);
  finally
  Rini.Free;
  end;
  except
  end;
end; // LitConfigUtilisateur

procedure TOptionsDlg.InitConfig;
var Rini : TIniFile;
    i : integer;
    acqGene : Tstrings;
    nomFichier  : string;
begin
  nomFichier := changeFileExt(application.exeName,'.ini');
  ConfigGeneraleChargee := FileExists(NomFichier);
  if ConfigGeneraleChargee
     then Rini := TIniFile.create(NomFichier)
     else Rini := TIniFile.create(NomFichierIni);
  try
     MenuW := High(LongInt);
     MenuW := Rini.ReadInteger(stRegressi,'Menus',MenuW);
     MenuPermis := TSetMenu(menuW);
     AcqList.clear;
     acqGene := TstringList.Create;
     Rini.ReadSectionValues('Acquisition',AcqGene);
     for i := 0 to pred(AcqGene.count) do
         AjouteAcq(acqGene.Strings[i],true);
     acqGene.free;
  finally
  Rini.Free;
  end;
end; // InitConfig

procedure TOptionsDlg.RazRepDataBtnClick(Sender: TObject);
begin
     if sender=RazRepDataBtn then begin
        DataDir := MesDocsDir;
        DataPathEdit.Text := DataDir;
     end;
     if sender=RazVideoDirBtn then begin
        VideoDir := GetFolder(CSIDL_MyVideo);
        VideoPathEdit.Text := VideoDir;
     end;
     if sender=RazWavDirBtn then begin
        WavDir := GetFolder(CSIDL_MYMUSIC);
        WavPathEdit.Text := WavDir;
     end;
     if sender=RazImagesDirBtn then begin
        ImagesDir := GetFolder(CSIDL_MYPICTURES);
        ImagesPathEdit.Text := ImagesDir;
     end;
     if sender=RazPythonDirBtn then begin
        PythonDir := mesDocsDir;
        PythonPathEdit.Text := PythonDir;
     end;
     if sender=RazDLLPythonPath then begin
        PythonDllDir := '';
        PythonDllPathEdit.Text := PythonDllDir
     end;
end;

procedure TOptionsDlg.RepertoireDataBtnClick(Sender: TObject);
begin
     if SelectDir(DataDir)
        then DataPathEdit.text := DataDir;
end;

Procedure TOptionsDlg.ResetConfig;
begin
    if not ModifConfig then if configGeneraleChargee
       then litConfigGenerale
       else litConfigUtilisateur;
end;

procedure TOptionsDlg.ConstUniversBtnClick(Sender: TObject);
begin
  ConstanteUnivDlg.showModal
end;

procedure TOptionsDlg.BiochimieBtnClick(Sender: TObject);
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

procedure TOptionsDlg.PhysiqueBtnClick(Sender: TObject);
var i : integer;
begin
  ToutModuleBtnClick(Sender);
  exclude(MenuPermis,imCornish);
  for i := 0 to pred(menuPermisCLB.items.count) do
      menuPermisCLB.checked[i] := i in menuPermis;
end;

procedure TOptionsDlg.PythonDirBtnClick(Sender: TObject);
begin
     if SelectDir(PythonDir)
        then PythonPathEdit.text := pythonDir;
end;

procedure TOptionsDlg.PythonDllPathBtnClick(Sender: TObject);
begin
  if SelectDir(PythonDllDir)
        then PythonDllPathEdit.text := pythonDllDir;
end;

procedure TOptionsDlg.PageControlChange(Sender: TObject);
begin
       PagePrecedente := Pagecontrol.ActivePage;
end;

procedure TOptionsDlg.CoeffEllipseRGClick(Sender: TObject);
begin
     case CoeffEllipseRG.ItemIndex of
         0 : coeffEllipse := 1; // 68 %
         1 : coeffEllipse := 1.96; // 95 %
         2 : coeffEllipse := 2.58; // 99 %
     end;
end;

procedure TOptionsDlg.SpinEditHauteurChange(Sender: TObject);
begin
  modifGraphe := true;
end;

end.


