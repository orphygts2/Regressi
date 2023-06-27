unit loupeU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TLoupeForm = class(TForm)
    PaintBox: TPaintBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure Rond;
  end;

var
  LoupeForm: TLoupeForm;

implementation

{$R *.dfm}

procedure TLoupeForm.FormCreate(Sender: TObject);
begin
    paintBox.Cursor := crNone;
    cursor := crNone;
end;

procedure TLoupeForm.FormDestroy(Sender: TObject);
begin
    loupeForm := nil;
end;

procedure TLoupeForm.Rond;
var regionCercle : hRgn;
begin
    regionCercle := createEllipticRgn(0, 0, width, height);
    setWindowRgn(self.handle, regionCercle, true);
    deleteObject(regionCercle);
end;

end.


