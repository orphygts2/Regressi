object ArduinoWifiDlg: TArduinoWifiDlg
  Left = 0
  Top = 0
  HelpContext = 80
  AutoSize = True
  Caption = 'Param'#233'trage r'#233'seau Arduino'
  ClientHeight = 1487
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 38
  object MemoPoint: TMemo
    Left = 0
    Top = 957
    Width = 764
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de '
      'donn'#233'es par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des '
      'virgules. La premi'#232're donn'#233'e sera plac'#233'e en abscisse.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    ExplicitWidth = 628
  end
  object ModeRG: TRadioGroup
    Left = 0
    Top = 0
    Width = 764
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Mode d'#39'acquisition'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Point par point'
      'Temporel')
    ParentFont = False
    TabOrder = 0
    OnClick = ModeRGClick
    ExplicitWidth = 628
  end
  object DureeGB: TGroupBox
    Left = 0
    Top = 160
    Width = 764
    Height = 220
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 628
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 305
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Dur'#233'e de l'#39'acquisition (s)'
    end
    object Label2: TLabel
      Left = 16
      Top = 96
      Width = 142
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Commande'
    end
    object Label3: TLabel
      Left = 16
      Top = 152
      Width = 381
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'P'#233'riode d'#39#233'chantillonnage (ms)'
    end
    object dureeMaxSE: TSpinEdit
      Left = 346
      Top = 20
      Width = 160
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 4096
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
    end
    object GetEdit: TEdit
      Left = 346
      Top = 86
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      Text = 'GetEdit'
    end
    object TechSE: TSpinEdit
      Left = 410
      Top = 143
      Width = 130
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 30000
      MinValue = 33
      ParentFont = False
      TabOrder = 2
      Value = 100
    end
  end
  object CommandGB: TGroupBox
    Left = 0
    Top = 380
    Width = 764
    Height = 208
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Boutons de commande'
    TabOrder = 3
    ExplicitWidth = 628
    object SendGrid: TStringGrid
      Left = 2
      Top = 40
      Width = 760
      Height = 166
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ColCount = 4
      DefaultColWidth = 180
      DefaultRowHeight = 48
      RowCount = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 624
    end
  end
  object ModeTempsRG: TRadioGroup
    Left = 0
    Top = 80
    Width = 764
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Mode temporel'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Monocoup'
      'Relax'#233
      'Rouleau')
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 628
  end
  object MemoTemps: TMemo
    Left = 0
    Top = 1077
    Width = 764
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de '
      'donn'#233'es par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des '
      'virgules. Le temps est g'#233'r'#233' par le PC et sera l'#39'abscisse')
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    ExplicitWidth = 628
  end
  object UdpGB: TGroupBox
    Left = 0
    Top = 1197
    Width = 764
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'R'#233'seau'
    TabOrder = 6
    ExplicitWidth = 628
    object HostEdit: TLabeledEdit
      Left = 216
      Top = 62
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 129
      EditLabel.Height = 38
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Adresse IP'
      TabOrder = 0
      Text = ''
      OnKeyPress = HostEditKeyPress
    end
    object PortEdit: TLabeledEdit
      Left = 480
      Top = 62
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      CharCase = ecUpperCase
      EditLabel.Width = 50
      EditLabel.Height = 38
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Port'
      TabOrder = 1
      Text = ''
      OnKeyPress = PortEditKeyPress
    end
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 1317
    Width = 764
    Height = 170
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 7
    ExplicitWidth = 628
    object ExPointBtn: TBitBtn
      Left = 16
      Top = 28
      Width = 600
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino point par point'
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 0
      OnClick = ExPointBtnClick
    end
    object arduinoExeBtn: TBitBtn
      Left = 400
      Top = 90
      Width = 314
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lancer IDE Arduino'
      TabOrder = 1
      OnClick = arduinoExeBtnClick
    end
    object Okbtn: TBitBtn
      Left = 16
      Top = 90
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 2
    end
    object HelpBtn: TBitBtn
      Left = 200
      Top = 90
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 3
      OnClick = HelpBtnClick
    end
  end
  object GrandeursGB: TGroupBox
    Left = 0
    Top = 588
    Width = 764
    Height = 369
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Grandeurs envoy'#233'es par Arduino'
    TabOrder = 8
    ExplicitWidth = 628
    object grid: TStringGrid
      Left = 2
      Top = 40
      Width = 760
      Height = 327
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      ColCount = 4
      DefaultColWidth = 200
      DefaultRowHeight = 48
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goAlwaysShowEditor]
      TabOrder = 0
      ExplicitWidth = 624
    end
  end
  object Panel1: TPanel
    Left = 4
    Top = 1104
    Width = 750
    Height = 2
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 9
  end
end
