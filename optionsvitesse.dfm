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
    Left = 448
    Top = 226
    Width = 200
    Height = 54
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
    Caption = '&Aide'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888800008888888888888888888800008888888887778888888800008888
      8888600788888888000088888888E60788888888000088888888EE6888888888
      000088888888877788888888000088888888600788888888000088888888E607
      78888888000088888888E660778888880000888888888E660778888800008888
      888878E660778888000088888880778E660788880000888888660778E6078888
      0000888888E66077E608888800008888888E660066688888000088888888E666
      6E8888880000888888888EEEE888888800008888888888888888888800008888
      88888888888888880000}
    Margin = 2
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
