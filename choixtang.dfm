object ChoixTangenteDlg: TChoixTangenteDlg
  Left = 403
  Top = 167
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Trac'#233' de tangentes'
  ClientHeight = 414
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object OptionsBtn: TSpeedButton
    Left = 468
    Top = 64
    Width = 54
    Height = 54
    Hint = 'Options|Stoechiom'#233'trie, couleur ...'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AllowAllUp = True
    GroupIndex = 1
    ImageIndex = 10
    ImageName = 'Item11'
    Images = FRegressiMain.VirtualImageList1
    NumGlyphs = 4
    ParentShowHint = False
    ShowHint = True
    OnClick = OptionsBtnClick
  end
  object CancelBtn: TBitBtn
    Left = 248
    Top = 64
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
    Top = 0
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
    Top = 64
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
    Top = 130
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
    Top = 174
    Width = 548
    Height = 240
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = TabSheet3
    Align = alBottom
    TabOrder = 4
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
