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
unit DelphiUIAutomation.Checkbox;

interface

uses
  activex,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  IAutomationCheckBox = interface (IAutomationBase)
  ['{9A290D8D-BAE7-47E6-BE7A-28DF5ADCE5C7}']
    ///<summary>
    ///  Performs a toggle action
    ///</summary>
    function Toggle: HRESULT;

    ///<summary>
    ///  Gets the toggle state of the checkbox
    ///</summary>
    function ToggleState : TOleEnum;

    /// <summary>
    ///  Focuses the checkbox
    /// </summary>
    function Focus : HResult;
  end;

  /// <summary>
  ///  Represents a checkbox control
  /// </summary>
  TAutomationCheckBox = class (TAutomationBase, IAutomationCheckBox)
  strict private
    FTogglePattern : IUIAutomationTogglePattern;
  public
    ///<summary>
    ///  Performs a toggle action
    ///</summary>
    function Toggle: HRESULT;

    ///<summary>
    ///  Gets the toggle state of the checkbox
    ///</summary>
    function ToggleState : TOleEnum;

    /// <summary>
    ///  Focuses the checkbox
    /// </summary>
    function Focus : HResult;

    /// <summary>
    ///  Constructor for the element.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.PatternIDs;

{ TAutomationCheckBox }

constructor TAutomationCheckBox.Create(element: IUIAutomationElement);
begin
  inherited create(element);

  FTogglePattern := GetTogglePattern;
end;

function TAutomationCheckBox.Toggle: HRESULT;
begin
  result := self.FTogglePattern.Toggle;
end;

function TAutomationCheckBox.ToggleState: TOleEnum;
var
  state : TOleEnum;
begin
  self.FTogglePattern.Get_CurrentToggleState(state);

  result := state;
end;

function TAutomationCheckBox.Focus: HResult;
begin
  result := FElement.SetFocus;
end;

end.

