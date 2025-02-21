unit ArduinoOscilloCfg;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin,
  OOmisc, adport, lnswin32, awuser, shellApi,
  regutil, constreg, Vcl.Mask, Vcl.Grids;

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
    WifiBtn: TBitBtn;
    microbitBtn: TBitBtn;
    GroupBox1: TGroupBox;
    grid: TStringGrid;
    Panel2: TPanel;
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
   end;
   if sender=microbitBtn then begin
      cheminPy := chemin+'oscillo.py';
      nbreRG.ItemIndex := 0; // 256
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
   end;
   if sender=DueBtn then begin
      cheminPy := chemin+'oscilloDue\oscilloDue.ino';
      nbreRG.ItemIndex := 3;// 2048
      resolutionRG.ItemIndex := 2;
      baudRG.ItemIndex := 3;
   end;
   if sender=CurieBtn then begin
      cheminPy := chemin+'oscilloCurie101\oscilloCurie101.ino';
      nbreRG.ItemIndex := 2; // 1024
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
   end;
   if sender=WifiBtn then begin
      cheminPy := chemin+'oscilloWifi\oscilloCurieWifi.ino';
      nbreRG.ItemIndex := 1; // 512
      resolutionRG.ItemIndex := 1;
      baudRG.ItemIndex := 4;
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
end;

procedure TArduinoOscilloDlg.FormCreate(Sender: TObject);
begin
   left := (screen.Width-width) div 2;
   chemin := extractFilePath(application.ExeName)+'Arduino\';
   grid.DefaultRowHeight := hauteurColonne;
   grid.Cells[0,0] := stNom;
   grid.Cells[1,0] := stUnite;
   grid.colWidths[0] := 150;
   grid.colWidths[1] := 150;
   grid.colWidths[2] := 300;
   grid.Cells[2,0] := stConversion;
end;

procedure TArduinoOscilloDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

end.
