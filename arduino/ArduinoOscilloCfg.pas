unit ArduinoOscilloCfg;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin,
  OOmisc, adport, lnswin32, awuser, shellApi,
  regutil, constreg, Vcl.Mask;

type
  TArduinoOscilloDlg = class(TForm)
    Comports: TRadioGroup;
    OKBtn: TBitBtn;
    Memo1: TMemo;
    UnoBtn: TBitBtn;
    BaudRG: TRadioGroup;
    NbreRG: TRadioGroup;
    CurieBtn: TBitBtn;
    DueBtn: TBitBtn;
    arduinoExeBtn: TBitBtn;
    HelpBtn: TBitBtn;
    sincGB: TGroupBox;
    sincCB: TCheckBox;
    ordreSincSE: TSpinEdit;
    ResolutionRG: TRadioGroup;
    Panel1: TPanel;
    UdpGB: TGroupBox;
    HostEdit: TLabeledEdit;
    PortEdit: TLabeledEdit;
    WifiBtn: TBitBtn;
    UdpCB: TCheckBox;
    WifiGB: TGroupBox;
    Label1: TLabel;
    microbitBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure UnoBtnClick(Sender: TObject);
    procedure arduinoExeBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    chemin : string;
  public
  end;

var
  ArduinoOscilloDlg: TArduinoOscilloDlg;

implementation

{$R *.dfm}

uses arduinoOscillo, arduinoGraphe, aidekey;

procedure TArduinoOscilloDlg.UnoBtnClick(Sender: TObject);
var cheminPy : string;
begin
   if sender=UnoBtn then begin
      cheminPy := chemin+'oscillo\oscillo.ino';
      nbreRG.ItemIndex := 0; // 256
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 3;
      UdpCB.Checked := false;
   end;
   if sender=microbitBtn then begin
      cheminPy := chemin+'oscillo.py';
      nbreRG.ItemIndex := 0; // 256
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
      UdpCB.Checked := false;
   end;
   if sender=DueBtn then begin
      cheminPy := chemin+'oscilloDue\oscilloDue.ino';
      nbreRG.ItemIndex := 3;// 2048
      resolutionRG.ItemIndex := 2;
      baudRG.ItemIndex := 3;
      UdpCB.Checked := false;
   end;
   if sender=CurieBtn then begin
      cheminPy := chemin+'oscilloCurie101\oscilloCurie101.ino';
      nbreRG.ItemIndex := 2; // 1024
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
      UdpCB.Checked := false;
   end;
   if sender=WifiBtn then begin
      cheminPy := chemin+'oscilloWifi\oscilloCurieWifi.ino';
      nbreRG.ItemIndex := 1; // 512
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
      UdpCB.Checked := true;
   end;
   if ShellExecute(Handle, 'open', PChar(cheminPy), nil, nil, SW_SHOW) <= 32 then
      ShowMessage(stNoAccesInstall+chemin);
end;

procedure TArduinoOscilloDlg.arduinoExeBtnClick(Sender: TObject);
begin
 if ShellExecute(Handle, 'open', PChar(arduinoExe), nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+arduinoExe);
end;

procedure TArduinoOscilloDlg.FormActivate(Sender: TObject);
begin
     UnoBtn.visible := directoryExists(chemin);
     DueBtn.visible := UnoBtn.visible;
     CurieBtn.visible := UnoBtn.visible;
     WifiBtn.visible := UnoBtn.visible;
     microBitBtn.visible := UnoBtn.visible;
     ArduinoExeBtn.Visible := fileExists(arduinoExe);
     Comports.Visible := ArduinoOscilloDlg.comports.Items.count>0;
     BaudRG.Visible := ArduinoOscilloDlg.comports.Items.count>0;
     WifiGB.Visible := ArduinoOscilloDlg.comports.Items.count=0;
end;

procedure TArduinoOscilloDlg.FormCreate(Sender: TObject);
begin
   left := (screen.Width-width) div 2;
   chemin := extractFilePath(application.ExeName)+'Arduino\';
   ResizeButtonImagesforHighDPI(self);
end;

procedure TArduinoOscilloDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

end.
