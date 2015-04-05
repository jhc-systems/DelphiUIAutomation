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
unit DelphiUIAutomation.Button;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a button control
  /// </summary>
  TAutomationButton = class (TAutomationBase)
  public
    /// <summary>
    ///  Clicks the button
    /// </summary>
    function Click : HResult;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.PatternIDs;

{ TAutomationButton }

function TAutomationButton.Click : HResult;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;

begin
  result := -1;

  fElement.GetCurrentPattern(UIA_InvokePatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationInvokePattern, Pattern) = S_OK then
    begin
      result := Pattern.Invoke;
    end;
  end;
end;

end.

