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
unit StringGridRow;

interface

uses
  ActiveX,
  UIAutomationCore_TLB, grids;

type
  TStringGridRow = class(TInterfacedObject,
          IValueProvider,
//          ISelectionItemProvider,
//          IGridItemProvider,
          IRawElementProviderSimple)
  strict private
    FRow : integer;
    FGrid : TDrawGrid;
  public
    property Row : integer read FRow write FRow;

    // IRawElementProviderSimple
    function Get_ProviderOptions(out pRetVal: ProviderOptions): HResult; stdcall;
    function GetPatternProvider(patternId: SYSINT; out pRetVal: IUnknown): HResult; stdcall;
    function GetPropertyValue(propertyId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function Get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // IValueProvider
    function SetValue(val: PWideChar): HResult; stdcall;
    function Get_Value(out pRetVal: WideString): HResult; stdcall;
    function Get_IsReadOnly(out pRetVal: Integer): HResult; stdcall;

    // ISelectionItemProvider
//    function Select: HResult; stdcall;
//    function AddToSelection: HResult; stdcall;
//    function RemoveFromSelection: HResult; stdcall;
//   function Get_IsSelected(out pRetVal: Integer): HResult; stdcall;
//    function Get_SelectionContainer(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    constructor Create(AOwner : TDrawGrid);
  end;

implementation

uses
  sysutils;

{ TStringGridRow }

constructor TStringGridRow.Create(AOwner: TDrawGrid);
begin
  inherited create;

  FGrid := AOwner;
end;

function TStringGridRow.GetPatternProvider(patternId: SYSINT;
  out pRetVal: IInterface): HResult;
begin
  result := S_FALSE;

  if (patternID = UIA_ValuePatternId) then
  begin
    pRetVal := self;
  result := S_OK;
  end;

end;

function TStringGridRow.GetPropertyValue(propertyId: SYSINT;
  out pRetVal: OleVariant): HResult;
begin
  if(propertyId = UIA_ClassNamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar('TStringGridRow');
  end;

  if(propertyId = UIA_NamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar('Row ' + IntToStr(FRow));
  end;

  result := S_OK;
end;

function TStringGridRow.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  pRetVal := nil;
  result := S_OK;
end;

function TStringGridRow.Get_IsReadOnly(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  Result := S_OK;
end;

function TStringGridRow.Get_ProviderOptions(
  out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

function TStringGridRow.Get_Value(out pRetVal: WideString): HResult;
begin
  pRetVal := IntToStr(FRow);
  result := S_OK;
end;

function TStringGridRow.SetValue(val: PWideChar): HResult;
begin
  FRow := StrToInt(val);
  Result := S_OK;
end;

end.
