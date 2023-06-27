object indicateurDlg: TindicateurDlg
  Left = 304
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Indicateurs acide base'
  ClientHeight = 362
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 854
    Height = 114
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    OnPaint = PaintBox1Paint
  end
  object Label2: TLabel
    Left = 16
    Top = 128
    Width = 157
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Couleur acide'
  end
  object Label3: TLabel
    Left = 640
    Top = 128
    Width = 150
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Couleur base'
  end
  object Bevel: TBevel
    Left = 0
    Top = 280
    Width = 854
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
  end
  object acideCB: TColorBox
    Left = 16
    Top = 160
    Width = 200
    Height = 42
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
    ItemHeight = 36
    TabOrder = 0
    OnChange = acideCBChange
  end
  object baseCB: TColorBox
    Left = 640
    Top = 160
    Width = 200
    Height = 42
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
    ItemHeight = 36
    TabOrder = 1
    OnChange = baseCBChange
  end
  object nomEdit: TLabeledEdit
    Left = 340
    Top = 160
    Width = 280
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 56
    EditLabel.Height = 36
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'Nom'
    TabOrder = 2
    Text = ''
    OnExit = nomEditChange
    OnKeyDown = nomEditKeyDown
  end
  object IndicateurCB: TComboBox
    Left = 340
    Top = 220
    Width = 280
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    DropDownCount = 12
    TabOrder = 3
    OnChange = IndicateurCBChange
  end
  object pkaEdit: TLabeledEdit
    Left = 230
    Top = 160
    Width = 98
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 43
    EditLabel.Height = 36
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'pKa'
    TabOrder = 4
    Text = ''
    OnChange = pkaseChange
  end
  object SaveBtn: TBitBtn
    Left = 232
    Top = 296
    Width = 180
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003777777777777777777300003777000000000000777300003770
      EE07777770EE077300003770EE07777770EE077300003770EE07777770EE0773
      00003770EE60000006EE077300003770EEEEEEEEEEEE077300003770E6000000
      006E077300003770E0FFFFFFFF0E077300003770E0FFFFFFFF0E077300003770
      E0F444F44F0E077300003770E0FFFFFFFF0E07730000377000F444444F000773
      0000377070FFFFFFFF0707730000377700000000000077730000377777777777
      77777773000030000000000000000003000030F0CCCCCCCCCC0F0F0300003333
      33333333333333330000}
    TabOrder = 5
    OnClick = SaveBtnClick
  end
  object AddBtn: TBitBtn
    Left = 20
    Top = 296
    Width = 180
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Ajouter'
    Glyph.Data = {
      CE000000424DCE0000000000000076000000280000000B0000000B0000000100
      0400000000005800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333330
      0000333322233330000033332A233330000033332A233330000032222A222230
      000032AAAAAAA230000032222A222230000033332A233330000033332A233330
      000033332223333000003333333333300000}
    TabOrder = 6
    OnClick = AddClick
  end
  object dpkaEdit: TLabeledEdit
    Left = 230
    Top = 220
    Width = 98
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    EditLabel.Width = 58
    EditLabel.Height = 44
    EditLabel.Margins.Left = 6
    EditLabel.Margins.Top = 6
    EditLabel.Margins.Right = 6
    EditLabel.Margins.Bottom = 6
    EditLabel.Caption = 'dpKa'
    LabelPosition = lpLeft
    TabOrder = 7
    Text = ''
    OnChange = dpkaEditChange
  end
  object BitBtn1: TBitBtn
    Left = 660
    Top = 296
    Width = 180
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 8
  end
  object ResetBtn: TBitBtn
    Left = 446
    Top = 296
    Width = 180
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'R'#224'Z'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003333333333333333333300003333334444443333333300003243
      342222224433333300003224422222222243333300003222222AAAAA22243333
      0000322222A33333A222433300003222223333333A2243330000322222233333
      3A44433300003AAAAAAA33333333333300003333333333333333333300003333
      333333334444443300003A444333333A2222243300003A2243333333A2222433
      000033A22433333442222433000033A222444442222224330000333A22222222
      22AA243300003333AA222222AA33A3330000333333AAAAAA3333333300003333
      33333333333333330000}
    TabOrder = 9
    OnClick = ResetBtnClick
  end
end
