object PageCopyDlg: TPageCopyDlg
  Left = 549
  Top = 83
  HelpContext = 10
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Recopie d'#39'une page'
  ClientHeight = 518
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object LabelY: TLabel
    Left = 16
    Top = 224
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object LabelX: TLabel
    Left = 16
    Top = 160
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object NumPageLabel: TLabel
    Left = 16
    Top = 32
    Width = 341
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Num'#233'ro de la page '#224' recopier'
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 290
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nombre de pages '#224' cr'#233'er'
  end
  object EditX: TEdit
    Left = 96
    Top = 160
    Width = 418
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 1
  end
  object EditY: TEdit
    Left = 94
    Top = 224
    Width = 418
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    TabOrder = 2
  end
  object PageSE: TSpinEdit
    Left = 400
    Top = 16
    Width = 100
    Height = 56
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxValue = 2
    MinValue = 1
    ParentFont = False
    TabOrder = 0
    Value = 1
    OnChange = PageSEChange
  end
  object BoutonsPanel: TPanel
    Left = 528
    Top = 0
    Width = 238
    Height = 518
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 3
    object HelpBtn: TBitBtn
      Left = 18
      Top = 304
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
      TabOrder = 0
      OnClick = HelpBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 18
      Top = 160
      Width = 200
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Abandon'
      Kind = bkCancel
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 1
      IsControl = True
    end
    object OKBtn: TBitBtn
      Left = 18
      Top = 16
      Width = 200
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&OK'
      Kind = bkOK
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 2
      OnClick = OKBtnClick
      IsControl = True
    end
  end
  object OptionsGB: TGroupBox
    Left = 0
    Top = 288
    Width = 514
    Height = 214
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Changement du nombre de points'
    TabOrder = 4
    object Label2: TLabel
      Left = 140
      Top = 100
      Width = 200
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nouveau nombre'
    end
    object Label1: TLabel
      Left = 140
      Top = 48
      Width = 170
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nombre actuel'
    end
    object NmesSpin: TSpinButton
      Left = 468
      Top = 88
      Width = 40
      Height = 54
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
      TabOrder = 0
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
      OnDownClick = NmesSpinDownClick
      OnUpClick = NmesSpinUpClick
    end
    object NewNmesEdit: TEdit
      Left = 360
      Top = 92
      Width = 104
      Height = 44
      Hint = 'Nombre de points'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object OldNmesEdit: TEdit
      Left = 360
      Top = 36
      Width = 104
      Height = 44
      Hint = 'Nombre de points'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object UnsurNSE: TSpinEdit
      Left = 212
      Top = 144
      Width = 100
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 16
      MinValue = 2
      ParentFont = False
      TabOrder = 3
      Value = 2
      OnChange = UnsurNSEChange
    end
    object UnsurNCB: TCheckBox
      Left = 16
      Top = 152
      Width = 194
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Un point sur'
      TabOrder = 4
      OnClick = UnsurNCBClick
    end
  end
  object NbrePageSE: TSpinEdit
    Left = 400
    Top = 80
    Width = 100
    Height = 56
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxValue = 16
    MinValue = 1
    ParentFont = False
    TabOrder = 5
    Value = 1
    OnChange = PageSEChange
  end
end
