unit origineu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vcl.HtmlHelpViewer,
  StdCtrls, Buttons, regutil, compile;

type
  TOrigineDlg = class(TForm)
    TempsCourantBtn: TBitBtn;
    NouveauTempsBtn: TBitBtn;
    escapeBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
  private
  public
    index : integer;
    LigneCompile : string;
  end;

var
  OrigineDlg: TOrigineDlg;

implementation

{$R *.DFM}

procedure TOrigineDlg.FormActivate(Sender: TObject);
begin
    inherited;
    TempsCourantBtn.caption := 'Change l''origine de '+grandeurs[indeX].nom;
    LigneCompile := grandeurs[indeX].nom+'0='+grandeurs[indeX].nom+'-'+deltaMin+grandeurs[indeX].nom;
    NouveauTempsBtn.caption := 'Crée '+ligneCompile
end;

end.
