unit DelphiUIAutomation.AutomationWindow;

interface

uses
  DelphiUIAutomation.AutomationBase,
  DelphiUIAutomation.AutomationTextbox,
  DelphiUIAutomation.AutomationComboBox,
  DelphiUIAutomation.AutomationButton,
  DelphiUIAutomation.AutomationTab,
  UIAutomationClient_TLB;

type
  TAutomationWindow = class (TAutomationBase)
  public
    constructor create(element : IUIAutomationElement);

    function Window (const title : string) : TAutomationWindow;
    function GetTextBoxByIndex (index : integer) : TAutomationTextBox;
    function GetComboboxByIndex (index : integer) : TAutomationComboBox;
    function GetButton (const title : string) : TAutomationButton;
    function GetTab : TAutomationTab;
    procedure Focus;

    procedure ListControlsAndStuff(element : IUIAutomationElement); deprecated;
  end;

implementation

uses
  DelphiUIAutomation.AutomationControlTypeIDs,
  DelphiUIAutomation.Automation,
  sysutils;

{ TAutomationWindow }

constructor TAutomationWindow.create(element: IUIAutomationElement);
begin
  FElement := element;
end;

procedure TAutomationWindow.Focus;
begin
  self.FElement.SetFocus;
end;

function TAutomationWindow.GetButton(const title: string): TAutomationButton;
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

    if (retval = UIA_ButtonControlTypeId) then
    begin
      element.Get_CurrentName(name);

      if (name = title)then
      begin
        result := TAutomationButton.create(element);
        break;
      end;
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find button');
end;

function TAutomationWindow.GetComboboxByIndex (index : integer) : TAutomationComboBox;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;
  retVal : integer;
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

    element.Get_CurrentControlType(retVal);

    if (retval = UIA_ComboBoxControlTypeId) then
    begin
      if counter = index then
        result := TAutomationComboBox.create(element);

      element.Get_CurrentName(name);

      writeln (name);

      inc(counter);
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find control');
end;

function TAutomationWindow.GetTab : TAutomationTab;
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

    if (retval = UIA_TabControlTypeId) then
    begin
      result := TAutomationTab.create(element);
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find tab');

end;

function TAutomationWindow.GetTextBoxByIndex(index: integer): TAutomationTextBox;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;
  retVal : integer;
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

    element.Get_CurrentControlType(retVal);

    if (retval = UIA_EditControlTypeId) then
    begin
      if counter = index then
        result := TAutomationTextBox.create(element);

      inc(counter);
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find control');
end;

procedure TAutomationWindow.ListControlsAndStuff(element : IUIAutomationElement);
var
  //element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name, help : widestring;
  length : integer;
  retVal : integer;

begin
  UIAuto.CreateTrueCondition(condition);

  if (element = nil) then
    element := self.FElement;

  // Find the element
  element.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);
    element.Get_CurrentControlType(retVal);
    element.Get_CurrentHelpText(help);

    Write(name + ' - ');
    Write(retval);
    Writeln(' - ' + help);

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

function TAutomationWindow.Window(const title: string): TAutomationWindow;
var
  element : IUIAutomationElement;
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name : widestring;
  length : integer;

begin
  result := nil;

  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);

    if (name = title)then
    begin
      result := TAutomationWindow.create(element);
      break;
    end;
  end;

  if result = nil then
    raise Exception.Create('Unable to find window');
end;

end.
