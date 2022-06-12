unit capturePS;
// d'après Paulo Santos

interface

uses   
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, ComCtrls, system.IOutils,
  Vcl.Buttons, ToolWin, System.Generics.Collections,
  DXSUtil, DSPack, DirectShow9,
  avProbe, avCodec, AVConverter, avProfile,
  constreg;

type
  TcapturePsForm = class(TForm)
    CaptureGraph: TFilterGraph;
    VideoWindow: TVideoWindow;
    Filter: TFilter;
    SampleGrabber: TSampleGrabber;
    StatusBar: TStatusBar;
    Label5: TLabel;
    StartStopButton: TButton;
    VitesseRG: TRadioGroup;
    DureeGB: TGroupBox;
    TmaxCB: TCheckBox;
    TimerStop: TTimer;
    WebcamList: TComboBox;
    PreviewTB: TTrackBar;
    ImgPreview: TImage;
    ProgressBar: TProgressBar;
    profileList: TAVProfileList;
    pfMKV: TAVCustomVideoProfile;
    Panel2: TPanel;
    TimeTB: TTrackBar;
    AVConverter: TAVConverter;
    VideoFormatsCB: TComboBox;
    DebutBtn: TSpeedButton;
    ConvertBtn: TButton;
    FinBtn: TSpeedButton;
    ReglagesBtn: TButton;
    VisuPC: TPageControl;
    PreviewTS: TTabSheet;
    TraitementTS: TTabSheet;
    AVCustomVideoProfile1: TAVCustomVideoProfile;
    ChercheBtn: TButton;
    PreviewBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartStopButtonClick(Sender: TObject);
    procedure TimerStopTimer(Sender: TObject);
    procedure TimeTBChange(Sender: TObject);
    procedure TmaxCBClick(Sender: TObject);
    procedure PreviewTBChange(Sender: TObject);
    procedure DebutBtnClick(Sender: TObject);
    procedure FinBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConvertBtnClick(Sender: TObject);
    procedure AVConverterComplete(Sender: TObject);
    procedure AVConverterProgress(Sender: TObject);
    procedure WebcamListChange(Sender: TObject);
    procedure ReglagesBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChercheBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
  private
    FProbe : TAVProbe;
    nomFichierTraitement,nomFichierCapture : string;
    VideoMediaTypes : TEnumMediaType;
    dureeImageInt : int64;
    indexFormat : TList<Integer>;
    positionZero: int64;
    procedure SelectCamera;
    procedure updatePreview;
    procedure videRepertoire;
    procedure capturer;
    procedure arreter;
    procedure setPreview(actif : boolean);
  public
  end;

var
  capturePsForm: TcapturePsForm;

implementation

{$R *.dfm}

uses regutil, math, Videoffmpeg;

const stStop = 'Stop';

procedure TcapturePsForm.FormDestroy(Sender: TObject);
begin
    FProbe.free;
    VideoMediaTypes.Free;
    indexFormat.Free;
    videRepertoire;
end;

procedure TcapturePsForm.FormShow(Sender: TObject);
begin
     selectCamera;
end;

procedure TcapturePsForm.setPreview(actif : boolean);
begin
    if actif
       then VisuPC.activePage := PreviewTS
       else VisuPC.activePage := TraitementTS;
    PreviewTB.Enabled := not actif;
    convertBtn.Enabled := not actif;
    PreviewBtn.Enabled := not actif;
    StartStopButton.Enabled := actif;
end;

procedure TcapturePsForm.FormCreate(Sender: TObject);
var i: integer;
    CapEnum: TSysDevEnum;
begin
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  VideoMediaTypes := TEnumMediaType.Create;
  if CapEnum.CountFilters=0
     then showMessage('Aucun webcam branchée')
     else for i := 0 to CapEnum.CountFilters - 1 do
          webcamList.items.Add(CapEnum.Filters[i].FriendlyName);
  capEnum.Free;
  nomFichierTraitement := TPath.Combine(tempDirReg,'regressi.avi');
  nomFichierCapture := TPath.Combine(TempDirReg,'capture.avi');
  FProbe := TAVProbe.Create;
  FProbe.active := false;
  indexFormat := TList<Integer>.create;
  dureeGB.Caption := trTempsLim;
  ResizeButtonImagesforHighDPI(self);
end;

procedure TcapturePsForm.selectCamera;
var i,j: integer;
    PinList: TPinList;
    chaine,chainePrec : string;
    CapEnum: TSysDevEnum;
begin
  CaptureGraph.Stop;
  CaptureGraph.Active := false;
  StartStopButton.Enabled := false;
  VideoFormatsCB.enabled := false;
  if (webcamList.Items.Count<=0) then exit;
  if (webcamList.ItemIndex<0) then webcamList.ItemIndex := 0;
  if (webcamList.ItemIndex>=webcamList.Items.Count) then webcamList.ItemIndex := 0;
  try
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  Filter.BaseFilter.Moniker := CapEnum.GetMoniker(WebcamList.ItemIndex);
  capEnum.Free;
  CaptureGraph.Active := true;
  PinList := TPinList.Create(Filter as IBaseFilter);
  VideoFormatsCB.Clear;
  VideoMediaTypes.Assign(PinList.First);
  PinList.Free;
  indexFormat.Clear;
  chainePrec := '';
  for i := 0 to VideoMediaTypes.Count - 1 do begin
      chaine := VideoMediaTypes.MediaDescription[i];
      // Format: VideoInfo YUY2 640X480, 16 bits
      j := pos('Format',chaine);
      if j>0 then begin
         chaine := copy(chaine,j+8,length(chaine));
         j := pos('X',chaine);
         if j=0 then j := pos('x',chaine);
         if j>0 then begin
            repeat
               dec(j)
            until not charInSet(chaine[j],['0'..'9']) or (j=1);
            chaine := copy(chaine,j+1,length(chaine));
         end;
      end;
      if chaine<>chainePrec then begin
         VideoFormatsCB.Items.Add(chaine);
         indexFormat.Add(i);
         chainePrec := chaine;
      end;
  end;
  if VideoFormatsCB.Items.Count>0 then begin
     VideoFormatsCB.enabled := true;
     VideoFormatsCB.itemIndex := 0;
  end;
  with CaptureGraph as IcaptureGraphBuilder2 do
       RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter as IBaseFilter,
          SampleGrabber as IBaseFilter, VideoWindow as IBaseFilter);
  setPreview(true);
  CaptureGraph.Play;
  StartStopButton.Enabled := true;
  StartStopButton.caption := 'Capturer';
  except
  end;
end;

procedure TcapturePsForm.WebcamListChange(Sender: TObject);
begin
   selectCamera;
end;

procedure TcapturePsForm.PreviewBtnClick(Sender: TObject);
begin
    selectCamera;
end;

procedure TcapturePsForm.PreviewTBChange(Sender: TObject);
begin
   if (PreviewTB.Tag=0) and FProbe.Active then begin
      FProbe.TimeStamp := PreviewTB.Position*dureeImageInt;
      UpdatePreview;
   end;
end;

procedure TcapturePsForm.AVConverterComplete(Sender: TObject);
begin
     ProgressBar.Position := 100;
     if ffmpegForm=nil then
        Application.CreateForm(TffmpegForm,ffmpegForm);
     ffmpegForm.Show;
     ffmpegForm.SetFocus;
     ffmpegForm.ouvreFichier(nomFichierTraitement);
     setPreview(true);
     close;
end;

procedure TcapturePsForm.AVConverterProgress(Sender: TObject);
begin
     ProgressBar.Position := AVConverter.Progress;
end;

procedure TcapturePsForm.ReglagesBtnClick(Sender: TObject);
begin
     ShowFilterPropertyPage(Self.Handle,Filter as IBaseFilter, ppDefault);
end;

procedure TcapturePsForm.ChercheBtnClick(Sender: TObject);
var i : integer;
    CapEnum: TSysDevEnum;
begin
  CapEnum := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  VideoMediaTypes := TEnumMediaType.Create;
  if CapEnum.CountFilters=0
     then showMessage('Aucun webcam branchée')
     else for i := 0 to CapEnum.CountFilters - 1 do
          webcamList.items.Add(CapEnum.Filters[i].FriendlyName);
  capEnum.Free;
  selectCamera;
end;

procedure TcapturePsForm.ConvertBtnClick(Sender: TObject);
begin with AVConverter do begin
  InputFiles.Text := nomFichiercapture;
  if profileList.profileCount>0
     then begin
       profileList.Profiles[0].ApplyProfile(AVConverter);
       nomFichierTraitement := ChangeFileExt(nomFichierTraitement, profileList.Profiles[0].Extension);
     end
     else nomFichierTraitement := ChangeFileExt(nomFichierTraitement, '.AVI');
  if fileExists(NomFichierTraitement) then deleteFile(nomFichierTraitement);
  ConvertOptions.StartTime := PreviewTB.selStart*dureeImageInt;
  ConvertOptions.RecordingTime := (PreviewTB.selEnd - PreviewTB.selStart)*dureeImageInt;
  ProgressBar.Position := 0;
  OutputFiles.Text := nomFichierTraitement;
  Convert;
end end;

procedure TcapturePsForm.videRepertoire;
var nomFic : string;
begin
     nomFic := ChangeFileExt(nomFichierCapture,'.MPG');
     if fileExists(NomFic) then deleteFile(nomFic);
     nomFic := ChangeFileExt(nomFichierCapture,'.AVI');
     if fileExists(NomFic) then deleteFile(nomFic);
     nomFic := ChangeFileExt(nomFichierTraitement,'.MPG');
     if fileExists(NomFic) then deleteFile(nomFic);
     nomFic := ChangeFileExt(nomFichierTraitement,'.AVI');
     if fileExists(NomFichierTraitement) then deleteFile(nomFic);
end;

procedure TcapturePsForm.DebutBtnClick(Sender: TObject);
begin
  PreviewTB.SelStart := PreviewTB.position
end;

procedure TcapturePsForm.FinBtnClick(Sender: TObject);
begin
  PreviewTB.SelEnd := PreviewTB.position
end;

procedure TcapturePsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CaptureGraph.Stop;
  CaptureGraph.ClearGraph;
  CaptureGraph.Active := false;
  FProbe.Active := false;
end;

procedure TcapturePsForm.StartStopButtonClick(Sender: TObject);
begin
    if StartStopButton.caption=stStop then arreter else capturer;
end;

procedure TcapturePsForm.Capturer;
var
  multiplexer: IBaseFilter;
  Writer: IFileSinkFilter;
  PinList: TPinList;
begin
    CaptureGraph.Stop;
    CaptureGraph.Active := false;
    CaptureGraph.Active := true;
    FProbe.active := false;
    FProbe.fileName := '';
    positionZero := 0;
    // configure output Video media type
    PinList := TPinList.Create(Filter as IBaseFilter);
    if VideoFormatsCB.ItemIndex <> -1 then
       with (PinList.First as IAMStreamConfig) do
           SetFormat(VideoMediaTypes.Items[indexFormat[VideoFormatsCB.ItemIndex]].AMMediaType^);
    PinList.Free;
    with CaptureGraph as IcaptureGraphBuilder2 do begin
       SetOutputFileName(MEDIASUBTYPE_Avi, PWideChar(nomFichierCapture), multiplexer, Writer);
    (*
       if Filter.BaseFilter.DataLength > 0 then // Connect Video preview (VideoWindow)
          RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter as IBaseFilter,
          nil , VideoWindow as IBaseFilter);
    *) // non actif pour gagner en vitesse ?
    // Connect Video capture streams
       RenderStream(@PIN_CATEGORY_CAPTURE, nil, Filter as IBaseFilter,
          nil, multiplexer as IBaseFilter);
    end;
    CaptureGraph.Play;
    ProgressBar.position := 0;
    ProgressBar.max := timeTB.position*2+1; // timer à 0.5s et marge
    ProgressBar.Visible := tmaxCB.Checked;
    TimerStop.Enabled := true;
    StartStopButton.Enabled := true;
    StartStopButton.caption := stStop;
end;

procedure TcapturePsForm.Arreter;
begin
    timerStop.Enabled := false;
    StartStopButton.caption := 'Capturer';
    ProgressBar.position := ProgressBar.max;
    StatusBar.SimpleText := 'Fin de la capture, enregistrement du fichier';
    CaptureGraph.Stop;
    FProbe.active := false;
    FProbe.fileName := '';
    PreviewTB.Tag := 1;
    PreviewTB.SelStart := 0;
    PreviewTB.Position := 0;
    if fileExists(nomFichierCapture) then begin
       FProbe.fileName := nomFichierCapture;
       FProbe.active := true;
       dureeImageInt := round(AV_TIME_BASE/FProbe.videoframeRate);
       PreviewTB.Max := round(FProbe.Duration*FProbe.videoFrameRate);
       updatePreview;
       setPreview(false);
    end
    else setPreview(true);
    PreviewTB.SelEnd := PreviewTB.Max;
    PreviewTB.Tag := 0;
end;

procedure TcapturePsForm.TimerStopTimer(Sender: TObject);
var
  position: int64;
  Hour, Min, Sec, MSec: Word;
const MiliSecInOneDay = 86400000;
begin
    if CaptureGraph.Active then begin
       with CaptureGraph as IMediaSeeking do
            GetCurrentPosition(position);
       if positionZero=0
          then positionZero := position
          else position := position-positionZero;
       DecodeTime(position div 10000 / MiliSecInOneDay, Hour, Min, Sec, MSec);
       StatusBar.SimpleText := Format('Capture de la vidéo... %d:%d:%d',[Min, Sec, MSec]);
       if ProgressBar.visible then begin
          ProgressBar.position := sec*2;
          if ProgressBar.position>=ProgressBar.max then arreter
       end
       else begin
          if min>0 then arreter
       end;
    end;
end;

procedure TcapturePsForm.TimeTBChange(Sender: TObject);
begin
   dureeGB.Caption := trTempsLim+' ('+inttostr(timeTB.Position)+' s )';
   TmaxCB.Checked := true;
end;

procedure TcapturePsForm.TmaxCBClick(Sender: TObject);
begin
    timeTB.Enabled:=tmaxcb.Checked;
    if tmaxCB.Checked
      then dureeGB.Caption := trTempsLim+' ('+inttostr(timeTB.Position)+' s )'
      else dureeGB.Caption := trTempsLim;
end;

procedure TcapturePsForm.UpdatePreview;
begin
   if FProbe.active then imgPreview.Picture.Assign(FProbe.Bitmap);
end;

end.
