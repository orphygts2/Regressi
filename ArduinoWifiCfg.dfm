object ArduinoWifiDlg: TArduinoWifiDlg
  Left = 0
  Top = 0
  HelpContext = 80
  Caption = 'Param'#233'trage liaison s'#233'rie Arduino'
  ClientHeight = 1082
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 37
  object MemoPoint: TMemo
    Left = 0
    Top = 588
    Width = 796
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      
        'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de donn'#233 +
        'es '
      'par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules.'
      'La premi'#232're donn'#233'e sera plac'#233'e en abscisse.')
    ReadOnly = True
    TabOrder = 4
  end
  object ModeRG: TRadioGroup
    Left = 0
    Top = 0
    Width = 796
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Mode d'#39'acquisition'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Point par point'
      'Temporel')
    TabOrder = 0
    OnClick = ModeRGClick
    ExplicitWidth = 748
  end
  object DureeGB: TGroupBox
    Left = 0
    Top = 160
    Width = 796
    Height = 220
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 748
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 291
      Height = 37
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Dur'#233'e de l'#39'acquisition (s)'
    end
    object Label2: TLabel
      Left = 16
      Top = 96
      Width = 138
      Height = 37
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Commande'
    end
    object Label3: TLabel
      Left = 16
      Top = 152
      Width = 366
      Height = 37
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
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      Text = 'GetEdit'
    end
    object TechSE: TSpinEdit
      Left = 394
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
    Width = 796
    Height = 208
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Boutons de commande'
    TabOrder = 3
    ExplicitWidth = 748
    object SendGrid: TStringGrid
      Left = 2
      Top = 39
      Width = 792
      Height = 167
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
      ExplicitTop = 32
      ExplicitWidth = 744
      ExplicitHeight = 174
    end
  end
  object ModeTempsRG: TRadioGroup
    Left = 0
    Top = 80
    Width = 796
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Mode temporel'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Monocoup'
      'Relax'#233
      'Rouleau')
    TabOrder = 1
    ExplicitWidth = 748
  end
  object MemoTemps: TMemo
    Left = 0
    Top = 708
    Width = 796
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      
        'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de donn'#233 +
        'es '
      'par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules.'
      'Le temps est g'#233'r'#233' par le PC et sera l'#39'abscisse')
    ReadOnly = True
    TabOrder = 5
  end
  object UdpGB: TGroupBox
    Left = 0
    Top = 828
    Width = 796
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'R'#233'seau'
    TabOrder = 6
    ExplicitTop = 788
    ExplicitWidth = 748
    object HostEdit: TLabeledEdit
      Left = 216
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
      TabOrder = 0
      Text = ''
      OnKeyPress = HostEditKeyPress
    end
    object PortEdit: TLabeledEdit
      Left = 480
      Top = 62
      Width = 242
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
      TabOrder = 1
      Text = ''
      OnKeyPress = PortEditKeyPress
    end
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 912
    Width = 796
    Height = 170
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 7
    ExplicitWidth = 748
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
      TabOrder = 3
      OnClick = HelpBtnClick
    end
  end
end
