unit choixmodeleGlb;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls,
  vcl.HtmlHelpViewer,
  constreg, maths, regutil, uniteKer, compile,
  graphker, modelegr, aidekey;

type
  TChoixModeleGlbDlg = class(TForm)
    AjouteBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PageControl: TPageControl;
    ModManuel: TTabSheet;
    yEdit: TEdit;
    CalculetteBtn: TBitBtn;
    ModMagnum: TTabSheet;
    DroiteBtn: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    NouveauBtn: TBitBtn;
    HelpManuelBtn: TBitBtn;
    helpMagnumBtn: TBitBtn;
    Label4: TLabel;
    SpeedButton6: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DecibelCB: TCheckBox;
    procedure GenreModeleRGClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CalculetteBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AjouteBtnClick(Sender: TObject);
    procedure ModeleBtnClick(Sender: TObject);
    procedure NouveauBtnClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure helpMagnumBtnClick(Sender: TObject);
    procedure HelpManuelBtnClick(Sender: TObject);
    procedure ModeleBtnDblClick(Sender: TObject);
  private
    Procedure MajTexte;
  public
    ModeleChoisi : TgenreModeleGr;
    EffaceModele : boolean;
    AppelMagnum : boolean;
  end;

var
    ChoixModeleGlbDlg: TChoixModeleGlbDlg;

implementation

uses regmain;

{$R *.DFM}

procedure TChoixModeleGlbDlg.GenreModeleRGClick(Sender: TObject);
begin
      MajTexte;
      PageControlChange(sender);
end;

Procedure TChoixModeleGlbDlg.MajTexte;
begin
   with fonctionTheoriqueGlb[succ(nbreModeleGlb)] do begin
      enTete := grandeurs[indexY].nom+'('+grandeurs[indexX].nom+')';
      yedit.text := enTete+'='+expression;
      if pageControl.ActivePage=ModManuel then begin
         yedit.setFocus;
         yedit.selStart := length(yedit.text);
         yedit.selLength := 0;
      end;
end end;

procedure TChoixModeleGlbDlg.AjouteBtnClick(Sender: TObject);
var posErreur,longErreur : integer;

Procedure SetErreur;
begin
   modalResult := mrNone;
   with fonctionTheoriqueGlb[succ(NbreModeleGlb)] do begin
        afficheErreur(codeErreurC,0);
        with yedit do begin
             setFocus;
             selStart := pred(posErreur);
             selLength := longErreur;
        end;
   end;
end;

begin
    EffaceModele := false;
    if pageControl.ActivePage=modManuel then begin
        ModeleChoisi := mgManuel;
        posErreur := 0;
        longErreur := 0;
        codeErreurC := '';
        EffaceModele := false;
        if fonctionTheoriqueGlb[succ(NbreModeleGlb)].compileM(yedit.text,posErreur,longErreur)
           then inc(NbreModeleGlb)
           else setErreur
    end
    else inc(NbreModeleGlb);
end;

procedure TChoixModeleGlbDlg.HelpBtnClick(Sender: TObject);
begin
     if PageControl.activePage=ModManuel
        then Aide(HELP_Modelisation)
        else Aide(HELP_ModelisationGraphique)
end;

procedure TChoixModeleGlbDlg.CalculetteBtnClick(Sender: TObject);
begin
     Aide(HELP_Modelisation)
end;

procedure TChoixModeleGlbDlg.FormActivate(Sender: TObject);
begin
     inherited;
     if NbreModeleGlb>0
        then with fonctionTheoriqueGlb[1] do begin
           if AppelMagnum
             then begin
                 AjouteBtn.caption := stAddModele;
                 NouveauBtn.caption := stReplaceModele;
                 NouveauBtn.visible := true;
                 AjouteBtn.visible := NbreModeleGlb<4;
             end
             else begin
                 AjouteBtn.caption := '&OK';
                 AjouteBtn.visible := true;
                 NouveauBtn.visible := false;
             end;
        end
        else begin
            AjouteBtn.visible := false;
            NouveauBtn.caption := '&OK';
            NouveauBtn.visible := true;
        end;
     MajTexte;
end;

procedure TChoixModeleGlbDlg.ModeleBtnClick(Sender: TObject);
begin
     ModeleChoisi := TgenreModeleGr((sender as Tcomponent).tag)
end;

procedure TChoixModeleGlbDlg.NouveauBtnClick(Sender: TObject);
var posErreur,longErreur : integer;

Procedure SetErreur;
begin
   modalResult := mrNone;
   with fonctionTheoriqueGlb[succ(NbreModeleGlb)] do begin
        afficheErreur(codeErreurC,0);
        with yedit do begin
             setFocus;
             selStart := pred(posErreur);
             selLength := longErreur;
        end;
   end;
end;

begin
    EffaceModele := true;
    if pageControl.ActivePage=ModManuel then begin
        ModeleChoisi := mgManuel;
        posErreur := 0;
        longErreur := 0;
        codeErreurC := '';
        if fonctionTheoriqueGlb[1].compileM(yedit.text,posErreur,longErreur)
           then NbreModeleGlb := 1
           else setErreur
    end
    else begin
       NbreModeleGlb := 1;
       if decibelCB.checked and
            (ord(ModeleChoisi)>=ord(mgPasseBas1)) and
            (ord(ModeleChoisi)<=ord(mgPasseHaut2)) then
            ModeleChoisi := TgenreModeleGr(ord(ModeleChoisi)+4);
    end;
end;

procedure TChoixModeleGlbDlg.PageControlChange(Sender: TObject);
begin
      with fonctionTheoriqueGlb[1] do
      AjouteBtn.visible := (NbreModeleGlb>0) and
                           (NbreModeleGlb<maxIntervalles) and
          ((genreC=g_fonction) and (pageControl.activePage=modMagnum))
end;

procedure TChoixModeleGlbDlg.helpMagnumBtnClick(Sender: TObject);
begin
     Aide(HELP_ModelisationGraphique)
end;

procedure TChoixModeleGlbDlg.helpManuelBtnClick(Sender: TObject);
begin
     Aide(HELP_ModelisationGraphique)
end;

procedure TChoixModeleGlbDlg.ModeleBtnDblClick(Sender: TObject);
begin
     ModeleChoisi := TgenreModeleGr((sender as Tcomponent).tag);
     NouveauBtnClick(sender);
     modalResult := mrOK;
end;

end.
