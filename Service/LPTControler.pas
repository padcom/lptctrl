unit LPTControler;

interface

uses
  Windows, Winsock, Classes, SysUtils, Log4D, Protocol;

type
  TLPTControler = class;

  TLPTControlerConnection = class (TThread)
  private
    FControler: TLPTControler;
    FSocket: TSocket;
    FAddress: TSockAddrIn;
  protected
    class function Log: TLogLogger;
    procedure ProcessRequests(Buffer: Pointer; BufferSize: Integer);
    procedure Execute; override;
    property Controler: TLPTControler read FControler;
  public
    constructor Create(AControler: TLPTControler; ASocket: TSocket; AAddress: TSockAddrIn);
    destructor Destroy; override;
    procedure Terminate;
  end;

  TLPTControlerConnectionList = class (TList)
  private
    FAccessCS: TRTLCriticalSection;
    function GetItem(Index: Integer): TLPTControlerConnection;
  protected
    class function Log: TLogLogger;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure DisconnectAllClients;
    property Items[Index: Integer]: TLPTControlerConnection read GetItem; default;
  end;

  TLPTControler = class (TThread)
  private
    FPortCS: TRTLCriticalSection;
    FSocket: TSocket;
    FClients: TLPTControlerConnectionList;
  protected
    class function Log: TLogLogger;
    function CreateAndBindSocket: TSocket; virtual;
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Terminate;
    property Clients: TLPTControlerConnectionList read FClients;
  end;

implementation

uses
  LPTControllerRequestHandler, LPTControllerRequestHandlerBag;

{ TLPTControlerConnection }

{ Private declarations }

{ Protected declarations }

class function TLPTControlerConnection.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

procedure TLPTControlerConnection.ProcessRequests(Buffer: Pointer; BufferSize: Integer);
var
  RequestHandler: ILPTControllerRequestHandler;
begin
  RequestHandler := TLPTControllerRequestHandlerBag.Instance.GetHandlerForCommand(PPacketHeader(Buffer)^.Command);
  Assert(Assigned(RequestHandler), Format('Error: not command handler for command %d', [PPacketHeader(Buffer)^.Command]));
  RequestHandler.Process(FSocket, Buffer, BufferSize);
end;

procedure TLPTControlerConnection.Execute;
var
  Buffer: array[0..1023] of Byte;
  BufferSize: Integer;
begin
  repeat
    BufferSize := recv(FSocket, Buffer, Length(Buffer), 0);
    if (BufferSize >= SizeOf(TPacketHeader)) and (PPacketHeader(@Buffer)^.DataSize + SizeOf(TPacketHeader) = BufferSize) then
      ProcessRequests(@Buffer, BufferSize)
    else
      Terminate;
  until Terminated;
end;

{ Public declarations }

constructor TLPTControlerConnection.Create(AControler: TLPTControler; ASocket: TSocket; AAddress: TSockAddrIn);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FControler := AControler;
  FSocket := ASocket;
  FAddress := AAddress;
  if Assigned(Controler) then
  begin
    Controler.Clients.BeginUpdate;
    try
      Controler.Clients.Add(Self);
    finally
      Controler.Clients.EndUpdate;
    end;
  end;
  Log.Debug('%s instance created', [ClassName]);
  Resume;
end;

destructor TLPTControlerConnection.Destroy;
begin
  if Assigned(Controler) then
  begin
    Controler.Clients.BeginUpdate;
    try
      Controler.Clients.Remove(Self);
    finally
      Controler.Clients.EndUpdate;
    end;
  end;
  Log.Debug('%s instance disposed', [ClassName]);
  inherited Destroy;
end;

procedure TLPTControlerConnection.Terminate;
begin
  inherited Terminate;
  closesocket(FSocket);
end;

{ TLPTControlerConnectionList }

{ Private declarations }

function TLPTControlerConnectionList.GetItem(Index: Integer): TLPTControlerConnection;
begin
  Result := TObject(Get(Index)) as TLPTControlerConnection;
end;

{ Protected declarations }

class function TLPTControlerConnectionList.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

{ Public declarations }

constructor TLPTControlerConnectionList.Create;
begin
  inherited Create;
  InitializeCriticalSection(FAccessCS);
  Log.Debug('%s instance created', [ClassName]);
end;

destructor TLPTControlerConnectionList.Destroy;
begin
  Log.Debug('%s instance disposed', [ClassName]);
  DeleteCriticalSection(FAccessCS);
end;

procedure TLPTControlerConnectionList.BeginUpdate;
begin
  EnterCriticalSection(FAccessCS);
end;

procedure TLPTControlerConnectionList.EndUpdate;
begin
  LeaveCriticalSection(FAccessCS);
end;

procedure TLPTControlerConnectionList.DisconnectAllClients;
begin
  while Count > 0 do
  begin
    Items[0].FreeOnTerminate := False;
    Items[0].Terminate;
    Items[0].WaitFor;
    Items[0].Free;
  end;
  Clear;
end;

{ TLPTControler }

{ Private declarations }

{ Protected declarations }

class function TLPTControler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

function TLPTControler.CreateAndBindSocket: TSocket;
var
  Addr: TSockAddrIn;
begin
  Result := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  Assert(Result <> INVALID_SOCKET, 'Error: cannot create socket');
  Addr.sin_family := AF_INET;
  Addr.sin_port := htons(SERVER_PORT);
  Addr.sin_addr.S_addr := INADDR_ANY;
  Assert(bind(Result, Addr, SizeOf(Addr)) = 0, 'Error: cannot bind socket (another instance already running?)');
  Assert(listen(Result, 5) = 0, 'Error: cannot start listening on socket');
end;

procedure TLPTControler.Execute;
var
  ClientSocket: TSocket;
  ClientAddress: TSockAddrIn;
  ClientAddressSize: Integer;
begin
  repeat
    FillChar(ClientAddress, SizeOf(ClientAddress), 0);
    ClientAddressSize := SizeOf(ClientAddress);
    ClientSocket := accept(FSocket, @ClientAddress, @ClientAddressSize);
    if ClientSocket <> INVALID_SOCKET then
    begin
      Log.Debug('Client %s connected', [inet_ntoa(ClientAddress.sin_addr)]);
      TLPTControlerConnection.Create(Self, ClientSocket, ClientAddress);
    end
    else
      Terminate;
  until Terminated;
end;

{ Public declarations }

constructor TLPTControler.Create;
begin
  inherited Create(True);
  FreeOnTerminate := False;
  InitializeCriticalSection(FPortCS);
  FClients := TLPTControlerConnectionList.Create;
  FSocket := CreateAndBindSocket;
  Log.Debug('%s instance created', [ClassName]);
  Resume;
end;

destructor TLPTControler.Destroy;
begin
  FClients.DisconnectAllClients;
  FreeAndNil(FClients);
  DeleteCriticalSection(FPortCS);
  Log.Debug('%s instance disposed', [ClassName]);
  inherited Destroy;
end;

procedure TLPTControler.Terminate;
begin
  inherited Terminate;
  closesocket(FSocket);
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

