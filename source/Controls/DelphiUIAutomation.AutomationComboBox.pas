unit DelphiUIAutomation.AutomationComboBox;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationComboBox = class (TAutomationBase)
  private
    function getText: string;
    procedure setText(const Value: string);
  public
    property Text : string read getText write setText;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs,
  sysutils;

{ TAutomationComboBox }

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
