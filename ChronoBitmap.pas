unit ChronoBitmap;

interface

uses
  Windows, system.Types, System.ImageList,
  SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,  ExtCtrls, Buttons, Printers, Math, ComCtrls, clipbrd, inifiles,
  vcl.HtmlHelpViewer,
  jpeg, Menus, Spin, constreg, gifImg, pngimage, registry,
  Grids, ToolWin, ImgList,
  grapheU, compile, regutil, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.VirtualImageList;

const
   maxObjet = 5;

type
  TindiceObjet = 1..maxObjet;

  TChronoForm = class(TForm)
    StatusBar: TStatusBar;
    Splitter: TSplitter;
    GridPanel: TPanel;
    ParamPanel: TPanel;
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
    angleCB: TCheckBox;
    HelpBtn: TToolButton;
    EtiquetteCB: TCheckBox;
    GroupBox2: TGroupBox;
    CouleurPointsCB: TColorBox;
    GroupBox3: TGroupBox;
    CouleurAxeCB: TColorBox;
    LoupeBtn: TToolButton;
    zoomUD: TSpinEdit;
    PaintBox: TPaintBox;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
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
    procedure StopBtnClick(Sender: TObject);
    procedure MesureBtnClick(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure CouleurPointsCBChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure SupprBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SerieSEChange(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FileBtnClick(Sender: TObject);
    procedure angleCBClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CouleurAxeCBChange(Sender: TObject);
    procedure EtiquetteCBClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
      e_PointRepere : TarrayPoint;
      PointRepere : TarrayPoint;
      BorneSelect,oldBorne : TstyleDrag;
      pointCourant,objetCourant : integer;
      oldStatus : String;
      objetSelect : integer;
      NbreObjet : integer;
      arrondiXY : double;
      CouleurGrid : array[0..maxObjet*2] of Tcolor;
      XY : array[TindiceObjet,0..maxPixel] of Tpoint;
      Echelle : double;
      signeY : double;
      NbrePoints : array[TindiceObjet] of integer;
      OrigineX,OrigineY : integer;
      NomFichier : String;
      Couleur : array[0..maxObjet] of Tcolor;
      Abitmap,bitmapLoupe : Tbitmap;
      Largeur,Hauteur : integer;
      LargeurAff,Hauteuraff : integer;
      pasZoom : double;
    Procedure envoieDonnees;
    Function GetBorne(x,y : integer) : TstyleDrag;
    Function PointProche(x,y : Integer) : integer;
    procedure EcranVersImage;
    Procedure AjoutePoint(x,y : integer);
    Procedure SupprimePoint(x,y : integer);
    procedure OuvreFichier(const Nom: String);
    Procedure setEchelle;
    function valeurAngle(i: integer): double;
    function StrAngle(i: integer): string;
    Function StrX(j : TindiceObjet;i : integer) : String;
    Function StrY(j : TindiceObjet;i : integer) : String;
    procedure TraceGrid;
    procedure cacheLoupe;
    procedure ConvertitXY(Sender: TObject;var X, Y: Integer);
    procedure SetCurseur(Acursor : Tcursor);
    procedure AffecteBorne(x,y : integer);
  public
     AvecT : boolean;
     Longueur : double;
     deltaT : double;
  end;

var
  ChronoForm: TChronoForm;

implementation

uses chronoEch, regdde, regmain, graphvar, loupeU, aidekey;

const
      Rayon = 5;
      marge = 4;
      rayonAngle = 25;
      SizeData = 4;
   //   ValeurGammaMax = 25;
      Titre = 'Chronophoto';

{$R *.DFM}

procedure TChronoForm.FormCreate(Sender: TObject);
var i : tstyleDrag;
    j : integer;
    Fichier : TIniFile;
begin
    AvecT := true;
    NbreObjet := 1;
    SigneY := -1;
    NomFichier := '';
    for i := low(TstyleDrag) to high(TstyleDrag) do
        PointRepere[i] := point(0,0);
    Longueur := 1;
    Deltat := 1;
    Abitmap := Tbitmap.create;
    bitmapLoupe := Tbitmap.create;
    bitmapLoupe.pixelFormat := pf24bit;
    Fichier := TIniFile.create(NomFichierIni);
    OpenDialog.filterIndex := Fichier.readInteger(Titre,'Filtre',0);
    CouleurGrid[0] := clBlack;
    for j := 0 to maxObjet do
        Couleur[j] := Fichier.readInteger(Titre,stCouleur+intToStr(j),clRed);
    CouleurPointsCB.selected := Couleur[1];
    CouleurAxeCB.selected := Couleur[0];
    Application.CreateForm(TechelleMecaBmpDlg,echelleMecaBmpDlg);
    echelleMecaBmpDlg.uniteEdit.text := Fichier.readString(Titre,'UniteX','m');
    echelleMecaBmpDlg.SigneYCB.checked := Fichier.readBool(Titre,'SigneY',false);
    Fichier.free;
    if LoupeForm=nil then
       Application.CreateForm(TLoupeForm, LoupeForm);
    LoupeForm.paintBox.onMouseUp := imageMouseUp;
    LoupeForm.paintBox.onMouseDown := imageMouseDown;
    LoupeForm.paintBox.onMouseMove := imageMouseMove;
    LoupeForm.onKeyDown := editBidonKeyDown;
    LoupeForm.Hide;
    Grid.DefaultRowHeight := hauteurColonne;
    ResizeButtonImagesforHighDPI(self);
end;

procedure TChronoForm.RegressiBtnClick(Sender: TObject);
begin
   StopBtnClick(nil);
   setEchelle;
   EnvoieDonnees;
end;

procedure TChronoForm.EnvoieDonnees;
var avecX,avecY : boolean;

Procedure AjouteOptionGrXY;
var j : integer;
begin
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMX');
     if NbreObjet=1
        then FormDDE.donnees.add(EchelleMecaBmpDlg.nomX.text)
        else for j := 1 to NbreObjet do
             FormDDE.donnees.add(EchelleMecaBmpDlg.nomX.text+intToStr(j));
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMY');
     if NbreObjet=1
        then FormDDE.donnees.add(EchelleMecaBmpDlg.nomY.text)
        else for j := 1 to NbreObjet do
             FormDDE.donnees.add(EchelleMecaBmpDlg.nomY.text+intToStr(j));
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' ORTHO');
     for j := 1 to NbreObjet do FormDDE.donnees.add('1');
     FormDDE.donnees.add('&1 FICHIER');
     FormDDE.donnees.add(NomFichier);
end;

Procedure AjouteOptionGrAngle;
begin
     FormDDE.donnees.add('&1 NOMX');
     FormDDE.donnees.add(EchelleMecaBmpDlg.nomT.text);
     FormDDE.donnees.add('&1 NOMY');
     FormDDE.donnees.add(EchelleMecaBmpDlg.nomX.text);
     FormDDE.donnees.add('&1 ORTHO');
     FormDDE.donnees.add('1');
     FormDDE.donnees.add('&1 FICHIER');
     FormDDE.donnees.add(NomFichier);
end;

Procedure AjouteOptionGrX;
var j : integer;
begin
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMX');
     for j := 1 to NbreObjet do
         FormDDE.donnees.add(EchelleMecaBmpDlg.nomT.text);
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMY');
     if NbreObjet=1
        then FormDDE.donnees.add(EchelleMecaBmpDlg.nomX.text)
        else for j := 1 to NbreObjet do
             FormDDE.donnees.add(EchelleMecaBmpDlg.nomX.text+intToStr(j));
     FormDDE.donnees.add('&1 FICHIER');
     FormDDE.donnees.add(NomFichier);
end;

Procedure AjouteOptionGrY;
var j : integer;
begin
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMX');
     for j := 1 to NbreObjet do
         FormDDE.donnees.add(EchelleMecaBmpDlg.nomT.text);
     FormDDE.donnees.add('&'+intToStr(NbreObjet)+' NOMY');
     if NbreObjet=1
        then FormDDE.donnees.add(EchelleMecaBmpDlg.nomY.text)
        else for j := 1 to NbreObjet do
             FormDDE.donnees.add(EchelleMecaBmpDlg.nomY.text+intToStr(j));
     FormDDE.donnees.add('&1 FICHIER');
     FormDDE.donnees.add(NomFichier);
end;

var ligne : String;
    i,j : integer;
    minY,maxY,minX,maxX : integer;
    P : Tpoint;
    compteur : integer;
begin
     minY := hauteur;maxY := 0;
     minX := largeur;maxX := 0;
     for i := 0 to pred(NbrePoints[1]) do begin
         for j := 1 to NbreObjet do begin
             P := xy[j,i];
             if P.x>maxX then maxX := P.x;
             if P.x<minX then minX := P.x;
             if P.y>maxY then maxY := P.y;
             if P.y<minY then minY := P.y;
         end;
     end;

     avecY := (maxY-minY)>hauteur div 32;
     avecX := (maxX-minX)>largeur div 32;
     compteur := 0;
     if avecX then inc(compteur);
     if avecY then inc(compteur);
     if avecT then inc(compteur);
     if compteur<2 then begin
        showMessage('Mesures sur zone trop étroite !');
        exit;
     end;

     FormDDE.donnees.Clear;
     FormDDE.donnees.add('Chronophotographie');
     FormDDE.donnees.add('');
     if avecT or angleCB.checked
        then ligne := EchelleMecaBmpDlg.nomT.text+crTab
        else ligne := '';
     if angleCB.checked
     then ligne := ligne+alpha+crTab
     else if NbreObjet=1
        then begin
            ligne := ligne+EchelleMecaBmpDlg.nomX.text+crTab;
            ligne := ligne+EchelleMecaBmpDlg.nomY.text+crTab;
        end
        else for j := 1 to NbreObjet do begin
           ligne := ligne+EchelleMecaBmpDlg.nomX.text+intToStr(j)+crTab;
           ligne := ligne+EchelleMecaBmpDlg.nomY.text+intToStr(j)+crTab;
        end;
     FormDDE.donnees.add(ligne);
     if avecT or angleCB.checked
        then ligne := EchelleMecaBmpDlg.uniteT.text+crTab
        else ligne := '';
     if angleCB.checked
     then ligne := ligne+'°'+crTab
     else for j := 1 to NbreObjet do begin
         ligne := ligne+EchelleMecaBmpDlg.uniteEdit.text+crTab;
         ligne := ligne+EchelleMecaBmpDlg.uniteEdit.text+crTab;
     end;
     FormDDE.donnees.add(ligne);
     for i := 0 to pred(NbrePoints[1]) do begin
         if avecT or angleCB.checked
            then ligne := FloatToStrPoint(i*deltaT)+crTab
            else ligne := '';
         if angleCB.checked
         then ligne := ligne+strAngle(i)+crTab
         else for j := 1 to NbreObjet do begin
             ligne := ligne+strX(j,i)+crTab;
             ligne := ligne+strY(j,i)+crTab;
         end;
         FormDDE.donnees.add(ligne);
     end;
     if pageCourante=0 then begin
           if angleCB.checked
           then AjouteOptionGrAngle
           else if avecX and avecY
              then AjouteOptionGrXY
              else if avecX
                 then AjouteOptionGrX
                 else AjouteOptionGrY;
     end;
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
     modeAcquisition := acqChrono;
     MesureBtn.Down := False;
     Close;
end; // envoieDonnees

Procedure TChronoForm.SetEchelle;
var PixelX : double;
begin
       PixelX := sqrt(
          sqr(PointRepere[bsEchelle2].x-PointRepere[bsEchelle1].x)+
          sqr(PointRepere[bsEchelle2].y-PointRepere[bsEchelle1].y)
          );
       Echelle := Longueur/PixelX;
       ArrondiXY := power(10,floor(log10(abs(Echelle))));
       OrigineX := PointRepere[bsOrigine].X;
       OrigineY := PointRepere[bsOrigine].Y;
       traceGrid;
end;

Function TChronoForm.GetBorne(x,y : integer) : TstyleDrag;
var i : TstyleDrag;
begin
      result := bsNone;
      for i in [bsOrigine,bsEchelle1,bsEchelle2] do
          if ((abs(x-e_PointRepere[i].x)+abs(y-e_PointRepere[i].y)) < Magnet)
                  then begin
                       result := i;
                       break;
                  end;
end;

procedure TChronoForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   convertitXY(sender,x,y);
   case BorneSelect of
      bsMesure : begin
         pointCourant := pointProche(x,y);
         if pointCourant>=0
          then begin
             setCursor(crCibleMove);
             hint := hDeplacerPoint;
          end
          else begin
             setCurseur(crCible);
             hint := hRepererPoint;
          end;
         statusBar.Panels[0].text := hint;
      end;
      bsSuppr : exit;
      else begin
        BorneSelect := GetBorne(x,y);
        case borneSelect of
           bsNone : setCurseur(crDefault);
           bsOrigine : setCurseur(crOrigine);
           bsEchelle1,bsEchelle2 : setCurseur(crCibleMove);
        end;
      end;
   end;
end;

procedure TChronoForm.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

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
   loupeForm.paintBox.OnMouseMove := nil;
   // mise à jour longue ...
   gainLoupe := zoomUD.value;
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

var BS : tstyleDrag;
    objetPrec,deltaX,nmes : integer;
begin
   if NomFichier='' then exit;
   convertitXY(sender,x,y);
   if (x<=0) or (y<=0) or (x>=largeurAff) or (y>=hauteurAff) then begin
      cacheLoupe;
      exit;
   end;
   case BorneSelect of
        bsMesure : if ssLeft in shift
          then begin
             if angleCB.checked and (objetCourant>1) and (PointCourant<0) then begin
                objetPrec := objetCourant-1;
                nmes := nbrePoints[ObjetPrec];
                if (ssShift in shift) then begin // horizontal ou vertical
                   deltaX := x-XY[objetPrec,nmes].x;
                   if deltaX<>0 then begin
                      if abs((y-XY[objetPrec,nmes].y)/deltaX)>1
                         then x := XY[objetPrec,nmes].x
                         else y := XY[objetPrec,nmes].y;
                   end;
                end; // Horiz
// ssShift   La touche Maj est enfoncée.
// ssAlt     La touche Alt est enfoncée.
// ssCtrl    La touche Ctrl est enfoncée.
// ssLeft    Le bouton gauche de la souris est enfoncé.
// ssRight   Le bouton droit de la souris est enfoncé.
// ssMiddle  Le bouton central de la souris est enfoncé.
// ssDouble  On a double-cliqué sur la souris.
                PaintBox.Canvas.moveTo(XY[objetPrec,nmes].x, XY[objetPrec,nmes].y);
                PaintBox.Canvas.moveTo(XY[objetPrec,nmes].x, XY[objetPrec,nmes].y);
                PaintBox.Canvas.lineTo(x, y); // retrace
          end; // mesure angulaire
          end
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
        bsOrigine,bsEchelle1,bsEchelle2 : AffecteBorne(x,y);
        bsNone : begin
           BS := GetBorne(x,y);
           case BS of
             bsNone : setCurseur(crDefault);
             bsOrigine : setCurseur(crOrigine);
             bsEchelle1 : setCurseur(crCibleMove);
             bsEchelle2 : setCurseur(crCibleMove);
           end;
           case BS of
               bsOrigine  : hint := hOrigineMove;
               bsEchelle1 : hint := hDebutEchelle;
               bsEchelle2 : hint := hFinEchelle;
               bsNone     : hint := hClicDroit;
           end;
           PaintBox.hint := hint;
        end;
   end; // case borne select
   if (borneSelect<>bsNone) and loupeBtn.Down and (zoomUD.value>1)
      then Loupe
      else cacheloupe;
   statusBar.Panels[0].text := hint;
end; // mouseMove

procedure TChronoForm.ImagePaint(Sender: TObject);

Procedure TraceLigne(P1,P2 : Tpoint);
begin
         with P1 do begin
            if y<marge then y := marge;
            if x<marge then x := marge;
            if y>(paintBox.height-marge) then y := paintBox.height-marge;
            if x>(paintBox.width-marge) then x := paintBox.width-marge;
            PaintBox.canvas.moveto(x,y);
         end;
         with P2 do begin
            if y<marge then y := marge;
            if x<marge then x := marge;
            if y>(paintBox.height-marge) then y := paintBox.height-marge;
            if x>(paintBox.width-marge) then x := paintBox.width-marge;
            PaintBox.canvas.lineto(x,y);
         end;
end;

Procedure TraceCercle(Apoint : Tpoint);
begin with Apoint do
      PaintBox.canvas.ellipse(x-rayon,y-rayon,
                              x+rayon+1,y+rayon+1)
end;

Procedure TraceCroix(Apoint : Tpoint);
begin with Apoint do begin
         TraceLigne(Point(x-sizeData,y),point(x+sizeData,y));
         TraceLigne(point(x,y-sizeData),point(x,y+sizeData));
end end;

   procedure TraceAngle(i : integer);
   var texte: string;
   begin
       TraceCroix(XY[2, i]); // sommet de l'angle
       PaintBox.Canvas.Arc(OrigineX-rayonAngle,OrigineY-rayonAngle,
                        OrigineX+rayonAngle,OrigineY+rayonAngle,
                        XY[1,i].x,XY[1,i].y,
                        XY[2,i].x,XY[2,i].y);
       PaintBox.canvas.moveTo(OrigineX,OrigineY);
       PaintBox.canvas.lineTo(XY[1,i].x,XY[1,i].y);
       PaintBox.canvas.moveTo(OrigineX,OrigineY);
       PaintBox.canvas.lineTo(XY[2,i].x,XY[2,i].y);
       texte := IntToStr(succ(i));
       PaintBox.Canvas.TextOut(XY[2, i].x + 2, XY[2, i].y + 2,texte);
// L'arc traverse le périmètre de l'ellipse circonscrite par les points (X1,Y1) et (X2,Y2).
// L'arc est dessiné en suivant le périmètre de l'ellipse, dans le sens contraire des aiguilles d'une montre
// jusqu'au point d'arrivée. Le point de départ est défini par l'intersection de l'ellipse et d'une ligne définie
// par le centre de l'ellipse et (X3,Y3). Le point d'arrivée est défini par l'intersection de l'ellipse et d'une ligne
// définie par le centre de l'ellipse et (X4,Y4).
   end;

Procedure TraceCroixData(i : integer;j : TindiceObjet);
var Apoint : Tpoint;
    texte : string;
begin
     Apoint.x := round(xy[j,i].x*pasZoom);
     Apoint.y := round(xy[j,i].y*pasZoom);
     TraceCroix(APoint);
     if etiquetteCB.checked then begin
        texte := intToStr(i);
        if NbreObjet>1 then texte := texte+'('+intToStr(j)+')';
        PaintBox.canvas.textOut(Apoint.x+SizeData,
                                Apoint.y+SizeData,
                                texte);
     end;
end;

Procedure TraceBorne;

Procedure TraceFleche(P1i,P2i : Tpoint);
var delta,zz : Tpoint;
    norme : integer;
begin
            delta.X := P1i.x-P2i.x;
            delta.Y := P1i.y-P2i.y;
            norme := round(sqrt(sqr(delta.X)+sqr(delta.Y)));
            delta.X := round(2*Magnet*delta.X/norme);
            delta.Y := round(2*Magnet*delta.Y/norme);
// zz = centre de la base de la flèche
            zz.y := P2i.y+delta.Y;          
            zz.x := P2i.x+delta.X;
            delta.x := round(delta.x/3);
            delta.y := round(delta.y/3);
            TraceLigne(P1i,P2i);
            TraceLigne(P2i,point(zz.x-delta.Y,zz.y+delta.X));
            TraceLigne(P2i,point(zz.x+delta.Y,zz.y-delta.X));
            TraceLigne(point(P1i.x-delta.Y,P1i.y+delta.X),
                       point(P1i.x+delta.Y,P1i.y-delta.X));
end;

var apoint : Tpoint;
    Langle : integer;
begin
       PaintBox.canvas.pen.color := couleur[0];
       TraceLigne(e_PointRepere[bsEchelle1],e_PointRepere[bsEchelle2]);
       TraceCroix(e_PointRepere[bsEchelle1]);
       TraceCroix(e_PointRepere[bsEchelle2]);
       Langle := round(arcTan2(e_PointRepere[bsEchelle2].Y-e_PointRepere[bsEchelle1].Y,
                              e_PointRepere[bsEchelle1].X-e_PointRepere[bsEchelle2].X)*180/system.pi);
       if Langle>90 then Langle := Langle-180;
       if Langle<-90 then Langle := Langle+180;
       Brush.Style := bsClear; // Set the brush style to transparent.
       PaintBox.canvas.font.orientation := Langle*10;
       PaintBox.canvas.font.color := couleur[0];
       PaintBox.canvas.font.size := 12;
       PaintBox.canvas.TextOut((e_PointRepere[bsEchelle1].X+e_PointRepere[bsEchelle2].X) div 2,
               (e_PointRepere[bsEchelle1].Y+e_PointRepere[bsEchelle2].Y) div 2,
               EchelleMecaBmpDlg.echelleEDit.text+EchelleMecaBmpDlg.uniteEdit.text);
       PaintBox.canvas.font.orientation := 0;
       PaintBox.canvas.font.size := 8;
       TraceCercle(e_PointRepere[bsOrigine]);
// axe vertical
       aPoint := e_PointRepere[bsOrigine];
       if signeY>0
          then begin
             inc(aPoint.y,2*hauteurAff div 3);
             if aPoint.Y>hauteurAff-marge then aPoint.Y := hauteurAff-marge
          end
          else begin
             dec(aPoint.y,2*hauteurAff div 3);
             if aPoint.Y<marge then aPoint.Y := marge
          end;
       TraceFleche(e_PointRepere[bsOrigine],aPoint);
// axe horizontal
       aPoint := e_PointRepere[bsOrigine];
       inc(aPoint.x,2*largeurAff div 3);
       if aPoint.x>largeurAff-marge then aPoint.x := largeurAff-marge;
       TraceFleche(e_PointRepere[bsOrigine],aPoint);
end; // TraceBorne

  procedure ImageVersEcran;
  var i : TstyleDrag;
  begin
       for i := low(TstyleDrag) to high(TstyleDrag) do begin
           if PointRepere[i].y<marge then PointRepere[i].y := marge;
           if PointRepere[i].x<marge then PointRepere[i].x := marge;
           if PointRepere[i].x>(largeur-marge) then
              PointRepere[i].x := largeur-marge;
           if PointRepere[i].y>(hauteur-marge) then
              PointRepere[i].y := hauteur-marge;
           e_pointRepere[i].x := round(pointRepere[i].x*pasZoom);
           e_pointRepere[i].y := round(pointRepere[i].y*pasZoom);
       end;
  end;

var i : integer;
    j : TindiceObjet;
    zoomH,zoomV : double;
begin //imagePaint
    if NomFichier='' then exit;
    ZoomH := paintBox.Height/hauteur;
    ZoomV := paintBox.Width/largeur;
    if zoomV<zoomH
         then pasZoom := ZoomV
         else pasZoom := ZoomH;
    ImageVersEcran;
    hauteurAff := round(hauteur*pasZoom);
    largeurAff := round(largeur*pasZoom);
    PaintBox.canvas.CopyRect(rect(0,0,largeurAff,hauteurAff),
            Abitmap.canvas,rect(0,0,largeur,hauteur));
    PaintBox.canvas.brush.style := bsClear;
    if angleCB.Checked
      then begin
           for i := 0 to pred(NbrePoints[1]) do
                traceAngle(i)
      end
      else for j := 1 to NbreObjet do begin
           PaintBox.canvas.pen.color := couleur[j];
           PaintBox.canvas.font.color := couleur[j];
           for i := 0 to pred(NbrePoints[j]) do
               traceCroixData(i,j);
      end;
    TraceBorne;
    EditBidon.setFocus;
end; // imagePaint

procedure TChronoForm.EtiquetteCBClick(Sender: TObject);
begin
    paintBox.repaint
end;

procedure TChronoForm.ExitBtnClick(Sender: TObject);
begin
    Close
end;

procedure TChronoForm.ImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Procedure setBorne;
begin
    AffecteBorne(x,y);
    BorneSelect := bsNone;
    setCurseur(crDefault);
    setEchelle;
end; // setBorne

begin
     if Button<>mbLeft then exit;
     convertitXY(sender,x,y);
     case BorneSelect of
          bsMesure : ajoutePoint(x,y);
          bsSuppr : supprimePoint(x,y);
          bsNone : setCurseur(crDefault);
          else setBorne;
     end;
end;

Function TChronoForm.PointProche(X,Y : Integer) : integer;
var distance, newDistance : double;
    i,j : integer;
begin
         result := -1;
         ObjetSelect := 1;
         Distance := 10;
         x := round(x/pasZoom);
         y := round(y/pasZoom);
         for j := 1 to NbreObjet do
         for i := 0 to pred(NbrePoints[j]) do begin
             newDistance := abs(xy[j,i].x-x)+
                            abs(xy[j,i].y-y);
             if (newDistance<distance) then begin
                distance := newDistance;
                result := i;
                ObjetSelect := j;
             end;
         end;
end;

procedure TChronoForm.EditBidonKeyDown(Sender: TObject; var Key: Word;
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
          vk_delete : ;
          vk_space,vk_return : case BorneSelect of
             bsMesure : begin
                P := PaintBox.ScreenToClient(P);
                ajoutePoint(P.x,P.y);
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

procedure TChronoForm.EchelleBtnClick(Sender: TObject);
begin
    if EchelleMecaBmpDlg.showModal=mrOK then begin
       NbreObjet := round(EchelleMecaBmpDlg.NbreSE.value);
       SerieSE.maxValue := NbreObjet;
       if serieSE.Value > NbreObjet then SerieSE.maxValue := 1;
       SerieSE.visible := NbreObjet > 1;
       SerieLabel.visible := SerieSE.visible;
       if EchelleMecaBmpDlg.signeYCB.checked
          then signeY := +1
          else signeY := -1;
    end;
    PaintBox.repaint;
    BorneSelect := bsNone;
    setCurseur(crDefault);
    statusBar.Panels[0].text := hRepererPoint;
    hint := '';
    statusBar.Panels[1].text := '';
    MesureBtn.enabled := true;
    EchelleBtn.enabled := true;
    PointCourant := -1;
    setEchelle;
    traceGrid;
end;

procedure ConvertitGifBmp(var nomFichier: string);
var
  GIF		 : TGIFImage;
  Bitmap : TBitmap;
begin
    GIF := TGIFImage.Create;
    try
      GIF.OnProgress := Nil;
      // Load the GIF that will be converted
      nomFichier := ChangeFileExt(nomFichier,'.gif');
      GIF.LoadFromFile(nomFichier);
      Bitmap := TBitmap.Create;
      try
        // Convert the GIF to a BMP
        Bitmap.Assign(GIF);
        // Save the BMP
        nomFichier := ChangeFileExt(nomFichier,'.bmp');
        Bitmap.SaveToFile(nomFichier);
      finally
        Bitmap.Free;
      end;
    finally
      GIF.Free;
    end;
end;

procedure TChronoForm.OuvreFichier(const Nom: String);

procedure MajBitmap;
var i : integer;
    j : TindiceObjet;
begin
     Largeur := Abitmap.width;
     Hauteur := Abitmap.height;
     for j := 1 to maxObjet do begin
         NbrePoints[j] := 0;
         for i := 0 to maxPixel do
             XY[j,i] := point(0,0);
     end;
     couleur[0] := couleurComplementaire(Abitmap);
     couleur[1] := couleur[0];
     CouleurPointsCB.selected := couleur[1];
     CouleurAxeCB.selected := couleur[0];
     PointRepere[bsOrigine] := point(Largeur div 5,4*Hauteur div 5);
     PointRepere[bsEchelle1] := point(Largeur div 3,Hauteur div 4);
     PointRepere[bsEchelle2] := point(Largeur div 3,3*Hauteur div 4);
     BorneSelect := bsNone;
     MesureBtn.enabled := false;
     EchelleBtn.enabled := true;
     UndoBtn.enabled := false;
     RegressiBtn.enabled := false;
     objetCourant := 1;
     NbreObjet := 1;
     PaintBox.repaint;
     EditBidon.setFocus;
     Caption := 'Lecture de chronophotographie ['+ExtractFileName(NomFichier)+']';
     statusBar.Panels[0].text := hRepereBmp;
end; // MajBitmap

var extension : String;
    Ajpeg : TjpegImage;
    Apng : TpngImage;
begin
     screen.cursor := crHourGlass;
     NomFichier := AnsiUpperCase(Nom);
     extension := AnsiUpperCase(extractFileExt(NomFichier));
     if (extension='.GIF') then begin
          ConvertitGifBmp(nomFichier);
          extension := '.BMP';
     end;
     if (extension='.PNG') then begin
           Apng := TpngImage.create;
           Apng.LoadFromFile(Nom);
           with Abitmap do begin
                pixelFormat := pf24bit;
                height := Apng.Height;
                width := Apng.Width;
                assign(Apng);
                nomFichier := changeFileExt(nom,'.BMP');
                saveToFile(nomFichier);
           end;
           Apng.free;
           extension := '.BMP';
     end;
     if (extension='.BMP') then
        ABitmap.LoadFromFile(NomFichier);
        // supprt TIFF wincodec twicimage dans delphi 2010
     if (extension='.JPG') or (extension='.JPEG') then begin
         Ajpeg := TjpegImage.create;
         Ajpeg.LoadFromFile(NomFichier);
         with Abitmap do begin
              pixelFormat := pf24bit;
              height := hauteur; // ??
              width := largeur;
         end;
         Abitmap.assign(Ajpeg);
         Ajpeg.free;
         nomFichier := changeFileExt(nom,'.BMP');
         Abitmap.saveToFile(nomFichier);
     end;
     MajBitMap;
     screen.cursor := crDefault;
     EchelleBtnClick(nil);
     statusBar.Panels[0].text := hparamBtn;
end; // OuvreFichier

    procedure TChronoForm.EcranVersImage;
    var i : TstyleDrag;
    begin
       for i := low(TstyleDrag) to High(TstyleDrag) do begin
           pointRepere[i].x := round(e_pointRepere[i].x/pasZoom);
           pointRepere[i].y := round(e_pointRepere[i].y/pasZoom);
       end;
    end;

procedure TChronoForm.StopBtnClick(Sender: TObject);
begin
     BorneSelect := bsNone;
     setCurseur(crDefault);
     MesureBtn.enabled := true;
     UndoBtn.enabled := false;
     EchelleBtn.enabled := true;
     RazBtn.enabled := NbrePoints[1]>0;
     statusBar.Panels[0].text := hTransfertRegressi;
end;

procedure TChronoForm.MesureBtnClick(Sender: TObject);
var i,j,N : integer;
begin
if MesureBtn.down
     then begin
     BorneSelect := bsMesure;
     setCurseur(crCible);
     statusBar.Panels[0].text := hRepererPoint;
     hint := '';
     statusBar.Panels[1].text := '';
     EchelleBtn.enabled := false;
     N := NbrePoints[1];
     ObjetCourant := 1;
     for j := maxObjet downto 1 do
        if NbrePoints[j]<=N then begin
           ObjetCourant := j;
           N := NbrePoints[j];
        end;
     PointCourant := -1;
     if angleCB.checked
        then Grid.ColCount := 2
        else Grid.ColCount := EchelleMecaBmpDlg.NbreSE.value*2+1;
     Grid.cells[0,0] := EchelleMecaBmpDlg.nomT.text+'('+EchelleMecaBmpDlg.uniteT.text+')';
     if angleCB.checked then
           Grid.cells[1,0] := 'angle(°)'
     else for j := 1 to EchelleMecaBmpDlg.NbreSE.value do begin
           Grid.cells[j*2-1,0] := EchelleMecaBmpDlg.nomX.text+intToStr(j)+
                                 '('+EchelleMecaBmpDlg.uniteEdit.text+')';
           Grid.cells[j*2,0] := EchelleMecaBmpDlg.nomY.text+intToStr(j)+
                                '('+EchelleMecaBmpDlg.uniteEdit.text+')';
     end;
     if angleCB.checked then ObjetCourant := 1;
     for i := 1 to pred(grid.rowCount) do
          for j := 0 to pred(grid.colCount) do
              Grid.cells[j,i] := '';
     grid.Col := 0;
     grid.Row := 1;
     MesureBtn.Hint := hStopMes;
     MesureBtn.imageIndex := 0;
     MesureBtn.Caption := stStop;
     PaintBox.repaint;
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
     end;
end;

procedure TChronoForm.UndoBtnClick(Sender: TObject);
begin
     if NbrePoints[objetCourant]>0 then dec(nbrePoints[ObjetCourant]);
     UndoBtn.enabled := nbrePoints[ObjetCourant]>0;
     PaintBox.repaint;
end;

procedure TChronoForm.CouleurAxeCBChange(Sender: TObject);
begin
      couleur[0] := couleurAxeCB.selected;
      if nomFichier='' then exit;
      PaintBox.repaint;
end;

procedure TChronoForm.CouleurPointsCBChange(Sender: TObject);
begin
      couleur[objetCourant] := couleurPointsCB.selected;
      if nomFichier='' then exit;
      TraceGrid;
      PaintBox.repaint;
end;

procedure TChronoForm.FormDestroy(Sender: TObject);
begin
     if LoupeForm<>nil then begin
        if LoupeForm.visible then LoupeForm.hide;
        LoupeForm.close;
        LoupeForm.free;
        LoupeForm := nil;
     end;
     bitmapLoupe.Free;
     Abitmap.free;
     chronoForm := nil;
end;

procedure TChronoForm.FormResize(Sender: TObject);
begin
     if gridPanel.Width>clientWidth div 3 then
        gridPanel.Width := clientWidth div 3;
end;

procedure TChronoForm.RazBtnClick(Sender: TObject);
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
     PaintBox.repaint;
end;

procedure TChronoForm.SupprBtnClick(Sender: TObject);
begin
      OldBorne := BorneSelect;
      BorneSelect := bsSuppr;
      setCurseur(crDefault);
      oldStatus := statusBar.Panels[0].text;
      statusBar.Panels[0].text := hSupprPoint;
      hint := '';
      statusBar.Panels[1].text := '';
end;

Procedure TChronoForm.AjoutePoint(x,y : integer);
begin
    if pointCourant>=0
       then XY[ObjetSelect,PointCourant] :=
                point(round(x/pasZoom-1/2),
                      round(y/pasZoom-1/2))
       else begin
               XY[ObjetCourant,NbrePoints[ObjetCourant]] :=
                        point(round(x/pasZoom),round(y/pasZoom));
               inc(NbrePoints[ObjetCourant]);
               if angleCB.Checked then begin
                  if objetCourant=3
                     then objetCourant := 1 // prochain angle
                     else inc(objetCourant); // prochain point de définition de l'angle
               end
               else if (ObjetCourant>1) and
                  (NbrePoints[1]=NbrePoints[ObjetCourant]) then
                      stopBtnClick(nil);
       end;
    pointCourant := -1;
    setCurseur(crCible);
    UndoBtn.enabled := NbrePoints[ObjetCourant]>0;
    SupprBtn.enabled := NbrePoints[ObjetCourant]>0;
    RazBtn.enabled := NbrePoints[1]>0;
    RegressiBtn.enabled := NbrePoints[1]>2;
    traceGrid;
    PaintBox.repaint;
end;

procedure TChronoForm.angleCBClick(Sender: TObject);
begin
  inherited;
  SerieLabel.Visible := not angleCB.checked;
  SerieSE.Visible := not angleCB.checked;
end;

Procedure TChronoForm.SupprimePoint(x,y : integer);
var i,num : integer;
begin
      Num := PointProche(x,y);
      if num>=0 then begin
         dec(NbrePoints[objetSelect]);
         for i := num to pred(NbrePoints[ObjetSelect]) do
             xy[ObjetSelect,i] := xy[ObjetSelect,succ(i)];
         PaintBox.repaint;
         UndoBtn.enabled := NbrePoints[ObjetCourant]>0;
         SupprBtn.enabled := NbrePoints[ObjetCourant]>0;
         RazBtn.enabled := NbrePoints[1]>0;
         RegressiBtn.enabled := NbrePoints[1]>2;
      end;
      BorneSelect := oldBorne;
      statusBar.Panels[0].text := oldStatus;
end;

procedure TChronoForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Fichier : TIniFile;
    j : integer;
begin
     try
     Fichier := TIniFile.create(NomFichierIni);
     try
     for j := 0 to maxObjet do
         Fichier.writeInteger(Titre,stCouleur+intToStr(j),Couleur[j]);
     Fichier.writeBool(Titre,'SigneY',echelleMecaBmpDlg.SigneYCB.checked);
     Fichier.writeString(Titre,'UniteX',echelleMecaBmpDlg.uniteEdit.text);
     Fichier.writeInteger(Titre,'Filtre',OpenDialog.filterIndex);
     if openDialog.InitialDir<>'' then
        imagesDir := openDialog.InitialDir;
     finally
     Fichier.free;
     end;
     except
     end;
     inherited;
end;

procedure TChronoForm.SerieSEChange(Sender: TObject);
begin
   ObjetCourant := round(SerieSE.Value);
   CouleurPointsCB.selected := couleur[objetCourant];
end;

Function TChronoForm.StrX(j : TindiceObjet;i : integer) : String;
begin
    result := FloatToStrPoint(ArrondiXY*round((
               echelle*((xy[j,i].x-origineX)))/ArrondiXY))
end;

Function TChronoForm.StrY(j : TindiceObjet;i : integer) : String;
begin
    result := FloatToStrPoint(ArrondiXY*round((
        signeY*echelle*((xy[j,i].y-origineY)))/ArrondiXY))
end;

function TChronoForm.StrAngle(i: integer): string;
begin
   Result := FloatToStrPoint(ArrondiXY * round(valeurAngle(i) / ArrondiXY));
end;

procedure TChronoForm.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s : String;
begin
   TstringGrid(sender).canvas.Font.Color := couleurGrid[Acol];
   S := TstringGrid(sender).cells[ACol,ARow];
   with TstringGrid(sender).canvas do
        TextOut(Rect.Left + 2, Rect.Top + 2,S);
end;

procedure TChronoForm.HelpBtnClick(Sender: TObject);
begin
    Aide(Help_Numerisationdunecourbe);
end;

procedure TChronoForm.FileBtnClick(Sender: TObject);
begin
    if OpenDialog.InitialDir='' then
       OpenDialog.InitialDir := ImagesDir;
    if OpenDialog.execute then begin
       ouvreFichier(openDialog.fileName);
       OpenDialog.InitialDir := extractFilePath(openDialog.fileName);
    end;
end;

Procedure TChronoForm.TraceGrid;

function GetCouleurGrid(Acol : integer) : TColor;
begin
if ACol=0
     then result := clBlack
     else result := couleur[(ACol+1) div 2];
case result of
    clMaroon: ;
    clGreen: ;
    clOlive: ;
    clNavy: ;
    clPurple: ;
    clTeal: ;
    clGray: ;
    clBlue: ;
    clFuchsia: ;
    clRed: ;
    clLime,clMoneyGreen: Result := clGreen;
    clAqua,clSkyBlue: Result := clBlue;
    clMedGray: Result := clGray;
    else Result := clBlack;
end; // case
end;

var i,j : integer;
begin
   if (NbrePoints[1]+2)>grid.rowCount then
        grid.rowCount := NbrePoints[1]+5;
   CouleurGrid[0] := clBlack;
   for j := 1 to maxObjet do begin
       CouleurGrid[2*j-1] := getCouleurGrid(2*j-1);
       CouleurGrid[2*j] := CouleurGrid[2*j-1];
   end;
   if angleCB.checked then begin
      for i := 0 to pred(NbrePoints[1]) do
          Grid.cells[1, i+1] := strAngle(i);
   end
   else begin
         for i := 0 to pred(NbrePoints[1]) do
              grid.cells[0,i+1] := FloatToStrF(i*deltaT,ffFixed,4,2);
         for j := 1 to NbreObjet do begin
             for i := 0 to pred(NbrePoints[j]) do begin
                 Grid.cells[j*2-1,i+1] := strX(j,i);
                 Grid.cells[j*2,i+1] := strY(j,i);
             end;
             for i := NbrePoints[j] to (grid.rowCount-2) do begin
                 grid.cells[j*2-1,i+1] := '';
                 grid.cells[j*2,i+1] := '';
             end;
         end;
   end;
   grid.Row := NbrePoints[1]+1;
end;

function TChronoForm.valeurAngle(i : integer) : double;
var CA,CB : Tpoint;
    PS,PV : integer;
begin
    CA.x := xy[1, i].x-OrigineX;
    CA.y := xy[1, i].y-OrigineY;
    CB.x := xy[2, i].x-OrigineX;
    CB.y := xy[3, i].y-OrigineY;
    PS := CA.X*CB.X+CA.Y*CB.Y;
    PV := -CA.X*CB.Y+CA.Y*CB.X;
    result := radToDeg(arcTan2(PV,PS));
end;

procedure TChronoForm.ConvertitXY(Sender: TObject;var X, Y: Integer);
var PointImage,PointLoupe : TPoint;
begin
    if (sender=LoupeForm.paintBox) then begin
       PointImage := PaintBox.ClientToScreen(Point(0,0));
       PointLoupe := LoupeForm.ClientToScreen(Point(0,0));
       x := x+pointLoupe.X-PointImage.X;
       y := y+pointLoupe.Y-PointImage.Y;
    end;
end;

procedure TChronoForm.CacheLoupe;
begin
     if loupeForm.visible then begin
        loupeForm.hide;
        setFocus;
     end;
end;

procedure TChronoForm.SetCurseur(Acursor : Tcursor);
begin
    if paintBox.Cursor<>Acursor then begin
       PaintBox.cursor := Acursor;
       cursor := Acursor;
    end;
    if (aCursor=crDefault) then cacheLoupe;
end;

Procedure TChronoForm.AffecteBorne(x,y : integer);
begin
    if x<marge then x := marge;
    if y<marge then y := marge;
    if x>largeurAff-marge then x := largeurAff-marge;
    if y>hauteurAff-marge then y := hauteurAff-marge;
    e_PointRepere[BorneSelect] := point(x,y);
    EcranVersImage;
    PaintBox.repaint;
end; // AffecteBorne

end.

