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
  OnCreate = FormCreate
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
    Caption = '&OK : ajouter comme nouvelle page'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333333333333333300003333
      3333333333333333000033333339033333333333000033333399903333333333
      0000333333999033333333330000333339999903333333330000333399999903
      3333333300003338990399903333333300003389033339903333333300003333
      3333399903333333000033333333339903333333000033333333333990333333
      0000333333333333890333330000333333333333389033330000333333333333
      3339933300003333333333333333333300003333333333333333333300003333
      33333333333333330000}
    ModalResult = 1
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
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333222222333333300003333
      33322222233333330000333333322AA2233333330000333333322AA223333333
      0000333333322AA2233333330000332222222AA2222222330000332222222AA2
      2222223300003322AAAAAAAAAAAA223300003322AAAAAAAAAAAA223300003322
      22222AA2222222330000332222222AA2222222330000333333322AA223333333
      0000333333322AA2233333330000333333322AA2233333330000333333322222
      2333333300003333333222222333333300003333333333333333333300003333
      33333333333333330000}
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
