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
unit DelphiUIAutomation.Checkbox;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a checkbox control
  /// </summary>
  TAutomationCheckBox = class (TAutomationBase)
  public
    ///<summary>
    ///  Performs a toggle action
    ///</summary>
    function Toggle: HRESULT;
  end;

implementation

uses
  DelphiUIAutomation.PatternIDs;

{ TAutomationCheckBox }

function TAutomationCheckBox.Toggle: HRESULT;
var
  Inter: IInterface;
  pattern : IUIAutomationTogglePattern;

begin
  result := -1;

  fElement.GetCurrentPattern(UIA_TogglePatternId, inter);

  if (inter <> nil) then
  begin
    if Inter.QueryInterface(IID_IUIAutomationTogglePattern, pattern) = S_OK then
    begin
      result := pattern.Toggle;
    end;
  end;
end;

end.

