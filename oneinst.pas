unit oneinst;

interface

uses
  Windows, Forms, Messages, clipBrd, regutil;

var premierAppel : boolean = true;   

implementation

var hSemaphore : integer;

Procedure AppelFichier(Wnd: HWnd);
const WM_Reg_Fichier = WM_USER + 3;
var NomFichier,zz : string;
    i : integer;
begin
    NomFichier := '';
    for i := 1 to paramCount do begin
        zz := ParamStr(i);
        if zz[1]<>'/' // options
           then if NomFichier=''
              then NomFichier := zz
              else NomFichier := NomFichier+' '+zz;
    end;
    if NomFichier<>'' then begin
       ClipBoard.AsText := NomFichier;
       PostMessage(Wnd,wm_reg_fichier,1,0);
    end;
end;


Function LanceDeuxFois : boolean;
var chaine : String;
    i : integer;
begin
    result := false;
    for i := 1 to ParamCount do begin
       chaine := ParamStr(i);
       if (length(chaine)=2) and
          (chaine[1]='/') and
          (upcase(chaine[2])='N') then begin
          result := true;
          premierAppel := false;
          break;
       end;
     end;
end;

procedure RestoreWindow(aFormName: string);
var
  Wnd,
  App: HWND;
begin
  Wnd := FindWindow(PChar(aFormName), nil);
  if (Wnd <> 0) then begin // Set Window to foreground
    App := GetWindowLong(Wnd, GWL_HWNDPARENT);
    if IsIconic(App) then
      ShowWindow(App, SW_RESTORE);

    SetForegroundwindow(App);
  end;
end;

procedure EnsureSingleInstance;
var
  Wnd,FormMainWnd: HWnd;
  WndClass, WndText: array[0..255] of char;
  WndClassStr, WndTextStr: string;
begin
{ Try and create a semaphore. If we succeed, then check
  if the semaphore was already present. If it was
  then a previous instance is floating around.
  Note the OS will free the returned semaphore handle
  when the app shuts so we can forget about it }
 //  InitOnceExcecuteOnce utilisé par VLC
  hSemaphore := CreateSemaphore(nil,0,1,'Regressi');
  if (hSemaphore<>0) and
     (GetLastError = Error_Already_Exists) then begin
    if LanceDeuxFois then exit;
    Wnd := GetWindow(Application.Handle,gw_HWndFirst);
    FormMainWnd := 0;
    while Wnd <> 0 do begin
      // Look for the other TApplication window out there
      if Wnd <> Application.Handle then begin
        // Check it's definitely got the same class and caption
        GetClassName(Wnd, WndClass, Pred(SizeOf(WndClass)));
        GetWindowText(Wnd, WndText, Pred(SizeOf(WndText)));
        WndClassStr := string(WndClass);
        WndTextStr := string(WndText);
        if (WndClassStr = 'TFRegressiMain') then FormMainWnd := Wnd;
        if (WndClassStr = Application.ClassName) and
           (WndTextStr = Application.Title) then begin
          { This technique is used by the VCL: post
           a message then bring the window to the
           top, before the message gets processed }
          PostMessage(Wnd, wm_SysCommand, sc_Restore, 0);
          SetForeGroundWindow(Wnd);
          if paramCount>0 then if FormMainWnd=0
             then AppelFichier(Wnd)
             else AppelFichier(FormMainWnd);
          Halt
        end
      end;
      Wnd := GetWindow(Wnd, gw_HWndNext);
    end
  end
end;

initialization
  EnsureSingleInstance
end.
