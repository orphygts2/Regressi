object OptionsDlg: TOptionsDlg
  Left = 339
  Top = 168
  HelpContext = 52
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 929
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -22
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 30
  object Label8: TLabel
    Left = 16
    Top = 160
    Width = 132
    Height = 30
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Commentaire'
  end
  object Label9: TLabel
    Left = 32
    Top = 400
    Width = 132
    Height = 30
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Commentaire'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 714
    Height = 929
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = PrefTS
    Align = alClient
    MultiLine = True
    TabOrder = 0
    OnChange = PageControlChange
    object CalculTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Calcul'
      object LissageLabel: TLabel
        Left = 12
        Top = 320
        Width = 265
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Ordre de lissage par d'#233'faut'
      end
      object Label1: TLabel
        Left = 16
        Top = 452
        Width = 464
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nombre de points pour le calcul pour la d'#233'riv'#233'e'
      end
      object DegreRG: TRadioGroup
        Left = 0
        Top = 672
        Width = 712
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'M'#233'thode de calcul de la d'#233'riv'#233'e : type de lissage'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          '&Affine'
          '&Parabolique'
          '&Cubique')
        TabOrder = 0
        OnClick = DegreRGClick
      end
      object OrdreFiltrageSE: TSpinEdit
        Left = 328
        Top = 308
        Width = 84
        Height = 47
        Hint = '|Filtrage d'#39'ordre 1 avec tau=N*deltat'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditorEnabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 32
        MinValue = 1
        ParentFont = False
        TabOrder = 5
        Value = 3
      end
      object NbreEdit: TEdit
        Left = 540
        Top = 442
        Width = 50
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = '5'
        OnChange = NbreEditChange
      end
      object NbreSpinButton: TSpinButton
        Left = 594
        Top = 442
        Width = 40
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        DownGlyph.Data = {
          7E040000424D7E04000000000000360400002800000009000000060000000100
          0800000000004800000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
          0303030000000303030300030303030000000303030000000303030000000303
          0000000000030300000003000000000000000300000003030303030303030300
          0000}
        TabOrder = 8
        UpGlyph.Data = {
          7E040000424D7E04000000000000360400002800000009000000060000000100
          0800000000004800000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A600000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
          0303030000000300000000000000030000000303000000000003030000000303
          0300000003030300000003030303000303030300000003030303030303030300
          0000}
        OnDownClick = NbreSpinButtonDownClick
        OnUpClick = NbreSpinButtonUpClick
      end
      object AngleEnDegreCB: TCheckBox
        Left = 16
        Top = 270
        Width = 514
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Angle en degr'#233
        TabOrder = 4
        OnClick = UniteSICBClick
      end
      object ConstUniversBtn: TBitBtn
        Left = 576
        Top = 160
        Width = 50
        Height = 50
        Hint = 'Gestion des constantes universelles'
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
        TabOrder = 1
        OnClick = ConstUniversBtnClick
      end
      object ExtrapoleDerCB: TCheckBox
        Left = 16
        Top = 496
        Width = 546
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Calcul de la d'#233'riv'#233'e aux points extr'#234'mes'
        TabOrder = 9
      end
      object fontSizeMemoRG: TRadioGroup
        Left = 16
        Top = 368
        Width = 418
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille de la police des zones de calcul'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          '10'
          '12'
          '14')
        TabOrder = 6
        OnClick = fontSizeMemoRGClick
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 712
        Height = 210
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Caption = 'Mod'#233'lisation'
        TabOrder = 2
        object AjustageAutoGrCB: TCheckBox
          Left = 16
          Top = 30
          Width = 530
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajustage automatique des mod'#232'les pr'#233'd'#233'finis'
          TabOrder = 0
        end
        object AjustageAutoLinCB: TCheckBox
          Left = 16
          Top = 72
          Width = 530
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajustage automatique des mod'#232'les lin'#233'aires'
          TabOrder = 1
        end
        object UseChi2CB: TCheckBox
          Left = 16
          Top = 160
          Width = 530
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Utilisation des incertitudes ('#967#178')'
          TabOrder = 3
          OnClick = UseChi2CBClick
        end
        object LevenbergCB: TCheckBox
          Left = 16
          Top = 116
          Width = 434
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Algorithme de Levenberg-Marquardt'
          TabOrder = 2
        end
      end
      object UniteSICB: TCheckBox
        Left = 16
        Top = 224
        Width = 566
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Calcul avec prise en compte des pr'#233'fixes d'#39'unit'#233
        TabOrder = 3
        OnClick = UniteSICBClick
      end
      object IndexRG: TRadioGroup
        Left = 0
        Top = 752
        Width = 712
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Valeur de x[i] lorsque i est incorrect'
        Columns = 2
        Ctl3D = True
        Items.Strings = (
          'Nan (d'#233'rivation ...)'
          '0 (filtre ...)')
        ParentCtl3D = False
        TabOrder = 10
        OnClick = DegreRGClick
      end
    end
    object AffichageTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Affichage'
      object Label4: TLabel
        Left = 16
        Top = 128
        Width = 132
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Commentaire'
        Visible = False
      end
      object Label5: TLabel
        Left = 16
        Top = 172
        Width = 102
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Expression'
        Visible = False
      end
      object Label6: TLabel
        Left = 16
        Top = 216
        Width = 51
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Unit'#233
        Visible = False
      end
      object Label7: TLabel
        Left = 16
        Top = 260
        Width = 75
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'sultat'
        Visible = False
      end
      object Label10: TLabel
        Left = 16
        Top = 84
        Width = 48
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nom'
        Visible = False
      end
      object Label3: TLabel
        Left = 16
        Top = 384
        Width = 405
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nombre de chiffres significatifs par d'#233'faut'
      end
      object Label16: TLabel
        Left = 16
        Top = 308
        Width = 149
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Valeur non exp.'
      end
      object FontBtn: TSpeedButton
        Left = 6
        Top = 20
        Width = 374
        Height = 48
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Choix de la police graphique'
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333333333003003300003333
          3333333330030033000033333333333333333333000033333333333333333333
          0000300007330000007333330000333073333000073333330000333073333000
          7333333300003333000000007333333300003333073300073333333300003333
          0733000733333333000033333070007333333333000033333070007333333333
          0000333333000073333333330000333333000733333333330000333333300733
          3333333300003333333073333333333300003333333333333333333300003333
          33333333333333330000}
        OnClick = FontBtnClick
      end
      object TestEdit: TEdit
        Left = 392
        Top = 14
        Width = 274
        Height = 53
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'Aa Bb '#945#955#937' ms'#8315#178
      end
      object UseMilliCB: TCheckBox
        Left = 16
        Top = 344
        Width = 400
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Puissance sous forme '#181' m k G'
        TabOrder = 1
      end
      object ChiffresSignifSE: TSpinEdit
        Left = 462
        Top = 376
        Width = 66
        Height = 47
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 10
        MinValue = 3
        ParentFont = False
        TabOrder = 2
        Value = 4
      end
      object NomColor: TColorBox
        Left = 192
        Top = 80
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 3
        Visible = False
      end
      object NonExpColor: TColorBox
        Left = 192
        Top = 300
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 4
      end
      object ResultatColor: TColorBox
        Left = 192
        Top = 256
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 5
        Visible = False
      end
      object UniteColor: TColorBox
        Left = 192
        Top = 212
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 6
        Visible = False
      end
      object ExpressionColor: TColorBox
        Left = 192
        Top = 168
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 7
        Visible = False
      end
      object CommentaireColor: TColorBox
        Left = 192
        Top = 124
        Width = 200
        Height = 22
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 8
        Visible = False
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 686
        Width = 712
        Height = 146
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Graphe avec variables textuelles'
        TabOrder = 9
        object LabelTaille: TLabel
          Left = 24
          Top = 88
          Width = 283
          Height = 30
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Taille du texte  (% du graphe)'
        end
        object NbreLabel: TLabel
          Left = 24
          Top = 36
          Width = 202
          Height = 30
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Nombre maxi affich'#233
        end
        object SpinEditHauteur: TSpinEdit
          Left = 392
          Top = 84
          Width = 84
          Height = 47
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 8
          MinValue = 1
          ParentFont = False
          TabOrder = 0
          Value = 8
          OnChange = SpinEditHauteurChange
        end
        object NbreSE: TSpinEdit
          Left = 392
          Top = 24
          Width = 84
          Height = 47
          Hint = 
            'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
            'e'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          EditorEnabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 128
          MinValue = 8
          ParentFont = False
          TabOrder = 1
          Value = 8
          OnChange = SpinEditHauteurChange
        end
      end
      object UseMPCB: TCheckBox
        Left = 430
        Top = 126
        Width = 194
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'MathPlayer'
        TabOrder = 10
        OnClick = UseMPCBClick
      end
      object ClavierAvecGrapheCB: TCheckBox
        Left = 16
        Top = 434
        Width = 474
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Entr'#233'e des donn'#233'es au clavier avec graphe'
        TabOrder = 11
      end
    end
    object DirTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#233'pertoires'
      object GroupePathLabel: TLabel
        Left = 16
        Top = 132
        Width = 445
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire partag'#233' (r'#233'seau, envoyer/recevoir)'
      end
      object GroupePathBtn: TSpeedButton
        Left = 528
        Top = 172
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire partag'#233' (menu recevoir/envoyer)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = GroupePathBtnClick
      end
      object TempDirBtn: TSpeedButton
        Left = 528
        Top = 72
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire temporaire'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = TempDirBtnClick
      end
      object Label14: TLabel
        Left = 16
        Top = 32
        Width = 216
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire temporaire'
      end
      object Label13: TLabel
        Left = 16
        Top = 232
        Width = 231
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire des donn'#233'es'
        Visible = False
      end
      object RepertoireDataBtn: TSpeedButton
        Left = 528
        Top = 272
        Width = 42
        Height = 42
        Hint = 'Choisir|Choix du r'#233'pertoire des donn'#233'es'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RepertoireDataBtnClick
      end
      object RazRepDataBtn: TSpeedButton
        Left = 600
        Top = 272
        Width = 42
        Height = 42
        Hint = 
          'Mes documents|Le r'#233'pertoire des donn'#233'es de Regressi sera "Mes do' +
          'cuments" de l'#39'utilisateur courant'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object VideoDirBtn: TSpeedButton
        Left = 528
        Top = 372
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoir des  videose'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = VideoDirBtnClick
      end
      object wavDirBtn: TSpeedButton
        Left = 528
        Top = 472
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire des sons'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = wavDirBtnClick
      end
      object ImagesDirBtn: TSpeedButton
        Left = 528
        Top = 572
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire des images'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = ImagesDirBtnClick
      end
      object Label15: TLabel
        Left = 16
        Top = 332
        Width = 211
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire des vid'#233'os'
      end
      object Label18: TLabel
        Left = 16
        Top = 432
        Width = 200
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoires des sons'
      end
      object Label19: TLabel
        Left = 16
        Top = 532
        Width = 217
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire des images'
      end
      object RazWavDirBtn: TSpeedButton
        Left = 600
        Top = 472
        Width = 42
        Height = 42
        Hint = 
          'Ma Musique|Le r'#233'pertoire des sons de Regressi sera "Ma musqiue" ' +
          'de l'#39'utilisateur courant'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object RazImagesDirBtn: TSpeedButton
        Left = 600
        Top = 572
        Width = 42
        Height = 42
        Hint = 
          'Mes images|Le r'#233'pertoire des images de Regressi sera "Mes images' +
          '" de l'#39'utilisateur courant'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object RazVideoDirBtn: TSpeedButton
        Left = 600
        Top = 372
        Width = 42
        Height = 42
        Hint = 
          'Mes Vid'#233'os|Le r'#233'pertoire des vid'#233'os sera "Mes Vid'#233'os" de l'#39'utili' +
          'sateur courant'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object Label20: TLabel
        Left = 16
        Top = 628
        Width = 444
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire des modules Python de l'#39'utilisateur'
      end
      object PythonDirBtn: TSpeedButton
        Left = 528
        Top = 668
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire des images'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = PythonDirBtnClick
      end
      object RazPythonDirBtn: TSpeedButton
        Left = 600
        Top = 668
        Width = 42
        Height = 42
        Hint = 'R'#224'Z : valeur par d'#233'faut'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object Label21: TLabel
        Left = 16
        Top = 718
        Width = 221
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#233'pertoire .DLL Python'
      end
      object PythonDllPathBtn: TSpeedButton
        Left = 528
        Top = 758
        Width = 42
        Height = 42
        Hint = 'Choix du r'#233'pertoire DLL Python'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 5
        ImageName = 'Item6'
        Images = FRegressiMain.VirtualImageList1
        OnClick = PythonDllPathBtnClick
      end
      object RazDllPythonPath: TSpeedButton
        Left = 600
        Top = 758
        Width = 42
        Height = 42
        Hint = 'R'#224'Z : valeur par d'#233'faut'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 2
        ImageName = 'Item3'
        Images = FRegressiMain.VirtualImageList1
        OnClick = RazRepDataBtnClick
      end
      object Label22: TLabel
        Left = 516
        Top = 6
        Width = 54
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Choix'
      end
      object Label23: TLabel
        Left = 600
        Top = 6
        Width = 37
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'R'#224'Z'
      end
      object GroupePathEdit: TEdit
        Left = 16
        Top = 172
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 0
      end
      object TempDirEdit: TEdit
        Left = 16
        Top = 72
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object DataPathEdit: TEdit
        Left = 16
        Top = 272
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
      object VideoPathEdit: TEdit
        Left = 16
        Top = 372
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 3
      end
      object wavpathEdit: TEdit
        Left = 16
        Top = 472
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 4
      end
      object ImagesPathEdit: TEdit
        Left = 16
        Top = 572
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 5
      end
      object PythonPathEdit: TEdit
        Left = 16
        Top = 668
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 6
      end
      object PythonDllPathEdit: TEdit
        Left = 16
        Top = 758
        Width = 480
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ReadOnly = True
        TabOrder = 7
      end
    end
    object PrintTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Imprimante'
      ImageIndex = 6
      object Label2: TLabel
        Left = 242
        Top = 372
        Width = 266
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nombre maximal de copies'
      end
      object FontSizeImprRG: TRadioGroup
        Left = 0
        Top = 0
        Width = 274
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille de la police'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '10'
          '12')
        TabOrder = 0
      end
      object PermuteCB: TCheckBox
        Left = 16
        Top = 180
        Width = 562
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Permute Col/Ligne des tableaux (impression, copie)'
        TabOrder = 1
      end
      object MaxCopiesSE: TSpinEdit
        Left = 528
        Top = 364
        Width = 98
        Height = 47
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 36
        MinValue = 1
        ParentFont = False
        TabOrder = 4
        Value = 1
      end
      object GridPrintCB: TCheckBox
        Left = 16
        Top = 268
        Width = 380
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Impression des grilles de tableau'
        TabOrder = 3
      end
      object ImpMonoCB: TCheckBox
        Left = 16
        Top = 224
        Width = 354
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Forcer impression monochrome'
        TabOrder = 2
      end
    end
    object AcquisitionTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Acquisition'
      ImageIndex = 6
      object GeneralLabel: TLabel
        Left = 16
        Top = 384
        Width = 349
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'La configuration ne sera pas sauv'#233'e '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object GenerallabelBis: TLabel
        Left = 16
        Top = 422
        Width = 308
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'car bloqu'#233'e par l'#39'administrateur'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object AcqListBox: TListBox
        Left = 2
        Top = 14
        Width = 274
        Height = 226
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ItemHeight = 30
        TabOrder = 0
      end
      object AddAcqBtn: TBitBtn
        Left = 304
        Top = 16
        Width = 274
        Height = 60
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Ajouter acquisition'
        TabOrder = 1
        OnClick = AddAcqBtnClick
      end
      object DelAcqBtn: TBitBtn
        Left = 304
        Top = 128
        Width = 274
        Height = 60
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Enlever acquisition'
        TabOrder = 2
        OnClick = DelAcqBtnClick
      end
      object DataCanModifCB: TCheckBox
        Left = 16
        Top = 256
        Width = 418
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Permission de modifier les donn'#233'es'
        TabOrder = 3
      end
      object SaveCfgAcqCB: TCheckBox
        Left = 16
        Top = 300
        Width = 370
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Sauver la config. de l'#39'acquisition'
        TabOrder = 4
      end
      object TriCB: TCheckBox
        Left = 16
        Top = 344
        Width = 338
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Ne pas trier les donn'#233'es'
        TabOrder = 5
      end
    end
    object PrefTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Pr'#233'f'#233'rences'
      ImageIndex = 7
      object Label24: TLabel
        Left = 16
        Top = 4
        Width = 195
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Modules accessibles'
      end
      object ToutModuleBtn: TBitBtn
        Left = 464
        Top = 16
        Width = 170
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '&Tous'
        ImageIndex = 1
        ImageName = 'Item2'
        Images = FRegressiMain.VirtualImageList1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = ToutModuleBtnClick
      end
      object AucunBtn: TBitBtn
        Left = 464
        Top = 80
        Width = 170
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Cancel = True
        Caption = '&Aucun'
        ImageIndex = 51
        ImageName = 'stopBis'
        Images = FRegressiMain.VirtualImageList1
        NumGlyphs = 2
        TabOrder = 1
        OnClick = AucunBtnClick
      end
      object MenuPermisCLB: TCheckListBox
        Left = 2
        Top = 42
        Width = 450
        Height = 514
        Hint = '|Cocher les modules qui seront accessibles'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        IntegralHeight = True
        ItemHeight = 34
        Items.Strings = (
          'Fen'#234'tre transform'#233'e de Fourier'
          'Fen'#234'tre graphe des param'#232'tres'
          'Fen'#234'tre statistique'
          'Mod'#233'les pr'#233'd'#233'finis'
          'Fonctions avanc'#233'es (lyc'#233'e)'
          'Utilisation des bornes'
          'Animation'
          'Calcul automatique des unit'#233's'
          'Impression du tableau des variables'
          'Menu choix de l'#39'imprimante'
          'Boutons d'#39'impression'
          'Acquisition'
          'Graphe de Cornish-Bowden'
          'Vecteurs vitesse/acc'#233'l'#233'ration'
          'Niveau de gris'
          'Fen'#234'tre d'#39'aide de mod'#233'lisation'
          'Liste des fichiers r'#233'cents'
          'M'#233'thode d'#39'Euler')
        TabOrder = 2
        OnClick = MenuPermisCLBClick
        OnClickCheck = MenuPermisCLBClickCheck
      end
      object OptionsFichierCB: TCheckBox
        Left = 6
        Top = 764
        Width = 450
        Height = 34
        Hint = 
          '|Les options du fichier sont priorotaires par rapport aux option' +
          's par d'#233'faut '
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Options sauv'#233'es dans le fichier'
        TabOrder = 3
        Visible = False
      end
      object BiochimieBtn: TBitBtn
        Left = 464
        Top = 144
        Width = 170
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Biochimie'
        TabOrder = 4
        OnClick = BiochimieBtnClick
      end
      object PhysiqueBtn: TBitBtn
        Left = 464
        Top = 208
        Width = 170
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Physique'
        TabOrder = 5
        OnClick = PhysiqueBtnClick
      end
    end
    object GrapheTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Graphique'
      ImageIndex = 6
      object Label11: TLabel
        Left = 8
        Top = 116
        Width = 282
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Ordre du lissage des courbes'
      end
      object Label17: TLabel
        Left = 8
        Top = 158
        Width = 259
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille des points par d'#233'faut'
      end
      object OptionsBtn: TSpeedButton
        Left = 218
        Top = 204
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
      object Label12: TLabel
        Left = 12
        Top = 230
        Width = 177
        Height = 30
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Couleurs, tailles  ...'
      end
      object IncertitudeHelpBtn: TSpeedButton
        Left = 276
        Top = 16
        Width = 46
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333333333333333300003333
          3333333333333333000033330033333333003333000033300003333330000333
          0000330000000000000000330000330F77FFFF7FFF77F0330000330FFF9FFF7F
          FFFF80330000330FF999FF70000003330000330FFF9FFF07777033330000330F
          FFFFFF0777033333000033800000000000333333000033333333393999393333
          0000333333333333933333330000333333333393339333330000333333333333
          9333333300003333333333333333333300003333333333333333333300003333
          33333333333333330000}
        OnClick = IncertitudeHelpBtnClick
      end
      object TraceDefautRG: TRadioGroup
        Left = 0
        Top = 631
        Width = 698
        Height = 120
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Trac'#233' par d'#233'faut'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Segments entre points'
          'Points seuls'
          'Points et lissage')
        TabOrder = 12
        OnClick = ModifGrapheClick
      end
      object GrilleCB: TCheckBox
        Left = 16
        Top = 64
        Width = 316
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Trac'#233' de grille par d'#233'faut'
        TabOrder = 1
        OnClick = ModifGrapheClick
      end
      object IncertitudeCB: TCheckBox
        Left = 16
        Top = 20
        Width = 256
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Trac'#233' des incertitudes'
        TabOrder = 0
        OnClick = IncertitudeCBClick
      end
      object OrdreSplineSE: TSpinEdit
        Left = 312
        Top = 100
        Width = 72
        Height = 47
        Hint = '|Plus l'#39'ordre est grand, plus le lissage est proche des points'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditorEnabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 7
        MinValue = 3
        ParentFont = False
        TabOrder = 2
        Value = 3
        OnClick = ModifGrapheClick
      end
      object DimPointSE: TSpinEdit
        Left = 312
        Top = 150
        Width = 72
        Height = 47
        Hint = 
          'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
          'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditorEnabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 20
        MinValue = 1
        ParentFont = False
        TabOrder = 3
        Value = 3
        OnClick = ModifGrapheClick
      end
      object GraduationZeroCB: TCheckBox
        Left = 400
        Top = 156
        Width = 258
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Axes passant par z'#233'ro'
        TabOrder = 5
        OnClick = ModifGrapheClick
      end
      object GraduationPiCB: TCheckBox
        Left = 400
        Top = 104
        Width = 258
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Radian traduit en '#960'/n'
        TabOrder = 4
        OnClick = ModifGrapheClick
      end
      object IncertitudeRG: TRadioGroup
        Left = 0
        Top = 479
        Width = 698
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Trac'#233' des incertitudes'
        Columns = 3
        Items.Strings = (
          'Ellipse'
          'Barre d'#39'erreur'
          'Rectangle')
        TabOrder = 10
        OnClick = ModifGrapheClick
      end
      object Memo1: TMemo
        Left = 0
        Top = 559
        Width = 698
        Height = 72
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Lines.Strings = (
          'L'#39'utilisation des ellipses supposent que les incertitudes '
          'soient donn'#233'es sous forme d'#39#233'cart-type')
        TabOrder = 11
      end
      object CoeffEllipseRG: TRadioGroup
        Left = 336
        Top = 4
        Width = 300
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille des ellipses'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'u'
          '2.u'
          '3.u')
        TabOrder = 6
        OnClick = CoeffEllipseRGClick
      end
      object UseItalicCB: TCheckBox
        Left = 16
        Top = 268
        Width = 284
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Grandeurs en italique'
        TabOrder = 7
      end
      object grapheClipRG: TRadioGroup
        Left = 0
        Top = 751
        Width = 698
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Format de la copie des graphes'
        Columns = 4
        Items.Strings = (
          'EMF'
          'Jpeg'
          'Bitmap'
          'Png')
        TabOrder = 9
      end
      object UniteParCB: TCheckBox
        Left = 336
        Top = 268
        Width = 282
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Unit'#233' avec parenth'#232'se'
        TabOrder = 8
      end
    end
  end
  object Panel1: TPanel
    Left = 714
    Top = 0
    Width = 220
    Height = 929
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object OKBtn: TBitBtn
      Left = 12
      Top = 16
      Width = 200
      Height = 60
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
      Left = 12
      Top = 96
      Width = 200
      Height = 60
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
      Left = 12
      Top = 176
      Width = 200
      Height = 60
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
    object FenetreRG: TRadioGroup
      Left = 0
      Top = 670
      Width = 220
      Height = 260
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Fen'#234'tres'
      ItemIndex = 0
      Items.Strings = (
        'Maximis'#233'es'
        'Cascade'
        'Mosa'#239'q. vert.'
        'Mosa'#239'q. horiz.'
        'Manuelle')
      TabOrder = 3
      ExplicitTop = 669
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'exe'
    Filter = 'Programme d'#39'acquisition|*.exe'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Programme d'#39'acquisition'
    Left = 768
    Top = 312
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 776
    Top = 464
  end
end
