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
  private
  public
  end;

var
  AddPageExpDlg: TAddPageExpDlg;

implementation

uses regmain;

{$R *.dfm}

end.
