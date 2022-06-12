unit coordEuler;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls,
  Constreg, regutil, uniteKer, compile, graphker, selpage, Spin,
  CheckLst, System.ImageList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
TFcoordonneesEuler = class(TForm)
    Panel1: TPanel;
    GroupBoxOptions: TGroupBox;
    OrthonormeCB: TCheckBox;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    AbscisseGB: TGroupBox;
    LabelZeroX: TLabel;
    ListeX: TComboBox;
    ZeroXCB: TCheckBox;
    OrdonneeGB: TGroupBox;
    labelZeroY: TLabel;
    ListeY: TComboBox;
    ZeroYCB: TCheckBox;
    OptionsGB: TGroupBox;
    LabelDimPoint: TLabel;
    DimPointSE: TSpinEdit;
    PointCombo: TComboBoxEx;
    OldParamCB: TCheckBox;
    LabelWidth: TLabel;
    WidthEcranSE: TSpinEdit;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListeXChange(Sender: TObject);
    procedure ListeYChange(Sender: TObject);
  private
    ListeVar : TstrListe;
    Procedure majOptions;
  public
     Transfert : TtransfertGraphe;
  end;

var
  FcoordonneesEuler: TFcoordonneesEuler;

implementation

uses Valeurs, optionsVitesse, options;

{$R *.DFM}

procedure TFcoordonneesEuler.OKBtnClick(Sender: TObject);
begin with transfert do begin
     DimPointVGA := DimPointSE.value;
     Motif[1] := Tmotif(PointCombo.itemIndex);
     zero[mondeX] := zeroXCB.checked;
     zero[mondeY] := zeroYCB.checked;
     if OrthonormeCB.checked and OrthonormeCB.visible
         then include(Transfert.OptionGr,OgOrthonorme)
         else exclude(Transfert.OptionGr,OgOrthonorme);
end end;

procedure TFcoordonneesEuler.FormActivate(Sender: TObject);
var i : byte;
    cx,cy : integer;
begin with transfert do begin
    DimPointSE.Value := DimPointVGA;
    ListeVar.Clear;
    for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
        if genreG=variable then ListeVar.add(nom);
    ListeX.items := listeVar;
    ListeY.items := listeVar;
    cY := ListeVar.MyIndexOf(nomY[1]);
    cX := listeVar.MyIndexOf(nomX[1]);
    if cX<0 then nomX[1] := getNomCoord(listeVar[0]);
    if cY<0 then nomY[1] := getNomCoord(listeVar[1]);
    OrthonormeCB.checked := OgOrthonorme in OptionGr;
    MajOptions;
    zeroXCB.checked := zero[mondeX];
    zeroYCB.checked := zero[mondeY];
    OrthonormeCB.enabled := true;
    listeX.text := nomX[1];
    listeY.itemIndex := ListeVar.MyIndexOf(nomY[1]);
    listeX.itemIndex := listeVar.MyIndexOf(nomX[1]);
    AbscisseGB.Caption := stAbscisse;
    OrdonneeGB.Caption := stOrdonnee;
    PointCombo.itemIndex := ord(motif[1]);
end end;// FormActivate

procedure TFcoordonneesEuler.MajOptions;
var indexX,indexY : integer;
begin with transfert do begin
      indexX := indexNom(nomX[1]);
      if indexX=grandeurInconnue then begin
         indexX := 1;
         nomX[1] := getNomCoord(listeVar[indexX]);
      end;
      indexY := indexNom(nomY[1]);
      if indexY=grandeurInconnue then begin
         indexY := 2;
         nomY[1] := getNomCoord(listeVar[indexY]);
      end;
      OptionsGB.Caption := 'Options de représentation de '+
         nomY[1]+'('+
         nomX[1]+')';
      OrthonormeCB.Visible := grandeurs[indexX].nomUnite=grandeurs[indexY].nomUnite;
end end; // MajOptions

procedure TFcoordonneesEuler.FormCreate(Sender: TObject);
begin
    ListeVar := TstrListe.create;
    Transfert := TtransfertGraphe.Create;
end;

procedure TFcoordonneesEuler.FormDestroy(Sender: TObject);
begin
    ListeVar.free;
    Transfert.free;
    inherited
end;

procedure TFcoordonneesEuler.ListeXChange(Sender: TObject);
begin
    transfert.nomX[1] := getNomCoord(listeX.text);
    MajOptions;
end;

procedure TFcoordonneesEuler.ListeYChange(Sender: TObject);
begin
    transfert.nomY[1] := getNomCoord(listeY.text);
    MajOptions;
end;

end.
