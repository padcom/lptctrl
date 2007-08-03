unit LPTClient;

interface

uses
  Windows, LPTControlerClient;

function Client: TLPTControlerClient;

implementation

uses SysUtils;

var
  _Instance: TLPTControlerClient;

function Client: TLPTControlerClient;
begin
  Result := _Instance;
end;

initialization
  try
    _Instance := TLPTControlerClient.Create(True);
  except
    on E: Exception do
    begin
      MessageBox(0, PChar(E.Message), 'Error', MB_ICONERROR or MB_OK);
      Halt(0);
    end;
  end;

finalization
  FreeAndNil(_Instance);

end.
