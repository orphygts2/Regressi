{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{                                                      }
{      Swapping bytes, determination of the order      }
{                of bytes in the system                }
{                                                      }
{                Semantics procedures:                 }
{     Swap__xy -> swapping value type x to type y      }
{                                                      }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

unit DeLaFitsOrderByte;

interface

uses
  DeLaFitsCommon;

  function SysOrderByte: TSysOrderByte;

  function Swap64cc(const Value: T64c): T64c;
  function Swap64cf(const Value: T64c): T64f; // Only! for read proc, see unit DeLaFitsDataRead
  function Swap64ff(const Value: T64f): T64f;

  function Swap32cc(const Value: T32c): T32c;
  function Swap32cf(const Value: T32c): T32f; // Only! for read proc, see unit DeLaFitsDataRead
  function Swap32ff(const Value: T32f): T32f;

  function Swap16cc(const Value: T16c): T16c;

implementation

{ Get current order byte in system }

function SysOrderByte: TSysOrderByte;
const
  A: array [0 .. 1] of Byte = ($12, $34);
var
  X: Word;
begin
  X := 0;
  Move(A[0], X, 2);
  if X = $1234 then
    Result := sobBe
  else { X = $3412 }
    Result := sobLe
end;

{ Swap bytes: 64 bit }

type
  TRec64 = packed record
    Lo, Hi: T32u;
  end;

function Swap64cc(const Value: T64c): T64c;
begin
  with TRec64(Value) do
  begin
    TRec64(Result).Hi := (Lo shr 24) or (Lo shl 24) or ((Lo and $00FF0000) shr 8) or ((Lo and $0000FF00) shl 8);
    TRec64(Result).Lo := (Hi shr 24) or (Hi shl 24) or ((Hi and $00FF0000) shr 8) or ((Hi and $0000FF00) shl 8);
  end;
end;

function Swap64cf(const Value: T64c): T64f;
begin
  with TRec64(Value) do
  begin
    TRec64(Result).Hi := (Lo shr 24) or (Lo shl 24) or ((Lo and $00FF0000) shr 8) or ((Lo and $0000FF00) shl 8);
    TRec64(Result).Lo := (Hi shr 24) or (Hi shl 24) or ((Hi and $00FF0000) shr 8) or ((Hi and $0000FF00) shl 8);
  end;
end;

function Swap64ff(const Value: T64f): T64f;
begin
  with TRec64(Value) do
  begin
    TRec64(Result).Hi := (Lo shr 24) or (Lo shl 24) or ((Lo and $00FF0000) shr 8) or ((Lo and $0000FF00) shl 8);
    TRec64(Result).Lo := (Hi shr 24) or (Hi shl 24) or ((Hi and $00FF0000) shr 8) or ((Hi and $0000FF00) shl 8);
  end;
end;

{ Swap bytes: 32 bit }

type
  TRec32 = packed record
    Lo, Hi: T16u;
  end;

function Swap32cc(const Value: T32c): T32c;
var
  R: TRec32;
begin
  R := TRec32(Value);
  TRec32(Result).Hi := Swap(R.Lo);
  TRec32(Result).Lo := Swap(R.Hi);
end;

function Swap32cf(const Value: T32c): T32f;
var
  R: TRec32;
begin
  R := TRec32(Value);
  TRec32(Result).Hi := Swap(R.Lo);
  TRec32(Result).Lo := Swap(R.Hi);
end;

function Swap32ff(const Value: T32f): T32f;
var
  R: TRec32;
begin
  R := TRec32(Value);
  TRec32(Result).Hi := Swap(R.Lo);
  TRec32(Result).Lo := Swap(R.Hi);
end;

{ Swap bytes: 16 bit }

function Swap16cc(const Value: T16c): T16c;
begin
  Result := T16c(System.Swap(Value));
end;

end.
