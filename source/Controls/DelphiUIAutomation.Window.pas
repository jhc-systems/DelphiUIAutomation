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
  DelphiUIAutomation.Container,
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.Statusbar,
  DelphiUIAutomation.Menu,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a window
  /// </summary>
  TAutomationWindow = class (TAutomationContainer)
  strict private
    FMainMenu : TAutomationMainMenu;
  private
    function GetStatusBar : TAutomationStatusbar;
    function GetMainMenu: TAutomationMainMenu;
  public
    /// <summary>
    ///  Constructor for window.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    /// <summary>
    ///  Destructor for window.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    /// Finds the child window with the title supplied
    /// </summary>
    function Window (const title : string) : TAutomationWindow;

    ///<summary>
    ///  Sets the focus to this window
    ///</summary>
    procedure Focus;

    /// <summary>
    /// Finds the main menu
    /// </summary>
    function GetMenuBar(index: integer) : TAutomationMainMenu;

    ///<summary>
    /// The status bar associated with this window
    ///</summary>
    property StatusBar : TAutomationStatusBar read GetStatusBar;

    ///<summary>
    /// Gets the main menu associated with this window
    ///</summary>
    property MainMenu : TAutomationMainMenu read GetMainMenu;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Automation,
  sysutils;

{ TAutomationWindow }

constructor TAutomationWindow.Create(element: IUIAutomationElement);
begin
  inherited create(element);

  self.FMainMenu := GetMenuBar(1);
end;

destructor TAutomationWindow.Destroy;
begin
  FMainMenu.Free;

  inherited;
end;

procedure TAutomationWindow.Focus;
begin
  self.FElement.SetFocus;
end;

function TAutomationWindow.GetMainMenu: TAutomationMainMenu;
begin
  result := self.FMainMenu;
end;

function TAutomationWindow.GetStatusBar: TAutomationStatusbar;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  length : integer;
  retVal : integer;

begin
  result := nil;

  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

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

function TAutomationWindow.Window(const title: string): TAutomationWindow;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;

begin
  result := nil;

  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);

    if (name = title)then
    begin
      result := TAutomationWindow.create(element);
      break;
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find window');
end;

function TAutomationWindow.GetMenuBar(index: integer): TAutomationMainMenu;
begin
  result := TAutomationMainMenu.Create(GetControlByControlType(index, UIA_MenuBarControlTypeId));
end;

end.
