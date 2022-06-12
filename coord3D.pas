unit coord3D;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls, CheckLst, spin, maths,
  Constreg, regutil, uniteKer, compile, graphker, aidekey,
  system.Contnrs, System.ImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.VirtualImageList;

type
TFcoordonnees3D = class(TForm)
    BoutonsPanel: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CoordPanel: TPanel;
    AbscisseGB: TGroupBox;
    LabelZeroX: TLabel;
    ListeX: TComboBox;
    ZeroXCB: TCheckBox;
    OrdonneeGB: TGroupBox;
    labelZeroY: TLabel;
    ListeY: TComboBox;
    ZeroYCB: TCheckBox;
    OptionsGB: TGroupBox;
    CouleurCombo: TColorBox;
    CoteGB: TGroupBox;
    Label1: TLabel;
    ListeZ: TComboBox;
    ZeroZCB: TCheckBox;
    LabelWidth: TLabel;
    WidthEcranSE: TSpinEdit;
    YParamCB: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure YParamCBClick(Sender: TObject);
  private
    ListeVar,ListeConst : TstrListe;
  public
  end;

var
  Fcoordonnees3D: TFcoordonnees3D;

implementation

uses graph3D;

{$R *.DFM}

procedure TFcoordonnees3D.OKBtnClick(Sender: TObject);
begin with fGraphe3D.coordonnee do begin
     penWidthVGA := widthEcranSE.value;
     couleur := CouleurCombo.selected;
     nomX := getNomCoord(listeX.text);
     nomY := getNomCoord(listeY.text);
     nomZ := getNomCoord(listeZ.text);
end end;

procedure TFcoordonnees3D.FormActivate(Sender: TObject);
var i : integer;
    cx,cy,cz : integer;
begin with fGraphe3D.coordonnee do begin
    widthEcranSE.value := penWidthVGA;
    ListeVar.Clear;
    ListeConst.Clear;
    for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
        if genreG=constante then ListeConst.add(nom);
        if genreG=variable then ListeVar.add(nom);
    end;
    for i := 1 to NbreParam[ParamNormal] do
        ListeConst.add(Parametres[paramNormal,i].nom);
    if nbreVariab<=3
      then begin
         YParamCB.Checked := true;
         YParamCB.enabled := false;
      end
      else YParamCB.enabled := true;
    ListeX.items := listeVar;
    if YparamCB.checked
       then ListeY.items := listeConst
       else ListeY.items := listeVar;
    ListeZ.items := listeVar;
    cX := listeVar.MyIndexOf(nomX);
    cZ := listeVar.MyIndexOf(nomZ);
    if YparamCB.checked
       then begin
          cY := ListeConst.MyIndexOf(nomY);
          if cX<0 then nomX := getNomCoord(listeVar[0]);
          if cY<0 then nomY := getNomCoord(listeConst[0]);
          if cZ<0 then nomZ := getNomCoord(listeVar[1]);
       end
       else begin
          cY := ListeVar.MyIndexOf(nomY);
          if cX<0 then nomX := getNomCoord(listeVar[0]);
          if cY<0 then nomY := getNomCoord(listeVar[1]);
          if cZ<0 then nomZ := getNomCoord(listeVar[2]);
       end;
    listeX.ItemIndex := listeVar.MyIndexOf(nomX);
    if YparamCB.checked
       then listeY.ItemIndex := listeConst.MyIndexOf(nomY)
       else listeY.ItemIndex := listeVar.MyIndexOf(nomY);
    listeZ.ItemIndex := listeVar.MyIndexOf(nomZ);
    listeX.text := nomX;
    listeY.text := nomY;
    listeZ.text := nomZ;
    CouleurCombo.selected := Couleur;
    if trace=[] then
         if (ModeAcquisition=AcqSimulation)
         then trace := [trLigne]
         else if pages[pageCourante].nmes>256
                then trace := [trLigne] // sinon illisible
                else trace := [trPoint]; // points entrés à la main
end end; // FormActivate

procedure TFcoordonnees3D.YParamCBClick(Sender: TObject);
var cY : integer;
begin with fGraphe3D.coordonnee do begin
     if YparamCB.checked then begin
         ListeY.items := listeConst;
         cY := ListeConst.MyIndexOf(nomY);
         if cY<0 then nomY := getNomCoord(listeConst[0]);
         listeY.ItemIndex := listeConst.MyIndexOf(nomY)
     end
     else begin
         ListeY.items := listeVar;
         cY := ListeVar.MyIndexOf(nomY);
         if cY<0 then nomY := getNomCoord(listeVar[0]);
         listeY.ItemIndex := listeVar.MyIndexOf(nomY)
     end;
end end;

procedure TFcoordonnees3D.FormCreate(Sender: TObject);
begin
  ListeVar := TstrListe.create;
  ListeConst := TstrListe.create;
end;

procedure TFcoordonnees3D.FormDestroy(Sender: TObject);
begin
     ListeVar.free;
     listeConst.Free;
     inherited
end;

end.
