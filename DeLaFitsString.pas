{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{                                                      }
{         Functions to format the header lines         }
{                                                      }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsString;

interface

uses
  SysUtils, {$IFNDEF FPC} Windows, {$ENDIF} DateUtils, DeLaFitsCommon;

const

  ERROR_STRING          = 2000;
  ERROR_STRING_LENGTH   = 2001;
  ERROR_STRING_BOOLEAN  = 2002;
  ERROR_STRING_BITPIX   = 2003;
  ERROR_STRING_INTEGER  = 2004;
  ERROR_STRING_FLOAT    = 2005;
  ERROR_STRING_PARSE    = 2006;
  ERROR_STRING_DATETIME = 2007;
  ERROR_STRING_COORD    = 2008;
  ERROR_STRING_RA_VALUE = 2009;
  ERROR_STRING_DE_VALUE = 2010;

  eStringLength         = 'Invalid string length <%s>';
  eStringConvert        = 'Error converting string <%s> to %s value';
  eStringParse          = 'Parse string to parts in error'#13'Exceeded number of various values'#13'<%s>';
  eStringIncorrectValue = 'Incorrect value <%g> as %s';

type

  EFitsStringException = class(EFitsException);

  // Return blank string in length of Width
  function Blank(Width: Integer): string;

  { Alignment to Width string. Left ~ (Width < 0), Right ~ (Width > 0), example:
    F(<text>,    -5) = <text >
    F(<text>, -4..4) = <text>
    F(<text>,     5) = < text> }
  function Alignment(const S: string; Width: Integer): string;

  { Strictly alignment to Width string, example:
    F(<text>, -5) = <text >
    F(<text>, -4) = <text>
    F(<text>, -3) = <tex>
    ...
    F(<text>,  0) = <>
    ...
    F(<text>,  3) = <tex>
    F(<text>,  4) = <text>
    F(<text>,  5) = < text> }
  function AlignmentStrict(const S: string; Width: Integer): string;

  function PosChar(Ch: Char; const S: string; StartPos: Integer = 1): Integer;

  { Citation string with alignment, example:
    F(<text>,    -5) = <'text '>
    F(<text>, -4..4) = <'text'>
    F(<text>,     5) = <' text'>
    F(<text>,     0) = <'text'>
    F(<t'ext>,    0) = <'t''ext'> }
  function Quoted(const S: string; Width: Integer = 0): string;

  function UnQuoted(const S: string): string;

  { Return value string as is, ie not trimming, used Result.Value.Str;
    Result.Keyword and Result.Note is trimming }
  function LineToItem(const Line: string): TLineItem;

  // Compose value string as is, used Item.Value.Str
  function ItemToLine(const Item: TLineItem): string;

  { Converting string values }

  function StriToBol(const Value: string): Boolean;
  function BolToStri(const Value: Boolean): string;

  function StriToBitPix(const Value: string): TBitPix;
  function BitPixToStri(const Value: TBitPix): string; overload;
  function BitPixToStri(const Value: Integer): string; overload;

  function StriToInt(const Value: string): Int64;
  function IntToStri(const Value: Int64): string; overload;
  function IntToStri(const Value: Int64; Sign: Boolean; const Fmt: string): string; overload;
  // Result = '(Prec)d'
  function IntToStri(const Value: Int64; Sign: Boolean; Prec: Word): string; overload;

  function StriToFloat(const Value: string): Extended;
  function FloatToStri(const Value: Extended): string; overload;
  function FloatToStri(const Value: Extended; Sign: Boolean; const Fmt: string): string; overload;
  // Result = '(PrecInt)d.(PrecFloat)f'
  function FloatToStri(const Value: Extended; Sign: Boolean; PrecInt, PrecFloat: Word): string; overload;

  function GetSliceDateTime(const Value: string): TSliceDateTime;
  // Strictly corresponds to parameter Slice
  function StriToDateTime(const Value: string; Slice: TSliceDateTime; Tip: TFmtShortDate = yymmdd): TDateTime;
  function DateTimeToStri(const Value: TDateTime; Slice: TSliceDateTime): string;

  { Result only in degrees ~ ddd.(d);
    Value ~ hh.(h) or ddd.(d) or HH:MM:SS.(s) or DDD:MM:SS.(s), see Tip }
  function StriToRa(const Value: string; Tip: TCoordMeasur = cmHour): Extended;
  
  { Result ~ any Ra, see Notate & Measure;
    Value only in degrees ~ ddd.(d);
    Accuracy <Prec> is always specified with respect to the measure degree:
    F(180.1234, 4, cmDecimal,     cmDegree) = 180.1234
    F(180.1234, 4, cmDecimal,     cmHour  ) =  12.00823
    F(180.1234, 4, cmSexagesimal, cmDegree) = 180:07:24.2
    F(180.1234, 4, cmSexagesimal, cmHour  ) =  12:00:29.62 }
  function RaToStri(Value: Extended; Prec: Word; Notate: TCoordNotate; Measure: TCoordMeasur): string;

  { Result only in degrees ~ ddd.(d);
    Value ~ dd.(d) or DD:MM:SS.(s) }
  function StriToDe(const Value: string): Extended;
  
  { Result ~ any De, see Notate;
    Value only in degrees ~ dd.(d);
    Accuracy <Prec> is always specified with respect to the measure degree:
    F(45.1234, 4, cmDecimal    ) = +45.1234
    F(45.2096, 4, cmSexagesimal) = +45:12:34.6 }
  function DeToStri(const Value: Extended; Prec: Word; Notate: TCoordNotate): string;

implementation

type

  TDelimDateTime = record
    deDate, deMain, deTime: Char;
  end;

  TCoord = record
    Sgn: (sPlus, sMinus); // ~ '-00:00:00.01'
    GG: Word;             // Hours or degrees
    MM: Word;             // Minutes
    SS: Extended;         // Seconds
  end;

const

  cFitsDelimDateTime: TDelimDateTime = (deDate: '-'; deMain: 'T'; deTime: ':');
  cDelimsDateTime = ' -/\T:.,';
  cMinShortYear = 35; // 1935 <= YEAR < 2035

  cFitsDelimCoord = ':';
  cDelimsCoord = ' :/\';
  cCoordNull = -999.99;

function Blank(Width: Integer): string;
begin
  Result := System.StringOfChar(cChrBlank, Width);
end;

function Alignment(const S: string; Width: Integer): string;
var
  Addon: Integer;
begin
  Result := S;
  Addon := Abs(Width) - Length(Result);
  if Addon > 0 then begin
    if Width > 0 then
      Result := Blank(Addon) + Result
    else if Width < 0 then
      Result := Result + Blank(Addon);
  end;
end;

function AlignmentStrict(const S: string; Width: Integer): string;
begin
  if Abs(Width) >= Length(S) then
    Result := Alignment(S, Width)
  else
    Result := Copy(S, 1, Abs(Width));
end;
  
function PosChar(Ch: Char; const S: string; StartPos: Integer = 1): Integer;
var
  I: Integer;
begin
  Result := 0;
  if StartPos > 0 then
    for I := StartPos to Length(S) do
      if S[I] = Ch then begin
        Result := I;
        Break;
      end;
end;

function Quoted(const S: string; Width: Integer = 0): string;
begin
  Result := StringReplace(S, cChrQuote, (cChrQuote + cChrQuote), [rfReplaceAll]);
  Result := cChrQuote + Alignment(Result, Width) + cChrQuote;
end;

function UnQuoted(const S: string): string;
var
  Len: Integer;
begin
  Result := Trim(S);
  Len := Length(Result);
  if (Len > 1) and (Result[1] = cChrQuote) and (Result[Len] = cChrQuote) then begin
    Result := Copy(Result, 2, Len - 2);
    Result := Trim(Result);
    Result := StringReplace(Result, (cChrQuote + cChrQuote), cChrQuote, [rfReplaceAll]);
  end;
end;

function LineToItem(const Line: string): TLineItem;
  function CopyLine(Index1, Index2: Integer; Triming: Boolean): string;
  begin
    if (Index1 < 1) or (Index2 > cSizeLine) or (Index2 < Index1) then
      Result := ''
    else begin
      Result := Copy(Line, Index1, Index2 - Index1 + 1);
      if Triming then Result := Trim(Result);      
    end;      
  end;

const
  cPosValueIndicator = cSizeKeyword + 1;
  cPosNoteIndicator = cSizeKeyword + cWidthLineValue + 4;
var
  I, J: Integer;
begin
  // Check of length line
  if Length(Line) < cSizeLine then
    raise EFitsStringException.CreateFmt('LineToItemStr - ' + eStringLength, [Line], ERROR_STRING_LENGTH);
  // Init
  with Result do begin
    Keyword := CopyLine(1, cSizeKeyword, True);
    ValueIndicate := (Line[cPosValueIndicator] = cChrValueIndicator);
    Value.Str := '';
    Value.Bol := False;
    Value.Int := 0;
    Value.Ext := 0.0;
    Value.Dtm := Now;
    NoteIndicate := False;
    Note := '';
  end;
  // Parse
  if not Result.ValueIndicate then begin
    Result.NoteIndicate := (Line[cPosNoteIndicator] = cChrNoteIndicator) and ((Line[cPosNoteIndicator - 1] = cChrBlank) or (Line[cPosNoteIndicator + 1] = cChrBlank));
    // Definition of the index Value start
    if Line[cPosValueIndicator] > cChrBlank then
      I := cPosValueIndicator
    else if Line[cPosValueIndicator + 1] > cChrBlank then
      I := cPosValueIndicator + 1
    else
      I := cPosValueIndicator + 2;
    // Copy Value & Note
    if Result.NoteIndicate then begin
      Result.Value.Str := CopyLine(I, cPosNoteIndicator - 1, False);
      Result.Note := CopyLine(cPosNoteIndicator + 1, cSizeLine, True);
    end
    else
      Result.Value.Str := CopyLine(I, cSizeLine, False);
  end
  else begin
    I := cPosValueIndicator + 1;
    while (I <= cSizeLine) and (Line[I] <= cChrBlank) do
      Inc(I);
    if I > cSizeLine then
      I := cSizeLine;
    if (I = cSizeLine) then
      Result.Value.Str := CopyLine(I, cSizeLine, False)
    else if Line[I] = cChrNoteIndicator then
    begin
      Result.Value.Str := '';
      Result.NoteIndicate := True;
      Result.Note := CopyLine(I + 1, cSizeLine, True);
    end
    else if Line[I] = cChrQuote then
    begin
      J := I;
      while True do
      begin
        Inc(J);
        if J = cSizeLine then
        begin
          Result.Value.Str := CopyLine(I, cSizeLine, False);
          Break;
        end
        else if (Line[J] = cChrQuote) then
        begin
          if (Line[J + 1] = cChrQuote) then Inc(J)
          else
          begin
            Result.Value.Str := CopyLine(I, J, False);
            I := J + 1;
            while (I <= cSizeLine) and (Line[I] <> cChrNoteIndicator) do 
              Inc(I);
            if I > cSizeLine then
              I := cSizeLine;
            Result.NoteIndicate := (I < cSizeLine);
            Result.Note := CopyLine(I + 1, cSizeLine, True);
            Break;
          end;
        end;
      end;     
    end
    else
    begin
      J := I + 1;
      while (J <= cSizeLine) and (Line[J] <> cChrNoteIndicator) do
        Inc(J);
      if J > cSizeLine then
        J := cSizeLine;
      if Line[J] = cChrNoteIndicator then
      begin
        Result.Value.Str := CopyLine(I, J - 1, False);
        Result.NoteIndicate := True;
        Result.Note := CopyLine(J + 1, cSizeLine, True);
      end
      else
        Result.Value.Str := CopyLine(I, cSizeLine, False);
    end;  
  end;
end;

function ItemToLine(const Item: TLineItem): string;
begin
  Result := AlignmentStrict(UpperCase(Trim(Item.Keyword)), -cSizeKeyword);
  if Item.ValueIndicate then
    Result := Result + cChrValueIndicator
  else
    Result := Result + cChrBlank;
  Result := Result + cChrBlank;
  Result := Result + Item.Value.Str;
  if Item.NoteIndicate then
    Result := Result + cChrBlank + cChrNoteIndicator + cChrBlank + Item.Note;
  Result := AlignmentStrict(Result, -cSizeLine);
end;

function StriToBol(const Value: string): Boolean;
var
  S: string;
begin
  S := Trim(Value);
  Result := (S = 'T');
  if not Result and (S <> 'F') then
    raise EFitsStringException.CreateFmt(eStringConvert, [S, 'Boolean'], ERROR_STRING_BOOLEAN);
end;

function BolToStri(const Value: Boolean): string;
begin
  if Value then 
    Result := 'T'
  else
    Result := 'F';
end;

function StriToBitPix(const Value: string): TBitPix;
var
  S: string;
  V, Code: Integer;
begin
  S := Trim(Value);
  Val(S, V, Code);
  if Code <> 0 then
    Result := biUnknown
  else
    Result := IntToBitPix(V);
  if Result = biUnknown then
    raise EFitsStringException.CreateFmt(eStringConvert, [S, 'BitPix'], ERROR_STRING_BITPIX);
end;

function BitPixToStri(const Value: TBitPix): string; overload;
begin
  Result := IntToStr(BitPixToInt(Value));
end;

function BitPixToStri(const Value: Integer): string; overload;
begin
  Result := IntToStr(Value);
end;

function StriToInt(const Value: string): Int64;
var
  S: string;
  Code: Integer;
begin
  S := Trim(Value);
  Val(S, Result, Code);
  if Code <> 0 then
    raise EFitsStringException.CreateFmt(eStringConvert, [S, 'Integer'], ERROR_STRING_INTEGER);
end;

function IntToStri(const Value: Int64): string; overload;
begin
  Result := IntToStr(Value);
end;

function IntToStri(const Value: Int64; Sign: Boolean; const Fmt: string): string; overload;
begin
  Result := Format(Fmt, [Value]);
  Result := Trim(Result);
  if Sign and (Value >= 0) then
    Result := '+' + Result;
end;

function IntToStri(const Value: Int64; Sign: Boolean; Prec: Word): string; overload;
begin
  Result := IntToStri(Value, Sign, '%.' + IntToStr(Prec) + 'd');
end;

function StriToFloat(const Value: string): Extended;
var
  S: string;
  Code: Integer;
begin
  S := Trim(Value);
  S := StringReplace(S, ',', '.', []);
  Val(S, Result, Code);
  if Code <> 0 then
    raise EFitsStringException.CreateFmt(eStringConvert, [S, 'Float'], ERROR_STRING_FLOAT);
end;

function GetFormatSettings: TFormatSettings;
begin
  {$IFDEF FPC}
  Result := FormatSettings
  {$ELSE}
//  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, Result);
  result := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  {$ENDIF}
end;

function FloatToStri(const Value: Extended): string; overload;
var
  fs: TFormatSettings;
begin
  fs := GetFormatSettings;
  fs.DecimalSeparator := '.';
  Result := FloatToStr(Value, fs);
end;

function FloatToStri(const Value: Extended; Sign: Boolean; const Fmt: string): string; overload;
var
  fs: TFormatSettings;
begin
  fs := GetFormatSettings;
  fs.DecimalSeparator := '.';
  Result := Format(Fmt, [Value], fs);
  Result := Trim(Result);
  if Sign and (Value >= 0) then
    Result := '+' + Result;
end;

function FloatToStri(const Value: Extended; Sign: Boolean; PrecInt, PrecFloat: Word): string;
var
  Int: Int64;
  Ext: Extended;
  S1, S2: string;
begin
  Int := Trunc(Value);
  Ext := Abs(Frac(Value));
  S1 := IntToStri(Int, Sign, '%.' + IntToStr(PrecInt) + 'd');
  S2 := FloatToStri(Ext, False, '%.' + IntToStr(PrecFloat) + 'f');
  if S2 = '0' then
    S2 := ''
  else {S2 = '0.000'}
    S2 := Copy(S2, 2, Length(S2));
  Result := S1 + S2;
end;

{ Function splits the string <Value> into parts <Parts>, separator is considered
  a symbol of <Delims>. Result - quantity parts found }
function ParseToParts(const Value, Delims: string; out Parts: array of string): Integer;
var
  I, J: Integer;
  Increment: Boolean;
  Ch: Char;
begin
  Result := 0;
  for I := Low(Parts) to High(Parts) do
    Parts[I] := '';
  J := Low(Parts) - 1;
  Increment := False;
  for I := 1 to Length(Value) do begin
    Ch := Value[I];
    if PosChar(Ch, Delims) = 0 then begin
      if not Increment then begin
        Inc(J);
        if J > High(Parts) then
          raise EFitsStringException.CreateFmt(eStringParse, [Value], ERROR_STRING_PARSE);
        Inc(Result);
      end;
      Parts[J] := Parts[J] + Ch;
      Increment := True;
    end
    else
      Increment := False;
  end;
end;

function GetSliceDateTime(const Value: string): TSliceDateTime;
begin
  if Length(Value) > 13 then
    Result := cCastDateTime
  else if PosChar(cFitsDelimDateTime.deTime, Value) > 0 then
    Result := cCastTime
  else
    Result := cCastDate;
end;

function StriToDateTime(const Value: string; Slice: TSliceDateTime; Tip: TFmtShortDate = yymmdd): TDateTime;
  procedure Exception;
  var
    S: string;
  begin
    case Slice of
      cCastDate: S := 'Date';
      cCastTime: S := 'Time';
      else {cCastDateTime:}
        S := 'DateTime'
    end;
    raise EFitsStringException.CreateFmt(eStringConvert, [Value, S], ERROR_STRING_DATETIME);
  end;

  function StrToWord(S: string): Word;
  begin
    Result := Word(StriToInt(S));
  end;

  function StrToMSec(S: string): Word;
  var
    Len: Integer;
  begin
    Len := Length(S);
    case Len of
      0:    Result := 0;
      1..3: Result := Round(StriToFloat('0.' + S) * 1000);
      else begin
          Result := Round(StriToFloat('0.' + Copy(S, 1, 3)) * 1000);
          if StriToInt(S[4]) >= 5 then Result := Result + 1;
        end;
    end;
  end;

  procedure LongYear(var Year: Word);
  begin
    if Year < cMinShortYear then
      Year := 2000 + Year
    else
      Year := 1900 + Year;
  end;

  procedure SwapWord(var V1, V2: Word);
  var
    Tmp: Word;
  begin
    Tmp := V1;
    V1 := V2;
    V2 := Tmp;
  end;

var
  Parts: array [0 .. 6] of string; // ['YYYY', 'MM', 'DD', 'HH', 'MM', 'SS', '(sss)']
  Count, dV02: Integer;
  S0, S2: string;
  V0, V2: Word;
  L0, L2: Integer;
  Year, Month, Day, Hour, Min, Sec, MSec, SecAddon: Word;
begin
  // Init
  Year := 1899;
  Month := 12;
  Day := 30;
  Hour := 0;
  Min := 0;
  Sec := 0;
  MSec := 0;
  SecAddon := 0;
  // Parse value
  Count := ParseToParts(Value, cDelimsDateTime, Parts);
  // Calculating obvious
  case Slice of
    cCastDateTime: begin
        if (Count < 6) then Exception;
        Month := StrToWord(Parts[1]);
        Hour  := StrToWord(Parts[3]);
        Min   := StrToWord(Parts[4]);
        Sec   := StrToWord(Parts[5]);
        MSec  := StrToMSec(Parts[6]);
      end;
    cCastDate: begin
        if (Count <> 3) then Exception;
        Month := StrToWord(Parts[1]);
      end;
    cCastTime: begin
        if (Count < 3) or (Count > 4) then Exception;
        Hour  := StrToWord(Parts[0]);
        Min   := StrToWord(Parts[1]);
        Sec   := StrToWord(Parts[2]);
        MSec  := StrToMSec(Parts[3]);
      end;
  end;
  // Determination of the date: calculating year & day
  if Slice in [cCastDateTime, cCastDate] then begin
    S0 := TrimLeft(Parts[0]); V0 := StrToWord(S0); L0 := Length(S0);
    S2 := TrimLeft(Parts[2]); V2 := StrToWord(S2); L2 := Length(S2);
    dV02 := (L0 - L2);
    case dV02 of
     +3:{YYYY-MM-D } ;
     +2:{YYYY-MM-DD} ;
     +1:{  YY-MM-D } LongYear(V0);
     // ?
     00:{YY-MM-DD or DD-MM-YY}
     begin
       // (19..|2000)YY-MM-DD
       if (V0 > 31) or (V0 = 0) then LongYear(V0)
       else begin
         // DD-MM-YY(19..|2000)
         if (V2 > 31) or (V2 = 0) then begin LongYear(V2); SwapWord(V0, V2); end
         else
           case Tip of
             yymmdd: LongYear(V0); // YY-MM-DD ~ Old format FITS
             ddmmyy: begin LongYear(V2); SwapWord(V0, V2); end;
           end;
       end;
     end;
     // end ?
     -1:{ D-MM-YY  } begin LongYear(V2); SwapWord(V0, V2); end;
     -2:{DD-MM-YYYY} SwapWord(V0, V2);
     -3:{ D-MM-YYYY} SwapWord(V0, V2);
    end;
    Year := V0;
    Day := V2;
  end;
  // Correction for a time: calculating addon second
  if Slice in [cCastDateTime, cCastTime] then begin
    if MSec > 999 then begin
      SecAddon := SecAddon + (MSec div 1000);
      MSec := MSec mod 1000;
    end;
    if Sec >= 60 then begin
      SecAddon := SecAddon + (Sec div 60) * 60;
      Sec := Sec mod 60;
    end;
  end;
  // Calculating Result
  Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Min, Sec, MSec);
  if SecAddon > 0 then Result := IncSecond(Result, SecAddon);
end;

function DateTimeToStri(const Value: TDateTime; Slice: TSliceDateTime): string;
  function vtos(V, Prec: Word): string;
  begin
    Result := Format('%.' + IntToStr(Prec) + 'd', [V]);
  end;

var
  sDate, sTime: string;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  // Fits standart: YYYY-MM-DDTHH:MM:SS.zzz
  DecodeDate(Value, Year, Month, Day);
  DecodeTime(Value, Hour, Min, Sec, MSec);
  with cFitsDelimDateTime do begin
    sDate := vtos(Year, 4) + deDate + vtos(Month, 2) + deDate + vtos(Day, 2);
    sTime := vtos(Hour, 2) + deTime + vtos(Min, 2) + deTime + vtos(Sec, 2) + '.' + vtos(MSec, 3);
  end;
  case Slice of
    cCastDate:
      Result := sDate;
    cCastTime:
      Result := sTime;
    else {cCastDateTime}
      Result := sDate + cFitsDelimDateTime.deMain + sTime;
  end;
end;

function FloatToCoord(Value: Extended): TCoord;
var
  St: string;
begin
  with Result do begin
    if Value < 0 then Sgn := sMinus else Sgn := sPlus;
    Value := Abs(Value);       
    GG := Trunc(Value);
    Value := (Value - GG) * 60;
    MM := Trunc(Value);
    Value := (Value - MM) * 60;
    //SS := Value;// accuracy is lost...
    St := FloatToStri(Value, False, '%g');
    SS := StriToFloat(St);
  end;
end;

function CoordToFloat(Value: TCoord): Extended;
begin
  with Value do begin
    Result := (GG * 3600 + MM * 60 + SS) / 3600;
    // Result := Abs(GG) + MM / 60 + SS / 3600;
    if Sgn = sMinus then Result := -Result;
  end;
end;

function CoordToStri(const Value: TCoord; SignGG: Boolean; PrecGG, PrecSS: Word): string;
var
  G, M, S: string;
begin
  G := IntToStri(Value.GG, False, PrecGG);
  if Value.Sgn = sMinus then
    G := '-' + G
  else if SignGG then
    G := '+' + G;
  M := IntToStri(Value.MM, False, 2);
  S := FloatToStri(Value.SS, False, 2, PrecSS);
  Result := G + cFitsDelimCoord + M + cFitsDelimCoord + S;
end;

function StriToCoord(Value: string): TCoord;
  procedure Exception;
  begin
    raise EFitsStringException.CreateFmt(eStringConvert, [Value, 'II Equatorial coordinate system'], ERROR_STRING_COORD);   
  end;

var
  Parts: array [0 .. 2] of string; // ['GG', 'MM', 'SS.sss']
  Count: Integer;
  Int: Int64;
begin
  // Init
  with Result do begin
    GG := 0;
    MM := 0;
    SS := 0.0;
  end;
  // Parse Value
  Value := Trim(Value);
  Count := ParseToParts(Value, cDelimsCoord, Parts);
  if (Count < 3) then 
    Exception;
  // Format
  with Result do begin
    if (Parts[0][1] = '-') then Sgn := sMinus else Sgn := sPlus;     
    Int := StriToInt(Parts[0]);
    GG := Word(Abs(Int));
    Int := StriToInt(Parts[1]); 
    if (Int < 0) or (Int > 60) then Exception;
    MM := Word(Int);
    SS := StriToFloat(Parts[2]);
    if (SS < 0) or (SS > 60) then Exception;
  end;
end;

function GetCoordNotate(Value: string): TCoordNotate;
var
  I: Integer;
begin
  Result := cmDecimal;
  Value := Trim(Value); 
  for I := 1 to Length(cDelimsCoord) do
    if PosChar(cDelimsCoord[I], Value) > 0 then begin
      Result := cmSexagesimal;
      Break;
    end;
end;

// Checking the value or Right Ascension
procedure CheckRa(const Ra: Extended);
begin
  if (Ra < 0) or (Ra > 360) then
    raise EFitsStringException.CreateFmt(eStringIncorrectValue, [Ra, 'Right Ascension'], ERROR_STRING_RA_VALUE);
end;

function StriToRa(const Value: string; Tip: TCoordMeasur = cmHour): Extended;
var
  Coord: TCoord;
begin
  Result := cCoordNull;
  case GetCoordNotate(Value) of
    cmDecimal:
        Result := StriToFloat(Value);
    cmSexagesimal: begin
        Coord := StriToCoord(Value);
        Result := CoordToFloat(Coord);
      end;
  end;
  if (Result < 24.0) and (Tip = cmHour) then
    Result := Result * 15;
  CheckRa(Result);
end;

function RaToStri(Value: Extended; Prec: Word; Notate: TCoordNotate; Measure: TCoordMeasur): string;
var
  Coord: TCoord;
  PrecGG: Word;
begin
  CheckRa(Value);
  Result := '';
  if (Measure = cmHour) then Value := Value / 15;
  if (Measure = cmHour) then PrecGG := 2 else {Measure = cmDegree} PrecGG := 3;
  if (Measure = cmHour) and (Prec > 0) then Inc(Prec);
  case Notate of
    cmDecimal:
        Result := FloatToStri(Value, False, PrecGG, Prec);
    cmSexagesimal: begin
        if Prec > 3 then Prec := Prec - 3 else Prec := 0;
        Coord := FloatToCoord(Value);
        Result := CoordToStri(Coord, False, PrecGG, Prec);
      end;
  end;
end;

// Checking the value or Declination
procedure CheckDe(const De: Extended);
begin
  if (De < -90) or (De > 90) then
    raise EFitsStringException.CreateFmt(eStringIncorrectValue, [De, 'Declination'], ERROR_STRING_DE_VALUE);
end;

function StriToDe(const Value: string): Extended;
var
  Coord: TCoord;
begin
  Result := cCoordNull;
  case GetCoordNotate(Value) of
    cmDecimal:
        Result := StriToFloat(Value);
    cmSexagesimal: begin
        Coord := StriToCoord(Value);
        Result := CoordToFloat(Coord);
      end;
  end;
  CheckDe(Result);
end;
  
function DeToStri(const Value: Extended; Prec: Word; Notate: TCoordNotate): string;
var
  Coord: TCoord;
begin
  CheckDe(Value);
  Result := '';
  case Notate of
    cmDecimal:
        Result := FloatToStri(Value, True, 2, Prec);
    cmSexagesimal: begin
        if Prec > 3 then Prec := Prec - 3 else Prec := 0;
        Coord := FloatToCoord(Value);
        Result := CoordToStri(Coord, True, 2, Prec);
      end;     
  end; 
end;

end.
