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
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
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
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
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
