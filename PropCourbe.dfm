object PropCourbeForm: TPropCourbeForm
  Left = 446
  Top = 247
  BorderStyle = bsDialog
  Caption = 'Information'
  ClientHeight = 922
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 192
  TextHeight = 36
  object Grid: TStringGrid
    Left = 0
    Top = 44
    Width = 572
    Height = 274
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    ColCount = 2
    DefaultColWidth = 200
    DefaultRowHeight = 48
    FixedCols = 0
    FixedRows = 0
    TabOrder = 1
    ColWidths = (
      200
      200)
    RowHeights = (
      48
      48
      48
      48
      48)
  end
  object LissageGB: TGroupBox
    Left = 0
    Top = 318
    Width = 572
    Height = 98
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Lissage'
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 208
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nombre de points'
    end
    object OrdreLissageSE: TSpinEdit
      Left = 238
      Top = 32
      Width = 84
      Height = 56
      Hint = '|Filtrage d'#39'ordre 1 avec tau=N*deltat'
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
      MaxValue = 32
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 3
      OnChange = OrdreLissageSEChange
    end
  end
  object DeriveGB: TGroupBox
    Left = 0
    Top = 514
    Width = 572
    Height = 220
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'M'#233'thode de calcul de la d'#233'riv'#233'e'
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 293
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nombre de points utilis'#233's'
    end
    object NbreEdit: TEdit
      Left = 340
      Top = 32
      Width = 50
      Height = 53
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '5'
    end
    object DegreRG: TRadioGroup
      Left = 2
      Top = 134
      Width = 568
      Height = 84
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Type de lissage'
      Columns = 3
      Items.Strings = (
        '&Affine'
        '&Parabolique'
        '&Cubique')
      TabOrder = 1
      OnClick = DegreRGClick
    end
    object NbreSpinButton: TSpinButton
      Left = 396
      Top = 32
      Width = 40
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      DownGlyph.Data = {
        7E040000424D7E04000000000000360400002800000009000000060000000100
        0800000000004800000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
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
      TabOrder = 2
      UpGlyph.Data = {
        7E040000424D7E04000000000000360400002800000009000000060000000100
        0800000000004800000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
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
      OnDownClick = NbreSpinButtonDownClick
      OnUpClick = NbreSpinButtonUpClick
    end
    object ExtrapoleDerCB: TCheckBox
      Left = 16
      Top = 86
      Width = 514
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Calcul de la d'#233'riv'#233'e aux points extr'#234'mes'
      TabOrder = 3
      OnClick = ExtrapoleDerCBClick
    end
  end
  object SplineGB: TGroupBox
    Left = 0
    Top = 416
    Width = 572
    Height = 98
    Hint = '|Plus l'#39'ordre est grand, plus le lissage est proche des points'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Lissage par une B-spline'
    TabOrder = 3
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 186
      Height = 36
      Hint = '|Plus l'#39'ordre est grand, plus le lissage est proche des points'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Ordre de lissage'
    end
    object OrdreSplineSE: TSpinEdit
      Left = 238
      Top = 32
      Width = 84
      Height = 56
      Hint = '|Plus l'#39'ordre est grand, plus le lissage est proche des points'
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
      MaxValue = 7
      MinValue = 3
      ParentFont = False
      TabOrder = 0
      Value = 3
      OnChange = OrdreSplineSEChange
    end
  end
  object TexteGB: TGroupBox
    Left = 0
    Top = 734
    Width = 572
    Height = 178
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Caption = 'Variable texte'
    TabOrder = 5
    object LabelTaille: TLabel
      Left = 16
      Top = 40
      Width = 165
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Taille du texte '
    end
    object NbreLabel: TLabel
      Left = 6
      Top = 106
      Width = 266
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nombre maxi '#224' afficher'
    end
    object SpinEditHauteur: TSpinEdit
      Left = 310
      Top = 36
      Width = 80
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxValue = 8
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 8
      OnChange = SpinEditHauteurChange
    end
    object NbreSE: TSpinEdit
      Left = 310
      Top = 106
      Width = 80
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
      OnChange = NbreSEChange
    end
  end
  object CourbeEdit: TEdit
    Left = 0
    Top = 0
    Width = 572
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    TabOrder = 0
    Text = 'CourbeEdit'
  end
  object Panel1: TPanel
    Left = 0
    Top = 840
    Width = 572
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 6
    object ExitBtn: TBitBtn
      Left = 186
      Top = 16
      Width = 200
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Fermer'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        3333333333333333000033333339033333333333000033333399903333333333
        0000333333999033333333330000333339999903333333330000333399999903
        3333333300003338990399903333333300003389033339903333333300003333
        3333399903333333000033333333339903333333000033333333333990333333
        0000333333333333890333330000333333333333389033330000333333333333
        3339933300003333333333333333333300003333333333333333333300003333
        33333333333333330000}
      ModalResult = 1
      TabOrder = 0
      OnClick = ExitBtnClick
    end
  end
end
