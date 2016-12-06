{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015-16 JHC Systems Limited                              }
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
unit TestMainForm;

interface

uses
  TestFramework,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.Window,
  DelphiUIAutomation.Client,
  DelphiUIAutomation.Desktop;

type
  TestIAutomationBase = class(TTestCase)
  strict private
    FApplication: IAutomationApplication;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Example;
  end;

implementation

{ TestIAutomationBase }

procedure TestIAutomationBase.Example;
var
  MainWindow: IAutomationWindow;
begin
  MainWindow := TAutomationDesktop.GetDesktopWindow('Form1', 5000); // crash

  MainWindow.GetButton('OK').Click;
end;

procedure TestIAutomationBase.SetUp;
begin
  inherited;

  FApplication := TAutomationApplication.LaunchOrAttach('..\..\..\demo\democlient\Win32\Debug\Project1.exe', '');

  FApplication.WaitWhileBusy;
end;

procedure TestIAutomationBase.TearDown;
begin
  inherited;

  FApplication.Kill;
end;

initialization
  TUIAuto.CreateUIAuto;   // Initialise the library
  RegisterTest(TestIAutomationBase.Suite);

end.
