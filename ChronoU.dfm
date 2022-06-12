object VideoChronoForm: TVideoChronoForm
  Left = 215
  Top = 246
  Caption = 'Chronophotographie '#224' partir de video'
  ClientHeight = 960
  ClientWidth = 1284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 1284
    Height = 878
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    Proportional = True
    Stretch = True
    OnClick = Image1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 878
    Width = 1284
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 0
    object PasBtn: TButton
      Left = 336
      Top = 12
      Width = 546
      Height = 60
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Indiquer le pas sur l'#39'image'
      TabOrder = 0
      OnClick = PasBtnClick
    end
  end
end
