unit LPTControllerRequestHandlerBag;

interface

uses
  Classes, SysUtils, Log4D,
  LPTControllerRequestHandler;

type  
  TLPTControllerRequestHandlerList = class (TInterfaceList)
  private
    function GetItem(Index: Integer): ILPTControllerRequestHandler;
  public
    property Items[Index: Integer]: ILPTControllerRequestHandler read GetItem; default;
  end;

  TLPTControllerRequestHandlerBag = class (TObject)
  private
    FHandlers: TLPTControllerRequestHandlerList;
  protected
    class function Log: TLogLogger;
    property Handlers: TLPTControllerRequestHandlerList read FHandlers;
  public
    class function Instance: TLPTControllerRequestHandlerBag;
    constructor Create;
    destructor Destroy; override;
    function GetHandlerForCommand(Command: Byte): ILPTControllerRequestHandler;
    procedure RegisterRequestHandler(Handler: ILPTControllerRequestHandler);
  end;

implementation

{ TLPTControllerRequestHandlerList }

{ Private declarations }

function TLPTControllerRequestHandlerList.GetItem(Index: Integer): ILPTControllerRequestHandler;
begin
  Result := Get(Index) as ILPTControllerRequestHandler;
end;

{ TLPTControllerRequestHandlerBag }

{ Protected declarations }

class function TLPTControllerRequestHandlerBag.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

{ Public declarations }

var
  _Instance: TLPTControllerRequestHandlerBag = nil;

class function TLPTControllerRequestHandlerBag.Instance: TLPTControllerRequestHandlerBag;
begin
  Result := _Instance;
end;

constructor TLPTControllerRequestHandlerBag.Create;
begin
  inherited Create;
  FHandlers := TLPTControllerRequestHandlerList.Create;
end;

destructor TLPTControllerRequestHandlerBag.Destroy; 
begin
  FreeAndNil(FHandlers);
  inherited Destroy;
end;

function TLPTControllerRequestHandlerBag.GetHandlerForCommand(Command: Byte): ILPTControllerRequestHandler;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Handlers.Count - 1 do
    if Handlers[I].Command = Command then
    begin
      Result := Handlers[I];
      Break;
    end;
end;

procedure TLPTControllerRequestHandlerBag.RegisterRequestHandler(Handler: ILPTControllerRequestHandler);
begin
  Log.Debug('Registering handler for command %d', [Handler.Command]);
  Assert(GetHandlerForCommand(Handler.Command) = nil, Format('Error: handler for command %d is already registered', [Handler.Command]));
  Handlers.Add(Handler);
end;

initialization
  _Instance := TLPTControllerRequestHandlerBag.Create;

finalization
  FreeAndNil(_Instance);

end.

