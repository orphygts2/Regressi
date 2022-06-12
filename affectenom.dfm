object AffecteNomDlg: TAffecteNomDlg
  Left = 406
  Top = 194
  BorderStyle = bsDialog
  Caption = 'D'#233'finition des noms'
  ClientHeight = 492
  ClientWidth = 876
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 37
  object StringGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 640
    Height = 430
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ColCount = 3
    DefaultColWidth = 128
    DefaultRowHeight = 48
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor]
    ScrollBars = ssVertical
    TabOrder = 0
    OnSelectCell = StringGridSelectCell
    ColWidths = (
      128
      320
      174)
    RowHeights = (
      48
      48
      48
      48
      48)
  end
  object OKBtn: TBitBtn
    Left = 664
    Top = 32
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
    TabOrder = 1
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 664
    Top = 138
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
    TabOrder = 2
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 664
    Top = 234
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
    TabOrder = 3
    OnClick = HelpBtnClick
    IsControl = True
  end
  object TriCB: TCheckBox
    Left = 16
    Top = 448
    Width = 594
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Les donn'#233'es sont d'#233'j'#224' tri'#233'es dans le fichier'
    TabOrder = 4
  end
end
