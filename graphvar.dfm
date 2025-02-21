object FgrapheVariab: TFgrapheVariab
  Left = 103
  Top = 200
  Cursor = crCross
  HelpContext = 25
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Graphe'
  ClientHeight = 1392
  ClientWidth = 2383
  Color = clBtnFace
  DoubleBuffered = True
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  OnShortCut = FormShortCut
  PixelsPerInch = 192
  TextHeight = 36
  object PanelModele: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 1392
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PanelAjuste: TPanel
      Left = 0
      Top = 275
      Width = 460
      Height = 650
      HelpContext = 603
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clSilver
      PopupMenu = PopupMenuModele
      TabOrder = 1
      object ParamScrollBox: TScrollBox
        Left = 0
        Top = 88
        Width = 456
        Height = 558
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        object Panel10: TPanel
          Tag = 10
          Left = 0
          Top = 486
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 0
          Visible = False
          object MoinsRapideBtn: TSpeedButton
            Tag = 10
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object MoinsBtn: TSpeedButton
            Tag = 10
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object PlusRapideBtn: TSpeedButton
            Tag = 10
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object PlusBtn: TSpeedButton
            Tag = 10
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SigneBtn: TSpeedButton
            Tag = 10
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object EditValeur10: TEdit
            Tag = 10
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel3: TPanel
          Tag = 9
          Left = 0
          Top = 432
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 1
          Visible = False
          object SpeedButton1: TSpeedButton
            Tag = 9
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton2: TSpeedButton
            Tag = 9
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton3: TSpeedButton
            Tag = 9
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton4: TSpeedButton
            Tag = 9
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton5: TSpeedButton
            Tag = 9
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit1: TEdit
            Tag = 9
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel4: TPanel
          Tag = 8
          Left = 0
          Top = 378
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 2
          Visible = False
          object SpeedButton6: TSpeedButton
            Tag = 8
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton7: TSpeedButton
            Tag = 8
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton8: TSpeedButton
            Tag = 8
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton9: TSpeedButton
            Tag = 8
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton10: TSpeedButton
            Tag = 8
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit2: TEdit
            Tag = 8
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel5: TPanel
          Tag = 7
          Left = 0
          Top = 324
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 3
          Visible = False
          object SpeedButton11: TSpeedButton
            Tag = 7
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton12: TSpeedButton
            Tag = 7
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton13: TSpeedButton
            Tag = 7
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton14: TSpeedButton
            Tag = 7
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton15: TSpeedButton
            Tag = 7
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit3: TEdit
            Tag = 7
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel6: TPanel
          Tag = 6
          Left = 0
          Top = 270
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 4
          Visible = False
          object SpeedButton16: TSpeedButton
            Tag = 6
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton17: TSpeedButton
            Tag = 6
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton18: TSpeedButton
            Tag = 6
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton19: TSpeedButton
            Tag = 6
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton20: TSpeedButton
            Tag = 6
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit4: TEdit
            Tag = 6
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel7: TPanel
          Tag = 5
          Left = 0
          Top = 216
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 5
          Visible = False
          object SpeedButton21: TSpeedButton
            Tag = 5
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton22: TSpeedButton
            Tag = 5
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton23: TSpeedButton
            Tag = 5
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton24: TSpeedButton
            Tag = 5
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton25: TSpeedButton
            Tag = 5
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit5: TEdit
            Tag = 5
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel8: TPanel
          Tag = 4
          Left = 0
          Top = 162
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 6
          Visible = False
          object SpeedButton26: TSpeedButton
            Tag = 4
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton27: TSpeedButton
            Tag = 4
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton28: TSpeedButton
            Tag = 4
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton29: TSpeedButton
            Tag = 4
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton30: TSpeedButton
            Tag = 4
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit6: TEdit
            Tag = 4
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel9: TPanel
          Tag = 3
          Left = 0
          Top = 108
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 7
          Visible = False
          object SpeedButton31: TSpeedButton
            Tag = 3
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton32: TSpeedButton
            Tag = 3
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton33: TSpeedButton
            Tag = 3
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton34: TSpeedButton
            Tag = 3
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton35: TSpeedButton
            Tag = 3
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit7: TEdit
            Tag = 3
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object Panel11: TPanel
          Tag = 2
          Left = 0
          Top = 54
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 8
          Visible = False
          object SpeedButton36: TSpeedButton
            Tag = 2
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton37: TSpeedButton
            Tag = 2
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton38: TSpeedButton
            Tag = 2
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton39: TSpeedButton
            Tag = 2
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton40: TSpeedButton
            Tag = 2
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object Edit8: TEdit
            Tag = 2
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '0.123456'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
        object PanelParam1: TPanel
          Tag = 1
          Left = 0
          Top = 0
          Width = 456
          Height = 54
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Align = alTop
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeft
          Caption = 'abcdef'
          ParentBiDiMode = False
          TabOrder = 9
          Visible = False
          object SpeedButton41: TSpeedButton
            Tag = 1
            Left = 1
            Top = 1
            Width = 40
            Height = 52
            Hint = '/2|Divise le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8810
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 80
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton42: TSpeedButton
            Tag = 1
            Left = 41
            Top = 1
            Width = 40
            Height = 52
            Hint = '-2%|Diminue le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '<'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = MoinsBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 120
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton43: TSpeedButton
            Tag = 1
            Left = 281
            Top = 1
            Width = 40
            Height = 52
            Hint = 'x2|Multiplie le param'#232'tre par 2'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = #8811
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusRapideBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 360
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton44: TSpeedButton
            Tag = 1
            Left = 241
            Top = 1
            Width = 40
            Height = 52
            Hint = '+2%|Augmente le param'#232'tre de 2 %'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Caption = '>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ParentBiDiMode = False
            OnClick = PlusBtnClick
            OnMouseDown = ParamBtnMouseDown
            OnMouseUp = ParamBtnMouseUp
            ExplicitLeft = 320
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object SpeedButton45: TSpeedButton
            Tag = 1
            Left = 321
            Top = 1
            Width = 40
            Height = 52
            Hint = '|Changer le signe du param'#232'tre'
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            Caption = #177
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Layout = blGlyphBottom
            ParentFont = False
            OnClick = SigneBtnClick
            ExplicitLeft = 400
            ExplicitTop = 0
            ExplicitHeight = 54
          end
          object EditValeur1: TEdit
            Tag = 1
            Left = 81
            Top = 1
            Width = 160
            Height = 52
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            Align = alLeft
            BiDiMode = bdLeftToRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            Text = '01234567'
            OnExit = EditValeurExit
            OnKeyDown = EditValeurKeyDown
            OnKeyPress = EditValeurKeyPress
            ExplicitHeight = 53
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 456
        Height = 88
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object AjusteBtn: TSpeedButton
          Left = 60
          Top = 4
          Width = 200
          Height = 50
          Hint = '|Ajustage automatique des param'#232'tres (F3)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Ajuster'
          ImageIndex = 59
          ImageName = 'AJUSTE'
          Images = ImageList1
          OnClick = AjusteBtnClick
        end
        object MajBtn: TSpeedButton
          Left = 8
          Top = 4
          Width = 50
          Height = 50
          Hint = 
            'Mise '#224' jour|Prise en compte des modifications du mod'#232'le (raccour' +
            'ci clavier F2 ou deux validations) (F2)'
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          ImageIndex = 11
          ImageName = 'Item12'
          Images = ImageList1
          OnClick = MajBtnClick
        end
        object TrigoLabel: TLabel
          Left = 8
          Top = 52
          Width = 126
          Height = 36
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'TrigoLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -26
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object TraceAutoCB: TCheckBox
          Left = 264
          Top = 8
          Width = 168
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Trac'#233' auto. '
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = TraceAutoBtnClick
        end
      end
    end
    object MemoModeleGB: TGroupBox
      Left = 0
      Top = 59
      Width = 460
      Height = 216
      Hint = '|Tapez ici l'#39'expression du mod'#232'le. Ex. y(x)=a*x+b'
      HelpType = htKeyword
      HelpKeyword = 'Mod'#233'lisation'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Expression du mod'#232'le'
      PopupMenu = PopupMenuModele
      TabOrder = 0
      object memoModele: TRichEdit
        Left = 2
        Top = 38
        Width = 456
        Height = 176
        Hint = '|Tapez ici l'#39'expression du mod'#232'le. Ex. y(x)=a*x+b'
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
        Lines.Strings = (
          'Test')
        ParentFont = False
        PopupMenu = PopupMenuModele
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        OnChange = MemoModeleChange
        OnKeyPress = MemoModeleKeyPress
        OnSelectionChange = MemoModeleChange
      end
    end
    object ResultatGB: TGroupBox
      Left = 0
      Top = 925
      Width = 460
      Height = 467
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Caption = 'R'#233'sultats de la mod'#233'lisation'
      PopupMenu = PopupMenuModele
      TabOrder = 2
      object memoResultat: TRichEdit
        Left = 2
        Top = 38
        Width = 456
        Height = 427
        Cursor = crArrow
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Color = clCream
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -26
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Test')
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenuModele
        ReadOnly = True
        ScrollBars = ssBoth
        ShowHint = False
        TabOrder = 0
        WordWrap = False
        OnMouseMove = memoResultatMouseMove
      end
    end
    object ModeleToolBar: TToolBar
      Left = 0
      Top = 0
      Width = 460
      Height = 59
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      ButtonHeight = 57
      ButtonWidth = 102
      Flat = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Segoe UI'
      Font.Style = []
      HotTrackColor = clTeal
      Images = ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 3
      Wrapable = False
      object OptionsModeleBtn: TToolButton
        Left = 0
        Top = 0
        Hint = 'Options de mod'#233'lisation '
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Options'
        DropdownMenu = PopupMenuModele
        ImageIndex = 12
        ImageName = 'Item13'
        PopupMenu = PopupMenuModele
        OnClick = OptionsModeleBtnClick
      end
      object ModeleGrBtn: TToolButton
        Left = 102
        Top = 0
        Hint = 
          'Mod'#233'lisation graphique|Mod'#233'lisation '#224' l'#39'aide de la souris '#224' part' +
          'ir de mod'#232'les pr'#233'd'#233'finis'
        HelpType = htKeyword
        HelpKeyword = 'Mod'#233'lisation graphique'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#232'les'
        DropdownMenu = ModeleMenu
        ImageIndex = 5
        ImageName = 'Item6'
        PopupMenu = ModeleMenu
        OnClick = CurseurBtnClick
      end
      object InitEquaDiffBtn: TToolButton
        Left = 204
        Top = 0
        Hint = 
          'Valeurs exp.|Initialise les valeurs initiales aux valeurs exp'#233'ri' +
          'mentales'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'Equa. diff.'
        ImageIndex = 9
        ImageName = 'Item10'
        OnClick = InitEquaDiffBtnClick
      end
      object BornesBtn: TToolButton
        Left = 310
        Top = 0
        Hint = 'D'#233'finition des bornes'
        HelpKeyword = 'Bornes'
        HelpContext = 808
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Bornes'
        DropdownMenu = BornesMenu
        ImageIndex = 7
        ImageName = 'Item8'
        PopupMenu = BornesMenu
        OnClick = CurseurBtnClick
      end
      object TrigoBtn: TToolButton
        Left = 412
        Top = 0
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Angles'
        ImageIndex = 46
        ImageName = 'Item47'
        OnClick = TrigoBtnClick
      end
    end
  end
  object PanelCentral: TPanel
    Left = 486
    Top = 0
    Width = 1633
    Height = 1392
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 1
    object PanelBis: TPanel
      Tag = 2
      Left = 879
      Top = 103
      Width = 754
      Height = 1245
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alRight
      Color = clWindow
      DockSite = True
      TabOrder = 1
      Visible = False
      OnMouseDown = PaintBoxMouseDown
      OnMouseMove = PaintBoxMouseMove
      OnMouseUp = PaintBoxMouseUp
      object PaintBox2: TPaintBox
        Tag = 2
        Left = 1
        Top = 1
        Width = 752
        Height = 1244
        Hint = '|Utiliser le clic droit pour ouvrir le menu local'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        OnClick = PaintBoxClick
        OnDragDrop = PaintBox2DragDrop
        OnMouseDown = PaintBoxMouseDown
        OnMouseMove = PaintBoxMouseMove
        OnMouseUp = PaintBoxMouseUp
        OnPaint = PaintBoxPaint
        ExplicitLeft = 2
        ExplicitTop = 2
        ExplicitWidth = 750
        ExplicitHeight = 1888
      end
    end
    object PanelPrinc: TPanel
      Tag = 1
      Left = 0
      Top = 103
      Width = 879
      Height = 1245
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Color = clWindow
      TabOrder = 0
      OnMouseDown = PaintBoxMouseDown
      OnMouseMove = PaintBoxMouseMove
      OnMouseUp = PaintBoxMouseUp
      object PaintBox3: TPaintBox
        Tag = 3
        Left = 1
        Top = 1100
        Width = 877
        Height = 144
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Visible = False
        OnClick = PaintBoxClick
        OnMouseDown = PaintBoxMouseDown
        OnMouseMove = PaintBoxMouseMove
        OnMouseUp = PaintBoxMouseUp
        OnPaint = PaintBoxPaint
        ExplicitLeft = 2
        ExplicitTop = 1746
        ExplicitWidth = 1490
      end
      object Bevel: TBevel
        Left = 1
        Top = 1096
        Width = 877
        Height = 4
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        ExplicitLeft = 2
        ExplicitTop = 1708
        ExplicitWidth = 1490
      end
      object PaintBox1: TPaintBox
        Tag = 1
        Left = 1
        Top = 1
        Width = 877
        Height = 997
        Hint = '|Utiliser le clic droit pour ouvrir le menu local'
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
        Touch.InteractiveGestures = [igZoom, igPan, igPressAndTap]
        OnClick = PaintBoxClick
        OnDragDrop = PaintBox2DragDrop
        OnGesture = PaintBox1Gesture
        OnMouseDown = PaintBoxMouseDown
        OnMouseMove = PaintBoxMouseMove
        OnMouseUp = PaintBoxMouseUp
        OnPaint = PaintBoxPaint
        ExplicitLeft = 2
        ExplicitTop = 2
        ExplicitWidth = 1490
        ExplicitHeight = 1642
      end
      object LabelX: TLabel
        Tag = 1
        Left = 28
        Top = 784
        Width = 94
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'LabelX'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object LabelY: TLabel
        Tag = 1
        Left = 28
        Top = 868
        Width = 93
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'LabelY'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object LabelDeltaX: TLabel
        Tag = 1
        Left = 28
        Top = 1030
        Width = 168
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'LabelDeltaX'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object LabelDeltaY: TLabel
        Tag = 1
        Left = 28
        Top = 922
        Width = 167
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'LabelDeltaY'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object hintResultatLabel: TLabel
        Tag = 1
        Left = 28
        Top = 720
        Width = 232
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'hintResulatLabel'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object LabelDistance: TLabel
        Tag = 1
        Left = 28
        Top = 976
        Width = 196
        Height = 45
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'LabelDistance'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Visible = False
        OnMouseMove = LabelYMouseMove
      end
      object VideoTrackBar: TTrackBar
        Left = 1
        Top = 998
        Width = 877
        Height = 64
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        LineSize = 16
        Max = 1
        Min = 1
        PageSize = 1
        Position = 1
        PositionToolTip = ptBottom
        ShowSelRange = False
        TabOrder = 0
        ThumbLength = 48
        Visible = False
        OnChange = VideoTrackBarChange
      end
      object AbscisseCB: TComboBox
        Left = 400
        Top = 900
        Width = 130
        Height = 44
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        TabOrder = 1
        OnChange = AbscisseCBClick
        Items.Strings = (
          '')
      end
      object ResidusNormalisesCB: TCheckBox
        Left = 1
        Top = 1062
        Width = 877
        Height = 34
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'R'#233'sidus normalis'#233's'
        TabOrder = 2
        Visible = False
        OnClick = ResidusNormalisesCBClick
      end
    end
    object HeaderXY: TStatusBar
      Left = 0
      Top = 1348
      Width = 1633
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Panels = <
        item
          Text = 'a1'
          Width = 48
        end
        item
          Text = 'b2'
          Width = 48
        end
        item
          Text = 'c3'
          Width = 48
        end
        item
          Text = 'd4'
          Width = 48
        end>
      ParentFont = True
      UseSystemFont = False
    end
    object ToolBarGraphe: TToolBar
      Left = 0
      Top = 0
      Width = 1633
      Height = 57
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      AutoSize = True
      ButtonHeight = 57
      ButtonWidth = 103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      GradientEndColor = clSkyBlue
      HotTrackColor = clAqua
      Images = ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 3
      Wrapable = False
      object CurseurBtn: TToolButton
        Left = 0
        Top = 0
        Hint = 'Outils graphiques|Choix des curseurs, ajout de texte ...'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Outils'
        DropdownMenu = CurseurMenu
        ImageIndex = 27
        ImageName = 'Item28'
        PopupMenu = CurseurMenu
        OnClick = CurseurBtnClick
      end
      object ModeleBtn: TToolButton
        Left = 103
        Top = 0
        Hint = 'Affiche la panneau de mod'#233'lisation -  F9'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Mod'#232'l.'
        ImageIndex = 14
        ImageName = 'Item15'
        OnClick = ModeleBtnClick
      end
      object CoordonneesBtn: TToolButton
        Left = 206
        Top = 0
        Hint = 'Coordonn'#233'es (Alt+C)'
        HelpKeyword = 'Coordonn'#233'es'
        HelpContext = 804
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Coord.'
        ImageIndex = 26
        ImageName = 'Item27'
        OnClick = CoordonneesItemClick
      end
      object IncertBtn: TToolButton
        Left = 309
        Top = 0
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Incert.'
        ImageIndex = 48
        ImageName = 'Item49'
        Style = tbsCheck
        OnClick = IncertBtnClick
      end
      object Separe1: TToolButton
        Left = 412
        Top = 0
        Width = 12
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ImageIndex = 38
        ImageName = 'Item39'
        Style = tbsSeparator
      end
      object ZoomAutoBtn: TToolButton
        Left = 424
        Top = 0
        Hint = 'Echelle automatique ; auto calibrage'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Auto'
        ImageIndex = 18
        ImageName = 'Item19'
        OnClick = ZoomAutoItemClick
      end
      object ZoomAvBtn: TToolButton
        Left = 527
        Top = 0
        Hint = 'D'#233'finir la zone par cliquer glisser'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Loupe'
        ImageIndex = 16
        ImageName = 'Item17'
        OnClick = ZoomAvantItemClick
      end
      object ZoomArBtn: TToolButton
        Left = 630
        Top = 0
        Hint = 'Zoom arri'#232're'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Zoom ar.'
        ImageIndex = 15
        ImageName = 'Item16'
        OnClick = ZoomArriereItemClick
      end
      object ZoomManuelBtn: TToolButton
        Left = 733
        Top = 0
        Hint = 'Echelle manuelle'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Manuel'
        ImageIndex = 17
        ImageName = 'Item18'
        OnClick = ZoomManuelItemClick
      end
      object Separe2: TToolButton
        Left = 836
        Top = 0
        Width = 12
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Enabled = False
        ImageIndex = 22
        ImageName = 'Item23'
        Style = tbsSeparator
      end
      object NGraphesBtn: TToolButton
        Left = 848
        Top = 0
        Hint = 'Nombre de graphes'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Graphes'
        DropdownMenu = NgraphesMenu
        ImageIndex = 31
        ImageName = 'Item32'
        PopupMenu = NgraphesMenu
        OnClick = CurseurBtnClick
      end
      object AnimBtn: TToolButton
        Left = 951
        Top = 0
        Hint = 'Animation'
        HelpType = htKeyword
        HelpKeyword = 'Animation'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Animation'
        DropdownMenu = AnimationMenu
        ImageIndex = 22
        ImageName = 'Item23'
        PopupMenu = AnimationMenu
        OnClick = CurseurBtnClick
      end
      object VecteursBtn: TToolButton
        Left = 1054
        Top = 0
        Hint = 'Vecteurs|Trac'#233' des vecteurs'
        HelpContext = 815
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Vecteurs'
        DropdownMenu = VecteursMenu
        ImageIndex = 25
        ImageName = 'Item26'
        OnClick = CurseurBtnClick
      end
      object CopierBtn: TToolButton
        Left = 1157
        Top = 0
        Hint = 'Copier graphe|Copier le graphe dans le presse-papiers'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Copier gr.'
        DropdownMenu = CopyMenu
        ImageIndex = 21
        ImageName = 'Item22'
        PopupMenu = CopyMenu
        OnClick = CopierItemClick
      end
      object CornishBtn: TToolButton
        Left = 1260
        Top = 0
        Hint = 'Cornish-Bowden|M'#233'thode de Cornish-Bowden'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'C.B.'
        ImageIndex = 35
        ImageName = 'Item36'
        Visible = False
      end
      object RandomBtn: TToolButton
        Left = 1363
        Top = 0
        Hint = '|Effectue une nouveau tirage des grandeurs al'#233'atoires (F4)'
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = 'Tirage'
        ImageIndex = 37
        ImageName = 'Item38'
        OnClick = RandomBtnClick
      end
    end
    object ToolBarGrandeurs: TToolBar
      Left = 0
      Top = 57
      Width = 1633
      Height = 46
      Cursor = crHandPoint
      Hint = 'Cliquer pour d'#233'finir les ordonn'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ButtonHeight = 42
      ButtonWidth = 165
      Flat = False
      HotTrackColor = clAqua
      List = True
      GradientDrawingOptions = [gdoHotTrack]
      ShowCaptions = True
      TabOrder = 4
      Transparent = False
      Wrapable = False
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton1'
        ImageIndex = 0
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton2: TToolButton
        Tag = 1
        Left = 155
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton2'
        ImageIndex = 1
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton3: TToolButton
        Tag = 2
        Left = 310
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton5: TToolButton
        Tag = 3
        Left = 465
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton5'
        ImageIndex = 3
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton6: TToolButton
        Tag = 4
        Left = 620
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton6'
        ImageIndex = 4
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton7: TToolButton
        Tag = 5
        Left = 775
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton8: TToolButton
        Tag = 6
        Left = 930
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton8'
        ImageIndex = 6
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton10: TToolButton
        Tag = 7
        Left = 1085
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton10'
        ImageIndex = 7
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton11: TToolButton
        Tag = 8
        Left = 1254
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton11'
        ImageIndex = 8
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton12: TToolButton
        Tag = 9
        Left = 1423
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton12'
        ImageIndex = 9
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton16: TToolButton
        Left = 1592
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton16'
        ImageIndex = 10
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object ToolButton17: TToolButton
        Left = 1761
        Top = 0
        Cursor = crHandPoint
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        AutoSize = True
        Caption = 'ToolButton17'
        ImageIndex = 11
        Style = tbsTextButton
        Visible = False
        OnClick = ToolButton1Click
        OnMouseUp = ToolButton1MouseUp
      end
      object LabelToolBar: TLabel
        Left = 1930
        Top = 0
        Width = 621
        Height = 36
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Caption = '   Cliquer pour d'#233'finir l'#39'ordonn'#233'e ; clic droit -> '#224' droite'
        Visible = False
      end
    end
  end
  object PanelAnimation: TPanel
    Left = 2119
    Top = 0
    Width = 264
    Height = 1392
    HelpType = htKeyword
    HelpKeyword = 'Animation'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alRight
    TabOrder = 2
    Visible = False
    object DebutBtn: TSpeedButton
      Left = 4
      Top = 60
      Width = 36
      Height = 42
      Hint = 'Premier graphe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C0333333C3300033C033333CC3300033C03333C0C3300033C0333C00C3
        300033C033C000C3300033C03C0000C3300033C0C00000C3300033C03C0000C3
        300033C033C000C3300033C0333C00C3300033C03333C0C3300033C033333CC3
        300033C0333333C330003333333333333000}
      OnClick = DebutBtnClick
    end
    object RetourRapideBtn: TSpeedButton
      Left = 40
      Top = 60
      Width = 36
      Height = 42
      Hint = 
        'Animation en d'#233'croissant|Animation avec d'#233'croissance du param'#232'tr' +
        'e'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        30003333333C03C33000333333C03CC3300033333C03C0C330003333C03C00C3
        3000333C03C000C3300033C03C0000C330003C03C00000C3300033C03C0000C3
        3000333C03C000C330003333C03C00C3300033333C03C0C33000333333C03CC3
        30003333333C03C330003333333333333000}
      OnClick = RetourRapideBtnClick
    end
    object RetourBtn: TSpeedButton
      Left = 76
      Top = 60
      Width = 36
      Height = 42
      Hint = 'Graphe pr'#233'c'#233'dent'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033333333C33330003333333CC3333000333333C0C333300033333C00C333
        30003333C000C3333000333C0000C333300033C00000C3333000333C0000C333
        30003333C000C333300033333C00C3333000333333C0C33330003333333CC333
        300033333333C33330003333333333333000}
      OnClick = RetourBtnClick
    end
    object StopBtn: TSpeedButton
      Left = 112
      Top = 60
      Width = 42
      Height = 42
      Hint = 'Stop|Arr'#234't de l'#39'animation'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333CCCCCCCCCCCCCCC3C0000000000000C3C0777777777770C3C07777777777
        70C3C0770007000770C3C0770007000770C3C0770007000770C3C07700070007
        70C3C0770007000770C3C0770007000770C3C0770007000770C3C07777777777
        70C3C0777777777770C3C0000000000000C3CCCCCCCCCCCCCCC3}
      OnClick = StopBtnClick
    end
    object AvanceBtn: TSpeedButton
      Left = 154
      Top = 60
      Width = 36
      Height = 42
      Hint = 'Graphe suivant'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C333333333300033CC33333333300033C0C3333333300033C00C333333
        300033C000C33333300033C0000C3333300033C00000C333300033C0000C3333
        300033C000C33333300033C00C333333300033C0C3333333300033CC33333333
        300033C33333333330003333333333333000}
      OnClick = AvanceBtnClick
    end
    object AvanceRapideBtn: TSpeedButton
      Left = 190
      Top = 60
      Width = 36
      Height = 42
      Hint = 'Animation en croissant|Animation avec croissance du param'#232'tre'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C30C333333300033CC30C33333300033C0C30C3333300033C00C30C333
        300033C000C30C33300033C0000C30C3300033C00000C30C300033C0000C30C3
        300033C000C30C33300033C00C30C333300033C0C30C3333300033CC30C33333
        300033C30C33333330003333333333333000}
      OnClick = AvanceRapideBtnClick
    end
    object FinBtn: TSpeedButton
      Left = 226
      Top = 60
      Width = 36
      Height = 42
      Hint = 'Dernier graphe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000D0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        300033C3333330C3300033CC333330C3300033C0C33330C3300033C00C3330C3
        300033C000C330C3300033C0000C30C3300033C00000C0C3300033C0000C30C3
        300033C000C330C3300033C00C3330C3300033C0C33330C3300033CC333330C3
        300033C3333330C330003333333333333000}
      OnClick = FinBtnClick
    end
    object LabelTempsAnim: TLabel
      Left = 16
      Top = 168
      Width = 73
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Temps'
    end
    object OptionsAnimBtn: TSpeedButton
      Left = 16
      Top = 106
      Width = 46
      Height = 46
      Hint = 'Options|Param'#233'trage des param'#232'tres !'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 42
      ImageName = 'Item43'
      Images = ImageList1
      OnClick = OptionsAnimBtnClick
    end
    object HelpAnimBtn: TSpeedButton
      Left = 78
      Top = 106
      Width = 46
      Height = 46
      Hint = 'Aide'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      ImageIndex = 60
      ImageName = 'HELP'
      Images = ImageList1
      OnClick = HelpAnimBtnClick
    end
    object GroupBox6: TGroupBox
      Left = 1
      Top = 1296
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 17
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 1295
      object TrackBar6: TTrackBar
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        PageSize = 8
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox4: TGroupBox
      Tag = 2
      Left = 1
      Top = 1104
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 15
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 1103
      object TrackBar4: TTrackBar
        Tag = 4
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox5: TGroupBox
      Tag = 4
      Left = 1
      Top = 912
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 13
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 911
      object TrackBar2: TTrackBar
        Tag = 3
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox2: TGroupBox
      Tag = 5
      Left = 1
      Top = 816
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 12
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 815
      object TrackBar1: TTrackBar
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox1: TGroupBox
      Tag = 3
      Left = 1
      Top = 1008
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 14
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 1007
      object TrackBar3: TTrackBar
        Tag = 1
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox3: TGroupBox
      Tag = 1
      Left = 1
      Top = 1200
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 16
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 1199
      object TrackBar5: TTrackBar
        Tag = 2
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object BoucleCB: TCheckBox
      Left = 16
      Top = 248
      Width = 162
      Height = 44
      Hint = 'Animation en continu'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Bouclage'
      TabOrder = 1
    end
    object TraceCB: TCheckBox
      Left = 16
      Top = 208
      Width = 112
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Trace'
      TabOrder = 0
    end
    object TitreAnimCB: TCheckBox
      Left = 16
      Top = 296
      Width = 242
      Height = 34
      Hint = '|Bandeau de valeurs des param'#232'tres sur le graphe'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Bandeau de valeurs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -22
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = TitreAnimCBClick
    end
    object LignePointCB: TCheckBox
      Left = 16
      Top = 296
      Width = 242
      Height = 34
      Hint = '|Animation des points, les lignes ne sont pas anim'#233'es'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Lignes fig'#233'es'
      TabOrder = 3
    end
    object NbreTickBar: TTrackBar
      Left = 1
      Top = 1
      Width = 262
      Height = 52
      Hint = 'Vitesse|Vitesse de l'#39'animation'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Max = 18
      Min = 1
      Position = 9
      TabOrder = 4
      ThumbLength = 32
      TickMarks = tmBoth
      TickStyle = tsNone
    end
    object GroupBox7: TGroupBox
      Tag = 6
      Left = 1
      Top = 720
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 11
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 719
      object TrackBar7: TTrackBar
        Tag = 6
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox8: TGroupBox
      Tag = 7
      Left = 1
      Top = 624
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 10
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 623
      object TrackBar8: TTrackBar
        Tag = 7
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox9: TGroupBox
      Tag = 8
      Left = 1
      Top = 528
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 9
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 527
      object TrackBar9: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox10: TGroupBox
      Tag = 12
      Left = 1
      Top = 144
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 5
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 143
      object TrackBar10: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox11: TGroupBox
      Tag = 11
      Left = 1
      Top = 240
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 239
      object TrackBar11: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox12: TGroupBox
      Tag = 10
      Left = 1
      Top = 336
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 7
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 335
      object TrackBar12: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
    object GroupBox13: TGroupBox
      Tag = 9
      Left = 1
      Top = 432
      Width = 262
      Height = 96
      Cursor = crHandPoint
      Hint = '|Double clic pour param'#232'trer'
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alBottom
      Color = clBtnFace
      ParentColor = False
      TabOrder = 8
      OnClick = GroupBoxAnimClick
      OnDblClick = GroupBoxAnimDblClick
      ExplicitTop = 431
      object TrackBar13: TTrackBar
        Tag = 8
        Left = 2
        Top = 38
        Width = 258
        Height = 56
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ThumbLength = 40
        TickStyle = tsNone
        OnChange = AnimSliderChange
      end
    end
  end
  object SplitterModele: TGripSplitter
    Left = 460
    Top = 0
    Width = 26
    Height = 1392
    Hint = 'F9'
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    caption = 'Mod'#233'l    isation'
    Associate = PanelModele
    Size = 26
    MinSplitSize = 350
    MaxSplitSize = 800
    Snapped = False
    Transparent = False
    Beveled = False
    Color = clHotLight
    ParentColor = False
  end
  object CurseurGrid: TStringGrid
    Left = 744
    Top = 214
    Width = 360
    Height = 320
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ColCount = 2
    DefaultColWidth = 140
    DefaultRowHeight = 48
    DragKind = dkDock
    DragMode = dmAutomatic
    FixedCols = 0
    RowCount = 6
    FixedRows = 0
    ParentColor = True
    ScrollBars = ssNone
    TabOrder = 4
    Visible = False
    OnEndDock = CurseurGridEndDock
    ColWidths = (
      140
      140)
    RowHeights = (
      48
      48
      48
      48
      48
      48)
  end
  object MenuAxes: TPopupMenu
    OnPopup = MenuAxesPopup
    Left = 1240
    Top = 864
    object identifierPagesItemA: TMenuItem
      Action = IdentAction
      AutoCheck = True
      RadioItem = True
    end
    object CoordonneesItem: TMenuItem
      Caption = '&Coordonn'#233'es'
      ImageIndex = 26
      OnClick = CoordonneesItemClick
    end
    object ModeleItem: TMenuItem
      Caption = 'Mod'#233'lisation'
      ImageIndex = 12
      ShortCut = 120
      OnClick = ModeleItemClick
    end
    object TableauXYItem: TMenuItem
      Caption = 'Tableau tangentes'
      HelpContext = 809
      ImageIndex = 4
      OnClick = TableauXYItemClick
    end
    object ViderXYItem: TMenuItem
      Caption = 'Vider tableau'
      OnClick = ViderXYItemClick
    end
    object AffIncertBis: TMenuItem
      AutoCheck = True
      Caption = 'Trac'#233' des incertitudes'
      Hint = '|Trac'#233' des ellipses d'#39'incertitudes'
      ImageIndex = 52
      OnClick = AffIncertClick
    end
    object SavePosItem: TMenuItem
      Caption = 'Enregistrer la position'
      OnClick = SavePosItemClick
    end
    object ProprieteCourbe: TMenuItem
      Break = mbBarBreak
      Caption = 'Caract'#233'ristiques'
      ImageIndex = 49
      OnClick = ProprieteCourbeClick
    end
    object EnregistrerGrapheItem: TMenuItem
      Caption = 'Enregistrer graphe'
      ImageIndex = 21
      OnClick = EnregistrerGrapheItemClick
    end
    object Imprimergraphe1: TMenuItem
      Caption = 'Imprimer graphe'
      ImageIndex = 10
      OnClick = ImprimeGrItemClick
    end
  end
  object PopupMenuModele: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PopupMenuModelePopup
    Left = 40
    Top = 160
    object OptionsModeleItem: TMenuItem
      Caption = '&Options de mod'#233'lisation'
      ImageIndex = 14
      OnClick = OptionsModeleBtnClick
    end
    object FermerItem: TMenuItem
      Caption = '&Fermer mod'#233'lisation '
      ImageIndex = 13
      ShortCut = 120
      OnClick = FermerItemClick
    end
    object ResidusItem: TMenuItem
      Caption = '&R'#233'sidus'
      HelpContext = 813
      OnClick = ResidusItemClick
    end
    object ImprimeModeleItem: TMenuItem
      Caption = '&Imprimer mod'#233'lisation'
      ImageIndex = 10
      OnClick = ImprModeleBtnClick
    end
    object RaZModele: TMenuItem
      Caption = 'R'#224'&Z'
      OnClick = RaZModeleClick
    end
    object SauverModeleItem: TMenuItem
      Caption = 'Sauver mod'#232'le'
      OnClick = SauverModeleItemClick
    end
    object SaveParamItem: TMenuItem
      Caption = '&Sauver param'#232'tres'
      OnClick = SaveParamItemClick
    end
    object TitreModeleItem: TMenuItem
      Caption = 'Mod'#232'le en &titre du graphe'
      Hint = '|Donne comme titre au graphe le mod'#232'le'
      ImageIndex = 45
      OnClick = addModeleItemClick
    end
    object ModelePagesIndependantesMenu: TMenuItem
      AutoCheck = True
      Caption = '&Pages ind'#233'pendantes'
    end
    object intersectionTer: TMenuItem
      Caption = 'Trac'#233' des &intersections'
      OnClick = IntersectionItemClick
    end
    object IncertChi2Item: TMenuItem
      AutoCheck = True
      Caption = 'Calcul avec incertitudes, '#967#178
      Hint = 'Prise en compte des incertitudes'
      ImageIndex = 51
      OnClick = IncertChi2ItemClick
    end
    object AffIncert: TMenuItem
      AutoCheck = True
      Caption = 'Affichage des incertitudes'
      ImageIndex = 48
      OnClick = AffIncertClick
    end
    object MonteCarloItem: TMenuItem
      Caption = 'Monte-Carlo'
      OnClick = MonteCarloItemClick
    end
  end
  object BornesMenu: TPopupMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    OnPopup = BornesMenuPopup
    Left = 251
    Top = 128
    object Inter1: TMenuItem
      Tag = 1
      Caption = 'Inter'
      OnClick = BornesClick
      OnDrawItem = BornesDrawItem
    end
    object Inter2: TMenuItem
      Tag = 2
      Caption = 'Inter'
      OnClick = BornesClick
      OnDrawItem = BornesDrawItem
    end
    object Inter3: TMenuItem
      Tag = 3
      Caption = 'Inter'
      OnClick = BornesClick
      OnDrawItem = BornesDrawItem
    end
    object Inter4: TMenuItem
      Tag = 4
      Caption = 'Inter'
      OnClick = BornesClick
      OnDrawItem = BornesDrawItem
    end
    object RazBornes: TMenuItem
      Caption = 'R'#224'Z des bornes'
      Hint = 'Remise '#224' z'#233'ro|Mod'#233'lisation sur la totalit'#233
      OnClick = RazBornesClick
    end
    object IntersectionItem: TMenuItem
      Caption = 'Trac'#233' des intersections'
      Visible = False
      OnClick = IntersectionItemClick
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'png'
    Filter = 'JPEG|*.jpg|PNG|*.png|Bitmap|*.bmp'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 1230
    Top = 312
  end
  object MenuDessin: TPopupMenu
    Left = 1406
    Top = 1160
    object DessinSupprimerItem: TMenuItem
      Caption = '&Supprimer'
      OnClick = DessinDeleteItemClick
    end
    object ProprietesDessin: TMenuItem
      Caption = '&Propri'#233't'#233's'
      OnClick = DessinOptionsItemClick
    end
  end
  object TimerAnim: TTimer
    Enabled = False
    OnTimer = TimerAnimTimer
    Left = 595
    Top = 541
  end
  object RepeatTimer: TTimer
    Enabled = False
    OnTimer = RepeatTimerTimer
    Left = 611
    Top = 213
  end
  object CurseurMenu: TPopupMenu
    Tag = 18
    OnPopup = CurseurMenuPopup
    Left = 1600
    Top = 851
    object SelectItem: TMenuItem
      Caption = 'Standard'
      ImageIndex = 27
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object CurTexteItem: TMenuItem
      Tag = 1
      Caption = '&Texte'
      ImageIndex = 2
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object CurLigneItem: TMenuItem
      Tag = 2
      Caption = '&Ligne'
      ImageIndex = 1
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object IdentifierPagesItemC: TMenuItem
      Action = IdentAction
      AutoCheck = True
    end
    object CurGommesItem: TMenuItem
      Tag = 3
      Caption = '&Gomme(s) (Ctrl)'
      ImageIndex = 0
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CurReticuleItem: TMenuItem
      Tag = 4
      Caption = '&R'#233'ticule libre'
      ImageIndex = 3
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object CurReticuleDataNewItem: TMenuItem
      Tag = 18
      Caption = 'R'#233'ticule &lissage'
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object curDataItem: TMenuItem
      Tag = 5
      Caption = 'R'#233'ticule &donn'#233'es'
      ImageIndex = 30
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object ModeleSepare: TMenuItem
      Caption = '-'
    end
    object CurReticuleModeleItem: TMenuItem
      Tag = 13
      Caption = 'Reticule &mod'#232'le'
      ImageIndex = 41
      RadioItem = True
      Visible = False
      OnClick = ChoixCurseurClick
    end
    object CurModeleItem: TMenuItem
      Tag = 8
      Caption = '&Valeur mod'#233'lis'#233'e'
      ImageIndex = 29
      OnClick = TableauXYItemClick
    end
    object addModeleItem: TMenuItem
      Caption = 'Afficher le mod'#232'le'
      ImageIndex = 45
      OnClick = addModeleItemClick
    end
    object CurTangenteItem: TMenuItem
      Tag = 6
      Caption = 'Tan&gente'
      ImageIndex = 4
      RadioItem = True
      OnClick = ChoixCurseurClick
    end
    object CurOrigineItem: TMenuItem
      Tag = 7
      Caption = '&Origine abscisse'
      ImageIndex = 8
      RadioItem = True
      OnClick = OrigineBtnClick
    end
  end
  object AnimationMenu: TPopupMenu
    OnPopup = AnimationMenuPopup
    Left = 1409
    Top = 1011
    object AnimationNone: TMenuItem
      Caption = 'Pas d'#39'animation'
      Checked = True
      RadioItem = True
      OnClick = AnimationNoneClick
    end
    object AnimationTemps: TMenuItem
      Caption = 'Animation=f(&temps)'
      RadioItem = True
      OnClick = AnimationTempsClick
    end
    object AnimationParam: TMenuItem
      Caption = 'Animation=f(&param)'
      RadioItem = True
      OnClick = AnimationParamClick
    end
  end
  object MenuIndicateur: TPopupMenu
    OnPopup = MenuIndicateurPopup
    Left = 1219
    Top = 1140
  end
  object NgraphesMenu: TPopupMenu
    OnPopup = PopupMenuModelePopup
    Left = 1744
    Top = 1018
    object UngrapheItem: TMenuItem
      Caption = '&1 graphe'
      Checked = True
      GroupIndex = 1
      ImageIndex = 31
      RadioItem = True
      OnClick = DeuxGraphesVertClick
    end
    object DeuxGraphesVert: TMenuItem
      Caption = '2i'#232'me graphe '#224' c'#244't'#233
      GroupIndex = 1
      ImageIndex = 34
      RadioItem = True
      OnClick = DeuxGraphesVertClick
    end
    object DeuxGraphesHoriz: TMenuItem
      Caption = '2i'#232'me graphe en-dessous'
      GroupIndex = 1
      ImageIndex = 33
      RadioItem = True
      OnClick = DeuxGraphesVertClick
    end
    object ResidusItemBis: TMenuItem
      Caption = 'Residus'
      GroupIndex = 1
      OnClick = ResidusItemClick
    end
    object IdentifierPagesItemN: TMenuItem
      Action = IdentAction
      AutoCheck = True
      GroupIndex = 2
    end
  end
  object TimerModele: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerModeleTimer
    Left = 560
    Top = 680
  end
  object VecteursMenu: TPopupMenu
    OnPopup = VecteursMenuPopup
    Left = 1584
    Top = 992
    object VitesseItem: TMenuItem
      Tag = 1
      Caption = 'Vitesse'
      GroupIndex = 1
      ImageIndex = 39
      RadioItem = True
      OnClick = VecteursItemClick
    end
    object AccelerItem: TMenuItem
      Tag = 2
      Caption = 'Acc'#233'l'#233'ration'
      GroupIndex = 1
      ImageIndex = 40
      RadioItem = True
      OnClick = VecteursItemClick
    end
    object VitesseAccItem: TMenuItem
      Caption = 'Vitesse et acc'#233'l'#233'ration'
      Checked = True
      GroupIndex = 1
      ImageIndex = 25
      RadioItem = True
      OnClick = VecteursItemClick
    end
    object NoVecteursItem: TMenuItem
      Tag = -1
      Caption = 'Pas de vecteurs'
      GroupIndex = 1
      RadioItem = True
      OnClick = VecteursItemClick
    end
    object OptionsItemBis: TMenuItem
      Tag = 2
      Caption = 'Options bis'
      GroupIndex = 1
      OnClick = OptionsItemClick
    end
    object OptionsItem: TMenuItem
      Tag = 1
      Caption = 'Options'
      GroupIndex = 1
      ImageIndex = 42
      OnClick = OptionsItemClick
    end
    object FildeferItem: TMenuItem
      AutoCheck = True
      Caption = 'Fil de fer'
      GroupIndex = 1
      ImageIndex = 43
      OnClick = FildeferItemClick
    end
  end
  object MenuReticule: TPopupMenu
    OnPopup = MenuReticulePopup
    Left = 1216
    Top = 1008
    object tableauXYItemBis: TMenuItem
      Caption = 'Tableau valeurs'
      HelpContext = 809
      ImageIndex = 4
      OnClick = TableauXYItemClick
    end
    object ViderTangenteItem: TMenuItem
      Caption = 'R'#224'Z tangentes'
      OnClick = ViderTangenteItemClick
    end
    object ViderXYItemBis: TMenuItem
      Caption = 'R'#224'Z rep'#232'res'
      OnClick = ViderXYItemClick
    end
    object SavePosItemBis: TMenuItem
      Caption = 'Enregistrer la position'
      OnClick = SavePosItemClick
    end
    object FinReticuleItem: TMenuItem
      Caption = 'Fin r'#233'ticule (ESC)'
      OnClick = FinReticuleItemClick
    end
    object ProprieteCourbeBis: TMenuItem
      Caption = 'Caract'#233'ristique'
      OnClick = ProprieteCourbeClick
    end
    object Enregistrergraphe1: TMenuItem
      Caption = 'Enregistrer graphe'
      OnClick = EnregistrerGrapheItemClick
    end
  end
  object TimerSizing: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerSizingTimer
    Left = 608
    Top = 376
  end
  object CopyMenu: TPopupMenu
    Left = 1576
    Top = 1152
    object metafile2: TMenuItem
      AutoCheck = True
      Caption = 'metafile'
      Checked = True
      GroupIndex = 1
      Hint = 'Copie le graphe comme metafile (vectoriel)'
      RadioItem = True
      OnClick = metafile2Click
    end
    object bitmap2: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = 'bitmap'
      GroupIndex = 1
      RadioItem = True
      OnClick = metafile2Click
    end
    object Jpeg2: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = 'Jpeg'
      GroupIndex = 1
      RadioItem = True
      OnClick = metafile2Click
    end
    object Png1: TMenuItem
      Tag = 3
      AutoCheck = True
      Caption = 'Png'
      GroupIndex = 1
      RadioItem = True
      OnClick = metafile2Click
    end
    object clipEPSitem: TMenuItem
      Tag = 5
      Caption = 'EPS'
      GroupIndex = 1
    end
  end
  object ActionList1: TActionList
    Left = 1353
    Top = 169
    object IdentAction: TAction
      AutoCheck = True
      Caption = 'Identifier les courbes'
      ImageIndex = 24
      OnExecute = identifierPages
    end
  end
  object ModeleMenu: TPopupMenu
    Left = 1416
    Top = 849
    object LineaireItem: TMenuItem
      Caption = 'Lin'#233'aire'
      ImageIndex = 3
      OnClick = LineaireItemClick
    end
    object AffineItem: TMenuItem
      Caption = 'Affine'
      ImageIndex = 0
      OnClick = AffineItemClick
    end
    object EchelonItem: TMenuItem
      Caption = 'Exp. 1'
      ImageIndex = 2
      OnClick = EchelonItemClick
    end
    object RadioItem: TMenuItem
      Caption = 'Exp. 2'
      ImageIndex = 12
      OnClick = RadioItemClick
    end
    object ParaboleItem: TMenuItem
      Caption = 'Parabole'
      ImageIndex = 16
      OnClick = ParaboleItemClick
    end
    object ModelesAutresItem: TMenuItem
      Caption = 'Autres'
      OnClick = ModelGrClick
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Item1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A64944415478DAD5D44B1680200805D0C7BE1BE6BA49F4F40143B19A
              C4C47EDE103C1283F165D01B90F27466A5D163D06294005E6EC0F22198663189
              5BF0496625960CC201BD2C778CF29B321AAC9631986183C9F455630D28934A2D
              24F54B96F55AC63EA6C01176FED4C75C50D75247AA16BC9DD06D8A054758A886
              32AE673331DCA3DE922D8E0076805EFDA2C810DCEFEDB3E90CBD683B1F688A45
              AFB59B59FAABF3F09FE006084BA9ED0E6EDCA50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000644944415478DACDD2B112C020080350F9FF8F56DCAA054D80EB3513
              03BC2187F4D65B65E477A028A18694803B96022D2C0C7A58083C613478C32810
              C16010C52090C1AE208B1DC108E68251CC0433D80BCC620B48BDC63CD3CCFDE7
              EC76F8390877589101F69B60ED1751BE360000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007A4944415478DAEDD4D10AC0200805D0FCEE7CB4EFAE1C08D24A658B
              0DC67C690C3D5C590C6AAA6967C10F9E1B7A4BEF81AD209F51D4040B958A88C7
              3311A58CD9454D50D24945523E07CABA8C081C597B093222804EEAA5344119BE
              0DEAAF3B96B7F614D4EBEA7791944B701CBA0CCE06C7EB63A11FF8DBBC0E36B1
              1C6BED2D28C7FA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A34944415478DACD55491280300823FF7F347671AA0CABDA835C5049
              330930164C4C3B039D103DB568CF7081ADCC231508E701F016C221EC8C7F2AAC
              F510B7C93152C25C215A612031C94327590F27C16539218C155E871F1162F548
              2EF9A8188BEF7F27040AA5123D655B69D0C39784B6420DB6F7D0C0C93D5C5A2D
              2BCE62AFFEA330E50A61C9F20742A2EA0F9129E3EB8294423F4F8529CEB3ACDF
              A5650F8FDD57C001A03CB1EDE42E51040000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008E4944415478DAB5D44B0E80200C04D0E9B975A9E7AE458580220C1F
              599440C84B6909A25008446D161487E86E71A99C130EE4B004748B3CCA634486
              6D580514DB3813777114BC300F595016CDD430C5BA418FB99AAD7340C0372007
              B06800B702D682920F9B471390BE167037F17D36EAB236BDB72F78087CC25D35
              ACE2F5CFA1138CB191F57FE08CFA0570E638002A67A7EE693F90600000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000714944415478DAE5D34B0E80300804D0E1DC75A9E746219A985869F9
              2C4C64C3AA2F0CA1C460541665C04D9E9FD5C0540236EDC00295E85B131E02B3
              B6821DF6B030F88685400B73810249B7B0697034950BF46026381BD1057AB107
              D8BBFC3478FDCD342811D75BC21418DDD730F23FC01DD6AD50EDB510D9BB0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item7'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000004C4944415478DA63FCCFF09F819A8091AE0632B6306295FC5FF39F71
              9019580D15681D5606E20A2F6C06E20B573A1858CD401A68A5BB8183360CB181
              C1950EE96B208EF01A7803C9015437100024AF73ED0651A0450000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item8'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000009F4944415478DACDD5DD0E83200C05E09EE7A697F0DC67AD93591DEE
              CFBAC885049B7EA915022894CC01075B6D2C5AB00A88056ADBCFD4E2A5E07F60
              7FD1E1EB55F80EA4EA12ABF518E8D884041CC2DF7AB8C5D615F3FB0AAF0DD29E
              236CF9CB78425FF6F010B8ADD043BBD80374D188800E40F05EA14D1F6F6CCC5F
              4804B06F5CE61CBD510FD38E9EAFD5123AE89DD49034AD0318F3CF032561388A
              EC2BE006670AE3EDC27941640000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item9'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006E4944415478DA63FCCFF09F819A8071C41AC80835F53F2341E504D4
              21B9909062E22C45F3322E4DC4FA006B18A26B26DE301C06221B0203C41986C7
              40D25D466F0389F532B23A881A0A2205248E2C06E153906C081A486AC2C66B20
              39598F282F930206BF81C84180082EAA97870081D56BEDA1290F0B0000000049
              454E44AE426082}
          end>
      end
      item
        Name = 'Item10'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000504944415478DAEDD1C10A0020080350F7FF1FAD97E83054443C14B8
              63AE87145454268305A7401C5511D6EE3CEF12E815795602798B68BBACE7BE61
              E5F23898C7F965D0411D0BC0DE660BFE07F6F33E68774051EDDF639375000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item11'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DABD94D10DC0200844612C9DAD9F9D4DC7B24242635B
              156AB5F72321FA725C889820C14CE1722052ABA27C0F878159D71EA219DA0412
              248400CE39AEA5A741CD0EA5A741BB0E79CCA2B6646A72F878D471A93A3C1D49
              864A966B1CB676CFAA127E02C9558C91D7E4CDE9BDAF0365E7AC30A08C2B79AE
              73383D43807D10B7FD00E46270ECFB3EAEFF60BFEA00E279C4ED2CAD7FCA0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item12'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006B4944415478DAE5D0C10E80200C03D0F5BBE508DF3D634023416607
              C683EE0A7BE90A159527075F0751961553608A4997106453F4840D81163600E6
              137B9813BCC71C208E4F346877C3A56B12EE68BDCCA7EB9C8CCB0E18CCE8B045
              27C11A65B1B7C1FCECC108D03F3F0457F0185FEDA5A7094D0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item13'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000009B4944415478DAADD5490E80200C05507A6E58CAB92B9350995B6063
              52E3CBE7A789800AD5CD031EB48F456D3488004FA483B7406740A0DCF3185429
              218484C7206086525236183FCCADC1BF43027EC3159C93E4EE9A02B8574EE59F
              83A57C7A452118536DE65F75B88F7513D69BCFC18620DD7C0E3601CBE68BC1D2
              A151B3B560243471405E8AC1DDBE7AEB55CF867B289D351D9E1C0FC3ED5FC00B
              50EBBBED100749980000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item14'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A94944415478DAADD44112C32008004078B71EE5DD14624DD4920C29
              7852467750546CAD312436BC036BAD6E440C1FC8C0F8980D20A78107C6B21431
              0E9E18914E8C810BD627FE0FFE607760912049B07C2B7BF52FD0C4DE8370A289
              60479341CD50DD7E4D6002C2196A057146C36718CBD0A8B207F4DCC357454905
              755FE06DC62BD91BF2E451A363506AC17D6CBDE1B183659E823B64E1FB0FA398
              B5EE31C3115B32949EF50B8DB51FE06D145AB03016D60000000049454E44AE42
              6082}
          end>
      end
      item
        Name = 'Item15'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008D4944415478DAADD5310EC02008055038B78EF5DC54AC0E2A560119
              DA84C457F80E4502829B850CA6275188014D0013B9B283CC5D04CB13DD205410
              CA84EE9519231C3A3A705C51F8C407B6C60EEE2F419C793DA17C785ED308F6E1
              9BC0D3A994199E630713EAB00DA8C77E401B266618632C6FF282A1424D7181A7
              2B4A598FBDE5A5587B53869E62186FFF025EA93BAAEDB445AAD3000000004945
              4E44AE426082}
          end>
      end
      item
        Name = 'Item16'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000904944415478DABDD4C10E8020080660796E39E2739B1C70E6504259
              5C5ACE3EFFD2809A6A8A2CF8052C542A22F67B224A19331C81D08618988B1768
              734DF4050AA6A591D416DA417E80AFBB57FB32A783BB749E940B1094ADAF7001
              06240CFF86564AF72ECFE85C72D0DDE098466A4C6D2575FFCB309C000D3D6A0E
              3BF4B8DBACD0ABF6A5A1D7FD90D1B084EA02D1E00369169AED4B27EA9F000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item17'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000924944415478DABDD4C10E8020080660796E39E273931C7068985359
              5C5A669FFFD2004E9C220B7E010B1546C4764F442963862310EA900063C90275
              EE12ED40C5BC349A7A8536505E906B8FD5C706F0E74C403FDD1B5CA59C80E06C
              3DC305189030FC1B86EFF2888EA5077D1BB469B46CEA55D2ED7F19CC09F0D0A3
              E6F0851E779B197AD5BE3CF4BA1F0A1A96D05D201A7C0046F6A2ED7B2562CB00
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item18'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BC4944415478DAD594410EC3200C04D7CF0A47BE158EF02D8E7CCB95
              438D206D0934A8527DB142A46199C41083B1B24880C18725D4DDED5480D6DAF2
              22C6886F9E37B3FD13F0670E8D31653DA574EFC802E3233B83880A7418A869BC
              F770CE3530E6DC8781192004828439C3745D361B72A8897AB029877542A0EDBA
              894227807881D57DD8211D239D237C820AACE7AF7148F595F306AAC986274514
              35B7D8F39FD3926453A3A7D433F4EAABF681A8B55DFB9A7028470CF76E9B95F5
              008C652CFC134B5AA70000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item19'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000CC4944415478DAB594490EC3200C45F1B96149CEEDE212337980A8A9
              3708018FEF411F30607833A002CB12107E46150674851D7AE50B534AED6ACE39
              C41461071B14F603B8016BD007A86631673701A16CEB4E3E64D5335496AA01E9
              01AD3535BDA627771A90D4CDB5920FBA4A3D8B0D50420918BFCDB22762035CA1
              B56978029CEBA37592EED4EE7B2324BA6CABA4735F9D008E500EAA1929DB35C3
              0472FA0CE0411FBBEF2905DB1C8C39BB87DF821A40DF2C3CA8023C731E0B2ACC
              E1898D6950D5BE9EC46A28FF34D877E203BCA5B9ED3C284DEC0000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item20'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DAC5934B0EC0200844877397A53DB75513ADE2AF35D8
              CE0613CD0B33205958688A3C9070AA502D0EDA0524EB2A0DAD4CDEC4FBEF8031
              066FA3069288C8819E004326A94A60791E02F3EED480B7D5B8018C25A0CCAE3D
              949740095B021A63C00CB8D214F382E55E77CB96E7C072F7F29DA4907B067466
              D183D51DF6EFFFFDCBA637B16C68FB3A8482125053177F56F6ED068167580000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item21'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000914944415478DABD94D10DC0200844612C9DAD9F9D4DC7B24242635B
              156AB5F72321FA725C889820C14CE1722052ABA27C0F878159D71EA219DA0412
              248400CE39AEA5A741CD0EA5A741BB0E79CCA2B6646A72F878D471A93A3C1D49
              864A966B1CB676CFAA127E02C9558C91D7E4CDE9BDAF0365E7AC30A08C2B79AE
              73383D43807D10B7FD00E46270ECFB3EAEFF60BFEA00E279C4ED2CAD7FCA0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item22'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C44944415478DAED92C90103210845A1AC496B78D4DA2CCB008971DF
              921CE75F1C18792C820102FC532840946320FE8F5F0159C9C98868221BFD6CFD
              444B60820674D60532660AED0295A8F7430385623C3B400ED4D0D096DAB6BF02
              BE0105271A387B9B04DE07E6A398549980D9CCEA4749894E5A9E00B1AA4CC75B
              81ACB54086701B38EA3AF7CB167C80926124C3BB2781CE59FD6E2A23D3028B3D
              ACE7C2B72530C262F2DCD6A43910168A151251E1F7DEC3753DCA0A577A757003
              7F052E2FC101F0444F80E4E1ED4A750EF50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item23'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000934944415478DAD594D10E80200845E1BBF351BFDB34B544216D615B
              F785ADE870B96CA1070F9AC225408C45418185A7C3083D1EBCAD4B1C16BA98CB
              83F702B038CE4D2CF0EAF90A580014760FEC07360EDBE3700EFB03623E88B072
              ED30B9A003FB2D0619CEAC3C0974D6F9CD1870D642ACDC075CCF20C3DAA99421
              850B19D23579603D3029424D80764050D08F7E0E9A5207EE660DFDED202BD967
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item24'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000BD4944415478DACD94410EC3200C04ED6F71E45BE1C8BB38F2ADA4AE
              BAAD310EA46954656F58CEC8DE85F04A2B5D29FE3B90A5E5A5472F779F9BDA10
              28B05A2B851028E74C292505ED61432060A594A6BEA4859DEE37DC050226C274
              A218E3F3DCAEDE4E7A1828309C476B374004001800BAF6014E3CD40158A0AE8B
              A7BE8F0E1049C233919C7D201BAF4C281A78C984DA433BE1290F6DCA807A131F
              4EF97B600F1DBE141D92DCC37DFF262FC57A0A0F67EB4E8116FAF3DFE68CEE0F
              DC002252CDEDAD27A9B80000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item25'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000804944415478DACDD3D10E8020080550EEFF7F346993CD0411CA55BC
              F8801EEED80413D3CEC267208898CF63032858045D823D66F5C701011005E406
              427129503049FA28618FA57A7740AFFF0EB8C2BC7B0A8C62B3FB17308B59EF7C
              903159B0B35B01CD7405C4F0B47E1B05D6C13012AA8A24ECB035E8950C03E7FE
              72B6FE0F1EC8067AEDF9B9D2020000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item26'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000884944415478DAC592D10E80200845E1FF3F9A0457422A91B2BA2FE8
              60E73200090832850CC4124AC454207F32A0810EAB994E7AC66120A8BC57FF00
              649867D4E71CA007931110C9206CCD04E8C31A9083ADED8075E3729D41A09DB3
              01B6A88B7F01B6CD0F0FFB7320E7CFF71D3ADCF24A8753E0CC3DAAE50E5F0177
              94023423D35BDED57536993A00C908A6EFAD6760450000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item27'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000634944415478DAD5924B0A002008449DFB1FDADA14D807B5146A36D1
              080F47051313085C5F5080B007D692F0C6BF026C062F213698D2A1AFB30F81EB
              19A674E8D32BC0FD8D1A66A84125FC32F2BCB097804A64DF0C0D4B493F9B532F
              0F1811B7032355002F3494EE3ADE47F40000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item28'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000754944415478DAD5D4BB0D002008045058CBD5A4C4D55CCB4F61A9DC
              191B6934217939BFDAA4C9CBD27F411DADD1D3A7E01C59F408D65A25A544A121
              388B41219041611045291041E984AB762874CACC6943F770CDDD5DB2E5FB3D5C
              898A976666C7A586E02E71941206D194D46F83BCEF8FFFC3DBEA21E877EDDC26
              960E0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item29'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007F4944415478DABDD34B0EC020084551D8FFA2E927DA5614E1A1A923
              4627DC56594868E7E1DF402612917BE065F0C2EA8CA21DA831660C6DC011866E
              FA80330C41DF0DCFA1E6595824BFFD8605B5B0C8A6FD5F56289A3FBE870BF9F6
              4B49E6CF9F5E22DF7FCBD17C8A82C17C0C74F22B868146FE17C341B5A9C672A0
              73B6830741637DED6C30D50A0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item30'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A84944415478DAA591DB128020084497EFCE47FA6E926E9AA682EE4C
              698C9C9695040202495C0951843DEEB7733F23CA810AD3A207A8BD578F1A22A1
              55870978BE6919881B88B71F2CB3793DCA0D540EDD231613BDC014ACE712EA88
              BA0EFF7FA4B5F4BD00FC863F056CB93201DB19B661130EFB3027700C73006DB0
              6186CC8C1002DA7926C87566A38EC3E73086C0DCD92FD0336239A6F9527A35D3
              C85677B5383E011FE08A4A8707D425CBEE574E8DB00000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item31'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000744944415478DA63FCCFF09F819A80116420239002D28C6419003202
              0860FA079F8138BD8C6C0B5DC39090E5D4379081A1054FBAA961203528F0BA90
              9CB02518298C0CAD40CBAAA9E3C25103493310C401198A9137297521D50DA459
              18C2C4900DC4A70E6B1862072D0CB02C48B40BF12A20D1CB007D0C97EE3D746D
              190000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item32'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008F4944415478DABD93DB1280200844D92F57BE9C289BF29E26B5930F
              3170669712424296C20E04B10955C8E12B2044B516155092FC080438C4105719
              E634AAF60C01432317D0B876F77580B13B33603C90479F02B67657830C036B1F
              A2B5D726D07B4FFA1CE78DF6F9C261CFDDB4C35160FCEFA5B5CCE151E8C09EF4
              FFD5330132333977C79E792F804BF64E5D404B6D264CEDEDCB80313900000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'Item33'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000AC4944415478DAD592D10DC3200C44CF9BB159CC666CE6D8D0124800
              41443F7A12C222E6E9F085040282176C12FD0848A21A371261A6E78F8000EB85
              A3F8E8E3FE3DAB805A57FA9C3F1C1AE402A4FADA6FC046DD0596EEB6014BA749
              3A92C633F3F3E3FD4628F7D94D876230A00C658F323084306C74CEADFD3606EC
              410D664BC70839641E38E3903C75A1CB0E73703E256BE0AA7EE3B07254B88D60
              C69C431333AF87B2EA7008C42645E04E9D25B7D7004F9EDEF20000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'Item34'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000984944415478DAAD93EB120021048579736FDEB24D9B1A6227A67EA9
              CFED40006A5068C897815484A30E64ABC90EF10C643F6463C95B29D8050E5806
              3ADF3AC01D72826ADF079413017A49E7404B866BA438233BE85672B66F9EDFEC
              E19F21A48037A6864225C0BB4D31C63E4BDE1C29982189B587D93DF344FA4A6F
              1F8AA5DE08A67CF2DBEE61662D4C66249B014EF658C9A6CEB0D5F2E001222580
              807C7063FB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item35'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000008B4944415478DAD5936D0FC0100C847BBF7CF5CB3B4562EB6A66E183
              4B04757972DE40C4421385054092A8BE11A09E4F3D1B0381907A91E30904EEE6
              52EF0215567B0374C64DE035DD3460DD6A2855FE07B467E75ECA28D0C28681CC
              9C37C5B97952CF70C256BA4F090B2C01F5C0EB937A015E0BF64DC6F9E65FCF33
              73EBC68A747D4DC22E6D4090B93C3A012648B4000D75EB5A0000000049454E44
              AE426082}
          end>
      end
      item
        Name = 'Item36'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000C64944415478DAAD920B1284200840E1647A33F166763256CAFCADB6
              A4CB4C5332F67C800840CCE0106220F8FC2DE1C933110103E7DCAFC0B839837A
              E07508F22BE06D38826E19D6C9DAF2B5A100CBCF051C82056BCD99DD00CAC237
              965B864738D85893271EDB074B3DAC0DF97CB5E5F7935F325C854E0D6BE0EC8E
              BE36BCEE6131AC0F5832BC2D7BC3275B85A128128CA0235B8561DC928023BBAF
              B5C650EEE153C9CDF034863D70D647C9A90D35E5AA7B38030E0F890669923B41
              E94986529A2387FF787F00EB1A0DFFCB852A5C0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item37'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B94944415478DACD92010E84200C04D99FF1B3C39FF133AE95AB142D
              82E2256EA24028D36D01C925F7A4C040F0D010EDE316906407008D1AEC4405B8
              C6CC436B877450A0C042D3CF0EAA01DCA61E309FA475C8F915F0081D04B23381
              9DBBBC004CEC90D61A2EEEDBCA701BC8805F3FB5CB91CB51EFD0E8DB0E5A4AD6
              EFB62EBBFB0EA5CCFC2F31EBA9CA6F4ED607EA0B398911F7FF03BA07B4014734
              92F41D40AB8F00EE03638C873DEFFD1C90011A3C050C216C9F48E60CFC02C27E
              C5ED569A793D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item38'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000994944415478DACDD3DD0E80200805607972F1C96DD4DC4E08E4DF45
              DEB4A57D1C70514D359D5C148185CB54B5CC995C5030E6DCBDAF899E24F01D73
              89418D21A241C1E4AC3C4DB0611182C95A6113C4641EA2313927673AD09B5984
              B5C21D387B9B980C8BBCC0D97443609BDBC8ECB0DDFF82E1A5ACCEF03888EDDE
              9D7D817A0CBA65C4B6418D6D81163604FA334C64ED2FFD7A56B21778725D6157
              F3ED922248AB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item39'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000B44944415478DAD5D4810E842008066079F2F0C9FF44C5A8A8C3AEDD
              766D4DB3FA42300909E9CD8304CC9C5F5307B8308FC15CFA4FAFFF08FC590EC9
              3C0CE7FED49405031A4544030D831A0D97BE9C16037A1B051B803A4909E688E9
              381BE836871AD11D3695431B617B756BF5238A4E80E984D9369C43AA4D0BE10A
              15EC53FE36D06E390EAA9179119DD76D5D0F66D576D41E3CF3EBF54A240F8D54
              F51AB468305F6E0E77604799F377BB8D1605A5DCBAF33C055799D6228166FA07
              210000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item40'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000884944415478DACD93810AC0200844F3FF3FBAE59A92B674D0B14D88
              A0AED7A546B5D4820C6AE32436304180EC9078024115C83099CDB67B4E76B101
              2E251A5D13E91320B98A79F7F39900283059F700BF1F02EFC5EB17B0AE5F3801
              E37CE6394EAAFC3A702E1AACB1D514F2A730E741637F08BCB2FA33A03F0B7168
              3EC658E5DDD0B6D9CEDBE0F000CD9B93EF3E1CAB380000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Item41'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000954944415478DAB592090EC0200804E5FF8FB6521245E4B25A1243AA
              76585CA0965A6E0620105A6A19AE00DBEA126F4027859652DCE7DF5EE1B065ED
              CCBDEF01770BB9C0C82878DF1E96F65560C675042271F95702C9804AE5134029
              4075995FCE0039F43F206E8EB66DE0783B993F0287C31452A56859AF9E695905
              7AD5B361CC616CCA16700B100DF6297472F934FAD89C0657F80043C4BDEF1CB5
              BFF70000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item42'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A24944415478DACD94DB1280200844D9FFFF68122F648A628ECDB42F
              0AE469450B4C4C221038CC4195421072F4C87982000526C131E05187D158D63F
              1DAEF5107C67192ED07728C052ABE75B3D44E3CA01CE1CDA8B1780D01EF1A318
              2B4D6E96771C8265D1F8946DA7931E6E026D87E961FF1EF6D0E61EAA5764FB0B
              175BFB0FA7876FBF9404FEF6E770429DC37A4CEF8A670DAB6E8EA32D1760D9B2
              55B762059ED20576B0B1EE3899366D0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item43'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000D24944415478DAB5D3D1120221080550FC72F1CB0975EF84C0AE36B3
              D183457662802D42426F46F90BD8A80DB5522DFDEC9F99385CCE7208FC3680A5
              A72CC24C8BC333E7F3297854D509E8AB42E877057FF608EA59D9814CBC54D331
              BCF7A8BF1B400CC1BFEED000EE7A68CF0C3D06B3C8D09F2BF4EBE251F47C5FE1
              3541111D946EA447DD027D2792AD4DA808A8616A4236E27C6DC2301210681BE7
              58AEB9A71908605C93D981137054C94DD63DD4047A67E318D42AE350AE8120EE
              AAB46017F0786EF7107DF4A8059B79AA16F0CD781DFC00D779E7ED6DBCE67900
              00000049454E44AE426082}
          end>
      end
      item
        Name = 'Item44'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000A04944415478DAE593DD0E80200885E5C9AB2737CC5FF4406B72975B
              A3103F8E4014430C9E8B1290D8B02517203F4D6286728E0DF8A49086FB772809
              7F4D3C618A0F5C592A44E558E3BB0858C38BBF8FB469D45613A136A542ED0650
              3CD98E71108802B535275E80F53D07CAE66830717E045AC58603029A6700D743
              D22F932DC067EBD340BF28FC0E042998E3FA2FBB034B21FE008483EDA1AE8DCD
              F635078537A993B2EFDB5E0BCB0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item45'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000954944415478DACDD3EB0E80200805607972E0C9099CB6746A606DC5
              9F96B98FE3259024E9CD824FC07E9240826D304F606E0711A7E8126C30A2F669
              4909C10DF6181588345D1ED777B19C6E90587A0C35D1D9A88C639772BD64FD3C
              C42E8D42A0156BD219561B85C0D57E62E45076B018E8C07CA09D76BD32834308
              83565CAFD04D3AFF92B3CAC33FE3F11E3E4FF8FB3D8CD6EBE00100F799ED29F0
              DF880000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item46'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000904944415478DAADD541128020080550FEC9D3935B669AA34048B291
              81E645B8088912ED0C6410F968915374E758AF394DFDAB8A07BCF3E1412D07FB
              02274842CF0DCA2B6140EF0E874F8E21B6B98F70F48A7C978500D329A00DAA58
              82D2B582F2540E509F8A05E51DDA31C3846BD807B88E29A00F5376B8017C27F4
              630CA863DCAEC79A7829DEDAB4C33F9161ECFE059CC69FAAED95F48AD7000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item47'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000704944415478DAD5D4D10A80300805D0F9FF1FEDDC20B07115670E96
              2F498B734D22E2C6ADB2E81848D24A4FE5E0B8A207A3617042AB2F0723F83DE0
              B3EB35200C6AC09B7A0B44AF1B02E16EC039BC9705CD8935B81E5A015EF81B64
              65CAD63CD00A4E815E1D063FD6FCBCFEF383ADAA0E9FEDAEED249795FE000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item48'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DA63FCCFF09F819A809166063202994036235D0C04C9
              816864796C624419882C0E6363131B380391BD07F322C506A2BB76F07A992AB1
              4C2AA0AD81E892E458806AE07F243381413F120CA400C0D3E5D02960A9050005
              D29CED18BC5ABA0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item49'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000674944415478DAD5D4EB0A00100C0560E7FD1F1A2BCA65637329F66F
              C3A79C02EFBC3B59F813048D53C5756C81849548DB9B40E9B005FD089CBD5DDD
              5368FC052CC8A5BC058EFB8CF1E8C21B1E055BA447EF82F67415A094B29C6C3D
              37FC36186C5C02D5D73E0E06585E96EDE90BE4320000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item50'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000444944415478DA63FCCFF09F819A809166063282981400A0398C9806
              3634205480D8C4F281F4503590E661F81FC90E4646DC7C207BA81A381A86A361
              38C05EA616A0BA8100FB2FAFEDB005F4020000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item51'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007D4944415478DAED944B0EC020084487938B27A77E12AB0236315DB4
              896C4C98E1311B2481E0CDA20C8C1C8539F82E8E100E54066024E8F53EA13627
              23AA71E8B6005A1F802A2953DA2C0AD8961BFA011EE00F80F749594029CFD4DF
              01661F1808C659AE81CE2DD79B77B4F9FB7A82AE6026701CB4CA872D81BBF57D
              E005A5CFC7EDF20F9B760000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item52'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000005A4944415478DAEDD4C10AC0200C03D0E4CB4DBF3C73631715B60E76
              18AC5EC4529E3D1869186F2E16F837301496DAD821C23289F1E67E606AC2053D
              C1B95E6081976040FB36BDCF347814711F9F47E09A98E85D2D9596EF7F0E1B51
              0296ED665F6B370000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item53'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000704944415478DADDD1CB128020080550F8722F5F4E522DCAF145B8B1
              EB46743C3AC84A4A2BC37B826CCB77F23E8740C39E4859BBC0D6610FBA1138EA
              DD2C5A056BBF1C027BB54014B08BD2B957D6EE1EFE0C9CE9A51B6CFD7208ECE5
              0212119860C3E624DFC1179A0308855E38CA72F000F33FC5ED8A42C721000000
              0049454E44AE426082}
          end>
      end
      item
        Name = 'Item54'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000007F4944415478DADDD4D10E8020080550F872AE5F6E92B1AC6986F590
              F1268C13832D8E14E9CDE03941D6F416A9CE8F40C54AE4FC7681AD660F3A11D8
              DBDD5DB40AD6AE9C73C703A617078408C8D88400C89A15B39AA19A73EDB09CE6
              27606F974360EBCA7B2D37B8C0ABC8CD0A0A971F010209C40F96535A18B6D63E
              FF835D009DD9BFEDFE8C475F0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item55'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000514944415478DADDD25B0A0020080440F7FE87DE208242A2A715B67F
              4A0D288242B10CAE8090DC642C17C112D21985CF812D6C0675049AEFF0085883
              B7EE702E481F09D5FD0B44E731F11A341FD917584F0000E849ED162939F20000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'Item56'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000644944415478DAED95DB0A00101044CDFF7FF4DA456E0F12A324FB62
              25D3712810278E59B040D8A0A53D2881A1D1961218C052DD49F81D3EEBD080E2
              5EA2C318BA480819ACB01C6E110E1C1E7836E55276D3A43E7276904897C73EB0
              D0B60A66E7607F011EC90381ED12D056E50000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item57'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000604944415478DAED94C10A00200843DDFF7FB469141DC4A232086A17
              F5F29C3B0826A6484181D022921E21C0DC481B02CCC68AEE74F8337C3B43753D
              BFC071B8067332C4E05BF4179D7168811B1912ED3FC406601887ABB55EE49E3C
              3B1B609412DD0681ED83FAFFA10000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item58'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D000000764944415478DACD95D10AC0200845BBFFFFD14D0B758D82950AF9A2
              0B3A9CDDD8422DB5441618086E54344397753E00B681C60EC44B791F8A2626DB
              152286FBA613C380574ECED0091C334C333CAF45864E60A8E13CC39B0CEFCF30
              016887E2A5B110EC07DBBF0E313DEE5FA0D98E11FC7D46F415F0008E8688ED28
              9D1FED0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Item59'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000140000001408060000008D891D
              0D0000006C4944415478DACD95410EC0200804D9FF3F1AB5626AA31E84D5948B
              70998C4BA2505161162A1046559080D6328045AB0DCA34446E69405886FF3494
              3B19FA37BEC83008A41ACE33A4193E58BCC07DF0244374AFC5BEE5992D8F407F
              7D9612AD22341886CFD595BD33D85F400274BE87ED466A04440000000049454E
              44AE426082}
          end>
      end
      item
        Name = 'AJUSTE'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0080808000808080008080800080808000808080008080
              8000808080008080800080808000808080008080800080808000808080008080
              800080808000808080008080800080808000FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00808080000000FF000000FF00FFFFFF00FFFFFF00FFFF
              FF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF000000FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000
              FF000000FF00FF000000FF000000FFFFFF00FFFFFF00FFFFFF000000FF000000
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00808080008080800080808000FF000000FF000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF0000000000FFFFFF000000
              0000FFFFFF00FFFFFF00808080008080800080808000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              000000000000000000000000000000000000FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
              FF000000FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FF000000FF000000FFFFFF000000FF000000FF00FFFFFF00FFFFFF00FFFF
              FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFFFF00FFFF
              FF00FFFFFF000000FF00FF000000FF000000FFFFFF0000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00808080008080800080808000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF00
              0000FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFF
              FF00FFFFFF00FFFFFF00808080008080800080808000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FF000000FF0000000000FF00FFFFFF00FFFFFF0080808000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FF000000FFFF
              FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          end>
      end
      item
        Name = 'HELP'
        SourceImages = <
          item
            Image.Data = {
              424D760600000000000036000000280000001400000014000000010020000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FF
              FF0000FFFF00000080000000FF000000800000FFFF0000FFFF0000FFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000
              FF0000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF00000080000000FF000000800000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000
              800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
              FF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF000000FF000000FF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
              FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
              FF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
              80000000800000FFFF0000FFFF00000080000000FF000000FF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF000000FF000000FF0000FFFF0000FFFF000000
              80000000FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
              FF000000FF000000800000FFFF00000080000000FF000000FF0000FFFF0000FF
              FF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF000000
              FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF000000FF000000FF000000FF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FF
              FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
              FF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          end>
      end>
    Left = 1569
    Top = 545
  end
  object ImageList1: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Item1'
        Name = 'Item1'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Item2'
        Name = 'Item2'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Item3'
        Name = 'Item3'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Item4'
        Name = 'Item4'
      end
      item
        CollectionIndex = 4
        CollectionName = 'Item5'
        Name = 'Item5'
      end
      item
        CollectionIndex = 5
        CollectionName = 'Item6'
        Name = 'Item6'
      end
      item
        CollectionIndex = 6
        CollectionName = 'Item7'
        Name = 'Item7'
      end
      item
        CollectionIndex = 7
        CollectionName = 'Item8'
        Name = 'Item8'
      end
      item
        CollectionIndex = 8
        CollectionName = 'Item9'
        Name = 'Item9'
      end
      item
        CollectionIndex = 9
        CollectionName = 'Item10'
        Name = 'Item10'
      end
      item
        CollectionIndex = 10
        CollectionName = 'Item11'
        Name = 'Item11'
      end
      item
        CollectionIndex = 11
        CollectionName = 'Item12'
        Name = 'Item12'
      end
      item
        CollectionIndex = 12
        CollectionName = 'Item13'
        Name = 'Item13'
      end
      item
        CollectionIndex = 13
        CollectionName = 'Item14'
        Name = 'Item14'
      end
      item
        CollectionIndex = 14
        CollectionName = 'Item15'
        Name = 'Item15'
      end
      item
        CollectionIndex = 15
        CollectionName = 'Item16'
        Name = 'Item16'
      end
      item
        CollectionIndex = 16
        CollectionName = 'Item17'
        Name = 'Item17'
      end
      item
        CollectionIndex = 17
        CollectionName = 'Item18'
        Name = 'Item18'
      end
      item
        CollectionIndex = 18
        CollectionName = 'Item19'
        Name = 'Item19'
      end
      item
        CollectionIndex = 19
        CollectionName = 'Item20'
        Name = 'Item20'
      end
      item
        CollectionIndex = 20
        CollectionName = 'Item21'
        Name = 'Item21'
      end
      item
        CollectionIndex = 21
        CollectionName = 'Item22'
        Name = 'Item22'
      end
      item
        CollectionIndex = 22
        CollectionName = 'Item23'
        Name = 'Item23'
      end
      item
        CollectionIndex = 23
        CollectionName = 'Item24'
        Name = 'Item24'
      end
      item
        CollectionIndex = 24
        CollectionName = 'Item25'
        Name = 'Item25'
      end
      item
        CollectionIndex = 25
        CollectionName = 'Item26'
        Name = 'Item26'
      end
      item
        CollectionIndex = 26
        CollectionName = 'Item27'
        Name = 'Item27'
      end
      item
        CollectionIndex = 27
        CollectionName = 'Item28'
        Name = 'Item28'
      end
      item
        CollectionIndex = 28
        CollectionName = 'Item29'
        Name = 'Item29'
      end
      item
        CollectionIndex = 29
        CollectionName = 'Item30'
        Name = 'Item30'
      end
      item
        CollectionIndex = 30
        CollectionName = 'Item31'
        Name = 'Item31'
      end
      item
        CollectionIndex = 31
        CollectionName = 'Item32'
        Name = 'Item32'
      end
      item
        CollectionIndex = 32
        CollectionName = 'Item33'
        Name = 'Item33'
      end
      item
        CollectionIndex = 33
        CollectionName = 'Item34'
        Name = 'Item34'
      end
      item
        CollectionIndex = 34
        CollectionName = 'Item35'
        Name = 'Item35'
      end
      item
        CollectionIndex = 35
        CollectionName = 'Item36'
        Name = 'Item36'
      end
      item
        CollectionIndex = 36
        CollectionName = 'Item37'
        Name = 'Item37'
      end
      item
        CollectionIndex = 37
        CollectionName = 'Item38'
        Name = 'Item38'
      end
      item
        CollectionIndex = 38
        CollectionName = 'Item39'
        Name = 'Item39'
      end
      item
        CollectionIndex = 39
        CollectionName = 'Item40'
        Name = 'Item40'
      end
      item
        CollectionIndex = 40
        CollectionName = 'Item41'
        Name = 'Item41'
      end
      item
        CollectionIndex = 41
        CollectionName = 'Item42'
        Name = 'Item42'
      end
      item
        CollectionIndex = 42
        CollectionName = 'Item43'
        Name = 'Item43'
      end
      item
        CollectionIndex = 43
        CollectionName = 'Item44'
        Name = 'Item44'
      end
      item
        CollectionIndex = 44
        CollectionName = 'Item45'
        Name = 'Item45'
      end
      item
        CollectionIndex = 45
        CollectionName = 'Item46'
        Name = 'Item46'
      end
      item
        CollectionIndex = 46
        CollectionName = 'Item47'
        Name = 'Item47'
      end
      item
        CollectionIndex = 47
        CollectionName = 'Item48'
        Name = 'Item48'
      end
      item
        CollectionIndex = 48
        CollectionName = 'Item49'
        Name = 'Item49'
      end
      item
        CollectionIndex = 49
        CollectionName = 'Item50'
        Name = 'Item50'
      end
      item
        CollectionIndex = 50
        CollectionName = 'Item51'
        Name = 'Item51'
      end
      item
        CollectionIndex = 51
        CollectionName = 'Item52'
        Name = 'Item52'
      end
      item
        CollectionIndex = 52
        CollectionName = 'Item53'
        Name = 'Item53'
      end
      item
        CollectionIndex = 53
        CollectionName = 'Item54'
        Name = 'Item54'
      end
      item
        CollectionIndex = 54
        CollectionName = 'Item55'
        Name = 'Item55'
      end
      item
        CollectionIndex = 55
        CollectionName = 'Item56'
        Name = 'Item56'
      end
      item
        CollectionIndex = 56
        CollectionName = 'Item57'
        Name = 'Item57'
      end
      item
        CollectionIndex = 57
        CollectionName = 'Item58'
        Name = 'Item58'
      end
      item
        CollectionIndex = 58
        CollectionName = 'Item59'
        Name = 'Item59'
      end
      item
        CollectionIndex = 59
        CollectionName = 'AJUSTE'
        Name = 'AJUSTE'
      end
      item
        CollectionIndex = 60
        CollectionName = 'HELP'
        Name = 'HELP'
      end>
    ImageCollection = ImageCollection1
    Width = 20
    Height = 20
    Left = 1385
    Top = 633
  end
end
