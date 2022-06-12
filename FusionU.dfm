object FusionDlg: TFusionDlg
  Left = 523
  Top = 277
  HelpContext = 28
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Fusion de fichier'
  ClientHeight = 360
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 74
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Label1'
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 176
    Width = 638
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Cr'#233'er une nouvelle grandeur exp'#233'rimentale'
    Kind = bkYes
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 238
    Width = 402
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Mettre '#224' la place de '
    Kind = bkNo
    NumGlyphs = 2
    TabOrder = 1
  end
  object HelpBtn: TBitBtn
    Left = 16
    Top = 114
    Width = 242
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkAbort
    NumGlyphs = 2
    TabOrder = 2
  end
  object NomCB: TComboBox
    Left = 430
    Top = 238
    Width = 224
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 3
    Text = 'NomCB'
  end
end
