unit GUIUpdater;

interface

uses
  Windows, Winsock, Classes, SysUtils, ExtCtrls,
  LPTControlerClient;

type
  TUpdateGUIEvent = procedure (Sender: TObject; Value: Byte) of object;

  TGUIUpdater = class (TObject)
  private
    FClient: TLPTControlerClient;
    FTimer: TTimer;
    FOnUpdateGUI: TUpdateGUIEvent;
  protected
    procedure DoOnUpdateGUI(Sender: TObject);
    property Client: TLPTControlerClient read FClient;
  public
    constructor Create;
    destructor Destroy; override;
    property OnUpdateGUI: TUpdateGUIEvent read FOnUpdateGUI write FOnUpdateGUI;
  end;

implementation

{ TGUIUpdater }

{ Protected declarations }
procedure TGUIUpdater.DoOnUpdateGUI(Sender: TObject);
begin
  if Assigned(FOnUpdateGUI) then
    FOnUpdateGUI(Self, Client.GetPortStatus);
end;

{ Public declarations }

constructor TGUIUpdater.Create;
begin
  inherited Create;
  FClient := TLPTControlerClient.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 500;
  FTimer.OnTimer := DoOnUpdateGUI;
  FTimer.Enabled := True;
end;

destructor TGUIUpdater.Destroy;
begin
  FTimer.Enabled := False;
  FreeAndNil(FTimer);
  FreeAndNil(FClient);
  inherited Destroy;
end;

end.
