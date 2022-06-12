{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{            Access to the header and data             }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsClasses;

{$I DeLaFitsCompiler.inc}

interface

uses
  SysUtils, Classes, DeLaFitsCommon, DeLaFitsString, DeLaFitsOrderByte,
  DeLaFitsDataRead, DeLaFitsDataWrite;

const

  { The error codes }

  ERROR_CLASSES = 3000;

  { Error codes for TFits }

  ERROR_STREAM_NOT_ASSIGNED = 3001;
  ERROR_STREAM_LOW_SIZE     = 3002;
  ERROR_STREAM_INVALID      = 3003;
  ERROR_STREAM_READ         = 3004;
  ERROR_STREAM_WRITE        = 3005;
  ERROR_CORE_INVALID        = 3006;
  ERROR_CORE_TWO_INVALID    = 3007;
  ERROR_STREAM_TWO_LOW_SIZE = 3008;

  { Error codes for TLineBuilder }

  ERROR_COMPOSE_UNKNOWN_CAST = 3101;
  ERROR_PARSE_UNKNOWN_CAST   = 3102;

  { Error codes for TFitsHeader }

  // LineInsert
  ERROR_LINEINSERT_INDEX             = 3200;
  ERROR_LINEINSERT_KEYWORD           = 3201;
  ERROR_LINEINSERT_CORE_KEYWORD      = 3202;
  ERROR_LINEINSERT_CORE_BREAK        = 3203;
  ERROR_LINEINSERT_CORE_INDEX        = 3204;
  // LineDelete
  ERROR_LINEDELETE_INDEX             = 3205;
  ERROR_LINEDELETE_COUNT             = 3206;
  ERROR_LINEDELETE_CORE              = 3207;
  // LineExchange
  ERROR_LINEEXCHANGE_INDEX           = 3208;
  ERROR_LINEEXCHANGE_CORE            = 3209;
  // LineMove
  ERROR_LINEMOVE_INDEX               = 3210;
  ERROR_LINEMOVE_CORE                = 3211;
  // LineRead
  ERROR_LINEREAD_INDEX               = 3212;
  ERROR_LINEREAD_COUNT               = 3213;
  // LineWrite
  ERROR_LINEWRITE_INDEX              = 3214;
  ERROR_LINEWRITE_COUNT              = 3215;
  ERROR_LINEWRITE_KEYWORD            = 3216;
  ERROR_LINEWRITE_CORE_KEYWORD       = 3217;
  ERROR_LINEWRITE_CORE_INDEX         = 3218;
  ERROR_LINEWRITE_CORE_BREAK         = 3219;
  // Get/Set LinesKeyword
  ERROR_GETLINESKEYWORD_INDEX        = 3220;
  ERROR_SETLINESKEYWORD_INDEX        = 3221;
  ERROR_SETLINESKEYWORD_CORE_KEYWORD = 3222;
  ERROR_SETLINESKEYWORD_CORE_INDEX   = 3223;

  { Error codes for TFitsFrame }

  ERRROR_DATAACCESS_BITPIX_UNKNOWN = 3300;
  ERRROR_DATAACCESS_REP_UNKNOWN    = 3301;
  ERRROR_DATAACCESS_PROC_NIL       = 3302;
  ERRROR_DATAACCESS_RGN_INVALID    = 3303;
  ERRROR_DATAACCESS_PIXEL_INVALID  = 3304;
  ERRROR_DATAACCESS_DATA_NIL       = 3305;
  ERRROR_DATAACCESS_DATA_COLSCOUNT = 3306;
  ERRROR_DATAACCESS_DATA_ROWSCOUNT = 3307;

  {Error codes for TFitsFileXxx }

  ERROR_FILE_NOT_FOUND = 3400;

  { The error text }

  eStreamNotAssigned = 'The stream is not assigned';
  eStreamInvalid     = 'Invalid format of the stream';
  eStreamInvalidSize = 'Invalid size of the stream';
  eStreamAccess      = 'Error accessing to stream';
  eCoreInvalid       = 'Invalid core';
  eCoreTwoInvalid    = 'Invalid core: should be of two axis';
  eKeywordInavlid    = 'Invalid keyword <%s>';
  eCoreAccess        = 'Access error to the core';
  eCoreAccessBreak   = 'Access error to the core: break keywords';
  eCoreAccessInput   = 'Access error to the core: input keyword <%s>';
  eIndexOfBound      = 'Index %d of bound';
  eUnknownCast       = 'Unknown identifier string parsing (%d)';
  eIndexIncorrect    = 'Incorrect indexes (%d, %d)';
  eInputInvalid      = 'Invalid input parameters';
  eBitPixUnknown     = 'Data access: unknown BitPix';
  eBitPixSupport     = 'Data access: BitPix = %.2d not supported in the current version of the library';
  eDataRepUnknown    = 'Data access: unknown user representation of data';
  eDataRgnInvalid    = 'Data access: the specified region (%d, %d, %d, %d) beyond the region''s borders (%d, %d, %d, %d) data frame';
  eDataPixelInvalid  = 'Data access: the specified pixel (%d, %d), goes beyond the region of the frame data (%d, %d, %d, %d)';
  eDataUnsigned      = 'Data access: pointer to the buffer for data a nil';
  eDataColsCount     = 'Data access: number of columns of the buffer for data %d less specified region %d';
  eDataRowsCount     = 'Data access: number of rows of the buffer for data %d less specified region %d';
  eFileNotFound      = 'File <%s> not found';

type

  { Exception classes }

  EFitsHduCoreException = class(EFitsException);
  EFitsHeaderException = class(EFitsException);
  EFitsLineBuilderException = class(EFitsException);
  EFitsFrameException = class(EFitsException);

  { Basic class }

  // Array of keywords header
  THduKeywords = array of string;

  // Kind keyword of header
  TKindHduKeyword = (keyUnknown, keyEnd, keySimple, keyBitPix, keyNAxis, keyNAxisn, keyBScale, keyBZero,
                     keyVal1, keyDelta1, keyUnit1, keyXunits, keyYunits, keyMinWave, keyMaxWave);
  TKindHduKeywords = set of TKindHduKeyword;

  TFits = class(TObject)
  {$IFDEF DELADATBUFPRIVATE}
  private
    // Private buffer for input/output operation on the stream
    FDataBuffer: TStreamBuffer;
  {$ENDIF}
  protected
    procedure AllocateBuffer(var Buffer: Pointer; SizeInBytes: Integer);
    procedure ReleaseBuffer(var Buffer: Pointer);
  protected
    // Stream of raw data
    FStream: TStream;
    // Array of keywords
    FHduKeywords: THduKeywords;
    // Basic parameters the stream
    FHduCore: THduCore;
    // Initialization of class fields
    procedure Init; virtual;
    // Checking input stream, fields are undefined
    procedure CheckStream(AStream: TStream); virtual;
    // Checking input core, fields are undefined
    procedure CheckCore(const AHduCore: THduCore); virtual;
  protected
    // Methods do not contain checks
    procedure StreamRead(const Offset, Count: Int64; var Buffer: TStreamBuffer);
    procedure StreamWrite(const Offset, Count: Int64; const Buffer: TStreamBuffer);
    // Rewrite content: Shift > 0 - move content down, Shift < 0 - move content up
    procedure StreamShift(const Offset, Count, Shift: Int64);
    procedure StreamFill(const Offset, Count: Int64; Chr: Char);
  private
    procedure MakeFromCore;
    procedure MakeFromStream(var debut : integer);
  public
    constructor Create(const Stub);
    destructor Destroy; override;
    // Load from stream
    constructor CreateJoin(AStream: TStream);
    // Manually create
    constructor CreateMade(AStream: TStream; const AHduCore: THduCore);
  private
    function GetStreamSize: Int64;
    function GetStreamSizeHead: Int64;
    function GetStreamSizeData: Int64;
  public
    // Direct access to the raw stream
    property Stream: TStream read FStream;
    // Veritable size of the stream
    property StreamSize: Int64 read GetStreamSize;
    // Header size (full), computed based on HduKeywords
    property StreamSizeHead: Int64 read GetStreamSizeHead;
    // The theoretical size of the array data, computed based on HduCore
    property StreamSizeData: Int64 read GetStreamSizeData;
  end;

  { Header Fits stream, see below }

  TFitsHeader = class;

  { Variant's field access to lines: access to records lines }

  TLineBuilder = class(TObject)
  private
    // Use methods LineRead & LineWrite
    FFits: TFitsHeader;
    FFmt: TFormatLine;
    procedure Init;
    function GetFmt: PFormatLine;
    function GetItems(Index, Cast: Integer): TLineItem;
    procedure SetItems(Index, Cast: Integer; Value: TLineItem);
    function GetKeywords(Index: Integer): string;
    procedure SetKeywords(Index: Integer; const Value: string);
    function GetNotes(Index: Integer): string;
    procedure SetNotes(Index: Integer; Value: string);
    function GetValuesStr(Index: Integer; Cast: Integer): string;
    procedure SetValuesStr(Index: Integer; Cast: Integer; Value: string);
    function GetValuesBoolean(Index: Integer): Boolean;
    procedure SetValuesBoolean(Index: Integer; const Value: Boolean);
    function GetValuesInteger(Index: Integer): Int64;
    procedure SetValuesInteger(Index: Integer; const Value: Int64);
    function GetValuesFloat(Index: Integer): Extended;
    procedure SetValuesFloat(Index: Integer; const Value: Extended);
    function GetValuesCoord(Index: Integer; Cast: Integer): Extended;
    procedure SetValuesCoord(Index: Integer; Cast: Integer; Value: Extended);
    function GetValuesDateTime(Index: Integer; Cast: Integer): TDateTime;
    procedure SetValuesDateTime(Index: Integer; Cast: Integer; Value: TDateTime);
    function GetCount: Integer;
  public
    constructor Create(AFits: TFitsHeader);
    destructor Destroy; override;
    property Fits: TFitsHeader read FFits;
    property Fmt: PFormatLine read GetFmt;
  public
    function Compose(Item: TLineItem; Cast: Integer): string;
    function Parse(Line: string; Cast: Integer): TLineItem;
  public
    function IndexOf(Keyword: string; StartIndex: Integer = 0): Integer;
    procedure Insert(Index: Integer; const Item: TLineItem; Cast: Integer);
    procedure Delete(Index: Integer; Long: Boolean);
    function Add(const Item: TLineItem; Cast: Integer): Integer;
    procedure Read(Index: Integer; out Item: TLineItem; Cast: Integer);
    procedure Write(Index: Integer; const Item: TLineItem; Cast: Integer);
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Clear;  
  public
    property Count: Integer read GetCount;
    property Items[Index, Cast: Integer]: TLineItem read GetItems write SetItems;
    property Keywords[Index: Integer]: string read GetKeywords write SetKeywords;
    property Notes[Index: Integer]: string read GetNotes write SetNotes;
    property ValuesChars[Index: Integer]: string Index cCastChars read GetValuesStr write SetValuesStr;
    property ValuesCharsLong[Index: Integer]: string Index cCastCharsLong read GetValuesStr write SetValuesStr;
    property ValuesString[Index: Integer]: string Index cCastString read GetValuesStr write SetValuesStr;
    property ValuesBoolean[Index: Integer]: Boolean read GetValuesBoolean write SetValuesBoolean;
    property ValuesInteger[Index: Integer]: Int64 read GetValuesInteger write SetValuesInteger;
    property ValuesFloat[Index: Integer]: Extended read GetValuesFloat write SetValuesFloat;
    property ValuesRa[Index: Integer]: Extended Index cCastRa read GetValuesCoord write SetValuesCoord;
    property ValuesDe[Index: Integer]: Extended Index cCastDe read GetValuesCoord write SetValuesCoord;
    property ValuesDateTime[Index: Integer]: TDateTime Index cCastDateTime read GetValuesDateTime write SetValuesDateTime;
    property ValuesDate[Index: Integer]: TDateTime Index cCastDate read GetValuesDateTime write SetValuesDateTime;
    property ValuesTime[Index: Integer]: TDateTime Index cCastTime read GetValuesDateTime write SetValuesDateTime;
    function ValuesDateTimeAny(Index: Integer; out Slice: TSliceDateTime): TDateTime;
  end;

  TFitsHeader = class(TFits)
  private
    // Number of lines in the header to the keyword 'END' inclusive
    FLineCount: Integer;
    // Total number of lines in the header
    FLineCapacity: Integer;
    // Offset of the data in the stream
    FDataOffset: Int64;
    // Flag checking the validity of transactions with core
    FHduCoreAuditing: Boolean;
    // Parse line - keyword, value, note
    FLineBuilder: TLineBuilder;
  private
    procedure Make;
    function GetHduText: string;
    function GetLines(Index: Integer): string;
    procedure SetLines(Index: Integer; Value: string);
    function GetLinesKeyword(Index: Integer): string;
    procedure SetLinesKeyword(Index: Integer; Value: string);
  protected
    procedure Init; override;
  public
    constructor CreateJoin(AStream: TStream);
    constructor CreateMade(AStream: TStream; const AHduCore: THduCore);
    destructor Destroy; override;
  public
    property DataOffset: Int64 read FDataOffset;
    property HduCore: THduCore read FHduCore;
    property HduCoreAuditing: Boolean read FHduCoreAuditing write FHduCoreAuditing;
    // ~ LineCount
    property HduText: string read GetHduText;
  public
    function LineIndexOf(Keyword: string; StartIndex: Integer = 0): Integer;
    procedure LineInsert(Index, Count: Integer; Line: string);
    function LineAdd(Count: Integer; Line: string): Integer;
    procedure LineDelete(Index, Count: Integer);
    procedure LineRead(Index, Count: Integer; out Line: string);
    procedure LineWrite(Index, Count: Integer; Line: string);
    procedure LineExchange(Index1, Index2: Integer);
    procedure LineMove(CurIndex, NewIndex: Integer);
    procedure LineClear;
    property Lines[Index: Integer]: string read GetLines write SetLines;
    property LinesKeyword[Index: Integer]: string read GetLinesKeyword write SetLinesKeyword;
    property LineCount: Integer read FLineCount;
    property LineCapacity: Integer read FLineCapacity;
    property LineBuilder: TLineBuilder read FLineBuilder;
  end;

  { Header & Data Unit Fits frame, data array 2D only

    Map Data:

    0-----|-----|-----|-----|--- X (NAXIS1, ColsCount)
    | 0;0 | 1;0 | 2;0 | 3;0 |
    |-----|-----|-----|-----|
    | 0;1 | 1;1 | 2;1 | 3;1 |
    |-----|-----|-----|-----|
    | 0;2 | 1;2 | 2;2 | 3;2 |
    |-----|-----|-----|-----|
    |
    Y (NAXIS2, RowsCount)

    Fits Standard, version 3.0, page 14-15. Data[NAXIS1 - 1, NAXIS2 - 1] }

  TFitsFrame = class(TFitsHeader)
  private
    // The representation of the data, the user buffer for data manipulation
    // and determine the data access interface
    FDataRep: TRep;
    FProcRead: TProcDataAccess;
    FProcWrite: TProcDataAccess;
    procedure SetDataRepDefault;
    procedure SetDataRep(Value: TRep);
    function GetDataBitPix: TBitPix;
    procedure CheckIDataAccess(Data: Pointer; const Rgn: TRgn); overload;
    procedure CheckIDataAccess(X, Y: Integer); overload;
    function GetDataHandle(const Rgn: TRgn): TDataHandle;
    function GetDataPixels(X, Y: Integer): Extended;
    procedure SetDataPixels(X, Y: Integer; const Value: Extended);
  protected
    procedure Init; override;
    procedure CheckCore(const AHduCore: THduCore); override;
    procedure CheckStreamSize; virtual;
  public
    constructor CreateJoin(AStream: TStream);
    constructor CreateMade(AStream: TStream; const AHduCore: THduCore);
  public
    // Physical representation of the data - type of the user buffer for data access
    property DataRep: TRep read FDataRep write SetDataRep;
    property DataBitPix: TBitPix read GetDataBitPix;
    // Full data region
    // Data access: type Data = array of array of DataRep, overloaded methods
    // without using the Rgn ~ Rgn = DataRgn
    // Allocate memory for user data buffer: SetLength
    procedure DataPrepare(out Data: Pointer); overload;
    procedure DataPrepare(out Data: Pointer; const Rgn: TRgn); overload;
    // Reading
    procedure DataRead(Data: Pointer); overload;
    procedure DataRead(Data: Pointer; const Rgn: TRgn); overload;
    // Writing
    procedure DataWrite(Data: Pointer); overload;
    procedure DataWrite(Data: Pointer; const Rgn: TRgn); overload;
    // Point access: X ~ Column, Y ~ Row from DataRgn
    property DataPixels[X, Y: Integer]: Extended read GetDataPixels write SetDataPixels;
  end;

  { Header Fits stream as the file }
  
  TFitsFileHeader = class(TFitsHeader)
  private
    FFileName: string;
    function GetFileStream: TFileStream;   
  public
    constructor CreateJoin(const AFileName: string; AFileMode: Word);
    constructor CreateMade(const AFileName: string; const AHduCore: THduCore);
    destructor Destroy; override;
    property Stream: TFileStream read GetFileStream;
    property StreamFileName: string read FFileName;
  end;

  { Header & Data Unit Fits stream as the file }
  
  TFitsFileFrame = class(TFitsFrame)
  private
    FFileName: string;
    function GetFileStream: TFileStream;   
  public
    constructor CreateJoin(const AFileName: string; AFileMode: Word);
    constructor CreateMade(const AFileName: string; const AHduCore: THduCore);
    destructor Destroy; override;
    property Stream: TFileStream read GetFileStream;
    property StreamFileName: string read FFileName;
  end;

implementation

// Returns number of axis from keyword, if result = -1 then invalid kind of keyword
function KeywordAxisNum(const Keyword: string): Integer;
var
  S: string;
  Code: Integer;
begin
  Result := -1;
  if Pos(cNAXIS, Keyword) = 1 then
  if Length(Keyword) > Length(cNAXIS) then begin
    S := Trim(Copy(Keyword, Length(cNAXIS) + 1, Length(Keyword)));
    Val(S, Result, Code);
  end;
end;

// Returns kind of keyword
function KeywordKind(const Keyword: string): TKindHduKeyword;
begin
  if Keyword = cEND then
    Result := keyEnd
  else if Keyword = cSIMPLE then
    Result := keySimple
  else if Keyword = cBITPIX then
    Result := keyBitPix
  else if Keyword = cNAXIS then
    Result := keyNAxis
  else if KeywordAxisNum(Keyword) > 0 then
      Result := keyNAxisn
  else if Keyword = cBSCALE then
    Result := keyBScale
  else if Keyword = cBZERO then
    Result := keyBZero
  else if Keyword = cVal1 then
    Result := keyVal1
  else if Keyword = cDelta1 then
    Result := keyDelta1
  else if Keyword = cUnit1 then
    Result := keyUnit1
  else if Keyword = cXUnits then
    Result := keyXUnits
  else if Keyword = cYUnits then
    Result := keyYUnits
  else if Keyword = cMinWave then
    Result := keyMinWave
  else if Keyword = cMaxWave then
    Result := keyMaxWave
  else
    Result := keyUnknown;
end;

// Nearest multiple of upward
function BigNearMul(const Val: Int64; Mul: Integer): Int64;
var
  ValMod: Int64;
begin
  if Val <= 0 then
    Result := Val
  else if Val <= Mul then
    Result := Mul
  else
    begin
      ValMod := (Val mod Mul);
      if ValMod = 0 then
        Result := Val
      else
        Result := Val + (Mul - ValMod);
    end;
end;

procedure CopyTo(const Source: string; Index, Count: Integer; var Dest: TStreamBuffer); overload;
var
  S: AnsiString;
begin
  if Length(Dest) < Count then SetLength(Dest, Count);
  S := AnsiString(Source);
  Move(S[Index], Dest[0], Count);
end;

procedure CopyTo(const Source: TStreamBuffer; Index, Count: Integer; var Dest: string); overload;
var
  S: AnsiString;
begin
  SetLength(S, Count);
  Move(Source[Index], S[1], Count);
  Dest := string(S);
end;

{ TFits }

{$IFDEF DELADATBUFSHARED}
var
  // Shared buffer for input/output operation on the stream
  vDataBuffer: TStreamBuffer = nil;
{$ENDIF}

const
   // Memory block to stub the default constructor
  cStub: Cardinal = $FFFFFFFF;

procedure TFits.AllocateBuffer(var Buffer: Pointer; SizeInBytes: Integer);
begin
  {$IF DEFINED(DELADATBUFSHARED)}
  if Length(vDataBuffer) < SizeInBytes then
    SetLength(vDataBuffer, SizeInBytes);
  TStreamBuffer(Buffer) := vDataBuffer;
  {$ELSEIF DEFINED(DELADATBUFPRIVATE)}
  if Length(FDataBuffer) < SizeInBytes then
    SetLength(FDataBuffer, SizeInBytes);
  TStreamBuffer(Buffer) := FDataBuffer;
  {$ELSEIF DEFINED(DELADATBUFTEMP)}
  SetLength(TStreamBuffer(Buffer), SizeInBytes);
  {$IFEND}
end;

procedure TFits.CheckCore(const AHduCore: THduCore);
var
  I: Integer;
  E: Boolean;
begin
  with AHduCore do begin
    E := Simple and
         (BitPix > biUnknown) and (NAxis <= cMaxNaxis) and (NAxis = Length(NAxisn));
    I := 0;
    while E and (I < NAxis) do begin
      E := NAxisn[I] > 0;
      Inc(I);
    end;
  end;
  if not E then
    raise EFitsHduCoreException.Create(eCoreInvalid, ERROR_CORE_INVALID);
end;

procedure TFits.CheckStream(AStream: TStream);
var
  Buffer: TStreamBuffer;
  I: Integer;
  S: string;
begin
  if not Assigned(AStream) then
    raise EFitsException.Create(eStreamNotAssigned, ERROR_STREAM_NOT_ASSIGNED); 
  try   
    if AStream.Size < cSizeBlock then
      raise EFitsException.Create(eStreamInvalid, ERROR_STREAM_LOW_SIZE);
    // Check stream format
    SetLength(Buffer, cSizeBlock);
    S := '';
    AStream.Position := 0;
    AStream.Read(Buffer[0], cSizeBlock);
    for I := 0 to cCountLinesInBlock - 1 do begin
      CopyTo(Buffer, I * cSizeLine, cSizeLine, S);
      if Copy(S, 1, Length(cSIMPLE)) = cSIMPLE then
        Break
      else if Trim(S) = '' then
        // Continue
      else
        raise EFitsException.Create(eStreamInvalid, ERROR_STREAM_INVALID);
    end;
  finally
    Buffer := nil;
  end;
end;

constructor TFits.Create(const Stub);
begin  
  inherited Create;
  Init;
  Assert(@Stub = @cStub, 'Calling the default constructor is denied');
end;

constructor TFits.CreateJoin(AStream: TStream);
var count : integer;
    trouve,fini : boolean;
begin
  CheckStream(AStream);
  Create(cStub);
  FStream := AStream;
  count := 0;
  trouve := false;
  fini := false;
  repeat
    MakeFromStream(count);
    try
    CheckCore(FHduCore);
    trouve := true;
    FHduCore.isSpectre := (FHduCore.Naxis=1) or
      ((FHduCore.Naxis=2) and (FHduCore.Naxisn[1]<(FHduCore.Naxisn[0] div 16)));
    except
       on E:eFitsException do begin
         case E.code of
            ERROR_STREAM_INVALID : fini := true;
            ERROR_CORE_INVALID : fini := true;
            // ERROR_CORE_TWO_INVALID : ;
         end;
       end;
    end;
  until trouve or fini;
end;

constructor TFits.CreateMade(AStream: TStream; const AHduCore: THduCore);
var
  I: Integer;
begin
  CheckCore(AHduCore);
  Create(cStub);
  FStream := AStream;
  with FHduCore do begin
    Simple := AHduCore.Simple;
    BitPix := AHduCore.BitPix;
    NAxis  := AHduCore.NAxis;
    SetLength(NAxisn, NAxis);
    for I := 0 to NAxis - 1 do NAxisn[I] := AHduCore.NAxisn[I];
    BScale := AHduCore.BScale;
    BZero  := AHduCore.BZero;
  end;
  MakeFromCore;
end;

destructor TFits.Destroy;
begin
  FStream := nil;
  FHduCore.NAxisn := nil;
  FHduKeywords := nil;
  {$IFDEF DELADATBUFPRIVATE}
  FDataBuffer := nil;
  {$ENDIF}
  inherited;
end;

function TFits.GetStreamSize: Int64;
begin
  if Assigned(FStream) then
    Result := FStream.Size
  else
    Result := -1;
end;

function TFits.GetStreamSizeData: Int64;
var
  I: Integer;
begin
  Result := 0;
  if FHduCore.NAxis > 0 then begin
    Result := FHduCore.NAxisn[0];
    for I := 1 to FHduCore.NAxis - 1 do
      Result := Result * FHduCore.NAxisn[I];
    Result := (Abs(BitPixToInt(FHduCore.BitPix)) div 08) * Result;
  end;
end;

function TFits.GetStreamSizeHead: Int64;
begin
  Result := Length(FHduKeywords) * Int64(cSizeLine);
end;

procedure TFits.Init;
begin
  {$IFDEF DELADATBUFPRIVATE}
  FDataBuffer := nil;
  {$ENDIF}
  FStream := nil;
  FHduKeywords := nil; 
  FHduCore := ToHduCore;
end;

procedure TFits.MakeFromCore;
var
  I, N, Count: Integer;
  SizeHead, SizeData: Int64;
  Item: TLineItem;
  Buffer: TStreamBuffer;

  procedure Write(const Keyword: string; const Value: string; const Note: string);
  begin
    FHduKeywords[N] := Keyword;   
    Item.Keyword := DeLaFitsString.Alignment(Keyword, -cSizeKeyword);
    Item.Value.Str := DeLaFitsString.Alignment(Value, cWidthLineValue);
    Item.Note := Note;
    CopyTo(DeLaFitsString.ItemToLine(Item), 1, cSizeLine, Buffer);
    StreamWrite(Int64(N) * cSizeLine, cSizeLine, Buffer);
    Inc(N);
  end;

begin
  // Set count line in new header
  Count := (5 + FHduCore.NAxis + 1);
  Count := BigNearMul(Count, cCountLinesInBlock);
  // Set index of keywords header
  SetLength(FHduKeywords, Count);
  // Set size new stream: head + data
  SizeHead := Int64(Count) * cSizeLine;
  SizeData := 0;
  if FHduCore.NAxis > 0 then begin
    SizeData := FHduCore.NAxisn[0];
    for I := 1 to FHduCore.NAxis - 1 do
      SizeData := SizeData * FHduCore.NAxisn[I];
    SizeData := (Abs(BitPixToInt(FHduCore.BitPix)) div 08) * SizeData;
    SizeData := BigNearMul(SizeData, cSizeBlock);
  end;
  FStream.Size := SizeHead + SizeData;
  // Write header info & build index of keywords
  N := 0;
  SetLength(Buffer, cSizeLine);
  try
    // Write HduCore
    Item := ToLineItem('', True, '', True, '');
    Write(cSIMPLE, BolToStri(FHduCore.Simple), 'Conforms to FITS standard');
    Write(cBITPIX, BitPixToStri(FHduCore.BitPix), 'Number of bits per data value');
    Write(cNAXIS, IntToStri(FHduCore.NAxis), 'Number of axes');
    Item := ToLineItem('', True, '', False, '');
    for I := 0 to FHduCore.NAxis - 1 do Write(cNAXIS + IntToStri(Int64(I) + 1), IntToStri(Int64(FHduCore.NAxisn[I])), '');
    Item.NoteIndicate := True;
    Write(cBSCALE, FloatToStri(FHduCore.BScale, False, '%.12f'), 'Data scaling factor');
    Write(cBZERO, FloatToStri(FHduCore.BZero, False, '%.12f'), 'Data offset');   
    // Write keyword 'END'
    Item := ToLineItem('', False, '', False, '');
    Write(cEND, '', '');
    // Alignment of the header block, write blank line
    Item := ToLineItem('', False, '', False, '');
    while N < Count do Write('', '', '');
  finally
    Buffer := nil;
  end;
end;

procedure TFits.MakeFromStream(var Debut: Integer);
var
  I, J, N, count, Ioffset : Integer;
  K: TKindHduKeyword;
  S: string;
  posMicro : integer;
  Find: array [TKindHduKeyword] of Boolean;
  Buffer, Buf: TStreamBuffer;
  MiniW,MaxiW : double;
begin
  SetLength(Buffer, cSizeBlock);
  SetLength(Buf, cSizeKeyword);
  FHduCore := ToHduCore;
  count := 0;
  for K := Low(Find) to High(Find) do Find[K] := False;
  try
    // Search of keyword 'END': definition of line count in header
    CopyTo(DeLaFitsString.Alignment(cEND, -cSizeKeyword), 1, cSizeKeyword, Buf);
    while (not Find[keyEnd]) and ((Int64(Count+debut) * cSizeLine + cSizeBlock) <= FStream.Size) do begin
      StreamRead(Int64(Count+debut) * cSizeLine, cSizeBlock, Buffer);
      for I := cCountLinesInBlock - 1 downto 0 do
        if CompareMem(@Buf[0], @Buffer[I * cSizeLine], cSizeKeyword) then begin
          Find[keyEnd] := True;
          Break;
        end;
      Inc(Count, cCountLinesInBlock);
    end;
    if not Find[keyEnd] then
      raise EFitsException.Create(eStreamInvalid, ERROR_STREAM_INVALID);
    // Definition of keywords
    SetLength(FHduKeywords, Count);
    S := '';
    Ioffset := (debut div cCountLinesInBlock);
    for I := 0 to (Count div cCountLinesInBlock) - 1 do begin
      StreamRead(Int64(I+Ioffset) * cSizeBlock, cSizeBlock, Buffer);
      for J := 0 to cCountLinesInBlock - 1 do begin
        CopyTo(Buffer, J * cSizeLine, cSizeKeyword, S);
        FHduKeywords[J + I * cCountLinesInBlock] := Trim(S);
      end;
    end;
    MiniW := 0; MaxiW := 0;
    // Definition of core, not NAxisn
    Ioffset := debut;
    for I := 0 to Count - 1 do begin
      K := KeywordKind(FHduKeywords[I]);
      if K = keyEnd then Break;
      if K in [keySimple, keyBitPix, keyNAxis, keyBScale, keyBZero,
       keyVal1, keyDelta1, keyUnit1, keyXunits, keyYunits, keyMinWave, keyMaxWave] then
      if not Find[K] then begin
        Find[K] := True;
        StreamRead(Int64(I+Ioffset) * cSizeLine, cSizeLine, Buffer);
        CopyTo(Buffer, 0, cSizeLine, S);
        S := LineToItem(S).Value.Str;
        S := unquoted(S);
        case K of
          keySimple: FHduCore.Simple := StriToBol(S);
         // keyXtension: ;
          keyBitPix: FHduCore.BitPix := StriToBitPix(S);
          keyNAxis: begin
              FHduCore.NAxis := Word(StriToInt(S));
              SetLength(FHduCore.NAxisn, FHduCore.NAxis);
              for J := 0 to FHduCore.NAxis - 1 do FHduCore.NAxisn[J] := 0;
          end;
          keyBScale: FHduCore.BScale := StriToFloat(S);
          keyBZero: FHduCore.BZero := StriToFloat(S);
          keyVal1: FHduCore.Lambda0 := StriToFloat(S);
          keyDelta1: FHduCore.DeltaLambda := StriToFloat(S);
          keyMinWave: MiniW := StriToFloat(S);
          keyMaxWave: MaxiW := StriToFloat(S);
          keyUnit1: FHduCore.uniteX := S;
          keyXUnits: FHduCore.uniteX := S;
          keyYUnits: begin
             PosMicro := pos('um',S);
             if posMicro>0 then S[posMicro] := 'μ';
             FHduCore.uniteY := S;
          end;
        end;
      end;
    end;
    // Definition of NAxisn in core
    if Find[keyNAxis] then begin
      I := 0;
      N := 0; // number of axes found
      while (I < Count) and (N < FHduCore.NAxis) do begin
        K := KeywordKind(FHduKeywords[I]);
        case K of
          keyEnd: Break;
          keyNAxisn: begin
              J := KeywordAxisNum(FHduKeywords[I]) - 1;
              if (J >= 0) and (J < FHduCore.NAxis) then begin
                StreamRead(Int64(I+Ioffset) * cSizeLine, cSizeLine, Buffer);
                CopyTo(Buffer, 0, cSizeLine, S);
                S := LineToItem(S).Value.Str;
                FHduCore.NAxisn[J] := Word(StriToInt(S));
                Inc(N);
              end;
            end;
        end;
        Inc(I);
      end;
    end;
    if (maxiW*miniW >0) and (FHduCore.Naxis>0) and (FHduCore.Naxisn[0]>0) then begin
       FHduCore.Lambda0 := miniW;
       FHduCore.DeltaLambda := (maxiW-miniW)/FHduCore.Naxisn[0];
    end;
  finally
    Buffer := nil;
    Buf := nil;
  end;
  debut := debut+count;
end;

procedure TFits.ReleaseBuffer(var Buffer: Pointer);
begin
  TStreamBuffer(Buffer) := nil;
  Buffer := nil;
end;

procedure TFits.StreamFill(const Offset, Count: Int64; Chr: Char);
var
  N, L: Integer;
  ACount: Int64;
  Buffer: TStreamBuffer;
begin
  try
    if Count > cSizeStreamBuffer then L := cSizeStreamBuffer else L := Count;
    Buffer := nil;
    AllocateBuffer(Pointer(Buffer), L);
    FillChar(Buffer[0], L, Char(Chr));
    ACount := Count;
    while ACount > 0 do begin
      if ACount > L then N := L else N := ACount;
      StreamWrite(Offset + ACount - N, N, Buffer);
      Dec(ACount, N);
    end;
  finally
    ReleaseBuffer(Pointer(Buffer));
  end;
end;

procedure TFits.StreamShift(const Offset, Count, Shift: Int64);
var
  N, L: Integer;
  ACount, AOffset: Int64;
  Buffer: TStreamBuffer;
begin
  ACount := Count;
  AOffset := Offset;
  try
    if ACount > cSizeStreamBuffer then L := cSizeStreamBuffer else L := ACount;
    Buffer := nil;
    AllocateBuffer(Pointer(Buffer), L);
    // Move content down
    if Shift > 0 then
      while ACount <> 0 do begin
        if ACount > L then N := L else N := ACount;
        StreamRead(AOffset + ACount - N, N, Buffer);
        StreamWrite(AOffset + Shift + ACount - N, N, Buffer);
        Dec(ACount, N);
      end
    // Move content up
    else { Shift < 0 }
      while ACount <> 0 do begin
        if ACount > L then N := L else N := ACount;
        StreamRead(AOffset, N, Buffer);
        StreamWrite(AOffset + Shift, N, Buffer);
        Inc(AOffset, N);
        Dec(ACount, N);
      end;
  finally
    ReleaseBuffer(Pointer(Buffer));
  end;
end;

procedure TFits.StreamRead(const Offset, Count: Int64; var Buffer: TStreamBuffer);
begin
  FStream.Position := Offset;
  if (Count <> 0) and (FStream.Read(Buffer[0], Count) <> Count) then
    raise EFitsException.Create(eStreamAccess, ERROR_STREAM_READ);
end;

procedure TFits.StreamWrite(const Offset, Count: Int64; const Buffer: TStreamBuffer);
begin
  FStream.Position := Offset;
  if (Count <> 0) and (FStream.Write(Buffer[0], Count) <> Count) then
    raise EFitsException.Create(eStreamAccess, ERROR_STREAM_WRITE);
end;

{ TLineBuilder }

function TLineBuilder.Add(const Item: TLineItem; Cast: Integer): Integer;
var
  Line: string;
begin
  Line := Compose(Item, Cast);
  Result := FFits.LineAdd(Length(Line) div cSizeLine, Line);
end;

procedure TLineBuilder.Clear;
begin
  FFits.LineClear;
end;

function TLineBuilder.Compose(Item: TLineItem; Cast: Integer): string;
const
  cLenMax = cSizeLine - cSizeKeyword - 2;
var
  I, Len: Integer;
  S: string;
begin
  case Cast of
    cCastChars: begin
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaStr.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastCharsLong: begin
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaStr.wWidth);
        if Length(Item.Value.Str) > cLenMax then begin
          Len := BigNearMul(Length(Item.Value.Str), cLenMax);
          S := DeLaFitsString.AlignmentStrict(Item.Value.Str, -Len);
          Result := '';
          for I := 0 to (Len div cLenMax) - 1 do begin
            Item.Value.Str := Copy(S, 1 + I * cLenMax, cLenMax);
            Result := Result + DeLaFitsString.ItemToLine(Item);
          end;
        end
        else
          Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastString: begin
        Item.Value.Str := DeLaFitsString.Quoted(Item.Value.Str, FFmt.vaStr.wWidthQuoteInside);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaStr.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastBoolean: begin
        Item.Value.Str := DeLaFitsString.BolToStri(Item.Value.Bol);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaBol.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastInteger: begin
        Item.Value.Str := DeLaFitsString.IntToStri(Item.Value.Int, FFmt.vaInt.wSign, FFmt.vaInt.wFmt);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaInt.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastFloat: begin
        Item.Value.Str := DeLaFitsString.FloatToStri(Item.Value.Ext, FFmt.vaFloat.wSign, FFmt.vaFloat.wFmt);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaFloat.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastRa: begin
        Item.Value.Str := DeLaFitsString.RaToStri(Item.Value.Ext, FFmt.vaCoord.wPrecRa, FFmt.vaCoord.wFmtNotate, FFmt.vaCoord.wFmtMeasurRa);
        Item.Value.Str := DeLaFitsString.Quoted(Item.Value.Str, FFmt.vaCoord.wWidthQuoteInside);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaCoord.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastDe: begin
        Item.Value.Str := DeLaFitsString.DeToStri(Item.Value.Ext, FFmt.vaCoord.wPrecDe, FFmt.vaCoord.wFmtNotate);
        Item.Value.Str := DeLaFitsString.Quoted(Item.Value.Str, FFmt.vaCoord.wWidthQuoteInside);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaCoord.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    cCastDateTime, cCastDate, cCastTime: begin
        Item.Value.Str := DeLaFitsString.DateTimeToStri(Item.Value.Dtm, Cast);
        Item.Value.Str := DeLaFitsString.Quoted(Item.Value.Str, FFmt.vaDateTime.wWidthQuoteInside);
        Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, FFmt.vaDateTime.wWidth);
        Result := DeLaFitsString.ItemToLine(Item);
      end;
    else begin
        Result := '';
        raise EFitsLineBuilderException.CreateFmt(eUnknownCast, [Cast], ERROR_COMPOSE_UNKNOWN_CAST);
      end;
  end;
end;

constructor TLineBuilder.Create(AFits: TFitsHeader);
begin
  inherited Create;
  Init;
  FFits := AFits;
end;

procedure TLineBuilder.Delete(Index: Integer; Long: Boolean);
var
  I, N: Integer;
begin
  N := 1;
  if Long then begin
    for I := Index + 1 to FFits.LineCount - 2 do
      if FFits.LinesKeyword[Index] = FFits.LinesKeyword[I] then
        Inc(N)
      else
        Break;
  end;
  FFits.LineDelete(Index, N);
end;

destructor TLineBuilder.Destroy;
begin
  FFits := nil;
  inherited;
end;

procedure TLineBuilder.Exchange(Index1, Index2: Integer);
begin
  FFits.LineExchange(Index1, Index2);
end;

function TLineBuilder.GetCount: Integer;
begin
  Result := FFits.LineCount;
end;

function TLineBuilder.GetFmt: PFormatLine;
begin
  Result := @FFmt;
end;

function TLineBuilder.GetItems(Index, Cast: Integer): TLineItem;
begin
  Read(Index, Result, Cast);
end;

function TLineBuilder.GetKeywords(Index: Integer): string;
begin
  Result := FFits.LinesKeyword[Index];
end;

function TLineBuilder.GetNotes(Index: Integer): string;
var
  Line: string;
begin
  FFits.LineRead(Index, 1, Line);
  Result := DeLaFitsString.LineToItem(Line).Note
end;

function TLineBuilder.GetValuesBoolean(Index: Integer): Boolean;
begin
  Result := Items[Index, cCastBoolean].Value.Bol;
end;

function TLineBuilder.GetValuesCoord(Index, Cast: Integer): Extended;
begin
  Result := Items[Index, Cast].Value.Ext;
end;

function TLineBuilder.GetValuesDateTime(Index, Cast: Integer): TDateTime;
begin
  Result := Items[Index, Cast].Value.Dtm;
end;

function TLineBuilder.GetValuesFloat(Index: Integer): Extended;
begin
  Result := Items[Index, cCastFloat].Value.Ext;
end;

function TLineBuilder.GetValuesInteger(Index: Integer): Int64;
begin
  Result := Items[Index, cCastInteger].Value.Int;
end;

function TLineBuilder.GetValuesStr(Index, Cast: Integer): string;
begin
  Result := Items[Index, Cast].Value.Str;
end;

function TLineBuilder.IndexOf(Keyword: string; StartIndex: Integer = 0): Integer;
begin
  Result := FFits.LineIndexOf(Keyword, StartIndex);
end;

procedure TLineBuilder.Init;
begin
  FFits := nil;
  with FFmt do begin
    vaStr.wWidth := -cWidthLineValue;
    vaStr.wWidthQuoteInside := -cWidthLineValueQuote;
    vaBol.wWidth := cWidthLineValue;
    vaInt.wWidth := cWidthLineValue;
    vaInt.wSign := False;
    vaInt.wFmt := '%d';
    vaFloat.wWidth := cWidthLineValue;
    vaFloat.wSign := False;
    vaFloat.wFmt := '%g';
    vaDateTime.rFmtShortDate := yymmdd;
    vaDateTime.wWidth := -cWidthLineValue;
    vaDateTime.wWidthQuoteInside := -cWidthLineValueQuote;
    vaCoord.rFmtMeasurRa := cmHour;
    vaCoord.wWidth := -cWidthLineValue;
    vaCoord.wWidthQuoteInside := -cWidthLineValueQuote;
    vaCoord.wPrecRa := 4;
    vaCoord.wPrecDe := 4;
    vaCoord.wFmtMeasurRa := cmHour;
    vaCoord.wFmtNotate := cmSexagesimal;
  end;
end;

procedure TLineBuilder.Insert(Index: Integer; const Item: TLineItem; Cast: Integer);
var
  Line: string;
begin
  Line := Compose(Item, Cast);
  FFits.LineInsert(Index, Length(Line) div cSizeLine, Line);
end;

procedure TLineBuilder.Move(CurIndex, NewIndex: Integer);
begin
  FFits.LineMove(CurIndex, NewIndex);
end;

function TLineBuilder.Parse(Line: string; Cast: Integer): TLineItem;
begin
  Result := DeLaFitsString.LineToItem(Line);
  case Cast of
    cCastChars:
        // Result := DeLaFitsString.LineToItem(Line);
    ;
    cCastCharsLong: begin
        // Result := DeLaFitsString.LineToItem(Line);
        System.Delete(Line, 1, cSizeLine);
        while Length(Line) >= cSizeLine do begin
          Result.Value.Str := Result.Value.Str + DeLaFitsString.LineToItem(Line).Value.Str;
          System.Delete(Line, 1, cSizeLine);
        end;
        Result.Value.Str := Trim(Result.Value.Str);
      end;
    cCastString: begin
        Result.Value.Str := DeLaFitsString.UnQuoted(Result.Value.Str);
      end;
    cCastBoolean: begin
        Result.Value.Bol := DeLaFitsString.StriToBol(Result.Value.Str);
        Result.Value.Str := '';
      end;
    cCastInteger: begin
        Result.Value.Int := DeLaFitsString.StriToInt(Result.Value.Str);
        Result.Value.Str := '';
      end;
    cCastFloat: begin
        Result.Value.Ext := DeLaFitsString.StriToFloat(Result.Value.Str);
        Result.Value.Str := '';
      end;
    cCastRa: begin
        Result.Value.Str := DeLaFitsString.UnQuoted(Result.Value.Str);
        Result.Value.Ext := DeLaFitsString.StriToRa(Result.Value.Str, FFmt.vaCoord.rFmtMeasurRa);
        Result.Value.Str := '';
      end;
    cCastDe: begin
        Result.Value.Str := DeLaFitsString.UnQuoted(Result.Value.Str);
        Result.Value.Ext := DeLaFitsString.StriToDe(Result.Value.Str);
        Result.Value.Str := '';
      end;
    cCastDateTime, cCastDate, cCastTime: begin
        Result.Value.Str := DeLaFitsString.UnQuoted(Result.Value.Str);
        Result.Value.Dtm := DeLaFitsString.StriToDateTime(Result.Value.Str, Cast, FFmt.vaDateTime.rFmtShortDate);
        Result.Value.Str := '';
      end;
    else
        raise EFitsLineBuilderException.CreateFmt(eUnknownCast, [Cast], ERROR_PARSE_UNKNOWN_CAST);
  end;
end;

procedure TLineBuilder.Read(Index: Integer; out Item: TLineItem; Cast: Integer);
var
  Line: string;
  I, N: Integer;
begin
  N := 1;
  if Cast = cCastCharsLong then begin
    for I := Index + 1 to FFits.LineCount - 2 do
      if FFits.LinesKeyword[Index] = FFits.LinesKeyword[I] then
        Inc(N)
      else
        Break;
  end;
  FFits.LineRead(Index, N, Line);
  Item := Parse(Line, Cast);
end;

procedure TLineBuilder.SetItems(Index, Cast: Integer; Value: TLineItem);
begin
  Write(Index, Value, Cast);
end;

procedure TLineBuilder.SetKeywords(Index: Integer; const Value: string);
begin
  FFits.LinesKeyword[Index] := Value;
end;

procedure TLineBuilder.SetNotes(Index: Integer; Value: string);
var
  AHduCoreAuditing: Boolean;
  Line: string;
  Item: TLineItem;
  L, W: Integer;
begin
  // Reading items from index & put new note
  FFits.LineRead(Index, 1, Line);
  Item := DeLaFitsString.LineToItem(Line);
  // Prepare Item.Value.Str
  Item.Value.Str := Trim(Item.Value.Str);
  L := Length(Item.Value.Str);
  if (L > 1) and (Item.Value.Str[1] = cChrQuote) and (Item.Value.Str[L] = cChrQuote) then
    W := -cWidthLineValue
  else
    W := cWidthLineValue;
  Item.Value.Str := DeLaFitsString.Alignment(Item.Value.Str, W);
  // Prepare new Item.Note
  Value := Trim(Value);
  Item.NoteIndicate := (Value <> '');
  Item.Note := Value;
  // Reset flag of HduCoreAuditing
  AHduCoreAuditing := FFits.HduCoreAuditing;
  FFits.HduCoreAuditing := False;
  try
    Line := DeLaFitsString.ItemToLine(Item);
    FFits.LineWrite(Index, 1, Line);
  finally
    // Restore flag of HduCoreAuditing
    FFits.HduCoreAuditing := AHduCoreAuditing;
  end;
end;

procedure TLineBuilder.SetValuesBoolean(Index: Integer; const Value: Boolean);
var
  Item: TLineItem;
begin
  Item := Items[Index, cCastChars];
  Item.Value.Bol := Value;
  Items[Index, cCastBoolean] := Item;
end;

procedure TLineBuilder.SetValuesCoord(Index, Cast: Integer; Value: Extended);
var
  Item: TLineItem;
begin
  Item := Items[Index, cCastChars];
  Item.Value.Ext := Value;
  Items[Index, Cast] := Item;
end;

procedure TLineBuilder.SetValuesDateTime(Index, Cast: Integer; Value: TDateTime);
var
  Item: TLineItem;
begin
  Item := Items[Index, cCastChars];
  Item.Value.Dtm := Value;
  Items[Index, Cast] := Item;
end;

procedure TLineBuilder.SetValuesFloat(Index: Integer; const Value: Extended);
var
  Item: TLineItem;
begin
  Item := Items[Index, cCastChars];
  Item.Value.Ext := Value;
  Items[Index, cCastFloat] := Item;
end;

procedure TLineBuilder.SetValuesInteger(Index: Integer; const Value: Int64);
var
  Item: TLineItem;
begin
  Item := Items[Index, cCastChars];
  Item.Value.Int := Value;
  Items[Index, cCastInteger] := Item;
end;

procedure TLineBuilder.SetValuesStr(Index, Cast: Integer; Value: string);
var
  Item: TLineItem;
begin
  Item := Items[Index, Cast]; // ~ mabe cCastCharsLong
  Item.Value.Str := Value;
  Items[Index, Cast] := Item;
end;

function TLineBuilder.ValuesDateTimeAny(Index: Integer; out Slice: TSliceDateTime): TDateTime;
var
  Value: string;
begin
  Value := Items[Index, cCastString].Value.Str;
  Slice := DeLaFitsString.GetSliceDateTime(Value);
  Result := DeLaFitsString.StriToDateTime(Value, Slice, FFmt.vaDateTime.rFmtShortDate);
end;

procedure TLineBuilder.Write(Index: Integer; const Item: TLineItem; Cast: Integer);
var
  Line: string;
begin
  Line := Compose(Item, Cast);
  FFits.LineWrite(Index, Length(Line) div cSizeLine, Line);
end;

{ TFitsHeader }

constructor TFitsHeader.CreateJoin(AStream: TStream);
begin
  inherited;
  Make;
end;

constructor TFitsHeader.CreateMade(AStream: TStream; const AHduCore: THduCore);
begin
  inherited;
  Make;
end;

destructor TFitsHeader.Destroy;
begin
  if Assigned(FLineBuilder) then FreeAndNil(FLineBuilder);
  inherited;
end;

function TFitsHeader.GetHduText: string;
begin
  LineRead(0, FLineCount, Result);
end;

function TFitsHeader.GetLines(Index: Integer): string;
begin
  LineRead(Index, 1, Result);
end;

function TFitsHeader.GetLinesKeyword(Index: Integer): string;
begin
  // The index must be in the correct range
  if (Index < 0) or (Index > FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_GETLINESKEYWORD_INDEX);
  Result := FHduKeywords[Index];
end;

procedure TFitsHeader.Init;
begin
  inherited;
  FLineCount := 0;
  FLineCapacity := 0;
  FDataOffset := -1;
  FHduCoreAuditing := True;
  FLineBuilder := nil;
end;

function TFitsHeader.LineAdd(Count: Integer; Line: string): Integer;
begin
  Result := FLineCount - 1;
  LineInsert(Result, Count, Line);
end;

procedure TFitsHeader.LineClear;
var
  I, J, Offset, Count: Integer;
  AHduCoreAuditing: Boolean;
begin
  // Key of line core move up
  // Reset flag of HduCoreAuditing
  AHduCoreAuditing := FHduCoreAuditing;
  FHduCoreAuditing := False;
  J := 0;
  for I := 0 to FLineCount - 2 do
  if KeywordKind(FHduKeywords[I]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn, keyBScale, keyBZero] then
  begin
    LineExchange(I, J);
    Inc(J);
  end;
  // Restore flag of HduCoreAuditing
  FHduCoreAuditing := AHduCoreAuditing;
  // Delete other line
  Count := FLineCount - (J + 1);
  LineDelete(J, Count);
  // Fill the empty space header
  Offset := FLineCount * cSizeLine;
  Count := (FLineCapacity - FLineCount) * cSizeLine;
  StreamFill(Offset, Count, cChrBlank);
end;

procedure TFitsHeader.LineDelete(Index, Count: Integer);
var
  I, Stock: Integer;
  AOffset, ACount, AShift: Int64;
begin
  // The index must be in the correct range
  if (Index < 0) or (Index > FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_LINEDELETE_INDEX);
  // Incorrect number of lines removed
  if not ((Count > 0) and (Index + Count < FLineCount)) then
    raise EFitsHeaderException.Create(eInputInvalid, ERROR_LINEDELETE_COUNT);
  // Checks of HduCore
  if FHduCoreAuditing then
    for I := Index to Index + Count - 1 do
      if KeywordKind(FHduKeywords[I]) > keyUnknown then
        raise EFitsHduCoreException.Create(eCoreAccess, ERROR_LINEDELETE_CORE);
  // Shift stream header-content up
  AOffset := cSizeLine * (Index + Int64(Count));
  ACount := cSizeLine * (FLineCount - (Index + Int64(Count) - 1));
  AShift := Int64(cSizeLine) * (0 - Count);
  StreamShift(AOffset, ACount, AShift);
  // Fill header of lines blank
  AOffset := cSizeLine * (FLineCount - Int64(Count));
  ACount := Int64(cSizeLine) * Count;
  StreamFill(AOffset, ACount, cChrBlank);
  // Remove from Keywords unnecessary
  for I := Index to FLineCount - Count - 1 do
    FHduKeywords[I] := FHduKeywords[I + Count];
  for I := FLineCount - Count to FLineCount - 1 do
    FHduKeywords[I] := '';
  Dec(FLineCount, Count);
  // Shift stream data-content up
  Stock := Int64(cSizeLine) * (FLineCapacity - BigNearMul(FLineCount, cCountLinesInBlock));
  if Stock >= cSizeBlock then begin
    StreamShift(FDataOffset, (FStream.Size - FDataOffset), -Stock);
    FStream.Size := FStream.Size - Stock;
    Dec(FLineCapacity, Stock div  cSizeLine);
    Dec(FDataOffset, Stock);
    SetLength(FHduKeywords, FLineCapacity);
  end;
end;

procedure TFitsHeader.LineExchange(Index1, Index2: Integer);
var
  Buf1, Buf2: TStreamBuffer;
  Key: string;
begin
  if Index1 = Index2 then Exit;
  // The index must be in the correct range
  if not ((Index1 >= 0) and (Index1 < FLineCount - 1) and (Index2 >= 0) and (Index2 < FLineCount - 1)) then
    raise EFitsHeaderException.CreateFmt(eIndexIncorrect, [Index1, Index2], ERROR_LINEEXCHANGE_INDEX);
  // Checks of HduCore: do not exchange the key line of core
  if FHduCoreAuditing then begin
    if (KeywordKind(FHduKeywords[Index1]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn]) or
       (KeywordKind(FHduKeywords[Index2]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn]) then
      raise EFitsHduCoreException.Create(eCoreAccess, ERROR_LINEEXCHANGE_CORE);
  end;
  try
    // Exchange stream content-header line
    SetLength(Buf1, cSizeLine);
    SetLength(Buf2, cSizeLine);
    StreamRead(Index1 * Int64(cSizeLine), cSizeLine, Buf1);
    StreamRead(Index2 * Int64(cSizeLine), cSizeLine, Buf2);
    StreamWrite(Index1 * Int64(cSizeLine), cSizeLine, Buf2);
    StreamWrite(Index2 * Int64(cSizeLine), cSizeLine, Buf1);
    // Exchange HduKeywords
    Key := FHduKeywords[Index1];
    FHduKeywords[Index1] := FHduKeywords[Index2];
    FHduKeywords[Index2] := Key;
  finally
    Buf1 := nil;
    Buf2 := nil;
  end;
end;

function TFitsHeader.LineIndexOf(Keyword: string; StartIndex: Integer = 0): Integer;
var
  I: Integer;
begin
  Result := -1;
  if StartIndex >= 0 then begin
    Keyword := UpperCase(Trim(Keyword));
    for I := StartIndex to FLineCount - 1 do
      if FHduKeywords[I] = Keyword then begin
        Result := I;
        Break;
      end;
  end;
end;

procedure TFitsHeader.LineInsert(Index, Count: Integer; Line: string);
var
  I: Integer;
  S: string;
  Keys: THduKeywords;
  Buffer: TStreamBuffer;
  Stock, Grow: Integer;
  AOffset, ACount, AShift: Int64;
begin
  if Count <= 0 then Exit;
  // The index must be in the correct range
  if (Index < 0) or (Index > FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_LINEINSERT_INDEX);
  // Correction of input parameters: Count & Line
  Line := AlignmentStrict(Line, -(Count * cSizeLine));
  try
    // Read keywords
    SetLength(Keys, Count);
    for I := 0 to Count - 1 do begin
      S := Copy(Line, 1 + I * cSizeLine, cSizeKeyword);
      // Keywords must be UpperCase
      if S <> UpperCase(S) then
        raise EFitsHeaderException.CreateFmt(eKeywordInavlid, [S], ERROR_LINEINSERT_KEYWORD);
      Keys[I] := Trim(S);
    end;
    // Checks of HduCore
    if FHduCoreAuditing then begin
      if Index = 0 then
        raise EFitsHduCoreException.Create(eCoreAccess, ERROR_LINEINSERT_CORE_INDEX);
      // Can not break line
      if KeywordKind(FHduKeywords[Index])     in [keySimple, keyBitPix, keyNAxis, keyNAxisn] then
      if KeywordKind(FHduKeywords[Index - 1]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn] then
        raise EFitsHduCoreException.Create(eCoreAccessBreak, ERROR_LINEINSERT_CORE_BREAK);
      // Keywords should not belong to core
      for I := 0 to Count - 1 do
      if KeywordKind(Keys[I]) > keyUnknown then
        raise EFitsHduCoreException.CreateFmt(eCoreAccessInput, [Keys[I]], ERROR_LINEINSERT_CORE_KEYWORD);
    end;
    // Insert
    Stock := (FLineCapacity - FLineCount) * cSizeLine;
    Grow := Count * cSizeLine;
    if Grow > Stock then begin // Stock lines not enough, FLineCapacity & FDataOffset must change
      // Move stream data-content
      AOffset := FDataOffset;
      ACount := FStream.Size - FDataOffset;
      AShift := BigNearMul(Int64(Grow) - Stock, cSizeBlock);
      FStream.Size := FStream.Size + AShift;
      StreamShift(AOffset, ACount, AShift);
      // Insert new Keywords in HduKeywords
      Inc(FLineCapacity, AShift div cSizeLine);
      Inc(FDataOffset, AShift);
      SetLength(FHduKeywords, FLineCapacity);
      for I := FLineCapacity - 1 downto Index + Count do
        FHduKeywords[I] := FHduKeywords[I - Count];
      for I := 0 to Count - 1 do
        FHduKeywords[Index + I] := Keys[I];
      // Move stream header-content
      AOffset := Int64(Index) * cSizeLine;
      ACount := (Int64(FLineCount) - Index) * cSizeLine;
      AShift := Grow;
      StreamShift(AOffset, ACount, AShift);
      Inc(FLineCount, AShift div cSizeLine);
      // Write Line
      SetLength(Buffer, Grow);
      CopyTo(Line, 1, Grow, Buffer);
      StreamWrite(AOffset, Grow, Buffer);
      StreamFill(Int64(FLineCount) * cSizeLine, (Int64(FLineCapacity) - FLineCount) * cSizeLine, cChrBlank);
    end
    else begin {if Grow <= Stock then}
      // Stock lines are enough, FLineCapacity & FDataOffset remain unchanged
      // Move stream header-content
      AOffset := Int64(Index) * cSizeLine;
      ACount := (Int64(FLineCount) - Index) * cSizeLine;
      AShift := Grow;
      StreamShift(AOffset, ACount, AShift);
      // Insert new Keywords in HduKeywords
      for I := FLineCapacity - 1 downto Index + Count do
        FHduKeywords[I] := FHduKeywords[I - Count];
      for I := 0 to Count - 1 do
        FHduKeywords[Index + I] := Keys[I];
      Inc(FLineCount, AShift div cSizeLine);
      // Write Line
      SetLength(Buffer, Grow);
      CopyTo(Line, 1, Grow, Buffer);
      StreamWrite(AOffset, Grow, Buffer);
    end;
  finally
     Keys := nil;
     Buffer := nil;
  end;  
end;

procedure TFitsHeader.LineMove(CurIndex, NewIndex: Integer);
var
  I, Offset, Count: Integer;
  Buffer: TStreamBuffer;
  Key: string;
begin
  if CurIndex = NewIndex then Exit;
  // The index must be in the correct range
  if not ((CurIndex >= 0) and (CurIndex < FLineCount - 1) and (NewIndex >= 0) and (NewIndex < FLineCount - 1)) then
    raise EFitsHeaderException.CreateFmt(eIndexIncorrect, [CurIndex, NewIndex], ERROR_LINEMOVE_INDEX);
  // Checks of HduCore: do not move the key line of core
  if FHduCoreAuditing then begin
   if (KeywordKind(FHduKeywords[CurIndex]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn]) or
      (KeywordKind(FHduKeywords[NewIndex]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn]) then
     raise EFitsHduCoreException.Create(eCoreAccess, ERROR_LINEMOVE_CORE);
  end;
  try
    SetLength(Buffer, cSizeLine);
    StreamRead(CurIndex * Int64(cSizeLine), cSizeLine, Buffer);
    Key := FHduKeywords[CurIndex];
    // Move line down: shift up header-content starting with (CurIndex + 1)
    if CurIndex < NewIndex then begin
      Offset := (CurIndex + 1) * cSizeLine;
      Count := (NewIndex - CurIndex) * cSizeLine;
      StreamShift(Offset, Count, -cSizeLine);
      for I := CurIndex to NewIndex - 1 do FHduKeywords[I] := FHduKeywords[I + 1];
    end
    // Move line up: shift down header-content starting with NewIndex
    else begin {CurIndex > NewIndex}
      Offset := NewIndex * cSizeLine;
      Count := (CurIndex - NewIndex) * cSizeLine;
      StreamShift(Offset, Count, cSizeLine);
      for I := CurIndex - 1 downto NewIndex do FHduKeywords[I + 1] := FHduKeywords[I];
    end;
    StreamWrite(NewIndex * Int64(cSizeLine), cSizeLine, Buffer);
    FHduKeywords[NewIndex] := Key;
  finally
    Buffer := nil;
  end;
end;

procedure TFitsHeader.LineRead(Index, Count: Integer; out Line: string);
var
  Buffer: TStreamBuffer;
begin
  // The index must be in the correct range
  if (Index < 0) or (Index > FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_LINEREAD_INDEX);
  // Incorrect number of lines for reading
  if not ((Count > 0) and (Index + Count <= FLineCount)) then
    raise EFitsHeaderException.Create(eInputInvalid, ERROR_LINEREAD_COUNT);
  try
    Index := Index * cSizeLine;
    Count := Count * cSizeLine;
    SetLength(Buffer, Count);
    StreamRead(Index, Count, Buffer);
    Line := '';
    CopyTo(Buffer, 0, Count, Line);
  finally
    Buffer := nil;
  end;
end;

procedure TFitsHeader.LineWrite(Index, Count: Integer; Line: string);
var
  I: Integer;
  S: string;
  Keys: THduKeywords;
  Buffer: TStreamBuffer;
begin
  // The index must be in the correct range
  if (Index < 0) or (Index > FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_LINEWRITE_INDEX);
  // Incorrect number of lines for reading
  if not ((Count > 0) and (Index + Count < FLineCount)) then
    raise EFitsHeaderException.Create(eInputInvalid, ERROR_LINEWRITE_COUNT);
  Line := AlignmentStrict(Line, -(Count * cSizeLine));
  try
    // Read keywords
    SetLength(Keys, Count);
    for I := 0 to Count - 1 do begin
      S := Copy(Line, 1 + I * cSizeLine, cSizeKeyword);
      // Keywords must be UpperCase
      if S <> UpperCase(S) then
        raise EFitsHeaderException.CreateFmt(eKeywordInavlid, [S], ERROR_LINEWRITE_KEYWORD);
      Keys[I] := Trim(S);
    end;
    // Checks of HduCore
    if FHduCoreAuditing then begin
      if Index = 0 then
        raise EFitsHduCoreException.Create(eCoreAccess, ERROR_LINEWRITE_CORE_INDEX);
      // Can not break line
      if KeywordKind(FHduKeywords[Index])     in [keySimple, keyBitPix, keyNAxis, keyNAxisn] then
      if KeywordKind(FHduKeywords[Index + 1]) in [keySimple, keyBitPix, keyNAxis, keyNAxisn] then
        raise EFitsHduCoreException.Create(eCoreAccessBreak, ERROR_LINEWRITE_CORE_BREAK);
      // Keywords should not belong to core
      for I := 0 to Count - 1 do begin
        if KeywordKind(Keys[I]) > keyUnknown then
          raise EFitsHduCoreException.CreateFmt(eCoreAccessInput, [Keys[I]], ERROR_LINEWRITE_CORE_KEYWORD);
        if KeywordKind(FHduKeywords[Index + I]) > keyUnknown then
          raise EFitsHduCoreException.CreateFmt(eCoreAccessInput, [FHduKeywords[Index + I]], ERROR_LINEWRITE_CORE_KEYWORD);
      end;
    end;
    // Write line and HduKeywords
    SetLength(Buffer, Count * cSizeLine);
    CopyTo(Line, 1, Count * cSizeLine, Buffer);
    StreamWrite(Index * Int64(cSizeLine), Length(Buffer), Buffer);
    for I := 0 to Length(Keys) - 1 do
      FHduKeywords[Index + I] := Keys[I];
  finally
    Keys := nil;
    Buffer := nil;
  end;
end;

procedure TFitsHeader.Make;
var
  I: Integer;
begin
  for I := 0 to Length(FHduKeywords) - 1 do
  if FHduKeywords[I] = cEND then begin
    FLineCount := I + 1;
    Break;
  end;
  FLineCapacity := Length(FHduKeywords);
  FDataOffset := Int64(Length(FHduKeywords)) * Int64(cSizeLine);
  FLineBuilder := TLineBuilder.Create(Self);
end;

procedure TFitsHeader.SetLines(Index: Integer; Value: string);
begin
  LineWrite(Index, 1, Value);
end;

procedure TFitsHeader.SetLinesKeyword(Index: Integer; Value: string);
var
  Buffer: TStreamBuffer;
begin
  // The index must be in the correct range
  if (Index < 0) or (Index >= FLineCount - 1) then
    raise EFitsHeaderException.CreateFmt(eIndexOfBound, [Index], ERROR_SETLINESKEYWORD_INDEX);
  Value := AlignmentStrict(UpperCase(Value), cSizeKeyword);
  // Checks of HduCore
  if FHduCoreAuditing then begin
    if Index = 0 then
      raise EFitsHduCoreException.Create(eCoreAccess, ERROR_SETLINESKEYWORD_CORE_INDEX);
    if KeywordKind(Value) > keyUnknown then
      raise EFitsHduCoreException.CreateFmt(eCoreAccessInput, [Value], ERROR_SETLINESKEYWORD_CORE_KEYWORD);
    if KeywordKind(FHduKeywords[Index]) > keyUnknown then
      raise EFitsHduCoreException.CreateFmt(eCoreAccessInput, [FHduKeywords[Index]], ERROR_SETLINESKEYWORD_CORE_KEYWORD);
  end;
  try
    // Write line and HduKeywords
    SetLength(Buffer, cSizeKeyword);
    CopyTo(Value, 1, cSizeKeyword, Buffer);
    StreamWrite(Index * Int64(cSizeLine), Length(Buffer), Buffer);
    FHduKeywords[Index] := Value;
  finally
    Buffer := nil;
  end;
end;

{ TFitsFrame }

procedure TFitsFrame.CheckCore(const AHduCore: THduCore);
begin
  inherited;
  if (AHduCore.NAxis <> 2) // image
     and (AHduCore.NAxis <> 1) // Spectre
  then raise EFitsHduCoreException.Create(eCoreTwoInvalid, ERROR_CORE_TWO_INVALID);
end;

procedure TFitsFrame.CheckStreamSize;
begin
  if StreamSize < (StreamSizeHead + StreamSizeData) then
    raise EFitsFrameException.Create(eStreamInvalidSize, ERROR_STREAM_TWO_LOW_SIZE);
end;

procedure TFitsFrame.CheckIDataAccess(Data: Pointer; const Rgn: TRgn);
var
  Dat: TA08u2;
  Ld, Lr: Integer;
begin
  if FHduCore.BitPix = biUnknown then
    raise EFitsFrameException.Create(eBitPixUnknown, ERRROR_DATAACCESS_BITPIX_UNKNOWN);
  if FDataRep = repUnknown then
    raise EFitsFrameException.Create(eDataRepUnknown, ERRROR_DATAACCESS_REP_UNKNOWN);
  if not (Assigned(FProcRead) and Assigned(FProcWrite)) then
    raise EFitsFrameException.CreateFmt(eBitPixSupport, [BitPixToInt(DataBitPix)], ERRROR_DATAACCESS_PROC_NIL);
  if (Data = nil) then
    raise EFitsFrameException.Create(eDataUnsigned, ERRROR_DATAACCESS_DATA_NIL);
  Dat := TA08u2(Data);
  try
    Ld := Length(Dat);
    Lr := Rgn.ColsCount;
    if Ld < Lr then
      raise EFitsFrameException.CreateFmt(eDataColsCount, [Ld, Lr], ERRROR_DATAACCESS_DATA_COLSCOUNT);
    Ld := Length(Dat[0]);
    Lr := Rgn.RowsCount;
    if Ld < Lr then
      raise EFitsFrameException.CreateFmt(eDataRowsCount, [Ld, Lr], ERRROR_DATAACCESS_DATA_ROWSCOUNT);
  finally
    Dat := nil;
  end;
end;

procedure TFitsFrame.CheckIDataAccess(X, Y: Integer);
begin
  if FHduCore.BitPix = biUnknown then
    raise EFitsFrameException.Create(eBitPixUnknown, ERRROR_DATAACCESS_BITPIX_UNKNOWN);
  if FDataRep = repUnknown then
    raise EFitsFrameException.Create(eDataRepUnknown, ERRROR_DATAACCESS_REP_UNKNOWN);
  if not (Assigned(FProcRead) and Assigned(FProcWrite)) then
    raise EFitsFrameException.CreateFmt(eBitPixSupport, [BitPixToInt(DataBitPix)], ERRROR_DATAACCESS_PROC_NIL);
end;

constructor TFitsFrame.CreateJoin(AStream: TStream);
begin
  inherited;
  CheckStreamSize;
  SetDataRepDefault;
end;

constructor TFitsFrame.CreateMade(AStream: TStream; const AHduCore: THduCore);
var
  ACore: THduCore;
begin
  ACore := AHduCore;
  try
    inherited CreateMade(AStream, ACore);
    SetDataRepDefault;
  finally
    ACore.NAxisn := nil;
  end;
end;

procedure TFitsFrame.DataPrepare(out Data: Pointer; const Rgn: TRgn);
begin
  if FDataRep = repUnknown then
    raise EFitsFrameException.Create(eDataRepUnknown, ERRROR_DATAACCESS_REP_UNKNOWN);
  RgnAllocMem(Rgn, FDataRep, Data);
end;

procedure TFitsFrame.DataPrepare(out Data: Pointer);
begin
end;

procedure TFitsFrame.DataRead(Data: Pointer);
begin
end;

procedure TFitsFrame.DataRead(Data: Pointer; const Rgn: TRgn);
begin
  CheckIDataAccess(Data, Rgn);
  FProcRead(Data, GetDataHandle(Rgn));
end;

procedure TFitsFrame.DataWrite(Data: Pointer);
begin
end;

procedure TFitsFrame.DataWrite(Data: Pointer; const Rgn: TRgn);
begin
  CheckIDataAccess(Data, Rgn);
  FProcWrite(Data, GetDataHandle(Rgn));
end;

function TFitsFrame.GetDataBitPix: TBitPix;
begin
  Result := FHduCore.BitPix;
end;

function TFitsFrame.GetDataHandle(const Rgn: TRgn): TDataHandle;
begin
  Result.ReqRgn := Rgn;
  {$IFDEF FPC}
  Result.Buffer.Allocate := @AllocateBuffer;
  Result.Buffer.Release := @ReleaseBuffer;
  {$ELSE}
  Result.Buffer.Allocate := AllocateBuffer;
  Result.Buffer.Release := ReleaseBuffer;
  {$ENDIF}
  Result.Stream := FStream;
  Result.StreamOffset := FDataOffset;
  Result.BitPix := FHduCore.BitPix;
  Result.NAxis1 := FHduCore.NAxisn[0];
  Result.NAxis2 := FHduCore.NAxisn[1];
  Result.BScale := FHduCore.BScale;
  Result.BZero := FHduCore.BZero;
end;

function TFitsFrame.GetDataPixels(X, Y: Integer): Extended;
var
  Size: Integer;
  Offset: Int64;
  ler: Boolean;
  v64f: T64f;
  v32f: T32f;
  v08u: T08u;
  v16c: T16c;
  v32c: T32c;
  v64c: T64c;
begin
  CheckIDataAccess(X, Y);
  Size := BitPixByteSize(FHduCore.BitPix);
  Offset := FDataOffset + (Int64(FHduCore.NAxisn[0]) * Y + X) * Size;
  FStream.Seek(Offset, soBeginning);
  ler := SysOrderByte = sobLe;
  with FHduCore do
  case BitPix of
    bi64f: begin
        v64f := 0; // Init variables for FPC...
        FStream.Read(v64f, Size);
        if ler then Result := Swap64ff(v64f) else Result := v64f;
        Result := Result * BScale + BZero;
      end;
    bi32f: begin
        v32f := 0;
        FStream.Read(v32f, Size);
        if ler then Result := Swap32ff(v32f) else Result := v32f;
        Result := Result * BScale + BZero;
      end;
    bi08u: begin
        v08u := 0;
        FStream.Read(v08u, Size);
        Result := v08u * BScale + BZero;
      end;
    bi16c: begin
        v16c := 0;
        FStream.Read(v16c, Size);
        if ler then Result := Swap16cc(v16c) else Result := v16c;
        Result := Result * BScale + BZero;
      end;
    bi32c: begin
        v32c := 0;
        FStream.Read(v32c, Size);
        if ler then Result := Swap32cc(v32c) else Result := v32c;
        Result := Result * BScale + BZero;
      end;
    bi64c: begin
        v64c := 0;
        FStream.Read(v64c, Size);
        if ler then Result := Swap64cc(v64c) else Result := v64c;
        Result := Result * BScale + BZero;
      end;
    else
      Result := 0.0;
  end;
end;

procedure TFitsFrame.Init;
begin
  inherited;
  FDataRep := repUnknown;
  FProcRead := nil;
  FProcWrite := nil;
end;

procedure TFitsFrame.SetDataPixels(X, Y: Integer; const Value: Extended);
var
  Size: Integer;
  Offset: Int64;
  ler: Boolean;
  v64f: T64f;
  v32f: T32f;
  v08u: T08u;
  v16c: T16c;
  v32c: T32c;
  v64c: T64c;
begin
  CheckIDataAccess(X, Y);
  Size := BitPixByteSize(FHduCore.BitPix);
  Offset := FDataOffset + (Int64(FHduCore.NAxisn[0]) * Y + X) * Size;
  FStream.Seek(Offset, soBeginning);
  ler := SysOrderByte = sobLe;
  with FHduCore do
  case BitPix of
    bi64f: begin
        v64f := (Value - BZero) / BScale;
        if ler then v64f := Swap64ff(v64f);
        FStream.Write(v64f, Size);
      end;
    bi32f: begin
        v32f := (Value - BZero) / BScale;
        if ler then v32f := Swap32ff(v32f);
        FStream.Write(v32f, Size);
      end;
    bi08u: begin
        v08u := Round((Value - BZero) / BScale);
        FStream.Write(v08u, Size);
      end;
    bi16c: begin
        v16c := Round((Value - BZero) / BScale);
        if ler then v16c := Swap16cc(v16c);
        FStream.Write(v16c, Size);
      end;
    bi32c: begin
        v32c := Round((Value - BZero) / BScale);
        if ler then v32c := Swap32cc(v32c);
        FStream.Write(v32c, Size);
      end;
    bi64c: begin
        v64c := Round((Value - BZero) / BScale);
        if ler then v64c := Swap64cc(v64c);
        FStream.Write(v64c, Size);
      end;
  end;
end;

procedure TFitsFrame.SetDataRep(Value: TRep);
begin
  if Value <> FDataRep then begin
    FDataRep := Value;
    with FHduCore do begin
      DeLaFitsDataRead.GetProc(BitPix, BScale, BZero, FDataRep, FProcRead);
      DeLaFitsDataWrite.GetProc(BitPix, BScale, BZero, FDataRep, FProcWrite);
    end;
  end;
end;

procedure TFitsFrame.SetDataRepDefault;
var
  Value: TRep;
begin
  with FHduCore do
  case BitPix of
     bi64f: Value := rep64f;
     bi32f: Value := rep32f;
     bi08u: begin
         if (BScale = 1.0) and (BZero = 0.0) then
           Value := rep08u
         else if (BScale = 1.0) and (BZero = cBZero08c) then
           Value := rep08c
         else if (Frac(BScale) <> 0.0) or (Frac(BZero) <> 0.0) then
           Value := rep32f
         else
           Value := rep64c;
       end;
     bi16c: begin
         if (BScale = 1.0) and (BZero = 0.0) then
           Value := rep16c
         else if (BScale = 1.0) and (BZero = cBZero16u) then
           Value := rep16u
         else if (Frac(BScale) <> 0.0) or (Frac(BZero) <> 0.0) then
           Value := rep32f
         else
           Value := rep64c;
       end;
     bi32c: begin
         if (BScale = 1.0) and (BZero = 0.0) then
           Value := rep32c
         else if (BScale = 1.0) and (BZero = cBZero32u) then
           Value := rep32u
         else if (Frac(BScale) <> 0.0) or (Frac(BZero) <> 0.0) then
           Value := rep64f
         else
           Value := rep64c;
       end;
     bi64c: begin
         if (BScale = 1.0) and (BZero = 0.0) then
           Value := rep64c
         else if (Frac(BScale) <> 0.0) or (Frac(BZero) <> 0.0) then
           Value := rep64f
         else
           Value := rep64c;
       end;
   else { biUnknown }
     Value := repUnknown;
  end;
  DataRep := Value;
end;

{ TFitsFileHeader }

constructor TFitsFileHeader.CreateJoin(const AFileName: string; AFileMode: Word);
var
  F: TFileStream;
begin
  if not FileExists(AFileName) then
    raise EFitsException.CreateFmt(eFileNotFound, [AFileName], ERROR_FILE_NOT_FOUND);
  F := TFileStream.Create(AFileName, AFileMode);
  try
    inherited CreateJoin(F);
  except
    F.Free;
    raise;
  end;
end;

constructor TFitsFileHeader.CreateMade(const AFileName: string; const AHduCore: THduCore);
var
  F: TFileStream;
begin
  if not FileExists(AFileName) then begin
    F := TFileStream.Create(AFileName, cFileCreate);
    F.Free;
  end;
  F := TFileStream.Create(AFileName, cFileReadWrite);
  try
    inherited CreateMade(F, AHduCore);
  except
    F.Free;
    raise;
  end;
end;

destructor TFitsFileHeader.Destroy;
begin
  if Assigned(FStream) then
    FreeAndNil(FStream);   
  inherited;
end;

function TFitsFileHeader.GetFileStream: TFileStream;
begin
  Result := FStream as TFileStream; 
end;

{ TFitsFileFrame }

constructor TFitsFileFrame.CreateJoin(const AFileName: string; AFileMode: Word);
var
  F: TFileStream;
begin
  if not FileExists(AFileName) then
    raise EFitsException.CreateFmt(eFileNotFound, [AFileName], ERROR_FILE_NOT_FOUND);
  F := TFileStream.Create(AFileName, AFileMode);
  try
    inherited CreateJoin(F);
  except
    F.Free;
    raise;
  end;
end;

constructor TFitsFileFrame.CreateMade(const AFileName: string; const AHduCore: THduCore);
var
  F: TFileStream;
begin
  if not FileExists(AFileName) then begin
    F := TFileStream.Create(AFileName, cFileCreate);
    F.Free;
  end;
  F := TFileStream.Create(AFileName, cFileReadWrite);
  try
    inherited CreateMade(F, AHduCore);
  except
    F.Free;
    raise;
  end;
end;

destructor TFitsFileFrame.Destroy;
begin
  if Assigned(FStream) then
    FreeAndNil(FStream);   
  inherited;
end;

function TFitsFileFrame.GetFileStream: TFileStream;
begin
  Result := FStream as TFileStream; 
end;

end.

