object SaveHarmoniqueDlg: TSaveHarmoniqueDlg
  Left = 352
  Top = 205
  HelpContext = 311
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la fr'#233'quence courante'
  ClientHeight = 95
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 404
    Top = 8
    Width = 100
    Height = 27
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
    Left = 404
    Top = 64
    Width = 100
    Height = 27
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
    Width = 401
    Height = 95
    Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
    Align = alLeft
    Caption = 'Param'#232'tres'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object Label1: TLabel
      Left = 136
      Top = 10
      Width = 29
      Height = 17
      Caption = 'Nom'
    end
    object Label4: TLabel
      Left = 352
      Top = 10
      Width = 36
      Height = 17
      Caption = 'Valeur'
    end
    object Label2: TLabel
      Left = 212
      Top = 10
      Width = 70
      Height = 17
      Caption = 'Signification'
    end
    object ParamListBox: TCheckListBox
      Left = 2
      Top = 19
      Width = 95
      Height = 68
      Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
      Align = alLeft
      IntegralHeight = True
      ItemHeight = 32
      Items.Strings = (
        'Fr'#233'quence'
        'Amplitude')
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 103
      Top = 28
      Width = 64
      Height = 25
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 102
      Top = 58
      Width = 64
      Height = 25
      TabOrder = 2
    end
    object Edit5: TEdit
      Left = 170
      Top = 28
      Width = 120
      Height = 25
      TabOrder = 3
    end
    object Edit6: TEdit
      Left = 170
      Top = 58
      Width = 120
      Height = 25
      TabOrder = 4
    end
  end
  object Edit3: TEdit
    Left = 296
    Top = 28
    Width = 98
    Height = 25
    TabOrder = 3
  end
  object Edit4: TEdit
    Left = 296
    Top = 58
    Width = 98
    Height = 25
    TabOrder = 4
  end
end
