object EphemerForm: TEphemerForm
  Left = 0
  Top = 0
  Caption = 'Eph'#233'm'#233'rides IMCCE'
  ClientHeight = 414
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -28
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 192
  TextHeight = 38
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 982
    Height = 289
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      'Pour r'#233'cup'#233'rer des '#233'ph'#233'm'#233'rides de plan'#232'tes, com'#232'tes ...'
      
        'Acc'#233'dez au serveur d'#39#233'ph'#233'm'#233'rides de l'#39'institut de m'#233'canique c'#233'le' +
        'ste (IMCCE)'
      
        'en cliquant sur le bouton ci-dessous, puis, lorsque vous aurez g' +
        #233'n'#233'r'#233' les '
      'donn'#233'es,'
      'sauvegardez celles-ci dans un fichier Votable (extension .xml) '
      'en cliquant sur le bouton en haut '#224' droite du tableau.'
      'Enfin chargez celui-ci dans Regressi.')
    TabOrder = 0
    ExplicitWidth = 968
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 320
    Width = 200
    Height = 60
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'IMCCE'
    ImageIndex = 40
    ImageName = 'ephemer'
    Images = FRegressiMain.VirtualImageList1
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 608
    Top = 320
    Width = 200
    Height = 60
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
