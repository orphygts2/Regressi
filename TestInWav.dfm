object TestWavDlg: TTestWavDlg
  Left = 378
  Top = 199
  HelpContext = 46
  Caption = 'ChoixModeWav'
  ClientHeight = 353
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object ModeRG: TRadioGroup
    Left = 0
    Top = 0
    Width = 339
    Height = 257
    Align = alClient
    Caption = 'Mode d'#39'enregistrement'
    TabOrder = 0
    OnClick = ModeRGClick
    ExplicitHeight = 161
  end
  object Panel1: TPanel
    Left = 0
    Top = 257
    Width = 339
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 161
    object BitBtn1: TBitBtn
      Left = 6
      Top = 8
      Width = 100
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 224
      Top = 8
      Width = 100
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 298
    Width = 339
    Height = 55
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 202
    object CourantB: TBevel
      Left = 160
      Top = 8
      Width = 4
      Height = 33
    end
    object VolumePB: TProgressBar
      Left = 8
      Top = 17
      Width = 320
      Height = 16
      Max = 128
      TabOrder = 0
    end
  end
end
