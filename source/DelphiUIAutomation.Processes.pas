unit DelphiUIAutomation.Processes;

interface

uses
  Windows,
  generics.collections,
  TlHelp32;

type
  TAutomationProcesses = class
  strict private
    FItems : TList<TProcessEntry32>;
  private
    function getProcesses : TList<TProcessEntry32>;
  public
    /// <summary>
    ///  Constructor
    /// </summary>
    constructor create;

    /// <summary>
    ///  Get the list of processes
    /// </summary>
    property Processes : TList<TProcessEntry32> read getProcesses;
  end;

implementation

{ TAutomationProcesses }

constructor TAutomationProcesses.create;
var
  Snapshot: THandle;
  pe: TProcessEntry32;

begin
  FItems := TList<TProcessEntry32>.create;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  try
    pe.dwSize := SizeOf(pe);
    if Process32First(Snapshot, pe) then
      while Process32Next(Snapshot, pe) do
      begin
        writeln (pe.szExeFile);
        FItems.Add(pe);
      end;
  finally
    CloseHandle(Snapshot);
  end;
end;

function TAutomationProcesses.getProcesses: TList<TProcessEntry32>;
begin
  result := self.FItems;
end;

end.
