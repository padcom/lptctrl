unit Debug;

interface

uses
  Classes, SysUtils, Log4D, JclDebug, JclHookExcept;

implementation

procedure ExceptionLogger(ExceptObj: TObject; ExceptAddr: Pointer; OSException: Boolean);
begin
  TLogLogger.GetLogger('EXCEPTION').Error(Exception(ExceptObj).Message);
end;

initialization
  JclAddExceptNotifier(ExceptionLogger);
  JclHookExceptions;

end.
