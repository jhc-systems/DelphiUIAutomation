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
  DelphiUIAutomation.Condition,
  DelphiUIAutomation.Window,
  UIAutomationClient_TLB;

type
  TUIAuto = class
  public
    /// <summary>
    ///  Creates a true condition
    /// </summary>
    class function CreateTrueCondition : ICondition;

    /// <summary>
    ///  Creates a false condition
    /// </summary>
    class function CreateFalseCondition : ICondition;

    /// <summary>
    ///  Creates a name condition
    /// </summary>
    class function createNameCondition(name: String) : ICondition;

    /// <summary>
    ///  Creates a controlID condition
    /// </summary>
    class function createControlTypeCondition(propertyId: SYSINT) : ICondition;

    /// <summary>
    ///  Creates an 'and' condition
    /// </summary>
    class function CreateAndCondition(condition1, condition2: ICondition) : ICondition;

    /// <summary>
    ///  Creates a property condition
    /// </summary>
//    class function CreatePropertyCondition(propertyId: SYSINT; value: OleVariant) : IUIAutomationCondition;

    class procedure CreateUIAuto;
    class procedure DestroyUIAuto;

    class function GetElementFromHandle(hwnd: Pointer): IUIAutomationElement; static;
  end;

var
  UIAuto: TCUIAutomation;
  RootElement: IUIAutomationElement;

implementation

uses
  DelphiUIAutomation.AndCondition,
  DelphiUIAutomation.TrueCondition,
  DelphiUIAutomation.ControlTypeCondition,
  DelphiUIAutomation.NameCondition,
  DelphiUIAutomation.FalseCondition,
  DelphiUIAutomation.Exception,
  sysutils;

{ TUIAuto }

class function TUIAuto.CreateAndCondition(condition1, condition2: ICondition): ICondition;
begin
  result := TAndCondition.create(condition1, condition2);
end;

class function TUIAuto.createControlTypeCondition(propertyId: SYSINT): ICondition;
begin
  result := TControlTypeCondition.create(propertyId);
end;

class function TUIAuto.CreateFalseCondition: ICondition;
begin
  result := TFalseCondition.create;
end;

class function TUIAuto.createNameCondition(name: String): ICondition;
begin
  result := TNameCondition.create(name);
end;

class function TUIAuto.CreateTrueCondition: ICondition;
begin
  result := TTrueCondition.create;
end;

class procedure TUIAuto.CreateUIAuto;
begin
  CoInitializeEx(nil, 2);
  UIAuto := TCUIAutomation.Create(nil);
  if not Succeeded(UIAuto.GetRootElement(RootElement)) then
    raise EDelphiAutomationException.Create('Failed to get root element for Automation');
end;

class procedure TUIAuto.DestroyUIAuto;
begin
  UIAuto.Free;
  CoUninitialize;
end;

class function TUIAuto.GetElementFromHandle(hwnd: Pointer) : IUIAutomationElement;
var
  elem: IUIAutomationElement;
begin
  UIAuto.ElementFromHandle(hwnd, elem);

  result := elem;
end;


//initialization
//  CoInitializeEx(nil, 2);
//  UIAuto := TCUIAutomation.Create(nil);
//  if not Succeeded(UIAuto.GetRootElement(RootElement)) then
//    raise EDelphiAutomationException.Create('Failed to get root element for Automation');

//finalization
//  UIAuto.Free;
//  CoUninitialize;

end.
