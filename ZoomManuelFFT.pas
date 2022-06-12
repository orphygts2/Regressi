unit ZoomManuelFFT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,
  vcl.HtmlHelpViewer,
  maths, regUtil, graphker, compile;

type
  TZoomManuelFFTdlg = class(TForm)
    PanelZoom: TPanel;
    MaxiLabel: TLabel;
    MiniLabel: TLabel;
    FminEdit: TEdit;
    FmaxEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  ZoomManuelFFTdlg: TZoomManuelFFTdlg;

implementation

uses graphfft;

{$R *.dfm}

procedure TZoomManuelFFTdlg.FormActivate(Sender: TObject);
begin
     inherited;
     with FgrapheFFT.GrapheFrequence do begin
        FminEdit.text := formatReg(monde[mondeX].mini);
        FmaxEdit.text := formatReg(monde[mondeX].maxi);
     end;
end;

procedure TZoomManuelFFTdlg.FormCreate(Sender: TObject);
begin
 ResizeButtonImagesforHighDPI(self);
end;

procedure TZoomManuelFFTdlg.OKBtnClick(Sender: TObject);
var fmin,fmax : double;
begin with FgrapheFFT.GrapheFrequence do begin
    UseDefaultX := true;
    with grandeurs[cFrequence] do begin
         MiniLabel.Caption := nom+' Mini ('+nomUnite+')';
         MaxiLabel.Caption := nom+' Maxi ('+nomUnite+')';
    end;
    with monde[mondeX] do begin
          try
          Fmin := GetFloat(FminEdit.text);
          except Fmin := 1 end;
          try
          Fmax := GetFloat(FmaxEdit.text);
          except Fmax := 100*Fmin end;
          SetMinMaxDefaut(Fmin,Fmax);
          monde[mondeX].defini := true;
    end;
end end;

procedure TZoomManuelFFTdlg.CancelBtnClick(Sender: TObject);
begin with FgrapheFFT.GrapheFrequence do begin
    UseDefaultX := false;
    monde[mondeX].defini := false;
    modif := [gmXY,gmEchelle];
end end;

end.
