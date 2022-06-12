unit OptionsAffModeleU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  vcl.HtmlHelpViewer,
  Dialogs, StdCtrls, ExtCtrls, CheckLst, Buttons;

type
  TOptionsAffModeleDlg = class(TForm)
    ParamGB: TGroupBox;
    ListeParamBox: TCheckListBox;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    ListeModeleGB: TGroupBox;
    ListeModeleBox: TCheckListBox;
    ModeleNumCB: TCheckBox;
    AffCoeffElargCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
  public
    isGlobal : boolean;
  end;

var
  OptionsAffModeleDlg: TOptionsAffModeleDlg;

implementation

uses compile, graphker;

{$R *.dfm}

procedure TOptionsAffModeleDlg.FormActivate(Sender: TObject);
var i : integer;
    sauve : array[0..MaxParametres] of boolean;
begin
with ListeParamBox do begin
     for i := 0 to pred(count) do
         sauve[i] := checked[i];
     Items.Clear;
     if isGlobal
     then for i := 1 to NbreParam[paramGlb] do begin
         Items.add(Parametres[paramGlb,i].nom);
         checked[i-1] := sauve[i-1];
     end
     else for i := 1 to NbreParam[paramNormal] do begin
         Items.add(Parametres[paramNormal,i].nom);
         checked[i-1] := sauve[i-1];
     end;
end;
if isGlobal
   then ListeModeleGB.visible := nbreModeleGlb>1
   else ListeModeleGB.visible := nbreModele>1;
with ListeModeleBox do begin
     for i := 0 to pred(count) do
         sauve[i] := checked[i];
     Items.Clear;
     if isGlobal
     then for i := 1 to NbreModeleGlb do begin
         Items.add(FonctionTheoriqueGlb[i].expression);
         checked[i-1] := sauve[i-1];
     end
     else for i := 1 to NbreModele do begin
         Items.add(FonctionTheorique[i].expression);
         checked[i-1] := sauve[i-1];
     end;
     if isGlobal
     then begin
        if nbreModeleGlb=1 then checked[0] := true;
     end
     else begin
        if nbreModele=1 then checked[0] := true;
     end;
end;
ModeleNumCB.Checked := ModeleNumerique;
AffCoeffElargCB.Checked := AffCoeffElarg;
end;

// Options
// MODELE LITTERAL
// MODELE AVEC CONSTANTES TROUVEES PAR LA MODELISATION

procedure TOptionsAffModeleDlg.OKBtnClick(Sender: TObject);
begin
   ModeleNumerique := ModeleNumCB.Checked;
   AffCoeffElarg := AffCoeffElargCB.Checked;
end;

end.
