object FGrapheFFT: TFGrapheFFT
  Left = 114
  Top = 187
  Cursor = crCross
  HelpContext = 23
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Fourier'
  ClientHeight = 1976
  ClientWidth = 2480
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
    FF88FF88FF8888880F880F880F88FF488488488488480F488488488488488848
    8488488488888848848888848888FF888488888888880F888488888888888888
    8488888888888888848888888888FF888488888888880F888488888888888888
    8488888888888888888888888888FF888888888888880F888888888888880000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  Position = poDefault
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnPaint = FormPaint
  OnResize = FormResize
  OnShortCut = FormShortCut
  PixelsPerInch = 192
  TextHeight = 36
  object SplitterGrid: TSplitter
    Left = 2010
    Top = 129
    Width = 6
    Height = 1741
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    Beveled = True
    Color = clHotLight
    MinSize = 1
    ParentColor = False
    OnCanResize = SplitterGridCanResize
    ExplicitTop = 150
    ExplicitHeight = 1720
  end
  object PanelCourbe: TPanel
    Left = 0
    Top = 129
    Width = 2010
    Height = 1741
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object PaintBoxTemps: TPaintBox
      Left = 0
      Top = 0
      Width = 2010
      Height = 100
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      ParentColor = False
      PopupMenu = PopupMenuTemps
      OnMouseDown = TempsMouseDown
      OnMouseMove = TempsMouseMove
      OnMouseUp = TempsMouseUp
      OnPaint = TempsPaint
    end
    object PaintBoxFrequence: TPaintBox
      Left = 0
      Top = 106
      Width = 2010
      Height = 1635
      Hint = '|Utiliser le clic droit pour ouvrir le menu local'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ParentColor = False
      PopupMenu = PopupMenuFFT
      OnDblClick = PaintBoxFrequenceDblClick
      OnMouseDown = FrequenceMouseDown
      OnMouseMove = FrequenceMouseMove
      OnMouseUp = FrequenceMouseUp
      OnPaint = FrequencePaint
      ExplicitHeight = 1614
    end
    object SplitterTemps: TSplitter
      Left = 0
      Top = 100
      Width = 2010
      Height = 6
      Cursor = crVSplit
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clHotLight
      ParentColor = False
    end
    object LabelX: TLabel
      Tag = 1
      Left = 66
      Top = 238
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
    object LabelY: TLabel
      Tag = 1
      Left = 496
      Top = 208
      Width = 93
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'LabelY'
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
    object CurseurGrid: TStringGrid
      Left = 1680
      Top = 112
      Width = 332
      Height = 240
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ColCount = 2
      DefaultColWidth = 140
      DefaultRowHeight = 48
      DragKind = dkDock
      DragMode = dmAutomatic
      Enabled = False
      FixedCols = 0
      FixedRows = 0
      ScrollBars = ssNone
      TabOrder = 0
      Visible = False
      ColWidths = (
        140
        140)
      RowHeights = (
        48
        48
        48
        48
        48)
    end
    object MediaPlayer: TMediaPlayer
      Left = 1032
      Top = 416
      Width = 505
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      DeviceType = dtWaveAudio
      DoubleBuffered = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 1
      OnNotify = MediaPlayerNotify
    end
  end
  object FFTToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 2480
    Height = 87
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 83
    ButtonWidth = 131
    Color = clGradientInactiveCaption
    DrawingStyle = dsGradient
    EdgeBorders = [ebTop, ebBottom]
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    GradientDrawingOptions = [gdoHotTrack]
    ParentColor = False
    ShowCaptions = True
    TabOrder = 1
    Transparent = False
    Wrapable = False
    object SelectBtn: TToolButton
      Left = 0
      Top = 0
      Hint = '|Choix des curseurs, ajout de texte ...'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Curseur'
      DropdownMenu = SourisMenu
      ImageIndex = 26
      ImageName = 'Item27'
      PopupMenu = SourisMenu
      OnClick = SelectBtnClick
    end
    object OptionsBtn: TToolButton
      Left = 131
      Top = 0
      HelpType = htKeyword
      HelpKeyword = 'Coordonn'#233'es et options (Alt+C) '
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Options'
      ImageIndex = 1
      ImageName = 'Item2'
      OnClick = OptionsFourierItemClick
    end
    object limitesBtn: TToolButton
      Left = 262
      Top = 0
      Hint = '|Zone de calcul de la FFT'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Limite'
      DropdownMenu = DureeMenu
      ImageIndex = 6
      ImageName = 'Item7'
      PopupMenu = DureeMenu
      Style = tbsDropDown
      OnClick = SelectBtnClick
    end
    object FenetrageBtn: TToolButton
      Left = 424
      Top = 0
      Hint = '|Choix de la fen'#233'tre'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Fen'#234'tre'
      DropdownMenu = FenetrageMenu
      ImageIndex = 8
      ImageName = 'Item9'
      OnClick = SelectBtnClick
    end
    object SonagrammeBtn: TToolButton
      Left = 555
      Top = 0
      Hint = 
        'Sonagramme : repr'#233'sentation fr'#233'quence-intensit'#233' en fonction du t' +
        'emps'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sonag.'
      ImageIndex = 32
      ImageName = 'Item33'
      Style = tbsCheck
      OnClick = SonagrammeBtnClick
    end
    object ZoomBtn: TToolButton
      Left = 686
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Loupe'
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = ZoomAvantItemClick
    end
    object ZoomAutoBtn: TToolButton
      Left = 817
      Top = 0
      Hint = '|Echelle automatique'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Auto'
      ImageIndex = 19
      ImageName = 'Item20'
      OnClick = zoomAutoItemClick
    end
    object TableauBtn: TToolButton
      Left = 948
      Top = 0
      Hint = '|Affiche un tableau des harmoniques'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Tableau'
      ImageIndex = 3
      ImageName = 'Item4'
      Style = tbsCheck
      OnClick = TableauItemClick
    end
    object TempsBtn: TToolButton
      Left = 1079
      Top = 0
      Hint = '|Graphe temporel'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Temps'
      ImageIndex = 4
      ImageName = 'Item5'
      Style = tbsCheck
      OnClick = TempsItemClick
    end
    object PlayBtn: TToolButton
      Left = 1210
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Jouer'
      ImageIndex = 22
      ImageName = 'Item23'
      Visible = False
      OnClick = PlayBtnClick
    end
    object AnimationBtn: TToolButton
      Left = 1341
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Animation'
      ImageIndex = 28
      ImageName = 'Item29'
      Style = tbsCheck
      OnClick = AnimationBtnClick
    end
    object ImprimeBtn: TToolButton
      Left = 1472
      Top = 0
      Hint = 'Imprime (Alt+I)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Impr.'
      ImageIndex = 11
      ImageName = 'Item12'
      OnClick = ImprimeBtnClick
    end
    object NbreHarmAffSpin: TSpinButton
      Left = 1603
      Top = 0
      Width = 40
      Height = 83
      Hint = 'R'#233'glage du nombre de pics affich'#233's'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      DownGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200420042
        0042000000420042004200420000004200420042000000000000004200420042
        0000004200420000000000000000000000420042000000420000000000000000
        000000000000004200000042004200420042004200420042004200420000}
      TabOrder = 3
      UpGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200000000
        0000000000000000000000420000004200420000000000000000000000420042
        0000004200420042000000000000004200420042000000420042004200420000
        004200420042004200000042004200420042004200420042004200420000}
      OnDownClick = NbreHarmAffSpinDownClick
      OnUpClick = NbreHarmAffSpinUpClick
    end
    object SeparePeriodeBtn: TToolButton
      Left = 1643
      Top = 0
      Width = 16
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Style = tbsSeparator
    end
    object DebutFFTspin: TSpinButton
      Left = 1659
      Top = 0
      Width = 40
      Height = 83
      Hint = 'd'#233'but FFT|d'#233'but de la fen'#234'tre de calcul de la FFT'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      DownGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200420042
        0042000000420042004200420000004200420042000000000000004200420042
        0000004200420000000000000000000000420042000000420000000000000000
        000000000000004200000042004200420042004200420042004200420000}
      TabOrder = 2
      UpGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200000000
        0000000000000000000000420000004200420000000000000000000000420042
        0000004200420042000000000000004200420042000000420042004200420000
        004200420042004200000042004200420042004200420042004200420000}
      OnDownClick = DebutFFTspinDownClick
      OnUpClick = DebutFFTspinUpClick
    end
    object PeriodeFFTEdit: TEdit
      Left = 1699
      Top = 0
      Width = 200
      Height = 83
      Hint = 'P'#233'riode FFT|p'#233'riode de calcul de la FFT'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -38
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '01234567'
      OnExit = DebutFFTEditExit
      OnKeyPress = DebutFFTEditKeyPress
    end
    object FinFFTspin: TSpinButton
      Left = 1899
      Top = 0
      Width = 40
      Height = 83
      Hint = 'fin FFT|fin de la fen'#234'tre de calcul de la FFT'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      DownGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200420042
        0042000000420042004200420000004200420042000000000000004200420042
        0000004200420000000000000000000000420042000000420000000000000000
        000000000000004200000042004200420042004200420042004200420000}
      TabOrder = 1
      UpGlyph.Data = {
        BA000000424DBA00000000000000420000002800000009000000060000000100
        1000030000007800000000000000000000000000000000000000007C0000E003
        00001F0000000042004200420042004200420042004200420000004200000000
        0000000000000000000000420000004200420000000000000000000000420042
        0000004200420042000000000000004200420042000000420042004200420000
        004200420042004200000042004200420042004200420042004200420000}
      OnDownClick = FinFFTspinDownClick
      OnUpClick = FinFFTspinUpClick
    end
  end
  object ValeursGrid: TStringGrid
    Left = 2016
    Top = 129
    Width = 200
    Height = 1741
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    ColCount = 3
    DefaultColWidth = 80
    DefaultRowHeight = 48
    FixedCols = 0
    FixedRows = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    PopupMenu = PopupMenuGrid
    TabOrder = 0
    OnDblClick = ValeursGridDblClick
    OnMouseDown = ValeursGridMouseDown
    ColWidths = (
      80
      80
      80)
    RowHeights = (
      48
      48
      48
      48
      48)
  end
  object ValeurCouranteH: TStatusBar
    Left = 0
    Top = 1938
    Width = 2480
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
    ParentFont = True
    UseSystemFont = False
  end
  object ToolBarGrandeurs: TToolBar
    Left = 0
    Top = 87
    Width = 2480
    Height = 42
    Hint = 'Glisser d'#233'placer pour d'#233'finir les coordonn'#233'es'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 42
    ButtonWidth = 165
    Color = clMoneyGreen
    GradientEndColor = clMoneyGreen
    HotTrackColor = clLime
    List = True
    GradientDrawingOptions = [gdoHotTrack]
    ParentColor = False
    ShowCaptions = True
    TabOrder = 4
    Wrapable = False
    object ToolButton6: TToolButton
      Tag = 7
      Left = 0
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton1'
      ImageIndex = 0
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton8: TToolButton
      Tag = 1
      Left = 155
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton9: TToolButton
      Tag = 2
      Left = 310
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton10: TToolButton
      Tag = 3
      Left = 465
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton5'
      ImageIndex = 3
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton11: TToolButton
      Tag = 4
      Left = 620
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton6'
      ImageIndex = 4
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton12: TToolButton
      Tag = 5
      Left = 775
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton7'
      ImageIndex = 5
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton13: TToolButton
      Tag = 6
      Left = 930
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton14: TToolButton
      Tag = 7
      Left = 1085
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton10'
      ImageIndex = 7
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton15: TToolButton
      Tag = 8
      Left = 1254
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton15'
      ImageIndex = 8
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton16: TToolButton
      Tag = 9
      Left = 1423
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton16'
      ImageIndex = 9
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton17: TToolButton
      Left = 1592
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton17'
      ImageIndex = 10
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
    object ToolButton18: TToolButton
      Left = 1761
      Top = 0
      Hint = 'Cliquer pour afficher le spectre de la grandeur'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'ToolButton18'
      ImageIndex = 11
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
  end
  object OptionsSonagramme: TPanel
    Left = 0
    Top = 1870
    Width = 2480
    Height = 68
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    BevelInner = bvLowered
    BevelKind = bkSoft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Visible = False
    object DecadeLabel: TLabel
      Left = 248
      Top = 8
      Width = 94
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'd'#233'cades'
      Visible = False
    end
    object Label2: TLabel
      Left = 1020
      Top = 8
      Width = 15
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DecadeSE: TSpinEdit
      Left = 140
      Top = 4
      Width = 98
      Height = 47
      Hint = 
        'Niveau de gris|Nombre de d'#233'cades de repr'#233'sentation des niveaux d' +
        'e gris'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 4
      MinValue = 1
      TabOrder = 0
      Value = 2
      Visible = False
      OnChange = DecadeSEChange
    end
    object DecibelCB: TCheckBox
      Left = 16
      Top = 16
      Width = 100
      Height = 34
      Hint = 'd'#233'cibel'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'en dB'
      TabOrder = 1
      OnClick = DecibelCBClick
    end
    object PasSonAffEdit: TLabeledEdit
      Left = 760
      Top = 8
      Width = 242
      Height = 44
      Hint = 'dur'#233'e de l'#39'intervalle sur laquelle est trac'#233' le spectre'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 350
      EditLabel.Height = 36
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Pas de calcul (s) = pas de trac'#233
      LabelPosition = lpLeft
      TabOrder = 2
      Text = ''
      OnExit = PasSonAffEditExit
      OnKeyPress = DebutFFTEditKeyPress
    end
    object FreqmaxEdit: TLabeledEdit
      Left = 1420
      Top = 8
      Width = 230
      Height = 44
      Hint = 'Fr'#233'quence maxi de trac'#233' (aussi modifiable '#224' la souris)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 234
      EditLabel.Height = 36
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Fr'#233'quence maxi (Hz)'
      LabelPosition = lpLeft
      TabOrder = 3
      Text = ''
      OnExit = FreqmaxEditExit
      OnKeyPress = DebutFFTEditKeyPress
    end
    object FaussesCouleursCB: TCheckBox
      Left = 1720
      Top = 12
      Width = 264
      Height = 34
      Hint = 'Fausses couleurs'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Fausses couleurs'
      TabOrder = 4
      OnClick = FaussesCouleursCBClick
    end
    object PasSonCalculSE: TSpinEdit
      Left = 1060
      Top = 4
      Width = 82
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
      MaxValue = 10
      MinValue = 1
      ParentFont = False
      TabOrder = 5
      Value = 1
      OnChange = pasSonCalculEditExit
    end
    object FreqMaxSonUD: TUpDown
      Left = 1644
      Top = 2
      Width = 34
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Min = 110
      Max = 11000
      Increment = 100
      Position = 1000
      TabOrder = 6
      OnChangingEx = FreqMaxSonUDChangingEx
    end
  end
  object PanelAnimation: TPanel
    Left = 2216
    Top = 129
    Width = 264
    Height = 1741
    HelpType = htKeyword
    HelpKeyword = 'Animation'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 6
    Visible = False
    object GroupBox6: TGroupBox
      Left = 1
      Top = 1047
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 7
      object TrackBar6: TTrackBar
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        PageSize = 8
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox4: TGroupBox
      Tag = 2
      Left = 1
      Top = 855
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 5
      object TrackBar4: TTrackBar
        Tag = 4
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox5: TGroupBox
      Tag = 4
      Left = 1
      Top = 663
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      object TrackBar2: TTrackBar
        Tag = 3
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox2: TGroupBox
      Tag = 5
      Left = 1
      Top = 567
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 2
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      object TrackBar1: TTrackBar
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox1: TGroupBox
      Tag = 3
      Left = 1
      Top = 759
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 4
      object TrackBar3: TTrackBar
        Tag = 1
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox3: TGroupBox
      Tag = 1
      Left = 1
      Top = 951
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      object TrackBar5: TTrackBar
        Tag = 2
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox8: TGroupBox
      Tag = 7
      Left = 1
      Top = 471
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      object TrackBar8: TTrackBar
        Tag = 7
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox9: TGroupBox
      Tag = 8
      Left = 1
      Top = 375
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      object TrackBar9: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox7: TGroupBox
      Tag = 8
      Left = 1
      Top = 279
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      TabOrder = 8
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      object TrackBar7: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox10: TGroupBox
      Tag = -1
      Left = 1
      Top = 1
      Width = 262
      Height = 278
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      TabOrder = 9
      object AvanceBtn: TSpeedButton
        Left = 154
        Top = 90
        Width = 36
        Height = 42
        Hint = 'Graphe suivant'
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
        OnClick = AvanceBtnClick
      end
      object AvanceRapideBtn: TSpeedButton
        Left = 190
        Top = 90
        Width = 36
        Height = 42
        Hint = 'Animation en croissant|Animation avec croissance du param'#232'tre'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          EE000000424DEE0000000000000076000000280000000D0000000F0000000100
          0400000000007800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          300033C30C333333300033CC30C33333300033C0C30C3333300033C00C30C333
          300033C000C30C33300033C0000C30C3300033C00000C30C300033C0000C30C3
          300033C000C30C33300033C00C30C333300033C0C30C3333300033CC30C33333
          300033C30C33333330003333333333333000}
        OnClick = AvanceRapideBtnClick
      end
      object DebutBtn: TSpeedButton
        Left = 4
        Top = 90
        Width = 36
        Height = 42
        Hint = 'Premier graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          EE000000424DEE0000000000000076000000280000000D0000000F0000000100
          0400000000007800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          300033C0333333C3300033C033333CC3300033C03333C0C3300033C0333C00C3
          300033C033C000C3300033C03C0000C3300033C0C00000C3300033C03C0000C3
          300033C033C000C3300033C0333C00C3300033C03333C0C3300033C033333CC3
          300033C0333333C330003333333333333000}
        OnClick = DebutBtnClick
      end
      object FinBtn: TSpeedButton
        Left = 226
        Top = 90
        Width = 36
        Height = 42
        Hint = 'Dernier graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          EE000000424DEE0000000000000076000000280000000D0000000F0000000100
          0400000000007800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          300033C3333330C3300033CC333330C3300033C0C33330C3300033C00C3330C3
          300033C000C330C3300033C0000C30C3300033C00000C0C3300033C0000C30C3
          300033C000C330C3300033C00C3330C3300033C0C33330C3300033CC333330C3
          300033C3333330C330003333333333333000}
        OnClick = FinBtnClick
      end
      object HelpAnimBtn: TSpeedButton
        Left = 78
        Top = 140
        Width = 46
        Height = 46
        Hint = 'Aide'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333BBBBB3333333300003333
          3BBB191BBB33333300003333BBBB999BBBB333330000333BBBBB191BBBBB3333
          000033BBBBBBBBBBBBBBB333000033BBBBBBB9BBBBBBB33300003BBBBBBBB91B
          BBBBBB3300003BBBBBBBB99BBBBBBB3300003BBBBBBBBB99BBBBBB3300003BBB
          BB11BB199BBBBB3300003BBBBB99BB199BBBBB33000033BBBB991B199BBBB333
          000033BBBBB99999BBBBB3330000333BBBBB999BBBBB333300003333BBBBBBBB
          BBB33333000033333BBBBBBBBB33333300003333333BBBBB3333333300003333
          33333333333333330000}
        OnClick = HelpAnimBtnClick
      end
      object OptionsAnimBtn: TSpeedButton
        Left = 16
        Top = 140
        Width = 46
        Height = 46
        Hint = 'Options|Param'#233'trage des param'#232'tres !'
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
        OnClick = OptionsAnimBtnClick
      end
      object RetourBtn: TSpeedButton
        Left = 76
        Top = 90
        Width = 36
        Height = 42
        Hint = 'Graphe pr'#233'c'#233'dent'
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
        OnClick = RetourBtnClick
      end
      object RetourRapideBtn: TSpeedButton
        Left = 40
        Top = 90
        Width = 36
        Height = 42
        Hint = 
          'Animation en d'#233'croissant|Animation avec d'#233'croissance du param'#232'tr' +
          'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          EE000000424DEE0000000000000076000000280000000D0000000F0000000100
          0400000000007800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          30003333333C03C33000333333C03CC3300033333C03C0C330003333C03C00C3
          3000333C03C000C3300033C03C0000C330003C03C00000C3300033C03C0000C3
          3000333C03C000C330003333C03C00C3300033333C03C0C33000333333C03CC3
          30003333333C03C330003333333333333000}
        OnClick = RetourRapideBtnClick
      end
      object StopBtn: TSpeedButton
        Left = 112
        Top = 90
        Width = 42
        Height = 42
        Hint = 'Stop|Arr'#234't de l'#39'animation'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333CCCCCCCCCCCCCCC3C0000000000000C3C0777777777770C3C07777777777
          70C3C0770007000770C3C0770007000770C3C0770007000770C3C07700070007
          70C3C0770007000770C3C0770007000770C3C0770007000770C3C07777777777
          70C3C0777777777770C3C0000000000000C3CCCCCCCCCCCCCCC3}
        OnClick = StopBtnClick
      end
      object BoucleCB: TCheckBox
        Left = 16
        Top = 180
        Width = 162
        Height = 44
        Hint = 'Animation en continu'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Bouclage'
        TabOrder = 0
      end
      object NbreTickBar: TTrackBar
        Left = 2
        Top = 38
        Width = 258
        Height = 52
        Hint = 'Vitesse|Vitesse de l'#39'animation'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Max = 18
        Min = 1
        Position = 9
        TabOrder = 1
        ThumbLength = 32
        TickMarks = tmBoth
        TickStyle = tsNone
      end
      object TitreAnimCB: TCheckBox
        Left = 16
        Top = 230
        Width = 242
        Height = 34
        Hint = '|Bandeau de valeurs des param'#232'tres sur le graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Bandeau de valeurs'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = TitreAnimCBClick
      end
    end
  end
  object PopupMenuFFT: TPopupMenu
    Alignment = paCenter
    OnPopup = PopupMenuFFTPopup
    Left = 687
    Top = 851
    object ZoomManuel: TMenuItem
      AutoCheck = True
      Caption = 'Echelle &manuelle'
      OnClick = ZoomManuelBtnClick
    end
    object OptionsFourierItem: TMenuItem
      Caption = 'Options Fourier'
      ImageIndex = 1
      OnClick = OptionsFourierItemClick
    end
    object CouleursItem: TMenuItem
      Caption = 'Options graphiques'
      ImageIndex = 20
      OnClick = CouleursItemClick
    end
    object VariablesItem: TMenuItem
      Caption = '&Coordonn'#233'es'
      ImageIndex = 0
      OnClick = OptionsFourierItemClick
    end
    object EnregistrerGrapheItem: TMenuItem
      Caption = 'Enregistrer graphe'
      OnClick = EnregistrerGrapheItemClick
    end
    object CopierGrapheItem: TMenuItem
      Caption = 'Copier graphe'
      ImageIndex = 14
      ShortCut = 16451
      OnClick = CopierItemClick
    end
    object Imprimer1: TMenuItem
      Caption = '&Imprimer'
      ImageIndex = 11
      OnClick = ImprimeBtnClick
    end
    object SaveFreqItem: TMenuItem
      Caption = 'Enregistrer la fr'#233'quence'
      ShortCut = 121
      OnClick = SaveFreqItemClick
    end
    object harmoniqueAffItem: TMenuItem
      AutoCheck = True
      Caption = 'Affichage des "harmoniques"'
      OnClick = harmoniqueAffItemClick
    end
  end
  object PopupMenuGrid: TPopupMenu
    OnPopup = PopupMenuGridPopup
    Left = 77
    Top = 790
    object CopyGridBtn: TMenuItem
      Caption = 'Copier tableau'
      ImageIndex = 13
      OnClick = copierTableauItemClick
    end
    object CacherGrid: TMenuItem
      Caption = 'Cacher'
      OnClick = CacherGridClick
    end
    object Imprimer2: TMenuItem
      Caption = 'Imprimer'
      ImageIndex = 11
      OnClick = ImprimeBtnClick
    end
    object SauverLigneItem: TMenuItem
      Caption = 'Enregistrer la ligne'
      OnClick = SauverLigneItemClick
    end
  end
  object PopupMenuTemps: TPopupMenu
    Left = 238
    Top = 606
    object EnregistrerItem: TMenuItem
      Caption = 'Enregistrer'
      OnClick = EnregistrerItemClick
    end
    object CopierTempsWMF: TMenuItem
      Caption = 'Copier'
      ImageIndex = 15
      OnClick = CopierTempsWMFClick
    end
    object CacherTemps: TMenuItem
      Caption = 'Fermer'
      OnClick = CacherTempsClick
    end
  end
  object FenetrageMenu: TPopupMenu
    OnPopup = FenetrageMenuPopup
    Left = 518
    Top = 806
    object HammingBtn: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = 'Hamming'
      GroupIndex = 1
      Hint = 'Fen'#234'tre de Hamming : meilleure r'#233'solution en fr'#233'quence'
      ImageIndex = 29
      RadioItem = True
      OnClick = FenetreBtnClick
    end
    object RectBtn: TMenuItem
      AutoCheck = True
      Caption = 'Naturelle'
      Checked = True
      GroupIndex = 1
      Hint = 'Fen'#234'tre naturelle rectangulaire'
      ImageIndex = 8
      RadioItem = True
      OnClick = FenetreBtnClick
    end
    object FlatTopBtn: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = 'Toit plat'
      GroupIndex = 1
      Hint = 'Flat top : meilleure r'#233'solution en amplitude'
      ImageIndex = 10
      RadioItem = True
      OnClick = FenetreBtnClick
    end
    object BlackmanBtn: TMenuItem
      Tag = 3
      Caption = 'Blackman'
      GroupIndex = 1
      ImageIndex = 30
      OnClick = FenetreBtnClick
    end
    object NaturelleCorrBtn: TMenuItem
      Tag = 4
      Caption = 'Naturelle corrig'#233'e'
      GroupIndex = 1
      Hint = 'Corrige les fuites s'#39'il y a un nombre suffisant de p'#233'riodes '
      ImageIndex = 31
      OnClick = FenetreBtnClick
    end
  end
  object MenuDessin: TPopupMenu
    Left = 446
    Top = 600
    object DessinSupprimerItem: TMenuItem
      Caption = '&Supprimer'
      OnClick = DessinSupprimerItemClick
    end
    object ProprietesMenu: TMenuItem
      Caption = '&Propri'#233't'#233's'
      OnClick = ProprietesMenuClick
    end
  end
  object SourisMenu: TPopupMenu
    Left = 174
    Top = 1046
    object StandardItem: TMenuItem
      Caption = 'Standard'
      GroupIndex = 1
      RadioItem = True
      OnClick = StandardItemClick
    end
    object exte1: TMenuItem
      Caption = 'Texte'
      GroupIndex = 1
      RadioItem = True
      OnClick = TexteItemClick
    end
    object LigneItem: TMenuItem
      Caption = 'Ligne'
      GroupIndex = 1
      OnClick = LigneItemClick
    end
    object N1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object ReticuleItem: TMenuItem
      Caption = 'Reticule'
      GroupIndex = 1
      RadioItem = True
      OnClick = ReticuleBtnClick
    end
  end
  object DureeMenu: TPopupMenu
    Left = 384
    Top = 1152
    object Priode1: TMenuItem
      Caption = 'P'#233'riode'
      Hint = '|Ajustement automatique sur une p'#233'riode'
      ImageIndex = 6
      OnClick = PeriodeBtnClick
    end
    object out1: TMenuItem
      Caption = 'Tout'
      Hint = '|FFT sur toutes les donn'#233'es'
      ImageIndex = 7
      OnClick = ToutBtnClick
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'EMF'
    Filter = 
      'Fichier WMF|*.EMF|JPEG|*.jpg|PNG|*.png|Bitmap|*.bmp|PostScript|*' +
      '.eps'
    Left = 328
    Top = 792
  end
  object TimerWav: TTimer
    Interval = 55
    OnTimer = TimerWavTimer
    Left = 1080
    Top = 688
  end
  object TimerAnim: TTimer
    Enabled = False
    OnTimer = TimerAnimTimer
    Left = 1435
    Top = 693
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000624944415478DAD590510A00200843DDFD0F6D4214148A1616E54F64
              F9DC06262610584E5042C106CAD3D09BEF0EB0355885C4608EC235651F02F50C
              23C0365BFF04143A7AA6B917813DACD1B29DE1FF966F011FC9505DA103777BE7
              8019763B30B30AC86192EEC0F82F1E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008B4944415478DAEDD3490E803008055038B75DEAB9D14EE920A58410
              57B269B0F4E5572312107816FEE03720421BA2D41AC10A516760995FC19B84CF
              3610EA9F0B604C9793F1604CCAA564C18CC5454ED8E604708FC9E8008E9B3A70
              3E97C0F635B5D81A9DAE8CA5D160FC99025AA0C53BCD574697FF8F2A582B1C81
              CEEB44EBDA5D7904ADFD0BF42877F0067B8992ED4A69443E0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000924944415478DABDD4C10E8020080660796E3CCA739B1C7068185359
              5C5A669FFFD2809A6A8A2CF805CC982B11F57B444C850A1C81D08618988B1768
              735D740005B3D2486A0FED20BFC0D7116B8F1560CF598076BA37E8A55C80606C
              7D850B302061F8370CDFE5199D4B0EFA36A8D348E9D45ED2ED7F19D409B0D0A3
              E6F0851E779B157AD5BE2CF4BA1F321A96D05C201A7C00390AA2EDB8E2653800
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000464944415478DA63FCCFF09F819A809166063282981400A0398C9806
              56572354B4B63210CD07B287AA81340FC3FF48763032E2E603D943D5C0D1301C
              0DC301F632B500D50D0400F247AFEDDD3F7EDF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000674944415478DA63FCCFF09F819181F13F906664A00260C465209003
              146360C4C52768204C00D9609821C41A86D785A4BA6C081A882D0C69E2428206
              A0A78641692022B880498C50180E0F2FD3C74072C3106628442F52A4D0A1F822
              4F8C760652C3BB7003A909004EE990EE73E256EC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000944944415478DAAD95D10EC0100C45F5BBE751BFBBC3C8AC1B6BAB24
              28C971723D000A143C1B8C40C865AEC105188F4888D82A3BF4659861B983195A
              81C5AE14C5F002166285ABA113430760CFF006B6632574615807D2E6B934DC02
              CE0D75792E5E7904F63CC3AFADD0506E2BC850676B30E4B64FB038C3F5BAF308
              360D79149F19DA1B71C30E4E98C03A4F81FC76E93E787F0127AA35D5ED405768
              780000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000824944415478DAEDD44B0E80200C04D09973C3D29EBBA26004C18A0B
              BBB22B3A8197F00954288E22521322A64A966D25AF31DD411501439804A92678
              6043B4031305A51F5823CF60C6CC33FC141CA28E20CEC600BBEC0D78F7F6C6E0
              89555B2E57FE0036A80DE621B175BCC51AB4CCADB1EE52F62044C544A92C1CE5
              FE9FC30FFA832BCCECCCED4ACB405A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000764944415478DAEDD44B0AC0200C04D0C9B9E3D29C3B55A12025C640
              ADEDA22E74213E7FA3A450104AC509B78AE48280683BA82220E635E08985D0D5
              A04AA6DA0EC11E9981AD1FEAAFF05170867E03F4D029E80E1C4DD2C7A65D3727
              0D6FCF3A8A6B0E6B1DCF9C914F2BD8E16766EDE2B5CFE107F78307191FD0ED22
              5938A10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006F4944415478DAED94C10E80200C43E977CB917DF7D8D411D0936C46
              13ED8594C04BD704C08953A4D00321563C3E07F488D18079C94C44BB9B4929A8
              1E38267402359D6EBD37E1DFE1B31D6205A5762F2CA13DDB53875E0D09155CA8
              6066DDEA3A8C6C07AE789BCA7E29DCFA6347A80209DFAEEEC941836800000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A64944415478DACD94490EC0200845E5DCBA94735BACA5B1080E1D92
              B2310C797EBF46482EB937036A20504A39FC0F187CD8A988E8BCF7E670C4083C
              6BF51715D2F8E0042730EF9C15DA4086F5A1930A25C4860E3D8C540B47ADF6B0
              AE2F7A68A9D1EB131EDE04EA0A47B7DAF6BB1E4A9FE43BD4FA1D85E337A7CD19
              1ECEC28A88BC164AD21496C60C4C8213036B0F9FC6456106B3F12B6BA3500257
              723E155F267CFA63BF111BB26CD5EE0CA607620000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000624944415478DA63FCCFF09F819A8071D440064690101A00AA61C425
              4E9481D814122D4F1703F1796B70B87084194829A0D84058AA80B99A6A2E8405
              05D8406CD98A222FD754D7FC6F696D612497C670210C202B2096DFDADACA4093
              3044F1323501000FEB93EE2C778AC30000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DABD94D10DC020084461351DABDF1D4B57B34242635B
              156AB5F72321FA725C889820C14CE1722052ABA27C0F878159D71EA219DA0412
              248400CE39AEA5A741CD0EA5A741BB0E79CCA2B6646A72F878D471A93A3C1D49
              864A966B1CB676CFAA127E02C9558C91D7E4CDE9BDAF0365E7AC30A08C2B79AE
              73383D43806D10B7FF00E46270ECFB3EAEFF60BFEA00D5ADC4EDE55E9CB40000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C44944415478DAED934B12C4200844E973EB52CF6DC41103FE12ABA6
              6635BD512AF06CD02051A26F0A0C042F1BE51C1C03B3E6098082CE0EB687BD02
              F2B7B2D662EF7C0A314EA123901D29B800DBBE156BB72B602E28257443A5E571
              A64F400E38358D2EBB19ECAE0F06488BB687992E60C621893BE15107ADCEF0BA
              E5DE917659674B0D29B3BC23E71C8518B0041A97985F528184A8F213B6EF50A0
              30E3B040164307201D4840B13E6E8E79DF804FFA7490FF10CF2D86798676F807
              FE06F8984407C0135DFFB6CEEDD47C8BBC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B34944415478DAED924B16C3200845616B66593AC465C5AD51D17AAA
              A6C44F3BCC9BC8017285179181E19F4201A21C8A621D41AD4B4D01465D6F435C
              863640E75C4A12518ABDF7207901F3659AFA824F6D0A58A66DA19BC0EF9E6E02
              E5EC3DBD7F138CB7C03E4E16A83F284FB909DC5C79EC6704BC636B2D90A7B995
              93775C7CECA0559E673D2C40F94826A9959F9602D4848830A306386C8E1D219C
              608C69F22184983BDA0947CA1B3CC05F81C3265800AEE805632406FC27788E4C
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B14944415478DACDD4D1128420080550F86E7DC4EF66BD95B58E286A
              B333CB4B39D109C4898948C90925652FA7041235473F817909BD41BC67B900CF
              E7DC69A5FED03478DF672086A89292894E81F69EB26E8166C52BA00BF36836CA
              2ED8AEC7C3D904375AEE5F9F96F5021021049224FC0A3C10494F27A33D9C0511
              402BD03F2C7514285D871B6BDC1FA04E789C0780EA62448B6267940A5BB04CEF
              7B72DB20B0F6AFF26F60DDEECF2A7427470BE04A7C0097BCE0EDF9BD8DDF0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D14944415478DABD944B12C4200844E1DCBAD47313612481F8CD4C6A
              D8444A7CD5D054100008164140B8AAD1E0422A312E407C04DD02F2BD7CFBFAF1
              2BE0792E801822A59CBBD016C82D9A5C5B6E678AB40696C7A2013CB451BC0554
              18B52A6FC48925840E0846E95CE1D89C0F500EE479F7B6AB32DC99211858D79C
              3A8EEB899A736521044839E1706D9C4A03B7AE0B2465534F38DD4385FA717820
              07431D101E8682725D6ECEF92C40DAE0158DD2448CDC62EA57A8420F64E7DA9F
              C08FC0D3437C09F8BAC23F0197CE018C5CEE4377E3001713C9ED3372590B0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000884944415478DAED934B0E80200C05FBCEAD4B3D776D6D08FF42220B
              17B0330CC310104C4C2B07540822162D9A80CCD175DBC77950CA4196CB7A044E
              E732610ACC084BAE12EEC2F7CEA08AEF85E008F685161039A75085F1287EA1B1
              4E61A89B1146B623CC65BEB0DEB81006C7CCB3696FDC107275837D2163F06C60
              CA6161FF24FBD7FB73E1CAF1007EB9F7ED41C2F1000000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000964944415478DAB593CB168020084487EFAEA57D37651DB31444CCDA
              98AFCB5C4E1100663061D243BF02091BC791B190F7BD02C6CDE786509BAF51B6
              49F73B944B509CEBE78D84DAE57ABD4A381DE8ED9956AC91B0DDABF28CA1DC03
              33807DBDB3D585841E58062ACA2B7CB00C250408CADE74522FBB7F3D03F9568E
              0B015F80E9BB3D81E31029E9AD4C93C602982B8DCD0FF1A9C6D801BB2BCAEE4C
              4E3C6E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BC4944415478DAD594410EC3200C04D7CF0A47BE158EF02D8E7CCB95
              438D206D0934A8527DB142A46199C41083B1B24880C18725D4DDED5480D6DAF2
              22C6886F9E37B3FD13F0670E8D31653DA574EFC802E3233B83880A7418A869BC
              F770CE3530E6DC8781192004828439C3745D361B72A8897AB029877542A0EDBA
              894227807881D57DD8211D239D237C820AACE7AF7148F595F306AAC986274514
              35B7D8F39FD3926453A3A7D433F4EAABF681A8B55DFB9A7028470CF76E9B95F5
              008C652CFC134B5AA70000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000CC4944415478DAB594490EC3200C45F1B96149CEEDE212337980A8A9
              3708018FEF411F30607833A002CB12107E46150674851D7AE50B534AED6ACE39
              C41461071B14F603B8016BD007A86631673701A16CEB4E3E64D5335496AA01E9
              01AD3535BDA627771A90D4CDB5920FBA4A3D8B0D50420918BFCDB22762035CA1
              B56978029CEBA37592EED4EE7B2324BA6CABA4735F9D008E500EAA1929DB35C3
              0472FA0CE0411FBBEF2905DB1C8C39BB87DF821A40DF2C3CA8023C731E0B2ACC
              E1898D6950D5BE9EC46A28FF34D877E203BCA5B9ED3C284DEC0000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item21'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005F4944415478DAED90B10EC0200844B9EFC651BEFB8A4B7B433B98E0
              502371796ADE01A0D12A0B0B8510339187F20BE80FB3E5FB0EC2E21DAA39F311
              1637BB3920CCC15DB8397E282CDF6164A24BD2CCDDA770B69B37F1DA0ECFC8BB
              8F5C5517163DBDED3C641F900000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item22'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BE4944415478DAC594410E03210845E15A5EAD2E9DAB792D2A4E152C
              DAD1B14DFF0603F1F9052312107C53C840E4D051AAE16D60922D222E4395C3B4
              220B14A7BD5BD8C31A87BC5F43B3C39C17A74738E8E1FD106AAEACA10568AFAF
              DD5E002B95C370502BC00A23D0A9BCC64FF339C12DB06C50A4168C83572B2E05
              586B66D435277D5CEDA1790B08E501492F4FF7200DC279E0DBC4BBB59F036153
              0D70465787DE06C6189BBC736E1FC89002DE068610C0A7CF8123CBBF3E8AFFF7
              70564FA488B8ED12BFF8FB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item23'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BD4944415478DACD94410EC3200C04ED6F71E45BE1C8BB38F2ADA4AE
              BAAD310EA46954656F58CEC8DE85F04A2B5D29FE3B90A5E5A5472F779F9BDA10
              28B05A2B851028E74C292505ED61432060A594A6BEA4859DEE37DC050226C274
              A218E3F3DCAEDE4E7A1828309C476B374004001800BAF6014E3CD40158A0AE8B
              A7BE8F0E1049C233919C7D201BAF4C281A78C984DA433BE1290F6DCA807A131F
              4EF97B600F1DBE141D92DCC37DFF262FC57A0A0F67EB4E8116FAF3DFE68CEE0F
              DC002252CDEDAD27A9B80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A54944415478DACD54ED1280200863EFFFD0A4617E84205D76D7FE24
              41632C0A4C4C1920703A835E02993093E5C0234C89D490960D115518263C8515
              FC5361CC43703BFB2F2EA81029715642C8DD49561E0A411B7941E82B6C0F3F22
              B43D9C118EF75D85DDF4D2A68BEFB0F28E87A30ABD3673958687BA78BE8793BA
              D1C3AA55773617FBDAD1E2F5BE2F4588BFFD39F8600AF06985F655142EEBAC91
              753C8E6CD557C25D3800E92CB2EEEC085DB10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AC4944415478DAC5934B1284200C44D3F79EA5F76E49C019010319B4
              CA2C44223C3B3F50289E4184B4256E5020744996DED17E4C9EFF81590DD80157
              149AB0622F28D4D41053603C8741604CE1011B4383393C4326C0B942FB6738EC
              2A87DF0099695B7A7C7443A9FC76E3D22F182804F592DF87D74A9D1CE6C3E33E
              7480BDC2DFC1F9A4F4D0A60FA52A406C524AFE0F11CFCD72068F812BB37C2ECA
              5D632964A5F0F6EA85BCBA079F8BD86C0770BBC5ED7A60B2560000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item26'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007A4944415478DAEDD4D10AC0200805D0FCEE7CB4EFAE1C08D24A658B
              0DC67C690C3D5C590C6AAA6967C10F9E1B7A4BEF81AD209F51D4040B958A88C7
              3311A58CD9454D50D24945523E07CABA8C081C597B093222804EEAA5344119BE
              0DEAAF3B96B7F614D4EBEA7791944B701CBA0CCE06C7EB63A11FF8DBBC0E36B1
              1C6BED2D28C7FA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item27'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000754944415478DAD5D4BB0D002008045058CBD5A4C4D55CCB4F61A9DC
              191B6934217939BFDAA4C9CBD27F411DADD1D3A7E01C59F408D65A25A544A121
              388B41219041611045291041E984AB762874CACC6943F770CDDD5DB2E5FB3D5C
              898A976666C7A586E02E71941206D194D46F83BCEF8FFFC3DBEA21E877EDDC26
              960E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item28'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A34944415478DAAD544912C0200883FF3F9A62198B1B8B1DBC542513
              42A02201415B0848BC47301732D08B7F287AC9DAC123E40027841C61AC103920
              A923952FA21F4A08CB15C61E4A33D443BF39098597849E874222659628FC4D68
              7968114A83CE33B9291C0738B30F3D9CC15A9E759F54B8966929DCCB5F3C6C91
              0E98C13BE1985407DEF1F08650F18584723F35A5621D149EBF3A163ECEFC53A2
              17DC4C44B515C30335BFE9EE587686FA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item29'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000934944415478DAD594D10E80200845E1BBF351BFDB34B544216D615B
              F785ADE870B96CA1070F9AC225408C45418185A7C3083D1EBCAD4B1C16BA98CB
              83F702B038CE4D2CF0EAF90A580014760FEC07360EDBE3700EFB03623E88B072
              ED30B9A003FB2D0619CEAC3C0974D6F9CD1870D642ACDC075CCF20C3DAA99421
              850B19D23579603D3029424D80764050D08F7E0E9A5207EE660DFDED202BD967
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item30'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000009D4944415478DABD938B0EC0100C45F5CBD5975B7521A6AD77D64484
              717676074417DDCD821A0834A431FC08A4E58317323060602A2272D3CAD37CA0
              96FB43C3D6CC362DC06499EC24D0DAACCF4F186E007B195A9959F303C3D15F95
              CF3B198E8F88B6CE309C8549A8C830B22DCEB39A4C15C3543BD7EFB554325C03
              02835CD977CD30E72F323CAD8F61027BF4B0DA0BC316B832CE5F15EB6373B3AE
              031FC5DEC971F0D946730000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item31'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A34944415478DABD940B0E80200C43D9C98193E30699512830145D42
              C83E79D68A5072C9ED0CBA028953CEE947208F4F1E988131C44C0D21E485C273
              3DF2D21DCF785A50A8EAC62A4FA0A81475185843FA50A3C245E0C8C39E67A86E
              F4B0A706D70D1E3E046285B373D7F6871E8ECE1CEA4F3C9CFF1568AEE3A11556
              44C85E2809292C0D0BAC0627055E3D7C1B378502166357F746610D5CC9F5ADF4
              63D2A737F68E380094CBD3EE908B7A710000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item32'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000994944415478DAC591510EC0200843E5E4C3933371BA8862264A327E
              4C8D3C4B010A143C0B5A202499340C8F82FC95F2D526B0C22AA4D726E0AC99EF
              0DC0B691CA88D309DB204000234642C48A581A4FF8EA81D2E12190DDB1F8CDE1
              B81405A865A841F54F161DF6D0779F43048B19AE97D1E1167096E1272AC33806
              678750A04386A7251C32F8C20B76CE27AEE2B0075A749D4ACDD0A3DC81372B0F
              CAEEDF2E5ACE0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item33'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C04944415478DAAD935B0E85200C44DB95D19D813B2B2BEBBDF88830
              8048647E4CA09E76C6CA4464AA4AABC4096870183F3468020F19DF0DA24D01D1
              B213C775E1564003DC8B4A1FD8928856909081A7812339C9806840CF6E3861AB
              E60215192210ADF9F364CB6E3C543159DF324E63F072024BE622AF7F95616E6B
              B4A3D51E7E59EA2610850D043E98423C9DC5BE5FE232BE77133E65389A08EF3F
              2DB6EE7F8FAF8144658A615F8CA35035AE053E9DB59A8D3314B716382BB6BF5D
              4E8F45FA0198797A3C3C8B98260000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item34'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000904944415478DAB5D4DB0E8020080050F972E7975374531114957849
              619D3132010306CF000D4C54EA440C086690B038E8242968035AB01E5A813398
              867EE00A26A117B88371F467109F7902E4F5BBE7F5724FE099AB412A023B0565
              4E5A17CF16E42F5941B5432B227528CE90CF47EB98CF50053DBFF29D703CD8B9
              E0F8EBADA0C3CB6106355F5F25DA03A72ED89D380046109DEDFBD4739A000000
              0049454E44AE426082}
          end>
      end>
    Left = 1248
    Top = 1279
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
      end
      item
        CollectionIndex = 12
        CollectionName = 'Item13'
        Name = 'Item13'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Item14'
        Name = 'Item14'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Item15'
        Name = 'Item15'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Item16'
        Name = 'Item16'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Item17'
        Name = 'Item17'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Item18'
        Name = 'Item18'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Item19'
        Name = 'Item19'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Item20'
        Name = 'Item20'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Item21'
        Name = 'Item21'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Item22'
        Name = 'Item22'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Item23'
        Name = 'Item23'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Item24'
        Name = 'Item24'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Item25'
        Name = 'Item25'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Item26'
        Name = 'Item26'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Item27'
        Name = 'Item27'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Item28'
        Name = 'Item28'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Item29'
        Name = 'Item29'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Item30'
        Name = 'Item30'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Item31'
        Name = 'Item31'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Item32'
        Name = 'Item32'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Item33'
        Name = 'Item33'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Item34'
        Name = 'Item34'
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 616
    Top = 1415
  end
end
