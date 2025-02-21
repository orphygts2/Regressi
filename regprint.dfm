object PrintDlg: TPrintDlg
  Left = 467
  Top = 189
  HelpContext = 39
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Impression'
  ClientHeight = 947
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 192
  TextHeight = 36
  object PanelOption: TPanel
    Left = 234
    Top = 0
    Width = 264
    Height = 669
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -26
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 248
    ExplicitHeight = 670
    object CopiesLabel: TLabel
      Left = 32
      Top = 358
      Width = 210
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Nombre de copies'
    end
    object PrintBtn: TBitBtn
      Left = 28
      Top = 6
      Width = 220
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Imprimer'
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
      OnClick = PrintBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 24
      Top = 96
      Width = 220
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
      Left = 24
      Top = 184
      Width = 220
      Height = 54
      HelpContext = 807
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
    object PrintGB: TGroupBox
      Left = 1
      Top = 438
      Width = 262
      Height = 232
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Imprimer'
      TabOrder = 3
      ExplicitTop = 437
      object DateCB: TCheckBox
        Left = 16
        Top = 32
        Width = 194
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'date courante'
        TabOrder = 0
      end
      object NomFichierCB: TCheckBox
        Left = 16
        Top = 72
        Width = 238
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'nom du fichier'
        TabOrder = 1
      end
      object GridPrintCB: TCheckBox
        Left = 16
        Top = 112
        Width = 238
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'grilles de tableau'
        TabOrder = 2
      end
    end
    object CopiesSE: TSpinEdit
      Left = 80
      Top = 290
      Width = 82
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
      MaxValue = 32
      MinValue = 1
      ParentFont = False
      TabOrder = 4
      Value = 25
    end
  end
  object PanelOptions: TPanel
    Left = 0
    Top = 0
    Width = 234
    Height = 669
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 248
    ExplicitHeight = 670
    object GrandeursCB: TCheckBox
      Left = 16
      Top = 16
      Width = 220
      Height = 34
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Expressions'
      TabOrder = 0
    end
    object VariabGB: TGroupBox
      Left = 1
      Top = 100
      Width = 260
      Height = 190
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Variables'
      TabOrder = 1
      ExplicitTop = 99
      ExplicitWidth = 246
      object TableauVariabCB: TCheckBox
        Left = 16
        Top = 32
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object ModeleVariabCB: TCheckBox
        Left = 16
        Top = 112
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'lisation'
        TabOrder = 2
      end
      object GrapheVariabCB: TCheckBox
        Left = 16
        Top = 72
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object TangenteCB: TCheckBox
        Left = 16
        Top = 152
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 3
      end
    end
    object ParamGB: TGroupBox
      Left = 1
      Top = 290
      Width = 260
      Height = 152
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Param'#232'tres'
      TabOrder = 2
      ExplicitTop = 289
      ExplicitWidth = 246
      object GrapheParamCB: TCheckBox
        Left = 16
        Top = 72
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        TabOrder = 1
      end
      object TableauParamCB: TCheckBox
        Left = 16
        Top = 32
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object ModeleParamCB: TCheckBox
        Left = 16
        Top = 112
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'lisation'
        TabOrder = 2
      end
    end
    object FourierGB: TGroupBox
      Left = 1
      Top = 442
      Width = 260
      Height = 114
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Fourier'
      TabOrder = 3
      ExplicitTop = 441
      ExplicitWidth = 246
      object TableauFourierCB: TCheckBox
        Left = 16
        Top = 32
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object GrapheFourierCB: TCheckBox
        Left = 16
        Top = 72
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        TabOrder = 1
      end
    end
    object StatistiqueGB: TGroupBox
      Left = 1
      Top = 556
      Width = 260
      Height = 114
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Statistique'
      TabOrder = 4
      ExplicitTop = 555
      ExplicitWidth = 246
      object TableauStatCB: TCheckBox
        Left = 16
        Top = 32
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object GrapheStatCB: TCheckBox
        Left = 16
        Top = 72
        Width = 220
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        TabOrder = 1
      end
    end
  end
  object EnteteGB: TGroupBox
    Left = 0
    Top = 849
    Width = 498
    Height = 98
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'En-t'#234'te d'#39'impression'
    TabOrder = 4
    ExplicitTop = 850
    ExplicitWidth = 512
    object EnteteEdit: TEdit
      Left = 2
      Top = 38
      Width = 522
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 508
      ExplicitHeight = 44
    end
  end
  object ImprimanteGB: TGroupBox
    Left = 0
    Top = 669
    Width = 498
    Height = 96
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Imprimante'
    TabOrder = 3
    object PrinterBtn: TSpeedButton
      Left = 480
      Top = 28
      Width = 50
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 3
      ImageName = 'Item4'
      Images = FValeurs.VirtualImageList1
      OnClick = PrinterBtnClick
    end
    object PrintCB: TComboBox
      Left = 2
      Top = 36
      Width = 472
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Style = csDropDownList
      TabOrder = 0
      OnChange = PrintCBChange
    end
  end
  object PanelPages: TPanel
    Left = 0
    Top = 765
    Width = 498
    Height = 84
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 766
    ExplicitWidth = 512
    object PagesBtn: TSpeedButton
      Left = 480
      Top = 20
      Width = 50
      Height = 50
      Hint = 'Choix|Choix des pages superpos'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 17
      ImageName = 'Item18'
      Images = FRegressiMain.VirtualImageList1
      OnClick = PagesBtnClick
    end
    object GraphePageRG: TRadioGroup
      Left = 1
      Top = 1
      Width = 472
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Caption = 'Options pages'
      Columns = 2
      Ctl3D = True
      Items.Strings = (
        'Page courante'
        'Choix des pages')
      ParentCtl3D = False
      TabOrder = 0
      OnClick = GraphePageRGClick
    end
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 232
    Top = 280
  end
end
