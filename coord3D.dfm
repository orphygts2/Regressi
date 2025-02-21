object Fcoordonnees3D: TFcoordonnees3D
  Left = 277
  Top = 180
  HelpContext = 804
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Coordonn'#233'es du graphe'
  ClientHeight = 440
  ClientWidth = 818
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
  object BoutonsPanel: TPanel
    Left = 575
    Top = 0
    Width = 243
    Height = 440
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 0
    ExplicitLeft = 561
    ExplicitHeight = 439
    object OKBtn: TBitBtn
      Left = 12
      Top = 34
      Width = 200
      Height = 58
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
      Left = 12
      Top = 164
      Width = 200
      Height = 58
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
  end
  object CoordPanel: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 440
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    ExplicitWidth = 561
    ExplicitHeight = 439
    object AbscisseGB: TGroupBox
      Left = 0
      Top = 0
      Width = 575
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Abscisse'
      TabOrder = 0
      ExplicitWidth = 561
      object LabelZeroX: TLabel
        Left = 200
        Top = 28
        Width = 125
        Height = 36
        Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Z'#233'ro inclus'
      end
      object ListeX: TComboBox
        Tag = 1
        Left = 16
        Top = 48
        Width = 160
        Height = 44
        Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 0
      end
      object ZeroXCB: TCheckBox
        Left = 220
        Top = 60
        Width = 30
        Height = 30
        Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
      end
    end
    object OrdonneeGB: TGroupBox
      Left = 0
      Top = 208
      Width = 575
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Ordonn'#233'e (en profondeur)'
      TabOrder = 2
      ExplicitWidth = 561
      object labelZeroY: TLabel
        Left = 200
        Top = 28
        Width = 125
        Height = 36
        Hint = '|Inclure le z'#233'ro sur l'#39'axe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Z'#233'ro inclus'
      end
      object ListeY: TComboBox
        Tag = 1
        Left = 16
        Top = 48
        Width = 160
        Height = 44
        Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 0
      end
      object ZeroYCB: TCheckBox
        Tag = 1
        Left = 220
        Top = 60
        Width = 30
        Height = 30
        Hint = '|Inclure le z'#233'ro sur l'#39'axe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
      end
      object YParamCB: TCheckBox
        Left = 352
        Top = 58
        Width = 194
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Param'#232'tres'
        TabOrder = 2
        OnClick = YParamCBClick
      end
    end
    object OptionsGB: TGroupBox
      Left = 0
      Top = 312
      Width = 575
      Height = 128
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'Options ligne'
      TabOrder = 3
      ExplicitWidth = 561
      ExplicitHeight = 127
      object LabelWidth: TLabel
        Left = 240
        Top = 56
        Width = 218
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Epaisseur des traits'
      end
      object CouleurCombo: TColorBox
        Left = 6
        Top = 56
        Width = 180
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Selected = clScrollBar
        Style = [cbStandardColors, cbPrettyNames]
        ItemHeight = 30
        TabOrder = 0
      end
      object WidthEcranSE: TSpinEdit
        Left = 470
        Top = 34
        Width = 64
        Height = 56
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
        MaxValue = 5
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
      end
    end
    object CoteGB: TGroupBox
      Left = 0
      Top = 104
      Width = 575
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Cote verticale'
      TabOrder = 1
      ExplicitWidth = 561
      object Label1: TLabel
        Left = 200
        Top = 28
        Width = 125
        Height = 36
        Hint = '|Inclure le z'#233'ro sur l'#39'axe horizontal'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Z'#233'ro inclus'
      end
      object ListeZ: TComboBox
        Tag = 1
        Left = 16
        Top = 48
        Width = 160
        Height = 44
        Hint = '|Cliquer sur la fl'#232'che pour choisir la coordonn'#233'e'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 0
      end
      object ZeroZCB: TCheckBox
        Left = 220
        Top = 60
        Width = 30
        Height = 30
        Hint = '|Inclure le z'#233'ro sur la cote'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
      end
    end
  end
end
