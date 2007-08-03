unit TimelineControler;

interface

uses
  Windows, Winsock, Classes, SysUtils, Log4D, ExtCtrls,
  LPTPort, LPTControlerClient, TimelineFile;

type
  TTimelineControler = class (TObject)
  private
    FClient: TLPTControlerClient;
    FTimer: TTimer;
    FTimelineData: TTimelineFile;
    FTimelineFileName: String;
  protected
    class function Log: TLogLogger;
    procedure RemoveOldEvents;
    procedure LoadTimeline;
    procedure SaveTimeline;
    procedure CheckStatuses(Sender: TObject);
    property Client: TLPTControlerClient read FClient;
    property TimelineFileName: String read FTimelineFileName;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddEvent(Timestamp: TDateTime; Bit: TBit; Status: TbitStatus);
    procedure RemoveEvent(Timestamp: TDateTime; Bit: TBit); overload;
    procedure RemoveEvent(var Event: TEventData); overload;
    property TimelineData: TTimelineFile read FTimelineData;
  end;

implementation

uses
  DateUtils, Math;

{ TTimelineControler }

{ Private declarations }

{ Protected declarations }

class function TTimelineControler.Log: TLogLogger;
begin
  Result := TLogLogger.GetLogger(Self);
end;

procedure TTimelineControler.RemoveOldEvents;
var
  I: Integer;
  Event: TEventData;
begin
  I := 0;
  while I < TimelineData.EventDatas.Count do
  begin
    Event := TimelineData.EventDatas[I];
    if Event.Timestamp < Now then
      RemoveEvent(Event.Timestamp, Event.Bit)
    else
      Inc(I);
  end;
end;

procedure TTimelineControler.LoadTimeline;
begin
  if FileExists(TimelineFileName) then
  begin
    TimelineData.Load(TimelineFileName);
    RemoveOldEvents;
  end;
end;

procedure TTimelineControler.SaveTimeline;
begin
  TimelineData.Save(TimelineFileName);
end;

procedure TTimelineControler.CheckStatuses(Sender: TObject);
  function EventShouldFire(Event: TEventData; CurrentTimestamp: TDateTime): Boolean;
  begin
    Result := Abs(Event.Timestamp - CurrentTimestamp) < EncodeTime(0, 0, 0, FTimer.Interval);
  end;
var
  CurrentTimestamp: TDateTime;
  I: Integer;
  OrgPortStatus, PortStatus: Byte;
  DoUpdate: Boolean;
  Event: TEventData;
begin
  CurrentTimestamp := Now;
  PortStatus := Client.GetPortStatus;
  OrgPortStatus := PortStatus;
  DoUpdate := False;

  for I := 0 to FTimelineData.EventDatas.Count - 1 do
  begin
    Event := FTimelineData.EventDatas[I];
    if EventShouldFire(Event, CurrentTimestamp) then
    begin
      DoUpdate := True;
      if Event.Value then
        PortStatus := PortStatus or (1 shl Event.Bit)
      else
        PortStatus := PortStatus and (not (1 shl Event.Bit));
    end;
  end;

  if DoUpdate and (PortStatus <> OrgPortStatus) then
    Client.SetPortStatus(PortStatus);

  RemoveOldEvents;
end;

{ Public declarations }

constructor TTimelineControler.Create;
begin
  inherited Create;
  FClient := TLPTControlerClient.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 500;
  FTimer.OnTimer := CheckStatuses;
  FTimer.Enabled := True;
  FTimelineData := TTimelineFile.Create;
  FTimelineFileName := ChangeFileExt(GetModuleName(HInstance), '.dat');
  LoadTimeline;
end;

destructor TTimelineControler.Destroy;
begin
  SaveTimeline;
  FTimer.Enabled := False;
  FreeAndNil(FTimer);
  FreeAndNil(FTimelineData);
  FreeAndNil(FClient);
  inherited Destroy;
end;

procedure TTimelineControler.AddEvent(Timestamp: TDateTime; Bit: TBit; Status: TbitStatus);
var
  Event: TEventData;
begin
  Log.Debug('Adding event on %s on bit %d with status %d', [
    FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp),
    Bit,
    Byte(Status)
  ]);

  if Status = bsUnspecified then
    Exit;

  Event := FTimelineData.AddEventData;
  Event.Timestamp := Timestamp;
  Event.Bit := Bit;
  Event.Value := Status = bsOn;
end;

procedure TTimelineControler.RemoveEvent(Timestamp: TDateTime; Bit: TBit);
var
  I: Integer;
  Event: TEventData;
begin
  Log.Debug('Removing event on %s on bit %d', [
    FormatDateTime('YYYY-MM-DD HH:NN:SS', Timestamp),
    Bit
  ]);

  Event := nil;
  for I := 0 to TimelineData.EventDatas.Count - 1 do
  begin
    Event := TimelineData.EventDatas[I];
    if (SecondsBetween(Event.Timestamp, Timestamp) = 0) and (Event.Bit = Bit) then
      Break
    else
      Event := nil;
  end;

  if Assigned(Event) then
    RemoveEvent(Event);
end;

procedure TTimelineControler.RemoveEvent(var Event: TEventData);
begin
  Log.Debug('Removing event on %s on bit %d', [
    FormatDateTime('YYYY-MM-DD HH:NN:SS', Event.Timestamp),
    Event.Bit
  ]);

  TimelineData.DelRecord(Event);
  Event.Free;
  Event := nil;
end;

end.

