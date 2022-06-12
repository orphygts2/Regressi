object capturePsForm: TcapturePsForm
  Left = 246
  Top = 202
  Caption = 'Capture'
  ClientHeight = 1388
  ClientWidth = 1300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 192
  DesignSize = (
    1300
    1388)
  TextHeight = 38
  object Label5: TLabel
    Left = 16
    Top = 320
    Width = 8
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 1340
    Width = 1300
    Height = 48
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <>
    SimplePanel = True
  end
  object VitesseRG: TRadioGroup
    Left = 16
    Top = 752
    Width = 16
    Height = 338
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Images par seconde'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -22
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 3
    Items.Strings = (
      '5'
      '10'
      '15'
      '20'
      '25'
      '30'
      '60'
      '90')
    ParentFont = False
    TabOrder = 0
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1300
    Height = 1340
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    TabOrder = 2
    object DebutBtn: TSpeedButton
      Left = 16
      Top = 1180
      Width = 160
      Height = 60
      Hint = 'D'#233'but de la chronophotographie'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'D'#233'but'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        3333333333333333000033333333333333333333000030000000000000000000
        0000330000000033333333330000333000000033333333330000333300000033
        3333333300003333300000333333333300003333330000333333333300003333
        3330003333333333000033333333003333333333000033333333303333333333
        0000333333333333333333330000333333333333333333330000333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        33333333333333330000}
      OnClick = DebutBtnClick
    end
    object FinBtn: TSpeedButton
      Left = 1100
      Top = 1178
      Width = 160
      Height = 60
      Hint = 'Fin de la chronophotographie'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Fin'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        3333333333333333000033333333333333333333000000000000000000000000
        0000333333333330000000030000333333333330000000330000333333333330
        0000033300003333333333300000333300003333333333300003333300003333
        3333333000333333000033333333333003333333000033333333333033333333
        0000333333333333333333330000333333333333333333330000333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        33333333333333330000}
      OnClick = FinBtnClick
    end
    object WebcamList: TComboBox
      Left = 1
      Top = 1
      Width = 1298
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Style = csDropDownList
      TabOrder = 0
      OnChange = WebcamListChange
    end
    object DureeGB: TGroupBox
      Left = 16
      Top = 1072
      Width = 410
      Height = 88
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Dur'#233'e impos'#233'e'
      TabOrder = 1
      object TmaxCB: TCheckBox
        Left = 308
        Top = 40
        Width = 100
        Height = 46
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alRight
        Caption = 'Actif'
        TabOrder = 0
        OnClick = TmaxCBClick
      end
      object TimeTB: TTrackBar
        Left = 2
        Top = 40
        Width = 300
        Height = 46
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Max = 15
        Min = 2
        Position = 3
        TabOrder = 1
        ThumbLength = 40
        OnChange = TimeTBChange
      end
    end
    object StartStopButton: TButton
      Left = 878
      Top = 1090
      Width = 160
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Capturer'
      ImageIndex = 9
      ImageName = 'Item10'
      Images = ffmpegForm.VirtualImageList1
      TabOrder = 2
      OnClick = StartStopButtonClick
    end
    object VideoFormatsCB: TComboBox
      Left = 1
      Top = 47
      Width = 1298
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Style = csDropDownList
      TabOrder = 3
    end
    object ConvertBtn: TButton
      Left = 440
      Top = 1178
      Width = 160
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Traiter'
      ImageIndex = 25
      ImageName = 'Item26'
      Images = ffmpegForm.VirtualImageList1
      TabOrder = 4
      OnClick = ConvertBtnClick
    end
    object PreviewTB: TTrackBar
      Left = 1
      Top = 1251
      Width = 1298
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Enabled = False
      Max = 100
      Min = 1
      Position = 1
      SelEnd = 4
      SelStart = 2
      TabOrder = 5
      ThumbLength = 32
      OnChange = PreviewTBChange
    end
    object ProgressBar: TProgressBar
      Left = 1
      Top = 1307
      Width = 1298
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      TabOrder = 6
    end
    object ReglagesBtn: TButton
      Left = 1100
      Top = 1090
      Width = 160
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#233'glages'
      ImageIndex = 8
      ImageName = 'Item9'
      Images = ffmpegForm.VirtualImageList1
      TabOrder = 7
      OnClick = ReglagesBtnClick
    end
    object VisuPC: TPageControl
      Left = 1
      Top = 93
      Width = 1298
      Height = 980
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ActivePage = TraitementTS
      Align = alTop
      TabOrder = 8
      object PreviewTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'PreviewTS'
        TabVisible = False
        object VideoWindow: TVideoWindow
          Left = 0
          Top = 0
          Width = 1282
          Height = 962
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          FilterGraph = CaptureGraph
          VMROptions.Mode = vmrWindowed
          VMROptions.Streams = 1
          VMROptions.Preferences = []
          Color = clBlack
          Align = alClient
        end
      end
      object TraitementTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'TraitementTS'
        ImageIndex = 1
        TabVisible = False
        object ImgPreview: TImage
          Left = 0
          Top = 0
          Width = 1282
          Height = 962
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alClient
          Proportional = True
          Stretch = True
          ExplicitWidth = 1280
          ExplicitHeight = 960
        end
      end
    end
    object ChercheBtn: TButton
      Left = 438
      Top = 1090
      Width = 160
      Height = 60
      Hint = 'D'#233'tecter les cam'#233'ras connect'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Chercher'
      ImageIndex = 28
      ImageName = 'Item29'
      Images = ffmpegForm.VirtualImageList1
      TabOrder = 9
      OnClick = ChercheBtnClick
    end
    object PreviewBtn: TButton
      Left = 658
      Top = 1090
      Width = 160
      Height = 60
      Hint = 'D'#233'tecter les cam'#233'ras connect'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Visualiser'
      TabOrder = 10
      OnClick = PreviewBtnClick
    end
  end
  object CaptureGraph: TFilterGraph
    Mode = gmCapture
    GraphEdit = True
    LinearVolume = True
    Left = 400
    Top = 128
  end
  object Filter: TFilter
    BaseFilter.data = {00000000}
    FilterGraph = CaptureGraph
    Left = 264
    Top = 120
  end
  object SampleGrabber: TSampleGrabber
    FilterGraph = CaptureGraph
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      FFFFFFFF0000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 96
    Top = 112
  end
  object TimerStop: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerStopTimer
    Left = 84
    Top = 376
  end
  object profileList: TAVProfileList
    Categories.Strings = (
      'Video')
    Left = 264
    Top = 242
    object AVCustomVideoProfile1: TAVCustomVideoProfile
      Description = 'H264'
      Extension = '.mpg'
      Category = 'Video'
      SampleRate = 0
      AudioEncoder = AAC
      AudioChannels = mono1
      Format = F_MP4
      FrameWidth = 0
      FrameHeight = 0
      VideoEncoder = H264
      FrameRate = rOriginal
      VideoBitrate = 0
      Pass = 0
      FrameAspectRatio = AR_NONE
    end
    object pfMKV: TAVCustomVideoProfile
      Description = 'Matroska Video'
      Extension = '.mkv'
      Category = 'Video'
      SampleRate = 48000
      AudioEncoder = MP3
      AudioChannels = stereo2
      AudioBitrate = 128.000000000000000000
      Format = F_NONE
      FrameWidth = 640
      FrameHeight = 480
      VideoEncoder = H264
      FrameRate = r25
      VideoBitrate = 1200
      Pass = 0
      FrameAspectRatio = AR_NONE
    end
  end
  object AVConverter: TAVConverter
    ConvertOptions.LimitFileSize = 9223372036854775807
    ConvertOptions.AudioOptions.AudioChannels = 0
    ConvertOptions.AudioOptions.AudioSampleRate = 0
    ConvertOptions.AudioOptions.AudioVolume = 256
    ConvertOptions.AudioOptions.AudioSyncMethod = 0
    ConvertOptions.AudioOptions.AudioDisable = False
    ConvertOptions.AudioOptions.AudioSampleFmt = sfAuto
    ConvertOptions.AudioOptions.AudioStreamCopy = False
    ConvertOptions.AudioOptions.AudioCodecTag = 0
    ConvertOptions.AudioOptions.AudioQScale = -99999.000000000000000000
    ConvertOptions.AudioOptions.AudioDriftThreshold = 0.100000001490116100
    ConvertOptions.AudioOptions.Bitrate = 0
    ConvertOptions.AudioOptions.MaxFrames = 9223372036854775807
    ConvertOptions.DataOptions.DataDisable = False
    ConvertOptions.SubtitleOptions.SubtitleDisable = False
    ConvertOptions.SubtitleOptions.SubtitleCodecTag = 0
    ConvertOptions.VideoOptions.FrameWidth = 0
    ConvertOptions.VideoOptions.FrameHeight = 0
    ConvertOptions.VideoOptions.VideoDisable = False
    ConvertOptions.VideoOptions.VideoStreamCopy = False
    ConvertOptions.VideoOptions.VideoCodecTag = 0
    ConvertOptions.VideoOptions.IntraOnly = False
    ConvertOptions.VideoOptions.TopFieldFirst = -1
    ConvertOptions.VideoOptions.ForceFPS = False
    ConvertOptions.VideoOptions.FrameRate.num = 0
    ConvertOptions.VideoOptions.FrameRate.den = 0
    ConvertOptions.VideoOptions.InputFrameRate.num = 0
    ConvertOptions.VideoOptions.InputFrameRate.den = 0
    ConvertOptions.VideoOptions.Deinterlace = False
    ConvertOptions.VideoOptions.Pass = 0
    ConvertOptions.VideoOptions.MaxFrames = 2147483647
    ConvertOptions.VideoOptions.Bitrate = 0
    ConvertOptions.MuxerOptions.MuxPreload = 0.500000000000000000
    ConvertOptions.StartTime = 0
    ConvertOptions.RecordingTime = 9223372036854775807
    OnProgress = AVConverterProgress
    OnComplete = AVConverterComplete
    VideoBufferEventInterval = 1
    Left = 97
    Top = 230
  end
end
