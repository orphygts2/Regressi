unit optfft;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, ComCtrls, Math,
  Vcl.htmlHelpViewer,
  maths, regutil,  fft, compile, graphker, selpage, aidekey, Vcl.Mask;

type
  TOptionsFFTDlg = class(TForm)
    PanelBoutons: TPanel;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    BtnHelp: TBitBtn;
    PanelOptions: TPanel;
    PageControl: TPageControl;
    AbscisseTS: TTabSheet;
    CalculTS: TTabSheet;
    FenetreRadioG: TRadioGroup;
    OrdonneeTS: TTabSheet;
    SpinMindB: TSpinButton;
    EditMindB: TEdit;
    LabeldB: TLabel;
    OrdonneeRG: TRadioGroup;
    SuperpositionTS: TTabSheet;
    SuperPagesCB: TCheckBox;
    AnalyseurCB: TCheckBox;
    PagesBtn: TSpeedButton;
    FreqReduiteCB: TCheckBox;
    LabelNomTemps: TLabel;
    OptimiseNbreHarmCB: TCheckBox;
    HarmMinSE: TSpinEdit;
    Label4: TLabel;
    DecalageSE: TSpinEdit;
    Label2: TLabel;
    DecibelCB: TCheckBox;
    EnveloppeCB: TCheckBox;
    ContinuCB: TCheckBox;
    NbreRaiesEdit: TLabeledEdit;
    NbreRaiesUD: TUpDown;
    HarmoniqueAffCB: TCheckBox;
    LabelWidth: TLabel;
    WidthEcranSE: TSpinEdit;
    ReglePeriodeCB: TCheckBox;
    ListeVariableBox: TListBox;
    GrandeurBtn: TBitBtn;
    AjusteRectangleRG: TRadioGroup;
    OptionsBtn: TSpeedButton;
    Label12: TLabel;
    periodiqueCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
    procedure SpinMindBDownClick(Sender: TObject);
    procedure SpinMindBUpClick(Sender: TObject);
    procedure dBCheckBoxClick(Sender: TObject);
    procedure PagesBtnClick(Sender: TObject);
    procedure SuperPagesCBClick(Sender: TObject);
    procedure EditHarmoniqueKeyPress(Sender: TObject; var Key: Char);
    procedure GrandeurFreqBtn(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
  private
    procedure MajdB(down  : boolean);
  public
    MiniDecibel : double;
    OrdonneeFFT : TordonneeFFT;
  end;

var
  OptionsFFTDlg : TOptionsFFTDlg;

implementation

uses Graphfft, modif, optcolordlg, regmain;

{$R *.DFM}

procedure TOptionsFFTDlg.FormActivate(Sender: TObject);
var i : integer;
begin
     inherited;
     FenetreRadioG.itemIndex := ord(Fenetre);
     HarmMinSE.value := round(PrecisionFFT*1000);
     DecalageSE.value := decalageFFT;
     OptimiseNbreHarmCB.Checked := NbreHarmoniqueOptimise;
     NbreRaiesUD.Position := NbreHarmoniqueAff;
     HarmoniqueAffCB.checked := HarmoniqueAff;
     i := round(20*log10(MiniDecibel));
     EditMindB.text := IntToStr(i);
     LabelNomTemps.caption := 'Grandeur inverse de '+grandeurs[indexTri].nom+' : ' ;
     GrandeurBtn.caption := grandeurs[cFrequence].nom;
     EnveloppeCB.checked := FgrapheFFT.enveloppeSpectre;
     ordonneeRG.itemIndex := ord(ordonneeFFT);
     LabeldB.visible := DecibelCB.checked;
     EditMindB.visible := LabeldB.visible;
     SpinMindB.visible := LabeldB.visible;
     widthEcranSE.value := penWidthCourbe;
     reglePeriodeCB.checked := avecReglagePeriode;
     AnalyseurCB.checked := OgAnalyseurLogique in FgrapheFFT.GrapheFrequence.OptionGraphe;
     ajusteRectangleRG.itemIndex := ord(zeroPaddingPermis);
//     sincCB.checked := sincPermis;
     periodiqueCB.checked := FFTperiodique;
     ListeVariableBox.upDate;
end;

procedure TOptionsFFTDlg.BtnOKClick(Sender: TObject);
begin with FgrapheFFT,grapheFrequence do begin
    NbreHarmoniqueAff := NbreRaiesUD.Position;
    HarmoniqueAff := HarmoniqueAffCB.checked;
    NbreHarmoniqueOptimise := OptimiseNbreHarmCB.Checked;
    PrecisionFFT := HarmMinSE.value/1000;
    Fenetre := Tfenetre(FenetreRadioG.itemIndex);
    zeroPaddingPermis := ajusteRectangleRG.itemIndex=1;
//    Grandeurs[cFrequence].nom := editNomFrequence.text;
//    Grandeurs[cFrequence].formatU := grandeurs[indexTri].formatU;
//    Grandeurs[cFrequence].precisionU := grandeurs[indexTri].precisionU;
    EnveloppeSpectre := enveloppeCB.checked;
    OrdonneeFFT := TordonneeFFT(ordonneeRG.itemIndex);
    DecalageFFT := decalageSE.value;
    penWidthCourbe := widthEcranSE.value;
    avecReglagePeriode := reglePeriodeCB.checked;
    FFTperiodique := periodiqueCB.checked;
//    sincPermis := sincCB.checked;
    if decibelCB.checked
        then DecadeDB := DecadeSE.value
        else DecadeDB := 0;
    if AnalyseurCB.checked
         then begin
            include(OptionGraphe,OgAnalyseurLogique);
            include(grapheTemps.OptionGraphe,OgAnalyseurLogique)
         end
         else begin
            exclude(OptionGraphe,OgAnalyseurLogique);
            exclude(grapheTemps.OptionGraphe,OgAnalyseurLogique);
         end;
end end;

procedure TOptionsFFTDlg.BtnHelpClick(Sender: TObject);
begin
     aide(HELP_OptionsFourier)
end;

procedure TOptionsFFTDlg.MajdB(down  : boolean);
var N : integer;
begin
     N := StrToInt(EditMindB.Text);
     if down
        then begin if N>-200 then dec(N,10) end
        else begin if N<200 then inc(N,10) end;
     EditMindB.Text := IntToStr(N);
     MiniDecibel := power(10,N/20.0);
end;

procedure TOptionsFFTDlg.OptionsBtnClick(Sender: TObject);
begin
   OptionCouleurDlg := TOptionCouleurDlg.create(self);
   OptionCouleurDlg.DlgGraphique := nil;
   OptionCouleurDlg.ShowModal;
   OptionCouleurDlg.free;
end;

procedure TOptionsFFTDlg.GrandeurFreqBtn(Sender: TObject);
begin  // modif du nom, de l'unité et du format
     modifDlg := TmodifDlg.create(self);
     modifDlg.index := cFrequence;
     if modifDlg.showModal=mrOK then
end;

procedure TOptionsFFTDlg.SpinMindBDownClick(Sender: TObject);
begin
    MajdB(true)
end;

procedure TOptionsFFTDlg.SpinMindBUpClick(Sender: TObject);
begin
     MajdB(false)
end;

procedure TOptionsFFTDlg.dBCheckBoxClick(Sender: TObject);
begin
     LabeldB.visible := decibelCB.checked;
     EditMindB.visible := LabeldB.visible;
     SpinMindB.visible := LabeldB.visible;
end;

procedure TOptionsFFTDlg.PagesBtnClick(Sender: TObject);
begin
     if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
     SelectPageDlg.appelPrint := false;
     SelectPageDlg.caption := 'Choix des pages affichées sur le graphe';
     SelectPageDlg.showModal
end;

procedure TOptionsFFTDlg.SuperPagesCBClick(Sender: TObject);
begin
   PagesBtn.visible := SuperPagesCB.checked
end;

procedure TOptionsFFTDlg.EditHarmoniqueKeyPress(Sender: TObject;
  var Key: Char);
begin
   verifKeyGetInt(key)
end;

end.
