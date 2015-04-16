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
unit DelphiUIAutomation.Menu;

interface

uses
  generics.collections,
  DelphiUIAutomation.MenuItem,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a menu
  /// </summary>
  TAutomationMenu = class (TAutomationBase)
  strict private
    FItems : TObjectList<TAutomationMenuItem>;
  private
    function getItems: TObjectList<TAutomationMenuItem>;
    procedure InitialiseList;
  public
    /// <summary>
    ///  Constructor for menu.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    /// <summary>
    ///  Destructor for menu.
    /// </summary>
    destructor Destroy; override;

    ///<summary>
    ///  Gets the list of items associated with this menu
    ///</summary>
    property Items : TObjectList<TAutomationMenuItem> read getItems;
  end;

  /// <summary>
  ///  Represents a popup menu
  /// </summary>
  TAutomationPopupMenu = class (TAutomationMenu)
  end;

  /// <summary>
  ///  Represents a main menu
  /// </summary>
  TAutomationMainMenu = class (TAutomationMenu)
  end;

implementation

uses
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.PatternIDs,
  DelphiUIAutomation.ControlTypeIDs;

{ TAutomationMenu }

constructor TAutomationMenu.Create(element: IUIAutomationElement);
begin
  inherited create(element);

  InitialiseList;
end;

destructor TAutomationMenu.Destroy;
begin
  FItems.free;
  inherited;
end;

function TAutomationMenu.getItems: TObjectList<TAutomationMenuItem>;
begin
  result := self.FItems;
end;

procedure TAutomationMenu.InitialiseList;
var
  condition: IUIAutomationCondition;
  collection : IUIAutomationElementArray;
  itemElement : IUIAutomationElement;
  count : integer;
  length : integer;
  retVal : integer;
  item : TAutomationMenuItem;

begin
  FItems := TObjectList<TAutomationMenuItem>.create;

  UIAuto.CreateTrueCondition(condition);

  // Find the elements
  self.FElement.FindAll(TreeScope_Children, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, itemElement);
    itemElement.Get_CurrentControlType(retVal);

    if (retVal = UIA_MenuItemControlTypeId) then
    begin
      item := TAutomationMenuItem.Create(itemElement);
      FItems.Add(item);
    end;
  end;
end;

end.

