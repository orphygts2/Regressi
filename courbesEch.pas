unit courbesEch;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Spin, ComCtrls,
     vcl.HtmlHelpViewer,
     grapheU, courbesU, regutil;

type
  TEchelleBmpDlg = class(TForm)
    GroupBox1: TGroupBox;
    EditY: TEdit;
    LabelX: TLabel;
    LabelY: TLabel;
    EditX: TEdit;
    UniteX: TEdit;
    UniteY: TEdit;
    Label2: TLabel;
    LabelEchelle: TLabel;
    Label4: TLabel;
    NomX: TEdit;
    NomY: TEdit;
    LabelOrigine: TLabel;
    EditX0: TEdit;
    EditY0: TEdit;
    Label7: TLabel;
    logxcb: TCheckBox;
    logycb: TCheckBox;
    OKBtn: TBitBtn;
    BitBtn2: TBitBtn;
    PolaireCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure PolaireCBClick(Sender: TObject);
  private
  public
  end;

var
  EchelleBmpDlg: TEchelleBmpDlg;

implementation

{$R *.DFM}

procedure TEchelleBmpDlg.FormActivate(Sender: TObject);
begin with courbesForm do begin
      NbreSE.MaxValue := maxObjet;
      EditX.text := FloatToStrF(MaxiX,ffGeneral,5,0);
      EditY.text := FloatToStrF(MaxiY,ffGeneral,5,0);
      EditX0.text := FloatToStrF(MiniX,ffGeneral,5,0);
      EditY0.text := FloatToStrF(MiniY,ffGeneral,5,0);
      logxcb.checked := echelleX in [elog];
      logycb.checked := echelleY in [elog];
end end;

procedure TEchelleBmpDlg.OKBtnClick(Sender: TObject);
begin with courbesForm do begin
      echelleX := elin;
      echelleY := elin;
      if logxcb.checked and not polaireCB.checked then echelleX := elog;
      if logycb.checked and not polaireCB.checked then echelleY := elog;
      if polaireCB.checked then begin
         echelleX := ePolaire;
         echelleY := ePolaire;
      end;

      try
      MaxiX := StrToFloatWin(EditX.text);
      except
         MaxiX := 1;
      end;
      if (echelleX=elog) and (maxiX<=0) then maxiX := 1;
      try
      MiniX := StrToFloatWin(EditX0.text);
      except
         MiniX := 0;
      end;
      if (echelleX=elog) and (miniX<=0) then miniX := 2;
      if maxiX=miniX then maxiX := miniX+1;

      try
      MaxiY := StrToFloatWin(EditY.text);
      except
         MaxiY := 1;
      end;
      if (echelleY=elog) and (maxiY<=0) then maxiY := 1;
      try
      MiniY := StrToFloatWin(EditY0.text);
      except
         MiniY := 0;
      end;
      if (echelleY=elog) and (miniY<=0) then miniY := 2;
      if maxiY=miniY then maxiY := miniY+1;
end end;

procedure TEchelleBmpDlg.PolaireCBClick(Sender: TObject);
begin
  inherited;
  if polaireCB.Checked then begin
     labelX.caption := 'angle';
     labelY.caption := 'rayon';
  end
  else begin
     labelX.caption := 'axe horizontal';
     labelY.caption := 'axe vertical';
  end;
  logxcb.Visible := not  polaireCB.Checked;
  logycb.Visible := not  polaireCB.Checked;
end;

end.
