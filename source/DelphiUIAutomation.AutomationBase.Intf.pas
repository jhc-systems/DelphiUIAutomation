unit DelphiUIAutomation.AutomationBase.Intf;

interface

uses
  UIAutomationClient_TLB;

type
  IAutomationBase = interface
    ['{E52FFD96-DE6E-4812-910A-E55C1ACFE06D}']
    constructor create(element : IUIAutomationElement);
    function getName: string;
    property Name : string read getName;
  end;

implementation

end.
