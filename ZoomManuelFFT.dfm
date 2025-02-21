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
    ExplicitHeight = 165
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
    ImageIndex = 44
    ImageName = 'zoomman'
    Images = FRegressiMain.VirtualImageList1
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
    ImageIndex = 43
    ImageName = 'ZOOMSANS'
    Images = FRegressiMain.VirtualImageList1
    Margin = 2
    ModalResult = 2
    Spacing = -1
    TabOrder = 2
    OnClick = CancelBtnClick
    IsControl = True
  end
end
