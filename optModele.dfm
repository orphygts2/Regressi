object OptionModeleDlg: TOptionModeleDlg
  Left = 452
  Top = 210
  HelpContext = 55
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options de mod'#233'lisation'
  ClientHeight = 842
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 540
    Top = 52
    Width = 200
    Height = 54
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
    Left = 540
    Top = 178
    Width = 200
    Height = 54
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
    Left = 540
    Top = 310
    Width = 200
    Height = 54
    HelpContext = 55
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
    Width = 530
    Height = 842
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = TabSheet1
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 3
    ExplicitHeight = 669
    object TabSheet2: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Calculs'
      ImageIndex = 1
      object IncertitudeHelpBtn: TSpeedButton
        Left = 64
        Top = 388
        Width = 318
        Height = 52
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Aide incertitudes '
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
      object Chi2CB: TCheckBox
        Left = 0
        Top = 20
        Width = 418
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Utilisation des incertitudes ('#967#178')'
        TabOrder = 0
      end
      object LevenbergCB: TCheckBox
        Left = 0
        Top = 64
        Width = 322
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Levenberg-Marquardt'
        TabOrder = 1
      end
      object RecuitCB: TCheckBox
        Left = 0
        Top = 108
        Width = 194
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Recuit'
        TabOrder = 2
      end
      object UnitParamCB: TCheckBox
        Left = 0
        Top = 152
        Width = 504
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Unit'#233's auto. des param'#232'tres'
        TabOrder = 3
      end
      object AjusteOrigineCB: TCheckBox
        Left = 0
        Top = 196
        Width = 338
        Height = 34
        Hint = 
          '|D'#233'termination de la valeur initiale lors de mod'#233'lisation par '#233'q' +
          'uations diff'#233'rentielles'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Valeur initiale ('#233'qua. diff.)'
        TabOrder = 4
      end
      object ModelePagesIndependantesCB: TCheckBox
        Left = 0
        Top = 240
        Width = 418
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'le d'#233'pendant de la page'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ModeleManuelCB: TCheckBox
        Left = 0
        Top = 284
        Width = 354
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'lisation manuelle'
        TabOrder = 6
      end
    end
    object TabSheet1: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Affichage'
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 0
        Top = 618
        Width = 514
        Height = 160
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Coefficient de corr'#233'lation'
        TabOrder = 0
        ExplicitTop = 446
        object LabelCorrel: TLabel
          Left = 16
          Top = 90
          Width = 220
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Nombre de chiffres'
        end
        object AfficheCorrel: TCheckBox
          Left = 16
          Top = 34
          Width = 338
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Affichage du coefficient'
          TabOrder = 0
          OnClick = AfficheCorrelClick
        end
        object ChiffreCorrelSE: TSpinEdit
          Left = 256
          Top = 80
          Width = 98
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
          MaxValue = 7
          MinValue = 2
          ParentFont = False
          TabOrder = 1
          Value = 4
        end
      end
      object EchelleModeleCB: TCheckBox
        Left = 8
        Top = 12
        Width = 400
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Echelle selon mod'#233'lisation'
        TabOrder = 1
      end
      object ExtrapoleModeleCB: TCheckBox
        Left = 8
        Top = 56
        Width = 452
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Inter/Extrapolation des mod'#232'les'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object IncertitudeCB: TCheckBox
        Left = 8
        Top = 100
        Width = 438
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Trac'#233' des ellipses d'#39'incertitudes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object VisuAjusteCB: TCheckBox
        Left = 8
        Top = 144
        Width = 400
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Trac'#233' pendant l'#39'ajustement'
        TabOrder = 4
      end
      object BandeConfianceCB: TCheckBox
        Left = 8
        Top = 188
        Width = 496
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Affichage bande de confiance '#224' 95%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = AfficheCorrelClick
      end
      object AffichePvaleur: TCheckBox
        Left = 8
        Top = 322
        Width = 194
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'P-valeurs'
        TabOrder = 6
      end
      object IncertParamRG: TRadioGroup
        Left = 0
        Top = 328
        Width = 514
        Height = 80
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Incertitudes sur les param'#232'tres'
        Columns = 3
        Items.Strings = (
          'type'
          #224' 95%'
          'les deux')
        TabOrder = 7
        ExplicitTop = 366
      end
      object ModelePourCentCB: TCheckBox
        Left = 8
        Top = 276
        Width = 480
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Affichage '#233'cart donn'#233'es-mod'#232'le en %'
        TabOrder = 8
        OnClick = AfficheCorrelClick
      end
      object BandePredictionCB: TCheckBox
        Left = 6
        Top = 230
        Width = 496
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Affichage bande de pr'#233'diction '#224' 95%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = AfficheCorrelClick
      end
      object ChiffreSignifRG: TRadioGroup
        Left = 0
        Top = 408
        Width = 514
        Height = 210
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Nombre de chiffres significatifs incertitude'
        ItemIndex = 0
        Items.Strings = (
          'Eduscol : deux chiffres'
          'GUM : deux si commence par 1 2 3 '
          'Unique : un chiffre')
        TabOrder = 10
        ExplicitLeft = 256
        ExplicitTop = 432
        ExplicitWidth = 370
      end
    end
    object TabSheet3: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Couleurs'
      ImageIndex = 2
      object Label5: TLabel
        Left = 16
        Top = 16
        Width = 108
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'le 1'
      end
      object Label12: TLabel
        Left = 16
        Top = 66
        Width = 108
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'le 2'
      end
      object Label6: TLabel
        Left = 16
        Top = 116
        Width = 108
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'le 3'
      end
      object Label13: TLabel
        Left = 16
        Top = 166
        Width = 108
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'le 4'
      end
      object Label7: TLabel
        Left = 16
        Top = 236
        Width = 180
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Superposition 1'
      end
      object Label8: TLabel
        Left = 16
        Top = 286
        Width = 180
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Superposition 2'
      end
      object Label9: TLabel
        Left = 16
        Top = 336
        Width = 180
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Superposition 3'
      end
      object Label10: TLabel
        Left = 16
        Top = 386
        Width = 180
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Superposition 4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object OptionCouleursBtn: TSpeedButton
        Left = 16
        Top = 468
        Width = 274
        Height = 52
        Hint = 'Couleurs, motifs des courbes'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Autres couleurs'
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FF33733337333373333333CCCC3377777777777773333300003373
          3337333373333333000033733337333373333333000033777777777777733333
          0000337333373333733333331608337333373333733333330AA0337777777777
          777333333324337333373333733333338AB333333333333333333333FE6533EE
          E3555344436663330FC933EEE355534443666333ABD933EEE355534443666333
          0611333333333333333333330C22339993BBB32223DDD333EC77339993BBB322
          23DDD3335136339993BBB32223DDD33333793333333333333333333300663333
          33333333333333330011}
        OnClick = OptionCouleursBtnClick
      end
      object ColorBox1: TColorBox
        Tag = 1
        Left = 220
        Top = 12
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemHeight = 28
        ParentFont = False
        TabOrder = 0
        OnChange = ColorBox1Change
      end
      object ColorBox8: TColorBox
        Tag = 2
        Left = 220
        Top = 60
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 1
        OnChange = ColorBox1Change
      end
      object ColorBox7: TColorBox
        Tag = 3
        Left = 220
        Top = 108
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 2
        OnChange = ColorBox1Change
      end
      object ColorBox6: TColorBox
        Tag = 4
        Left = 220
        Top = 156
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 3
        OnChange = ColorBox1Change
      end
      object ColorBox2: TColorBox
        Tag = -4
        Left = 220
        Top = 372
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 4
        OnChange = ColorBox1Change
      end
      object ColorBox3: TColorBox
        Tag = -3
        Left = 220
        Top = 324
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 5
        OnChange = ColorBox1Change
      end
      object ColorBox4: TColorBox
        Tag = -2
        Left = 220
        Top = 276
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 6
        OnChange = ColorBox1Change
      end
      object ColorBox5: TColorBox
        Tag = -1
        Left = 220
        Top = 228
        Width = 240
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbIncludeDefault, cbPrettyNames]
        ItemHeight = 28
        TabOrder = 7
        OnChange = ColorBox1Change
      end
    end
  end
end
