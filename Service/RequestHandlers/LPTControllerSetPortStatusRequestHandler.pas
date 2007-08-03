unit LPTControllerSetPortStatusRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

type
  TLPTControllerSetPortStatusRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler)
  protected
    class function Log: TLogLogger;
    function GetCommand: Byte;
  public
    procedure Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
  end;

implementation

uses
  Protocol, LPTPort;

{ Protected declarations }

class function TLPTControllerSetPortStatusRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerSetPortStatusRequestHandler.GetCommand: Byte;
begin
  Result := CMD_SET_PORT_STATUS;
end;

{ Public declarations }

procedure TLPTControllerSetPortStatusRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
begin
  Log.Debug('Processing command CMD_SET_PORT_STATUS; Value: %d', [PSetPortStatusRec(Buffer)^.Value]);
  TLPTPort.SetStatus(PSetPortStatusRec(Buffer)^.Value);
  PPortStatusRec(Buffer)^.Header.Command := CMD_PORT_STATUS;
  PPortStatusRec(Buffer)^.Header.DataSize := 1;
  PPortStatusRec(Buffer)^.Value := TLPTPort.GetStatus;
  Log.Debug('NewValue: %d', [PPortStatusRec(Buffer)^.Value]);
  send(Socket, Buffer^, SizeOf(TPortStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerSetPortStatusRequestHandler.Create);

end.
