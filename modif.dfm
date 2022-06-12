object ModifDlg: TModifDlg
  Left = 439
  Top = 416
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Grandeurs'
  ClientHeight = 818
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 272
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Symbole de la grandeur'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 236
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Unit'#233' de la grandeur'
  end
  object Label4: TLabel
    Left = 16
    Top = 240
    Width = 81
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Format'
  end
  object Bevel: TBevel
    Left = 512
    Top = 0
    Width = 244
    Height = 210
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object GenreLabel: TLabel
    Left = 16
    Top = 144
    Width = 67
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'genre'
  end
  object LabelPrecision: TLabel
    Left = 384
    Top = 240
    Width = 250
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nombre de d'#233'cimales'
  end
  object IncertitudeHelpBtn: TSpeedButton
    Left = 678
    Top = 300
    Width = 50
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333333333333333300003333
      3333333333333333000033330033333333003333000033300003333330000333
      0000330000000000000000330000330F77FFFF7FFF77F0330000330FFF9FFF7F
      FFFF80330000330FF999FF70000003330000330FFF9FFF07777033330000330F
      FFFFFF0777033333000033800000000000333333000033333333393999393333
      0000333333333333933333330000333333333393339333330000333333333333
      9333333300003333333333333333333300003333333333333333333300003333
      33333333333333330000}
    OnClick = IncertitudeHelpBtnClick
  end
  object OKBtn: TBitBtn
    Left = 536
    Top = 16
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
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 536
    Top = 80
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
    OnClick = CancelBtnClick
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 536
    Top = 144
    Width = 200
    Height = 54
    HelpContext = 38
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
  object EditNom: TEdit
    Left = 320
    Top = 16
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    MaxLength = 8
    TabOrder = 3
    OnKeyPress = EditNomKeyPress
  end
  object EditUnite: TEdit
    Left = 320
    Top = 80
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    MaxLength = 20
    TabOrder = 4
  end
  object PrecisionCB: TComboBox
    Left = 112
    Top = 228
    Width = 242
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    DropDownCount = 11
    TabOrder = 5
    OnChange = PrecisionCBChange
    Items.Strings = (
      'D'#233'faut'
      'Exponentiel'
      'Fixe'
      's -> hh:mm:ss'
      'Date et heure'
      'Date'
      'Heure'
      'Degr'#233' minute '
      'Binaire'
      'Hexa')
  end
  object RazIncertitudeBtn: TBitBtn
    Left = 602
    Top = 300
    Width = 64
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'R'#224'Z'
    TabOrder = 6
    OnClick = RazIncertitudeBtnClick
  end
  object AffSignifCB: TCheckBox
    Left = 16
    Top = 482
    Width = 642
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Etiquette de graphe = commentaire'
    TabOrder = 7
  end
  object PrecisionSE: TSpinEdit
    Left = 660
    Top = 228
    Width = 80
    Height = 56
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxValue = 9
    MinValue = 1
    ParentFont = False
    TabOrder = 8
    Value = 5
  end
  object CalculExpGB: TGroupBox
    Left = 0
    Top = 600
    Width = 756
    Height = 218
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Calcul automatique'
    TabOrder = 9
    Visible = False
    object Image2: TImage
      Left = 668
      Top = 78
      Width = 20
      Height = 20
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Picture.Data = {
        07544269746D617066010000424D660100000000000076000000280000001400
        0000140000000100040000000000F00000000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFFFFFFF0000F999999999999999999F0000F99999999999
        9999999F0000FF99FFFFFFFFFFFF99FF0000FF99FFFFF00FFFFF99FF0000FFF9
        9FFFF00FFFF99FFF0000FFF99FFFFFFFFFF99FFF0000FFFF99FFF00FFF99FFFF
        0000FFFF99FFF00FFF99FFFF0000FFFFF99FF00FF99FFFFF0000FFFFF99FF00F
        F99FFFFF0000FFFFF99FF00FF99FFFFF0000FFFFFF99F00F99FFFFFF0000FFFF
        FF99F00F99FFFFFF0000FFFFFFF99FF99FFFFFFF0000FFFFFFF99FF99FFFFFFF
        0000FFFFFFFF9999FFFFFFFF0000FFFFFFFF9999FFFFFFFF0000FFFFFFFFF99F
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000}
      Stretch = True
      Transparent = True
    end
    object ExpressionEdit: TLabeledEdit
      Left = 144
      Top = 160
      Width = 572
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 121
      EditLabel.Height = 36
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Expression'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = ''
    end
    object Memo1: TMemo
      Left = 8
      Top = 34
      Width = 652
      Height = 120
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Lines.Strings = (
        'Donner l'#39'expression pour remplir automatiquement la '
        'grandeur, ceci uniquement dans la page courante'
        'A utiliser avec pr'#233'cautions !')
      TabOrder = 1
    end
  end
  object CalculVersExpCB: TCheckBox
    Left = 16
    Top = 546
    Width = 700
    Height = 34
    Hint = 'Convertit la grandeur calcul'#233'e en une grandeur exp'#233'rimentale'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Figer la grandeur calcul'#233'e'
    TabOrder = 10
  end
  object EditComm: TLabeledEdit
    Left = 174
    Top = 420
    Width = 580
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 155
    EditLabel.Height = 36
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'Commentaire'
    LabelPosition = lpLeft
    TabOrder = 11
    Text = ''
  end
  object EditIncertitude: TLabeledEdit
    Left = 200
    Top = 302
    Width = 392
    Height = 44
    Hint = '|Expression de l'#39'incertitude'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 186
    EditLabel.Height = 36
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'Incertitude-type'
    LabelPosition = lpLeft
    TabOrder = 12
    Text = ''
    OnKeyPress = EditIncertitude_TypeBKeyPress
  end
  object EditIncertitude_TypeB: TLabeledEdit
    Left = 360
    Top = 362
    Width = 392
    Height = 44
    Hint = '|Deuxi'#232'me cause d'#39'incertitude (par ex. type B vs type A)'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 344
    EditLabel.Height = 36
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'Deuxi'#232'me incertitude (A vs. B)'
    LabelPosition = lpLeft
    TabOrder = 13
    Text = ''
    OnKeyPress = EditIncertitude_TypeBKeyPress
  end
end
