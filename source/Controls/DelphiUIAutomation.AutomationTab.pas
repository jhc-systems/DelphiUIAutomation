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
unit DelphiUIAutomation.AutomationTab;

interface

uses
  DelphiUIAutomation.AutomationBase,
  DelphiUIAutomation.AutomationTabItem,
  Generics.Collections,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a tab control
  /// </summary>
  /// <remarks>
  ///  TPageControl for example
  /// </remarks>
  TAutomationTab = class (TAutomationBase)
  strict private
    FTabItems : TList<TAutomationTabItem>;
    FSelectedItem : TAutomationTabItem;
  private
    function GetSelectedItem: TAutomationTabItem;
  public
    /// <summary>
    ///  Creates the representation
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    ///<summary>
    ///  Selects the given tab
    ///</summary>
    procedure SelectTabPage(const value : string);

    ///<summary>
    ///  Gets the list of tabitems associated with this tab
    ///</summary>
    property Pages : TList<TAutomationTabItem> read FTabItems;

    /// <summary>
    ///  Gets the currently selected item
    /// </summary>
    property SelectedItem : TAutomationTabItem read GetSelectedItem;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.AutomationControlTypeIDs,
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationTab }

constructor TAutomationTab.Create(element: IUIAutomationElement);
var
  condition : IUIAutomationCondition;
  collection : IUIAutomationElementArray;
  count : integer;
  retval : integer;
  length : integer;

begin
  inherited Create(element);

  FTabItems := TList<TAutomationTabItem>.create;

  // See what tabs are there???
  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentControlType(retVal);

    if (retval = UIA_TabItemControlTypeId) then
    begin
      FTabItems.Add(TAutomationTabItem.create(element));
    end;
  end;
end;

function TAutomationTab.GetSelectedItem: TAutomationTabItem;
begin
  result := self.FSelectedItem;
end;

procedure TAutomationTab.SelectTabPage(const value: string);
var
  count : integer;

begin
  for count := 0 to self.FTabItems.Count -1 do
  begin
    if self.FTabItems[count].Name = value then
    begin
      self.FTabItems[count].Select;
      FSelectedItem := self.FTabItems[count];
      break;
    end;
  end;
end;

end.

