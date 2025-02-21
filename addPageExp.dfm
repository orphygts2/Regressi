object AddPageExpDlg: TAddPageExpDlg
  Left = 213
  Top = 249
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Ajout d'#39'une page exp'#233'rimentale'
  ClientHeight = 406
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 192
  TextHeight = 36
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Variables exp'#233'rimentales actuelles'
    TabOrder = 0
    ExplicitWidth = 838
  end
  object Grid: TStringGrid
    Left = 0
    Top = 50
    Width = 852
    Height = 112
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    DefaultColWidth = 128
    DefaultRowHeight = 48
    Enabled = False
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    TabOrder = 1
    ExplicitWidth = 838
  end
  object Panel2: TPanel
    Left = 0
    Top = 162
    Width = 852
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Variables exp'#233'rimentales '#224' ajouter comme nouvelle page'
    TabOrder = 2
    ExplicitWidth = 838
  end
  object OKbtn: TBitBtn
    Left = 76
    Top = 224
    Width = 700
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object AddBtn: TBitBtn
    Left = 76
    Top = 288
    Width = 700
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Ajouter comme nouveau &fichier'
    DoubleBuffered = False
    ImageIndex = 6
    ImageName = 'Item7'
    Images = FRegressiMain.VirtualImageList1
    ModalResult = 6
    TabOrder = 4
  end
  object escBtn: TBitBtn
    Left = 76
    Top = 352
    Width = 700
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    DoubleBuffered = False
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
end
