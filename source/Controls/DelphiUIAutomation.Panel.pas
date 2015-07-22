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
unit DelphiUIAutomation.Panel;

interface

uses
  Winapi.Windows,
  DelphiUIAutomation.Container.Intf,
  DelphiUIAutomation.Panel.Intf,
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

const
  DEFAULT_TIMEOUT = 99999999;

type
  /// <summary>
  ///  Represents a window
  /// </summary>
  TAutomationPanel = class (TAutomationBase, IAutomationPanel)
  public
  end;

implementation

{ TAutomationPanel }

end.
