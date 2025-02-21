object ModifDlg: TModifDlg
  Left = 439
  Top = 416
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Grandeurs'
  ClientHeight = 820
  ClientWidth = 770
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
    Top = 140
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
    ImageIndex = 7
    ImageName = 'Item8'
    Images = FValeurs.VirtualImageList1
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
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
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
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
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
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
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
    OnKeyPress = EditUniteKeyPress
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
    Left = 0
    Top = 562
    Width = 770
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Etiquette de graphe = commentaire'
    TabOrder = 7
    ExplicitTop = 561
    ExplicitWidth = 756
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
    Top = 602
    Width = 770
    Height = 218
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Calcul automatique'
    TabOrder = 9
    Visible = False
    ExplicitTop = 601
    ExplicitWidth = 756
    object SpeedButton1: TSpeedButton
      Left = 660
      Top = 80
      Width = 46
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 29
      ImageName = 'warning'
      Images = FValeurs.VirtualImageList1
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
      EditLabel.Height = 44
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
    Left = 0
    Top = 522
    Width = 770
    Height = 40
    Hint = 'Convertit la grandeur calcul'#233'e en une grandeur exp'#233'rimentale'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Figer la grandeur calcul'#233'e'
    TabOrder = 10
    ExplicitTop = 521
    ExplicitWidth = 756
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
    EditLabel.Height = 44
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
    EditLabel.Height = 44
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
    EditLabel.Height = 44
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
  object UniteGrapheImposeeCB: TCheckBox
    Left = 16
    Top = 192
    Width = 300
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Unit'#233' graphe impos'#233'e'
    TabOrder = 14
    OnClick = UniteGrapheImposeeCBClick
  end
  object EditUniteGraphe: TEdit
    Left = 320
    Top = 180
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 15
    OnKeyPress = EditUniteKeyPress
  end
end
