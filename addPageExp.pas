unit addPageExp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls,
  regutil;

type
  TAddPageExpDlg = class(TForm)
    Panel1: TPanel;
    Grid: TStringGrid;
    Panel2: TPanel;
    OKbtn: TBitBtn;
    AddBtn: TBitBtn;
    escBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  AddPageExpDlg: TAddPageExpDlg;

implementation

{$R *.dfm}

procedure TAddPageExpDlg.FormCreate(Sender: TObject);
begin
    ResizeButtonImagesforHighDPI(self);
end;

end.
