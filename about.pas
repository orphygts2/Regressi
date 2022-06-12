unit about;

interface

uses Windows, Classes, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, regutil, shellApi, dialogs,
     constreg, graphfft, Graphics, Vcl.Imaging.pngimage;
     // system.SysUtils, Vcl.Imaging.pngimage;
     // System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TAboutBox = class(TForm)
    PanelCop: TPanel;
    OKButton: TBitBtn;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Copyright: TLabel;
    NumeroVersionLabel: TLabel;
    Email: TLabel;
    Label1: TLabel;
    VersionBtn: TBitBtn;
    DebugLabel: TLabel;
    Image1: TImage;
    Label3: TLabel;
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
  if ShellExecute(Handle, 'open', 'https://jean-michel-millet.pagesperso-orange.fr/miseajour2008.html', nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+' site jean-michel-millet.pagesperso-orange.fr')
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
{$IFDEF win64}
    productName.Caption := 'Regressi/ffmpeg 64 bits';
{$ENDIF}
{$IFDEF Debug}
    DebugLabel.Visible := true;
{$ELSE}
    DebugLabel.Visible := false;
{$ENDIF}
   ResizeButtonImagesforHighDPI(self);
end;

end.
