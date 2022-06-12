object LoupeForm: TLoupeForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 100
  Color = clOlive
  TransparentColor = True
  TransparentColorValue = clOlive
  Constraints.MaxHeight = 128
  Constraints.MaxWidth = 128
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 0
    Top = 0
    Width = 100
    Height = 100
    Align = alClient
    Color = clBlack
    ParentColor = False
    ExplicitWidth = 128
  end
end
