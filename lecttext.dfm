object LectureTexteDlg: TLectureTexteDlg
  Left = 136
  Top = 151
  HelpContext = 57
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Texte'
  ClientHeight = 343
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 324
    Top = 24
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
    Left = 324
    Top = 96
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
  object HelpBtn: TBitBtn
    Left = 324
    Top = 160
    Width = 100
    Height = 27
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
    OnClick = HelpBtnClick
    IsControl = True
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 313
    Height = 343
    ActivePage = OptionsTab
    Align = alLeft
    TabOrder = 3
    object TexteTab: TTabSheet
      Caption = 'Texte'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 0
        Top = 220
        Width = 305
        Height = 17
        Align = alBottom
        Caption = 'Syntaxe des options'
        ExplicitWidth = 117
      end
      object Edit: TMemo
        Left = 0
        Top = 0
        Width = 305
        Height = 81
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 255
        ParentFont = False
        TabOrder = 0
      end
      object PageGB: TGroupBox
        Left = 0
        Top = 144
        Width = 305
        Height = 76
        Align = alBottom
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 48
          Width = 194
          Height = 17
          Caption = 'Page nulle signifie page courante'
        end
        object Label3: TLabel
          Left = 8
          Top = 17
          Width = 40
          Height = 17
          Caption = 'Page : '
        end
        object NumeroPageSE: TSpinEdit
          Left = 54
          Top = 15
          Width = 54
          Height = 27
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
      object Memo: TMemo
        Left = 0
        Top = 237
        Width = 305
        Height = 74
        Align = alBottom
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          '%X (resp. Y)= valeur de l'#39#39'abscisse (resp. ordonn'#233'e)'
          '%S = signification de la page'
          '%Ci = valeur du i'#232'me param'#232'tre exp'#233'rimental ou calcul'#233
          '%Pi = valeur du i'#232'me param'#232'tre de mod'#233'lisation'
          '%Mi = expression du i'#232'me mod'#232'le')
        ParentFont = False
        TabOrder = 2
      end
    end
    object OptionsTab: TTabSheet
      HelpType = htKeyword
      HelpKeyword = 'Options texte'
      Caption = 'Options'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object LabelTaille: TLabel
        Left = 8
        Top = 58
        Width = 142
        Height = 17
        Caption = 'Taille (en % du graphe) :'
      end
      object CouleurComboLabel: TLabel
        Left = 8
        Top = 88
        Width = 174
        Height = 17
        Caption = 'Couleur du texte et des lignes'
      end
      object CadreCB: TCheckBox
        Left = 8
        Top = 8
        Width = 73
        Height = 17
        Caption = '&Cadre'
        TabOrder = 0
      end
      object LigneRappelCB: TCheckBox
        Left = 80
        Top = 8
        Width = 129
        Height = 17
        Caption = '&Ligne de rappel'
        TabOrder = 1
      end
      object VerticalCB: TCheckBox
        Left = 216
        Top = 8
        Width = 81
        Height = 17
        Caption = '&Vertical'
        TabOrder = 2
      end
      object SpinEditHauteur: TSpinEdit
        Left = 190
        Top = 56
        Width = 52
        Height = 31
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 20
        MinValue = 1
        ParentFont = False
        TabOrder = 3
        Value = 3
      end
      object CouleurCombo: TColorBox
        Left = 190
        Top = 88
        Width = 110
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        TabOrder = 4
      end
      object MotifRG: TRadioGroup
        Left = 0
        Top = 111
        Width = 305
        Height = 90
        Align = alBottom
        Caption = '&Motif'
        Columns = 2
        Items.Strings = (
          '&Sans'
          '&Croix'
          '&Fl'#232'che'
          'Ligne &verticale'
          'Ligne &horizontale'
          'Lignes de &rappel')
        TabOrder = 5
      end
      object OpaqueCB: TCheckBox
        Left = 8
        Top = 32
        Width = 105
        Height = 17
        Caption = 'Fond opaque'
        TabOrder = 6
        OnClick = OpaqueCBClick
      end
      object OpaqueColorBox: TColorBox
        Left = 190
        Top = 32
        Width = 110
        Height = 22
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        TabOrder = 7
      end
      object TitreRG: TRadioGroup
        Left = 0
        Top = 251
        Width = 305
        Height = 60
        Align = alBottom
        Caption = 'Position du texte d'#233'finie selon'
        Items.Strings = (
          'les coordonn'#233'es "physiques"'
          'les coordonn'#233'es '#233'cran')
        TabOrder = 8
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 201
        Width = 305
        Height = 50
        Align = alBottom
        Caption = 'Position du motif'
        TabOrder = 9
        object Label1: TLabel
          Left = 10
          Top = 18
          Width = 8
          Height = 17
          Caption = 'X'
        end
        object Label2: TLabel
          Left = 173
          Top = 18
          Width = 7
          Height = 17
          Caption = 'Y'
        end
        object Xcb: TComboBox
          Tag = 1
          Left = 33
          Top = 18
          Width = 80
          Height = 23
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Ycb: TComboBox
          Tag = 1
          Left = 191
          Top = 18
          Width = 80
          Height = 23
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
end
