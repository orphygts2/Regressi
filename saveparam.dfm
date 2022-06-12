object SaveParamDlg: TSaveParamDlg
  Left = 447
  Top = 224
  HelpContext = 61
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Sauvegarde'
  ClientHeight = 444
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 328
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
    Left = 328
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 290
    Height = 322
    Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Param'#232'tres '#224' sauver'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object ParamListBox: TCheckListBox
      Left = 2
      Top = 38
      Width = 286
      Height = 282
      Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
    end
  end
  object HelpBtn: TBitBtn
    Left = 328
    Top = 240
    Width = 200
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
  object Memo1: TMemo
    Left = 0
    Top = 332
    Width = 538
    Height = 112
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Lines.Strings = (
      'Transforme'
      'les param'#232'tres de mod'#233'lisation '
      'en param'#232'tres exp'#233'rimentaux.')
    TabOrder = 4
    ExplicitTop = 336
  end
end
