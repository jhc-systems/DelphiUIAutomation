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
unit DelphiUIAutomation.Condition;

interface

uses
  UIAutomationClient_TLB;

type
  ICondition = interface
    ['{9548F1A8-5FA7-4318-A22E-B1BE20DFD63A}']
    function getCondition : IUIAutomationCondition;
  end;

//type
//  TCondition = class(TInterfacedObject, ICondition)
//  public
//    function getCondition : IUIAutomationCondition; virtual; abstract;
//  end;

implementation

end.
