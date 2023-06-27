object SaveModeleDlg: TSaveModeleDlg
  Left = 376
  Top = 207
  HelpContext = 61
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la mod'#232'lisation'
  ClientHeight = 394
  ClientWidth = 668
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
  object LabelExp: TLabel
    Left = 16
    Top = 16
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object Label1: TLabel
    Left = 16
    Top = 58
    Width = 313
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nom de la grandeur cr'#233#233'e :'
  end
  object CancelBtn: TBitBtn
    Left = 112
    Top = 318
    Width = 180
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 0
    IsControl = True
  end
  object EditNom: TEdit
    Left = 368
    Top = 52
    Width = 108
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object HelpBtn: TBitBtn
    Left = 368
    Top = 318
    Width = 180
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 2
    OnClick = HelpBtnClick
  end
  object SauveValeurBtn: TBitBtn
    Left = 16
    Top = 128
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les valeurs mod'#233'lis'#233'es'
    ModalResult = 1
    TabOrder = 3
    OnClick = SauveValeurBtnClick
  end
  object SauveParamBtn: TBitBtn
    Left = 16
    Top = 192
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les param'#232'tres et les valeurs page par page'
    ModalResult = 1
    TabOrder = 4
    OnClick = SauveParamBtnClick
  end
  object SauveParamGlbBtn: TBitBtn
    Left = 16
    Top = 256
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les param'#232'tres et les valeurs globalement'
    ModalResult = 1
    TabOrder = 5
    OnClick = SauveParamGlbBtnClick
  end
end
