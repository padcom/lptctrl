unit LPTControllerRequestHandler;

interface

uses
  Winsock;

type
  ILPTControllerRequestHandler = interface
    ['{786707F5-6F3B-4751-864C-4D9A8B435325}']
    function GetCommand: Byte;
    procedure Process(Socket: TSocket; Buffer: Pointer; BufferSize: Integer);
    property Command: Byte read GetCommand;
  end;

implementation

end.
