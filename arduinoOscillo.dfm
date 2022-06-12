object ArduinoOscilloForm: TArduinoOscilloForm
  Left = 0
  Top = 0
  HelpContext = 80
  Caption = 'Acquisition par Arduino pour Regressi'
  ClientHeight = 1006
  ClientWidth = 1730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 192
  TextHeight = 36
  object PaintBox: TPaintBox
    Left = 66
    Top = 270
    Width = 1664
    Height = 716
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    OnPaint = PaintBoxPaint
    ExplicitTop = 282
    ExplicitWidth = 1548
    ExplicitHeight = 564
  end
  object grid: TStringGrid
    Left = 0
    Top = 90
    Width = 1730
    Height = 180
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    ColCount = 4
    DefaultColWidth = 160
    DefaultRowHeight = 48
    FixedCols = 2
    RowCount = 3
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSizing, goEditing, goAlwaysShowEditor]
    TabOrder = 0
    OnDrawCell = gridDrawCell
    ExplicitWidth = 1614
    ColWidths = (
      160
      160
      160
      160)
    RowHeights = (
      48
      48
      48)
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1730
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AutoSize = True
    ButtonHeight = 42
    ButtonWidth = 177
    Caption = 'ToolBar'
    DrawingStyle = dsGradient
    EdgeBorders = [ebBottom]
    GradientEndColor = clSkyBlue
    HotTrackColor = clAqua
    Images = VirtualImageList1
    List = True
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    ExplicitWidth = 1614
    object ToolsBtn: TToolButton
      Left = 0
      Top = 0
      Hint = 'Options de la voie s'#233'rie'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Options'
      ImageIndex = 0
      ImageName = 'Item1'
      OnClick = ToolsBtnClick
    end
    object StartBtn: TToolButton
      Left = 177
      Top = 0
      Hint = 'Lancer l'#39'acquisition'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Acquisition'
      Enabled = False
      ImageIndex = 3
      ImageName = 'Item4'
      Style = tbsCheck
      OnClick = StartBtnClick
    end
    object RegressiBtn: TToolButton
      Left = 354
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
    object StopBtn: TToolButton
      Left = 531
      Top = 0
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Stop'
      Enabled = False
      ImageIndex = 7
      ImageName = 'Item8'
      OnClick = StopBtnClick
    end
    object HelpBtn: TToolButton
      Left = 708
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
  end
  object ParamToolBar: TToolBar
    Left = 0
    Top = 44
    Width = 1730
    Height = 46
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ButtonHeight = 12800
    ButtonWidth = 46
    Caption = 'ParamToolBar'
    Ctl3D = False
    EdgeInner = esNone
    EdgeOuter = esNone
    TabOrder = 2
    StyleElements = []
    Wrapable = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Width = 16
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object UneVoieRB: TRadioButton
      Left = 16
      Top = 0
      Width = 160
      Height = 12800
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '1 voie A0'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = UneVoieRBClick
    end
    object DeuxVoiesRB: TRadioButton
      Left = 176
      Top = 0
      Width = 200
      Height = 12800
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = '2 voies A0 A1'
      TabOrder = 1
      OnClick = UneVoieRBClick
    end
    object intervalle: TLabel
      Left = 376
      Top = 0
      Width = 208
      Height = 12800
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = '  Freq. d'#39#233'chant. : '
    end
    object FechList: TComboBox
      Left = 584
      Top = 6378
      Width = 168
      Height = 44
      Hint = 'Pour Arduino Uno, ne pas d'#233'passer 2 kHz'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoComplete = False
      AutoDropDown = True
      Style = csDropDownList
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '100 kHz'
      OnChange = FechSEClick
      Items.Strings = (
        '100 kHz'
        '50 kHz'
        '20 Khz'
        '10 kHz'
        '5 kHz'
        '2 kHz'
        '1 kHz'
        '500 Hz'
        '200 Hz'
        '100 Hz'
        '50 Hz'
        '20 Hz'
        '10 Hz')
    end
    object DureeLabel: TLabel
      Left = 752
      Top = 0
      Width = 200
      Height = 12800
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = False
      Caption = 'DureeLabel'
    end
    object SynchroCB: TComboBox
      Left = 952
      Top = 6378
      Width = 260
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 3
      Text = 'Seuil descendant'
      OnChange = SynchroLBClick
      Items.Strings = (
        'Relax'#233
        'Seuil montant'
        'Seuil descendant')
    end
    object SingleCB: TCheckBox
      Left = 1212
      Top = 0
      Width = 180
      Height = 12800
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Monocoup'
      TabOrder = 4
    end
  end
  object TriggerTB: TTrackBar
    Left = 0
    Top = 270
    Width = 66
    Height = 716
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    Ctl3D = True
    LineSize = 4
    Max = 1023
    Orientation = trVertical
    ParentCtl3D = False
    PageSize = 16
    Position = 512
    ShowSelRange = False
    TabOrder = 3
    ThumbLength = 40
    OnChange = TriggerTBChange
    ExplicitHeight = 576
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 986
    Width = 1730
    Height = 20
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Max = 200
    Position = 100
    TabOrder = 4
    ExplicitTop = 846
    ExplicitWidth = 1614
  end
  object VoieSerie: TApdComPort
    AutoOpen = False
    TraceSize = 64000
    TraceName = 'Arduino.TRC'
    LogSize = 64000
    LogName = 'Arduino.LOG'
    OnTriggerAvail = VoieSerieTriggerAvail
    OnTriggerData = VoieSerieTriggerData
    Left = 912
    Top = 384
  end
  object UdpClient: TIdUDPClient
    Host = '192.168.1.35'
    Port = 2390
    ReceiveTimeout = 1000
    Left = 592
    Top = 272
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
              0D000000904944415478DAB5D4DB0E8020080050F972E7975374531114957849
              619D3132010306CF000D4C54EA440C086690B038E8242968035AB01E5A813398
              867EE00A26A117B88371F467109F7902E4F5BBE7F5724FE099AB412A023B0565
              4E5A17CF16E42F5941B5432B227528CE90CF47EB98CF50053DBFF29D703CD8B9
              E0F8EBADA0C3CB6106355F5F25DA03A72ED89D380046109DEDFBD4739A000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000003E4944415478DAEDCDC10D00200843513A79EBE4681C8060F42009FF
              DE57B8B9BD0C0D160087C6F103458420A5BCE66B0F6BB01E48E6C1AD04E06D0D
              7E084EAFE253ED828BED200000000049454E44AE426082}
          end>
      end>
    Left = 496
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
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 284
    Top = 424
  end
end
