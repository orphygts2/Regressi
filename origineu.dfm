object OrigineDlg: TOrigineDlg
  Left = 289
  Top = 296
  HelpContext = 82
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Changement d'#39'origine'
  ClientHeight = 218
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object TempsCourantBtn: TBitBtn
    Left = 6
    Top = 20
    Width = 400
    Height = 48
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ModalResult = 6
    TabOrder = 0
  end
  object NouveauTempsBtn: TBitBtn
    Left = 6
    Top = 86
    Width = 400
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ModalResult = 7
    TabOrder = 1
  end
  object escapeBtn: TBitBtn
    Left = 120
    Top = 152
    Width = 180
    Height = 52
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Cancel = True
    Caption = '&Annuler'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777888877777
      8877777700007770888777778887777700007911088877910888777700007911
      0088879100888777000079111008891110087777000079911108911111007777
      0000779111101111110777770000777911111111077777770000777991111111
      8777777700007777991111108877777700007777791111108887777700007777
      7911111088877777000077777911111108887777000077779111991100888777
      0000777911108991100888770000777911187799110088870000777111187779
      1110888700007771110777779111087700007779997777777991777700007777
      77777777779977770000}
    ModalResult = 2
    TabOrder = 2
  end
end
