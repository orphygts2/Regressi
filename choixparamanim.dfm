object AnimParamDlg: TAnimParamDlg
  Left = 442
  Top = 170
  HelpContext = 2
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'R'#233'glage des param'#232'tres d'#39'animation'
  ClientHeight = 476
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object ParamGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 754
    Height = 340
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ColCount = 6
    DefaultColWidth = 128
    DefaultRowHeight = 48
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
    ScrollBars = ssVertical
    TabOrder = 0
    OnGetEditText = ParamGridGetEditText
    OnMouseUp = ParamGridMouseUp
    OnSelectCell = ParamGridSelectCell
    ColWidths = (
      128
      128
      128
      128
      128
      128)
    RowHeights = (
      48
      48
      48)
  end
  object BitBtn1: TBitBtn
    Left = 760
    Top = 24
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
  object DesactiveBtn: TBitBtn
    Left = 760
    Top = 174
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Cancel = True
    Caption = '&Annuler'
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
    ModalResult = 2
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 0
    Top = 354
    Width = 968
    Height = 122
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Enabled = False
    Lines.Strings = (
      'Si  Exp. est '#224' :'
      
        '-oui : la variation est exponentielle et le pas est le coefficie' +
        'nt multiplicateur (>1)'
      '-non: la variation est lin'#233'aire et le pas la valeur ajout'#233'e (>0)'
      '')
    TabOrder = 3
  end
end
