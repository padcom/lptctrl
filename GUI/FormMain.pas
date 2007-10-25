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

procedure TFrmMain.TmrStatusUpdateTimer(Sender: TObject);
begin
  UpdateLEDs;
end;

procedure TFrmMain.BtnManageClick(Sender: TObject);
begin
  TOutputControler.Instance[TComponent(Sender).Tag].Show;
end;

end.

