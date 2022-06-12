object ZoomManuelFFTdlg: TZoomManuelFFTdlg
  Left = 241
  Top = 152
  Caption = 'Echelle Manuelle FFT'
  ClientHeight = 166
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 36
  object PanelZoom: TPanel
    Left = 0
    Top = 0
    Width = 386
    Height = 166
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    TabOrder = 0
    object MaxiLabel: TLabel
      Left = 208
      Top = 16
      Width = 54
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Maxi'
    end
    object MiniLabel: TLabel
      Left = 32
      Top = 16
      Width = 50
      Height = 36
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Mini'
    end
    object FminEdit: TEdit
      Left = 16
      Top = 72
      Width = 160
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 0
    end
    object FmaxEdit: TEdit
      Left = 208
      Top = 72
      Width = 160
      Height = 44
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      TabOrder = 1
    end
  end
  object OKBtn: TBitBtn
    Left = 398
    Top = 16
    Width = 320
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Imposer l'#39#233'chelle'
    Default = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333300003EEEC87778777877787300003EECE08888888888888300003ECE
      EE0778777877787300003CEEE00008777877787300003EEE0BFBF07778777873
      000030E0BFBFBF08888888830000380BFBFBFBF0787778730000380FBFBFB0B0
      787778730000380B0BF0FB07787778730000380FB0BF0FB08888888300003870
      080BF0F078777873000038777870BF0078777873000038777877000778777873
      0000388888888888888888830000387778777877787778730000387778777877
      7877787300003877787778777877787300003888888888888888888300003333
      33333333333333330000}
    Margin = 2
    ModalResult = 1
    Spacing = -1
    TabOrder = 1
    OnClick = OKBtnClick
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 402
    Top = 98
    Width = 320
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Cancel = True
    Caption = 'Echelle &automatique'
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333330222393333333333333333937EA633933333333333330933CCCC3339
      3333333333309033132933339333333333090333FFFB33333933333330903333
      00023333339333330903333377F633333709073390333333CCCC333307779709
      33333333103133307333399033333333FFFE3377333339977333333300003307
      3333933903333333277F33073339333793333333CCCC33073393333709333333
      111133773933333773933333FFBB333093333370333933330000333907777703
      33339333777733933700073333333933CCCC3933333333333333339311113333
      3333333333333333FFFF}
    Margin = 2
    ModalResult = 2
    Spacing = -1
    TabOrder = 2
    OnClick = CancelBtnClick
    IsControl = True
  end
end
