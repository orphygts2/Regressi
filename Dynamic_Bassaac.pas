{

********************************************************************************

  Dynamic_Bassaac.pas written by Wishmaster
  Updated by Wishmaster 02/11/2018

********************************************************************************

}


unit Dynamic_Bassaac;

interface

uses
 {$IFDEF LINUX}
  Libc
 {$ENDIF}
 {$IFDEF MSWINDOWS}
  Windows,
 {$ENDIF}
  Dynamic_Bass;


const
{$IFDEF MSWINDOWS}
  bassaacdll = 'bass_aac.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassaacdll = 'libbass_aac.so';
{$ENDIF}
{$IFDEF MACOS}
  bassaacdll = 'libbass_aac.dylib';
{$ENDIF}


const
  // additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_MP4_NOSTREAM = 6000; // non-streamable due to MP4 atom order ("mdat" before "moov")

  // additional BASS_SetConfig options
  BASS_CONFIG_MP4_VIDEO = $10700; // play the audio from MP4 videos
  BASS_CONFIG_AAC_MP4 = $10701; // support MP4 in BASS_AAC_StreamCreateXXX functions (no need for BASS_MP4_StreamCreateXXX)
  BASS_CONFIG_AAC_PRESCAN = $10702; // pre-scan ADTS AAC files for seek points and accurate length

  // additional BASS_AAC_StreamCreateFile/etc flags
  BASS_AAC_FRAME960 = $1000; // 960 samples per frame
  BASS_AAC_STEREO = $400000; // downmatrix to stereo

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_AAC = $10b00; // AAC
  BASS_CTYPE_STREAM_MP4 = $10b01; // MP4



var
 BASS_AAC_StreamCreateFile:function(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
 BASS_AAC_StreamCreateURL:function(URL:PChar; offset:DWORD; flags:DWORD; proc:DOWNLOADPROC; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
 BASS_AAC_StreamCreateFileUser:function(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
 BASS_MP4_StreamCreateFile:function(mem:BOOL; f:Pointer; offset,length:QWORD; flags:DWORD): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
 BASS_MP4_StreamCreateFileUser:function(system,flags:DWORD; var procs:BASS_FILEPROCS; user:Pointer): HSTREAM; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};




var
 BASSAAC_Handle:Thandle = 0;

function Load_BASSAACDLL(const dllfilename : string) : boolean;
procedure Unload_BASSAACDLL;

implementation

function Load_BASSAACDLL(const dllfilename : string) : boolean;
{$IFDEF MSWINDOWS}
	var oldmode : integer;
{$ENDIF}
begin
 if BASSAAC_Handle <> 0 then // is it already there ?
  Result:= true
 else
  begin {go & load the dll}
   {$IFDEF MSWINDOWS}
     oldmode := SetErrorMode($8001);
   {$ENDIF}

   {$IFDEF UNICODE}
     BASSAAC_Handle:= LoadLibraryW(PWideChar(dllfilename));
   {$ELSE}
     BASSCD_Handle:= LoadLibrary(PChar(dllfilename));
   {$ENDIF}

   {$IFDEF MSWINDOWS}
    SetErrorMode(oldmode);
   {$ENDIF}
   if BASSAAC_Handle <> 0 then
    begin
     BASS_AAC_StreamCreateFile:= GetProcAddress(BASSAAC_Handle, PChar('BASS_AAC_StreamCreateFile'));
     BASS_AAC_StreamCreateURL:= GetProcAddress(BASSAAC_Handle, PChar('BASS_AAC_StreamCreateURL'));
     BASS_AAC_StreamCreateFileUser:= GetProcAddress(BASSAAC_Handle, PChar('BASS_AAC_StreamCreateFileUser'));
     BASS_MP4_StreamCreateFile:= GetProcAddress(BASSAAC_Handle, PChar('BASS_MP4_StreamCreateFile'));
     BASS_MP4_StreamCreateFileUser:= GetProcAddress(BASSAAC_Handle, PChar('BASS_MP4_StreamCreateFileUser'));

 if (@BASS_AAC_StreamCreateFile = nil) or
    (@BASS_AAC_StreamCreateURL = nil) or
    (@BASS_AAC_StreamCreateFileUser = nil) or
    (@BASS_MP4_StreamCreateFile = nil) or
    (@BASS_MP4_StreamCreateFileUser = nil) then
    begin
     FreeLibrary(BASSAAC_Handle);
     BASSAAC_Handle:= 0;
    end;
   end;
   Result:= (BASSAAC_Handle <> 0);
  end;
end;

procedure Unload_BASSAACDLL;
begin
  if BASSAAC_Handle <> 0 then
   FreeLibrary(BASSAAC_Handle);
   BASSAAC_Handle := 0;
end;

end.
