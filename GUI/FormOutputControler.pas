unit FormOutputControler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvLED, Grids, ExtCtrls, LPTControlerClient,
  ActnList;

type
  TFrmOutputControler = class(TForm)
    GrdEvents: TDrawGrid;
    BtnToggle: TButton;
    BtnAddEvent: TButton;
    BtnRemoveEvent: TButton;
    LedStatus: TJvLED;
    BtnClose: TButton;
    LblEvents: TLabel;
    TmrUpdate: TTimer;
    Actions: TActionList;
    ActAddEvent: TAction;
    ActRemoveEvent: TAction;
    ActEditEvent: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure BtnToggleClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure TmrUpdateTimer(Sender: TObject);
    procedure GrdEventsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ActAddEventExecute(Sender: TObject);
    procedure ActAddEventUpdate(Sender: TObject);
    procedure ActRemoveEventExecute(Sender: TObject);
    procedure ActRemoveEventUpdate(Sender: TObject);
    procedure ActEditEventExecute(Sender: TObject);
    procedure ActEditEventUpdate(Sender: TObject);
    procedure GrdEventsDblClick(Sender: TObject);
  private
    { Private declarations }
    FBIT: Integer;
    Events: TEventList;
    procedure UpdateEventList;
    procedure SortEvents;
    procedure UpdateGrid;
    procedure ResizeGrid;
    procedure UpdateLED;
  public
    { Public declarations }
    property BIT: Integer read FBIT write FBIT;
  end;

implementation

uses
  LPTPort, LPTClient, FormEventEditor, OutputControler;

{$R *.dfm}

{ Private declarations }

procedure TFrmOutputControler.UpdateEventList;
var
  I, J: Integer;
begin
  SetLength(Events, 0);
  Client.GetEventList(Events);
  I := 0;
  while I < Length(Events) do
  begin
    if Events[I].Bit <> BIT then
    begin
      for J := I to Length(Events) - 2 do
        Events[J] := Events[J + 1];
      SetLength(Events, Length(Events) - 1);
    end
    else
      Inc(I);
  end;
  SortEvents;
end;

procedure TFrmOutputControler.SortEvents;
var
  I: Integer;
  Done: Boolean;
  Temp: TEvent;
begin
  repeat
    Done := True;
    for I := 0 to Length(Events) - 2 do
      if Events[I].Timestamp > Events[I + 1].Timestamp then
      begin
        Done := False;
        Temp := Events[I + 1];
        Events[I + 1] := Events[I];
        Events[I] := Temp;
      end;
  until Done;
end;

procedure TFrmOutputControler.UpdateGrid;
begin
  UpdateEventList;
  GrdEvents.RowCount := Length(Events) + 1;
  GrdEvents.ColCount := 3;
  GrdEvents.FixedCols := 0;
  if GrdEvents.RowCount = 1 then
    GrdEvents.RowHeights[0] := -1
  else
  begin
    GrdEvents.FixedRows := 1;
    GrdEvents.DefaultRowHeight := 18;
  end;
end;

procedure TFrmOutputControler.ResizeGrid;
begin
  GrdEvents.ColWidths[0] := Round(GrdEvents.ClientWidth * 0.5);
  GrdEvents.ColWidths[1] := Round(GrdEvents.ClientWidth * 0.3);
  GrdEvents.ColWidths[2] := GrdEvents.ClientWidth - GrdEvents.ColCount - GrdEvents.ColWidths[0] - GrdEvents.ColWidths[1];
end;

procedure TFrmOutputControler.UpdateLED;
begin
  LedStatus.ColorOn := clGreen;
  LedStatus.Status := Client.GetPortStatus and (1 shl BIT) <> 0;
end;

{ Public declarations }

{ Event handlers }

procedure TFrmOutputControler.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmOutputControler.FormDestroy(Sender: TObject);
begin
  TOutputControler.Instance[BIT] := nil;
end;

procedure TFrmOutputControler.FormShow(Sender: TObject);
begin
  UpdateGrid;
  ResizeGrid;
  UpdateLED;
end;

procedure TFrmOutputControler.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmOutputControler.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmOutputControler.FormResize(Sender: TObject);
begin
  ResizeGrid;
end;

procedure TFrmOutputControler.BtnToggleClick(Sender: TObject);
var
  Status: Byte;
begin
  Screen.Cursor := crHourGlass;
  try
    Status := Client.GetPortStatus;
    Status := Status xor (1 shl BIT);
    Client.SetPortStatus(Status);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmOutputControler.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmOutputControler.TmrUpdateTimer(Sender: TObject);
begin
  UpdateGrid;
  UpdateLED;
end;

procedure TFrmOutputControler.GrdEventsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  function StatusToStr(Status: TBitStatus): String;
  begin
    case Status of
      bsUnspecified:
        Result := '(unspecified)';
      bsOn:
        Result := 'ON';
      bsOff:
        Result := 'OFF';
    end;
  end;
var
  S: String;
begin
  with GrdEvents.Canvas do
  begin
    if ARow = 0 then
      case ACol of
        0: S := 'Date and time';
        1: S := 'Output';
        2: S := 'Status';
      end
    else
      case ACol of
        0: S := FormatDateTime('YYYY-MM-DD HH:NN:SS', Events[ARow - 1].Timestamp);
        1: S := Format('BIT%d', [Events[ARow - 1].Bit]);
        2: S := Format('%s', [StatusToStr(Events[ARow - 1].Status)]);
        else
           S := Format('Col: %d; Row: %d', [ACol, ARow]);
      end;
    Rect.Left := Rect.Left + 4;
    Rect.Top := Rect.Top + 2;
    DrawText(Handle, PChar(S), Length(S), Rect, DT_END_ELLIPSIS);
  end;
end;

procedure TFrmOutputControler.ActAddEventExecute(Sender: TObject);
begin
  with TFrmEventEditor.Create(nil) do
    try
      Timestamp := Now;
      State := bsUnspecified;
      if ShowModal = mrOK then
        Client.AddEvent(Timestamp, BIT, State);
    finally
      Free;
    end;
end;

procedure TFrmOutputControler.ActAddEventUpdate(Sender: TObject);
begin
  ActAddEvent.Enabled := True;
end;

procedure TFrmOutputControler.ActRemoveEventExecute(Sender: TObject);
var
  Event: TEvent;
begin
  Event := Events[GrdEvents.Row - 1];
  if MessageBox(Handle, 'Are you sure?', 'Confirm', MB_ICONQUESTION or MB_YESNO) = ID_YES then
    Client.RemoveEvent(Event.Timestamp, Event.Bit);
end;

procedure TFrmOutputControler.ActRemoveEventUpdate(Sender: TObject);
begin
  ActRemoveEvent.Enabled := GrdEvents.Row > 0;
end;

procedure TFrmOutputControler.ActEditEventExecute(Sender: TObject);
var
  Event: TEvent;
begin
  Event := Events[GrdEvents.Row - 1];

  with TFrmEventEditor.Create(nil) do
    try
      Timestamp := Event.Timestamp;
      State := Event.Status;
      if ShowModal = mrOK then
      begin
        Client.RemoveEvent(Event.Timestamp, Event.Bit);
        Client.AddEvent(Timestamp, BIT, State);
      end;
    finally
      Free;
    end;
end;

procedure TFrmOutputControler.ActEditEventUpdate(Sender: TObject);
begin
  ActEditEvent.Enabled := GrdEvents.Row > 0;
end;

procedure TFrmOutputControler.GrdEventsDblClick(Sender: TObject);
begin
  ActEditEvent.Execute;
end;

end.

