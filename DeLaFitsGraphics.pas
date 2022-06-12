{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{              Graphic image of the data               }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsGraphics;

interface

{$I DeLaFitsCompiler.inc}

uses
  SysUtils, Classes, {$IFNDEF FPC} Windows, {$ENDIF} Graphics, Math,
  DeLaFitsCommon, DeLaFitsOrderByte, DeLaFitsClasses;

const

  { The error codes }

  ERROR_GRAPHICS = 5000;

  { Error codes for TGraphicColor }

  ERROR_HISTOGRAMDYNAMICRANGE_INVALID = 5101;
  ERROR_BRIGHTNESS_INVALID            = 5102;
  ERROR_CONTRAST_INVALID              = 5103;
  ERROR_GAMMA_INVALID                 = 5104;
  ERROR_PALETTE_UNKNOWN               = 5105;

  { Error codes for TFitsBitmap }

  ERRROR_BITMAP_NIL = 5201;

  { The error text }

  eScalingInvalid    = 'Invalid value of scaling: [%.2f; %.2f]. A scale can not be equal to the zero';
  eShearInvalid      = 'Invalid value of shear: %.2f. The correct values (-90 .. 90)';
  eBrightnessInvalid = 'Invalid value of brightness: %.2f. The correct values [%.2f .. %.2f]';
  eContrastInvalid   = 'Invalid value of contrast: %.2f. The correct values [%.2f .. %.2f]';
  eGammaInvalid      = 'Invalid value of gamma: %.2f. The correct values [%.2f .. %.2f]';
  ePaletteUnknown    = 'Invalid value of palette. The property should not be set to nil';
  eBitmapUnsigned    = 'Bitmap: not assigned pointer a bitmap';

type

  EFitsGraphicColorException = class(EFitsException);
  EFitsGraphicException = class(EFitsException);
  EFitsBitmapException = class(EFitsException);

  TFitsGraphic = class;

  TGraphicColor = class(TObject)
  private
    FFits: TFitsGraphic;
  private
  public
    constructor Create(AFits: TFitsGraphic);
    destructor Destroy; override;
    property Fits: TFitsGraphic read FFits;
  public
  public
  end;

  { Graphic Fits frame, data array 2D only

  Map stream:
  DataOffset 00 01 02 03 04 05 06 07 08 09 10 11 ~~

  Map Data:

  0-----|-----|-----|-----|--- X (NAXIS1, ColsCount, Width)
  | 0;0 | 1;0 | 2;0 | 3;0 |
  |-----|-----|-----|-----|
  | 0;1 | 1;1 | 2;1 | 3;1 |
  |-----|-----|-----|-----|
  | 0;2 | 1;2 | 2;2 | 3;2 |
  |-----|-----|-----|-----|
  |
  Y (NAXIS2, RowsCount, Height)

  Fits Standard, version 3.0, page 14-15. Data[NAXIS1 - 1, NAXIS2 - 1] }

  TFitsGraphic = class(TFitsFrame)
  private
    FGraphicColor: TGraphicColor;
  protected
    procedure Init; override;
  public
    destructor Destroy; override;
    procedure DataRead(var Intensite: TSpectre); virtual;
  end;

  { A class of graphic presentation of frame is in the format of Bitmap, de-facto
    Bitmap 8bit. For TBitmap Delphi (Windows) property of PixelFormat is supported
    pf8bit, pf24bit and pf32bit. For TBitmap in Lazarus support only pf24bit }

  TFitsBitmap = class(TFitsGraphic)
  public
    // Get a spectre, overloaded methods
    procedure SpectreRead(var lambda,intensite: TSpectre); overload;
  end;

  { Graphic (Bitmap) Fits frame as the file }
  
  TFitsFileBitmap = class(TFitsBitmap)
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

{ TGraphicColor }

constructor TGraphicColor.Create(AFits: TFitsGraphic);
begin
  inherited Create;
  FFits := AFits;
end;

destructor TGraphicColor.Destroy;
begin
  FFits := nil;
  inherited;
end;

{ TFitsGraphic }

destructor TFitsGraphic.Destroy;
begin
  FGraphicColor.Free;
  inherited;
end;

procedure TFitsGraphic.DataRead(var Intensite: Tspectre);
var Row1: TA64f1;
    N: Integer;

  procedure DataRead(var Buffer: TStreamBuffer);
  var
    {$IFDEF DELABITPIX64F}
    v64f: T64f;
    b64f: TA64f1;
    {$ENDIF}
    {$IFDEF DELABITPIX32F}
    v32f: T32f;
    b32f: TA32f1;
    {$ENDIF}
    {$IFDEF DELABITPIX08U}
    v08u: T08u;
    b08u: TA08u1;
    {$ENDIF}
    {$IFDEF DELABITPIX16C}
    v16c: T16c;
    b16c: TA16c1;
    {$ENDIF}
    {$IFDEF DELABITPIX32C}
    v32c: T32c;
    b32c: TA32c1;
    {$ENDIF}
    {$IFDEF DELABITPIX64C}
    v64c: T64c;
    b64c: TA64c1;
    {$ENDIF}
    ler: Boolean;
    BitPixSize: Integer;
    BScale, BZero: Double;
    Size, R, Rnum: Integer;
    Offset: int64;
  begin
    ler := SysOrderByte = sobLe;
    BitPixSize := BitPixByteSize(HduCore.BitPix);
    BScale := HduCore.BScale;
    BZero := HduCore.BZero;
    {$IFDEF DELABITPIX64F}
    b64f := TA64f1(Buffer);
    {$ENDIF}
    {$IFDEF DELABITPIX32F}
    b32f := TA32f1(Buffer);
    {$ENDIF}
    {$IFDEF DELABITPIX08U}
    b08u := TA08u1(Buffer);
    {$ENDIF}
    {$IFDEF DELABITPIX16C}
    b16c := TA16c1(Buffer);
    {$ENDIF}
    {$IFDEF DELABITPIX32C}
    b32c := TA32c1(Buffer);
    {$ENDIF}
    {$IFDEF DELABITPIX64C}
    b64c := TA64c1(Buffer);
    {$ENDIF}
    // Row1
    Size := N * BitPixSize;
    if FHduCore.NAxis=2
       then Rnum := FHduCore.NAxisn[1] div 2  // on lit la ligne du milieu
       else Rnum := 0;
    Offset := DataOffset + (Int64(HduCore.NAxisn[0]) * Rnum) * BitPixSize;
    StreamRead(Offset, Size, Buffer);
    case HduCore.BitPix of
      bi64f: begin
         {$IFDEF DELABITPIX64F}
          for R := 0 to N-1 do begin
            v64f := b64f[R];
            if ler then
              v64f := Swap64ff(v64f);
            Row1[R] := v64f * BScale + BZero;
          end;
          {$ENDIF}
        end;
      bi32f: begin
          {$IFDEF DELABITPIX32F}
          for R := 0 to N-1 do begin
            v32f := b32f[R];
            if ler then
              v32f := Swap32ff(v32f);
            Row1[R] := v32f * BScale + BZero;
          end;
          {$ENDIF}
        end;
      bi08u: begin
          {$IFDEF DELABITPIX08U}
          for R := 0 to N-1 do begin
            v08u := b08u[R];
            Row1[R] := v08u * BScale + BZero;
          end;
          {$ENDIF}
        end;
      bi16c: begin
          {$IFDEF DELABITPIX16C}
          for R := 0 to N-1 do begin
            v16c := b16c[R];
            if ler then
              v16c := Swap16cc(v16c);
            Row1[R] := v16c * BScale + BZero;
          end;
          {$ENDIF}
        end;
      bi32c: begin
          {$IFDEF DELABITPIX32C}
          for R := 0 to N-1 do begin
            v32c := b32c[R];
            if ler then
              v32c := Swap32cc(v32c);
            Row1[R] := v32c * BScale + BZero;
          end;
          {$ENDIF}
        end;
      bi64c: begin
          {$IFDEF DELABITPIX64C}
          for R := 0 to N-1 do begin
            v64c := b64c[R];
            if ler then
              v64c := Swap64cc(v64c);
            Row1[R] := v64c * BScale + BZero;
          end;
          {$ENDIF}
        end;
    end; {case BitPix of ...}
    // free local buf
    {$IFDEF DELABITPIX64F}
    b64f := nil;
    {$ENDIF}
    {$IFDEF DELABITPIX32F}
    b32f := nil;
    {$ENDIF}
    {$IFDEF DELABITPIX08U}
    b08u := nil;
    {$ENDIF}
    {$IFDEF DELABITPIX16C}
    b16c := nil;
    {$ENDIF}
    {$IFDEF DELABITPIX32C}
    b32c := nil;
    {$ENDIF}
    {$IFDEF DELABITPIX64C}
    b64c := nil;
    {$ENDIF}
  end;

var
  I: Integer;
  Buffer: TStreamBuffer;
begin
  // Prepare buffer
  N := FHduCore.NAxisn[0];
  Buffer := nil;
  AllocateBuffer(Pointer(Buffer), (N + 1) * BitPixByteSize(HduCore.BitPix));
  SetLength(Row1, N);
  DataRead(Buffer);
  setLength(intensite,HDUcore.NAxisn[0]);
  for I := 0 to HDUcore.NAxisn[0] - 1 do Intensite[I] := Row1[i];
  // Release buffer and rows
  ReleaseBuffer(Pointer(Buffer));
  Row1 := nil;
end;

procedure TFitsGraphic.Init;
begin
  inherited;
  FGraphicColor := TGraphicColor.Create(Self);
end;

{ TFitsBitmap }

procedure TFitsBitmap.SpectreRead(var lambda,intensite: Tspectre);
var i : integer;
begin
    DataRead(intensite);
    setLength(lambda,length(intensite));
    for i := 0 to FHDucore.NAxisn[0]-1 do
        lambda[i] := FHduCore.lambda0+i*FHduCore.DeltaLambda;
end;

{ TFitsFileBitmap }

constructor TFitsFileBitmap.CreateJoin(const AFileName: string; AFileMode: Word);
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

constructor TFitsFileBitmap.CreateMade(const AFileName: string; const AHduCore: THduCore);
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

destructor TFitsFileBitmap.Destroy;
begin
  if Assigned(FStream) then
    FreeAndNil(FStream);   
  inherited;
end;

function TFitsFileBitmap.GetFileStream: TFileStream;
begin
  Result := FStream as TFileStream; 
end;

end.

