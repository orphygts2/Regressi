object FgrapheEuler: TFgrapheEuler
  Left = 103
  Top = 200
  Cursor = crCross
  HelpContext = 22
  Caption = 'Ajustement de donn'#233'es exp'#233'rimentales par la m'#233'thode d'#39'Euler'
  ClientHeight = 1222
  ClientWidth = 1646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
    FF88FF88FF8887770F770F770F77FF888888888888880F888888888888888788
    88888888888887FF888888FF8888FFCCF88888CC88880FCCF88888CCF8888788
    CF888C88CFF887888CFFC8888CF8FF8888CCF88888CF0F8888CCF888888C8788
    8888888888888788888888888888FF888888888888880F888888888888880000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShortCut = FormShortCut
  PixelsPerInch = 192
  TextHeight = 36
  object SplitterModele: TSplitter
    Left = 450
    Top = 0
    Width = 10
    Height = 1222
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Beveled = True
    Color = clBtnFace
    MinSize = 200
    ParentColor = False
    OnCanResize = SplitterModeleCanResize
  end
  object PanelModele: TPanel
    Left = 0
    Top = 0
    Width = 450
    Height = 1222
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 1221
    object PanelAjuste: TPanel
      Left = 0
      Top = 690
      Width = 450
      Height = 196
      HelpContext = 603
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clSilver
      TabOrder = 1
      object DeltatLabel: TLabel
        Left = 16
        Top = 12
        Width = 129
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'DeltatLabel'
      end
      object Panel10: TPanel
        Tag = 6
        Left = 2
        Top = 140
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 0
        Visible = False
        object SpeedButton41: TSpeedButton
          Tag = 1
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton42: TSpeedButton
          Tag = 1
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton43: TSpeedButton
          Tag = 1
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton44: TSpeedButton
          Tag = 1
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton45: TSpeedButton
          Tag = 1
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton6: TSpeedButton
          Tag = 1
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object EditValeur1: TEdit
          Tag = 1
          Left = 160
          Top = 0
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
      object Panel11: TPanel
        Tag = 5
        Left = 2
        Top = 96
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 1
        Visible = False
        object SpeedButton36: TSpeedButton
          Tag = 2
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton37: TSpeedButton
          Tag = 2
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton38: TSpeedButton
          Tag = 2
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton39: TSpeedButton
          Tag = 2
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton40: TSpeedButton
          Tag = 2
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton5: TSpeedButton
          Tag = 2
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object Edit8: TEdit
          Tag = 2
          Left = 160
          Top = 0
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
      object Panel9: TPanel
        Tag = 4
        Left = 2
        Top = 52
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 2
        Visible = False
        object SpeedButton31: TSpeedButton
          Tag = 3
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton32: TSpeedButton
          Tag = 3
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton33: TSpeedButton
          Tag = 3
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton34: TSpeedButton
          Tag = 3
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton35: TSpeedButton
          Tag = 3
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton4: TSpeedButton
          Tag = 3
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object Edit7: TEdit
          Tag = 3
          Left = 160
          Top = 0
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
    end
    object MemoModeleGB: TGroupBox
      Left = 0
      Top = 0
      Width = 450
      Height = 690
      Hint = '|Tapez ici l'#39'expression du mod'#232'le. Ex. y(x)=a*x+b'
      HelpType = htKeyword
      HelpKeyword = 'Mod'#233'lisation'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Expression du mod'#232'le'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 198
        Width = 236
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Valeurs initiales (i=0)'
      end
      object MajBtn: TSpeedButton
        Left = 6
        Top = 142
        Width = 354
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mise '#224' jour'
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
        OnClick = MajBtnClick
      end
      object iBtn: TSpeedButton
        Left = 16
        Top = 34
        Width = 60
        Height = 44
        Hint = '+'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '[i]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object iMoinsBtn: TSpeedButton
        Left = 76
        Top = 34
        Width = 60
        Height = 44
        Hint = '-'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '[i-1]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object DeltatBtn: TSpeedButton
        Left = 136
        Top = 34
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object Label2: TLabel
        Left = 16
        Top = 434
        Width = 203
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'For i := 1 to N do '
      end
      object NbrePasLabel: TLabel
        Left = 16
        Top = 390
        Width = 259
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'N : nombre de pas : 12'
      end
      object VarBtn: TSpeedButton
        Left = 196
        Top = 34
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object tBtn: TSpeedButton
        Left = 256
        Top = 34
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object SpeedButton7: TSpeedButton
        Left = 16
        Top = 86
        Width = 60
        Height = 44
        Hint = '+'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '='
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object SpeedButton8: TSpeedButton
        Left = 76
        Top = 86
        Width = 60
        Height = 44
        Hint = '-'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object SpeedButton9: TSpeedButton
        Left = 136
        Top = 86
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object SpeedButton10: TSpeedButton
        Left = 196
        Top = 86
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = iBtnClick
      end
      object SpeedButton11: TSpeedButton
        Left = 256
        Top = 86
        Width = 60
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -38
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        OnClick = iBtnClick
      end
      object memoModele: TRichEdit
        Left = 2
        Top = 488
        Width = 446
        Height = 200
        Hint = '|Tapez ici l'#39'expression du mod'#232'le. Ex. v[i]=v[i-1]+'#8211't*a'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        WordWrap = False
        OnChange = MemoModeleChange
        OnKeyDown = memoModeleKeyDown
        OnKeyPress = MemoModeleKeyPress
        OnSelectionChange = MemoModeleChange
      end
      object Panel6: TPanel
        Tag = 1
        Left = 2
        Top = 244
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 1
        Visible = False
        object SpeedButton16: TSpeedButton
          Tag = 6
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton17: TSpeedButton
          Tag = 6
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton18: TSpeedButton
          Tag = 6
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton19: TSpeedButton
          Tag = 6
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton20: TSpeedButton
          Tag = 6
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton1: TSpeedButton
          Tag = 6
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object Edit4: TEdit
          Tag = 6
          Left = 160
          Top = -2
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
      object Panel7: TPanel
        Tag = 2
        Left = 2
        Top = 288
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 2
        Visible = False
        object SpeedButton21: TSpeedButton
          Tag = 5
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton22: TSpeedButton
          Tag = 5
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton23: TSpeedButton
          Tag = 5
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton24: TSpeedButton
          Tag = 5
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton25: TSpeedButton
          Tag = 5
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton2: TSpeedButton
          Tag = 5
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object Edit5: TEdit
          Tag = 5
          Left = 160
          Top = 0
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
      object Panel8: TPanel
        Tag = 3
        Left = 2
        Top = 332
        Width = 442
        Height = 42
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Alignment = taLeftJustify
        Caption = 'abcdef'
        TabOrder = 3
        Visible = False
        object SpeedButton26: TSpeedButton
          Tag = 4
          Left = 80
          Top = 0
          Width = 40
          Height = 40
          Hint = '/2|Divise le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton27: TSpeedButton
          Tag = 4
          Left = 120
          Top = 0
          Width = 40
          Height = 40
          Hint = '-2%|Diminue le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '<'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = MoinsBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton28: TSpeedButton
          Tag = 4
          Left = 320
          Top = 0
          Width = 40
          Height = 40
          Hint = 'x2|Multiplie le param'#232'tre par 2'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusRapideBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton29: TSpeedButton
          Tag = 4
          Left = 280
          Top = 0
          Width = 40
          Height = 40
          Hint = '+2%|Augmente le param'#232'tre de 2 %'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -26
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PlusBtnClick
          OnMouseDown = ParamBtnMouseDown
          OnMouseUp = ParamBtnMouseUp
        end
        object SpeedButton30: TSpeedButton
          Tag = 4
          Left = 360
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Changer le signe du param'#232'tre'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = #177
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = SigneBtnClick
        end
        object SpeedButton3: TSpeedButton
          Tag = 4
          Left = 398
          Top = 0
          Width = 40
          Height = 40
          Hint = '|Affecte comme valeur initiale la valeur exp'#233'rimentale'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -32
          Font.Name = 'Regressi'
          Font.Style = [fsBold]
          Layout = blGlyphBottom
          ParentFont = False
          OnClick = ValeurInitClick
        end
        object Edit6: TEdit
          Tag = 4
          Left = 160
          Top = 0
          Width = 120
          Height = 44
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          TabOrder = 0
          Text = '0.123456'
          OnExit = EditValeurExit
          OnKeyDown = EditValeurKeyDown
          OnKeyPress = EditValeurKeyPress
        end
      end
      object NpasSB: TSpinButton
        Left = 334
        Top = 384
        Width = 40
        Height = 50
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        DownGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000008080000080800000808000000000000080800000808000008080000080
          8000008080000080800000808000000000000000000000000000008080000080
          8000008080000080800000808000000000000000000000000000000000000000
          0000008080000080800000808000000000000000000000000000000000000000
          0000000000000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        TabOrder = 4
        UpGlyph.Data = {
          0E010000424D0E01000000000000360000002800000009000000060000000100
          200000000000D800000000000000000000000000000000000000008080000080
          8000008080000080800000808000008080000080800000808000008080000080
          8000000000000000000000000000000000000000000000000000000000000080
          8000008080000080800000000000000000000000000000000000000000000080
          8000008080000080800000808000008080000000000000000000000000000080
          8000008080000080800000808000008080000080800000808000000000000080
          8000008080000080800000808000008080000080800000808000008080000080
          800000808000008080000080800000808000}
        OnDownClick = NpasSBDownClick
        OnUpClick = NpasSBUpClick
      end
    end
    object ResultatGB: TGroupBox
      Left = 0
      Top = 886
      Width = 450
      Height = 336
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'R'#233'sultats de la mod'#233'lisation'
      TabOrder = 2
      ExplicitHeight = 335
      object memoResultat: TRichEdit
        Left = 2
        Top = 38
        Width = 446
        Height = 296
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitHeight = 295
      end
    end
  end
  object PanelCentral: TPanel
    Left = 460
    Top = 0
    Width = 1186
    Height = 1222
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 1
    ExplicitWidth = 1172
    ExplicitHeight = 1221
    object PanelPrinc: TPanel
      Tag = 1
      Left = 0
      Top = 56
      Width = 1186
      Height = 1122
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Color = clWindow
      TabOrder = 0
      OnMouseDown = FormMouseDown
      OnMouseMove = FormMouseMove
      OnMouseUp = FormMouseUp
      ExplicitWidth = 1172
      ExplicitHeight = 1121
      object PaintBoxPrinc: TPaintBox
        Tag = 1
        Left = 1
        Top = 1
        Width = 1184
        Height = 1116
        Hint = '|Utiliser le clic droit pour ouvrir le menu local'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        OnMouseDown = FormMouseDown
        OnMouseMove = FormMouseMove
        OnMouseUp = FormMouseUp
        OnPaint = PaintBoxPaint
        ExplicitLeft = 2
        ExplicitTop = 2
        ExplicitWidth = 1182
        ExplicitHeight = 1104
      end
      object Bevel: TBevel
        Left = 1
        Top = 1117
        Width = 1184
        Height = 4
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        ExplicitLeft = 2
        ExplicitTop = 1106
        ExplicitWidth = 1182
      end
    end
    object HeaderXY: TStatusBar
      Left = 0
      Top = 1178
      Width = 1186
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Panels = <>
      ParentFont = True
      UseSystemFont = False
      Visible = False
      ExplicitTop = 1177
      ExplicitWidth = 1172
    end
    object ToolBar: TToolBar
      Left = 0
      Top = 0
      Width = 1186
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      ButtonHeight = 52
      ButtonWidth = 176
      Color = clBtnFace
      Customizable = True
      EdgeBorders = [ebTop, ebBottom]
      GradientEndColor = clSkyBlue
      HideClippedButtons = True
      HotTrackColor = clAqua
      ParentColor = False
      ShowCaptions = True
      TabOrder = 1
      Wrapable = False
      ExplicitWidth = 1172
      object CoordonneesBtn: TToolButton
        Left = 0
        Top = 0
        Hint = 'Coordonn'#233'es'
        HelpKeyword = 'Coordonn'#233'es'
        HelpContext = 804
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coordonn'#233'es'
        ImageIndex = 14
        OnClick = CoordonneesItemClick
      end
      object ToolButton20: TToolButton
        Left = 176
        Top = 0
        Width = 8
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 26
        Style = tbsSeparator
      end
      object ZommAvantBtn: TToolButton
        Left = 184
        Top = 0
        Hint = 'Loupe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Loupe'
        ImageIndex = 10
        OnClick = ZoomAvantItemClick
      end
      object ZoomAutoBtn: TToolButton
        Left = 360
        Top = 0
        Hint = 'Echelle automatique'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Echelle auto'
        ImageIndex = 11
        OnClick = ZoomAutoItemClick
      end
      object ToolButton9: TToolButton
        Left = 536
        Top = 0
        Width = 8
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ImageIndex = 18
        Style = tbsSeparator
      end
      object ImprimeBtn: TToolButton
        Left = 544
        Top = 0
        Hint = 'Imprimer|Imprimer le graphe'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Imprimer'
        ImageIndex = 12
        OnClick = ImprModeleBtnClick
      end
      object CopierBtn: TToolButton
        Left = 720
        Top = 0
        Hint = 'Copier graphe|Copier le graphe dans le presse-papiers'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Copier graphe'
        ImageIndex = 13
        PopupMenu = MenuAxes
        Style = tbsDropDown
        OnClick = CopierItemClick
      end
      object ToolButton1: TToolButton
        Left = 927
        Top = 0
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Aide'
        ImageIndex = 1
        OnClick = ToolButton1Click
      end
    end
  end
  object MenuAxes: TPopupMenu
    Left = 368
    Top = 56
    object ClipBitmapItem: TMenuItem
      Caption = 'copier comme &Bitmap'
      ImageIndex = 21
      OnClick = ClipBitmapItemClick
    end
    object copierAsJPEGitem: TMenuItem
      Caption = 'copier comme &JPEG'
      OnClick = copierAsJPEG
    end
    object ClipMetafileItem: TMenuItem
      Caption = 'copier comme &M'#233'tafichier'
      OnClick = CopierItemClick
    end
    object SauverGraphe: TMenuItem
      Caption = '&Enregistrer'
      GroupIndex = 1
      ImageIndex = 36
      OnClick = SauverGrapheClick
    end
  end
  object MajTimer: TTimer
    Enabled = False
    Interval = 600
    OnTimer = MajTimerTimer
    Left = 456
    Top = 74
  end
  object SaveDialog: TSaveDialog
    Filter = 
      'Bitmap |*.bmp|Postscript|*.eps|format HPGL|*.plt|format JPEG|*.j' +
      'pg|M'#233'tafichier Windows|*.emf'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 398
    Top = 136
  end
  object RepeatTimer: TTimer
    Enabled = False
    OnTimer = RepeatTimerTimer
    Left = 555
    Top = 69
  end
end
