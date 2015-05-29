{ *************************************************************************** }
{ }
{ DelphiUIAutomation }
{ }
{ Copyright 2015 JHC Systems Limited }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }
program AutomationDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  generics.collections,
  System.SysUtils,
  System.Types,
  dialogs,
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
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.Clipboard in '..\source\DelphiUIAutomation.Clipboard.pas',
  DelphiUIAutomation.StringGrid in '..\source\Controls\DelphiUIAutomation.StringGrid.pas';

var
  application: IAutomationApplication;
  enquiry : IAutomationWindow;
  tb1 : IAutomationEditBox;
  eb0: IAutomationTextBox;
  Tab: IAutomationTab;
  Statusbar: IAutomationStatusBar;
  check: IAutomationCheckBox;
  radio: IAutomationRadioButton;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  // First launch the application
  application := TAutomationApplication.Launch
    ('..\..\democlient\Win32\Debug\Project1.exe', '');

  application.WaitWhileBusy;

  // Now wait for a very long time for the enquiry screen to come up
  enquiry := TAutomationDesktop.GetDesktopWindow('Form1');
  enquiry.Focus;

  // Select the correct tab
  Tab := enquiry.GetTabByIndex(0);
  Tab.SelectTabPage('Second Tab'); // 3 is the magic number

  tb1 := Tab.GetEditBoxByIndex(0);
  writeln(tb1.Text);

  check := enquiry.GetCheckboxByIndex(0);
  check.toggle;

  radio := enquiry.GetRadioButtonByIndex(2);
  radio.Select;

  // Now see whether we can get the statusbar
  Statusbar := enquiry.Statusbar;
  eb0 := Statusbar.GetTextBoxByIndex(1);
  writeln('Text is ' + eb0.Text);

  application.Kill;

  WriteLn('Press key to exit');
  ReadLn;

end.
