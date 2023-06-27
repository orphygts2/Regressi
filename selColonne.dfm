object SelectColonneDlg: TSelectColonneDlg
  Left = 655
  Top = 363
  ActiveControl = OKBtn
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Choix des grandeurs export'#233'es'
  ClientHeight = 460
  ClientWidth = 892
  Color = clBtnFace
  Constraints.MinHeight = 268
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 632
    Top = 16
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
    Left = 632
    Top = 116
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
  object GrandeursListBox: TCheckListBox
    Left = 0
    Top = 0
    Width = 594
    Height = 460
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    ItemHeight = 36
    TabOrder = 2
    ExplicitHeight = 459
  end
  object CSVCB: TCheckBox
    Left = 632
    Top = 224
    Width = 194
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '"Vrai" CSV'
    TabOrder = 3
  end
  object ValeursSeulesCB: TCheckBox
    Left = 632
    Top = 288
    Width = 216
    Height = 34
    Hint = 'Pas d'#39'en t'#234'te (pour Maple, Mathematica ...)'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Valeurs seules '
    TabOrder = 4
  end
end
