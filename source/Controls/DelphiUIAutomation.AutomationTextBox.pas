unit DelphiUIAutomation.AutomationTextBox;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationTextBox = class (TAutomationBase)
  private
    function getIsPassword: boolean;
    function getIsReadOnly: boolean;
    function getText: string;
    procedure setText(const Value: string);
  public
    property Text : string read getText write setText;
    property IsPassword : boolean read getIsPassword;
    property IsReadOnly : boolean read getIsReadOnly;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs,
  sysutils;

{ TAutomationTextBox }

function TAutomationTextBox.getIsPassword: boolean;
var
  retVal : integer;

begin
  Felement.Get_CurrentIsPassword(retVal);

  result := false;
end;

function TAutomationTextBox.getIsReadOnly: boolean;
begin
  result := false;
end;

function TAutomationTextBox.getText: string;
var
  Inter: IInterface;
  ValPattern  : IUIAutomationValuePattern;
  value : widestring;

begin
  result := '';

  if getIsPassword then
  begin
    raise Exception.Create('Unable to get text for password editboxes');
  end
  else
  begin
    fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
    if Inter.QueryInterface(IID_IUIAutomationValuePattern, ValPattern) = S_OK then
    begin
      ValPattern.Get_CurrentValue(value);
      Result := trim(value);
    end;
  end;
end;

procedure TAutomationTextBox.setText(const Value: string);
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
