{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015 JHC Systems Limited                              }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}
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
    ///  Destructor
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///  Get the list of processes
    /// </summary>
    property Processes : TList<TProcessEntry32> read getProcesses;

    /// <summary>
    ///  Finds the first process with the given name
    /// </summary>
    function FindProcess(const name: string): TProcessEntry32;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  sysutils;

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
        FItems.Add(pe);
  finally
    CloseHandle(Snapshot);
  end;
end;

destructor TAutomationProcesses.Destroy;
begin
//  FreeAndNil(FItems);

  inherited;
end;

function TAutomationProcesses.getProcesses: TList<TProcessEntry32>;
begin
  result := self.FItems;
end;

function TAutomationProcesses.FindProcess (const name : string) : TProcessEntry32;
var
  count : integer;
  p : TProcessEntry32;
  found : boolean;

begin
  found := false;

  try
    for count := 0 to self.Processes.count -1 do
    begin
      p := self.Processes[count];
      if p.szExeFile = name then
      begin
        result := p;
        found := true;
        break;
      end;
    end;
  finally
    processes.Free;
  end;

  if not found then
    raise EDelphiAutomationException.Create('Failed to find process - ' + name);
end;

end.
