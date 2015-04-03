unit DelphiUIAutomation.AutomationTabItem;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationTabItem = class (TAutomationBase)
  strict private
    Felement : IUIAutomationElement;
  private
    function getName: string;
  public
    constructor Create(element : IUIAutomationElement);
    procedure Select;

    property Name : string read getName;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationTabItem }

constructor TAutomationTabItem.Create(element: IUIAutomationElement);
begin
  FElement := element;
end;

function TAutomationTabItem.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
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

  // Select it somehow
(*
SelectionItemPattern changeTab_aeTabPage = aeTabPage.GetCurrentPattern(SelectionItemPattern.Pattern) as SelectionItemPattern;

changeTab_aeTabPage.Select();
*)

end;

end.
