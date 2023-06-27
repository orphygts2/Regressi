object ConvergenceModeleForm: TConvergenceModeleForm
  Left = 0
  Top = 0
  Caption = 'Convergence de la mod'#233'lisation'
  ClientHeight = 887
  ClientWidth = 1226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 32
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 1226
    Height = 721
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    ExplicitWidth = 1254
  end
  object Button1: TButton
    Left = 464
    Top = 800
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 864
    Top = 800
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 800
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Button3'
    TabOrder = 2
    OnClick = Button3Click
  end
end
