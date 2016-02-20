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

unit DelphiUIAutomation.TreeView;

interface

uses
  generics.collections,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.ListItem,
  UIAutomationClient_TLB;

type
  IAutomationTreeView = interface (IAutomationBase)
    ['{7228845F-E622-442F-A38B-491CE7392245}']
  end;

  TAutomationTreeView = class (TAutomationBase, IAutomationTreeView)
  strict private
    FItems : TObjectList<TAutomationListItem>;
  private
    procedure getItems;
  public
    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  DelphiUIAutomation.ControlTypeIDs;

procedure TAutomationTreeView.getItems;
var
  collection : IUIAutomationElementArray;
  itemElement : IUIAutomationElement;
  count : integer;
  length : integer;
  retVal : integer;
  item : TAutomationListItem;

begin
  FItems := TObjectList<TAutomationListItem>.create;

  // Find the elements
  collection := self.FindAll(TreeScope_Children);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, itemElement);
    itemElement.Get_CurrentControlType(retVal);

    if (retVal = UIA_TreeItemControlTypeId) then
    begin
      item := TAutomationListItem.Create(itemElement);
      FItems.Add(item);
    end;
  end;

end;

{ TAutomationTreeView }

constructor TAutomationTreeView.Create(element : IUIAutomationElement);
begin
  inherited Create(element);

  getItems;
end;

end.
