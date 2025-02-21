unit optcolordlg;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls, SysUtils, Dialogs, ComCtrls, ImgList,
  vcl.HtmlHelpViewer,
  constreg, regutil, compile, graphker, aidekey, System.ImageList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TOptionCouleurDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PageControl: TPageControl;
    PageTS: TTabSheet;
    ModeleTS: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    CourbeTS: TTabSheet;
    Label3: TLabel;
    ResetBtn: TBitBtn;
    Label4: TLabel;
    CourbeSE: TSpinEdit;
    AxeColorCombo: TColorBox;
    CouleurComboCourbe: TColorBox;
    CouleurComboPage: TColorBox;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    ColorBox6: TColorBox;
    ColorBox7: TColorBox;
    ColorBox8: TColorBox;
    LigneComboPage: TComboBoxEx;
    PointComboPage: TComboBoxEx;
    PointComboCourbe: TComboBoxEx;
    TabSheet1: TTabSheet;
    TangenteGB: TGroupBox;
    ReticuleGB: TGroupBox;
    TangenteColor: TColorBox;
    ReticuleColor: TColorBox;
    TangenteCB: TComboBoxEx;
    ReticuleCB: TComboBoxEx;
    PageSE: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    LabelWidth: TLabel;
    WidthEcranSE: TSpinEdit;
    ReperePageRG: TRadioGroup;
    EtiquetteGB: TGroupBox;
    FondColor: TColorBox;
    Label11: TLabel;
    FondReticuleColor: TColorBox;
    Label14: TLabel;
    penWidthAxeSE: TSpinEdit;
    Label15: TLabel;
    TailleTickSE: TSpinEdit;
    MethodeTangenteColor: TColorBox;
    Label16: TLabel;
    ImageCollectionLigne: TImageCollection;
    ImageCollectionPoint: TImageCollection;
    VirtualImageListPoint: TVirtualImageList;
    VirtualImageListLigne: TVirtualImageList;
    procedure FormActivate(Sender: TObject);
    procedure SetModif(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure PointComboPageClick(Sender: TObject);
    procedure LigneComboPageClick(Sender: TObject);
    procedure CouleurComboPageClick(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure ColorModeleCBClick(Sender: TObject);
    procedure PointComboCourbeClick(Sender: TObject);
    procedure CouleurComboCourbeClick(Sender: TObject);
    procedure CourbeSEClick(Sender: TObject);
    procedure PageSEChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    DlgGraphique : TgrapheReg;
    Modification : boolean;
  end;

var
  OptionCouleurDlg: TOptionCouleurDlg;

implementation

uses graphvar, regmain;

{$R *.DFM}

procedure TOptionCouleurDlg.FormActivate(Sender: TObject);
var i : integer;
begin
     inherited;
     PageSE.MaxValue := MaxPagesGr;
     PageSE.Value := 1;
     PageSEChange(Sender);
     CourbeSE.Value := 1;
     CourbeSEClick(Sender);
     TangenteColor.selected := pColorTangente;
     MethodeTangenteColor.selected := CouleurMethodeTangente;
     TangenteCB.itemIndex := ord(PstyleTangente);
     ReticuleColor.selected := pColorReticule;
     FondReticuleColor.selected := FondReticule;
     FondColor.selected := FondReticule;
     ReticuleCB.itemIndex := ord(PstyleReticule);
     widthEcranSE.value := penWidthCourbe;
     penWidthAxeSE.value := penWidthGrid;
     tailleTickSE.value := tailleTick;
     AxeColorCombo.selected := couleurGrille;
     Modification := false;
     reperePageRG.itemIndex := ord(reperePage);
     with ModeleTS do for i := 0 to pred(ControlCount) do
         if controls[i] is TcolorBox
            then with controls[i] as TcolorBox do
                 selected := CouleurModele[tag]
end;

procedure TOptionCouleurDlg.FormCreate(Sender: TObject);
begin
  VirtualImageListPoint.height := VirtualImageListSize;
  VirtualImageListPoint.width := VirtualImageListSize;
  VirtualImageListLigne.height := VirtualImageListSize;
  VirtualImageListLigne.width := VirtualImageListSize;
end;

procedure TOptionCouleurDlg.SetModif(Sender: TObject);
begin
     Modification := true
end;

procedure TOptionCouleurDlg.HelpBtnClick(Sender: TObject);
begin
     aide(HELP_OptionsGraphe)
end;

procedure TOptionCouleurDlg.OKBtnClick(Sender: TObject);
var c,g : integer;
begin
    CouleurGrille := AxeColorCombo.selected;
    pColorTangente := TangenteColor.selected;
    couleurMethodeTangente := MethodeTangenteColor.selected;
    PstyleTangente := TpenStyle(TangenteCB.itemIndex);
    pColorReticule := ReticuleColor.selected;
    FondReticule := FondReticuleColor.selected;
    FondReticule := FondColor.selected;
    PstyleReticule := TpenStyle(ReticuleCB.itemIndex);
    penWidthCourbe := widthEcranSE.value;
    penWidthGrid := penwidthaxeSE.value;
    tailleTick := tailleTickSE.value;
    reperePage := TreperePage(reperePageRG.itemIndex);
    if FgrapheVariab=nil then exit;
    for g := 1 to 3 do with FgrapheVariab.graphes[g] do begin
        for c := 1 to MaxOrdonnee do with coordonnee[c] do begin
           couleur := couleurInit[c];
           motif := motifInit[c];
        end;
        if paintBox.visible then FgrapheVariab.setCoordonnee(g);
    end;
end;

procedure TOptionCouleurDlg.PointComboPageClick(Sender: TObject);
begin
     MotifPages[PageSE.value] := Tmotif(PointComboPage.itemIndex)
end;

procedure TOptionCouleurDlg.LigneComboPageClick(Sender: TObject);
begin
     stylePages[PageSE.value] := TpenStyle(LigneComboPage.itemIndex)
end;

procedure TOptionCouleurDlg.CouleurComboPageClick(Sender: TObject);
begin
     CouleurPages[PageSE.value] := CouleurComboPage.selected;
end;

procedure TOptionCouleurDlg.ResetBtnClick(Sender: TObject);
var i,j : integer;
begin
     for i := 0 to pred(NbreCouleur) do begin
         j := (i mod 4) +1;
         CouleurPages[i] := couleurInit[j];
         MotifPages[i] := motifInit[j];
     end;
end;

procedure TOptionCouleurDlg.ColorModeleCBClick(Sender: TObject);
begin
     with sender as TcolorBox do
        CouleurModele[tag] := selected
end;

procedure TOptionCouleurDlg.PointComboCourbeClick(Sender: TObject);
begin
     MotifInit[CourbeSE.value] := Tmotif(PointComboCourbe.itemIndex);
     if DlgGraphique<>nil then
        DlgGraphique.coordonnee[CourbeSE.value].motif := Tmotif(PointComboCourbe.itemIndex);
     Modification := true;
end;

procedure TOptionCouleurDlg.CouleurComboCourbeClick(Sender: TObject);
begin
     CouleurInit[CourbeSE.value] := CouleurComboCourbe.selected;
     if DlgGraphique<>nil then
        DlgGraphique.coordonnee[CourbeSE.value].couleur := CouleurComboCourbe.selected;
     Modification := true;
end;

procedure TOptionCouleurDlg.CourbeSEClick(Sender: TObject);
var index : integer;
begin
     index := CourbeSE.value;
     CouleurComboCourbe.selected := couleurInit[index];
     PointComboCourbe.itemIndex := ord(motifInit[index]);
end;

procedure TOptionCouleurDlg.PageSEChange(Sender: TObject);
var index : integer;
begin
     index := PageSE.value;
     CouleurComboPage.selected := couleurPages[index];
     LigneComboPage.itemIndex := ord(stylePages[index]);
     PointComboPage.itemIndex := ord(motifPages[index]);
end;

end.
