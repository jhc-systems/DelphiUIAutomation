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
  IAutomationApplication = interface
    ['{82CC20ED-7DA4-48D4-B46D-09D059606A15}']
    procedure WaitWhileBusy;

    function GetAttached: boolean;

    /// <summary>
    ///  Gets whether the process was attached or started
    /// </summary>
    property IsAttached : boolean read GetAttached;

    ///<summary>
    ///  Kills the application being automated
    ///</summary>
    procedure Kill;
  end;

  /// <summary>
  ///  The main automation application wrapper
  /// </summary>
  TAutomationApplication = class (TInterfacedObject, IAutomationApplication)
  strict private
    FProcess : THandle;
    FAttached : boolean;
  private
    function getProcID: THandle;
    function GetAttached: boolean;
  public
    /// <summary>
    /// Creates an application
    /// </summary>
    constructor Create(process: THandle; IsAttached : boolean = false);

    /// <summary>
    ///  Launches an application
    /// </summary>
    class function Launch(executable, parameters : String) : IAutomationApplication;

    /// <summary>
    ///  Attaches to an already running application
    /// </summary>
    class function Attach (process: TProcessEntry32) : IAutomationApplication;

    /// <summary>
    ///  Launches or attaches to an application
    /// </summary>
    class function LaunchOrAttach(executable, parameters : String) : IAutomationApplication;

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

    /// <summary>
    ///  Gets whether the process was attached or started
    /// </summary>
    property IsAttached : boolean read GetAttached;
  end;

implementation

uses
  sysutils,
  ActiveX,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Processes,
  DelphiUIAutomation.Utils,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ScreenShot;

{ TAutomationApplication }

class function TAutomationApplication.Attach(process: TProcessEntry32): IAutomationApplication;
//var
//  info : TProcessInformation;

begin
//  info.hProcess := process.th32ProcessID;
//  info.hThread := 0;
//  info.dwProcessId := 0;
//  info.dwThreadId := 0;

  result := TAutomationApplication.Create(process.th32ProcessID, true);
end;

constructor TAutomationApplication.Create(process: THandle; IsAttached : boolean = false);
begin
  FProcess := process;
  FAttached := IsAttached;
end;

function TAutomationApplication.GetAttached: boolean;
begin
  result := FAttached;
end;

function TAutomationApplication.getProcID: THandle;
begin
  result := FProcess;
end;

function TerminateProcessByID(ProcessID: Cardinal; IsAttached : boolean): Boolean;
var
  hProcess : THandle;
begin
  Result := False;

  // If we attached to an already running process, then we need to open the handle
  if (IsAttached) then
  begin
    hProcess := OpenProcess(PROCESS_TERMINATE,False,ProcessID);

    if hProcess > 0 then
    try
      Result := Win32Check(TerminateProcess(hProcess,0));
    finally
      CloseHandle(hProcess);
    end;
  end
  else
  begin
    try
      Result := Win32Check(TerminateProcess(ProcessID,0));
    finally
      CloseHandle(ProcessID);
    end;
  end;
end;

procedure TAutomationApplication.Kill;
begin
  if FProcess <> 0 then
  begin
    TerminateProcessByID(FProcess, self.FAttached);
  end;
end;

class function TAutomationApplication.Launch(executable,
  parameters: String): IAutomationApplication;
var
  info : TProcessInformation;
  actualParameters : string;

begin
  if (parameters <> '') then
  begin
    actualParameters := string.Format('%s %s',
      [executable, parameters]);
  end;

  info := ExecNewProcess(executable, actualParameters, false);

  result := TAutomationApplication.Create(info.hProcess);
end;

class function TAutomationApplication.LaunchOrAttach(executable,
  parameters: String): IAutomationApplication;
var
  exename : string;
  Processes : TAutomationProcesses;
  process : TProcessEntry32;

begin
  exename := ExtractFileName(executable);

  processes := TAutomationProcesses.create;
  try
    // See whether we can get hold of the process
    try
      // Found a running application
      process := processes.FindProcess(exename);
      result := self.Attach(process);
    except on EDelphiAutomationException do
      result := self.Launch(executable, parameters);
    end;
  finally
    processes.Free;
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

