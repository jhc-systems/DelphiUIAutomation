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
  DelphiUIAutomation.Panel.Intf,
  DelphiUIAutomation.TreeView,
  DelphiUIAutomation.Menu,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.StringGrid,
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
    function GetTextBoxByIndex (index : integer) : IAutomationTextBox;

    /// <summary>
    /// Finds the combobox, by index
    /// </summary>
    function GetComboboxByIndex (index : integer) : IAutomationComboBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetCheckboxByIndex (index : integer) : IAutomationCheckBox;

    /// <summary>
    /// Finds the checkbox, by text
    /// </summary>
    function GetCheckboxByName (const value : string) : IAutomationCheckBox;

    /// <summary>
    /// Finds the checkbox, by index
    /// </summary>
    function GetRadioButtonByIndex (index : integer) : IAutomationRadioButton;

    /// <summary>
    /// Finds a panel, by index
    /// </summary>
    function GetPanelByIndex (index : integer) : IAutomationPanel;

    /// <summary>
    /// Finds the button with the title supplied
    /// </summary>
    function GetButton (const title : string) : IAutomationButton;

    /// <summary>
    /// Finds the stringgrid, by index
    /// </summary>
    function GetStringGridByIndex (index : integer) : IAutomationStringGrid;

    /// <summary>
    /// Finds the editbox, by index
    /// </summary>
    function GetEditBoxByIndex (index : integer) : IAutomationEditBox;

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
    function GetTreeViewByIndex (index : integer): IAutomationTreeView;
  end;

implementation

end.
