object PrintDlg: TPrintDlg
  Left = 467
  Top = 189
  HelpContext = 39
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Impression'
  ClientHeight = 950
  ClientWidth = 540
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
    Left = 276
    Top = 0
    Width = 264
    Height = 672
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
      Left = 24
      Top = 184
      Width = 220
      Height = 54
      HelpContext = 807
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
    object PrintGB: TGroupBox
      Left = 1
      Top = 439
      Width = 262
      Height = 232
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Imprimer'
      TabOrder = 3
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
    Width = 276
    Height = 672
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    TabOrder = 1
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
      Top = 101
      Width = 274
      Height = 190
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Variables'
      TabOrder = 1
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
      Top = 291
      Width = 274
      Height = 152
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Param'#232'tres'
      TabOrder = 2
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
      Top = 443
      Width = 274
      Height = 114
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Fourier'
      TabOrder = 3
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
      Top = 557
      Width = 274
      Height = 114
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Statistique'
      TabOrder = 4
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
    Top = 852
    Width = 540
    Height = 98
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'En-t'#234'te d'#39'impression'
    TabOrder = 4
    object EnteteEdit: TEdit
      Left = 2
      Top = 38
      Width = 536
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 44
    end
  end
  object ImprimanteGB: TGroupBox
    Left = 0
    Top = 672
    Width = 540
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
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003555550FF0559195053300003580
        00FF0555919035330000380FFFF0555591933533000030F00FF0555591933833
        0000300550F05555919358330000308550F0555999995833000035580F085501
        1111553300003550008550333055553300003555555503335055553300003550
        0550333550555533000035050503335550555533000030500033355550555833
        0000300000035555808558330000355000005555808555330000355300008555
        8085553300003553350000055555553300003333333333333333333300003333
        33333333333333330000}
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
    Top = 768
    Width = 540
    Height = 84
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 2
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
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333300003333333333333333333300003333333333333333333300003333
        33333333333333330000333333000000000033330000333330BFBFBFBFB03333
        0000333300FBFBFBFBF0333300003330B0BFBFBFBFB0333300003300F0FBFBFB
        FBF03333000030B0B0BFBFBFBFB03333000030F0F0FBFBFBFBF03333000030B0
        B008999998033333000030F0FB0FBFB0F0333333000030B00080000803333333
        000030FB0FBFB0F0333333330000300089999803333333330000330FBFB03333
        3333333300003380000833333333333300003333333333333333333300003333
        33333333333333330000}
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
