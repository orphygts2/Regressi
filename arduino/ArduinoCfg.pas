unit ArduinoCfg;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.Grids,
  Vcl.htmlHelpViewer,
  shellApi, constreg,  regutil,
  OOmisc, adport, lnswin32, awuser;

type
  TArduinoDlg = class(TForm)
    Comports: TRadioGroup;
    Okbtn: TBitBtn;
    BaudRG: TRadioGroup;
    DureeGB: TGroupBox;
    dureeMaxSE: TSpinEdit;
    arduinoExeBtn: TBitBtn;
    CommandGB: TGroupBox;
    SendGrid: TStringGrid;
    EtalonBtn: TBitBtn;
    ModeTempsRG: TRadioGroup;
    LabelDuree: TLabel;
    LabelCommande: TLabel;
    StartEdit: TEdit;
    HelpBtn: TBitBtn;
    TriggerRG: TRadioGroup;
    monocoupCB: TCheckBox;
    TerminateurRG: TRadioGroup;
    StopEdit: TEdit;
    LabelArret: TLabel;
    TempsArduinoCB: TCheckBox;
    MemoTemps: TMemo;
    exTempsArduinoBtn: TBitBtn;
    BoutonsPanel: TPanel;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure ExPointBtnClick(Sender: TObject);
    procedure arduinoExeBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModeRGClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure ModeTempsRGClick(Sender: TObject);
  private
    chemin : string;
  public
  end;

var
  ArduinoDlg: TArduinoDlg;

implementation

{$R *.dfm}

uses arduinoU, arduinoGraphe, aidekey;

procedure TArduinoDlg.ExPointBtnClick(Sender: TObject);
var cheminPy : string;
    i : integer;
begin
   for I := 1 to 3 do begin
       sendGrid.Cells[i,1] := '';
       sendGrid.Cells[i,2] := '';
   end;
   if sender=EtalonBtn then begin
       cheminPy := chemin+'etalon\etalon.ino';
       sendGrid.Cells[1,1] := 'Set';
       sendGrid.Cells[1,2] := 'Zéro';
   end;
   if sender=ExTempsArduinoBtn then begin
       cheminPy := chemin+'tempsArduino\tempsArduino.ino';
       ModeTempsRG.ItemIndex := 2;
       startEdit.text := '';
       tempsArduinoCB.Checked := true;
       startEdit.Text := 'S';
       stopEdit.Text := 'a';
   end;
   if ShellExecute(Handle, 'open', PChar(cheminPy), nil, nil, SW_SHOW) <= 32 then
      ShowMessage(stNoAccesInstall+chemin);
end;

procedure TArduinoDlg.arduinoExeBtnClick(Sender: TObject);
begin
 if ShellExecute(Handle, 'open', PChar(arduinoExe), nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+arduinoExe);
end;

procedure TArduinoDlg.FormActivate(Sender: TObject);
begin
     exTempsArduinoBtn.Visible := fileExists(chemin+'tempsArduino\tempsArduino.ino');
     etalonBtn.Visible := fileExists(chemin+'etalon\etalon.ino');
     ArduinoExeBtn.Visible := fileExists(arduinoExe);
     modeRGClick(nil);
     modeTempsRGClick(nil);
end;

procedure TArduinoDlg.FormCreate(Sender: TObject);
var i : integer;
begin
      for i := 1 to 3 do
          sendGrid.Cells[i,0] := intToStr(i);
      sendGrid.Cells[0,1] := 'Commande';
      sendGrid.Cells[0,2] := 'Texte';
      left := (screen.Width-width) div 2;
      chemin := extractFilePath(application.ExeName)+'Arduino\';
      SendGrid.DefaultRowHeight := hauteurColonne;
end;

procedure TArduinoDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoDlg.ModeRGClick(Sender: TObject);
begin
    triggerRG.visible := (modeTempsRG.itemIndex=0);
    labelCommande.Caption := 'Commande de démarrage';
end;

procedure TArduinoDlg.ModeTempsRGClick(Sender: TObject);
begin
    monocoupCB.visible := (ModeTempsRG.ItemIndex=0) and (triggerRG.ItemIndex<2);
    triggerRG.Visible := ModeTempsRG.ItemIndex=0;
end;

end.
