{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{                                                      }
{          Reading files Fits to user buffer,          }
{ physical quantities Value = Data[j,i]*BScale + BZero }
{                                                      }
{                Semantics procedures:                 }
{ SysOrderByte_FileBitPix_UserDataRep_UsageBScaleBZero }
{                                                      }
{ The prefix UsageBScaleBZero indicates true DataRep:  }
{   - - BScale = 1.0 and BZero = 0.0;                  }
{   z - BScale = 1.0 and BZero = -$80|+$8000|+80000000 }
{       only BitPix = 08, 16, 32;                      }
{   e - BScale = R or BZero = R;                       }
{                                                      }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsDataRead;

{$I DeLaFitsCompiler.inc}

interface

uses
  Classes, DeLaFitsCommon, DeLaFitsOrderByte;

  procedure GetProc(BitPix: TBitPix; const BScale, BZero: Double; UserRep: TRep;
    out Proc: TProcDataAccess);

implementation

{$WARNINGS OFF}
{$IFDEF FPC}
  {$HINTS OFF}
{$ENDIF}

{$IFDEF DELABITPIX64F}
//Lazarus Hint: Converting the operands to "Int64" before doing the multiply could prevent overflow errors
//procedure ler_bi64f_rep80f   ... TBuf = T64c; TDat = T80f; ... Swap64cf(Buf[J])                         ...;
//procedure ler_bi64f_rep80f_e ... TBuf = T64c; TDat = T80f; ... Swap64cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64f_rep64f   ... TBuf = T64c; TDat = T64f; ... Swap64cf(Buf[J])                         ...;
//procedure ler_bi64f_rep64f_e ... TBuf = T64c; TDat = T64f; ... Swap64cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64f_rep32f   ... TBuf = T64c; TDat = T32f; ... Swap64cf(Buf[J])                         ...;
//procedure ler_bi64f_rep32f_e ... TBuf = T64c; TDat = T32f; ... Swap64cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64f_rep08c   ... TBuf = T64c; TDat = T08c; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep08c_e ... TBuf = T64c; TDat = T08c; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep08u   ... TBuf = T64c; TDat = T08u; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep08u_e ... TBuf = T64c; TDat = T08u; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep16c   ... TBuf = T64c; TDat = T16c; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep16c_e ... TBuf = T64c; TDat = T16c; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep16u   ... TBuf = T64c; TDat = T16u; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep16u_e ... TBuf = T64c; TDat = T16u; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep32c   ... TBuf = T64c; TDat = T32c; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep32c_e ... TBuf = T64c; TDat = T32c; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep32u   ... TBuf = T64c; TDat = T32u; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep32u_e ... TBuf = T64c; TDat = T32u; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64f_rep64c   ... TBuf = T64c; TDat = T64c; ... Round(Swap64cf(Buf[J]))                  ...;
//procedure ler_bi64f_rep64c_e ... TBuf = T64c; TDat = T64c; ... Round(Swap64cf(Buf[J]) * BScale + BZero) ...;
//procedure ber_bi64f_rep80f   ... TBuf = T64f; TDat = T80f; ... Buf[J]                                   ...;
//procedure ber_bi64f_rep80f_e ... TBuf = T64f; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64f_rep64f   ... TBuf = T64f; TDat = T64f; ... Buf[J]                                   ...;
//procedure ber_bi64f_rep64f_e ... TBuf = T64f; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64f_rep32f   ... TBuf = T64f; TDat = T32f; ... Buf[J]                                   ...;
//procedure ber_bi64f_rep32f_e ... TBuf = T64f; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64f_rep08c   ... TBuf = T64f; TDat = T08c; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep08c_e ... TBuf = T64f; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep08u   ... TBuf = T64f; TDat = T08u; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep08u_e ... TBuf = T64f; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep16c   ... TBuf = T64f; TDat = T16c; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep16c_e ... TBuf = T64f; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep16u   ... TBuf = T64f; TDat = T16u; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep16u_e ... TBuf = T64f; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep32c   ... TBuf = T64f; TDat = T32c; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep32c_e ... TBuf = T64f; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep32u   ... TBuf = T64f; TDat = T32u; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep32u_e ... TBuf = T64f; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64f_rep64c   ... TBuf = T64f; TDat = T64c; ... Round(Buf[J])                            ...;
//procedure ber_bi64f_rep64c_e ... TBuf = T64f; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure ler_bi64f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64f;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX64F}

{$IFDEF DELABITPIX32F}
//Lazarus Hint: Converting the operands to "Int64" before doing the multiply could prevent overflow errors
//procedure ler_bi32f_rep80f   ... TBuf = T32c; TDat = T80f; ... Swap32cf(Buf[J])                         ...;
//procedure ler_bi32f_rep80f_e ... TBuf = T32c; TDat = T80f; ... Swap32cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32f_rep64f   ... TBuf = T32c; TDat = T64f; ... Swap32cf(Buf[J])                         ...;
//procedure ler_bi32f_rep64f_e ... TBuf = T32c; TDat = T64f; ... Swap32cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32f_rep32f   ... TBuf = T32c; TDat = T32f; ... Swap32cf(Buf[J])                         ...;
//procedure ler_bi32f_rep32f_e ... TBuf = T32c; TDat = T32f; ... Swap32cf(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32f_rep08c   ... TBuf = T32c; TDat = T08c; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep08c_e ... TBuf = T32c; TDat = T08c; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep08u   ... TBuf = T32c; TDat = T08u; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep08u_e ... TBuf = T32c; TDat = T08u; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep16c   ... TBuf = T32c; TDat = T16c; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep16c_e ... TBuf = T32c; TDat = T16c; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep16u   ... TBuf = T32c; TDat = T16u; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep16u_e ... TBuf = T32c; TDat = T16u; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep32c   ... TBuf = T32c; TDat = T32c; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep32c_e ... TBuf = T32c; TDat = T32c; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep32u   ... TBuf = T32c; TDat = T32u; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep32u_e ... TBuf = T32c; TDat = T32u; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32f_rep64c   ... TBuf = T32c; TDat = T64c; ... Round(Swap32cf(Buf[J]))                  ...;
//procedure ler_bi32f_rep64c_e ... TBuf = T32c; TDat = T64c; ... Round(Swap32cf(Buf[J]) * BScale + BZero) ...;
//procedure ber_bi32f_rep80f   ... TBuf = T32f; TDat = T80f; ... Buf[J]                                   ...;
//procedure ber_bi32f_rep80f_e ... TBuf = T32f; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32f_rep64f   ... TBuf = T32f; TDat = T64f; ... Buf[J]                                   ...;
//procedure ber_bi32f_rep64f_e ... TBuf = T32f; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32f_rep32f   ... TBuf = T32f; TDat = T32f; ... Buf[J]                                   ...;
//procedure ber_bi32f_rep32f_e ... TBuf = T32f; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32f_rep08c   ... TBuf = T32f; TDat = T08c; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep08c_e ... TBuf = T32f; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep08u   ... TBuf = T32f; TDat = T08u; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep08u_e ... TBuf = T32f; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep16c   ... TBuf = T32f; TDat = T16c; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep16c_e ... TBuf = T32f; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep16u   ... TBuf = T32f; TDat = T16u; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep16u_e ... TBuf = T32f; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep32c   ... TBuf = T32f; TDat = T32c; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep32c_e ... TBuf = T32f; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep32u   ... TBuf = T32f; TDat = T32u; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep32u_e ... TBuf = T32f; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32f_rep64c   ... TBuf = T32f; TDat = T64c; ... Round(Buf[J])                            ...;
//procedure ber_bi32f_rep64c_e ... TBuf = T32f; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure ler_bi32f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cf(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]));
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cf(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32f;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX32F}

{$IFDEF DELABITPIX08U}
//Lazarus Hint: Converting the operands to "Int64" before doing the add could prevent overflow errors
//procedure xxr_bi08u_rep80f   ... TBuf = T08u; TDat = T80f; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep80f_z ... TBuf = T08u; TDat = T80f; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep80f_e ... TBuf = T08u; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure xxr_bi08u_rep64f   ... TBuf = T08u; TDat = T64f; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep64f_z ... TBuf = T08u; TDat = T64f; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep64f_e ... TBuf = T08u; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure xxr_bi08u_rep32f   ... TBuf = T08u; TDat = T32f; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep32f_z ... TBuf = T08u; TDat = T32f; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep32f_e ... TBuf = T08u; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure xxr_bi08u_rep08c   ... TBuf = T08u; TDat = T08c; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep08c_z ... TBuf = T08u; TDat = T08c; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep08c_e ... TBuf = T08u; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep08u   ... TBuf = T08u; TDat = T08u; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep08u_z ... TBuf = T08u; TDat = T08u; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep08u_e ... TBuf = T08u; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep16c   ... TBuf = T08u; TDat = T16c; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep16c_z ... TBuf = T08u; TDat = T16c; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep16c_e ... TBuf = T08u; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep16u   ... TBuf = T08u; TDat = T16u; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep16u_z ... TBuf = T08u; TDat = T16u; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep16u_e ... TBuf = T08u; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep32c   ... TBuf = T08u; TDat = T32c; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep32c_z ... TBuf = T08u; TDat = T32c; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep32c_e ... TBuf = T08u; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep32u   ... TBuf = T08u; TDat = T32u; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep32u_z ... TBuf = T08u; TDat = T32u; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep32u_e ... TBuf = T08u; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure xxr_bi08u_rep64c   ... TBuf = T08u; TDat = T64c; ... Buf[J]                                   ...;
//procedure xxr_bi08u_rep64c_z ... TBuf = T08u; TDat = T64c; ... Buf[J] + cBZero08c                       ...;
//procedure xxr_bi08u_rep64c_e ... TBuf = T08u; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure xxr_bi08u_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero08c;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxr_bi08u_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T08u;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX08U}

{$IFDEF DELABITPIX16C}
//Lazarus Hint: Converting the operands to "Int64" before doing the add could prevent overflow errors
//procedure ler_bi16c_rep80f   ... TBuf = T16c; TDat = T80f; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep80f_z ... TBuf = T16c; TDat = T80f; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep80f_e ... TBuf = T16c; TDat = T80f; ... Swap(Buf[J]) * BScale + BZero            ...;
//procedure ler_bi16c_rep64f   ... TBuf = T16c; TDat = T64f; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep64f_z ... TBuf = T16c; TDat = T64f; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep64f_e ... TBuf = T16c; TDat = T64f; ... Swap(Buf[J]) * BScale + BZero            ...;
//procedure ler_bi16c_rep32f   ... TBuf = T16c; TDat = T32f; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep32f_z ... TBuf = T16c; TDat = T32f; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep32f_e ... TBuf = T16c; TDat = T32f; ... Swap(Buf[J]) * BScale + BZero            ...;
//procedure ler_bi16c_rep08c   ... TBuf = T16c; TDat = T08c; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep08c_z ... TBuf = T16c; TDat = T08c; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep08c_e ... TBuf = T16c; TDat = T08c; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep08u   ... TBuf = T16c; TDat = T08u; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep08u_z ... TBuf = T16c; TDat = T08u; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep08u_e ... TBuf = T16c; TDat = T08u; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep16c   ... TBuf = T16c; TDat = T16c; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep16c_z ... TBuf = T16c; TDat = T16c; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep16c_e ... TBuf = T16c; TDat = T16c; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep16u   ... TBuf = T16c; TDat = T16u; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep16u_z ... TBuf = T16c; TDat = T16u; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep16u_e ... TBuf = T16c; TDat = T16u; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep32c   ... TBuf = T16c; TDat = T32c; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep32c_z ... TBuf = T16c; TDat = T32c; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep32c_e ... TBuf = T16c; TDat = T32c; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep32u   ... TBuf = T16c; TDat = T32u; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep32u_z ... TBuf = T16c; TDat = T32u; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep32u_e ... TBuf = T16c; TDat = T32u; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ler_bi16c_rep64c   ... TBuf = T16c; TDat = T64c; ... Swap(Buf[J])                             ...;
//procedure ler_bi16c_rep64c_z ... TBuf = T16c; TDat = T64c; ... Swap(Buf[J]) + cBZero16u                 ...;
//procedure ler_bi16c_rep64c_e ... TBuf = T16c; TDat = T64c; ... Round(Swap(Buf[J]) * BScale + BZero)     ...;
//procedure ber_bi16c_rep80f   ... TBuf = T16c; TDat = T80f; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep80f_z ... TBuf = T16c; TDat = T80f; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep80f_e ... TBuf = T16c; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi16c_rep64f   ... TBuf = T16c; TDat = T64f; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep64f_z ... TBuf = T16c; TDat = T64f; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep64f_e ... TBuf = T16c; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi16c_rep32f   ... TBuf = T16c; TDat = T32f; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep32f_z ... TBuf = T16c; TDat = T32f; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep32f_e ... TBuf = T16c; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi16c_rep08c   ... TBuf = T16c; TDat = T08c; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep08c_z ... TBuf = T16c; TDat = T08c; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep08c_e ... TBuf = T16c; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep08u   ... TBuf = T16c; TDat = T08u; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep08u_z ... TBuf = T16c; TDat = T08u; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep08u_e ... TBuf = T16c; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep16c   ... TBuf = T16c; TDat = T16c; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep16c_z ... TBuf = T16c; TDat = T16c; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep16c_e ... TBuf = T16c; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep16u   ... TBuf = T16c; TDat = T16u; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep16u_z ... TBuf = T16c; TDat = T16u; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep16u_e ... TBuf = T16c; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep32c   ... TBuf = T16c; TDat = T32c; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep32c_z ... TBuf = T16c; TDat = T32c; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep32c_e ... TBuf = T16c; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep32u   ... TBuf = T16c; TDat = T32u; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep32u_z ... TBuf = T16c; TDat = T32u; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep32u_e ... TBuf = T16c; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi16c_rep64c   ... TBuf = T16c; TDat = T64c; ... Buf[J]                                   ...;
//procedure ber_bi16c_rep64c_z ... TBuf = T16c; TDat = T64c; ... Buf[J] + cBZero16u                       ...;
//procedure ber_bi16c_rep64c_e ... TBuf = T16c; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure ler_bi16c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap(Buf[J]) + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi16c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero16u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi16c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T16c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX16C}

{$IFDEF DELABITPIX32C}
//Lazarus Hint: Mixing signed expressions and longwords gives a 64bit result
//procedure ler_bi32c_rep80f   ... TBuf = T32c; TDat = T80f; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep80f_z ... TBuf = T32c; TDat = T80f; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep80f_e ... TBuf = T32c; TDat = T80f; ... Swap32cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32c_rep64f   ... TBuf = T32c; TDat = T64f; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep64f_z ... TBuf = T32c; TDat = T64f; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep64f_e ... TBuf = T32c; TDat = T64f; ... Swap32cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32c_rep32f   ... TBuf = T32c; TDat = T32f; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep32f_z ... TBuf = T32c; TDat = T32f; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep32f_e ... TBuf = T32c; TDat = T32f; ... Swap32cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi32c_rep08c   ... TBuf = T32c; TDat = T08c; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep08c_z ... TBuf = T32c; TDat = T08c; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep08c_e ... TBuf = T32c; TDat = T08c; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep08u   ... TBuf = T32c; TDat = T08u; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep08u_z ... TBuf = T32c; TDat = T08u; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep08u_e ... TBuf = T32c; TDat = T08u; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep16c   ... TBuf = T32c; TDat = T16c; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep16c_z ... TBuf = T32c; TDat = T16c; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep16c_e ... TBuf = T32c; TDat = T16c; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep16u   ... TBuf = T32c; TDat = T16u; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep16u_z ... TBuf = T32c; TDat = T16u; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep16u_e ... TBuf = T32c; TDat = T16u; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep32c   ... TBuf = T32c; TDat = T32c; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep32c_z ... TBuf = T32c; TDat = T32c; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep32c_e ... TBuf = T32c; TDat = T32c; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep32u   ... TBuf = T32c; TDat = T32u; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep32u_z ... TBuf = T32c; TDat = T32u; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep32u_e ... TBuf = T32c; TDat = T32u; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi32c_rep64c   ... TBuf = T32c; TDat = T64c; ... Swap32cc(Buf[J])                         ...;
//procedure ler_bi32c_rep64c_z ... TBuf = T32c; TDat = T64c; ... Swap32cc(Buf[J]) + cBZero32u             ...;
//procedure ler_bi32c_rep64c_e ... TBuf = T32c; TDat = T64c; ... Round(Swap32cc(Buf[J]) * BScale + BZero) ...;
//procedure ber_bi32c_rep80f   ... TBuf = T32c; TDat = T80f; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep80f_z ... TBuf = T32c; TDat = T80f; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep80f_e ... TBuf = T32c; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32c_rep64f   ... TBuf = T32c; TDat = T64f; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep64f_z ... TBuf = T32c; TDat = T64f; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep64f_e ... TBuf = T32c; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32c_rep32f   ... TBuf = T32c; TDat = T32f; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep32f_z ... TBuf = T32c; TDat = T32f; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep32f_e ... TBuf = T32c; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi32c_rep08c   ... TBuf = T32c; TDat = T08c; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep08c_z ... TBuf = T32c; TDat = T08c; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep08c_e ... TBuf = T32c; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep08u   ... TBuf = T32c; TDat = T08u; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep08u_z ... TBuf = T32c; TDat = T08u; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep08u_e ... TBuf = T32c; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep16c   ... TBuf = T32c; TDat = T16c; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep16c_z ... TBuf = T32c; TDat = T16c; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep16c_e ... TBuf = T32c; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep16u   ... TBuf = T32c; TDat = T16u; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep16u_z ... TBuf = T32c; TDat = T16u; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep16u_e ... TBuf = T32c; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep32c   ... TBuf = T32c; TDat = T32c; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep32c_z ... TBuf = T32c; TDat = T32c; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep32c_e ... TBuf = T32c; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep32u   ... TBuf = T32c; TDat = T32u; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep32u_z ... TBuf = T32c; TDat = T32u; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep32u_e ... TBuf = T32c; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi32c_rep64c   ... TBuf = T32c; TDat = T64c; ... Buf[J]                                   ...;
//procedure ber_bi32c_rep64c_z ... TBuf = T32c; TDat = T64c; ... Buf[J] + cBZero32u                       ...;
//procedure ber_bi32c_rep64c_e ... TBuf = T32c; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure ler_bi32c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap32cc(Buf[J]) + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi32c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap32cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] + cBZero32u;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi32c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T32c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX32C}

{$IFDEF DELABITPIX64C}
// Lazarus, Hint: Converting the operands to "Int64" before doing the multiply could prevent overflow errors
//procedure ler_bi64c_rep80f   ... TBuf = T64c; TDat = T80f; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep80f_e ... TBuf = T64c; TDat = T80f; ... Swap64cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64c_rep64f   ... TBuf = T64c; TDat = T64f; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep64f_e ... TBuf = T64c; TDat = T64f; ... Swap64cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64c_rep32f   ... TBuf = T64c; TDat = T32f; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep32f_e ... TBuf = T64c; TDat = T32f; ... Swap64cc(Buf[J]) * BScale + BZero        ...;
//procedure ler_bi64c_rep08c   ... TBuf = T64c; TDat = T08c; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep08c_e ... TBuf = T64c; TDat = T08c; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep08u   ... TBuf = T64c; TDat = T08u; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep08u_e ... TBuf = T64c; TDat = T08u; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep16c   ... TBuf = T64c; TDat = T16c; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep16c_e ... TBuf = T64c; TDat = T16c; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep16u   ... TBuf = T64c; TDat = T16u; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep16u_e ... TBuf = T64c; TDat = T16u; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep32c   ... TBuf = T64c; TDat = T32c; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep32c_e ... TBuf = T64c; TDat = T32c; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep32u   ... TBuf = T64c; TDat = T32u; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep32u_e ... TBuf = T64c; TDat = T32u; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ler_bi64c_rep64c   ... TBuf = T64c; TDat = T64c; ... Swap64cc(Buf[J])                         ...;
//procedure ler_bi64c_rep64c_e ... TBuf = T64c; TDat = T64c; ... Round(Swap64cc(Buf[J]) * BScale + BZero) ...;
//procedure ber_bi64c_rep80f   ... TBuf = T64c; TDat = T80f; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep80f_e ... TBuf = T64c; TDat = T80f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64c_rep64f   ... TBuf = T64c; TDat = T64f; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep64f_e ... TBuf = T64c; TDat = T64f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64c_rep32f   ... TBuf = T64c; TDat = T32f; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep32f_e ... TBuf = T64c; TDat = T32f; ... Buf[J] * BScale + BZero                  ...;
//procedure ber_bi64c_rep08c   ... TBuf = T64c; TDat = T08c; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep08c_e ... TBuf = T64c; TDat = T08c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep08u   ... TBuf = T64c; TDat = T08u; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep08u_e ... TBuf = T64c; TDat = T08u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep16c   ... TBuf = T64c; TDat = T16c; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep16c_e ... TBuf = T64c; TDat = T16c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep16u   ... TBuf = T64c; TDat = T16u; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep16u_e ... TBuf = T64c; TDat = T16u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep32c   ... TBuf = T64c; TDat = T32c; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep32c_e ... TBuf = T64c; TDat = T32c; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep32u   ... TBuf = T64c; TDat = T32u; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep32u_e ... TBuf = T64c; TDat = T32u; ... Round(Buf[J] * BScale + BZero)           ...;
//procedure ber_bi64c_rep64c   ... TBuf = T64c; TDat = T64c; ... Buf[J]                                   ...;
//procedure ber_bi64c_rep64c_e ... TBuf = T64c; TDat = T64c; ... Round(Buf[J] * BScale + BZero)           ...;

procedure ler_bi64c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]) * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Swap64cc(Buf[J]);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ler_bi64c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Swap64cc(Buf[J]) * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T80f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32f;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J] * BScale + BZero;
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T08u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T16u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T32u;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Buf[J];
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure ber_bi64c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBufArr = array of T64c;
  TDatArr = array of array of T64c;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        Stream.Read(Buf[0], SizeBuf);
        for J := 0 to ColsCount - 1 do
          Dat[J, I] := Round(Buf[J] * BScale + BZero);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX64C}

{$WARNINGS ON}
{$IFDEF FPC}
  {$HINTS ON}
{$ENDIF}

procedure GetProc(BitPix: TBitPix; const BScale, BZero: Double; UserRep: TRep; out Proc: TProcDataAccess);
var
  ler: Boolean;
  z, e: Boolean;
begin
  ler := (SysOrderByte = sobLe);
  z := False;
  e := False;
  // From hide IDE hints
  if z or e or ler then
    Proc := nil
  else
    Proc := nil;
  {$IFDEF DELABITPIX64F}
  if BitPix = bi64f then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi64f_rep80f_e else Proc := @ber_bi64f_rep80f_e;
      rep64f: if ler then Proc := @ler_bi64f_rep64f_e else Proc := @ber_bi64f_rep64f_e;
      rep32f: if ler then Proc := @ler_bi64f_rep32f_e else Proc := @ber_bi64f_rep32f_e;
      rep08c: if ler then Proc := @ler_bi64f_rep08c_e else Proc := @ber_bi64f_rep08c_e;
      rep08u: if ler then Proc := @ler_bi64f_rep08u_e else Proc := @ber_bi64f_rep08u_e;
      rep16c: if ler then Proc := @ler_bi64f_rep16c_e else Proc := @ber_bi64f_rep16c_e;
      rep16u: if ler then Proc := @ler_bi64f_rep16u_e else Proc := @ber_bi64f_rep16u_e;
      rep32c: if ler then Proc := @ler_bi64f_rep32c_e else Proc := @ber_bi64f_rep32c_e;
      rep32u: if ler then Proc := @ler_bi64f_rep32u_e else Proc := @ber_bi64f_rep32u_e;
      rep64c: if ler then Proc := @ler_bi64f_rep64c_e else Proc := @ber_bi64f_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if ler then Proc := @ler_bi64f_rep80f else Proc := @ber_bi64f_rep80f;
      rep64f: if ler then Proc := @ler_bi64f_rep64f else Proc := @ber_bi64f_rep64f;
      rep32f: if ler then Proc := @ler_bi64f_rep32f else Proc := @ber_bi64f_rep32f;
      rep08c: if ler then Proc := @ler_bi64f_rep08c else Proc := @ber_bi64f_rep08c;
      rep08u: if ler then Proc := @ler_bi64f_rep08u else Proc := @ber_bi64f_rep08u;
      rep16c: if ler then Proc := @ler_bi64f_rep16c else Proc := @ber_bi64f_rep16c;
      rep16u: if ler then Proc := @ler_bi64f_rep16u else Proc := @ber_bi64f_rep16u;
      rep32c: if ler then Proc := @ler_bi64f_rep32c else Proc := @ber_bi64f_rep32c;
      rep32u: if ler then Proc := @ler_bi64f_rep32u else Proc := @ber_bi64f_rep32u;
      rep64c: if ler then Proc := @ler_bi64f_rep64c else Proc := @ber_bi64f_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX64F}
  {$IFDEF DELABITPIX32F}
  if BitPix = bi32f then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi32f_rep80f_e else Proc := @ber_bi32f_rep80f_e;
      rep64f: if ler then Proc := @ler_bi32f_rep64f_e else Proc := @ber_bi32f_rep64f_e;
      rep32f: if ler then Proc := @ler_bi32f_rep32f_e else Proc := @ber_bi32f_rep32f_e;
      rep08c: if ler then Proc := @ler_bi32f_rep08c_e else Proc := @ber_bi32f_rep08c_e;
      rep08u: if ler then Proc := @ler_bi32f_rep08u_e else Proc := @ber_bi32f_rep08u_e;
      rep16c: if ler then Proc := @ler_bi32f_rep16c_e else Proc := @ber_bi32f_rep16c_e;
      rep16u: if ler then Proc := @ler_bi32f_rep16u_e else Proc := @ber_bi32f_rep16u_e;
      rep32c: if ler then Proc := @ler_bi32f_rep32c_e else Proc := @ber_bi32f_rep32c_e;
      rep32u: if ler then Proc := @ler_bi32f_rep32u_e else Proc := @ber_bi32f_rep32u_e;
      rep64c: if ler then Proc := @ler_bi32f_rep64c_e else Proc := @ber_bi32f_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if ler then Proc := @ler_bi32f_rep80f else Proc := @ber_bi32f_rep80f;
      rep64f: if ler then Proc := @ler_bi32f_rep64f else Proc := @ber_bi32f_rep64f;
      rep32f: if ler then Proc := @ler_bi32f_rep32f else Proc := @ber_bi32f_rep32f;
      rep08c: if ler then Proc := @ler_bi32f_rep08c else Proc := @ber_bi32f_rep08c;
      rep08u: if ler then Proc := @ler_bi32f_rep08u else Proc := @ber_bi32f_rep08u;
      rep16c: if ler then Proc := @ler_bi32f_rep16c else Proc := @ber_bi32f_rep16c;
      rep16u: if ler then Proc := @ler_bi32f_rep16u else Proc := @ber_bi32f_rep16u;
      rep32c: if ler then Proc := @ler_bi32f_rep32c else Proc := @ber_bi32f_rep32c;
      rep32u: if ler then Proc := @ler_bi32f_rep32u else Proc := @ber_bi32f_rep32u;
      rep64c: if ler then Proc := @ler_bi32f_rep64c else Proc := @ber_bi32f_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX32F}
  {$IFDEF DELABITPIX08U}
  if BitPix = bi08u then
  begin
    z := (BScale = 1.0) and (BZero = cBZero08c);
    e := (not z) and ((BScale <> 1.0) or (BZero <> 0.0));
    if z then
    case UserRep of
      rep80f: Proc := @xxr_bi08u_rep80f_z;
      rep64f: Proc := @xxr_bi08u_rep64f_z;
      rep32f: Proc := @xxr_bi08u_rep32f_z;
      rep08c: Proc := @xxr_bi08u_rep08c_z;
      rep08u: Proc := @xxr_bi08u_rep08u_z;
      rep16c: Proc := @xxr_bi08u_rep16c_z;
      rep16u: Proc := @xxr_bi08u_rep16u_z;
      rep32c: Proc := @xxr_bi08u_rep32c_z;
      rep32u: Proc := @xxr_bi08u_rep32u_z;
      rep64c: Proc := @xxr_bi08u_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: Proc := @xxr_bi08u_rep80f_e;
      rep64f: Proc := @xxr_bi08u_rep64f_e;
      rep32f: Proc := @xxr_bi08u_rep32f_e;
      rep08c: Proc := @xxr_bi08u_rep08c_e;
      rep08u: Proc := @xxr_bi08u_rep08u_e;
      rep16c: Proc := @xxr_bi08u_rep16c_e;
      rep16u: Proc := @xxr_bi08u_rep16u_e;
      rep32c: Proc := @xxr_bi08u_rep32c_e;
      rep32u: Proc := @xxr_bi08u_rep32u_e;
      rep64c: Proc := @xxr_bi08u_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: Proc := @xxr_bi08u_rep80f;
      rep64f: Proc := @xxr_bi08u_rep64f;
      rep32f: Proc := @xxr_bi08u_rep32f;
      rep08c: Proc := @xxr_bi08u_rep08c;
      rep08u: Proc := @xxr_bi08u_rep08u;
      rep16c: Proc := @xxr_bi08u_rep16c;
      rep16u: Proc := @xxr_bi08u_rep16u;
      rep32c: Proc := @xxr_bi08u_rep32c;
      rep32u: Proc := @xxr_bi08u_rep32u;
      rep64c: Proc := @xxr_bi08u_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX08U}
  {$IFDEF DELABITPIX16C}
  if BitPix = bi16c then
  begin
    z := (BScale = 1.0) and (BZero = cBZero16u);
    e := (not z) and ((BScale <> 1.0) or (BZero <> 0.0));
    if z then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi16c_rep80f_z else Proc := @ber_bi16c_rep80f_z;
      rep64f: if ler then Proc := @ler_bi16c_rep64f_z else Proc := @ber_bi16c_rep64f_z;
      rep32f: if ler then Proc := @ler_bi16c_rep32f_z else Proc := @ber_bi16c_rep32f_z;
      rep08c: if ler then Proc := @ler_bi16c_rep08c_z else Proc := @ber_bi16c_rep08c_z;
      rep08u: if ler then Proc := @ler_bi16c_rep08u_z else Proc := @ber_bi16c_rep08u_z;
      rep16c: if ler then Proc := @ler_bi16c_rep16c_z else Proc := @ber_bi16c_rep16c_z;
      rep16u: if ler then Proc := @ler_bi16c_rep16u_z else Proc := @ber_bi16c_rep16u_z;
      rep32c: if ler then Proc := @ler_bi16c_rep32c_z else Proc := @ber_bi16c_rep32c_z;
      rep32u: if ler then Proc := @ler_bi16c_rep32u_z else Proc := @ber_bi16c_rep32u_z;
      rep64c: if ler then Proc := @ler_bi16c_rep64c_z else Proc := @ber_bi16c_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi16c_rep80f_e else Proc := @ber_bi16c_rep80f_e;
      rep64f: if ler then Proc := @ler_bi16c_rep64f_e else Proc := @ber_bi16c_rep64f_e;
      rep32f: if ler then Proc := @ler_bi16c_rep32f_e else Proc := @ber_bi16c_rep32f_e;
      rep08c: if ler then Proc := @ler_bi16c_rep08c_e else Proc := @ber_bi16c_rep08c_e;
      rep08u: if ler then Proc := @ler_bi16c_rep08u_e else Proc := @ber_bi16c_rep08u_e;
      rep16c: if ler then Proc := @ler_bi16c_rep16c_e else Proc := @ber_bi16c_rep16c_e;
      rep16u: if ler then Proc := @ler_bi16c_rep16u_e else Proc := @ber_bi16c_rep16u_e;
      rep32c: if ler then Proc := @ler_bi16c_rep32c_e else Proc := @ber_bi16c_rep32c_e;
      rep32u: if ler then Proc := @ler_bi16c_rep32u_e else Proc := @ber_bi16c_rep32u_e;
      rep64c: if ler then Proc := @ler_bi16c_rep64c_e else Proc := @ber_bi16c_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: if ler then Proc := @ler_bi16c_rep80f else Proc := @ber_bi16c_rep80f;
      rep64f: if ler then Proc := @ler_bi16c_rep64f else Proc := @ber_bi16c_rep64f;
      rep32f: if ler then Proc := @ler_bi16c_rep32f else Proc := @ber_bi16c_rep32f;
      rep08c: if ler then Proc := @ler_bi16c_rep08c else Proc := @ber_bi16c_rep08c;
      rep08u: if ler then Proc := @ler_bi16c_rep08u else Proc := @ber_bi16c_rep08u;
      rep16c: if ler then Proc := @ler_bi16c_rep16c else Proc := @ber_bi16c_rep16c;
      rep16u: if ler then Proc := @ler_bi16c_rep16u else Proc := @ber_bi16c_rep16u;
      rep32c: if ler then Proc := @ler_bi16c_rep32c else Proc := @ber_bi16c_rep32c;
      rep32u: if ler then Proc := @ler_bi16c_rep32u else Proc := @ber_bi16c_rep32u;
      rep64c: if ler then Proc := @ler_bi16c_rep64c else Proc := @ber_bi16c_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX16C}
  {$IFDEF DELABITPIX32C}
  if BitPix = bi32c then
  begin
    z := (BScale = 1.0) and (BZero = cBZero32u);
    e := (not z) and ((BScale <> 1.0) or (BZero <> 0.0));
    if z then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi32c_rep80f_z else Proc := @ber_bi32c_rep80f_z;
      rep64f: if ler then Proc := @ler_bi32c_rep64f_z else Proc := @ber_bi32c_rep64f_z;
      rep32f: if ler then Proc := @ler_bi32c_rep32f_z else Proc := @ber_bi32c_rep32f_z;
      rep08c: if ler then Proc := @ler_bi32c_rep08c_z else Proc := @ber_bi32c_rep08c_z;
      rep08u: if ler then Proc := @ler_bi32c_rep08u_z else Proc := @ber_bi32c_rep08u_z;
      rep16c: if ler then Proc := @ler_bi32c_rep16c_z else Proc := @ber_bi32c_rep16c_z;
      rep16u: if ler then Proc := @ler_bi32c_rep16u_z else Proc := @ber_bi32c_rep16u_z;
      rep32c: if ler then Proc := @ler_bi32c_rep32c_z else Proc := @ber_bi32c_rep32c_z;
      rep32u: if ler then Proc := @ler_bi32c_rep32u_z else Proc := @ber_bi32c_rep32u_z;
      rep64c: if ler then Proc := @ler_bi32c_rep64c_z else Proc := @ber_bi32c_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi32c_rep80f_e else Proc := @ber_bi32c_rep80f_e;
      rep64f: if ler then Proc := @ler_bi32c_rep64f_e else Proc := @ber_bi32c_rep64f_e;
      rep32f: if ler then Proc := @ler_bi32c_rep32f_e else Proc := @ber_bi32c_rep32f_e;
      rep08c: if ler then Proc := @ler_bi32c_rep08c_e else Proc := @ber_bi32c_rep08c_e;
      rep08u: if ler then Proc := @ler_bi32c_rep08u_e else Proc := @ber_bi32c_rep08u_e;
      rep16c: if ler then Proc := @ler_bi32c_rep16c_e else Proc := @ber_bi32c_rep16c_e;
      rep16u: if ler then Proc := @ler_bi32c_rep16u_e else Proc := @ber_bi32c_rep16u_e;
      rep32c: if ler then Proc := @ler_bi32c_rep32c_e else Proc := @ber_bi32c_rep32c_e;
      rep32u: if ler then Proc := @ler_bi32c_rep32u_e else Proc := @ber_bi32c_rep32u_e;
      rep64c: if ler then Proc := @ler_bi32c_rep64c_e else Proc := @ber_bi32c_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: if ler then Proc := @ler_bi32c_rep80f else Proc := @ber_bi32c_rep80f;
      rep64f: if ler then Proc := @ler_bi32c_rep64f else Proc := @ber_bi32c_rep64f;
      rep32f: if ler then Proc := @ler_bi32c_rep32f else Proc := @ber_bi32c_rep32f;
      rep08c: if ler then Proc := @ler_bi32c_rep08c else Proc := @ber_bi32c_rep08c;
      rep08u: if ler then Proc := @ler_bi32c_rep08u else Proc := @ber_bi32c_rep08u;
      rep16c: if ler then Proc := @ler_bi32c_rep16c else Proc := @ber_bi32c_rep16c;
      rep16u: if ler then Proc := @ler_bi32c_rep16u else Proc := @ber_bi32c_rep16u;
      rep32c: if ler then Proc := @ler_bi32c_rep32c else Proc := @ber_bi32c_rep32c;
      rep32u: if ler then Proc := @ler_bi32c_rep32u else Proc := @ber_bi32c_rep32u;
      rep64c: if ler then Proc := @ler_bi32c_rep64c else Proc := @ber_bi32c_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX32C}
  {$IFDEF DELABITPIX64C}
  if BitPix = bi64c then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if ler then Proc := @ler_bi64c_rep80f_e else Proc := @ber_bi64c_rep80f_e;
      rep64f: if ler then Proc := @ler_bi64c_rep64f_e else Proc := @ber_bi64c_rep64f_e;
      rep32f: if ler then Proc := @ler_bi64c_rep32f_e else Proc := @ber_bi64c_rep32f_e;
      rep08c: if ler then Proc := @ler_bi64c_rep08c_e else Proc := @ber_bi64c_rep08c_e;
      rep08u: if ler then Proc := @ler_bi64c_rep08u_e else Proc := @ber_bi64c_rep08u_e;
      rep16c: if ler then Proc := @ler_bi64c_rep16c_e else Proc := @ber_bi64c_rep16c_e;
      rep16u: if ler then Proc := @ler_bi64c_rep16u_e else Proc := @ber_bi64c_rep16u_e;
      rep32c: if ler then Proc := @ler_bi64c_rep32c_e else Proc := @ber_bi64c_rep32c_e;
      rep32u: if ler then Proc := @ler_bi64c_rep32u_e else Proc := @ber_bi64c_rep32u_e;
      rep64c: if ler then Proc := @ler_bi64c_rep64c_e else Proc := @ber_bi64c_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if ler then Proc := @ler_bi64c_rep80f else Proc := @ber_bi64c_rep80f;
      rep64f: if ler then Proc := @ler_bi64c_rep64f else Proc := @ber_bi64c_rep64f;
      rep32f: if ler then Proc := @ler_bi64c_rep32f else Proc := @ber_bi64c_rep32f;
      rep08c: if ler then Proc := @ler_bi64c_rep08c else Proc := @ber_bi64c_rep08c;
      rep08u: if ler then Proc := @ler_bi64c_rep08u else Proc := @ber_bi64c_rep08u;
      rep16c: if ler then Proc := @ler_bi64c_rep16c else Proc := @ber_bi64c_rep16c;
      rep16u: if ler then Proc := @ler_bi64c_rep16u else Proc := @ber_bi64c_rep16u;
      rep32c: if ler then Proc := @ler_bi64c_rep32c else Proc := @ber_bi64c_rep32c;
      rep32u: if ler then Proc := @ler_bi64c_rep32u else Proc := @ber_bi64c_rep32u;
      rep64c: if ler then Proc := @ler_bi64c_rep64c else Proc := @ber_bi64c_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX64C}
end;

end.
