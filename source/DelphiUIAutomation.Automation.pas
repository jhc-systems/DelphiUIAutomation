unit DelphiUIAutomation.Automation;

interface

uses
  generics.collections,
  winapi.windows,
  UIAutomationClient_TLB;

var
  UIAuto: IUIAutomation;
  RootElement: IUIAutomationElement;

implementation


uses
  sysutils,
  ActiveX;

function ExecNewProcess(Command, Parameters : String; Wait: Boolean) : TProcessInformation;
var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  CreateOK : Boolean;

begin
  UniqueString(Command);
  UniqueString(parameters);

  { fill with known state }
  FillChar(StartInfo,SizeOf(TStartupInfo), 0);
  FillChar(ProcInfo,SizeOf(TProcessInformation), 0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcess(PChar(Command), PChar(parameters),
              nil, nil,False,
              CREATE_NEW_PROCESS_GROUP or NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);

  { check to see if successful }
  if not CreateOK then
  begin
    raise Exception.Create(SysErrorMessage(GetLastError()));
  end;

// LEAKING them for now
//  CloseHandle(ProcInfo.hProcess);
//  CloseHandle(ProcInfo.hThread);

  result := ProcInfo;
end;

initialization
  UIAuto := CoCUIAutomation.Create;
  if not Succeeded(UIAuto.GetRootElement(RootElement)) then
    raise Exception.Create('Failed to get root element for Automation');

end.
