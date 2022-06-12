object ChoixIdentPagesDlg: TChoixIdentPagesDlg
  Left = 401
  Top = 280
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = 'Options d'#39'identification de pages'
  ClientHeight = 201
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 17
  object OKBtn: TBitBtn
    Left = 147
    Top = 19
    Width = 100
    Height = 27
    Caption = '&OK'
    Kind = bkOK
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 3
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 147
    Top = 116
    Width = 100
    Height = 27
    Caption = '&Abandon'
    Kind = bkCancel
    Margin = 2
    NumGlyphs = 2
    Spacing = -1
    TabOrder = 4
    IsControl = True
  end
  object CommentaireCB: TCheckBox
    Left = 4
    Top = 151
    Width = 130
    Height = 17
    Caption = 'Commentaire'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object ParamGB: TGroupBox
    Left = 4
    Top = 0
    Width = 130
    Height = 145
    Caption = 'Param'#232'tres'
    TabOrder = 0
    object ListeConstBox: TCheckListBox
      Left = 2
      Top = 19
      Width = 126
      Height = 124
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
    end
  end
  object NewIdentPageCB: TCheckBox
    Left = 4
    Top = 176
    Width = 130
    Height = 17
    Caption = 'panneau lat'#233'ral'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
end
