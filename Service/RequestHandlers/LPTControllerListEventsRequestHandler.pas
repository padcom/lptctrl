unit LPTControllerListEventsRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag,
  TimelineControler, ObjectWithTimelineControler;

type
  TLPTControllerListEventsRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler, IObjectWithTimelineControler)
  private
    FTimelineControler: TTimelineControler;
  protected
    class function Log: TLogLogger;
    function GetCommand: Byte;
    function GetTimelineControler: TTimelineControler;
    procedure SetTimelineControler(Value: TTimelineControler);
  public
    procedure Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
  end;

implementation

uses
  Protocol, LPTPort, DateUtils, TimelineFile;

{ Private declarations }

{ Protected declarations }

class function TLPTControllerListEventsRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerListEventsRequestHandler.GetCommand: Byte;
begin
  Result := CMD_LIST_EVENTS;
end;

function TLPTControllerListEventsRequestHandler.GetTimelineControler: TTimelineControler;
begin
  Result := FTimelineControler;
end;

procedure TLPTControllerListEventsRequestHandler.SetTimelineControler(Value: TTimelineControler);
begin
  FTimelineControler := Value;
end;

{ Public declarations }

procedure TLPTControllerListEventsRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
var
  I: Integer;
  Event: TEventData;
  Response: TEventRec;
begin
  Log.Debug('Processing command CMD_LIST_EVENTS');

  try
    Assert(Assigned(FTimelineControler), 'Error: no TimelineControler object assigned');

    for I := 0 to FTimelineControler.TimelineData.EventDatas.Count - 1 do
    begin
      Event := FTimelineControler.TimelineData.EventDatas[I];
      Response.Header.Command := CMD_EVENT;
      Response.Header.DataSize := SizeOf(Response) - SizeOf(Response.Header);
      StrPCopy(@Response.Timestamp, FormatDateTime('YYYY-MM-DD HH:NN:SS', Event.Timestamp));
      Response.Bit := Event.Bit;
      if Event.Value then
        Response.Value := bsOn
      else
        Response.Value := bsOff;
      send(Socket, Response, SizeOf(Response), 0);
    end;

    PStatusRec(Buffer).Header.Command := CMD_OK;
    PStatusRec(Buffer).Header.DataSize := 0;
  except
    PStatusRec(Buffer).Header.Command := CMD_ERROR;
    PStatusRec(Buffer).Header.DataSize := 0;
  end;

  send(Socket, Buffer^, SizeOf(TStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerListEventsRequestHandler.Create);

end.

