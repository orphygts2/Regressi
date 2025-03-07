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
    ImageIndex = 6
    ImageName = 'Item7'
    Images = FRegressiMain.VirtualImageList1
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
    ImageIndex = 42
    ImageName = 'Plus0'
    Images = FRegressiMain.VirtualImageList1
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
    ImageIndex = 41
    ImageName = 'reset'
    Images = FRegressiMain.VirtualImageList1
    TabOrder = 9
    OnClick = ResetBtnClick
  end
end
