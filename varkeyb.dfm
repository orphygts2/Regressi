object NewClavierDlg: TNewClavierDlg
  Left = 388
  Top = 110
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Entr'#233'e de donn'#233'es au clavier'
  ClientHeight = 850
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 38
  object Label1: TLabel
    Left = 8
    Top = 456
    Width = 925
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 
      'La premi'#232're variable est la variable de tri et par d'#233'faut l'#39'absc' +
      'isse du graphe'
  end
  object Label2: TLabel
    Left = 8
    Top = 536
    Width = 763
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Chacune des autres variables d'#233'finit par d'#233'faut une ordonn'#233'e'
  end
  object Label3: TLabel
    Left = 8
    Top = 578
    Width = 692
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Essayez de travailler en S.I. sans pr'#233'fixe m k ... (sauf kg !)'
  end
  object OKBtn: TBitBtn
    Left = 728
    Top = 592
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
    Left = 728
    Top = 672
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
    Left = 728
    Top = 752
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
    Top = 146
    Width = 968
    Height = 312
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
      Top = 40
      Width = 964
      Height = 270
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      DefaultColWidth = 190
      DefaultRowHeight = 52
      DrawingStyle = gdsClassic
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor, goFixedRowDefAlign]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyDown = GridVariabKeyDown
      OnKeyPress = GridVariabKeyPress
      ExplicitWidth = 950
    end
  end
  object ConstGB: TGroupBox
    Left = 4
    Top = 620
    Width = 554
    Height = 212
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Param'#232'tres exp'#233'rimentaux'
    TabOrder = 5
    object GridConst: TStringGrid
      Left = 2
      Top = 40
      Width = 550
      Height = 170
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ColCount = 3
      DefaultColWidth = 180
      DefaultRowHeight = 52
      DrawingStyle = gdsClassic
      FixedCols = 0
      RowCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goTabs, goAlwaysShowEditor, goFixedRowDefAlign]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyDown = GridVariabKeyDown
    end
  end
  object MemoGB: TGroupBox
    Left = 0
    Top = 0
    Width = 968
    Height = 146
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Commentaire'
    TabOrder = 0
    ExplicitWidth = 954
    object MemoClavier: TMemo
      Left = 2
      Top = 40
      Width = 964
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Lines.Strings = (
        '')
      TabOrder = 0
      ExplicitWidth = 950
    end
  end
  object IncrementAutoCB: TCheckBox
    Left = 580
    Top = 496
    Width = 386
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Incr'#233'mentation automatique'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = IncrementAutoCBClick
  end
  object TriCB: TCheckBox
    Left = 8
    Top = 496
    Width = 560
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Tri automatique selon la premi'#232're variable'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
end
