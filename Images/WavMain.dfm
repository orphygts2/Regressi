object WaveForm: TWaveForm
  Left = 43
  Top = 285
  HelpContext = 46
  Caption = 'Lecture de fichier son'
  ClientHeight = 905
  ClientWidth = 1914
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 192
  TextHeight = 36
  object PaintBox: TPaintBox
    Left = 0
    Top = 111
    Width = 1914
    Height = 366
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    OnMouseDown = PaintBoxMouseDown
    OnMouseMove = PaintBoxMouseMove
    OnMouseUp = PaintBoxMouseUp
    OnPaint = PaintBoxPaint
    ExplicitTop = 136
    ExplicitWidth = 1984
  end
  object PaintBoxZoom: TPaintBox
    Left = 0
    Top = 487
    Width = 1914
    Height = 418
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    OnPaint = PaintBoxZoomPaint
    ExplicitTop = 512
    ExplicitWidth = 1984
    ExplicitHeight = 398
  end
  object Splitter: TSplitter
    Left = 0
    Top = 477
    Width = 1914
    Height = 10
    Cursor = crVSplit
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Color = clHighlight
    ParentColor = False
    ExplicitTop = 502
    ExplicitWidth = 1984
  end
  object BoutonsPanel: TPanel
    Left = 0
    Top = 63
    Width = 1914
    Height = 48
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Color = clMenuBar
    TabOrder = 0
    ExplicitWidth = 1900
    object DureeTot: TLabel
      Left = 251
      Top = 1
      Width = 200
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = ' dur'#233'e'
      ExplicitLeft = 252
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object FreqLabel: TLabel
      Left = 451
      Top = 1
      Width = 200
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = 'fr'#233'quence'
      ExplicitLeft = 452
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PositionLabel: TLabel
      Left = 871
      Top = 1
      Width = 200
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = 'Position'
      Visible = False
      ExplicitLeft = 872
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object DureeLabel: TLabel
      Left = 1241
      Top = 1
      Width = 200
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = 'Taille de l'#39'extrait'
      ExplicitLeft = 1242
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object FreqRegLabel: TLabel
      Left = 651
      Top = 1
      Width = 220
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = 'fr'#233'quence'
      ExplicitLeft = 652
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object BoucleCB: TCheckBox
      Left = 1
      Top = 1
      Width = 250
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Lecture en boucle'
      TabOrder = 0
    end
    object MediaPlayer: TMediaPlayer
      Left = 1790
      Top = -8
      Width = 29
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      VisibleButtons = [btPlay]
      DoubleBuffered = True
      Visible = False
      ParentDoubleBuffered = False
      TabOrder = 1
      OnNotify = MediaPlayerNotify
    end
    object EnveloppeCB: TCheckBox
      Left = 1071
      Top = 1
      Width = 170
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Enveloppe'
      TabOrder = 2
      Visible = False
      OnClick = EnveloppeCBClick
    end
    object ZoomUD: TUpDown
      Left = 1574
      Top = 2
      Width = 74
      Height = 34
      Hint = 'Taille de la s'#233'lection / Zoom'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Min = -256
      Max = 256
      Orientation = udHorizontal
      TabOrder = 3
      OnChangingEx = ZoomUDChangingEx
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1914
    Height = 63
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 63
    ButtonWidth = 151
    Color = clBtnFace
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    ParentColor = False
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 1900
    object OpenFileBtn: TToolButton
      Left = 0
      Top = 0
      Hint = '|Ouverture d'#39'un fichier son .WAV'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ouvrir'
      ImageIndex = 7
      ImageName = 'Item8'
      OnClick = OpenFileBtnClick
    end
    object PlayBtn: TToolButton
      Left = 151
      Top = 0
      Hint = '|Ecouter la partie s'#233'lectionn'#233'e'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Jouer'
      Enabled = False
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = PlayBtnClick
    end
    object StopBtn: TToolButton
      Left = 302
      Top = 0
      Hint = '|Arr'#234't de l'#39'enregistrement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Stop'
      Enabled = False
      ImageIndex = 6
      ImageName = 'Item7'
      OnClick = StopBtnClick
    end
    object RecordBtn: TToolButton
      Left = 453
      Top = 0
      Hint = 'Enregistrer|D'#233'but de l'#39'enregistrement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Enregistrer'
      ImageIndex = 0
      ImageName = 'Item1'
      OnClick = RecordBtnClick
    end
    object ModeBtn: TToolButton
      Left = 604
      Top = 0
      Hint = 'Choix de la source et options pour l'#39'enregistrement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Mode'
      ImageIndex = 4
      ImageName = 'Item5'
      OnClick = ModeBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 755
      Top = 0
      Hint = '|Traitement des donn'#233'es : FFT, sonagramme ...'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Traiter'
      Enabled = False
      ImageIndex = 8
      ImageName = 'Item9'
      OnClick = RegressiBtnClick
    end
    object SaveFileBtn: TToolButton
      Left = 906
      Top = 0
      Hint = '|Sauver dans un fichier son .WAV'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Sauver (wav)'
      Enabled = False
      ImageIndex = 1
      ImageName = 'Item2'
      OnClick = SaveFileBtnClick
    end
    object LabelAttente: TLabel
      Left = 1057
      Top = 0
      Width = 559
      Height = 63
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = ' Traitement en cours, patientez ... '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -38
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object ExitBtn: TToolButton
      Left = 1616
      Top = 0
      Hint = '|Quitter'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Quitter'
      ImageIndex = 5
      ImageName = 'Item6'
      OnClick = ExitBtnClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'wav'
    Filter = 'Fichiers WAV|*.wav'
    FilterIndex = 0
    Left = 1064
    Top = 224
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'wav'
    Filter = 'Fichier son|*.wav'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 944
    Top = 224
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 110
    OnTimer = Timer1Timer
    Left = 816
    Top = 224
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
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
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D14944415478DAAD94011284200C03C9CFF8993CCD9F71460DD65E95
              93B3331D11702909889A6A8A02096D60990337BA8CF9BE365243D83CCF29E79C
              4A296B1ED06B5808148C69632A13C2CF1DFC04148CA1EAD4669EB71E57DA05F2
              A9F75FB6BD026580DDA64076810DD8D19026CA000FB4FDCC58C7002827A51983
              ED1808772C9C2916F84A8556435FE19086DE6581A28AF72DDE2AF81C586F8040
              7C53AC49D290FA6DD31F025BE17BC818EA872F873B1A5E417543FE02F6167915
              58031D018C03FDAF8DA153300C8CEEFE30F0EAEE333E6CBFD8F7406B99680000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005C4944415478DAD5D4310EC0300843D1F8E44D4EEE2EC9142130F2D0
              FE099627B1000E0E67F8178809721256F0CC5DF8069FBDAC1E1C832711CE4111
              AE8345580713B80F6ED40612A69323480633A80C56A11454A110B43E0747DF07
              5FB13065ED9F217E320000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B94944415478DACD92010E84200C04D99FF1B3C39FF133AE95AB142D
              82E2256EA24028D36D01C925F7A4C040F0D010EDE316906407008D1AEC4405B8
              C6CC436B877450A0C042D3CF0EAA01DCA61E309FA475C8F915F0081D04B23381
              9DBBBC004CEC90D61A2EEEDBCA701BC8805F3FB5CB91CB51EFD0E8DB0E5A4AD6
              EFB62EBBFB0EA5CCFC2F31EBA9CA6F4ED607EA0B398911F7FF03BA07B4014734
              92F41D40AB8F00EE03638C873DEFFD1C90011A3C050C216C9F48E60CFC02C27E
              C5ED569A793D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000744944415478DAD594510A00210844F5E6DEBC6D83057367A2A43E1A
              0853549E066991223BA5F737D43705A8D669BA612C46B1738466D60AAA6D270A
              C5596E47C8C6581EF938A1B76C5F91D0FB94F0BBCF507B9F12C27108F5142112
              A31E124A4269C211F98F304B1677BAA561F740F7FF87AB7A00176D937241F06D
              2D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
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
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000003E4944415478DAEDCDC10D00200843513A79EBE4681C8060F42009FF
              DE57B8B9BD0C0D160087C6F103458420A5BCE66B0F6BB01E48E6C1AD04E06D0D
              7E084EAFE253ED828BED200000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
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
        Name = 'Item9'
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
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000714944415478DAE5953112C0200804B9978B2F27D039181D82A49242
              9C2BD61D2884905065C103A19166280176EEC2CC54062C35343BEBBF1AEAA177
              FA04DFCEF0187899E1DB964760141E364C0177338CC253866160C6D0C38F0D97
              C071CBD93291C9D0C08D1BB27D09F4AF4773547F010FA6F2C9ED72AD9E9C0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
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
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007C4944415478DAE5D58B0E40300C05D0DE3FF7E7A535369DA1532121
              F1486D27573380892972430B0411B39E02C005EB412B7046C460F4240D0565EC
              B3609E3C951328D7201D85334CFBFE49B06CD30A6E7B75039463BE3598DD5F4F
              097D29CAA7B0ABE0AFE0D5B7C1AE84BD10EF8225DA9AA375F737EF2000A27F01
              2362DAA8EED5A5D3AA0000000049454E44AE426082}
          end>
      end>
    Left = 436
    Top = 204
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
    Left = 216
    Top = 348
  end
end
