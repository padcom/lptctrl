object FrmOutputControler: TFrmOutputControler
  Left = 341
  Top = 285
  BorderStyle = bsDialog
  Caption = 'BIT editor'
  ClientHeight = 219
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LedStatus: TJvLED
    Left = 16
    Top = 184
    Width = 25
    Height = 25
    ColorOn = clGray
  end
  object LblEvents: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Events'
  end
  object GrdEvents: TDrawGrid
    Left = 8
    Top = 24
    Width = 537
    Height = 144
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnDblClick = GrdEventsDblClick
    OnDrawCell = GrdEventsDrawCell
  end
  object BtnToggle: TButton
    Left = 48
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Toggle'
    TabOrder = 1
    OnClick = BtnToggleClick
  end
  object BtnAddEvent: TButton
    Left = 272
    Top = 184
    Width = 89
    Height = 25
    Action = ActAddEvent
    TabOrder = 2
  end
  object BtnRemoveEvent: TButton
    Left = 368
    Top = 184
    Width = 89
    Height = 25
    Action = ActRemoveEvent
    TabOrder = 3
  end
  object BtnClose: TButton
    Left = 472
    Top = 184
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 4
    OnClick = BtnCloseClick
  end
  object TmrUpdate: TTimer
    Interval = 2000
    OnTimer = TmrUpdateTimer
    Left = 152
    Top = 176
  end
  object Actions: TActionList
    Left = 184
    Top = 176
    object ActAddEvent: TAction
      Caption = 'Add Event'
      OnExecute = ActAddEventExecute
      OnUpdate = ActAddEventUpdate
    end
    object ActRemoveEvent: TAction
      Caption = 'Remove Event'
      OnExecute = ActRemoveEventExecute
      OnUpdate = ActRemoveEventUpdate
    end
    object ActEditEvent: TAction
      Caption = 'Edit Event'
      OnExecute = ActEditEventExecute
      OnUpdate = ActEditEventUpdate
    end
  end
end
