{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2016 JHC Systems Limited                              }
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
library UIAutomation;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.ShareMem,
  System.SysUtils,
  System.Classes,
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.Automation in '..\source\DelphiUIAutomation.Automation.pas',
  DelphiUIAutomation.Window in '..\source\Controls\DelphiUIAutomation.Window.pas',
  DelphiUIAutomation.Client in '..\source\DelphiUIAutomation.Client.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  DelphiUIAutomation.EditBox in '..\source\Controls\DelphiUIAutomation.EditBox.pas',
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
  DelphiUIAutomation.MenuItem in '..\source\Controls\Menus\DelphiUIAutomation.MenuItem.pas',
  DelphiUIAutomation.Exception in '..\source\DelphiUIAutomation.Exception.pas',
  DelphiUIAutomation.Desktop in '..\source\Controls\DelphiUIAutomation.Desktop.pas',
  DelphiUIAutomation.ScreenShot in '..\source\DelphiUIAutomation.ScreenShot.pas',
  DelphiUIAutomation.Menu in '..\source\Controls\Menus\DelphiUIAutomation.Menu.pas',
  DelphiUIAutomation.Base in '..\source\DelphiUIAutomation.Base.pas',
  DelphiUIAutomation.Container in '..\source\Controls\DelphiUIAutomation.Container.pas',
  DelphiUIAutomation.Tab.Intf in '..\source\Controls\DelphiUIAutomation.Tab.Intf.pas',
  DelphiUIAutomation.Container.Intf in '..\source\Controls\DelphiUIAutomation.Container.Intf.pas',
  DelphiUIAutomation.ListItem in '..\source\Controls\DelphiUIAutomation.ListItem.pas',
  DelphiUIAutomation.Keyboard in '..\source\DelphiUIAutomation.Keyboard.pas',
  DelphiUIAutomation.Hyperlink in '..\source\Controls\DelphiUIAutomation.Hyperlink.pas',
  DelphiUIAutomation.TextBox in '..\source\Controls\DelphiUIAutomation.TextBox.pas',
  DelphiUIAutomation.Processes in '..\source\DelphiUIAutomation.Processes.pas',
  DelphiUIAutomation.Clipboard in '..\source\DelphiUIAutomation.Clipboard.pas',
  DelphiUIAutomation.StringGrid in '..\source\Controls\DelphiUIAutomation.StringGrid.pas',
  DelphiUIAutomation.Panel.Intf in '..\source\Controls\DelphiUIAutomation.Panel.Intf.pas',
  DelphiUIAutomation.StringGridItem in '..\source\Controls\DelphiUIAutomation.StringGridItem.pas',
  DelphiUIAutomation.Panel in '..\source\Controls\DelphiUIAutomation.Panel.pas',
  DelphiUIAutomation.TreeView in '..\source\Controls\DelphiUIAutomation.TreeView.pas',
  DelphiUIAutomation.Condition in '..\source\Conditions\DelphiUIAutomation.Condition.pas',
  DelphiUIAutomation.AndCondition in '..\source\Conditions\DelphiUIAutomation.AndCondition.pas',
  DelphiUIAutomation.OrCondition in '..\source\Conditions\DelphiUIAutomation.OrCondition.pas',
  DelphiUIAutomation.FalseCondition in '..\source\Conditions\DelphiUIAutomation.FalseCondition.pas',
  DelphiUIAutomation.TrueCondition in '..\source\Conditions\DelphiUIAutomation.TrueCondition.pas',
  DelphiUIAutomation.NameCondition in '..\source\Conditions\DelphiUIAutomation.NameCondition.pas',
  DelphiUIAutomation.ControlTypeCondition in '..\source\Conditions\DelphiUIAutomation.ControlTypeCondition.pas',
  Dialogs;

{$R *.res}

var
  application: IAutomationApplication;

procedure Initialize; export;
begin
  TUIAuto.CreateUIAuto;
end;

procedure Finalize; export;
begin
  TUIAuto.DestroyUIAuto;
end;

procedure LaunchOrAttach(const val1, val2 : String); export;
begin
  application := TAutomationApplication.LaunchOrAttach (val1, val2);
end;

procedure Kill; export;
begin
  application.Kill;
end;

function GetDesktopWindow(const value: String): Pointer; export;
var
  window: TAutomationWindow;
begin
  window := TAutomationDesktop.GetDesktopWindow(value);
  result := window.GetHandle;
end;

function GetWindow(parent: Pointer; const value: String): Pointer; export;
var
  window : IAutomationWindow;
  popup : IAutomationWindow;
  elem : IUIAutomationElement;

begin
  elem := TUIAuto.GetElementFromHandle(parent);
  window := TAutomationWindow.Create(elem, false);

  popup := window.Window(value);

  result := popup.GetHandle;
end;

procedure WaitWhileBusy; export;
begin
  application.WaitWhileBusy;
end;

procedure Maximize(handle: Pointer); export;
var
  window : IAutomationWindow;
  elem : IUIAutomationElement;

begin
  elem := TUIAuto.GetElementFromHandle(handle);

  window := TAutomationWindow.Create(elem, false);

  window.Maximize;
end;

procedure SelectTab(handle: Pointer; text: String); export;
var
  elem : IUIAutomationElement;
  tab : IAutomationTab;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  tab := TAutomationTab.Create(elem);

  tab.SelectTabPage(text);
end;

function GetTab(handle: Pointer; item: Integer) : Pointer; export;
var
  window : IAutomationWindow;
  elem : IUIAutomationElement;
  tab : IAutomationTab;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  window := TAutomationWindow.Create(elem, false);

  tab := window.GetTabByIndex(item);

  result := tab.GetHandle;
end;

function GetEditBoxByName(handle: Pointer; name: String) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  eb : IAutomationEditBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  eb := parent.GetEditBoxByName(name);

  result := eb.GetHandle;
end;

procedure Toggle(handle: Pointer); export;
var
  cb : IAutomationCheckBox;
  elem : IUIAutomationElement;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  cb := TAutomationCheckBox.Create(elem);

  cb.Toggle;
end;

procedure SelectRadioButton(handle: Pointer; index: Integer); export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  rb : IAutomationRadioButton;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);
  rb := parent.GetRadioButtonByIndex(index);

  rb.Select;
end;

function GetCheckBox(handle: Pointer; index: Integer) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  cb : IAutomationCheckBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);
  cb := parent.GetCheckboxByIndex(index);
  result := cb.GetHandle;
end;

function GetTextBox(handle: Pointer; index: Integer) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  tb : IAutomationTextBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  tb := parent.GetTextBoxByIndex(index);

  result := tb.GetHandle;
end;

function GetEditBox(handle: Pointer; index: Integer) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  eb : IAutomationEditBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  eb := parent.GetEditBoxByIndex(index);

  result := eb.GetHandle;
end;

function GetText(handle: Pointer) : String; export;
var
  elem : IUIAutomationElement;
  tb : IAutomationEditBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  tb := TAutomationEditBox.Create(elem);

  result := tb.Text;
end;

function GetTextFromText(handle: Pointer) : String; export;
var
  elem : IUIAutomationElement;
  tb : IAutomationTextBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  tb := TAutomationTextBox.Create(elem);

  result := tb.Text;
end;

function GetStatusBar(handle: Pointer): Pointer; export;
var
  parent : IAutomationWindow;
  elem : IUIAutomationElement;
  sb : IAutomationStatusBar;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationWindow.Create(elem, false);

  sb := parent.StatusBar;

  result := sb.GetHandle;
end;

function GetComboBoxByName(handle: Pointer; name: String) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  cb : IAutomationComboBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  cb := parent.GetComboBoxByName(name);

  result := cb.GetHandle;
end;

function GetComboBox(handle: Pointer; index: Integer) : Pointer; export;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  cb : IAutomationComboBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  cb := parent.GetComboBoxByIndex(index);

  result := cb.GetHandle;
end;

function SetText(handle: Pointer; name: String) : String; export;
var
  elem : IUIAutomationElement;
  tb : IAutomationEditBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  tb := TAutomationEditBox.Create(elem);

  tb.Text := name;
end;

procedure SelectTreeViewItem(handle: Pointer; index: Integer; text: String);
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  tv : IAutomationTreeView;
  tvi : IAutomationTreeViewItem;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  tv := parent.GetTreeViewByIndex(index);
  tvi := tv.GetItem(text);
  tvi.select;
end;

procedure ClickButton(handle: Pointer; name: String) export;
var
  parent: IAutomationContainer;
  elem : IUIAutomationElement;
  btn : IAutomationButton;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationWindow.Create(elem, false);
  btn := parent.GetButton(name);

  btn.Click;
end;

procedure ClickMenuItem(handle: Pointer; name: String) export;
var
  menu : IAutomationMenu;
  parent: IAutomationWindow;
  elem : IUIAutomationElement;
  mi : IAutomationMenuItem;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationWindow.Create(elem, true);
  menu := parent.MainMenu;
  mi := menu.MenuItem(name);

  mi.Click;
end;

function GetStatusBarText(handle: Pointer; index: Integer) : String; export;
var
  parent : IAutomationWindow;
  elem : IUIAutomationElement;
  sb : IAutomationStatusBar;
  tb : IAutomationTextBox;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationWindow.Create(elem, false);

  sb := parent.StatusBar;

  tb := sb.GetTextBoxByIndex(index);

  result := tb.Text;
end;


function GetGrid(handle: Pointer; index: Integer) : Pointer;
var
  parent : IAutomationContainer;
  elem : IUIAutomationElement;
  grid : IAutomationStringGrid;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationContainer.Create(elem);

  grid := parent.GetStringGridByIndex(index);

  result := grid.GetHandle;
end;

function GetCellValue(handle: Pointer; x, y: integer) : String;
var
  parent : IAutomationStringGrid;
  elem : IUIAutomationElement;
  cell : IAutomationStringGridItem;

begin
  elem := TUIAuto.GetElementFromHandle(handle);
  parent := TAutomationStringGrid.Create(elem);

  cell := parent.GetItem(x,y);
  result := cell.Name;
end;

exports
  GetGrid, GetCellValue,
  GetWindow,
  ClickButton,
  ClickMenuItem, SelectRadioButton,
  SelectTreeViewItem,
  GetComboBox, GetComboBoxByName, SetText,
  GetTextBox, GetTextFromText,
  GetStatusBarText, GetEditBoxByName, GetEditBox, GetText, GetCheckBox, Toggle,
  Kill, LaunchOrAttach, GetTab, Initialize,
  Finalize, GetDesktopWindow, WaitWhileBusy, Maximize, SelectTab;

begin
end.
