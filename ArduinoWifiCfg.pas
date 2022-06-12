unit ArduinoWifiCfg;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, shellApi, constreg,
  OOmisc, adport, lnswin32, awuser,
  regutil, Vcl.Samples.Spin, Vcl.Grids, Vcl.Mask;

type
  TArduinoWifiDlg = class(TForm)
    Okbtn: TBitBtn;
    MemoPoint: TMemo;
    ExPointBtn: TBitBtn;
    ModeRG: TRadioGroup;
    DureeGB: TGroupBox;
    dureeMaxSE: TSpinEdit;
    arduinoExeBtn: TBitBtn;
    CommandGB: TGroupBox;
    SendGrid: TStringGrid;
    ModeTempsRG: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    GetEdit: TEdit;
    HelpBtn: TBitBtn;
    MemoTemps: TMemo;
    UdpGB: TGroupBox;
    HostEdit: TLabeledEdit;
    PortEdit: TLabeledEdit;
    BoutonsPanel: TPanel;
    TechSE: TSpinEdit;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ExPointBtnClick(Sender: TObject);
    procedure arduinoExeBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModeRGClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure HostEditKeyPress(Sender: TObject; var Key: Char);
    procedure PortEditKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;

var
  ArduinoWifiDlg: TArduinoWifiDlg;

implementation

{$R *.dfm}

uses arduinoU, arduinoGraphe, aidekey;

procedure TArduinoWifiDlg.ExPointBtnClick(Sender: TObject);
var chemin : string;
begin
   chemin := application.ExeName;
   chemin := extractFilePath(chemin)+'Arduino\';
   if sender=ExPointBtn then begin
      chemin := chemin+'simplePointWifi\simplePointWifi.ino';
      modeRG.ItemIndex := 0;
   end;
   if ShellExecute(Handle, 'open', PChar(chemin), nil, nil, SW_SHOW) <= 32 then
      ShowMessage(stNoAccesInstall+chemin);
end;

procedure TArduinoWifiDlg.arduinoExeBtnClick(Sender: TObject);
begin
 if ShellExecute(Handle, 'open', PChar(arduinoExe), nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+arduinoExe);
end;

procedure TArduinoWifiDlg.FormActivate(Sender: TObject);
var chemin : string;
begin
     chemin := application.ExeName;
     chemin := extractFilePath(chemin)+'Arduino\';
     ExPointBtn.Visible := fileExists(chemin+'simplePointWifi\simplePointWifi.ino');
     ArduinoExeBtn.Visible := fileExists(arduinoExe);
     modeTempsRG.Visible := modeRG.ItemIndex=1;
     memoTemps.Visible := modeRG.itemIndex=1;
     memoPoint.Visible := modeRG.itemIndex=0;
end;

procedure TArduinoWifiDlg.FormCreate(Sender: TObject);
var i : integer;
begin
      for i := 1 to 3 do
          sendGrid.Cells[i,0] := intToStr(i);
      sendGrid.Cells[0,1] := 'Commande';
      sendGrid.Cells[0,2] := 'Texte';
 //     SendGrid.DefaultRowHeight := hauteurColonne;
      ResizeButtonImagesforHighDPI(self);
end;

procedure TArduinoWifiDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoWifiDlg.HostEditKeyPress(Sender: TObject; var Key: Char);
begin
 if not charInSet(key,['0'..'9','.',crGauche,crDroite,crSupprArr]) then key := #0;
end;

procedure TArduinoWifiDlg.ModeRGClick(Sender: TObject);
begin
    modeTempsRG.Visible := modeRG.itemIndex=1;
    memoTemps.Visible := modeRG.itemIndex=1;
    memoPoint.Visible := modeRG.itemIndex=0;
    dureeGB.Visible := modeRG.itemIndex=1;
end;

procedure TArduinoWifiDlg.PortEditKeyPress(Sender: TObject; var Key: Char);
begin
if not charInSet(key,['0'..'9',crGauche,crDroite,crSupprArr]) then key := #0;
end;

end.
