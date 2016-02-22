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
unit DelphiUIAutomation.Automation;

interface

uses
  ActiveX,
  generics.collections,
  winapi.windows,
  DelphiUIAutomation.Window,
  UIAutomationClient_TLB;

type
  TUIAuto = class
  public
    /// <summary>
    ///  Creates a true condition
    /// </summary>
    class function CreateTrueCondition : IUIAutomationCondition;

    /// <summary>
    ///  Creates an 'and' condition
    /// </summary>
    class function CreateAndCondition(condition1, condition2: IUIAutomationCondition) : IUIAutomationCondition;

    /// <summary>
    ///  Creates a property condition
    /// </summary>
    class function CreatePropertyCondition(propertyId: SYSINT; value: OleVariant) : IUIAutomationCondition;
  end;


var
  UIAuto: TCUIAutomation;
  RootElement: IUIAutomationElement;

implementation

uses
  DelphiUIAutomation.Exception,
  sysutils;

{ TUIAuto }

class function TUIAuto.CreateAndCondition(condition1, condition2: IUIAutomationCondition): IUIAutomationCondition;
var
  condition : IUIAutomationCondition;

begin
  UIAuto.CreateAndCondition(condition1, condition2, condition);

  result := condition;
end;

class function TUIAuto.CreatePropertyCondition(propertyId: SYSINT; value: OleVariant): IUIAutomationCondition;
var
  condition : IUIAutomationCondition;

begin
  UIAuto.CreatePropertyCondition(propertyId, value, condition);

  result := condition;
end;

class function TUIAuto.CreateTrueCondition: IUIAutomationCondition;
var
  condition : IUIAutomationCondition;

begin
  UIAuto.CreateTrueCondition(condition);

  result := condition;
end;

initialization
  CoInitializeEx(nil, 2);
  UIAuto := TCUIAutomation.Create(nil);
  if not Succeeded(UIAuto.GetRootElement(RootElement)) then
    raise EDelphiAutomationException.Create('Failed to get root element for Automation');

finalization
  UIAuto.Free;
  CoUninitialize;

end.
