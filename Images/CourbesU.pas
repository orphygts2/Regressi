unit CourbesU;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Printers, Math, Vcl.ComCtrls, clipbrd,
  Menus, Spin, ImgList, ToolWin, grids, inifiles,
  system.Types, System.ImageList, system.UITypes,
  Vcl.Mask, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList, Vcl.HtmlHelpViewer,

  jpeg, pngimage, gifImg,

  constreg, grapheU, regUtil;

const
   maxObjet = 6;

type
  TindiceObjet = 1..maxObjet;
  Techelle = (eLin,eLog,ePolaire);

  TCourbesForm = class(TForm)
    StatusBar: TStatusBar;
    Splitter: TSplitter;
    GridPanel: TPanel;
    Panel3: TPanel;
    ZoomEdit: TEdit;
    SerieLabel: TLabel;
    SerieSE: TSpinEdit;
    Grid: TStringGrid;
    ToolBar: TToolBar;
    FileBtn: TToolButton;
    RazBtn: TToolButton;
    UndoBtn: TToolButton;
    SupprBtn: TToolButton;
    ExiBtn: TToolButton;
    RegressiBtn: TToolButton;
    MesureBtn: TToolButton;
    EchelleBtn: TToolButton;
    EditBidon: TEdit;
    OpenDialog: TOpenDialog;
    SignifEdit: TLabeledEdit;
    NbreSE: TSpinEdit;
    Label1: TLabel;
    AideBtn: TToolButton;
    GroupBox1: TGroupBox;
    CouleurPointsCB: TColorBox;
    LoupeBtn: TToolButton;
    zoomUD: TSpinEdit;
    TimerMove: TTimer;
    PaintBox: TPaintBox;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    GroupBox2: TGroupBox;
    CouleurAxeCB: TColorBox;
    AutoBtn: TToolButton;
    CouleurCibleP: TPanel;
    PythonBtn: TToolButton;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImagePaint(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditBidonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EchelleBtnClick(Sender: TObject);
    procedure OpenFileBtnClick(Sender: TObject);
    procedure MesureBtnClick(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure CouleurPointsCBChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure SupprBtnClick(Sender: TObject);
    procedure SplitterMoved(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SerieSEChange(Sender: TObject);
    procedure SignifEditChange(Sender: TObject);
    procedure NbreSEChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure AideBtnClick(Sender: TObject);
    procedure TimerMoveTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AutoBtnClick(Sender: TObject);
    procedure PythonBtnClick(Sender: TObject);
  private
    penWidth : integer;
    e_PointRepere : TarrayPoint;
    PointRepere : TarrayPoint;
    BorneSelect,oldBorne : TstyleDrag;
    pointCourant,objetCourant : integer;
    oldStatus : String;
// Vignette
    pasZoom : double;
    objetSelect : integer;
    NbreObjet : integer;
    arrondiX,arrondiY : double;
    XY : array[TindiceObjet,0..maxPixel] of Tpoint;
    Signif : array[TindiceObjet] of String;
    PenteX,PenteY : double;
    ZeroX,ZeroY : double;
    NbrePoints : array[TindiceObjet] of integer;
    NomFichier : String;
    Couleur : array[0..maxObjet] of Tcolor; // 0 pour axe
    Abitmap,bitmapLoupe : Tbitmap;
    Largeur,Hauteur : integer;
    LargeurAff,HauteurAff : integer;
    BlueCible,RedCible,GreenCible : integer;
    couleurFond : TColor;
    BlueFond,RedFond,GreenFond : integer;
    Ymax,Ymin,Xmax,Xmin  : integer;
    Procedure envoieDonneesReg;
    Function GetBorne(x,y : integer) : TstyleDrag;
    Function PointProche(x,y : Integer) : integer;
    Procedure AffecteBorne(x,y : integer);
    procedure EcranVersImage;
    Procedure AjoutePoint(x,y : integer);
    Procedure SupprimePoint(x,y : integer);
    procedure OuvreFichier(const Nom: String);
    Procedure setEchelle;
    Function StrX(j : TindiceObjet;i : integer) : String;
    Function StrY(j : TindiceObjet;i : integer) : String;
    procedure TraceGrid;
    procedure ConvertitXY(Sender: TObject;var X, Y: Integer);
    procedure cacheLoupe;
    procedure SetCurseur(Acursor : Tcursor);
    procedure effectueModeAuto;
    procedure choixCibleAuto(X, Y: Integer);
  public
    MaxiX,MaxiY : double;
    MiniX,MiniY : double;
    echelleX,echelleY : Techelle;
    orthonorme : boolean;
    modifierPointCourant : boolean;
  end;

var
  CourbesForm: TCourbesForm;

implementation

uses courbesEch, regdde, compile, regmain, graphvar, loupeU, aidekey, maths;

const
      Rayon = 5;
      SizeData = 4;
      marge = 5;
       // echelle1 = X : echelle2 = Y
      Titre = 'CourbesBMP';

{$R *.DFM}

procedure TCourbesForm.FormCreate(Sender: TObject);
var i : tstyleDrag;
    j,w : integer;
    Fichier : TIniFile;
begin
    couleurCibleP.Visible := false;
    NbreSE.MaxValue := maxObjet;
    NbreObjet := 1;
    NomFichier := '';
    for i := low(TstyleDrag) to high(TstyleDrag) do
        PointRepere[i] := point(0,0);
    MaxiX := 1;
    MaxiY := 1;
    MiniX := 0;
    MiniY := 0;
    echelleX := eLin;
    echelleY := eLin;
    Abitmap := Tbitmap.create;
    Fichier := TIniFile.create(NomFichierIni);
    for j := 0 to maxObjet do
        Couleur[j] := Fichier.readInteger(Titre,stCouleur+intToStr(j),clRed);
    CouleurPointsCB.selected := Couleur[1];
    CouleurAxeCB.selected := couleur[0];
    if echelleBmpDlg=nil then Application.CreateForm(TechelleBmpDlg,echelleBmpDlg);
    MaxiX := 10;
    MaxiY := 10;
    MiniX := 0;
    MiniY := 0;
    with echelleBmpDlg do begin
         uniteX.text := Fichier.readString(Titre,'UniteX','m');
         uniteY.text := Fichier.readString(Titre,'UniteY','m');
         editX.text := Fichier.readString(Titre,'EditX','m');
         editY.text := Fichier.readString(Titre,'EditY','m');
         modifierPointCourant := Fichier.readBool(Titre,'ModifPoint',true);
         modifPointCB.checked := modifierPointCourant;
    end;
    Fichier.free;
    bitmapLoupe := Tbitmap.create;
    bitmapLoupe.pixelFormat := pf24bit;
    if LoupeForm=nil then
       Application.CreateForm(TLoupeForm, LoupeForm);
    LoupeForm.paintBox.onMouseUp := imageMouseUp;
    LoupeForm.paintBox.onMouseDown := imageMouseDown;
    LoupeForm.paintBox.onMouseMove := imageMouseMove;
    LoupeForm.onKeyDown := editBidonKeyDown;
    LoupeForm.Hide;
    EchelleBtn.enabled := false;
    MesureBtn.Enabled := false;
    UndoBtn.enabled := false;
    RegressiBtn.enabled := false;
    Grid.DefaultRowHeight := hauteurColonne;
    w := (Grid.Width-8) div (2*NbreSE.value);
    if (w<64) and (NbreSE.value>1) then
        w := (Grid.Width-8) div 2;
    Grid.DefaultColWidth := w;
    VirtualImageList1.height := VirtualImageListSize;
    VirtualImageList1.width := VirtualImageListSize;
end;

procedure TCourbesForm.ChoixCibleAuto(x,y : integer);

function InitMesure : boolean;
var
    Lcouleur : TRGBtriple;
    xCible,yCible : integer;
    scanLine : pRGBTripleArray;
begin
     result := false;
     xCible := round(pointRepere[bsChronoInit].x);
     if (xcible<Xmin) or (xcible>Xmax) then exit;
     yCible := round(pointRepere[bsChronoInit].y);
     if (ycible<Ymin) or (ycible>Ymax) then exit;
     scanLine := Abitmap.scanLine[yCible];
     Lcouleur := scanLine[xCible];
     RedCible := Lcouleur.rgbtRed;
     BlueCible := Lcouleur.rgbtBlue;
     GreenCible := Lcouleur.rgbtGreen;
     result := true;
end; // initMesure

begin
  if initMesure then begin
     borneSelect := bsChrono;
     setCurseur(crNone);
     PaintBox.hint := hChronoEnCours;
     effectueModeAuto;
  end;
end; //ChoixCibleAuto

procedure TCourbesForm.effectueModeAuto;

procedure chercheUnPoint(xc : integer;var yprec : integer);
var ecart,ecartMin : integer;
    yc,y0 : integer;
    couleurC :  TRGBtriple;
    scanLine : pRGBTripleArray;
begin
    EcartMin := 50;
    y0 := 0;
    for yc := Ymin to Ymax do begin
        scanLine := Abitmap.scanLine[yc];
        couleurC := scanLine[xc];
        ecart := abs(BlueCible-couleurC.rgbtBlue)+
                 abs(GreenCible-couleurC.rgbtGreen)+
                 abs(RedCible-couleurC.rgbtRed);
        // test couleur=couleurCible
        if (y0>0) and (abs(ecart-ecartMin)<4)  then begin
            if abs(y0-yprec)>abs(yc-yprec) then begin
               y0 := yc;
               ecartMin := ecart;
            end;
        end
        else if ecart<ecartMin then begin
            ecartMin := ecart;
            y0 := yc;
        end
    end; // for yc
    if y0>0 then begin
       XY[ObjetCourant,NbrePoints[ObjetCourant]] := point(xc,y0);
       inc(NbrePoints[ObjetCourant]);
       yprec := y0;
    end;
end; // chercheMobile

var xx, pasXX, yprec : integer;
begin
    pasXX := (Xmax-Xmin) div 64;
    if pasXX<2 then pasXX := 2;
    xx := Xmin+2;
    yprec := 0;
    while xx<=xMax do begin
        chercheUnPoint(xx,yprec);
        inc(xx,pasXX);
    end;
    PaintBox.refresh;
    traceGrid;
    if objetCourant<NbreSE.value then begin
       inc(objetCourant);
       serieSE.Value := objetCourant;
       ShowMessage('Sélectionnez la couleur de la courbe suivante');
       setCurseur(crCible);
       BorneSelect := bsChronoInit;
    end
    else begin
       BorneSelect := bsNone;
       setCurseur(crDefault);
       EchelleBtn.enabled := true;
       MesureBtn.Down := false;
       MesureBtn.Hint :=  hStartMes;
       MesureBtn.imageIndex := 9;
       MesureBtn.Caption := 'Mesures';
       RazBtn.enabled := true;
       RegressiBtn.enabled := true;
       CouleurCibleP.Visible := false;
    end;
end; // effectueModeleAuto

procedure TCourbesForm.RegressiBtnClick(Sender: TObject);
begin
   BorneSelect := bsNone;
   UndoBtn.enabled := false;
   EchelleBtn.enabled := true;
   statusBar.Panels[0].text := hTransfertRegressi;
   MesureBtn.Hint :=  hStartMes;
   MesureBtn.imageIndex := 9;
   MesureBtn.Caption := 'Mesures';
   EnvoieDonneesReg;
end;

procedure TCourbesForm.EnvoieDonneesReg;

Procedure AjouteOptionGr;
var j : integer;
begin
     formDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMX');
     if NbreObjet=1
         then formDDE.donnees.add(EchelleBmpDlg.nomX.text)
         else for j := 1 to NbreObjet do
              formDDE.donnees.add(EchelleBmpDlg.nomX.text+intToStr(j));
     if echelleX=eLog then begin
        formDDE.donnees.Add(symbReg2+'1 LOGX');
        formDDE.donnees.Add(intTostr(ord(true)));
     end;
     formDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMY');
     if NbreObjet=1
        then formDDE.donnees.add(EchelleBmpDlg.nomY.text)
        else for j := 1 to NbreObjet do
             formDDE.donnees.add(EchelleBmpDlg.nomY.text+intToStr(j));
     if echelleY=eLog then begin
        formDDE.donnees.Add(symbReg2+intToStr(NbreObjet)+' LOGY');
        for j := 1 to nbreObjet do
            formDDE.donnees.Add(IntToStr(ord(true)));
     end;
     formDDE.donnees.add('&1 FICHIER');
     formDDE.donnees.add(NomFichier);
end;

var ligne : String;
    i,j,N : integer;
begin
     Screen.Cursor := crHourGlass;
     formDDE.donnees.Clear;
     formDDE.donnees.add(Application.exeName);
     if pageCourante=0
          then formDDE.donnees.add('Lecture de courbes')
          else formDDE.donnees.add('');
     formDDE.donnees.add('Lecture de courbes');
     ligne := 'index';
     if NbreObjet=1
        then begin
            ligne := ligne+crTab+EchelleBmpDlg.nomX.text;
            ligne := ligne+crTab+EchelleBmpDlg.nomY.text;
        end
        else for j := 1 to NbreObjet do begin
           ligne := ligne+crTab+EchelleBmpDlg.nomX.text+intToStr(j);
           ligne := ligne+crTab+EchelleBmpDlg.nomY.text+intToStr(j);
        end;
     formDDE.donnees.add(ligne);
     ligne := '';
     N := 0;
     for j := 1 to NbreObjet do begin
         ligne := ligne+crTab+EchelleBmpDlg.uniteX.text;
         ligne := ligne+crTab+EchelleBmpDlg.uniteY.text;
         if NbrePoints[j]>N then N := NbrePoints[j];
     end;
     formDDE.donnees.add(ligne);
     ligne := 'index';
     for j := 1 to NbreObjet do begin
         ligne := ligne+crTab+signif[j];
         ligne := ligne+crTab+signif[j];
     end;
     formDDE.donnees.add(ligne);
     for i := 0 to pred(N) do begin
         ligne := intToStr(i+1);
         for j := 1 to NbreObjet do begin
             ligne := ligne+crTab+strx(j,i);
             ligne := ligne+crTab+stry(j,i);
         end;
         formDDE.donnees.add(ligne);
     end;
     if pageCourante=0 then AjouteOptionGr;
     if pageCourante=0
         then with FregressiMain do begin
             grandeursOpen;
             grapheOpen;
             if FormDDE.ImporteDonnees then begin
                ModifConfigAcq := SaveConfigAcq;
                FocusAcquisitionBtn.visible := true;
             end
         end
         else FormDDE.AjouteDonnees;
     ModeAcquisition := AcqCourbes;
     Screen.Cursor := crDefault;
     Close;
end;

Procedure TCourbesForm.SetEchelle;
var PixelX,PixelY : double;
begin
       if (PointRepere[bsEchelle2].y<0) and not orthonorme then
              PointRepere[bsEchelle2].y := 0;
       if (PointRepere[bsEchelle2].y>hauteur) and not orthonorme then
              PointRepere[bsEchelle2].y := hauteur;
       if (PointRepere[bsEchelle1].x>largeur) and not orthonorme then
              PointRepere[bsEchelle1].x := largeur;
       if (PointRepere[bsEchelle1].x<0) and not orthonorme then
              PointRepere[bsEchelle1].x := 0;
       PixelX := PointRepere[bsEchelle1].x-PointRepere[bsOrigine].x;
       PixelY := PointRepere[bsEchelle2].y-PointRepere[bsOrigine].y;
       case echelleX of
          eLog : begin
             penteX := log10(MaxiX/MiniX)/PixelX;
             zeroX := PointRepere[bsOrigine].x;
             if maxiX>miniX
                then arrondiX := power(10,floor(log10(miniX)-1))
                else arrondiX := power(10,floor(log10(maxiX)-1));
             // xr := minix*10^(xi-zeroX) ; xi := zerox+log10(xr/miniX)
          end;
          eLin,ePolaire : begin
             penteX := (MaxiX-MiniX)/PixelX;
             zeroX := PointRepere[bsOrigine].x;
             ArrondiX := power(10,floor(log10(abs(penteX))));
          end;
       end;
       case echelleY of
          eLog : begin
             penteY := log10(MaxiY/MiniY)/PixelY;
             zeroY := PointRepere[bsOrigine].y;
             if maxiY>miniY
                then arrondiY := power(10,floor(log10(miniY)-1))
                else arrondiY := power(10,floor(log10(maxiY)-1));
          end;
          eLin,ePolaire : begin
             if orthonorme
                then penteY := penteX
                else penteY := (MaxiY-MiniY)/PixelY;
             zeroY := PointRepere[bsOrigine].y;
             ArrondiY := power(10,floor(log10(abs(penteY))));
          end;
       end;
       PaintBox.refresh;
       traceGrid;
end;

Function TCourbesForm.GetBorne(x,y : integer) : TstyleDrag;
var i : TstyleDrag;
begin
      result := bsNone;
      for i in [bsOrigine,bsEchelle1,bsEchelle2] do
          if sqrt(sqr(x-e_PointRepere[i].x)+sqr(y-e_PointRepere[i].y)) < Magnet
                then begin
                     result := i;
                     break;
                end;
end;

Procedure TCourbesForm.AffecteBorne(x,y : integer);
var delta : single;

Procedure setOrtho;
begin
        case BorneSelect of
           bsOrigine :  begin
               e_PointRepere[bsEchelle1] := e_PointRepere[bsOrigine];
               e_PointRepere[bsEchelle1].offset(delta,0);
               e_PointRepere[bsEchelle2] := e_PointRepere[bsOrigine];
               e_PointRepere[bsEchelle2].offset(0,-delta);
           end;
           bsEchelle1 : begin
               delta := e_PointRepere[bsEchelle1].x-e_PointRepere[bsOrigine].x;
               e_PointRepere[bsEchelle2] := e_PointRepere[bsOrigine];
               e_PointRepere[bsEchelle2].offset(0,-delta);
           end;
           bsEchelle2 : begin
               delta := e_PointRepere[bsEchelle1].y-e_PointRepere[bsOrigine].y;
               e_PointRepere[bsEchelle1] := e_PointRepere[bsOrigine];
               e_PointRepere[bsEchelle1].offset(delta,0);
           end;
        end; // case
end;

begin
    if x<0 then x := 0;
    if y<0 then y := 0;
    if y>hauteurAff-marge then y := hauteurAff-marge;
    if x>largeurAff-marge then x := largeurAff-marge;
    e_PointRepere[BorneSelect] := pointF(x,y);
    delta := e_PointRepere[bsEchelle1].x-e_PointRepere[bsOrigine].x;
    case BorneSelect of
        bsOrigine : begin
           e_PointRepere[bsEchelle1].y := e_PointRepere[bsOrigine].y;
           e_PointRepere[bsEchelle2].x := e_PointRepere[bsOrigine].x;
        end;
        bsEchelle1 : e_PointRepere[bsOrigine].y := e_PointRepere[bsEchelle1].y;
        bsEchelle2 : e_PointRepere[bsOrigine].x := e_PointRepere[bsEchelle2].x;
    end; // case
    if orthonorme then setOrtho;
    EcranVersImage;
    PaintBox.repaint;
    TimerMove.enabled := true;
end; // AffecteBorne

procedure TCourbesForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   convertitXY(sender,x,y);
   case BorneSelect of
      bsMesure : begin
         pointCourant := pointProche(x,y);
         if pointCourant>=0
         then begin
             setCurseur(crCibleMove);
             hint := hDeplacerPoint;
         end
         else begin
             setCurseur(crCible);
             hint := hRepererPoint;
         end;
         exit;
      end;
      bsChronoInit : exit;
      bsSuppr : exit;
   end;
   BorneSelect := GetBorne(x,y);
   case borneSelect of
      bsNone : begin
         setCurseur(crCible);
         e_PointRepere[bsNone] := point(x,y);
         ecranVersImage;
      end;
      bsOrigine : setCurseur(crOrigine);
      bsEchelle1,bsEchelle2 : setCurseur(crCibleMove);
      else setCurseur(crDrag);
   end;
end;

procedure TCourbesForm.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

procedure Loupe;
var gainLoupe,largeurLoupe,hauteurLoupe : integer;
    Xleft,Xright,Ytop,Ybottom : integer;

procedure reperage;
begin
    LoupeForm.PaintBox.canvas.pen.color := couleurAxeCB.selected;
    LoupeForm.PaintBox.canvas.brush.Color := couleurAxeCB.selected;
    LoupeForm.PaintBox.canvas.brush.style := bsSolid;

    LoupeForm.PaintBox.canvas.moveto(0,LoupeForm.height div 2);
    LoupeForm.PaintBox.canvas.lineto(LoupeForm.width div 3,LoupeForm.height div 2);
    LoupeForm.PaintBox.canvas.moveto(2*LoupeForm.width div 3,LoupeForm.height div 2);
    LoupeForm.PaintBox.canvas.lineto(LoupeForm.width,LoupeForm.height div 2);

    LoupeForm.PaintBox.canvas.moveto(LoupeForm.width div 2,0);
    LoupeForm.PaintBox.canvas.lineto(LoupeForm.width div 2,LoupeForm.height div 3);
    LoupeForm.PaintBox.canvas.moveto(LoupeForm.width div 2,2*LoupeForm.height div 3);
    LoupeForm.PaintBox.canvas.lineto(LoupeForm.width div 2,LoupeForm.height);

    LoupeForm.PaintBox.canvas.FillRect(rect(
       (LoupeForm.width div 2)-1,(LoupeForm.height div 2)-1,
       (LoupeForm.width div 2)+1,(LoupeForm.height div 2)+1));
end;

procedure Efface;
begin
     if (Ybottom>0) or (Ytop>0) or  (Xleft>0) or (Xright>0) then begin
        LoupeForm.PaintBox.canvas.brush.Color := LoupeForm.transparentColorValue;
        LoupeForm.PaintBox.canvas.brush.style := bsSolid;
     end;
     if (Ytop>0) or (ybottom>0) then
        LoupeForm.PaintBox.canvas.FillRect(rect(0,ytop,LoupeForm.width,ybottom));
     if (xleft>0) or (xright>0) then
        LoupeForm.PaintBox.canvas.FillRect(rect(xleft,0,xright,LoupeForm.height));
end;

var
   X1,Y1,X2,Y2 : integer;
   decaleX,decaleY : integer;
   aPoint : TPoint;
begin
   PaintBox.OnMouseMove := nil;
   loupeForm.paintBox.OnMouseMove := nil; // mise à jour longue ...
   gainLoupe := zoomUD.Value;
   largeurLoupe := LoupeForm.width div (gainLoupe);
   hauteurLoupe := LoupeForm.height div (gainLoupe);
   X1 := X-largeurLoupe div 2;
   Y1 := Y-hauteurLoupe div 2;
   X2 := X+largeurLoupe div 2;
   Y2 := Y+hauteurLoupe div 2;
   Xleft := 0;Xright := 0;
   Ytop := 0;Ybottom := 0;
   decaleX := 0;decaleY := 0;
   if Y1<0 then begin
      Ybottom := -Y1*gainLoupe;
      Y1 := 0;
      decaleY := Ybottom;
   end;
   if X1<0 then begin
      Xright := -X1*gainLoupe;
      X1 := 0;
      decaleX := Xright;
   end;
   if Y2>hauteurAff then begin
      Ybottom := loupeForm.Height;
      Ytop := loupeForm.Height-(Y2-hauteurAff)*gainLoupe;
      Y2 := hauteurAff;
   end;
   if X2>largeurAff then begin
      Xright := loupeForm.width;
      Xleft := loupeForm.width-(X2-largeurAff)*gainLoupe;
      X2 := largeurAff;
   end;
   bitmapLoupe.Width := (X2-X1);
   bitmapLoupe.Height := (Y2-Y1);
   bitmapLoupe.canvas.CopyRect(rect(0,0,X2-X1,Y2-Y1),
            Abitmap.canvas,
            rect(round(X1/pasZoom),round(Y1/pasZoom),round(X2/pasZoom),round(Y2/pasZoom)));
   aPoint := PaintBox.clientToScreen(Point(x,y));
   LoupeForm.Left := aPoint.X-LoupeForm.width div 2;
   LoupeForm.Top := aPoint.Y-LoupeForm.height div 2;
   LoupeForm.paintBox.canvas.StretchDraw(
             rect(decaleX,decaleY,
                  decaleX+(X2-X1)*gainLoupe,
                  decaleY+(Y2-Y1)*gainLoupe),bitmapLoupe);
   Reperage;
   Efface;
   PaintBox.OnMouseMove := imageMouseMove;
   loupeForm.paintBox.OnMouseMove := imageMouseMove;
   if not loupeForm.visible then begin
      loupeForm.Cursor := crNone;
      loupeForm.paintBox.Cursor := crNone;
      loupeForm.show;
   end;
end; // loupe

procedure ChercheCouleurCible;
var
    Lcouleur : TRGBtriple;
    xCible,yCible : integer;
    scanLine : pRGBTripleArray;
begin
     xCible := round(x/pasZoom);
     if (xcible<Xmin) or (xcible>Xmax) then exit;
     yCible := round(y/pasZoom);
     if (ycible<Ymin) or (ycible>Ymax) then exit;
     scanLine := Abitmap.scanLine[yCible];
     Lcouleur := scanLine[xCible];
     couleurCibleP.Color := RGB(Lcouleur.rgbtRed,Lcouleur.rgbtGreen,Lcouleur.rgbtBlue);
     CouleurCibleP.repaint;
end; //ChercheCouleurCible

var BS : tstyleDrag;
begin
   if NomFichier='' then exit;
   convertitXY(sender,x,y);
   if (x<=0) or (y<=0) or (x>=largeurAff) or (y>=hauteurAff) then begin
      cacheLoupe;
      exit;
   end;
   case BorneSelect of
        bsMesure : if ssLeft in shift
          then
          else begin
            if pointProche(x,y)>=0
               then begin
                  setCurseur(crCibleMove);
                  hint := hDeplacerPoint;
               end
               else begin
                  setCurseur(crCible);
                  hint := hRepererPoint;
               end;
        end;
        bsSuppr : ;
        bsChronoInit : chercheCouleurCible;
        bsNone : begin
           BS := GetBorne(x,y);
           case BS of
              bsNone : setCurseur(crDefault);
              bsOrigine : setCurseur(crOrigine);
              bsEchelle2,bsEchelle1 : setCurseur(crCibleMove);
              else setCurseur(crDrag);
           end;
           case BS of
               bsOrigine : hint := hOrigineMove;
               bsEchelle1 : hint := hFinX+EchelleBmpDlg.nomX.text;
               bsEchelle2 : hint := hFinY+EchelleBmpDlg.nomY.text;
               else hint := hClicDroit;
           end;
           PaintBox.hint := hint;
        end;
        else if not timerMove.Enabled then AffecteBorne(x,y);
   end; // case borne select
   if (borneSelect<>bsNone) and (zoomUD.value>1)
      then Loupe
      else cacheloupe;
end; // mouseMove

procedure TCourbesForm.ImagePaint(Sender: TObject);

Procedure TraceLigne(P1,P2 : TpointF);
var xx,yy : integer;
begin
    xx := round(P1.x);
    yy := round(P1.y);
    PaintBox.canvas.moveto(xx,yy);
    xx := round(P2.x);
    yy := round(P2.y);
    PaintBox.canvas.lineto(xx,yy);
end;

Procedure TraceCercle(Apoint : TpointF);
var xx,yy : integer;
begin
    xx := round(Apoint.x);
    yy := round(Apoint.y);
    PaintBox.canvas.ellipse(xx-rayon,yy-rayon,
                            xx+rayon+1,yy+rayon+1)
end;

Procedure TraceCroix(Apoint : TpointF;taille : integer);
begin with Apoint do begin
         TraceLigne(PointF(x-taille,y),pointF(x+taille,y));
         TraceLigne(pointF(x,y-taille),pointF(x,y+taille));
end end;

Procedure TraceCroixData(i : integer;j : TindiceObjet);
var texte : string;
    x,y : integer;
begin
     x := round(xy[j,i].X*pasZoom);
     y := round(xy[j,i].Y*pasZoom);
     PaintBox.canvas.pen.color := couleur[j];
     PaintBox.canvas.font.color := couleur[j];
     TraceCroix(Point(x,y),SizeData);
     texte := intToStr(i);
     if NbreObjet>1 then texte := texte+'('+intToStr(j)+')';
     PaintBox.canvas.textOut(x+SizeData,y+SizeData,texte);
end;

Procedure TraceBorne;

Procedure TraceFleche(P1i,P2i : TpointF);
var delta,zz : TpointF;
    norme : integer;
begin
            delta.X := P1i.x-P2i.x;
            delta.Y := P1i.y-P2i.y;
            norme := round(sqrt(sqr(delta.X)+sqr(delta.Y)));
            delta.X := round(2*Magnet*delta.X/norme);
            delta.Y := round(2*Magnet*delta.Y/norme);
// x,y = centre de la base de la flèche
            zz.y := P2i.y+delta.Y;
            zz.x := P2i.x+delta.X;
            delta.x := round(delta.x/3);
            delta.y := round(delta.y/3);
            TraceLigne(P1i,P2i);
            TraceLigne(P2i,pointF(zz.x-delta.Y,zz.y+delta.X));
            TraceLigne(P2i,pointF(zz.x+delta.Y,zz.y-delta.X));
            TraceCercle(P1i);
end; // traceFleche

begin
       PaintBox.canvas.pen.color := couleur[0];
       PaintBox.canvas.pen.width := penWidth;
       TraceFleche(e_PointRepere[bsOrigine],e_PointRepere[bsEchelle2]);
       TraceFleche(e_PointRepere[bsOrigine],e_PointRepere[bsEchelle1]);
       TraceCroix(e_PointRepere[bsOrigine],magnet);
       PaintBox.canvas.pen.width := 1;
end; // traceBorne

Procedure ImageVersEcran;
    var i : TstyleDrag;
    begin
       for i := low(TstyleDrag) to High(TstyleDrag) do begin
           if (PointRepere[i].y<marge) and
              ((not orthonorme) or (i<>bsEchelle2)) then PointRepere[i].y := marge;
           if (PointRepere[i].x<marge) and
              ((not orthonorme) or (i<>bsEchelle1))then PointRepere[i].x := marge;
           if (PointRepere[i].x>(largeur-marge)) and
              ((not orthonorme) or (i<>bsEchelle1))  then
              PointRepere[i].x := largeur-marge;
           if (PointRepere[i].y>(hauteur-marge)) and
              ((not orthonorme) or (i<>bsEchelle2))then
              PointRepere[i].y := hauteur-marge;
           e_pointRepere[i].x := pointRepere[i].x*pasZoom;
           e_pointRepere[i].y := pointRepere[i].y*pasZoom;
       end;
    end;

var i,j : integer;
    zoomH,zoomV : double;
begin // imagePaint
    if NomFichier='' then exit;
    ZoomH := paintBox.Height/hauteur;
    ZoomV := paintBox.Width/largeur;
    if zoomV<zoomH
         then pasZoom := ZoomV
         else pasZoom := ZoomH;
    (*
    ZoomEdit.text := hNoZoom;
    if pasZoom>1.1 then ZoomEdit.text := 'Zoom x'+FloatToStrF(pasZoom,ffFixed,3,2);
    if pasZoom<0.9 then ZoomEdit.text := 'Zoom /'+FloatToStrF(1/pasZoom,ffFixed,3,2);
    *)
    PaintBox.canvas.pen.color := couleur[0];
    ImageVersEcran;
    hauteurAff := round(hauteur*pasZoom);
    largeurAff := round(largeur*pasZoom);
    PaintBox.canvas.CopyRect(rect(0,0,largeurAff,hauteurAff),
               Abitmap.canvas,rect(0,0,largeur,hauteur));
    PaintBox.canvas.brush.style := bsClear;
    for j := 1 to NbreObjet do begin
        if NbrePoints[j]>grid.rowCount then
           grid.rowCount := NbrePoints[j]+12;
        for i := 0 to pred(NbrePoints[j]) do
            traceCroixData(i,j);
    end;
    grid.Row := NbrePoints[1]+1;
    TraceBorne;
    Ymax := round(PointRepere[bsEchelle2].y);
    Ymin := round(PointRepere[bsOrigine].y);
    Xmax := round(PointRepere[bsEchelle1].x);
    Xmin := round(PointRepere[bsOrigine].x);
    verifMinMaxInt(Xmin,Xmax);
    verifMinMaxInt(Ymin,Ymax);
    EditBidon.setFocus;
end; // ImagePaint

procedure TCourbesForm.ExitBtnClick(Sender: TObject);
begin
    Close
end;

procedure TCourbesForm.ImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     if Button<>mbLeft then exit;
     convertitXY(sender,x,y);
     AffecteBorne(x,y);
     case BorneSelect of
          bsMesure : AjoutePoint(x,y);
          bsSuppr : supprimePoint(x,y);
          bsNone : setCurseur(crDefault);
          bsChronoInit : ChoixCibleAuto(x,y);
          else begin
             borneSelect := bsNone;
             setCurseur(crDefault);
             setEchelle;
          end;
     end;
end;

Function TCourbesForm.PointProche(X,Y : Integer) : integer;
var distance, newDistance : double;
    i,j : integer;
begin
         result := -1;
         ObjetSelect := 1;
         Distance := 8;
         x := round(x/pasZoom);
         y := round(y/pasZoom);
         for j := 1 to NbreObjet do
         for i := 0 to pred(NbrePoints[j]) do begin
             newDistance := sqrt(sqr(xy[j,i].x-x)+
                                 sqr(xy[j,i].y-y));
             if (newDistance<distance) then begin
                distance := newDistance;
                result := i;
                ObjetSelect := j;
             end;
         end;
end;

procedure TCourbesForm.PythonBtnClick(Sender: TObject);
var FichierPy : textFile;

procedure ecritObjet(j : integer;avecIndex : boolean);
var i : integer;
    index : string;
begin
       if avecIndex then index := IntToStr(j) else index := '';
       write(fichierPy,EchelleBmpDlg.nomX.text+index+'List=[');
       for i := 0 to NbrePoints[j]-2 do begin
           write(fichierPy,strx(j,i)+',');
           if ((i mod 11)=10) then  writeln(fichierPy);
       end;
       writeln(fichierPy,strx(j,NbrePoints[1]-1)+']');
       writeln(fichierPy,EchelleBmpDlg.nomX.text+index+'=np.array('+EchelleBmpDlg.nomX.text+index+'List)');
       writeln(fichierPy);
       write(fichierPy,EchelleBmpDlg.nomY.text+index+'List=[');
       for i := 0 to NbrePoints[j]-2 do begin
             write(fichierPy,stry(1,i)+',');
             if ((i mod 11)=10) then  writeln(fichierPy);
       end;
       writeln(fichierPy,stry(1,NbrePoints[j]-1)+']');
       writeln(fichierPy,EchelleBmpDlg.nomY.text+index+'=np.array('+EchelleBmpDlg.nomY.text+index+'List)');
end;

var j : integer;
begin
with saveDialog do if Execute then begin
     FileMode := fmOpenWrite;
     AssignFile(fichierPy,FileName,CP_UTF8);
     Rewrite(fichierPy);
     writeln(fichierPy,'#!/usr/bin/env python3');
     writeln(fichierPy,'# -*- coding: utf-8 -*-');
     writeln(fichierPy,'import numpy as np');
     writeln(fichierPy);
     writeln(fichierPy,'# Unité de '+EchelleBmpDlg.nomX.text+'='+EchelleBmpDlg.uniteX.text);
     writeln(fichierPy,'# Unité de '+EchelleBmpDlg.nomY.text+'='+EchelleBmpDlg.uniteY.text);
     writeln(fichierPy);
     if NbreObjet=1
        then ecritObjet(1,false)
        else begin
           for j := 1 to NbreObjet do
               ecritObjet(j,true);
        end;
     closeFile(fichierPy);
     FileMode := fmOpenReadWrite;
end
end;

procedure TCourbesForm.EditBidonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
begin
     GetCursorPos(P);
     case key of
          vk_left,vk_numpad4 : dec(P.X);
          vk_right,vk_numpad6 : inc(P.X);
          vk_down,vk_numpad2 : inc(P.Y);
          vk_up,vk_numpad8 : dec(P.Y);
          vk_prior :  if ssShift in shift
             then dec(P.X,10)
             else dec(P.Y,10);
          vk_next : if ssShift in shift
              then inc(P.X,10)
              else inc(P.Y,10);
          vk_delete,vk_back : ;
          vk_space,vk_return : case BorneSelect of
             bsMesure : begin
                P := PaintBox.ScreenToClient(P);
                AjoutePoint(P.x,P.y);
                exit;
             end;
             bsSuppr : begin
                P := PaintBox.ScreenToClient(P);
                supprimePoint(P.x,P.y);
                exit;
             end;
          end;
          else exit;
     end;
     setCursorPos(P.X,P.Y);
end;

procedure TCourbesForm.EchelleBtnClick(Sender: TObject);
begin
    if EchelleBmpDlg.showModal=mrOK then begin
      setEchelle;
      modifierPointCourant := EchelleBmpDlg.modifPointCB.checked;
      BorneSelect := bsNone;
      setCurseur(crCible);
      statusBar.Panels[0].text := hRepererPoint;
      hint := '';
      EchelleBtn.enabled := true;
      PointCourant := -1;
    end;
end;

procedure TCourbesForm.OpenFileBtnClick(Sender: TObject);
begin
    if OpenDialog.InitialDir='' then
       OpenDialog.InitialDir := ImagesDir;
    if OpenDialog.execute then begin
       ouvreFichier(openDialog.fileName);
       OpenDialog.InitialDir := extractFilePath(openDialog.fileName);
    end;
end;

procedure TCourbesForm.OuvreFichier(const Nom: String);

procedure MajBitmap;
var i : integer;
    j : TindiceObjet;
    cc : TColor;
begin
     Largeur := Abitmap.width;
     Hauteur := Abitmap.height;
     for j := 1 to maxObjet do begin
         NbrePoints[j] := 0;
         for i := 0 to maxPixel do
             XY[j,i] := point(0,0);
     end;
     PointRepere[bsOrigine].x := Largeur div 5;
     PointRepere[bsEchelle2].x := PointRepere[bsOrigine].x;
     PointRepere[bsOrigine].y := 4*Hauteur div 5;
     PointRepere[bsEchelle1].y := PointRepere[bsOrigine].y;
     PointRepere[bsEchelle1].x := 4*Largeur div 5;
     PointRepere[bsEchelle2].y := Hauteur div 5;
     couleurFond := GetCouleurFond(Abitmap);
     RedFond := GetRValue(couleurFond);
     BlueFond := GetBValue(couleurFond);
     GreenFond := GetGValue(couleurFond);
     cc := CouleurComplementaire(couleurFond);
     couleur[1] := cc;
     couleur[0] := cc;
     CouleurPointsCB.selected := cc;
     CouleurAxeCB.selected := cc;
     BorneSelect := bsNone;
     EchelleBtn.enabled := true;
     MesureBtn.Enabled := true;
     UndoBtn.enabled := false;
     RegressiBtn.enabled := false;
     objetCourant := 1;
     NbreObjet := 1;
     PaintBox.refresh;
     Caption := 'Lecture de courbes ['+ExtractFileName(NomFichier)+']';
     statusBar.Panels[0].text := hRepereBmp;
     setEchelle;
end; // MajBitmap

var extension : String;
    Ljpeg : TjpegImage;
    Lpng : TpngImage;
    LGIF : TGIFImage;
begin
     screen.cursor := crHourGlass;
     NomFichier := Nom;
     extension := AnsiUpperCase(extractFileExt(NomFichier));
     if (extension='.GIF') then begin
        LGIF := TGIFImage.Create;
        try
       // LGIF.OnProgress := Nil;
        LGIF.LoadFromFile(nom);
        with Abitmap do begin
            height := LGIF.Height;
            width := LGIF.Width;
            Assign(LGIF);
            pixelFormat := pf24bit;
        //    NomFichier := changeFileExt(Nom,'.bmp');
        //    saveToFile(NomFichier);
        //    extension := '.BMP';
        end;
        finally
           LGIF.Free;
        end;
     end;
     if (extension='.PNG') then begin
           Lpng := TpngImage.create;
           try
           Lpng.LoadFromFile(Nom);
           with Abitmap do begin
                height := Lpng.Height;
                width := Lpng.Width;
                assign(Lpng);
                pixelFormat := pf24bit;
           //     NomFichier := changeFileExt(Nom,'.bmp');
           //     saveToFile(NomFichier);
           //     extension := '.BMP';
           end;
           finally
              Lpng.free;
           end;
     end;
     if (extension='.JPG') or (extension='.JPEG') then begin
         Ljpeg := TjpegImage.create;
         try
         Ljpeg.LoadFromFile(Nom);
         with Abitmap do begin
              height := Ljpeg.Height;
              width := Ljpeg.Width;
              assign(Ljpeg);
              pixelFormat := pf24bit;
          //    NomFichier := changeFileExt(Nom,'.bmp');
          //    saveToFile(NomFichier);
          //    extension := '.BMP';
         end;
         finally
           Ljpeg.free;
         end;
     end;
     if (extension='.BMP') then begin
        ABitmap.LoadFromFile(nomFichier);
        ABitmap.pixelFormat := pf24bit;
     end;
     MajBitMap;
     screen.cursor := crDefault;
     EchelleBtnClick(nil);
     statusBar.Panels[0].text := hparamBtn;
end;

procedure TCourbesForm.EcranVersImage;
    var i : TstyleDrag;
    begin
       for i := low(TstyleDrag) to High(TstyleDrag) do begin
           pointRepere[i].x := round(e_pointRepere[i].x/pasZoom);
           pointRepere[i].y := round(e_pointRepere[i].y/pasZoom);
       end;
    end;

procedure TCourbesForm.MesureBtnClick(Sender: TObject);
begin
    if MesureBtn.down
    then begin
        MesureBtn.Hint := hStopMes;
        MesureBtn.Caption := stStop;
        BorneSelect := bsMesure;
        setCurseur(crCible);
        statusBar.Panels[0].text := hRepererPoint;
        hint := '';
        MesureBtn.imageIndex := 0;
        EchelleBtn.enabled := false;
        PointCourant := -1;
        grid.Col := 0;
        grid.Row := 1;
        paintBox.refresh;
    end
    else begin
        BorneSelect := bsNone;
        UndoBtn.enabled := false;
        EchelleBtn.enabled := true;
        setCurseur(crDefault);
        statusBar.Panels[0].text := hTransfertRegressi;
        MesureBtn.Hint := hStartMes;
        MesureBtn.imageIndex := 9;
        MesureBtn.Caption := 'Mesurer';
    end
end;

procedure TCourbesForm.NbreSEChange(Sender: TObject);
begin
       NbreObjet := NbreSE.value;
       SerieSE.maxValue := NbreObjet;
       if serieSE.Value > NbreObjet then SerieSE.value := 1;
       SerieSE.visible := NbreObjet > 1;
       SerieLabel.visible := SerieSE.visible;
       traceGrid;
end;

procedure TCourbesForm.UndoBtnClick(Sender: TObject);
begin
     if NbrePoints[objetCourant]>0 then dec(nbrePoints[ObjetCourant]);
     UndoBtn.enabled := nbrePoints[ObjetCourant]>0;
     SupprBtn.enabled := NbrePoints[ObjetCourant]>0;     
     PaintBox.refresh;
     PaintBox.refresh;
end;

procedure TCourbesForm.CouleurPointsCBChange(Sender: TObject);
begin
      if nomFichier='' then exit;
      if sender=CouleurAxeCB
         then couleur[0] := couleurAxeCB.selected
         else couleur[objetCourant] := couleurPointsCB.selected;
      PaintBox.refresh;
end;

procedure TCourbesForm.FormDestroy(Sender: TObject);
begin
    Abitmap.free;
    bitmapLoupe.Free;
    if LoupeForm<>nil then begin
        if LoupeForm.visible then LoupeForm.hide;
        LoupeForm.close;
        LoupeForm.free;
        LoupeForm := nil;
    end;
    courbesForm := nil;
end;

procedure TCourbesForm.FormResize(Sender: TObject);
begin
  inherited;
  if gridPanel.Width>clientWidth div 3 then
       gridPanel.Width := clientWidth div 3;
  CouleurCibleP.left := GroupBox2.Left - 90;
  signifEdit.width := CouleurCibleP.left - signifEdit.left - 64;
end;

procedure TCourbesForm.RazBtnClick(Sender: TObject);
var i,j : integer;
begin
     for j := 1 to maxObjet do NbrePoints[j] := 0;
     for i := 1 to pred(grid.rowCount) do
         for j := 0 to pred(grid.colCount) do
             grid.cells[j,i] := '';
     ObjetCourant := 1;
     NbreObjet := 1;
     RazBtn.enabled := false;
     UndoBtn.enabled := false;
     SupprBtn.enabled := false;
     RegressiBtn.enabled := false;
     MesureBtn.visible := true;
     EchelleBtn.enabled := true;
     PaintBox.refresh;
end;

procedure TCourbesForm.SupprBtnClick(Sender: TObject);
begin
      OldBorne := BorneSelect;
      BorneSelect := bsSuppr;
      setCurseur(crDefault);
      oldStatus := statusBar.Panels[0].text;
      statusBar.Panels[0].text := hSupprPoint;
      hint := '';
end;

Procedure TCourbesForm.AjoutePoint(x,y : integer);
var N,j : integer;
begin
    if pointCourant>=0
       then XY[ObjetSelect,PointCourant] :=
                point(round(x/pasZoom-1/2),
                      round(y/pasZoom-1/2))
       else begin
            XY[ObjetCourant,NbrePoints[ObjetCourant]] :=
                        point(round(x/pasZoom),
                              round(y/pasZoom));
            inc(NbrePoints[ObjetCourant]);
       end;
    pointCourant := -1;
    setCurseur(crCible);
    UndoBtn.enabled := NbrePoints[ObjetCourant]>0;
    SupprBtn.enabled := NbrePoints[ObjetCourant]>0;
    N := 0;
    for j := 1 to NbreObjet do N := N+NbrePoints[j];
    RazBtn.enabled := N>1;
    RegressiBtn.enabled := N>3;
    PaintBox.refresh;
    traceGrid;
end;

procedure TCourbesForm.AutoBtnClick(Sender: TObject);
var i : integer;
    P : TPoint;
begin
         setCurseur(crCible);
         BorneSelect := bsChronoInit;
         SerieSE.value := 1;
         for i := 1 to maxObjet do NbrePoints[i] := 0;
         objetCourant := 1;
         MesureBtn.Down := true;
         MesureBtn.Hint := hStopMes;
         MesureBtn.imageIndex := 1;
         MesureBtn.Caption := stStop;
         Grid.ColCount := NbreSE.value*2;
         P.X := AutoBtn.Left;
         P.Y := AutoBtn.top;
         P := Toolbar.ClientToScreen(P);
         ShowMessagePos('Sélectionnez la couleur de la courbe',P.X-AutoBtn.Width,P.Y+AutoBtn.height);
         statusBar.Panels[0].text := 'Sélectionnez la couleur de la courbe';
         CouleurCibleP.Visible := true;
end;

Procedure TCourbesForm.SupprimePoint(x,y : integer);
var i,num,N : integer;
begin
      Num := PointProche(x,y);
      if num>=0 then begin
         dec(NbrePoints[objetSelect]);
         for i := num to pred(NbrePoints[ObjetSelect]) do
             xy[ObjetSelect,i] := xy[ObjetSelect,succ(i)];
         PaintBox.refresh;
         traceGrid;
         UndoBtn.enabled := NbrePoints[ObjetCourant]>0;
         SupprBtn.enabled := NbrePoints[ObjetCourant]>0;
         N := 0;
         for i := 1 to NbreObjet do
             N := N+NbrePoints[i];
         RazBtn.enabled := N>1;
         RegressiBtn.enabled := N>3;
      end;
      BorneSelect := oldBorne;
      statusBar.Panels[0].text := oldStatus;
end;

procedure TCourbesForm.TimerMoveTimer(Sender: TObject);
begin
    TimerMove.Enabled := false;
end;

procedure TCourbesForm.AideBtnClick(Sender: TObject);
begin
    Aide(Help_Numerisationdunecourbe);
end;

procedure TCourbesForm.SplitterMoved(Sender: TObject);
var w : integer;
begin
     PaintBox.refresh;
     w := (Grid.Width-8) div (2*NbreSE.value);
     if (w<64) and (NbreSE.value>1) then
        w := (Grid.Width-8) div 2;
     Grid.defaultColWidth := w
end;

procedure TCourbesForm.SignifEditChange(Sender: TObject);
begin
  signif[objetCourant] := signifEdit.text
end;

procedure TCourbesForm.FormActivate(Sender: TObject);
begin
   penWidth := screen.Width div 1920;
end;

procedure TCourbesForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Fichier : TIniFile;
    j : integer;
begin
     try
     Fichier := TIniFile.create(NomFichierIni);
     try
     for j := 0 to maxObjet do
         Fichier.writeInteger(Titre,stCouleur+intToStr(j),Couleur[j]);
     with echelleBmpDlg do begin
         Fichier.writeString(Titre,'UniteX',uniteX.text);
         Fichier.writeString(Titre,'UniteY',uniteY.text);
         Fichier.writeString(Titre,'EditX',editX.text);
         Fichier.writeString(Titre,'EditY',editX.text);
         Fichier.writeBool(Titre,'ModifPoint',modifierPointCourant);
     end;
     if openDialog.InitialDir<>'' then
        imagesDir := openDialog.InitialDir;
     finally
     Fichier.free;
     end;
     except
     end;
end;

procedure TCourbesForm.SerieSEChange(Sender: TObject);
begin
   ObjetCourant := round(SerieSE.Value);
   CouleurPointsCB.selected := couleur[objetCourant];
   signifEdit.text := signif[objetCourant];
end;

Function TCourbesForm.StrX(j : TindiceObjet;i : integer) : String;
var xx,yy : double;
begin
    if i>=NbrePoints[j] then result := '' else begin
    xx := penteX*(xy[j,i].x-zeroX);
    case echelleX of
       eLog : xx := MiniX*power(10,xx);
       eLin : xx := MiniX+xx;
       ePolaire : begin
            yy := penteY*(xy[j,i].y-zeroY);
            xx := radToDeg(arcTan2(yy,xx));
       end;
    end;
    result := FloatToStrPoint(ArrondiX*round(xx/ArrondiX));
    end;
end;

Function TCourbesForm.StrY(j : TindiceObjet;i : integer) : String;
var yy,xx : double;
begin
    if i>=NbrePoints[j] then result := '' else begin
    yy := penteY*(xy[j,i].y-zeroY);
    case echelleY of
       eLog : yy := MiniY*power(10,yy);
       eLin : yy := MiniY+yy;
       ePolaire : begin
           xx := penteX*(xy[j,i].x-zeroX);
           yy := sqrt(sqr(xx)+sqr(yy));
       end;
    end;
    result := FloatToStrPoint(ArrondiY*round(yy/ArrondiY))
    end;
end;

Procedure TCourbesForm.TraceGrid;
var i,j : integer;
begin
    Grid.ColCount := NbreObjet*2;
    if NbreObjet>1 then begin
    for j := 1 to NbreObjet do begin
        Grid.cells[j*2-2,0] := EchelleBmpDlg.nomX.text+intToStr(j)+'('+
                               EchelleBmpDlg.uniteX.text+')';
        Grid.cells[j*2-1,0] := EchelleBmpDlg.nomY.text+intToStr(j)+'('+
                               EchelleBmpDlg.uniteY.text+')';
    end;
    end
    else begin
        Grid.cells[0,0] := EchelleBmpDlg.nomX.text+'('+
                               EchelleBmpDlg.uniteX.text+')';
        Grid.cells[1,0] := EchelleBmpDlg.nomY.text+'('+
                               EchelleBmpDlg.uniteY.text+')';
    end;
    for j := 1 to NbreObjet do begin
       if (NbrePoints[j]+3)>grid.rowCount then
          grid.rowCount := NbrePoints[j]+12;
       for i := 0 to pred(NbrePoints[j]) do begin
           Grid.cells[j*2-2,i+1] := strX(j,i);
           Grid.cells[j*2-1,i+1] := strY(j,i);
       end;
       for i := NbrePoints[j]+1 to pred(grid.rowCount) do begin
           grid.cells[j*2-2,i] := '';
           grid.cells[j*2-1,i] := '';
       end;
    end;
end;

procedure TCourbesForm.ConvertitXY(Sender: TObject;var X, Y: Integer);
var PointImage,PointLoupe : TPoint;
begin
    if (sender=LoupeForm.paintBox) then begin
       PointImage := PaintBox.ClientToScreen(Point(0,0));
       PointLoupe := LoupeForm.ClientToScreen(Point(0,0));
       x := x+pointLoupe.X-PointImage.X;
       y := y+pointLoupe.Y-PointImage.Y;
    end;
end;

procedure TCourbesForm.CacheLoupe;
begin
     if loupeForm.visible then begin
        loupeForm.hide;
        setFocus;
     end;
end;

procedure TCourbesForm.SetCurseur(Acursor : Tcursor);
begin
    if Cursor<>Acursor then begin
       PaintBox.cursor := Acursor;
       cursor := Acursor;
    end;
    if (aCursor=crDefault) then cacheLoupe;
end;


end.


