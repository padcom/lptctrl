object FrmMain: TFrmMain
  Left = 290
  Top = 352
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'LPT Remote controller'
  ClientHeight = 73
  ClientWidth = 709
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
  object BIT0: TJvLED
    Left = 40
    Top = 8
    ColorOn = clGray
  end
  object BIT1: TJvLED
    Left = 128
    Top = 8
    ColorOn = clGray
  end
  object BIT2: TJvLED
    Left = 216
    Top = 8
    ColorOn = clGray
  end
  object BIT3: TJvLED
    Left = 304
    Top = 8
    ColorOn = clGray
  end
  object BIT4: TJvLED
    Left = 392
    Top = 8
    ColorOn = clGray
  end
  object BIT5: TJvLED
    Left = 480
    Top = 8
    ColorOn = clGray
  end
  object BIT6: TJvLED
    Left = 568
    Top = 8
    ColorOn = clGray
  end
  object BIT7: TJvLED
    Left = 656
    Top = 8
    ColorOn = clGray
  end
  object BtnBIT0: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT0'
    TabOrder = 0
    OnClick = BtnManageClick
  end
  object BtnBIT1: TButton
    Tag = 1
    Left = 96
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT1'
    TabOrder = 1
    OnClick = BtnManageClick
  end
  object BtnBIT2: TButton
    Tag = 2
    Left = 184
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT2'
    TabOrder = 2
    OnClick = BtnManageClick
  end
  object BtnBIT3: TButton
    Tag = 3
    Left = 272
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT3'
    TabOrder = 3
    OnClick = BtnManageClick
  end
  object BtnBIT4: TButton
    Tag = 4
    Left = 360
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT4'
    TabOrder = 4
    OnClick = BtnManageClick
  end
  object BtnBIT5: TButton
    Tag = 5
    Left = 448
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT5'
    TabOrder = 5
    OnClick = BtnManageClick
  end
  object BtnBIT6: TButton
    Tag = 6
    Left = 536
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT6'
    TabOrder = 6
    OnClick = BtnManageClick
  end
  object BtnBIT7: TButton
    Tag = 7
    Left = 624
    Top = 40
    Width = 75
    Height = 25
    Caption = 'BIT7'
    TabOrder = 7
    OnClick = BtnManageClick
  end
  object TmrStatusUpdate: TTimer
    Interval = 2000
    OnTimer = TmrStatusUpdateTimer
    Left = 72
    Top = 8
  end
end
