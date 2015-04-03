unit DelphiUIAutomation.AutomationStatusbar;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationStatusbar = class (TAutomationBase)
  public
    constructor Create(element : IUIAutomationElement);
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.AutomationPatternIDs;

{ TAutomationStatusbar }

constructor TAutomationStatusbar.Create(element: IUIAutomationElement);
begin
  Felement := element;
end;

end.

