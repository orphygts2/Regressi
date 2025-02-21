object OptiqueForm: TOptiqueForm
  Left = 187
  Top = 234
  HelpContext = 79
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Lecture d'#39'intensit'#233' lumineuse ; mesure d'#39'angle, de distance'
  ClientHeight = 1738
  ClientWidth = 2024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClick = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 192
  TextHeight = 36
  object StatusBar: TStatusBar
    Left = 0
    Top = 1698
    Width = 2024
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <>
    SimplePanel = True
    ExplicitTop = 1711
    ExplicitWidth = 2206
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 2024
    Height = 65
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 63
    ButtonWidth = 141
    EdgeBorders = [ebBottom]
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 2206
    object OpenFileBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Ouverture d'#39'un fichier image'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Charger '
      ImageIndex = 10
      ImageName = 'Item11'
      OnClick = OpenFileBtnClick
    end
    object SaveBtn: TToolButton
      Left = 109
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Enregistrer '
      Enabled = False
      ImageIndex = 8
      ImageName = 'Item9'
      OnClick = SaveBtnClick
    end
    object EditBidon: TEdit
      Left = 251
      Top = 0
      Width = 2
      Height = 63
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
      Text = 'EditBidon'
      OnKeyDown = EditBidonKeyDown
    end
    object AcquireBtn: TToolButton
      Left = 253
      Top = 0
      Hint = 'Acquisition d'#39'une image '#224' partir de la cam'#233'ra'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Acquisition '
      ImageIndex = 4
      ImageName = 'Item5'
      OnClick = AcquireBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 398
      Top = 0
      Hint = 'Traitements des donn'#233'es par Regressi'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Traiter '
      Enabled = False
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = RegressiBtnClick
    end
    object PythonBtn: TToolButton
      Left = 488
      Top = 0
      Hint = 'Exporter les donn'#233'es sous forme de liste Python'
      AutoSize = True
      Caption = 'Python '
      Enabled = False
      ImageIndex = 9
      ImageName = 'Item10'
      OnClick = PythonBtnClick
    end
    object ExitBtn: TToolButton
      Left = 588
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Fermer'
      ImageIndex = 6
      ImageName = 'Item7'
      OnClick = ExitBtnClick
    end
  end
  object PanelBoutons: TPanel
    Left = 0
    Top = 65
    Width = 300
    Height = 1633
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    ShowCaption = False
    TabOrder = 2
    object LissageGB: TGroupBox
      Left = 1
      Top = 1
      Width = 298
      Height = 160
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Lissage'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 44
        Width = 30
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'x='
      end
      object MoyenneSE: TSpinEdit
        Left = 48
        Top = 36
        Width = 100
        Height = 47
        Hint = 
          'Lissage entre prenant la moyenne sur x lignes au-dessus et en-de' +
          'ssous'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        MaxValue = 128
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = MoyenneSEChange
      end
      object Memo: TMemo
        Left = 2
        Top = 94
        Width = 294
        Height = 64
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Moyenne sur 2x+1 lignes '
          'au-dessus et en-dessous')
        ParentFont = False
        TabOrder = 1
      end
    end
    object EchelleGB: TGroupBox
      Left = 1
      Top = 161
      Width = 298
      Height = 340
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Echelle OA'
      TabOrder = 1
      object UniteLabel: TLabel
        Left = 10
        Top = 200
        Width = 62
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Unit'#233
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 122
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Dimension'
      end
      object EchelleEdit: TLabeledEdit
        Left = 10
        Top = 128
        Width = 200
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditLabel.Width = 246
        EditLabel.Height = 36
        EditLabel.Margins.Left = 6
        EditLabel.Margins.Top = 6
        EditLabel.Margins.Right = 6
        EditLabel.Margins.Bottom = 6
        EditLabel.Caption = 'Longueur de l'#39#233'chelle'
        TabOrder = 1
        Text = ''
        OnExit = EchelleEditExit
        OnKeyDown = EchelleEditKeyDown
        OnKeyPress = EchelleEditKeyPress
      end
      object UniteCB: TComboBox
        Left = 82
        Top = 186
        Width = 100
        Height = 38
        Hint = 'Unit'#233' de l'#39#233'chelle'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'm'
        OnChange = UniteCBChange
        Items.Strings = (
          'm'
          'mm'
          #181'm'
          'nm')
      end
      object OrigineEdit: TLabeledEdit
        Left = 10
        Top = 272
        Width = 178
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditLabel.Width = 248
        EditLabel.Height = 36
        EditLabel.Margins.Left = 6
        EditLabel.Margins.Top = 6
        EditLabel.Margins.Right = 6
        EditLabel.Margins.Bottom = 6
        EditLabel.Caption = 'Origine de l'#39#233'chelle O'
        TabOrder = 0
        Text = '0'
        OnExit = EchelleEditExit
        OnKeyDown = EchelleEditKeyDown
        OnKeyPress = EchelleEditKeyPress
      end
      object OrigineZeroBtn: TBitBtn
        Left = 194
        Top = 272
        Width = 50
        Height = 50
        Hint = 'Remise '#224' z'#233'ro de la valeur de l'#39'origine'
        HelpType = htKeyword
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003888888888888888888300003833333333333333338300003839
          9999999999993383000038339993333339993383000038333999333333993383
          0000383339993333339933830000383333999333333933830000383333399933
          3333338300003833333999333333338300003833333399933333338300003833
          3333999333333383000038333333399933333383000038339333339993333383
          0000383399333399933333830000383399933339993333830000383399999999
          9993338300003833333333333333338300003888888888888888888300003333
          33333333333333330000}
        TabOrder = 3
        OnClick = OrigineZeroBtnClick
      end
      object EchelleRG: TComboBox
        Left = 140
        Top = 36
        Width = 146
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 4
        Text = 'Pixel'
        OnChange = EchelleRGClick
        Items.Strings = (
          'Echelle'
          'Pixel'
          'Index')
      end
    end
    object LargeurGB: TGroupBox
      Left = 1
      Top = 501
      Width = 298
      Height = 96
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Largeur du trac'#233
      TabOrder = 2
      object LargeurSE: TSpinEdit
        Left = 16
        Top = 36
        Width = 100
        Height = 47
        Hint = '|Largeur du trac'#233' de l'#39#233'chelle sur l'#39'image (en pixel original)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        MaxValue = 5
        MinValue = 1
        TabOrder = 0
        Value = 1
        OnChange = LargeurSEChange
      end
    end
    object CouleursGB: TGroupBox
      Left = 1
      Top = 597
      Width = 298
      Height = 96
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Couleurs exploit'#233'es'
      Enabled = False
      TabOrder = 3
      object BlueBtn: TBitBtn
        Left = 144
        Top = 36
        Width = 48
        Height = 48
        Hint = 'Bleu'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -42
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Layout = blGlyphBottom
        ParentFont = False
        Spacing = 0
        TabOrder = 2
        OnClick = BlueBtnClick
      end
      object RedBtn: TBitBtn
        Left = 16
        Top = 36
        Width = 48
        Height = 48
        Hint = 'Rouge'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'R'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -42
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Layout = blGlyphBottom
        ParentFont = False
        Spacing = 0
        TabOrder = 0
        OnClick = RedBtnClick
      end
      object GreenBtn: TBitBtn
        Left = 80
        Top = 36
        Width = 48
        Height = 48
        Hint = 'Vert'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'V'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -42
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Layout = blGlyphBottom
        ParentFont = False
        Spacing = 0
        TabOrder = 1
        OnClick = GreenBtnClick
      end
      object LumBtn: TBitBtn
        Left = 208
        Top = 36
        Width = 48
        Height = 48
        Hint = 'Luminosit'#233
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'L'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -42
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Layout = blGlyphBottom
        ParentFont = False
        Spacing = 0
        TabOrder = 3
        OnClick = LumBtnClick
      end
    end
    object gammaGB: TGroupBox
      Left = 1
      Top = 693
      Width = 298
      Height = 96
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Gamma'
      Enabled = False
      TabOrder = 4
      object GammaBtn: TSpinButton
        Left = 174
        Top = 36
        Width = 40
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        DownGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000008080000080
          8000008080000080800000808000000000000000000000000000000000000000
          0000008080000080800000808000000000000000000000000000000000000000
          0000000000000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        TabOrder = 0
        UpGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000000000000000000000000000000000000000000000000000000000000080
          8000008080000080800000000000000000000000000000000000000000000080
          8000008080000080800000808000008080000000000000000000000000000080
          8000008080000080800000808000008080000080800000808000000000000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        OnDownClick = GammaBtnDownClick
        OnUpClick = GammaBtnUpClick
      end
      object GammaEdit: TEdit
        Left = 16
        Top = 36
        Width = 148
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
        OnExit = EchelleEditExit
        OnKeyDown = EchelleEditKeyDown
        OnKeyPress = EchelleEditKeyPress
      end
    end
    object MesureRG: TRadioGroup
      Left = 1
      Top = 789
      Width = 298
      Height = 180
      Hint = 'Type de mesure'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Mesure'
      ItemIndex = 0
      Items.Strings = (
        'Intensit'#233
        'Angle'
        'Distance')
      TabOrder = 5
      OnClick = MesureRGClick
    end
    object couleurGB: TGroupBox
      Left = 1
      Top = 1542
      Width = 298
      Height = 90
      Hint = 'Couleur de trac'#233' des angles'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Couleur de trac'#233
      TabOrder = 7
      ExplicitTop = 1555
      object CouleurCB: TColorBox
        Left = 8
        Top = 34
        Width = 250
        Height = 22
        Hint = 'Couleur de la courbe courante'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbPrettyNames]
        DropDownCount = 16
        ItemHeight = 32
        TabOrder = 0
        OnChange = CouleurCBChange
      end
    end
    object ValeurMesureGB: TGroupBox
      Left = 1
      Top = 969
      Width = 298
      Height = 152
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Valeur'
      TabOrder = 6
      object AngleLabelbis: TLabel
        Left = 40
        Top = 48
        Width = 60
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Label'
      end
    end
  end
  object Panel2: TPanel
    Left = 300
    Top = 65
    Width = 1724
    Height = 1633
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    ShowCaption = False
    TabOrder = 3
    ExplicitWidth = 1906
    ExplicitHeight = 1646
    object IntensitePB: TPaintBox
      Left = 1
      Top = 1144
      Width = 1918
      Height = 502
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      OnMouseDown = IntensitePBMouseDown
      OnMouseEnter = IntensitePBMouseEnter
      OnMouseMove = IntensitePBMouseMove
      OnPaint = IntensitePBPaint
      ExplicitLeft = 2
      ExplicitTop = 1174
      ExplicitWidth = 1804
    end
    object LabelDeltaX: TLabel
      Tag = 1
      Left = 394
      Top = 944
      Width = 168
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'LabelDeltaX'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object LabelX: TLabel
      Tag = 1
      Left = 126
      Top = 944
      Width = 94
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'LabelX'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object PanelImage: TPanel
      Left = 1
      Top = 1
      Width = 1918
      Height = 1143
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 1904
      ExplicitHeight = 1142
      object Image: TImage
        Left = 0
        Top = 0
        Width = 1000
        Height = 600
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Proportional = True
        Stretch = True
        OnMouseDown = ImageMouseDown
        OnMouseMove = ImageMouseMove
        OnMouseUp = ImageMouseUp
      end
      object labelO: TLabel
        Tag = 1
        Left = 522
        Top = 26
        Width = 29
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'O'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        Visible = False
      end
      object labelA: TLabel
        Tag = 1
        Left = 314
        Top = 26
        Width = 25
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'A'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        Visible = False
      end
      object AngleLabel: TLabel
        Tag = 1
        Left = 730
        Top = 26
        Width = 98
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Angle'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        Visible = False
      end
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 'png|*.png|bitmap|*.bmp|Jpeg|*.jpg'
    Left = 443
    Top = 245
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 
      'Tous |*.gif;*.png;*.jpg;*.jpeg;*.bmp|Image GIF|*.gif|Portable Ne' +
      'twork Graphics|*.png|Fichier image JPEG|*.jpg;*.jpeg|Bitmaps|*.b' +
      'mp'
    Left = 707
    Top = 245
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D24944415478DAB5D3D1120221080550FC72F1CB0975EF84C0AE36B3
              D183457662802D42426F46F90BD8A80DB5522DFDEC9F99385CCE7208FC3680A5
              A72CC24C8BC333E7F3297854D509E8AB42E877057FF608EA59D9814CBC54D331
              BCF7A8BF1B400CC1BFEED000EE7A68CF0C3D06B3C8D09F2BF4EBE251F47C5FE1
              3541111D946EA447DD027D2792AD4DA808A8616A4236E27C6DC2301210681BE7
              58AEB9A71908605C93D981137054C94DD63DD4047A67E318D42AE350AE8120EE
              AAB46017F0786EF7107DF4A8059B79AA16F0CD781DFC00D779E7ED6DBCE67900
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004B4944415478DA63FCCFF09F819A809166063232906FF27FB076AC06
              3292651C5E030F1C3840B4510E0E0E03682044310480C4D0F9A3068E1AC83094
              1236E900AF81E401AC06520B0C7E03013A8A9DEDAD42D94A0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BA4944415478DAAD938B0E80200845E1CBA32F27A587A820B179B796
              0A1C11141918760A2B10EBCF51B123B8F66A738045F68E88296808ECA143A801
              6D4059E701D496666804AC918AF00E7DE81FE04392301EB2947508EE04A35943
              818095EDAA4177963E90DB006FD73E5CD7BA7C4404071D7386BA66AD0473C39E
              03BEED143F1E8F3CC1D4B5010E5ED40804D508178886911D6074B13BE00751F3
              39C340196024D93073E434707B86DB804BA704F0A493EB4B58A97B293B7501C0
              FCC9ED7281317A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000514944415478DAEDD2310E0020080340FAFF47A3AE22588C4ED21572
              240054546E0605DAB289E210843F497B09820488FD1E1C740112588016F80424
              51FECA049AFFC3000D30021CC0D410601C98CC8760033BC349ED26378E800000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A44944415478DAB592010E80200845F566DE2CBA99373369FBCD404D
              07B119C3C5E383C4124AF0B4F82B30D6B0C6D105C8B09C734829050BF40602C6
              E6028442F65695EA51ACAD2B8530405B930590D3DEAB19628E2DB8BD47F2A893
              074844C33650A057680A942DCAD6D9235E024A959C2481F80F02CC0A6128CEDE
              34C3AD4739EAB917A17E88CE9792EDB5E9299CA91E2DFD70B1BF8072760AD8AD
              D629B2ACD0CBDC81175F45B9ED773A50660000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000944944415478DAC5954B0EC0200844E1FE87A6DAA40D1D07D0B4A6AC
              40CC73C09F8A884962065955494D19D0431090E506A0B9C119EB7084A6400B9A
              E12108BD819860AB47391F9FC00A7629ADE6F47800A2EF412C46FF018CC051C9
              14D81CCB56AC7A38F80CB8D2C37F80AF4AFE7C53B61E1B5652D5438CF75CBD4A
              19DAD4E330A3AC524A81A86CF9816DC7B05135FC0656BF8003A26CBBF92BB8D4
              B80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007B4944415478DADDD2810AC020080450FDF3FBF356419072E6A06031
              2118D55E979B162972B27480DA1E37AB5A6A402C36F7B5B23853F5B7607D5118
              7E07388A5DFD53B0CD03E8631BC44837832CE9553D0CBCF7579EA1C55F938308
              1086A6201CC012F9E41484D8D3196652CDFB3C18F526FA10690F65B30C78AA1E
              E7B5A6ED81EC4E460000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000009E4944415478DADDD45D0E802008006038991E4D6EA6272369E90CC5
              7C68EB87A774F00D8D4206863B03FF08E61260BC01D4D0187EAAC38260935CD6
              67BC8214884308CB7DB2D16505313FE6B07B448418635D7BEF87A80D66009AB5
              062D740C629373ECA59476E0EAF8CB1D0AE89CEB302202B9FB8276A0144AE862
              0DB679721D4370F9154F8E7D9A438D9AA331C9EB06BB24F3E46B98E5BDE16FF3
              757003A0D586ED71840D730000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A44944415478DAD5944B0E80200C44DB93C9CD909BE1C9B055DAF841
              A4B11B67D34487C73810B140014F210391060910911E8D6E80206B744241057A
              A453E0921717E014A63B30846082E49C9F810C63034FEEA5DB2075265E813681
              DAC756746A7755623DC073CA369093D5937B4B28DE61E031E19E2A9D135A81EE
              09FD80893E6D9EFBF785DFC73808B46818D84B29E94CC083F1AA27DF0F816A36
              A8FB73F82A057A6A0505BEF5ED9725CC860000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000984944415478DACDD4DB0D80200C0550EE666C066CC66695628880BC
              E18326C6C6EAA1020A12244E0618049F2AE1EA10D53AD72AA08BF288C0149A80
              C6187F512995E41F9A3D5A4087C0B4D30360C8B5D6117A0C6C0561B1C3D202BD
              5DDEF0CAF9C22C6C9B1814CD59C402480D10E87F29E9FD1807BBDA6060E66F33
              32F01D6069BEFDFCAE82D6DA5F4D4AB9073210C35B20EFC7708408F903D59FDF
              F78CBF11C20000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AC4944415478DACD94510E84200C44A727D39B596FA62763A95A0461
              BB54FDD8494843028F6152A0808037450224291B9880EE0374ED59238B12300A
              443EA0EE493507028C73F488AB513A8C9347D91D8C0A38F31C984B97329F78A2
              5BC03D4F14816B3E6E600B9643552DB801AC612DF815EA76985731EB00B6AF69
              29EDB51CEE0D0BACEB826118BF56756B3AF4C2CC2B6FFE9CB09F7DD89B5B5763
              DFD5FF03E50F90F79E7D5FCF951CBEA90F95A106FC07A264DA0000000049454E
              44AE426082}
          end>
      end>
    Left = 437
    Top = 721
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
      end>
    ImageCollection = ImageCollection1
    Width = 20
    Height = 20
    Left = 789
    Top = 793
  end
end
