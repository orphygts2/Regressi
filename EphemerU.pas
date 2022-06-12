unit EphemerU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  shellApi, regUtil;

type
  TEphemerForm = class(TForm)
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  EphemerForm: TEphemerForm;

implementation

{$R *.dfm}

procedure TEphemerForm.BitBtn1Click(Sender: TObject);
const  FileName3 = 'https://ssp.imcce.fr/forms/ephemeris';
begin
  if ShellExecute(Handle, 'open', PChar(FileName3), nil, nil, SW_SHOW) <= 32
     then ShowMessage('Impossible d''accéder au Bureau des Longitudes')
end;

procedure TEphemerForm.FormCreate(Sender: TObject);
begin
 ResizeButtonImagesforHighDPI(self);
end;

end.
