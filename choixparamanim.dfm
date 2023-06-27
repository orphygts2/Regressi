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
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
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
    Kind = bkCancel
    NumGlyphs = 2
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
    ExplicitTop = 353
    ExplicitWidth = 954
  end
end
