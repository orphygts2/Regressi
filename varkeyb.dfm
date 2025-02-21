object NewClavierDlg: TNewClavierDlg
  Left = 388
  Top = 110
  ActiveControl = OKBtn
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Entr'#233'e de donn'#233'es au clavier'
  ClientHeight = 907
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -30
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  PrintScale = poNone
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 41
  object Label1: TLabel
    Left = 11
    Top = 472
    Width = 884
    Height = 37
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 
      'La premi'#232're variable est la variable de tri et par d'#233'faut l'#39'absc' +
      'isse du graphe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 11
    Top = 552
    Width = 726
    Height = 37
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Chacune des autres variables d'#233'finit par d'#233'faut une ordonn'#233'e'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 11
    Top = 594
    Width = 654
    Height = 37
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Essayez de travailler en S.I. sans pr'#233'fixe m k ... (sauf kg !)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object OKBtn: TBitBtn
    Left = 715
    Top = 668
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 715
    Top = 748
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 715
    Top = 828
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
    OnClick = HelpBtnClick
    IsControl = True
  end
  object VariabGB: TGroupBox
    Left = 0
    Top = 150
    Width = 926
    Height = 320
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Variables exp'#233'rimentales'
    TabOrder = 4
    ExplicitWidth = 954
    object GridVariab: TStringGrid
      Left = 2
      Top = 43
      Width = 950
      Height = 275
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      DefaultColWidth = 190
      DefaultRowHeight = 64
      DrawingStyle = gdsClassic
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor, goFixedRowDefAlign]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyDown = GridVariabKeyDown
      OnKeyPress = GridVariabKeyPress
      ExplicitWidth = 936
      ExplicitHeight = 315
    end
  end
  object ConstGB: TGroupBox
    Left = 2
    Top = 643
    Width = 650
    Height = 240
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Param'#232'tres exp'#233'rimentaux'
    TabOrder = 5
    object GridConst: TStringGrid
      Left = 2
      Top = 43
      Width = 646
      Height = 195
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ColCount = 3
      DefaultColWidth = 180
      DefaultRowHeight = 64
      DrawingStyle = gdsClassic
      FixedCols = 0
      RowCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor, goFixedRowDefAlign]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyDown = GridVariabKeyDown
      OnKeyPress = GridConstKeyPress
      ColWidths = (
        180
        180
        180)
    end
  end
  object MemoGB: TGroupBox
    Left = 0
    Top = 0
    Width = 926
    Height = 150
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Commentaire'
    TabOrder = 0
    ExplicitWidth = 940
    object MemoClavier: TMemo
      Left = 2
      Top = 43
      Width = 936
      Height = 105
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Lines.Strings = (
        '')
      TabOrder = 0
    end
  end
  object IncrementAutoCB: TCheckBox
    Left = 560
    Top = 512
    Width = 426
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Incr'#233'mentation automatique'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = IncrementAutoCBClick
  end
  object TriCB: TCheckBox
    Left = 11
    Top = 512
    Width = 550
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Tri automatique selon la premi'#232're variable'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
end
