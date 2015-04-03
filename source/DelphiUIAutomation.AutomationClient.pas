unit DelphiUIAutomation.AutomationClient;

interface

uses
  generics.collections,
  winapi.windows,
  DelphiUIAutomation.AutomationWindow,
  UIAutomationClient_TLB;

type
  TAutomationClient = class
  strict private
    FprocessInfo : TProcessInformation;
  public
    constructor Create(processInfo: TProcessInformation);

    function getProcID: THandle;
    class function Launch(executable, parameters : String) : TAutomationClient;
    class function GetDesktopWindows : TList<TAutomationWindow>;
    class function GetDesktopWindow (const title : String) : TAutomationWindow;

    property Process : THandle read getProcID;
  end;

implementation

uses
  DelphiUIAutomation.Utils,
  DelphiUIAutomation.Automation,
  sysutils,
  ActiveX;

{ TAutomationClient }

constructor TAutomationClient.Create(processInfo: TProcessInformation);
begin
  FprocessInfo := processInfo;
end;

class function TAutomationClient.GetDesktopWindow(const title : String): TAutomationWindow;
var
  windows : TList<TAutomationWindow>;
  window : TAutomationWindow;
  count : integer;

begin
  windows := TAutomationClient.GetDesktopWindows;

  for count := 0 to windows.Count -1 do
  begin
    window := windows[count];

    if (window.Name = title) then
    begin
      result := window;
      break;
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find window');
end;

class function TAutomationClient.getDesktopWindows: TList<TAutomationWindow>;
var
  res : TList<TAutomationWindow>;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  element : IUIAutomationElement;
  name : WideString;
  count, length : integer;

begin
  res := TList<TAutomationWindow>.create();

  UIAuto.CreateTrueCondition(condition);

  rootElement.FindAll(TreeScope_Children, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentName(name);
 //   Writeln(name);

    res.Add(TAutomationWindow.create(element));
  end;

  result := res;
end;

function TAutomationClient.getProcID: THandle;
begin
  result := FprocessInfo.hProcess;
end;

class function TAutomationClient.Launch(executable,
  parameters: String): TAutomationClient;
var
  info : TProcessInformation;

begin
  info := ExecNewProcess(executable, parameters, false);

  result := TAutomationClient.Create(info);
end;

end.

