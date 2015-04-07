unit DelphiUIAutomation.Tab.Intf;

interface

uses
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Combobox,
  DelphiUIAutomation.RadioButton;

type
  IAutomationTab = interface
    ['{542BED07-5345-4E0F-993C-26C121B66371}']
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

end.
