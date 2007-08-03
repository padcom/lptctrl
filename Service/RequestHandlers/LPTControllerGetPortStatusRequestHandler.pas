unit LPTControllerGetPortStatusRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

type
  TLPTControllerGetPortStatusRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler)
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

class function TLPTControllerGetPortStatusRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerGetPortStatusRequestHandler.GetCommand: Byte;
begin
  Result := CMD_GET_PORT_STATUS;
end;

{ Public declarations }

procedure TLPTControllerGetPortStatusRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
begin
  Log.Debug('Processing command CMD_GET_PORT_STATUS');
  PPortStatusRec(Buffer)^.Header.Command := CMD_PORT_STATUS;
  PPortStatusRec(Buffer)^.Header.DataSize := 1;
  PPortStatusRec(Buffer)^.Value := TLPTPort.GetStatus;
  Log.Debug('Value: %d', [PPortStatusRec(Buffer)^.Value]);
  send(Socket, Buffer^, SizeOf(TPortStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerGetPortStatusRequestHandler.Create);

end.

