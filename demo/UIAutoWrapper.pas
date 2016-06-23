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
unit UIAutoWrapper;

interface

type
  // TODO: Better names for these types please
  TSimpleFunc = procedure; stdcall;
  TLaunchFunc = procedure (const val1, val2: String);
  TStringFunc = function (const value: String): Pointer;
  TPointerFunc = procedure (handle: Pointer);
  TSelectTabFunc = procedure (handle: Pointer; text: String);
  TGetTabFunc = function (handle: Pointer; value: Integer): Pointer;
  TGetEditBoxByNameFunc = function (handle: Pointer; text: String): Pointer;
  TGetTextFunc = function (handle: Pointer): String;
  TToggleFunc = procedure (handle: Pointer);
  TGetStatusBarFunc = function (handle: Pointer): Pointer;
  TSetTextFunc = procedure (handle: Pointer; text: String);
  TGetMenuItemFunc = function (parent: Pointer; handle: Pointer; text: String): Pointer;

  TGetStatusbarTextFunc = function (handle: Pointer; value: Integer): String;
  TClickFunc = procedure(handle: Pointer; text: String);

  TSelectTreeViewItemFunc = procedure (handle: Pointer; item: Integer; text: String);
  TRadioButtonSelectFunc = procedure (handle: Pointer; item: Integer);

  TGetGridFunc = function (parent: Pointer; item: Integer) : Pointer;
  TGetCellValueFunc = function (parent: Pointer; x, y: Integer): String;

  TUIAutoWrapper = class
  private
    dllHandle : THandle;

    launchOrAttachFunc: TLaunchFunc;
    killFunc: TSimpleFunc;
    initializeFunc: TSimpleFunc;
    finalizeFunc: TSimpleFunc;
    waitWhileBusyFunc: TSimpleFunc;
    getDesktopWindowFunc: TStringFunc;
    getWindowFunc: TGetEditBoxByNameFunc;
    maximizeFunc: TPointerFunc;
    selectTabFunc: TSelectTabFunc;
    getTabFunc: TGetTabFunc;
    getCheckBoxFunc: TGetTabFunc;

    getEditBoxFunc: TGetTabFunc;
    getTextBoxFunc: TGetTabFunc;
    getEditBoxByNameFunc: TGetEditBoxByNameFunc;

    getTextFunc: TGetTextFunc;
    getTextFromTextFunc: TGetTextFunc;
    toggleFunc: TToggleFunc;
    getStatusbarTextFunc: TGetStatusbarTextFunc;

    getComboBoxByNameFunc: TGetEditBoxByNameFunc;
    getComboBoxFunc: TGetTabFunc;

    setTextFunc: TSetTextFunc;
    selectTreeViewItemFunc: TSelectTreeViewItemFunc;

    selectRadioButtonFunc: TRadioButtonSelectFunc;

    clickMenuItemFunc : TClickFunc;
    clickButtonFunc : TClickFunc;
    getGridFunc: TGetGridFunc;
    getCellValueFunc : TGetCellValueFunc;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Launch(const val1, val2: String);
    procedure Kill;

    procedure Initialize;
    procedure Finalize;

    procedure WaitWhileBusy;

    function GetDesktopWindow(const name: String) : Pointer;
    function GetWindow(parent: Pointer; const name: String) : Pointer;

    procedure Maximize(handle: Pointer);
    procedure Focus(handle: Pointer);

    procedure SelectTab(handle: Pointer; text: String);
    function GetTab(handle: Pointer; item: integer): Pointer;

    function GetEditBox(handle: Pointer; item: Integer): pointer; overload;
    function GetEditBox(handle: Pointer; name: String): pointer; overload;

    function GetTextBox(handle: Pointer; item: Integer): pointer;

    function GetText(handle: Pointer): String;
    function GetTextFromText(handle: Pointer): String;

    function GetCheckBox(handle: Pointer; index: Integer): Pointer;
    procedure Toggle(handle: Pointer);

    function GetStatusbarText(handle: Pointer; item: Integer): String;

    function GetComboBox(handle: Pointer; item: Integer): Pointer; overload;
    function GetComboBox(handle: Pointer; name: String): Pointer; overload;

    procedure SetText(handle: Pointer; text: String);

    procedure SelectTreeViewItem(parent: Pointer; item: Integer; name: String);

    procedure ClickMenu(parent: Pointer; value: String);

    procedure SelectRadioButton(handle: Pointer; index: Integer);

    procedure ClickButton(parent: Pointer; name: String);

    function GetDataGrid(parent: Pointer; item: Integer): Pointer;
    function GetCellValue(parent: Pointer; x, y: Integer): String;
  end;

implementation

uses
  dialogs,
  windows;

{ TUIAutoWrapper }

procedure TUIAutoWrapper.ClickMenu(parent: Pointer; value: String);
begin
  writeln('About to click on ' + value);
  self.clickMenuItemFunc(parent, value);
  writeln('Clicked ' + value);
end;

constructor TUIAutoWrapper.Create;
begin
  WriteLn('Loading DLL');
  dllHandle := LoadLibrary('..\..\..\library\Win32\Debug\UIAutomation.dll') ;
  WriteLn('Loaded DLL');
  if dllHandle <> 0 then
  begin
    @launchOrAttachFunc := getProcAddress(dllHandle, 'LaunchOrAttach');
    if not Assigned (launchOrAttachFunc) then
      WriteLn('"LaunchOrAttach" function not found') ;

    @killFunc := getProcAddress(dllHandle, 'Kill');
    if not Assigned (killFunc) then
      WriteLn('"Kill" function not found') ;

    @clickMenuItemFunc := getProcAddress(dllHandle, 'ClickMenuItem');
    if not Assigned (clickMenuItemFunc) then
      WriteLn('"ClickMenuItem" function not found') ;

    @initializeFunc := getProcAddress(dllHandle, 'Initialize');
    if not Assigned (initializeFunc) then
      WriteLn('"Initialise" function not found') ;

    @finalizeFunc := getProcAddress(dllHandle, 'Finalize');
    if not Assigned (finalizeFunc) then
      WriteLn('"Finalize" function not found') ;

    @waitWhileBusyFunc := getProcAddress(dllHandle, 'WaitWhileBusy');
    if not Assigned (waitWhileBusyFunc) then
      WriteLn('"WaitWhileBusy" function not found');

    @getDesktopWindowFunc := getProcAddress(dllHandle, 'GetDesktopWindow');
    if not Assigned (getDesktopWindowFunc) then
      WriteLn('"GetDesktopWindow" function not found');

    @selectTabFunc := getProcAddress(dllHandle, 'SelectTab');
    if not Assigned (selectTabFunc) then
      WriteLn('"SelectTab" function not found');

    @getTabFunc := getProcAddress(dllHandle, 'GetTab');
    if not Assigned (getTabFunc) then
      WriteLn('"GetTab" function not found');

    @maximizeFunc := getProcAddress(dllHandle, 'Maximize');
    if not Assigned (maximizeFunc) then
      WriteLn('"Maximize" function not found');

    @getEditBoxByNameFunc := getProcAddress(dllHandle, 'GetEditBoxByName');
    if not Assigned (getEditBoxByNameFunc) then
      WriteLn('"GetEditBoxByName" function not found');

    @getEditBoxFunc := getProcAddress(dllHandle, 'GetEditBox');
    if not Assigned (getEditBoxFunc) then
      WriteLn('"GetEditBox" function not found');

    @getTextFunc := getProcAddress(dllHandle, 'GetText');
    if not Assigned (getTextFunc) then
      WriteLn('"GetText" function not found');

    @getCheckBoxFunc := getProcAddress(dllHandle, 'GetCheckBox');
    if not Assigned (getCheckBoxFunc) then
      WriteLn('"GetCheckBox" function not found');

    @toggleFunc := getProcAddress(dllHandle, 'Toggle');
    if not Assigned (toggleFunc) then
      WriteLn('"Toggle" function not found');

    @getStatusbarTextFunc := getProcAddress(dllHandle, 'GetStatusBarText');
    if not Assigned (getStatusbarTextFunc) then
      WriteLn('"GetStatusBarText" function not found');

    @getTextBoxFunc := getProcAddress(dllHandle, 'GetTextBox');
    if not Assigned (getTextBoxFunc) then
      WriteLn('"GetTextBox" function not found');

    @getTextFromTextFunc := getProcAddress(dllHandle, 'GetTextFromText');
    if not Assigned (getTextFromTextFunc) then
      WriteLn('"GetTextFromText" function not found');

    @getComboBoxByNameFunc := getProcAddress(dllHandle, 'GetComboBoxByName');
    if not Assigned (getComboBoxByNameFunc) then
      WriteLn('"GetComboBoxByName" function not found');

    @getComboBoxFunc := getProcAddress(dllHandle, 'GetComboBox');
    if not Assigned (getComboBoxFunc) then
      WriteLn('"GetComboBox" function not found');

    @setTextFunc := getProcAddress(dllHandle, 'SetText');
    if not Assigned (setTextFunc) then
      WriteLn('"SetText" function not found');

    @selectTreeViewItemFunc := getProcAddress(dllHandle, 'SelectTreeViewItem');
    if not Assigned (selectTreeViewItemFunc) then
      WriteLn('"SelectTreeViewItem" function not found');

    @selectRadioButtonFunc := getProcAddress(dllHandle, 'SelectRadioButton');
    if not Assigned (selectRadioButtonFunc) then
      WriteLn('"SelectRadioButton" function not found');

    @clickButtonFunc := getProcAddress(dllHandle, 'ClickButton');
    if not Assigned (clickButtonFunc) then
      WriteLn('"ClickButton" function not found');

    @getWindowFunc := getProcAddress(dllHandle, 'GetWindow');
    if not Assigned (getWindowFunc) then
      WriteLn('"GetWindow" function not found');

    @getGridFunc := getProcAddress(dllHandle, 'GetGrid');
    if not Assigned (getGridFunc) then
      WriteLn('"GetGrid" function not found');

    @getCellValueFunc := getProcAddress(dllHandle, 'GetCellValue');
    if not Assigned (getCellValueFunc) then
      WriteLn('"GetCellValue" function not found');

  end
  else
  begin
    WriteLn('Dll not found') ;
    Exit;
  end;
end;

destructor TUIAutoWrapper.Destroy;
begin
  FreeLibrary(dllHandle);

  inherited Destroy;
end;

procedure TUIAutoWrapper.Finalize;
begin
  self.FinalizeFunc;
end;

procedure TUIAutoWrapper.Initialize;
begin
  self.InitializeFunc;
end;

procedure TUIAutoWrapper.WaitWhileBusy;
begin
  self.waitWhileBusyFunc;
end;

function TUIAutoWrapper.GetDesktopWindow(const name: String) : Pointer;
begin
  result := self.getDesktopWindowFunc(name);
end;

procedure TUIAutoWrapper.ClickButton(parent: Pointer; name: String);
begin
  self.clickButtonFunc(parent, name);
end;

//wrapper.GetDataGrid(window, 0, 'TAutomationStringGrid');
function TUIAutoWrapper.GetDataGrid(parent: Pointer; item: Integer) : Pointer;
begin
  result := self.getGridFunc(parent, item);
end;

function TUIautoWrapper.GetCellValue(parent: Pointer; x,y : Integer) : String;
begin
  result := self.getCellValueFunc(parent, x, y);
end;

procedure TUIAutoWrapper.Focus (handle: Pointer);
begin
  // Nothing yet.
end;

procedure TUIAutoWrapper.Kill;
begin
  self.KillFunc;
end;

procedure TUIautoWrapper.maximize(handle: Pointer);
begin
  self.maximizeFunc (handle);
end;

function TUIAutoWrapper.getTab(handle: Pointer; item: Integer): Pointer;
begin
  result := self.GetTabFunc(handle, item);
end;

function TUIAutoWrapper.GetEditBox(handle: Pointer; item: Integer): pointer;
begin
  result := self.getEditBoxFunc(handle, item);
end;

function TUIAutoWrapper.GetTextBox(handle: Pointer; item: Integer): pointer;
begin
  result := self.getTextBoxFunc(handle, item);
end;

function TUIAutoWrapper.GetTextFromText(handle: Pointer): String;
begin
  result := self.getTextFromTextFunc(handle);
end;

function TUIAutoWrapper.GetWindow(parent: Pointer; const name: String): Pointer;
begin
  result := self.getWindowFunc(parent, name);
end;

function TUIAutoWrapper.GetText(handle: Pointer): String;
begin
  result := self.getTextFunc(handle);
end;

function TUIAutoWrapper.GetCheckBox(handle: Pointer; index: Integer): Pointer;
begin
  result := self.getCheckBoxFunc(handle, index);
end;

procedure TUIAutoWrapper.SelectRadioButton(handle: Pointer; index: Integer);
begin
  self.selectRadioButtonFunc(handle, index);
end;

function TUIAutoWrapper.GetComboBox(handle: Pointer; name: String): Pointer;
begin
  result := self.getComboBoxByNameFunc(handle, name);
end;

function TUIAutoWrapper.GetComboBox(handle: Pointer; item: Integer): Pointer;
begin
  result := self.getComboBoxFunc(handle, item);
end;

function TUIAutoWrapper.GetStatusBarText(handle: Pointer; item: Integer): String;
begin
  result := self.GetStatusBarTextFunc(handle, item);
end;

function TUIAutoWrapper.GetEditBox(handle: Pointer; name: String): pointer;
begin
  result := self.getEditBoxByNameFunc(handle, name);
end;

procedure TUIAutoWrapper.SelectTab(handle: Pointer; text: String);
begin
  self.SelectTabFunc(handle, text);
end;

procedure TUIAutoWrapper.SelectTreeViewItem(parent: Pointer; item: Integer;
  name: String);
begin
  self.selectTreeViewItemFunc(parent, item, name);
end;

procedure TUIAutoWrapper.SetText(handle: Pointer; text: String);
begin
  self.setTextFunc(handle, text);
end;

procedure TUIAutoWrapper.Toggle(handle: Pointer);
begin
  self.ToggleFunc(handle);
end;

procedure TUIAutoWrapper.Launch(const val1, val2: String);
begin
  self.launchOrAttachFunc(val1, val2);
end;

end.

