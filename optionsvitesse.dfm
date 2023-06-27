object OptionsVitesseDlg: TOptionsVitesseDlg
  Left = 527
  Top = 266
  HelpContext = 58
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Options des vecteurs'
  ClientHeight = 814
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 448
    Top = 56
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
    TabOrder = 0
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 448
    Top = 226
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
    TabOrder = 1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 448
    Top = 440
    Width = 200
    Height = 54
    HelpContext = 802
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkHelp
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 2
    OnClick = HelpBtnClick
    IsControl = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 814
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    ExplicitHeight = 813
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 430
      Height = 282
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitHeight = 281
      object LabelX: TLabel
        Left = 16
        Top = 16
        Width = 6
        Height = 25
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -22
        Font.Name = 'Regressi'
        Font.Style = []
        ParentFont = False
      end
      object LabelY: TLabel
        Left = 16
        Top = 56
        Width = 6
        Height = 25
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -22
        Font.Name = 'Regressi'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 12
        Top = 94
        Width = 250
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Taille des vecteurs (%)'
      end
      object NbreLabel: TLabel
        Left = 12
        Top = 148
        Width = 293
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Nombre maxi de vecteurs'
      end
      object EchelleVecteurSE: TSpinEdit
        Left = 320
        Top = 72
        Width = 84
        Height = 56
        Hint = 
          'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
          'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 100
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 3
      end
      object NbreSE: TSpinEdit
        Left = 320
        Top = 132
        Width = 84
        Height = 56
        Hint = 
          'Taille en %|1 = toujours 1 pixel; sinon % de la hauteur du graph' +
          'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        EditorEnabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 128
        MinValue = 8
        ParentFont = False
        TabOrder = 1
        Value = 8
      end
      object UseSelectCB: TCheckBox
        Left = 12
        Top = 192
        Width = 390
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'S'#233'lection des points de trac'#233
        TabOrder = 2
      end
      object CouleurPointCB: TCheckBox
        Left = 12
        Top = 236
        Width = 390
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'M'#234'me couleur que les points'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 558
      Width = 430
      Height = 256
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Vecteur "acc'#233'l'#233'ration"'
      TabOrder = 2
      ExplicitTop = 557
      object Label3: TLabel
        Left = 16
        Top = 40
        Width = 204
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coordonn'#233'e sur x'
      end
      object Label5: TLabel
        Left = 16
        Top = 92
        Width = 205
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coordonn'#233'e sur y'
      end
      object AccelerationX: TComboBox
        Tag = 1
        Left = 236
        Top = 40
        Width = 160
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object AccelerationY: TComboBox
        Tag = 1
        Left = 236
        Top = 100
        Width = 160
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ProlongeCB: TCheckBox
        Left = 12
        Top = 212
        Width = 414
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Prolonge le vecteur acc'#233'l'#233'ration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object CouleurAcceleration: TColorBox
        Left = 12
        Top = 156
        Width = 290
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 3
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 282
      Width = 430
      Height = 276
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Vecteur "vitesse"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 281
      object Label1: TLabel
        Left = 16
        Top = 40
        Width = 204
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coordonn'#233'e sur x'
      end
      object Label2: TLabel
        Left = 16
        Top = 92
        Width = 205
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coordonn'#233'e sur y'
      end
      object VitesseX: TComboBox
        Tag = 1
        Left = 236
        Top = 40
        Width = 160
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object VitesseY: TComboBox
        Tag = 1
        Left = 236
        Top = 100
        Width = 160
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object CouleurVitesse: TColorBox
        Left = 12
        Top = 156
        Width = 290
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = [cbStandardColors, cbPrettyNames]
        ItemHeight = 32
        TabOrder = 2
      end
      object ProjeteCB: TCheckBox
        Left = 12
        Top = 212
        Width = 390
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Projette le vecteur vitesse'
        TabOrder = 3
      end
    end
  end
end
