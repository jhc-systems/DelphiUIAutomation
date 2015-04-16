{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015 JHC Systems Limited                              }
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
unit DelphiUIAutomation.Hyperlink;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a hyperlink
  /// </summary>
  TAutomationHyperlink = class (TAutomationBase)
  public
    /// <summary>
    ///  Selects this tabitem
    /// </summary>
    /// <remarks>
    ///  Has to simulate the click
    /// </remarks>
    procedure Click;
  end;

implementation

uses
  Winapi.Windows,
  DelphiUIAutomation.Mouse;

{ TAutomationHyperlink }

procedure TAutomationHyperlink.Click;
var
  rect : tagRect;
  mouse : TAutomationMouse;

begin
  fElement.Get_CurrentBoundingRectangle(rect);

  mouse := TAutomationMouse.Create;

  try
    mouse.Location := TPoint.Create(rect.top, rect.left);
    mouse.LeftClick;
  finally
    mouse.Free;
  end;

end;

end.
