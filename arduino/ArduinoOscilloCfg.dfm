object ArduinoOscilloDlg: TArduinoOscilloDlg
  Left = 0
  Top = 0
  HelpContext = 80
  Caption = 'Param'#233'trage liaison s'#233'rie Arduino'
  ClientHeight = 1230
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 37
  object Comports: TRadioGroup
    Left = 0
    Top = 0
    Width = 810
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Voie s'#233'rie:'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Com1'
      'Com2'
      'Com3'
      'Com4')
    TabOrder = 0
    ExplicitWidth = 686
  end
  object Memo1: TMemo
    Left = 0
    Top = 242
    Width = 810
    Height = 338
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de '
      'donn'#233'es, les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules,'
      'la premi'#232're donn'#233'e '#233'tant le temps qui sera plac'#233' en abscisse.'
      'La vitesse doit '#234'tre r'#233'gl'#233'e '#224' x baud par Serial.begin(x);'
      'On a pr'#233'vu une fr'#233'quence d'#39#233'chantillonnage maxi de 100 kHz.'
      
        'Attention, dans la cas de Arduino Uno, elle est limit'#233'e '#224' 10 kHZ' +
        '.'
      
        'Les donn'#233'es sont cens'#233'es '#234'tre des entiers positifs sur 10 bits, ' +
        'la '
      
        'conversion se faisant '#224' l'#39'aide de la troisi'#232'me ligne pour laquel' +
        'le '
      'cette valeur enti'#232're est not'#233'e V.'
      'Exemple conversion vers 0..5V : 5*V/1024'
      'Pour le sur'#233'chantillonnage, il faut respecter le crit'#232're de '
      'Shannon (pas de signal carr'#233' !)')
    ReadOnly = True
    TabOrder = 3
    ExplicitWidth = 686
  end
  object BaudRG: TRadioGroup
    Left = 0
    Top = 162
    Width = 810
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Vitesse/baud'
    Columns = 5
    ItemIndex = 0
    Items.Strings = (
      '9600'
      '19200'
      '38400'
      '57600'
      '115200')
    TabOrder = 2
    ExplicitWidth = 686
  end
  object sincGB: TGroupBox
    Left = 0
    Top = 580
    Width = 810
    Height = 176
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Options d'#39'acquisition'
    TabOrder = 4
    ExplicitWidth = 686
    object sincCB: TCheckBox
      Left = 16
      Top = 116
      Width = 264
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sur'#233'chantillonnage x '
      TabOrder = 0
    end
    object ordreSincSE: TSpinEdit
      Left = 290
      Top = 116
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
      Top = 39
      Width = 806
      Height = 80
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Nombre de points'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        '256'
        '512'
        '1024'
        '2048')
      TabOrder = 2
      ExplicitTop = 32
      ExplicitWidth = 682
    end
  end
  object ResolutionRG: TRadioGroup
    Left = 0
    Top = 756
    Width = 810
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'R'#233'solution (bits)'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      '8'
      '10'
      '12 '
      '14')
    TabOrder = 5
    ExplicitWidth = 686
  end
  object Panel1: TPanel
    Left = 0
    Top = 888
    Width = 810
    Height = 342
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 7
    ExplicitWidth = 686
    object OKBtn: TBitBtn
      Left = 16
      Top = 280
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
      Left = 180
      Top = 280
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Aide'
      Default = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333BBBBB3333333300003333
        3BBB191BBB33333300003333BBBB999BBBB333330000333BBBBB191BBBBB3333
        000033BBBBBBBBBBBBBBB333000033BBBBBBB9BBBBBBB33300003BBBBBBBB91B
        BBBBBB3300003BBBBBBBB99BBBBBBB3300003BBBBBBBBB99BBBBBB3300003BBB
        BB11BB199BBBBB3300003BBBBB99BB199BBBBB33000033BBBB991B199BBBB333
        000033BBBBB99999BBBBB3330000333BBBBB999BBBBB333300003333BBBBBBBB
        BBB33333000033333BBBBBBBBB33333300003333333BBBBB3333333300003333
        33333333333333330000}
      ModalResult = 9
      TabOrder = 1
      OnClick = HelpBtnClick
    end
    object DueBtn: TBitBtn
      Left = 16
      Top = 80
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
      Left = 16
      Top = 140
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
      Left = 428
      Top = 78
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
      Left = 344
      Top = 280
      Width = 320
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lancer IDE Arduino'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333133333333333300003333333013333333333300003333
        3331013333333333000033333331901333333333000033333331990133333333
        0000333333319990133333330000333333319999013333330000333333319999
        9013333300003333333199999901333300003333333199999990333300003333
        3331999999033333000033333331999990333333000033333331999903333333
        0000333333319990333333330000333333319903333333330000333333319033
        3333333300003333333103333333333300003333333033333333333300003333
        33333333333333330000}
      TabOrder = 5
      OnClick = arduinoExeBtnClick
    end
    object WifiBtn: TBitBtn
      Left = 16
      Top = 202
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
      Left = 428
      Top = 140
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
  object UdpGB: TGroupBox
    Left = 0
    Top = 836
    Width = 810
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'R'#233'seau'
    TabOrder = 6
    ExplicitWidth = 686
    object HostEdit: TLabeledEdit
      Left = 200
      Top = 62
      Width = 242
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 121
      EditLabel.Height = 37
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Adresse IP'
      TabOrder = 1
      Text = ''
    end
    object PortEdit: TLabeledEdit
      Left = 460
      Top = 62
      Width = 200
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      CharCase = ecUpperCase
      EditLabel.Width = 48
      EditLabel.Height = 37
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Port'
      TabOrder = 2
      Text = ''
    end
    object UdpCB: TCheckBox
      Left = 16
      Top = 64
      Width = 180
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Arduino Wifi'
      TabOrder = 0
    end
  end
  object WifiGB: TGroupBox
    Left = 0
    Top = 80
    Width = 810
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Pas de voie s'#233'rie'
    TabOrder = 1
    ExplicitWidth = 686
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 535
      Height = 37
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Communication avec Arduino par r'#233'seau Wifi'
    end
  end
end
