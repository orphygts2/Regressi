unit cornopt;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls,
  Vcl.htmlHelpViewer,
  constreg, regUtil, compile, aidekey;

type
  TCornishOptDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    ClasseGroupe: TRadioGroup;
    NombreSpin: TSpinEdit;
    LabelNombre: TLabel;
    EditCibleK: TEdit;
    CibleCB: TCheckBox;
    NomGroupe: TGroupBox;
    ConcentrationListe: TListBox;
    GroupBox1: TGroupBox;
    int2SigmaCB: TCheckBox;
    int3SigmaCB: TCheckBox;
    t95CB: TCheckBox;
    t99CB: TCheckBox;
    GroupBox2: TGroupBox;
    VitesseListe: TListBox;
    MoyenneCB: TCheckBox;
    MedianeCB: TCheckBox;
    EditCibleV: TEdit;
    LabelCibleK: TLabel;
    LabelCibleV: TLabel;
    procedure ClasseGroupeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure Modif(Sender: TObject);
  private
     procedure setLabel;
  public
     modifCoord : boolean;
     procedure SetVitesseConcentration(const V,C : string);
  end;

var
  CornishOptDlg: TCornishOptDlg;

implementation

{$R *.DFM}

Procedure TCornishOptDlg.setLabel;
begin
     EditCibleK.visible := cibleCB.checked;
     LabelCibleK.visible := cibleCB.checked;
     EditCibleV.visible := cibleCB.checked;
     LabelCibleV.visible := cibleCB.checked;
     LabelNombre.visible := false;
     NombreSpin.visible := false;
     case ClasseGroupe.ItemIndex of
          0 : ;
          1 : begin
             NombreSpin.visible := true;
             LabelNombre.visible := true;
          end;
          2 : begin
          end;
     end;
end;

procedure TCornishOptDlg.ClasseGroupeClick(Sender: TObject);
begin
     SetLabel
end;

procedure TCornishOptDlg.FormActivate(Sender: TObject);
begin
     inherited;
     modifCoord := false;
     setLabel;
end;

procedure TCornishOptDlg.SetVitesseConcentration(const V,C : string);
var i : integer;
begin
     ConcentrationListe.Items.Clear;
     VitesseListe.Items.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then begin
             ConcentrationListe.Items.add(nom);
             if nom=C then ConcentrationListe.itemIndex := i;
             VitesseListe.Items.add(nom);
             if nom=V then VitesseListe.itemIndex := i;
         end;
     if ConcentrationListe.itemIndex<0
        then ConcentrationListe.itemIndex := 0;
     if VitesseListe.itemIndex<0
        then VitesseListe.itemIndex := 1;
end;

procedure TCornishOptDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_MethodedeCornishBowden)
end;

procedure TCornishOptDlg.Modif(Sender: TObject);
begin
     ModifCoord := true
end;

end.
