unit ArduinoCfgNew;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.Grids,
  Vcl.htmlHelpViewer,
  shellApi, constreg,  regutil,
  OOmisc, adport, lnswin32, awuser, Vcl.Mask;

type
  TArduinoNewDlg = class(TForm)
    Comports: TRadioGroup;
    Okbtn: TBitBtn;
    MemoPoint: TMemo;
    ExPointBtn: TBitBtn;
    BaudRG: TRadioGroup;
    ModeRG: TRadioGroup;
    DureeGB: TGroupBox;
    dureeMaxSE: TSpinEdit;
    arduinoExeBtn: TBitBtn;
    LabelDuree: TLabel;
    HelpBtn: TBitBtn;
    BoutonsPanel: TPanel;
    LabelDeltat: TLabel;
    DeltatSE: TSpinEdit;
    grid: TStringGrid;
    GroupBox1: TGroupBox;
    nomClavierEdit: TLabeledEdit;
    UniteClavierEdit: TLabeledEdit;
    Panel1: TPanel;
    AvecDemandeRG: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure ExPointBtnClick(Sender: TObject);
    procedure arduinoExeBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModeRGClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    chemin : string;
  public
  end;

var
  ArduinoNewDlg: TArduinoNewDlg;

implementation

{$R *.dfm}

uses arduinoNew, arduinoGraphe, aidekey;

procedure TArduinoNewDlg.ExPointBtnClick(Sender: TObject);
var cheminPy : string;
begin
   if sender=ExPointBtn then begin
      cheminPy := chemin+'simplePoint\simplePoint.ino';
      modeRG.ItemIndex := 0;
   end;
   if ShellExecute(Handle, 'open', PChar(cheminPy), nil, nil, SW_SHOW) <= 32 then
      ShowMessage(stNoAccesInstall+chemin);
end;

procedure TArduinoNewDlg.arduinoExeBtnClick(Sender: TObject);
begin
 if ShellExecute(Handle, 'open', PChar(arduinoExe), nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+arduinoExe);
end;

procedure TArduinoNewDlg.FormActivate(Sender: TObject);
begin
     ExPointBtn.Visible := fileExists(chemin+'simplePoint\simplePoint.ino');
     ArduinoExeBtn.Visible := fileExists(arduinoExe);
     modeRGClick(nil);
end;

procedure TArduinoNewDlg.FormCreate(Sender: TObject);
begin
      left := (screen.Width-width) div 2;
      chemin := extractFilePath(application.ExeName)+'Arduino\';
      grid.DefaultRowHeight := hauteurColonne;
      grid.Cells[0,0] := stNom;
      grid.Cells[1,0] := stUnite;
      grid.Cells[2,0] := stMini;
      grid.Cells[3,0] := stMaxi;
end;

procedure TArduinoNewDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoNewDlg.ModeRGClick(Sender: TObject);
begin
    labelDuree.Visible := modeRG.itemIndex=0;
    DureeMaxSE.Visible := modeRG.itemIndex=0;
    DeltatSE.Visible := modeRG.itemIndex=0;
    labelDeltat.Visible := modeRG.itemIndex=0;
    nomClavierEdit.Visible := modeRG.itemIndex=1;
    uniteClavierEdit.Visible := modeRG.itemIndex=1;
end;

end.
