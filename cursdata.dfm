object ReticuleDataDlg: TReticuleDataDlg
  Left = 453
  Top = 202
  HelpContext = 49
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Curseur donn'#233'es'
  ClientHeight = 552
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 110
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Curseur 1'
  end
  object Label2: TLabel
    Left = 16
    Top = 152
    Width = 110
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Curseur 2'
  end
  object OKBtn: TBitBtn
    Left = 280
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
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 280
    Top = 96
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
    Left = 280
    Top = 176
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
  object Curseur1GB: TComboBox
    Left = 16
    Top = 48
    Width = 226
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Curseur2GB: TComboBox
    Left = 16
    Top = 192
    Width = 226
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object OptionsGB: TGroupBox
    Left = 0
    Top = 316
    Width = 504
    Height = 236
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Affichage'
    TabOrder = 5
    object PenteCB: TCheckBox
      Left = 16
      Top = 40
      Width = 162
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Pente'
      TabOrder = 0
    end
    object YCB: TCheckBox
      Left = 256
      Top = 88
      Width = 178
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ordonn'#233'e'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object XCB: TCheckBox
      Left = 16
      Top = 88
      Width = 162
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Abscisse'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object DeltaXCB: TCheckBox
      Left = 16
      Top = 136
      Width = 242
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ecart abscisse'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object ReticuleCB: TCheckBox
      Left = 256
      Top = 40
      Width = 194
      Height = 34
      Hint = '|Trace ou non un r'#233'ticule pour rep'#233'rer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#233'ticule'
      TabOrder = 1
    end
    object deltaYCB: TCheckBox
      Left = 256
      Top = 136
      Width = 242
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ecart ordonn'#233'e'
      TabOrder = 5
    end
    object GridCB: TCheckBox
      Left = 96
      Top = 182
      Width = 258
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Tableau de valeurs'
      TabOrder = 6
    end
  end
  object TangenteColor: TColorBox
    Left = 16
    Top = 258
    Width = 200
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = [cbStandardColors, cbExtendedColors, cbPrettyNames]
    ItemHeight = 32
    TabOrder = 6
  end
  object LigneCombo: TComboBoxEx
    Left = 234
    Top = 258
    Width = 200
    Height = 38
    Hint = 'Lignes de rappel'
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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -22
    Font.Name = 'Regressi'
    Font.Style = []
    ItemHeight = 32
    ParentFont = False
    TabOrder = 7
    Images = VirtualImageList2
  end
  object DeuxCurseursCB: TCheckBox
    Left = 16
    Top = 112
    Width = 242
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Deux curseurs'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = DeuxCurseursCBClick
  end
  object ImageCollection2: TImageCollection
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
    Left = 184
    Top = 348
  end
  object VirtualImageList2: TVirtualImageList
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
    ImageCollection = ImageCollection2
    Width = 32
    Height = 32
    Left = 400
    Top = 324
  end
end
