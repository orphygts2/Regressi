object PageDistribDlg: TPageDistribDlg
  Left = 549
  Top = 83
  HelpContext = 10
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Distribution des variables d'#39'une page en plusieurs pages'
  ClientHeight = 233
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 17
  object LabelY: TLabel
    Left = 8
    Top = 112
    Width = 4
    Height = 17
  end
  object LabelX: TLabel
    Left = 8
    Top = 80
    Width = 4
    Height = 17
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 245
    Height = 17
    Caption = 'Grandeurs '#224' conserver dans chaque page'
  end
  object Panel1: TPanel
    Left = 264
    Top = 0
    Width = 119
    Height = 233
    HelpContext = 10
    Align = alRight
    TabOrder = 0
    object HelpBtn: TBitBtn
      Left = 9
      Top = 152
      Width = 100
      Height = 27
      Kind = bkHelp
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 0
      OnClick = HelpBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 9
      Top = 80
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
    object OKBtn: TBitBtn
      Left = 9
      Top = 8
      Width = 100
      Height = 27
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
    Left = 8
    Top = 31
    Width = 233
    Height = 196
    Hint = '|Cocher les param'#232'tres '#224' conserver'
    IntegralHeight = True
    ItemHeight = 32
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
