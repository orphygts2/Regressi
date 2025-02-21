unit graph3D;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     Dialogs, sysUtils, Buttons, StdCtrls, Grids, Messages, printers,
     math, ComCtrls, Spin, system.Types,
     constreg, maths, regutil, uniteker, compile, graphker,
     ImgList, ToolWin, System.ImageList,
     GraphicsPrimitivesLibrary, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.VirtualImageList;

type
  Tfgraphe3D = class(TForm)
    PaintBox: TPaintBox;
    PopupMenuAxes: TPopupMenu;
    CoordonneesItem: TMenuItem;
    PanelCourbe: TPanel;
    ImprimeGrItem: TMenuItem;
    EditBidon: TEdit;
    ToolBarGr: TToolBar;
    CordonneesBtn: TToolButton;
    ImprimeBtn: TToolButton;
    CopierBtn: TToolButton;
    CurseurBtn: TToolButton;
    SupprReticule: TMenuItem;
    EnregistrerGrapheItem: TMenuItem;
    SaveDialog: TSaveDialog;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CoordonneesItemClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImprimeGrItemClick(Sender: TObject);
    procedure EnregistrerGrapheItemClick(Sender: TObject);
  private
      modification : boolean;
      xClic,yClic : integer;
      azimuthClic,elevationClic : double;
      Azimuth, Elevation : double;
      Distance, ScreenSize, ScreenToCamera : double;
      xmin,xmax : double;
      ymin,ymax : double;
      zmin,zmax : double;
      Procedure SetCoordonnee;
      procedure Draw(Pantograph: TPantograph);
  protected
      procedure WMRegMaj(var Amessage: TWMRegMessage); message WM_Reg_Maj;
  public
      majFichierEnCours : boolean;
      Coordonnee : Tcoordonnee;
      ordonneeParam : boolean;
  end;

var fgraphe3D : Tfgraphe3D;

implementation

uses
    clipBrd, options, Coord3D, regmain,
    GraphicsMathLibrary, modif;

{$R *.DFM}


procedure Tfgraphe3D.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin // MouseMove
    if ssLeft in Shift  then begin
       Azimuth := azimuthClic+1.1*(x-xClic)/paintbox.width;
       if azimuth>1.3 then azimuth := 1.3;
       if azimuth<-1.3 then azimuth := -1.3;
       Elevation := elevationClic+0.6*(y-yClic)/paintbox.height;
       if elevation>0.8 then elevation := 0.8;
       if elevation<-0.3 then elevation := -0.3;
       paintBox.Invalidate;
    end;
end; // FormMouseMove

procedure Tfgraphe3D.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    xClic := x;
    yClic := y;
    elevationClic := Elevation;
    azimuthClic := Azimuth;
end; // FormMouseDown

procedure Tfgraphe3D.FormCreate(Sender: TObject);
begin
  MajFichierEnCours := true;
  modification := true;
  ImprimeBtn.visible := imBoutonImpr in menuPermis;
  Distance := 10;
  ScreenSize := 5;
  ScreenToCamera := 30;
  elevation := 0.1;
  azimuth := 0.1;
  VirtualImageList1.height := VirtualImageListSize;
  VirtualImageList1.width := VirtualImageListSize;
end;

procedure Tfgraphe3D.SetCoordonnee;

procedure ChercheMinMaxPages;
var p,i : integer;
    x,y,z : double;
begin
     ymin := pages[1].valeurParametre(coordonnee.codeY);
     ymax := ymin;
     zmin := pages[1].valeurVar[coordonnee.codeZ,0];
     zmax := zmin;
     xmin := pages[1].valeurVar[coordonnee.codeX,0];
     xmax := xmax;
     FOR p := 1 TO NbrePages DO with pages[p] do begin
      y := valeurParametre(coordonnee.codeY);
      if y>ymax then ymax := y else if y<ymin then ymin := y;
      FOR i := 0 TO pred(nmes) DO begin
        x := valeurVar[coordonnee.codeX,i];
        if x>xmax then xmax := x else if x<xmin then xmin := x;
        z := valeurVar[coordonnee.codeZ,i];
        if z>zmax then zmax := z else if z<zmin then zmin := z;
      end;// for i
   end;// for p
end;

procedure ChercheMinMaxPageCourante;
var i : integer;
    x,y,z : double;
begin with pages[pageCourante] do begin
     ymin := valeurVar[coordonnee.codeY,0];
     ymax := ymin;
     zmin := valeurVar[coordonnee.codeZ,0];
     zmax := zmin;
     xmin := valeurVar[coordonnee.codeX,0];
     xmax := xmax;
     FOR i := 0 TO pred(nmes) DO begin
        x := valeurVar[coordonnee.codeX,i];
        if x>xmax then xmax := x else if x<xmin then xmin := x;
        z := valeurVar[coordonnee.codeZ,i];
        if z>zmax then zmax := z else if z<zmin then zmin := z;
        y := valeurVar[coordonnee.codeY,i];
        if y>ymax then xmax := y else if y<ymin then ymin := y;
      end;// for i
end end;

begin
     with coordonnee do begin
        codeX := indexNom(nomX);
        if (codeX=grandeurInconnue) or
           (grandeurs[codeX].genreG<>variable) then begin
                  codeX := indexVariab[0];
                  nomX := grandeurs[codeX].nom;
        end;
        codeZ := indexNom(nomZ);
        if (codeX=grandeurInconnue) or
           (grandeurs[codeZ].genreG<>variable) then begin
                  codeZ := indexVariab[1];
                  nomZ := grandeurs[codeZ].nom;
        end;
        codeY := indexNom(nomY);
        if (codeY=grandeurInconnue) or
           not(grandeurs[codeY].genreG in [variable,constante,paramNormal]) then
                  if NbreConst>0
                    then begin
                        codeY := indexConst[0];
                        nomY := grandeurs[codeY].nom;
                    end
                    else begin
                        codeY := ParamToIndex(paramNormal,1);
                        nomY := Parametres[paramNormal,1].nom;
                    end;
        ordonneeParam := grandeurs[codeY].genreG<>variable;
     end;
     if ordonneeParam
        then chercheMinMaxPages
        else chercheMinMaxPageCourante;
   if zmax*zmin>0 then if zmin>0 then zmin := 0 else zmax := 0;
   if xmax*xmin>0 then if xmin>0 then xmin := 0 else xmax := 0;
   if ymax*ymin>0 then if ymin>0 then ymin := 0 else ymax := 0;
   modification := false;
end; // setCoordonnees

procedure Tfgraphe3D.CoordonneesItemClick(Sender: TObject);
begin
    if FCoordonnees3D=nil then application.CreateForm(TFcoordonnees3D,Fcoordonnees3D);
    with Fcoordonnees3D do begin
        if Fcoordonnees3D.ShowModal=mrOK then begin
            modification := true;
            PaintBox.invalidate;
        end;
     end;
end;

procedure Tfgraphe3D.WMRegMaj(var Amessage: TWMRegMessage);
begin
   case Amessage.typeMaj of
      MajPreferences : ImprimeBtn.visible := imBoutonImpr in menuPermis;
      MajVide : majFichierEnCours := true;
      MajFichier : if majFichierEnCours then begin
         if (WindowState=wsMinimized) and
            (dispositionFenetre<>dNone)
                then WindowState:=wsNormal;
         MajFichierEnCours := false;
      end;
      MajSupprPage,MajAjoutPage,MajModele,
      MajGrandeur,MajTri,MajValeurConst,MajValeur : begin
         Modification := true;
         MajFichierEnCours := false;
         PaintBox.invalidate;
      end;
   end;
end;

procedure Tfgraphe3D.PaintBoxPaint(Sender: TObject);
var pantograph : Tpantograph;
begin // PaintBoxPaint
    if (pageCourante=0) or MajFichierEnCours then exit;
    if modification then setCoordonnee;
   	canvas.Pen.mode := pmCopy;
    paintBox.canvas.brush.Color := clWindow;
    paintBox.canvas.brush.style := bsSolid;
    paintBox.canvas.FillRect(paintBox.clientRect);
    pantograph := TPantoGraph.Create(paintBox.Canvas);
    Draw(pantograph);
    pantograph.Free;
end; // PaintBoxPaint

procedure Tfgraphe3D.Draw(pantograph: TPantograph);

procedure DrawPages;
var i,j : integer;
    x,y,z : double;
    u : Tvector;
begin
     FOR j := 1 TO NbrePages DO with pages[j] do begin
      y := valeurParametre(coordonnee.codeY);
      x := valeurVar[coordonnee.codeX,0];
      z := valeurVar[coordonnee.codeZ,0];
      u := Vector3D(x,y,z);
      pantograph.MoveTo (u);
      FOR i := 1 TO pred(nmes) DO begin
        x := valeurVar[coordonnee.codeX,i];
        z := valeurVar[coordonnee.codeZ,i];
        u := Vector3D(x,y,z);
        pantograph.LineTo(u);
      end;
    end;
end;

procedure DrawPageCourante;
var i : integer;
    x,y,z : double;
    u : Tvector;
begin with pages[pageCourante] do begin
      y := valeurVar[coordonnee.codeY,0];
      x := valeurVar[coordonnee.codeX,0];
      z := valeurVar[coordonnee.codeZ,0];
      u := Vector3D(x,y,z);
      pantograph.MoveTo (u);
      FOR i := 1 TO pred(nmes) DO begin
        x := valeurVar[coordonnee.codeX,i];
        z := valeurVar[coordonnee.codeZ,i];
        y := valeurVar[coordonnee.codeY,i];
        u := Vector3D(x,y,z);
        pantograph.LineTo (u);
      end;
end end;

var u :   TVector;
    a,b :  TMatrix;
begin
    a := ViewTransformMatrix(coordSpherical,
           Azimuth, Elevation,
           Distance, ScreenSize,ScreenSize,
           ScreenToCamera);
    pantograph.WorldCoordinatesRange (0.0, 1.0,  0.0, 1.0);
    pantograph.World3DCoordinatesRange (xmin,xmax,ymin,ymax,zmin,zmax);
    with coordonnee do
         pantograph.nameAxis(nomX,nomY,nomZ);

    u := Vector3D(1/(xmax-xmin),1/(ymax-ymin),1/(zmax-zmin));
    b := scaleMatrix(u);
    a := MultiplyMatrices(b, a);
    u := Vector3D(-(xmin+xmax)/2,-(ymin+ymax)/2,-(zmin+zmax)/2);
    // Milieu au centre !
    b := TranslateMatrix(u);
    a := MultiplyMatrices(b, a);
    pantograph.Transformation := a;

    Pantograph.drawAxis;

    Pantograph.hiding := true;
    Pantograph.Color := coordonnee.couleur;

    Pantograph.canvas.Pen.style := coordonnee.styleT;
    Pantograph.canvas.Pen.width := 1;

    if ordonneeParam
       then drawPages
       else drawPageCourante;
end; // Draw

procedure Tfgraphe3D.FormDestroy(Sender: TObject);
begin
     Fgraphe3D := nil
end;

(*
Procedure Tfgraphe3D.ecritConfig;
begin
   writeln(fichier,symbReg2,1,' X');
       ecritChaineRW3(coordonnee.nomX);
   writeln(fichier,symbReg2,1,' Y');
       ecritChaineRW3(coordonnee.nomY);
   writeln(fichier,symbReg2,1,' Z');
       ecritChaineRW3(coordonnee.nomZ);
   if dispositionFenetre=dNone then begin
      writeln(fichier,symbReg2,'5 '+stFENETRE);
      writeln(fichier,ord(windowState));
      writeln(fichier,top);
      writeln(fichier,left);
      writeln(fichier,width);
      writeln(fichier,height);
   end;   
end;

Procedure Tfgraphe3D.litConfig;
var i,Nligne,zint : integer;
    choix : integer;
    zByte : byte;
begin
   majFichierEnCours := true;
   while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
      choix := 0;
      Nligne := NbreLigneWin(ligneWin);
      if pos('X',ligneWin)<>0 then choix := 1;
      if pos('Y',ligneWin)<>0 then choix := 2;
      if pos('Z',ligneWin)<>0 then choix := 3;
      if pos(stFENETRE,ligneWin)<>0 then choix := 4;
      case choix of
           0 : for i := 1 to Nligne do readln(fichier);
           1 : coordonnee.nomX := litLigneWinU;
           2 : coordonnee.nomY := litLigneWinU;
           3 : coordonnee.nomZ := litLigneWinU;
           4 : begin
              readln(fichier,zByte);
              windowState := TwindowState(zByte);
              readln(fichier,zint);
              top := zint;
              readln(fichier,zint);
              left := zint;
              readln(fichier,zint);
              width := zint;
              readln(fichier,zint);
              height := zint;
              position := poDesigned;
           end;
       end;
       litLigneWin;
   end;
end;
*)

procedure Tfgraphe3D.FormActivate(Sender: TObject);
begin
     inherited;
     ImprimeBtn.visible := imBoutonImpr in menuPermis;
     FregressiMain.Graphe3DBtn.down := true;
end;

procedure Tfgraphe3D.ImprimeGrItemClick(Sender: TObject);
var pantographPr : Tpantograph;
begin
     if OKreg(OkImprGr,0) then begin
     pantographPr := TPantoGraph.Create(printer.Canvas);
     try
     printer.title := stRegressi;
     printer.beginDoc;
     draw(pantographPr);
     printer.endDoc;
     finally
        pantographPr.Free;
     end;
     end;
end;

(*
procedure Tfgraphe3D.ImprimerGraphe(var bas : integer);
var pantographPr : Tpantograph;
begin
    pantographPr := TPantoGraph.Create(printer.Canvas);
    draw(PantographPr);
    pantographPr.Free;
end;
 *)

procedure Tfgraphe3D.EnregistrerGrapheItemClick(Sender: TObject);
begin
    saveDialog.options := saveDialog.options-[ofOverwritePrompt];
end;

end.

