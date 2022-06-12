{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{    Types, constants, Fits dictionary of keywords     }
{                 and simple functions                 }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsCommon;

interface

uses
  SysUtils, Types, Classes;

const

  cDeLaFits = 'DeLaFits';

  { File access mode }

  cFileCreate = fmCreate;
  cFileRead = fmOpenRead or fmShareDenyNone;
  cFileReadWrite = fmOpenReadWrite or fmShareDenyNone;

  { Fits Standard. Header block A 2880-byte FITS block containing a sequence of
    thirty-six 80-character keyword records }

  cSizeBlock = 2880;

  cSizeLine = 80;
  cCountLinesInBlock = cSizeBlock div cSizeLine; // 36
  cSizeKeyword = 08;

  cChrValueIndicator: Char = '=';
  cChrNoteIndicator: Char = '/';  // $2F
  cChrBlank: Char = ' ';          // $20
  cChrQuote: Char = '''';         // $27

  cWidthLineValue = 20;
  cWidthLineValueQuote = 08;

  { Fits Standard. A sequence of data values. This sequence corresponds to the
    elements in a rectilinear, n-dimension matrix (1 <= n <= 999, or n = 0 in the
    case of a null array) }

  cMaxNaxis = 999;

const

  { Fits Standard. Basic & other commonly used keywords:
    http://heasarc.gsfc.nasa.gov/docs/fcg/standard_dict.html
    http://heasarc.gsfc.nasa.gov/docs/fcg/common_dict.html }

  cSIMPLE   = 'SIMPLE';
  cBITPIX   = 'BITPIX';
  cNAXIS    = 'NAXIS';
  cBSCALE   = 'BSCALE';
  cBZERO    = 'BZERO';
  cXTENSION = 'XTENSION';

  cEND      = 'END';

  cNAXIS1   = 'NAXIS1';
  cNAXIS2   = 'NAXIS2';

  cAUTHOR   = 'AUTHOR';
  cBLANK    = '';
  cCOMMENT  = 'COMMENT';
  cDATAMAX  = 'DATAMAX';  // Double
  cDATAMIN  = 'DATAMIN';  // Double
  cDATE     = 'DATE';     // String: 'yyyy-mm-dd' or 'yyyy-mm-ddTHH:MM:SS[.sss]'
  cDATE_OBS = 'DATE-OBS';
  cEPOCH    = 'EPOCH';
  cEQUINOX  = 'EQUINOX';  // Double: equinox of celestial coordinate system
  cHISTORY  = 'HISTORY';
  cINSTRUME = 'INSTRUME';
  cOBJECT   = 'OBJECT';
  cOBSERVER = 'OBSERVER';
  cORIGIN   = 'ORIGIN';
  cTELESCOP = 'TELESCOP';

  cAPERTURE = 'APERTURE';
  cCREATOR  = 'CREATOR';  // String: name of software that created the file
  cDATE_END = 'DATE-END'; // String: end date of observation
  cDEC      = 'DEC';      // String or Double, 'sdd(.d)' or 'sdd:mm:ss(.sss)'
  cELAPTIME = 'ELAPTIME'; // Double: elapsed time of observation, number of seconds
  cEXPOSURE = 'EXPOSURE'; // Double: excerpt from the observations in units of seconds (exposure). Exact, syn. EXPTIME
  cEXPTIME  = 'EXPTIME';  // Double: exposure time
  cFILTER   = 'FILTER';
  cLATITUDE = 'LATITUDE'; // Double: geographical latitude observations
  cLIVETIME = 'LIVETIME'; // Double: the exposure time after Deadtime correction
  cOBJNAME  = 'OBJNAME';  // String: IUA name of the monitored object
  cOBS_ID   = 'OBS_ID';   // String: unique identifier for of observation
  cORIENTAT = 'ORIENTAT'; // Double: position angle of the image axis Y (deg. E of N)
  cRA       = 'RA';       // String or Double: 'ddd(.d)' or 'ddd:mm:ss(.s)' or 'hh(.h)' or 'hh:mm:ss(.sss)'
  cTIME_OBS = 'TIME-OBS'; // String: start time of observation

  cVAL1     = 'CRVAL1';   // valeur de la longueur d'onde du premier pixel
  cDELTA1   = 'CDELT1';   // incrément de longueur d'onde
  cTYPE1    = 'CTYPE1';   // type première colonne wavelength ou linear
  cUNIT1    = 'CUNIT1';   // unité nm ou Angstrom
  cXUNITS   = 'XUNITS';   // unité nm ou Angstrom
  cYUNITS   = 'YUNITS';   // unité nm ou Angstrom
  cMinWave  = 'MINWAVE';  // origine spectre
  cMaxWave  = 'MAXWAVE';  // fin spectre


type

  TSysOrderByte = (sobBe, sobLe);

type

  { Numbers: f ~ floating-point, u ~ unsigned binary integer, c ~ two's complement binary integer }

  P08u = ^T08u;
  P08c = ^T08c;
  P16u = ^T16u;
  P16c = ^T16c;
  P32f = ^T32f;
  P32u = ^T32u;
  P32c = ^T32c;
  P64f = ^T64f;
  P64c = ^T64c;
  P80f = ^T80f;

  T08u = Byte;
  T08c = ShortInt;
  T16u = Word;
  T16c = SmallInt;
  T32f = Single;
  T32u = LongWord;
  T32c = LongInt;
  T64f = Double;
  T64c = Int64;
  T80f = Extended;

  { Arrays }

  PA08u1 = ^TA08u1;

  TA08u1 = array of T08u;
  TA08c1 = array of T08c;
  TA16u1 = array of T16u;
  TA16c1 = array of T16c;
  TA32f1 = array of T32f;
  TA32u1 = array of T32u;
  TA32c1 = array of T32c;
  TA64f1 = array of T64f;
  TA64c1 = array of T64c;
  TA80f1 = array of T80f;

  TA08u2 = array of array of T08u;
  TA08c2 = array of array of T08c;
  TA16u2 = array of array of T16u;
  TA16c2 = array of array of T16c;
  TA32f2 = array of array of T32f;
  TA32u2 = array of array of T32u;
  TA32c2 = array of array of T32c;
  TA64f2 = array of array of T64f;
  TA64c2 = array of array of T64c;
  TA80f2 = array of array of T80f;

  { Type of data elements: representation of physical data }

  TRep = (repUnknown, rep80f, rep64f, rep32f, rep08c, rep08u, rep16c, rep16u,
    rep32c, rep32u, rep64c);

type

  { Fits Standard. BITPIX:
    -64 ~ IEEE double precision floating-point
    -32 ~ IEEE single precision floating-point
    +08 ~ Character or unsigned binary integer
    +16 ~ 16-bit two's complement binary integer
    +32 ~ 32-bit two's complement binary integer
    +64 ~ 64-bit two's complement binary integer }

  TBitPix = (biUnknown, bi64f, bi32f, bi08u, bi16c, bi32c, bi64c);

  function BitPixToInt(Value: TBitPix): Integer;
  function IntToBitPix(Value: Integer): TBitPix;

  // Returns size BitPix in bytes
  function BitPixByteSize(Value: TBitPix): Byte;

type

  { Important elements header & data unit }

  THduCore = record
    Simple: Boolean;
    isSpectre: boolean;
    BitPix: TBitPix;
    NAxis: Word;
    NAxisn: TA16u1;
    BScale: Double;
    BZero: Double;
    Lambda0 : double;
    DeltaLambda : double;
    uniteX,uniteY : string;
  end;

  // Just a wrapper, no checks
  function ToHduCore : THduCore;

const
  cBZero08c = -$80;
  cBZero16u = +$8000;
  cBZero32u = +$80000000;

const
  { Constant string values parsing rules }

  cCast = 0;

  cCastChars     = cCast + 1;  // ~ string as is, one line (len ~ 80)
  cCastCharsLong = cCast + 2;  // ~ string as is long
  cCastString    = cCast + 3;  // ~ quoted/unquoted string
  cCastBoolean   = cCast + 4;  // ~ Boolean
  cCastInteger   = cCast + 5;  // ~ Int64
  cCastFloat     = cCast + 6;  // ~ Extended
  cCastRa        = cCast + 7;  // ~ Extended
  cCastDe        = cCast + 8;  // ~ Extended
  cCastDateTime  = cCast + 9;  // ~ TDateTime
  cCastDate      = cCast + 10; // ~ TDateTime, only Date
  cCastTime      = cCast + 11; // ~ TDateTime, only Time

type

  TSliceDateTime = cCastDateTime .. cCastTime; // DateTime, only Date, only Time

  { Header line element. Rec.Value contains only one! value: string, Boolean,
    Int64, Extended or TDateTime. Simple analog of Variant type }

  TLineItem = record
    Keyword: string;
    ValueIndicate: Boolean;
    Value: record
      Str: string;
      Bol: Boolean;
      Int: Int64;
      Ext: Extended;
      Dtm: TDateTime;
    end;
    NoteIndicate: Boolean;
    Note: string;
  end;

  // Just a wrapper, no checks
  function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: string;
                      NoteIndicate: Boolean; const Note: string): TLineItem; overload;
  function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Boolean;
                      NoteIndicate: Boolean; const Note: string): TLineItem; overload;
  function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Int64;
                      NoteIndicate: Boolean; const Note: string): TLineItem; overload;
  function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Extended;
                      NoteIndicate: Boolean; const Note: string): TLineItem; overload;
  function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: TDateTime;
                      NoteIndicate: Boolean; const Note: string): TLineItem; overload;
type

  { Region: rectangular patch }

  PRgn = ^TRgn;
  TRgn = record
    X1, Y1: Integer;
    case Integer of
      0: (ColsCount, RowsCount: Integer);
      1: (Width, Height: Integer);
  end;

  // Just a wrapper, no checks
  function ToRgnCoRo(X1, Y1: Integer; ColsCount, RowsCount: Integer): TRgn;
  function ToRgnWiHe(X1, Y1: Integer; Width, Height: Integer): TRgn;

  function RgnIsIncluded(const R, Rsub: TRgn): Boolean; overload;
  function RgnIsIncluded(const R: TRgn; const Xsub, Ysub: Integer): Boolean; overload;

  procedure RgnAllocMem(const Rgn: TRgn; Rep: TRep; out Data: Pointer); overload;
  procedure RgnAllocMem(const Rgn: TRgn; out Data: TA08u2); overload;

var

  { Size buffer for operation with stream. Type (as var) is specified explicitly
    for the possibility of changes only! in testing }

  cSizeStreamBuffer: Integer = 1024 * 64;

type

  { The type of data in the temporary buffer when dealing with stream, possible
    need packed }

  TStreamBuffer = TA08u1;

  // Methods for allocation/release buffer, see type TDataHandle
  TManagerDataBuffer = record
    Allocate: procedure (var Buffer: Pointer; SizeInBytes: Integer) of object;
    Release: procedure (var Buffer: Pointer) of object;
  end;

  { A pointer to the description of the requested data }

  TDataHandle = record
    ReqRgn: TRgn;               // requested region
    Buffer: TManagerDataBuffer; // for allocation/release local buffer
    Stream: TStream;
    StreamOffset: Int64;        // data offset
    BitPix: TBitPix;
    NAxis1: Word;
    NAxis2: Word;
    BScale: Double;
    BZero: Double;
  end;

  TProcDataAccess = procedure (Data: Pointer; const Handle: TDataHandle);

type

  TFmtShortDate = (yymmdd, ddmmyy); // Fits format short date ~ yymmdd

  TCoordNotate = (cmDecimal, cmSexagesimal); // G.(g) or GG MM SS.(s)
  TCoordMeasur = (cmDegree, cmHour);         // DDD:MM:SS.(s) or HH:MM:SS.(s)

  { Format equatorial coordinate system (Ra, De). Fits standart:
    Ra in [cmHour, cmSexagesimal], De in [cmDegree, cmSexagesimal]
    |------|------------------------|----------------------------|
    |      |  Ra                    | De                         |
    |------|------------------------|----------------------------|
    | Fits | HH:MM:SS.(s)  | 0..24  | +/-DD:MM:SS.(s) | -90..+90 |
    |  ~   | HH.(h)        | 0..24  | +/-DD.(d)       | -90..+90 |
    |  ~   | DDD:MM:SS.(s) | 0..360 | +/-DD:MM:SS.(s) | -90..+90 |
    |  ~   | DDD.(d)       | 0..360 | +/-DD.(d)       | -90..+90 |
    |------------------------------------------------------------| }

// Formatting options header lines: additional parameters when parsing the header lines
 
  PFormatLine = ^TFormatLine;
  TFormatLine = record
    vaStr: record
      wWidth: ShortInt;             // default = -cWidthLineValue ~ <text >
      wWidthQuoteInside: ShortInt;  // default = -cWidthLineValueQuote ~ 'text '
    end;
    vaBol: record
      wWidth: ShortInt;             // default = cWidthLineValue ~ < text>
    end;
    vaInt: record
      wWidth: ShortInt;             // default = cWidthLineValue ~ < text>
      wSign: Boolean;               // default = False
      wFmt: string;                 // see Format function; default = '%d'
    end;
    vaFloat: record
      wWidth: ShortInt;             // default = cWidthLineValue ~ < text>
      wSign: Boolean;               // default = False
      wFmt: string;                 // see Format function; default = '%g'
    end;
    vaDateTime: record
      rFmtShortDate: TFmtShortDate; // used as a prompt when reading short date format; default = yymmdd
      wWidth: ShortInt;             // default = -cWidthLineValue ~ <text >
      wWidthQuoteInside: ShortInt;  // default = -cWidthLineValueQuote ~ <text >
    end;
    vaCoord: record
      rFmtMeasurRa: TCoordMeasur;   // used as a prompt when reading Ra (Equatorial coordinate system); default = cmHour
      wWidth: ShortInt;             // default = -cWidthLineValue ~ <text >, used Abs(cWidthLineValue) for cmDecimal Notate
      wWidthQuoteInside: ShortInt;  // default = -cWidthLineValueQuote ~ <text >
      wPrecRa: Word;                // in [degree], '%.(wPrecRa)f'; default = 4 ~ hh:mm:ss.ss, ie (0.1")
      wPrecDe: Word;                // in [degree], '%.(wPrecDe)f'; default = 4 ~ dd:mm:ss.s, ie (0.1")
      wFmtMeasurRa: TCoordMeasur;   // default = cmHour
      wFmtNotate: TCoordNotate;     // default = cmSexagesimal
    end;  
  end;

  { ~ TFitsGeom }

type

  TMatrix = array [1 .. 3, 1 .. 3] of Double;

  // Line density: lx, ly > 0!
  TLineDensity = record
    lx, ly: Double;
  end;

  TDesignPoint = (xy00, xyLT, xyRT, xyRB, xyLB, xyCC);
  TDesignShift = (xyLTat00, xyRTat00, xyRBat00, xyLBat00, xyCCat00);

  TPix = Types.TPoint; // ~ record X, Y: Integer; end;

  TPnt = record
    X, Y: Double;
  end;

  function ToPnt(const X, Y: Double): TPnt;
  function ToPix(const X, Y: Integer): TPix;

type
  TSpectre = array of double;
  TPixels = TA08u2;
  
const
  { The base class of exceptions and error codes }
  ERROR_SYS     = 1;
  ERROR_FITS    = 1000;
  ERROR_NULL    = 1001;
  ERROR_UNKNOWN = 1002;

type
  EFitsException = class(Exception)
  private
    FCode: Integer;
    function FmtMsg(const Msg: string): string;
  public
    constructor Create(const Msg: string; ACode: Integer = ERROR_NULL);
    constructor CreateFmt(const Msg: string; const Args: array of const; ACode: Integer = ERROR_NULL);
    property Code: Integer read FCode;
  end;

const
  ERROR_HDUCORE_CONVERT = 1003;

implementation

function BitPixToInt(Value: TBitPix): Integer;
begin
  case Value of
    bi64f: Result := -64;
    bi32f: Result := -32;
    bi08u: Result := 08;
    bi16c: Result := 16;
    bi32c: Result := 32;
    bi64c: Result := 64;
    else   Result := 00;
  end;
end;

function IntToBitPix(Value: Integer): TBitPix;
begin
  case Value of
    -64: Result := bi64f;
    -32: Result := bi32f;
     08: Result := bi08u;
     16: Result := bi16c;
     32: Result := bi32c;
     64: Result := bi64c;
    else Result := biUnknown;
  end;
end;

function BitPixByteSize(Value: TBitPix): Byte;
begin
  case Value of
    bi64f: Result := 8;
    bi32f: Result := 4;
    bi08u: Result := 1;
    bi16c: Result := 2;
    bi32c: Result := 4;
    bi64c: Result := 8;
    else   Result := 0;
  end;
end;

function ToHduCore: THduCore;
begin
  Result.Simple := false;
  Result.isSpectre := false;
  Result.BitPix := biUnknown;
  Result.NAxis := 0;
  SetLength(Result.NAxisn, 0);
  Result.BScale := 1.0;
  Result.BZero := 0.0;
  Result.lambda0 := 0;
  Result.DeltaLambda := 1;
  Result.uniteX := '';
  Result.uniteY := '';
end;

function EmptyLineItem(const Keyword: string; ValueIndicate: Boolean; NoteIndicate: Boolean; const Note: string): TLineItem;
begin
  Result.Keyword := Keyword;
  Result.ValueIndicate := ValueIndicate;
  with Result.Value do begin
    Str := '';
    Bol := False;
    Int := 0;
    Ext := 0.0;
    Dtm := Now;
  end;
  Result.NoteIndicate := NoteIndicate;
  Result.Note := Note;
end;

function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: string;
  NoteIndicate: Boolean; const Note: string): TLineItem; overload;
begin
  Result := EmptyLineItem(Keyword, ValueIndicate, NoteIndicate, Note);
  Result.Value.Str := Value;
end;

function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Boolean;
  NoteIndicate: Boolean; const Note: string): TLineItem; overload;
begin
  Result := EmptyLineItem(Keyword, ValueIndicate, NoteIndicate, Note);
  Result.Value.Bol := Value;
end;

function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Int64;
  NoteIndicate: Boolean; const Note: string): TLineItem; overload;
begin
  Result := EmptyLineItem(Keyword, ValueIndicate, NoteIndicate, Note);
  Result.Value.Int := Value;
end;

function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: Extended;
  NoteIndicate: Boolean; const Note: string): TLineItem; overload;
begin
  Result := EmptyLineItem(Keyword, ValueIndicate, NoteIndicate, Note);
  Result.Value.Ext := Value;
end;

function ToLineItem(const Keyword: string; ValueIndicate: Boolean; Value: TDateTime;
  NoteIndicate: Boolean; const Note: string): TLineItem; overload;
begin
  Result := EmptyLineItem(Keyword, ValueIndicate, NoteIndicate, Note);
  Result.Value.Dtm := Value;
end;

function ToRgnCoRo(X1, Y1: Integer; ColsCount, RowsCount: Integer): TRgn;
begin
  Result.X1 := X1;
  Result.Y1 := Y1;
  Result.ColsCount := ColsCount;
  Result.RowsCount := RowsCount;
end;

function ToRgnWiHe(X1, Y1: Integer; Width, Height: Integer): TRgn;
begin
  Result.X1 := X1;
  Result.Y1 := Y1;
  Result.Width := Width;
  Result.Height := Height;
end;

function RgnIsIncluded(const R, Rsub: TRgn): Boolean;
begin
  Result := (R.X1 <= Rsub.X1) and
            (R.Y1 <= Rsub.Y1) and
            ((R.X1 + R.ColsCount) >= (Rsub.X1 + Rsub.ColsCount)) and
            ((R.Y1 + R.RowsCount) >= (Rsub.Y1 + Rsub.RowsCount));
end;

function RgnIsIncluded(const R: TRgn; const Xsub, Ysub: Integer): Boolean; overload;
begin
  Result := (R.X1 <= Xsub) and
            (R.Y1 <= Ysub) and
            ((R.X1 + R.ColsCount) > Xsub) and
            ((R.Y1 + R.RowsCount) > Ysub);
end;

procedure RgnAllocMem(const Rgn: TRgn; Rep: TRep; out Data: Pointer);
var
  Cols, Rows: Integer;
begin
  Cols := Rgn.ColsCount;
  Rows := Rgn.RowsCount;
  case Rep of
    rep80f: SetLength(TA80f2(Data), Cols, Rows);
    rep64f: SetLength(TA64f2(Data), Cols, Rows);
    rep32f: SetLength(TA32f2(Data), Cols, Rows);
    rep08c: SetLength(TA08c2(Data), Cols, Rows);
    rep08u: SetLength(TA08u2(Data), Cols, Rows);
    rep16c: SetLength(TA16c2(Data), Cols, Rows);
    rep16u: SetLength(TA16u2(Data), Cols, Rows);
    rep32c: SetLength(TA32c2(Data), Cols, Rows);
    rep32u: SetLength(TA32u2(Data), Cols, Rows);
    rep64c: SetLength(TA64c2(Data), Cols, Rows);
    else {repUnknown}
      Data := nil;
  end;
end;

procedure RgnAllocMem(const Rgn: TRgn; out Data: TA08u2); overload;
begin
  SetLength(Data, Rgn.ColsCount, Rgn.RowsCount);
end;

function ToPnt(const X, Y: Double): TPnt;
begin
  Result.X := X;
  Result.Y := Y;
end;

function ToPix(const X, Y: Integer): TPix;
begin
  Result.X := X;
  Result.Y := Y;
end;

{ EFitsException }

constructor EFitsException.Create(const Msg: string; ACode: Integer = ERROR_NULL);
begin
  FCode := ACode;
  inherited Create(FmtMsg(Msg));
end;

constructor EFitsException.CreateFmt(const Msg: string; const Args: array of const; ACode: Integer = ERROR_NULL);
begin
  FCode := ACode;
  inherited CreateFmt(FmtMsg(Msg), Args);
end;

function EFitsException.FmtMsg(const Msg: string): string;
begin
  Result := cDeLaFits + '.' + ClassName + #13 + 
            Msg + #13 + 
            Format('Code %.4d', [FCode]);
end;

end.
