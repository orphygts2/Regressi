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
    Caption = '&OK'
    Default = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333333333333333333300003333
      333333333333333300003333333A0333333333330000333333AAA03333333333
      0000333333AAA03333333333000033333AAAAA033333333300003333AAAAAA03
      3333333300003337AA03AAA0333333330000337A03333AA03333333300003333
      33333AAA0333333300003333333333AA03333333000033333333333AA0333333
      00003333333333337A033333000033333333333337A033330000333333333333
      333AA33300003333333333333333333300003333333333333333333300003333
      33333333333333330000}
    Margin = 2
    ModalResult = 1
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
    Cancel = True
    Caption = '&Abandon'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777888877777
      8877777700007770888777778887777700007911088877910888777700007911
      0088879100888777000079111008891110087777000079911108911111007777
      0000779111101111110777770000777911111111077777770000777991111111
      8777777700007777991111108877777700007777791111108887777700007777
      7911111088877777000077777911111108887777000077779111991100888777
      0000777911108991100888770000777911187799110088870000777111187779
      1110888700007771110777779111087700007779997777777991777700007777
      77777777779977770000}
    Margin = 2
    ModalResult = 2
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
    Caption = '&Aide'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888800008888888888888888888800008888888887778888888800008888
      8888600788888888000088888888E60788888888000088888888EE6888888888
      000088888888877788888888000088888888600788888888000088888888E607
      78888888000088888888E660778888880000888888888E660778888800008888
      888878E660778888000088888880778E660788880000888888660778E6078888
      0000888888E66077E608888800008888888E660066688888000088888888E666
      6E8888880000888888888EEEE888888800008888888888888888888800008888
      88888888888888880000}
    Margin = 2
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
      ExplicitWidth = 537
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
