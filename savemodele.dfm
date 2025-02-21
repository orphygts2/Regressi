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
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object ModeleGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 668
    Height = 97
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    ColCount = 2
    DefaultColWidth = 128
    DefaultRowHeight = 48
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goAlwaysShowEditor]
    TabOrder = 0
    ExplicitWidth = 654
  end
  object BtnPanel: TPanel
    Left = 0
    Top = 94
    Width = 668
    Height = 300
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 93
    ExplicitWidth = 654
    object CancelBtn: TBitBtn
      Left = 80
      Top = 230
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
    object HelpBtn: TBitBtn
      Left = 368
      Top = 230
      Width = 180
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 1
      OnClick = HelpBtnClick
    end
    object SauveParamBtn: TBitBtn
      Left = 16
      Top = 90
      Width = 640
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sauver les param'#232'tres et les valeurs page par page'
      ModalResult = 1
      TabOrder = 2
      OnClick = SauveParamBtnClick
    end
    object SauveParamGlbBtn: TBitBtn
      Left = 16
      Top = 160
      Width = 640
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sauver les param'#232'tres et les valeurs globalement'
      ModalResult = 1
      TabOrder = 3
      OnClick = SauveParamGlbBtnClick
    end
    object SauveValeurBtn: TBitBtn
      Left = 16
      Top = 20
      Width = 640
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sauver les valeurs mod'#233'lis'#233'es dans la variable "Nom"'
      ModalResult = 1
      TabOrder = 4
      OnClick = SauveValeurBtnClick
    end
  end
end
