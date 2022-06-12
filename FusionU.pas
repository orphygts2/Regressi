unit FusionU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vcl.HtmlHelpViewer,
  StdCtrls, Buttons, ExtCtrls, regutil, compile;

type
  TFusionDlg = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    NomCB: TComboBox;
    procedure FormActivate(Sender: TObject);
  private
  public
    nom : string;
  end;

var
  FusionDlg: TFusionDlg;

implementation

{$R *.DFM}

procedure TFusionDlg.FormActivate(Sender: TObject);
var i : integer;
begin
     label1.caption := nom+' n''existe pas';
     nomCB.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if (genreG=variable) and (fonct.genreC=g_experimentale) then nomCB.items.add(nom);
     nomCB.ItemIndex := 0;
end;

end.
