program LPTCtrlSvc;

uses
  SysUtils,
  Forms,
  Log4D,
  Debug,
  inpout32,
  FormMain in 'FormMain.pas' {FrmMain},
  LPTPort in '..\Common\LPTPort.pas',
  LPTControler in 'LPTControler.pas',
  GUIUpdater in 'GUIUpdater.pas',
  Protocol in '..\Common\Protocol.pas',
  TimelineFile in 'TimelineFile.pas',
  TimelineControler in 'TimelineControler.pas',
  LPTControlerClient in '..\Common\LPTControlerClient.pas',
  LPTControllerRequestHandler in 'RequestHandlers\LPTControllerRequestHandler.pas',
  ObjectWithTimelineControler in 'RequestHandlers\ObjectWithTimelineControler.pas',
  LPTControllerRequestHandlerBag in 'RequestHandlers\LPTControllerRequestHandlerBag.pas',
  LPTControllerPingRequestHandler in 'RequestHandlers\LPTControllerPingRequestHandler.pas',
  LPTControllerGetPortStatusRequestHandler in 'RequestHandlers\LPTControllerGetPortStatusRequestHandler.pas',
  LPTControllerSetPortStatusRequestHandler in 'RequestHandlers\LPTControllerSetPortStatusRequestHandler.pas',
  LPTControllerGetBitStatusRequestHandler in 'RequestHandlers\LPTControllerGetBitStatusRequestHandler.pas',
  LPTControllerSetBitStatusRequestHandler in 'RequestHandlers\LPTControllerSetBitStatusRequestHandler.pas',
  LPTControllerAddEventRequestHandler in 'RequestHandlers\LPTControllerAddEventRequestHandler.pas',
  LPTControllerRemoveEventRequestHandler in 'RequestHandlers\LPTControllerRemoveEventRequestHandler.pas',
  LPTControllerListEventsRequestHandler in 'RequestHandlers\LPTControllerListEventsRequestHandler.pas';

{$R *.res}

var
  LPTControlerInstance: TLPTControler;

begin
  TPort.Initialize;
  TLogPropertyConfigurator.Configure(ChangeFileExt(GetModuleName(HInstance), '.log4d'));

  LPTControlerInstance := TLPTControler.Create;
  try
    Application.Initialize;
    Application.Title := 'LPTController Service';
    Application.CreateForm(TFrmMain, FrmMain);
    Application.Run;
  finally
    LPTControlerInstance.Terminate;
    LPTControlerInstance.WaitFor;
    LPTControlerInstance.Free;
  end;
end.
