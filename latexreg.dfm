object LatexDlg: TLatexDlg
  Left = 450
  Top = 187
  BorderStyle = bsDialog
  Caption = 'Latex'
  ClientHeight = 846
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 30
  object PanelOption: TPanel
    Left = 308
    Top = 0
    Width = 260
    Height = 674
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 0
    object HelpBtn: TBitBtn
      Left = 26
      Top = 152
      Width = 200
      Height = 58
      HelpContext = 807
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Kind = bkHelp
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 0
      Visible = False
      OnClick = HelpBtnClick
      IsControl = True
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 423
      Width = 258
      Height = 250
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Options'
      TabOrder = 1
      object DateCB: TCheckBox
        Left = 18
        Top = 32
        Width = 208
        Height = 38
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'date'
        TabOrder = 0
      end
    end
    object SaveBtn: TBitBtn
      Left = 26
      Top = 288
      Width = 200
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Enregistrer'
      Kind = bkOK
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 2
      OnClick = SaveBtnClick
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 26
      Top = 18
      Width = 200
      Height = 58
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '&Abandon'
      Kind = bkCancel
      Margin = 2
      NumGlyphs = 2
      Spacing = -1
      TabOrder = 3
      IsControl = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 308
    Height = 674
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    TabOrder = 1
    object GrandeursCB: TCheckBox
      Left = 18
      Top = 18
      Width = 236
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Expressions'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object VariabGB: TGroupBox
      Left = 1
      Top = 59
      Width = 306
      Height = 204
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Variables'
      TabOrder = 1
      object TableauVariabCB: TCheckBox
        Left = 18
        Top = 32
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object ModeleVariabCB: TCheckBox
        Left = 18
        Top = 112
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#233'lisation'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object GrapheVariabCB: TCheckBox
        Left = 18
        Top = 72
        Width = 236
        Height = 36
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
        Left = 18
        Top = 152
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 3
      end
    end
    object ParamGB: TGroupBox
      Left = 1
      Top = 263
      Width = 306
      Height = 168
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = '&Param'#232'tres'
      TabOrder = 2
      object GrapheParamCB: TCheckBox
        Left = 18
        Top = 72
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        TabOrder = 1
      end
      object TableauParamCB: TCheckBox
        Left = 18
        Top = 32
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object ModeleParamCB: TCheckBox
        Left = 18
        Top = 112
        Width = 236
        Height = 36
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
      Top = 431
      Width = 306
      Height = 122
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Fourier'
      TabOrder = 3
      object TableauFourierCB: TCheckBox
        Left = 18
        Top = 32
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object GrapheFourierCB: TCheckBox
        Left = 18
        Top = 72
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object StatistiqueGB: TGroupBox
      Left = 1
      Top = 553
      Width = 306
      Height = 120
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Caption = 'Statistique'
      TabOrder = 4
      object TableauStatCB: TCheckBox
        Left = 18
        Top = 32
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tableau'
        TabOrder = 0
      end
      object GrapheStatCB: TCheckBox
        Left = 18
        Top = 72
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphe'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 760
    Width = 568
    Height = 86
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = 'Titre'
    TabOrder = 2
    object EnteteEdit: TEdit
      Left = 4
      Top = 30
      Width = 550
      Height = 38
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 674
    Width = 568
    Height = 86
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 3
    object PagesBtn: TSpeedButton
      Left = 500
      Top = 22
      Width = 52
      Height = 46
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
      Width = 482
      Height = 84
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
  object SaveDialog: TSaveDialog
    DefaultExt = 'tex'
    Filter = 'Fichier TeX|*.tex'
    Left = 220
    Top = 168
  end
end
