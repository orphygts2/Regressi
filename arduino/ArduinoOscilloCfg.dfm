object ArduinoOscilloDlg: TArduinoOscilloDlg
  Left = 0
  Top = 0
  HelpContext = 80
  AutoSize = True
  Caption = 'Param'#233'trage oscillo Arduino/micro:bit'
  ClientHeight = 1404
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 38
  object Comports: TRadioGroup
    Left = 0
    Top = 0
    Width = 754
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Voie s'#233'rie:'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Com1'
      'Com2'
      'Com3'
      'Com4')
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 628
  end
  object Memo1: TMemo
    Left = 0
    Top = 160
    Width = 754
    Height = 350
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
      'donn'#233'es, '
      'les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules, la premi'#232're '
      'donn'#233'e '
      #233'tant le temps qui sera plac'#233' en abscisse.'
      'La vitesse doit '#234'tre r'#233'gl'#233'e '#224' x baud par Serial.begin(x);'
      'On a pr'#233'vu une fr'#233'quence d'#39#233'chantillonnage maxi de 100 kHz.'
      'Attention, dans la cas de Arduino Uno, elle est limit'#233'e '#224' 10 '
      'kHZ.'
      'Les donn'#233'es sont cens'#233'es '#234'tre des entiers not'#233's V dans la '
      'formule '
      'de conversion. Ex. de conversion vers 0..5V : 5*V/1024.'
      'Pour le sur'#233'chantillonnage, il faut respecter le crit'#232're de '
      'Shannon.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    ExplicitTop = 242
    ExplicitWidth = 628
  end
  object BaudRG: TRadioGroup
    Left = 0
    Top = 80
    Width = 754
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Vitesse/baud'
    Columns = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      '9600'
      '19200'
      '38400'
      '57600'
      '115200')
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 162
    ExplicitWidth = 628
  end
  object sincGB: TGroupBox
    Left = 0
    Top = 831
    Width = 754
    Height = 193
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Options d'#39'acquisition'
    TabOrder = 3
    ExplicitTop = 913
    ExplicitWidth = 628
    object sincCB: TCheckBox
      Left = 16
      Top = 130
      Width = 312
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sur'#233'chantillonnage x '
      TabOrder = 0
    end
    object ordreSincSE: TSpinEdit
      Left = 340
      Top = 124
      Width = 80
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
      MaxValue = 12
      MinValue = 2
      ParentFont = False
      TabOrder = 1
      Value = 2
    end
    object NbreRG: TRadioGroup
      Left = 2
      Top = 40
      Width = 750
      Height = 80
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Nombre de points'
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        '256'
        '512'
        '1024'
        '2048')
      ParentFont = False
      TabOrder = 2
      ExplicitWidth = 624
    end
  end
  object ResolutionRG: TRadioGroup
    Left = 0
    Top = 1024
    Width = 754
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'R'#233'solution (bits)'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      '8'
      '10'
      '12 '
      '14')
    ParentFont = False
    TabOrder = 4
    ExplicitTop = 1106
    ExplicitWidth = 628
  end
  object Panel1: TPanel
    Left = 0
    Top = 1104
    Width = 754
    Height = 300
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 5
    ExplicitTop = 1306
    ExplicitWidth = 628
    object OKBtn: TBitBtn
      Left = 32
      Top = 232
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object HelpBtn: TBitBtn
      Left = 204
      Top = 232
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 1
      OnClick = HelpBtnClick
    end
    object DueBtn: TBitBtn
      Left = 32
      Top = 32
      Width = 400
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino Due'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = UnoBtnClick
    end
    object CurieBtn: TBitBtn
      Left = 32
      Top = 92
      Width = 400
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino Curie 101'
      NumGlyphs = 2
      TabOrder = 3
      OnClick = UnoBtnClick
    end
    object UnoBtn: TBitBtn
      Left = 444
      Top = 30
      Width = 240
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Arduino Uno'
      NumGlyphs = 2
      TabOrder = 4
      OnClick = UnoBtnClick
    end
    object arduinoExeBtn: TBitBtn
      Left = 396
      Top = 232
      Width = 320
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lancer IDE Arduino'
      TabOrder = 5
      OnClick = arduinoExeBtnClick
    end
    object WifiBtn: TBitBtn
      Left = 32
      Top = 154
      Width = 400
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple MKR1010 Wifi'
      NumGlyphs = 2
      TabOrder = 6
      OnClick = UnoBtnClick
    end
    object microbitBtn: TBitBtn
      Left = 444
      Top = 92
      Width = 240
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'micro:bit'
      NumGlyphs = 2
      TabOrder = 7
      OnClick = UnoBtnClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 510
    Width = 754
    Height = 321
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Grandeurs envoy'#233'es par Arduino'
    TabOrder = 6
    ExplicitTop = 592
    ExplicitWidth = 628
    object grid: TStringGrid
      Left = 2
      Top = 40
      Width = 750
      Height = 279
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      ColCount = 3
      DefaultColWidth = 200
      DefaultRowHeight = 48
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goAlwaysShowEditor]
      TabOrder = 0
      ExplicitWidth = 624
    end
  end
  object Panel2: TPanel
    Left = 4
    Top = 16
    Width = 750
    Height = 2
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 7
  end
end
