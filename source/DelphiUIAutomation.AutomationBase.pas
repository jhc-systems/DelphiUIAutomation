unit DelphiUIAutomation.AutomationBase;

interface

uses
  UIAutomationClient_TLB;

type
  TAutomationBase = class
  protected
    FElement : IUIAutomationElement;
    function getName: string; virtual;
  public
    property Name : string read getName;
    constructor Create(element : IUIAutomationElement); virtual;
  end;

implementation

constructor TAutomationBase.Create(element: IUIAutomationElement);
begin
  Felement := element;
end;

function TAutomationBase.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
end;


end.
