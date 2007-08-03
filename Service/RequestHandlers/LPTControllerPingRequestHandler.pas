unit LPTControllerPingRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

type
  TLPTControllerPingRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler)
  protected
    class function Log: TLogLogger;
    function GetCommand: Byte;
  public
    procedure Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
  end;

implementation

uses
  Protocol;

{ Protected declarations }

class function TLPTControllerPingRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerPingRequestHandler.GetCommand: Byte;
begin
  Result := CMD_PING;
end;

{ Public declarations }

procedure TLPTControllerPingRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
begin
  Log.Debug('Processing command CMD_PING');
  PPacketHeader(Buffer)^.Command := CMD_PONG;
  send(Socket, Buffer^, SizeOf(TPacketHeader), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerPingRequestHandler.Create);

end.

