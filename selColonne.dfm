object SelectColonneDlg: TSelectColonneDlg
  Left = 655
  Top = 363
  ActiveControl = OKBtn
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Choix des grandeurs export'#233'es'
  ClientHeight = 230
  ClientWidth = 432
  Color = clBtnFace
  Constraints.MinHeight = 160
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 316
    Top = 8
    Width = 100
    Height = 27
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
    Left = 316
    Top = 58
    Width = 100
    Height = 27
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
    Width = 297
    Height = 230
    Align = alLeft
    ItemHeight = 15
    TabOrder = 2
  end
  object CSVCB: TCheckBox
    Left = 316
    Top = 112
    Width = 97
    Height = 17
    Caption = '"Vrai" CSV'
    TabOrder = 3
  end
  object ValeursSeulesCB: TCheckBox
    Left = 316
    Top = 144
    Width = 108
    Height = 17
    Hint = 'Pas d'#39'en t'#234'te (pour Maple, Mathematica ...)'
    Caption = 'Valeurs seules '
    TabOrder = 4
  end
end
