object ArduinoDlg: TArduinoDlg
  Left = 0
  Top = 0
  HelpContext = 80
  AutoSize = True
  Caption = 'Param'#233'trage acquisition par Arduino/Micro:bit'
  ClientHeight = 1278
  ClientWidth = 775
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
    Width = 775
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
  object BaudRG: TRadioGroup
    Left = 0
    Top = 80
    Width = 775
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
  object DureeGB: TGroupBox
    Left = 0
    Top = 320
    Width = 775
    Height = 242
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 4
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
    object LabelCommande: TLabel
      Left = 16
      Top = 96
      Width = 323
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Commande de d'#233'marrage'
    end
    object LabelArret: TLabel
      Left = 16
      Top = 144
      Width = 230
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Commande d'#39'arr'#234't'
    end
    object dureeMaxSE: TSpinEdit
      Left = 480
      Top = 18
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
    object StartEdit: TEdit
      Left = 480
      Top = 86
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      Text = 'StartEdit'
    end
    object monocoupCB: TCheckBox
      Left = 16
      Top = 196
      Width = 194
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Monocoup'
      TabOrder = 2
    end
    object StopEdit: TEdit
      Left = 480
      Top = 140
      Width = 242
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 3
      Text = 'StartEdit'
    end
    object TempsArduinoCB: TCheckBox
      Left = 222
      Top = 196
      Width = 468
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Temps fourni par Arduino/micro:bit'
      TabOrder = 4
    end
  end
  object CommandGB: TGroupBox
    Left = 0
    Top = 562
    Width = 775
    Height = 298
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Boutons de commande'
    TabOrder = 5
    object SendGrid: TStringGrid
      Left = 2
      Top = 40
      Width = 771
      Height = 164
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
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
    end
    object TerminateurRG: TRadioGroup
      Left = 2
      Top = 216
      Width = 771
      Height = 80
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Terminateur'
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Sans'
        'CR 13 $0D'
        'LF  10 $0A'
        'CR+LF')
      ParentFont = False
      TabOrder = 1
    end
  end
  object ModeTempsRG: TRadioGroup
    Left = 0
    Top = 160
    Width = 775
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Balayage'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'D'#233'clench'#233
      'Relax'#233
      'Rouleau')
    ParentFont = False
    TabOrder = 2
    OnClick = ModeTempsRGClick
  end
  object TriggerRG: TRadioGroup
    Left = 0
    Top = 240
    Width = 775
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'D'#233'clenchement'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Seuil montant'
      'Seuil descendant'
      'Bouton')
    ParentFont = False
    TabOrder = 3
  end
  object MemoTemps: TMemo
    Left = 0
    Top = 860
    Width = 775
    Height = 200
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
      'virgules.'
      'Si la case "temps Arduino" est coch'#233'e, la premi'#232're ligne est '
      'le temps en seconde, sinon le temps est g'#233'r'#233' par Regressi.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 1060
    Width = 775
    Height = 217
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 6
    object EtalonBtn: TBitBtn
      Left = 2
      Top = 82
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ex. Arduino avec commande d'#39#233'talonnage '
      NumGlyphs = 2
      TabOrder = 0
      OnClick = ExPointBtnClick
    end
    object exTempsArduinoBtn: TBitBtn
      Left = 2
      Top = 24
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple avec temps g'#233'r'#233' par Arduino'
      NumGlyphs = 2
      TabOrder = 1
      OnClick = ExPointBtnClick
    end
    object arduinoExeBtn: TBitBtn
      Left = 404
      Top = 144
      Width = 314
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lancer IDE Arduino'
      TabOrder = 2
      OnClick = arduinoExeBtnClick
    end
    object Okbtn: TBitBtn
      Left = 2
      Top = 144
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 3
    end
    object HelpBtn: TBitBtn
      Left = 202
      Top = 144
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 4
      OnClick = HelpBtnClick
    end
  end
  object Panel1: TPanel
    Left = 11
    Top = 288
    Width = 750
    Height = 2
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 8
  end
end
