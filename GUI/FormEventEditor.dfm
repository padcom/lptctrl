object FrmEventEditor: TFrmEventEditor
  Left = 319
  Top = 326
  BorderStyle = bsDialog
  Caption = 'Event editor'
  ClientHeight = 113
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object LblDate: TLabel
    Left = 8
    Top = 16
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object LblTime: TLabel
    Left = 184
    Top = 16
    Width = 23
    Height = 13
    Caption = 'Time'
  end
  object LblState: TLabel
    Left = 296
    Top = 16
    Width = 25
    Height = 13
    Caption = 'State'
  end
  object EdtDate: TDateTimePicker
    Left = 8
    Top = 32
    Width = 169
    Height = 21
    Date = 39289.842905266200000000
    Time = 39289.842905266200000000
    TabOrder = 0
  end
  object CbxState: TComboBox
    Left = 296
    Top = 32
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      'On'
      'Off')
  end
  object BtnOk: TButton
    Left = 96
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BtnCancel: TButton
    Left = 184
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object EdtTime: TDateTimePicker
    Left = 184
    Top = 32
    Width = 97
    Height = 21
    Date = 39289.851987476850000000
    Time = 39289.851987476850000000
    Kind = dtkTime
    TabOrder = 4
  end
end
