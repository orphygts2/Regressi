object ChoixIdentPagesDlg: TChoixIdentPagesDlg
  Left = 401
  Top = 280
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Options d'#39'identification de pages'
  ClientHeight = 402
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -26
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 192
  TextHeight = 36
  object OKBtn: TBitBtn
    Left = 294
    Top = 38
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&OK'
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 294
    Top = 232
    Width = 200
    Height = 54
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = '&Abandon'
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 4
    IsControl = True
  end
  object CommentaireCB: TCheckBox
    Left = 8
    Top = 302
    Width = 260
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Commentaire'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object ParamGB: TGroupBox
    Left = 8
    Top = 0
    Width = 260
    Height = 290
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Param'#232'tres'
    TabOrder = 0
    object ListeConstBox: TCheckListBox
      Left = 2
      Top = 38
      Width = 256
      Height = 250
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 36
      ParentFont = False
      TabOrder = 0
    end
  end
  object NewIdentPageCB: TCheckBox
    Left = 8
    Top = 352
    Width = 260
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'panneau lat'#233'ral'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
end
