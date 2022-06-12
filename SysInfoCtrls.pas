{ SysInfoCtrls Suite written by Simone Di Cicco - Italy
 This Component/Unit give you some System Information:
   Thank you for choosing my component
   You can contact me at this E-Mail address:
   simone.dicicco@tin.it or  whisper@email.it
   http://www.devresource.net
}

unit SysInfoCtrls;

interface

uses
  Messages, SysUtils, Classes, Windows, Registry;

const
 About = 'InfoCtrl component written by Simone Di Cicco';
 DateFormat = 'dd/mm/yyyy';

type

  TWinInfo = class(TComponent)
    private
      function GetUserName:    string;
      function GetCompanyName: string;
      function GetCfgPath:     string;
      function GetProgramDir:  string;
      function GetSysRoot:     string;
    public
      property    UserName:    string read GetUsername;
      property    CompanyName: string read GetCompanyName;
      property    CfgPath:     string read GetCfgPath;
      property    ProgramDir:  string read GetProgramDir;
      property    SysRoot:     string read GetSysRoot;
      constructor Create(AOwner: TComponent); override;
  end;

var
   winInfo : TwinInfo;

implementation

{ TWinInfo }

constructor TWinInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TWinInfo.GetCfgPath: string;
var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True);
  Result := Reg.ReadString('ConfigPath');
end;

function TWinInfo.GetCompanyName: string;
 var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True);
  Result := Reg.ReadString('RegisteredOrganization');
end;


function TWinInfo.GetProgramDir: string;
 var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True);
  Result := Reg.ReadString('ProgramFilesPath');
end;

function TWinInfo.GetSysRoot: string;
 var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True);
  Result := Reg.ReadString('SystemRoot');
end;

function TWinInfo.GetUserName: string;
 var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey('\Volatile Environment', True);
  Result := Reg.ReadString('UserName');
end;

initialization
   winInfo := TwinInfo.create(nil);
end.

