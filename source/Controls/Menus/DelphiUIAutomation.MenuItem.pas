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
unit DelphiUIAutomation.MenuItem;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a menu item
  /// </summary>
  TAutomationMenuItem = class (TAutomationBase)
  strict private
    FInvokePattern : IUIAutomationInvokePattern;
  private
    procedure GetInvokePattern;
  public
    /// <summary>
    ///  Constructor for menu items.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;

    /// <summary>
    ///  Clicks the menuitem
    /// </summary>
    function Click: HResult;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.PatternIDs;

constructor TAutomationMenuItem.Create(element: IUIAutomationElement);
begin
  inherited create(element);

  GetInvokePattern;
end;

procedure TAutomationMenuItem.GetInvokePattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_InvokePatternId, inter);

  if (inter <> nil) then
  begin
    if Inter.QueryInterface(IUIAutomationInvokePattern, FInvokePattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;
end;

function TAutomationMenuItem.Click : HResult;
begin
  result := FInvokePattern.Invoke;
end;

end.
