object ArduinoWifiDirectForm: TArduinoWifiDirectForm
  Left = 0
  Top = 0
  HelpContext = 80
  Caption = 'Acquisition par Arduino (Wifi) pour Regressi'
  ClientHeight = 940
  ClientWidth = 1942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 192
  TextHeight = 38
  object PaintBox: TPaintBox
    Left = 0
    Top = 176
    Width = 1942
    Height = 672
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    OnPaint = PaintBoxPaint
    ExplicitTop = 408
    ExplicitWidth = 2054
    ExplicitHeight = 458
  end
  object Splitter: TSplitter
    Left = 0
    Top = 144
    Width = 1942
    Height = 12
    Cursor = crVSplit
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Beveled = True
    Color = clHighlight
    ParentColor = False
    ExplicitTop = 376
    ExplicitWidth = 2054
  end
  object sendGB: TGroupBox
    Left = 0
    Top = 44
    Width = 1942
    Height = 100
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Commande '#224' envoyer '#224' Arduino'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Button2: TButton
      Tag = 1
      Left = 444
      Top = 44
      Width = 180
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Tag = 2
      Left = 636
      Top = 44
      Width = 180
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button4: TButton
      Tag = 3
      Left = 828
      Top = 44
      Width = 180
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1942
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 42
    ButtonWidth = 188
    DrawingStyle = dsGradient
    EdgeBorders = [ebBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    List = True
    ParentFont = False
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    object ToolsBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Options Wifi, mode d'#39'acquisition ...'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Configuration'
      ImageIndex = 0
      ImageName = 'Item1'
      OnClick = ToolsBtnClick
    end
    object StartBtn: TToolButton
      Left = 188
      Top = 0
      Hint = 'Lancer l'#39'acquisition'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Acquisition'
      ImageIndex = 3
      ImageName = 'Item4'
      Style = tbsCheck
      OnClick = StartBtnClick
    end
    object StopBtn: TToolButton
      Left = 376
      Top = 0
      Hint = 'Arr'#234't de l'#39'acquisition'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Stop'
      ImageIndex = 1
      ImageName = 'Item2'
      OnClick = StopBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 564
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Traitements'
      ImageIndex = 2
      ImageName = 'Item3'
      OnClick = RegressiBtnClick
    end
    object RazBtn: TToolButton
      Left = 752
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#224'Z'
      ImageIndex = 6
      ImageName = 'Item7'
      OnClick = RazBtnClick
    end
    object ConnectBtn: TToolButton
      Left = 940
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Connexion'
      ImageIndex = 7
      ImageName = 'Item8'
      OnClick = ConnectBtnClick
    end
    object HelpBtn: TToolButton
      Left = 1128
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Aide'
      ImageIndex = 5
      ImageName = 'Item6'
      OnClick = HelpBtnClick
    end
    object ExitBtn: TToolButton
      Left = 1316
      Top = 0
      Caption = 'Quitter'
      ImageIndex = 4
      ImageName = 'Item5'
      OnClick = ExitBtnClick
    end
  end
  object PanelVoies: TPanel
    Left = 0
    Top = 848
    Width = 1942
    Height = 92
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 2
    object GroupBox2: TGroupBox
      Tag = 6
      Left = 1
      Top = 1
      Width = 300
      Height = 90
      Cursor = crHandPoint
      HelpType = htKeyword
      HelpKeyword = 'Voie_Ana'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object Label2: TLabel
        Tag = 6
        Left = 2
        Top = 40
        Width = 96
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'voieF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox3: TGroupBox
      Tag = 2
      Left = 301
      Top = 1
      Width = 300
      Height = 90
      Cursor = crHandPoint
      HelpType = htKeyword
      HelpKeyword = 'Voie_Ana'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      object Label1: TLabel
        Tag = 6
        Left = 2
        Top = 40
        Width = 100
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'voieB'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox4: TGroupBox
      Tag = 1
      Left = 601
      Top = 1
      Width = 300
      Height = 90
      Cursor = crHandPoint
      HelpType = htKeyword
      HelpKeyword = 'Voie_Ana'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      object Label3: TLabel
        Tag = 1
        Left = 2
        Top = 40
        Width = 103
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'voieA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox5: TGroupBox
      Tag = 4
      Left = 901
      Top = 1
      Width = 300
      Height = 90
      Cursor = crHandPoint
      HelpType = htKeyword
      HelpKeyword = 'Voie_Ana'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 3
      object Label4: TLabel
        Tag = 6
        Left = 2
        Top = 40
        Width = 104
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'voieD'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox6: TGroupBox
      Tag = 3
      Left = 1201
      Top = 1
      Width = 300
      Height = 90
      Cursor = crHandPoint
      HelpType = htKeyword
      HelpKeyword = 'Voie_Ana'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 4
      object Label5: TLabel
        Tag = 6
        Left = 2
        Top = 40
        Width = 100
        Height = 51
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = 'voieC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 156
    Width = 1942
    Height = 20
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 3
    OnDocumentComplete = WebBrowser1DocumentComplete
    ExplicitWidth = 2012
    ControlData = {
      4C00000014650000090100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object TimerAcq: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerAcqTimer
    Left = 952
    Top = 496
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
              0D0000007B4944415478DADDD2810AC020080450FDF3FBF356419072E6A06031
              2118D55E979B162972B27480DA1E37AB5A6A402C36F7B5B23853F5B7607D5118
              7E07388A5DFD53B0CD03E8631BC44837832CE9553D0CBCF7579EA1C55F938308
              1086A6201CC012F9E41484D8D3196652CDFB3C18F526FA10690F65B30C78AA1E
              E7B5A6ED81EC4E460000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
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
        Name = 'Item7'
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
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000784944415478DABDD3E10AC020080460EFCDEBC9DD84052223B51DBB
              9F8B3E2E6B50518140E520F75EC46F88E018638BF8F51298C5C085A6A0EADE05
              D0076DD3EBBC9EB5333016C55790D9903AC34ADAE0AE25F5C80B5B2D53B08A95
              C1CAEC5A20BD61F5C9B48E4CBD940CF428ED1D5AE69CDC3FC5E717F0024C26C7
              ED538DB2620000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000704944415478DAC5D4E10A8030080460EFCD7D73CBA09068753A6907
              FD18B18FCBD1606202814931FB7EC4357E01CDC63E0051D5E3A14006F350208B
              D1E057D2607BC337B034C3F643C9B46C399438BF750D1DF44D4F39DF95C07B4F
              CC82AD0D5B67C8240DC65F6C045E5FB4E4829D01375E8DC1ED79F85EFA000000
              0049454E44AE426082}
          end>
      end>
    Left = 728
    Top = 512
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
      end>
    ImageCollection = ImageCollection1
    Width = 20
    Height = 20
    Left = 380
    Top = 448
  end
end
