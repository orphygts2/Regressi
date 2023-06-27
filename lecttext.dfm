object LectureTexteDlg: TLectureTexteDlg
  Left = 136
  Top = 151
  HelpContext = 57
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Texte'
  ClientHeight = 685
  ClientWidth = 874
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 648
    Top = 48
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
    Left = 648
    Top = 192
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
    Left = 648
    Top = 320
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 626
    Height = 685
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = OptionsTab
    Align = alLeft
    TabOrder = 3
    object TexteTab: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Texte'
      object Label5: TLabel
        Left = 0
        Top = 437
        Width = 610
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Syntaxe des options'
        ExplicitTop = 438
        ExplicitWidth = 229
      end
      object Edit: TMemo
        Left = 0
        Top = 0
        Width = 610
        Height = 162
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 255
        ParentFont = False
        TabOrder = 0
      end
      object PageGB: TGroupBox
        Left = 0
        Top = 285
        Width = 610
        Height = 152
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 286
        object Label4: TLabel
          Left = 16
          Top = 96
          Width = 380
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Page nulle signifie page courante'
        end
        object Label3: TLabel
          Left = 16
          Top = 34
          Width = 76
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Page : '
        end
        object NumeroPageSE: TSpinEdit
          Left = 108
          Top = 30
          Width = 108
          Height = 47
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
      end
      object Memo: TMemo
        Left = 0
        Top = 473
        Width = 610
        Height = 148
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
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
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Options'
      ImageIndex = 1
      object LabelTaille: TLabel
        Left = 16
        Top = 120
        Width = 274
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille (en % du graphe) :'
      end
      object CouleurComboLabel: TLabel
        Left = 16
        Top = 176
        Width = 343
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Couleur du texte et des lignes'
      end
      object Label6: TLabel
        Left = 432
        Top = 120
        Width = 69
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Trait : '
      end
      object CadreCB: TCheckBox
        Left = 16
        Top = 16
        Width = 146
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Cadre'
        TabOrder = 0
      end
      object LigneRappelCB: TCheckBox
        Left = 160
        Top = 16
        Width = 258
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Ligne de rappel'
        TabOrder = 1
      end
      object VerticalCB: TCheckBox
        Left = 432
        Top = 16
        Width = 162
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Vertical'
        TabOrder = 2
      end
      object SpinEditHauteur: TSpinEdit
        Left = 310
        Top = 114
        Width = 80
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 20
        MinValue = 1
        ParentFont = False
        TabOrder = 3
        Value = 3
      end
      object CouleurCombo: TColorBox
        Left = 380
        Top = 176
        Width = 220
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 4
      end
      object MotifRG: TRadioGroup
        Left = 0
        Top = 221
        Width = 610
        Height = 180
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
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
        Left = 16
        Top = 64
        Width = 210
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Fond opaque'
        TabOrder = 6
        OnClick = OpaqueCBClick
      end
      object OpaqueColorBox: TColorBox
        Left = 380
        Top = 64
        Width = 220
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 7
      end
      object TitreRG: TRadioGroup
        Left = 0
        Top = 501
        Width = 610
        Height = 120
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Position du texte d'#233'finie selon'
        Items.Strings = (
          'les coordonn'#233'es "physiques"'
          'les coordonn'#233'es '#233'cran')
        TabOrder = 8
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 401
        Width = 610
        Height = 100
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Position du motif'
        TabOrder = 9
        object Label1: TLabel
          Left = 20
          Top = 36
          Width = 15
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'X'
        end
        object Label2: TLabel
          Left = 346
          Top = 36
          Width = 14
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Y'
        end
        object Xcb: TComboBox
          Tag = 1
          Left = 66
          Top = 36
          Width = 160
          Height = 40
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object Ycb: TComboBox
          Tag = 1
          Left = 382
          Top = 36
          Width = 160
          Height = 40
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object penwidthSE: TSpinEdit
        Left = 523
        Top = 114
        Width = 60
        Height = 56
        Hint = 'Epaisseur des traits'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 5
        MinValue = 1
        ParentFont = False
        TabOrder = 10
        Value = 1
      end
    end
  end
end
