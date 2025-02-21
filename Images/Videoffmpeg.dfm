object ffmpegForm: TffmpegForm
  Left = 160
  Top = 208
  HelpContext = 51
  Caption = ' '
  ClientHeight = 941
  ClientWidth = 2502
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 192
  TextHeight = 36
  object GridSplitter: TSplitter
    Left = 2116
    Top = 185
    Width = 16
    Height = 718
    Hint = '|D'#233'placer pour changer la taille du tableau'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    Beveled = True
    Color = clHighlight
    MinSize = 50
    ParentColor = False
    ResizeStyle = rsLine
    ExplicitLeft = 2110
    ExplicitTop = 206
  end
  object PanelMediaPlayer: TPanel
    Left = 0
    Top = 0
    Width = 2502
    Height = 88
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 2
    object TempsLabel: TLabel
      Left = 320
      Top = 16
      Width = 91
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Position'
    end
    object PlayBtn: TSpeedButton
      Left = 59
      Top = 1
      Width = 58
      Height = 86
      Hint = 'Jouer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 30
      ImageName = 'vcr_run'
      Images = VirtualImageList1
      Flat = True
      OnClick = PlayBtnClick
      ExplicitLeft = 60
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object StopBtn: TSpeedButton
      Left = 117
      Top = 1
      Width = 58
      Height = 86
      Hint = 'Stop'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 29
      ImageName = 'Item30'
      Images = VirtualImageList1
      Flat = True
      OnClick = StopBtnClick
      ExplicitLeft = 118
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object SuivantBtn: TSpeedButton
      Left = 233
      Top = 1
      Width = 58
      Height = 86
      Hint = 'Avance d'#39'une image'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 33
      ImageName = 'vcrav1'
      Images = VirtualImageList1
      Flat = True
      OnClick = SuivantBtnClick
      ExplicitLeft = 234
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object Image1: TImage
      Left = 2417
      Top = 1
      Width = 84
      Height = 86
      Hint = 'Utilise ffmpeg'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
        00190806000000C4E98563000000017352474200AECE1CE90000000970485973
        00000E7500000E7501B9635132000001CB69545874584D4C3A636F6D2E61646F
        62652E786D7000000000003C783A786D706D65746120786D6C6E733A783D2261
        646F62653A6E733A6D6574612F2220783A786D70746B3D22584D5020436F7265
        20352E342E30223E0A2020203C7264663A52444620786D6C6E733A7264663D22
        687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D726466
        2D73796E7461782D6E7323223E0A2020202020203C7264663A44657363726970
        74696F6E207264663A61626F75743D22220A202020202020202020202020786D
        6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F786170
        2F312E302F220A202020202020202020202020786D6C6E733A746966663D2268
        7474703A2F2F6E732E61646F62652E636F6D2F746966662F312E302F223E0A20
        20202020202020203C786D703A43726561746F72546F6F6C3E7777772E696E6B
        73636170652E6F72673C2F786D703A43726561746F72546F6F6C3E0A20202020
        20202020203C746966663A4F7269656E746174696F6E3E313C2F746966663A4F
        7269656E746174696F6E3E0A2020202020203C2F7264663A4465736372697074
        696F6E3E0A2020203C2F7264663A5244463E0A3C2F783A786D706D6574613E0A
        18CB55580000053E4944415478DA95565B6F545514DE97734E6798B652101415
        0998B648110502D376660C0F86F0E0833E9450CBFD5244D0A4033F60487C834E
        0DA242B9A380D898F8A2099A98DA4E99162C974049A0B18948E452B0B6D33297
        73CEDE7EFB7466E8652A3A939369F75E677DEB5BDFDA6B6D4AC67F688E35F91F
        ED72DA8F360C1186474CF01AC5573ED52EC7FEB86896859669F8D1EE4C713B0E
        5F2A88D3E60DCD898C7DD53755AC696593EDD81E5BE6BA1373CB62FCDDAD6CFF
        8A2B7F5673A8D91ACF241DA577AFBF967012A4D259E1443A91EBD8ECA6C2AE3D
        BFEBFCEFCADCBB2F308F59F280A4E479E514565A365C49A9A4724F475DA431C3
        88A6819CA8CB1BFCB75C53DDC5D690498439CC56D882E44DCE23A9BF933BA275
        91CFBC7B020B28173F7297F61CA580D718B1933691022E6CA07934620E9AB7DA
        8391D20C113A32871561FFBB88AE1A90F9805E418434E1CCB092F6AF1D036F79
        2BF2CF9548C67F613A9B2EE110FBAD08B31B4E56E09D175436004CA52D56B5EF
        6C3B4B4221F80D89AC26555555BCA96938D715E1C039802DE706A24C5897F1C2
        22DF27BE525BD0F394D3298C633D657F8E68B79737BC59031A47E1DB70722264
        4D3418393D52FCD19AECF316524BFF81E7719F5A06832B1DC1C842056009DACE
        389DCC86D3330C501F58CF747A4C4AE9245C0852DD116CFD3A1DB0C8C8301AA4
        DE7F5AF768D58892484B5E6B1F88BC5139A972B6D0D8058781E6303B0C665BBC
        F595AB99C6BF74DCC08B1474757B5DCBA925615F996740BF99AE3047EFACF065
        A132A3A0B0E82A58CC1549BBA7572B985764C75EE4845EA08C4C1D0D100000C9
        02088BACE9D8D9FA95B7C1BF5F33F8763B691D680FB66DCB049F05597C70B1AE
        0FB92FEA85C6EBA958EA2461EC632A64D40170341078B1755B45BD7F2DD1E889
        EC994E6B505EEF3BC4DDDA665510C212DDB1FEBEF95DA1AE54A6BA9E803C765F
        E279DA7C2B617561B110D1CF449A94368DD0662B225DC3183D393645E5617F23
        AA708B1DB752A83C03657FDD9C145FD4B9B5D31C07620CB92FA3EECB5434EACB
        0D9E15D91BF66F00E851228629489BA24C5BCE82C1313058AFCE8ACA8D0A4A5A
        A22BE5892FCC09A20FBA2F2192F9A09BE22E6E8884DD18CDC9408041DB292745
        AE6C8A6E633BA6B9781900733371847FA6E83AA22D56D1406447BCF2B06F1DD5
        F8718781B234E57BD15D9133D0E60873F18D700E56F2218EFE1249ACDD46BEB1
        D68CA5AE9A9EF8929120D91286C32FA0C9FBA88EFD00F87042060D814338A89B
        1D00411EA1E0977AFAB53F1385D60D54E76C68787370A06FC148E133E745AA0E
        3C5468965E0CB6758D2DD32C40D87F188E366518D8947801701B0097A0E76BAA
        4B588FADD3D0B16664093F9917BB4354F59A8A06FF46C2D911923EC9687C2BA3
        3B234DE5E1C0719EC7D6A9A689C37ADFE464E9745A70BFCF8A5D66067F55858C
        83FC93D91F7FA733D4F9783C48B649FA364183C3CA11B693C0A9C141FB360BE0
        3020F7EC3CBAF459DBF3A0CF1CB88214CF55EBD0ED7B14CADB637BE1A82EEC0D
        07563146CEA06DABBEC3F0DCC3F3339E5728A35E3C6A043CC06660D6CC19BFFD
        71E7EE05A46E11AA29091B43D922A81893F4447457EB77B9E749D87F53CFD74B
        9053A21CAA2A431A54DD13D504ED847D0F2BCBA3C1966B60BCC328727D9AEA4F
        3976CA03CA1FF344278987F16E685292739E5436F86BD149EB006B66F2A94611
        1D9E7C8FA4463FE8F8A8F5867AA5726FE52C9BB283F0F0727A3A2A7B356594ED
        BEB19371D407339CF7F4F5B0CCFF05770B642FE965E9722463DBB83A5FD3C834
        119B11737CCD299A23327780DC1789FF730B19797BF9373B92FBEE34D17D4A4E
        B0FED47BDA3FB7DDFE40200C4E610000000049454E44AE426082}
      Proportional = True
      Stretch = True
      ExplicitLeft = 2410
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object RewindBtn: TSpeedButton
      Left = 1
      Top = 1
      Width = 58
      Height = 86
      Hint = 'Rembobiner'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 31
      ImageName = 'TOP'
      Images = VirtualImageList1
      Flat = True
      OnClick = RewindBtnClick
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object PrecedentBtn: TSpeedButton
      Left = 175
      Top = 1
      Width = 58
      Height = 86
      Hint = 'Recul d'#39'une image'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 32
      ImageName = 'vcrarr1'
      Images = VirtualImageList1
      Flat = True
      OnClick = PrecedentBtnClick
      ExplicitLeft = 176
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object rotateMoinsBtn: TSpeedButton
      Tag = -1
      Left = 1936
      Top = 16
      Width = 60
      Height = 60
      Hint = 'Rotation '#224' gauche de 90'#176
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Flat = True
      Glyph.Data = {
        9E000000424D9E000000000000003E0000002800000018000000180000000100
        01000000000060000000D70D0000D70D00000200000002000000FFFFFF000000
        000000000000007F000001FFC0000380F000070038000C000C0000000C000000
        06000000060000000300000003000000030000000300100003003C0002007E00
        06007F000600F8000E00CC000C00070038000380F00001FFC000007F00000000
        0000}
      OnClick = rotateMoinsBtnClick
    end
    object RotatePlusBtn: TSpeedButton
      Tag = 1
      Left = 2000
      Top = 16
      Width = 60
      Height = 60
      Hint = 'Rotation '#224' droite de 90'#176
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Flat = True
      Glyph.Data = {
        9E000000424D9E000000000000003E0000002800000018000000180000000100
        01000000000060000000D70D0000D70D00000200000002000000FFFFFF000000
        00000000000000FE000003FF80000F01C0001C00600030003000300020006000
        000060000000C0000000C0000000C0000000C0000000C0000800C0003C006000
        7E006000DE0030003B00300033001C00E0000F01C00003FF800000FE00000000
        0000}
      OnClick = rotateMoinsBtnClick
    end
    object Image2: TImage
      Left = 2173
      Top = 1
      Width = 84
      Height = 86
      Hint = 
        'En cas de probl'#232'me de lecture de video, cliquer sur bouton pour ' +
        'changer de m'#233'thode'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Picture.Data = {
        07544269746D617066010000424D660100000000000076000000280000001400
        0000140000000100040000000000F00000000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00333333333333333333330000333333333333333333330000333333333333
        3333333300003333333333333333333300003333003333333300333300003330
        00033333300003330000330000000000000000330000330F77FFFF7FFF77F033
        0000330FFF9FFF7FFFFF80330000330FF999FF70000003330000330FFF9FFF07
        777033330000330FFFFFFF077703333300003380000000000033333300003333
        3333393999393333000033333333333393333333000033333333339333933333
        0000333333333333933333330000333333333333333333330000333333333333
        333333330000333333333333333333330000}
      Proportional = True
      Stretch = True
      Transparent = True
      OnClick = Image2Click
      ExplicitLeft = 2166
      ExplicitTop = 2
      ExplicitHeight = 84
    end
    object GroupBox1: TGroupBox
      Left = 600
      Top = 0
      Width = 640
      Height = 84
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axes et '#233'chelle'
      Padding.Left = 10
      Padding.Right = 10
      TabOrder = 0
      object TraceEchCB: TCheckBox
        Left = 12
        Top = 38
        Width = 140
        Height = 44
        Hint = '|Trac'#233' des axes et de l'#39#233'chelle'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Caption = 'visibles'
        TabOrder = 0
        OnClick = CouleurAxeCBChange
      end
      object CouleurAxeCB: TColorBox
        Left = 552
        Top = 38
        Width = 76
        Height = 44
        Hint = '|Couleur des axes et de l'#39#233'chelle'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alRight
        Style = [cbStandardColors]
        ItemHeight = 32
        TabOrder = 3
        OnChange = CouleurAxeCBChange
        ExplicitHeight = 38
      end
      object altitudeCB: TCheckBox
        Left = 382
        Top = 38
        Width = 170
        Height = 44
        Hint = 'Orientation des axes'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alRight
        Caption = 'sens trigo'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = altitudeCBClick
      end
      object origineMobileCB: TCheckBox
        Left = 152
        Top = 38
        Width = 210
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Caption = 'origine mobile'
        TabOrder = 1
        OnClick = OrigineItemClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1260
      Top = 0
      Width = 420
      Height = 84
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Points'
      Padding.Left = 10
      Padding.Right = 10
      TabOrder = 1
      object TracePointsCB: TCheckBox
        Left = 12
        Top = 38
        Width = 140
        Height = 44
        Hint = 'Trac'#233' des points d'#39'acquisition'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Caption = 'visibles'
        TabOrder = 0
        OnClick = CouleurAxeCBChange
      end
      object CouleurPointsCB: TColorBox
        Left = 332
        Top = 38
        Width = 76
        Height = 44
        Hint = '|Couleur du prochain point '#224' acqu'#233'rir'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alRight
        Style = [cbStandardColors]
        ItemHeight = 32
        TabOrder = 2
        OnChange = CouleurPointsCBChange
        ExplicitHeight = 38
      end
      object EtiquetteCB: TCheckBox
        Left = 152
        Top = 38
        Width = 150
        Height = 44
        Hint = 'Num'#233'ro des point d'#39'acquisition sur le graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Caption = #233'tiquette'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = CouleurAxeCBChange
      end
    end
    object MesureAutoCB: TCheckBox
      Left = 1700
      Top = 32
      Width = 200
      Height = 42
      Hint = 
        '|La cible doit '#234'tre constrast'#233'e et les poistions successives dis' +
        'tantes de moins d'#39'un dixi'#232'me de la taille de la video.'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Mesures auto'
      TabOrder = 2
      OnClick = CouleurAxeCBChange
    end
    object MethodeRG: TRadioGroup
      Left = 2257
      Top = 1
      Width = 160
      Height = 86
      Hint = 'M'#233'thodes :  1= ffmpeg.preview ; 2=ffmeg.probe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Caption = 'M'#233'thode'
      Color = clWhite
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        '1'
        '2')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 3
    end
  end
  object ToolBarBoutons: TToolBar
    Left = 0
    Top = 139
    Width = 2502
    Height = 46
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 42
    ButtonWidth = 132
    DoubleBuffered = True
    EdgeBorders = [ebTop, ebBottom]
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    List = True
    ParentDoubleBuffered = False
    ShowCaptions = True
    TabOrder = 0
    Transparent = False
    Wrapable = False
    object CaptureBtn: TToolButton
      Left = 0
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Webcam'
      ImageIndex = 9
      ImageName = 'Item10'
      OnClick = CaptureBtnClick
    end
    object OpenBtn: TToolButton
      Left = 132
      Top = 0
      Hint = '|Ouverture d'#39'un fichier video'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Ouvrir'
      ImageIndex = 3
      ImageName = 'Item4'
      OnClick = OpenFileBtnClick
    end
    object Label1: TLabel
      Left = 238
      Top = 0
      Width = 64
      Height = 36
      Hint = 'Prendre une image sur N'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = ' 1/N  '
    end
    object NimagesSE: TSpinEdit
      Left = 302
      Top = 0
      Width = 80
      Height = 47
      Hint = 'Prendre une image sur N'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditorEnabled = False
      MaxValue = 60
      MinValue = 1
      ParentColor = True
      TabOrder = 0
      Value = 1
    end
    object MesureBtn: TToolButton
      Left = 382
      Top = 0
      Hint = '|D'#233'but des mesures'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Mesurer'
      ImageIndex = 8
      ImageName = 'Item9'
      Style = tbsCheck
      OnClick = MesureBtnClick
    end
    object Label2: TLabel
      Left = 512
      Top = 0
      Width = 111
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '  Loupe x '
    end
    object zoomUD: TSpinEdit
      Left = 623
      Top = 0
      Width = 100
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditorEnabled = False
      MaxValue = 5
      MinValue = 1
      ParentColor = True
      TabOrder = 2
      Value = 1
      OnChange = zoomUDChange
    end
    object UndoBtn: TToolButton
      Left = 723
      Top = 0
      Hint = '|Annuler le dernier point'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'D'#233'faire'
      ImageIndex = 0
      ImageName = 'Item1'
      OnClick = UndoBtnClick
    end
    object RazBtn: TToolButton
      Left = 840
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'R'#224'Z'
      ImageIndex = 22
      ImageName = 'Item23'
      OnClick = RazBtnClick
    end
    object RazAxes: TToolButton
      Left = 919
      Top = 0
      Hint = 'Axes parall'#232'les aux c'#244't'#233's de la video'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#224'Z axes'
      ImageIndex = 16
      ImageName = 'Item17'
      PopupMenu = EchelleMenu
      OnClick = RazAxesClick
    end
    object ChronoPhotoBtn: TToolButton
      Left = 1051
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = 'Chrono'
      ImageIndex = 14
      ImageName = 'Item15'
      Style = tbsCheck
      OnClick = ChronoPhotoBtnClick
    end
    object NchronoSE: TSpinEdit
      Left = 1171
      Top = 0
      Width = 100
      Height = 47
      Hint = 'Chronophoto avec une image sur N'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditorEnabled = False
      MaxValue = 9
      MinValue = 1
      ParentColor = True
      TabOrder = 1
      Value = 1
    end
    object OrigineTempsBtn: TToolButton
      Left = 1271
      Top = 0
      Hint = '|Fixe l'#39'origine des temps en cliquant sur le point correspondant'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Origine'
      ImageIndex = 15
      ImageName = 'Item16'
      OnClick = OrigineTempsBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 1403
      Top = 0
      Hint = '|Traitement des donn'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = '&Traiter'
      ImageIndex = 25
      ImageName = 'Item26'
      OnClick = RegressiBtnClick
    end
    object ExitBtn: TToolButton
      Left = 1510
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      Caption = '&Quitter'
      ImageIndex = 20
      ImageName = 'Item21'
      OnClick = ExitBtnClick
    end
  end
  object ToolBarParam: TToolBar
    Left = 0
    Top = 88
    Width = 2502
    Height = 51
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 47
    ButtonWidth = 54
    Color = clBtnFace
    EdgeBorders = [ebTop, ebBottom]
    ParentColor = False
    TabOrder = 1
    object NbreSE: TSpinEdit
      Left = 0
      Top = 0
      Width = 100
      Height = 47
      Hint = '|nombre de points '#224' enregistrer par image'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditorEnabled = False
      MaxValue = 5
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object LabelNbreSE: TLabel
      Left = 100
      Top = 0
      Width = 170
      Height = 47
      Hint = '|nombre de points '#224' enregistrer par image'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Alignment = taCenter
      AutoSize = False
      Caption = ' points/image '
    end
    object LabelIncertitude: TLabel
      Left = 270
      Top = 0
      Width = 150
      Height = 47
      Hint = 'Incertitude|Incertitude en pixels (0 si pas d'#39'incertitude)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Alignment = taRightJustify
      AutoSize = False
      Caption = ' Incertitude '
    end
    object IncertitudeSE: TSpinEdit
      Left = 420
      Top = 0
      Width = 100
      Height = 47
      Hint = 'Incertitude|Incertitude en pixels (0 si pas d'#39'incertitude)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      EditorEnabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 8
      MinValue = 1
      ParentFont = False
      TabOrder = 2
      Value = 1
    end
    object LabelEchelle: TLabel
      Left = 520
      Top = 0
      Width = 150
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Alignment = taRightJustify
      AutoSize = False
      Caption = #201'chelle/m '
    end
    object EchelleEdit: TEdit
      Left = 670
      Top = 0
      Width = 150
      Height = 47
      Hint = 'Echelle|Longueur en m'#232'tre de l'#39#233'chelle'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = EchelleEditExit
      OnKeyPress = EchelleEditKeyPress
    end
    object LabelFPS: TLabel
      Left = 820
      Top = 0
      Width = 150
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Alignment = taCenter
      AutoSize = False
      Caption = 'LabelFPS'
    end
    object LabelAttente: TLabel
      Left = 970
      Top = 0
      Width = 559
      Height = 51
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
    end
    object VitesseLabel: TLabel
      Left = 1529
      Top = 0
      Width = 100
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = ' Vitesse '
    end
    object RalentiTB: TTrackBar
      Left = 1629
      Top = 0
      Width = 300
      Height = 47
      Hint = 'Ralenti'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Max = 50
      Min = 1
      Position = 10
      PositionToolTip = ptBottom
      TabOrder = 3
      ThumbLength = 40
    end
    object RollingShutterLabel: TLabel
      Left = 1929
      Top = 0
      Width = 483
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '  Correction obturateur d'#233'roulant '#916't/ms= '
    end
    object RollingShutterSE: TSpinEdit
      Left = 2412
      Top = 0
      Width = 100
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxValue = 50
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = RollingShutterSEChange
    end
    object RollingShutterBtn: TSpeedButton
      Left = 2512
      Top = 0
      Width = 47
      Height = 47
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 10
      ImageName = 'Item11'
      Images = VirtualImageList1
      OnClick = RollingShutterBtnClick
    end
  end
  object PanelVideo: TPanel
    Left = 0
    Top = 185
    Width = 2116
    Height = 718
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    AutoSize = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    OnResize = PanelVideoResize
    object imgPreview: TImage
      Left = 0
      Top = 0
      Width = 481
      Height = 369
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      OnMouseDown = PaintBoxMouseDown
      OnMouseMove = PaintBoxMouseMove
      OnMouseUp = PaintBoxMouseUp
    end
    object CibleLabel: TLabel
      Left = 1312
      Top = 192
      Width = 653
      Height = 71
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = ' Cliquer sur la cible '#224' suivre '
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -53
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 658
      Width = 2128
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      TabOrder = 0
      ExplicitTop = 657
      ExplicitWidth = 2114
      object FinBtn: TSpeedButton
        Left = 47
        Top = 1
        Width = 46
        Height = 58
        Hint = 'Fin de la chronophotographie'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333333333333333300003333
          3333333333333333000033333333333333333333000000000000000000000000
          0000333333333330000000030000333333333330000000330000333333333330
          0000033300003333333333300000333300003333333333300003333300003333
          3333333000333333000033333333333003333333000033333333333033333333
          0000333333333333333333330000333333333333333333330000333333333333
          3333333300003333333333333333333300003333333333333333333300003333
          33333333333333330000}
        OnClick = FinBtnClick
        ExplicitLeft = 48
        ExplicitTop = 2
        ExplicitHeight = 56
      end
      object DebutBtn: TSpeedButton
        Left = 1
        Top = 1
        Width = 46
        Height = 58
        Hint = 'D'#233'but de la chronophotographie'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alLeft
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333300003333333333333333333300003333333333333333333300003333
          3333333333333333000033333333333333333333000030000000000000000000
          0000330000000033333333330000333000000033333333330000333300000033
          3333333300003333300000333333333300003333330000333333333300003333
          3330003333333333000033333333003333333333000033333333303333333333
          0000333333333333333333330000333333333333333333330000333333333333
          3333333300003333333333333333333300003333333333333333333300003333
          33333333333333330000}
        OnClick = DebutBtnClick
        ExplicitLeft = 2
        ExplicitTop = 2
        ExplicitHeight = 56
      end
      object TrackBar: TTrackBar
        Left = 93
        Top = 1
        Width = 2034
        Height = 58
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Position = 1
        SelEnd = 4
        SelStart = 2
        TabOrder = 0
        ThumbLength = 32
        OnChange = TrackBarChange
        ExplicitWidth = 2020
      end
    end
  end
  object GridPanel: TPanel
    Left = 2132
    Top = 185
    Width = 370
    Height = 718
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    Color = clWindow
    ParentBackground = False
    TabOrder = 4
    object Grid: TStringGrid
      Left = 1
      Top = 1
      Width = 368
      Height = 717
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ColCount = 3
      DefaultColWidth = 100
      DefaultRowHeight = 48
      DrawingStyle = gdsClassic
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      ParentColor = True
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = GridDrawCell
      OnSelectCell = GridSelectCell
      ExplicitHeight = 716
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
  object Status: TStatusBar
    Left = 0
    Top = 903
    Width = 2502
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 100
      end>
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'avi'
    Filter = 
      'video|*.avi;*.mpg;*.mpeg;*.mp4;*.divx;*.mov;*.m4v;*.webm;*.wmv;*' +
      '.asf;*.mkv|liste d'#39'images|*.bmp;*.jpg;*.jpeg;*.png'
    Options = [ofHideReadOnly, ofNoChangeDir, ofAllowMultiSelect, ofEnableSizing]
    Left = 64
    Top = 680
  end
  object TimerPlayVideo: TTimer
    Enabled = False
    Interval = 5
    OnTimer = TimerPlayVideoTimer
    Left = 312
    Top = 194
  end
  object SaveDialog: TSaveDialog
    Left = 216
    Top = 672
  end
  object TimerMove: TTimer
    Interval = 200
    OnTimer = TimerMoveTimer
    Left = 920
    Top = 208
  end
  object TimerChrono: TTimer
    Enabled = False
    Interval = 30
    OnTimer = TimerChronoTimer
    Left = 664
    Top = 207
  end
  object TimerPlayImages: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerPlayImagesTimer
    Left = 480
    Top = 186
  end
  object EchelleMenu: TPopupMenu
    Left = 80
    Top = 471
    object Axeverslehautdroite: TMenuItem
      AutoCheck = True
      Caption = 'Axe vers le haut et la droite'
      Checked = True
      GroupIndex = 3
      ImageIndex = 16
      RadioItem = True
      OnClick = AxesClick
    end
    object Axeverslebasdroite: TMenuItem
      AutoCheck = True
      Caption = 'Axe vers le bas et la droite'
      GroupIndex = 3
      ImageIndex = 17
      RadioItem = True
      OnClick = AxesClick
    end
    object Axeverslehautgauche: TMenuItem
      AutoCheck = True
      Caption = 'Axe vers le haut et la gauche'
      GroupIndex = 3
      ImageIndex = 19
      RadioItem = True
      OnClick = AxesClick
    end
    object Axeverslebasgauche: TMenuItem
      AutoCheck = True
      Caption = 'Axe vers le bas et la gauche'
      GroupIndex = 3
      ImageIndex = 18
      RadioItem = True
      OnClick = AxesClick
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000874944415478DACD924B0EC0200844E15A5ECD2E3D9BD7B2B609462D
              FE3AA6291B12098F71800305DA19FC29906339D679ABC255E80D94262D7BEFC9
              184302BDDEA4591B9414E6CDAD2C436A480E86146A50C8C31CEE9C237B5886B7
              5C7B0ADFE110B87C263DA01467815D0F5BDB9B8D62CBBB6009882894AF3E806F
              3C547D45B73C04A2F17FE009E38E90ED8A3BA2560000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000904944415478DAB5D44B12802008005039B76BCF4DD14F4550546293
              C2F48621133060F00CD0C044A54EC4806006098B834E928236A005EBA1153883
              69E807AE60127A813B18477F06F19927405EBF7B5E2FF7049EB91AA422B05350
              E6A475F16C41FE9215543BB4225287E20CF97CB48EF90C55D0F32BDF09C7839D
              0B8EBFDE0A3ABC1C6650F3F555A23D70EA82DD890349109DED3710EE92000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A64944415478DAAD93E10E85200885E1B9F1A73CB789AD7B85416971
              3697867E1C15B141834CA100513E817A1C218C4B2C0076F91911B7A00AC8CCE3
              2711A9FE1F6A963AD025A0769A00BCFAA594099A06BC53C3970EBD0B3A5D2E03
              05A6CB693ACDDE6AAD4085D61CCA858053567D83B2F2AAAFE1FE135057D11B20
              B273741403E3E406F8834C630B8427ED009F3412EE6C791B98EE300D783B6903
              C8959B7D2956EAA564EA00117EFBEDC041F1220000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000874944415478DADDD3510AC0200806603D56DE1F3B96CB413156BA0A
              7BD9FF12447D5A110A08440615C43294002296A9D90208754F1B41B08111DD35
              30730E0113A5C32011758B98790F544C067DDEEF64E45D6C0AF4A2C59EE80F41
              EB3E2BEA82A3CD56C1DAA909EA8295E3BBE02E661E3914F4EEE90BEB409D187D
              3D2FEE4F59928C9C032373015260B7EDF95620C50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004C4944415478DA63FCCFF09F819A809118031981CA80EA18A96220C8
              30189B1843E9EFC2C16FE0300D43740D94F0E10612633B21003294362E1CFC91
              42C830E4301A7C2E1CFC06D2240C490100F5E875ED6543E42A0000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000364944415478DA63FCCFF09F819A8011DD40460688C07F30938168B9
              61602003432B16E5D50C83C785A35E1EF5F2A89747BDCC404D0000406C6AED5F
              5896B10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D84944415478DAB593C10EC4200844F5BBE5A8DFED82ED2408B8BA89
              4B0F5AA4AF1318734F3DDD8CFC17604B6D504B2A595679A744AEB8F2B30A7CEB
              8059521A52194213351191CB87C023552740AB0AC167193FFB0AE46D21031425
              5AA1C0B0B750A99B945B20860028D615D401773D44F10A7A0C8C2282FEACD0DA
              C542D1F3BDC27782BDF3A0D891161ADBBAC6B6718A00559812F8B4C979641B37
              8C0008681BEB30D7E3D30808C028EB4F074E8043656D7DF62127D03B1DC74056
              E987F20E04B152A98142C0F5DCFA107DB4500D6CEA664DC09B711DF801EAD9E7
              ED5CECAF860000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A94944415478DAADD44112C32008004078B71EE5DD14624DD4920C29
              7852467750546CAD312436BC036BAD6E440C1FC8C0F8980D20A78107C6B21431
              0E9E18914E8C810BD627FE0FFE607760912049B07C2B7BF52FD0C4DE8370A289
              60479341CD50DD7E4D6002C2196A057146C36718CBD0A8B207F4DCC357454905
              755FE06DC62BD91BF2E451A363506AC17D6CBDE1B183659E823B64E1FB0FA398
              B5EE31C3115B32949EF50B8DB51FE06D145AB03016D60000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000DB4944415478DAB5944B0E85200C45615932645B32C46D31C465F1AC
              C935B550C084D78980E570FB015B4C312BCDFE0D68AF618CD178EF8D73EE71A0
              35B210C2E559EC2760CEF986019C52BA4134A72FAC077E80473C0AD4713080B0
              91525521078C14D25EAC553904A497438A0607ED61B72A9003B8E1000ED054BF
              722895B5E6B491FBA2809BDBDA214B051C80FFAD36AB14CA24F70A80312FE273
              90CCE1A87979F1789B5521232C2DC4CF0AB5A2688A659B55393CF3790F70DD78
              9B4898AC32999AC399C760AA0F49E1EC63307553A4236CE6D952812B6C39F007
              4FE51DFC0E5A3CD10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D54944415478DAAD93411AC4100C85E35A5DBA164BAE65E95A06DF3C
              5F10A6537D8B06E5CF4BAACA39978C35CA3B3F45CA2A63FA0AEFA431F6AA1D50
              8A1C26459528D1DDCDA323B8EA1CEE80AB9277C92A1052799AE70DF0440D5860
              3146BAAE8B4EA0150858D12B40382CF1D465D7C3374A9F1C4280728D097086AF
              4F3D441F3998AFE3F0AA9206CC7FCCB20CADF532D11688835C21840E0857B780
              D6DA0E560E8D40EC83816387105A54E0473DFCEBA3989CAD5E84FC70CE37078F
              AE8DE470EC29D7EAD22F2F36EF93A4B1771350CC2624F9E5F003DA4930898A06
              E96E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DACDD3510AC020080050BD56F7A76B395BB4495A9904
              5B5F11FA304B242038B9F01B90380C097F02CAE4B2D719A8E296155AD008DE05
              51A41145C00EA35B29B97C433E58A143B0C74C740A767DAB2008A4A2EFB95DA9
              AB428D07AE2CD15661AC875334F2CA2608BA775BDF464C83FA87A14991011C92
              7386941247AEE7D9053E159E001BEAC1DCE0CE3A0E5E81A098ED0AEF2F760000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004D4944415478DA63FCCFF09F819A8011DD40460688C07F3093816839
              AC06C234C000BAC6813510A418A41059134C6C7018489348410DC7562CCAAB19
              C83690EA2E1CF5F2A89747BD8CCF404A0100B68D73EDDAAF9FE4000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000494944415478DA63FCCFF09F819A8011DD40460688C07F3093816839
              FA1BC8C0D08A457935C3E071E1A89747BD3CECBD0C1203F191E5606283C340D4
              B065C01B8E036720D9914229000074BC73ED1A19BAB40000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000744944415478DACDD24B0AC0200C04D0CCFD0F1DFBB31432D57C5CE8
              468CF01207A1A202811E3B64C13A11ED871BC573CE35809D7039587C32032B0D
              5E905D66D00B34453AA12F5B0A72B4007E23883E3B30E1EEA0B7C11064F519FA
              0B66237081913CA760F40B1527B49F7D0F7094A91B64758636B01776EDF03D25
              480000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006A4944415478DACDD44B0E8030080450E6DCED927BA30B135183423B
              3165D992C767014C4C98816F704F11030984FBCCA17F83A49171746621141719
              00DFD7E0C0B32A01BC261146AE82710C8C9C06DD631974CDCC83B7752D08D247
              7ED0AB83AA4A3BD9AD3724CE572D36E88E70ED62D741F60000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006D4944415478DAE593410EC0200804E1DD72C477536943626DABC470
              69E0047199ACA0C8CC0281810A2C54300256B94A7620028A80B8E0AAED6BEDBB
              014DE0018E5AAB1BEBDA32113D9A66E025F0CBE1782D3BDF062672B87A3E2EE0
              9BD0E3B21FC50FBF5E1260DBCE994400350EC410BAF1332EC3E7000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005B4944415478DA63FCCFF09F819A8011DD40460688C07F3093420361
              86C1003986D2CE409061200390BD0C131B1C06A27B9B2A91326A207D0DC4A58E
              6217A2AB071B889E43C805E0B44B1303A9EE65720CA459A46058447303290500
              71D55BEDA17769060000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000554944415478DA63FCCFF09F819A801197818C0C1089FF60E6A88178
              E4297621BA3AB08130414A01C850DA1848752F936320CD220543DFA8816083C0
              D18F64204C6C701888EC5D1820C5DBF43110D950AAC532B90000994E5BEDAFC6
              3EC10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000584944415478DA63FCCFF09F819A80911C031919209AFE839943DE40
              7C8A4932901883883610A6805200B280360652DDCBC42A26CB4062C0A881E41B
              0832089C34900C84890D0E0391BD0B03E8DE1E7803910DA55A2CE30300B9215B
              ED2B6E002B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000594944415478DAEDD2410A0020080440FDFFA30D0B213C98999187F6
              1461034B220141663002228C47D48F87A060128DBE05196360AE2C7735405D3B
              E5533EB806ADE12DD003B941BDFDD1F4BDBC02A657F60E87404FEA83561A5199
              5BED4D90C7DD0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item21'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007E4944415478DADDD3D10A80200C05D0BBFFBE8FFB6F534152DB3450
              48BA4F817ADC564940C0CE4801253D2E265AD2803AD8CC7C6270A7C86FC17810
              167E065862B5FE2998305505C9753063C8E20D5A951E3543C77BDF720D0DBE9A
              394807B1D029C80EB02AEA2B3741E2598DF70BD76B26E8CDC67B11D31962310D
              B82B17ED95A6ED50EC32FF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item22'
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
        Name = 'Item23'
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
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BC4944415478DAED925B16C32008449995D99DC5A5D595110926BEA2
              86B69F9D9F9C005E61044C4CBF140408F90C14F3A0615E720360D4FD8D80093A
              07426B7175DA1CBD818E810946299E3BFD04D8C04E60F6F409B0B3A6B740BB9C
              8951BC32132F3668FE40DA6535321ADB7B5B6118B9395DDA0874EB96FCD40D10
              79EF69F31BA66B9339B8BA1D4D21712E3DE48981C7A8AC87A49352F27FE64CC0
              27E2FA9517C5B122843739E7AA780821C65E75872BE9047FE0B7C06511198016
              EDFD7CC9ED0B17EFA00000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
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
        Name = 'Item26'
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
        Name = 'Item27'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000494944415478DA63FCCFF09F819A8011DD40460688C07F3093816839
              FA1BC8C0D08845793DC3E071E1A89747BD3CECBD0C1203F191E5606283C340D4
              B065C01B8E036720D99142290000737C73ED83A776230000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Item28'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004D4944415478DA63FCCFF09F819A8011DD40460688C07F3093816839
              AC06C234C000BAC6813510A418A41059134C6C7018489348410DC7462CCAEB19
              C83690EA2E1CF5F2A89747BD8CCF404A0100B54D73ED211DF7AA000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item29'
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
      end
      item
        Name = 'Item30'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000554944415478DAEDD24B0AC030084551EFCECDCA5F1B324A493FA942
              29E44E858388C8649951412CAEEE000790103704A5F945811B90E7AB162F72F7
              8F40EAE8FC622C7081BF79EC369CEB127CDF108CD58199A5831B4FD8C0EDD0F8
              5EA00000000049454E44AE426082}
          end>
      end
      item
        Name = 'vcr_run'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF0000008000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000008000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000000000008000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF00000000000000
              8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF000000000000008000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF000000FF000000
              FF000000000000008000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF000000FF000000FF000000000000008000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF000000FF000000
              FF000000FF000000FF000000000000008000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF000000FF000000FF000000FF000000FF000000
              000000008000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF000000FF000000
              FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF000000FF000000FF000000FF000000FF000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF000000FF000000
              FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF000000FF000000
              FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000080000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080000000FF0000000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          end>
      end
      item
        Name = 'TOP'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
              8000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C0008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000808080008080800080808000808080008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000080808000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000808080008080800080808000808080000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              00000000000080808000C0C0C000C0C0C000C0C0C00080808000808080008080
              800080808000000000000000000000000000000000008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000080808000C0C0C0008080
              8000808080008080800080808000000000000000000000000000000000000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              0000000000008080800080808000808080008080800000000000000000000000
              000000000000000000000000000000000000000000008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000080808000808080000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              00000000000080808000C0C0C000000000000000000000000000000000000000
              000000000000000000000000000000000000000000008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000080808000C0C0C000C0C0
              C000C0C0C0000000000000000000000000000000000000000000000000000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
              000000000000000000000000000000000000000000008080800080808000C0C0
              C000C0C0C000C0C0C000C0C0C000000000000000000080808000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
              0000000000008080800080808000C0C0C000C0C0C000C0C0C000C0C0C0000000
              000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
          end>
      end
      item
        Name = 'vcrarr1'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
              000000000000FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FF000000FF000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00000000000000FFFF
              FF00FF00000000000000FF000000FFFFFF00FFFFFF00FFFFFF00000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FF00000000000000FFFFFF00FF0000000000000000000000FF000000FFFF
              FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FF0000000000
              00000000000000000000FF000000FFFFFF00FFFFFF00FFFFFF00000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
              0000FFFFFF00FF00000000000000000000000000000000000000FF000000FFFF
              FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FF00000000000000FFFFFF00FF00000000000000000000000000
              00000000000000000000FF000000FFFFFF00FFFFFF00FFFFFF00000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF0000000000
              0000FFFFFF00FF00000000000000000000000000000000000000FF000000FFFF
              FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FF0000000000
              00000000000000000000FF000000FFFFFF0000000000FFFFFF00000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FF00000000000000FFFFFF00FF0000000000000000000000FF000000FFFF
              FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00000000000000FFFF
              FF00FF00000000000000FF000000FFFFFF00FFFFFF0000000000000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FF000000FF000000FFFF
              FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00
              000000000000FFFFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          end>
      end
      item
        Name = 'vcrav1'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF0000000000FF00
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FF000000FF0000000080800000000000FF000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000000000000000FFFFFF00FFFFFF00FF00000000000000FF0000000080
              800000000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
              FF00FF0000000000000000000000FF0000000080800000000000FF000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000000000000000FFFFFF00FFFFFF00FF00000000000000000000000000
              0000FF0000000080800000000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
              FF00FF00000000000000000000000000000000000000FF000000008080000000
              0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000000000000000FFFFFF00FFFFFF00FF00000000000000000000000000
              00000000000000000000FF0000000080800000000000FF000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
              FF00FF00000000000000000000000000000000000000FF000000008080000000
              0000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
              FF000000000000000000FFFFFF00FFFFFF00FF00000000000000000000000000
              0000FF0000000080800000000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
              FF00FF0000000000000000000000FF0000000080800000000000FF000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000FFFFFF00FFFFFF00FF00000000000000FF0000000080
              800000000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
              FF00FF000000FF0000000080800000000000FF000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF0000000000FF00
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          end>
      end>
    Left = 1528
    Top = 559
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
        CollectionName = 'vcr_run'
        Name = 'vcr_run'
      end
      item
        CollectionIndex = 31
        CollectionName = 'TOP'
        Name = 'TOP'
      end
      item
        CollectionIndex = 32
        CollectionName = 'vcrarr1'
        Name = 'vcrarr1'
      end
      item
        CollectionIndex = 33
        CollectionName = 'vcrav1'
        Name = 'vcrav1'
      end>
    ImageCollection = ImageCollection1
    Width = 20
    Height = 20
    Left = 1024
    Top = 519
  end
end
