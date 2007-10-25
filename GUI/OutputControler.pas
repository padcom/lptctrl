unit OutputControler;

interface

uses
  Classes, SysUtils,
  FormOutputControler;

type
  TOutputControler = class (TObject)
  private
    FControlers: array[0..7] of TFrmOutputControler;
    function GetControler(Index: Integer): TFrmOutputControler;
    procedure SetControler(Index: Integer; Value: TFrmOutputControler);
  protected
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TOutputControler;
    class procedure Initialize;
    class procedure Finalize;
    property Controlers[Index: Integer]: TFrmOutputControler read GetControler write SetControler; default;
  end;

implementation

{ TOutputControler }

{ Private declarations }

function TOutputControler.GetControler(Index: Integer): TFrmOutputControler;
begin
  if not (Index in [0..7]) then
    raise Exception.CreateFmt('%d - index out of range', [Index]);
  if not Assigned(FControlers[Index]) then
    FControlers[Index] := TFrmOutputControler.Create(nil);
  Result := FControlers[Index];
  Result.BIT := Index;
end;

procedure TOutputControler.SetControler(Index: Integer; Value: TFrmOutputControler);
begin
  Assert(Value = nil, 'Error: can only set nil as value to dispose of a controler');
  if not (Index in [0..7]) then
    raise Exception.CreateFmt('%d - index out of range', [Index]);
  if Assigned(FControlers[Index]) then
    FControlers[Index] := nil;
end;

{ Protected declarations }

{ Public declarations }

var
  _Instance: TOutputControler = nil;

class function TOutputControler.Instance: TOutputControler;
begin
  Assert(Assigned(_Instance), 'Error: Instance not initialized');
  Result := _Instance;
end;

class procedure TOutputControler.Initialize;
begin
  _Instance := TOutputControler.Create;
end;

class procedure TOutputControler.Finalize;
begin
  FreeAndNil(_Instance);
end;

constructor TOutputControler.Create;
begin
  Assert(not Assigned(_Instance), 'Error: this is a singleton and should be accessed using Instance method');
  inherited Create;
end;

destructor TOutputControler.Destroy;
begin
  inherited Destroy;
end;

initialization
  TOutputControler.Initialize;

finalization
  TOutputControler.Finalize;

end.

