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
unit DelphiUIAutomation.TabItem;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  IAutomationTabItem = interface (IAutomationBase)
  ['{6FC85416-87FD-4FE6-91C5-3D465F73DBD5}']
    /// <summary>
    ///  Selects this tabitem
    /// </summary>
    procedure Select;
  end;

  /// <summary>
  ///  Represents a tab item
  /// </summary>
  TAutomationTabItem = class (TAutomationBase, IAutomationTabItem)
  private
    FSelectionItemPattern: IUIAutomationSelectionItemPattern;
  public
    /// <summary>
    ///  Selects this tabitem
    /// </summary>
    procedure Select;

    /// <summary>
    ///  Constructor for tab items.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.PatternIDs;

{ TAutomationTabItem }

constructor TAutomationTabItem.Create(element: IUIAutomationElement);
begin
  inherited;
  FSelectionItemPattern := GetSelectionItemPattern;
end;

procedure TAutomationTabItem.Select;
begin
  FSelectionItemPattern.Select;
end;

end.
