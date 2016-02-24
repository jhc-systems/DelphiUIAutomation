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
unit DelphiUIAutomation.Window;

interface

uses
  Winapi.Windows,
  DelphiUIAutomation.Container.Intf,
  DelphiUIAutomation.Container,
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.Statusbar,
  DelphiUIAutomation.Menu,
  UIAutomationClient_TLB;

const
  DEFAULT_TIMEOUT = 99999999;

type
  IAutomationWindow = interface (IAutomationContainer)
    ['{4ECCEFCA-7A72-4CBC-A192-568031A28F2B}']
    function GetMainMenu: IAutomationMainMenu;
    function GetPopupMenu : IAutomationMenu;
    function GetStatusBar : IAutomationStatusbar;

    /// <summary>
    /// Finds the child window with the title supplied
    /// </summary>
    function Window (const title : string; timeout : DWORD = DEFAULT_TIMEOUT; WithMenu : boolean = true) : IAutomationWindow;

    ///<summary>
    /// Gets the main menu associated with this window
    ///</summary>
    property MainMenu : IAutomationMainMenu read GetMainMenu;

    ///<summary>
    ///  Sets the focus to this window
    ///</summary>
    procedure Focus;

    ///<summary>
    ///  Maximize the window
    ///</summary>
    procedure Maximize;

    ///<summary>
    /// The status bar associated with this window
    ///</summary>
    property StatusBar : IAutomationStatusBar read GetStatusBar;
  end;

  /// <summary>
  ///  Represents a window
  /// </summary>
  TAutomationWindow = class (TAutomationContainer, IAutomationWindow)
  strict private
    FMainMenu : IAutomationMainMenu;
    FControlMenu : IAutomationMenu;
    FWithMenu : boolean;
    FWindowPattern : IUIAutomationWindowPattern;
  private
    function GetStatusBar : IAutomationStatusbar;
    function GetMainMenu: IAutomationMainMenu;
    function GetControlMenu : IAutomationMenu;
    function GetPopupMenu : IAutomationMenu;

  public
    /// <summary>
    ///  Constructor for window.
    /// </summary>
    constructor Create(element : IUIAutomationElement; WithMenu : boolean); reintroduce;

    /// <summary>
    ///  Destructor for window.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// Finds the child window with the title supplied, with a timeout
    /// </summary>
    function Window (const title : string; timeout : DWORD; WithMenu : boolean = true) : IAutomationWindow; overload;

    ///<summary>
    ///  Sets the focus to this window
    ///</summary>
    procedure Focus;

    ///<summary>
    ///  Maximize the window
    ///</summary>
    procedure Maximize;

    /// <summary>
    /// Finds the main menu
    /// </summary>
    function GetMenuBar(index: integer) : TAutomationMainMenu;

    ///<summary>
    /// The status bar associated with this window
    ///</summary>
    property StatusBar : IAutomationStatusBar read GetStatusBar;

    ///<summary>
    /// Gets the main menu associated with this window
    ///</summary>
    property MainMenu : IAutomationMainMenu read GetMainMenu;

    ///<summary>
    /// Gets the popup menu associated with this window
    ///</summary>
    property PopupMenu : IAutomationMenu read GetPopupMenu;

    ///<summary>
    /// Gets the control menu associated with this window
    ///</summary>
    property ControlMenu : IAutomationMenu read GetControlMenu;

    ///<summary>
    /// Waits for the window to be idle, with timeout
    ///</summary>
    procedure WaitWhileBusy(timeout: DWORD); overload;

    ///<summary>
    /// Waits for the window to be idle, infinite timeout
    ///</summary>
    procedure WaitWhileBusy; overload;
  end;

implementation

uses
  DelphiUIAutomation.Condition,
  DelphiUIAutomation.MenuItem,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.PatternIDs,
  DelphiUIAutomation.Automation,
  sysutils;

{ TAutomationWindow }

constructor TAutomationWindow.Create(element: IUIAutomationElement; WithMenu : boolean);
begin
  inherited create(element);

  FWithMenu := WithMenu;

  if WithMenu then
    self.FMainMenu := GetMenuBar(1);

  FWindowPattern := GetWindowPattern;
end;

destructor TAutomationWindow.Destroy;
begin
  inherited;
end;

procedure TAutomationWindow.Focus;
begin
  self.FElement.SetFocus;
end;

function TAutomationWindow.GetControlMenu: IAutomationMenu;
begin
  result := self.FControlMenu;
end;

procedure TAutomationWindow.Maximize;
begin
  self.FWindowPattern.SetWindowVisualState(WindowVisualState_Maximized);
end;

function TAutomationWindow.GetMainMenu: IAutomationMainMenu;
begin
  result := self.FMainMenu;
end;

function TAutomationWindow.GetStatusBar: IAutomationStatusbar;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : ICondition;
  count : integer;
  length : integer;
  retVal : integer;

begin
  result := nil;

  condition := TUIAuto.CreateTrueCondition;

  // Find the element
  collection := self.FindAll(TreeScope_Descendants, condition);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentControlType(retVal);

    if (retval = UIA_StatusBarControlTypeId) then
    begin
      result := TAutomationStatusbar.create(element);
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find statusbar');
end;

function TAutomationWindow.Window(const title: string; timeout : DWORD; WithMenu : Boolean): IAutomationWindow;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;
  start : DWORD;
  aborted : boolean;

  function TimedOut : boolean;
  begin
    result := GetTickCount - start > timeout;
  end;

begin
  result := nil;

  UIAuto.CreateTrueCondition(condition);

  start := GetTickCount;
  aborted := false;

  while (result = nil) and (not aborted) do
  begin
    aborted := TimedOut;

    // Find the element
    self.FElement.FindAll(TreeScope_Descendants, condition, collection);

    collection.Get_Length(length);

    for count := 0 to length -1 do
    begin
      collection.GetElement(count, element);

      element.Get_CurrentName(name);

      if (name = title)then
      begin
        result := TAutomationWindow.create(element, WithMenu);
        break;
      end;
    end;
  end;

  if result = nil then
    raise EWindowNotFoundException.Create('Unable to find window');
end;

function TAutomationWindow.GetMenuBar(index: integer): TAutomationMainMenu;
var
  element : IUIAutomationElement;

begin
  result := nil;
  element := GetControlByControlType(index, UIA_MenuBarControlTypeId);

  if (element <> nil) then
  begin
    result := TAutomationMainMenu.Create(self.FElement, element);
  end;
end;

function TAutomationWindow.GetPopupMenu: IAutomationMenu;
var
  element : IUIAutomationElement;

begin
  result := nil;
  element := GetControlByControlType(0, UIA_MenuControlTypeId);

  if (element <> nil) then
  begin
    result := TAutomationMenu.Create(self.FElement, element);
  end;
end;

procedure TAutomationWindow.WaitWhileBusy(timeout: DWORD);
var
  success : integer;
begin
  self.FWindowPattern.WaitForInputIdle(timeout, success);
end;

procedure TAutomationWindow.WaitWhileBusy;
begin
  WaitWhileBusy(INFINITE);
end;

end.
