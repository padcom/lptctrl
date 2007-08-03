program LPTCtrlGUI;

uses
  SysUtils,
  Forms,
  Log4D,
  LPTPort in '..\Common\LPTPort.pas',
  LPTControlerClient in '..\Common\LPTControlerClient.pas',
  Protocol in '..\Common\Protocol.pas',
  FormMain in 'FormMain.pas' {FrmMain},
  LPTClient in 'LPTClient.pas',
  FormOutputControler in 'FormOutputControler.pas' {FrmOutputControler},
  FormEventEditor in 'FormEventEditor.pas' {FrmEventEditor};

{$R *.res}

begin
  TLogPropertyConfigurator.Configure(ChangeFileExt(GetModuleName(HInstance), '.log4d'));

  Application.Initialize;
  Application.Title := 'LPT Remote Controller';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
