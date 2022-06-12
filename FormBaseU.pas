unit FormBaseU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  regutil;

type
  TFormBase = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.FormCreate(Sender: TObject);
begin
    ResizeButtonImagesforHighDPI(self);
end;

end.
