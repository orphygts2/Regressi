object FcoordonneesPhys: TFcoordonneesPhys
  Left = 277
  Top = 180
  HelpContext = 9
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Coordonn'#233'es du graphe'
  ClientHeight = 990
  ClientWidth = 1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object BoutonsPanel: TPanel
    Left = 764
    Top = 0
    Width = 320
    Height = 654
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 0
    ExplicitLeft = 778
    ExplicitHeight = 655
    object DetailBtn: TSpeedButton
      Left = 8
      Top = 296
      Width = 300
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AllowAllUp = True
      GroupIndex = 1
      Down = True
      Margin = 2
      NumGlyphs = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = DetailBtnClick
    end
    object Label12: TLabel
      Left = 12
      Top = 440
      Width = 204
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Couleurs, tailles ...'
    end
    object OptionsBtn: TSpeedButton
      Left = 232
      Top = 440
      Width = 50
      Height = 52
      Hint = 'Couleurs, motifs des courbes'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 48
      ImageName = 'OPTGR'
      Images = FRegressiMain.VirtualImageList1
      OnClick = OptionsBtnClick
    end
    object OKBtn: TBitBtn
      Left = 8
      Top = 80
      Width = 300
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 0
      OnClick = OKBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 8
      Top = 152
      Width = 300
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkCancel
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 1
      IsControl = True
    end
    object HelpBtn: TBitBtn
      Left = 8
      Top = 224
      Width = 300
      Height = 58
      HelpContext = 804
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
    object AddBtn: TBitBtn
      Left = 8
      Top = 8
      Width = 300
      Height = 58
      Hint = '|Ajouter un onglet que l'#39'on peut ensuite configurer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Ajouter une courbe'
      Glyph.Data = {
        76060000424D7606000000000000360000002800000014000000140000000100
        2000000000004006000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000084000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000084000000840000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000084000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000840000008400000084000000840000FF00
        FF00FF00FF000084000000840000008400000084000000840000008400000084
        000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF
        000000FF000000FF000000FF000000840000FF00FF000084000000FF000000FF
        000000FF000000FF000000FF000000FF000000840000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000FF000000FF000000FF000000840000FF00
        FF00FF00FF000084000000840000008400000084000000840000008400000084
        000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF
        000000FF000000FF000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000084000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000FF000000FF000000FF000000840000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000084000000840000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF
        000000FF000000FF000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000084000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000FF000000FF000000FF000000840000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF
        000000FF00000084000000FF000000840000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000FF000000FF000000840000FF00FF00FF00FF0000FF
        000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF000000FF
        000000840000FF00FF00FF00FF0000FF000000840000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000FF000000FF000000840000FF00FF00FF00FF00FF00FF00FF00
        FF0000FF000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF000000FF000000FF000000FF
        000000840000FF00FF0000FF000000FF000000FF000000FF000000840000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000084000000840000008400000084000000840000FF00FF00008400000084
        0000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 3
      OnClick = AddBtnClick
    end
    object FinModeleBtn: TBitBtn
      Left = 8
      Top = 368
      Width = 300
      Height = 58
      HelpContext = 804
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Sans mod'#233'lisation'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003777777777777777777300003733337333373333733300003933
        3333333733337333000037990033333333333333000037770033333333333333
        0000373339333333333333330000373333933333333333330000373333393333
        3333333300003777333393333333333300003733333339333333333300003733
        3330039933333333000037333330033393333333000037773333333300333333
        0000373333333333009333330000373333333333333933330000373333333333
        3333993300003733333333333333009300003733333333333333003900003333
        33333333333333330000}
      Margin = 2
      Spacing = -1
      TabOrder = 4
      OnClick = FinModeleBtnClick
      IsControl = True
    end
    object UniteImposeeBtn: TBitBtn
      Left = 8
      Top = 562
      Width = 300
      Height = 58
      HelpContext = 804
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233' graphe impos'#233'e'
      Spacing = -1
      TabOrder = 5
      OnClick = UniteImposeeBtnClick
      IsControl = True
    end
  end
  object GroupBoxOptions: TGroupBox
    Left = 0
    Top = 830
    Width = 1084
    Height = 160
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Options g'#233'n'#233'rales'
    TabOrder = 3
    ExplicitTop = 831
    ExplicitWidth = 1098
    object ZoomAutoBtn: TSpeedButton
      Left = 992
      Top = 64
      Width = 46
      Height = 44
      Hint = 'Echelle automatique'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 43
      ImageName = 'ZOOMSANS'
      Images = FRegressiMain.VirtualImageList1
      OnClick = ZoomAutoBtnClick
    end
    object EchelleManuelleLabel: TLabel
      Left = 776
      Top = 78
      Width = 162
      Height = 30
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Echelle bloqu'#233'e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -22
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelWidth: TLabel
      Left = 530
      Top = 32
      Width = 218
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Epaisseur des traits'
    end
    object OrthonormeCB: TCheckBox
      Left = 256
      Top = 116
      Width = 260
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axes orthonorm'#233's'
      TabOrder = 5
      OnClick = OrthonormeCBClick
    end
    object MemeZeroCB: TCheckBox
      Left = 260
      Top = 32
      Width = 260
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Z'#233'ros Y identiques'
      TabOrder = 6
    end
    object MemeXCB: TCheckBox
      Left = 16
      Top = 32
      Width = 240
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Abscisse unique'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = MemeXCBClick
    end
    object AnalyseurCB: TCheckBox
      Left = 16
      Top = 70
      Width = 520
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Courbes s'#233'par'#233'es (et non superpos'#233'es)'
      TabOrder = 2
      OnClick = AnalyseurCBClick
    end
    object MemeEchelleCB: TCheckBox
      Left = 256
      Top = 32
      Width = 260
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Echelles identiques'
      TabOrder = 1
      OnClick = MemeEchelleCBClick
    end
    object PolaireCB: TCheckBox
      Left = 16
      Top = 116
      Width = 138
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Polaire'
      TabOrder = 4
      OnClick = PolaireCBClick
    end
    object GraduationZeroCB: TCheckBox
      Left = 530
      Top = 116
      Width = 300
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axes passant par z'#233'ro'
      TabOrder = 7
    end
    object GrilleCB: TCheckBox
      Left = 530
      Top = 70
      Width = 210
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Trac'#233' de grille'
      TabOrder = 3
    end
    object widthEcranSE: TSpinEdit
      Left = 780
      Top = 19
      Width = 81
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 5
      MinValue = 1
      TabOrder = 8
      Value = 1
    end
  end
  object VariableLB: TTabControl
    Left = 0
    Top = 0
    Width = 764
    Height = 654
    Hint = '|S'#233'lectionnez le graphe que vous voulez modifier'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    HotTrack = True
    ParentShowHint = False
    RaggedRight = True
    ShowHint = True
    TabOrder = 1
    Tabs.Strings = (
      ''
      ''
      ''
      ''
      ''
      '')
    TabIndex = 0
    TabWidth = 124
    OnChange = VariableLBClick
    OnDrawTab = VariableLBDrawTab
    object Panel3: TPanel
      Left = 8
      Top = 56
      Width = 748
      Height = 590
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      BevelOuter = bvNone
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object AbscisseGB: TGroupBox
        Left = 0
        Top = 0
        Width = 748
        Height = 104
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        TabOrder = 0
        object LabelZeroX: TLabel
          Left = 180
          Top = 8
          Width = 125
          Height = 36
          Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Z'#233'ro inclus'
        end
        object LabelGradX: TLabel
          Left = 332
          Top = 8
          Width = 139
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Graduations'
        end
        object ListeX: TComboBox
          Tag = 1
          Left = 16
          Top = 48
          Width = 160
          Height = 44
          Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          DropDownCount = 10
          TabOrder = 0
          OnChange = ListeXChange
        end
        object ZeroXCB: TCheckBox
          Left = 216
          Top = 56
          Width = 32
          Height = 30
          Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 1
          OnClick = ZeroXCBClick
        end
        object GraduationX: TComboBox
          Left = 312
          Top = 48
          Width = 160
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          TabOrder = 2
          OnChange = GraduationXChange
          Items.Strings = (
            'lin'#233'aire'
            'log.'
            'inverse')
        end
        object DeleteBtn: TBitBtn
          Left = 560
          Top = 24
          Width = 200
          Height = 58
          Hint = '|Supprimer la courbe courante'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '&Supprimer'
          Default = True
          TabOrder = 3
          OnClick = DeleteBtnClick
        end
      end
      object OrdonneeGB: TGroupBox
        Left = 0
        Top = 104
        Width = 748
        Height = 104
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        TabOrder = 1
        object labelZeroY: TLabel
          Left = 180
          Top = 8
          Width = 125
          Height = 36
          Hint = '|Inclure le z'#233'ro sur l'#39'axe'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Z'#233'ro inclus'
        end
        object LabelAxeY: TLabel
          Left = 520
          Top = 8
          Width = 80
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Echelle'
        end
        object LabelGradY: TLabel
          Left = 332
          Top = 8
          Width = 139
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Graduations'
        end
        object ListeY: TComboBox
          Tag = 1
          Left = 16
          Top = 48
          Width = 160
          Height = 44
          Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = ListeYChange
        end
        object ZeroYCB: TCheckBox
          Tag = 1
          Left = 216
          Top = 52
          Width = 32
          Height = 30
          Hint = '|Inclure le z'#233'ro sur l'#39'axe'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 1
          OnClick = ZeroYCBClick
        end
        object MondeCB: TComboBox
          Tag = 1
          Left = 484
          Top = 48
          Width = 160
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          TabOrder = 3
          OnChange = MondeCBChange
          Items.Strings = (
            #224' gauche'
            #224' droite'
            'sans')
        end
        object GraduationY: TComboBox
          Tag = 1
          Left = 312
          Top = 48
          Width = 160
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          TabOrder = 2
          OnChange = GraduationYChange
          Items.Strings = (
            'lin'#233'aire'
            'log.'
            'inverse'
            'd'#233'cibel'
            'bits')
        end
        object MinidBEdit: TSpinEdit
          Left = 656
          Top = 48
          Width = 98
          Height = 47
          Hint = 'Minimum|Valeurs inf'#233'rieures '#224' ce mini non prises en compte'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Increment = 10
          MaxValue = 0
          MinValue = -200
          TabOrder = 4
          Value = 0
          OnChange = MinidBEditChange
        end
      end
      object OptionsGB: TGroupBox
        Left = 0
        Top = 208
        Width = 748
        Height = 382
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'Options de repr'#233'sentation'
        TabOrder = 2
        object LigneBevel: TBevel
          Left = 2
          Top = 38
          Width = 744
          Height = 68
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          ExplicitLeft = 4
          ExplicitWidth = 776
        end
        object PointBevel: TBevel
          Left = 2
          Top = 106
          Width = 744
          Height = 68
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          ExplicitLeft = 4
          ExplicitWidth = 776
        end
        object LabelDimPoint: TLabel
          Left = 384
          Top = 112
          Width = 56
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Taille'
        end
        object Label5: TLabel
          Left = 592
          Top = 112
          Width = 38
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Pas'
        end
        object LigneCB: TCheckBox
          Left = 16
          Top = 40
          Width = 110
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ligne'
          TabOrder = 0
          OnClick = LigneCBClick
        end
        object PointCB: TCheckBox
          Left = 16
          Top = 112
          Width = 110
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Point'
          TabOrder = 1
          OnClick = PointCBClick
        end
        object PageBioMeca: TPageControl
          Left = 2
          Top = 240
          Width = 744
          Height = 140
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          ActivePage = CouleurPointTS
          Align = alBottom
          TabOrder = 2
          Visible = False
          OnChange = PageBioMecaChange
          object MecaniqueTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'M'#233'canique'
            ImageIndex = 1
            object LabelVitesse: TLabel
              Left = 340
              Top = 16
              Width = 243
              Height = 30
              Hint = 
                '|Les coordonn'#233'es doivent '#234'tre diff'#233'rentes de la premi'#232're colonne' +
                ' (temps?)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Coordonn'#233'es incorrectes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -22
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object VitesseCB: TCheckBox
              Left = 16
              Top = 12
              Width = 132
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Vitesse'
              TabOrder = 0
              OnClick = VitesseCBClick
            end
            object AccelerationCB: TCheckBox
              Left = 152
              Top = 12
              Width = 190
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Acc'#233'l'#233'ration'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = AccelerationCBClick
            end
            object OptionsVitesseBtn: TBitBtn
              Left = 380
              Top = 10
              Width = 162
              Height = 46
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '&Options'
              Default = True
              Glyph.Data = {
                DE010000424DDE01000000000000760000002800000024000000120000000100
                0400000000006801000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333333333333333330000333333333333333333333333F33333333333
                00003333344333333333333333388F3333333333000033334224333333333333
                338338F3333333330000333422224333333333333833338F3333333300003342
                222224333333333383333338F3333333000034222A22224333333338F338F333
                8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
                33333338F83338F338F33333000033A33333A222433333338333338F338F3333
                0000333333333A222433333333333338F338F33300003333333333A222433333
                333333338F338F33000033333333333A222433333333333338F338F300003333
                33333333A222433333333333338F338F00003333333333333A22433333333333
                3338F38F000033333333333333A223333333333333338F830000333333333333
                333A333333333333333338330000333333333333333333333333333333333333
                0000}
              NumGlyphs = 2
              TabOrder = 2
              OnClick = OptionsVitesseBtnClick
            end
            object FilDeFerCB: TCheckBox
              Left = 600
              Top = 12
              Width = 160
              Height = 34
              Hint = '|Relie les points de m'#234'me num'#233'ro entre eux'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Fil de fer'
              TabOrder = 3
            end
          end
          object OptiqueTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'Optique'
            ImageIndex = 3
            object ContrastePanel: TPanel
              Left = 232
              Top = 0
              Width = 524
              Height = 76
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Align = alRight
              TabOrder = 0
              object Label2: TLabel
                Left = 24
                Top = 16
                Width = 180
                Height = 36
                Margins.Left = 6
                Margins.Top = 6
                Margins.Right = 6
                Margins.Bottom = 6
                Caption = 'Contraste faible'
              end
              object Label3: TLabel
                Left = 448
                Top = 16
                Width = 60
                Height = 36
                Margins.Left = 6
                Margins.Top = 6
                Margins.Right = 6
                Margins.Bottom = 6
                Caption = #233'lev'#233
              end
              object NiveauGrisTB: TTrackBar
                Left = 212
                Top = 8
                Width = 228
                Height = 40
                Margins.Left = 6
                Margins.Top = 6
                Margins.Right = 6
                Margins.Bottom = 6
                Max = 8
                Min = -8
                PageSize = 1
                Position = -3
                TabOrder = 0
                ThumbLength = 24
              end
            end
            object IntensiteCB: TCheckBox
              Left = 16
              Top = 14
              Width = 220
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Niveau de gris'
              TabOrder = 1
              OnClick = IntensiteCBClick
            end
          end
          object ChimieTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'Chimie'
            ImageIndex = 3
            object IndicateurBtn: TSpeedButton
              Left = 720
              Top = 8
              Width = 50
              Height = 48
              Hint = 'Configuration des indicateurs'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333300003333333333333333333300003555550FF0559195053300003580
                00FF0555919035330000380FFFF0555591933533000030F00FF0555591933833
                0000300550F05555919358330000308550F0555999995833000035580F085501
                1111553300003550008550333055553300003555555503335055553300003550
                0550333550555533000035050503335550555533000030500033355550555833
                0000300000035555808558330000355000005555808555330000355300008555
                8085553300003553350000055555553300003333333333333333333300003333
                33333333333333330000}
              OnClick = IndicateurBtnClick
            end
            object IndicateurCombo: TComboBox
              Left = 370
              Top = 8
              Width = 340
              Height = 44
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Style = csDropDownList
              DropDownCount = 12
              TabOrder = 1
              OnChange = IndicateurComboChange
            end
            object IndicateurCB: TCheckBox
              Left = 8
              Top = 8
              Width = 144
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Indicateur'
              TabOrder = 0
              OnClick = indicateurCBClick
            end
            object OptionsIndicateurLB: TCheckListBox
              Left = 152
              Top = 0
              Width = 216
              Height = 0
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -22
              Font.Name = 'Segoe UI'
              Font.Style = []
              IntegralHeight = True
              ItemHeight = 34
              Items.Strings = (
                'Zone de virage'
                'Echelle de teinte'
                'Nom')
              ParentFont = False
              TabOrder = 2
              OnClick = OptionsIndicateurLBClick
            end
            object CouleursSpectreCB: TCheckBox
              Left = 8
              Top = 42
              Width = 128
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Spectre'
              TabOrder = 3
              OnClick = CouleursSpectreCBClick
            end
          end
          object TexteTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'Texte'
            ImageIndex = 4
            object NbreLabel: TLabel
              Left = 4
              Top = 24
              Width = 237
              Height = 36
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Nombre maxi affich'#233
            end
            object LabelTaille: TLabel
              Left = 340
              Top = 24
              Width = 327
              Height = 36
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Taille du texte (% du graphe)'
            end
            object NbreSE: TSpinEdit
              Left = 256
              Top = 6
              Width = 80
              Height = 47
              Hint = 
                'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
                'e'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              EditorEnabled = False
              MaxValue = 99
              MinValue = 8
              TabOrder = 0
              Value = 99
            end
            object SpinEditHauteur: TSpinEdit
              Left = 690
              Top = 6
              Width = 64
              Height = 47
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -26
              Font.Name = 'Segoe UI'
              Font.Style = []
              MaxValue = 9
              MinValue = 1
              ParentFont = False
              TabOrder = 1
              Value = 8
            end
          end
          object AstroTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'Astronomie'
            ImageIndex = 5
            object axeXinverseCB: TCheckBox
              Left = 6
              Top = 24
              Width = 230
              Height = 30
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'axe X invers'#233
              TabOrder = 0
              OnClick = axeXinverseCBClick
            end
            object axeYinverseCB: TCheckBox
              Left = 312
              Top = 24
              Width = 230
              Height = 30
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'axe Y invers'#233
              TabOrder = 1
              OnClick = axeYinverseCBClick
            end
          end
          object CouleurPointTS: TTabSheet
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = 'Point'
            ImageIndex = 5
            object TeinteLabel: TLabel
              Left = 16
              Top = 0
              Width = 147
              Height = 36
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'expression ...'
            end
            object HueImage: TImage
              Left = 500
              Top = 36
              Width = 250
              Height = 40
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000001DB0000
                0045080600000002614CB30000000467414D410000B18F0BFC61050000005065
                5849664D4D002A00000008000201120003000000010001000087690004000000
                0100000026000000000003A00100030000000100010000A00200040000000100
                0001DBA00300040000000100000045000000006B6913B0000002316954587458
                4D4C3A636F6D2E61646F62652E786D7000000000003C783A786D706D65746120
                786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B
                3D22584D5020436F726520362E302E30223E0A2020203C7264663A5244462078
                6D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F31393939
                2F30322F32322D7264662D73796E7461782D6E7323223E0A2020202020203C72
                64663A4465736372697074696F6E207264663A61626F75743D22220A20202020
                2020202020202020786D6C6E733A657869663D22687474703A2F2F6E732E6164
                6F62652E636F6D2F657869662F312E302F220A20202020202020202020202078
                6D6C6E733A746966663D22687474703A2F2F6E732E61646F62652E636F6D2F74
                6966662F312E302F223E0A2020202020202020203C657869663A506978656C59
                44696D656E73696F6E3E36393C2F657869663A506978656C5944696D656E7369
                6F6E3E0A2020202020202020203C657869663A506978656C5844696D656E7369
                6F6E3E3437353C2F657869663A506978656C5844696D656E73696F6E3E0A2020
                202020202020203C657869663A436F6C6F7253706163653E313C2F657869663A
                436F6C6F7253706163653E0A2020202020202020203C746966663A4F7269656E
                746174696F6E3E313C2F746966663A4F7269656E746174696F6E3E0A20202020
                20203C2F7264663A4465736372697074696F6E3E0A2020203C2F7264663A5244
                463E0A3C2F783A786D706D6574613E0A7D66F5740000046E4944415478DAEDD5
                D16EDA401404504351A5E6B7FBD75580261148B4F51A0742349D9C0784C55C56
                8BD7CCD91C7F4CC769374DD3B785D757CF0733C7ED343DBF5CEE4FAF35D76BE7
                5AD73D4EDBE0837ED083F288FCF2804687F53FE69FB887CD61FE8EEF1E70DDB2
                EEF6E51FFCE51E940FCA37B05D91C316B6B0ADEB50D8C216B669396C610BDBBA
                0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96
                C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50
                D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C
                610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D
                6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6
                B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216
                B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDB
                BA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B
                96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB
                50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B66939
                6C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E85
                2D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316
                B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C2
                16B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610B
                DBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C61
                9B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0AD
                EB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669
                396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E
                852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C3
                16B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8
                C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C61
                0BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C
                619B96C316B6B0ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0
                ADEB50D8C216B669396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B6
                69396C610BDBBA0E852D6C619B96C316B6B0ADEB50D8C216B669396C610BDBBA
                0E852D6C619B96C316B6B0ADEB50D8C2F673B17D9A7EBEDDC973076E4F77F6F2
                FDFBE0F3CBF9DDE0FAFC3E5A7B37F8CE7BD67E7D6D6E5C7B69EE727E263B9CB0
                3D9C6EEBF97A3FFDFBF9DCDCF9280E83995BE6AEEDE19EFDEE177EC7DAFD1E86
                0FC1F9004787F8F7F57B0EF123D64EF8235CCCFD7953C787343AACF3ECDCDCA3
                D67E7DFFB5B0F6D27AA3876BCDFE07BF737B983FA9A5D31CD5CEDCDCB51A19AD
                B9347BCF7EAFCDADD9EFF6ED06CE1DCE71C54371ED109F57AE7DED613D2E64F7
                3EACB7FFCEDF8CE2FAB28CB3EA600000000049454E44AE426082}
              Stretch = True
            end
            object SigneLabel: TLabel
              Left = 500
              Top = 32
              Width = 216
              Height = 36
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '<0 bleu ; >0 rouge'
            end
            object CouleurPointEdit: TEdit
              Left = 16
              Top = 32
              Width = 414
              Height = 44
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              TabOrder = 0
              OnExit = CouleurPointEditExit
            end
            object CouleurSigneCB: TCheckBox
              Left = 448
              Top = 34
              Width = 50
              Height = 34
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              TabOrder = 1
              OnClick = CouleurSigneCBClick
            end
          end
        end
        object OrdreLissageSE: TSpinEdit
          Left = 550
          Top = 40
          Width = 64
          Height = 47
          Hint = 
            'Degr'#233' du polyn'#244'me|Plus le degr'#233' est grand, plus le lissage est p' +
            'roche des points'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          EditorEnabled = False
          MaxValue = 7
          MinValue = 3
          TabOrder = 3
          Value = 3
        end
        object CouleurCombo: TColorBox
          Left = 130
          Top = 40
          Width = 180
          Height = 22
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Selected = clScrollBar
          Style = [cbStandardColors, cbPrettyNames]
          ItemHeight = 28
          TabOrder = 4
          OnChange = CouleurComboChange
        end
        object LigneRG: TComboBox
          Left = 312
          Top = 40
          Width = 230
          Height = 38
          Hint = 'Type de ligne : lissage : B-spline ; Shannon=sinus cardinal'
          HelpType = htKeyword
          HelpKeyword = 'Type de ligne. Lissage par B-spline.  Interpolation par sinc'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csOwnerDrawFixed
          ItemHeight = 32
          TabOrder = 5
          OnChange = LigneRGChange
          OnClick = LigneRGClick
          OnDrawItem = LigneRGDrawItem
          Items.Strings = (
            'Segments'
            'Mod'#232'le'
            'Lissage'
            'Interpol. Shannon')
        end
        object PointCombo: TComboBoxEx
          Left = 130
          Top = 108
          Width = 180
          Height = 39
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          ItemsEx = <
            item
              Caption = 'Croix'
              ImageIndex = 0
              SelectedImageIndex = 0
            end
            item
              Caption = 'Croix diag.'
              ImageIndex = 1
              SelectedImageIndex = 1
            end
            item
              Caption = 'Cercle'
              ImageIndex = 2
              SelectedImageIndex = 2
            end
            item
              Caption = 'Carr'#233
              ImageIndex = 3
              SelectedImageIndex = 3
            end
            item
              Caption = 'Losange'
              ImageIndex = 4
              SelectedImageIndex = 4
            end
            item
              Caption = 'Disque'
              ImageIndex = 5
              SelectedImageIndex = 5
            end
            item
              Caption = 'Carr'#233' plein'
              ImageIndex = 6
              SelectedImageIndex = 6
            end
            item
              Caption = 'Incertitude'
              ImageIndex = 7
              SelectedImageIndex = 7
            end
            item
              Caption = 'Echantillon'
              ImageIndex = 10
              SelectedImageIndex = 10
            end
            item
              Caption = 'Barre'
              ImageIndex = 9
              SelectedImageIndex = 9
            end
            item
              Caption = 'Trait'
              ImageIndex = 8
              SelectedImageIndex = 8
            end
            item
              Caption = 'Pixel'
              ImageIndex = 11
              SelectedImageIndex = 11
            end
            item
              Caption = 'Reticule'
              ImageIndex = 12
              SelectedImageIndex = 12
            end>
          Style = csExDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = PointComboChange
          Images = VirtualImageListPoint
          DropDownCount = 12
        end
        object LigneCombo: TComboBoxEx
          Left = 620
          Top = 40
          Width = 150
          Height = 45
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          ItemsEx = <
            item
              ImageIndex = 0
              SelectedImageIndex = 0
            end
            item
              ImageIndex = 1
              SelectedImageIndex = 1
            end
            item
              ImageIndex = 2
              SelectedImageIndex = 2
            end
            item
              ImageIndex = 3
              SelectedImageIndex = 3
            end
            item
              ImageIndex = 4
              SelectedImageIndex = 4
            end>
          TabOrder = 7
          OnChange = LigneComboChange
          Images = VirtualImageListLigne
        end
        object SuperPagesCB: TCheckBox
          Left = 16
          Top = 176
          Width = 352
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Superposition des pages'
          TabOrder = 8
          OnClick = SuperPagesCBClick
        end
        object ConfigPageCB: TCheckBox
          Left = 380
          Top = 176
          Width = 370
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'graphique li'#233' '#224' la page'
          TabOrder = 9
        end
        object dimPointSE: TSpinEdit
          Left = 464
          Top = 112
          Width = 106
          Height = 47
          Hint = 
            'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
            'e'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          MaxValue = 9
          MinValue = 1
          TabOrder = 10
          Value = 3
        end
        object PasPointSE: TSpinEdit
          Left = 654
          Top = 110
          Width = 100
          Height = 47
          Hint = 'Pas|Trac'#233' de 1 point sur x'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          MaxValue = 32
          MinValue = 1
          TabOrder = 11
          Value = 3
        end
      end
    end
  end
  object pagesGB: TGroupBox
    Left = 0
    Top = 654
    Width = 1084
    Height = 176
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Gestion des pages'
    TabOrder = 2
    ExplicitTop = 655
    ExplicitWidth = 1098
    object PagesBtn: TSpeedButton
      Left = 16
      Top = 32
      Width = 210
      Height = 48
      Hint = 'Choix|Choix des pages superpos'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'S'#233'lection'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        33333333333333330000333333000000000033330000333330BFBFBFBFB03333
        0000333300FBFBFBFBF0333300003330B0BFBFBFBFB0333300003300F0FBFBFB
        FBF03333000030B0B0BFBFBFBFB03333000030F0F0FBFBFBFBF03333000030B0
        B008999998033333000030F0FB0FBFB0F0333333000030B00080000803333333
        000030FB0FBFB0F0333333330000300089999803333333330000330FBFB03333
        3333333300003380000833333333333300003333333333333333333300003333
        33333333333333330000}
      OnClick = PagesBtnClick
    end
    object PagePrecBtn: TSpeedButton
      Left = 232
      Top = 32
      Width = 52
      Height = 48
      Hint = 'Page pr'#233'c'#233'dente F7'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033333333C33330003333333CC3333000333333C0C333300033333C00C333
        30003333C000C3333000333C0000C333300033C00000C3333000333C0000C333
        30003333C000C333300033333C00C3333000333333C0C33330003333333CC333
        300033333333C33330003333333333333000}
      OnClick = PagePrecBtnClick
    end
    object PageSuivBtn: TSpeedButton
      Left = 1008
      Top = 32
      Width = 50
      Height = 48
      Hint = 'Page suivante F8'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C333333333300033CC33333333300033C0C3333333300033C00C333333
        300033C000C33333300033C0000C3333300033C00000C333300033C0000C3333
        300033C000C33333300033C00C333333300033C0C3333333300033CC33333333
        300033C33333333330003333333333333000}
      OnClick = PageSuivBtnClick
    end
    object ReperePageRG: TRadioGroup
      Left = 2
      Top = 82
      Width = 1108
      Height = 92
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Rep'#233'rage des pages par '
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'le style de trait'
        'le motif'
        'la couleur')
      TabOrder = 0
      ExplicitWidth = 1094
    end
    object CommentaireEdit: TEdit
      Left = 288
      Top = 32
      Width = 712
      Height = 44
      Hint = 'Page active pour les modifications'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSelect = False
      Enabled = False
      TabOrder = 1
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerTimer
    Left = 1008
    Top = 480
  end
  object ImageCollectionLigne: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000230000000A08060000003E7AE7
              A7000000284944415478DA63FCCFF09F61B000C651C70C19C73082A801064077
              300E3EC70C1630EA9821E118004FDB19F7AB7831D30000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000230000000A08060000003E7AE7
              A70000002C4944415478DA63FCCFF09F61B000C651C70C19C73082283C00A886
              11AE81466A07A763060B1875CC90700C00D38225F71FCF1D840000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000230000000A08060000003E7AE7
              A70000002B4944415478DA63FCCFF09F61B000C651C70C19C73082282800F219
              E19274161F7C8E192C60D43143C23100ED3137F7CB1A6A650000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000230000000A08060000003E7AE7
              A7000000304944415478DA63FCCFF09F61B000C651C70C19C73082283C00A886
              11AE01492D2E71B2CD18748E192C60D43143C23100D1622BF799E8ABD4000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000230000000A08060000003E7AE7
              A7000000304944415478DA63FCCFF09F61B000C651C70C19C73082283C00A886
              11AE01492DA9E204CD1E748E192C60D43143C2310049712BF7DFAF2B32000000
              0049454E44AE426082}
          end>
      end>
    Left = 928
    Top = 480
  end
  object ImageCollectionPoint: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000002B4944415478DA63FCCFF09F815CC0884F3323501A28CF38AA999A9A
              418A184804204387B29F8799664200000EFD44F2D7796F0F0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000004F4944415478DA63FCCFF09F815CC04815CD8C402690CD485003923A
              149B0919802E8FE16C5C066013C7EA670C1B7019882BC0601AF079056F68130C
              03AADB4CB69FC90E6DB2E399E214462AA0483300C9635CF28D7E4B0D00000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000004F4944415478DAE5D2C1120020040450FEFFA3950E4D694575CC7179
              0E060B09DD1623CC1A9BAA731C62857010E413F6A0D7EF38826841C35968177C
              8B9FAE8D1A115CF06E41F861E3A0CD52BF7D5205B67F65F2E371B45C00000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000334944415478DA63FCCFF09F815CC008D2CC08A24800403D8C289A61
              02046D43523BAA795433F19A89D10803289AC9051469060053915FF2695B30E2
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000564944415478DAA5935B1200200445D9FFA2659AF191B7F449E7E226
              2420F83D98C1C869CEE31816301370610D4402060E2F3AF1072E67D41D095C81
              9EC085BBA031735D793DF3DAEDB042F79D8D29D30D6B7BB0F95507C65F65F29F
              DE4A640000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000004F4944415478DA63FCCFF09F815CC0884D332348180D00D53112D40C
              D188CD358C1806A068C6AD11BB0170CD8435621A00D64CBC46540346AC668A42
              1B214C663C133680400A433500151095B64901008F364FF299823CFD00000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000002E4944415478DA63FCCFF09F815CC008D2CC08A24800403D8C689A89
              D5CF38AA795433599A8907289AC9051469060031574BF21EAF47C10000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000614944415478DAC5923116C0200843C9FD0F6D6540418DD476305BC4
              0F92278A143141D04C3D872482C10A7A60F4146617B3061761CD66B76BF41AA8
              AF397895F66B783FD9C0DEE060E7CF707CAEF9FFF069CA13CCD29EC1DE20C0F4
              1FF14A06733DF71884F2E4757F890000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000474944415478DA63FCCFF09F815CC04875CD8C0C0CFFFF83A961A119
              5D7C10684696A09A667C8652AE991144910880FA18C19A5B5B5AFF57D7543392
              4AA36886994A2C9FA28C01006C7174F2B90BA6BF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A0000003E4944415478DA63FCCFF09F815CC048BC6646A8C2FF8C7834632A1A
              9E9A9125868166FC860E8466089B32CD201E0399009E485A5B5AFF57D7543392
              C206008B227580747666CF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000514944415478DA63FCCFF09F815CC04837CD8C0C0CFFFF8329123583
              34C2D8300388D28CAC11D900DADB4CD0CFE812446BC6E624A23443F898818147
              31619B718911F433CEA82136C0C8B699400051473300C22152F2B197F54F0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000214944415478DA63FCCFF09F815CC038AA79B06866044A03E5198798
              B3473563020032DD20F222796A690000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000000F0000000F08060000003BD695
              4A000000644944415478DABD90810A80300844BD2F57BFDC24682D9335477530
              6470C7D383911108E613541444C4FCD152F807B2339A4E5F23CB80C0975F177E
              85FC74B3BA878367BAED349C93EF6B0EC97D615941DF91E3CDD15C204F860FF2
              8A76B28A1A0BA33A375E2C8BF3568321F30000000049454E44AE426082}
          end>
      end>
    Left = 840
    Top = 480
  end
  object VirtualImageListLigne: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Item1'
        Name = 'Item1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Item2'
        Name = 'Item2'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Item3'
        Name = 'Item3'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Item4'
        Name = 'Item4'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Item5'
        Name = 'Item5'
      end>
    ImageCollection = ImageCollectionLigne
    Width = 20
    Height = 20
    Left = 600
    Top = 704
  end
  object VirtualImageListPoint: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Item1'
        Name = 'Item1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Item2'
        Name = 'Item2'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Item3'
        Name = 'Item3'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Item4'
        Name = 'Item4'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Item5'
        Name = 'Item5'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Item6'
        Name = 'Item6'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Item7'
        Name = 'Item7'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Item8'
        Name = 'Item8'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Item9'
        Name = 'Item9'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Item10'
        Name = 'Item10'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Item11'
        Name = 'Item11'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Item12'
        Name = 'Item12'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Item13'
        Name = 'Item13'
      end>
    ImageCollection = ImageCollectionPoint
    Width = 20
    Height = 20
    Left = 400
    Top = 664
  end
end
