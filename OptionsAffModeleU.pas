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
var i,N : integer;
    sauve : array[1..MaxParametres] of boolean;
begin
with ListeParamBox do begin
     for i := 1 to MaxParametres do sauve[i] := false;
     if pages[pageCourante].ModeleCalcule then
        for i := 1 to count do
            sauve[i] := checked[i-1];
     Items.Clear;
     if isGlobal
     then for i := 1 to NbreParam[paramGlb] do begin
         Items.add(Parametres[paramGlb,i].nom);
         checked[i-1] := sauve[i];
     end
     else for i := 1 to NbreParam[paramNormal] do begin
         Items.add(Parametres[paramNormal,i].nom);
         checked[i-1] := sauve[i];
     end;
end;
ParamGB.visible := pages[pageCourante].ModeleCalcule;
if isGlobal
   then ListeModeleGB.visible := nbreModeleGlb>1
   else ListeModeleGB.visible := nbreModele>1;
with ListeModeleBox do begin
     for i := 1 to MaxParametres do sauve[i] := false;
     for i := 1 to count do
         sauve[i] := checked[i-1];
     Items.Clear;
     if isGlobal
     then begin
         N := 0;
         for i := 1 to NbreModeleGlb do begin
             Items.add(FonctionTheoriqueGlb[i].expression);
             checked[i-1] := sauve[i];
             if sauve[i] then inc(N);
         end;
         if N=0 then checked[0] := true;
     end
     else begin
         N := 0;
         for i := 1 to NbreModele do begin
             Items.add(FonctionTheorique[i].expression);
             checked[i-1] := sauve[i];
             if sauve[i] then inc(N);
         end;
         if N=0 then checked[0] := true;
     end;
end;
ModeleNumCB.Checked := ModeleNumerique;
AffCoeffElargCB.Checked := AffCoeffElarg;
end;

procedure TOptionsAffModeleDlg.OKBtnClick(Sender: TObject);
begin
   ModeleNumerique := ModeleNumCB.Checked;
// MODELE LITTERAL vs. MODELE AVEC CONSTANTES TROUVEES PAR LA MODELISATION
   AffCoeffElarg := AffCoeffElargCB.Checked;
end;

end.
