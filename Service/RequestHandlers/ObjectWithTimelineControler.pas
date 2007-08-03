unit ObjectWithTimelineControler;

interface

uses
  TimelineControler;

type
  IObjectWithTimelineControler = interface
    ['{6BF3CA90-8D01-4147-B335-7C07C98E28DA}']
    function GetTimelineControler: TTimelineControler;
    procedure SetTimelineControler(Value: TTimelineControler);
    property TimelineControler: TTimelineControler read GetTimelineControler write SetTimelineControler;
  end;

implementation

end.
