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
program AutomationDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  generics.collections,
  System.SysUtils,
  System.Types,
  dialogs,
  UIAutoWrapper in 'UIAutoWrapper.pas';

(*
var
  application: IAutomationApplication;
  enquiry : IAutomationWindow;
  tb1, tb2 : IAutomationEditBox;
  eb0: IAutomationTextBox;
  Tab: IAutomationTab;
  Statusbar: IAutomationStatusBar;
  check: IAutomationCheckBox;
  radio: IAutomationRadioButton;
//  eb2 : IAutomationEditBox;
  cb1: IAutomationCombobox;
  cb2: IAutomationCombobox;
  tv1: IAutomationTreeView;
  tvi: IAutomationTreeViewItem;
  exit1: IAutomationMenuItem;
  menu: IAutomationMenu;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  // First launch the application
  application := TAutomationApplication.LaunchOrAttach
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

  tb2 := enquiry.GetEditBoxByName('AutomatedEdit1');
  writeln(tb2.Text);

  check := enquiry.GetCheckboxByIndex(0);
  check.toggle;

  radio := enquiry.GetRadioButtonByIndex(2);
  radio.Select;

  // Now see whether we can get the statusbar
  Statusbar := enquiry.Statusbar;
  eb0 := Statusbar.GetTextBoxByIndex(1);
  writeln('Text is ' + eb0.Text);

  // Now get and set the text in an editbox, by name
  cb1 := enquiry.GetComboboxByName('AutomatedCombobox1');
  writeln('Combo text is ' + cb1.Text);
  cb1.Text := 'Replacements';
  cb1 := enquiry.GetComboboxByName('AutomatedCombobox1');
  writeln('Combo text is ' + cb1.Text);

  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);
  cb2.Text := 'First';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);
  cb2.Text := 'No there';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);

  cb2.Text := 'Third';
  cb2 := enquiry.GetComboboxByName('AutomatedCombobox2');
  writeln('Combo2 text is ' + cb2.Text);

  // Now try and get stuff from TreeView
  tv1 := enquiry.getTreeViewByIndex(0);
  tvi := tv1.GetItem('Sub-SubItem');
  tvi.select;

  menu := enquiry.GetMainMenu;
  exit1 := menu.MenuItem('File|Exit');

  if assigned(exit1) then
    exit1.Click;

  WriteLn('Press key to exit');
  ReadLn;

  application.Kill;
*)
var
  wrapper: TUIAutoWrapper;
  window: Pointer;
  tab: Pointer;
  tb1, tb2 : Pointer;
  check: Pointer;

begin
  WriteLn('Creating wrapper');
  wrapper := TUIAutoWrapper.create;
  WriteLn('Created wrapper');

  try
    ReportMemoryLeaksOnShutdown := DebugHook <> 0;
    // Should do something here

    wrapper.Launch('..\..\democlient\Win32\Debug\Project1.exe', '');

    wrapper.Initialize;

    wrapper.WaitWhileBusy;

    // Now wait for a very long time for the enquiry screen to come up
    window := wrapper.GetDesktopWindow('Form1');
    wrapper.Focus(window);
    wrapper.Maximize(window);

    tab := wrapper.GetTab(window, 0);
    wrapper.SelectTab(tab, 'Second Tab');

    tb1 := wrapper.GetEditBox(tab, 0);
    writeLn(wrapper.GetText(tb1));

    tb2 := wrapper.GetEditBox(window, 'AutomatedEdit1');
    writeLn(wrapper.GetText(tb2));

    check := wrapper.GetCheckBox(window, 0);
    wrapper.Toggle(check);

    WriteLn('Press key to continue');
    ReadLn;

  finally
    WriteLn('About to kill');
    wrapper.Kill;
    WriteLn('Killed');

    wrapper.Finalize;
    wrapper.free;
  end;

end.
