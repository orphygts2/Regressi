unit choixtang;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, sysUtils,
  regutil, maths, compile, graphker, ExtCtrls, ComCtrls;

type
  TChoixTangenteDlg = class(TForm)
    CancelBtn: TBitBtn;
    OptionsBtn: TSpeedButton;
    TangenteCB: TComboBox;
    OKBtn: TBitBtn;
    SupprCB: TCheckBox;
    OptionsPC: TPageControl;
    TabSheet1: TTabSheet;
    StoechTS: TTabSheet;
    TabSheet3: TTabSheet;
    TraitCB: TComboBoxEx;
    TangenteColor: TColorBox;
    Label4: TLabel;
    NbreEdit: TEdit;
    SpinButton1: TSpinButton;
    Label3: TLabel;
    Burette: TSpinEdit;
    Label5: TLabel;
    Becher: TSpinEdit;
    Label1: TLabel;
    LargeurCB: TComboBox;
    LabelLargeur: TLabel;
    GridCB: TCheckBox;
    procedure OptionsBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure TangenteCBChange(Sender: TObject);
    procedure NbreSpinButtonDownClick(Sender: TObject);
    procedure NbreSpinButtonUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  ChoixTangenteDlg: TChoixTangenteDlg;

implementation

{$R *.DFM}

procedure TChoixTangenteDlg.OptionsBtnClick(Sender: TObject);
begin
   TangenteCBChange(sender);
end;

procedure TChoixTangenteDlg.FormActivate(Sender: TObject);
begin
  case LigneRappelTangente of
     lrTangente : TangenteCB.itemIndex := 2;
     lrEquivalenceManuelle : TangenteCB.itemIndex := 1;
     else TangenteCB.itemIndex := 0
  end;
  if (stoechBecherGlb>1) or (stoechBuretteGlb>1)
     then optionsBtn.Down := true;
  largeurCB.itemIndex := round(1/LongueurTangente)-1;
  NbreEdit.text := IntToStr(NbrePointDerivee);
  gridCB.Checked := avecTableau;
  TangenteColor.selected := pColorTangente;
  TraitCB.itemIndex := ord(PstyleTangente);
  TangenteCBChange(sender);
end;

procedure TChoixTangenteDlg.FormCreate(Sender: TObject);
begin
   ResizeButtonImagesforHighDPI(self);
end;

procedure TChoixTangenteDlg.NbreSpinButtonDownClick(Sender: TObject);
begin
     if NbrePointDerivee>MinPointsDerivee then begin
        dec(NbrePointDerivee,2);
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TChoixTangenteDlg.NbreSpinButtonUpClick(Sender: TObject);
begin
     if NbrePointDerivee<MaxPointsDerivee then begin
        inc(NbrePointDerivee,2);
        NbreEdit.text := IntToStr(NbrePointDerivee);
     end;
end;

procedure TChoixTangenteDlg.OKBtnClick(Sender: TObject);
begin
    case TangenteCB.itemIndex of
         1 : LigneRappelTangente := lrEquivalenceManuelle;
         2 : LigneRappelTangente := lrTangente;
         else LigneRappelTangente := lrEquivalence;
    end;
    avecTableau := gridCB.Checked;
    LigneRappelCourante := LigneRappelTangente;
    PstyleTangente := TpenStyle(TraitCB.itemIndex);
    if stoechTS.visible
       then begin
          StoechBecherGlb := Becher.value;
          StoechBuretteGlb := Burette.value;
          pages[pageCourante].StoechBecher :=  StoechBecherGlb;
          pages[pageCourante].StoechBurette :=  StoechBuretteGlb;
       end
       else begin
          StoechBecherGlb := 1;
          StoechBuretteGlb := 1;
       end;
    LongueurTangente := 1/(largeurCB.itemIndex+1);
    pColorTangente := TangenteColor.selected;
end;

procedure TChoixTangenteDlg.TangenteCBChange(Sender: TObject);
var hauteurMin : integer;
begin
   hauteurMin := optionsPC.top + height-clientHeight;
   optionsPC.visible := optionsBtn.down;
   stoechTS.Visible := TangenteCB.itemIndex<>2;
   largeurCB.visible := TangenteCB.itemIndex=2;
   labelLargeur.Visible := largeurCB.visible;
   if optionsBtn.down
      then height := hauteurMin + optionsPC.height
      else height := hauteurMin;
end;

end.


