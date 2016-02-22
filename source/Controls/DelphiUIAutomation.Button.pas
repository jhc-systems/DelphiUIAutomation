{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015-16 JHC Systems Limited                              }
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
  ///  Interface for a button control
  /// </summary>
  IAutomationButton = interface
    ['{BB9FB82C-8794-4355-B0BE-610B03B69822}']
    /// <summary>
    ///  Clicks the button
    /// </summary>
    function Click : HResult;

    /// <summary>
    ///  Focuses the button
    /// </summary>
    function Focus : HResult;
  end;

  /// <summary>
  ///  Representation of a button control
  /// </summary>
  TAutomationButton = class (TAutomationBase, IAutomationButton)
  private
    fInvokePattern : IUIAutomationInvokePattern;
  public
    /// <summary>
    ///  Clicks the button
    /// </summary>
    function Click : HResult;

    /// <summary>
    ///  Focuses the button
    /// </summary>
    function Focus : HResult;

    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  types,
  DelphiUIAutomation.Mouse,
  DelphiUIAutomation.PatternIDs;

{ TAutomationButton }

function TAutomationButton.Click : HResult;
begin
  result := FInvokePattern.Invoke;
end;

constructor TAutomationButton.Create(element: IUIAutomationElement);
begin
  inherited Create(element);

  fInvokePattern := getInvokePattern;
end;

function TAutomationButton.Focus: HResult;
begin
  result := FElement.SetFocus;
end;

end.

