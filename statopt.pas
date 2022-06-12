unit statopt;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls,
  vcl.HtmlHelpViewer,
  constreg, regutil, compile, aidekey;

type
  TStatOptDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    ClasseGroupe: TRadioGroup;
    NombreSpin: TSpinEdit;
    LabelNombre: TLabel;
    LabelAmplitude: TLabel;
    EditAmplitude: TEdit;
    EditCible: TEdit;
    CibleCB: TCheckBox;
    NomGroupe: TGroupBox;
    ListeGr: TListBox;
    LabelDebut: TLabel;
    EditDebut: TEdit;
    GrapheGB: TGroupBox;
    int2SigmaCB: TCheckBox;
    int3SigmaCB: TCheckBox;
    t95CB: TCheckBox;
    t99CB: TCheckBox;
    CourbeGaussCB: TCheckBox;
    DistributionCB: TCheckBox;
    MedianeCB: TCheckBox;
    MoyenneCB: TCheckBox;
    CourbePoissonCB: TCheckBox;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    EffectifGB: TGroupBox;
    EffectifCB: TComboBox;
    GrilleCB: TCheckBox;
    CourbeBinomeCB: TCheckBox;
    Int1SigmaCB: TCheckBox;
    SuperPagesCB: TCheckBox;
    procedure ClasseGroupeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
     procedure setLabel;
     procedure resetListe;
  public
     NomStat,NomEffectif : string;
  end;

var
  StatOptDlg: TStatOptDlg;

implementation

{$R *.DFM}

Procedure TstatOptDlg.setLabel;
begin
     EditCible.visible := cibleCB.checked;
     LabelNombre.visible := false;
     LabelAmplitude.visible := false;
     EditAmplitude.visible := false;
     LabelDebut.visible := false;
     EditDebut.visible := false;
     NombreSpin.visible := false;
     EffectifGB.visible := false;
     case ClasseGroupe.ItemIndex of
          0 : ;
          1 : begin
             NombreSpin.visible := true;
             LabelNombre.visible := true;
          end;
          2 : begin
             LabelAmplitude.visible := true;
             EditAmplitude.visible := true;
             LabelDebut.visible := true;
             EditDebut.visible := true;
          end;
          3 : begin
             EffectifGB.visible := true;
             EffectifGB.caption := 'Effectif';
          end;
          4 : begin
             EffectifGB.visible := true;
             EffectifGB.caption := 'Fréquence';
          end;
     end;
end;

procedure TStatOptDlg.ClasseGroupeClick(Sender: TObject);
begin
     ResetListe;
     SetLabel
end;

procedure TStatOptDlg.FormActivate(Sender: TObject);
var i : integer;
begin
     inherited;
     ListeGr.Items.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then ListeGr.Items.add(nom);
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=constante then ListeGr.Items.add(nom);
     for i := 1 to NbreParam[ParamNormal] do with parametres[paramNormal,i] do
         ListeGr.Items.add(nom);
     listeGr.itemIndex := listeGr.items.indexOf(NomStat);
     if listeGr.itemIndex<0 then listeGr.itemIndex := 1;
     EffectifCB.Items.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then EffectifCB.Items.add(nom);
     EffectifCB.itemIndex := effectifCB.items.indexOf(NomEffectif);
     setLabel;
end;

procedure TStatOptDlg.ResetListe;
var i : integer;
begin
     ListeGr.Items.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then ListeGr.Items.add(nom);
     if ClasseGroupe.itemIndex<3 then begin
        for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
            if genreG=constante then ListeGr.Items.add(nom);
        for i := 1 to NbreParam[ParamNormal] do
            ListeGr.Items.add(parametres[paramNormal,i].nom);
     end;       
     listeGr.itemIndex := listeGr.items.indexOf(NomStat);
     if listeGr.itemIndex<0 then listeGr.itemIndex := 1;
end;

procedure TStatOptDlg.OKBtnClick(Sender: TObject);
begin
     if listeGr.itemIndex<0 then listeGr.itemIndex := 1;
     NomStat := listeGr.items[listeGr.itemIndex];
     if effectifCB.itemIndex<0 then effectifCB.itemIndex := 0;
     NomEffectif := EffectifCB.items[effectifCB.itemIndex];
end;

procedure TStatOptDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_OptionsStatistique)
end;

end.
