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
unit DelphiUIAutomation.Desktop;

interface

uses
  windows,
  generics.collections,
  DelphiUIAutomation.Menu,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.Window;

type
  /// <summary>
  /// Represents the Windows 'desktop'
  /// </summary>
  TAutomationDesktop = class
  public
    /// <summary>
    ///  Gets the list of desktop windows
    /// </summary>
    class function GetDesktopWindows : TObjectList<TAutomationWindow>;

    /// <summary>
    ///  Gets the specified desktop windows
    /// </summary>
    class function GetDesktopWindow (const title : String) : TAutomationWindow; overload;

    /// <summary>
    ///  Gets the specified desktop windows, with a timeout
    /// </summary>
    class function GetDesktopWindow (const title : String; timeout : DWORD) : TAutomationWindow; overload;

    /// <summary>
    ///  Gets the context menu
    /// </summary>
    /// <remarks>
    ///  Yes, it seems to be owned by the desktop
    /// </remarks>
    class function GetContextMenu(timeout: DWORD = DEFAULT_TIMEOUT) : IAutomationMenu;
  end;

implementation

uses
  ActiveX,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Condition,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ControlTypeIDs,
  UIAutomationClient_TLB,
  sysutils;

const
  DEFAULT_TIMEOUT = 99999999;

class function TAutomationDesktop.GetDesktopWindow(const title : String): TAutomationWindow;
begin
  result := TAutomationDesktop.GetDesktopWindow(title, DEFAULT_TIMEOUT);
end;

class function TAutomationDesktop.GetContextMenu(timeout: DWORD = DEFAULT_TIMEOUT): IAutomationMenu;
var
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  element : IUIAutomationElement;
  name : WideString;
  count, length : integer;
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

    rootElement.FindAll(TreeScope_Children, condition, collection);

    collection.Get_Length(length);

    for count := 0 to length -1 do
    begin
      collection.GetElement(count, element);
      element.Get_CurrentName(name);

      if name = 'Context' then
      begin
        result := TAutomationMenu.Create(nil, element);
        break;
      end;
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find context menu');
end;

class function TAutomationDesktop.GetDesktopWindow(const title: String;
  timeout: DWORD): TAutomationWindow;
var
  collection : IUIAutomationElementArray;
  condition : ICondition;
  element : IUIAutomationElement;
  name : WideString;
  count, length : integer;
  start : DWORD;
  aborted : boolean;

  function TimedOut : boolean;
  begin
    result := GetTickCount - start > timeout;
  end;

begin
  result := nil;

  condition := TUIAuto.CreateTrueCondition;

  start := GetTickCount;
  aborted := false;

  while (result = nil) and (not aborted) do
  begin
    aborted := TimedOut;

    rootElement.FindAll(TreeScope_Children, condition.getCondition, collection);

    collection.Get_Length(length);

    for count := 0 to length -1 do
    begin
      collection.GetElement(count, element);
      element.Get_CurrentName(name);

      if name = title then
      begin
        result := TAutomationWindow.Create(element, true);
        break;
      end;
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find window');
end;

class function TAutomationDesktop.getDesktopWindows: TObjectList<TAutomationWindow>;
var
  res : TObjectList<TAutomationWindow>;
  collection : IUIAutomationElementArray;
  condition : ICondition;
  element : IUIAutomationElement;
  name : WideString;
  count, length : integer;

begin
  res := TObjectList<TAutomationWindow>.create();

  condition := TUIAuto.CreateTrueCondition;

  rootElement.FindAll(TreeScope_Children, condition.getCondition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentName(name);
    res.Add(TAutomationWindow.create(element, true));
  end;

  result := res;
end;

end.
