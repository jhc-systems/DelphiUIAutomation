unit DelphiUIAutomation.Container.Intf;

interface

uses
  DelphiUIAutomation.Tab.Intf,
  DelphiUIAutomation.TextBox,
  DelphiUIAutomation.CheckBox,
  DelphiUIAutomation.Button,
  DelphiUIAutomation.Combobox,
  DelphiUIAutomation.RadioButton;

type
  IAutomationContainer = interface
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
  end;

implementation

end.
