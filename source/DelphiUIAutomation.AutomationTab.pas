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
    FTabItems : TList<TAutomationTabItem>;
    FSelectedItem : TAutomationTabItem;
  private
    function GetSelectedItem: TAutomationTabItem;
  public
    constructor Create(element : IUIAutomationElement);

    function Click : HResult;
    procedure SelectTabPage(const value : string);

    property Pages : TList<TAutomationTabItem> read FTabItems;

    procedure ListControlsAndStuff(element : IUIAutomationElement); deprecated;

    property SelectedItem : TAutomationTabItem read GetSelectedItem;
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
    end;
  end;
end;

function TAutomationTab.GetSelectedItem: TAutomationTabItem;
begin
  result := self.FSelectedItem;
end;

procedure TAutomationTab.ListControlsAndStuff(element: IUIAutomationElement);
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

    if retval = UIA_PaneControlTypeId then
    begin
      writeln('Looking at children');
      ListControlsAndStuff(element);
    end;
  end;
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
      FSelectedItem := self.FTabItems[count];
      break;
    end;
  end;
end;

end.

