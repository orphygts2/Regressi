object RollingShutterForm: TRollingShutterForm
  Left = 0
  Top = 0
  Caption = 'Obturateur d'#233'roulant'
  ClientHeight = 538
  ClientWidth = 908
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -27
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 192
  TextHeight = 37
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 908
    Height = 274
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      
        'L'#39'acquisition de video avec un capteur CMOS implique l'#39'utilisati' +
        'on d'#39'un '
      
        'obturateur d'#233'roulant '#233'lectronique (rolling shutter), ce qui cr'#233'e' +
        ' un d'#233'calage '
      'temporel entre les lignes.'
      
        'La correction '#224' indiquer est le d'#233'calage entre les lignes extr'#234'm' +
        'es.'
      
        'En absence de renseignement ou de mesure pr'#233'cise, on peut prendr' +
        'e '
      '1/ (nombre maxi d'#39'images par seconde).'
      
        'Pour la cam'#233'ra Sordalab,  0,76/ (nombre maxi d'#39'images par second' +
        'e).'
      '')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 640
    Top = 384
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Fermer'
    ModalResult = 1
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 280
    Width = 449
    Height = 236
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sens de d'#233'filement de l'#39'obturateur'
    TabOrder = 2
    object UpBtn: TRadioButton
      Left = 160
      Top = 34
      Width = 90
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #8595
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -38
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = UpBtnClick
    end
    object LeftBtn: TRadioButton
      Left = 32
      Top = 100
      Width = 90
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -38
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DownBtn: TRadioButton
      Left = 160
      Top = 176
      Width = 90
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #8593
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -38
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object RightBtn: TRadioButton
      Left = 260
      Top = 100
      Width = 90
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = #8592
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -38
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
