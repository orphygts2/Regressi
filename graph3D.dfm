object fgraphe3D: Tfgraphe3D
  Left = 298
  Top = 240
  Cursor = crCross
  HelpKeyword = 'Fen'#234'tre param'#232'tres'
  HelpContext = 105
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Graphe des param'#232'tres'
  ClientHeight = 1160
  ClientWidth = 2180
  Color = clBtnFace
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
    0000000000000000000000000000077777777777777777777777777777700F77
    77777777777777777777777777700FF888888888888888888888888887700FF8
    88888888888888888888888887700FF888888888888888888888888887700FF8
    8FF88FF88FF88FF88FF88FF887700FF880F880F880F880F880F880F887700FF8
    88888888888888888888888887700FF888888888888888888888888887700FF8
    8FF88FF888888FF88888888887700FF880F8844F8888844F8888888887700FF8
    8888844F8888844F8888888887700FF888888880F8880880F888888887700FF8
    8FF888880FF088880FF8888887700FF880F88888844F8888844F888887700FF8
    88888888844F8888844F888887700FF888888888888888888880F88887700FF8
    8FF888888888888888880FF887700FF880F88888888888888888844F87700FF8
    88888888888888888888844F87700FF888888888888888888888888887700FF8
    8FF88888888888888888888887700FF880F88888888888888888888887700FF8
    88888888888888888888888887700FF888888888888888888888888887700FF8
    8FF88888888888888888888887700FF880F88888888888888888888887700FF8
    88888888888888888888888887700FFFFFFFFFFFFFFFFFFFFFFFFFFFF7700FFF
    FFFFFFFFFFFFFFFFFFFFFFFFFF70000000000000000000000000000000008000
    0001000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000080000001}
  KeyPreview = True
  Position = poDefault
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object PanelCourbe: TPanel
    Left = 0
    Top = 0
    Width = 2180
    Height = 1160
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    ExplicitWidth = 2166
    ExplicitHeight = 1159
    object PaintBox: TPaintBox
      Left = 0
      Top = 46
      Width = 2180
      Height = 1114
      Hint = '|Utiliser le clic droit pour ouvrir le menu local'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ParentColor = False
      PopupMenu = PopupMenuAxes
      OnMouseDown = FormMouseDown
      OnMouseMove = FormMouseMove
      OnPaint = PaintBoxPaint
      ExplicitTop = 96
      ExplicitHeight = 1064
    end
    object ToolBarGr: TToolBar
      Left = 0
      Top = 0
      Width = 2180
      Height = 46
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      BorderWidth = 1
      ButtonHeight = 42
      ButtonWidth = 147
      Color = clGradientInactiveCaption
      GradientEndColor = clSkyBlue
      HotTrackColor = clAqua
      Images = VirtualImageList1
      List = True
      GradientDrawingOptions = [gdoHotTrack]
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      ExplicitWidth = 2166
      object CurseurBtn: TToolButton
        Left = 0
        Top = 0
        Hint = 'Outils'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Titre'
        ImageIndex = 20
        ImageName = 'Item21'
      end
      object CordonneesBtn: TToolButton
        Left = 147
        Top = 0
        Hint = 'Coordonn'#233'es (Alt+C)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Axes'
        ImageIndex = 19
        ImageName = 'Item20'
        OnClick = CoordonneesItemClick
      end
      object ImprimeBtn: TToolButton
        Left = 294
        Top = 0
        Hint = 'Imprimer (Alt+I)|Imprimer le graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Imprimer'
        ImageIndex = 15
        ImageName = 'Item16'
        OnClick = ImprimeGrItemClick
      end
      object CopierBtn: TToolButton
        Left = 441
        Top = 0
        Hint = 'Copier graphe|Copier le graphe dans le presse-papiers'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Copier'
        ImageIndex = 16
        ImageName = 'Item17'
      end
    end
  end
  object EditBidon: TEdit
    Left = 992
    Top = 0
    Width = 0
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 1
  end
  object PopupMenuAxes: TPopupMenu
    Left = 280
    Top = 120
    object CoordonneesItem: TMenuItem
      Caption = '&Coordonn'#233'es'
      OnClick = CoordonneesItemClick
    end
    object SauveItem: TMenuItem
      Caption = 'Copier &graphe'
    end
    object ImprimeGrItem: TMenuItem
      Caption = '&Imprimer graphe'
      OnClick = ImprimeGrItemClick
    end
    object EnregistrerGrapheItem: TMenuItem
      Caption = 'Enregistrer graphe'
      OnClick = EnregistrerGrapheItemClick
    end
    object SupprReticule: TMenuItem
      Caption = 'Suppr. r'#233'ticule'
      GroupIndex = 1
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'EPS'
    Filter = 
      'Metafichier Windows|*.emf|JPEG|*.jpg|PNG|*.png|Bitmap|*.bmp|Post' +
      'script|*.eps'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 462
    Top = 248
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A64944415478DAD5D44B1680200805D0C7BE1BE6BA49F4F40143B19A
              C4C47EDE103C1283F165D01B90F27466A5D163D06294005E6EC0F22198663189
              5BF0496625960CC201BD2C778CF29B321AAC9631986183C9F455630D28934A2D
              24F54B96F55AC63EA6C01176FED4C75C50D75247AA16BC9DD06D8A054758A886
              32AE673331DCA3DE922D8E0076805EFDA2C810DCEFEDB3E90CBD683B1F688A45
              AFB59B59FAABF3F09FE006084BA9ED0E6EDCA50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000644944415478DACDD2B112C020080350F9FF8F56DCAA054D80EB3513
              03BC2187F4D65B65E477A028A18694803B96022D2C0C7A58083C613478C32810
              C16010C52090C1AE208B1DC108E68251CC0433D80BCC620B48BDC63CD3CCFDE7
              EC76F8390877589101F69B60ED1751BE360000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
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
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A34944415478DACD55491280300823FF7F347671AA0CABDA835C5049
              330930164C4C3B039D103DB568CF7081ADCC231508E701F016C221EC8C7F2AAC
              F510B7C93152C25C215A612031C94327590F27C16539218C155E871F1162F548
              2EF9A8188BEF7F27040AA5123D655B69D0C39784B6420DB6F7D0C0C93D5C5A2D
              2BCE62AFFEA330E50A61C9F20742A2EA0F9129E3EB8294423F4F8529CEB3ACDF
              A5650F8FDD57C001A03CB1EDE42E51040000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000714944415478DAE5D34B0E80300804D0E1DC75A9E746219A985869F9
              2C4C64C3AA2F0CA1C460541665C04D9E9FD5C0540236EDC00295E85B131E02B3
              B6821DF6B030F88685400B73810249B7B0697034950BF46026381BD1057AB107
              D8BBFC3478FDCD342811D75BC21418DDD730F23FC01DD6AD50EDB510D9BB0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004C4944415478DA63FCCFF09F819A8091AE0632B6306295FC5FF39F71
              9019580D15681D5606E20A2F6C06E20B573A1858CD401A68A5BB8183360CB181
              C1950EE96B208EF01A7803C9015437100024AF73ED0651A0450000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DABD94D10DC0200844612C9DAD9F9D4DC7B24242635B
              156AB5F72321FA725C889820C14CE1722052ABA27C0F878159D71EA219DA0412
              248400CE39AEA5A741CD0EA5A741BB0E79CCA2B6646A72F878D471A93A3C1D49
              864A966B1CB676CFAA127E02C9558C91D7E4CDE9BDAF0365E7AC30A08C2B79AE
              73383D43807D10B7FD00E46270ECFB3EAEFF60BFEA00E279C4ED2CAD7FCA0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006B4944415478DAE5D0C10E80200C03D0F5BBE508DF3D634023416607
              C683EE0A7BE90A159527075F0751961553608A4997106453F4840D81163600E6
              137B9813BCC71C208E4F346877C3A56B12EE68BDCCA7EB9C8CCB0E18CCE8B045
              27C11A65B1B7C1FCECC108D03F3F0457F0185FEDA5A7094D0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000009B4944415478DAADD5490E80200C05507A6E58CAB92B9350995B6063
              52E3CBE7A789800AD5CD031EB48F456D3488004FA483B7406740A0DCF3185429
              218484C7206086525236183FCCADC1BF43027EC3159C93E4EE9A02B8574EE59F
              83A57C7A452118536DE65F75B88F7513D69BCFC18620DD7C0E3601CBE68BC1D2
              A151B3B560243471405E8AC1DDBE7AEB55CF867B289D351D9E1C0FC3ED5FC00B
              50EBBBED100749980000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
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
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008D4944415478DAADD5310EC02008055038B78EF5DC54AC0E2A560119
              DA84C457F80E4502829B850CA6275188014D0013B9B283CC5D04CB13DD205410
              CA84EE9519231C3A3A705C51F8C407B6C60EEE2F419C793DA17C785ED308F6E1
              9BC0D3A994199E630713EAB00DA8C77E401B266618632C6FF282A1424D7181A7
              2B4A598FBDE5A5587B53869E62186FFF025EA93BAAEDB445AAD3000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000904944415478DABDD4C10E8020080660796E39E2739B1C70E6504259
              5C5ACE3EFFD2809A6A8A2CF8052C542A22F67B224A19331C81D08618988B1768
              734DF4050AA6A591D416DA417E80AFBB57FB32A783BB749E940B1094ADAF7001
              06240CFF86564AF72ECFE85C72D0DDE098466A4C6D2575FFCB309C000D3D6A0E
              3BF4B8DBACD0ABF6A5A1D7FD90D1B084EA02D1E00369169AED4B27EA9F000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000924944415478DABDD4C10E8020080660796E39E273931C7068985359
              5C5A669FFFD2004E9C220B7E010B1546C4764F442963862310EA900063C90275
              EE12ED40C5BC349A7A8536505E906B8FD5C706F0E74C403FDD1B5CA59C80E06C
              3DC305189030FC1B86EFF2888EA5077D1BB469B46CEA55D2ED7F19CC09F0D0A3
              E6F0851E779B197AD5BE3CF4BA1F0A1A96D05D201A7C0046F6A2ED7B2562CB00
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
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
        Name = 'Item15'
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
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DABD94D10DC0200844612C9DAD9F9D4DC7B24242635B
              156AB5F72321FA725C889820C14CE1722052ABA27C0F878159D71EA219DA0412
              248400CE39AEA5A741CD0EA5A741BB0E79CCA2B6646A72F878D471A93A3C1D49
              864A966B1CB676CFAA127E02C9558C91D7E4CDE9BDAF0365E7AC30A08C2B79AE
              73383D43807D10B7FD00E46270ECFB3EAEFF60BFEA00E279C4ED2CAD7FCA0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C44944415478DAED92C90103210845A1AC496B78D4DA2CCB008971DF
              921CE75F1C18792C820102FC532840946320FE8F5F0159C9C98868221BFD6CFD
              444B60820674D60532660AED0295A8F7430385623C3B400ED4D0D096DAB6BF02
              BE0105271A387B9B04DE07E6A398549980D9CCEA4749894E5A9E00B1AA4CC75B
              81ACB54086701B38EA3AF7CB167C80926124C3BB2781CE59FD6E2A23D3028B3D
              ACE7C2B72530C262F2DCD6A43910168A151251E1F7DEC3753DCA0A577A757003
              7F052E2FC101F0444F80E4E1ED4A750EF50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008F4944415478DAADD58B0AC0200805D0EEFF7FB4AB9860AFAB910D06
              4B7694960B52A4640E74B0DD50AF54B03F9DD11A10297ED250858A455017B4D8
              2E3E270880A8A0FC2016EE0A544C2B7DAAD0622C51780DD94B2C3E82064E053D
              8CA1CBC68E622734DC295194EF43C1FECF01B2B61E8869B6B5CD02B6C4C8AAD0
              603EC8862683DCF5F2ED18BF729F7983917D047C1AD199EDFFA7E8C200000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000884944415478DAC592D10E80200845E1FF3F9A0457422A91B2BA2FE8
              60E73200090832850CC4124AC454207F32A0810EAB994E7AC66120A8BC57FF00
              649867D4E71CA007931110C9206CCD04E8C31A9083ADED8075E3729D41A09DB3
              01B6A88B7F01B6CD0F0FFB7320E7CFF71D3ADCF24A8753E0CC3DAAE50E5F0177
              94023423D35BDED57536993A00C908A6EFAD6760450000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000634944415478DAD5924B0A002008449DFB1FDADA14D807B5146A36D1
              080F47051313085C5F5080B007D692F0C6BF026C062F213698D2A1AFB30F81EB
              19A674E8D32BC0FD8D1A66A84125FC32F2BCB097804A64DF0C0D4B493F9B532F
              0F1811B7032355002F3494EE3ADE47F40000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item21'
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
        Name = 'Item22'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AD4944415478DAAD92591284300844E973673EC773234974C4AC900C
              558A65A55F9A054C4C3A40073305D06220022149325680511B73D683FF084C6F
              6C03E902D2ADCFC0E3BA25E0FEF68436503974975854B4016CB748482CD78024
              FD143DF1D33356671C0ECB95D0CD9F03A343E5AE9E64BB250B3DECC316806398
              133887398036D81098E69716B5B52A35249F09F3C5B600B5B326D0536259A679
              28A37FA692ADEEEAF8CAF3A11770274A8727C0C4D2EE0AE3150F000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item23'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000744944415478DA63FCCFF09F819A80116420239002D28C6419003202
              0860FA079F8138BD8C6C0B5DC39090E5D4379081A1054FBAA961203528F0BA90
              9CB02518298C0CAD40CBAAA9E3C25103493310C401198A9137297521D50DA459
              18C2C4900DC4A70E6B1862072D0CB02C48B40BF12A20D1CB007D0C97EE3D746D
              190000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000924944415478DAADD541128020080550FEB96D99E7B6CC2C47819064
              2303CD8B701112255A19C820F2F1444ED19C7DBDE634F4CF2A6EF0CABB07B51C
              EC0B9C20093D3728AF8401BD3BEC3E39EEF1993B6CA155E4BB2C04984E016D50
              C51294AE1594A77280FA542C28EFD08E19269CC33EC0794C017D98B2C305E03B
              A11F63401DE376DDD7C44BF1D6861DFE890C63F52FE000CE4FAAED4E9098A400
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000994944415478DAE5D2C10E8020088061786E3DEA731BD2746094A676
              8A8B66EBDF37172648B073F0B3600C3179EFD5CB100238EF702A88B4A5E11DC0
              B922E65D7A1FCC31ADD2D24867593F12AFC1A2639525A533A44D2F2A82C01F4A
              A975A73DA912B260517A114AA9759FBD3B3585525A74D66A496F85DC83E7A8F5
              5BA9FF90133B84F5A1912E0965B4489785AD748BB095F66638383B3F0C1E73F7
              BEEDE4E0FF9B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item26'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000804944415478DACDD3D10E8020080550EEFF7F346993CD0411CA55BC
              F8801EEED80413D3CEC267208898CF63032858045D823D66F5C701011005E406
              427129503049FA28618FA57A7740AFFF0EB8C2BC7B0A8C62B3FB17308B59EF7C
              903159B0B35B01CD7405C4F0B47E1B05D6C13012AA8A24ECB035E8950C03E7FE
              72B6FE0F1EC8067AEDF9B9D2020000000049454E44AE426082}
          end>
      end>
    Left = 672
    Top = 472
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
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 296
    Top = 680
  end
end
