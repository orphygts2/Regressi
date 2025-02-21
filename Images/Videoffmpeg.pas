unit Videoffmpeg;

interface

uses
  System.Types, System.UITypes, System.ImageList, system.IOUtils, system.dateUtils,
  Windows, SysUtils, Messages,  Classes, Graphics, Controls,
  Forms,  Dialogs, StdCtrls,  ExtCtrls,  Buttons, math,
  Menus, ImgList, Spin, ComCtrls, ToolWin, grids, inifiles,
  jpeg, Vcl.Imaging.pngimage, vcl.graphUtil,
  regutil, compile, constreg, grapheU, shellApi, clipBrd, maths,
  rollingShutterCalc,
  AVProbe, AVPreview, AVCodec,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TffmpegForm = class(TForm)
    PanelMediaPlayer: TPanel;
    TempsLabel: TLabel;
    OpenDialog: TOpenDialog;
    ToolBarBoutons: TToolBar;
    OpenBtn: TToolButton;
    UndoBtn: TToolButton;
    RegressiBtn: TToolButton;
    ExitBtn: TToolButton;
    MesureBtn: TToolButton;
    ToolBarParam: TToolBar;
    LabelNbreSE: TLabel;
    NbreSE: TSpinEdit;
    LabelIncertitude: TLabel;
    EchelleEdit: TEdit;
    IncertitudeSE: TSpinEdit;
    LabelEchelle: TLabel;
    GridSplitter: TSplitter;
    RazBtn: TToolButton;
    PanelVideo: TPanel;
    PlayBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    SuivantBtn: TSpeedButton;
    Grid: TStringGrid;
    Image1: TImage;
    RewindBtn: TSpeedButton;
    LabelFPS: TLabel;
    PrecedentBtn: TSpeedButton;
    TimerPlayVideo: TTimer;
    SaveDialog: TSaveDialog;
    ChronoPhotoBtn: TToolButton;
    RalentiTB: TTrackBar;
    NimagesSE: TSpinEdit;
    Label1: TLabel;
    Panel1: TPanel;
    TrackBar: TTrackBar;
    FinBtn: TSpeedButton;
    DebutBtn: TSpeedButton;
    NchronoSE: TSpinEdit;
    GroupBox1: TGroupBox;
    TraceEchCB: TCheckBox;
    CouleurAxeCB: TColorBox;
    GroupBox2: TGroupBox;
    TracePointsCB: TCheckBox;
    CouleurPointsCB: TColorBox;
    MesureAutoCB: TCheckBox;
    EtiquetteCB: TCheckBox;
    VitesseLabel: TLabel;
    GridPanel: TPanel;
    altitudeCB: TCheckBox;
    TimerMove: TTimer;
    zoomUD: TSpinEdit;
    origineMobileCB: TCheckBox;
    RazAxes: TToolButton;
    Label2: TLabel;
    RollingShutterLabel: TLabel;
    RollingShutterBtn: TSpeedButton;
    RollingShutterSE: TSpinEdit;
    imgPreview: TImage;
    TimerChrono: TTimer;
    CaptureBtn: TToolButton;
    TimerPlayImages: TTimer;
    LabelAttente: TLabel;
    MethodeRG: TRadioGroup;
    rotateMoinsBtn: TSpeedButton;
    RotatePlusBtn: TSpeedButton;
    OrigineTempsBtn: TToolButton;
    EchelleMenu: TPopupMenu;
    Axeverslehautdroite: TMenuItem;
    Axeverslebasdroite: TMenuItem;
    Axeverslehautgauche: TMenuItem;
    Axeverslebasgauche: TMenuItem;
    Image2: TImage;
    Status: TStatusBar;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    CibleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenFileBtnClick(Sender: TObject);
    procedure MesureBtnClick(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure EchelleEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OrigineItemClick(Sender: TObject);
    procedure CouleurPointsCBChange(Sender: TObject);
    procedure CouleurAxeCBChange(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure SuivantBtnClick(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure RewindBtnClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure PrecedentBtnClick(Sender: TObject);
    procedure TimerPlayVideoTimer(Sender: TObject);
    procedure PanelVideoResize(Sender: TObject);
    procedure ChronoPhotoBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DebutBtnClick(Sender: TObject);
    procedure FinBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure altitudeCBClick(Sender: TObject);
    procedure TimerMoveTimer(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure RazAxesClick(Sender: TObject);
    procedure zoomUDChange(Sender: TObject);
    procedure RollingShutterBtnClick(Sender: TObject);
    procedure TimerChronoTimer(Sender: TObject);
    procedure CaptureBtnClick(Sender: TObject);
 //   procedure DroiteBtnClick(Sender: TObject);
    procedure TimerPlayImagesTimer(Sender: TObject);
    procedure EchelleEditExit(Sender: TObject);
    procedure rotateMoinsBtnClick(Sender: TObject);
    procedure RollingShutterSEChange(Sender: TObject);
    procedure OrigineTempsBtnClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure AxesClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormShowHint(Sender: TObject);
  private
    debutPlayVideo : TDateTime;
    BorneSelect : TstyleDrag;
    LongueurEchelle : double;
    DureeImage : double;
    signeY : integer;
    Nmes : integer;
    Largeur,Hauteur : integer;
    LargeurAff,HauteurAff : integer;
    PointRepere : array[TstyleDrag] of TpointF;
    e_PointRepere : array[TstyleDrag] of TpointF;
    PointCourant : integer;
    Couleur : array[0..maxPoints] of Tcolor;
    CouleurGrid : array[0..2*maxPoints+1] of Tcolor;
    nomFichier,nomCopie : string;
    pasZoom : single; // entre bitmap et écran
    zoomBmp : single; // entre video et bitmap
    BlueCibleChrono,RedCibleChrono,GreenCibleChrono : array[0..maxPoints] of integer;
    bitmapC,bitmapFin,bitmapInit : TBitmap; // pour Chrono
    nomFichierChrono : string;
    dureeSec : single;
    angleX : double;
    bitmapLoupe : Tbitmap;
    demiHauteurLoupe : integer;
    imageCourante : string;
    FProbe : TAVProbe;
    FPreview : TAVPreview;
    methode : Tmethode;
    rotation : integer;
    nomOriginal : string;
    zoomEffectue : boolean;
    procedure setBoutons;
    procedure EnregistrePoint;
    procedure SetCurseur(Acursor : Tcursor);
    procedure traceGrid;
    procedure SauveData;
    Function GetBorne(x,y : integer;Deplace : boolean) : TstyleDrag;
    Procedure SetBorne(aBorne : TstyleDrag);
    procedure videRepertoire;
    procedure dessineImage;
    procedure calcEchelle;
    procedure SaveChronoPhoto;
    procedure ConvertitXY(Sender: TObject;var X, Y: Integer);
    procedure ConvertitCibleXY(Sender: TObject;var X, Y: Integer);
    procedure CacheLoupe;
    procedure EcranVersImage;
    procedure ImageVersEcran;
    procedure CorrigeAxes;
    procedure AffecteChrono;
    procedure LanceChrono;
    procedure ChronoInit;
    procedure updatePreview(index : integer);
    function getNomImage(index : integer) : string;
    procedure upDateImage(const NomImage : string);
    procedure upDateCourant;
    procedure EffectuerZoom(init : boolean);
    procedure OuvreFichiers(const NomFichiers : Tstrings);
  public
    procedure OuvreFichier(const Anom: string);
  protected
    procedure WMMajAvi(var Msg: Tmessage); message WM_Maj_Avi;
  end;

var
  ffmpegForm: TffmpegForm;

implementation

uses regmain, regdde, graphvar, chronoU, ChronoBitmap, loupeU, rollingShutterU, avlib,
     captureCamera, aideKey;

const
      hintBorne : array[TStyleDrag] of string =
               (hClicDroitAvi, '', hOrigineMove, hDebutEchelle, hFinEchelle,
                hCibleAuto, '', hAxeX, hAxeY,'',hLectureAvi);

{$R *.DFM}

procedure TffmpegForm.WMMajAvi(var Msg: Tmessage);
begin
     timerPlayImages.Enabled := false;
     timerPlayVideo.Enabled := false;
     timerChrono.enabled := false;
     labelAttente.caption := '';
     trackBar.position := 0;
     stopBtn.enabled := true;
     suivantBtn.Enabled := true;
     precedentBtn.Enabled := true;
     rewindBtn.Enabled := true;
     borneSelect := bsNone;
     toolBarBoutons.Enabled := true;
     dessineImage;
end;

procedure TffmpegForm.FormCreate(Sender: TObject);
var Fichier : TMemIniFile;
    j : integer;
begin
    nomFichier := '';
    nomCopie := '';
    nomFichierChrono := '';
    LabelFPS.Caption := '';
    LongueurEchelle := 1;
    EchelleEdit.text := '1';
    tempsLabel.Caption := '';
    LabelAttente.Caption := '';
    methode := mPreview;
    FPreview := TAVPreview.Create(self);
    with FPreview do begin
      Left := 0;
      Top := 0;
      Width := 5;
      Height := 5;
      Active := False;
    end;
    FProbe := TAVProbe.Create;
    Fichier := TMemIniFile.create(NomFichierIni);
    videoDir := Fichier.readString(stAvi,stRepertoire,videoDir);
    OpenDialog.filterIndex := Fichier.readInteger(stAvi,'FilterIndex',1);
    MethodeRG.itemIndex := Fichier.readInteger(stAvi,'Methode',1);
    RollingShutterSE.value := Fichier.readInteger(stAvi,'RollingShutter',0);
    NbreSE.value := Fichier.readInteger(stAvi,'NImages',1);
    NimagesSE.value := 1;
    TraceEchCB.checked := Fichier.readBool(stAvi,'TraceEchelle',true);
    TracePointsCB.checked := Fichier.readBool(stAvi,'TracePoints',true);
    EtiquetteCB.checked := Fichier.readBool(stAvi,'Etiquette',true);
    couleurAxeCB.selected := Fichier.readInteger(stAvi,'CouleurEchelle',clBlack);
    bitmapC := Tbitmap.create;
    //bitmapOrigin := Tbitmap.create;
    couleur[0] := couleurAxeCB.selected;
    for j := 1 to maxPoints do
        Couleur[j] := Fichier.readInteger(stAvi,stCouleur+intToStr(j),clBlack);
    CouleurPointsCB.selected := Couleur[1];
    LoupeForm := TLoupeForm.Create(self);
    altitudeCB.checked := Fichier.readBool(stAvi,'Altitude',true);
    if altitudeCB.checked
        then SigneY := -1
        else SigneY := +1;
    IncertitudeSE.value := Fichier.readInteger(stAvi,'PixelIncert',0);
    ZoomUD.value := Fichier.readInteger(stAvi,'Loupe',1);
    Fichier.free;
    Grid.cells[0,0] := 't(s)';
    nbreSE.MaxValue := maxPoints;
    bitmapLoupe := Tbitmap.create;
    bitmapLoupe.pixelFormat := pf24bit;
    LoupeForm.paintBox.onMouseUp := paintBoxMouseUp;
    LoupeForm.paintBox.onMouseDown := paintBoxMouseDown;
    LoupeForm.paintBox.onMouseMove := paintBoxMouseMove;
    LoupeForm.onKeyDown := formKeyDown;
    LoupeForm.Hide;
    VirtualImageList1.height := VirtualImageListSize;
    VirtualImageList1.width := VirtualImageListSize;
    Grid.DefaultRowHeight := hauteurColonne;
    setBoutons;
end; // FormCreate

procedure TffmpegForm.RegressiBtnClick(Sender: TObject);
begin
    setBorne(bsNone);
    setBoutons;
    SauveData
end;

procedure TffmpegForm.RewindBtnClick(Sender: TObject);
begin
    trackBar.position := trackBar.SelStart;
    timerPlayImages.Enabled := false;
    timerPlayVideo.Enabled := false;
    timerChrono.enabled := false;
end;

procedure TffmpegForm.RollingShutterBtnClick(Sender: TObject);
begin
    RollingShutterForm := TRollingShutterForm.create(self);
    RollingShutterForm.showModal;
    RollingShutterForm.free;
end;

procedure TffmpegForm.RollingShutterSEChange(Sender: TObject);
begin
    if RollingShutterSE.Value=0
       then RollingShutterLabel.Font.Color := clBlack
       else RollingShutterLabel.Font.Color := clRed
end;

procedure TffmpegForm.rotateMoinsBtnClick(Sender: TObject);
var deltaRotation : integer;

  procedure ChangeZoom;
  var oldZoomBmp,coeff : single;
    S : single;
    i : TstyleDrag;
    x,y : single;
    dx,dy : single;
  begin
    oldZoomBmp := zoomBmp;
    effectuerZoom(false);
    coeff := zoomBmp/oldZoomBmp;
    if deltaRotation=1
       then begin
         S := coeff;
         dX := largeur;
         dY := 0;
       end
       else begin
         S := -coeff;
         dX := 0;
         dY := hauteur;
       end;
    for i := low(TstyleDrag) to High(TstyleDrag) do begin
        x := PointRepere[i].x;
        y := PointRepere[i].y;
        PointRepere[i].x := -y*S + dx;
        PointRepere[i].y := x*S + dy;
    end;
    imageVersEcran;
    TrackBarChange(Sender);
  end;

begin // rotateMoinsClick
    deltaRotation := (sender as TSpeedButton).tag;
    rotation := rotation+deltaRotation;
    if rotation>2 then dec(rotation,4);
    if rotation<-2 then inc(rotation,4);
    hauteur := round(hauteur/zoomBmp);
    largeur := round(largeur/zoomBmp);
    swap(largeur,hauteur);
    changeZoom;
end;

procedure TffmpegForm.SauveData;
begin
       Screen.Cursor := crHourGlass;
       calcEchelle;
       correctionRS.withOrigine := OrigineMobileCB.Checked;
       correctionRS.RSvalue := RollingShutterSE.value;
       correctionRS.Nbre := nmes;
       correctionRS.NPoints := NbreSE.value;
       correctionRS.hauteur := hauteur;
       correctionRS.largeur := largeur;
       correctionRS.angleX := angleX;
       correctionRS.signeY := signeY;
       correctionRS.incertXY := IncertitudeSE.value;
       correctionRS.nomFichierVideo := nomFichier;
       correctionRS.sauveData;
       Screen.Cursor := crDefault;
       setBoutons;
       Close;
end; // SauveData

procedure TffmpegForm.ExitBtnClick(Sender: TObject);
begin
    Close
end;

procedure TffmpegForm.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var deltax, deltay, rayon : single;
begin
if (Button<>mbLeft) or not (FPreview.active or FProbe.active) then exit;
convertitCibleXY(sender,x,y);
if OrigineTempsBtn.down and (OrigineTempsBtn.style=tbsCheck) then begin
   OrigineTempsBtn.down := false;
   if BorneSelect=bsMesure
        then begin
           hint := hintBorne[bsMesure];
           status.Panels[2].Text := hint;
           setCurseur(crNone);
        end
        else begin
           status.Panels[2].Text := '';
           setCurseur(crDefault);
        end;
   exit;
end;
e_pointRepere[BorneSelect].x := x;
e_pointRepere[BorneSelect].y := y;
corrigeAxes;
ecranVersImage;
case BorneSelect of
     bsEchelle1,bsEchelle2,bsOrigine,bsAxeX,bsAxeY : begin
         rayon := hauteur/4;
         sinCos(angleX,deltaY,deltaX);
         deltaY := rayon*deltaY;
         deltaX := rayon*deltaX;
         PointRepere[bsAxeX] := PointRepere[bsOrigine];
         PointRepere[bsAxeX].offset(deltaX,deltaY);
         sincos(angleX+signeY*pi/2,deltaY,deltaX);
         deltaY := rayon*deltaY;
         deltaX := rayon*deltaX;
         PointRepere[bsAxeY] := PointRepere[bsOrigine];
         PointRepere[bsAxeY].offset(deltaX,deltaY);
         imageVersEcran;
         setBorne(bsNone);
         updateCourant;
     end;
     bsMesure : EnregistrePoint;
     bsChronoInit : ChronoInit;
  end;
end; // MouseUp

procedure TffmpegForm.EnregistrePoint;
begin
         correctionRS.XY[pointCourant,Nmes] := pointRepere[bsMesure];
         correctionRS.Temps[Nmes] := trackBar.position*dureeImage;
         if (Nmes + 2) > grid.rowCount then
             grid.rowCount := Nmes + 5;
         Grid.cells[0,Nmes+1] := correctionRS.StrT(Nmes);
         if pointCourant>0 then begin
            Grid.cells[pointCourant*2-1,Nmes+1] := correctionRS.strX(pointCourant,Nmes);
            Grid.cells[pointCourant*2,Nmes+1] := correctionRS.strY(pointCourant,Nmes);
         end;
         inc(PointCourant);
         if OrigineMobileCB.checked then begin
            if (PointCourant=1)
            then begin
               if NbreSE.value>1
                  then hint := Format(hMesureAvi1N,[succ(nmes)])
                  else hint := Format(hMesureAvi1,[succ(nmes)]);
            end
            else hint := Format(hMesureAviN,[PointCourant,succ(nmes)]);
         end
         else if NbreSE.value>1 then
                hint := Format(hMesureAviN,[PointCourant,succ(nmes)]);
         UndoBtn.enabled := true;
         if PointCourant>NbreSe.value then begin
             inc(Nmes);
             if OrigineMobileCB.checked
                then begin
                   PointCourant := 0;
                   hint := hOrigineI+intToStr(succ(nmes));
                end
                else begin
                    PointCourant := 1;
                    if NbreSE.value>1
                      then hint := Format(hMesureAvi1N,[succ(nmes)])
                      else hint := Format(hMesureAvi1,[succ(nmes)]);
                end;
             RegressiBtn.enabled := nmes>3;
             if trackBar.position<trackBar.max
                then SuivantBtnClick(nil)
                else begin
                   setBorne(bsNone);
                   setBoutons;
                   DessineImage;
                end;
         end;
         PanelVideo.Hint := hint;
         ImgPreview.Hint := hint;
         if Nmes>0
            then begin
                OrigineTempsBtn.style := tbsCheck;
                OrigineTempsBtn.Hint := hOrigineTemps;
            end
            else begin
                OrigineTempsBtn.style := tbsButton;
                OrigineTempsBtn.Hint := trOrigineTemps;
            end;
end; // EnregistrePoint

procedure TffmpegForm.OuvreFichier(const Anom : string);

  Procedure RecopieLocal;
  var nomCourt : string;
    src,dest : Pchar;
  begin
     if Anom[1]<>'C' then begin
        nomCourt := extractFileName(Anom);
        removeBackSlash(tempDirReg);
        nomFichier := Tpath.combine(tempDirReg,nomCourt);
        NomCopie := nomFichier;
        src := strAlloc(length(Anom)+1);
        dest := strAlloc(length(nomFichier)+1);
        strPCopy(src,anom);
        strPCopy(dest,nomFichier);
        copyFile(src,dest,true);
        strDispose(src);
        strDispose(dest);
     end
     else begin
        NomFichier := ANom;
        NomCopie := '';
     end;
  end;

  procedure RecupereData;

  function GetDosOutput(CommandLine: string): string;
// Run a DOS program and retrieve its output dynamically while it is running.
  var
  SecAtrrs: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  pCommandLine: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
  begin
  Result := '';
  with SecAtrrs do begin
    nLength := SizeOf(SecAtrrs);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SecAtrrs, 0);
  try
    with StartupInfo do begin
      FillChar(StartupInfo, SizeOf(StartupInfo), 0);
      cb := SizeOf(StartupInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := extractFilePath(application.exeName);
    Handle := CreateProcess(nil, PChar(CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), StartupInfo, ProcessInfo);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := windows.ReadFile(StdOutPipeRead, pCommandLine, 255, BytesRead, nil);
          if BytesRead > 0 then begin
            pCommandLine[BytesRead] := #0;
            Result := Result + string(pCommandLine);
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      finally
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
  end;

  procedure RecupereOrientation;
  var info, param, nomffProbe : string;
  begin
     nomffProbe := '"'+extractFilePath(application.exeName)+'ffprobe.exe"';
     param := ' -loglevel error -select_streams v:0 -show_entries stream_tags=rotate -of default=nw=1:nk=1 "'+nomFichier+'"';
     info := GetDosOutput(nomffProbe+param);
     rotation := 0;
     if pos('90',info)>0 then rotation := 1;
     if pos('270',info)>0 then rotation := -1;
     if pos('180',info)>0 then rotation := 2;
  end;

  procedure RecupereProbe;
  begin
      FProbe.FileName := NomFichier;
      FProbe.Active := true;
      largeur := FProbe.VideoWidth;
      hauteur := FProbe.VideoHeight;
      DureeImage := 1/FProbe.videoframeRate;
      DureeSec := FProbe.Duration;
  end;

  procedure RecuperePreview;
  begin
      FPreview.inputFile := NomFichier;
      FPreview.Active := true;
      DureeImage := 1/FPreview.VideoFrameRate;
      DureeSec := Fpreview.Duration;
  end;

  begin // recupereData
          imageCourante := '';
          tempsLabel.Caption  := '';
          trackBar.tag := 1;
          methode := Tmethode(MethodeRG.itemIndex);
          RecupereOrientation;
          case methode of
               mPreview: recuperePreview;
               mProbe: recupereProbe;
          end;
          TrackBar.Max := trunc(DureeSec/dureeImage)-1;
          TrackBar.SelEnd := trackBar.Max;
          TrackBar.SelStart := 0;
          TrackBar.Position := 0;
          trackBar.tag := 0;
          angleX := 0;
          RazAxes.Caption := 'Axes';
          RazAxes.hint := trOrientationAxes;
          RazAxes.imageIndex := 16;
          if methode=mProbe then EffectuerZoom(true);
          LabelFPS.Caption := '  '+ intToStr(round(1/dureeImage))+' img/s ';
  end; // recupereData

var i,j : integer;
    blocage : boolean;
begin // ouvreFichier
     // Raz
     if FPreview.Active then FPreview.TimeStamp := 0;
     if FProbe.Active then FProbe.TimeStamp := 0;
     FPreview.Active := false;
     FPreview.inputFile := '';
     Nmes := 0;
     Fprobe.Active := false;
     FProbe.FileName := '';

     // valeur par défaut
     zoomBmp := 1;
     pasZoom := 1;
     rotation := 0;
     DureeImage := 1/25;
     trackBar.SelEnd := 0;
     trackBar.SelStart := 0;
     traceEchCB.visible := true;

     nomOriginal := Anom;
     cacheLoupe;
     videRepertoire;
     videoDir := extractFilePath(Anom);
     recopieLocal;
     setBorne(bsNone);
     ImgPreview.Stretch := false; // pour accélérer ?
     try
     RecupereData;
     Caption := Captionffmpeg+' ['+ExtractFileName(NomFichier)+']';
     for i := 2 to pred(Grid.rowCount) do
         for j := 0 to pred(grid.colCount) do
             Grid.cells[j,i] := '';
     if (methode=mProbe) and (ImgPreview.Width>(largeurAff+32)) then
         gridPanel.Width := ClientWidth-largeurAff-gridSplitter.Width-32;
     except
         FPreview.Active := false;
         Fprobe.active := false;
     end;
     setBoutons;
     if FPreview.active or Fprobe.Active then begin
        labelAttente.Caption := hInitPatience;
        blocage := TrackBar.Max>60*15; // 1 minute à 15 img/sec
        suivantBtn.Enabled := blocage;
        precedentBtn.Enabled := blocage;
        rewindBtn.Enabled := blocage;
        toolBarBoutons.Enabled := blocage;
     // boutons interdits de manière à être sûr de créer toutes les images
        timerPlayVideo.Interval := round(dureeImage*1.25*1000);
        timerPlayVideo.Enabled := true;
        debutPlayVideo := now;
        stopBtn.enabled := true; // Il faut pouvoir débloquer !
        BorneSelect := bsPlay;
     end;
     CorrectionRS.reset;
end; // ouvreFichier

procedure TffmpegForm.OuvreFichiers(const NomFichiers : Tstrings);

  Procedure RecopieLocal;

  procedure unFichier(NomFichierScr,NomFichierDest : string);
  var extension : string;
      Ajpeg : TjpegImage;
      Apng : TpngImage;
  begin
     extension := AnsiUpperCase(extractFileExt(NomFichierScr));
     if (extension='.GIF') then begin
          ConvertitGifBmp(nomFichierScr);
          extension := '.BMP';
     end;
     if (extension='.PNG') then begin
          Apng := TpngImage.create;
          Apng.LoadFromFile(NomFichierScr);
          with bitmapC do begin
               pixelFormat := pf24bit;
               height := Apng.Height;
               width := Apng.Width;
               assign(Apng);
               saveToFile(nomFichierDest);
          end;
          Apng.free;
     end;
     if (extension='.JPG') or (extension='.JPEG') then begin
          Ajpeg := TjpegImage.create;
          Ajpeg.LoadFromFile(NomFichierScr);
          with bitmapC do begin
              pixelFormat := pf24bit;
              height := Ajpeg.height;
              width := Ajpeg.width;
              assign(Ajpeg);
              saveToFile(nomFichierDest);
          end;
          Ajpeg.free;
     end;
     if (extension='.BMP') then begin
        BitmapC.LoadFromFile(NomFichierScr);
        bitmapC.saveToFile(nomFichierDest);
     end;
  end;

  var nomCourt,nomCopie : string;
      i : integer;
  begin
     nomCourt := extractFileName(nomFichiers[0]);
     Caption := Captionffmpeg+' ['+nomCourt+']';
     removeBackSlash(tempDirReg);
     NomCopie := Tpath.combine(tempDirReg,'test');
     for i := 0 to nomFichiers.count-1 do
         unFichier(nomFichiers[i], nomCopie+system.SysUtils.format('%3d',[i]));
     bitmapC.loadFromFile(nomCopie+'.001.bmp');
     largeur := bitmapC.Width;
     hauteur := bitmapC.Height;
  end;

  procedure RecupereData;
  begin // recupereData
          imageCourante := '';
          tempsLabel.Caption  := '';
          trackBar.tag := 1;
          TrackBar.Max := NomFichiers.count-1;
          TrackBar.SelEnd := trackBar.Max;
          TrackBar.SelStart := 0;
          TrackBar.Position := 0;
          trackBar.tag := 0;
          angleX := 0;
          RazAxes.Caption := 'Axes';
          RazAxes.hint := trOrientationAxes;
          RazAxes.imageIndex := 16;
          EffectuerZoom(true);
          LabelFPS.Caption := '  '+ intToStr(round(1/dureeImage))+' img/s ';
  end; // recupereData

var i,j : integer;
begin // ouvreFichiers
     // Raz
     Nmes := 0;
     // valeur par défaut
     zoomBmp := 1;
     pasZoom := 1;
     rotation := 0;
     DureeImage := 1/25;
     trackBar.SelEnd := 0;
     trackBar.SelStart := 0;
     traceEchCB.visible := true;

     nomOriginal := nomFichiers[0];
     cacheLoupe;
     videRepertoire;
     videoDir := extractFilePath(nomFichiers[0]);
     recopieLocal;
     setBorne(bsNone);
     RecupereData;
     for i := 2 to pred(Grid.rowCount) do
         for j := 0 to pred(grid.colCount) do
             Grid.cells[j,i] := '';
     if (ImgPreview.Width>(largeurAff+32)) then
         gridPanel.Width := ClientWidth-largeurAff-gridSplitter.Width-32;
     setBoutons;
     CorrectionRS.reset;
end; // ouvreFichiers

procedure TffmpegForm.OpenFileBtnClick(Sender: TObject);
begin
   if OpenDialog.InitialDir='' then
      OpenDialog.InitialDir := VideoDir;
   if OpenDialog.execute then begin
      if (openDialog.FilterIndex=2) then begin // images
         if openDialog.Files.count<3
         then begin
              afficheErreur('Trop peu d''images',0);
         end
         else begin
            ouvreFichiers(openDialog.files);
            OpenDialog.InitialDir := extractFilePath(openDialog.fileName);
         end;
      end
      else begin // video
         ouvreFichier(openDialog.fileName);
         OpenDialog.InitialDir := extractFilePath(openDialog.fileName);
      end;
   end;
end;

procedure TffmpegForm.setBoutons;
var OK : boolean;
begin
    OK := FPreview.active or Fprobe.active;
    EchelleEdit.enabled := OK;
    MesureBtn.enabled := OK and not ChronoPhotoBtn.down;
    ChronoPhotoBtn.enabled := OK and (borneSelect<>bsMesure) and not(MesureBtn.down);
    RegressiBtn.enabled := nmes>3;
    EchelleEdit.enabled := OK;
    OrigineTempsBtn.Enabled := (borneSelect=bsMesure) or ((borneSelect=bsMesure) and (Nmes>0));
    RazAxes.enabled := OK;// and (angleX<>0);
    if angleX=0
       then begin
           RazAxes.caption := 'Axes';
           RazAxes.hint := trOrientationAxes;
       end
       else begin
           RazAxes.caption := 'RàZ axes';
           RazAxes.hint := trAxesParalleles;
       end;
    NbreSE.enabled := OK  and (borneSelect<>bsMesure);
    RazBtn.enabled := OK and (borneSelect<>bsMesure) and (nmes>0);
    if (borneSelect in [bsMesure,bsChrono,bsChronoInit]) and mesureBtn.enabled
       then begin
          MesureBtn.Hint := hStopMes;
          MesureBtn.Caption := stStop;
          MesureBtn.imageIndex := 1;
       end
       else begin
          MesureBtn.Hint := hStartMes;
          MesureBtn.Caption := 'Mesurer';
          MesureBtn.imageIndex := 8;
       end;
    if ChronoPhotoBtn.down and chronoPhotoBtn.enabled
       then begin
          ChronoPhotoBtn.Hint := hStopChrono;
          ChronoPhotoBtn.Caption := stStop;
          ChronoPhotoBtn.imageIndex := 1;
       end
       else begin
          ChronoPhotoBtn.Hint := hChrono;
          ChronoPhotoBtn.Caption := 'Chrono';
          ChronoPhotoBtn.imageIndex := 14;
       end;
    UndoBtn.enabled := OK and (borneSelect<>bsMesure) and (Nmes>0);
    OrigineTempsBtn.Enabled := OK;
    EchelleEdit.Height := 22;
    cursor := crDefault;
    if (borneSelect in [bsNone,bsChrono]) then cacheLoupe;
end; // setBoutons

procedure TffmpegForm.MesureBtnClick(Sender: TObject);
var i,j : integer;
begin
if MesureBtn.down
  then begin
     calcEchelle;
     correctionRS.RSvalue := RollingShutterSE.value;
     correctionRS.NPoints := NbreSE.value;
     correctionRS.hauteur := hauteur;
     correctionRS.angleX := angleX;
     correctionRS.signeY := signeY;
     correctionRS.incertXY := IncertitudeSE.value;
     Grid.ColCount := NbreSE.value*2+1;
     if NbreSE.value=1
          then begin
            Grid.cells[1,0] := 'x(m)';
            Grid.cells[2,0] := 'y(m)';
          end
          else for j := 1 to NbreSE.value do begin
            Grid.cells[2*j-1,0] := 'x'+intToStr(j)+'(m)';
            Grid.cells[2*j,0] := 'y'+intToStr(j)+'(m)';
          end;
     for i := 2 to pred(Grid.rowCount) do
         for j := 0 to pred(grid.colCount) do
             Grid.cells[j,i] := '';
  if MesureAutoCB.checked
    then begin
       nomFichierChrono := Tpath.combine(tempDirReg,'regressi.bmp');
{$IFDEF Debug}
       ecritDebug('début MesureBtnClick');
       ecritDebug('nomFichierChrono');
{$ENDIF}
       lanceChrono;
    end
    else begin
      setBorne(bsMesure);
      Nmes := 0;
      if OrigineMobileCB.checked
        then begin
           PointCourant := 0;
           hint := hOrigine1
        end
        else begin
           PointCourant := 1;
           if NbreSE.value>1
              then hint := Format(hMesureAvi1N,[1])
              else hint := Format(hMesureAvi1,[1]);
        end;
        panelVideo.Hint := hint;
        imgPreview.Hint := hint;
        MesureBtn.Hint := hStopMes;
        MesureBtn.imageIndex := 1;
        MesureBtn.Caption := stStop;
    end;
  end
  else begin
     setBorne(bsNone);
     MesureBtn.Hint := hStartMes;
     MesureBtn.imageIndex := 8;
     MesureBtn.Caption := 'Mesurer';
     if MesureAutoCB.checked and (borneSelect=bsChrono) then saveChronoPhoto;
  end;
  setBoutons;
  if (borneSelect<>bsNone) and not zoomEffectue then updateCourant;
end;

procedure TffmpegForm.UndoBtnClick(Sender: TObject);
var j : integer;
begin
     if Nmes>0 then dec(nmes);
     UndoBtn.enabled := nmes>0;
     if OrigineMobileCB.checked
          then begin
               PointCourant := 0;
               hint := hOrigineI+intToStr(succ(nmes));
          end
          else begin
               PointCourant := 1;
               if NbreSE.value>1
                   then hint := Format(hMesureAvi1N,[succ(nmes)])
                   else hint := Format(hMesureAvi1,[succ(nmes)]);
          end;
      for j := 0 to pred(grid.colCount) do
          Grid.cells[j,nmes+1] := '';
      PrecedentBtnClick(nil);
      updateCourant;
      panelVideo.Hint := hint;
      imgPreview.Hint := hint;
end;

procedure TffmpegForm.EchelleEditExit(Sender: TObject);
begin
    calcEchelle;
    traceGrid;
end;

procedure TffmpegForm.EchelleEditKeyPress(Sender: TObject; var Key: Char);
begin
    if key=crCR then EchelleEditExit(sender);
    if not CharInSet(key,['0'..'9','.',',','E','e','+','-',
                     crSupprArr,crTab,crGauche,crDroite]) then key := #0
end;

procedure TffmpegForm.PanelVideoResize(Sender: TObject);
begin
    if not (FPreview.active or FProbe.active) then exit;
    effectuerZoom(false);
end;

procedure TffmpegForm.PlayBtnClick(Sender: TObject);
begin
     if FPreview.active or FProbe.active then begin
        trackBar.Position := trackBar.selStart;
        timerPlayImages.Interval := 1000 div RalentiTB.Position;
        timerPlayImages.Enabled := true;
        stopBtn.Enabled := true;
     end;
end;

procedure TffmpegForm.DebutBtnClick(Sender: TObject);
begin
  TrackBar.SelStart := Trackbar.position
end;

procedure TffmpegForm.TraceGrid;

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
    if not (FPreview.active or FProbe.active) then exit;
    for j := 0 to pred(grid.ColCount) do
        couleurGrid[j] := getCouleurGrid(j);
    if (Nmes+2)>grid.rowCount then grid.rowCount := Nmes+5;
    if NbreSE.value=1
       then begin
          Grid.cells[1,0] := 'x(m)';
          Grid.cells[2,0] := 'y(m)';
       end
       else for j := 1 to NbreSE.value do begin
          Grid.cells[2*j-1,0] := 'x'+intToStr(j)+'(m)';
          Grid.cells[2*j,0] := 'y'+intToStr(j)+'(m)';
       end;
    for i := 0 to pred(nmes) do begin
           Grid.cells[0,i+1] := correctionRS.strT(i);
           for j := 1 to NbreSE.value do begin
               Grid.cells[j*2-1,i+1] := correctionRS.strX(j,i);
               Grid.cells[j*2,i+1] := correctionRS.strY(j,i);
           end;{j}
    end;
    for i := nmes+1 to pred(grid.rowCount) do
        for j := 0 to pred(grid.colCount) do
            Grid.cells[j,i] := '';
end; // TraceGrid

procedure TffmpegForm.FinBtnClick(Sender: TObject);
begin
    TrackBar.SelEnd := Trackbar.position
end;

procedure TffmpegForm.FormActivate(Sender: TObject);
begin
    cacheLoupe;
    Application.OnHint := FormShowHint;
end;

procedure TffmpegForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Fichier : TMemIniFile;
    j : integer;
begin
     try
     Fichier := TMemIniFile.create(NomFichierIni);
     try
     Fichier.writeInteger(stAvi,'RollingShutter',RollingShutterSE.value);
     Fichier.writeInteger(stAvi,'Methode',MethodeRG.itemIndex);
     Fichier.WriteBool(stAvi,'Etiquette',EtiquetteCB.checked);
     Fichier.writeInteger(stAvi,'FilterIndex',OpenDialog.filterIndex);
     Fichier.writeInteger(stAvi,'NImages',NbreSE.value);
     Fichier.writeBool(stAvi,'TraceEchelle',traceEchCB.checked);
     Fichier.writeBool(stAvi,'TracePoints',tracePointsCB.checked);
     Fichier.writeInteger(stAvi,'CouleurEchelle',couleurAxeCB.selected);
     Fichier.writeString(stAvi,stRepertoire,videoDir);
     for j := 1 to maxPoints do
         Fichier.writeInteger(stAvi,stCouleur+intToStr(j),Couleur[j]);
     Fichier.writeBool(stAvi,'Altitude',altitudeCB.checked);
     Fichier.writeInteger(stAvi,'PixelIncert',IncertitudeSE.value);
     Fichier.writeInteger(stAvi,'Loupe',zoomUD.value);
     Fichier.UpdateFile;
     finally
     Fichier.free;
     end;
     except
     end;
     timerPlayVideo.Enabled := false;
     labelAttente.caption := '';
     timerPlayImages.Enabled := false;
     timerMove.Enabled := false;
     timerChrono.Enabled := false;
     loupeForm.Hide;
     Application.OnHint := FRegressiMain.FormShowHint;
     inherited;
end; // formClose

procedure TffmpegForm.FormDestroy(Sender: TObject);
begin
     ffmpegForm := nil;
     if LoupeForm<>nil then begin
        LoupeForm.close;
        LoupeForm.free;
        LoupeForm := nil;
     end;
     bitmapC.free;
     //bitmapOrigin.free;
     FPreview.Active:=false;
     FPreview.InputFile:='';
     FProbe.Active:=false;
     FProbe.FileName:='';
     FProbe.Free;
     videRepertoire;
     bitmapLoupe.Free;
end;

procedure TffmpegForm.FormHide(Sender: TObject);
begin
     setCurseur(crDefault);
end;

procedure TffmpegForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
    incr : integer;
begin
     if not key in [vk_left,vk_numpad4,vk_right,vk_numpad6,
                    vk_down,vk_numpad2,vk_up,vk_numpad8,
                    vk_prior,vk_next,
                    vk_space,vk_return]
        then exit;
     try
     P := Mouse.CursorPos;
     except
       exit;
     end;
     if ssShift in shift then incr := 8 else incr := 1;
     case key of
          vk_left,vk_numpad4 : dec(P.X,incr);
          vk_right,vk_numpad6 : inc(P.X,incr);
          vk_down,vk_numpad2 : inc(P.Y,incr);
          vk_up,vk_numpad8 : dec(P.Y,incr);
          vk_prior : if ssShift in shift
              then dec(P.X,8)
              else dec(P.Y,8);
          vk_next : if ssShift in shift
              then inc(P.X,8)
              else inc(P.Y,8);
          vk_space,vk_return : if BorneSelect=bsMesure then begin
              P := ImgPreview.ScreenToClient(P);
              pointRepere[bsMesure].x := P.x/pasZoom;
              pointRepere[bsMesure].y := P.y/pasZoom;
              enregistrePoint;
              exit;
          end;
          else exit;
     end;
     key := 0;
     Mouse.CursorPos := P;
end;

procedure TffmpegForm.FormResize(Sender: TObject);
begin
    if gridPanel.Width>clientWidth div 3 then
       gridPanel.Width := clientWidth div 3;
end;

procedure TffmpegForm.SetCurseur(Acursor : Tcursor);
begin
    if ImgPreview.Cursor<>Acursor then begin
       imgPreview.cursor := Acursor;
       if (aCursor=crDefault) then cacheLoupe;
    end;
end;

procedure TffmpegForm.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

  procedure Loupe;
  var gainLoupe, LoupeSize : integer;
    xLeft,xRight,yTop,yBottom : integer;
    demiHauteur : integer;

  procedure reperage;
  var ecart : integer;
  begin
    ecart := gainLoupe*(LoupeSize div 3);
    LoupeForm.PaintBox.canvas.pen.color := couleurAxeCB.selected;
    LoupeForm.PaintBox.canvas.pen.style := psSolid;

    LoupeForm.PaintBox.canvas.moveto(0,demiHauteurLoupe);
    LoupeForm.PaintBox.canvas.lineto(ecart,demiHauteurLoupe);
    LoupeForm.PaintBox.canvas.moveto(2*ecart,demiHauteurLoupe);
    LoupeForm.PaintBox.canvas.lineto(LoupeForm.width,demiHauteurLoupe);

    LoupeForm.PaintBox.canvas.moveto(demiHauteurLoupe,0);
    LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe,ecart);
    LoupeForm.PaintBox.canvas.moveto(demiHauteurLoupe,2*ecart);
    LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe,LoupeForm.height);

    LoupeForm.PaintBox.canvas.moveto(demiHauteurLoupe,demiHauteurLoupe-2);
    LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe,demiHauteurLoupe+2);
    LoupeForm.PaintBox.canvas.moveto(demiHauteurLoupe-2,demiHauteurLoupe);
    LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe+2,demiHauteurLoupe);
    if (borneSelect=bsMesure) and (pointCourant=0) then begin
    // fleche X
        LoupeForm.PaintBox.canvas.moveto(LoupeForm.width-10,demiHauteurLoupe-4);
        LoupeForm.PaintBox.canvas.lineto(LoupeForm.width-2,demiHauteurLoupe);
        LoupeForm.PaintBox.canvas.lineto(LoupeForm.width-10,demiHauteurLoupe+4);
    // fleche Y
        LoupeForm.PaintBox.canvas.moveto(demiHauteurLoupe-4,10);
        LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe,2);
        LoupeForm.PaintBox.canvas.lineto(demiHauteurLoupe+4,10);
    end;
  end;

  procedure Efface;
  begin
     if (yBottom<>yTop) or (xLeft<>xRight) then begin
        LoupeForm.PaintBox.canvas.brush.Color := LoupeForm.transparentColorValue;
        LoupeForm.PaintBox.canvas.brush.style := bsSolid;
     end;
     if (yTop<>yBottom) then
        LoupeForm.PaintBox.canvas.FillRect(rect(0,yTop,LoupeForm.width,yBottom));
     if (xleft<>xright) then
        LoupeForm.PaintBox.canvas.FillRect(rect(xLeft,0,xRight,LoupeForm.height));
  end;

  var
   X1,Y1,X2,Y2 : integer;
   decaleX,decaleY : integer;
   aPoint : TPoint;
  begin
   imgPreview.OnMouseMove := nil;
   loupeForm.paintBox.OnMouseMove := nil; // mise à jour longue ...
   gainLoupe := zoomUD.value;
   LoupeSize := screen.height div 10;
   demiHauteur := LoupeSize div gainLoupe div 2;
   demiHauteurLoupe := demiHauteur*gainLoupe;
   LoupeSize := demiHauteur*2+1;
   LoupeForm.width := gainLoupe*loupeSize;
   LoupeForm.height := LoupeForm.width;
   LoupeForm.rond;
   X1 := X-demiHauteur;
   Y1 := Y-demiHauteur;
   X2 := X+demiHauteur;
   Y2 := Y+demiHauteur;
   xLeft := 0;xRight := 0;
   yTop := 0;yBottom := 0;
   decaleX := 0;decaleY := 0;
   if Y1<0 then begin
      yBottom := -Y1*gainLoupe;
      Y1 := 0;
      decaleY := Ybottom;
   end;
   if X1<0 then begin
      xRight := -X1*gainLoupe;
      X1 := 0;
      decaleX := Xright;
   end;
   if Y2>hauteurAff then begin
      yBottom := loupeForm.Height;
      yTop := loupeForm.Height-(Y2-hauteurAff)*gainLoupe;
      Y2 := hauteurAff;
   end;
   if X2>largeurAff then begin
      xRight := loupeForm.width;
      xLeft := loupeForm.width-(X2-largeurAff)*gainLoupe;
      X2 := largeurAff;
   end;
   bitmapLoupe.Width := X2-X1;
   bitmapLoupe.Height := Y2-Y1;
   bitmapLoupe.canvas.CopyRect(rect(0,0,X2-X1,Y2-Y1),
            bitmapC.canvas,
            rect(round(X1/pasZoom),round(Y1/pasZoom),
                 round(X2/pasZoom),round(Y2/pasZoom)));
   aPoint := imgPreview.clientToScreen(Point(x,y));
   LoupeForm.Left := aPoint.X-demiHauteurLoupe;
   LoupeForm.Top := aPoint.Y-demiHauteurLoupe;
   LoupeForm.paintBox.canvas.StretchDraw(
             rect(decaleX,decaleY,
                  decaleX+(X2-X1)*gainLoupe,
                  decaleY+(Y2-Y1)*gainLoupe),bitmapLoupe);
   Reperage;
   Efface;
   imgPreview.OnMouseMove := paintBoxMouseMove;
   loupeForm.paintBox.OnMouseMove := paintBoxMouseMove;
   if not loupeForm.visible then begin
      loupeForm.Cursor := crNone;
      loupeForm.paintBox.Cursor := crNone;
      loupeForm.show;
   end;
  end; // loupe

var BS : TstyleDrag;
begin
   if not (FPreview.active or FProbe.active) then exit;
   if borneSelect=bsChrono then exit;
   ConvertitXY(Sender,X,Y);
   if (x<=0) or (y<=0) or (x>=largeurAff) or (y>=hauteurAff) then begin
      cacheLoupe;
      exit;
   end;
   if borneSelect=bsNone then begin
         hint := '';
         BS := GetBorne(x,y,false);
         hint := hintBorne[BS];
         ImgPreview.hint := hint;
         panelVideo.Hint := hint;
         Status.panels[2].Text := hint;
         exit;
   end
   else if (BorneSelect in[bsEchelle1,bsEchelle2,bsOrigine,bsAxeX,bsAxeY]) and
           not timerMove.enabled then begin
      e_pointRepere[BorneSelect].x := x;
      e_pointRepere[BorneSelect].y := y;
      corrigeAxes;
      ecranVersImage;
      updateCourant;
      timerMove.Enabled := true;
   end;
   if (borneSelect in [bsMesure,bsOrigine,bsEchelle1,bsEchelle2,bsAxeX,bsAxeY,bsChronoInit])
      then Loupe
      else cacheLoupe;
end; // mouseMove

procedure TffmpegForm.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var d,dmin : integer;
    i,i0 : integer;
begin
    if (Button<>mbLeft) or not (FPreview.active or FProbe.active) then exit;
    ConvertitXY(Sender,X,Y);
    if OrigineTempsBtn.down and (OrigineTempsBtn.style=tbsCheck) then begin
       i0 := 0;
       dmin := 64;
       for i := 0 to pred(nmes) do begin
           d := round(sqrt(sqr(x-correctionRS.XY[1,i].x)+sqr(y-correctionRS.XY[1,i].y)));
           if d<dmin then begin
              dmin := d;
              i0 := i;
           end;
       end;
       if dmin<64 then begin
          correctionRS.tOrigine := correctionRS.valeurT(i0);
          traceGrid;
       end;
   //  OrigineTempsBtn.down := false sera fait par mouseUp
       exit;
    end;
    if borneSelect=bsNone then begin
      setBorne(GetBorne(x,y,true));
      setBoutons;
      ImgPreview.hint := hint;
      panelVideo.Hint := hint;
      Status.Panels[2].Text := hint;
      if (borneSelect<>bsNone) and not zoomEffectue then updateCourant;
    end;
end;

procedure TffmpegForm.calcEchelle;
var EchelleEnPixel : double;
begin
     if not (FPreview.active or FProbe.active) then exit;
     correctionRS.origineFixe.x := PointRepere[bsOrigine].x;
     correctionRS.origineFixe.y := PointRepere[bsOrigine].y;
     try
     LongueurEchelle := StrToFloatWin(EchelleEdit.text);
     except
         showMessage(erEchelle);
         EchelleEdit.text := FormatReg(LongueurEchelle);
     end;
     echelleEnPixel := PointRepere[bsEchelle1].distance(PointRepere[bsechelle2]);
     correctionRS.Echelle := LongueurEchelle/EchelleEnPixel;
     if altitudeCB.checked
        then SigneY := -1
        else SigneY := +1
end;

procedure TffmpegForm.zoomUDChange(Sender: TObject);
begin
    if zoomUD.Value=1 then cacheLoupe;
end;

procedure TffmpegForm.PrecedentBtnClick(Sender: TObject);
begin
    if (TrackBar.Position>TrackBar.Min) and (FPreview.Active or FProbe.active) then begin
         Screen.Cursor := crHourGlass;
         precedentBtn.enabled := false;
         suivantBtn.enabled := false;
         TrackBar.Position := trackBar.Position-1;
    end;
end;

procedure TffmpegForm.SuivantBtnClick(Sender: TObject);
var increment : integer;
begin
    if (FPreview.Active or FProbe.active) and (TrackBar.Position<TrackBar.SelEnd) then begin
         Screen.Cursor := crHourGlass;
         suivantBtn.enabled := false;
         precedentBtn.enabled := false;
         case BorneSelect of
            bsMesure : increment := NimagesSE.value;
            bsChrono : increment := NchronoSE.value
            else increment := 1;
         end;
         TrackBar.Position := trackBar.Position+increment;
    end;
end;

procedure TffmpegForm.TimerChronoTimer(Sender: TObject);
begin
{$IFDEF Debug}
    ecritDebug('appel timerChrono');
{$ENDIF}
    suivantBtnClick(sender);
end;

procedure TffmpegForm.TimerMoveTimer(Sender: TObject);
begin
    TimerMove.Enabled := false;
end;

procedure TffmpegForm.TimerPlayImagesTimer(Sender: TObject);
begin
  if TrackBar.Position<TrackBar.Max
     then TrackBar.Position := trackBar.Position+1
     else timerPlayImages.Enabled := false;
   timerPlayImages.Interval := 1000 div RalentiTB.Position;
end;

procedure TffmpegForm.TimerPlayVideoTimer(Sender: TObject);
begin
   if TrackBar.Position<TrackBar.Max then begin
      TimerPlayVideo.Enabled := false;
      if trackBar.Position=0 then updatePreview(0);  // crée l'image initiale
      if methode=mProbe then FProbe.NextFrame;
      updatePreview(trackBar.Position+1); // crée l'image suivante
      if (trackBar.Position>=trackBar.max)
         then PostMessage(Handle,WM_Maj_Avi,0,0)
         else TimerPlayVideo.Enabled := true;
   end
   else PostMessage(Handle,WM_Maj_Avi,0,0);
end;

procedure TffmpegForm.TrackBarChange(Sender: TObject);
var nomImage : string;

  procedure UpdatePreviewTB;
  begin
     bitmapC.Canvas.CopyMode := cmSrcCopy;
     case methode of
        mPreview : begin
           FPreview.TimeStamp := trackBar.Position*dureeImage;
           imgPreview.Picture.Assign(FPreview.Bitmap);
           if hauteur=0 then begin
              largeur := Fpreview.bitmap.Width;
              hauteur := Fpreview.bitmap.Height;
              effectuerZoom(true);
           end;
           if (nomImage<>'') then FPreview.Bitmap.SaveToFile(nomImage);
           bitmapC.Canvas.Draw(0,0,FPreview.bitmap);
        end;
        mProbe : begin
           FProbe.TimeStamp := Round(trackBar.Position*dureeImage*AV_TIME_BASE);
           imgPreview.Picture.Assign(FProbe.Bitmap);
           if (nomImage<>'') then Fprobe.Bitmap.SaveToFile(nomImage);
           bitmapC.Canvas.Draw(0,0,FProbe.bitmap);
        end;
     end;
     zoomEffectue := false;
     imageCourante := nomImage;
     case borneSelect of
        bsChrono : AffecteChrono;
        bsChronoInit : ;
        bsPlay : ;
        else dessineImage;
     end;
  end;

begin
   if (TrackBar.Tag = 0) and (FPreview.Active or FProbe.active) then begin
      nomImage := getNomImage(trackBar.Position);
      if (nomImage='') or not FileExists(nomImage)
          then UpdatePreviewTB
          else updateImage(nomImage);
      if trackBar.Position>=trackBar.max then begin
         timerPlayImages.Enabled := false;
         timerPlayVideo.Enabled := false;
         if borneSelect=bsPlay then borneSelect := bsNone;
         timerChrono.enabled := false;
      end;
      precedentBtn.Enabled := trackBar.Position>0;
      suivantBtn.Enabled := trackBar.Position<trackBar.max;
      Screen.Cursor := crDefault;
      tempsLabel.Caption := FloatToStrF(trackBar.Position*dureeImage,ffFixed,5,3)+'/'+IntToStr(ceil(DureeSec))+' s ';
   end;
end; // trackbarChange

procedure TffmpegForm.OrigineItemClick(Sender: TObject);
begin
  correctionRS.withOrigine := OrigineMobileCB.Checked;
  setBoutons;
  updateCourant;
end;

procedure TffmpegForm.OrigineTempsBtnClick(Sender: TObject);
begin
if OrigineTempsBtn.style=tbsCheck
   then if OrigineTempsBtn.down
        then begin
            ShowMessage(msgOrigineTemps);
            hint := hOrigineT;
            status.Panels[2].Text := hOrigineT;
            setCurseur(crOrigineTemps);
        end
        else if BorneSelect=bsMesure
              then begin
                 hint := hintBorne[bsMesure];
                 status.Panels[2].Text := hint;
                 setCurseur(crNone);
              end
              else begin
                 status.Panels[2].Text := '';
                 setCurseur(crDefault);
              end
   else begin
      correctionRS.tOrigine := trackBar.position*dureeImage;
      traceGrid;
      OrigineTempsBtn.down := false;
   end;
end;

procedure TffmpegForm.StopBtnClick(Sender: TObject);
begin
     timerPlayVideo.enabled := false;
     if borneSelect=bsPlay then borneSelect := bsNone;
     timerPlayImages.enabled := false;
     timerChrono.enabled := false;
     labelAttente.caption := '';
     trackBar.position := 0;
     stopBtn.enabled := true;
     suivantBtn.Enabled := true;
     precedentBtn.Enabled := true;
     rewindBtn.Enabled := true;
     borneSelect := bsNone;
     toolBarBoutons.Enabled := true;
end;

procedure TffmpegForm.CouleurPointsCBChange(Sender: TObject);
begin
   if pointCourant=0
      then couleur[1] := couleurPointsCB.selected
      else couleur[pointCourant] := couleurPointsCB.selected;
   updateCourant;
end;

procedure TffmpegForm.CouleurAxeCBChange(Sender: TObject);
begin
      updateCourant;
end;

procedure TffmpegForm.altitudeCBClick(Sender: TObject);
begin
      if altitudeCB.checked
         then SigneY := -1
         else SigneY := +1;
      traceGrid;
      e_pointRepere[bsAxeY].x := 2*e_pointRepere[bsOrigine].x-e_pointRepere[bsAxeY].x;
      e_pointRepere[bsAxeY].y := 2*e_pointRepere[bsOrigine].y-e_pointRepere[bsAxeY].y;
      ecranVersImage;
      updateCourant;
end;

procedure TffmpegForm.AxesClick(Sender: TObject);
var LsigneX,LsigneY : integer;
begin
   with (sender as TMenuItem) do checked := true;
   RazAxes.ImageIndex := (sender as TMenuItem).ImageIndex;
   altitudeCB.Checked := axeVersLeHautDroite.Checked or
                         axeVersLeBasGauche.Checked;
   if altitudeCB.checked
        then SigneY := -1
        else SigneY := +1;
   if axeVersLeHautDroite.Checked or
      axeVersLeBasDroite.Checked
         then begin
            angleX := 0;
            LsigneX := +1;
         end
         else begin
            angleX := 180;
            LsigneX := -1;
         end;
    if axeVersLeHautDroite.Checked or
       axeVersLeHautGauche.Checked
         then LsigneY := -1
         else LsigneY := -1;
   pointRepere[bsAxeX] := pointRepere[bsOrigine];
   pointRepere[bsAxeY] := pointRepere[bsOrigine];
   pointRepere[bsAxeX].Offset(LsigneX*largeur div 4,0);
   pointRepere[bsAxeY].Offset(0,LsigneY*largeur div 4);
   imageVersEcran;
   updateCourant;
end;

procedure TffmpegForm.RazAxesClick(Sender: TObject);
var P : Tpoint;
begin
    P.y := RazAxes.top+RazAxes.Height;
    P.x := RazAxes.left;
    P := ToolBarBoutons.ClientToScreen(P);
    EchelleMenu.Popup(P.x,P.y);
end;

procedure TffmpegForm.RazBtnClick(Sender: TObject);
var i,j : integer;
begin
     if MessageDlg(OkDelAllData,mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
         for i := 0 to nmes do
           for j := 0 to pred(grid.ColCount) do
               Grid.cells[j,i+1] := '';
         Nmes := 0;
         updateCourant;
         setBoutons;
     end;
end;

Procedure TffmpegForm.SetBorne(aBorne : TstyleDrag);
begin
    borneSelect := aBorne;
    case BorneSelect of
         bsEchelle1, bsEchelle2 : setCurseur(crSizeAll);
         bsOrigine : setCurseur(crSizeAll);
         bsAxeX, bsAxeY : setCurseur(crSizeAll);
         bsMesure : setCurseur(crNone);
         bsChronoInit : setCurseur(crNone);
         bsChrono : setCurseur(crDefault);
         bsNone : setCurseur(crDefault);
         bsPlay : setCurseur(crDefault);
    end;
    hint := hintBorne[aBorne];
    panelVideo.Hint := hint;
    imgPreview.Hint := hint;
end;

Function TffmpegForm.GetBorne(x,y : integer;deplace : boolean) : TstyleDrag;
var i : TstyleDrag;
    aPoint : TPointF;
    a,d : double;
begin
      result := bsNone;
      aPoint := PointF(x,y);
      for i in [bsOrigine,bsEchelle1,bsEchelle2,bsAxeX,bsAxeY] do
          if (e_PointRepere[i].distance(aPoint) < (Magnet*pasZoom))
              then begin
                   result := i;
                   break;
              end;
      case result of
         bsNone : begin
            setCurseur(crDefault);
            d := e_PointRepere[bsOrigine].distance(aPoint);
            if d<100 then exit;
            a := arcTan2(aPoint.y-e_PointRepere[bsOrigine].y,
                      aPoint.x-e_PointRepere[bsOrigine].x);
            if (abs(angleX-a)<0.02)
            then begin
                 if deplace then begin
                    e_PointRepere[bsAxeX] := aPoint;
                    ecranVersImage;
                 end;
                 result := bsAxeX;
                 setCurseur(crSizeAll);
            end
            else if (abs(angleX+signeY*pi/2-a)<0.02) then begin
               if deplace then begin
                  e_PointRepere[bsAxeY] := aPoint;
                  ecranVersImage;
               end;
               result := bsAxeY;
               setCurseur(crSizeAll);
            end;
         end;
         bsOrigine : setCurseur(crOrigine);
         bsEchelle1,bsEchelle2 : setCurseur(crSizeAll);
         bsAxeX,bsAxeY : setCurseur(crSizeAll);
         else setCurseur(crDefault);
      end;
end;

procedure TffmpegForm.VideRepertoire;
var info : TSearchRec;
begin
  try
    if findFirst(TPath.combine(tempDirReg,'*.bmp'),faAnyFile,Info)=0 then begin
      repeat
         if (Info.attr and faDirectory)<>faDirectory then
            deleteFile(Tpath.combine(tempDirReg,Info.Name));
      until FindNext(Info)<>0;
      FindClose(info);
    end;
    if (NomCopie<>'') and fileExists(nomCopie) then begin
       deleteFile(nomCopie);
       nomCopie := '';
    end;
    if (NomFichierChrono<>'') and
       fileExists(NomFichierChrono) and
       (extractFilePath(NomFichierChrono)=tempDirReg) then begin
         deleteFile(nomFichierChrono);
    end;
  except
     showMessage('Changer le répertoire temporaire : '+tempDirReg+' protégé ?');
  end;
end;

procedure TffmpegForm.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s : String;
begin
    TstringGrid(sender).canvas.Font.Color := CouleurGrid[ACol];
    S := TstringGrid(sender).cells[ACol,ARow];
    with TstringGrid(sender).canvas do
         TextOut(Rect.Left + 2, Rect.Top + 2,S);
end;

procedure TffmpegForm.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
   if OrigineTempsBtn.down then begin
       correctionRS.tOrigine := correctionRS.Temps[Arow-1];
       traceGrid;
       OrigineTempsBtn.down := false;
   end;
end;

Procedure TffmpegForm.DessineImage;
var imgCanvas : TCanvas;

Procedure TraceLigne(x1,y1,x2,y2 : single);
begin
    ImgCanvas.moveto(round(x1),round(y1));
    ImgCanvas.lineto(round(x2),round(y2));
end;

  Procedure TraceRepere(i : integer);
  var Apoint : TPointF;
  begin
  Apoint := correctionRS.XY[0,i];
  with Apoint do begin
         Imgcanvas.pen.Color := couleurAxeCB.selected;
         TraceLigne(x-4*Magnet,y,x+4*Magnet,y);  // axe X
// flèche X
         TraceLigne(x+4*Magnet,y,x+2*Magnet,y-magnet);
         TraceLigne(x+4*Magnet,y,x+2*Magnet,y+magnet);
         TraceLigne(x,y-4*Magnet,x,y+4*Magnet); // axe Y
// flèche Y
         TraceLigne(x,y+4*signeY*Magnet,x-magnet,y+2*signeY*Magnet);
         traceLigne(x,y+4*signeY*Magnet,x+magnet,y+2*signeY*Magnet);
  end end;

  Procedure TraceCroix(Apoint : TpointF);
  begin
      traceLigne(Apoint.x-Magnet+1,Apoint.y,Apoint.x+Magnet,Apoint.y);
      traceLigne(Apoint.x,Apoint.y-Magnet+1,Apoint.x,Apoint.y+Magnet);
  end;

  Procedure TraceOrigine;

  function rayonOptimal(angle : double;x0,y0 : single) : single;
  var rC,ro,rD : integer;

  function Cherchex(y1 : single) : integer;
  var x1 : single;
  begin
     try
     x1 := x0+(y1-y0)/tan(angle);
     if isInfinite(x1) or (x1<0) or (x1>largeur)
        then result := rD
        else result := round(sqrt(sqr(y0-y1)+sqr(x0-x1)));
     except
     result := rD;
     end;
  end;

  function Cherchey(x1 : single) : integer;
  var y1 : single;
  begin
     try
     y1 := y0+(x1-x0)*tan(angle);
     if isInfinite(y1) or (y1<0) or (y1>hauteur)
        then result := rD
        else result := round(sqrt(sqr(y0-y1)+sqr(x0-x1)));
     except
     result := rD;
     end;
  end;

begin
     if largeur<hauteur then rD := largeur else rD := hauteur;
     if angle<=0
        then ro := cherchex(0) // intersection y=0
        else ro := cherchex(hauteur); // intersection y = hauteur
     if abs(angle)>=pi/2
        then rC := cherchey(0)  // intersection x=0
        else rc := cherchey(largeur); // intersection x=largeur
     if rC<ro then ro := rC;
     result := ro;
end;// rayonOptimal

  procedure TraceFleche(angle : double);
  var
      PE: TPoint; // centre puis extrémité de la base de la flèche
      deltaX, deltaY: integer;
      Points:  array[0..2] of Tpoint; // Flèche
      hFleche,rayon : single;
  begin
       rayon := rayonOptimal(angle,PointRepere[bsOrigine].x,PointRepere[bsOrigine].y)*0.95;
       PE.x := round(PointRepere[bsOrigine].x);
       PE.y := round(PointRepere[bsOrigine].y);
       deltaY := round(rayon*sin(angle));
       deltaX := round(rayon*cos(angle));
       PE.offset(deltaX,deltaY);
       TraceLigne(PointRepere[bsOrigine].X,PointRepere[bsOrigine].Y,PE.X,PE.y);
       hFleche := hauteur div 16;
       deltaX := round(hFleche*cos(angle));
       deltaY := round(hFleche*sin(angle));
       Points[0] := PE;
       PE.offset(-deltaX,-deltaY); // base de la flèche
       deltaX := deltaX div 3;
       deltaY := deltaY div 3;
       PE.offset(-deltaY,+deltaX);
       Points[1] := PE;
       PE.offset(+2*deltaY,-2*deltaX);
       Points[2] := PE;
       ImgCanvas.Polygon(Points);
  end;

begin  // traceOrigine
         if borneSelect=bsOrigine then exit;
         Imgcanvas.pen.Color := couleurAxeCB.selected;
         angleX := arcTan2(PointRepere[bsAxeX].y-PointRepere[bsOrigine].y,
                           PointRepere[bsAxeX].x-PointRepere[bsOrigine].x);
// axe X
         if borneSelect=bsAxeX
         then TraceFleche(angleX)
         else begin
            TraceFleche(angleX);
            if EtiquetteCB.checked then
            ImgCanvas.TextOut(round(PointRepere[bsAxeX].X+magnet),
                              round(PointRepere[bsAxeX].Y),
                                      'X');
         end;
// axe Y
         if borneSelect=bsAxeY
         then TraceFleche(angleX+signeY*pi/2)
         else begin
            TraceFleche(angleX+signeY*pi/2);
            if EtiquetteCB.checked then
            ImgCanvas.TextOut(round(PointRepere[bsAxeY].X+magnet),
                              round(PointRepere[bsAxeY].Y),
                                      'Y');
         end;
end; // traceOrigine

  Procedure TraceEchelle;
  var angleLoc : integer;
      P1,P2 : TPointF;
  begin
      if borneSelect=bsEchelle1
         then begin
              P1 := PointRepere[bsEchelle2];
              P1.Offset((PointRepere[bsEchelle1].X-PointRepere[bsEchelle2].X)*0.9,
                        (PointRepere[bsEchelle1].Y-PointRepere[bsEchelle2].Y)*0.9);
         end
         else P1 := PointRepere[bsEchelle1];
      if bornESelect=bsEchelle2
         then begin
              P2 := PointRepere[bsEchelle1];
              P2.Offset((PointRepere[bsEchelle2].X-PointRepere[bsEchelle1].X)*0.9,
                        (PointRepere[bsEchelle2].Y-PointRepere[bsEchelle1].Y)*0.9);
         end
         else P2 := PointRepere[bsEchelle2];
      TraceLigne(P1.X,P1.Y,P2.X,P2.Y);
      if borneSelect<>bsEchelle1 then TraceCroix(PointRepere[bsEchelle1]);
      if borneSelect<>bsEchelle2 then TraceCroix(PointRepere[bsechelle2]);
      angleLoc := round(arcTan2(PointRepere[bsEchelle2].Y-PointRepere[bsEchelle1].Y,
                                PointRepere[bsEchelle1].X-PointRepere[bsEchelle2].X)*180/system.pi);
      if angleLoc>90 then angleLoc := angleLoc-180;
      if angleLoc<-90 then angleLoc := angleLoc+180;
      ImgCanvas.font.orientation := angleLoc*10;
      ImgCanvas.TextOut(round((PointRepere[bsEchelle1].X+PointRepere[bsEchelle2].X)/2),
                        round((PointRepere[bsEchelle1].Y+PointRepere[bsEchelle2].Y)/2),
                        echelleEDit.text+' m');
      ImgCanvas.font.orientation := 0;
  end;

var i,j : integer;
    texte : string;
begin // DessineImage
    if not (FPreview.active or FProbe.active) then exit;
    if timerPlayImages.Enabled then exit;
    calcEchelle;
    couleurAxeCB.Visible := traceEchCB.checked;
    couleurPointsCB.Visible := tracePointsCB.checked;
    imgCanvas := imgPreview.picture.bitmap.canvas;
    Imgcanvas.font.name := 'Courier New';
    Imgcanvas.font.color := couleur[0];
    ImgCanvas.pen.width := (screen.Width div 1024)+1;
    ImgCanvas.Brush.Style := bsClear; // Set the brush style to transparent.
    if traceEchCB.checked then begin
       ImgCanvas.pen.color := couleur[0];
       Imgcanvas.font.size := 12; // X, Y et échelle
       if OrigineMobileCB.checked
          then begin
              for i := 0 to pred(nmes) do TraceRepere(i);
              if PointCourant>0 then TraceRepere(nmes);
          end
          else TraceOrigine;
       TraceEchelle;
    end;
    if tracePointsCB.checked then begin
       Imgcanvas.font.size := 8; // numéro
       for j := 1 to NbreSE.value do begin
          Imgcanvas.pen.color := couleur[j];
          Imgcanvas.Font.Color := couleur[j];
          for i := 0 to pred(nmes) do begin
                 TraceCroix(correctionRS.XY[j,i]);
                 if EtiquetteCB.checked then begin
                    texte := intToStr(succ(i));
                    if NbreSE.value>1 then texte := intToStr(j)+'-'+texte;
                    Imgcanvas.TextOut(round(correctionRS.XY[j,i].x)+2,
                                      round(correctionRS.XY[j,i].y)+2,
                                                 texte);
                 end;
          end;// for j
       end; // for i
       for j := 1 to pred(PointCourant) do begin
           Imgcanvas.pen.color := couleur[j];
           TraceCroix(correctionRS.XY[j,nmes]);
           if etiquetteCB.checked then begin
              Imgcanvas.Font.Color := couleur[j];
              texte := intToStr(succ(nmes));
              if NbreSE.value>1 then texte := intToStr(j)+'-'+texte;
              Imgcanvas.TextOut(round(correctionRS.XY[j,nmes].x)+2,
                                round(correctionRS.XY[j,nmes].y)+2,
                                           texte);
           end;
       end; // for j
    end;
end; // DessineImage


procedure TffmpegForm.AffecteChrono;
var couleurC,LcouleurInit : TRGBtriple;
    scanLineC,scanLineInit : pRGBTripleArray;
    xPrec,yPrec : integer;
    xAttendu,yAttendu : integer;
    DeltaX,DeltaY : integer;
    x0,y0 : integer;
    RedCible, BlueCible, GreenCible : integer;
    ecartMin : integer;

procedure EnregistrePointChrono(p : integer);
// on affine autour de x0, y0
var xMin,xMax : integer;
    yMin,yMax : integer;
    xc,yc,x1,y1,x2,y2 : integer;
    ecartCible,ecart : integer;
    largeurCible,hauteurCible : integer;
    scanLineFin : pRGBTripleArray;
begin
{$IFDEF Debug}
    ecritDebug('début enregistrePointChrono');
{$ENDIF}
    largeurCible := largeur div 24; // zone de recherche
    hauteurCible := hauteur div 24;
    correctionRS.XY[p,Nmes].x := x0;
    correctionRS.XY[p,Nmes].y := y0;
    xMin := x0+hauteurCible;
    xMax := x0-hauteurCible;
    yMin := y0+largeurCible;
    yMax := y0-largeurCible;
    y1 := yMax;y2 := yMin;
    if y1<0 then y1 := 0;
    if y2>=hauteur then y2 := pred(hauteur);
    x1 := xMax;x2 := xMin;
    if x1<0 then x1 := 0;
    if x2>=largeur then x2 := pred(largeur);
    for yc := y1 to y2 do begin
        scanLineC := bitmapC.scanLine[yc];
        scanLineInit := bitmapInit.scanLine[yc];
        scanLineFin := bitmapFin.scanLine[yc];
        for xc := x1 to x2 do begin
            couleurC := scanLineC[xc];
            LcouleurInit := scanLineInit[xc];
            ecart := abs(integer(LcouleurInit.rgbtBlue)-integer(couleurC.rgbtBlue))+
                     abs(integer(LcouleurInit.rgbtGreen)-integer(couleurC.rgbtGreen))+
                     abs(integer(LcouleurInit.rgbtRed)-integer(couleurC.rgbtRed));
            ecartCible := abs(BlueCible-integer(couleurC.rgbtBlue))+
                          abs(GreenCible-integer(couleurC.rgbtGreen))+
                          abs(RedCible-integer(couleurC.rgbtRed));
            if ecartCible<resolutionCible then
                  scanLineFin[xc] := couleurC;
            if (ecart>resolutionCible) and (ecartCible<ecartMin) then begin
            // différent de l'état initial et proche couleur cible
               if xc<xMin then xMin := xc;
               if yc<yMin then yMin := yc;
               if xc>xMax then xMax := xc;
               if yc>yMax then yMax := yc;
            end;
        end;// for xc
    end;// for yc
    correctionRS.XY[p,Nmes].x := (xMin+xMax) div 2;
    correctionRS.XY[p,Nmes].y := (yMin+yMax) div 2;
    if (Nmes + 2) > grid.rowCount then grid.rowCount := Nmes + 5;
    Grid.cells[2*p-1,Nmes+1] := correctionRS.strX(p,Nmes);
    Grid.cells[2*p,Nmes+1] := correctionRS.strY(p,Nmes);
end; // EnregistrePointChrono

function chercheMobile : boolean;
var resolutionCible : integer;
    ecart,ecartCible : integer;
    xc,yc : integer;
    procheAttendu,prochePrec : boolean;
    LigneProcheAttendu,LigneProchePrec : boolean;
begin
{$IFDEF Debug}
    ecritDebug('début chercheMobile');
{$ENDIF}
resolutionCible := resolutionCibleMin;
repeat
    EcartMin := resolutionCible;
    for yc := 0 to pred(hauteur) do begin
        LigneProcheAttendu := abs(yc-yAttendu)<deltaY;
        LigneProchePrec := abs(yc-yPrec)<deltaY;
        if LigneProcheAttendu or LigneProchePrec then begin
           scanLineC := bitmapC.scanLine[yc];
           scanLineInit := bitmapInit.scanLine[yc];
           for xc := 0 to pred(largeur) do begin
              procheAttendu := (abs(xc-xAttendu)<deltaX) and ligneProcheAttendu;
              prochePrec := (abs(xc-xPrec)<deltaX) and ligneProchePrec;
              if (procheAttendu or prochePrec) then begin
                couleurC := scanLineC[xc];
                LcouleurInit := scanLineInit[xc];
                ecart := abs(integer(LcouleurInit.rgbtBlue)-integer(couleurC.rgbtBlue))+
                         abs(integer(LcouleurInit.rgbtGreen)-integer(couleurC.rgbtGreen))+
                         abs(integer(LcouleurInit.rgbtRed)-integer(couleurC.rgbtRed));
                if (ecart>resolutionCible)  then begin // On cherche là où il y eu changement
                    ecartCible := abs(BlueCible-integer(couleurC.rgbtBlue))+
                                  abs(GreenCible-integer(couleurC.rgbtGreen))+
                                  abs(RedCible-integer(couleurC.rgbtRed));
                    if ecartCible<ecartMin then begin // couleur=couleurCible
                       ecartMin := ecartCible;
                       x0 := xc;y0 := yc;
                    end;
                end;
              end;
           end; // i
        end; // ligne proche
    end; // j
    result := (x0>0) and (y0>0);
    inc(resolutionCible,pasCouleur);
until result or (resolutionCible>resolutionCibleMax);
{$IFDEF Debug}
    ecritDebug('sortie cherchemobile: trouve = '+stOuiNon[result]);
{$ENDIF}
end; // chercheMobile

function chercheFixe : boolean;
var ecartCible : integer;
    xc,yc : integer;
    resolutionCible : integer;
begin
{$IFDEF Debug}
    ecritDebug('début chercheFixe');
{$ENDIF}
    resolutionCible := resolutionCibleMin;
    repeat
       EcartMin := resolutionCible;
       for yc := 0 to pred(hauteur) do
          if abs(yc-yPrec)<deltaY then begin
            scanLineC := bitmapC.scanLine[yc];
            for xc := 0 to pred(largeur) do begin
              if abs(xc-xPrec)<deltaX then begin
                couleurC := scanLineC[xc];
                ecartCible := abs(BlueCible-integer(couleurC.rgbtBlue))+
                              abs(GreenCible-integer(couleurC.rgbtGreen))+
                              abs(RedCible-integer(couleurC.rgbtRed));
                if ecartCible<ecartMin then begin // couleur=couleurCible
                   ecartMin := ecartCible;
                   x0 := xc;y0 := yc;
                end;
              end;// proche
          end;// for xc
       end;// for yc
       result := (x0>0) and (y0>0);
       inc(resolutionCible,pasCouleur);
    until result or (resolutionCible>resolutionCibleMax);
{$IFDEF Debug}
    ecritDebug('sortie chercheFixe : trouve = '+stOuiNon[result]);
{$ENDIF}
end;

var trouve,trouveGlb : boolean;
    p,p0 : integer;
begin // AffecteChrono
{$IFDEF Debug}
    ecritDebug('affecteChrono ; point = '+IntToStr(nmes));
{$ENDIF}
    timerChrono.Enabled := false;
    DeltaX := largeur div 10; // zone de recherche
    DeltaY := hauteur div 10;
    trouveGlb := false;
    if origineMobileCB.Checked then p0 := 0 else p0 := 1;
    for p := p0 to NbreSE.value do begin
       blueCible := blueCibleChrono[p];
       redCible := redCibleChrono[p];
       greenCible := greenCibleChrono[p];
       x0 := 0;
       y0 := 0;
       xPrec := round(correctionRS.XY[p,pred(nmes)].x);
       yPrec := round(correctionRS.XY[p,pred(nmes)].y);
       if nmes>1 then begin // Nouvelle position en supposant la vitesse constante
          yAttendu := round(2*yPrec-correctionRS.XY[p,nmes-2].y);
          xAttendu := round(2*xPrec-correctionRS.XY[p,nmes-2].x);
       end
       else begin
          yAttendu := yPrec;
          xAttendu := xPrec;
       end;
       trouve := chercheMobile;
       if not trouve then trouve := chercheFixe;
       if trouve then begin
          inc(ecartMin,pasCouleur);
          enregistrePointChrono(p);
          trouveGlb := true;
       end;
    end;
    if trouveGlb then begin
       correctionRS.Temps[Nmes] := trackBar.position*dureeImage;
       Grid.cells[0,Nmes+1] := correctionRS.strT(Nmes);
       inc(Nmes);
    end;
    if (trackBar.position>=trackBar.selEnd) or not trouveGlb
          then begin
             VideoChronoForm.image1.picture.assign(bitmapFin);
             saveChronoPhoto;
          end
          else timerChrono.Enabled := true;
end; // AffecteChrono

procedure TffmpegForm.ChronoPhotoBtnClick(Sender: TObject);
begin
if ChronoPhotoBtn.Down
    then begin
       saveDialog.filter := 'bitmap|*.bmp';
       saveDialog.defaultExt := 'BMP';
       if saveDialog.Execute
          then begin
            nomFichierChrono := saveDialog.FileName;
            lanceChrono;
          end
          else ChronoPhotoBtn.Down := false
    end // début chrono
    else begin
        if (borneSelect=bsChrono) and (trackBar.position>(trackbar.SelStart+10))
            then saveChronoPhoto
            else setBorne(bsNone);
    end; // fin chrono
end;

procedure TffmpegForm.SaveChronoPhoto;
begin
       TimerChrono.enabled := false;
       setBorne(bsNone);
       mesureBtn.Down := false;
       bitmapFin.saveToFile(nomFichierChrono);
       bitmapFin.free;
       bitmapInit.free;
       DessineImage;
       if chronoPhotoBtn.Down then begin
           chronoPhotoBtn.Down := false;
           if VideoChronoForm=nil then
              Application.createForm(TVideoChronoForm,VideoChronoForm);
           VideoChronoForm.image1.picture.loadFromFile(NomFichierChrono);
           VideoChronoForm.dtStr := DeltaMin+'t='+formatCourt(dureeImage)+'s';
           VideoChronoForm.nomFichierBmp := NomFichierChrono;
           if not VideoChronoForm.visible then VideoChronoForm.show;
       end;
       setBoutons;
       TimerChrono.enabled := false;
end;

procedure TffmpegForm.CaptureBtnClick(Sender: TObject);
begin
     if videoForm=nil then Application.CreateForm(TvideoForm,videoForm);
     videoForm.Show;
end;


procedure TffmpegForm.ChronoInit;

procedure InitMesure;
var
    xc,yc : integer;
    Lcouleur : TRGBtriple;
    scanLine : pRGBTripleArray;
    xCible,yCible : integer;
    RedCible, BlueCible, GreenCible : integer;
begin
{$IFDEF Debug}
         ecritDebug('début initmesure');
{$ENDIF}
     correctionRS.Temps[0] := trackBar.Position*dureeImage;
     correctionRS.XY[pointCourant,0] := pointRepere[bsChronoInit];
     Grid.cells[pointCourant*2-1,1] := correctionRS.strX(pointCourant,0);
     Grid.cells[pointCourant*2,1] := correctionRS.strY(pointCourant,0);
     xCible := round(pointRepere[bsChronoInit].x);
     if xcible<1 then xcible := 1;
     if xcible>(largeur-2) then xcible := largeur-2;
     yCible := round(pointRepere[bsChronoInit].y);
     if ycible<1 then ycible := 1;
     if ycible>(hauteur-2) then ycible := hauteur-2;
     RedCible := 0;
     BlueCible := 0;
     GreenCible := 0;
     for yc := yCible-1 to yCible+1 do begin
         scanLine := BitmapC.scanLine[yc];
         for xc := xCible-1 to xCible+1 do begin
            Lcouleur := scanLine[xc];
            RedCible := RedCible+integer(Lcouleur.rgbtRed);
            BlueCible := BlueCible+integer(Lcouleur.rgbtBlue);
            GreenCible := GreenCible+integer(Lcouleur.rgbtGreen);
         end;
     end;
     RedCibleChrono[pointCourant] := RedCible div 9;
     BlueCibleChrono[pointCourant] := BlueCible div 9;
     GreenCibleChrono[pointCourant] := GreenCible div 9;
{$IFDEF Debug}
         ecritDebug('couleurs : '+intToStr(redcible)+' '+intToStr(bluecible)+' '+intToStr(greencible));
{$ENDIF}
     cibleLabel.Visible := false;
     setBoutons;
end;

var P : TPoint;
begin
     initMesure;
     if pointCourant=NbreSE.value
        then begin
           setBorne(bsChrono);
           imgPreview.hint := hChronoEnCours;
           panelVideo.Hint := hChronoEnCours;
           Nmes := 1;
           calcEchelle;
{$IFDEF Debug}
         ecritDebug('timerChrono enabled');
{$ENDIF}
           timerChrono.enabled := true;
           stopBtn.Enabled := true;
        end
        else begin
           inc(pointCourant);
           P := TPoint.create(largeurAff div 4,hauteurAff div 3);
           P := ImgPreview.ClientToScreen(P);
           if pointCourant=1 then cibleLabel.Caption := trCibleAuto;
           if pointCourant=2 then cibleLabel.Caption := trCible2Auto;
           cibleLabel.Visible := true;
           cibleLabel.left := P.x;
           cibleLabel.top := P.y;
        end;
end; //ChronoInit

procedure TffmpegForm.ConvertitXY(Sender: TObject;var X, Y: Integer);
var PointImage,PointLoupe : TPoint;
begin
    if (sender=LoupeForm.paintBox) then begin
       PointImage := imgPreview.ClientToScreen(Point(0,0));
       PointLoupe := LoupeForm.ClientToScreen(Point(0,0));
       x := x+pointLoupe.X-PointImage.X;
       y := y+pointLoupe.Y-PointImage.Y;
    end;
end;

procedure TffmpegForm.ConvertitCibleXY(Sender: TObject;var X, Y: Integer);
var PointImage,PointLoupe : TPoint;
begin
    if (sender=LoupeForm.paintBox) then begin
       PointImage := imgPreview.ClientToScreen(Point(0,0));
       PointLoupe := LoupeForm.ClientToScreen(Point(0,0));
       x := demiHauteurLoupe+pointLoupe.X-PointImage.X;
       y := demiHauteurLoupe+pointLoupe.Y-PointImage.Y;
    end;
end;

procedure TffmpegForm.CacheLoupe;
begin
     if loupeForm.visible then begin
        loupeForm.hide;
        setFocus;
     end;
end;

procedure TffmpegForm.UpdatePreview(index : integer);
var nomImage : string;
    c,cc : TColor;
begin
   if not(FPreview.active or FProbe.active) then exit;
   case methode of
        mPreview : begin
            FPreview.TimeStamp := index*dureeImage;
            imgPreview.Picture.Assign(FPreview.Bitmap);
            if hauteur=0 then begin
               largeur := Fpreview.bitmap.Width;
               hauteur := Fpreview.bitmap.Height;
               effectuerZoom(true);
            end;
        end;
        mProbe : imgPreview.Picture.Assign(FProbe.Bitmap);
   end;
   if index=0 then begin
      c := GetCouleurFond(imgPreview.picture.bitmap);
      cc := CouleurComplementaire(c);
      couleurAxeCB.selected := cc;
      couleur[0] := cc;
   end;
   trackBar.Tag := 1;
   trackBar.Position := index;
   trackBar.Tag := 0;
   nomImage := getNomImage(index);
   case methode of
        mPreview : FPreview.Bitmap.SaveToFile(nomImage);
        mProbe : Fprobe.Bitmap.SaveToFile(nomImage);
   end;
   imageCourante := nomImage;
   labelAttente.caption := ' Création de l''image '+intToStr(index)+'/'+intToStr(trackBar.max)+' ';
   if borneSelect in [bsChrono,bsChronoInit] then begin
        bitmapC.Canvas.CopyMode := cmSrcCopy;
        case methode of
            mPreview : bitmapC.Canvas.Draw(0,0,FPreview.bitmap);
            mProbe : bitmapC.Canvas.Draw(0,0,FProbe.bitmap);
        end;
   end;
   case borneSelect of
      bsChrono : AffecteChrono;
      bsChronoInit : ;
      bsPlay : ;
      else dessineImage;
   end;
end; //updatePreview

    procedure TffmpegForm.EcranVersImage;
    var i : TstyleDrag;
    begin
       for i := low(TstyleDrag) to High(TstyleDrag) do begin
           pointRepere[i].x := e_pointRepere[i].x/pasZoom;
           pointRepere[i].y := e_pointRepere[i].y/pasZoom;
       end;
    end;

    procedure TffmpegForm.Image2Click(Sender: TObject);
    begin
       if nomOriginal = '' then exit;
       if OKReg('Problème de lecture ? On essaie l''autre méthode ?',Help_video) then begin
          if MethodeRG.itemIndex=0
            then MethodeRG.itemIndex := 1
            else MethodeRG.itemIndex := 0;
           ouvreFichier(nomOriginal);
       end;
    end;

procedure TffmpegForm.ImageVersEcran;
    var i : TstyleDrag;
    begin
       for i := low(TstyleDrag) to High(TstyleDrag) do
           e_pointRepere[i] := pointRepere[i]*pasZoom;
    end;

procedure TffmpegForm.CorrigeAxes;
var angleLoc : double;
    longueur : integer;
begin  // AngleLoc est l'angle informatique Y vers le bas donc positif=sens horaire
      if borneSelect=bsAxeX then begin // rendre les axes perpendiculaires
           angleLoc := arcTan2(e_pointRepere[bsAxeX].y-e_pointRepere[bsOrigine].y,
                               e_pointRepere[bsAxeX].x-e_pointRepere[bsOrigine].x);
           angleLoc := angleLoc+signeY*pi/2;
           longueur := round(e_pointRepere[bsAxeY].Distance(e_pointRepere[bsOrigine]));
           e_pointRepere[bsAxeY].x := e_pointRepere[bsOrigine].x+round(longueur*cos(angleLoc));
           e_pointRepere[bsAxeY].y := e_pointRepere[bsOrigine].y+round(longueur*sin(angleLoc));
      end;
      if borneSelect=bsAxeY then begin // rendre les axes perpendiculaires
           angleLoc := arcTan2(signeY*(-e_pointRepere[bsAxeY].x+e_pointRepere[bsOrigine].x),
                               signeY*(e_pointRepere[bsAxeY].y-e_pointRepere[bsOrigine].y));
           longueur := round(e_pointRepere[bsAxeX].Distance(e_pointRepere[bsOrigine]));
           e_pointRepere[bsAxeX].x := e_pointRepere[bsOrigine].x+round(longueur*cos(angleLoc));
           e_pointRepere[bsAxeX].y := e_pointRepere[bsOrigine].y+round(longueur*sin(angleLoc));
      end;
      if borneSelect=bsOrigine then begin // ne pas changer l'angle
           longueur := round(e_pointRepere[bsAxeX].Distance(e_pointRepere[bsOrigine]));
           e_pointRepere[bsAxeX].x := e_pointRepere[bsOrigine].x+round(longueur*cos(angleX));
           e_pointRepere[bsAxeX].y := e_pointRepere[bsOrigine].y+round(longueur*sin(angleX));
           longueur := round(e_pointRepere[bsAxeY].Distance(e_pointRepere[bsOrigine]));
           e_pointRepere[bsAxeY].x := e_pointRepere[bsOrigine].x-signeY*round(longueur*sin(angleX));
           e_pointRepere[bsAxeY].y := e_pointRepere[bsOrigine].y+signeY*round(longueur*cos(angleX));
      end;
      razAxes.Enabled := true;//angleX<>0;
end; // CorrigeAxes

function TffmpegForm.getNomImage(index : integer) : string;
var numero : string;
begin
     result := '';
     if (index<TrackBar.Min) or (index>TrackBar.max) then exit;
     numero := intToStr(index);
     while length(numero)<3 do
           numero := '0'+numero;
     result := Tpath.combine(tempDirReg,'test'+numero+'.bmp');
end;

procedure TffmpegForm.updateImage(const nomImage : string);
var bitmapLoad : Tbitmap;
begin
    if not (FPreview.Active or FProbe.active) then exit;
    bitmapLoad := Tbitmap.create;
    bitmapLoad.loadFromFile(nomImage);
    if rotation<>0 then rotateBitmap2(bitmapLoad,rotation);
    if (ZoomBmp>1)
      then vCl.GraphUtil.scaleImage(bitmapLoad,bitmapC,zoomBmp,pf24bit)
      else bitmapC.Assign(bitmapLoad);
    imgPreview.Picture.Assign(bitmapC);
    case borneSelect of
       bsChrono : AffecteChrono;
       bsChronoInit :;
       bsPlay : ;
       else dessineImage;
    end;
    imageCourante := nomImage;
    zoomEffectue := true;
    bitmapLoad.free;
end; // updateImage

procedure TffmpegForm.updateCourant;
begin
      if not (FPreview.Active or FProbe.active) then exit;
      if imageCourante=''
         then updatePreview(trackBar.Position)
         else if not zoomEffectue
             then updateImage(imageCourante)
             else begin
               imgPreview.Picture.Assign(bitmapC);
               case borneSelect of
                  bsChrono : AffecteChrono;
                  bsChronoInit : ;
                  bsPlay : ;
                  else dessineImage;
                end;
             end;
end;

procedure TffmpegForm.lanceChrono;
var P : TPoint;
    i,j : integer;
begin
{$IFDEF Debug}
         ecritDebug('début lancechrono');
{$ENDIF}
         setBorne(bsChronoInit);
         calcEchelle;
         correctionRS.RSvalue := RollingShutterSE.value;
         correctionRS.NPoints := NbreSE.value;
         correctionRS.hauteur := hauteur;
         correctionRS.angleX := angleX;
         correctionRS.signeY := signeY;
         correctionRS.incertXY := IncertitudeSE.value;
         TrackBarChange(nil);
         if trackBar.SelStart>0 then trackbar.Position := trackBar.SelStart;
         if (NbreSE.value>2) then begin
             showMessage('Un ou deux mobiles');
             NbreSE.value := 2;
         end;
         Nmes := 0;
         P := TPoint.create(largeurAff div 4,hauteurAff div 3);
         P := ImgPreview.ClientToScreen(P);
         if origineMobileCB.checked
            then begin
               pointCourant := 0;
               cibleLabel.caption := trOrigineAuto;
               cibleLabel.Left := P.X;
               cibleLabel.Top := P.Y;
               cibleLabel.visible := true;
            end
            else begin
               pointCourant := 1;
               cibleLabel.caption := trCibleAuto;
               cibleLabel.Left := P.X;
               cibleLabel.Top := P.Y;
               cibleLabel.visible := true;
            end;
         bitmapInit := Tbitmap.create;
         bitmapFin := Tbitmap.create;
         bitmapInit.assign(bitmapC);
         bitmapFin.assign(bitmapC);
         if VideoChronoForm=nil then begin
             Application.createForm(TVideoChronoForm,VideoChronoForm);
{$IFDEF Debug}
         ecritDebug('création videoChronoform');
{$ENDIF}
         end;
         VideoChronoForm.image1.picture.assign(bitmapInit);
         MesureBtn.Hint := hStopMes;
         MesureBtn.imageIndex := 1;
         MesureBtn.Caption := stStop;
         Grid.ColCount := NbreSE.value*2+1;
         Grid.cells[1,0] := 'x(m)';
         Grid.cells[2,0] := 'y(m)';
         for i := 1 to pred(Grid.rowCount) do
             for j := 0 to pred(grid.colCount) do
                 Grid.cells[j,i] := '';
end; // lanceChrono

procedure TffmpegForm.EffectuerZoom;
var zoomX,zoomY : single;
begin
    zoomBmp := 1;
    if init and (abs(rotation)=1) then swap(largeur,hauteur);
    zoomX := (PanelVideo.Width - 4)/ largeur;
    zoomY := (PanelVideo.Height - trackBar.height - 4)/ hauteur;
    if zoomX>zoomY then pasZoom := zoomY else pasZoom := zoomX;
    if pasZoom>1
    then begin
        ZoomBmp := pasZoom;
        hauteur := round(hauteur*pasZoom);
        largeur := round(largeur*pasZoom);
        hauteurAff := hauteur;
        largeurAff := largeur;
        pasZoom := 1;
    end
    else begin
        zoomBmp := 1;
        hauteurAff := round(hauteur*pasZoom);
        largeurAff := round(largeur*pasZoom);
    end;
    ImgPreview.Height := hauteurAff;
    ImgPreview.Width := largeurAff;
    if init then begin
          PointRepere[bsOrigine] := pointF(Largeur/2,Hauteur/2);
          PointRepere[bsEchelle1] := pointF(Largeur/4,3*Hauteur/4);
          PointRepere[bsEchelle2] := pointF(3*Largeur/4,3*Hauteur/4);
          PointRepere[bsAxeX] :=  PointRepere[bsOrigine];
          PointRepere[bsAxeX].Offset(Hauteur/4,0);
          PointRepere[bsAxeY] := PointRepere[bsOrigine];
          PointRepere[bsAxeY].Offset(0,signeY*Hauteur/4);
          magnet := Largeur div 100;
    end;
    imageVersEcran;
end;

procedure TffmpegForm.FormShowHint(Sender: TObject);
var FilePart : string;
begin
   if Application.Hint=''
      then begin
          Caption := Captionffmpeg;
          if NomFichier<>'' then begin
             try
             FilePart := ExtractFileName(nomFichier);
             Caption := caption+' ['+FilePart+']';
             except
             end;
          end;
      end
      else Caption := Application.Hint
end;

initialization
   FFMPEG_DLL_PATH := ExtractFilePath(application.exeName)+'Win32\';
finalization
   UnloadLibs;

end.

