unit DelphiUIAutomation.AutomationTab;

interface

uses
  DelphiUIAutomation.AutomationBase,
  DelphiUIAutomation.AutomationTabItem,
  Generics.Collections,
  UIAutomationClient_TLB;

type
  TAutomationTab = class (TAutomationBase)
  strict private
    Felement : IUIAutomationElement;
    FTabItems : TList<TAutomationTabItem>;
  private
    function getName: string;
  public
    constructor Create(element : IUIAutomationElement);

    function Click : HResult;
    procedure SelectTabPage(const value : string);
    property Name : string read getName;

    property Pages : TList<TAutomationTabItem> read FTabItems;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.AutomationControlTypeIDs,
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationTab }

function TAutomationTab.Click : HResult;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;
  rect : UIAutomationClient_TLB.tagRECT;
  mouse : TAutomationMouse;
  gotIt : integer;
  name : string;

begin
  result := -1;

  name := self.Name;

  fElement.GetCurrentPattern(UIA_InvokePatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationInvokePattern, Pattern) = S_OK then
    begin
      result := Pattern.Invoke;
    end;
  end;
end;

constructor TAutomationTab.Create(element: IUIAutomationElement);
var
  condition : IUIAutomationCondition;
  collection : IUIAutomationElementArray;
  count : integer;
  retval : integer;
  length : integer;
  name : widestring;

begin
  FElement := element;
  FTabItems := TList<TAutomationTabItem>.create;

  // See what tabs are there???
  UIAuto.CreateTrueCondition(condition);

  // Find the element
  self.FElement.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentControlType(retVal);

    if (retval = UIA_TabItemControlTypeId) then
    begin
      FTabItems.Add(TAutomationTabItem.create(element));
//      element.Get_CurrentName(name);
//      writeln(name);
    end;
  end;
end;

function TAutomationTab.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
end;

procedure TAutomationTab.SelectTabPage(const value: string);
var
  count : integer;

begin
  for count := 0 to self.FTabItems.Count -1 do
  begin
    if self.FTabItems[count].Name = value then
    begin
      self.FTabItems[count].Select;
      break;
    end;
  end;
end;

end.

