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
unit DelphiUIAutomation.Container;

interface

uses
  DelphiUIAutomation.Tab.Intf,
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Container.Intf,
  DelphiUIAutomation.RadioButton,
  DelphiUIAutomation.ComboBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  TAutomationContainer = class (TAutomationBase, IAutomationContainer)
  protected
    function GetControlByControlType (index : integer; id : word) : IUIAutomationElement; overload;
    function GetControlByControlType (title : string; id : word) : IUIAutomationElement; overload;

  public
    /// <summary>
    /// Finds the tab
    /// </summary>
    function GetTabByIndex (index : integer) : IAutomationTab;

    /// <summary>
    /// Finds the textbox, by index
    /// </summary>
    function GetTextBoxByIndex (index : integer) : TAutomationTextBox;

    /// <summary>
    /// Finds the combobox, by index
    /// </summary>
    function GetComboboxByIndex (index : integer) : TAutomationComboBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetCheckboxByIndex (index : integer) : TAutomationCheckBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetRadioButtonByIndex (index : integer) : TAutomationRadioButton;

    /// <summary>
    /// Finds the button with the title supplied
    /// </summary>
    function GetButton (const title : string) : TAutomationButton;
  end;

implementation

uses
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Automation;

function TAutomationContainer.GetTextBoxByIndex(index: integer): TAutomationTextBox;
begin
  result := TAutomationTextBox.Create(GetControlByControlType(index, UIA_EditControlTypeId));
end;

function TAutomationContainer.GetButton(const title: string): TAutomationButton;
begin
  result := TAutomationButton.Create(GetControlByControlType(title, UIA_ButtonControlTypeId));
end;

function TAutomationContainer.GetCheckboxByIndex(index: integer): TAutomationCheckBox;
begin
  result := TAutomationCheckBox.Create(GetControlByControlType(index, UIA_CheckBoxControlTypeId));
end;

function TAutomationContainer.GetComboboxByIndex (index : integer) : TAutomationComboBox;
begin
  result := TAutomationComboBox.Create(GetControlByControlType(index, UIA_ComboBoxControlTypeId));
end;

function TAutomationContainer.GetControlByControlType(title: string; id: word): IUIAutomationElement;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;
  retVal : integer;

begin
  result := nil;

  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentControlType(retVal);

    if (retval = id) then
    begin
      element.Get_CurrentName(name);

      if (name = title)then
      begin
        result := element;
        break;
      end;
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find control');

end;

function TAutomationContainer.GetControlByControlType(index : integer;  id: word): IUIAutomationElement;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  length : integer;
  controlType : integer;
  counter : integer;

begin
  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  counter := 0;

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentControlType(controlType);

    if (controlType = id) then
    begin
      if counter = index then
      begin
        result := element;
      end;

      inc(counter);
    end;
  end;

  if result = nil then
    raise EDelphiAutomationException.Create('Unable to find control');
end;

function TAutomationContainer.GetRadioButtonByIndex(index: integer): TAutomationRadioButton;
begin
  result := TAutomationRadioButton.Create(GetControlByControlType(index, UIA_RadioButtonControlTypeId));
end;

function TAutomationContainer.GetTabByIndex (index : integer) : IAutomationTab;
begin
  result := TAutomationTab.Create(GetControlByControlType(index, UIA_TabControlTypeId));
end;

end.
