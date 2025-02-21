unit optline;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Messages, Dialogs, ImgList, ComCtrls, Spin,
  vcl.HtmlHelpViewer,
  Constreg, regutil, uniteKer, graphker, selpage, compile, maths,
  system.UITypes, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TOptionLigneDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PenBar: TPanel;
    PenSize: TLabel;
    PenWidth: TScrollBar;
    CouleurCombo: TColorBox;
    OptionsRG: TRadioGroup;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    LigneCombo: TComboBoxEx;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Xcb: TComboBox;
    Ycb: TComboBox;
    MotifRG: TRadioGroup;
    Label1: TLabel;
    SpinEditWidth: TSpinEdit;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ListeVar : TstrListe;
  public
    DessinLoc : Tdessin;
    Agraphe : TgrapheReg;
  end;

var
  OptionLigneDlg: TOptionLigneDlg;

implementation

{$R *.DFM}

procedure TOptionLigneDlg.FormActivate(Sender: TObject);
var i : integer;
    code : integer;
begin
inherited;
 with dessinLoc do begin
        CouleurCombo.selected := pen.color;
        LigneCombo.itemIndex := ord(pen.style);
        optionsRG.ItemIndex := ord(texteLigne);
        SpinEditWidth.Value := pen.width;
        SpinEditHauteur.text := IntToStr(hauteur);
        ListeVar.Clear;
        ListeVar.add('désactivé');
        for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
            if (genreG=constante) or (genreG=constanteGlb) then ListeVar.add(nom);
        end;
        for i := 1 to NbreParam[ParamNormal] do
            ListeVar.add(Parametres[paramNormal,i].nom);
        for i := 1 to NbreParam[ParamGlb] do
            ListeVar.add(Parametres[paramGlb,i].nom);
        Xcb.items := listeVar;
        Ycb.items := listeVar;
        code := listeVar.MyIndexOf(nomX);
        if code<0 then code := 0;
        Xcb.itemIndex := code;
        code := listeVar.MyIndexOf(nomY);
        if code<0 then code := 0;
        Ycb.itemIndex := code;
        case motifTexte of
             mtFleche : motifRG.itemIndex := 1;
             mtDoubleFleche : motifRG.itemIndex := 2;
             else motifRG.itemIndex := 0;
        end;
end end;

procedure TOptionLigneDlg.FormCreate(Sender: TObject);
begin
    ListeVar := TstrListe.create;
    VirtualImageList1.height := VirtualImageListSize;
    VirtualImageList1.width := VirtualImageListSize;
end;

procedure TOptionLigneDlg.FormDestroy(Sender: TObject);
begin
  inherited;
     ListeVar.free;
end;

procedure TOptionLigneDlg.OKBtnClick(Sender: TObject);
begin with DessinLoc do begin
       CouleurLigne := CouleurCombo.selected;
       pen.color := CouleurLigne;
       pen.width := SpinEditWidth.Value;
       hauteur := StrToInt(SpinEditHauteur.text);
       pen.style := TpenStyle(LigneCombo.itemIndex);
       texteLigne := TtexteLigne(optionsRG.ItemIndex);
       if (optionsRG.itemIndex=0) and
          (sousDessin<>nil) then begin
            with Agraphe.dessins do Remove(sousDessin);
            SousDessin := nil;            
       end;
       if Xcb.itemIndex>0 then nomX := listeVar[Xcb.itemIndex];
       if Ycb.itemIndex>0 then nomY := listeVar[Ycb.itemIndex];
       motifTexte := mtNone;
       if motifRG.itemIndex=1 then motifTexte := mtFleche;
       if motifRG.itemIndex=2 then motifTexte := mtDoubleFleche;
end end;

end.
