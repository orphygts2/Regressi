object PageDistribDlg: TPageDistribDlg
  Left = 549
  Top = 83
  HelpContext = 10
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Distribution des variables d'#39'une page en plusieurs pages'
  ClientHeight = 466
  ClientWidth = 794
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
  object LabelY: TLabel
    Left = 16
    Top = 224
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object LabelX: TLabel
    Left = 16
    Top = 160
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 473
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Grandeurs '#224' conserver dans chaque page'
  end
  object Panel1: TPanel
    Left = 556
    Top = 0
    Width = 238
    Height = 466
    HelpContext = 10
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 0
    ExplicitLeft = 542
    ExplicitHeight = 465
    object HelpBtn: TBitBtn
      Left = 18
      Top = 304
      Width = 200
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 0
      OnClick = HelpBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 18
      Top = 160
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
    object OKBtn: TBitBtn
      Left = 18
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
      TabOrder = 2
      OnClick = OKBtnClick
      IsControl = True
    end
  end
  object ParamListBox: TCheckListBox
    Left = 16
    Top = 62
    Width = 466
    Height = 388
    Hint = '|Cocher les param'#232'tres '#224' conserver'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    IntegralHeight = True
    ItemHeight = 64
    Items.Strings = (
      'x'
      'y'
      'dx'
      'dy'
      'pente')
    Style = lbOwnerDrawFixed
    TabOrder = 1
  end
end
