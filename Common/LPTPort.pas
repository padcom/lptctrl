unit LPTPort;

interface

type
  TBit = 0..7;
  TBitStatus = (bsUnspecified, bsOn, bsOff);

type
  TLPTPort = class (TObject)
    class function GetStatus: Byte;
    class procedure SetStatus(Value: Byte);
    class function GetBitStatus(Bit: TBit): TBitStatus;
    class procedure SetBitStatus(Bit: TBit; Value: TBitStatus);
  end;

implementation

uses
  inpout32;   

class function TLPTPort.GetStatus: Byte;
begin
  Result := TPort.Read($378);
end;

class procedure TLPTPort.SetStatus(Value: Byte);
begin
  TPort.Write($378, Value);
end;

class function TLPTPort.GetBitStatus(Bit: TBit): TBitStatus;
begin
  if (GetStatus shr Bit) <> 0 then
    Result := bsOn
  else
    Result := bsOff;
end;

class procedure TLPTPort.SetBitStatus(Bit: TBit; Value: TBitStatus);
var
  Status: Byte;
begin
  Status := GetStatus;
  case Value of
    bsUnspecified:
      Exit;
    bsOn:
      Status := Status or (1 shl Bit);
    bsOff:
      Status := Status and (not (1 shl Bit));
  end;
  SetStatus(Status);
end;

end.
