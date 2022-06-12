unit RollingShutterU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  rollingShutterCalc;

type
  TRollingShutterForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    UpBtn: TRadioButton;
    GroupBox1: TGroupBox;
    LeftBtn: TRadioButton;
    DownBtn: TRadioButton;
    RightBtn: TRadioButton;
    procedure UpBtnClick(Sender: TObject);
  private
  public
  end;

var
  RollingShutterForm: TRollingShutterForm;

implementation

{$R *.dfm}

procedure TRollingShutterForm.UpBtnClick(Sender: TObject);
begin
    if rightBtn.Checked then begin
       correctionRS.FX_RS := -1;
       correctionRS.FY_RS := 0;
    end;
    if leftBtn.Checked then begin
       correctionRS.FX_RS := 1;
       correctionRS.FY_RS := 0;
    end;
    if upBtn.Checked then begin
       correctionRS.FX_RS := 0;
       correctionRS.FY_RS := 1;
    end;
    if downBtn.Checked then begin
       correctionRS.FX_RS := 0;
       correctionRS.FY_RS := -1;
    end;
end;

end.
