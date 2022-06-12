{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{                                                      }
{          Writing files Fits to user buffer,          }
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

unit DeLaFitsDataWrite;

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
//procedure lew_bi64f_rep80f   ... TBuf = T64f; TDat = T80f; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep80f_e ... TBuf = T64f; TDat = T80f; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep64f   ... TBuf = T64f; TDat = T64f; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep64f_e ... TBuf = T64f; TDat = T64f; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep32f   ... TBuf = T64f; TDat = T32f; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep32f_e ... TBuf = T64f; TDat = T32f; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep08c   ... TBuf = T64f; TDat = T08c; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep08c_e ... TBuf = T64f; TDat = T08c; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep08u   ... TBuf = T64f; TDat = T08u; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep08u_e ... TBuf = T64f; TDat = T08u; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep16c   ... TBuf = T64f; TDat = T16c; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep16c_e ... TBuf = T64f; TDat = T16c; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep16u   ... TBuf = T64f; TDat = T16u; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep16u_e ... TBuf = T64f; TDat = T16u; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep32c   ... TBuf = T64f; TDat = T32c; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep32c_e ... TBuf = T64f; TDat = T32c; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep32u   ... TBuf = T64f; TDat = T32u; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep32u_e ... TBuf = T64f; TDat = T32u; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi64f_rep64c   ... TBuf = T64f; TDat = T64c; ... Swap64ff(Dat[J, I])                            ...;
//procedure lew_bi64f_rep64c_e ... TBuf = T64f; TDat = T64c; ... Swap64ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure bew_bi64f_rep80f   ... TBuf = T64f; TDat = T80f; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep80f_e ... TBuf = T64f; TDat = T80f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep64f   ... TBuf = T64f; TDat = T64f; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep64f_e ... TBuf = T64f; TDat = T64f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep32f   ... TBuf = T64f; TDat = T32f; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep32f_e ... TBuf = T64f; TDat = T32f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep08c   ... TBuf = T64f; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep08c_e ... TBuf = T64f; TDat = T08c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep08u   ... TBuf = T64f; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep08u_e ... TBuf = T64f; TDat = T08u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep16c   ... TBuf = T64f; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep16c_e ... TBuf = T64f; TDat = T16c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep16u   ... TBuf = T64f; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep16u_e ... TBuf = T64f; TDat = T16u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep32c   ... TBuf = T64f; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep32c_e ... TBuf = T64f; TDat = T32c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep32u   ... TBuf = T64f; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep32u_e ... TBuf = T64f; TDat = T32u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi64f_rep64c   ... TBuf = T64f; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure bew_bi64f_rep64c_e ... TBuf = T64f; TDat = T64c; ... Dat[J, I] * BScale + BZero                     ...;

procedure lew_bi64f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX64F}

{$IFDEF DELABITPIX32F}
//procedure lew_bi32f_rep80f   ... TBuf = T32f; TDat = T80f; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep80f_e ... TBuf = T32f; TDat = T80f; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep64f   ... TBuf = T32f; TDat = T64f; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep64f_e ... TBuf = T32f; TDat = T64f; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep32f   ... TBuf = T32f; TDat = T32f; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep32f_e ... TBuf = T32f; TDat = T32f; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep08c   ... TBuf = T32f; TDat = T08c; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep08c_e ... TBuf = T32f; TDat = T08c; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep08u   ... TBuf = T32f; TDat = T08u; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep08u_e ... TBuf = T32f; TDat = T08u; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep16c   ... TBuf = T32f; TDat = T16c; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep16c_e ... TBuf = T32f; TDat = T16c; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep16u   ... TBuf = T32f; TDat = T16u; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep16u_e ... TBuf = T32f; TDat = T16u; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep32c   ... TBuf = T32f; TDat = T32c; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep32c_e ... TBuf = T32f; TDat = T32c; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep32u   ... TBuf = T32f; TDat = T32u; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep32u_e ... TBuf = T32f; TDat = T32u; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure lew_bi32f_rep64c   ... TBuf = T32f; TDat = T64c; ... Swap32ff(Dat[J, I])                            ...;
//procedure lew_bi32f_rep64c_e ... TBuf = T32f; TDat = T64c; ... Swap32ff((Dat[J, I] - BZero) / BScale)         ...;
//procedure bew_bi32f_rep80f   ... TBuf = T32f; TDat = T80f; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep80f_e ... TBuf = T32f; TDat = T80f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep64f   ... TBuf = T32f; TDat = T64f; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep64f_e ... TBuf = T32f; TDat = T64f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep32f   ... TBuf = T32f; TDat = T32f; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep32f_e ... TBuf = T32f; TDat = T32f; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep08c   ... TBuf = T32f; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep08c_e ... TBuf = T32f; TDat = T08c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep08u   ... TBuf = T32f; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep08u_e ... TBuf = T32f; TDat = T08u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep16c   ... TBuf = T32f; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep16c_e ... TBuf = T32f; TDat = T16c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep16u   ... TBuf = T32f; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep16u_e ... TBuf = T32f; TDat = T16u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep32c   ... TBuf = T32f; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep32c_e ... TBuf = T32f; TDat = T32c; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep32u   ... TBuf = T32f; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep32u_e ... TBuf = T32f; TDat = T32u; ... Dat[J, I] * BScale + BZero                     ...;
//procedure bew_bi32f_rep64c   ... TBuf = T32f; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure bew_bi32f_rep64c_e ... TBuf = T32f; TDat = T64c; ... Dat[J, I] * BScale + BZero                     ...;

procedure lew_bi32f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32ff((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32f_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32f;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] * BScale + BZero;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX32F}

{$IFDEF DELABITPIX08U}
//procedure xxw_bi08u_rep80f   ... TBuf = T08u; TDat = T80f; ... Round(Dat[J, I])                               ...;
//procedure xxw_bi08u_rep80f_z ... TBuf = T08u; TDat = T80f; ... Round(Dat[J, I] - cBZero08c)                   ...;
//procedure xxw_bi08u_rep80f_e ... TBuf = T08u; TDat = T80f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep64f   ... TBuf = T08u; TDat = T64f; ... Round(Dat[J, I])                               ...;
//procedure xxw_bi08u_rep64f_z ... TBuf = T08u; TDat = T64f; ... Round(Dat[J, I] - cBZero08c)                   ...;
//procedure xxw_bi08u_rep64f_e ... TBuf = T08u; TDat = T64f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep32f   ... TBuf = T08u; TDat = T32f; ... Round(Dat[J, I])                               ...;
//procedure xxw_bi08u_rep32f_z ... TBuf = T08u; TDat = T32f; ... Round(Dat[J, I] - cBZero08c)                   ...;
//procedure xxw_bi08u_rep32f_e ... TBuf = T08u; TDat = T32f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep08c   ... TBuf = T08u; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep08c_z ... TBuf = T08u; TDat = T08c; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep08c_e ... TBuf = T08u; TDat = T08c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep08u   ... TBuf = T08u; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep08u_z ... TBuf = T08u; TDat = T08u; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep08u_e ... TBuf = T08u; TDat = T08u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep16c   ... TBuf = T08u; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep16c_z ... TBuf = T08u; TDat = T16c; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep16c_e ... TBuf = T08u; TDat = T16c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep16u   ... TBuf = T08u; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep16u_z ... TBuf = T08u; TDat = T16u; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep16u_e ... TBuf = T08u; TDat = T16u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep32c   ... TBuf = T08u; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep32c_z ... TBuf = T08u; TDat = T32c; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep32c_e ... TBuf = T08u; TDat = T32c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep32u   ... TBuf = T08u; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep32u_z ... TBuf = T08u; TDat = T32u; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep32u_e ... TBuf = T08u; TDat = T32u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure xxw_bi08u_rep64c   ... TBuf = T08u; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure xxw_bi08u_rep64c_z ... TBuf = T08u; TDat = T64c; ... Dat[J, I] - cBZero08c                          ...;
//procedure xxw_bi08u_rep64c_e ... TBuf = T08u; TDat = T64c; ... Round((Dat[J, I] - BZero) / BScale)            ...;

procedure xxw_bi08u_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero08c);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero08c);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero08c);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero08c;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure xxw_bi08u_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T08u;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX08U}

{$IFDEF DELABITPIX16C}
//Important! Explicit type conversion TBuf(...) is used to Lazarus. Because of
//differences in the behavior of the function Swap(...) overload
//procedure lew_bi16c_rep80f   ... TBuf = T16c; TDat = T80f; ... Swap(TBuf(Round(Dat[J, I])))                   ...;
//procedure lew_bi16c_rep80f_z ... TBuf = T16c; TDat = T80f; ... Swap(TBuf(Round(Dat[J, I] - cBZero16u)))       ...;
//procedure lew_bi16c_rep80f_e ... TBuf = T16c; TDat = T80f; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep64f   ... TBuf = T16c; TDat = T64f; ... Swap(TBuf(Round(Dat[J, I])))                   ...;
//procedure lew_bi16c_rep64f_z ... TBuf = T16c; TDat = T64f; ... Swap(TBuf(Round(Dat[J, I] - cBZero16u)))       ...;
//procedure lew_bi16c_rep64f_e ... TBuf = T16c; TDat = T64f; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep32f   ... TBuf = T16c; TDat = T32f; ... Swap(TBuf(Round(Dat[J, I])))                   ...;
//procedure lew_bi16c_rep32f_z ... TBuf = T16c; TDat = T32f; ... Swap(TBuf(Round(Dat[J, I] - cBZero16u)))       ...;
//procedure lew_bi16c_rep32f_e ... TBuf = T16c; TDat = T32f; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep08c   ... TBuf = T16c; TDat = T08c; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep08c_z ... TBuf = T16c; TDat = T08c; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep08c_e ... TBuf = T16c; TDat = T08c; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep08u   ... TBuf = T16c; TDat = T08u; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep08u_z ... TBuf = T16c; TDat = T08u; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep08u_e ... TBuf = T16c; TDat = T08u; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep16c   ... TBuf = T16c; TDat = T16c; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep16c_z ... TBuf = T16c; TDat = T16c; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep16c_e ... TBuf = T16c; TDat = T16c; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep16u   ... TBuf = T16c; TDat = T16u; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep16u_z ... TBuf = T16c; TDat = T16u; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep16u_e ... TBuf = T16c; TDat = T16u; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep32c   ... TBuf = T16c; TDat = T32c; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep32c_z ... TBuf = T16c; TDat = T32c; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep32c_e ... TBuf = T16c; TDat = T32c; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep32u   ... TBuf = T16c; TDat = T32u; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep32u_z ... TBuf = T16c; TDat = T32u; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep32u_e ... TBuf = T16c; TDat = T32u; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure lew_bi16c_rep64c   ... TBuf = T16c; TDat = T64c; ... Swap(TBuf(Dat[J, I]))                          ...;
//procedure lew_bi16c_rep64c_z ... TBuf = T16c; TDat = T64c; ... Swap(TBuf(Dat[J, I] - cBZero16u))              ...;
//procedure lew_bi16c_rep64c_e ... TBuf = T16c; TDat = T64c; ... Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)))...;
//procedure bew_bi16c_rep80f   ... TBuf = T16c; TDat = T80f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi16c_rep80f_z ... TBuf = T16c; TDat = T80f; ... Round(Dat[J, I] - cBZero16u)                   ...;
//procedure bew_bi16c_rep80f_e ... TBuf = T16c; TDat = T80f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep64f   ... TBuf = T16c; TDat = T64f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi16c_rep64f_z ... TBuf = T16c; TDat = T64f; ... Round(Dat[J, I] - cBZero16u)                   ...;
//procedure bew_bi16c_rep64f_e ... TBuf = T16c; TDat = T64f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep32f   ... TBuf = T16c; TDat = T32f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi16c_rep32f_z ... TBuf = T16c; TDat = T32f; ... Round(Dat[J, I] - cBZero16u)                   ...;
//procedure bew_bi16c_rep32f_e ... TBuf = T16c; TDat = T32f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep08c   ... TBuf = T16c; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep08c_z ... TBuf = T16c; TDat = T08c; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep08c_e ... TBuf = T16c; TDat = T08c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep08u   ... TBuf = T16c; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep08u_z ... TBuf = T16c; TDat = T08u; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep08u_e ... TBuf = T16c; TDat = T08u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep16c   ... TBuf = T16c; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep16c_z ... TBuf = T16c; TDat = T16c; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep16c_e ... TBuf = T16c; TDat = T16c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep16u   ... TBuf = T16c; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep16u_z ... TBuf = T16c; TDat = T16u; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep16u_e ... TBuf = T16c; TDat = T16u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep32c   ... TBuf = T16c; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep32c_z ... TBuf = T16c; TDat = T32c; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep32c_e ... TBuf = T16c; TDat = T32c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep32u   ... TBuf = T16c; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep32u_z ... TBuf = T16c; TDat = T32u; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep32u_e ... TBuf = T16c; TDat = T32u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi16c_rep64c   ... TBuf = T16c; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure bew_bi16c_rep64c_z ... TBuf = T16c; TDat = T64c; ... Dat[J, I] - cBZero16u                          ...;
//procedure bew_bi16c_rep64c_e ... TBuf = T16c; TDat = T64c; ... Round((Dat[J, I] - BZero) / BScale)            ...;

procedure lew_bi16c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I])));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I] - cBZero16u)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I])));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I] - cBZero16u)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I])));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round(Dat[J, I] - cBZero16u)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Dat[J, I] - cBZero16u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi16c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap(TBuf(Round((Dat[J, I] - BZero) / BScale)));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero16u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero16u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero16u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero16u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi16c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T16c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX16C}

{$IFDEF DELABITPIX32C}
//procedure lew_bi32c_rep80f   ... TBuf = T32c; TDat = T80f; ... Swap32cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi32c_rep80f_z ... TBuf = T32c; TDat = T80f; ... Swap32cc(Round(Dat[J, I] - cBZero32u))         ...;
//procedure lew_bi32c_rep80f_e ... TBuf = T32c; TDat = T80f; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep64f   ... TBuf = T32c; TDat = T64f; ... Swap32cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi32c_rep64f_z ... TBuf = T32c; TDat = T64f; ... Swap32cc(Round(Dat[J, I] - cBZero32u))         ...;
//procedure lew_bi32c_rep64f_e ... TBuf = T32c; TDat = T64f; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep32f   ... TBuf = T32c; TDat = T32f; ... Swap32cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi32c_rep32f_z ... TBuf = T32c; TDat = T32f; ... Swap32cc(Round(Dat[J, I] - cBZero32u))         ...;
//procedure lew_bi32c_rep32f_e ... TBuf = T32c; TDat = T32f; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep08c   ... TBuf = T32c; TDat = T08c; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep08c_z ... TBuf = T32c; TDat = T08c; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep08c_e ... TBuf = T32c; TDat = T08c; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep08u   ... TBuf = T32c; TDat = T08u; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep08u_z ... TBuf = T32c; TDat = T08u; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep08u_e ... TBuf = T32c; TDat = T08u; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep16c   ... TBuf = T32c; TDat = T16c; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep16c_z ... TBuf = T32c; TDat = T16c; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep16c_e ... TBuf = T32c; TDat = T16c; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep16u   ... TBuf = T32c; TDat = T16u; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep16u_z ... TBuf = T32c; TDat = T16u; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep16u_e ... TBuf = T32c; TDat = T16u; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep32c   ... TBuf = T32c; TDat = T32c; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep32c_z ... TBuf = T32c; TDat = T32c; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep32c_e ... TBuf = T32c; TDat = T32c; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep32u   ... TBuf = T32c; TDat = T32u; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep32u_z ... TBuf = T32c; TDat = T32u; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep32u_e ... TBuf = T32c; TDat = T32u; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi32c_rep64c   ... TBuf = T32c; TDat = T64c; ... Swap32cc(Dat[J, I])                            ...;
//procedure lew_bi32c_rep64c_z ... TBuf = T32c; TDat = T64c; ... Swap32cc(Dat[J, I] - cBZero32u)                ...;
//procedure lew_bi32c_rep64c_e ... TBuf = T32c; TDat = T64c; ... Swap32cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure bew_bi32c_rep80f   ... TBuf = T32c; TDat = T80f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi32c_rep80f_z ... TBuf = T32c; TDat = T80f; ... Round(Dat[J, I] - cBZero32u)                   ...;
//procedure bew_bi32c_rep80f_e ... TBuf = T32c; TDat = T80f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep64f   ... TBuf = T32c; TDat = T64f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi32c_rep64f_z ... TBuf = T32c; TDat = T64f; ... Round(Dat[J, I] - cBZero32u)                   ...;
//procedure bew_bi32c_rep64f_e ... TBuf = T32c; TDat = T64f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep32f   ... TBuf = T32c; TDat = T32f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi32c_rep32f_z ... TBuf = T32c; TDat = T32f; ... Round(Dat[J, I] - cBZero32u)                   ...;
//procedure bew_bi32c_rep32f_e ... TBuf = T32c; TDat = T32f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep08c   ... TBuf = T32c; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep08c_z ... TBuf = T32c; TDat = T08c; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep08c_e ... TBuf = T32c; TDat = T08c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep08u   ... TBuf = T32c; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep08u_z ... TBuf = T32c; TDat = T08u; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep08u_e ... TBuf = T32c; TDat = T08u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep16c   ... TBuf = T32c; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep16c_z ... TBuf = T32c; TDat = T16c; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep16c_e ... TBuf = T32c; TDat = T16c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep16u   ... TBuf = T32c; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep16u_z ... TBuf = T32c; TDat = T16u; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep16u_e ... TBuf = T32c; TDat = T16u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep32c   ... TBuf = T32c; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep32c_z ... TBuf = T32c; TDat = T32c; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep32c_e ... TBuf = T32c; TDat = T32c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep32u   ... TBuf = T32c; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep32u_z ... TBuf = T32c; TDat = T32u; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep32u_e ... TBuf = T32c; TDat = T32u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi32c_rep64c   ... TBuf = T32c; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure bew_bi32c_rep64c_z ... TBuf = T32c; TDat = T64c; ... Dat[J, I] - cBZero32u                          ...;
//procedure bew_bi32c_rep64c_e ... TBuf = T32c; TDat = T64c; ... Round((Dat[J, I] - BZero) / BScale)            ...;

procedure lew_bi32c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I] - cBZero32u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I] - cBZero32u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round(Dat[J, I] - cBZero32u));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi32c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap32cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep80f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32f_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I] - cBZero32u);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32u_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64c_z(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I] - cBZero32u;
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi32c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T32c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

{$ENDIF DELABITPIX32C}

{$IFDEF DELABITPIX64C}
//procedure lew_bi64c_rep80f   ... TBuf = T64c; TDat = T80f; ... Swap64cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi64c_rep80f_e ... TBuf = T64c; TDat = T80f; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep64f   ... TBuf = T64c; TDat = T64f; ... Swap64cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi64c_rep64f_e ... TBuf = T64c; TDat = T64f; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep32f   ... TBuf = T64c; TDat = T32f; ... Swap64cc(Round(Dat[J, I]))                     ...;
//procedure lew_bi64c_rep32f_e ... TBuf = T64c; TDat = T32f; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep08c   ... TBuf = T64c; TDat = T08c; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep08c_e ... TBuf = T64c; TDat = T08c; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep08u   ... TBuf = T64c; TDat = T08u; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep08u_e ... TBuf = T64c; TDat = T08u; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep16c   ... TBuf = T64c; TDat = T16c; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep16c_e ... TBuf = T64c; TDat = T16c; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep16u   ... TBuf = T64c; TDat = T16u; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep16u_e ... TBuf = T64c; TDat = T16u; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep32c   ... TBuf = T64c; TDat = T32c; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep32c_e ... TBuf = T64c; TDat = T32c; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep32u   ... TBuf = T64c; TDat = T32u; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep32u_e ... TBuf = T64c; TDat = T32u; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure lew_bi64c_rep64c   ... TBuf = T64c; TDat = T64c; ... Swap64cc(Dat[J, I])                            ...;
//procedure lew_bi64c_rep64c_e ... TBuf = T64c; TDat = T64c; ... Swap64cc(Round((Dat[J, I] - BZero) / BScale))  ...;
//procedure bew_bi64c_rep80f   ... TBuf = T64c; TDat = T80f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi64c_rep80f_e ... TBuf = T64c; TDat = T80f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep64f   ... TBuf = T64c; TDat = T64f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi64c_rep64f_e ... TBuf = T64c; TDat = T64f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep32f   ... TBuf = T64c; TDat = T32f; ... Round(Dat[J, I])                               ...;
//procedure bew_bi64c_rep32f_e ... TBuf = T64c; TDat = T32f; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep08c   ... TBuf = T64c; TDat = T08c; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep08c_e ... TBuf = T64c; TDat = T08c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep08u   ... TBuf = T64c; TDat = T08u; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep08u_e ... TBuf = T64c; TDat = T08u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep16c   ... TBuf = T64c; TDat = T16c; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep16c_e ... TBuf = T64c; TDat = T16c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep16u   ... TBuf = T64c; TDat = T16u; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep16u_e ... TBuf = T64c; TDat = T16u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep32c   ... TBuf = T64c; TDat = T32c; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep32c_e ... TBuf = T64c; TDat = T32c; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep32u   ... TBuf = T64c; TDat = T32u; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep32u_e ... TBuf = T64c; TDat = T32u; ... Round((Dat[J, I] - BZero) / BScale)            ...;
//procedure bew_bi64c_rep64c   ... TBuf = T64c; TDat = T64c; ... Dat[J, I]                                      ...;
//procedure bew_bi64c_rep64c_e ... TBuf = T64c; TDat = T64c; ... Round((Dat[J, I] - BZero) / BScale)            ...;

procedure lew_bi64c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round(Dat[J, I]));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure lew_bi64c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Swap64cc(Round((Dat[J, I] - BZero) / BScale));
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep80f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep80f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T80f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep64f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep64f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32f(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round(Dat[J, I]);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32f_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32f;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep08c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep08c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep08u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep08u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T08u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep16c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep16c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep16u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep16u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T16u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32u(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep32u_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T32u;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep64c(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Dat[J, I];
        Stream.Write(Buf[0], SizeBuf);
      end;
    end;
  finally
    Handle.Buffer.Release(Pointer(Buf));
    Dat := nil;
  end;
end;

procedure bew_bi64c_rep64c_e(Data: Pointer; const Handle: TDataHandle);
type
  TBuf = T64c;
  TDat = T64c;
  TBufArr = array of TBuf;
  TDatArr = array of array of TDat;
var
  Dat: TDatArr;
  Buf: TBufArr;
  SizeBitPix: Byte;
  SizeBuf: Integer;
  ColsCount, RowsCount: Integer;
  Offset: Int64;
  OffsetInc: Integer;
  J, I: Integer;
begin
  with Handle do
  begin
    SizeBitPix := BitPixByteSize(BitPix);
    ColsCount := ReqRgn.ColsCount;
    RowsCount := ReqRgn.RowsCount;
    Offset := StreamOffset + (NAxis1 * ReqRgn.Y1 + ReqRgn.X1) * SizeBitPix;
    OffsetInc := NAxis1 * SizeBitPix;
    SizeBuf := ColsCount * SizeBitPix;
  end;
  try
    Buf := nil;
    Handle.Buffer.Allocate(Pointer(Buf), SizeBuf);
    Dat := TDatArr(Data);
    with Handle do
    begin
      for I := 0 to RowsCount - 1 do
      begin
        Stream.Seek(Offset, soFromBeginning);
        Inc(Offset, OffsetInc);
        for J := 0 to ColsCount - 1 do
          Buf[J] := Round((Dat[J, I] - BZero) / BScale);
        Stream.Write(Buf[0], SizeBuf);
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
  lew: Boolean;
  z, e: Boolean;
begin
  lew := (SysOrderByte = sobLe);
  z := False;
  e := False;
  // From hide IDE hints
  if z or e or lew then
    Proc := nil
  else
    Proc := nil;
  {$IFDEF DELABITPIX64F}
  if BitPix = bi64f then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if lew then Proc := @lew_bi64f_rep80f_e else Proc := @bew_bi64f_rep80f_e;
      rep64f: if lew then Proc := @lew_bi64f_rep64f_e else Proc := @bew_bi64f_rep64f_e;
      rep32f: if lew then Proc := @lew_bi64f_rep32f_e else Proc := @bew_bi64f_rep32f_e;
      rep08c: if lew then Proc := @lew_bi64f_rep08c_e else Proc := @bew_bi64f_rep08c_e;
      rep08u: if lew then Proc := @lew_bi64f_rep08u_e else Proc := @bew_bi64f_rep08u_e;
      rep16c: if lew then Proc := @lew_bi64f_rep16c_e else Proc := @bew_bi64f_rep16c_e;
      rep16u: if lew then Proc := @lew_bi64f_rep16u_e else Proc := @bew_bi64f_rep16u_e;
      rep32c: if lew then Proc := @lew_bi64f_rep32c_e else Proc := @bew_bi64f_rep32c_e;
      rep32u: if lew then Proc := @lew_bi64f_rep32u_e else Proc := @bew_bi64f_rep32u_e;
      rep64c: if lew then Proc := @lew_bi64f_rep64c_e else Proc := @bew_bi64f_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if lew then Proc := @lew_bi64f_rep80f else Proc := @bew_bi64f_rep80f;
      rep64f: if lew then Proc := @lew_bi64f_rep64f else Proc := @bew_bi64f_rep64f;
      rep32f: if lew then Proc := @lew_bi64f_rep32f else Proc := @bew_bi64f_rep32f;
      rep08c: if lew then Proc := @lew_bi64f_rep08c else Proc := @bew_bi64f_rep08c;
      rep08u: if lew then Proc := @lew_bi64f_rep08u else Proc := @bew_bi64f_rep08u;
      rep16c: if lew then Proc := @lew_bi64f_rep16c else Proc := @bew_bi64f_rep16c;
      rep16u: if lew then Proc := @lew_bi64f_rep16u else Proc := @bew_bi64f_rep16u;
      rep32c: if lew then Proc := @lew_bi64f_rep32c else Proc := @bew_bi64f_rep32c;
      rep32u: if lew then Proc := @lew_bi64f_rep32u else Proc := @bew_bi64f_rep32u;
      rep64c: if lew then Proc := @lew_bi64f_rep64c else Proc := @bew_bi64f_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX64F}
  {$IFDEF DELABITPIX32F}
  if BitPix = bi32f then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if lew then Proc := @lew_bi32f_rep80f_e else Proc := @bew_bi32f_rep80f_e;
      rep64f: if lew then Proc := @lew_bi32f_rep64f_e else Proc := @bew_bi32f_rep64f_e;
      rep32f: if lew then Proc := @lew_bi32f_rep32f_e else Proc := @bew_bi32f_rep32f_e;
      rep08c: if lew then Proc := @lew_bi32f_rep08c_e else Proc := @bew_bi32f_rep08c_e;
      rep08u: if lew then Proc := @lew_bi32f_rep08u_e else Proc := @bew_bi32f_rep08u_e;
      rep16c: if lew then Proc := @lew_bi32f_rep16c_e else Proc := @bew_bi32f_rep16c_e;
      rep16u: if lew then Proc := @lew_bi32f_rep16u_e else Proc := @bew_bi32f_rep16u_e;
      rep32c: if lew then Proc := @lew_bi32f_rep32c_e else Proc := @bew_bi32f_rep32c_e;
      rep32u: if lew then Proc := @lew_bi32f_rep32u_e else Proc := @bew_bi32f_rep32u_e;
      rep64c: if lew then Proc := @lew_bi32f_rep64c_e else Proc := @bew_bi32f_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if lew then Proc := @lew_bi32f_rep80f else Proc := @bew_bi32f_rep80f;
      rep64f: if lew then Proc := @lew_bi32f_rep64f else Proc := @bew_bi32f_rep64f;
      rep32f: if lew then Proc := @lew_bi32f_rep32f else Proc := @bew_bi32f_rep32f;
      rep08c: if lew then Proc := @lew_bi32f_rep08c else Proc := @bew_bi32f_rep08c;
      rep08u: if lew then Proc := @lew_bi32f_rep08u else Proc := @bew_bi32f_rep08u;
      rep16c: if lew then Proc := @lew_bi32f_rep16c else Proc := @bew_bi32f_rep16c;
      rep16u: if lew then Proc := @lew_bi32f_rep16u else Proc := @bew_bi32f_rep16u;
      rep32c: if lew then Proc := @lew_bi32f_rep32c else Proc := @bew_bi32f_rep32c;
      rep32u: if lew then Proc := @lew_bi32f_rep32u else Proc := @bew_bi32f_rep32u;
      rep64c: if lew then Proc := @lew_bi32f_rep64c else Proc := @bew_bi32f_rep64c;
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
      rep80f: Proc := @xxw_bi08u_rep80f_z;
      rep64f: Proc := @xxw_bi08u_rep64f_z;
      rep32f: Proc := @xxw_bi08u_rep32f_z;
      rep08c: Proc := @xxw_bi08u_rep08c_z;
      rep08u: Proc := @xxw_bi08u_rep08u_z;
      rep16c: Proc := @xxw_bi08u_rep16c_z;
      rep16u: Proc := @xxw_bi08u_rep16u_z;
      rep32c: Proc := @xxw_bi08u_rep32c_z;
      rep32u: Proc := @xxw_bi08u_rep32u_z;
      rep64c: Proc := @xxw_bi08u_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: Proc := @xxw_bi08u_rep80f_e;
      rep64f: Proc := @xxw_bi08u_rep64f_e;
      rep32f: Proc := @xxw_bi08u_rep32f_e;
      rep08c: Proc := @xxw_bi08u_rep08c_e;
      rep08u: Proc := @xxw_bi08u_rep08u_e;
      rep16c: Proc := @xxw_bi08u_rep16c_e;
      rep16u: Proc := @xxw_bi08u_rep16u_e;
      rep32c: Proc := @xxw_bi08u_rep32c_e;
      rep32u: Proc := @xxw_bi08u_rep32u_e;
      rep64c: Proc := @xxw_bi08u_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: Proc := @xxw_bi08u_rep80f;
      rep64f: Proc := @xxw_bi08u_rep64f;
      rep32f: Proc := @xxw_bi08u_rep32f;
      rep08c: Proc := @xxw_bi08u_rep08c;
      rep08u: Proc := @xxw_bi08u_rep08u;
      rep16c: Proc := @xxw_bi08u_rep16c;
      rep16u: Proc := @xxw_bi08u_rep16u;
      rep32c: Proc := @xxw_bi08u_rep32c;
      rep32u: Proc := @xxw_bi08u_rep32u;
      rep64c: Proc := @xxw_bi08u_rep64c;
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
      rep80f: if lew then Proc := @lew_bi16c_rep80f_z else Proc := @bew_bi16c_rep80f_z;
      rep64f: if lew then Proc := @lew_bi16c_rep64f_z else Proc := @bew_bi16c_rep64f_z;
      rep32f: if lew then Proc := @lew_bi16c_rep32f_z else Proc := @bew_bi16c_rep32f_z;
      rep08c: if lew then Proc := @lew_bi16c_rep08c_z else Proc := @bew_bi16c_rep08c_z;
      rep08u: if lew then Proc := @lew_bi16c_rep08u_z else Proc := @bew_bi16c_rep08u_z;
      rep16c: if lew then Proc := @lew_bi16c_rep16c_z else Proc := @bew_bi16c_rep16c_z;
      rep16u: if lew then Proc := @lew_bi16c_rep16u_z else Proc := @bew_bi16c_rep16u_z;
      rep32c: if lew then Proc := @lew_bi16c_rep32c_z else Proc := @bew_bi16c_rep32c_z;
      rep32u: if lew then Proc := @lew_bi16c_rep32u_z else Proc := @bew_bi16c_rep32u_z;
      rep64c: if lew then Proc := @lew_bi16c_rep64c_z else Proc := @bew_bi16c_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: if lew then Proc := @lew_bi16c_rep80f_e else Proc := @bew_bi16c_rep80f_e;
      rep64f: if lew then Proc := @lew_bi16c_rep64f_e else Proc := @bew_bi16c_rep64f_e;
      rep32f: if lew then Proc := @lew_bi16c_rep32f_e else Proc := @bew_bi16c_rep32f_e;
      rep08c: if lew then Proc := @lew_bi16c_rep08c_e else Proc := @bew_bi16c_rep08c_e;
      rep08u: if lew then Proc := @lew_bi16c_rep08u_e else Proc := @bew_bi16c_rep08u_e;
      rep16c: if lew then Proc := @lew_bi16c_rep16c_e else Proc := @bew_bi16c_rep16c_e;
      rep16u: if lew then Proc := @lew_bi16c_rep16u_e else Proc := @bew_bi16c_rep16u_e;
      rep32c: if lew then Proc := @lew_bi16c_rep32c_e else Proc := @bew_bi16c_rep32c_e;
      rep32u: if lew then Proc := @lew_bi16c_rep32u_e else Proc := @bew_bi16c_rep32u_e;
      rep64c: if lew then Proc := @lew_bi16c_rep64c_e else Proc := @bew_bi16c_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: if lew then Proc := @lew_bi16c_rep80f else Proc := @bew_bi16c_rep80f;
      rep64f: if lew then Proc := @lew_bi16c_rep64f else Proc := @bew_bi16c_rep64f;
      rep32f: if lew then Proc := @lew_bi16c_rep32f else Proc := @bew_bi16c_rep32f;
      rep08c: if lew then Proc := @lew_bi16c_rep08c else Proc := @bew_bi16c_rep08c;
      rep08u: if lew then Proc := @lew_bi16c_rep08u else Proc := @bew_bi16c_rep08u;
      rep16c: if lew then Proc := @lew_bi16c_rep16c else Proc := @bew_bi16c_rep16c;
      rep16u: if lew then Proc := @lew_bi16c_rep16u else Proc := @bew_bi16c_rep16u;
      rep32c: if lew then Proc := @lew_bi16c_rep32c else Proc := @bew_bi16c_rep32c;
      rep32u: if lew then Proc := @lew_bi16c_rep32u else Proc := @bew_bi16c_rep32u;
      rep64c: if lew then Proc := @lew_bi16c_rep64c else Proc := @bew_bi16c_rep64c;
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
      rep80f: if lew then Proc := @lew_bi32c_rep80f_z else Proc := @bew_bi32c_rep80f_z;
      rep64f: if lew then Proc := @lew_bi32c_rep64f_z else Proc := @bew_bi32c_rep64f_z;
      rep32f: if lew then Proc := @lew_bi32c_rep32f_z else Proc := @bew_bi32c_rep32f_z;
      rep08c: if lew then Proc := @lew_bi32c_rep08c_z else Proc := @bew_bi32c_rep08c_z;
      rep08u: if lew then Proc := @lew_bi32c_rep08u_z else Proc := @bew_bi32c_rep08u_z;
      rep16c: if lew then Proc := @lew_bi32c_rep16c_z else Proc := @bew_bi32c_rep16c_z;
      rep16u: if lew then Proc := @lew_bi32c_rep16u_z else Proc := @bew_bi32c_rep16u_z;
      rep32c: if lew then Proc := @lew_bi32c_rep32c_z else Proc := @bew_bi32c_rep32c_z;
      rep32u: if lew then Proc := @lew_bi32c_rep32u_z else Proc := @bew_bi32c_rep32u_z;
      rep64c: if lew then Proc := @lew_bi32c_rep64c_z else Proc := @bew_bi32c_rep64c_z;
    end
    else if e then
    case UserRep of
      rep80f: if lew then Proc := @lew_bi32c_rep80f_e else Proc := @bew_bi32c_rep80f_e;
      rep64f: if lew then Proc := @lew_bi32c_rep64f_e else Proc := @bew_bi32c_rep64f_e;
      rep32f: if lew then Proc := @lew_bi32c_rep32f_e else Proc := @bew_bi32c_rep32f_e;
      rep08c: if lew then Proc := @lew_bi32c_rep08c_e else Proc := @bew_bi32c_rep08c_e;
      rep08u: if lew then Proc := @lew_bi32c_rep08u_e else Proc := @bew_bi32c_rep08u_e;
      rep16c: if lew then Proc := @lew_bi32c_rep16c_e else Proc := @bew_bi32c_rep16c_e;
      rep16u: if lew then Proc := @lew_bi32c_rep16u_e else Proc := @bew_bi32c_rep16u_e;
      rep32c: if lew then Proc := @lew_bi32c_rep32c_e else Proc := @bew_bi32c_rep32c_e;
      rep32u: if lew then Proc := @lew_bi32c_rep32u_e else Proc := @bew_bi32c_rep32u_e;
      rep64c: if lew then Proc := @lew_bi32c_rep64c_e else Proc := @bew_bi32c_rep64c_e;
    end
    else {not z, e}
    case UserRep of
      rep80f: if lew then Proc := @lew_bi32c_rep80f else Proc := @bew_bi32c_rep80f;
      rep64f: if lew then Proc := @lew_bi32c_rep64f else Proc := @bew_bi32c_rep64f;
      rep32f: if lew then Proc := @lew_bi32c_rep32f else Proc := @bew_bi32c_rep32f;
      rep08c: if lew then Proc := @lew_bi32c_rep08c else Proc := @bew_bi32c_rep08c;
      rep08u: if lew then Proc := @lew_bi32c_rep08u else Proc := @bew_bi32c_rep08u;
      rep16c: if lew then Proc := @lew_bi32c_rep16c else Proc := @bew_bi32c_rep16c;
      rep16u: if lew then Proc := @lew_bi32c_rep16u else Proc := @bew_bi32c_rep16u;
      rep32c: if lew then Proc := @lew_bi32c_rep32c else Proc := @bew_bi32c_rep32c;
      rep32u: if lew then Proc := @lew_bi32c_rep32u else Proc := @bew_bi32c_rep32u;
      rep64c: if lew then Proc := @lew_bi32c_rep64c else Proc := @bew_bi32c_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX32C}
  {$IFDEF DELABITPIX64C}
  if BitPix = bi64c then
  begin
    e := (BScale <> 1.0) or (BZero <> 0.0);
    if e then
    case UserRep of
      rep80f: if lew then Proc := @lew_bi64c_rep80f_e else Proc := @bew_bi64c_rep80f_e;
      rep64f: if lew then Proc := @lew_bi64c_rep64f_e else Proc := @bew_bi64c_rep64f_e;
      rep32f: if lew then Proc := @lew_bi64c_rep32f_e else Proc := @bew_bi64c_rep32f_e;
      rep08c: if lew then Proc := @lew_bi64c_rep08c_e else Proc := @bew_bi64c_rep08c_e;
      rep08u: if lew then Proc := @lew_bi64c_rep08u_e else Proc := @bew_bi64c_rep08u_e;
      rep16c: if lew then Proc := @lew_bi64c_rep16c_e else Proc := @bew_bi64c_rep16c_e;
      rep16u: if lew then Proc := @lew_bi64c_rep16u_e else Proc := @bew_bi64c_rep16u_e;
      rep32c: if lew then Proc := @lew_bi64c_rep32c_e else Proc := @bew_bi64c_rep32c_e;
      rep32u: if lew then Proc := @lew_bi64c_rep32u_e else Proc := @bew_bi64c_rep32u_e;
      rep64c: if lew then Proc := @lew_bi64c_rep64c_e else Proc := @bew_bi64c_rep64c_e;
    end
    else {not e}
    case UserRep of
      rep80f: if lew then Proc := @lew_bi64c_rep80f else Proc := @bew_bi64c_rep80f;
      rep64f: if lew then Proc := @lew_bi64c_rep64f else Proc := @bew_bi64c_rep64f;
      rep32f: if lew then Proc := @lew_bi64c_rep32f else Proc := @bew_bi64c_rep32f;
      rep08c: if lew then Proc := @lew_bi64c_rep08c else Proc := @bew_bi64c_rep08c;
      rep08u: if lew then Proc := @lew_bi64c_rep08u else Proc := @bew_bi64c_rep08u;
      rep16c: if lew then Proc := @lew_bi64c_rep16c else Proc := @bew_bi64c_rep16c;
      rep16u: if lew then Proc := @lew_bi64c_rep16u else Proc := @bew_bi64c_rep16u;
      rep32c: if lew then Proc := @lew_bi64c_rep32c else Proc := @bew_bi64c_rep32c;
      rep32u: if lew then Proc := @lew_bi64c_rep32u else Proc := @bew_bi64c_rep32u;
      rep64c: if lew then Proc := @lew_bi64c_rep64c else Proc := @bew_bi64c_rep64c;
    end;
  end;
  {$ENDIF DELABITPIX64C}
end;

end.
