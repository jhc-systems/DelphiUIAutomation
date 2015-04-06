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
program AutomationDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  generics.collections,
  System.SysUtils,
  types,
  DelphiUIAutomation.Automation in '..\source\DelphiUIAutomation.Automation.pas',
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.Window in '..\source\Controls\DelphiUIAutomation.Window.pas',
  DelphiUIAutomation.Client in '..\source\DelphiUIAutomation.Client.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  DelphiUIAutomation.TextBox in '..\source\Controls\DelphiUIAutomation.TextBox.pas',
  DelphiUIAutomation.Base in '..\source\DelphiUIAutomation.Base.pas',
  DelphiUIAutomation.Button in '..\source\Controls\DelphiUIAutomation.Button.pas',
  DelphiUIAutomation.ControlTypeIDs in '..\source\Ids\DelphiUIAutomation.ControlTypeIDs.pas',
  DelphiUIAutomation.PatternIDs in '..\source\Ids\DelphiUIAutomation.PatternIDs.pas',
  DelphiUIAutomation.Mouse in '..\source\DelphiUIAutomation.Mouse.pas',
  DelphiUIAutomation.ComboBox in '..\source\Controls\DelphiUIAutomation.ComboBox.pas',
  DelphiUIAutomation.PropertyIDs in '..\source\Ids\DelphiUIAutomation.PropertyIDs.pas',
  DelphiUIAutomation.Tab in '..\source\Controls\DelphiUIAutomation.Tab.pas',
  DelphiUIAutomation.TabItem in '..\source\Controls\DelphiUIAutomation.TabItem.pas',
  DelphiUIAutomation.Statusbar in '..\source\Controls\DelphiUIAutomation.Statusbar.pas',
  DelphiUIAutomation.Checkbox in '..\source\Controls\DelphiUIAutomation.Checkbox.pas',
  DelphiUIAutomation.RadioButton in '..\source\Controls\DelphiUIAutomation.RadioButton.pas',
  DelphiUIAutomation.MenuItem in '..\source\Controls\DelphiUIAutomation.MenuItem.pas',
  DelphiUIAutomation.Exception in '..\source\DelphiUIAutomation.Exception.pas',
  DelphiUIAutomation.Desktop in '..\source\Controls\DelphiUIAutomation.Desktop.pas',
  DelphiUIAutomation.ScreenShot in '..\source\DelphiUIAutomation.ScreenShot.pas',
  DelphiUIAutomation.Menu in '..\source\Controls\DelphiUIAutomation.Menu.pas';

var
  FApp : TAutomationApplication;
  windows : TList<TAutomationWindow>;
  window : TAutomationWindow;
  i : integer;
  splash : TAutomationWindow;
  enquiry : TAutomationWindow;
  connect, security, calc : TAutomationWindow;
  tb1 : TAutomationTextBox;
  tb0 : TAutomationTextBox;
  btnOK, btnCalc : TAutomationButton;
  mouse : TAutomationMouse;
  price, quantity, netValue : TAutomationTextBox;
  account, stock, buysell : TAutomationComboBox;
  tab : TAutomationTab;
  statusBar : TAutomationStatusbar;

begin
  // First launch the application
  FApp := TAutomationApplication.Launch('..\..\democlient\Win32\Debug\Project1.exe', '');

  sleep(5000);

  // Now wait for a very long time for the enquiry screen to come up
  enquiry := TAutomationDesktop.GetDesktopWindow('Form1');
  enquiry.Focus;

  // 4. Select the correct tab
  tab := enquiry.GetTab;
  tab.SelectTabPage('Second Tab');     // 3 is the magic number

//  tab.selectedItem.ListControlsAndStuff(nil);

  // 5. Click the fetch button
//  mouse := TAutomationMouse.Create;
//  mouse.Location := TPoint.Create(370, 160);
//  mouse.LeftClick;

//  sleep(8000);

  // Now see whether we can get the statusbar
//  statusBar := enquiry.StatusBar;

  // Get the textedits form the statusbar???

  FApp.Kill;

end.

