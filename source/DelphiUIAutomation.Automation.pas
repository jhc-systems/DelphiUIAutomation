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
unit DelphiUIAutomation.Automation;

interface

uses
  generics.collections,
  winapi.windows,
  DelphiUIAutomation.Window,
  UIAutomationClient_TLB;

var
  /// <summary>
  ///  The main automation interface
  /// </summary>
  UIAuto: IUIAutomation;

  /// <summary>
  ///  The root of the desktop
  /// </summary>
  RootElement: IUIAutomationElement;

implementation

uses
  DelphiUIAutomation.Exception,
  sysutils,
  ActiveX;

initialization
  UIAuto := CoCUIAutomation.Create;
  if not Succeeded(UIAuto.GetRootElement(RootElement)) then
    raise EDelphiAutomationException.Create('Failed to get root element for Automation');

end.
