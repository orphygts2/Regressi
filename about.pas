unit about;

interface

uses Windows, Classes, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, regutil, shellApi, dialogs,
     constreg, graphfft, Graphics, Vcl.Imaging.pngimage;

type
  TAboutBox = class(TForm)
    OKButton: TBitBtn;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Copyright: TLabel;
    NumeroVersionLabel: TLabel;
    Email: TLabel;
    Label1: TLabel;
    VersionBtn: TBitBtn;
    Image1: TImage;
    Label2: TLabel;
    procedure VersionBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

procedure TAboutBox.VersionBtnClick(Sender: TObject);
begin
  if ShellExecute(Handle, 'open', 'https://regressi.fr/miseajour2008.html', nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+' site https://regressi.fr/WordPress')
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
{$IFDEF win64}
    productName.Caption := 'Regressi/ffmpeg 64 bits';
{$ELSE}
    productName.Caption := 'Regressi/ffmpeg 32 bits';
{$ENDIF}
end;

end.
