object FormDDE: TFormDDE
  Left = 339
  Top = 86
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Regressi'
  ClientHeight = 441
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 28
  object Editor: TRichEdit
    Left = 0
    Top = 320
    Width = 452
    Height = 126
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    HideSelection = False
    HideScrollBars = False
    ParentFont = False
    TabOrder = 0
    Visible = False
    WordWrap = False
  end
  object ServeurItem: TDdeServerItem
    ServerConv = ServeurDDE
    Lines.Strings = (
      '')
    Left = 232
    Top = 48
  end
  object ServeurDDE: TDdeServerConv
    OnExecuteMacro = ExecuteMacro
    Left = 56
    Top = 136
  end
  object ClientDDE: TDdeClientConv
    DdeTopic = 'ServeurDDE'
    ConnectMode = ddeManual
    Left = 32
    Top = 8
    LinkInfo = (
      'Service '
      'Topic ServeurDDE')
  end
  object TimerOpenDDE: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerOpenDDETimer
    Left = 200
    Top = 208
  end
end
