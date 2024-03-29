object ChoixTangenteDlg: TChoixTangenteDlg
  Left = 403
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Trac'#233' de tangentes'
  ClientHeight = 432
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object OptionsBtn: TSpeedButton
    Left = 468
    Top = 80
    Width = 54
    Height = 54
    Hint = 'Options|Stoechiom'#233'trie, couleur ...'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AllowAllUp = True
    GroupIndex = 1
    Glyph.Data = {
      76020000424D7602000000000000760000002800000040000000100000000100
      0400000000000002000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333338FF33333333333338FF3333333333333033333333333333000333
      3333333333888F333333333333888F3333333333330003333333333333070333
      3333333F33888FF33F33333F33888FF33F333333330703333333333333000333
      33333383F888883F83333383F888883F833333B33B000B33B3333333330F0333
      33333338838F8F88F3333338838F8F88F333333BBB0B0BBB33333333330F0333
      33333338338383F83F333338338383F83F33333BBB0F0BBB3333333330F8F033
      3333338F3838F83F8F33338F3838F83F8F3333BBB0F8F0BBB33333330FF8FF03
      33333F838F38F38F83FF3F838F38F38F83FF33BB0FB8BF0BB33333330FF8FF03
      3333883F8F38338F3883883F8F38338F3883BBBB0BF8FB0BBBB333330FFFFF03
      3333338F83F333838F33338F83F333838F3333BB0FBFBF0BB333333330FFF033
      33333383F83FF83383333383F83FF833833333BBB0FBF0BBB333333333000333
      33333338FF888338F3333338FF888338F333333BBB000BBB3333333333333333
      3333333883FF3F883F33333883FF3F883F33333BBBBBBBBB3333333333333333
      33333383388388338333338338838833833333B33BBBBB33B333333333333333
      333333333338F333333333333338F33333333333333B33333333333333333333
      3333333333383333333333333338333333333333333B33333333}
    NumGlyphs = 4
    ParentShowHint = False
    ShowHint = True
    OnClick = OptionsBtnClick
  end
  object CancelBtn: TBitBtn
    Left = 248
    Top = 80
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
    TabOrder = 2
    IsControl = True
  end
  object TangenteCB: TComboBox
    Left = 8
    Top = 16
    Width = 522
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 0
    Text = 'M'#233'thode des tangentes (d'#233'pla'#231'ables)'
    OnChange = TangenteCBChange
    Items.Strings = (
      'M'#233'thode des tangentes (avec clic)'
      'M'#233'thode des tangentes (d'#233'pla'#231'ables)'
      'Tangente simple')
  end
  object OKBtn: TBitBtn
    Left = 16
    Top = 80
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object SupprCB: TCheckBox
    Left = 16
    Top = 146
    Width = 518
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Suppression des tangentes existantes'
    TabOrder = 3
  end
  object OptionsPC: TPageControl
    Left = 0
    Top = 192
    Width = 540
    Height = 240
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = TabSheet3
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 191
    ExplicitWidth = 526
    object TabSheet1: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Calcul'
      object Label4: TLabel
        Left = 6
        Top = 40
        Width = 293
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nombre de points utilis'#233's'
      end
      object Label1: TLabel
        Left = 6
        Top = 84
        Width = 305
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'pour le calcul de la d'#233'riv'#233'e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object NbreEdit: TEdit
        Left = 348
        Top = 48
        Width = 50
        Height = 53
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '5'
      end
      object SpinButton1: TSpinButton
        Left = 396
        Top = 48
        Width = 40
        Height = 58
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
        TabOrder = 1
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
    end
    object StoechTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Stoechiom'#232'trie'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 48
        Width = 85
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Burette'
      end
      object Label5: TLabel
        Left = 240
        Top = 48
        Width = 79
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Becher'
      end
      object Burette: TSpinEdit
        Left = 128
        Top = 38
        Width = 80
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 6
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 1
      end
      object Becher: TSpinEdit
        Left = 360
        Top = 38
        Width = 80
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 6
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
      end
    end
    object TabSheet3: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Affichage'
      ImageIndex = 2
      object LabelLargeur: TLabel
        Left = 70
        Top = 124
        Width = 110
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Extension'
      end
      object TraitCB: TComboBoxEx
        Left = 276
        Top = 62
        Width = 240
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ItemsEx = <
          item
            Caption = 'Plein'
            ImageIndex = 0
            SelectedImageIndex = 0
          end
          item
            Caption = 'Tirets'
            ImageIndex = 1
            SelectedImageIndex = 1
          end
          item
            Caption = 'Pointill'#233's'
            ImageIndex = 2
            SelectedImageIndex = 2
          end
          item
            Caption = 'Tiret point'
            ImageIndex = 3
            SelectedImageIndex = 3
          end
          item
            Caption = 'Mixte'
            ImageIndex = 4
            SelectedImageIndex = 4
          end>
        ItemHeight = 39
        TabOrder = 2
      end
      object TangenteColor: TColorBox
        Left = 276
        Top = 6
        Width = 240
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 1
      end
      object LargeurCB: TComboBox
        Left = 276
        Top = 120
        Width = 240
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        TabOrder = 3
        Items.Strings = (
          'Sans limite'
          'Grande'
          'Moyenne'
          'Petite'
          'Tr'#232's petite')
      end
      object GridCB: TCheckBox
        Left = 6
        Top = 16
        Width = 258
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau de valeurs'
        TabOrder = 0
      end
    end
  end
end
