object CourbesForm: TCourbesForm
  Left = 225
  Top = 287
  HelpContext = 47
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Lecture de courbes'
  ClientHeight = 1680
  ClientWidth = 2602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  ShowHint = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = EditBidonKeyDown
  OnResize = FormResize
  PixelsPerInch = 192
  TextHeight = 36
  object Splitter: TSplitter
    Left = 2192
    Top = 134
    Width = 10
    Height = 1474
    Hint = '|D'#233'placer pour changer les dimensions relatives des deux images'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    AutoSnap = False
    Beveled = True
    Color = clHighlight
    MinSize = 300
    ParentColor = False
    OnMoved = SplitterMoved
    ExplicitTop = 136
    ExplicitHeight = 1472
  end
  object PaintBox: TPaintBox
    Left = 0
    Top = 134
    Width = 2192
    Height = 1474
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = ImageMouseDown
    OnMouseMove = ImageMouseMove
    OnMouseUp = ImageMouseUp
    OnPaint = ImagePaint
    ExplicitTop = 136
    ExplicitHeight = 1472
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 1642
    Width = 2602
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <
      item
        Text = 'Cliquer sur le bouton ouvrir pour charger un fichier'
        Width = 640
      end>
    ParentFont = True
    UseSystemFont = False
    ExplicitTop = 1641
    ExplicitWidth = 2588
  end
  object GridPanel: TPanel
    Left = 2202
    Top = 134
    Width = 400
    Height = 1474
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    ParentColor = True
    TabOrder = 1
    ExplicitLeft = 2188
    ExplicitHeight = 1473
    object Grid: TStringGrid
      Left = 1
      Top = 1
      Width = 398
      Height = 1472
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabStop = False
      Align = alClient
      ColCount = 3
      DefaultColWidth = 100
      DefaultRowHeight = 48
      Enabled = False
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = GridDrawCell
      ExplicitHeight = 1471
      ColWidths = (
        100
        100
        100)
      RowHeights = (
        48
        48
        48
        48
        48)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 44
    Width = 2602
    Height = 90
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 2588
    object SerieLabel: TLabel
      Left = 638
      Top = 16
      Width = 238
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Courbe courante'
      Visible = False
    end
    object Label1: TLabel
      Left = 180
      Top = 16
      Width = 321
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '  Nombre de courbes  '
    end
    object ZoomEdit: TEdit
      Left = 16
      Top = 16
      Width = 177
      Height = 53
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
      Text = 'Taille r'#233'elle'
    end
    object SerieSE: TSpinEdit
      Left = 888
      Top = 12
      Width = 66
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
      MaxValue = 5
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 1
      Visible = False
      OnChange = SerieSEChange
    end
    object EditBidon: TEdit
      Left = 1344
      Top = 0
      Width = 2
      Height = 53
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
      Text = 'EditBidon'
    end
    object SignifEdit: TLabeledEdit
      Left = 1200
      Top = 12
      Width = 568
      Height = 53
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditLabel.Width = 175
      EditLabel.Height = 53
      EditLabel.Margins.Left = 6
      EditLabel.Margins.Top = 6
      EditLabel.Margins.Right = 6
      EditLabel.Margins.Bottom = 6
      EditLabel.Caption = 'Signification'
      LabelPosition = lpLeft
      TabOrder = 3
      Text = ''
      OnChange = SignifEditChange
    end
    object NbreSE: TSpinEdit
      Left = 502
      Top = 15
      Width = 82
      Height = 56
      Hint = '|Deux s'#233'rie de points peuvent correspondre '#224' deux courbes'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 3
      MinValue = 1
      ParentFont = False
      TabOrder = 4
      Value = 1
      OnChange = NbreSEChange
    end
    object GroupBox1: TGroupBox
      Left = 2301
      Top = 1
      Width = 300
      Height = 88
      Hint = 'Couleur de la courbe courante'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Couleur de trac'#233
      TabOrder = 6
      ExplicitLeft = 2287
      object CouleurPointsCB: TColorBox
        Left = 2
        Top = 48
        Width = 296
        Height = 38
        Hint = 'Couleur de la courbe courante'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Style = [cbStandardColors, cbPrettyNames]
        DropDownCount = 16
        ItemHeight = 32
        TabOrder = 0
        OnChange = CouleurPointsCBChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 2001
      Top = 1
      Width = 300
      Height = 88
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Couleur des axes'
      TabOrder = 5
      ExplicitLeft = 1987
      object CouleurAxeCB: TColorBox
        Left = 2
        Top = 48
        Width = 296
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Style = [cbStandardColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 0
        OnChange = CouleurPointsCBChange
      end
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 2602
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 42
    ButtonWidth = 140
    EdgeBorders = [ebBottom]
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    List = True
    ShowCaptions = True
    TabOrder = 3
    Transparent = False
    Wrapable = False
    ExplicitWidth = 2588
    object FileBtn: TToolButton
      Left = 0
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Ouvrir'
      ImageIndex = 11
      ImageName = 'Item12'
      OnClick = OpenFileBtnClick
    end
    object EchelleBtn: TToolButton
      Left = 118
      Top = 0
      Hint = 'Echelle/options|D'#233'finition de l'#39#233'chelle, options'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Echelle'
      ImageIndex = 10
      ImageName = 'Item11'
      OnClick = EchelleBtnClick
    end
    object MesureBtn: TToolButton
      Left = 245
      Top = 0
      Hint = 'R'#224'Z et d'#233'but des mesures'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Mesurer'
      ImageIndex = 9
      ImageName = 'Item10'
      Style = tbsCheck
      OnClick = MesureBtnClick
    end
    object LoupeBtn: TToolButton
      Left = 387
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Loupe  x'
      ImageIndex = 19
      ImageName = 'Item20'
      Style = tbsCheck
    end
    object zoomUD: TSpinEdit
      Left = 531
      Top = 0
      Width = 68
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 4
      MinValue = 1
      TabOrder = 0
      Value = 2
    end
    object RazBtn: TToolButton
      Left = 599
      Top = 0
      Hint = 'R'#224'Z|Remise '#224' z'#233'ro'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'R'#224'Z'
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = RazBtnClick
    end
    object UndoBtn: TToolButton
      Left = 690
      Top = 0
      Hint = 'Annuler dernier point'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'D'#233'faire'
      ImageIndex = 1
      ImageName = 'Item2'
      OnClick = UndoBtnClick
    end
    object SupprBtn: TToolButton
      Left = 819
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Effacer'
      ImageIndex = 4
      ImageName = 'Item5'
      OnClick = SupprBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 943
      Top = 0
      Hint = 'Regressi|Envoi de donn'#233'es vers Regressi'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Traiter'
      ImageIndex = 3
      ImageName = 'Item4'
      OnClick = RegressiBtnClick
    end
    object ToolButton1: TToolButton
      Left = 1062
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Aide'
      ImageIndex = 18
      ImageName = 'Item19'
      OnClick = ToolButton1Click
    end
    object ExiBtn: TToolButton
      Left = 1161
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Quitter'
      ImageIndex = 8
      ImageName = 'Item9'
      OnClick = ExitBtnClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 1608
    Width = 2602
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 4
    Visible = False
    ExplicitTop = 1607
    ExplicitWidth = 2588
  end
  object OpenDialog: TOpenDialog
    Filter = 'bitmap|*.bmp|Jpeg|*.jpg;*.jpeg|GIF|*.gif|Ping|*.png'
    Left = 144
    Top = 506
  end
  object TimerMove: TTimer
    Interval = 165
    OnTimer = TimerMoveTimer
    Left = 832
    Top = 484
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
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
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000854944415478DACD92DD0DC020088461333793D1DCCCDA26186BF1AF
              679AF24222E1E33CE0489176067F0AE4544E75DEAA70157A01B5C9CA210472CE
              9142CF376DB606658565732BEB901A528221851614F2B0848B0879F10C6FB9F6
              14BEC32170F94C7A402DCE02BB1EB6B6371BB72DEF826520A250BFFA00BEF1D0
              F415DDF21088C6FF8107E14E90EDF21805200000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AA4944415478DAB5D3D1128420080550F872EDCB596DCA15B957DD9D
              E2D1E818046A62F2642803D5143E28C7FA13D8A083BC913C5CF3FB4B1C78620C
              22F0999F7351923A30602529043A931DB04B70ED90C3203C823BD8B42D10D4EF
              AD0CA43D4625EF462B7B88BFC1E585AD6412AB41C660265B918DF792F49C820C
              6B20990AFE8509978B16600FBCD010132C82F706B0159339E6C17E38EBAC4DF6
              76FC1101840F1603CCE29DC17E323EA31996EDFC7D02170000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C64944415478DAAD93090EC4200845E1E4E2C91D70A9E0E09648D2B4
              147C7E1031418297860244794D8CE308D3B8C42640367F47C44D0D16DA8139B6
              828E6AB4EA1EB30A7961832246FE0C0BE809B0AC649F4ADA00EC3DBD008AB206
              F355AEFBE9029328645FC36DD9DEA917953E5000B59FCD6F257FCBF5F1F04344
              1028A09AC3FFBE6928E8FFBDC0361F393779253B33539BBDB951C7405516D49E
              5A99E101F083287F04C2CEF2E01F02779637D4C05DC9D7C0E70A9F01974917C0
              4831C94D5899B9292FED071DADD2ED52629D270000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A04944415478DACDD34B0E80200C04D0CEC98593570A22882DA0B270
              3698A02FC3473031AD0CBE80089F335F34BC065B0C9E889D02C61789F11493A8
              E09B66312E80648056CB8C21CCC4B1C1D2364E36BC6148508DA9606E57B74CCF
              32F631B3A18695391B1B2EB9C524FEF0AC9BD06DD88223ACDBB0465D394C1ADE
              51BDA1E74C649426B0132C801637053D00A5D986995F72B86481ACBD5D062E6F
              F80FF04B7637B79CED430D6F550000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
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
        Name = 'Item7'
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
      end
      item
        Name = 'Item8'
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
        Name = 'Item9'
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
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000CE4944415478DAB594810D85200C446132D94CDC0C27E35B9333FD07
              851AB58911101FD76B35D650C39B113F03C66398730E29A5F342C81AEEC7DE78
              0B584A396100CB5CC6B81023F005DCF256A14E831936536A2AD480994279176B
              8D87DA37CB43C90687AC798D2690613D280096EA3F0F7BA9F25C5ED47B51C025
              2DFD94598106E079AFCD1A856CF2A80018EB225E07B187B3E6D5C5D36DD6A48C
              B4AC146F2BB48A6229E6366B3CDCCB5E712AB709C3B8CA12A6879E9F81AB0F45
              A1F767E0FA5278A3F6D253F9611F3E89D7813F3F7D1DFCD322D4F70000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000364944415478DA63FCCFF09F819A8011DD40460688C07F30938168B9
              61602003432316E5F50C83C785A35E1EF5F2A89747BDCC404D00003EDC6AED46
              2A9E2A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000824944415478DACDD4E10A80200C04E0EEC95B4F7E498D5AB5749682
              83B41FF3631712269293570BCEF7D96FF10A076801AF82E80E96B00AB40852B4
              5162682730F20D2D4E3600D364042AC0126AA2E6603CEEE11BFA194C257A4018
              BFD04D406FD2B1C0E691BB80F7D8E38199C830A0EE172FFC3F0C7666632BC6ED
              615AF00BB5E00A9A9087DB83A11B650000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000664944415478DACD92510AC0300843E3C9C74EEE50700B1D8316DBD9
              FC48B53C0D2A0A854900550FB8DF1639D72361207052E9401A387DC252CB5F0D
              D313B6FF1C18C9AC0CBA0638DDF253D86029AF46DBDC61CD844B801C03D836AB
              05B2DDD088ED7F8099A55C2DD27FED9B3C85B10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000644944415478DAED93D10E00100845EBCBCD9767437327F340C6839E
              B8CBD19558480883A90892974DC3FD2C18810AD350C81B403D849651BB0FB4B6
              23A881B6812E5D3E0AFC968DE5D1C52E15F6F935D72760081C81BBDFC6585E7D
              C3634D31153F3F2909DAEC7CEDABB9AE6B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000624944415478DA63FCCFF09F8154C0C800D1F41FCC448881F88CA41A
              08330C0660860E0E03E19A90BC8C2C36F006627ABB1149B49E816203A912CB34
              35709878199B62B2BC4C8C4144BB103D3B5102686320D5BD4C48312E0387493A
              24C5406C5E060000897CED1DEDBD420000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000644944415478DA63FCCFF09F011F60648028F80F66E21683CB116B20
              03432392683D03C50652DD85641B88AE986C2FE3B2952C17225C41190059401B
              03A9EE659A440A2E30F8D2212E0347A097C1690C48C16874B1C161206A243160
              8D9881379050A40000A5697FEDBD82E47C0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
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
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BC4944415478DAAD94810D85200C05E9666C066C0693F5DB922AF4A3
              14F4252606F07A4203A043F765E00E083435C8B11EB6818815718E01D8812323
              02A614F93D84C0C0993103AB4DE5A5945C8CD169BBD692E6A94029C579EF3B68
              073C174CCE894473CEFC70F119D0123370255B408BF13210079B7A1D1E76ED64
              06B61D53DBE902CAE91374DB5020FAD7B70CC59222DF483FBE32D4B6AF0CB5ED
              1F501A55A7DD78B3210FDC5C57D560D1F0B17273712C193E01A73431B50057F3
              0310E3F9ED842C1D400000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
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
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B54944415478DAC5D3D10DC420080660994C37936EA69379D20B0DB5
              3F97D69A1C2F6A6C3F1103B5D0C2CAA0BF801B6F8D998FB5CC33679A02A97F62
              318BF67FE91168B194D269AF94025117946BEA3CE7BC8FB5D60BBAEF9BEBBBA0
              662799C51821A899DB9ADE0251C82172C02350AFB40CF432544C1FE63628A345
              6D2D2D661F068282F50844DFC71B33F530088E981708BB8008435DA281DAEF00
              7F615EDFC2DA8F19BEC1DC1ACE621094903E9EC15CF04D2C073F3BF0ADEDFE39
              69B10000000049454E44AE426082}
          end>
      end>
    Left = 332
    Top = 420
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
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 544
    Top = 496
  end
end
