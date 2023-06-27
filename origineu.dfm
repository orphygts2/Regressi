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
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
