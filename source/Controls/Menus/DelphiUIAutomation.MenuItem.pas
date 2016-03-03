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
unit DelphiUIAutomation.MenuItem;

interface

uses
  DelphiUIAutomation.Base,
  generics.collections,
  UIAutomationClient_TLB;

type
  IAutomationMenuItem = interface (IAutomationBase)
    ['{CCAE523B-A6D2-4C9C-BC96-C1E1BDCF5705}']
    /// <summary>
    ///  Clicks the menuitem
    /// </summary>
    function Click: HResult;
  end;

  /// <summary>
  ///  Represents a menu item
  /// </summary>
  /// <remarks>
  ///  Models Menu items (root or leaf).
  ///  SubMenus are themselves are Menu(s).
  /// </remarks>
  TAutomationMenuItem = class (TAutomationBase, IAutomationMenuItem)
  strict private
    FItems : TObjectList<TAutomationMenuItem>;
    FInvokePattern : IUIAutomationInvokePattern;
    FExpandCollapsePattern : IUIAutomationExpandCollapsePattern;

    function getItems: TObjectList<TAutomationMenuItem>;
  public
    /// <summary>
    ///  Constructor for menu items.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    /// <summary>
    ///  Destructor.
    /// </summary>
    destructor Destroy; override;

    /// <summary>
    ///  Call the expand property
    /// </summary>
    function Expand : HRESULT;

    /// <summary>
    ///  Call the collapse property
    /// </summary>
    function Collapse : HRESULT;

    /// <summary>
    ///  Clicks the menuitem
    /// </summary>
    function Click: HResult;

    ///<summary>
    ///  Gets the list of items associated with this menu
    ///</summary>
    property Items : TObjectList<TAutomationMenuItem> read getItems;
  end;

implementation

uses
  Winapi.Windows,
  Winapi.ActiveX,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.PatternIDs,
  DelphiUIAutomation.Automation;

constructor TAutomationMenuItem.Create(element: IUIAutomationElement);
var
  name : widestring;

begin
  inherited create(element);

  FElement.Get_CurrentName(name);

  FExpandCollapsePattern := GetExpandCollapsePattern;
  FInvokePattern := GetInvokePattern;
end;

destructor TAutomationMenuItem.Destroy;
begin
  if FItems <> nil then
    FItems.free;

  inherited;
end;

function TAutomationMenuItem.Expand: HRESULT;
begin
  result := FExpandCollapsePattern.Expand;
end;

function TAutomationMenuItem.Collapse: HRESULT;
begin
  result := FExpandCollapsePattern.Collapse;
end;

function TAutomationMenuItem.getItems: TObjectList<TAutomationMenuItem>;
begin
  result := self.FItems;
end;

function TAutomationMenuItem.Click : HResult;
begin
  result := -1;

  if (Assigned (FInvokePattern)) then
  begin
    result := FInvokePattern.Invoke;
  end;
end;

end.
