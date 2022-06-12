object PageCalcDlg: TPageCalcDlg
  Left = 576
  Top = 325
  HelpContext = 1
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Cr'#233'ation d'#39'une page calcul'#233'e'
  ClientHeight = 280
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 196
    Top = 8
    Width = 100
    Height = 27
    Caption = '&OK'
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 196
    Top = 56
    Width = 100
    Height = 27
    Caption = '&Abandon'
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 4
    OnClick = CancelBtnClick
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 196
    Top = 104
    Width = 100
    Height = 27
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 5
    OnClick = HelpBtnClick
    IsControl = True
  end
  object CalculRG: TRadioGroup
    Left = 4
    Top = 4
    Width = 173
    Height = 153
    Caption = 'Type de calcul'
    ItemIndex = 0
    Items.Strings = (
      '&Somme'
      'Mo&yenne'
      'Ma&ximum'
      'Mi&nimum'
      '&Ecart-type'
      '&Autres...')
    TabOrder = 0
    OnClick = CalculRGClick
  end
  object GroupBox: TGroupBox
    Left = 0
    Top = 198
    Width = 308
    Height = 82
    Align = alBottom
    Caption = 'Expression de la nouvelle page'
    TabOrder = 2
    object LabelFonction: TLabel
      Left = 16
      Top = 56
      Width = 212
      Height = 17
      Caption = 'par ex. : page(1)/page(2)+2*page(3)'
    end
    object EditExp: TEdit
      Left = 8
      Top = 24
      Width = 233
      Height = 25
      TabOrder = 0
    end
  end
  object VariabExpGB: TGroupBox
    Left = 0
    Top = 158
    Width = 308
    Height = 40
    Align = alBottom
    TabOrder = 1
    object EditFixe: TLabel
      Left = 156
      Top = 16
      Width = 36
      Height = 17
      Caption = 'temps'
    end
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 127
      Height = 17
      Caption = 'Grandeur commune : '
    end
  end
end
