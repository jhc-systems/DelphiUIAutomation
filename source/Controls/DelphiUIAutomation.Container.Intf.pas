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
unit DelphiUIAutomation.Container.Intf;

interface

uses
  DelphiUIAutomation.Tab.Intf,
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.EditBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Combobox,
  DelphiUIAutomation.Menu,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.RadioButton;

type
  IAutomationContainer = interface (IAutomationBase)
    ['{1077F870-7065-4FA9-BCC7-C8D3610CB2C6}']
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

    /// <summary>
    /// Finds the editbox, by index
    /// </summary>
    function GetEditBoxByIndex (index : integer) : TAutomationEditBox;

  end;

implementation

end.
