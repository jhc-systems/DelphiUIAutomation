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
unit DelphiUIAutomation.Client;

interface

uses
  generics.collections,
  winapi.windows,
  TlHelp32,
  DelphiUIAutomation.Window,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  The main automation application wrapper
  /// </summary>
  TAutomationApplication = class
  strict private
//    FProcessInfo : TProcessInformation;
    FProcess : THandle;
    function getProcID: THandle;
  public
    /// <summary>
    /// Creates an application
    /// </summary>
    constructor Create(process: THandle);

    /// <summary>
    ///  Launches an application
    /// </summary>
    class function Launch(executable, parameters : String) : TAutomationApplication;

    /// <summary>
    ///  Attaches to an already running application
    /// </summary>
    class function Attach (process: TProcessEntry32) : TAutomationApplication;

    /// <summary>
    ///  Launches or attaches to an application
    /// </summary>
    class function LaunchOrAttach(executable, parameters : String) : TAutomationApplication;

    ///<summary>
    ///  Kills the application being automated
    ///</summary>
    procedure Kill;

    /// <summary>
    /// Waits while the application is busy - INFINITE timeout
    /// </summary>
    procedure WaitWhileBusy; overload;

    /// <summary>
    /// Waits while the application is busy, with a given timeout
    /// </summary>
    procedure WaitWhileBusy(timeout : DWORD); overload;

    /// <summary>
    ///  Saves the current screen image to a file
    /// </summary>
    class procedure SaveScreenshot;

    /// <summary>
    ///  Gets the process
    /// </summary>
    property Process : THandle read getProcID;
  end;

implementation

uses
  sysutils,
  ActiveX,
  DelphiUIAutomation.Processes,
  DelphiUIAutomation.Utils,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ScreenShot;

{ TAutomationApplication }

class function TAutomationApplication.Attach(process: TProcessEntry32): TAutomationApplication;
//var
//  info : TProcessInformation;

begin
//  info.hProcess := process.th32ProcessID;
//  info.hThread := 0;
//  info.dwProcessId := 0;
//  info.dwThreadId := 0;

  result := TAutomationApplication.Create(process.th32ProcessID);
end;

constructor TAutomationApplication.Create(process: THandle);
begin
 // FprocessInfo := processInfo;

  FProcess := process;
end;

function TAutomationApplication.getProcID: THandle;
begin
  result := FProcess;
end;

procedure TAutomationApplication.Kill;
begin
  if FProcess <> 0 then
  begin
    TerminateProcess(FProcess, 0);
    CloseHandle(FProcess);
  end;
end;

class function TAutomationApplication.Launch(executable,
  parameters: String): TAutomationApplication;
var
  info : TProcessInformation;

begin
  info := ExecNewProcess(executable, parameters, false);

  result := TAutomationApplication.Create(info.hProcess);
end;

class function TAutomationApplication.LaunchOrAttach(executable,
  parameters: String): TAutomationApplication;
var
  exename : string;
  Processes : TAutomationProcesses;
  process, p : TProcessEntry32;
  found : boolean;
  count : integer;

begin
  exename := ExtractFileName(executable);

  processes := TAutomationProcesses.create;
  found := false;
  try
    for count := 0 to Processes.Processes.count -1 do
    begin
      p := Processes.Processes[count];
      if p.szExeFile = exename then
      begin
        process := p;
        found := true;
        break;
      end;
    end;
  finally
    processes.Free;
  end;

  if (found) then
  begin
    result := self.Attach(process);
  end
  else
  begin
    result := self.Launch(executable, parameters);
  end;
end;

class procedure TAutomationApplication.SaveScreenshot;
var
  screenshot : TAutomationScreenshot;
begin

  screenshot := TAutomationScreenshot.Create;

  try
    screenshot.SaveCurrentScreen;
  finally
    screenshot.Free;
  end;
end;

procedure TAutomationApplication.WaitWhileBusy(timeout: DWORD);
begin
  WaitForInputIdle(self.FProcess, timeout);
end;

procedure TAutomationApplication.WaitWhileBusy;
begin
  WaitWhileBusy(INFINITE);
end;

end.

