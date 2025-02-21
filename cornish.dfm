object Fcornish: TFcornish
  Left = 288
  Top = 308
  HelpContext = 11
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  ClientHeight = 620
  ClientWidth = 1250
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000077777777777777777777777777777700877
    7777777777777777777777777770088888888888888888888888888887700888
    888888888888888888888888877008888FF88FF88FF88FF88FF88FF887700888
    80F880F880F880F880F880F88770088888844C44C44C44C44C44C88887700888
    88844C44C44C44C44C44C888877008888FF44C44C44C44C44C44C88887700888
    80F44C44C44C44C44C8888888770088888844C44C44C44C44C88888887700888
    88844C44C44C44C888888888877008888FF44C44C44C44C88888888887700888
    80F44C44C44C44C8888888888770088888888844C44C44C88888888887700888
    88888844C44C888888888888877008888FF88844C44C88888888888887700888
    80F88888844C8888888888888770088888888888844C88888888888887700888
    88888888844C888888888888877008888FF88888844C88888888888887700888
    80F88888844C8888888888888770088888888888888888888888888887700888
    888888888888888888888888877008888FF88888888888888888888887700888
    80F8888888888888888888888770088888888888888888888888888887700888
    8888888888888888888888888770088888888888888888888888888887700888
    8888888888888888888888888870000000000000000000000000000000008000
    0001000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000080000001}
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 192
  TextHeight = 36
  object PaintBox: TPaintBox
    Left = 420
    Top = 80
    Width = 830
    Height = 540
    Hint = '|Utiliser le clic droit pour ouvrir le menu local'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    Color = clWhite
    ParentColor = False
    OnClick = PaintBoxClick
    OnDblClick = PaintBoxDblClick
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnMouseUp = PaintBoxMouseUp
    OnPaint = PaintBoxPaint
    ExplicitWidth = 858
    ExplicitHeight = 542
  end
  object PanelValeurs: TPanel
    Left = 0
    Top = 80
    Width = 420
    Height = 540
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 539
    object StatGrid: TStringGrid
      Left = 0
      Top = 0
      Width = 420
      Height = 258
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      ColCount = 3
      DefaultColWidth = 130
      DefaultRowHeight = 40
      RowCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      ColWidths = (
        130
        130
        130)
      RowHeights = (
        40
        40
        40
        40
        40
        42
        40
        40
        40
        40
        40
        40)
    end
    object DistGrid: TStringGrid
      Left = 0
      Top = 258
      Width = 420
      Height = 282
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ColCount = 3
      DefaultColWidth = 120
      DefaultRowHeight = 40
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      ExplicitHeight = 281
      ColWidths = (
        120
        120
        120)
      RowHeights = (
        40
        40
        40
        40
        40)
    end
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 0
    Width = 1250
    Height = 80
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Alignment = taLeftJustify
    TabOrder = 1
    ExplicitWidth = 1236
    object OptionsBtn: TSpeedButton
      Left = 178
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Options'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 14
      ImageName = 'tools'
      Images = FRegressiMain.VirtualImageList1
      OnClick = OptionsItemClick
    end
    object ImprimeBtn: TSpeedButton
      Left = 262
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Imprimer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageName = 'Item12'
      Images = FRegressiMain.VirtualImageList1
      OnClick = ImprimeBtnClick
    end
    object CopierGrapheBtn: TSpeedButton
      Left = 344
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Copier graphe|Copier le graphe dans le presse-papiers'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 46
      ImageName = 'clipgr'
      Images = FRegressiMain.VirtualImageList1
      OnClick = GrapheCopierClick
    end
    object AideModeleBtn: TSpeedButton
      Left = 426
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Aide'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 10
      ImageName = 'Item11'
      Images = FRegressiMain.VirtualImageList1
      OnClick = AideModeleBtnClick
    end
    object ClipGridBtn: TSpeedButton
      Left = 510
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Copier tableau|Copier le tableau dans le presse-papiers'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 3
      ImageName = 'Item4'
      Images = FRegressiMain.VirtualImageList1
      OnClick = CopierTableauItemClick
    end
    object TexteBtn: TSpeedButton
      Left = 96
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Texte|Placer un texte sur le graphe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 45
      ImageName = 'a0'
      Images = FRegressiMain.VirtualImageList1
      OnClick = TexteBtnClick
    end
    object GommeBtn: TSpeedButton
      Left = 14
      Top = 2
      Width = 68
      Height = 68
      Hint = 'Effacer|Supprimer un point'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 2
      ImageName = 'Item3'
      Images = FRegressiMain.VirtualImageList1
      OnClick = GommeBtnClick
    end
    object EditBidon: TEdit
      Left = 560
      Top = 0
      Width = 2
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
      Text = '  '
      OnKeyDown = EditBidonKeyDown
      OnKeyPress = EditBidonKeyPress
    end
    object CornishRG: TRadioGroup
      Left = 735
      Top = 1
      Width = 514
      Height = 78
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Graphe'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'KM'
        'Vlim'
        'KM et Vlim')
      TabOrder = 1
      OnClick = CornishRGClick
      ExplicitLeft = 721
    end
  end
end
