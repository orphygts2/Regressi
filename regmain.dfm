object FRegressiMain: TFRegressiMain
  Left = 171
  Top = 279
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Regressi'
  ClientHeight = 1610
  ClientWidth = 2022
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF77
    F77F77FF77FF77FF77FF77F77F77FF70F70F70FF70FF70FF70FF70F70F70FFFF
    2FFFFFFFFFFFFFFFFFFFFFFFFFFFFF7724FFFFFFFFFFFFFFFFFFFFFFFFFFFF70
    2FFFFCCFFCCFCCCCCFFCCCCCFFFFFFFF924FFCCFFCCFCCFFFFCCFFCCFFFFFF77
    F244FCCCCCFFCCFFFFCCFCCCFFFFFF70F24FFCCEECCFCCCCFFCCFFFFFFFFFFFF
    F2FFFCCEECCFCCFFFFCCFFCCFFFFFF77F924FCCCCCFFCCCCCFFCCCCFFFFFFF70
    FF244FFFFFFFFFFFFFFFFFFFFFFFFFFFFF24FFFFFFFFFFFFFFFFFFFFFFFFFF77
    FF2FFFFFFFFFFFFFFFFFFFFFFFFFFF70FF92FFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFF2FF4FFFFFFFFFFFFFFFFFFFFFFF77FFF29444FFFFFFFFFFFFFFFFFFFFFF70
    FFF2F94FFFFFFFFFFFFFFFFFFFFFFFFFFFF2FF9FFFFFFFFFFFFFFFFFFFFFFF77
    FFFF2FF9FFFFFFFFF4FFFFFFFFFFFF70FFFF2FF499FFFFFF444FFFFFFFFFFFFF
    FFFF2F444F999FFFF4FFFFFFF4FFFF77FFFF2FF4FFFF499999999999999FFF70
    FFFFF2FFFFF444FFFFFF4FFF444FFFFFFFFFF2FFFFFF4FFFFFF444FFF4FFFF77
    FFFFF2FFFFFFFFFFFFFF4FFFFFFFFF70FFFFF2FFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFF2FFFFFFFFFFFFFFFFFFFFFFF77FFFFFF2FFFFFFFFFFFFFFFFFFFFFFF70
    FFFFFF2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  Menu = MainMenu
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 38
  object PanelStatut: TPanel
    Left = 0
    Top = 0
    Width = 2022
    Height = 60
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    object GrandeursBtn: TSpeedButton
      Left = 168
      Top = 0
      Width = 200
      Height = 60
      Hint = 
        '|Fen'#234'tre des expressions des grandeurs et des tableaux de valeur' +
        's'
      HelpContext = 101
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Grandeurs'
      ImageIndex = 23
      ImageName = 'Item24'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      OnClick = GrandeursBtnClick
      ExplicitHeight = 80
    end
    object GrapheBtn: TSpeedButton
      Left = 368
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre graphique des variables (F5)'
      HelpContext = 102
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Graphe'
      ImageIndex = 9
      ImageName = 'Item10'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      OnClick = GrapheBtnClick
      ExplicitHeight = 80
    end
    object FourierBtn: TSpeedButton
      Left = 568
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre spectre de Fourier'
      HelpKeyword = 'Fen'#234'tre Fourier'
      HelpContext = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Fourier'
      ImageIndex = 8
      ImageName = 'Item9'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      OnClick = FourierBtnClick
      ExplicitHeight = 80
    end
    object StatistiqueBtn: TSpeedButton
      Left = 768
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre statistique'
      HelpKeyword = 'Fen'#234'tre statistique'
      HelpContext = 103
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Statistique'
      ImageIndex = 24
      ImageName = 'Item25'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      OnClick = StatistiqueBtnClick
      ExplicitHeight = 80
    end
    object GrapheConstBtn: TSpeedButton
      Left = 968
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre graphique des param'#232'tres'
      HelpKeyword = 'Fen'#234'tre param'#232'tres'
      HelpContext = 105
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Graphe param.'
      ImageIndex = 7
      ImageName = 'Item8'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      Visible = False
      OnClick = GrapheConstBtnClick
      ExplicitHeight = 80
    end
    object FocusAcquisitionBtn: TSpeedButton
      Left = 1168
      Top = 0
      Width = 200
      Height = 60
      Hint = 
        '|Basculer vers acquisition|Basculer vers le programme d'#39'acquisit' +
        'ion (Alt-Tab)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Acquisition'
      ImageIndex = 20
      ImageName = 'Item21'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      Visible = False
      OnClick = FocusAcquisitionBtnClick
      ExplicitHeight = 80
    end
    object EnregistreBtn: TSpeedButton
      Left = 0
      Top = 0
      Width = 56
      Height = 60
      Hint = 'Enregistrer|Enregistrer le fichier en cours'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 6
      ImageName = 'Item7'
      Images = VirtualImageList1
      Margin = 2
      OnClick = EnregistreBtnClick
      ExplicitHeight = 36
    end
    object OpenFileBtn: TSpeedButton
      Left = 56
      Top = 0
      Width = 56
      Height = 60
      Hint = 'Ouvrir un fichier'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 5
      ImageName = 'Item6'
      Images = VirtualImageList1
      Margin = 2
      OnClick = FileOpenItemClick
      ExplicitHeight = 36
    end
    object UndoBtn: TSpeedButton
      Left = 112
      Top = 0
      Width = 56
      Height = 60
      Hint = 'Annuler'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 21
      ImageName = 'Item22'
      Images = VirtualImageList1
      Margin = 2
      OnClick = RestaurerItemClick
      ExplicitHeight = 36
    end
    object graphe3DBtn: TSpeedButton
      Left = 1568
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre graphique des param'#232'tres'
      HelpKeyword = 'Fen'#234'tre param'#232'tres'
      HelpContext = 105
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Graphe 3D'
      Flat = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFF0000FFF888888886FFFFFFFF0000FFF8EFFFFFF88FFFFFFF
        0000FFF8FEFFFFF8F8FFFFFF0000FFF8FFEFFFF8FF8FFFFF0000FFF8FFF6EEE8
        EEE8FFFF0000FFF8FFFEFFF8FFF8FFFF0000FFF8FFFEFFF8FFF8FFFF0000FFF8
        88888888FFF8FFFF0000FFFF8FFEFFFF8FF8FFFF0000FFFFF8FEFFFFF8F8FFFF
        0000FFFFFF8EFFFFFF88FFFF0000FFFFFFF888888868FFFF0000FFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFF0000}
      Margin = 2
      Visible = False
      OnClick = graphe3DBtnClick
      ExplicitLeft = 1768
      ExplicitHeight = 80
    end
    object GrapheEulerBtn: TSpeedButton
      Left = 1368
      Top = 0
      Width = 200
      Height = 60
      Hint = '|Fen'#234'tre graphique des param'#232'tres'
      HelpKeyword = 'Fen'#234'tre param'#232'tres'
      HelpContext = 105
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      GroupIndex = 1
      Caption = 'Graphe Euler'
      ImageIndex = 7
      ImageName = 'Item8'
      Images = VirtualImageList1
      Flat = True
      Margin = 2
      OnClick = GrapheEulerBtnClick
      ExplicitLeft = 1568
      ExplicitHeight = 80
    end
  end
  object PanelPage: TPanel
    Left = 0
    Top = 60
    Width = 2022
    Height = 52
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Visible = False
    object PageDebutBtn: TSpeedButton
      Left = 1
      Top = 1
      Width = 40
      Height = 48
      Hint = 'Premi'#232're page'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C0333333C3300033C033333CC3300033C03333C0C3300033C0333C00C3
        300033C033C000C3300033C03C0000C3300033C0C00000C3300033C03C0000C3
        300033C033C000C3300033C0333C00C3300033C03333C0C3300033C033333CC3
        300033C0333333C330003333333333333000}
      OnClick = PageDebutBtnClick
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PagePrecBtn: TSpeedButton
      Left = 41
      Top = 1
      Width = 40
      Height = 48
      Hint = 'Page pr'#233'c'#233'dente F7'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033333333C33330003333333CC3333000333333C0C333300033333C00C333
        30003333C000C3333000333C0000C333300033C00000C3333000333C0000C333
        30003333C000C333300033333C00C3333000333333C0C33330003333333CC333
        300033333333C33330003333333333333000}
      OnClick = PagePrecClick
      ExplicitLeft = 42
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PageFinBtn: TSpeedButton
      Left = 201
      Top = 1
      Width = 40
      Height = 48
      Hint = 'Derni'#232're page'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C3333330C3300033CC333330C3300033C0C33330C3300033C00C3330C3
        300033C000C330C3300033C0000C30C3300033C00000C0C3300033C0000C30C3
        300033C000C330C3300033C00C3330C3300033C0C33330C3300033CC333330C3
        300033C3333330C330003333333333333000}
      OnClick = PageFinBtnClick
      ExplicitLeft = 202
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PagesBtn: TSpeedButton
      Left = 241
      Top = 1
      Width = 44
      Height = 48
      Hint = 'Choix des pages|Choix des pages '#224' superposer ou '#224' activer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 17
      ImageName = 'Item18'
      Images = VirtualImageList1
      OnClick = PageSelectItemClick
      ExplicitLeft = 242
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PageSuivBtn: TSpeedButton
      Left = 161
      Top = 1
      Width = 40
      Height = 48
      Hint = 'Page suivante F8'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C333333333300033CC33333333300033C0C3333333300033C00C333333
        300033C000C33333300033C0000C3333300033C00000C333300033C0000C3333
        300033C000C33333300033C00C333333300033C0C3333333300033CC33333333
        300033C33333333330003333333333333000}
      OnClick = PageSuivClick
      ExplicitLeft = 162
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PageAddBtn: TSpeedButton
      Left = 285
      Top = 1
      Width = 48
      Height = 48
      Hint = 'Ajouter une page'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      ImageIndex = 15
      ImageName = 'Item16'
      Images = VirtualImageList1
      OnClick = PageAddBtnClick
      ExplicitLeft = 286
      ExplicitTop = 2
      ExplicitHeight = 44
    end
    object PanelNumPage: TPanel
      Left = 81
      Top = 1
      Width = 80
      Height = 48
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWindow
      Enabled = False
      TabOrder = 0
    end
    object ConstHeader: TStatusBar
      Left = 333
      Top = 1
      Width = 194
      Height = 48
      Hint = 'clic=choix param.|Cliquer pour choisir les param'#232'tres affich'#233's'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Panels = <
        item
          Style = psOwnerDraw
          Text = 'ghhgnvnjvb,n'
          Width = 100
        end
        item
          Width = 100
        end>
      ParentFont = True
      UseSystemFont = False
      OnClick = ConstHeaderClick
    end
    object CommentaireEdit: TEdit
      Left = 527
      Top = 1
      Width = 1492
      Height = 48
      Hint = 'Commentaire|Commentaire de la page courante (modifiable)'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      AutoSelect = False
      TabOrder = 2
      OnChange = CommentaireEditChange
      ExplicitHeight = 44
    end
  end
  object CommPagePanel: TPanel
    Left = 0
    Top = 112
    Width = 2022
    Height = 48
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    AutoSize = True
    TabOrder = 2
    Visible = False
    object CommPageEdit: TEdit
      Left = 1
      Top = 1
      Width = 2020
      Height = 46
      Hint = 'Commentaire|Commentaire de la page '
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      TabOrder = 0
      OnChange = CommPageEditChange
    end
  end
  object MainMenu: TMainMenu
    Images = VirtualImageList1
    Left = 896
    Top = 171
    object MenuFile: TMenuItem
      Caption = '&Fichier'
      Hint = 'Quitter l'#39'application'
      OnClick = UpdateMenuItems
      object FileNewItem: TMenuItem
        Caption = 'Nouveau'
        Hint = 'Cr'#233'er un nouveau fichier'
        ImageIndex = 29
        ImageName = 'Item30'
        OnClick = FileNewItemClick
        object NewClavierItem: TMenuItem
          Caption = '&Clavier'
          HelpContext = 206
          Hint = 'Entr'#233'e des donn'#233'es au clavier'
          ImageIndex = 25
          ImageName = 'Item26'
          OnClick = NewClavierItemClick
        end
        object NewSimulationItem: TMenuItem
          Caption = '&Simulation'
          HelpContext = 207
          Hint = 'Utilisation de Regressi comme grapheur'
          OnClick = NewSimulationItemClick
        end
        object FileNewClipItem: TMenuItem
          Caption = 'Presse-Papiers'
          Hint = 'Cr'#233'ation d'#39'un fichier '#224' partir du presse-papiers'
          ImageIndex = 18
          ImageName = 'Item19'
          OnClick = FileNewClipItemClick
        end
        object VideoItem: TMenuItem
          Caption = 'Video'
          ImageIndex = 19
          ImageName = 'Item20'
          OnClick = VideoItemClick
        end
        object SonItem: TMenuItem
          Caption = 'Son'
          ImageIndex = 35
          ImageName = 'Item36'
          OnClick = SonItemClick
        end
        object OscilloArduinoItem: TMenuItem
          Caption = 'Oscillo Arduino/micro:bit'
          OnClick = OscilloArduinoItemClick
        end
        object ArduinoWifiItem: TMenuItem
          Caption = 'Arduino Wifi'
          OnClick = ArduinoWifiItemClick
        end
        object ArduinoWifiDirectItem: TMenuItem
          Caption = 'Arduino Wifi Direct'
          OnClick = ArduinoWifiDirectItemClick
        end
        object ArduinoItem: TMenuItem
          Caption = 'Arduino/micro:bit'
          OnClick = ArduinoItemClick
        end
        object FileBitmap: TMenuItem
          Caption = 'Image'
          object CourbesItem: TMenuItem
            Caption = 'Courbes'
            ImageIndex = 7
            ImageName = 'Item8'
            OnClick = CourbesItemClick
          end
          object FileNewChronophoto: TMenuItem
            Caption = 'Chronophotographie'
            ImageIndex = 38
            ImageName = 'Item39'
            OnClick = NumerisationItemClick
          end
          object FileNewIntensite: TMenuItem
            Caption = 'Intensit'#233' lumineuse'
            ImageIndex = 37
            ImageName = 'Item38'
            OnClick = ImageItemClick
          end
          object FileNewAngle: TMenuItem
            Caption = 'Angle, distance ...'
            OnClick = ImageItemClick
          end
        end
        object EphmridesIMCCE1: TMenuItem
          Caption = 'Eph'#233'm'#233'rides IMCCE'
          OnClick = EphmridesIMCCE1Click
        end
        object AcqSeparator: TMenuItem
          Caption = '-'
          Visible = False
        end
        object AcqItem1: TMenuItem
          Visible = False
          OnClick = AcqItemClick
        end
        object AcqItem2: TMenuItem
          Tag = 1
          Visible = False
          OnClick = AcqItemClick
        end
        object AcqItem3: TMenuItem
          Tag = 2
          Visible = False
          OnClick = AcqItemClick
        end
        object AcqItem4: TMenuItem
          Tag = 3
          Visible = False
          OnClick = AcqItemClick
        end
        object AcqItem5: TMenuItem
          Tag = 4
          OnClick = AcqItemClick
        end
        object AcqItem6: TMenuItem
          Tag = 5
          OnClick = AcqItemClick
        end
        object AcqItem7: TMenuItem
          Tag = 6
          OnClick = AcqItemClick
        end
        object Acqitem8: TMenuItem
          Tag = 7
          OnClick = AcqItemClick
        end
        object Acqitem9: TMenuItem
          Tag = 8
          OnClick = AcqItemClick
        end
        object Acqitem10: TMenuItem
          Tag = 9
          OnClick = AcqItemClick
        end
        object AcqItem11: TMenuItem
          Tag = 10
          OnClick = AcqItemClick
        end
        object AcqItem12: TMenuItem
          Tag = 11
          OnClick = AcqItemClick
        end
        object AcqItem13: TMenuItem
          Tag = 12
          OnClick = AcqItemClick
        end
      end
      object FileOpenItem: TMenuItem
        Caption = '&Ouvrir'
        HelpContext = 202
        Hint = 'Ouvrir un fichier existant'
        ImageIndex = 5
        ImageName = 'Item6'
        ShortCut = 114
        OnClick = FileOpenItemClick
      end
      object FileSaveItem: TMenuItem
        Caption = '&Enregistrer'
        Hint = '|Enregistrer le fichier en cours'
        ImageIndex = 6
        ImageName = 'Item7'
        ShortCut = 113
        OnClick = FileSaveItemClick
      end
      object FileSaveAsItem: TMenuItem
        Caption = 'Enregistrer sous..'
        HelpContext = 204
        Hint = 'Enregistrer le fichier en cours sous...'
        OnClick = FileSaveAsItemClick
      end
      object EnvoyerItem: TMenuItem
        Caption = 'Envoyer'
        ImageIndex = 31
        ImageName = 'Item32'
        OnClick = EnvoyerItemClick
      end
      object RecevoirItem: TMenuItem
        Caption = 'Recevoir'
        ImageIndex = 30
        ImageName = 'Item31'
        OnClick = RecevoirItemClick
      end
      object FileAddItem: TMenuItem
        Caption = '&Fusionner'
        HelpContext = 208
        Hint = '|Ajouter une page '#224' partir d'#39'un fichier'
        OnClick = FileAddItemClick
      end
      object FileCalcItem: TMenuItem
        Caption = 'Importer traitements'
        OnClick = FileCalcItemClick
      end
      object FilePrintItem: TMenuItem
        Caption = '&Imprimer'
        HelpContext = 205
        Hint = 'Imprimer|Choix des parties '#224' imprimer'
        ImageIndex = 11
        ImageName = 'Item12'
        ShortCut = 49225
        OnClick = FilePrintItemClick
      end
      object PrinterSetUpItem: TMenuItem
        Caption = 'Param. imprimante'
        OnClick = PrinterSetUpItemClick
      end
      object CSVhorizontal1: TMenuItem
        Caption = 'Ouvrir ".scv horizontal"'
        Visible = False
        OnClick = CSVhorizontal1Click
      end
      object ExporterLatexItem: TMenuItem
        Caption = 'Exporter Latex'
        OnClick = ExporterLatexItemClick
      end
      object MRUseparator: TMenuItem
        Caption = '-'
      end
      object MRUitem0: TMenuItem
        OnClick = MRUItemClick
      end
      object MRUItem1: TMenuItem
        Tag = 1
        OnClick = MRUItemClick
      end
      object MRUitem2: TMenuItem
        Tag = 2
        OnClick = MRUItemClick
      end
      object MRUiTem3: TMenuItem
        Tag = 3
        OnClick = MRUItemClick
      end
      object MRUitem4: TMenuItem
        Tag = 4
        OnClick = MRUItemClick
      end
      object MRUItem5: TMenuItem
        Tag = 5
        OnClick = MRUItemClick
      end
      object SeparatorItem: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Caption = '&Quitter'
        HelpContext = 201
        Hint = 'Quitter l'#39'application'
        ImageIndex = 4
        ImageName = 'Item5'
        OnClick = FileExitItemClick
      end
    end
    object MenuEdition: TMenuItem
      Caption = '&Edition'
      GroupIndex = 1
      OnClick = MenuEditionClick
      object RestaurerItem: TMenuItem
        Caption = '&Annuler suppression'
        ImageIndex = 21
        ImageName = 'Item22'
        OnClick = RestaurerItemClick
      end
      object CutItem: TMenuItem
        Tag = 1
        Caption = 'Couper'
        Hint = 'Couper vers le presse-papiers'
        ImageIndex = 28
        ImageName = 'Item29'
        ShortCut = 16472
        OnClick = CutItemClick
      end
      object CopyItem: TMenuItem
        Tag = 2
        Caption = 'Copier'
        Hint = 'Copier vers le presse-papiers'
        ImageIndex = 3
        ImageName = 'Item4'
        ShortCut = 16451
        OnClick = CopyItemClick
      end
      object PasteItem: TMenuItem
        Tag = 3
        Caption = 'Coller'
        Hint = 'Coller depuis le presse-papiers'
        ImageIndex = 18
        ImageName = 'Item19'
        ShortCut = 16470
        OnClick = PasteItemClick
      end
      object AnnulerItem: TMenuItem
        Caption = 'Annuler'
        ImageIndex = 21
        ImageName = 'Item22'
        ShortCut = 16474
        OnClick = AnnulerItemClick
      end
      object DeleteItem: TMenuItem
        Tag = 4
        Caption = '&Supprimer'
        Hint = 'Supprimer la s'#233'lection'
        ImageIndex = 2
        ImageName = 'Item3'
        ShortCut = 16430
        OnClick = DeleteItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CollerPageItem: TMenuItem
        Caption = 'Coller page'
        OnClick = CollerPageItemClick
      end
      object CollerNewDocItem: TMenuItem
        Caption = 'Coller document'
        HelpContext = 904
        OnClick = FileNewClipItemClick
      end
      object UtilisateurSepar: TMenuItem
        Caption = '-'
      end
      object UtilisateurItem: TMenuItem
        Caption = '&En-t'#234'te d'#39'impression'
        OnClick = UtilisateurItemClick
      end
      object RecupItem: TMenuItem
        Caption = 'R'#233'cup'#233'ration sauvegarde auto.'
        OnClick = RecupItemClick
      end
      object RazItem: TMenuItem
        Caption = 'R'#233'initialisation'
        OnClick = RazItemClick
      end
      object RandomItem: TMenuItem
        Caption = 'Recalculer'
        ShortCut = 115
        Visible = False
        OnClick = RandomItemClick
      end
    end
    object MenuFenetre: TMenuItem
      Caption = 'Fen'#234'tre'
      GroupIndex = 3
      Hint = 'Commandes de fen'#234'tres telles que Mosa'#239'que et Cascade'
      OnClick = UpdateMenuItems
      object WindowCascade: TMenuItem
        Tag = 1
        Caption = '&Cascade'
        GroupIndex = 3
        Hint = 'Disposer les fen'#234'tres en recouvrement'
        ImageIndex = 0
        ImageName = 'Item1'
        RadioItem = True
        OnClick = WindowClick
      end
      object WindowMosaiqueVert: TMenuItem
        Tag = 2
        Caption = 'mosa'#239'que &Vert.'
        GroupIndex = 3
        Hint = 'Disposer les fen'#234'tres sans recouvrement (c'#244'te '#224' c'#244'te)'
        ImageIndex = 12
        ImageName = 'Item13'
        RadioItem = True
        OnClick = WindowClick
      end
      object WindowMosaiqueHoriz: TMenuItem
        Tag = 3
        Caption = 'mosa'#239'que &Horiz.'
        GroupIndex = 3
        Hint = 'Disposer les fen'#234'tres sans recouvrement (en-dessous)'
        ImageIndex = 13
        ImageName = 'Item14'
        RadioItem = True
        OnClick = WindowClick
      end
      object WindowMaxi: TMenuItem
        Caption = ' '
        GroupIndex = 3
        Hint = 'Chaque fen'#234'tre occupe tout l'#39'espace'
        ImageIndex = 33
        ImageName = 'Item34'
        RadioItem = True
        OnClick = WindowClick
      end
      object WindowManuelle: TMenuItem
        Tag = 4
        Caption = 'Disposition manuelle'
        GroupIndex = 3
        RadioItem = True
        OnClick = WindowClick
      end
      object SeparatorWindow: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object GrandeursItem: TMenuItem
        Caption = '&Grandeurs'
        GroupIndex = 3
        Hint = 
          '|Fen'#234'tre des expressions des grandeurs et des tableaux de valeur' +
          's'
        ImageIndex = 23
        ImageName = 'Item24'
        OnClick = GrandeursBtnClick
      end
      object GrapheItem: TMenuItem
        Caption = 'graphe &Variables'
        GroupIndex = 3
        HelpContext = 102
        ImageIndex = 9
        ImageName = 'Item10'
        ShortCut = 116
        OnClick = GrapheBtnClick
      end
      object FourierItem: TMenuItem
        Caption = '&Fourier'
        GroupIndex = 3
        HelpContext = 104
        Hint = 'Appel de la fen'#234'tre FFT'
        ImageIndex = 8
        ImageName = 'Item9'
        OnClick = FourierBtnClick
      end
      object StatistiqueItem: TMenuItem
        Caption = '&Statistique'
        GroupIndex = 3
        HelpContext = 103
        Hint = 'Appel de la fen'#234'tre statistique'
        ImageIndex = 24
        ImageName = 'Item25'
        OnClick = StatistiqueBtnClick
      end
      object GrapheConstItem: TMenuItem
        Caption = 'graphe &Param'#232'tres'
        GroupIndex = 3
        ImageIndex = 7
        ImageName = 'Item8'
        OnClick = GrapheConstBtnClick
      end
      object Graphe3DItem: TMenuItem
        Caption = 'Graphe 3D'
        GroupIndex = 3
        OnClick = graphe3DBtnClick
      end
      object AcquisitionItem: TMenuItem
        Caption = '&Acquisition'
        GroupIndex = 3
        ImageIndex = 20
        ImageName = 'Item21'
        OnClick = FocusAcquisitionBtnClick
      end
    end
    object MenuPage: TMenuItem
      Caption = '&Pages'
      GroupIndex = 4
      OnClick = MenuPageClick
      object PageSuivItem: TMenuItem
        Caption = 'Suivante'
        ImageIndex = 26
        ImageName = 'Item27'
        ShortCut = 119
        OnClick = PageSuivClick
      end
      object PagePrecItem: TMenuItem
        Caption = 'Pr'#233'c'#233'dente'
        ImageIndex = 27
        ImageName = 'Item28'
        ShortCut = 118
        OnClick = PagePrecClick
      end
      object PageAddItem: TMenuItem
        Caption = '&Nouvelle'
        Hint = 'Cr'#233'ation d'#39'une page'
        ImageIndex = 15
        ImageName = 'Item16'
        OnClick = PageAddItemClick
        object PageNewItem: TMenuItem
          Caption = 'Cr'#233'er page &vierge'
          Hint = 'Cr'#233'er une nouvelle page'
          OnClick = PageAddClick
        end
        object PageCopyItem: TMenuItem
          Caption = '&Recopier page'
          HelpContext = 307
          OnClick = PageCopyItemClick
        end
        object PageCalculerItem: TMenuItem
          Caption = '&Calculer page'
          HelpContext = 305
          OnClick = PageCalculerItemClick
        end
        object PageNewClipItem: TMenuItem
          Caption = '&Presse-papiers'
          OnClick = CollerPageItemClick
        end
        object DistribuerItem: TMenuItem
          Caption = '&Distribuer'
          OnClick = DistribuerItemClick
        end
      end
      object PageDelItem: TMenuItem
        Caption = '&Supprimer'
        Hint = 'Supprimer la page courante'
        ImageIndex = 16
        ImageName = 'Item17'
        OnClick = PageDelClick
      end
      object PageTrierItem: TMenuItem
        Caption = '&Trier'
        Hint = '|trier les pages selon un param'#232'tre'
        ImageIndex = 22
        ImageName = 'Item23'
        OnClick = PageTrierItemClick
      end
      object EchantillonnerItem: TMenuItem
        Caption = 'R'#233#233'chantillonner'
        OnClick = EchantillonnerItemClick
      end
      object PageSelectItem: TMenuItem
        Caption = 'Se&lectionner'
        Hint = '|S'#233'lectionner les pages actives pour le graphe...'
        ImageIndex = 17
        ImageName = 'Item18'
        OnClick = PageSelectItemClick
      end
      object PageGrouperItem: TMenuItem
        Caption = '&Grouper'
        Hint = 
          'N pages -> une page|Recopie les donn'#233'es de toutes les pages dans' +
          ' une seule'
        OnClick = PageGrouperItemClick
      end
      object GrouperColonnesItem: TMenuItem
        Caption = 'Grouper colonnes'
        Hint = 
          'N pages -> une page|Recopie les donn'#233'es de toutes les pages comm' +
          'e nouvelles colonnes'
        OnClick = GrouperColonnesItemClick
      end
    end
    object OptionsItem: TMenuItem
      Caption = '&Options'
      GroupIndex = 5
      OnClick = OptionsItemClick
    end
    object MenuHelp: TMenuItem
      Caption = '&Aide'
      GroupIndex = 6
      Hint = 'Sujets d'#39'aide'
      object TOCitem: TMenuItem
        Caption = 'Table des mati'#232'res'
        OnClick = TOCitemClick
      end
      object DocumentationWord: TMenuItem
        Caption = 'Doc. au format .odt'
        OnClick = DocumentationWordClick
      end
      object Documentationpdf: TMenuItem
        Caption = 'Documentation pdf'
        OnClick = DocumentationpdfClick
      end
      object DocModele: TMenuItem
        Caption = 'Doc. mod'#233'lisation'
        OnClick = DocModeleClick
      end
      object SeparatorAide: TMenuItem
        Caption = '-'
      end
      object ListeRegAction: TMenuItem
        Caption = 'Liste Regressi'
        OnClick = ListeRegActionClick
      end
      object WebItem: TMenuItem
        Caption = 'Site auteur'
        OnClick = WebItemClick
      end
      object AboutItem: TMenuItem
        Caption = #224' &propos'
        OnClick = AboutItemClick
      end
      object ExemplesItem: TMenuItem
        Caption = 'Exemples'
        object N11: TMenuItem
          Caption = '1'
          OnClick = ExemplesClick
        end
        object N21: TMenuItem
          Tag = 1
          Caption = '2'
          OnClick = ExemplesClick
        end
        object N31: TMenuItem
          Tag = 2
          Caption = '3'
          OnClick = ExemplesClick
        end
        object N41: TMenuItem
          Tag = 3
          Caption = '4'
          OnClick = ExemplesClick
        end
        object N51: TMenuItem
          Tag = 4
          Caption = '5'
          OnClick = ExemplesClick
        end
        object N61: TMenuItem
          Tag = 5
          Caption = '6'
          OnClick = ExemplesClick
        end
        object N71: TMenuItem
          Tag = 6
          Caption = '7'
          OnClick = ExemplesClick
        end
        object N81: TMenuItem
          Tag = 7
          Caption = '8'
          OnClick = ExemplesClick
        end
        object N91: TMenuItem
          Tag = 8
          Caption = '9'
          OnClick = ExemplesClick
        end
        object N101: TMenuItem
          Tag = 9
          Caption = '10'
          OnClick = ExemplesClick
        end
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'rw3'
    Filter = 
      'Regressi|*.rw3|Texte avec tabulation|*.txt|OpenOffice, CSV|*.csv' +
      '|Regressi XML|*.rxml'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Sauvegarde Regressi'
    Left = 352
    Top = 136
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'rw3'
    Filter = 
      'Regressi Windows|*.rw3;*.rxml|Tableur txt ou csv|*.txt;*.csv|Aud' +
      'io|*.wav;*.mp3|Video|*.avi;*.mpg|Pasco capstone|*.csv;*.txt|Jeul' +
      'in|*.lab|CRAB|*.cpt|Logger|*.?mbl|CCD Micrelec|*.eps|Spectre FIT' +
      'S|*.fit;*.fits|Votable IMCE|*.xml|Regressi Dos|*.rrr|Keysight HD' +
      'F|*.h5'
    FilterIndex = 0
    Options = [ofFileMustExist, ofEnableSizing]
    Title = 'Regressi'
    Left = 208
    Top = 136
  end
  object PopupMenuAcq: TPopupMenu
    Images = VirtualImageList1
    Left = 424
    Top = 136
    object AcqItemBis1: TMenuItem
      OnClick = AcqItemClick
    end
    object AcqItemBis2: TMenuItem
      Tag = 1
      OnClick = AcqItemClick
    end
    object AcqItemBis3: TMenuItem
      Tag = 2
      OnClick = AcqItemClick
    end
    object AcqItemBis4: TMenuItem
      Tag = 3
      OnClick = AcqItemClick
    end
    object AcqItemBis5: TMenuItem
      Tag = 4
      OnClick = AcqItemClick
    end
    object AcqItemBis6: TMenuItem
      Tag = 5
      OnClick = AcqItemClick
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
              0D000000934944415478DAB5938B0D80200C05DBC964B48E562743FC11ADAD14
              A92F216A88C7C153CC902132F80B10D74B400A0B2B909921A5E91388792EEFA6
              9F814054A6060681041E7356081A40520C374BAD1F84E60E2CC39C772022BED8
              7618DE8196ADB27D8FE179EF32F6183E812FC69E9625F0FA7C5BC8349467E206
              5A86A235993143ADC52143E53BEB6F39F45F0E48054666017EDFD5ED9C3CCCFC
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000764944415478DADDD44B0AC0200C04D0CCB9EBB29E7B8AF4433F31C4
              58A4342B05F3D4110485F266E1EF20B666A20BCC73E694921485272C045A5800
              5CAF58C39E60994010C5AEE03E50411CBBBA413B1BDFE92A19DE9BFDA7AB64A8
              AFF7604686601FA83E48DB5507810ADA821919C6EB6BDFD7007001B2106BEDB3
              20E08E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
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
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B14944415478DAED934B1284200C44936371B6640957E35A482C4128
              4204CBD94D6F0C1F1F9D563041822F8502447928CA6BF81A98D52F203650ED40
              FDB00E2890182338E7CEBACC15A7C18744CC26D47458E65A68EFF60158DB6CEA
              31D30DA09DB6F57D6EB0EAB06E2B19D62C6DD896C33BC70F321CC6F2E2557BEF
              8198F4969F1C420B21AED1A659863B409140A740585001F1F573CB58EA013875
              753ACF3724488BA4EFD01CFE81BF05C28296816F740097D5C6ED663DC8B00000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
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
        Name = 'Item6'
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
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A64944415478DAD5944B0E80300844E158F66A7569AF568F554185F8
              A9B54436CE86A4195FC7C188050A780A19883448808874D47B01823CA3130A2A
              D0239D02E73CBB008730DC8121041324E7FC0C64181B78722FCD06A933F10AB4
              0AD43ED6A253BDAB12F7059E53D6819C6CDFDC5B42F176038F09B754E99CD00A
              744FE8074CF46AE3D8FE5EA60920C64EA045DDC0564A4967021E8C573DF97E08
              54B341CD9FC35729D0530B278EF5EDCA509B980000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000804944415478DAD595D10A80300845BDDF3D1FDB772F0D8A308DB58C
              912F0E19C7AB7730346A9419B04048496A4801D6A53666A6A740B92C2208290A
              15B69F157A00559DE6A90ACFA0D73BB4A3BAC0A90AC3269FBD43CF653B923762
              B7C2CBFB0A4CB805DA1DA62A4C31E53F2E8FC666A655A8E0C205A33904DAEEBD
              75647F012BCA8CB3ED4EE278280000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000734944415478DAE5953112C0200804B9774B19DF8DD039243A044915
              0A71AE5877A010424295050F84469AA104D8AF2ECC4C65C05243B3B3FEA9A11E
              7AA757F0ED0C8F813F337CDAF20C8CC2C38629E06E865178CA300CCC187AF8B1
              E112386F395B2672333470E3866C5F02FDEBD11CD55FC000AB12C9ED513B2F92
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AB4944415478DACD95DD0E80200885E1B9F3329F9BC065E20FD89C6D
              79118EE4EB78D08504043B07B640E414E7700B309E914208B002E4021602B845
              6186550A459D44AD502F9CC318C575AEC219B085B91E3E9E7450559CDEC9B458
              642A1C03330CF9219535CC540869715135DA5A3D37807D976D80E5AFD3E5B2BD
              3AFACD72146A1024AFEC464D3CA41BE01F15E328FDF62E7FAF50777975D0E82E
              0BF80807AE4613D87EFD6D1E77FF022EE5CEDCEDCA2EE6170000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008B4944415478DAADD4510AC0200C03507B6EBF3DB793A1CC619366CE
              821F43F78C48B59A6A3A5946C16AD5F9C3BE831E24C22BA860047D83EE11E7CD
              62F401234C4431D8979436729B29ED3B23740159BA3E43C1098560E9603E0546
              89FF8111B6038ECBD1C07B77829A964E07A37241808EDB8547869D8250D67A61
              2F3B284C28BF362C2D813470A38E8317467E73ED468BEE380000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item12'
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
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A74944415478DACD94511280200844E1647533E166DECCC4B2A4A2C9
              A299F6474B7DECAA232648E02914204AE3A0CCC215186384711CACBA703D3ECF
              5140778759766DCCD5D375CD32E70D1091F3BF600389E8141642380005B6C65C
              A08F1D56988074BF1738AF3C89CA3690991548E2B60E5B47C7F8D41FB9B801AA
              9BB7837602CB82EAAC7C8302779FB2026E95B62EFCED62DF02EE4FB98DECEED0
              DAE32A19FFEEB5F1943B70021A7DD1EDFBC90FFB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A34944415478DABD925112C3200805E164CDCDC49B7933229D50A19A
              345526EFCB515C37106460880C2A1065B998CA42072CA5C0B6BD66DD7A60B8E1
              7BC59E8B98EB56FAED87034316583D50A8C09C8182A5E6EBF173A00159B3CF1E
              5003B9C7873DA40632C57A198FF3CEB6D65D1A5A882174BD6DC320C0E150787E
              D0279FBC96017085F9C88F1DDD4322BA7539A5740F186E28C09CF35F20B57DC6
              709A76C401A3B2033822A3EDD64A18E80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C74944415478DAB5D44B12C32008005038B72EF5DCC64FA880982149
              E326330E3E1168B140817F2EFC1CCC09FB4688051170B9ADC6E36D3046199452
              AA17049C31B9C6C465DF043D59B9400B1AD98DE73F025B261C6E182D8D52FC65
              0D394ADF1DEA02F9D3297887BA416B59E8ED0C470D67D135DA46CB0552074BBD
              1F6B1E0B6ABC20305874591F265466628DD706D4CDB0C1712CF7CCDA8B54F7C5
              1C9E4087CBB9EF0045F709E4B513479F821CFD55669BE50411E4CFF3720EA90C
              2B3A41003993DFFFC1BE5D079F96DEED7D45AE7F0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007F4944415478DACDD1D10E8020080550EE77FBCC77533A2B646A4AAE
              797BC85C3B0242486865A041100FE94201C3A048E85700EEA22E30FE93DE15B4
              0DE27C2A03BEC07B6D507785C5B742DD33D49902194F4741A47AC0341877782B
              50B7995ACD60B197F161B07735EC019756B8FFA558D0B6F9097CCBFFE09496D3
              0457E40036D8BAEDB52E61DB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000664944415478DAEDD1D10A8030080550EF77FBEC77DF68448C489C26
              F5D27D71B07150070AA533984188853A45910249F51FC342340DEEF7A33A6809
              3CCF376819F4D0D20EAF99D114E876FD3A68C012A6E43A18F5699F83AD23B77F
              CA0F3E0353DA1117ECC806F28EA4ED640020E60000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
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
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B24944415478DAC5D3DB128420080660786EBCC4E726F1D0A01B9A4D
              BBCB4DD6E8D7EF090504DE2CFC1A18394A0861DA99998102E12D1053536AD818
              191A9E11AA3FFAA00497A0625A16D45214D370C9088A8776A00E1E21FBAEED2D
              B02524A2ABD5D94FB80261BA1D057E90D0C7FE3F653443E5027B963075C22ACB
              CE39B4D50EB605CFA737E53A83E9C51EC1F2AD473B10610E966B48E794BB7D1E
              8F8D9B2A2FC5A28F49791B1C53796BF9FB84BBF53A78006BD4BFED7318247500
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007F4944415478DABDD34B0EC020084551D8FFA2E927DA5614E1A1A923
              4627DC56594868E7E1DF402612917BE065F0C2EA8CA21DA831660C6DC011866E
              FA80330C41DF0DCFA1E6595824BFFD8605B5B0C8A6FD5F56289A3FBE870BF9F6
              4B49E6CF9F5E22DF7FCBD17C8A82C17C0C74F22B868146FE17C341B5A9C672A0
              73B6830741637DED6C30D50A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item21'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006F4944415478DAD5D4DB0A80300C03D0E6FF3FBA3A41DDB4B51103B2
              BCEC023B632D0C6E6ECAA081688320AB8513FC4AE23710DB5B44E08E5528981A
              5E910CED2ECDC1EA70B44E41E6791EE377F04503A2128DA091D8C3257553FA78
              BDCF77999CCF064621EA366ECFF5DB087280CA2CDCBB8AED3AAC87EE00000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item22'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000604944415478DAEDD24B0AC0300805C0E7B9E352CF6DE842FA53129A
              5068894BD15144321866062DF0C320414F852240E1424D706B34EC850E1D739E
              8FD01074E08A475BDF066560B4D530D8421F8119DA7DC39E5051634E06FDE7B1
              17F81E58016E2156EDFB426F970000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item23'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000824944415478DACD92C10EC0200843E97773F5BF992E73590C222287
              F5A8F8ACAD10120241C8A93A0F6B1F1D58B584018803EB591AEF68C0954B15F8
              9C53816DCE72BAEDB0CFCDA02FB094722F30B30B38838632FCCA0DF468DBA156
              4C18683DDD051C4B59C1524A49C9D0CA319461BAC3FFB4AC018F5AD6BE4DAAC3
              E30C29A811780153B1C0EDEE47EBD80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DA63FCCFF09F819A8071E818C80862520080E6306218
              78ECD83130DBCACA9228438E1D3B0E556F85DD4006B2BDCF88DD402020CF3846
              3C068224C16142041B993FEAC251178E1C1792651ACCA5E806520B50DD400014
              EEB8ED4714567E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A54944415478DABD93DB1280200844E5BBE551BFDBA0CB84883A9AC6
              8B23D471DD36482EB995051208B4A53DFC06A401CD1D748131C4938A882E8450
              7D18D1D33C56E71E3DEC51C8C52A59E132605B211851B00FEE7AE8A917EF9EF4
              50F6073D6475572FBFF2DB1FF47012682BCC5F2A3F4A096D7AA87DD239D4F38E
              87C6E9666CD42D4A0FEBB1A8E7F08955DAF4A7480FBF54D20A19CCC6CEAE9987
              1238BB2F802B6A39F000B5DAD7EDA86A552B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item26'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BA4944415478DAADD2C11184200C05D050161C690B8ED01A6D297F76
              E32C4802B87289A23C3E5173D0416F0E03D0D452ABD16ABF10F34310CF66182F
              96AE6F09978E02A012A66ED16FB40D329673A610C2858A3D5CC5628C94525251
              15FCC5300061684945B04F76F5EF5BA5A44370948C53A17AEFC95AFB797706CE
              92DDAA76642D19169752C83927620DF86FB206648CBF207AC449FA7B0D1B261C
              A12BC9D41E8AE80453BF7233B7884DFFC35D4C041945DDC154F0E9781D3C01E4
              FF0CFCC73907010000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item27'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000664944415478DAD5CFC10A80300C03D0F6BBD763F7DD730A8AE08C6B
              B6C3CCA924F0A05AA4C8CCE8FF40AD55ED7418CC9E8FC3CCAE918121C8C05D60
              040E813D300522780DD0DD25596ABE1D0277E8CC10788710F60946200832D02B
              C8421064A007382BEB831B66C079ED16D4E8460000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item28'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006A4944415478DAEDD2BB0AC0300840D1F8DD7134DF6D9382500AC647
              842EBD8B593C4B046EDC2A831FF42FAED5D9DC872350208988EED9B143087C43
              695083C2A005B9412FF41DB81A3418116B41795BB0FB539EE80E0E9F8D05A70F
              5B83D3A0064B6950838F41AD72F002C2996DED5D1B8F9E0000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Item29'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BB4944415478DACD94C10EC4200844E1BBF1A8DFCD8AD94646B1B54D
              935D2E2D8D3E6780CA4A4A6F06FF04C8B62C88BA971F036BF49C992C6FCF013A
              0199FA076D690702E87BC00805207706588A14AEAC87405B80EFA8101CED285C
              01C3FA9E01D1B652A4B0591CEB79061C47E5B142DF5DD0BB1113B0C36680292B
              A52C6129A5062CB9A8246107643726D8909C73DB2C227B96B111441E7ED4F380
              9AA24BCBD8DDC53FEA95566BAB12DCBA6D76A0B7AF2F3F4EAF002F0FFC7BE007
              829DB2EDD36CDF150000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item30'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008D4944415478DAED91391680200C0593734309E7FEB208224B101A1B
              BE45501F9321300894E35FD83DF57A211C8069735D37C2D9B054DD8445A0CBF0
              27DBE61B48B10CEC19064134353590A0ED0C07B030073604E85807D078E4F266
              2786807AE01D28BFEFC2C21B4886B39976808AA463D7C6E6EEA174042F19F68C
              3F008FE131FCDF901623027DAC598796C00B71C7DFED31B89DBF000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item31'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A84944415478DAD594510E02210C44DB63C1D5CA275C0D8E851D1553
              930611F970E787ECA63C66DA5DB853A79362004B2E47A89284EF400677A29C33
              A5943E0295F500CE34DC03880D4B91A7055A526BA518E33E10901113ABE85ACC
              F388EF1DE0021153444C95EEEBEF75ACEF968170D82DE057E0451CA2F10A69AD
              51D009379D7408E105DF73C8CE57F274BADF430B35B1FFA087A7A76CFF14C8BB
              1C96819EE36397C33580DFE80690D4B7EDCB5203B90000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item32'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B34944415478DAD594410E84200C45DB63C1926BC912AFC5921E0B29
              2349470902C164E66F34A47DFC6F53314284954206EE6E5F42DDEC861988CC6D
              C83907D6DA4760627D802D51A0E8BDCF406EE88ADC2C48252104D05ACF01F97B
              B29B12939FC618282E65FCDA05376071A4941287A92F5EEAD25917901DB2A365
              C09B43143D023AE7102B3338A1E3C034556E26A2FC4EC5F5197F3EF2EF0FE515
              87150D39945B72DD8EAF81F7006B2AEBB8E4E7F01FC0111DB2E5BEED968B8F87
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item33'
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
        Name = 'Item34'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AB4944415478DAC594610EC3200885E1647A33F5667A32D7F7C3060B
              C46DBAEC25C648CBC7AB54B953A793620019D3015D2CBE8139678A3152ADF57E
              016B29EF19E2C89F8008627890151C63021EFF64DA6E0EFFD8E1256AAD5108C1
              28CE22CBAECDCC769727E0004908620654014D874EB2155F3BF460EF0295C35D
              E0FF1D3E9AE53B9447AC2F7E4F51D47708E00A6438554079D8BF91BA1CE41E96
              5228A5F4D1ACAEAF2D7B63CB07F0A45EEF26E0EDC3EF36D40000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item35'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A44944415478DAB592D10DC0200844753337533773332B1F672CB95A
              ADF412434AEAE3407C75D559CAFF0EF42DD572DE0428B0528A0B21B8AFD00E04
              4C64020454E2894BFA2827AD538710A0A37401DC419ECE10731CC163BE5F269D
              DC8029A5C7565080159A02758BBA7589F85E026A97724903F11F0C1C3B84505C
              E2D10CB71E25B693A59DD84E4E3727DB6BC31CCE5CB3A59F2EF61B709C1D0532
              B122CB0E2D640EBC00E63ABAEDE0E82C090000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item36'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B24944415478DACD94010E83200C45E9CDB8991C8D9BA9DFEDCF521A
              404696356944529FEDFF01D9C31E5686FC1C282879C7592BD5E766AF09042CE7
              1C628C21A574E50DAD614D2061481D5BDAC4A9FEC05D20610876C735B21CBDEC
              74188827DF5B6317401AA0C72448FFE005EC68A80DB040BD8FF475748074929A
              21B0F68162B432A668E0920EB586B6C3290DADCB04791D0FBBFC1C58439B2745
              9B440DA74E8AD5941AF6C6ED022DF4EBDB6626FE1F7800130ACDED5480923D00
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item37'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DAD594810E80200844E1CBD32F374D2D11485BD8165B
              63337C1CC72606086019B8048829194464E1A930418F83B77989C24A577D79F0
              5F0156C5A548045E355F012B80C2EE81BC61A7B05F8EA4902F10CB4294915B85
              59056DC8A718783833F224D03B1F36E7C0C72F65E9825433F0B055AA7948E18A
              87744C19D836CC91A02E4219100CE2478F836598037764EDFDED38AE0E7A0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item38'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000434944415478DA637CF080E1FF82050D0C20909000A11514C014C3FF
              FF109A91113B1FA8170C90F5338E1A386AE0A881A3068E1A38540CFCCFF09FA1
              B1A1F13FB50C0400D8252710B8CF5EFD0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item39'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000694944415478DACDD44B0EC020080450E6E47273DA4593D23654D089
              91A592C767014C4C98813E78A6888104C27DE6D0D52069645C9D5908C54506C0
              FF3538F0AE4A009F498491AB601C0323A741F758065D33F3E06B5D1B82F4913F
              F4EEA0AAD24E76D386C4F9AAC501E4FE70EDAA1D3A010000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Item40'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006B4944415478DAD5D5C109C0200C856133991DC5D13A8A4E96424128
              6A7C393CC5E61CBEC37F48448306E688072C49DEA578AB9C0756AC0E42F7822D
              E641E7602E63F08A07801686501B34FAA18E43106133743D88DA7568D3F267A0
              B75D877E5AF2C19CB817960FB25FC0031D4B682F12CF80740000000049454E44
              AE426082}
          end>
      end>
    Left = 536
    Top = 236
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
      end
      item
        CollectionIndex = 34
        CollectionName = 'Item35'
        Name = 'Item35'
      end
      item
        CollectionIndex = 35
        CollectionName = 'Item36'
        Name = 'Item36'
      end
      item
        CollectionIndex = 36
        CollectionName = 'Item37'
        Name = 'Item37'
      end
      item
        CollectionIndex = 37
        CollectionName = 'Item38'
        Name = 'Item38'
      end
      item
        CollectionIndex = 38
        CollectionName = 'Item39'
        Name = 'Item39'
      end
      item
        CollectionIndex = 39
        CollectionName = 'Item40'
        Name = 'Item40'
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 348
    Top = 280
  end
end
