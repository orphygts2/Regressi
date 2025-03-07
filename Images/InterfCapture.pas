unit interfCapture;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, iniFiles,
  system.IOUtils, system.SysUtils, regUtil, constreg,
  WCamera;

type
  Tetat = (eNone,eAttente,ePreview);
  TInterfCaptureForm = class(TForm)
    PanelTop: TPanel;
    PanelRight: TPanel;
    PanelLeft: TPanel;
    WCamera: TWCamera;
    LabelCamera: TLabel;
    ComboBoxCamera: TComboBox;
    LabelFormat: TLabel;
    ComboBoxFormat: TComboBox;
    TrackBarBacklightCompensation: TTrackBar;
    LabelBacklightCompensation: TLabel;
    CheckBoxBacklightCompensation: TCheckBox;
    LabelBrightness: TLabel;
    TrackBarBrightness: TTrackBar;
    CheckBoxBrightness: TCheckBox;
    LabelColorEnable: TLabel;
    TrackBarColorEnable: TTrackBar;
    CheckBoxColorEnable: TCheckBox;
    LabelContrast: TLabel;
    TrackBarContrast: TTrackBar;
    CheckBoxContrast: TCheckBox;
    LabelExposure: TLabel;
    TrackBarExposure: TTrackBar;
    CheckBoxExposure: TCheckBox;
    LabelFocus: TLabel;
    TrackBarFocus: TTrackBar;
    CheckBoxFocus: TCheckBox;
    LabelGain: TLabel;
    TrackBarGain: TTrackBar;
    CheckBoxGain: TCheckBox;
    LabelGamma: TLabel;
    TrackBarGamma: TTrackBar;
    CheckBoxGamma: TCheckBox;
    LabelHue: TLabel;
    TrackBarHue: TTrackBar;
    CheckBoxHue: TCheckBox;
    LabelIris: TLabel;
    TrackBarIris: TTrackBar;
    CheckBoxIris: TCheckBox;
    LabelPan: TLabel;
    TrackBarPan: TTrackBar;
    CheckBoxPan: TCheckBox;
    LabelRoll: TLabel;
    TrackBarRoll: TTrackBar;
    CheckBoxRoll: TCheckBox;
    LabelSaturation: TLabel;
    TrackBarSaturation: TTrackBar;
    CheckBoxSaturation: TCheckBox;
    LabelSharpness: TLabel;
    TrackBarSharpness: TTrackBar;
    CheckBoxSharpness: TCheckBox;
    LabelTilt: TLabel;
    TrackBarTilt: TTrackBar;
    CheckBoxTilt: TCheckBox;
    LabelWhiteBalance: TLabel;
    TrackBarWhiteBalance: TTrackBar;
    CheckBoxWhiteBalance: TCheckBox;
    LabelZoom: TLabel;
    TrackBarZoom: TTrackBar;
    CheckBoxZoom: TCheckBox;
    DefaultValuesBtn: TButton;
    PreviewBtn: TButton;
    RecordBtn: TButton;
    PanelBoutons: TPanel;
    ConfigBtn: TButton;
    CancelBtn: TButton;
    ImagePreview: TImage;
    procedure ComboBoxCameraDropDown(Sender: TObject);
    procedure ComboBoxCameraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxFormatChange(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure DefaultValuesBtnClick(Sender: TObject);
    procedure WCameraImageAvailable(Sender: TObject; SampleTime: Double);
    procedure FormDestroy(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RecordBtnClick(Sender: TObject);
    procedure ConfigBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    MemoryStream: TMemoryStream;
    Bitmap: TBitmap;
    withConfig : boolean;
    indexCBFormat : integer;
    NomCamera : string;
    etat : Tetat;
    procedure SetDevices;
    procedure SetFormats;
    procedure SetTrackBars;
    procedure setBoutons(NewEtat : Tetat);
    procedure startDevice;
    procedure stopDevice;
  public
  end;

var
  InterfCaptureForm: TInterfCaptureForm;

implementation

{$R *.dfm}

uses
    interfMain;

procedure TInterfCaptureForm.stopDevice;
begin
    if WCamera.active then begin
        PreviewBtn.Enabled := false;
        Screen.Cursor := crHourGlass; // stop peut durer longtemps !
        WCamera.Stop;
        WCamera.Active := False;
        Screen.Cursor := crDefault;
    end;
end;

procedure TInterfCaptureForm.setBoutons(NewEtat : Tetat);
const
   indexCamera = 4;
   indexStop = 1;
   indexAttente = 3;
begin
    etat := NewEtat;
    PanelRight.Enabled := etat<>eAttente;
    ConfigBtn.Enabled := etat<>eAttente;
    comboBoxFormat.Enabled := etat<>eAttente;
    comboBoxCamera.Enabled := etat<>eAttente;
    case etat of
        eNone : begin
            PreviewBtn.Enabled := true;
            PreviewBtn.caption := 'Pr�visualisation';
            PreviewBtn.ImageIndex := indexCamera;
            Screen.Cursor := crDefault;
        end;
        ePreview : begin
            PreviewBtn.Caption := 'Stop';
            PreviewBtn.ImageIndex := indexStop;
            Screen.Cursor := crDefault;
            PreviewBtn.Enabled := true;
        end;
        eAttente : begin
            PreviewBtn.ImageIndex := indexAttente;
            PreviewBtn.caption := 'Attente';
            PreviewBtn.Enabled := false;
            Screen.Cursor := crHourGlass;
        end;
    end;
    PreviewBtn.Update;
end;

procedure TInterfCaptureForm.StartDevice;
begin
  SetTrackBars;
  if (ComboBoxFormat.ItemIndex >=0 ) and (WCamera.DeviceIndex >= 0) then begin
     try
     stopDevice;
     WCamera.Format := WCamera.SupportedFormats[ComboBoxFormat.ItemIndex];
     WCamera.Active := True;
     setBoutons(eAttente);
     WCamera.Run;
     except
         setBoutons(eNone);
         AfficheErreur('Impossible d''activer la cam�ra',0)
     end;
  end
  else setBoutons(eNone);
end;

procedure TInterfCaptureForm.SetDevices;
var
  CurrentDeviceName: string;
  CurrentDeviceIndex: Integer;
  Devices: TWVideoCaptureDevices;
  I: Integer;
begin
  ComboBoxCamera.Items.BeginUpdate;
  try
    CurrentDeviceName := ComboBoxCamera.Text;
    CurrentDeviceIndex := ComboBoxCamera.ItemIndex;
    ComboBoxCamera.Items.Clear;
    Devices := WCamera.Devices;
    for I := 0 to Length(Devices) - 1 do
      ComboBoxCamera.Items.Add(Devices[I].Name);
    if (CurrentDeviceIndex >= 0) and
       (CurrentDeviceIndex < ComboBoxCamera.Items.Count) and
       (ComboBoxCamera.Items[CurrentDeviceIndex] = CurrentDeviceName)
         then ComboBoxCamera.ItemIndex := CurrentDeviceIndex;
    if (ComboBoxCamera.Items.Count>0) and (ComboBoxCamera.ItemIndex<0) then begin
       for i := 0 to ComboBoxCamera.Items.Count - 1 do
           if nomCamera=ComboBoxCamera.Items[i]
              then ComboBoxCamera.ItemIndex := i;
       if (ComboBoxCamera.ItemIndex<0)
          then ComboBoxCamera.ItemIndex := 0;
    end;
  finally
    ComboBoxCamera.Items.EndUpdate;
  end;
  if (ComboBoxCamera.ItemIndex>=0) then ComboBoxCameraChange(nil);
end;

procedure TInterfCaptureForm.SetFormats;
var
  Formats: TWCameraFormats;
  I: Integer;
  str : string;
  relancer : boolean;
begin
  if ComboBoxCamera.ItemIndex<0 then exit;
  ComboBoxFormat.Items.BeginUpdate;
  try
    relancer := etat=ePreview;
    stopDevice;
    WCamera.DeviceIndex := ComboBoxCamera.ItemIndex;
    ComboBoxFormat.Items.Clear;
    ComboBoxFormat.Enabled := WCamera.DeviceIndex <> -1;
    if ComboBoxFormat.Enabled then begin
      Formats := WCamera.SupportedFormats;
      for I := 0 to Length(Formats) - 1 do begin
        str := IntToStr(Formats[I].Width) + 'x' + IntToStr(Formats[I].Height);
        if Formats[I].AvgTimePerFrame > 0 then str := str + ' ' + IntToStr(10000000 div Formats[I].AvgTimePerFrame) + 'Hz';
        ComboBoxFormat.Items.Add(str)
      end;
      if indexCBFormat<ComboBoxFormat.Items.count then ComboBoxFormat.ItemIndex := indexCBFormat;
      if relancer then startDevice;
    end
  finally
    ComboBoxFormat.Items.EndUpdate;
  end;
end;

procedure InitTrackBar(TrackbarLabel: TLabel; TrackBar: TTrackBar; CheckBoxAuto: TCheckBox);
begin
  TrackbarLabel.Enabled := False;
  TrackBar.Enabled := False;
  CheckBoxAuto.Enabled := False;
end;

procedure SetTrackBar(TrackbarLabel: TLabel; TrackBar: TTrackBar; CheckBoxAuto: TCheckBox; Position: Integer; Range: TWRange; Auto: Boolean);
begin
  CheckBoxAuto.Checked := Auto;
  TrackBar.Min := Range.Min;
  TrackBar.Max := Range.Max;
  TrackBar.PageSize := Range.Delta;
  if (Range.Delta > 0) and ((Range.Max - Range.Min) div Range.Delta > 25)
     then TrackBar.Frequency := (Range.Max - Range.Min) div 25
     else TrackBar.Frequency := 1;
  TrackBar.Position := Position;

  TrackbarLabel.Enabled := True;
  CheckBoxAuto.Enabled := Range.Auto and Range.Manual;
  TrackBar.Enabled := not CheckBoxAuto.Checked;
end;

var TrackBarsSetting: Boolean;

procedure TInterfCaptureForm.SetTrackBars;
begin
  if not TrackBarsSetting then
  try
    TrackBarsSetting := True;
    InitTrackBar(LabelBacklightCompensation, TrackBarBacklightCompensation, CheckBoxBacklightCompensation);
    InitTrackBar(LabelBrightness, TrackBarBrightness, CheckBoxBrightness);
    InitTrackBar(LabelColorEnable, TrackBarColorEnable, CheckBoxColorEnable);
    InitTrackBar(LabelContrast, TrackBarContrast, CheckBoxContrast);
    InitTrackBar(LabelExposure, TrackBarExposure, CheckBoxExposure);
    InitTrackBar(LabelFocus, TrackBarFocus, CheckBoxFocus);
    InitTrackBar(LabelGain, TrackBarGain, CheckBoxGain);
    InitTrackBar(LabelGamma, TrackBarGamma, CheckBoxGamma);
    InitTrackBar(LabelHue, TrackBarHue, CheckBoxHue);
    InitTrackBar(LabelIris, TrackBarIris, CheckBoxIris);
    InitTrackBar(LabelPan, TrackBarPan, CheckBoxPan);
    InitTrackBar(LabelRoll, TrackBarRoll, CheckBoxRoll);
    InitTrackBar(LabelSaturation, TrackBarSaturation, CheckBoxSaturation);
    InitTrackBar(LabelSharpness, TrackBarSharpness, CheckBoxSharpness);
    InitTrackBar(LabelTilt, TrackBarTilt, CheckBoxTilt);
    InitTrackBar(LabelWhiteBalance, TrackBarWhiteBalance, CheckBoxWhiteBalance);
    InitTrackBar(LabelZoom, TrackBarZoom, CheckBoxZoom);

    if WCamera.DeviceIndex <> -1 then begin
      if WCamera.BacklightCompensationSupported then
        SetTrackBar(LabelBacklightCompensation, TrackBarBacklightCompensation, CheckBoxBacklightCompensation, WCamera.BacklightCompensation, WCamera.BacklightCompensationRange, WCamera.BacklightCompensationAuto);
      if WCamera.BrightnessSupported then
        SetTrackBar(LabelBrightness, TrackBarBrightness, CheckBoxBrightness, WCamera.Brightness, WCamera.BrightnessRange, WCamera.BrightnessAuto);
      if WCamera.ColorEnableSupported then
        SetTrackBar(LabelColorEnable, TrackBarColorEnable, CheckBoxColorEnable, WCamera.ColorEnable, WCamera.ColorEnableRange, WCamera.ColorEnableAuto);
      if WCamera.ContrastSupported then
        SetTrackBar(LabelContrast, TrackBarContrast, CheckBoxContrast, WCamera.Contrast, WCamera.ContrastRange, WCamera.ContrastAuto);
      if WCamera.ExposureSupported then
        SetTrackBar(LabelExposure, TrackBarExposure, CheckBoxExposure, WCamera.Exposure, WCamera.ExposureRange, WCamera.ExposureAuto);
      if WCamera.FocusSupported then
        SetTrackBar(LabelFocus, TrackBarFocus, CheckBoxFocus, WCamera.Focus, WCamera.FocusRange, WCamera.FocusAuto);
      if WCamera.GainSupported then
        SetTrackBar(LabelGain, TrackBarGain, CheckBoxGain, WCamera.Gain, WCamera.GainRange, WCamera.GainAuto);
      if WCamera.GammaSupported then
        SetTrackBar(LabelGamma, TrackBarGamma, CheckBoxGamma, WCamera.Gamma, WCamera.GammaRange, WCamera.GammaAuto);
      if WCamera.HueSupported then
        SetTrackBar(LabelHue, TrackBarHue, CheckBoxHue, WCamera.Hue, WCamera.HueRange, WCamera.HueAuto);
      if WCamera.IrisSupported then
        SetTrackBar(LabelIris, TrackBarIris, CheckBoxIris, WCamera.Iris, WCamera.IrisRange, WCamera.IrisAuto);
      if WCamera.PanSupported then
        SetTrackBar(LabelPan, TrackBarPan, CheckBoxPan, WCamera.Pan, WCamera.PanRange, WCamera.PanAuto);
      if WCamera.RollSupported then
        SetTrackBar(LabelRoll, TrackBarRoll, CheckBoxRoll, WCamera.Roll, WCamera.RollRange, WCamera.RollAuto);
      if WCamera.SaturationSupported then
        SetTrackBar(LabelSaturation, TrackBarSaturation, CheckBoxSaturation, WCamera.Saturation, WCamera.SaturationRange, WCamera.SaturationAuto);
      if WCamera.SharpnessSupported then
        SetTrackBar(LabelSharpness, TrackBarSharpness, CheckBoxSharpness, WCamera.Sharpness, WCamera.SharpnessRange, WCamera.SharpnessAuto);
      if WCamera.TiltSupported then
        SetTrackBar(LabelTilt, TrackBarTilt, CheckBoxTilt, WCamera.Tilt, WCamera.TiltRange, WCamera.TiltAuto);
      if WCamera.WhiteBalanceSupported then
        SetTrackBar(LabelWhiteBalance, TrackBarWhiteBalance, CheckBoxWhiteBalance, WCamera.WhiteBalance, WCamera.WhiteBalanceRange, WCamera.WhiteBalanceAuto);
      if WCamera.ZoomSupported then
        SetTrackBar(LabelZoom, TrackBarZoom, CheckBoxZoom, WCamera.Zoom, WCamera.ZoomRange, WCamera.ZoomAuto);
    end
  finally
    TrackBarsSetting := False;
  end;
end;

procedure TInterfCaptureForm.ComboBoxCameraDropDown(Sender: TObject);
begin
  SetDevices;
end;

procedure TInterfCaptureForm.ComboBoxCameraChange(Sender: TObject);
begin
  SetFormats;
  SetTrackBars;
  DefaultValuesBtn.Enabled := WCamera.DeviceIndex <> -1;
  ConfigBtn.Enabled := WCamera.DeviceIndex <> -1;
  PreviewBtn.Enabled := WCamera.DeviceIndex <> -1;
end;

procedure TInterfCaptureForm.FormActivate(Sender: TObject);
begin
    withConfig := true;
    ConfigBtnClick(nil);
    SetDevices;
    RecordBtn.Enabled := false;
    setBoutons(eNone);
end;

procedure TInterfCaptureForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Fichier : TMemIniFile;
begin
       Fichier := TMemIniFile.create(NomFichierIni);

       Fichier.WriteBool(stCaptureCB,'BLC',CheckBoxBacklightCompensation.Checked);
       Fichier.WriteBool(stCaptureCB,'B',CheckBoxBrightness.Checked );
       Fichier.WriteBool(stCaptureCB,'CE',CheckBoxColorEnable.Checked);
       Fichier.WriteBool(stCaptureCB,'C',CheckBoxContrast.Checked);
       Fichier.WriteBool(stCaptureCB,'E',CheckBoxExposure.Checked);
       Fichier.WriteBool(stCaptureCB,'F',CheckBoxFocus.Checked );
       Fichier.WriteBool(stCaptureCB,'Gain',CheckBoxGain.Checked);
       Fichier.WriteBool(stCaptureCB,'Gamma',CheckBoxGamma.Checked );
       Fichier.WriteBool(stCaptureCB,'H',CheckBoxHue.Checked );
       Fichier.WriteBool(stCaptureCB,'I',CheckBoxIris.Checked);
       Fichier.WriteBool(stCaptureCB,'P', CheckBoxPan.Checked);
       Fichier.WriteBool(stCaptureCB,'R', CheckBoxRoll.Checked );
       Fichier.WriteBool(stCaptureCB,'Sat',CheckBoxSaturation.Checked  );
       Fichier.WriteBool(stCaptureCB,'S', CheckBoxSharpness.Checked);
       Fichier.WriteBool(stCaptureCB,'T', CheckBoxTilt.Checked  );
       Fichier.WriteBool(stCaptureCB,'Balance',CheckBoxWhiteBalance.Checked );
       Fichier.WriteBool(stCaptureCB,'Z', CheckBoxZoom.Checked);

       Fichier.writeInteger(stCaptureTB,'BLC',TrackBarBacklightCompensation.Position);
       Fichier.writeInteger(stCaptureTB,'B',TrackBarBrightness.Position);
       Fichier.writeInteger(stCaptureTB,'CE',TrackBarColorEnable.Position);
       Fichier.writeInteger(stCaptureTB,'C',TrackBarContrast.Position);
       Fichier.writeInteger(stCaptureTB,'E',TrackBarExposure.Position);
       Fichier.writeInteger(stCaptureTB,'F',TrackBarFocus.Position);
       Fichier.writeInteger(stCaptureTB,'Gain', TrackBarGain.Position);
       Fichier.writeInteger(stCaptureTB,'Gamma',TrackBarGamma.Position);
       Fichier.writeInteger(stCaptureTB,'H',TrackBarHue.Position);
       Fichier.writeInteger(stCaptureTB,'I',TrackBarIris.Position);
       Fichier.writeInteger(stCaptureTB,'P',TrackBarPan.Position);
       Fichier.writeInteger(stCaptureTB,'R', TrackBarRoll.Position);
       Fichier.writeInteger(stCaptureTB,'Sat', TrackBarSaturation.Position);
       Fichier.writeInteger(stCaptureTB,'S', TrackBarSharpness.Position);
       Fichier.writeInteger(stCaptureTB,'T',TrackBarTilt.Position );
       Fichier.writeInteger(stCaptureTB,'Balance',TrackBarWhiteBalance.Position);
       Fichier.writeInteger(stCaptureTB,'Z',TrackBarZoom.Position);

       Fichier.writeInteger(stCaptureTB,'CBFormat',ComboBoxFormat.itemIndex);
       Fichier.writeString(stCaptureTB,'CBCamera',ComboBoxCamera.text);

       Fichier.UpdateFile;
       Fichier.free;
       stopDevice;
end;

procedure TInterfCaptureForm.FormCreate(Sender: TObject);

procedure LitIni;
var Fichier : TMemIniFile;
begin
       TrackBarsSetting := True;
       Fichier := TMemIniFile.create(NomFichierIni);

       CheckBoxBacklightCompensation.Checked := Fichier.ReadBool(stCaptureCB,'BLC',CheckBoxBacklightCompensation.Checked);
       CheckBoxBrightness.Checked := Fichier.ReadBool(stCaptureCB,'B',CheckBoxBrightness.Checked );
       CheckBoxColorEnable.Checked := Fichier.ReadBool(stCaptureCB,'CE',CheckBoxColorEnable.Checked);
       CheckBoxContrast.Checked := Fichier.ReadBool(stCaptureCB,'C',CheckBoxContrast.Checked);
       CheckBoxExposure.Checked := Fichier.ReadBool(stCaptureCB,'E',CheckBoxExposure.Checked);
       CheckBoxFocus.Checked := Fichier.ReadBool(stCaptureCB,'F',CheckBoxFocus.Checked );
       CheckBoxGain.Checked := Fichier.ReadBool(stCaptureCB,'Gain',CheckBoxGain.Checked);
       CheckBoxGamma.Checked := Fichier.ReadBool(stCaptureCB,'Gamma',CheckBoxGamma.Checked );
       CheckBoxHue.Checked := Fichier.ReadBool(stCaptureCB,'H',CheckBoxHue.Checked );
       CheckBoxIris.Checked := Fichier.ReadBool(stCaptureCB,'I',CheckBoxIris.Checked);
       CheckBoxPan.Checked := Fichier.ReadBool(stCaptureCB,'P', CheckBoxPan.Checked);
       CheckBoxRoll.Checked  := Fichier.ReadBool(stCaptureCB,'R', CheckBoxRoll.Checked );
       CheckBoxSaturation.Checked  := Fichier.ReadBool(stCaptureCB,'Sat',CheckBoxSaturation.Checked  );
       CheckBoxSharpness.Checked := Fichier.ReadBool(stCaptureCB,'S', CheckBoxSharpness.Checked);
       CheckBoxTilt.Checked := Fichier.ReadBool(stCaptureCB,'T', CheckBoxTilt.Checked  );
       CheckBoxWhiteBalance.Checked := Fichier.ReadBool(stCaptureCB,'Balance',CheckBoxWhiteBalance.Checked );
       CheckBoxZoom.Checked := Fichier.ReadBool(stCaptureCB,'Z', CheckBoxZoom.Checked);

       TrackBarBacklightCompensation.Position := Fichier.ReadInteger(stCaptureTB,'BLC',TrackBarBacklightCompensation.Position);
       TrackBarBrightness.Position := Fichier.ReadInteger(stCaptureTB,'B',TrackBarBrightness.Position);
       TrackBarColorEnable.Position := Fichier.readInteger(stCaptureTB,'CE',TrackBarColorEnable.Position);
       TrackBarContrast.Position := Fichier.readInteger(stCaptureTB,'C',TrackBarContrast.Position);
       TrackBarExposure.Position := Fichier.readInteger(stCaptureTB,'E',TrackBarExposure.Position);
       TrackBarFocus.Position := Fichier.readInteger(stCaptureTB,'F',TrackBarFocus.Position);
       TrackBarGain.Position := Fichier.readInteger(stCaptureTB,'Gain', TrackBarGain.Position);
       TrackBarGamma.Position := Fichier.readInteger(stCaptureTB,'Gamma',TrackBarGamma.Position);
       TrackBarHue.Position := Fichier.readInteger(stCaptureTB,'H',TrackBarHue.Position);
       TrackBarIris.Position := Fichier.readInteger(stCaptureTB,'I',TrackBarIris.Position);
       TrackBarPan.Position := Fichier.readInteger(stCaptureTB,'P',TrackBarPan.Position);
       TrackBarRoll.Position := Fichier.readInteger(stCaptureTB,'R', TrackBarRoll.Position);
       TrackBarSaturation.Position := Fichier.readInteger(stCaptureTB,'Sat', TrackBarSaturation.Position);
       TrackBarSharpness.Position := Fichier.readInteger(stCaptureTB,'S', TrackBarSharpness.Position);
       TrackBarTilt.Position  := Fichier.readInteger(stCaptureTB,'T',TrackBarTilt.Position );
       TrackBarWhiteBalance.Position := Fichier.readInteger(stCaptureTB,'Balance',TrackBarWhiteBalance.Position);
       TrackBarZoom.Position := Fichier.readInteger(stCaptureTB,'Z',TrackBarZoom.Position);
       TrackBarsSetting := False;

       IndexCBFormat := Fichier.readInteger(stCaptureTB,'CBFormat',0);
       nomCamera := Fichier.readString(stCaptureTB,'CBCamera','');
       Fichier.free;
end;

begin
  Bitmap := TBitmap.Create;
  MemoryStream := TMemoryStream.Create;
  recordBtn.Enabled := false;
  SetTrackBars;
  LitIni;
end;

procedure TInterfCaptureForm.FormDestroy(Sender: TObject);
begin
  WCamera.Active := False;
  Bitmap.Free;
  MemoryStream.Free;
end;

procedure TInterfCaptureForm.ComboBoxFormatChange(Sender: TObject);
begin
    if (WCamera.DeviceIndex >=0 ) and
       (ComboBoxFormat.ItemIndex >= 0) and
       (etat=ePreview)
       then startDevice;
end;

procedure TInterfCaptureForm.ConfigBtnClick(Sender: TObject);
begin
    withConfig := not withConfig;
    if withConfig
       then begin
            panelRight.Visible := true;
            width := PanelLeft.Width + PanelRight.Width - ClientWidth + Width;
            ConfigBtn.Caption := 'Fin r�glage';
           if (etat<>ePreview) and
              (WCamera.DeviceIndex <> -1 ) then previewBtnClick(sender)
       end
       else begin
            panelRight.Visible := false;
            width := PanelLeft.Width - ClientWidth + Width;
            ConfigBtn.Caption := 'R�glage';
       end;
end;

procedure TInterfCaptureForm.CancelBtnClick(Sender: TObject);
begin
    close;
end;

procedure TInterfCaptureForm.CheckBoxClick(Sender: TObject);
begin
  if not TrackBarsSetting then begin
    if Sender = CheckBoxBacklightCompensation then
      WCamera.BacklightCompensationAuto := CheckBoxBacklightCompensation.Checked
    else if Sender = CheckBoxBrightness then
      WCamera.BrightnessAuto := CheckBoxBrightness.Checked
    else if Sender = CheckBoxColorEnable then
      WCamera.ColorEnableAuto := CheckBoxColorEnable.Checked
    else if Sender = CheckBoxContrast then
      WCamera.ContrastAuto := CheckBoxContrast.Checked
    else if Sender = CheckBoxExposure then
      WCamera.ExposureAuto := CheckBoxExposure.Checked
    else if Sender = CheckBoxFocus then
      WCamera.FocusAuto := CheckBoxFocus.Checked
    else if Sender = CheckBoxGain then
      WCamera.GainAuto := CheckBoxGain.Checked
    else if Sender = CheckBoxGamma then
      WCamera.GammaAuto := CheckBoxGamma.Checked
    else if Sender = CheckBoxHue then
      WCamera.HueAuto := CheckBoxHue.Checked
    else if Sender = CheckBoxIris then
      WCamera.IrisAuto := CheckBoxIris.Checked
    else if Sender = CheckBoxPan then
      WCamera.PanAuto := CheckBoxPan.Checked
    else if Sender = CheckBoxRoll then
      WCamera.RollAuto := CheckBoxRoll.Checked
    else if Sender = CheckBoxSaturation then
      WCamera.SaturationAuto := CheckBoxSaturation.Checked
    else if Sender = CheckBoxSharpness then
      WCamera.SharpnessAuto := CheckBoxSharpness.Checked
    else if Sender = CheckBoxTilt then
      WCamera.TiltAuto := CheckBoxTilt.Checked
    else if Sender = CheckBoxWhiteBalance then
      WCamera.WhiteBalanceAuto := CheckBoxWhiteBalance.Checked
    else if Sender = CheckBoxZoom then
      WCamera.ZoomAuto := CheckBoxZoom.Checked;
    SetTrackBars;
  end
end;

procedure TInterfCaptureForm.TrackBarChange(Sender: TObject);
begin
  if not TrackBarsSetting then
    if Sender = TrackBarBacklightCompensation then
      WCamera.BacklightCompensation := TrackBarBacklightCompensation.Position
    else if Sender = TrackBarBrightness then
      WCamera.Brightness := TrackBarBrightness.Position
    else if Sender = TrackBarColorEnable then
      WCamera.ColorEnable := TrackBarColorEnable.Position
    else if Sender = TrackBarContrast then
      WCamera.Contrast := TrackBarContrast.Position
    else if Sender = TrackBarExposure then
      WCamera.Exposure := TrackBarExposure.Position
    else if Sender = TrackBarFocus then
      WCamera.Focus := TrackBarFocus.Position
    else if Sender = TrackBarGain then
      WCamera.Gain := TrackBarGain.Position
    else if Sender = TrackBarGamma then
      WCamera.Gamma := TrackBarGamma.Position
    else if Sender = TrackBarHue then
      WCamera.Hue := TrackBarHue.Position
    else if Sender = TrackBarIris then
      WCamera.Iris := TrackBarIris.Position
    else if Sender = TrackBarPan then
      WCamera.Pan := TrackBarPan.Position
    else if Sender = TrackBarRoll then
      WCamera.Roll := TrackBarRoll.Position
    else if Sender = TrackBarSaturation then
      WCamera.Saturation := TrackBarSaturation.Position
    else if Sender = TrackBarSharpness then
      WCamera.Sharpness := TrackBarSharpness.Position
    else if Sender = TrackBarTilt then
      WCamera.Tilt := TrackBarTilt.Position
    else if Sender = TrackBarWhiteBalance then
      WCamera.WhiteBalance := TrackBarWhiteBalance.Position
    else if Sender = TrackBarZoom then
      WCamera.Zoom := TrackBarZoom.Position;
end;

procedure TInterfCaptureForm.PreviewBtnClick(Sender: TObject);
begin
  case etat of
     ePreview : begin
        stopDevice;
        setBoutons(eNone);
     end;
     eNone : startDevice;
     eAttente : ;
  end;
end;

procedure TInterfCaptureForm.RecordBtnClick(Sender: TObject);
begin
       if etat=ePreview then PreviewBtnClick(Sender); // arr�t
       optiqueForm.Image.Picture.Assign(bitmap);
       optiqueForm.MajCapture;
       optiqueForm.Show;
       optiqueForm.SetFocus;
       close;
end;

procedure TInterfCaptureForm.DefaultValuesBtnClick(Sender: TObject);
begin
  try
    if WCamera.BacklightCompensationSupported then
      WCamera.BacklightCompensation := WCamera.BacklightCompensationRange.Default;
    if WCamera.BrightnessSupported then
      WCamera.Brightness := WCamera.BrightnessRange.Default;
    if WCamera.ColorEnableSupported then
      WCamera.ColorEnable := WCamera.ColorEnableRange.Default;
    if WCamera.ContrastSupported then
      WCamera.Contrast := WCamera.ContrastRange.Default;
    if WCamera.ExposureSupported then
      WCamera.Exposure := WCamera.ExposureRange.Default;
    if WCamera.FocusSupported then
      WCamera.Focus := WCamera.FocusRange.Default;
    if WCamera.GainSupported then
      WCamera.Gain := WCamera.GainRange.Default;
    if WCamera.GammaSupported then
      WCamera.Gamma := WCamera.GammaRange.Default;
    if WCamera.HueSupported then
      WCamera.Hue := WCamera.HueRange.Default;
    if WCamera.IrisSupported then
      WCamera.Iris := WCamera.IrisRange.Default;
    if WCamera.PanSupported then
      WCamera.Pan := WCamera.PanRange.Default;
    if WCamera.RollSupported then
      WCamera.Roll := WCamera.RollRange.Default;
    if WCamera.SaturationSupported then
      WCamera.Saturation := WCamera.SaturationRange.Default;
    if WCamera.SharpnessSupported then
      WCamera.Sharpness := WCamera.SharpnessRange.Default;
    if WCamera.TiltSupported then
      WCamera.Tilt := WCamera.TiltRange.Default;
    if WCamera.WhiteBalanceSupported then
      WCamera.WhiteBalance := WCamera.WhiteBalanceRange.Default;
    if WCamera.ZoomSupported then
      WCamera.Zoom := WCamera.ZoomRange.Default;
  finally
    SetTrackBars;
  end
end;

procedure TInterfCaptureForm.WCameraImageAvailable(Sender: TObject; SampleTime: Double);
begin
  if WCamera.Active then begin
    try
      if WCamera.CurrentImageToBitmap(Bitmap, MemoryStream) then begin
        imagePreview.Picture.Assign(Bitmap);
        recordBtn.Enabled := true;
        if etat=eAttente then setBoutons(ePreview);
      end;
    except
    end;
  end;
end;

end.



