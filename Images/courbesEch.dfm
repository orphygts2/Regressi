object EchelleBmpDlg: TEchelleBmpDlg
  Left = 236
  Top = 228
  HelpContext = 47
  BorderStyle = bsDialog
  Caption = 'D'#233'termination de l'#39#233'chelle'
  ClientHeight = 363
  ClientWidth = 950
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
    Width = 950
    Height = 270
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Donn'#233'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ExplicitWidth = 978
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
      Top = 128
      Width = 131
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axe vertical'
    end
    object Label2: TLabel
      Left = 360
      Top = 40
      Width = 62
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Unit'#233
    end
    object LabelEchelle: TLabel
      Left = 666
      Top = 40
      Width = 108
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Extr'#233'mit'#233
    end
    object Label4: TLabel
      Left = 208
      Top = 40
      Width = 98
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Symbole'
    end
    object LabelOrigine: TLabel
      Left = 512
      Top = 40
      Width = 85
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Origine'
    end
    object Label7: TLabel
      Left = 824
      Top = 40
      Width = 129
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Echelle log.'
    end
    object EditY: TEdit
      Left = 666
      Top = 128
      Width = 140
      Height = 44
      Hint = 
        'Longueur vecteur|Longueur du vecteur vertical trac'#233' sur l'#39'image ' +
        'ult'#233'rieurement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 7
    end
    object EditX: TEdit
      Left = 668
      Top = 78
      Width = 140
      Height = 44
      Hint = 
        'Longueur vecteur|Longueur du vecteur horizontal trac'#233' sur l'#39'imag' +
        'e ult'#233'rieurement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 3
    end
    object UniteX: TEdit
      Left = 360
      Top = 78
      Width = 140
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
      Text = 'm'
    end
    object UniteY: TEdit
      Left = 360
      Top = 128
      Width = 140
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 5
      Text = 'm'
    end
    object NomX: TEdit
      Left = 208
      Top = 78
      Width = 140
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      Text = 'X'
    end
    object NomY: TEdit
      Left = 208
      Top = 128
      Width = 140
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      MaxLength = 8
      TabOrder = 4
      Text = 'Y'
    end
    object EditX0: TEdit
      Left = 514
      Top = 78
      Width = 140
      Height = 44
      Hint = 
        'Longueur vecteur|Longueur du vecteur horizontal trac'#233' sur l'#39'imag' +
        'e ult'#233'rieurement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 2
    end
    object EditY0: TEdit
      Left = 512
      Top = 128
      Width = 140
      Height = 44
      Hint = 
        'Longueur vecteur|Longueur du vecteur vertical trac'#233' sur l'#39'image ' +
        'ult'#233'rieurement'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object logxcb: TCheckBox
      Left = 824
      Top = 82
      Width = 110
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 8
    end
    object logycb: TCheckBox
      Left = 824
      Top = 134
      Width = 110
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 9
    end
    object PolaireCB: TCheckBox
      Left = 16
      Top = 180
      Width = 242
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Courbe en polaire'
      TabOrder = 10
      OnClick = PolaireCBClick
    end
    object OrthoCB: TCheckBox
      Left = 432
      Top = 180
      Width = 374
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Axes orthonorm'#233's'
      TabOrder = 11
    end
    object modifPointCB: TCheckBox
      Left = 200
      Top = 230
      Width = 625
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Autoriser la correction locale des points'
      TabOrder = 12
    end
  end
  object OKBtn: TBitBtn
    Left = 90
    Top = 290
    Width = 200
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object BitBtn2: TBitBtn
    Left = 554
    Top = 290
    Width = 200
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
