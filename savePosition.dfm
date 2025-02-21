object SavePositionDlg: TSavePositionDlg
  Left = 352
  Top = 205
  HelpContext = 62
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la position'
  ClientHeight = 382
  ClientWidth = 950
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
  object OKBtn: TBitBtn
    Left = 720
    Top = 16
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
    Left = 720
    Top = 128
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 706
    Height = 382
    Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    Caption = 'Param'#232'tres '#224' sauver'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    ExplicitHeight = 381
    object Label1: TLabel
      Left = 320
      Top = 20
      Width = 56
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nom'
    end
    object Label2: TLabel
      Left = 480
      Top = 20
      Width = 140
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Signification'
    end
    object ParamListBox: TCheckListBox
      Left = 2
      Top = 38
      Width = 302
      Height = 324
      Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      IntegralHeight = True
      ItemHeight = 64
      Items.Strings = (
        'x'
        'y'
        'dx'
        'dy'
        'pente')
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 316
      Top = 52
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 316
      Top = 116
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
    end
    object Edit3: TEdit
      Left = 316
      Top = 180
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 316
      Top = 244
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 4
    end
    object Edit5: TEdit
      Left = 452
      Top = 52
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 5
    end
    object Edit6: TEdit
      Left = 452
      Top = 116
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 6
    end
    object Edit7: TEdit
      Left = 452
      Top = 180
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 7
    end
    object Edit8: TEdit
      Left = 452
      Top = 244
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 8
    end
    object Edit9: TEdit
      Left = 316
      Top = 308
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 9
    end
    object Edit10: TEdit
      Left = 450
      Top = 308
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 10
    end
  end
  object HelpBtn: TBitBtn
    Left = 720
    Top = 240
    Width = 200
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 3
    OnClick = HelpBtnClick
  end
end
