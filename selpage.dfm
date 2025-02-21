object SelectPageDlg: TSelectPageDlg
  Left = 655
  Top = 363
  ActiveControl = OKBtn
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Choix des pages actives'
  ClientHeight = 464
  ClientWidth = 998
  Color = clBtnFace
  Constraints.MinHeight = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 730
    Top = 8
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 730
    Top = 212
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 1
    IsControl = True
  end
  object AllBtn: TBitBtn
    Left = 730
    Top = 282
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Cocher &tout'
    ImageIndex = 17
    ImageName = 'Item18'
    Images = FRegressiMain.VirtualImageList1
    TabOrder = 2
    OnClick = AllBtnClick
  end
  object OneBtn: TBitBtn
    Left = 730
    Top = 342
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Cocher &une'
    TabOrder = 3
    OnClick = OneBtnClick
  end
  object PageListBox: TCheckListBox
    Left = 0
    Top = 0
    Width = 722
    Height = 418
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    ItemHeight = 36
    TabOrder = 4
    ExplicitHeight = 417
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 418
    Width = 998
    Height = 46
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Color = clRed
    Panels = <>
    ParentFont = True
    SimplePanel = True
    UseSystemFont = False
    Visible = False
    ExplicitTop = 417
    ExplicitWidth = 984
  end
  object AllOKBtn: TBitBtn
    Left = 730
    Top = 68
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'OK pour toutes'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 6
    OnClick = AllOKBtnClick
  end
  object OneOKBtn: TBitBtn
    Left = 730
    Top = 128
    Width = 240
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'OK pour une'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 7
    OnClick = OneOKBtnClick
  end
end
