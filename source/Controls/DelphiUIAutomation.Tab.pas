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
unit DelphiUIAutomation.Tab;

interface

uses
  Generics.Collections,
  DelphiUIAutomation.Container,
  DelphiUIAutomation.TabItem,
  DelphiUIAutomation.Textbox,
  DelphiUIAutomation.Tab.Intf,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a tab control
  /// </summary>
  /// <remarks>
  ///  TPageControl for example
  /// </remarks>
  TAutomationTab = class (TAutomationContainer, IAutomationTab)
  strict private
    FSelectionPattern : IUIAutomationSelectionPattern;
    FTabItems : TObjectList<TAutomationTabItem>;
//    FSelectedItem : TAutomationTabItem;
  private
    function GetSelectedItem: IAutomationTabItem;
  public
    /// <summary>
    ///  Creates the representation
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    /// <summary>
    ///  Destructor for the representation.
    /// </summary>
    destructor Destroy; override;

    ///<summary>
    ///  Selects the given tab
    ///</summary>
    procedure SelectTabPage(const value : string);

    ///<summary>
    ///  Gets the list of tabitems associated with this tab
    ///</summary>
    property Pages : TObjectList<TAutomationTabItem> read FTabItems;

    /// <summary>
    ///  Gets the currently selected item
    /// </summary>
    property SelectedItem : IAutomationTabItem read GetSelectedItem;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.PatternIDs;

{ TAutomationTab }

constructor TAutomationTab.Create(element: IUIAutomationElement);
var
  collection : IUIAutomationElementArray;
  count : integer;
  retval : integer;
  length : integer;

begin
  inherited Create(element);

  FSelectionPattern := GetSelectionPattern;

  FTabItems := TObjectList<TAutomationTabItem>.create;

  // Find the element
  collection := self.FindAll(TreeScope_Descendants);

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

destructor TAutomationTab.Destroy;
begin
  FTabItems.free;

  inherited;
end;

function TAutomationTab.GetSelectedItem: IAutomationTabItem;
var
  unknown: IInterface;
  Pattern  : IUIAutomationSelectionPattern;
  collection : IUIAutomationElementArray;
  element : IUIAutomationElement;
  length : integer;

begin
  fElement.GetCurrentPattern(UIA_SelectionPatternId, unknown);

  result := nil;

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IID_IUIAutomationSelectionPattern, Pattern) = S_OK then
    begin
      Pattern.GetCurrentSelection(collection);

      collection.Get_Length(length);

      // In this case it should be one entry only
      collection.GetElement(0, element);
      result := TAutomationTabItem.Create(element);
    end;
  end;
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
//      FSelectedItem := self.FTabItems[count];
      break;
    end;
  end;
end;

end.

