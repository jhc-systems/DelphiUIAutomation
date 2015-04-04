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
unit DelphiUIAutomation.AutomationComboBox;

interface

uses
  generics.collections,
  DelphiUIAutomation.AutomationBase,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a combobox control
  /// </summary>
  TAutomationComboBox = class (TAutomationBase)
  private
    function getText: string;
    procedure setText(const Value: string);
    function getItems: TList<string>;
  public
    ///<summary>
    ///  Gets or sets the text associated with this combobox
    ///</summary>
    property Text : string read getText write setText;

    ///<summary>
    ///  Gets the list of items associated with this combobox
    ///</summary>
    ///<remarks>
    ///  To be implemented
    ///</remarks>
    property Items : TList<string> read getItems;
  end;

implementation

uses
  DelphiUIAutomation.AutomationPatternIDs,
  sysutils;

{ TAutomationComboBox }

function TAutomationComboBox.getItems : TList<string>;
begin
  result := TList<string>.Create;
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
