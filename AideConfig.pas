unit AideConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TAideDlg = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
  private
  public
  end;

var
  AideDlg: TAideDlg;

implementation

{$R *.dfm}

end.
