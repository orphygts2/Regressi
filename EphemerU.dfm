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
  OnCreate = FormCreate
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
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888800008888888888888888888800008888888888888888888800008888
      8888888888888888000088888888888888888888000088888888888888888888
      0000888888000000088EE888000088880088888880EEEE880000888088888888
      88EEEE880000880888888888888EE08800008088888888888888880800000888
      888BBB88888888800000088888BBBBB8888888800000088888BBBBB888888880
      0000808888BBBBB88888880800008808888BBB88888880880000888088888888
      8888088800008888008888888800888800008888880000000088888800008888
      88888888888888880000}
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
