object SaveHarmoniqueDlg: TSaveHarmoniqueDlg
  Left = 352
  Top = 205
  HelpContext = 311
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la fr'#233'quence courante'
  ClientHeight = 206
  ClientWidth = 1042
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
    Left = 812
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
    Left = 812
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
    Width = 802
    Height = 206
    Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    Caption = 'Param'#232'tres'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    ExplicitHeight = 189
    object Label1: TLabel
      Left = 272
      Top = 20
      Width = 56
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nom'
    end
    object Label4: TLabel
      Left = 704
      Top = 20
      Width = 71
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Valeur'
    end
    object Label2: TLabel
      Left = 424
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
      Width = 190
      Height = 132
      Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      IntegralHeight = True
      ItemHeight = 64
      Items.Strings = (
        'Fr'#233'quence'
        'Amplitude')
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 206
      Top = 56
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 204
      Top = 116
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
    end
    object Edit5: TEdit
      Left = 340
      Top = 56
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 3
    end
    object Edit6: TEdit
      Left = 340
      Top = 116
      Width = 240
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 4
    end
  end
  object Edit3: TEdit
    Left = 592
    Top = 56
    Width = 196
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 3
  end
  object Edit4: TEdit
    Left = 592
    Top = 116
    Width = 196
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 4
  end
end
