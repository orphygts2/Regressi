unit optModele;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls, SysUtils, Dialogs, ComCtrls, ImgList,
  Vcl.htmlHelpViewer,
  constreg, regutil, compile, graphker, options, selpage, aidekey;

type
  TOptionModeleDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PageControl: TPageControl;
    TabSheet2: TTabSheet;
    Chi2CB: TCheckBox;
    LevenbergCB: TCheckBox;
    RecuitCB: TCheckBox;
    TabSheet1: TTabSheet;
    UnitParamCB: TCheckBox;
    AjusteOrigineCB: TCheckBox;
    GroupBox1: TGroupBox;
    AfficheCorrel: TCheckBox;
    LabelCorrel: TLabel;
    ChiffreCorrelSE: TSpinEdit;
    EchelleModeleCB: TCheckBox;
    ExtrapoleModeleCB: TCheckBox;
    IncertitudeCB: TCheckBox;
    VisuAjusteCB: TCheckBox;
    BandeConfianceCB: TCheckBox;
    AffichePvaleur: TCheckBox;
    OptionCouleursBtn: TSpeedButton;
    ModelePagesIndependantesCB: TCheckBox;
    ModeleManuelCB: TCheckBox;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    ColorBox1: TColorBox;
    Label12: TLabel;
    ColorBox8: TColorBox;
    Label6: TLabel;
    ColorBox7: TColorBox;
    Label13: TLabel;
    ColorBox6: TColorBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    IncertitudeHelpBtn: TSpeedButton;
    IncertParamRG: TRadioGroup;
    ModelePourCentCB: TCheckBox;
    BandePredictionCB: TCheckBox;
    ChiffreSignifRG: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure AfficheCorrelClick(Sender: TObject);
    procedure OptionCouleursBtnClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure IncertitudeHelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    DlgGraphique : TgrapheReg;
  end;

var
  OptionModeleDlg: TOptionModeleDlg;

implementation

uses optcolordlg;

{$R *.DFM}

procedure TOptionModeleDlg.FormActivate(Sender: TObject);
var i,j : integer;
begin
     inherited;
     EchelleModeleCB.checked := OmEchelle in DlgGraphique.optionModele;
     ExtrapoleModeleCB.checked := OmExtrapole in DlgGraphique.optionModele;
     IncertitudeCB.checked := avecEllipse;
     ajusteOrigineCB.Checked := ajusteOrigine;
     AfficheCorrel.checked := withCoeffCorrel;
     AffichePvaleur.checked := withPvaleur;
     BandeConfianceCB.checked := withBandeConfiance;
     BandePredictionCB.checked := withBandePrediction;
     ChiffreCorrelSE.value := PrecisionCorrel;
     LevenbergCB.checked := LevenbergMarquardt;
     UnitParamCB.checked := ChercheUniteParam;
     VisuAjusteCB.checked := VisualisationAjustement;     
     RecuitCB.checked := Recuit;
     chi2CB.visible := (imLycee in menuPermis);
     chi2CB.checked := avecChi2 and chi2CB.visible;
     modelePourCentCB.Checked := modelePourCent;
     modeleManuelCB.checked := avecModeleManuel;
     incertParamRG.itemIndex := ord(AffIncertParam);
     chiffreSignifRG.itemIndex := ord(ChiffreSignif);
     with TabSheet3 do
        for i := 0 to pred(controlCount) do
           if controls[i] is TcolorBox then begin
              j := TcolorBox(controls[i]).tag;
              TcolorBox(controls[i]).selected := couleurModele[j];
           end;
end;

procedure TOptionModeleDlg.FormCreate(Sender: TObject);
begin
   ResizeButtonImagesforHighDPI(self);
end;

procedure TOptionModeleDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_OptionsdeModelisation)
end;

procedure TOptionModeleDlg.IncertitudeHelpBtnClick(Sender: TObject);
begin
    Aide(Help_Incertitudes);
end;

procedure TOptionModeleDlg.OKBtnClick(Sender: TObject);
begin
    if EchelleModeleCB.checked
        then include(DlgGraphique.OptionModele,OmEchelle)
        else exclude(DlgGraphique.OptionModele,OmEchelle);
    if ExtrapoleModeleCB.checked
        then include(DlgGraphique.OptionModele,OmExtrapole)
        else exclude(DlgGraphique.OptionModele,OmExtrapole);
    avecEllipse := IncertitudeCB.checked;
    VisualisationAjustement := VisuAjusteCB.checked;
    withCoeffCorrel := AfficheCorrel.checked;
    withPvaleur := AffichePvaleur.checked;
    withBandeConfiance := BandeConfianceCB.checked;
    withBandePrediction := BandePredictionCB.checked;
    PrecisionCorrel := ChiffreCorrelSE.value;
    avecChi2 := chi2CB.checked;
    if avecChi2 then avecEllipse := true;
    LevenbergMarquardt := LevenbergCB.checked;
    Recuit := RecuitCB.checked;
    ChercheUniteParam := UnitparamCB.checked;
    modelePourCent := modelePourCentCB.checked;
    ajusteOrigine := ajusteOrigineCB.Checked;
    avecModeleManuel := modeleManuelCB.checked;
    AffIncertParam := TAffIncertParam(incertParamRG.itemIndex);
    ChiffreSignif := TChiffreSignif(chiffreSignifRG.itemIndex)
end;

procedure TOptionModeleDlg.AfficheCorrelClick(Sender: TObject);
begin
  inherited;
  ChiffreCorrelSE.visible := AfficheCorrel.Checked;
  LabelCorrel.visible := AfficheCorrel.Checked;
end;

procedure TOptionModeleDlg.OptionCouleursBtnClick(Sender: TObject);
begin
   OptionCouleurDlg := TOptionCouleurDlg.create(self);
   OptionCouleurDlg.DlgGraphique := nil;
   OptionCouleurDlg.ShowModal;
   OptionCouleurDlg.free;
end;

procedure TOptionModeleDlg.ColorBox1Change(Sender: TObject);
begin
     with sender as TcolorBox do
        CouleurModele[tag] := selected
end;

end.
