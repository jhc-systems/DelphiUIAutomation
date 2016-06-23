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

var
  wrapper: TUIAutoWrapper;
  window: Pointer;
  popup: Pointer;
  tab: Pointer;
  tb1, tb2 : Pointer;
  check: Pointer;
  cb1, cb2: Pointer;
  grid: Pointer;
  cellValue : String;

begin
  WriteLn('Creating wrapper');
  wrapper := TUIAutoWrapper.create;
  WriteLn('Created wrapper');

  WriteLn('Press key to continue');
  ReadLn;

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

    wrapper.SelectRadioButton(window, 2);

    writeln('Getting status bar, etc.');

    // Now see whether we can get the statusbar and associated text

    writeln('Text is ' + wrapper.GetStatusBarText(window, 1));

    writeln('Getting Combobox');

    cb1 := wrapper.GetComboBox(window, 'AutomatedCombobox1');
    writeln('Got combobox');
    writeLn(wrapper.GetText(cb1));

    wrapper.SetText(cb1, 'Helloo');
    writeLn('Value is now - ' + wrapper.GetText(cb1));

    cb2 := wrapper.GetComboBox(window, 'AutomatedCombobox2');
    writeln('Combo2 text is ' + wrapper.GetText(cb2));
    wrapper.SetText(cb2, 'First');
    cb2 := wrapper.GetComboBox(window, 'AutomatedCombobox2');
    writeln('Combo2 text is ' + wrapper.GetText(cb2));
    wrapper.SetText(cb2, 'No there');
    cb2 := wrapper.GetComboBox(window, 'AutomatedCombobox2');
    writeln('Combo2 text is ' + wrapper.GetText(cb2));

    wrapper.SetText(cb2, 'Third');
    cb2 := wrapper.GetComboBox(window, 'AutomatedCombobox2');
    writeln('Combo2 text is ' + wrapper.GetText(cb2));

    // Now try and get stuff to a TreeView

    wrapper.SelectTreeViewItem (window, 0, 'Sub-SubItem');

    wrapper.ClickMenu(window, 'File|Exit');

    // Now look for the popup

    writeln('Finding Window');

    popup := wrapper.GetWindow(window, 'Project1');

    writeln('Found Window');
    wrapper.ClickButton(popup, 'OK');
    writeln('clicked button');

    writeln('Data grid');

    // Get window again
    window := wrapper.GetDesktopWindow('Form1');

    grid := wrapper.GetDataGrid(window, 0);
    writeln('Got datagrid');
    cellValue := wrapper.GetCellValue(grid, 3,3);

    writeln('Value is = "' + cellValue + '"');

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
