object PageCalcDlg: TPageCalcDlg
  Left = 576
  Top = 325
  HelpContext = 1
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Cr'#233'ation d'#39'une page calcul'#233'e'
  ClientHeight = 560
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 392
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
    TabOrder = 3
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 392
    Top = 112
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
    TabOrder = 4
    OnClick = CancelBtnClick
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 392
    Top = 208
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
    TabOrder = 5
    OnClick = HelpBtnClick
    IsControl = True
  end
  object CalculRG: TRadioGroup
    Left = 8
    Top = 8
    Width = 346
    Height = 306
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
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
    Top = 396
    Width = 622
    Height = 164
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Expression de la nouvelle page'
    TabOrder = 2
    ExplicitTop = 395
    ExplicitWidth = 630
    object LabelFonction: TLabel
      Left = 32
      Top = 112
      Width = 410
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'par ex. : page(1)/page(2)+2*page(3)'
    end
    object EditExp: TEdit
      Left = 16
      Top = 48
      Width = 466
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
  end
  object VariabExpGB: TGroupBox
    Left = 0
    Top = 316
    Width = 622
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 315
    ExplicitWidth = 630
    object EditFixe: TLabel
      Left = 312
      Top = 32
      Width = 71
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'temps'
    end
    object Label1: TLabel
      Left = 22
      Top = 32
      Width = 250
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Grandeur commune : '
    end
  end
end
