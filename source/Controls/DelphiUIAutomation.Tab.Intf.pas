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
unit DelphiUIAutomation.Tab.Intf;

interface

uses
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.EditBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.TabItem,
  DelphiUIAutomation.Combobox,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.RadioButton;

type
  IAutomationTab = interface (IAutomationBase)
    ['{542BED07-5345-4E0F-993C-26C121B66371}']
    function GetSelectedItem: IAutomationTabItem;

    ///<summary>
    ///  Selects the given tab
    ///</summary>
    procedure SelectTabPage(const value : string);

    /// <summary>
    /// Finds the tab
    /// </summary>
    function GetTabByIndex (index : integer) : IAutomationTab;

    /// <summary>
    /// Finds the textbox, by index
    /// </summary>
    function GetTextBoxByIndex (index : integer) : IAutomationTextBox;

    /// <summary>
    /// Finds the editbox, by index
    /// </summary>
    function GetEditBoxByIndex (index : integer) : IAutomationEditBox;

    /// <summary>
    /// Finds the combobox, by index
    /// </summary>
    function GetComboboxByIndex (index : integer) : IAutomationComboBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetCheckboxByIndex (index : integer) : IAutomationCheckBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetRadioButtonByIndex (index : integer) : IAutomationRadioButton;

    /// <summary>
    /// Finds the button with the title supplied
    /// </summary>
    function GetButton (const title : string) : IAutomationButton;

    /// <summary>
    ///  Gets the currently selected item
    /// </summary>
    property SelectedItem : IAutomationTabItem read GetSelectedItem;
  end;

implementation

end.
