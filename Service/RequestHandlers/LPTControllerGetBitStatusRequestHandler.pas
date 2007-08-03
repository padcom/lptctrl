unit LPTControllerGetBitStatusRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

type
  TLPTControllerGetBitStatusRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler)
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

class function TLPTControllerGetBitStatusRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerGetBitStatusRequestHandler.GetCommand: Byte;
begin
  Result := CMD_GET_BIT_STATUS;
end;

{ Public declarations }

procedure TLPTControllerGetBitStatusRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
begin
  Log.Debug('Processing command CMD_GET_BIT_STATUS');
  PBitStatusRec(Buffer)^.Header.Command := CMD_BIT_STATUS;
  PBitStatusRec(Buffer)^.Header.DataSize := 1;
  PBitStatusRec(Buffer)^.Value := TLPTPort.GetBitStatus(PBitStatusRec(Buffer)^.Bit);
  Log.Debug('NewValue: %d', [Byte(PBitStatusRec(Buffer)^.Value)]);
  send(Socket, Buffer^, SizeOf(TBitStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerGetBitStatusRequestHandler.Create);

end.

