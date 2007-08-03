unit LPTControllerSetBitStatusRequestHandler;

interface

uses
  Winsock, Classes, SysUtils, Log4D,
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

type
  TLPTControllerSetBitStatusRequestHandler = class (TInterfacedObject, ILPTControllerRequestHandler)
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

class function TLPTControllerSetBitStatusRequestHandler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControllerSetBitStatusRequestHandler.GetCommand: Byte;
begin
  Result := CMD_SET_BIT_STATUS;
end;

{ Public declarations }

procedure TLPTControllerSetBitStatusRequestHandler.Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
begin
  Log.Debug('Processing command CMD_SET_BIT_STATUS; Value: %d', [Byte(PSetBitStatusRec(Buffer)^.Value)]);
  TLPTPort.SetBitStatus(PSetBitStatusRec(Buffer)^.Bit, PSetBitStatusRec(Buffer)^.Value);
  PBitStatusRec(Buffer)^.Header.Command := CMD_BIT_STATUS;
  PBitStatusRec(Buffer)^.Header.DataSize := 1;
  PBitStatusRec(Buffer)^.Value := TLPTPort.GetBitStatus(PBitStatusRec(Buffer)^.Bit);
  send(Socket, Buffer^, SizeOf(TBitStatusRec), 0);
end;

initialization
  TLPTControllerRequestHandlerBag.Instance.RegisterRequestHandler(TLPTControllerSetBitStatusRequestHandler.Create);

end.

