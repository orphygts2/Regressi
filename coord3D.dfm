object Fcoordonnees3D: TFcoordonnees3D
  Left = 277
  Top = 180
  HelpContext = 804
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Coordonn'#233'es du graphe'
  ClientHeight = 442
  ClientWidth = 846
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
    Left = 603
    Top = 0
    Width = 243
    Height = 442
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 0
    ExplicitLeft = 703
    object OKBtn: TBitBtn
      Left = 12
      Top = 34
      Width = 200
      Height = 58
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
      Cancel = True
      Caption = '&Abandon'
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
      Margin = 2
      ModalResult = 2
      Spacing = -1
      TabOrder = 1
      IsControl = True
    end
  end
  object CoordPanel: TPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 442
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    ExplicitWidth = 703
    object AbscisseGB: TGroupBox
      Left = 0
      Top = 0
      Width = 603
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Abscisse'
      TabOrder = 0
      ExplicitWidth = 703
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
      Width = 603
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Ordonn'#233'e (en profondeur)'
      TabOrder = 2
      ExplicitWidth = 703
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
      Width = 603
      Height = 130
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'Options ligne'
      TabOrder = 3
      ExplicitWidth = 703
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
      Width = 603
      Height = 104
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Cote verticale'
      TabOrder = 1
      ExplicitWidth = 703
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
