unit ChronoEch;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     vcl.HtmlHelpViewer,
     Buttons, ExtCtrls, grapheU, chronoBitmap, Spin, ComCtrls, regutil;

type
  TEchelleMecaBmpDlg = class(TForm)
    GroupBox1: TGroupBox;
    LabelX: TLabel;
    LabelY: TLabel;
    EchelleEdit: TEdit;
    UniteEdit: TEdit;
    Label2: TLabel;
    LabelEchelle: TLabel;
    Label4: TLabel;
    NomX: TEdit;
    NomY: TEdit;
    nomT: TEdit;
    EditT: TEdit;
    UniteT: TEdit;
    ReferenceCB: TCheckBox;
    Panel: TPanel;
    Label1: TLabel;
    NbreSE: TSpinEdit;
    StatusBar: TStatusBar;
    OKBtn: TBitBtn;
    BitBtn2: TBitBtn;
    TeditLabel: TLabel;
    TUnitLabel: TLabel;
    signeYCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ReferenceCBClick(Sender: TObject);
  private
  public
  end;

var
  EchelleMecaBmpDlg: TEchelleMecaBmpDlg;

implementation

{$R *.DFM}

procedure TEchelleMecaBmpDlg.FormActivate(Sender: TObject);
begin with chronoForm do begin
      NbreSE.MaxValue := maxObjet;
      ReferenceCB.checked := avecT;
      EchelleEdit.text := FloatToStrF(Longueur,ffGeneral,5,0);
      EditT.text := FloatToStrF(deltaT,ffGeneral,5,0);
end end;

procedure TEchelleMecaBmpDlg.OKBtnClick(Sender: TObject);
begin with chronoForm do begin
      try
      Longueur := StrToFloatWin(EchelleEdit.text);
      except
         Longueur := 1;
      end;
      try
      DeltaT := StrToFloatWin(EditT.text);
      except
         Deltat := 1;
      end;
      avecT := ReferenceCB.checked;
      if not avecT then deltat := 1;
end end;

procedure TEchelleMecaBmpDlg.ReferenceCBClick(Sender: TObject);
begin
   nomT.visible := referenceCB.checked;
   editT.visible := referenceCB.checked;
   uniteT.visible := referenceCB.checked;
   TunitLabel.visible := referenceCB.checked;
   TeditLabel.visible := referenceCB.checked;
end;

end.
