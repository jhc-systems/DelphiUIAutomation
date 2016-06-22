{ *************************************************************************** }
{ }
{ DelphiUIAutomation }
{ }
{ Copyright 2015 JHC Systems Limited }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }
unit DelphiUIAutomation.Menu;

interface

uses
  generics.collections,
  DelphiUIAutomation.MenuItem,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  IAutomationMenu = interface
    ['{503033B8-D055-40F3-B3F1-DAB915295CCA}']
    /// <summary>
    /// Gets the menu associated with the given path
    /// </summary>
    /// <remarks>
    /// Currently working to 2 levels i.e. 'Help|About';
    /// </remarks>
    function MenuItem(const path: string): IAutomationMenuItem;

    function GetHandle : Pointer;
  end;

  /// <summary>
  /// Represents a menu
  /// </summary>
  TAutomationMenu = class(TAutomationBase, IAutomationMenu)
  strict private
    FParentElement: IUIAutomationElement;
  public
    /// <summary>
    /// Constructor for menu.
    /// </summary>
    constructor Create(parent: IUIAutomationElement;
      element: IUIAutomationElement); reintroduce;

    /// <summary>
    /// Gets the menu associated with the given path
    /// </summary>
    /// <remarks>
    /// Currently working to 2 levels i.e. 'Help|About';
    /// </remarks>
    function MenuItem(const path: string): IAutomationMenuItem;
  end;

  /// <summary>
  /// Represents a popup menu
  /// </summary>
  TAutomationPopupMenu = class(TAutomationMenu, IAutomationMenu)
  end;

  IAutomationMainMenu = interface(IAutomationMenu)
    ['{86FB2309-D9EE-48F5-851C-ED40E4BFCFD4}']
  end;

  /// <summary>
  /// Represents a main menu
  /// </summary>
  TAutomationMainMenu = class(TAutomationMenu, IAutomationMainMenu)
  end;

implementation

uses
  windows,
  System.RegularExpressions,
  sysutils,
  generics.Defaults,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.Keyboard,
  DelphiUIAutomation.Condition,
  DelphiUIAutomation.PatternIDs,
  DelphiUIAutomation.ControlTypeIDs;

{ TAutomationMenu }

constructor TAutomationMenu.Create(parent: IUIAutomationElement;
  element: IUIAutomationElement);
begin
  inherited Create(element);

  self.FParentElement := parent;
end;

function TAutomationMenu.MenuItem(const path: string): IAutomationMenuItem;
var
  regexpr: TRegEx;
  matches: TMatchCollection;
  match: TMatch;
  value, value1: string;
  condition0,
  condition : ICondition;
  collection: IUIAutomationElementArray;
  lLength: Integer;
  count: Integer;
  menuElement, imenuElement: IUIAutomationElement;
  retVal: Integer;
  name: widestring;
  pattern: IUIAutomationExpandCollapsePattern;

begin
  result := nil;

  if (path.Contains('|')) then
  begin
    regexpr := TRegEx.Create('(.*)\|(.*)', [roIgnoreCase, roMultiline]);
    matches := regexpr.matches(path);

    for match in matches do
    begin
      if match.success then
      begin
        if match.Groups.count > 1 then
        begin
          value := match.Groups.Item[1].value;
          value1 := match.Groups.Item[2].value;

          condition := TUIAuto.createAndCondition(
            TUIAuto.createNameCondition(value),
            TUIAuto.createControlTypeCondition(UIA_MenuItemControlTypeId));

          self.FElement.FindFirst(TreeScope_Descendants, condition.getCondition, menuElement);

          if (menuElement <> nil) then
          begin
            // 2. Find leaf level
            menuElement.GetCurrentPattern(UIA_ExpandCollapsePatternId, IInterface(pattern));
            if Assigned(pattern) then
            begin
              pattern.Expand;
              sleep(750);

              condition0 := TUIAuto.createAndCondition(
                TUIAuto.createNameCondition(value1),
                TUIAuto.createControlTypeCondition(UIA_MenuItemControlTypeId));

              self.FParentElement.FindFirst(TreeScope_Descendants, condition0.getCondition,
                 imenuElement);

              result := TAutomationMenuItem.Create(imenuElement);
              break;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    condition := TUIAuto.CreateTrueCondition;

    self.FElement.FindAll(TreeScope_Descendants, condition.getCondition, collection);

    collection.Get_Length(lLength);

    for count := 0 to lLength - 1 do
    begin
      collection.GetElement(count, menuElement);
      menuElement.Get_CurrentControlType(retVal);

      if (retVal = UIA_MenuItemControlTypeId) then
      begin
        menuElement.Get_CurrentName(name);

        if name = path then
        begin
          result := TAutomationMenuItem.Create(menuElement);
        end;
      end;
    end;
  end;
end;

end.
