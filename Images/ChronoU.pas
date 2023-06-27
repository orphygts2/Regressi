unit ChronoU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Vcl.StdCtrls;

type
  TVideoChronoForm = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    PasBtn: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure PasBtnClick(Sender: TObject);
  private
    attenteClic : boolean;
  public
    dtStr : string;
    nomFichierBmp : string;
  end;

var
  VideoChronoForm: TVideoChronoForm;

implementation

{$R *.dfm}

procedure TVideoChronoForm.FormActivate(Sender: TObject);
begin
    pasBtn.Caption := 'Indiquer le pas "'+dtStr+'"sur l''image';
    attenteClic := false;
end;

procedure TVideoChronoForm.Image1Click(Sender: TObject);
var P : Tpoint;
    echelleX,echelleY : single;
begin
      if attenteClic then begin
         P := mouse.CursorPos;
         P := Image1.ScreenToClient(P);
         echelleX := Image1.Picture.width/image1.width;
         echelleY := Image1.Picture.height/image1.height;
         if echelleX>echelleY
            then echelleY := echelleX
            else echelleX := echelleY;
         if (P.X<0) or (P.X>image1.width) or
            (P.Y<0) or (P.Y>image1.height) then exit;
         Image1.canvas.font.height := image1.height div 12;
         Image1.canvas.font.name := 'Segoe UI';
         P.X := round(P.x*echelleX);
         P.Y := round(P.y*echelleY);
         Image1.canvas.TextOut(P.x, P.y, dtStr);
         Image1.Picture.saveToFile(nomFichierBmp);
         attenteClic := false;
      end;
end;

procedure TVideoChronoForm.PasBtnClick(Sender: TObject);
begin
    ShowMessage('Cliquer à l''endroit où placer '+dtStr);
    AttenteClic := true;
end;

end.
