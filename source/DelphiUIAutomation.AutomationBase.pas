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
unit DelphiUIAutomation.AutomationBase;

interface

uses
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  The base class for automation objects
  /// </summary>
  TAutomationBase = class
  protected
    FElement : IUIAutomationElement;
    function getName: string; virtual;
  public
    /// <summary>
    ///  Gets the name of the element
    /// </summary>
    property Name : string read getName;

    /// <summary>
    ///  Constructor for the element.
    /// </summary>
    constructor Create(element : IUIAutomationElement); virtual;
  end;

implementation

constructor TAutomationBase.Create(element: IUIAutomationElement);
begin
  Felement := element;
end;

function TAutomationBase.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
end;


end.
