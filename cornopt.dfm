object CornishOptDlg: TCornishOptDlg
  Left = 401
  Top = 209
  HelpContext = 11
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options Cornish-Bowden'
  ClientHeight = 592
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object LabelNombre: TLabel
    Left = 18
    Top = 202
    Width = 94
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nombre'
  end
  object LabelCibleK: TLabel
    Left = 144
    Top = 282
    Width = 37
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Km'
  end
  object LabelCibleV: TLabel
    Left = 144
    Top = 350
    Width = 62
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Vmax'
  end
  object OKBtn: TBitBtn
    Left = 684
    Top = 20
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&OK'
    Default = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333333333333333300003333
      333333333333333300003333333A0333333333330000333333AAA03333333333
      0000333333AAA03333333333000033333AAAAA033333333300003333AAAAAA03
      3333333300003337AA03AAA0333333330000337A03333AA03333333300003333
      33333AAA0333333300003333333333AA03333333000033333333333AA0333333
      00003333333333337A033333000033333333333337A033330000333333333333
      333AA33300003333333333333333333300003333333333333333333300003333
      33333333333333330000}
    Margin = 2
    ModalResult = 1
    Spacing = -1
    TabOrder = 0
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 684
    Top = 216
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Cancel = True
    Caption = '&Abandon'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777888877777
      8877777700007770888777778887777700007911088877910888777700007911
      0088879100888777000079111008891110087777000079911108911111007777
      0000779111101111110777770000777911111111077777770000777991111111
      8777777700007777991111108877777700007777791111108887777700007777
      7911111088877777000077777911111108887777000077779111991100888777
      0000777911108991100888770000777911187799110088870000777111187779
      1110888700007771110777779111087700007779997777777991777700007777
      77777777779977770000}
    Margin = 2
    ModalResult = 2
    Spacing = -1
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 688
    Top = 378
    Width = 200
    Height = 54
    HelpContext = 308
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Aide'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888800008888888888888888888800008888888887778888888800008888
      8888600788888888000088888888E60788888888000088888888EE6888888888
      000088888888877788888888000088888888600788888888000088888888E607
      78888888000088888888E660778888880000888888888E660778888800008888
      888878E660778888000088888880778E660788880000888888660778E6078888
      0000888888E66077E608888800008888888E660066688888000088888888E666
      6E8888880000888888888EEEE888888800008888888888888888888800008888
      88888888888888880000}
    Margin = 2
    Spacing = -1
    TabOrder = 2
    OnClick = HelpBtnClick
    IsControl = True
  end
  object ClasseGroupe: TRadioGroup
    Left = 2
    Top = -2
    Width = 412
    Height = 180
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Classes'
    Items.Strings = (
      'Amplitude automatique'
      'Nombre impos'#233
      'Amplitude impos'#233'e')
    TabOrder = 3
    OnClick = ClasseGroupeClick
  end
  object NombreSpin: TSpinEdit
    Left = 234
    Top = 192
    Width = 102
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
    MaxValue = 8
    MinValue = 3
    ParentFont = False
    TabOrder = 4
    Value = 3
  end
  object EditCibleK: TEdit
    Left = 234
    Top = 266
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object CibleCB: TCheckBox
    Left = 18
    Top = 270
    Width = 100
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Cible'
    TabOrder = 6
    OnClick = ClasseGroupeClick
  end
  object NomGroupe: TGroupBox
    Left = 426
    Top = 6
    Width = 242
    Height = 236
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Concentration'
    TabOrder = 7
    object ConcentrationListe: TListBox
      Left = 2
      Top = 38
      Width = 238
      Height = 196
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
      OnClick = Modif
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 400
    Width = 414
    Height = 178
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Affichage graphique'
    TabOrder = 8
    object int2SigmaCB: TCheckBox
      Left = 240
      Top = 32
      Width = 98
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #177'2 '#963
      TabOrder = 3
    end
    object int3SigmaCB: TCheckBox
      Left = 240
      Top = 80
      Width = 98
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #177'3 '#963
      TabOrder = 4
    end
    object t95CB: TCheckBox
      Left = 16
      Top = 32
      Width = 210
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #181' '#224' 95 %'
      TabOrder = 0
    end
    object t99CB: TCheckBox
      Left = 16
      Top = 80
      Width = 210
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #181' '#224' 99 %'
      TabOrder = 1
    end
    object MoyenneCB: TCheckBox
      Left = 16
      Top = 128
      Width = 194
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Moyenne m'
      TabOrder = 2
    end
    object MedianeCB: TCheckBox
      Left = 240
      Top = 128
      Width = 146
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'M'#233'diane'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 426
    Top = 240
    Width = 242
    Height = 226
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Vitesse'
    TabOrder = 9
    object VitesseListe: TListBox
      Left = 2
      Top = 38
      Width = 238
      Height = 186
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
      OnClick = Modif
    end
  end
  object EditCibleV: TEdit
    Left = 234
    Top = 334
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
end
