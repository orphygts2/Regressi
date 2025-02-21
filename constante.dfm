object ConstanteUnivDlg: TConstanteUnivDlg
  Left = 338
  Top = 163
  HelpContext = 15
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Constantes universelles'
  ClientHeight = 620
  ClientWidth = 950
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object HelpBtn: TBitBtn
    Left = 706
    Top = 328
    Width = 220
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
    Visible = False
    OnClick = HelpBtnClick
    IsControl = True
  end
  object Tableau: TStringGrid
    Left = 0
    Top = 0
    Width = 690
    Height = 514
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ColCount = 3
    DefaultColWidth = 128
    DefaultRowHeight = 48
    FixedCols = 0
    RowCount = 20
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    ScrollBars = ssVertical
    TabOrder = 1
    ColWidths = (
      130
      252
      262)
    RowHeights = (
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48
      48)
  end
  object SaveBtn: TBitBtn
    Left = 704
    Top = 40
    Width = 220
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Enregistrer'
    Default = True
    ImageIndex = 6
    ImageName = 'Item7'
    Images = FRegressiMain.VirtualImageList1
    ModalResult = 1
    TabOrder = 2
    OnClick = SaveBtnClick
  end
  object DefautBtn: TBitBtn
    Left = 704
    Top = 184
    Width = 220
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&D'#233'faut'
    Images = FRegressiMain.VirtualImageList1
    NumGlyphs = 2
    TabOrder = 3
    OnClick = DefautBtnClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 518
    Width = 950
    Height = 102
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Lines.Strings = (
      'La valeur doit '#234'tre '#233'crite sous la forme'
      'nom=valeur_unit'
      '')
    TabOrder = 4
    ExplicitTop = 517
    ExplicitWidth = 874
  end
end
