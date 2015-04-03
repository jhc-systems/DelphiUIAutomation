unit DelphiUIAutomation.AutomationTextBox;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  TAutomationTextBox = class (TAutomationBase)
  strict private
    Felement : IUIAutomationElement;
  private
    function getName: string;
    function getIsPassword: boolean;
    function getIsReadOnly: boolean;
    function getText: string;
    procedure setText(const Value: string);
  public
    constructor Create(element : IUIAutomationElement);
    property Name : string read getName;
    property Text : string read getText write setText;
    property IsPassword : boolean read getIsPassword;
    property IsReadOnly : boolean read getIsReadOnly;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs,
  sysutils;

{ TAutomationTextBox }

constructor TAutomationTextBox.Create(element: IUIAutomationElement);
begin
  Felement := element;
end;

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

function TAutomationTextBox.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
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
