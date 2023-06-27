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
    MemoPoint: TMemo;
    ExPointBtn: TBitBtn;
    BaudRG: TRadioGroup;
    ModeRG: TRadioGroup;
    DureeGB: TGroupBox;
    dureeMaxSE: TSpinEdit;
    arduinoExeBtn: TBitBtn;
    CommandGB: TGroupBox;
    SendGrid: TStringGrid;
    ExTempsBtn: TBitBtn;
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
    exPointMBBtn: TBitBtn;
    extempsmicrobitBtn: TBitBtn;
    extempsmbbtn: TBitBtn;
    etalonmbbtn: TBitBtn;
    BoutonsPanel: TPanel;
    UserDataCB: TCheckBox;
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
   if sender=ExPointBtn then begin
      cheminPy := chemin+'simplePoint\simplePoint.ino';
      modeRG.ItemIndex := 0;
   end;
   if sender=ExPointMBBtn then begin
      cheminPy := chemin+'simplePoint.py';
      modeRG.ItemIndex := 0;
      baudRG.itemIndex := 4;
   end;
   if sender=EtalonBtn then begin
       cheminPy := chemin+'etalon\etalon.ino';
       sendGrid.Cells[1,1] := 'Set';
       sendGrid.Cells[1,2] := 'Zéro';
       modeRG.ItemIndex := 0;
   end;
   if sender=EtalonMBBtn then begin
       cheminPy := chemin+'etalon.py';
       sendGrid.Cells[1,1] := 'Z';
       sendGrid.Cells[1,2] := 'Zéro';
       modeRG.ItemIndex := 0;
       baudRG.itemIndex := 4;
   end;
   if sender=ExTempsBtn then begin
       cheminPy := chemin+'simpleTemps\simpleTemps.ino';
       modeRG.ItemIndex := 1;
       ModeTempsRG.ItemIndex := 2;
       tempsArduinoCB.Checked := false;
       startEdit.Text := '';
       stopEdit.Text := '';
   end;
   if sender=ExTempsMBBtn then begin
       cheminPy := chemin+'simpleTemps.py';
       modeRG.ItemIndex := 1;
       ModeTempsRG.ItemIndex := 2;
       tempsArduinoCB.Checked := false;
       startEdit.Text := '';
       stopEdit.Text := '';
       baudRG.itemIndex := 4;
   end;
   if sender=ExTempsArduinoBtn then begin
       cheminPy := chemin+'tempsArduino\tempsArduino.ino';
       modeRG.ItemIndex := 1;
       ModeTempsRG.ItemIndex := 2;
       startEdit.text := '';
       tempsArduinoCB.Checked := true;
       startEdit.Text := 'S';
       stopEdit.Text := 'a';
   end;
   if sender=ExTempsMicrobitBtn then begin
       cheminPy := chemin+'startstop.py';
       modeRG.ItemIndex := 1;
       ModeTempsRG.ItemIndex := 2;
       tempsArduinoCB.Checked := true;
       startEdit.Text := 'D';
       stopEdit.Text := 'F';
       baudRG.itemIndex := 4;
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
     ExPointBtn.Visible := fileExists(chemin+'simplePoint\simplePoint.ino');
     exTempsBtn.Visible := fileExists(chemin+'simpleTemps\simpleTemps.ino');
     exTempsArduinoBtn.Visible := fileExists(chemin+'tempsArduino\tempsArduino.ino');
     etalonBtn.Visible := fileExists(chemin+'etalon\etalon.ino');
     ExPointMBBtn.Visible := fileExists(chemin+'simplePoint.py');
     exTempsMBBtn.Visible := fileExists(chemin+'simpleTemps.py');
     exTempsMicroBitBtn.Visible := fileExists(chemin+'startstop.py');
     etalonMBBtn.Visible := fileExists(chemin+'etalon.py');
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
  //    SendGrid.DefaultRowHeight := hauteurColonne;
      ResizeButtonImagesforHighDPI(self);
end;

procedure TArduinoDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoDlg.ModeRGClick(Sender: TObject);
begin
    modeTempsRG.Visible := modeRG.itemIndex=1;
    memoTemps.Visible := modeRG.itemIndex=1;
    memoPoint.Visible := modeRG.itemIndex=0;
    triggerRG.visible := (modeRG.itemIndex=1) and (modeTempsRG.itemIndex=0);
    labelArret.Visible := modeRG.itemIndex=1;
    labelDuree.Visible := modeRG.itemIndex=1;
    DureeMaxSE.Visible := modeRG.itemIndex=1;
    stopEdit.Visible := modeRG.itemIndex=1;
    monocoupCB.Visible := modeRG.itemIndex=1;
    tempsArduinoCB.Visible := modeRG.itemIndex=1;
    userDataCB.Visible :=  modeRG.itemIndex=0;
    if modeRG.itemIndex=1
    then begin // temporel
         labelCommande.Caption := 'Commande de démarrage';
    end
    else begin // point par point
         labelCommande.Caption := 'Commande d''acquisition d''un point';
    end;
end;

procedure TArduinoDlg.ModeTempsRGClick(Sender: TObject);
begin
    monocoupCB.visible := (ModeTempsRG.ItemIndex=0) and (triggerRG.ItemIndex<2);
    triggerRG.Visible := ModeTempsRG.ItemIndex=0;
end;

end.
