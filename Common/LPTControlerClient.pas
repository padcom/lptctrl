unit LPTControlerClient;

interface

uses
  Windows, Winsock, Classes, SysUtils, Log4D, IniFiles, Dialogs,
  LPTPort, Protocol;

type
  TEvent = record
    Timestamp: TDateTime;
    Bit: TBit;
    Status: TBitStatus;
  end;

  TEventList = array of TEvent;

  TLPTControlerClient = class (TObject)
  private
    FSocket: TSocket;
  protected
    class function Log: TLogLogger;
  public
    constructor Create(AutoConnect: Boolean = True);
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    function GetPortStatus: Byte;
    procedure SetPortStatus(Value: Byte);
    procedure SetBitStatus(Bit: Byte; Status: TBitStatus);
    procedure AddEvent(Timestamp: TDateTime; Bit: TBit; Status: TBitStatus);
    procedure RemoveEvent(Timestamp: TDateTime; Bit: TBit);
    procedure GetEventList(var Events: TEventList);
  end;

implementation

uses
  DateUtils;

{ TLPTControlerClient }

{ Private declarations }

{ Protected declarations }

class function TLPTControlerClient.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

{ Public declarations }

constructor TLPTControlerClient.Create(AutoConnect: Boolean = True);
begin
  inherited Create;
  if AutoConnect then
    Connect;
end;

destructor TLPTControlerClient.Destroy;
begin
  Disconnect;
  inherited Destroy;
end;

procedure TLPTControlerClient.Connect;
var
  Address: TSockAddrIn;
  Host: String;
  HostEnt: PHostEnt;
begin
  FSocket := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  Assert(FSocket <> INVALID_SOCKET, 'Error: cannot create socket');

  with TIniFile.Create(ChangeFileExt(GetModuleName(HInstance), '.ini')) do
    try
      Host := ReadString('connection', 'server', '127.0.0.1');
    finally
      Free;
    end;

  HostEnt := gethostbyname(PChar(Host));
  Assert(Assigned(HostEnt), Format('Error: host %s not found', [Host]));
  Assert(Assigned(HostEnt^.h_addr), Format('Error: host %s not found', [Host]));

  FillChar(Address, SizeOf(Address), 0);
  Address.sin_family := AF_INET;
  Address.sin_port := htons(SERVER_PORT);
  Address.sin_addr.S_addr := PInteger(HostEnt^.h_addr^)^;
  Assert(Winsock.connect(FSocket, Address, SizeOf(Address)) = 0, 'Error: cannot connect to LPT server');
end;

procedure TLPTControlerClient.Disconnect;
begin
  closesocket(FSocket);
  FSocket := INVALID_SOCKET;
end;

function TLPTControlerClient.GetPortStatus: Byte;
var
  Request: TGetPortStatusRec;
  Response: TPortStatusRec;
begin
  Log.Debug('Retrieving port status');

  Assert(FSocket <> INVALID_SOCKET, 'Error: not connected');

  Request.Header.Command := CMD_GET_PORT_STATUS;
  Request.Header.DataSize := 0;
  send(FSocket, Request, SizeOf(Request), 0);
  recv(FSocket, Response, SizeOf(Response), 0);
  Result := Response.Value;
end;

procedure TLPTControlerClient.SetPortStatus(Value: Byte);
var
  Request: TSetPortStatusRec;
  Response: TPortStatusRec;
begin
  Log.Debug(Format('Setting port status to %d', [Value]));

  Assert(FSocket <> INVALID_SOCKET, 'Error: not connected');

  Request.Header.Command := CMD_SET_PORT_STATUS;
  Request.Header.DataSize := 1;
  Request.Value := Value;
  send(FSocket, Request, SizeOf(Request), 0);
  recv(FSocket, Response, SizeOf(Response), 0);
end;

procedure TLPTControlerClient.SetBitStatus(Bit: Byte; Status: TBitStatus);
var
  Request: TSetBitStatusRec;
  Response: TBitStatusRec;
begin
  Log.Debug(Format('Setting bit %d to %d', [Bit, Byte(Status)]));

  Assert(FSocket <> INVALID_SOCKET, 'Error: not connected');

  Request.Header.Command := CMD_SET_BIT_STATUS;
  Request.Header.DataSize := 2;
  Request.Bit := Bit;
  Request.Value := Status;
  send(FSocket, Request, SizeOf(Request), 0);
  recv(FSocket, Response, SizeOf(Response), 0);
end;

procedure TLPTControlerClient.AddEvent(Timestamp: TDateTime; Bit: TBit; Status: TBitStatus);
var
  Data: TAddEventRec;
begin
  Log.Debug(Format('Adding event on %s on bit %d with status %d', [
    FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp),
    Bit,
    Byte(Status)
  ]));

  Assert(FSocket <> INVALID_SOCKET, 'Error: not connected');

  Data.Header.Command := CMD_ADD_EVENT;
  Data.Header.DataSize := SizeOf(Data) - SizeOf(Data.Header);
  StrPCopy(Data.Timestamp, FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp));
  Data.Bit := Bit;
  Data.Value := Status;
  send(FSocket, Data, SizeOf(Data), 0);
  recv(FSocket, Data, SizeOf(Data), 0);
end;

procedure TLPTControlerClient.RemoveEvent(Timestamp: TDateTime; Bit: TBit);
var
  Data: TAddEventRec;
begin
  Log.Debug(Format('Removing event on %s on bit %d', [
    FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp),
    Bit
  ]));

  Assert(FSocket <> INVALID_SOCKET, 'Error: not connected');

  Data.Header.Command := CMD_REMOVE_EVENT;
  Data.Header.DataSize := SizeOf(Data) - SizeOf(Data.Header);
  StrPCopy(Data.Timestamp, FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp));
  Data.Bit := Bit;
  send(FSocket, Data, SizeOf(Data), 0);
  recv(FSocket, Data, SizeOf(Data), 0);
end;

procedure TLPTControlerClient.GetEventList(var Events: TEventList);
var
  Request: TListEventsRec;
  Response: TEventRec;
begin
  Request.Header.Command := CMD_LIST_EVENTS;
  Request.Header.DataSize := SizeOf(Request) - SizeOf(Request.Header);
  send(FSocket, Request, SizeOf(Request), 0);

  repeat
    recv(FSocket, Response, SizeOf(Response), 0);
    if Response.Header.Command = CMD_EVENT then
    begin
      SetLength(Events, Length(Events) + 1);
      Events[Length(Events) - 1].Timestamp := EncodeDateTime(
        StrToInt(Copy(Response.Timestamp, 1, 4)),
        StrToInt(Copy(Response.Timestamp, 6, 2)),
        StrToInt(Copy(Response.Timestamp, 9, 2)),
        StrToInt(Copy(Response.Timestamp, 12, 2)),
        StrToInt(Copy(Response.Timestamp, 15, 2)),
        StrToInt(Copy(Response.Timestamp, 18, 2)),
        0);
      Events[Length(Events) - 1].Bit := Response.Bit;
      Events[Length(Events) - 1].Status := Response.Value;
    end;
  until Response.Header.Command <> CMD_EVENT;
end;

{ *** }

procedure Initialize;
var
  WSAData: TWSAData;
begin
  WSAStartup($101, WSAData);
end;

procedure Finalize;
begin
  WSACleanup;
end;

initialization
  Initialize;

finalization
  Finalize;

end.

