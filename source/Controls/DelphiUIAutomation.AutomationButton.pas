unit DelphiUIAutomation.AutomationButton;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationButton = class (TAutomationBase)
  public
    function Click : HResult;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationButton }

function TAutomationButton.Click : HResult;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;

begin
  result := -1;

  fElement.GetCurrentPattern(UIA_InvokePatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationInvokePattern, Pattern) = S_OK then
    begin
      result := Pattern.Invoke;
    end;
  end;
end;

end.

