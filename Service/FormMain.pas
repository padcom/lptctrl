unit FormMain;

interface

uses
  Windows, Messages, Winsock, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, GUIUpdater, TimelineControler,
  JvExControls, JvLED;

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
    BvlLEDHeader: TBevel;
    LblLEDHeader: TLabel;
    LblBIT0: TLabel;
    LblBIT1: TLabel;
    LblBIT2: TLabel;
    LblBIT3: TLabel;
    LblBIT4: TLabel;
    LblBIT5: TLabel;
    LblBIT6: TLabel;
    LblBIT7: TLabel;
    BvlActionsHeader: TBevel;
    LblActionsHeader: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FGUIUpdater: TGUIUpdater;
    FTimelineControler: TTimelineControler;
    procedure AssignLanguage;
    procedure UpdateLEDs(Sender: TObject; Value: Byte);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  LPTPort, TimelineFile, PxDataFile, DateUtils,
  LPTControllerAddEventRequestHandler, LPTControllerRequestHandlerBag, ObjectWithTimelineControler,
  Protocol, LPTControlerClient;

{$R *.dfm}

{ Private declarations }

procedure TFrmMain.AssignLanguage;
begin
  Caption := 'LPTControler Service';
  LblLEDHeader.Caption := ' LPT Port bits visualization ';
  LblBIT0.Caption := 'BIT0';
  LblBIT1.Caption := 'BIT1';
  LblBIT2.Caption := 'BIT2';
  LblBIT3.Caption := 'BIT3';
  LblBIT4.Caption := 'BIT4';
  LblBIT5.Caption := 'BIT5';
  LblBIT6.Caption := 'BIT6';
  LblBIT7.Caption := 'BIT7';
  LblActionsHeader.Caption := ' Operations ';
end;

procedure TFrmMain.UpdateLEDs(Sender: TObject; Value: Byte);
begin
  BIT0.Status := (Value and 1) <> 0;
  BIT1.Status := (Value and 2) <> 0;
  BIT2.Status := (Value and 4) <> 0;
  BIT3.Status := (Value and 8) <> 0;
  BIT4.Status := (Value and 16) <> 0;
  BIT5.Status := (Value and 32) <> 0;
  BIT6.Status := (Value and 64) <> 0;
  BIT7.Status := (Value and 128) <> 0;
end;

{ Public declarations }

{ Event handlers }

procedure TFrmMain.FormCreate(Sender: TObject);
var
  EventHandler: IObjectWithTimelineControler;
begin
  AssignLanguage;
  Sleep(100);
  FTimelineControler := TTimelineControler.Create;
  EventHandler := TLPTControllerRequestHandlerBag.Instance.GetHandlerForCommand(CMD_ADD_EVENT) as IObjectWithTimelineControler;
  EventHandler.TimelineControler := FTimelineControler;
  EventHandler := TLPTControllerRequestHandlerBag.Instance.GetHandlerForCommand(CMD_REMOVE_EVENT) as IObjectWithTimelineControler;
  EventHandler.TimelineControler := FTimelineControler;
  EventHandler := TLPTControllerRequestHandlerBag.Instance.GetHandlerForCommand(CMD_LIST_EVENTS) as IObjectWithTimelineControler;
  EventHandler.TimelineControler := FTimelineControler;

  FGUIUpdater := TGUIUpdater.Create;
  FGUIUpdater.OnUpdateGUI := UpdateLEDs;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGUIUpdater);
  FreeAndNil(FTimelineControler);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmMain.Button1Click(Sender: TObject);
var
  Client: TLPTControlerClient;
begin
  Client := TLPTControlerClient.Create;
  try
    Client.AddEvent(Now + OneHour + OneSecond * 3, 5, bsOn);
    Client.AddEvent(Now + OneHour + OneSecond * 4, 5, bsOff);
    Client.AddEvent(Now + OneHour + OneSecond * 5, 5, bsOff);
    Client.RemoveEvent(Now + OneHour + OneSecond * 5, 5);
  finally
    Client.Free;
  end;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
var
  Client: TLPTControlerClient;
  Events: TEventList;
begin
  Client := TLPTControlerClient.Create;
  try
    Client.GetEventList(Events);
    ShowMessageFmt('Events count: %d', [Length(Events)]);
  finally
    Client.Free;
  end;
end;

end.

