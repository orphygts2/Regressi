object AideDlg: TAideDlg
  Left = 224
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Aide configuration Regressi'
  ClientHeight = 736
  ClientWidth = 1288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 192
  TextHeight = 36
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 1288
    Height = 644
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    Lines.Strings = (
      
        'ConfigRegressi.exe permet d'#39'imposer une configuration par d'#233'faut' +
        ' au d'#233'marrage de Regressi sur une machine.'
      
        'Cela n'#39'est utile que si chaque utilisateur se connecte sous une ' +
        'session diff'#233'rente. '
      
        'Si vous voulez laisser chaque utilisateur libre de configurer co' +
        'mme il l'#39'entend, cliquer sur le bouton "Lib'#232're".'
      ''
      
        'Remarque : une partie des options est sauv'#233'e dans les fichiers d' +
        'e donn'#233'es et celles-ci sont prioritaires quand '
      
        'vous chargez le fichier. Les options que vous imposez sont celle' +
        's au d'#233'marrage de Regressi.'
      ''
      
        'ConfigRegressi.exe doit se trouver dans le m'#234'me r'#233'pertoire que R' +
        'egressi.exe. '
      
        'Le fichier de configuration regressi.ini se trouve dans le r'#233'per' +
        'toire de Regressi. '
      
        'Pour utiliser configRegressi vous devez avoir des droits de lect' +
        'ure et '#233'criture dans ce r'#233'pertoire.'
      
        'Pour que Regressi puisse utiliser ce fichier, l'#8217'utilisateur doit' +
        ' avoir des droits de lecture dans ce r'#233'pertoire.'
      ''
      
        'Vous pouvez donc transporter une configuration d'#39'un ordinateur '#224 +
        ' un autre en transportant le fichier regressi.ini '
      
        'du r'#233'pertoire de regressi (par d'#233'faut c:\Program Files\Evariste\' +
        'Regressi)'
      ''
      
        'Vous pouvez d'#233'sormais indiquer le r'#233'pertoire de donn'#233'es "'#224' la ma' +
        'in"  pour le cas o'#249' le r'#233'pertoire de l'#39'utilisateur '
      'ne serait pas  accessible/d'#233'fini.')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 480
    Top = 656
    Width = 194
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
end
