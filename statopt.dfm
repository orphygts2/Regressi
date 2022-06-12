object StatOptDlg: TStatOptDlg
  Left = 136
  Top = 131
  HelpContext = 56
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Statistique'
  ClientHeight = 852
  ClientWidth = 922
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
    Left = 16
    Top = 254
    Width = 94
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nombre'
  end
  object LabelAmplitude: TLabel
    Left = 16
    Top = 310
    Width = 119
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Amplitude'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object LabelDebut: TLabel
    Left = 14
    Top = 354
    Width = 71
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'D'#233'but'
  end
  object OKBtn: TBitBtn
    Left = 708
    Top = 20
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&OK'
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 708
    Top = 128
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Abandon'
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 708
    Top = 238
    Width = 200
    Height = 54
    HelpContext = 803
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
  object ClasseGroupe: TRadioGroup
    Left = 2
    Top = 0
    Width = 448
    Height = 226
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Classes'
    ItemIndex = 0
    Items.Strings = (
      'Automatique'
      'Nombre de classes impos'#233
      'Amplitude des classes impos'#233'e'
      'Effectif et moyenne donn'#233's'
      'Fr'#233'quence et moyenne donn'#233'es')
    TabOrder = 3
    OnClick = ClasseGroupeClick
  end
  object NombreSpin: TSpinEdit
    Left = 152
    Top = 238
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
    MaxValue = 30
    MinValue = 3
    ParentFont = False
    TabOrder = 4
    Value = 3
  end
  object EditAmplitude: TEdit
    Left = 152
    Top = 294
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
  object EditCible: TEdit
    Left = 152
    Top = 394
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 6
  end
  object CibleCB: TCheckBox
    Left = 16
    Top = 404
    Width = 98
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Cible'
    TabOrder = 7
    OnClick = ClasseGroupeClick
  end
  object NomGroupe: TGroupBox
    Left = 460
    Top = 0
    Width = 242
    Height = 300
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nom'
    TabOrder = 8
    object ListeGr: TListBox
      Left = 2
      Top = 38
      Width = 238
      Height = 260
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
    end
  end
  object EditDebut: TEdit
    Left = 152
    Top = 344
    Width = 180
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 9
  end
  object GrapheGB: TGroupBox
    Left = 0
    Top = 472
    Width = 922
    Height = 156
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Affichage graphique'
    TabOrder = 10
    object int2SigmaCB: TCheckBox
      Left = 208
      Top = 32
      Width = 100
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #177'2 '#963
      TabOrder = 1
    end
    object int3SigmaCB: TCheckBox
      Left = 208
      Top = 72
      Width = 100
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #177'3 '#963
      TabOrder = 5
    end
    object t95CB: TCheckBox
      Left = 16
      Top = 32
      Width = 180
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'ICm '#224' 95 %'
      TabOrder = 0
    end
    object t99CB: TCheckBox
      Left = 16
      Top = 72
      Width = 180
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'ICm '#224' 99 %'
      TabOrder = 4
    end
    object CourbeGaussCB: TCheckBox
      Left = 552
      Top = 32
      Width = 300
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Courbe de Gauss'
      TabOrder = 3
    end
    object DistributionCB: TCheckBox
      Left = 16
      Top = 112
      Width = 180
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Distribution'
      TabOrder = 8
    end
    object MedianeCB: TCheckBox
      Left = 320
      Top = 32
      Width = 224
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'M'#233'diane'
      TabOrder = 2
    end
    object MoyenneCB: TCheckBox
      Left = 320
      Top = 72
      Width = 224
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Moyenne m'
      TabOrder = 6
    end
    object CourbePoissonCB: TCheckBox
      Left = 552
      Top = 112
      Width = 330
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Distribution de Poisson'
      TabOrder = 11
    end
    object GrilleCB: TCheckBox
      Left = 320
      Top = 112
      Width = 224
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Trac'#233' de grille'
      TabOrder = 10
    end
    object CourbeBinomeCB: TCheckBox
      Left = 552
      Top = 72
      Width = 300
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Distribution binomiale'
      TabOrder = 7
    end
    object Int1SigmaCB: TCheckBox
      Left = 208
      Top = 112
      Width = 100
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #177' '#963
      TabOrder = 9
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 628
    Width = 922
    Height = 224
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Notations'
    TabOrder = 11
    object Memo1: TMemo
      Left = 2
      Top = 38
      Width = 918
      Height = 184
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Lines.Strings = (
        'ICmxx : intervalle de confiance sur la moyenne '#224' xx %'
        #963' : '#233'cart type'
        'inexactitude : '#233'cart entre cible et moyenne'
        'CV : coefficient de variation  = ecart type / moyenne'
        'U(m,xx%) : incertitude sur la moyenne '#224' xx %'
        '')
      TabOrder = 0
    end
  end
  object EffectifGB: TGroupBox
    Left = 464
    Top = 304
    Width = 242
    Height = 114
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Effectif'
    TabOrder = 12
    object EffectifCB: TComboBox
      Left = 8
      Top = 44
      Width = 226
      Height = 44
      Hint = 'Nom de la variable donnant l'#39'effectif'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
  end
  object SuperPagesCB: TCheckBox
    Left = 472
    Top = 410
    Width = 352
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Superposition des pages'
    TabOrder = 13
  end
end
