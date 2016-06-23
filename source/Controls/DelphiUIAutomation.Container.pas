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
unit DelphiUIAutomation.Container;

interface

uses
  DelphiUIAutomation.Tab.Intf,
  DelphiUIAutomation.EditBox,
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Container.Intf,
  DelphiUIAutomation.panel.Intf,
  DelphiUIAutomation.RadioButton,
  DelphiUIAutomation.ComboBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Panel,
  DelphiUIAutomation.Menu,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.TreeView,
  DelphiUIAutomation.StringGrid,
  UIAutomationClient_TLB;

type
  /// <summary>
  /// Finds the tab
  /// </summary>
  TAutomationContainer = class (TAutomationBase, IAutomationContainer)
  protected
    function GetControlByControlType (index : integer; id : word) : IUIAutomationElement; overload;
    function GetControlByControlType (index : integer;  id: word; controlType : string) : IUIAutomationElement; overload;
//    function GetControlByControlType (title : string; id : word) : IUIAutomationElement; overload;
    function GetControlByControlType1 (title : string; id : word) : IUIAutomationElement; overload;

  public
    /// <summary>
    /// Finds the tab
    /// </summary>
    function GetTabByIndex (index : integer) : IAutomationTab;

    /// <summary>
    /// Finds the editbox, by index
    /// </summary>
    function GetEditBoxByIndex (index : integer) : IAutomationEditBox;

    /// <summary>
    /// Finds the textbox, by index
    /// </summary>
    function GetTextBoxByIndex(index: integer): IAutomationTextBox;

    /// <summary>
    /// Finds the combobox, by index
    /// </summary>
    function GetComboboxByIndex (index : integer) : IAutomationComboBox;

    /// <summary>
    /// Finds the stringgrid, by index
    /// </summary>
    function GetStringGridByIndex (index : integer) : IAutomationStringGrid;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetCheckboxByIndex (index : integer) : IAutomationCheckBox;

    /// <summary>
    /// Finds a panel, by index
    /// </summary>
    function GetPanelByIndex (index : integer) : IAutomationPanel;

    /// <summary>
    /// Finds the checkbox, by name
    /// </summary>
    function GetCheckboxByName(const value: string): IAutomationCheckBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetRadioButtonByIndex (index : integer) : IAutomationRadioButton;

    /// <summary>
    /// Finds the button with the title supplied
    /// </summary>
    function GetButton (const title : string) : IAutomationButton;

    /// <summary>
    /// Finds the editbox, by name
    /// </summary>
    function GetEditBoxByName (name: String) : IAutomationEditBox;

    /// <summary>
    /// Finds the combobox, by name
    /// </summary>
    function GetComboboxByName (name : String) : IAutomationComboBox;

    /// <summary>
    /// Finds the treeview, by index
    /// </summary>
    function GetTreeViewByIndex (index: Integer): IAutomationTreeView;
  end;

implementation

uses
  windows,
  sysutils,
  ActiveX,
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.Condition,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Automation;

function TAutomationContainer.GetCheckboxByName(const value: string): IAutomationCheckBox;
begin
  result := TAutomationCheckBox.Create(GetControlByControlType1(value, UIA_CheckBoxControlTypeId));
end;

function TAutomationContainer.GetEditBoxByIndex(index: integer): IAutomationEditBox;
var
  eb : IUIAutomationElement;

begin
  eb := GetControlByControlType(index, UIA_EditControlTypeId);
  result := TAutomationEditBox.Create(eb);
end;

function TAutomationContainer.GetPanelByIndex(index: integer): IAutomationPanel;
var
  tb : IUIAutomationElement;

begin
  tb := GetControlByControlType(index, UIA_PaneControlTypeId);
  result := TAutomationPanel.Create(tb);
end;

function TAutomationContainer.GetTextBoxByIndex(index: integer): IAutomationTextBox;
var
  tb : IUIAutomationElement;

begin
  tb := GetControlByControlType(index, UIA_TextControlTypeId);
  result := TAutomationTextBox.Create(tb);
end;

function TAutomationContainer.GetTreeViewByIndex(
  index: Integer): IAutomationTreeView;
var
  treeView : IUIAutomationElement;

begin
  treeView := GetControlByControlType(0, UIA_TreeControlTypeId);

  result := TAutomationTreeView.Create(treeView);
end;

function TAutomationContainer.GetButton(const title: string): IAutomationButton;
var
  btn : IUIAutomationElement;

begin
  btn := GetControlByControlType1(title, UIA_ButtonControlTypeId);
  result := TAutomationButton.Create(btn);
end;

function TAutomationContainer.GetCheckboxByIndex(index: integer): IAutomationCheckBox;
begin
  result := TAutomationCheckBox.Create(GetControlByControlType(index, UIA_CheckBoxControlTypeId));
end;

function TAutomationContainer.GetComboboxByIndex (index : integer) : IAutomationComboBox;
begin
  result := TAutomationComboBox.Create(GetControlByControlType(index, UIA_ComboBoxControlTypeId));
end;

function TAutomationContainer.GetControlByControlType1(title: string; id: word): IUIAutomationElement;
var
  condition, condition1, condition2: ICondition;
  element : IUIAutomationElement;

begin
  condition1 := TuiAuto.createNameCondition(title);
  condition2 := TuiAuto.createControlTypeCondition(id);
  condition := TUIAuto.createAndCondition(condition1, condition2);

  self.FElement.FindFirst(TreeScope_Descendants, condition.getCondition, element);

  result := element;
end;

function TAutomationContainer.GetControlByControlType(index: integer; id: word;
  controlType: string): IUIAutomationElement;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  length : integer;
  counter : integer;
  varProp : OleVariant;
  CName : WideString;

begin
  element := nil;

  TVariantArg(varProp).vt := VT_I4;
  TVariantArg(varProp).lVal := id; // At the moment it is always a pane

  UIAuto.CreatePropertyCondition(UIA_ControlTypePropertyId, varProp, condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  counter := 0;

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentClassName(CName);

    if CName = controlType then
    begin
      if counter = index then
      begin
        result := element;
        break;
      end;
      inc (counter);
    end;
  end;

//  if result = nil then
//    raise EDelphiAutomationException.Create('Unable to find control');
end;

function TAutomationContainer.GetControlByControlType(index : integer;  id: word): IUIAutomationElement;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  length : integer;
  counter : integer;
  varProp : OleVariant;

  // For debugging
  name : WideString;

begin
  element := nil;

  TVariantArg(varProp).vt := VT_I4;
  TVariantArg(varProp).lVal := id;

  UIAuto.CreatePropertyCondition(UIA_ControlTypePropertyId, varProp, condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  counter := 0;

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentName(name);

    OutputDebugString(pwidechar(name));

    if counter = index then
    begin
      result := element;
      break;
    end;

    inc (counter);
  end;

//  if result = nil then
//    raise EDelphiAutomationException.Create('Unable to find control');
end;

function TAutomationContainer.GetRadioButtonByIndex(index: integer): IAutomationRadioButton;
begin
  result := TAutomationRadioButton.Create(GetControlByControlType(index, UIA_RadioButtonControlTypeId));
end;

function TAutomationContainer.GetStringGridByIndex(index: integer): IAutomationStringGrid;
begin
  result := TAutomationStringGrid.Create(GetControlByControlType(index, UIA_DataGridControlTypeId, 'TAutomationStringGrid'));
end;

function TAutomationContainer.GetTabByIndex (index : integer) : IAutomationTab;
begin
  result := TAutomationTab.Create(GetControlByControlType(index, UIA_TabControlTypeId));
end;

function TAutomationContainer.GetEditBoxByName(
  name: String): IAutomationEditBox;
var
  eb : IUIAutomationElement;

begin
  eb := GetControlByControlType1(name, UIA_EditControlTypeId);
  result := TAutomationEditBox.Create(eb);
end;

function TAutomationContainer.GetComboboxByName(
  name: String): IAutomationComboBox;
var
  cb : IUIAutomationElement;

begin
  cb := GetControlByControlType1(name, UIA_ComboBoxControlTypeId);
  result := TAutomationComboBox.Create(cb);
end;

end.
