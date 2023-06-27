object EchelleMecaBmpDlg: TEchelleMecaBmpDlg
  Left = 236
  Top = 228
  HelpContext = 47
  BorderStyle = bsDialog
  Caption = 'D'#233'termination de l'#39#233'chelle'
  ClientHeight = 458
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 854
    Height = 338
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Donn'#233'es'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object LabelX: TLabel
      Left = 16
      Top = 80
      Width = 165
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axe horizontal'
    end
    object LabelY: TLabel
      Left = 16
      Top = 130
      Width = 131
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axe vertical'
    end
    object Label2: TLabel
      Left = 222
      Top = 240
      Width = 62
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233
    end
    object LabelEchelle: TLabel
      Left = 30
      Top = 240
      Width = 80
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Echelle'
    end
    object Label4: TLabel
      Left = 208
      Top = 24
      Width = 98
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Symbole'
    end
    object TeditLabel: TLabel
      Left = 348
      Top = 130
      Width = 105
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Intervalle'
    end
    object TUnitLabel: TLabel
      Left = 512
      Top = 130
      Width = 62
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233
    end
    object EchelleEdit: TEdit
      Left = 22
      Top = 280
      Width = 160
      Height = 44
      Hint = 
        'Longueur vecteur|Longueur du vecteur horizontal trac'#233' sur l'#39'imag' +
        'e ult'#233'rieurement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
    object UniteEdit: TEdit
      Left = 190
      Top = 280
      Width = 146
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      Text = 'm'
    end
    object NomX: TEdit
      Left = 208
      Top = 68
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxLength = 8
      TabOrder = 2
      Text = 'X'
    end
    object NomY: TEdit
      Left = 208
      Top = 120
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxLength = 8
      TabOrder = 3
      Text = 'Y'
    end
    object nomT: TEdit
      Left = 208
      Top = 172
      Width = 128
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxLength = 8
      TabOrder = 6
      Text = 't'
    end
    object EditT: TEdit
      Left = 344
      Top = 172
      Width = 160
      Height = 44
      Hint = 'Incr'#233'ment|Intervalle entre deux points'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 8
    end
    object UniteT: TEdit
      Left = 510
      Top = 172
      Width = 146
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 9
      Text = 's'
    end
    object ReferenceCB: TCheckBox
      Left = 16
      Top = 180
      Width = 180
      Height = 34
      Hint = 
        'Temps ou num'#233'ro|Grandeur permettant de conserver l'#39'ordre d'#39'acqui' +
        'sition des points'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'R'#233'f'#233'rence'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = ReferenceCBClick
    end
    object OKBtn: TBitBtn
      Left = 660
      Top = 68
      Width = 180
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 5
      OnClick = OKBtnClick
    end
    object BitBtn2: TBitBtn
      Left = 660
      Top = 230
      Width = 180
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 7
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 338
    Width = 854
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 112
      Top = 20
      Width = 179
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 's'#233'ries de points'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object NbreSE: TSpinEdit
      Left = 16
      Top = 12
      Width = 82
      Height = 56
      Hint = '|Deux s'#233'rie de points peuvent correspondre '#224' deux courbes'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 3
      MinValue = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 420
    Width = 854
    Height = 38
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Panels = <>
    SimplePanel = True
  end
  object signeYCB: TCheckBox
    Left = 402
    Top = 292
    Width = 258
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Axe Y vers le bas'
    TabOrder = 3
  end
end
