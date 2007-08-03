unit LPTControllerRemoveEventRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag,
  TimelineControler, ObjectWithTimelineControler;

type
  TLPTControllerRemoveEventRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler, IObjectWithTimelineControler)
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
  Protocol, LPTPort, DateUtils;

{ Private declarations }

{ Protected declarations }

class function TLPTControllerRemoveEventRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerRemoveEventRequestHandler.GetCommand: Byte;
begin
  Result := CMD_REMOVE_EVENT;
end;

function TLPTControllerRemoveEventRequestHandler.GetTimelineControler: TTimelineControler;
begin
  Result := FTimelineControler;
end;

procedure TLPTControllerRemoveEventRequestHandler.SetTimelineControler(Value: TTimelineControler);
begin
  FTimelineControler := Value;
end;

{ Public declarations }

procedure TLPTControllerRemoveEventRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
var
  EventTimestamp: TDateTime;
begin
  Log.Debug('Processing command CMD_REMOVE_EVENT');

  try
    Assert(Assigned(FTimelineControler), 'Error: no TimelineControler object assigned');
    
    with PRemoveEventRec(Buffer)^ do
    begin
      //  YYYY-MM-DD HH-NN-SS
      //  0123456789012345678
      //            111111111
      EventTimestamp := EncodeDateTime(
        StrToInt(Copy(Timestamp, 1, 4)),
        StrToInt(Copy(Timestamp, 6, 2)),
        StrToInt(Copy(Timestamp, 9, 2)),
        StrToInt(Copy(Timestamp, 12, 2)),
        StrToInt(Copy(Timestamp, 15, 2)),
        StrToInt(Copy(Timestamp, 18, 2)),
        0);
      FTimelineControler.RemoveEvent(EventTimestamp, Bit);

      PStatusRec(Buffer).Header.Command := CMD_OK;
      PStatusRec(Buffer).Header.DataSize := 0;
    end;
  except
    PStatusRec(Buffer).Header.Command := CMD_ERROR;
    PStatusRec(Buffer).Header.DataSize := 0;
  end;

  send(Socket, Buffer^, SizeOf(TStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerRemoveEventRequestHandler.Create);

end.

