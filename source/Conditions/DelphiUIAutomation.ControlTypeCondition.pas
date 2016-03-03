{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2016 JHC Systems Limited                              }
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
unit DelphiUIAutomation.ControlTypeCondition;

interface

uses
  UIAutomationClient_TLB,
  generics.collections,
  activex,
  DelphiUIAutomation.Condition;

type
  TControlTypeCondition = class(TInterfacedObject, ICondition)
  strict private
    FpropertyId: SYSINT;
  public
    function getCondition : IUIAutomationCondition;
    constructor Create(propertyId: SYSINT);
  end;

implementation

uses
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.Automation;

constructor TControlTypeCondition.Create(propertyId: SYSINT);
begin
  FpropertyId := propertyId;
end;

function TControlTypeCondition.getCondition: IUIAutomationCondition;
var
  condition : IUIAutomationCondition;
begin
  uiAuto.CreatePropertyCondition(UIA_ControlTypePropertyId, FpropertyId, condition);
  result := condition;
end;

end.

