unit DelphiUIAutomation.AutomationComboBox;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationComboBox = class (TAutomationBase)
  strict private
    Felement : IUIAutomationElement;
  private
    function getName: string;
    function getText: string;
    procedure setText(const Value: string);
  public
    constructor Create(element : IUIAutomationElement);
    property Name : string read getName;
    property Text : string read getText write setText;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs,
  sysutils;

{ TAutomationComboBox }

constructor TAutomationComboBox.Create(element: IUIAutomationElement);
begin
  Felement := element;
end;

function TAutomationComboBox.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
end;

function TAutomationComboBox.getText: string;
var
  Inter: IInterface;
  ValPattern  : IUIAutomationValuePattern;
  value : widestring;

begin
  result := '';

  fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
  if Inter.QueryInterface(IID_IUIAutomationValuePattern, ValPattern) = S_OK then
  begin
    ValPattern.Get_CurrentValue(value);
    Result := trim(value);
  end;
end;

procedure TAutomationComboBox.setText(const Value: string);
var
  Inter: IInterface;
  ValPattern  : IUIAutomationValuePattern;

begin
  fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
  if Inter.QueryInterface(IID_IUIAutomationValuePattern, ValPattern) = S_OK then
  begin
    ValPattern.SetValue(value);
  end;
end;

end.
