object FrmMain: TFrmMain
  Left = 293
  Top = 232
  Anchors = [akLeft, akTop, akRight]
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FrmMain'
  ClientHeight = 161
  ClientWidth = 401
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
  OnShow = FormShow
  DesignSize = (
    401
    161)
  PixelsPerInch = 96
  TextHeight = 13
  object BIT0: TJvLED
    Left = 24
    Top = 40
  end
  object BIT1: TJvLED
    Left = 72
    Top = 40
  end
  object BIT2: TJvLED
    Left = 120
    Top = 40
  end
  object BIT3: TJvLED
    Left = 168
    Top = 40
  end
  object BIT4: TJvLED
    Left = 216
    Top = 40
  end
  object BIT5: TJvLED
    Left = 264
    Top = 40
  end
  object BIT6: TJvLED
    Left = 312
    Top = 40
  end
  object BIT7: TJvLED
    Left = 360
    Top = 40
  end
  object BvlLEDHeader: TBevel
    Left = 0
    Top = 16
    Width = 401
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object LblLEDHeader: TLabel
    Left = 8
    Top = 10
    Width = 70
    Height = 13
    Caption = 'LblLEDHeader'
  end
  object LblBIT0: TLabel
    Left = 14
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT0'
  end
  object LblBIT1: TLabel
    Left = 62
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT1'
  end
  object LblBIT2: TLabel
    Left = 110
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT2'
  end
  object LblBIT3: TLabel
    Left = 158
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT3'
  end
  object LblBIT4: TLabel
    Left = 206
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT4'
  end
  object LblBIT5: TLabel
    Left = 254
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT5'
  end
  object LblBIT6: TLabel
    Left = 302
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT6'
  end
  object LblBIT7: TLabel
    Left = 350
    Top = 64
    Width = 37
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'LblBIT7'
  end
  object BvlActionsHeader: TBevel
    Left = 0
    Top = 112
    Width = 401
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object LblActionsHeader: TLabel
    Left = 8
    Top = 106
    Width = 84
    Height = 13
    Caption = 'LblActionsHeader'
  end
  object Button1: TButton
    Left = 160
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 320
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
  end
end
