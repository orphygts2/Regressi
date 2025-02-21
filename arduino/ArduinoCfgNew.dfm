object ArduinoNewDlg: TArduinoNewDlg
  Left = 0
  Top = 0
  HelpContext = 80
  AutoSize = True
  Caption = 'Param'#233'trage liaison s'#233'rie Arduino'
  ClientHeight = 1203
  ClientWidth = 768
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
    Top = 150
    Width = 768
    Height = 80
    Hint = 
      'La vitesse est r'#233'gl'#233'e dans Arduino '#224' x bauds par Serial.begin(x)' +
      ';'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Voie s'#233'rie'
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
  end
  object MemoPoint: TMemo
    Left = 0
    Top = 540
    Width = 768
    Height = 143
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie'
      'des lignes de donn'#233'es par Serial.println(), '
      'les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules.')
    ReadOnly = True
    TabOrder = 4
  end
  object BaudRG: TRadioGroup
    Left = 0
    Top = 230
    Width = 768
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
  end
  object ModeRG: TRadioGroup
    Left = 0
    Top = 310
    Width = 768
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
      'Temporelle'
      'Entr'#233'e clavier'
      'Barre d'#39'espace')
    ParentFont = False
    TabOrder = 2
    OnClick = ModeRGClick
  end
  object DureeGB: TGroupBox
    Left = 0
    Top = 390
    Width = 768
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 3
    object LabelDuree: TLabel
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
    object LabelDeltat: TLabel
      Left = 16
      Top = 102
      Width = 335
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'P'#233'riode '#233'chantillonnage (s)'
    end
    object dureeMaxSE: TSpinEdit
      Left = 360
      Top = 12
      Width = 100
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
      MaxValue = 4096
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
    end
    object DeltatSE: TSpinEdit
      Left = 360
      Top = 82
      Width = 100
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
      MaxValue = 60
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 1
    end
    object nomClavierEdit: TLabeledEdit
      Left = 64
      Top = 50
      Width = 209
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 269
      EditLabel.Height = 38
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Nom grandeur clavier'
      TabOrder = 2
      Text = ''
    end
    object UniteClavierEdit: TLabeledEdit
      Left = 472
      Top = 50
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 274
      EditLabel.Height = 38
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Unit'#233' grandeur clavier'
      TabOrder = 3
      Text = ''
    end
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 1052
    Width = 768
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 5
    object ExPointBtn: TBitBtn
      Left = 96
      Top = 12
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino'
      NumGlyphs = 2
      TabOrder = 0
      OnClick = ExPointBtnClick
    end
    object arduinoExeBtn: TBitBtn
      Left = 418
      Top = 74
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
      Top = 74
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
      Left = 216
      Top = 74
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 683
    Width = 768
    Height = 369
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Grandeurs envoy'#233'es par Arduino'
    TabOrder = 6
    object grid: TStringGrid
      Left = 2
      Top = 40
      Width = 764
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
    end
  end
  object Panel1: TPanel
    Left = 4
    Top = 244
    Width = 750
    Height = 2
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 7
  end
  object AvecDemandeRG: TRadioGroup
    Left = 0
    Top = 0
    Width = 768
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Envoi des donn'#233'es par Arduino'
    Items.Strings = (
      'Contr'#244'l'#233' par Arduino '
      'En r'#233'ponse '#224' l'#39'envoi de ? par le PC')
    TabOrder = 8
  end
end
