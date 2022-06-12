object FValeurs: TFValeurs
  Left = 195
  Top = 144
  HelpContext = 24
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Grandeurs'
  ClientHeight = 1252
  ClientWidth = 1750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000FFFF7FFFF7FFFF7FFFF7FFFF7F0000008
    8888888887888888888888888000000FFFF7FFFF7FFFF7FFFF7FFFF7F000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F000000FFFF7FFFF7FFFF7FFFF7FFFF7F000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F00000088888888887888888888888888000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F000000FFFF7FFFF7FFFF7FFFF7FFFF7F000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F00000088888888887888888888888888000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F000000FFFF7FFFF7FFFF7FFFF7FFFF7F000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F00000088888888888888888888888888000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F000000FFFF7FFFF7FFFF7FFFF7FFFF7F000000F
    FFF7FFFF7FFFF7FFFF7FFFF7F000000888888888888888888888888780000004
    4447444474444744447444444000000444474444744447444474444440000004
    444744447444474444744444400000044447444474444744447444444000000C
    CCCCCCCCCCCCCCCCCCCCCCCCC000000CCCCCCCCCCCCCCCCCCCCCCCCCC0000007
    77CCCCCCCCCCCCCCCCCCCC777000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFC0000003C0000003C0000003C0000003C0000003C0000003C000
    0003C0000003C0000003C0000003C0000003C0000003C0000003C0000003C000
    0003C0000003C0000003C0000003C0000003C0000003C0000003C0000003C000
    0003C0000003C0000003C0000003C0000003C0000003FFFFFFFFFFFFFFFF}
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object Feuillets: TPageControl
    Left = 0
    Top = 0
    Width = 1750
    Height = 1252
    HelpContext = 500
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = PythonTS
    Align = alClient
    Images = VirtualImageList1
    TabOrder = 0
    OnChange = FeuilletsChange
    object ParamSheet: TTabSheet
      HelpContext = 701
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Param'#232'tres'
      ImageIndex = 17
      ImageName = 'Item18'
      object GridParam: TStringGrid
        Left = 0
        Top = 75
        Width = 1734
        Height = 923
        HelpType = htKeyword
        HelpKeyword = 'Constantes'
        HelpContext = 701
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        ColCount = 2
        DefaultColWidth = 160
        DefaultRowHeight = 44
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goTabs, goAlwaysShowEditor]
        ParentFont = False
        PopupMenu = PopupMenuGrid
        TabOrder = 0
        OnMouseDown = GridParamMouseDown
        RowHeights = (
          44
          44)
      end
      object GridParamGlb: TStringGrid
        Left = 0
        Top = 998
        Width = 1734
        Height = 190
        HelpContext = 701
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        ColCount = 10
        DefaultColWidth = 128
        DefaultRowHeight = 44
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 3
        FixedRows = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goTabs, goAlwaysShowEditor]
        ScrollBars = ssHorizontal
        TabOrder = 1
        OnMouseDown = GridParamMouseDown
        ColWidths = (
          128
          128
          128
          128
          128
          128
          128
          128
          128
          128)
        RowHeights = (
          44
          44
          44)
      end
      object ToolBarParam: TToolBar
        Left = 0
        Top = 0
        Width = 1734
        Height = 75
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akTop]
        AutoSize = True
        ButtonHeight = 75
        ButtonWidth = 132
        Color = clGradientInactiveCaption
        DrawingStyle = dsGradient
        GradientEndColor = clSkyBlue
        HotTrackColor = clAqua
        Images = VirtualImageList1
        GradientDrawingOptions = [gdoHotTrack]
        ParentColor = False
        ShowCaptions = True
        TabOrder = 2
        Wrapable = False
        object TriPageBtn: TToolButton
          Left = 0
          Top = 0
          Hint = '|Trier les pages selon la valeur des param'#232'tres'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Trier'
          ImageIndex = 8
          ImageName = 'Item9'
        end
        object AddParamBtn: TToolButton
          Left = 132
          Top = 0
          Hint = 'Cr'#233'er grandeur'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajouter'
          ImageIndex = 1
          ImageName = 'Item2'
          OnClick = AddBtnClick
        end
        object DeleteParamBtn: TToolButton
          Left = 264
          Top = 0
          Hint = 'Suppr. param'#232'tre|Supprimer un param'#232'tre exp'#233'rimental courant'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Supprimer'
          ImageIndex = 2
          ImageName = 'Item3'
          OnClick = DeleteBtnClick
        end
        object DeltaParamBtn: TToolButton
          Left = 396
          Top = 0
          Hint = 
            'Incertitude|Affiche, si enfonc'#233', l'#39'incertitude sur les param'#232'tre' +
            's'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Incertitude'
          ImageIndex = 23
          ImageName = 'Item24'
          Style = tbsCheck
        end
        object PrintParamBtn: TToolButton
          Left = 528
          Top = 0
          Hint = 'Imprimer (Alt+I)|Imprimer les tableaux'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Imprimer'
          ImageIndex = 3
          ImageName = 'Item4'
        end
        object CopyParamBtn: TToolButton
          Left = 660
          Top = 0
          Hint = 'Copier tableau|Copier le tableau dans le presse-papiers'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Copier'
          ImageIndex = 12
          ImageName = 'Item13'
        end
      end
    end
    object VariabSheet: TTabSheet
      HelpContext = 704
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Tableau'
      ImageIndex = 17
      ImageName = 'Item18'
      object UniteSILabelVariab: TLabel
        Left = 0
        Top = 1152
        Width = 1734
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 
          'Attention : les calculs ne prennent pas en compte les coefficien' +
          'ts d'#39#39'unit'#233' (Options/Calcul)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Visible = False
        ExplicitWidth = 1027
      end
      object gridVariab: TStringGrid
        Left = 0
        Top = 150
        Width = 1734
        Height = 1002
        HelpType = htKeyword
        HelpKeyword = 'Valeurs'
        HelpContext = 704
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        DefaultColWidth = 128
        DefaultRowHeight = 48
        DrawingStyle = gdsClassic
        FixedRows = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goTabs, goAlwaysShowEditor]
        PopupMenu = PopupMenuGrid
        TabOrder = 0
        OnMouseMove = gridVariabMouseMove
        ColWidths = (
          128
          128
          128
          128
          128)
      end
      object ToolBarVariab: TToolBar
        Left = 0
        Top = 0
        Width = 1734
        Height = 150
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        ButtonHeight = 75
        ButtonWidth = 156
        Color = clGradientInactiveCaption
        DrawingStyle = dsGradient
        GradientEndColor = clSkyBlue
        HotTrackColor = clAqua
        Images = VirtualImageList1
        GradientDrawingOptions = [gdoHotTrack]
        ParentColor = False
        ShowCaptions = True
        TabOrder = 1
        object TriBtn: TToolButton
          Left = 0
          Top = 0
          Hint = '|Trier les donn'#233'es selon une variable'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Trier'
          ImageIndex = 8
          ImageName = 'Item9'
          Visible = False
        end
        object AddVarBtn: TToolButton
          Left = 156
          Top = 0
          Hint = 'Cr'#233'er grandeur'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajouter'
          ImageIndex = 1
          ImageName = 'Item2'
          OnClick = AddBtnClick
        end
        object DeleteVarBtn: TToolButton
          Left = 312
          Top = 0
          Hint = 'Suppr. grandeur|Supprimer la grandeur exp'#233'rimentale courante'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Sup. colonne'
          ImageIndex = 2
          ImageName = 'Item3'
          OnClick = DeleteBtnClick
        end
        object DelLinesBtn: TToolButton
          Left = 468
          Top = 0
          Hint = 'Suppr. lignes|Suppression des lignes s'#233'lectionn'#233'es'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Sup. ligne'
          ImageIndex = 9
          ImageName = 'Item10'
          Visible = False
        end
        object DeltaBtn: TToolButton
          Left = 624
          Top = 0
          Hint = 'Pr'#233'cision|Affiche, si enfonc'#233', la pr'#233'cision des variables'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Incertitudes'
          ImageIndex = 23
          ImageName = 'Item24'
          Style = tbsCheck
        end
        object AddPageBtn: TToolButton
          Left = 780
          Top = 0
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajouter page'
          ImageIndex = 10
          ImageName = 'Item11'
        end
        object PrintVarBtn: TToolButton
          Left = 936
          Top = 0
          Hint = 'Imprimer  (Alt+I)|Imprimer le tableau'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Imprimer'
          ImageIndex = 3
          ImageName = 'Item4'
          Wrap = True
        end
        object CopyGridBtn: TToolButton
          Left = 0
          Top = 75
          Hint = 'Copier tableau|Copier le tableau dans le presse-papiers'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Copier'
          ImageIndex = 12
          ImageName = 'Item13'
        end
        object PhaseBtn: TToolButton
          Left = 156
          Top = 75
          Hint = 'Phase|Rend continue unevariable par un modulo 360'#176
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Continuit'#233
          ImageIndex = 13
          ImageName = 'Item14'
        end
        object RazBtn: TToolButton
          Left = 312
          Top = 75
          Hint = '|Supprime toutes les donn'#233'es de la page courante'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'R'#224'Z'
          ImageIndex = 14
          ImageName = 'Item15'
        end
        object TrigoBtnBis: TToolButton
          Left = 468
          Top = 75
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Angle'
          ImageIndex = 11
          ImageName = 'Item12'
        end
        object RandomBtnBis: TToolButton
          Left = 624
          Top = 75
          Hint = 'Hasard|Effectue une nouveau tirage des grandeurs al'#233'atoires (F4)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Recalculer'
          ImageIndex = 15
          ImageName = 'Item16'
        end
        object UniteSIBtnBis: TToolButton
          Left = 780
          Top = 75
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Pr'#233'fixe'
          ImageIndex = 16
          ImageName = 'Item17'
        end
      end
    end
    object ExpSheet: TTabSheet
      HelpType = htKeyword
      HelpKeyword = 'Expressions'
      HelpContext = 703
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Expressions'
      ImageIndex = 18
      ImageName = 'Item19'
      object SimulationBox: TGroupBox
        Left = 0
        Top = 75
        Width = 1734
        Height = 140
        HelpContext = 207
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Caption = 'Variable de contr'#244'le'
        TabOrder = 0
        Visible = False
        object NomLabel: TLabel
          Left = 6
          Top = 36
          Width = 56
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Nom'
        end
        object UniteLabel: TLabel
          Left = 6
          Top = 84
          Width = 62
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Unit'#233
        end
        object MiniLabel: TLabel
          Left = 200
          Top = 36
          Width = 50
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Mini'
        end
        object MaxiLabel: TLabel
          Left = 200
          Top = 84
          Width = 54
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Maxi'
        end
        object DeltaLabel: TLabel
          Left = 394
          Top = 84
          Width = 60
          Height = 36
          Hint = 'Maj+Ctrl+D|Delta majuscule obtenu par Maj+Ctrl+D'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Delta'
        end
        object NbreLabel: TLabel
          Left = 394
          Top = 36
          Width = 57
          Height = 36
          Hint = 'Nombre de points'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Nbre'
        end
        object FreqEchLabel: TLabel
          Left = 648
          Top = 84
          Width = 91
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'FreqEch'
        end
        object NomEdit: TEdit
          Left = 80
          Top = 28
          Width = 114
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
        end
        object UniteEdit: TEdit
          Left = 80
          Top = 80
          Width = 114
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 1
        end
        object MiniEdit: TEdit
          Left = 268
          Top = 28
          Width = 114
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 2
        end
        object MaxiEdit: TEdit
          Left = 268
          Top = 80
          Width = 114
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 3
        end
        object NmesEdit: TEdit
          Left = 480
          Top = 28
          Width = 100
          Height = 44
          Hint = 'Nombre de points'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 4
          Text = '512'
        end
        object NmesSpin: TSpinButton
          Left = 580
          Top = 24
          Width = 34
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          DownGlyph.Data = {
            7E040000424D7E04000000000000360400002800000009000000060000000100
            0800000000004800000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
            0303030000000303030300030303030000000303030000000303030000000303
            0000000000030300000003000000000000000300000003030303030303030300
            0000}
          TabOrder = 5
          UpGlyph.Data = {
            7E040000424D7E04000000000000360400002800000009000000060000000100
            0800000000004800000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
            0303030000000300000000000000030000000303000000000003030000000303
            0300000003030300000003030303000303030300000003030303030303030300
            0000}
        end
        object LogBox: TCheckBox
          Left = 628
          Top = 32
          Width = 382
          Height = 34
          Hint = '|pour coordonn'#233'e logarithmique !'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Remplissage exponentiel'
          TabOrder = 6
        end
        object DeltaEdit: TEdit
          Left = 480
          Top = 80
          Width = 158
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 7
        end
        object PagesIndependantesCB: TCheckBox
          Left = 1020
          Top = 32
          Width = 360
          Height = 34
          Hint = '|Ind'#233'pendantes en terme de nombre de points et de mini/maxi'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Pages ind'#233'pendantes'
          TabOrder = 8
        end
      end
      object StatusBar: TStatusBar
        Left = 0
        Top = 1150
        Width = 1734
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Panels = <>
        ParentFont = True
        SimplePanel = True
        UseSystemFont = False
      end
      object GrandeursPC: TPageControl
        Left = 0
        Top = 215
        Width = 240
        Height = 935
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ActivePage = Grec
        Align = alLeft
        MultiLine = True
        TabOrder = 2
        object ConstanteTabSheet: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Constantes'
          object ListConstanteUniv: TListBox
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            ExtendedSelect = False
            ItemHeight = 36
            TabOrder = 0
          end
        end
        object TabSheet2: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Statistique'
          ImageIndex = 1
          object ToolBarStat: TToolBar
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            AutoSize = True
            ButtonHeight = 44
            ButtonWidth = 116
            Customizable = True
            ShowCaptions = True
            TabOrder = 0
            Wrapable = False
            object ToolButton56: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 'minimum d'#39'une expression'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'MIN'
            end
            object ToolButton57: TToolButton
              Tag = 1
              Left = 116
              Top = 0
              Hint = 'maximum d'#39'une expression'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'MAX'
              Wrap = True
            end
            object ToolButton58: TToolButton
              Tag = 1
              Left = 0
              Top = 44
              Hint = 'mean(exp)=moy(exp)=moyenne d'#39'une expression'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'MEAN'
            end
            object ToolButton59: TToolButton
              Tag = 1
              Left = 116
              Top = 44
              Hint = #233'cart type d'#39'une expression'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'STDEV'
              Wrap = True
            end
            object ToolButton46: TToolButton
              Left = 0
              Top = 88
              Hint = 'RMS(x)=Eff(x)=valeur efficace de x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'RMS'
            end
            object ToolButton60: TToolButton
              Tag = 1
              Left = 116
              Top = 88
              Hint = 'fonction d'#39'erreur'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ERF'
              Wrap = True
            end
            object ToolButton62: TToolButton
              Tag = 2
              Left = 0
              Top = 132
              Hint = 'origin(y,x) renvoie l'#39'origine b de y(x)=ax+b'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ORIGIN'
            end
            object ToolButton61: TToolButton
              Tag = 2
              Left = 116
              Top = 132
              Hint = 'pente(y,x) renvoie la pente a de y(x)=ax+b'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'PENTE'
              Wrap = True
            end
            object ToolButton66: TToolButton
              Tag = 2
              Left = 0
              Top = 176
              Hint = 'Valeur initiale'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'INIT'
            end
            object ToolButton63: TToolButton
              Tag = 2
              Left = 116
              Top = 176
              Hint = 'poisson(n,p)=fonction de Poisson de param'#232'tre p'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'POISSON'
              Wrap = True
            end
            object ToolButton14: TToolButton
              Tag = 1
              Left = 0
              Top = 220
              Hint = 'Somme(expression)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SOMME'
              ImageIndex = 0
            end
            object ToolButton21: TToolButton
              Tag = 3
              Left = 116
              Top = 220
              Hint = 'gauss(x,moyenne,ecart-type)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'GAUSS'
              ImageIndex = 1
              Wrap = True
            end
            object ToolButton30: TToolButton
              Tag = 2
              Left = 0
              Top = 264
              Hint = 'Coefficient binomial'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Cnp'
              ImageIndex = 2
            end
            object ToolButton47: TToolButton
              Tag = 1
              Left = 116
              Top = 264
              Hint = 
                'meanF(exp)=moyF(exp)=moyenne d'#39'une expression dans l'#39'espace des ' +
                'fr'#233'quences'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'MoyF'
              ImageIndex = 4
              Wrap = True
            end
            object ToolButton42: TToolButton
              Tag = 1
              Left = 0
              Top = 308
              Hint = 'SommeF(expression) : somme dans l'#39'espace des fr'#233'quences'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SommeF'
              ImageIndex = 3
            end
            object ToolButton68: TToolButton
              Tag = 1
              Left = 116
              Top = 308
              Hint = 'sign(expression)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SIGN'
              ImageIndex = 4
              Wrap = True
            end
            object SigmaBtn: TToolButton
              Tag = 1
              Left = 0
              Top = 352
              Hint = 'u(x)=incertitude type sur x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'u'
              ImageIndex = 5
            end
          end
        end
        object TabSheet3: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Classiques'
          ImageIndex = 2
          object ToolBarFonctions: TToolBar
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            AutoSize = True
            ButtonHeight = 42
            ButtonWidth = 110
            Customizable = True
            List = True
            ShowCaptions = True
            TabOrder = 0
            object ToolButton4: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 'sinus'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SIN'
            end
            object ToolButton8: TToolButton
              Tag = 1
              Left = 110
              Top = 0
              Hint = 'cosinus'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'COS'
              Wrap = True
            end
            object ToolButton10: TToolButton
              Tag = 1
              Left = 0
              Top = 42
              Hint = 'Tangente'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'TAN'
            end
            object ToolButton11: TToolButton
              Tag = 1
              Left = 110
              Top = 42
              Hint = 'arg(x+j*y)=argument entre -'#960' et +'#960
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ARG'
              Wrap = True
            end
            object ToolButton22: TToolButton
              Tag = 1
              Left = 0
              Top = 84
              Hint = 'logarithme d'#233'cimal'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'LOG'
            end
            object ToolButton23: TToolButton
              Tag = 1
              Left = 110
              Top = 84
              Hint = 'logarithme n'#233'p'#233'rien'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'LN'
              Wrap = True
            end
            object ToolButton24: TToolButton
              Tag = 1
              Left = 0
              Top = 126
              Hint = 'exponentielle"'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'EXP'
              Wrap = True
            end
            object ToolButton34: TToolButton
              Tag = 1
              Left = 0
              Top = 168
              Hint = 'carr'#233
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SQR'
            end
            object ToolButton25: TToolButton
              Tag = 1
              Left = 110
              Top = 168
              Hint = 'racine carr'#233'e'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SQRT'
              Wrap = True
            end
            object ToolButton26: TToolButton
              Tag = 1
              Left = 0
              Top = 210
              Hint = 'partie enti'#232're'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'INT'
            end
            object ToolButton73: TToolButton
              Tag = 1
              Left = 110
              Top = 210
              Hint = 'sinc(x)=sin(x)/x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SINC'
              Wrap = True
            end
            object ToolButton43: TToolButton
              Tag = 1
              Left = 0
              Top = 252
              Hint = 'sign(x)=-1 si x<0, +1 si x>0'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SIGN'
            end
            object ToolButton13: TToolButton
              Tag = 1
              Left = 110
              Top = 252
              Hint = 'valeur absolue'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ABS'
              Wrap = True
            end
            object ToolButton83: TToolButton
              Tag = 1
              Left = 0
              Top = 294
              Hint = 'fonction gamma'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'GAMMA'
            end
            object ToolButton84: TToolButton
              Tag = 1
              Left = 110
              Top = 294
              Hint = 'factorielle'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'FACT'
              Wrap = True
            end
            object ToolButton70: TToolButton
              Tag = 1
              Left = 0
              Top = 336
              Hint = 'sign(expression)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SIGN'
              ImageIndex = 0
            end
          end
        end
        object TabSheet4: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Signal'
          ImageIndex = 3
          object ToolBarSignal: TToolBar
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            AutoSize = True
            ButtonHeight = 44
            ButtonWidth = 123
            Customizable = True
            ShowCaptions = True
            TabOrder = 0
            object ToolButton17: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 'RMS(x) ou Eff(x) = valeur efficace sur une p'#233'riode AC+DC'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'RMS'
            end
            object ToolButton18: TToolButton
              Tag = 1
              Left = 123
              Top = 0
              Hint = 'fr'#233'quence ; seuil en option : f=freq(y,seuil)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'FREQ'
              Wrap = True
            end
            object ToolButton19: TToolButton
              Tag = 2
              Left = 0
              Top = 44
              Hint = 'phase(x,y)=phase(y)-phase(x)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'PHASE'
            end
            object ToolButton20: TToolButton
              Tag = 2
              Left = 123
              Top = 44
              Hint = 'filtre(x,G(f))=x filtr'#233' par G(f) : gain complexe'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'FILTRE'
              Wrap = True
            end
            object ToolButton32: TToolButton
              Tag = 3
              Left = 0
              Top = 88
              Hint = 'harm(x,debut,fin)=somme des harmoniques de x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'HARM'
            end
            object ToolButton40: TToolButton
              Tag = 2
              Left = 123
              Top = 88
              Hint = 
                'triangle(t,f,r)=triangle de fr'#233'quence f et de rapport cyclique r' +
                ' (dur'#233'e pente positive / p'#233'riode)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'TRIANGLE'
              Wrap = True
            end
            object ToolButton44: TToolButton
              Tag = 2
              Left = 0
              Top = 132
              Hint = 
                'creneau(t,f,r)=creneau de fr'#233'quence f et de rapport cyclique r (' +
                'dur'#233'e '#233'tat haut / p'#233'riode)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'CRENEAU'
            end
            object ToolButton50: TToolButton
              Tag = 1
              Left = 123
              Top = 132
              Hint = 'ech(x)=0 si x<0 ; 1 si x>0'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ECH'
              Wrap = True
            end
            object ToolButton51: TToolButton
              Tag = 2
              Left = 0
              Top = 176
              Hint = 
                'lisseF(y,N)='#244'te les points "incorrects" puis filtre avec tau=N*T' +
                'ech'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'LISSE'
            end
            object ToolButton52: TToolButton
              Tag = 1
              Left = 123
              Top = 176
              Hint = 'enveloppe'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ENV '
              Wrap = True
            end
            object ToolButton53: TToolButton
              Tag = 2
              Left = 0
              Top = 220
              Hint = 'corr(y,x)=corr'#233'lation de y et x fonction de TCORR'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'CORR'
              Wrap = True
            end
            object ToolButton54: TToolButton
              Tag = 1
              Left = 0
              Top = 264
              Hint = 'D'#233'calage temporel'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'TCORR'
            end
            object ToolButton55: TToolButton
              Tag = 1
              Left = 123
              Top = 264
              Hint = 'noise(x)= valeur al'#233'atoire gaussienne centr'#233' d'#39#233'cart-type x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'NOISE'
              Wrap = True
            end
            object ToolButton9: TToolButton
              Tag = 2
              Left = 0
              Top = 308
              Hint = 'peigne(t,dt)=peigne de Dirac de pas dt'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'PEIGNE'
              ImageIndex = 0
            end
            object ToolButton33: TToolButton
              Tag = 1
              Left = 123
              Top = 308
              Hint = 'fr'#233'quence instantan'#233'e'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'FREQINST'
              ImageIndex = 1
              Wrap = True
            end
            object ToolButton67: TToolButton
              Tag = 1
              Left = 0
              Top = 352
              Hint = 'Phase continue'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'PHASEC'
              ImageIndex = 2
            end
            object ToolButton69: TToolButton
              Tag = 1
              Left = 123
              Top = 352
              Hint = 'sign(expression)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SIGN'
              ImageIndex = 3
              Wrap = True
            end
            object ToolButton72: TToolButton
              Tag = 2
              Left = 0
              Top = 396
              Hint = 
                'lisseC(y,N)=effectue un lissage centr'#233' avec N points '#224' gauche et' +
                ' '#224' droite'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'LISSEC'
              ImageIndex = 4
            end
            object ToolButton75: TToolButton
              Tag = 1
              Left = 123
              Top = 396
              Hint = 'Avg(x) ou MoyP(x) =moyenne sur une p'#233'riode'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'AVG'
              ImageIndex = 6
              Wrap = True
            end
            object ToolButton74: TToolButton
              Tag = 1
              Left = 0
              Top = 440
              Hint = 'Valeur efficace calcul'#233'e sur l'#39'ensemble du signal'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'RMSALL'
              ImageIndex = 5
            end
          end
        end
        object TabSheet5: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Autres'
          ImageIndex = 4
          object ToolBarDivers: TToolBar
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            AutoSize = True
            ButtonHeight = 44
            ButtonWidth = 80
            Customizable = True
            ShowCaptions = True
            TabOrder = 0
            Wrapable = False
            object ToolButton15: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 'partie fractionnaire'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'FRAC'
              Wrap = True
            end
            object ToolButton16: TToolButton
              Tag = 1
              Left = 0
              Top = 44
              Hint = 'rand(x)= valeur al'#233'atoire entre 0 et x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'RAND'
            end
            object ToolButton27: TToolButton
              Left = 80
              Top = 44
              Hint = 'noise(x)= valeur al'#233'atoire entre -x et x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'NOISE'
              Wrap = True
            end
            object ToolButton28: TToolButton
              Tag = 1
              Left = 0
              Top = 88
              Hint = 'arccosinus'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ACOS'
            end
            object ToolButton29: TToolButton
              Tag = 1
              Left = 80
              Top = 88
              Hint = ' arcsinus'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ASIN'
              Wrap = True
            end
            object ToolButton37: TToolButton
              Tag = 1
              Left = 0
              Top = 132
              Hint = 'arctangente '#224' valeur entre -'#960'/2 et +'#960'/2 (voir ARG pour -'#960' et +'#960')'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ATAN'
              Wrap = True
            end
            object ToolButton39: TToolButton
              Tag = 1
              Left = 0
              Top = 176
              Hint = 'sinus hyperbolique'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SH'
            end
            object ToolButton38: TToolButton
              Tag = 1
              Left = 80
              Top = 176
              Hint = 'cosinus hyperbolique'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'CH'
              Wrap = True
            end
            object ToolButton45: TToolButton
              Tag = 1
              Left = 0
              Top = 220
              Hint = 'tangente hyperbolique'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'TH'
              Wrap = True
            end
            object ToolButton48: TToolButton
              Tag = 1
              Left = 0
              Top = 264
              Hint = 'partie r'#233'elle'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'RE'
            end
            object ToolButton49: TToolButton
              Tag = 1
              Left = 80
              Top = 264
              Hint = 'partie imaginaire'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'IM'
              Wrap = True
            end
            object ToolButton36: TToolButton
              Tag = 1
              Left = 0
              Top = 308
              Hint = 'abs(x+j*y)=norme de z=x+j*y'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ABS'
              ImageIndex = 1
            end
            object ToolButton35: TToolButton
              Tag = 1
              Left = 80
              Top = 308
              Hint = 'arg(x+j*y)=argument de z = x+j*y'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'ARG'
              ImageIndex = 0
              Wrap = True
            end
          end
        end
        object TabSheet6: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Programme'
          ImageIndex = 5
          object ToolBarProgram: TToolBar
            Left = 0
            Top = 0
            Width = 224
            Height = 595
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            AutoSize = True
            ButtonHeight = 44
            ButtonWidth = 123
            ShowCaptions = True
            TabOrder = 0
            Wrapable = False
            object ToolButton5: TToolButton
              Tag = 1
              Left = 0
              Top = 0
              Hint = 
                'x=solve(f(x),x1,x2)=solution de f(x)=0 ; x1 et x2 bornes faculta' +
                'tives de recherche'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'SOLVE'
            end
            object ToolButton6: TToolButton
              Tag = 3
              Left = 123
              Top = 0
              Hint = 'if(test,valeur si vrai, valeur sinon)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'IF'
              Wrap = True
            end
            object ToolButton1: TToolButton
              Tag = 2
              Left = 0
              Top = 44
              Hint = 
                'diff(y,x,ordre,n)=d'#233'riv'#233'e dy/dx ; ordre facultatif de lissage su' +
                'r n points'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'DIFF'
            end
            object ToolButton2: TToolButton
              Tag = 2
              Left = 123
              Top = 44
              Hint = 'aire(y,x)=aire de la courbe d'#233'limit'#233'e par y(x)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'AIRE'
              Wrap = True
            end
            object ToolButton3: TToolButton
              Tag = 2
              Left = 0
              Top = 88
              Hint = 'intg(f,x)=int'#233'grale de f selon x'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'INTG'
            end
            object ToolButton7: TToolButton
              Left = 123
              Top = 88
              Hint = 'x[i]=valeur de x pour le point courant'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '[i]'
              Wrap = True
            end
            object ToolButton12: TToolButton
              Left = 0
              Top = 132
              Hint = 'x[i-1]=valeur de x pour le point pr'#233'c'#233'dent'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '[i-1]'
            end
            object ToolButton64: TToolButton
              Left = 123
              Top = 132
              Hint = 'x[i+1]=valeur de x pour le point suivant'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '[i+1]'
              ImageIndex = 0
              Wrap = True
            end
            object ToolButton31: TToolButton
              Tag = 4
              Left = 0
              Top = 176
              Hint = 
                'intgd(a,a0,a1,f(a))=int'#233'grale de f(a, variable MUETTE) de a0 '#224' a' +
                '1'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'INTGD'
              ImageIndex = 1
            end
            object ToolButton41: TToolButton
              Tag = 2
              Left = 123
              Top = 176
              Hint = 't0=pos(t,equation[,donw/up]) vaeur de t telle que equation'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'POS'
              ImageIndex = 2
              Wrap = True
            end
            object ToolButton65: TToolButton
              Tag = 3
              Left = 0
              Top = 220
              Hint = 'PieceWise([test,then],else)'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'PieceWise'
              ImageIndex = 3
            end
            object ToolButton76: TToolButton
              Tag = 2
              Left = 123
              Top = 220
              Hint = 
                'diff2(y,x,ordre,n)=d'#233'riv'#233'e seconde d2y/dx2 ; ordre facultatif de' +
                ' lissage sur n points'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'Diff2'
              ImageIndex = 4
            end
          end
        end
        object GrandeursTS: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Grandeurs'
          ImageIndex = 6
          object ListeGrandeur: TListBox
            Left = 0
            Top = 96
            Width = 224
            Height = 499
            Hint = '|clic pour ins'#233'rer'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alClient
            ExtendedSelect = False
            ItemHeight = 36
            TabOrder = 0
          end
          object PanelOperateurs: TPanel
            Left = 0
            Top = 0
            Width = 224
            Height = 96
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -37
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object PlusBtn: TSpeedButton
              Left = 2
              Top = 2
              Width = 42
              Height = 40
              Hint = '+'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '+'
            end
            object SpeedButton2: TSpeedButton
              Left = 46
              Top = 2
              Width = 42
              Height = 40
              Hint = '-'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '-'
            end
            object SpeedButton3: TSpeedButton
              Left = 90
              Top = 2
              Width = 42
              Height = 40
              Hint = '*'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = 'x'
            end
            object SpeedButton4: TSpeedButton
              Left = 134
              Top = 2
              Width = 42
              Height = 40
              Hint = '/'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '/'
            end
            object SpeedButton5: TSpeedButton
              Left = 2
              Top = 46
              Width = 42
              Height = 40
              Hint = '('
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '('
            end
            object SpeedButton6: TSpeedButton
              Left = 46
              Top = 46
              Width = 42
              Height = 40
              Hint = ')'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = ')'
            end
            object SpeedButton7: TSpeedButton
              Left = 90
              Top = 46
              Width = 42
              Height = 40
              Hint = '^'
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '^'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -38
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object SpeedButton8: TSpeedButton
              Left = 134
              Top = 46
              Width = 42
              Height = 40
              Hint = '='
              Margins.Left = 6
              Margins.Top = 6
              Margins.Right = 6
              Margins.Bottom = 6
              Caption = '='
            end
          end
        end
        object Grec: TTabSheet
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 0
          Margins.Bottom = 6
          Caption = 'Grec'
          ImageIndex = 7
          object AlphaSpeedButton: TSpeedButton
            Left = 2
            Top = 2
            Width = 50
            Height = 44
            Hint = '+'
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Caption = #945
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            Margin = 0
            ParentFont = False
          end
          object SpeedButton9: TSpeedButton
            Left = 52
            Top = 2
            Width = 50
            Height = 44
            Hint = '-'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #946
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton10: TSpeedButton
            Left = 100
            Top = 2
            Width = 50
            Height = 44
            Hint = '*'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #964
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton11: TSpeedButton
            Left = 150
            Top = 2
            Width = 50
            Height = 44
            Hint = '/'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #948
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton12: TSpeedButton
            Left = 2
            Top = 48
            Width = 50
            Height = 44
            Hint = '('
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #8486
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton13: TSpeedButton
            Left = 52
            Top = 48
            Width = 50
            Height = 44
            Hint = ')'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #961
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton14: TSpeedButton
            Left = 100
            Top = 48
            Width = 50
            Height = 44
            Hint = '^'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #960
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton15: TSpeedButton
            Left = 150
            Top = 48
            Width = 50
            Height = 44
            Hint = '='
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #966
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton16: TSpeedButton
            Left = 52
            Top = 94
            Width = 50
            Height = 44
            Hint = ')'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #916
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton17: TSpeedButton
            Left = 100
            Top = 94
            Width = 50
            Height = 44
            Hint = '^'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #963
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton18: TSpeedButton
            Left = 150
            Top = 94
            Width = 50
            Height = 44
            Hint = '='
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #949
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton19: TSpeedButton
            Left = 2
            Top = 94
            Width = 50
            Height = 44
            Hint = '('
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #956
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton20: TSpeedButton
            Left = 2
            Top = 140
            Width = 50
            Height = 44
            Hint = '('
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #947
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton21: TSpeedButton
            Left = 52
            Top = 140
            Width = 50
            Height = 44
            Hint = ')'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #951
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton22: TSpeedButton
            Left = 100
            Top = 140
            Width = 50
            Height = 44
            Hint = '^'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #952
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object SpeedButton23: TSpeedButton
            Left = 150
            Top = 140
            Width = 50
            Height = 44
            Hint = '='
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Caption = #968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -34
            Font.Name = 'Segoe UI'
            Font.Style = []
            Layout = blGlyphBottom
            ParentFont = False
          end
          object ListBox1: TListBox
            Left = 2
            Top = 210
            Width = 220
            Height = 114
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Enabled = False
            ExtendedSelect = False
            ItemHeight = 36
            Items.Strings = (
              'Ctrl+G,A  = '#945
              'Ctrl+G,L   = '#955
              'Ctrl+G,Maj+W='#937' ')
            TabOrder = 0
          end
        end
      end
      object ToolBarExpr: TToolBar
        Left = 0
        Top = 0
        Width = 1734
        Height = 75
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        ButtonHeight = 75
        ButtonWidth = 133
        Color = clGradientInactiveCaption
        DrawingStyle = dsGradient
        GradientEndColor = clSkyBlue
        HotTrackColor = clAqua
        Images = VirtualImageList1
        GradientDrawingOptions = [gdoHotTrack]
        ParentColor = False
        ShowCaptions = True
        TabOrder = 3
        object AddBtn: TToolButton
          Left = 0
          Top = 0
          Hint = 'Cr'#233'er grandeur'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajouter'
          ImageIndex = 1
          ImageName = 'Item2'
          OnClick = AddBtnClick
        end
        object HelpBtn: TToolButton
          Left = 133
          Top = 0
          Hint = 'Syntaxe|Ouvre une boite donnant les diff'#233'rentes fonctions'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Syntaxe'
          ImageIndex = 7
          ImageName = 'Item8'
        end
        object MajBtn: TToolButton
          Left = 266
          Top = 0
          Hint = 
            'Calcule les grandeurs cr'#233#233'es ou modifi'#233'es (raccourci : F2 ou Ent' +
            'er pav'#233' num'#233'rique)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Mise '#224' jour'
          ImageIndex = 0
          ImageName = 'Item1'
          OnClick = MajBtnClick
        end
        object ImprimeBtn: TToolButton
          Left = 399
          Top = 0
          Hint = 'Imprimer (Alt+I)|Imprimer texte et '#233'ventuellement les tableaux'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Imprimer'
          ImageIndex = 3
          ImageName = 'Item4'
        end
        object CopierBtn: TToolButton
          Left = 532
          Top = 0
          Hint = 
            'Copier expressions|Copier l'#39#39'ensemble du texte dans le presse-pa' +
            'piers'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Copier'
          ImageIndex = 12
          ImageName = 'Item13'
        end
        object TrigoBtn: TToolButton
          Left = 665
          Top = 0
          Hint = 'radian/degr'#233'|Choix de l'#39'unit'#233' d'#39'angle'
          HelpType = htKeyword
          HelpKeyword = 'Trigonom'#232'trie'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Angle'
          ImageIndex = 6
          ImageName = 'Item7'
        end
        object UniteSIBtn: TToolButton
          Left = 798
          Top = 0
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Pr'#233'fixe'
          ImageIndex = 20
          ImageName = 'Item21'
        end
      end
      object Memo: TRichEdit
        Left = 240
        Top = 215
        Width = 1124
        Height = 935
        Hint = 
          '|Tapez ici les expressions des grandeurs '#224' calculer. Ex. y=2*x+3' +
          ' cr'#233'e y'
        HelpType = htKeyword
        HelpKeyword = 'Expressions'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        PopupMenu = PopupMenuExpr
        ScrollBars = ssBoth
        TabOrder = 4
        WordWrap = False
      end
      object ConstGlbEdit: TRichEdit
        Left = 1364
        Top = 215
        Width = 370
        Height = 935
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alRight
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        TabOrder = 5
        WordWrap = False
      end
    end
    object MathSheet: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'MathPlayer'
      ImageIndex = 21
      ImageName = 'Item22'
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 1734
        Height = 1080
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 1078
        ControlData = {
          4C0000009B590000D03700000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620C000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel2: TPanel
        Left = 0
        Top = 1080
        Width = 1734
        Height = 108
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 1
        object BitBtn1: TBitBtn
          Left = 256
          Top = 38
          Width = 786
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'En cas de probl'#232'me, t'#233'l'#233'charger MathPlayer'
          NumGlyphs = 2
          TabOrder = 0
        end
        object Button1: TButton
          Left = 1088
          Top = 42
          Width = 482
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'D'#233'sactiver MathPlayer'
          TabOrder = 1
        end
      end
    end
    object PythonTS: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Python'
      ImageIndex = 24
      ImageName = 'Item25'
      object PythonSplitter: TSplitter
        Left = 0
        Top = 578
        Width = 1734
        Height = 6
        Cursor = crVSplit
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        AutoSnap = False
        Color = clHighlight
        MinSize = 100
        ParentColor = False
        ExplicitWidth = 1718
      end
      object MemoResultat: TMemo
        Left = 0
        Top = 584
        Width = 1734
        Height = 534
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Color = clBlack
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Pitch = fpFixed
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 0
        Top = 1118
        Width = 1734
        Height = 70
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        TabOrder = 1
        object PythonVersionLabel: TLabel
          Left = 16
          Top = 8
          Width = 260
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Select Python version :'
        end
        object CalcPythonBtn: TButton
          Left = 660
          Top = 8
          Width = 300
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Calculer'
          TabOrder = 1
          OnClick = CalcPythonBtnClick
        end
        object cbPyVersions: TComboBox
          Left = 300
          Top = 8
          Width = 322
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Style = csDropDownList
          TabOrder = 0
        end
        object AidePythonBtn: TButton
          Left = 1200
          Top = 8
          Width = 150
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Aide'
          TabOrder = 2
        end
        object PythonDllBtn: TButton
          Left = 1400
          Top = 8
          Width = 226
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Chemins Lib, DLL'
          TabOrder = 3
        end
        object effaceConsoleBtn: TButton
          Left = 980
          Top = 8
          Width = 200
          Height = 50
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Efface console'
          TabOrder = 4
        end
      end
      object PanelSource: TPanel
        Left = 0
        Top = 0
        Width = 1734
        Height = 578
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        TabOrder = 2
        object ListeGrandeurPython: TListBox
          Left = 1
          Top = 1
          Width = 242
          Height = 576
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alLeft
          ItemHeight = 36
          TabOrder = 0
        end
        object MemoSource: TRichEdit
          Left = 293
          Top = 1
          Width = 1440
          Height = 576
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            
              '#Exemple supposant qu'#39'existent deux variables x et y dans Regres' +
              'si'
            '#et qu'#39'il n'#39'y a pas de variable z qui sera donc cr'#233#233'e.'
            'import Regressi as R'
            'print(R.x)'
            'N=len(R.t)'
            'for i in range(0,N) :'
            '  R.z[i]=R.x[i]+R.y[i]'
            'print(R.z)')
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object NumeroLigneMemo: TRichEdit
          Left = 243
          Top = 1
          Width = 50
          Height = 576
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alLeft
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            '12'
            '15'
            '8')
          ParentFont = False
          TabOrder = 2
        end
      end
    end
  end
  object PopupMenuExpr: TPopupMenu
    Left = 397
    Top = 482
    object CompileItem: TMenuItem
      Caption = 'Mise '#224' jour'
      ShortCut = 113
      OnClick = CompileItemClick
    end
    object CreerGrandeurItem: TMenuItem
      Caption = 'Cr'#233'er grandeur'
      OnClick = AddBtnClick
    end
    object CopierItem: TMenuItem
      Caption = 'Copier'
    end
    object CollerItem: TMenuItem
      Caption = 'Coller'
      OnClick = CollerItemClick
    end
    object ImporterTraitements: TMenuItem
      Caption = 'Importer traitements'
    end
    object RazItem: TMenuItem
      Caption = 'R'#224'&Z'
      OnClick = MajBtnClick
    end
    object Phase: TMenuItem
      Caption = 'Phase'
      Hint = 'Phase|Rend continue unevariable par un modulo 2'#8249
    end
  end
  object MajTimer: TTimer
    Enabled = False
    Interval = 440
    Left = 684
    Top = 510
  end
  object PopupMenuGrid: TPopupMenu
    Left = 541
    Top = 500
    object CreerGrandeurGrid: TMenuItem
      Caption = '&Cr'#233'er grandeur'
      ImageIndex = 1
      Visible = False
      OnClick = AddBtnClick
    end
    object DelGrandeurItem: TMenuItem
      Caption = '&Supprimer grandeur'
      ImageIndex = 2
      OnClick = DeleteBtnClick
    end
    object TrierItem: TMenuItem
      Caption = '&Trier'
      ImageIndex = 8
    end
    object DelSelectItem: TMenuItem
      Caption = 'Supprimer &lignes'
      ImageIndex = 9
    end
    object CopierTableauItem: TMenuItem
      Caption = 'Copier tableau'
      Hint = 'Copier l'#39'ensemble du tableau'
      ImageIndex = 12
    end
    object PhaseItem: TMenuItem
      Caption = 'Phase continue'
      Hint = 'Rendre un angle continu par des modulo 360'#176
      ImageIndex = 13
    end
    object TrigoItem: TMenuItem
      Caption = 'Angle'
    end
    object RandomItemBis: TMenuItem
      Caption = 'Recalculer'
      Hint = 'Hasard|Effectue une nouveau tirage des grandeurs al'#233'atoires (F4)'
      ShortCut = 115
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
              0D0000006B4944415478DAE5D0C10E80200C03D0F5BBE508DF3D634023416607
              C683EE0A7BE90A159527075F0751961553608A4997106453F4840D81163600E6
              137B9813BCC71C208E4F346877C3A56B12EE68BDCCA7EB9C8CCB0E18CCE8B045
              27C11A65B1B7C1FCECC108D03F3F0457F0185FEDA5A7094D0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000734944415478DADDD3D10AC020080550EF77D7E3FA6E07B58D309D8E
              C560F96878302D3031CD0CFC07C48641E6CCB0F23EC8A2B01CA0910F5DF92A56
              8AEA9983A933D4D028F60D28514AFEDCE2606009D3C0F3398DCB5B0AD47E4D1F
              ED237860875630195AB9034527AF3B8CC4A319AE015AB1034C3CA4ED89398F75
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BF4944415478DAAD94D10E85200886E1B93B97FADC06274D40322AD9
              9A53E49B3F1058A0C04A4306222DB4E2275065607BE117A88CFD03332F643FFA
              92B8B8D1A5E60373EEC14E208820F6F0269F811A9805D05385BD281A9ACC4BD8
              7F0733C011DA0362B02930D79C962ABB01EF8A87631F5E41639D30054A28A814
              3C02FAAF5C0694C57929B903BDF6795194E3786C70E18DB78D86C93C46A10390
              2F268899F7EF2BE04C0A0F89CD936852131E5F57C0064D121869076F8C59F9C5
              4A5E613BAACBA6ED9E343D4A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
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
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000564944415478DA63FCCFF09F819A8071D4C02164202303F136FD072B
              C7612029069165204C314C1C5933412F231B864D232179920D24C6A5641B88D3
              1743CB40A234906A203E4D24C7322E43910149E9901A60F01B080040CA4DED4E
              296EFF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000584944415478DA63FCCFF09F819A80717818C8C80051F41FCC1C6C06
              C20CA38981C4188AD74074C3A86620C81062BD8ED340F48818FC06126B285603
              71A53BAA1B488CA1180612CA15036B20B6844C086084F3F0280F4901007B7D53
              ED2DB89BF80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000704944415478DAD5D4D10A80300805D0F9FF1FEDDC20B07115670E96
              2F498B734D22E2C6ADB2E81848D24A4FE5E0B8A207A3617042AB2F0723F83DE0
              B3EB35200C6AC09B7A0B44AF1B02E16EC039BC9705CD8935B81E5A015EF81B64
              65CAD63CD00A4E815E1D063FD6FCBCFEF383ADAA0E9FEDAEED249795FE000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000854944415478DAB5D34B0E80200C04D0F6DCB28473D7889F48A07646
              B1CB161E8611353199591A81A305A6A234780D4A19CE2D2D0A83B5E94011DA81
              1D966EC32C4DDF040173316F5373180AD6A6ECA88BB16078A70E06810C16822C
              C6810016830F89BF02EB8223F1ED1FF45E0705B245A5FCF90BFF09E57CCBB3EE
              F04C1AC12090ADE9E00A3A837AED1E6FD0BB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000774944415478DACD95610AC0200885F55ADE1F3B5653C786BAFDDA5E
              901028D9D7D38478D224A4B12D18D1C47100CD4EBA85EE8F31221691761F93AA
              BEC23CB700395CC201B3C20B0E2BF9D6C3BDC575BF3C869F5D0EEC5008F0D94B
              0070EF92F33CFE0266D0BE25EF3D87CB7AD8933E01096401447F01079816D5ED
              F15A72CB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007C4944415478DA63FCCFF09F819A801188A96622D0718C60038F1D3B
              0617B4B2B26280F191D9D8F8C80024473B03A9EE652040042A5008C6476663E3
              A34406488E6606A2FA1A3914D043045F080D79035BC0347E5083A68FA081D578
              0C6BA5AB81D892462B23612F57A3EB1B3A097BF01B4830F489046003A95D0500
              00A26CBCEDB9CDBE760000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000764944415478DACDD1D10AC020080550FDEE9EFDEE3B8AD85A944B93
              D17D29244E5A0C0245865B9049967450E26510487A072C2AEA02F399B20E5037
              78EF3B740B1CA1EE376C6302859F891230BCC00CE68A1C05B66396512BF8AA55
              7C19D4BE463C606887E77F4A0FF6636E815FF91F34693553302217543AB8EDF9
              9DB5000000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DA63FCCFF09F819A809166063202994036235D0C04C9
              816864796C624419882C0E6363131B380391BD07F322C506A2BB76F07A992AB1
              4C2AA0AD81E892E458806AE07F243381413F120CA400C0D3E5D02960A9050005
              D29CED18BC5ABA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item13'
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
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006E4944415478DAED92510E00110C44F5E4ECC9E9A6D9986DD012F165
              7E64463CD34039E4B05374811272CC39A17F57CCDC40847D209405FD011FB609
              0EE966E213FB482E601B50BDBEF03CD01A59F62746EE3D0AFAA947C1962D2D7D
              1B6C56351ED3046AB0A7D9051E02AE683BB00097427BED730CE2220000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item15'
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
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A04944415478DAC5D4DD0E80200805607D728F4F6EC346A11D2B7F5A
              DCD8747E806CF9E492631111F9C14378060A06842E08881CACB1E4FC99BDD18D
              607247D60264953D818AE9F701B6DABC032D5680A36F267734A124CB2080A169
              6A01141CAD8EED17A0CDC6DE51F75F81F6F1ED65B6FF0FB8BCE5DEA104E092FC
              7B70A6E53D49F04B86A2583E9F052D5680232DD7D805EC198A448D6550FF365D
              620393D8008CD5D7FB46762D010000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006E4944415478DAE5D1490A80300C05D0E4E4A6278FA160B4D821BF15
              04CDA68BF21F195849E9C9E26F83AC9CC3F6F0129824A96C6269C3E8C4A6C01E
              0683C7882D0C02235818740C01FB8B8E7577EBD0D14B18E9AE3A7201141F63AC
              B9C32ABA02A28778077414C086E04CFD10DC01FFA16BED2FBD60FB0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DA63FCCFF09F819A8071E818C80862520080E6306218
              78E0C00130DBC1C19E28430E1C380855EF80DD4006B2BDCF88DD402020CF3846
              3C068224C16142041B993FEAC251178E1C1792651ACCA5E806520B50DD400013
              CEB8ED7812512E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000844944415478DAC590590EC0200805E1641E0D8FE6CDAC34A1B1B844
              5C5A7E8851C6E16184083B0B1988DC262ACD621398CA66825885BE80FC288400
              CEB921A0CCE4D0254399C9A185E1BDC6005CDEEA4CA70DABC61AA87F7D32CABA
              0978CC50DBF6CEDE7B20A28F0DB545EDEEDF0C5B1666E051C35E8EADBCCF1B6E
              052ED1647501EEAC0B9B3AC6EDB58DDDBC0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item20'
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
        Name = 'Item21'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005D4944415478DAED93510AC0200C439B931B4F9EC1AA206393AD14F6
              D3FC486B79244A2193650A05F45648C206E8979F7C15B0803F023116C129429A
              439CD0014478DD6EC3CB3ABB1A1BA2E78CAE6BE475E06D4DD25FEFF953122267
              EA009C1689EE3F72354B0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item22'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008A4944415478DAED924B0EC0200844F1E4CAC96968021969B5A4BA74
              56C4CF73062942423B550ED0C5BA9554252939606B3960AB3920BEBC25721785
              D80FAA7175C58D456BA10F877A506F19D06076F10DFE005ACFEE97A18E30741C
              610EF41F05E0C81D02E35AEF10626E01626CECDFAC873655C3B13197163D3AB2
              3A82A7BFFC77FEA663B3A2035CD7054E0F8EED6BF787030000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'Item23'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007D4944415478DAED944B0EC020084487938B27A77E12AB0236315DB4
              896C4C98E1311B2481E0CDA20C8C1C8539F82E8E100E54066024E8F53EA13627
              23AA71E8B6005A1F802A2953DA2C0AD8961BFA011EE00F80F749594029CFD4DF
              01661F1808C659AE81CE2DD79B77B4F9FB7A82AE6026701CB4CA872D81BBF57D
              E005A5CFC7EDF20F9B760000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DAEDD4C10AC0200C03D0E4CB4DBF3C73631715B60E76
              18AC5EC4529E3D1869186F2E16F837301496DAD821C23289F1E67E606AC2053D
              C1B95E6081976040FB36BDCF347814711F9F47E09A98E85D2D9596EF7F0E1B51
              0296ED665F6B370000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000003924944415478DAAD955D685B6518C77FE79C244DD2A5B16BD3BA2475
              492743F651BC9888E21474F8C52E647E0C1404C7846D5E38063254E6A537622F
              0419142B28E88DDE287833563F07B2521547716B69D7D864B1B569B54993E6E4
              9CF31E9F73526A1BBA5DED1C5E5E78DFE7F99FFFF37F3E8EA61B86AB1C87DBF1
              08169AECEE1657B2D4AD5C6F7ABF0EA8691AAEEBA219215CA7217B1B773FF716
              D1AE64D3C455D8F52AE5D93FC88F0C8BBDE763888FE3C378BE5B02EAD16E54AD
              C49E57060904C3E8810091ED3B70ED866FEA392C5CFD99E9AFDE675BBC9395F2
              3FE2F77FA09B00B5B64EB46008A732C781339FB32C6C0291763A33FBB16B65B1
              74308C20B5A522BF0F9F212C77BD7193624961D9AA0530D88E6B55D7B5D8FDC2
              3BB4F7DC8563AE8A5C0EE178B717189AAE535B2870E593B36215946561E81A4A
              B93E5013508F88D32A7D4F9C627B7640E47204C302C7F6B5F3D8473A7BD14492
              B680CE8F7FE6B97CE453766792FC30FA37CFBC3E4E3C0ACBB50D0C773CF23299
              878F360F04D003F298696BBBB24D89D8261234F83E57247FF24BD2D91E4994C5
              479F5DE7E4BB339B43DE77FC036277F64B88353CF221298B3643A3E1A8264BAF
              025C1B570FF0D3D83885B7BF26D59BC29677726299BDCFFFB619F0DED78645A7
              2E1CCB24249A944C9B89D91284ACA689F212222AE417193AF41DAF1E89086B1D
              A52BE68B55D24FFFD202786A887047378663B224D2F5FF759173CF5E22D92365
              645B3E434F8AA05E2799E8160F03655928F9C8FC8D1AE9C3BFB6847C6C9068A2
              8F98663332B9C0E88BE7B9EFA13D506D34F5F44257DE725166C34F98F2CE4270
              ED6A99FD2F8D6F064C3F7A8CD48127690F687C3B9567E6C417647626A4FEEA18
              9AD741AC270AAF2B54535BDB7218FC38C7D9F3731B013D6B87ECE1D3A4B2F770
              69A2C0F41B17E8CF2670EB0D9FC954AE8265397EE8BAB80475D7AF808B979738
              F15E81444C3AA8B2B1B0A5605DF96A524AB228B53C75E120BB3252EC921C653B
              5C9F5DF101A2218D2B93659E3A3DB9DE04890E9D85726BA7E8D2E846077D5D26
              F9B91AB32307E94B47B044435D5819DB0CC64617292DD579605F8C3B1E1B63EF
              4E8355D325372FBADE6C386493063345876F3E1CE0F143BDD2599272AF4F25C4
              C24C855AD562A56673FFF16BA4BA346E2C8A046BADD7C250F7C59646A061E31F
              0F9DDBC58303713AA2BA9F044706F164AECAD137A7F977D52516D6A8986B6454
              4BC8ADE33324C0F55B0CF2B018D5B798B1DAEDFE05FC078D49C420AD38683400
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item26'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000001F14944415478DACD55BDABF16118BE28221F03594E6291C1EA3F2083
              8F2C3E160B9132182D066220A3456C164928F231590C24659189CC12F98AA2C4
              7B9EE774DEF39ECEEBE33D9DE1BD96A77ECFFD5CDDF775DDF7FD635C5F8127B0
              5EAFC1E3F1C066B3EFC631EE1106020174BB5D8CC7632C974B4AE672B9A056AB
              61341AF1F2F2F298B0DFEFC36C36633E9F2397CBC166B381C562FDBE1F8D4668
              B7DB08854258AD5634B65AAD7E105E2E97EB64328152A944B3D984D56AC5F97C
              462A9582C7E3B959DA6C3683D7EB45BD5EA7D98BC5E237428D46731D0C06B42C
              954A85D3E9844AA502AD56FB8CB488C7E3180E87C8E7F36F84B158EC1A0C0669
              69C56211E9741A76BB1D87C30152A9F42121518CC964A2542AC162B180B1DD6E
              AF32990CAF27CDD060302093C940AFD7A350283C95A540200097CB05918E9A42
              3490482490CBE5D459B7DB0D0E87F3141941ABD5824EA7432412F970399BCDC2
              E1707C72F4596C361B884422984CA6FB7DF82F205DB2DFEFFF53C21F2F391C0E
              231A8DA2D168FC0CE197B679BF201FC8C490C17F165F1AFB9DF0783C5261C952
              2033FDEDD1FB33C34EA7431B94209148C0EFF7DF24BAB91CFEA6E162B180CFE7
              43B95C069FCF8742A1A0734D1EF67A3D1A23140A914C26E1743A3FBDBD6B0A71
              AF56AB613A9D62B7DB7D6FC1DE0259A624DB47BF805F41AD1E9281DFCFAF0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item27'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007B4944415478DAED92010A80200C45B793B59BA9379B275B33739505
              52184438041DFB7B7EA62820D03370003F0C8C1C8588ACC0CC30D184E91C92CC
              7B5D3E177567D59A5E73F10E0FC0D4442B24C3592BCE808ABBCC8B91626001D6
              803AF697B572738810A41BF01587E7196E7379046CBDF26D60F77F38803F06CE
              2D37AEED8C854A2E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item28'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C64944415478DAB595DB11C4200845A1B2D0996E675A190BF191C7A2
              B31A93F1C3C0E580C421C800BA10963CC8C8CA93CD73686264E0617802CB3B36
              1D333003380AFDD51AC07FA1B6A60263884C44D591AC29E0A332EF65F9EA8B21
              40D58B9DBDBBF6508348441B6D98E0413C7E87AA4F70C0EC2402452B0C7D0787
              A590906377E00170681D4D012919D50425F9BD985AA1E4651B58FA756D4117D8
              AF700268F7B0F48560EAC8F7AF1C9A80734F3BC0B1BBD8F6BD77B1C7606DED9B
              C361E9F85A3A60D7FE02BE4A89DDED466F6DEA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item29'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000844944415478DABD94E10EC0100C847BAFE5FDC36359115B3B59B670
              763F10EAD31E812C5998C21620B453B50940CA38A574068510B4B50743628C6E
              5D39188005564403DA0C3BFCAB5E81CE970AF719DA98BAE737E00510B1872C01
              5DE0E9E722D0964E2979B480E061F7711A78BF0C6A86B492B7BD434A86340F1B
              E5F9639C039244071E496CF4ED06F45F120000000049454E44AE426082}
          end>
      end>
    Left = 928
    Top = 680
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
      end>
    ImageCollection = ImageCollection1
    Width = 32
    Height = 32
    Left = 920
    Top = 848
  end
end
