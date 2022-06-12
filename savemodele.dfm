object SaveModeleDlg: TSaveModeleDlg
  Left = 376
  Top = 207
  HelpContext = 61
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Sauvegarde de la mod'#232'lisation'
  ClientHeight = 394
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  PixelsPerInch = 192
  TextHeight = 36
  object LabelExp: TLabel
    Left = 16
    Top = 16
    Width = 7
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
  end
  object Label1: TLabel
    Left = 16
    Top = 58
    Width = 313
    Height = 36
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Nom de la grandeur cr'#233#233'e :'
  end
  object CancelBtn: TBitBtn
    Left = 112
    Top = 318
    Width = 180
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
    TabOrder = 0
    IsControl = True
  end
  object EditNom: TEdit
    Left = 368
    Top = 52
    Width = 108
    Height = 44
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object HelpBtn: TBitBtn
    Left = 368
    Top = 318
    Width = 180
    Height = 54
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
    TabOrder = 2
    OnClick = HelpBtnClick
  end
  object SauveValeurBtn: TBitBtn
    Left = 16
    Top = 128
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les valeurs mod'#233'lis'#233'es'
    ModalResult = 1
    TabOrder = 3
    OnClick = SauveValeurBtnClick
  end
  object SauveParamBtn: TBitBtn
    Left = 16
    Top = 192
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les param'#232'tres et les valeurs page par page'
    ModalResult = 1
    TabOrder = 4
    OnClick = SauveParamBtnClick
  end
  object SauveParamGlbBtn: TBitBtn
    Left = 16
    Top = 256
    Width = 640
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Sauver les param'#232'tres et les valeurs globalement'
    ModalResult = 1
    TabOrder = 5
    OnClick = SauveParamGlbBtnClick
  end
end
