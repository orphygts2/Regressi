unit keysu;

interface

uses
  Windows, Forms, SysUtils;


// Déclarations des structures utilisées par SendInput
Type
tMOUSEINPUT    = record
dx          : longint;
dy          : longint;
mousedata   : DWORD;
dwFlags     : DWORD;
time        : DWORD;
dwExtraInfo : DWORD;
end;
pMOUSEINPUT    = ^tMOUSEINPUT;

tKEYBDINPUT    = record
wVk         : WORD;
wScan       : WORD;
dwFlags     : DWORD;
time        : DWORD;
dwExtraInfo : DWORD;
end;
pKEYBDINPUT    = ^tKEYBDINPUT;

tHARDWAREINPUT = record
uMsg        : DWORD;
wParamL     : WORD;
wParamH     : WORD;
dwExtraInfo : DWORD;
end;
pHARDWAREINPUT = ^tHARDWAREINPUT;

tINPUT         = record
case typeInput : DWORD of
INPUT_MOUSE    : (mi:tMOUSEINPUT);
INPUT_KEYBOARD : (ki:tKEYBDINPUT);
INPUT_HARDWARE : (hi:tHARDWAREINPUT);
end;
pINPUT         = ^tINPUT;

procedure PressKey(Key: Char);
procedure ReleaseKey(Key: Char);
procedure SendKeys(const Keys: String);
procedure SendVirtualKey(vk: word);
function SendInput(cInputs:UINT;pInputs:pINPUT;cbSize:integer):uint;stdcall;

implementation

const
  KeyEventF_KeyDown = 0;

procedure PostVirtualKeyEvent(vk: Word; fUp: Boolean);
var
  ScanCode: Byte;
const
  ButtonUp: array[Boolean] of Byte = (KeyEventF_KeyDown, KeyEventF_KeyUp);
begin
  ScanCode := MapVirtualKey(vk, 0);
  Keybd_Event(vk, ScanCode, ButtonUp[fUp], 0);
end;

procedure SendVirtualKey(vk: word);
begin
  PostVirtualKeyEvent(vk, False);
  PostVirtualKeyEvent(vk, True)
end;

procedure PressKey(Key: Char);
begin
  PostVirtualKeyEvent(Ord(Key), False)
end;

procedure ReleaseKey(Key: Char);
begin
  PostVirtualKeyEvent(Ord(Key), True)
end;

procedure SendKeys(const Keys: String);
var
  Loop: Byte;
begin
  for Loop := 1 to Length(Keys) do begin
    PostVirtualKeyEvent(Ord(Keys[Loop]), False); { Press key }
    PostVirtualKeyEvent(Ord(Keys[Loop]), True);  { Release key }
  end;
  { Let the keys be processed }
  Application.ProcessMessages;
end;

function SendInput; external 'user32.dll'  name 'SendInput';

end.
