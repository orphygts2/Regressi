unit interfMain;

interface

uses
  Windows, SysUtils, Messages,  Classes,  Graphics, Controls,  Forms,
  Dialogs, StdCtrls,  ExtCtrls,  Buttons,  Math, ComCtrls, Vcl.ExtDlgs,
  ImgList, ToolWin, Menus, Spin, gifImg, system.IOUtils,
  constreg, jpeg,  pngImage, inifiles,
  grapheU, regutil, uniteKer,
  system.Types, System.ImageList,
  Vframes, Vcl.Mask, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection;

type
  TstyleDragOptique = (bsNone,bsOrigine,bsDirection,bsEchelle1,bsEchelle2,bsAngle1,bsAngle2,bsAngle3);
  Taxe = (aX,aY,apX,apY);
  TcalculLuminance = (cSomme,cMaxi,cMinMax);
  TMesure = (mIntensite,mAngle,mDistance);
  TPropertyControl  = RECORD
                        GB : TGroupBox;
                        TB : TTrackBar;
                        positionInit : integer;
                        auto : boolean;
                      END;
  TOptiqueForm = class(TForm)
    StatusBar: TStatusBar;
    ToolBar: TToolBar;
    ConnectBtn: TToolButton;
    RegressiBtn: TToolButton;
    OpenFileBtn: TToolButton;
    AcquireBtn: TToolButton;
    PanelBoutons: TPanel;
    Panel2: TPanel;
    PanelImage: TPanel;
    IntensitePB: TPaintBox;
    LissageGB: TGroupBox;
    MoyenneSE: TSpinEdit;
    EchelleGB: TGroupBox;
    EchelleEdit: TLabeledEdit;
    UniteCB: TComboBox;
    LargeurGB: TGroupBox;
    LargeurSE: TSpinEdit;
    CouleursGB: TGroupBox;
    BlueBtn: TBitBtn;
    RedBtn: TBitBtn;
    GreenBtn: TBitBtn;
    gammaGB: TGroupBox;
    GammaBtn: TSpinButton;
    EditBidon: TEdit;
    BrightnessGB: TGroupBox;
    tbrBrightness: TTrackBar;
    btnBrightness: TButton;
    ContrastGB: TGroupBox;
    tbrContrast: TTrackBar;
    btnContrast: TButton;
    GainGB: TGroupBox;
    tbrGain: TTrackBar;
    btnGain: TButton;
    ConfigVideoBtn: TToolButton;
    VideoDevices: TComboBox;
    GammaEdit: TEdit;
    Image: TImage;
    OrigineEdit: TLabeledEdit;
    OrigineZeroBtn: TBitBtn;
    labelO: TLabel;
    labelA: TLabel;
    AngleLabel: TLabel;
    MesureRG: TRadioGroup;
    LabelX: TLabel;
    LabelDeltaX: TLabel;
    Label1: TLabel;
    Memo: TMemo;
    UniteLabel: TLabel;
    couleurGB: TGroupBox;
    CouleurCB: TColorBox;
    LumBtn: TBitBtn;
    ExitBtn: TToolButton;
    ValeurMesureGB: TGroupBox;
    AngleLabelbis: TLabel;
    SaturationGB: TGroupBox;
    tbrSaturation: TTrackBar;
    btnSaturation: TButton;
    GammaVideoGB: TGroupBox;
    tbrGamma: TTrackBar;
    btnGamma: TButton;
    SaveBtn: TToolButton;
    SaveDialog: TSaveDialog;
    OpenPictureDialog: TOpenPictureDialog;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    CameraBtn: TToolButton;
    ToolButton3: TToolButton;
    EchelleRG: TComboBox;
    Label2: TLabel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditBidonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenFileBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LargeurSEChange(Sender: TObject);
    procedure EchelleEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EchelleEditKeyPress(Sender: TObject; var Key: Char);
    procedure EchelleEditExit(Sender: TObject);
    procedure MoyenneSEChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniteCBChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure regleZoom(initRepere : boolean);
    procedure regleZoomVideo;
    procedure IntensitePBPaint(Sender: TObject);
    procedure EchelleRGClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImagePanelExit(Sender: TObject);
    procedure GammaBtnDownClick(Sender: TObject);
    procedure GammaBtnUpClick(Sender: TObject);
    procedure cboVideoSizesChange(Sender: TObject);
    procedure VideoDevicesChange(Sender: TObject);
    procedure OrigineZeroBtnClick(Sender: TObject);
    procedure MesureRGClick(Sender: TObject);
    procedure IntensitePBMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure IntensitePBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IntensitePBMouseEnter(Sender: TObject);
    procedure CouleurCBChange(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure RedBtnClick(Sender: TObject);
    procedure GreenBtnClick(Sender: TObject);
    procedure LumBtnClick(Sender: TObject);
    procedure BlueBtnClick(Sender: TObject);
    procedure OnNewVideoFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);
    procedure ConnectBtnClick(Sender: TObject);
    procedure AcquireBtnClick(Sender: TObject);
    procedure ConfigVideoBtnClick(Sender: TObject);
    procedure btnBrightnessClick(Sender: TObject);
    procedure tbrContrastChange(Sender: TObject);
    procedure btnContrastClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure CameraBtnClick(Sender: TObject);
  private
    Finitializing : boolean;
    VideoImage : TVideoImage;
    PropCtrl     : ARRAY[TVideoProperty] OF TPropertyControl;
    bitmapOriginal : Tbitmap;
    zoomAffichage,zoomVideo : double;
    PointRepere : array[TStyleDragOptique] of TPoint;
    BorneSelect,BorneSelectUp : TstyleDragOptique;
    axeI,axeE : Taxe;
    Pente,invCosa : double;
    LargeurI,HauteurI : integer; // sur l'image
    LigneCourante : integer;
    graphe : Tgraphe;
    largeurTrait : integer;
    couleurTrait : Tcolor;
    moyenneI : integer;
    Debut,Fin : integer;
    Intensite,Position,rouge,vert,bleu : TvecteurOptique;
    longueurRef,origineEchelle,Gamma : double;
    NomFichier : String;
    mesure : Tmesure;
    xRef,xCourant : integer;
    axeDesX : Tunite;
    mesureDelta : boolean;
    magnetInterf : integer;
    calculLuminance : TcalculLuminance;
    coeffUnite : double;
    redBtnDown,BlueBtnDown,GreenBtnDown,LumBtnDown : boolean;
    fActivated : boolean;
    function RGBToL(red,green,blue : byte) : double;
    Function GetBorne(x,y : integer) : TstyleDragOptique;
    Procedure TraceBorne;
    Procedure AffecteBorne(x,y : integer;horizVert : boolean);
    Procedure CalculIntensite;
    procedure setEchelle;
    procedure cherchePente;
    procedure MajBitmap;
    procedure TraceAngle;
    procedure TraceDistance;
    procedure TraceFleche(P1,P2 : Tpoint);
    procedure SetRGB;
    procedure chercheWebcam;
  public
    procedure OuvreFichier(nom : string);
  protected
  end;

var
  OptiqueForm: TOptiqueForm;

implementation

uses regMain, regDDE, compile, graphvar;

const
    Titre = 'Optique';
    FormCaption = 'Lecture d''intensité lumineuse ';
    TickEchelle = 4;
    rayonAngle = 50;
    longFleche = 16;
    hintDrag : array[TstyleDragOptique] of string =
      ('',
       'Déplacer la position de mesure',
       'Modifier la direction de mesure, Maj pour verticale ou horizontale',
       'Déplacer l''origine de l''échelle',
       'Déplacer l''extémité de l''échelle',
       'Déplacer la direction de référence de l''angle',
       'Déplacer la base de l''angle',
       'Déplacer la direction à repérer');
    hintX : array[boolean] of string =
          ('Cliquer pour mesurer une distance',
           'Cliquer pour indiquer uniquement le point courant');

{$R *.DFM}

 function TOptiqueForm.RGBToL(red,green,blue : byte) : double;
 var maxRGB,minRGB : Double;
 begin
    case calculLuminance of
         cSomme : result := (Red+green+blue)/(3*255);
         cMaxi : result := Max(Max(Red, Green), Blue) / 255;
         cMinMax : begin
             maxRGB := Max(Max(Red, Green), Blue) ;
             minRGB := Min(Min(Red, Green), Blue) ;
             result := (maxRGB+minRGB) / 255 /2;
         end;
         else result := (0.299*red+0.587*green+0.114*blue)/255;
    end;
 end;

procedure TOptiqueForm.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.execute then
     image.Picture.SaveToFile(SaveDialog.fileName);
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

procedure TOptiqueForm.FormCreate(Sender: TObject);

procedure SetProperty;
(*
  TVideoProperty = (VP_Brightness,
                    VP_Contrast,
                    VP_Hue,
                    VP_Saturation,
                    VP_Sharpness,
                    VP_Gamma,
                    VP_ColorEnable,
                    VP_WhiteBalance,
                    VP_BacklightCompensation,
                    VP_Gain);
 *)
begin
   with PropCtrl[VP_gain] do begin
      GB := gainGB;
      TB := tbrGain;
   end;
   with PropCtrl[VP_BacklightCompensation] do begin
      GB := nil;
      TB := nil;
   end;
   with PropCtrl[VP_whiteBalance] do begin
      GB := nil;
      TB := nil;
   end;
   with PropCtrl[VP_ColorEnable] do begin
      GB := nil;
      TB := nil;
   end;
   with PropCtrl[VP_gamma] do begin
      GB := gammaVideoGB;
      TB := tbrGamma;
   end;
   with PropCtrl[VP_sharpness] do begin
      GB := nil;
      TB := nil;
   end;
   with PropCtrl[VP_saturation] do begin
      GB := saturationGB;
      TB := tbrSaturation;
   end;
   with PropCtrl[VP_hue] do begin
      GB := nil;
      TB := nil;
   end;
   with PropCtrl[VP_Contrast] do begin
      GB := contrastGB;
      TB := tbrContrast;
   end;
   with PropCtrl[VP_Brightness] do begin
      GB := brightnessGB;
      TB := tbrBrightness;
   end;
end;

var Fichier : TIniFile;
    j : integer;
begin
    graphe := Tgraphe.create;
    with graphe do begin
        canvas := IntensitePB.canvas;
        MondeY.maxi := 1.05;
        MondeY.mini := -0.05;
        for j := -maxVecteurOptique to maxVecteurOptique do
            valeurX[j] := j;
    end;
    Finitializing := false;
    LigneCourante := 1;
    NomFichier := '';
    zoomAffichage := 1;
    zoomVideo := 1;
    axeDesX := Tunite.Create;
    axeDesX.nom := 'x';
    axeDesX.nomUnite := 'm';
    lumBtndown := true;
    Fichier := TIniFile.create(NomFichierIni);
    LargeurSE.value := Fichier.readInteger(Titre,'Largeur',LargeurSE.value);
    largeurTrait := LargeurSE.value;
    EchelleEdit.text := Fichier.readString(Titre,trEchelle,'10');
    CalculLuminance := TCalculLuminance(Fichier.readInteger(Titre,'Luminance',1));
    OrigineEdit.text := Fichier.readString(Titre,stOrigine,'0');
    Gamma := Fichier.readInteger(Titre,'Gamma',100)/100;
    GammaEdit.text := FloatToStr(gamma);
    uniteCB.itemIndex  := Fichier.readInteger(Titre,stUnite,2);
    coeffUnite := power(10,-3*uniteCB.ItemIndex);
    echelleRG.itemIndex := Fichier.readInteger(Titre,'TypeEchelle',0);
    setEchelle;
    MoyenneSE.value := Fichier.readInteger(Titre,'Moyenne',MoyenneSE.value);
    moyenneI := moyenneSE.value;
    OpenPictureDialog.filterIndex := Fichier.readInteger(Titre,'FilterOpen',0);
    couleurCB.selected := Fichier.readInteger(Titre,'CouleurAngle',0);
    couleurTrait := couleurCB.Selected;
    Fichier.free;
    setRGB;
    VideoImage := TVideoImage.Create;
// Tell fVideoImage what routine to call whan a new video-frame has arrived.
    VideoImage.OnNewVideoFrame := OnNewVideoFrame;
    bitmapOriginal := Tbitmap.create;
    setProperty;
    ResizeButtonImagesforHighDPI(self);
end;

procedure TOptiqueForm.OnNewVideoFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);
begin
  // Retreive latest video image
  VideoImage.GetBitmap(BitmapOriginal);
  largeurI := width;
  hauteurI := height;
  regleZoomVideo;
  Image.Picture.Assign(BitmapOriginal);
end;

procedure TOptiqueForm.RegressiBtnClick(Sender: TObject);
var i : integer;
    Ligne : String;
begin
     Screen.Cursor := crHourGlass;
     calculIntensite;
     FormDDE.donnees.Clear;
     FormDDE.donnees.add(Application.exeName);
     FormDDE.donnees.add('');
     Ligne := 'x';
     if blueBtndown then ligne := ligne+crTab+'B';
     if redBtndown then ligne := ligne+crTab+'R';
     if greenBtndown then ligne := ligne+crTab+'G';
     if lumBtndown then ligne := ligne+crTab+'L';
     FormDDE.donnees.add(Ligne);
     if echelleRG.itemIndex<2
        then Ligne := 'm'
        else Ligne := '';
     if blueBtndown then ligne := ligne+crTab+'';
     if redBtndown then ligne := ligne+crTab+'';
     if greenBtndown then ligne := ligne+crTab+'';
     if lumBtndown then ligne := ligne+crTab+'';
     FormDDE.donnees.add(Ligne);
     if echelleRG.itemIndex<2
        then Ligne := 'Distance'
        else Ligne := 'Numéro pixel';
     if blueBtndown then ligne := ligne+crTab+'Blue';
     if redBtndown then ligne := ligne+crTab+'Red';
     if greenBtndown then ligne := ligne+crTab+'Green';
     if lumBtndown then ligne := ligne+crTab+stIntensite;
     FormDDE.donnees.add(ligne);
     for i := Debut to Fin do begin
         Ligne := FloatToStrPoint(position[i]);
         if blueBtndown then ligne := ligne+crTab+FloatToStrPoint(bleu[i]);
         if redBtndown then ligne := ligne+crTab+FloatToStrPoint(rouge[i]);
         if greenBtndown then ligne := ligne+crTab+FloatToStrPoint(vert[i]);
         if lumBtndown then ligne := ligne+crTab+FloatToStrPoint(intensite[i]);
         FormDDE.donnees.add(Ligne);
     end;
     if NomFichier<>'' then begin
        FormDDE.donnees.add('&1 FICHIER');
        FormDDE.donnees.add(NomFichier);
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
     modeAcquisition := acqBitmap;
     Screen.Cursor := crDefault;
     Close;
end;

Function TOptiqueForm.GetBorne(x,y : integer) : TstyleDragOptique;
var i,iMax,iMin : TstyleDragOptique;
begin
      result := bsNone;
      x := round(x*zoomAffichage);
      y := round(y*zoomAffichage);
      case mesure of
           mAngle : begin
              imin := bsEchelle1;
              imax := bsAngle3;
           end;
           mDistance : begin
              imin := bsEchelle1;
              imax := bsAngle2;
           end;
           mIntensite : begin
              imin := bsOrigine;
              if echelleRG.itemIndex=0
                 then imax := bsEchelle2
                 else imax := bsDirection;
           end
           else begin
              imin := bsOrigine;
              imax := bsEchelle2;
           end;
      end;
      for i := iMin to imax do
          if abs(x-PointRepere[i].x)+
             abs(y-PointRepere[i].y) < MagnetInterf
               then begin
                  result := i;
                  statusBar.SimpleText := hintDrag[i];
                  break;
               end;
end;

procedure TOptiqueForm.GreenBtnClick(Sender: TObject);
begin
     greenBtndown := not greenBtndown;
     setRGB;
end;

Procedure TOptiqueForm.TraceBorne;

Procedure TraceCroix(bsi : TstyleDragOptique);
begin with PointRepere[bsi],image.canvas do begin
       moveto(x-MagnetInterf,y);
       if bsi=bsEchelle1
          then lineto(x,y)
          else lineto(x+MagnetInterf,y);
       moveto(x,y-MagnetInterf);
       lineto(x,y+MagnetInterf);
end end;

Procedure Marque(bsi : TstyleDragOptique);
var dX,dY : integer;
begin with PointRepere[bsi],image.canvas do begin
       case axeE of
            aX,apX: begin
               if y<hauteurI div 2
                  then dY := +magnetInterf
                  else dY := -magnetInterf-labelO.Height;
               dX := -labelO.Width div 2;
            end;
            aY,apY: begin
              if x<largeurI div 2
                then dX := magnetInterf
                else dX := -magnetInterf-labelO.Width;
              dY := -labelO.Height div 2;
            end
            else begin
                dX := 0;
                dY := 0;
            end
       end;
       case bsi of
            bsNone:;
            bsOrigine:;
            bsDirection:;
            bsEchelle1: begin
               labelO.left := round(x/zoomAffichage)+dx;
               labelO.top := round(y/zoomAffichage)+dy;
            end;
            bsEchelle2: begin
               labelA.left := round(x/zoomAffichage)+dx;
               labelA.top := round(y/zoomAffichage)+dy;
            end;
       end;
end end; // Marque

Procedure TraceEchelle;
var deltaX,deltaY : single;

Procedure TraceTick(i : integer);
var Kp : integer;
    Xa,Ya,Xb,Yb : integer;
    xx,yy : integer;
begin
      xx := round(PointRepere[bsEchelle1].x+deltaX*i);
      yy := round(PointRepere[bsEchelle1].y+deltaY*i);
      if abs(deltaX)>abs(deltaY)
         then begin
              Ya := yy+tickEchelle;
              Yb := yy-tickEchelle;
              Kp := round(-tickEchelle*deltaY/deltaX);
              Xa := xx+Kp;
              Xb := xx-Kp;
         end
         else begin
              Xa := xx+tickEchelle;
              Xb := xx-tickEchelle;
              Kp := round(-tickEchelle*deltaX/deltaY);
              Ya := yy+Kp;
              Yb := yy-Kp;
         end;
      with image.canvas do begin
         moveto(Xa,Ya);
         lineto(Xb,Yb);
     end;
end;// traceTick

var i : integer;
begin // traceEchelle
          TraceCroix(bsEchelle1);
          Marque(bsEchelle1);
          Marque(bsEchelle2);
          traceFleche(pointRepere[bsEchelle1],pointRepere[bsEchelle2]);
          deltaX := (PointRepere[bsEchelle2].x-PointRepere[bsEchelle1].x)/10;
          deltaY := (PointRepere[bsEchelle2].y-PointRepere[bsEchelle1].y)/10;
          with image.canvas do begin
              if zoomAffichage>1
                 then pen.width := round(zoomAffichage)
                 else pen.width := round(1/zoomAffichage);
              moveto(PointRepere[bsEchelle1].X,PointRepere[bsEchelle1].Y);
              lineto(PointRepere[bsEchelle2].X,PointRepere[bsEchelle2].Y);
          end;
          for i := 1 to 9 do TraceTick(i);
end; // traceEchelle

var p : single;
    xdroit,ydroit,xgauche,ygauche : integer;
    decaleX,decaleY : integer;
begin // traceBorne
if nomFichier<>'' then with image.canvas do begin
       pen.color := couleurTrait;
       pen.Mode := pmNot;
       pen.width := round(largeurTrait*zoomAffichage);
       brush.style := bsClear;
       labelA.Visible := echelleRG.itemIndex=0;
       labelO.Visible := echelleRG.itemIndex=0;
       angleLabel.Visible := mesure in [mAngle,mDistance];
       intensitePB.Visible := mesure=mIntensite;
       ValeurMesureGB.Visible := mesure in [mAngle,mDistance];
       couleursGB.Visible := mesure=mIntensite;
       gammaGB.Visible := mesure=mIntensite;
       lissageGB.Visible := mesure=mIntensite;
       if (mesure=mIntensite) then begin
          TraceCroix(bsOrigine);
          with PointRepere[bsDirection] do
               Ellipse(x-MagnetInterf,y-MagnetInterf,x+MagnetInterf,y+MagnetInterf);
       end;
       case axeI of
          aY : begin
               xdroit := PointRepere[bsOrigine].x;
               xgauche := xdroit;
               ydroit := 0;
               ygauche := hauteurI;
          end;
          aX : begin
               ydroit := PointRepere[bsOrigine].y;
               ygauche := ydroit;
               xdroit := 0;
               xgauche := largeurI;
          end;
          apX,apY : begin
               p := (PointRepere[bsOrigine].y-PointRepere[bsDirection].y)/
                    (PointRepere[bsOrigine].x-PointRepere[bsDirection].x);
               // intersection xmax
               xdroit := largeurI;
               ydroit := round(p*(xdroit-PointRepere[bsOrigine].x)+PointRepere[bsOrigine].y);
               if (pente>0) and (ydroit>hauteurI) then  begin
                   ydroit := hauteurI;
                   xdroit := round((ydroit-PointRepere[bsOrigine].y)/p+PointRepere[bsOrigine].x);
               end;
               if (pente<0) and (ydroit<0) then  begin
                   xdroit := round((0-PointRepere[bsOrigine].y)/p+PointRepere[bsOrigine].x);
                   ydroit := 0;
               end;
               // intersection xmin
               xgauche := 0;
               ygauche := round(p*(0-PointRepere[bsOrigine].x)+PointRepere[bsOrigine].y);
               if (pente<0) and (ygauche>hauteurI) then  begin
                  ygauche := hauteurI;
                  xgauche := round((ygauche-PointRepere[bsOrigine].y)/p+PointRepere[bsOrigine].x);
               end;
               if (pente>0) and (ygauche<0) then  begin
                  xgauche := round((0-PointRepere[bsOrigine].y)/p+PointRepere[bsOrigine].x);
                  ygauche := 0;
               end;
            end
            else begin
               ydroit := hauteurI;
               ygauche := 0;
               xdroit := 0;
               xgauche := largeurI;
            end;
       end;
       pen.width := round(largeurTrait*zoomAffichage);
       if mesure=mIntensite then begin
          moveto(xdroit,ydroit);
          lineto(xgauche,ygauche);
          if moyenneI>2 then begin
            case axeI of
               aX,apX: begin
                 decaleY := round(moyenneI*invCosA);
                 decaleX := 0;
               end;
               aY,apY: begin
                 decaleX := round(moyenneI*invCosa);
                 decaleY := 0;
               end;
               else begin
                 decaleX := 0;
                 decaleY := 0;
               end;
            end;
            moveto(xdroit+decaleX,ydroit+decaleY);
            lineto(xgauche+decaleX,ygauche+decaleY);
            moveto(xdroit-decaleX,ydroit-decaleY);
            lineto(xgauche-decaleX,ygauche-decaleY);
          end;
       end;
       case mesure of
            mAngle : traceAngle;
            mDistance : traceDistance;
       end;
       if echelleRG.itemIndex=0 then traceEchelle;
       pen.Mode := pmCopy;
       couleurGB.visible := mesure in [mAngle,mDistance];
end end;  // traceBorne

Procedure TOptiqueForm.CalculIntensite;
var dimPix : double;
    origineX,origineY : integer;

Procedure chercheEchelle;
var NbrePixelEchelle : double;
begin
   OrigineX := PointRepere[bsOrigine].x;
   OrigineY := PointRepere[bsOrigine].y;
   case echelleRG.itemIndex of
        1 : dimPix := LongueurRef;
        0 : begin
          NbrePixelEchelle := sqrt(
             sqr(PointRepere[bsEchelle1].x-PointRepere[bsEchelle2].x)+
             sqr(PointRepere[bsEchelle1].y-PointRepere[bsechelle2].y));
          dimPix := LongueurRef/NbrePixelEchelle;
          case axeI of
             aX : OrigineX := PointRepere[bsEchelle1].x;
             aY : OrigineY := PointRepere[bsEchelle1].y;
             else begin
                OrigineX := round((pente*(PointRepere[bsEchelle1].y-PointRepere[bsOrigine].y)+
                             sqr(pente)*PointRepere[bsOrigine].x+
                             PointRepere[bsEchelle1].x)/(1+sqr(pente)));
                OrigineY := round((pente*(PointRepere[bsEchelle1].x-PointRepere[bsOrigine].x)+
                             sqr(pente)*PointRepere[bsEchelle1].y+
                             PointRepere[bsOrigine].y)/(1+sqr(pente)));
             end;
          end;
        end;
        else dimPix := 1;
   end;
   case axeI of
      aX,apX : begin
           debut := -OrigineX;
           fin := largeurI-OrigineX;
           dimPix := dimPix*invCosA;
      end;
      aY,apY : begin
           debut := -OrigineY;
           fin := hauteurI-OrigineY;
           dimPix := dimPix*invCosA;
      end;
   end;
   debut := debut+moyenneI;
   fin := fin-moyenneI;
   if debut<-maxVecteurOptique then debut := -maxVecteurOptique;
   if fin>maxVecteurOptique then fin := maxVecteurOptique;
   graphe.dimPix := dimPix;
   graphe.decalage := origineEchelle;
end; // chercheEchelle

Procedure cherche(decale : integer); // sur l'image grâce au stretch
var i,xi,yi : integer;
    valeur : Tcolor;
    rr,gg,bb : integer;
    x0,y0 : integer;
begin
     case axeI of
       aX,apX : begin
            x0 := origineX;
            y0 := origineY+decale;
       end;
       aY,apY : begin
            x0 := origineX+decale;
            y0 := origineY;
       end
       else begin // pour le compilateur
            x0 := origineX;
            y0 := origineY;
       end;
     end;
     yi := y0;
     xi := x0;
     for i := debut to fin do begin
         case axeI of
            aX,apX : begin
                 xi := x0+i;
                 yi := y0+round(i*pente);
            end;
            aY,apY : begin
                 yi := y0+i;
                 if pente<>0 then xi := x0+ round(i/pente);
            end;
         end;
            if (xi>=0) and (xi<largeurI) and
               (yi>=0) and (yi<hauteurI) then begin
               try
               valeur := image.canvas.pixels[xi,yi];
               if valeur<0 then valeur :=0;
               rr := GetRvalue(valeur);
               gg := GetGvalue(valeur);
               bb := GetBvalue(valeur);
               rouge[i] := rouge[i]+rr;
               bleu[i] := bleu[i]+bb;
               vert[i] := vert[i]+gg;
               intensite[i] := intensite[i]+RGBtoL(rr,gg,bb);
               except
               intensite[i] := 0;
               vert[i] := 0;
               rouge[i] := 0;
               bleu[i] := 0;
// pixels non reconnus si non visibles ?
               end;
            end
            else begin
               intensite[i] := 0;
               rouge[i] := 0;
               bleu[i] := 0;
               vert[i] := 0;
            end;
            if decale=0 then Position[i] := dimPix*i+origineEchelle;
       end;{ for i }
end; // cherche

procedure getEchelle;
begin
     try
       gamma := StrToFloat(GammaEdit.text);
     except
       gamma := 1;
     end;
     case echelleRG.itemIndex of
          0 : begin // echelle
     try
         OrigineEchelle := StrToFloat(OrigineEdit.text)*coeffUnite;
     except
         showMessage(erEchelle);
         origineEchelle := 0;
         OrigineEdit.text := '0';
     end;
          end;
       1 : origineEchelle := 0; // pixel
       else begin // index
            origineEchelle := 0;
            longueurRef := 1;
            coeffUnite := 1;
            exit;
       end;
     end;
     try
     longueurRef := StrToFloat(EchelleEdit.text)*coeffUnite;
     if echelleRG.itemIndex=0 then LongueurRef := longueurRef-origineEchelle;
     except
         showMessage(erEchelle);
         EchelleEdit.Text := '10';
         longueurRef := coeffUnite;
     end;
     setEchelle;
end; // getEchelle

var i,Nbre : integer;
begin // CalculIntensite
     if nomFichier='' then exit;
     Screen.cursor := crHourGlass;
     traceBorne; // efface
     getEchelle;
     for i := -maxVecteurOptique to maxVecteurOptique do begin
         Intensite[i] := 0;
         vert[i] := 0;
         bleu[i] := 0;
         rouge[i] := 0;
     end;
     cherchePente;
     chercheEchelle;
     cherche(0);
     for i := 1 to moyenneI do begin
        cherche(i);
        cherche(-i);
     end;
     Nbre := 1+2*moyenneI;
     while (debut<0) and (intensite[debut]=0) do inc(debut);
     while (fin>0) and (intensite[fin]=0) do dec(fin);
     for i := Debut to Fin do begin
         Intensite[i] := power(Intensite[i]/nbre,gamma);
         rouge[i] := rouge[i]/255/Nbre;
         vert[i] := vert[i]/255/Nbre;
         bleu[i] := bleu[i]/255/Nbre;
     end;
     traceBorne; // retrace les bornes
     intensitePB.refresh;
     Screen.cursor := crDefault;
end; // CalculIntensite

procedure TOptiqueForm.CameraBtnClick(Sender: TObject);
begin
  ChercheWebcam;
end;

procedure TOptiqueForm.VideoDevicesChange(Sender: TObject);
begin
   connectBtnClick(sender);
end;

procedure TOptiqueForm.cboVideoSizesChange(Sender: TObject);
var connected : boolean;
begin
   try
   connected := connectBtn.down;
   if connected then connectBtn.Down := false;
   if connected then connectBtn.Down := true;
   except
   end;
end;

procedure TOptiqueForm.AcquireBtnClick(Sender: TObject);
begin
  VideoImage.VideoStop;
  ConnectBtn.Enabled := true;
  AcquireBtn.Enabled  := false;
  configVideoBtn.Enabled := false;
  GainGB.Visible := false;
  BrightnessGB.Visible := false;
  ContrastGB.Visible := false;
  GammaVideoGB.Visible := false;
  SaturationGB.Visible := false;
  lissageGB.Visible := true;
  echelleGB.Visible := true;
  axeI := aX;
  axeE := aX;
  nomFichier := TPath.combine(tempDirReg,'interf.bmp');
  image.Picture.SaveToFile(nomFichier);
  largeurI := image.picture.width;
  hauteurI := image.picture.height;
  saveBtn.Enabled := true;
  majBitmap;
end;

Procedure TOptiqueForm.AffecteBorne(x,y : integer;horizVert : boolean);
var deltaX,deltaY : integer;
    p : double;
begin
    case BorneSelect of
        bsOrigine,bsDirection : if
           (x<magnet) or
           (y<magnet) or
           (x>(image.width-magnet)) or
           (y>(image.height-magnet)) then exit;
        bsEchelle1,bsEchelle2 : if
          (x<0) or
          (y<0) or
          (x>image.width-1) or
          (y>image.height-1) then exit;
       bsNone : exit;
    end;
    x := round(x*zoomAffichage);
    y := round(y*zoomAffichage);
    traceBorne; // efface
    cherchePente;
    case BorneSelect of
        bsOrigine : begin
             deltaX := x-PointRepere[bsOrigine].x;
             PointRepere[bsOrigine].x := x;
             deltaY := y-PointRepere[bsOrigine].y;
             PointRepere[bsOrigine].y := y;
             PointRepere[bsDirection].x := PointRepere[bsDirection].x+deltaX;
             if PointRepere[bsDirection].x>largeurI then
                  PointRepere[bsDirection].x := (largeurI-magnetInterf);
             if PointRepere[bsDirection].x<magnetInterf then
                  PointRepere[bsDirection].x := magnetInterf;
             if PointRepere[bsDirection].x<magnetInterf then
                PointRepere[bsDirection].x := magnet;
             PointRepere[bsDirection].y := PointRepere[bsDirection].y+deltaY;
             if PointRepere[bsDirection].y>(hauteurI-magnetInterf) then
                  PointRepere[bsDirection].y := (hauteurI-magnetInterf);
             if PointRepere[bsDirection].y<magnetInterf then
                  PointRepere[bsDirection].y := magnetInterf;
             if PointRepere[bsDirection].y<magnetInterf then
                  PointRepere[bsDirection].y := magnetInterf;
             if horizVert and
               (PointRepere[bsOrigine].x<>PointRepere[bsDirection].x) then begin
                p := abs((PointRepere[bsOrigine].y-PointRepere[bsDirection].y)/
                     (PointRepere[bsOrigine].x-PointRepere[bsDirection].x));
                if p>1
                   then PointRepere[bsDirection].x := PointRepere[bsOrigine].x
                   else PointRepere[bsDirection].y := PointRepere[bsOrigine].y;
             end;
        end;
        bsDirection : begin
           if (abs(x-PointRepere[bsOrigine].x)+
               abs(y-PointRepere[bsOrigine].y))>magnet
              then begin
                 PointRepere[bsDirection].x := x;
                 PointRepere[bsDirection].y := y;
              end;
           if horizVert and
              (PointRepere[bsOrigine].x<>PointRepere[bsDirection].x) then begin
                p := abs((PointRepere[bsOrigine].y-PointRepere[bsDirection].y)/
                     (PointRepere[bsOrigine].x-PointRepere[bsDirection].x));
                if p>1
                   then PointRepere[bsOrigine].x := PointRepere[bsDirection].x
                   else PointRepere[bsOrigine].y := PointRepere[bsDirection].y;
           end;
        end;
        bsEchelle1 : begin
           if (abs(x-PointRepere[bsEchelle2].x)+
               abs(y-PointRepere[bsEchelle2].y))>magnet
              then begin
                   PointRepere[bsEchelle1].x := X;
                   PointRepere[bsEchelle1].y := Y;
              end;
           if horizVert and
              (PointRepere[bsEchelle1].x<>PointRepere[bsEchelle2].x) then begin
                p := abs((PointRepere[bsEchelle1].y-PointRepere[bsEchelle2].y)/
                     (PointRepere[bsEchelle1].x-PointRepere[bsEchelle2].x));
                if p>1
                  then PointRepere[bsEchelle2].x := PointRepere[bsEchelle1].x
                  else PointRepere[bsEchelle2].y := PointRepere[bsEchelle1].y;
           end;
        end;
        bsEchelle2 : begin
            if (abs(x-PointRepere[bsEchelle1].x)+
                abs(y-PointRepere[bsEchelle1].y))>magnetInterf
              then begin
                 PointRepere[bsEchelle2].x := X;
                 PointRepere[bsEchelle2].y := Y;
              end;
           if horizVert and
              (PointRepere[bsEchelle1].x<>PointRepere[bsEchelle2].x) then begin
                p := abs((PointRepere[bsEchelle1].y-PointRepere[bsEchelle2].y)/
                     (PointRepere[bsEchelle1].x-PointRepere[bsEchelle2].x));
                if p>1
                  then PointRepere[bsEchelle1].x := PointRepere[bsEchelle2].x
                  else PointRepere[bsEchelle1].y := PointRepere[bsEchelle2].y;
           end;
        end;
        bsAngle1 : if (abs(x-PointRepere[bsAngle2].x)+
                abs(y-PointRepere[bsAngle2].y))>magnetInterf
              then begin
                 PointRepere[bsAngle1].x := X;
                 PointRepere[bsAngle1].y := Y;
        end;
        bsAngle3 : if (abs(x-PointRepere[bsAngle2].x)+
                abs(y-PointRepere[bsAngle2].y))>magnetInterf
              then begin
                 PointRepere[bsAngle3].x := X;
                 PointRepere[bsAngle3].y := Y;
        end;
        bsAngle2 : if ((abs(x-PointRepere[bsAngle1].x)+
                        abs(y-PointRepere[bsAngle1].y))>magnetInterf) and
                      ((abs(x-PointRepere[bsAngle3].x)+
                        abs(y-PointRepere[bsAngle3].y))>magnetInterf)
              then begin
                 PointRepere[bsAngle2].x := X;
                 PointRepere[bsAngle2].y := Y;
        end;
    end;
    traceBorne; // retrace
    if BorneSelect in [bsOrigine,bsEchelle1,bsEchelle2]
       then Image.cursor := crCibleMove
       else Image.cursor := crHandPoint;
end; // AffecteBorne


procedure TOptiqueForm.BlueBtnClick(Sender: TObject);
begin
     blueBtndown := not blueBtndown;
     setRGB;
end;

procedure TOptiqueForm.btnBrightnessClick(Sender: TObject);
begin
    VideoImage.SetVideoPropertySettings(VP_Brightness, tbrBrightness.position, true);
end;

procedure TOptiqueForm.btnContrastClick(Sender: TObject);
var VP : TvideoProperty;
begin
  VP := TvideoProperty((sender as TControl).tag);
  with PropCtrl[VP] do
       VideoImage.SetVideoPropertySettings(VP, PositionInit, true);
end;

procedure TOptiqueForm.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if nomFichier='' then exit;
   BorneSelect := GetBorne(x,y);
   if borneSelect=bsNone
      then borneSelectUp := bsNone
      else EditBidon.setFocus;
end;

procedure TOptiqueForm.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var BS : tstyleDragOptique;
begin
   if nomFichier='' then exit;
   if (ssLeft in Shift) or (ssRight in Shift)
      then AffecteBorne(x,y,ssShift in shift)  // ssShift touche majuscule
      else begin
          BS := GetBorne(x,y);
          case BS of
             bsDirection : Image.cursor := crHandPoint;
             bsNone : Image.cursor := crDefault;
             else Image.cursor := crCibleMove;
          end;
          case BS of
                bsOrigine : hint := hOrigineMove;
                bsDirection : hint := hDirection;
                bsEchelle1,bsEchelle2 : hint:= hEchelle;
                else hint := '';
          end;
          Image.hint := hint;
      end;
   if borneSelect<>bsNone then EditBidon.setFocus;
end;

procedure TOptiqueForm.ImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     if nomFichier='' then exit;
     AffecteBorne(x,y,ssShift in shift);
     CalculIntensite;
     hint := '';
     Image.hint := '';
     BorneSelectUp := BorneSelect;
     BorneSelect := bsNone;
end;

procedure TOptiqueForm.EditBidonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
    changement : boolean;
begin
     if (ssRight in Shift) or (ssLeft in Shift) then begin
        try
        P := Mouse.CursorPos;
        except
          exit;
        end;
        changement := true;
        case key of
           vk_left,vk_numpad4 : dec(P.X);
           vk_right,vk_numpad6 : inc(P.X);
           vk_down,vk_numpad2 : inc(P.Y);
           vk_up,vk_numpad8 : dec(P.Y);
           else changement := false;
        end;
        if changement then Mouse.CursorPos := P;
        key := 0;
     end;
end;

procedure TOptiqueForm.MajBitmap;
var i : integer;
begin
     regleZoom(true);
     debut := 0;
     fin := 0;
     for i := -maxVecteurOptique to maxVecteurOptique do begin
         Intensite[i] := 0;
         vert[i] := 0;
         bleu[i] := 0;
         rouge[i] := 0;
         Position[i] := i;
     end;
     RegressiBtn.enabled := nomFichier<>'';
     CouleursGB.Enabled := RegressiBtn.enabled;
     GammaGB.Enabled := RegressiBtn.enabled;
     if NomFichier<>'' then begin
        Image.refresh;
        Caption := FormCaption+'['+ExtractFileName(NomFichier)+']';
        cherchePente;
        traceBorne;
        calculIntensite;
     end
     else Caption := FormCaption;
     EditBidon.setFocus;
end; // MajBitmap

procedure TOptiqueForm.MesureRGClick(Sender: TObject);
begin
   traceBorne; // efface
   mesure := Tmesure(MesureRG.itemIndex);
   traceBorne; // retrace
end;

procedure TOptiqueForm.OpenFileBtnClick(Sender: TObject);
begin
    if OpenPictureDialog.InitialDir='' then
       OpenPictureDialog.InitialDir := ImagesDir;
    if OpenPictureDialog.execute then begin
       ouvreFichier(OpenPictureDialog.fileName);
       OpenPictureDialog.InitialDir := extractFilePath(openPictureDialog.fileName);
    end;
end;

procedure TOptiqueForm.OrigineZeroBtnClick(Sender: TObject);
begin
  inherited;
  OrigineEdit.Text := '0';
  calculIntensite;
end;

procedure TOptiqueForm.OuvreFichier(nom : string);
var extension : String;
    Ajpeg : TjpegImage;
    Apng : TpngImage;
begin
       axeI := aX;
       axeE := aX;
       Screen.Cursor := crHourGlass;
       extension := AnsiUpperCase(extractFileExt(Nom));
       if (extension='.GIF') then begin
          ConvertitGifBmp(nom);
          extension := '.BMP';
       end;
       if (extension='.FIT') or (extension='.FITS') then begin
          //ConvertitFITSBmp(nom);
          extension := '.BMP';
       end;
       if (extension='.JPG') or (extension='.JPEG') then begin
           Ajpeg := TjpegImage.create;
           Ajpeg.LoadFromFile(Nom);
           with bitmapOriginal do begin
                pixelFormat := pf24bit;
                height := Ajpeg.Height;
                width := Ajpeg.Width;
                assign(Ajpeg);
                nom := changeFileExt(nom,'.BMP');
                saveToFile(nom);
           end;
           Ajpeg.free;
           extension := '.BMP';
       end;
       if (extension='.PNG') then begin
           Apng := TpngImage.create;
           Apng.LoadFromFile(Nom);
           with bitmapOriginal do begin
                pixelFormat := pf24bit;
                height := Apng.Height;
                width := Apng.Width;
                assign(Apng);
                nom := changeFileExt(nom,'.BMP');
                saveToFile(nom);
           end;
           Apng.free;
           extension := '.BMP';
       end;
       if (extension='.BMP') then begin
           image.Picture.LoadFromFile(Nom);
           largeurI := image.picture.width;
           hauteurI := image.picture.height;
       end;
       nomFichier := nom;
       saveBtn.Enabled := false;
       MajBitMap;
end; // OuvreFichier

procedure TOptiqueForm.FormDestroy(Sender: TObject);
begin
    bitmapOriginal.free;
    optiqueForm := nil
end;

procedure TOptiqueForm.LargeurSEChange(Sender: TObject);
begin
     traceBorne; // efface
     cherchePente;
     largeurTrait := largeurSE.value;
     traceBorne; // retrace
end;

procedure TOptiqueForm.LumBtnClick(Sender: TObject);
begin
     lumBtndown := not lumBtndown;
     setRGB;
end;

procedure TOptiqueForm.EchelleEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key=ord(crCR) then calculIntensite
end;

procedure TOptiqueForm.EchelleEditKeyPress(Sender: TObject; var Key: Char);
begin
    verifKeyGetFloat(key)
end;

procedure TOptiqueForm.EchelleEditExit(Sender: TObject);
begin
   calculIntensite
end;

procedure TOptiqueForm.MoyenneSEChange(Sender: TObject);
begin
   calculIntensite
end;

procedure TOptiqueForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var Fichier : TIniFile;
begin
     try
     Fichier := TIniFile.create(NomFichierIni);
     try
     Fichier.writeInteger(Titre,'Largeur',LargeurSE.value);
     Fichier.writeInteger(Titre,'FilterOpen',OpenPictureDialog.filterIndex);
     Fichier.writeString(Titre,trEchelle,EchelleEdit.text);
     Fichier.writeString(Titre,stOrigine,OrigineEdit.text);
     Fichier.writeInteger(Titre,'Unite',uniteCB.itemIndex);
     Fichier.writeInteger(Titre,'Gamma',round(Gamma*100));
     Fichier.writeInteger(Titre,'TypeEchelle',echelleRG.itemIndex);
     Fichier.writeInteger(Titre,'CouleurAngle',couleurCB.selected);
     Fichier.writeInteger(Titre,'Moyenne',MoyenneSE.value);
     if openPictureDialog.InitialDir<>'' then
        imagesDir := openPictureDialog.InitialDir;
     finally
     Fichier.free;
     end;
     except
     end;
     inherited;
end;

procedure TOptiqueForm.setEchelle;
begin
    case echelleRG.itemIndex of
       0 : begin
       echelleGB.Caption := 'Echelle OA';
       coeffUnite := power(10,-3*uniteCB.ItemIndex);
       if origineEchelle=0
           then begin
              echelleEdit.editLabel.caption := trLongEchelle;
              origineEdit.editLabel.caption := trOrigineEchelle;
           end
           else begin
              echelleEdit.editLabel.caption := 'Coordonnée de A';
              origineEdit.editLabel.caption := 'Coordonnée de O';
           end;
       end;
       1 : begin // pixel
           echelleGB.Caption := trEchelle;
           EchelleEdit.EditLabel.caption := trDimPixel;
           coeffUnite := power(10,-3*uniteCB.ItemIndex);
       end;
       2 : coeffUnite := 1; // index
    end;
    EchelleEdit.visible := echelleRG.itemIndex<2; // dimension pixel, échelle
    UniteLabel.Visible := echelleRG.itemIndex<2;
    OrigineEdit.Visible := echelleRG.itemIndex=0;
    OrigineZeroBtn.Visible := echelleRG.itemIndex=0;
    UniteCB.visible := echelleRG.itemIndex<2;
    EchelleEdit.hint := EchelleEdit.EditLabel.caption+' '+hAideValide;
    if echelleRG.ItemIndex<2
       then axedesX.nomUnite := uniteCB.Text
       else axedesX.nomUnite := '';
    if nomFichier<>'' then image.Picture.LoadFromFile(NomFichier);
end;

procedure TOptiqueForm.UniteCBChange(Sender: TObject);
begin
     if echelleRG.itemIndex<2
        then coeffUnite := power(10,-3*uniteCB.ItemIndex)
        else coeffUnite := 1;
     CalculIntensite;
     if echelleRG.itemIndex<2
        then axeDesX.nomUnite := uniteCB.Text
        else axeDesX.nomUnite := ''
end;

procedure TOptiqueForm.FormActivate(Sender: TObject);
begin
  inherited;
  xRef := IntensitePB.width div 2;
  xCourant := xRef;
  IF not fActivated then chercheWebcam;
  fActivated := true;
end;

procedure TOptiqueForm.ChercheWebcam;
var DeviceList : TStringList;
begin
  // Get list of available cameras
  DeviceList := TStringList.Create;
  VideoImage.GetListOfDevices(DeviceList);
  ConfigVideoBtn.Enabled := false;
  AcquireBtn.Enabled := false;

  IF DeviceList.Count < 1 then begin
      // no camera has been found
      ConnectBtn.Enabled := false;
      VideoDevices.Visible := false;
    end
    else begin
      // at least one camera has been found.
      VideoDevices.items.Assign(DeviceList);
      VideoDevices.ItemIndex := 0;
      VideoDevices.Visible := true;
      ConnectBtn.Enabled := true;
    end;
end;

procedure TOptiqueForm.RegleZoom(initRepere : boolean);
var zoomX,zoomY : integer;
begin
     intensitePB.height := clientHeight div 4;
     ZoomY := hauteurI div panelImage.Height;
     ZoomX := largeurI div panelImage.Width;
     if (zoomX=0) and (zoomY=0)
        then begin
           ZoomY := panelImage.Height div hauteurI;
           ZoomX := panelImage.Width div largeurI;
           if zoomY>zoomX
              then zoomAffichage := zoomX
              else zoomAffichage := zoomY;
           if zoomAffichage<1 then zoomAffichage := 1;
           if zoomAffichage>5 then zoomAffichage := 5;
           zoomAffichage := 1/zoomAffichage;
        end
        else begin
           if zoomY>zoomX
              then zoomAffichage := zoomY
              else zoomAffichage := zoomX;
           if zoomAffichage<1 then zoomAffichage := 1;
           if zoomAffichage>5 then zoomAffichage := 5;
           zoomAffichage := zoomAffichage+1;
        end;
     magnetInterf := round(magnet*zoomAffichage);
     image.Width := round(largeurI/zoomAffichage);
     image.Height := round(hauteurI/zoomAffichage);
     if initRepere then begin
        PointRepere[bsOrigine] := point(largeurI div 2,hauteurI div 2);
        PointRepere[bsDirection] := point(4*largeurI div 5,hauteurI div 2);
        axeI := aX;
        PointRepere[bsEchelle1] := point(largeurI div 5,3*hauteurI div 4);
        PointRepere[bsEchelle2] := point(4*largeurI div 5,3*hauteurI div 4);
        axeE := aX;
        PointRepere[bsAngle1] := point(largeurI div 4,2*hauteurI div 3);
        PointRepere[bsAngle2] := point(largeurI div 8,hauteurI div 3);
        PointRepere[bsAngle3] := point(largeurI div 4,hauteurI div 3);
     end;
     BorneSelect := bsNone;
     BorneSelectUp := bsNone;
end;

procedure TOptiqueForm.RegleZoomVideo;
var zoomX,zoomY : integer;
begin
     intensitePB.height := clientHeight div 4;
     ZoomY := hauteurI div panelImage.Height;
     ZoomX := largeurI div panelImage.Width;
     if (zoomX=0) and (zoomY=0)
        then begin
           ZoomY := panelImage.Height div hauteurI;
           ZoomX := panelImage.Width div largeurI;
           if zoomY>zoomX
              then zoomVideo := zoomX
              else zoomVideo := zoomY;
           if zoomVideo<1 then zoomVideo := 1;
           if zoomVideo>5 then zoomVideo := 5;
           zoomVideo := 1/zoomVideo;
        end
        else begin
           if zoomY>zoomX
              then zoomVideo := zoomY
              else zoomVideo := zoomX;
           if zoomVideo<1 then zoomVideo := 1;
           if zoomVideo>5 then zoomVideo := 5;
           zoomVideo := zoomVideo+1;
        end;
     image.Width := round(largeurI/zoomVideo);
     image.Height := round(hauteurI/zoomVideo);
end;

procedure TOptiqueForm.IntensitePBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     mesureDelta := not mesureDelta;
     labelDeltaX.Visible := mesureDelta;
     xRef := x;
     statusBar.SimpleText := hintX[mesureDelta];
     intensitePB.Invalidate
end;

procedure TOptiqueForm.IntensitePBMouseEnter(Sender: TObject);
begin
     statusBar.SimpleText := hintX[mesureDelta];
end;

procedure TOptiqueForm.IntensitePBMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

procedure AffichePosition;
var Xr : double;
begin
    xr := graphe.getXMonde(x)/coeffUnite;
    labelx.Visible := true;
    labelX.transparent := false;
    labelX.caption := ' '+axeDesX.formatNomEtUnite(Xr)+' ';
    labelX.top := intensitePB.top+16;
    labelX.left := x-(labelX.width div 2);
end; // AffichePosition

procedure AfficheDelta;
var xr1,xr2 : double;
begin
    xr1 := graphe.getXMonde(xRef)/coeffUnite;
    xr2 := graphe.getXMonde(xCourant)/coeffUnite;
    labelDeltaX.transparent := false;
    labelDeltaX.caption := ' '+deltaMaj+axeDesX.formatNomEtUnite(xr2-xr1)+' ';
    labelDeltaX.top := intensitePB.top+(intensitePB.height div 2)+16;
    labelDeltaX.left := (xRef+xCourant-labelX.width) div 2;
    graphe.traceEcart(xRef,xCourant);
end; // AfficheDelta

begin // PaintBoxMouseMove
        graphe.TraceReticule(xCourant); // efface
        if mesureDelta then graphe.traceEcart(xRef,xCourant); // efface
        xCourant := x;
        graphe.TraceReticule(xCourant); // retrace
        AffichePosition;
        if mesureDelta then afficheDelta;
end;

procedure TOptiqueForm.IntensitePBPaint(Sender: TObject);
begin with graphe do begin
        if (debut=fin) then exit;
        LimiteCourbe := rect(image.left,0,
                             image.left+image.width,IntensitePB.height);
        debutG := debut;
        finG := fin;
        valeurY := intensite;
        rougeY := rouge;
        vertY := vert;
        bleuY := bleu;
        MondeX.maxi := fin;
        MondeX.mini := debut;
        drawG;
        graphe.TraceReticule(xCourant);
        if mesureDelta then traceEcart(xRef,xCourant);
end end;

procedure TOptiqueForm.EchelleRGClick(Sender: TObject);
begin
   setEchelle;
   cherchePente;
   traceBorne;
   calculIntensite;
end;

procedure TOptiqueForm.setRGB;
begin
    graphe.wR := RedBtnDown;
    if RedBtnDown
       then RedBtn.Font.Color := clRed
       else RedBtn.Font.Color := clMedGray;
    graphe.wG := GreenBtnDown;
    if GreenBtnDown
       then GreenBtn.Font.Color := clGreen
       else GreenBtn.Font.Color := clMedGray;
    graphe.wB := BlueBtnDown;
    if BlueBtnDown
       then BlueBtn.Font.Color := clBlue
       else BlueBtn.Font.Color := clMedGray;
    graphe.wL := LumBtnDown;
    if LumBtnDown
       then LumBtn.Font.Color := clBlack
       else LumBtn.Font.Color := clMedGray;
    CalculIntensite;
end;

procedure TOptiqueForm.tbrContrastChange(Sender: TObject);
var VP : TvideoProperty;
begin
  if Finitializing  then exit;
  VP := TvideoProperty((sender as TControl).tag);
  with PropCtrl[VP] do
       VideoImage.SetVideoPropertySettings(VP, TB.Position, auto);
end;

procedure TOptiqueForm.FormResize(Sender: TObject);
begin
  inherited;
  if NomFichier<>'' then regleZoom(false);
end;

procedure TOptiqueForm.ConfigVideoBtnClick(Sender: TObject);
begin
   VideoImage.ShowProperty_Stream;
end;

procedure TOptiqueForm.ConnectBtnClick(Sender: TObject);
var VP : TvideoProperty;
    minVal,maxVal,stepSize,actual,valDefault : integer;
    autoMode : boolean;
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  ConnectBtn.enabled := false;
  acquireBtn.Enabled := true;
  configVideoBtn.Enabled := true;

  VideoImage.VideoStart(VideoDevices.Items[VideoDevices.itemIndex]);

  ConfigVideoBtn.Enabled := true;
  Finitializing := true;
  FOR VP := Low(TVideoProperty) TO High(TVideoProperty) DO if propCtrl[VP].GB<>nil then begin
      IF Succeeded(VideoImage.GetVideoPropertySettings(VP,
         MinVal, MaxVal, StepSize, ValDefault, Actual, AutoMode)) then begin
          WITH PropCtrl[VP] DO BEGIN
              GB.visible  := true;
              TB.Min      := MinVal;
              TB.Max      := MaxVal;
              TB.Frequency:= StepSize;
              TB.Position := Actual;
              positionInit := actual;
              auto := automode;
            end;
        end
        else PropCtrl[VP].GB.visible := false;
    END;
  Finitializing := false;
  lissageGB.Visible := false;
  echelleGB.Visible := false;
  Screen.Cursor := crDefault;
end;

procedure TOptiqueForm.CouleurCBChange(Sender: TObject);
begin
    couleurTrait := couleurCB.Selected;
    if NomFichier<>'' then begin
        Image.refresh;
        traceBorne;
    end
end;

procedure TOptiqueForm.ImagePanelExit(Sender: TObject);
begin
     CalculIntensite;
end;

procedure TOptiqueForm.GammaBtnDownClick(Sender: TObject);
begin
  inherited;
  gamma := gamma-0.1;
  if gamma<1 then gamma := 1;
  gammaEdit.text := FloatToStr(gamma);
  calculIntensite;
end;

procedure TOptiqueForm.GammaBtnUpClick(Sender: TObject);
begin
  inherited;
  gamma := gamma+0.1;
  if gamma>3 then gamma := 3;
  gammaEdit.text := FloatToStr(gamma);
  calculIntensite;
end;

procedure TOptiqueForm.RedBtnClick(Sender: TObject);
begin
     redBtndown := not redBtndown;
     setRGB;
end;

procedure ToptiqueForm.cherchePente;
var penteE : double;
begin
 if (PointRepere[bsOrigine].x=PointRepere[bsDirection].x)
        then begin
           axeI := aY;
           pente := 0;
           invCosA := 1;
        end
        else if (PointRepere[bsOrigine].y=PointRepere[bsDirection].y)
           then begin
              axeI := aX;
              pente := 0;
              invCosA := 1;
           end
           else begin
              pente := (PointRepere[bsOrigine].y-PointRepere[bsdirection].y)/
                       (PointRepere[bsOrigine].x-PointRepere[bsdirection].x);
              if abs(pente)<=1
                 then begin
                    axeI := apX;
                    invcosa := sqrt(1+sqr(pente));
                 end
                 else begin
                    axeI := apY;
                    invcosa := sqrt(1+sqr(1/pente));
                 end;
          end;
  if (PointRepere[bsEchelle1].x=PointRepere[bsEchelle2].x)
        then axeE := aY
        else if (PointRepere[bsEchelle1].y=PointRepere[bsEchelle2].y)
           then axeE := aX
           else begin
              penteE := (PointRepere[bsOrigine].y-PointRepere[bsdirection].y)/
                       (PointRepere[bsOrigine].x-PointRepere[bsdirection].x);
              if abs(penteE)<=1
                 then axeE := apX
                 else axeE := apY;
          end;
  moyenneI := moyenneSE.value;
end;

procedure TOptiqueForm.ExitBtnClick(Sender: TObject);
begin
    close
end;

procedure ToptiqueForm.TraceAngle;
  var angleRef,angleFin : TStyleDragOptique;

   function valeurAngle : string;
   var CA,CB : Tpoint;
       PS,PV : integer;
       valeur : double;
   begin
      CA.x := pointRepere[bsAngle1].x-pointRepere[bsAngle2].x;
      CA.y := pointRepere[bsAngle1].y-pointRepere[bsAngle2].y;
      CB.x := pointRepere[bsAngle3].x-pointRepere[bsAngle2].x;
      CB.y := pointRepere[bsAngle3].y-pointRepere[bsAngle2].y;
      PS := CA.X*CB.X+CA.Y*CB.Y;
      PV := -CA.X*CB.Y+CA.Y*CB.X;
      valeur := radToDeg(arcTan2(PV,PS));
      if valeur>0 then angleRef := bsAngle1 else angleRef := bsAngle3;
      if angleRef=bsAngle1 then angleFin := bsAngle3 else angleFin := bsAngle1;
      result := intToStr(round(valeur))+' °';
   end;

   var xt,yt,signe : integer;
       lT : double;
       dx,dy : integer;
       Points:  array[0..2] of Tpoint;
   begin
       angleLabel.caption := valeurAngle;
       angleLabelBis.caption := valeurAngle;
       image.Canvas.Arc(pointRepere[bsAngle2].x-rayonAngle,
                        pointRepere[bsAngle2].y-rayonAngle,
                        pointRepere[bsAngle2].x+rayonAngle,
                        pointRepere[bsAngle2].y+rayonAngle,
                        pointRepere[AngleRef].x,pointRepere[AngleRef].y,
                        pointRepere[AngleFin].x,pointRepere[AngleFin].y);
       image.canvas.moveTo(pointRepere[bsAngle2].x,pointRepere[bsAngle2].y);
       image.canvas.lineTo(pointRepere[bsAngle1].x,pointRepere[bsAngle1].y);
       image.canvas.moveTo(pointRepere[bsAngle2].x,pointRepere[bsAngle2].y);
       image.canvas.lineTo(pointRepere[bsAngle3].x,pointRepere[bsAngle3].y);
       xT := -pointRepere[bsAngle2].x+((pointRepere[bsAngle3].x+pointRepere[bsAngle1].x) div 2);
       yT := -pointRepere[bsAngle2].y+((pointRepere[bsAngle3].y+pointRepere[bsAngle1].y) div 2);
       lT := rayonAngle/sqrt(sqr(xt)+sqr(yt));
       angleLabel.left := round(pointRepere[bsAngle2].x+xT*lT/zoomAffichage);
       if angleRef=bsAngle1 then signe := 0 else signe := -1;
       angleLabel.top := round(pointRepere[bsAngle2].y/zoomAffichage+yT*lT+signe*angleLabel.Height);
// L'arc traverse le périmètre de l'ellipse circonscrite par les points (X1,Y1) et (X2,Y2).
// L'arc est dessiné en suivant le périmètre de l'ellipse, dans le sens contraire des aiguilles d'une montre
// jusqu'au point d'arrivée. Le point de départ est défini par l'intersection de l'ellipse et d'une ligne définie
// par le centre de l'ellipse et (X3,Y3). Le point d'arrivée est défini par l'intersection de l'ellipse et d'une ligne
// définie par le centre de l'ellipse et (X4,Y4).
        dx := pointRepere[bsAngle3].X- pointRepere[bsAngle2].X;
        dy := pointRepere[bsAngle3].y- pointRepere[bsAngle2].y;
        lT := rayonAngle/sqrt(sqr(dX) + sqr(dY));
        Points[0] := Point(pointRepere[bsAngle2].X+round(lT * dX),
                           pointRepere[bsAngle2].y+round(lT * dY));
        lT := longFleche/sqrt(sqr(dX) + sqr(dY));
        dX := round(lT * dX);
        dY := round(lT * dY);
        if angleRef=bsAngle1 then begin dX := -dX; dY := -dY end;
        Points[1] := Point(Points[0].x + dY - (dX div 3), Points[0].Y - dX - (dY div 3));
        Points[2] := Point(Points[0].x + dY + (dX div 3), Points[0].y - dX + (dY div 3));
        image.canvas.Polygon(Points); // triangle 3 points
   end;

   procedure ToptiqueForm.TraceDistance;
   var dimPix,Larrondi : double;
       unite : string;
       xt,yt : integer;
       valeur : double;
       NbrePixelEchelle : double;
   begin
       unite := ' m';
       case echelleRG.itemIndex of
          1 : dimPix := longueurRef;
          0 : begin
             NbrePixelEchelle := sqrt(
                sqr(PointRepere[bsEchelle1].x-PointRepere[bsEchelle2].x)+
                sqr(PointRepere[bsEchelle1].y-PointRepere[bsechelle2].y));
             dimPix := LongueurRef/NbrePixelEchelle;
          end;
          else begin
             dimPix := 1;
             unite := '';
          end;
       end;
       LArrondi  := power(10, floor(log10(abs(dimPix))));
       valeur := sqrt(sqr(pointRepere[bsAngle2].x-pointRepere[bsAngle1].x)+
                      sqr(pointRepere[bsAngle2].y-pointRepere[bsAngle1].y))
                 *dimPix;
       angleLabel.caption := FormatReg(LArrondi * round(valeur / LArrondi))+unite;
       angleLabelBis.caption := angleLabel.caption;
       image.canvas.moveTo(pointRepere[bsAngle2].x,pointRepere[bsAngle2].y);
       image.canvas.lineTo(pointRepere[bsAngle1].x,pointRepere[bsAngle1].y);
       traceFleche(pointRepere[bsAngle1],pointRepere[bsAngle2]);
       traceFleche(pointRepere[bsAngle2],pointRepere[bsAngle1]);
       xT := ((pointRepere[bsAngle2].x+pointRepere[bsAngle1].x) div 2)+20;
       yT := ((pointRepere[bsAngle2].y+pointRepere[bsAngle1].y) div 2)+20;
       angleLabel.left := round(xt/zoomAffichage);
       angleLabel.top := round(yt/zoomAffichage);
   end;

    procedure ToptiqueForm.TraceFleche(P1,P2: Tpoint);
    var
      dx,dy: integer;
      Points:  array[0..2] of Tpoint;
      d : double;
    begin // P2 = extrémité de la flèche ; P1-P2 = direction
      dx := P2.X-P1.X;
      dy := P2.y-P1.y;
      d := longFleche/sqrt(sqr(dX) + sqr(dY));
      dX := round(d * dX);
      dY := round(d * dY);
      Points[0] := Point(P2.x, P2.y);
      Points[1] := Point(P2.x - dX - (dY div 3), P2.Y - dY + (dX div 3));
      Points[2] := Point(P2.x - dX + (dY div 3), P2.y - dY - (dX div 3));
      image.canvas.Polygon(Points); // triangle 3 points
    end;

end.



