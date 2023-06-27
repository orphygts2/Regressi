unit unitGraphe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, inifiles, constreg,
  regutil, compile, keysU, aidekey;

type
  TunitGrapheDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    xGB: TGroupBox;
    yGB: TGroupBox;
    UniteXCB: TCheckBox;
    UniteYCB: TCheckBox;
    EditUniteX: TEdit;
    EditUniteY: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure EditUniteYKeyPress(Sender: TObject; var Key: Char);
    procedure UniteXCBClick(Sender: TObject);
    procedure UniteYCBClick(Sender: TObject);
  private
  public
    varX,varY : Tgrandeur;
  end;

var
  unitGrapheDlg: TunitGrapheDlg;

implementation

{$R *.DFM}

procedure TunitGrapheDlg.EditUniteYKeyPress(Sender: TObject; var Key: Char);
begin
     case key of
        crCR,crTab : ;
        crEsc : ;
        else if not isCaracUnite(key) then key := #0;
     end;
end;

procedure TunitGrapheDlg.FormActivate(Sender: TObject);
begin
     inherited;
     with varX do begin
        UniteXCB.checked := uniteGrapheImposee;
        EditUniteX.Text := uniteGraphe;
        EditUniteX.visible := UniteGrapheImposee;
        xGB.Caption := 'Abscisse : '+nom;
     end;
     with varX do begin
        UniteYCB.checked := uniteGrapheImposee;
        EditUniteY.Text := uniteGraphe;
        EditUniteY.visible := UniteGrapheImposee;
        yGB.Caption := 'Oronnée : '+nom;
     end;
end;

procedure TunitGrapheDlg.OKBtnClick(Sender: TObject);
var nomLoc : string;
begin
     with varX do begin
         uniteGrapheImposee := UniteXCB.checked;
         if uniteGrapheImposee
            then begin
               nomLoc := EditUniteX.Text;
               convertitExpUnite(nomLoc);
            end
            else nomLoc := '';
         uniteGraphe := nomLoc;
     end;
     with varY do begin
         uniteGrapheImposee := UniteYCB.checked;
         if uniteGrapheImposee
            then begin
               nomLoc := EditUniteY.Text;
               convertitExpUnite(nomLoc);
            end
            else nomLoc := '';
         uniteGraphe := nomLoc;
     end;
end;

procedure TunitGrapheDlg.UniteXCBClick(Sender: TObject);
begin
     EditUniteX.visible := UniteXCB.checked;
end;

procedure TunitGrapheDlg.UniteYCBClick(Sender: TObject);
begin
     EditUniteY.visible := UniteYCB.checked;
end;

procedure TunitGrapheDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(0)  { TODO : aide modif unité graphe }
end;

end.
