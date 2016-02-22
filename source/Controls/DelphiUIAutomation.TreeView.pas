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
  IAutomationTreeViewItem = interface (IAutomationBase)
    ['{ED19F4CE-6A7B-4C53-B42B-5487A32E8696}']
    procedure select;
  end;

  IAutomationTreeView = interface (IAutomationBase)
    ['{7228845F-E622-442F-A38B-491CE7392245}']
    function GetItem(name: String): IAutomationTreeViewItem;
  end;

  TAutomationTreeViewItem = class(TAutomationBase, IAutomationTreeViewItem)
  private
    FSelectItemPattern : IUIAutomationSelectionItemPattern;
  public
    procedure select;
    constructor Create(element : IUIAutomationElement); override;
  end;

  TAutomationTreeView = class (TAutomationBase, IAutomationTreeView)
  public
    function GetItem(name: String): IAutomationTreeViewItem;
    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Automation;

{ TAutomationTreeView }

constructor TAutomationTreeView.Create(element : IUIAutomationElement);
begin
  inherited Create(element);
end;

function TAutomationTreeView.GetItem(name: String): IAutomationTreeViewItem;
var
  item : IUIAutomationElement;
  condition,
  condition1,
  condition2 : IUIAutomationCondition;
begin
  uiAuto.createPropertyCondition(UIA_NamePropertyId, name, condition1);
  uiAuto.createPropertyCondition(UIA_ControlTypePropertyId, UIA_TreeItemControlTypeId, condition2);
  UIAuto.createAndCondition(condition1, condition2, condition);

  FElement.FindFirst(TreeScope_Descendants, condition, item);

  result := TAutomationTreeViewItem.create(item);
end;

{ TAutomationTreeViewItem }

constructor TAutomationTreeViewItem.Create(element: IUIAutomationElement);
begin
  inherited;
  FSelectItemPattern := GetSelectionItemPattern;
end;

procedure TAutomationTreeViewItem.select;
begin
  FSelectItemPattern.select;
end;

end.
