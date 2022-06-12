object OptionsAffModeleDlg: TOptionsAffModeleDlg
  Left = 0
  Top = 0
  HelpContext = 55
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Affichage mod'#233'lisation'
  ClientHeight = 618
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object ParamGB: TGroupBox
    Left = 16
    Top = 0
    Width = 226
    Height = 290
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Param'#232'tres'
    TabOrder = 0
    object ListeParamBox: TCheckListBox
      Left = 2
      Top = 38
      Width = 222
      Height = 250
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
    end
  end
  object OKBtn: TBitBtn
    Left = 16
    Top = 548
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
    Left = 414
    Top = 548
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Abandon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    ParentFont = False
    Spacing = -1
    TabOrder = 2
    IsControl = True
  end
  object ListeModeleGB: TGroupBox
    Left = 254
    Top = 2
    Width = 360
    Height = 290
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Mod'#232'le'
    TabOrder = 3
    object ListeModeleBox: TCheckListBox
      Left = 2
      Top = 38
      Width = 356
      Height = 250
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ItemHeight = 36
      TabOrder = 0
    end
  end
  object ModeleNumCB: TCheckBox
    Left = 16
    Top = 454
    Width = 620
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Mod'#232'le avec  valeurs num'#233'riques des param'#232'tres'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object AffCoeffElargCB: TCheckBox
    Left = 16
    Top = 500
    Width = 598
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Affichage du facteur d'#39#233'largissement'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
end
