{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{                                                                           }
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
  DelphiUIAutomation.Window,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  The main automation application wrapper
  /// </summary>
  TAutomationApplication = class
  strict private
    FProcessInfo : TProcessInformation;
    function getProcID: THandle;
  public
    /// <summary>
    /// Creates an application
    /// </summary>
    constructor Create(processInfo: TProcessInformation);

    /// <summary>
    ///  Launches an application
    /// </summary>
    class function Launch(executable, parameters : String) : TAutomationApplication;

    /// <summary>
    ///  Attaches to an already running application
    /// </summary>
    class function Attach (exectable : String) : TAutomationApplication;

    /// <summary>
    ///  Launches or attaches to an application
    /// </summary>
    class function LaunchOrAttach(executable, parameters : String) : TAutomationApplication;

    ///<summary>
    ///  Kills the application being automated
    ///</summary>
    procedure Kill;

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
  DelphiUIAutomation.Utils,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ScreenShot,
  sysutils,
  ActiveX;

{ TAutomationApplication }

class function TAutomationApplication.Attach(
  exectable: String): TAutomationApplication;
begin
  raise Exception.Create('Not yet implemented');
end;

constructor TAutomationApplication.Create(processInfo: TProcessInformation);
begin
  FprocessInfo := processInfo;
end;

function TAutomationApplication.getProcID: THandle;
begin
  result := FprocessInfo.hProcess;
end;

procedure TAutomationApplication.Kill;
begin
  if FprocessInfo.hProcess <> 0 then
  begin
    TerminateProcess(FprocessInfo.hProcess, 0);
    CloseHandle(FprocessInfo.hProcess);
  end;
end;

class function TAutomationApplication.Launch(executable,
  parameters: String): TAutomationApplication;
var
  info : TProcessInformation;

begin
  info := ExecNewProcess(executable, parameters, false);

  result := TAutomationApplication.Create(info);
end;

class function TAutomationApplication.LaunchOrAttach(executable,
  parameters: String): TAutomationApplication;
begin
  raise Exception.Create('Not yet implemented');
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

end.

