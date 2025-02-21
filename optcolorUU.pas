unit optcolorUU;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls, SysUtils, Dialogs, ComCtrls,
  ImgList, System.ImageList, regutil, maths;

type
  TCfgOptionCouleurDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    ImagePoint: TImageList;
    ImageLigne: TImageList;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    ListeCourbe: TComboBox;
    PointCombo: TComboBox;
    LigneCombo: TComboBox;
    Label4: TLabel;
    CourbeSE: TSpinEdit;
    PointComboBis: TComboBox;
    LigneComboBis: TComboBox;
    BoldCB: TCheckBox;
    AxeColorCombo: TColorBox;
    CouleurComboBis: TColorBox;
    CouleurCombo: TColorBox;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    ColorBox6: TColorBox;
    ColorBox7: TColorBox;
    ColorBox8: TColorBox;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    TangenteColor: TColorBox;
    TangenteCB: TComboBoxEx;
    GroupBox3: TGroupBox;
    ReticuleColor: TColorBox;
    ReticuleCB: TComboBoxEx;
    FondReticuleColor: TColorBox;
    Label11: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ListeCourbeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListeCourbeClick(Sender: TObject);
    procedure PointComboClick(Sender: TObject);
    procedure LigneComboClick(Sender: TObject);
    procedure ComboDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CouleurComboClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ColorModeleCBClick(Sender: TObject);
    procedure PointComboBisClick(Sender: TObject);
    procedure LigneComboBisClick(Sender: TObject);
    procedure CouleurComboBisClick(Sender: TObject);
    procedure CourbeSEClick(Sender: TObject);
  private
  public
  end;

var
  CfgOptionCouleurDlg: TCfgOptionCouleurDlg;

implementation

uses optionsUU;

{$R *.DFM}

const
 MaxPages = 16;
 CouleurModele: array[-MaxIntervalles..MaxIntervalles] of
    Tcolor = (clTeal, clMaroon, clFuchsia, clNavy, clWhite, clBlue, clRed, clPurple, clGreen);
 CouleurPages: array[0..MaxPages] of
    Tcolor = (clGray, clBlue, clRed, clOlive, clNavy, clPurple, clTeal, clBlack,
      clMaroon, clFuchsia, clBlue, clGray, clAqua,
      clRed, clOlive, clNavy,clGreen);
 MotifPages: array[0..MaxPages] of
    Tmotif = (mCroix, mCroixDiag, mCercle, mCarre, mLosange,mCerclePlein, mCarrePlein,
      mCroix, mCroixDiag, mCercle, mCarre, mLosange, mCerclePlein, mCarrePlein,
      mCroix, mCroixDiag, mCercle);
 TraitPages: array[0..MaxPages] of
    TpenStyle = (psSolid, psDash, psDot, psDashDot, psDashDotDot,
      psSolid, psDash, psDot, psDashDot, psDashDotDot,
      psSolid, psDash, psDot, psDashDot, psDashDotDot,
      psSolid, psDash);
 CouleurInit: array[TindiceOrdonnee] of
    Tcolor = (clBlack, clBlue, clRed, clPurple, clGreen, clNavy);
  MotifInit: array[TindiceOrdonnee] of
    Tmotif = (mCroix, mCroixDiag, mCercle, mCarre, mLosange, mCerclePlein);
  TraitInit: array[TindiceOrdonnee] of
    TpenStyle = (psSolid, psDash, psDot, psDashDot, psDashDotDot, psDot);

procedure TCfgOptionCouleurDlg.FormActivate(Sender: TObject);
var i : integer;
begin
     ListeCourbeClick(Sender);
     CourbeSEClick(Sender);
     AxeColorCombo.selected := couleurAxeX;
     TangenteColor.selected := pColorTangente;
     TangenteCB.itemIndex := ord(PstyleTangente);
     ReticuleColor.selected := pColorReticule;
     FondReticuleColor.selected := FondReticule;
     ReticuleCB.itemIndex := ord(PstyleReticule);
     with tabsheet3 do
     for i := 0 to pred(ControlCount) do
         if controls[i] is TcolorBox
            then with controls[i] as TcolorBox do
                 selected := CouleurModele[tag]
end;

procedure TCfgOptionCouleurDlg.HelpBtnClick(Sender: TObject);
begin
     Application.HelpContext(802)
end;

procedure TCfgOptionCouleurDlg.OKBtnClick(Sender: TObject);
begin
    CouleurAxeX := AxeColorCombo.selected;
    pColorTangente := TangenteColor.selected;
    PstyleTangente := TpenStyle(TangenteCB.itemIndex);
    pColorReticule := ReticuleColor.selected;
    FondReticule := FondReticuleColor.selected;
    PstyleReticule := TpenStyle(ReticuleCB.itemIndex);
end;

procedure TCfgOptionCouleurDlg.ListeCourbeDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin with ListeCourbe.canvas do begin
       Pen.color := clWindow;
       Brush.color := clWindow;
       FillRect(rect);
       Font.Color := couleurPages[index];
       TextOut(rect.left,rect.top,listeCourbe.Items[index]);
end end;

procedure TCfgOptionCouleurDlg.ListeCourbeClick(Sender: TObject);
var index : integer;
begin
     index := listeCourbe.ItemIndex;
     CouleurCombo.selected := couleurPages[index];
     LigneCombo.itemIndex := ord(traitPages[index]);
     PointCombo.itemIndex := ord(motifPages[index]);
end;

procedure TCfgOptionCouleurDlg.PointComboClick(Sender: TObject);
begin
     MotifPages[ListeCourbe.ItemIndex] := Tmotif(PointCombo.itemIndex)
end;

procedure TCfgOptionCouleurDlg.LigneComboClick(Sender: TObject);
begin
     TraitPages[ListeCourbe.ItemIndex] := TpenStyle(LigneCombo.itemIndex)
end;

procedure TCfgOptionCouleurDlg.ComboDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Bmp : Tbitmap;
begin with TcomboBox(Control).Canvas do begin
    { Since we are only drawing over part of the item, make sure }
    { we blank out any old garbage with a foreground rectangle }
    FillRect(Rect);
    Bmp := TBitmap.Create;
    if (control=LigneCombo) or (control=LigneComboBis)
       then ImageLigne.GetBitmap(index,bmp)
       else if (control=pointCombo) or (control=pointComboBis)
           then ImagePoint.GetBitmap(index,bmp)
           else exit;
    { Draw the bitmap, scaled to fit in the fixed height item }
    with Rect, Bmp do
         Right := Trunc(Left + (Bottom - Top) * Width / Height);
    StretchDraw(Rect, Bmp);
    { Invert the item colours if it is selected }
    if odSelected in State then InvertRect(Handle, Rect);
    bmp.free;
end end;

procedure TCfgOptionCouleurDlg.CouleurComboClick(Sender: TObject);
begin
     CouleurPages[ListeCourbe.ItemIndex] := CouleurCombo.selected;
     ListeCourbe.Refresh;
     ListeCourbeClick(Sender);
end;

procedure TCfgOptionCouleurDlg.FormCreate(Sender: TObject);
var i : integer;
begin
     LigneCombo.Clear;
     for i := 0 to pred(ImageLigne.count) do
         LigneCombo.Items.Add('');
     PointCombo.Clear;
     for i := 0 to pred(ImagePoint.count) do
         PointCombo.Items.Add('');
     ListeCourbe.clear;
     ListeCourbe.Items.add('Pages inactives');
     for i := 1 to pred(NbreCouleur) do
         ListeCourbe.Items.add('Page n°'+intTostr(i));
     ListeCourbe.itemIndex := 0;
end;

procedure TCfgOptionCouleurDlg.ColorModeleCBClick(Sender: TObject);
begin
     with sender as TcolorBox do
          CouleurModele[tag] := selected
end;

procedure TCfgOptionCouleurDlg.PointComboBisClick(Sender: TObject);
begin
    MotifInit[CourbeSE.value] := Tmotif(PointComboBis.itemIndex)
end;

procedure TCfgOptionCouleurDlg.LigneComboBisClick(Sender: TObject);
begin
    TraitInit[CourbeSE.value] := TpenStyle(LigneComboBis.itemIndex)
end;

procedure TCfgOptionCouleurDlg.CouleurComboBisClick(Sender: TObject);
begin
    CouleurInit[CourbeSE.value] := CouleurComboBis.selected
end;

procedure TCfgOptionCouleurDlg.CourbeSEClick(Sender: TObject);
var index : integer;
begin
     index := CourbeSE.value;
     CouleurComboBis.selected := couleurInit[index];
     LigneComboBis.itemIndex := ord(traitInit[index]);
     PointComboBis.itemIndex := ord(motifInit[index]);
end;

end.
