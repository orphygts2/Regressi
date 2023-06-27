object ArduinoDlg: TArduinoDlg
  Left = 0
  Top = 0
  HelpContext = 80
  Caption = 'Param'#233'trage liaison s'#233'rie Arduino/Micro:bit'
  ClientHeight = 1322
  ClientWidth = 794
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
    Width = 794
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
    ItemIndex = 0
    Items.Strings = (
      'Com1'
      'Com2'
      'Com3'
      'Com4')
    TabOrder = 0
    ExplicitWidth = 780
  end
  object MemoPoint: TMemo
    Left = 0
    Top = 940
    Width = 794
    Height = 120
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de '
      'donn'#233'es '
      'par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules.'
      'La premi'#232're donn'#233'e sera plac'#233'e en abscisse.')
    ReadOnly = True
    TabOrder = 7
    ExplicitWidth = 780
  end
  object BaudRG: TRadioGroup
    Left = 0
    Top = 80
    Width = 794
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
    TabOrder = 1
    ExplicitWidth = 780
  end
  object ModeRG: TRadioGroup
    Left = 0
    Top = 160
    Width = 794
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
    TabOrder = 2
    OnClick = ModeRGClick
    ExplicitWidth = 780
  end
  object DureeGB: TGroupBox
    Left = 0
    Top = 400
    Width = 794
    Height = 242
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 5
    ExplicitWidth = 780
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
      Left = 319
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
      Left = 400
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
      Left = 400
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
      Caption = 'Temps fourni par Arduino (colonne 1)'
      TabOrder = 4
    end
    object UserDataCB: TCheckBox
      Left = 16
      Top = 196
      Width = 674
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Abscisse : donn'#233'e utilisateur (sinon index)'
      TabOrder = 5
    end
  end
  object CommandGB: TGroupBox
    Left = 0
    Top = 642
    Width = 794
    Height = 298
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Boutons de commande'
    TabOrder = 6
    ExplicitWidth = 780
    object SendGrid: TStringGrid
      Left = 2
      Top = 40
      Width = 790
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
      ExplicitWidth = 776
    end
    object TerminateurRG: TRadioGroup
      Left = 2
      Top = 208
      Width = 790
      Height = 88
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Terminateur'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        'Sans'
        'CR 13'
        'LF  10'
        'CR+LF')
      TabOrder = 1
      ExplicitWidth = 776
    end
  end
  object ModeTempsRG: TRadioGroup
    Left = 0
    Top = 240
    Width = 794
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
      'D'#233'clench'#233
      'Relax'#233
      'Rouleau')
    TabOrder = 3
    OnClick = ModeTempsRGClick
    ExplicitWidth = 780
  end
  object TriggerRG: TRadioGroup
    Left = 0
    Top = 320
    Width = 794
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'D'#233'clenchement'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Seuil montant'
      'Seuil descendant'
      'Bouton')
    TabOrder = 4
    ExplicitWidth = 780
  end
  object MemoTemps: TMemo
    Left = 0
    Top = 1060
    Width = 794
    Height = 128
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      'Le logiciel s'#39'attend '#224' ce que Arduino envoie des lignes de '
      'donn'#233'es '
      'par println(), les donn'#233'es '#233'tant s'#233'par'#233'es par des virgules.'
      'Si la case "temps Arduino" est coch'#233'e, la premi'#232're ligne est le '
      'temps en '
      'seconde, sinon le temps est g'#233'r'#233' par Regressi  ')
    ReadOnly = True
    TabOrder = 9
    ExplicitWidth = 780
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 1002
    Width = 794
    Height = 320
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 8
    ExplicitTop = 1001
    ExplicitWidth = 780
    object EtalonBtn: TBitBtn
      Left = 16
      Top = 16
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
    object ExPointBtn: TBitBtn
      Left = 16
      Top = 76
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino point par point'
      NumGlyphs = 2
      TabOrder = 1
      OnClick = ExPointBtnClick
    end
    object exTempsArduinoBtn: TBitBtn
      Left = 16
      Top = 136
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple avec temps g'#233'r'#233' par Arduino'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = ExPointBtnClick
    end
    object ExTempsBtn: TBitBtn
      Left = 16
      Top = 196
      Width = 550
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Exemple Arduino temporel'
      NumGlyphs = 2
      TabOrder = 3
      OnClick = ExPointBtnClick
    end
    object arduinoExeBtn: TBitBtn
      Left = 418
      Top = 256
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
      TabOrder = 4
      OnClick = arduinoExeBtnClick
    end
    object Okbtn: TBitBtn
      Left = 16
      Top = 256
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 5
    end
    object HelpBtn: TBitBtn
      Left = 216
      Top = 256
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 6
      OnClick = HelpBtnClick
    end
    object exPointMBBtn: TBitBtn
      Left = 578
      Top = 76
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'micro:bit'
      DoubleBuffered = False
      NumGlyphs = 2
      TabOrder = 7
      OnClick = ExPointBtnClick
    end
    object extempsmicrobitBtn: TBitBtn
      Left = 578
      Top = 136
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'micro:bit'
      DoubleBuffered = False
      NumGlyphs = 2
      TabOrder = 8
      OnClick = ExPointBtnClick
    end
    object extempsmbbtn: TBitBtn
      Left = 578
      Top = 196
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'micro:bit'
      DoubleBuffered = False
      NumGlyphs = 2
      TabOrder = 9
      OnClick = ExPointBtnClick
    end
    object etalonmbbtn: TBitBtn
      Left = 578
      Top = 16
      Width = 160
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'micro:bit'
      DoubleBuffered = False
      NumGlyphs = 2
      TabOrder = 10
      OnClick = ExPointBtnClick
    end
  end
end
