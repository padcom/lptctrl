unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, ActnList, ComCtrls, ToolWin,
  JvExControls, JvLED, ExtCtrls;

type
  TFrmMain = class(TForm)
    BIT0: TJvLED;
    BIT1: TJvLED;
    BIT2: TJvLED;
    BIT3: TJvLED;
    BIT4: TJvLED;
    BIT5: TJvLED;
    BIT6: TJvLED;
    BIT7: TJvLED;
    BtnBIT0: TButton;
    BtnBIT1: TButton;
    BtnBIT2: TButton;
    BtnBIT3: TButton;
    BtnBIT4: TButton;
    BtnBIT5: TButton;
    BtnBIT6: TButton;
    BtnBIT7: TButton;
    TmrStatusUpdate: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TmrStatusUpdateTimer(Sender: TObject);
    procedure BtnManageClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateLEDs;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  LPTClient, OutputControler;

{$R *.dfm}

{ TFrmMain }

{ Private declarations }

procedure TFrmMain.UpdateLEDs;
var
  Status: Integer;
begin
  Status := Client.GetPortStatus;
  BIT0.ColorOn := clGreen;
  BIT0.Status := Status and 1 <> 0;
  BIT1.ColorOn := clGreen;
  BIT1.Status := Status and 2 <> 0;
  BIT2.ColorOn := clGreen;
  BIT2.Status := Status and 4 <> 0;
  BIT3.ColorOn := clGreen;
  BIT3.Status := Status and 8 <> 0;
  BIT4.ColorOn := clGreen;
  BIT4.Status := Status and 16 <> 0;
  BIT5.ColorOn := clGreen;
  BIT5.Status := Status and 32 <> 0;
  BIT6.ColorOn := clGreen;
  BIT6.Status := Status and 64 <> 0;
  BIT7.ColorOn := clGreen;
  BIT7.Status := Status and 128 <> 0;
end;

{ Public declarations }

{ Event handlers }

procedure TFrmMain.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  UpdateLEDs;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
//
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  function KeyToBit(Key: Word): Integer;
  begin
    Result := -1;
    case Key of
      VK_F1: Result := 0;
      VK_F2: Result := 1;
      VK_F3: Result := 2;
      VK_F4: Result := 3;
      VK_F5: Result := 4;
      VK_F6: Result := 5;
      VK_F7: Result := 6;
      VK_F8: Result := 7;
      VK_F9: Result := 256;
      VK_F10: Result := 257;
    end;
  end;
var
  Bit: Integer;
  Status: Byte;
begin
  Bit := KeyToBit(Key);
  if Bit in [0..7] then
  begin
    Screen.Cursor := crHourGlass;
    try
      Status := Client.GetPortStatus;
      Status := Status xor (1 shl BIT);
      Client.SetPortStatus(Status);
      UpdateLEDs;
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else if Bit = 256 then
  begin
    Screen.Cursor := crHourGlass;
    try
      Client.SetPortStatus(255);
      UpdateLEDs;
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else if Bit = 257 then
  begin
    Screen.Cursor := crHourGlass;
    try
      Client.SetPortStatus(0);
      UpdateLEDs;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFrmMain.TmrStatusUpdateTimer(Sender: TObject);
begin
  UpdateLEDs;
end;

procedure TFrmMain.BtnManageClick(Sender: TObject);
begin
  TOutputControler.Instance[TComponent(Sender).Tag].Show;
end;

end.

