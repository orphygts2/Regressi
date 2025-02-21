object unitGrapheDlg: TunitGrapheDlg
  Left = 406
  Top = 194
  BorderStyle = bsDialog
  Caption = 'Unit'#233' du graphe'
  ClientHeight = 348
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 38
  object OKBtn: TBitBtn
    Left = 408
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
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 408
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
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 408
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
    TabOrder = 2
    OnClick = HelpBtnClick
    IsControl = True
  end
  object xGB: TGroupBox
    Left = 11
    Top = 11
    Width = 370
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Abscisse'
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 87
      Width = 66
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233
    end
    object UniteXCB: TCheckBox
      Left = 12
      Top = 41
      Width = 340
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233' graphe impos'#233'e'
      TabOrder = 0
      OnClick = UniteXCBClick
    end
    object EditUniteX: TEdit
      Left = 100
      Top = 87
      Width = 180
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      OnKeyPress = EditUniteYKeyPress
    end
  end
  object yGB: TGroupBox
    Left = 11
    Top = 173
    Width = 370
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Ordonn'#233'e'
    TabOrder = 4
    object Label2: TLabel
      Left = 12
      Top = 103
      Width = 66
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233
    end
    object UniteYCB: TCheckBox
      Left = 12
      Top = 48
      Width = 340
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233' graphe impos'#233'e'
      TabOrder = 0
      OnClick = UniteYCBClick
    end
    object EditUniteY: TEdit
      Left = 100
      Top = 94
      Width = 180
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      OnKeyPress = EditUniteYKeyPress
    end
  end
end
