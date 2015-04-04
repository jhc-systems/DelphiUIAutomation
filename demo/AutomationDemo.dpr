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
  DelphiUIAutomation.AutomationWindow in '..\source\Controls\DelphiUIAutomation.AutomationWindow.pas',
  DelphiUIAutomation.AutomationClient in '..\source\DelphiUIAutomation.AutomationClient.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  DelphiUIAutomation.AutomationTextBox in '..\source\Controls\DelphiUIAutomation.AutomationTextBox.pas',
  DelphiUIAutomation.AutomationBase in '..\source\DelphiUIAutomation.AutomationBase.pas',
  DelphiUIAutomation.AutomationButton in '..\source\Controls\DelphiUIAutomation.AutomationButton.pas',
  DelphiUIAutomation.AutomationControlTypeIDs in '..\source\DelphiUIAutomation.AutomationControlTypeIDs.pas',
  DelphiUIAutomation.AutomationPatternIDs in '..\source\DelphiUIAutomation.AutomationPatternIDs.pas',
  DelphiUIAutomation.Mouse in '..\source\DelphiUIAutomation.Mouse.pas',
  DelphiUIAutomation.AutomationComboBox in '..\source\Controls\DelphiUIAutomation.AutomationComboBox.pas',
  DelphiUIAutomation.AutomationPropertyIDs in '..\source\DelphiUIAutomation.AutomationPropertyIDs.pas',
  DelphiUIAutomation.AutomationTab in '..\source\Controls\DelphiUIAutomation.AutomationTab.pas',
  DelphiUIAutomation.AutomationTabItem in '..\source\Controls\DelphiUIAutomation.AutomationTabItem.pas',
  DelphiUIAutomation.AutomationStatusbar in '..\source\Controls\DelphiUIAutomation.AutomationStatusbar.pas',
  DelphiUIAutomation.AutomationCheckbox in '..\source\Controls\DelphiUIAutomation.AutomationCheckbox.pas',
  DelphiUIAutomation.AutomationRadioButton in '..\source\Controls\DelphiUIAutomation.AutomationRadioButton.pas',
  DelphiUIAutomation.AutomationMenu in '..\source\Controls\DelphiUIAutomation.AutomationMenu.pas',
  DelphiUIAutomation.AutomationMenuItem in '..\source\Controls\DelphiUIAutomation.AutomationMenuItem.pas',
  DelphiUIAutomation.Desktop in '..\source\Controls\DelphiUIAutomation.Desktop.pas',
  DelphiUIAutomation.Exception in '..\source\DelphiUIAutomation.Exception.pas';

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
  // Now wait for a very long time for the enquiry screen to come up
  enquiry := TAutomationDesktop.GetDesktopWindow('Enquiry');
  enquiry.Focus;

  // 4. Select the correct tab
  tab := enquiry.GetTab;
  tab.SelectTabPage('Accounts');     // 3 is the magic number

//  tab.selectedItem.ListControlsAndStuff(nil);

  // 5. Click the fetch button
  mouse := TAutomationMouse.Create;
  mouse.Location := TPoint.Create(370, 160);
  mouse.LeftClick;

  sleep(8000);

  // Now see whether we can get the statusbar
  statusBar := enquiry.StatusBar;

  // Get the textedits form the statusbar???

end.

