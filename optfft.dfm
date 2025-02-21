object OptionsFFTDlg: TOptionsFFTDlg
  Left = 456
  Top = 200
  HelpContext = 53
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options transform'#233'e de Fourier'
  ClientHeight = 420
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000077777777777777777777777777777700F77
    77777777777777777777777777700FF888888888888888888888888887700FF8
    88888888888888888888888887700FF888888888888888888888888887700FF8
    8FF88FF88FF88FF88FF88FF887700FF880F880F880F880F880F880F887700FF8
    88888848884888488848884887700FF888888848884888488848888887700FF8
    8FF88848884888488888888887700FF880F88848884888488888888887700FF8
    88888848884888488888888887700FF888888848884888888888888887700FF8
    8FF88848884888888888888887700FF880F88848884888888888888887700FF8
    88888848888888888888888887700FF888888848888888888888888887700FF8
    8FF88848888888888888888887700FF880F88848888888888888888887700FF8
    88888848888888888888888887700FF888888848888888888888888887700FF8
    8FF88848888888888888888887700FF880F88848888888888888888887700FF8
    88888888888888888888888887700FF888888888888888888888888887700FF8
    8FF88888888888888888888887700FF880F88888888888888888888887700FF8
    88888888888888888888888887700FFFFFFFFFFFFFFFFFFFFFFFFFFFF7700FFF
    FFFFFFFFFFFFFFFFFFFFFFFFFF70000000000000000000000000000000008000
    0001000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000080000001}
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object PanelBoutons: TPanel
    Left = 624
    Top = 0
    Width = 234
    Height = 420
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    BorderStyle = bsSingle
    ParentColor = True
    TabOrder = 0
    ExplicitLeft = 610
    ExplicitHeight = 419
    object BtnOK: TBitBtn
      Left = 12
      Top = 10
      Width = 200
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnCancel: TBitBtn
      Left = 12
      Top = 154
      Width = 200
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object BtnHelp: TBitBtn
      Left = 12
      Top = 298
      Width = 200
      Height = 56
      HelpContext = 801
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      NumGlyphs = 2
      TabOrder = 2
      OnClick = BtnHelpClick
    end
  end
  object PanelOptions: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 420
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = True
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 1
    ExplicitWidth = 610
    ExplicitHeight = 419
    object PageControl: TPageControl
      Left = 0
      Top = 0
      Width = 624
      Height = 420
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ActivePage = AbscisseTS
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 610
      ExplicitHeight = 419
      object AbscisseTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Abscisse'
        object LabelNomTemps: TLabel
          Left = 16
          Top = 32
          Width = 240
          Height = 30
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          AutoSize = False
          Caption = 't'
        end
        object Label4: TLabel
          Left = 140
          Top = 200
          Width = 453
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #8240' mini des harmoniques (tableau, son)'
        end
        object Label2: TLabel
          Left = 140
          Top = 268
          Width = 250
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'D'#233'calage des courbes'
        end
        object FreqReduiteCB: TCheckBox
          Left = 16
          Top = 80
          Width = 402
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Abscisse=fr'#233'quence r'#233'duite'
          TabOrder = 0
          Visible = False
        end
        object OptimiseNbreHarmCB: TCheckBox
          Left = 16
          Top = 128
          Width = 546
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Echelle de fr'#233'quence automatique'
          TabOrder = 1
        end
        object HarmMinSE: TSpinEdit
          Left = 16
          Top = 184
          Width = 108
          Height = 56
          Hint = 'Niveau de validit'#233'|Les valeurs plus petites en sont pas tabul'#233'es'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 100
          MinValue = 1
          ParentFont = False
          TabOrder = 2
          Value = 2
        end
        object DecalageSE: TSpinEdit
          Left = 16
          Top = 252
          Width = 108
          Height = 56
          Hint = '|D'#233'calage en pixel entre les diff'#233'rents spectres'
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
          MinValue = 0
          ParentFont = False
          TabOrder = 3
          Value = 2
        end
        object ContinuCB: TCheckBox
          Left = 16
          Top = 316
          Width = 306
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Inclure le continu'
          TabOrder = 4
        end
        object GrandeurBtn: TBitBtn
          Left = 336
          Top = 20
          Width = 226
          Height = 50
          Hint = 'Modification du nom, de l'#39'affichage ...'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'GrandeurBtn'
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
          TabOrder = 5
          OnClick = GrandeurFreqBtn
        end
        object periodiqueCB: TCheckBox
          Left = 350
          Top = 316
          Width = 250
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Signal p'#233'rioidique'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
      end
      object CalculTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Fen'#234'tre'
        ImageIndex = 1
        object FenetreRadioG: TRadioGroup
          Left = 0
          Top = 186
          Width = 608
          Height = 170
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alBottom
          Caption = 'Fen'#234'tre'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Naturelle (&rectangle)'
            '&Hamming'
            '&Toit plat'
            '&Blackman'
            'Naturelle &corrig'#233'e')
          TabOrder = 0
        end
        object ReglePeriodeCB: TCheckBox
          Left = 32
          Top = 6
          Width = 322
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'R'#233'glage dur'#233'e d'#39'analyse'
          TabOrder = 1
        end
        object AjusteRectangleRG: TRadioGroup
          Left = 0
          Top = 50
          Width = 608
          Height = 136
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alBottom
          Caption = 'Si nombre de points diff'#233'rents de 2^n'
          Items.Strings = (
            'Interpolation'
            'Compl'#233'ment '#224' z'#233'ro')
          TabOrder = 2
        end
      end
      object OrdonneeTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Ordonn'#233'e'
        ImageIndex = 2
        object LabeldB: TLabel
          Left = 404
          Top = 136
          Width = 145
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'dB minimum'
        end
        object LabelWidth: TLabel
          Left = 240
          Top = 20
          Width = 218
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Epaisseur des traits'
        end
        object OptionsBtn: TSpeedButton
          Left = 362
          Top = 66
          Width = 50
          Height = 52
          Hint = 'Couleurs, motifs des courbes'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
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
          OnClick = OptionsBtnClick
        end
        object Label12: TLabel
          Left = 240
          Top = 72
          Width = 101
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Couleurs'
        end
        object SpinMindB: TSpinButton
          Left = 362
          Top = 130
          Width = 30
          Height = 40
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          DownGlyph.Data = {
            7E040000424D7E04000000000000360400002800000009000000060000000100
            0800000000004800000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
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
          TabOrder = 1
          UpGlyph.Data = {
            7E040000424D7E04000000000000360400002800000009000000060000000100
            0800000000004800000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
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
          OnDownClick = SpinMindBDownClick
          OnUpClick = SpinMindBUpClick
        end
        object EditMindB: TEdit
          Left = 240
          Top = 130
          Width = 112
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Enabled = False
          TabOrder = 2
        end
        object OrdonneeRG: TRadioGroup
          Left = 0
          Top = 276
          Width = 608
          Height = 80
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alBottom
          Caption = 'Ordonn'#233'e'
          Columns = 3
          Items.Strings = (
            'amplitude'
            'puissance'
            'r'#233'duite')
          TabOrder = 3
        end
        object DecibelCB: TCheckBox
          Left = 240
          Top = 190
          Width = 130
          Height = 34
          Hint = 'd'#233'cibel'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'en dB'
          TabOrder = 4
          OnClick = dBCheckBoxClick
        end
        object EnveloppeCB: TCheckBox
          Left = 240
          Top = 236
          Width = 320
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Trac'#233' de l'#39'enveloppe'
          TabOrder = 5
        end
        object WidthEcranSE: TSpinEdit
          Left = 492
          Top = 8
          Width = 72
          Height = 56
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          EditorEnabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 5
          MinValue = 1
          ParentFont = False
          TabOrder = 6
          Value = 1
        end
        object ListeVariableBox: TListBox
          Left = 8
          Top = 6
          Width = 200
          Height = 262
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          ExtendedSelect = False
          ItemHeight = 36
          MultiSelect = True
          TabOrder = 0
        end
      end
      object SuperpositionTS: TTabSheet
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Superposition'
        ImageIndex = 3
        object PagesBtn: TSpeedButton
          Left = 384
          Top = 6
          Width = 48
          Height = 48
          Hint = 'Choix|Choix des pages superpos'#233'es'
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
            33333333333333330000333333000000000033330000333330BFBFBFBFB03333
            0000333300FBFBFBFBF0333300003330B0BFBFBFBFB0333300003300F0FBFBFB
            FBF03333000030B0B0BFBFBFBFB03333000030F0F0FBFBFBFBF03333000030B0
            B008999998033333000030F0FB0FBFB0F0333333000030B00080000803333333
            000030FB0FBFB0F0333333330000300089999803333333330000330FBFB03333
            3333333300003380000833333333333300003333333333333333333300003333
            33333333333333330000}
          OnClick = PagesBtnClick
        end
        object SuperPagesCB: TCheckBox
          Left = 6
          Top = 34
          Width = 338
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Superposition des pages'
          TabOrder = 0
          OnClick = SuperPagesCBClick
        end
        object AnalyseurCB: TCheckBox
          Left = 6
          Top = 80
          Width = 546
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Courbes s'#233'par'#233'es (non superpos'#233'es)'
          TabOrder = 1
        end
        object NbreRaiesEdit: TLabeledEdit
          Left = 262
          Top = 172
          Width = 82
          Height = 53
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          EditLabel.Width = 217
          EditLabel.Height = 53
          EditLabel.Margins.Left = 6
          EditLabel.Margins.Top = 6
          EditLabel.Margins.Right = 6
          EditLabel.Margins.Bottom = 6
          EditLabel.Caption = 'Nombre de valeurs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Segoe UI'
          Font.Style = []
          LabelPosition = lpLeft
          ParentFont = False
          TabOrder = 2
          Text = '0'
        end
        object NbreRaiesUD: TUpDown
          Left = 344
          Top = 172
          Width = 32
          Height = 53
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Associate = NbreRaiesEdit
          Max = 16
          TabOrder = 3
        end
        object HarmoniqueAffCB: TCheckBox
          Left = 6
          Top = 126
          Width = 546
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Affichage de la valeur des harmoniques'
          TabOrder = 4
        end
      end
    end
  end
end
