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
unit DelphiUIAutomation.TextBox;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  IAutomationTextBox = interface (IAutomationBase)
    /// <summary>
    ///  Gets the text from the control
    /// </summary>
    property Text : string read getName;
  end;

  /// <summary>
  ///  Represents a text box
  /// </summary>
  TAutomationTextBox = class (TAutomationBase, IAutomationTextBox)
  public
    /// <summary>
    ///  Gets the text from the control
    /// </summary>
    property Text : string read getName;
  end;

implementation

{ TAutomationTextBox }

end.
