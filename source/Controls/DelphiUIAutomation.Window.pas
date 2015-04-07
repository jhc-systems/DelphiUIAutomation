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
unit DelphiUIAutomation.Window;

interface

uses
  DelphiUIAutomation.Container,
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.Statusbar,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a window
  /// </summary>
  TAutomationWindow = class (TAutomationContainer)
  private
    function GetStatusBar : TAutomationStatusbar;
  public
    /// <summary>
    /// Finds the child window with the title supplied
    /// </summary>
    function Window (const title : string) : TAutomationWindow;

    /// <summary>
    /// Finds the tab
    /// </summary>
    /// <remarks>
    ///  This is the first tab associated with this window
    /// </remarks>
//    function GetTab : TAutomationTab;

    ///<summary>
    ///  Sets the focus to this window
    ///</summary>
    procedure Focus;

    /// <summary>
    ///  Prints out the child controls
    /// </summary>
    /// <remarks>
    ///  For debugging only
    /// </remarks>
    procedure ListControlsAndStuff(element : IUIAutomationElement); deprecated;

    ///<summary>
    /// The status bar associated with this window
    ///</summary>
    property StatusBar : TAutomationStatusBar read GetStatusBar;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Automation,
  sysutils;

{ TAutomationWindow }

procedure TAutomationWindow.Focus;
begin
  self.FElement.SetFocus;
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
(*
function TAutomationWindow.GetTab : TAutomationTab;
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

    if (retval = UIA_TabControlTypeId) then
    begin
      result := TAutomationTab.create(element);
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find tab');

end;
*)
procedure TAutomationWindow.ListControlsAndStuff(element : IUIAutomationElement);
var
  //element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name, help : widestring;
  length : integer;
  retVal : integer;

begin
  UIAuto.CreateTrueCondition(condition);

  if (element = nil) then
    element := self.FElement;

  // Find the element
  element.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);
    element.Get_CurrentControlType(retVal);
    element.Get_CurrentHelpText(help);

    Write(name + ' - ');
    Write(retval);
    Writeln(' - ' + help);

    if retval = UIA_PaneControlTypeId then
    begin
      writeln('Looking at children');
      ListControlsAndStuff(element);
    end;

//    if (name = title)then
//    begin
//      result := TAutomationWindow.create(element);
//      break;
//    end;
  end;

//  if result = nil then
//    raise Exception.Create('Unable to find window');
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

end.
