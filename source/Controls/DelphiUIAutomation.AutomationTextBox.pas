{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{                                                                           }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}
unit DelphiUIAutomation.AutomationTextBox;

interface

uses
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a text box
  /// </summary>
  /// <remarks>
  ///  TEdit for example.
  /// </remarks>
  TAutomationTextBox = class (TAutomationBase)
  private
    function getIsPassword: boolean;
    function getIsReadOnly: boolean;
    function getText: string;
    procedure setText(const Value: string);
  public
    ///<summary>
    ///  Gets or sets the text
    ///</summary>
    property Text : string read getText write setText;

    ///<summary>
    ///  Gets whether the control is a password control
    ///</summary>
    property IsPassword : boolean read getIsPassword;

    ///<summary>
    ///  Gets whether the control is read-only
    ///</summary>
    property IsReadOnly : boolean read getIsReadOnly;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
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
    raise EDelphiAutomationException.Create('Unable to get text for password editboxes');
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
