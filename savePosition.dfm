object SavePositionDlg: TSavePositionDlg
  Left = 352
  Top = 205
  HelpContext = 62
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la position'
  ClientHeight = 191
  ClientWidth = 461
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
    Left = 356
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
    Left = 356
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
    Width = 353
    Height = 191
    Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
    Align = alLeft
    Caption = 'Param'#232'tres '#224' sauver'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object Label1: TLabel
      Left = 160
      Top = 10
      Width = 29
      Height = 17
      Caption = 'Nom'
    end
    object Label2: TLabel
      Left = 240
      Top = 10
      Width = 70
      Height = 17
      Caption = 'Signification'
    end
    object ParamListBox: TCheckListBox
      Left = 2
      Top = 19
      Width = 151
      Height = 170
      Hint = '|Cocher les param'#232'tres '#224' sauvegarder'
      Align = alLeft
      IntegralHeight = True
      ItemHeight = 32
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
      Left = 158
      Top = 26
      Width = 64
      Height = 25
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 158
      Top = 58
      Width = 64
      Height = 25
      TabOrder = 2
    end
    object Edit3: TEdit
      Left = 158
      Top = 90
      Width = 64
      Height = 25
      TabOrder = 3
    end
    object Edit4: TEdit
      Left = 158
      Top = 122
      Width = 64
      Height = 25
      TabOrder = 4
    end
    object Edit5: TEdit
      Left = 226
      Top = 26
      Width = 120
      Height = 25
      TabOrder = 5
    end
    object Edit6: TEdit
      Left = 226
      Top = 58
      Width = 120
      Height = 25
      TabOrder = 6
    end
    object Edit7: TEdit
      Left = 226
      Top = 90
      Width = 120
      Height = 25
      TabOrder = 7
    end
    object Edit8: TEdit
      Left = 226
      Top = 122
      Width = 120
      Height = 25
      TabOrder = 8
    end
    object Edit9: TEdit
      Left = 158
      Top = 154
      Width = 64
      Height = 25
      TabOrder = 9
    end
    object Edit10: TEdit
      Left = 225
      Top = 154
      Width = 120
      Height = 25
      TabOrder = 10
    end
  end
  object HelpBtn: TBitBtn
    Left = 356
    Top = 120
    Width = 100
    Height = 25
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 3
    OnClick = HelpBtnClick
  end
end
