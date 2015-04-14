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
  DelphiUIAutomation.EditBox,
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Container.Intf,
  DelphiUIAutomation.RadioButton,
  DelphiUIAutomation.ComboBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Menu,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  /// Finds the tab
  /// </summary>
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
    /// Finds the editbox, by index
    /// </summary>
    function GetEditBoxByIndex (index : integer) : TAutomationEditBox;

    /// <summary>
    /// Finds the textbox, by index
    /// </summary>
    function GetTextBoxByIndex(index: integer): TAutomationTextBox;

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

    /// <summary>
    /// Finds the main menu
    /// </summary>
    function GetMenuBar(index: integer) : TAutomationMainMenu;

{$IFDEF INVESTIGATION}
    /// <summary>
    ///  Prints out the child controls
    /// </summary>
    /// <remarks>
    ///  For investigation only
    /// </remarks>
    procedure ListControlsAndStuff(element : IUIAutomationElement);
{$ENDIF}
  end;

implementation

uses
  ActiveX,
  DelphiUIAutomation.Tab,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Automation;

{$IFDEF INVESTIGATION}
procedure TAutomationContainer.ListControlsAndStuff(element : IUIAutomationElement);
var
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name, help : widestring;
  length : integer;
  retVal : integer;

begin
  UIAuto.CreateTrueCondition(condition);

  if element = nil then
    element := self.FElement;

  // Find the elements
  element.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);
    element.Get_CurrentControlType(retVal);
    element.Get_CurrentHelpText(help);

    if retval = UIA_PaneControlTypeId then
    begin
      writeln('Looking at children');
      ListControlsAndStuff(element);
    end;

//    if (name = title)then
//    begin
//      result := TAutomationWindow.create(element);
//      break;
//    end;
  end;

//  if result = nil then
//    raise Exception.Create('Unable to find window');
end;
{$ENDIF}

function TAutomationContainer.GetEditBoxByIndex(index: integer): TAutomationEditBox;
begin
  result := TAutomationEditBox.Create(GetControlByControlType(index, UIA_EditControlTypeId));
end;

function TAutomationContainer.GetMenuBar(index: integer): TAutomationMainMenu;
begin
  result := TAutomationMainMenu.Create(GetControlByControlType(index, UIA_MenuBarControlTypeId));
end;

function TAutomationContainer.GetTextBoxByIndex(index: integer): TAutomationTextBox;
begin
  result := TAutomationTextBox.Create(GetControlByControlType(index, UIA_TextControlTypeId));
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
  counter : integer;
  varProp : OleVariant;

begin
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

    if counter = index then
    begin
      result := element;
      break;
    end;

    inc (counter);
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
