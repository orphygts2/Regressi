object FcoordonneesEuler: TFcoordonneesEuler
  Left = 277
  Top = 180
  HelpContext = 23
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Coordonn'#233'es du graphe'
  ClientHeight = 380
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 38
  object Panel1: TPanel
    Left = 670
    Top = 0
    Width = 216
    Height = 380
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 3
    ExplicitLeft = 598
    ExplicitHeight = 379
    object OKBtn: TBitBtn
      Left = 12
      Top = 12
      Width = 200
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
      Left = 4
      Top = 232
      Width = 200
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
  end
  object GroupBoxOptions: TGroupBox
    Left = 8
    Top = 228
    Width = 650
    Height = 136
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Options g'#233'n'#233'rales'
    TabOrder = 4
    object LabelWidth: TLabel
      Left = 372
      Top = 33
      Width = 236
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Epaisseur des traits'
    end
    object OrthonormeCB: TCheckBox
      Left = 16
      Top = 36
      Width = 274
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axes orthonorm'#233's'
      TabOrder = 0
    end
    object OldParamCB: TCheckBox
      Left = 16
      Top = 82
      Width = 474
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Affichage du param'#232'tre pr'#233'c'#233'dent'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object WidthEcranSE: TSpinEdit
      Left = 502
      Top = 82
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
      TabOrder = 2
      Value = 3
    end
  end
  object AbscisseGB: TGroupBox
    Left = 8
    Top = 8
    Width = 300
    Height = 108
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 0
    object LabelZeroX: TLabel
      Left = 166
      Top = 7
      Width = 136
      Height = 38
      Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Z'#233'ro inclus'
    end
    object ListeX: TComboBox
      Tag = 1
      Left = 16
      Top = 48
      Width = 160
      Height = 46
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
      Left = 220
      Top = 56
      Width = 30
      Height = 30
      Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
  end
  object OrdonneeGB: TGroupBox
    Left = 332
    Top = 8
    Width = 326
    Height = 108
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 1
    object labelZeroY: TLabel
      Left = 166
      Top = 3
      Width = 136
      Height = 38
      Hint = '|Inclure le z'#233'ro sur l'#39'axe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Z'#233'ro inclus'
    end
    object ListeY: TComboBox
      Tag = 1
      Left = 16
      Top = 48
      Width = 160
      Height = 46
      Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Style = csDropDownList
      DropDownCount = 10
      TabOrder = 0
      OnChange = ListeYChange
    end
    object ZeroYCB: TCheckBox
      Tag = 1
      Left = 220
      Top = 52
      Width = 30
      Height = 30
      Hint = '|Inclure le z'#233'ro sur l'#39'axe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
  end
  object OptionsGB: TGroupBox
    Left = 8
    Top = 120
    Width = 650
    Height = 108
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Motif'
    TabOrder = 2
    object LabelDimPoint: TLabel
      Left = 284
      Top = 48
      Width = 62
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Taille'
    end
    object DimPointSE: TSpinEdit
      Left = 384
      Top = 44
      Width = 84
      Height = 56
      Hint = 
        'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
        'e'
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
      MaxValue = 20
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 3
    end
    object PointCombo: TComboBoxEx
      Left = 28
      Top = 44
      Width = 196
      Height = 47
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
        end>
      Style = csExDropDownList
      TabOrder = 1
      Images = VirtualImageList1
      DropDownCount = 12
    end
  end
  object ImageCollection1: TImageCollection
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
      end>
    Left = 576
    Top = 128
  end
  object VirtualImageList1: TVirtualImageList
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
      end>
    ImageCollection = ImageCollection1
    Width = 20
    Height = 20
    Left = 664
    Top = 120
  end
end
