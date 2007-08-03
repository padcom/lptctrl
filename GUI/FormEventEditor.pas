unit FormEventEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, LPTPort;

type
  TFrmEventEditor = class(TForm)
    EdtDate: TDateTimePicker;
    CbxState: TComboBox;
    LblDate: TLabel;
    LblTime: TLabel;
    LblState: TLabel;
    BtnOk: TButton;
    BtnCancel: TButton;
    EdtTime: TDateTimePicker;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    function GetState: TBitStatus;
    procedure SetState(State: TBitStatus);
    function GetTimestamp: TDateTime;
    procedure SetTimestamp(Value: TDateTime);
  public
    { Public declarations }
    property State: TBitStatus read GetState write SetState;
    property Timestamp: TDateTime read GetTimestamp write SetTimestamp;
  end;

implementation

{$R *.dfm}

function TFrmEventEditor.GetState: TBitStatus;
begin
  case CbxState.ItemIndex of
    0: Result := bsOn;
    1: Result := bsOff;
    else
      Result := bsUnspecified;
  end;
end;

procedure TFrmEventEditor.SetState(State: TBitStatus);
begin
  case State of
    bsUnspecified:
      CbxState.ItemIndex := -1;
    bsOn:
      CbxState.ItemIndex := 0;
    bsOff:
      CbxState.ItemIndex := 1;
  end;
end;

function TFrmEventEditor.GetTimestamp: TDateTime;
begin
  Result := Trunc(EdtDate.Date) + Frac(EdtTime.Time);
end;

procedure TFrmEventEditor.SetTimestamp(Value: TDateTime);
begin
  EdtDate.Date := Trunc(Value);
  EdtTime.Time := Frac(Value);
end;

procedure TFrmEventEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (ModalResult = mrOk) and (State = bsUnspecified) then
  begin
    MessageBox(Handle, 'Please select output state', 'Error', MB_ICONERROR or MB_OK);
    CanClose := False;
  end;
end;

end.
