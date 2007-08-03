unit Protocol;

interface

uses
  LPTPort;

const
  SERVER_PORT = 8888;

const
  CMD_PING            = 1;
  CMD_PONG            = 2;
  CMD_GET_PORT_STATUS = 3;
  CMD_SET_PORT_STATUS = 4;
  CMD_PORT_STATUS     = 5;
  CMD_GET_BIT_STATUS  = 6;
  CMD_SET_BIT_STATUS  = 7;
  CMD_BIT_STATUS      = 8;
  CMD_SET_TIMELINE    = 9;
  CMD_GET_TIMELINE    = 10;
  CMD_ADD_EVENT       = 11;
  CMD_REMOVE_EVENT    = 12;
  CMD_OK              = 13;
  CMD_ERROR           = 14;
  CMD_LIST_EVENTS     = 15;
  CMD_EVENT           = 16; 

type
  PPacketHeader = ^TPacketHeader;
  TPacketHeader = packed record
    Command : Byte;
    DataSize: Word;
  end;

  PGetPortStatusRec = ^TGetPortStatusRec;
  TGetPortStatusRec = packed record
    Header: TPacketHeader;
  end;

  PSetPortStatusRec = ^TSetPortStatusRec;
  TSetPortStatusRec = packed record
    Header: TPacketHeader;
    Value : Byte;
  end;

  PPortStatusRec = ^TPortStatusRec;
  TPortStatusRec = packed record
    Header: TPacketHeader;
    Value : Byte;
  end;

  PGetBitStatusRec = ^TGetBitStatusRec;
  TGetBitStatusRec = packed record
    Header: TPacketHeader;
    Bit   : Byte;
  end;

  PSetBitStatusRec = ^TSetBitStatusRec;
  TSetBitStatusRec = packed record
    Header: TPacketHeader;
    Bit   : TBit;
    Value : TBitStatus;
  end;

  PBitStatusRec = ^TBitStatusRec;
  TBitStatusRec = packed record
    Header: TPacketHeader;
    Bit   : TBit;
    Value : TBitStatus;
  end;

  PTimelineRec = ^TTimelineRec;
  TTimelineRec = packed record
    Header: TPacketHeader;
    Timeline: array[0..65535] of Byte;
  end;

  PAddEventRec = ^TAddEventRec;
  TAddEventRec = packed record
    Header: TPacketHeader;
    Timestamp: array[0..18] of Char; // YYYY-MM-DD HH:NN:SS
    Bit: TBit;
    Value: TBitStatus;
  end;

  PRemoveEventRec = ^TRemoveEventRec;
  TRemoveEventRec = packed record
    Header: TPacketHeader;
    Timestamp: array[0..18] of Char; // YYYY-MM-DD HH:NN:SS
    Bit: TBit;
  end;

  PStatusRec = ^TStatusRec;
  TStatusRec = packed record
    Header: TPacketHeader;
  end;

  PListEventsRec = ^TListEventsRec;
  TListEventsRec = packed record
    Header: TPacketHeader;
  end;

  PEventRec = ^TEventRec;
  TEventRec = packed record
    Header: TPacketHeader;
    Timestamp: array[0..18] of Char; // YYYY-MM-DD HH:NN:SS
    Bit: TBit;
    Value: TBitStatus;
  end;

implementation

end.

