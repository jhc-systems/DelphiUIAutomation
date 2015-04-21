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
    FParentElement : IUIAutomationElement;
    FItems : TObjectList<TAutomationMenuItem>;
  private
    function getItems: TObjectList<TAutomationMenuItem>;
    procedure InitialiseList(recurse : Boolean);
    procedure FindMenuItems(Recurse: Boolean);
  public
    /// <summary>
    ///  Constructor for menu.
    /// </summary>
    constructor Create(parent: IUIAutomationElement; element : IUIAutomationElement); reintroduce;

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

constructor TAutomationMenu.Create(parent: IUIAutomationElement; element: IUIAutomationElement);
begin
  inherited create(element);

  self.FParentElement := parent;

  FItems := TObjectList<TAutomationMenuItem>.create;

//  InitialiseList(true);


  self.FindMenuItems(true);  

end;

procedure TAutomationMenu.FindMenuItems(Recurse: Boolean);   
var
  condition: IUIAutomationCondition;
  collection: IUIAutomationElementArray;
  lLength: Integer;
  Count: Integer;
  itemElement: IUIAutomationElement;
  retVal: Integer;
  ExpandCollapsePattern: IUIAutomationExpandCollapsePattern;  
  item : TAutomationMenuItem;
  
begin
  UIAuto.CreateTrueCondition(condition);

  self.FParentElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(lLength);

  for Count := 0 to lLength - 1 do
  begin
    collection.GetElement(Count, itemElement);
    itemElement.Get_CurrentControlType(retVal);

    if (retVal = UIA_MenuItemControlTypeId) then
    begin
      item := TAutomationMenuItem.Create(itemElement);
      FItems.Add(item);
      
      itemElement.GetCurrentPattern(UIA_ExpandCollapsePatternId, IInterface(ExpandCollapsePattern));
      if Assigned(ExpandCollapsePattern) then
      begin
        ExpandCollapsePattern.Expand;
        if Recurse = True then
          FindMenuItems(False);
      end;
    end;
  end;
end;

destructor TAutomationMenu.Destroy;
begin
  writeln ('Freeing ' + self.Name);
  FItems.free;
  inherited;
end;

function TAutomationMenu.getItems: TObjectList<TAutomationMenuItem>;
begin
  result := self.FItems;
end;

procedure TAutomationMenu.InitialiseList(recurse : Boolean);
var
  condition: IUIAutomationCondition;
  collection: IUIAutomationElementArray;
  Length: Integer;
  Count: Integer;
  itemElement: IUIAutomationElement;
  retVal: Integer;
  val: WideString;
  ExpandCollapsePattern: IUIAutomationExpandCollapsePattern;
//  FElement: IUIAutomationElement;
  item : TAutomationMenuItem;

(*
  condition: IUIAutomationCondition;
  collection : IUIAutomationElementArray;
  itemElement : IUIAutomationElement;
  count : integer;
  length : integer;
  retVal : integer;
  item : TAutomationMenuItem;
*)
begin
  condition := TUIAuto.CreateTrueCondition;

  self.Felement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for Count := 0 to length - 1 do
  begin
    collection.GetElement(Count, itemElement);
    itemElement.Get_CurrentControlType(retVal);

    if (retVal = UIA_MenuItemControlTypeId) then
    begin
      item := TAutomationMenuItem.Create(itemElement);
      FItems.Add(item);

      itemElement.GetCurrentPattern(UIA_ExpandCollapsePatternId, IInterface(ExpandCollapsePattern));
      if Assigned(ExpandCollapsePattern) then
      begin
        ExpandCollapsePattern.Expand;
        if recurse then        
          InitialiseList(false);
      end;
    end;
  end;

(*
  FItems := TObjectList<TAutomationMenuItem>.create;

  condition := TUIAuto.CreateTrueCondition;

  // Find the elements
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

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
*)
end;

end.

