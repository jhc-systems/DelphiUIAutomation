unit DelphiUIAutomation.AutomationTabItem;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationTabItem = class (TAutomationBase)
  public
    constructor Create(element : IUIAutomationElement);
    procedure Select;

    procedure ListControlsAndStuff(element : IUIAutomationElement); deprecated;
  end;

implementation

uses
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationTabItem }

constructor TAutomationTabItem.Create(element: IUIAutomationElement);
begin
  FElement := element;
end;

procedure TAutomationTabItem.ListControlsAndStuff(
  element: IUIAutomationElement);
var
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

//    if retval = UIA_PaneControlTypeId then
//    begin
//      writeln('Looking at children');
//      ListControlsAndStuff(element);
 //   end;
  end;
end;

procedure TAutomationTabItem.Select;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;

begin
  fElement.GetCurrentPattern(UIA_SelectionItemPatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationSelectionItemPattern, Pattern) = S_OK then
    begin
      Pattern.Invoke;
    end;
  end;
end;

end.
