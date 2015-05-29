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
unit AutomatedStringGrid;

interface

uses
  UIAutomationCore_TLB,
  windows,
  messages,
  classes,
  ActiveX,
  StringGridRow,
  grids;

type
  TStringGrid = class(Grids.TStringGrid,
                      ISelectionProvider,
                      IInvokeProvider,
                      IValueProvider,
                      IRawElementProviderSimple)
  private
    FRawElementProviderSimple : IRawElementProviderSimple;
    procedure WMGetObject(var Message: TMessage); message WM_GETOBJECT;

  public
    // IRawElementProviderSimple
    function Get_ProviderOptions(out pRetVal: ProviderOptions): HResult; stdcall;
    function GetPatternProvider(patternId: SYSINT; out pRetVal: IUnknown): HResult; stdcall;
    function GetPropertyValue(propertyId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function Get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // ISelectionProvider
    ///<remarks>
    ///  Will return the selected row (if possible)
    ///</remarks>
    function GetSelection(out pRetVal: PSafeArray): HResult; stdcall;
    function Get_CanSelectMultiple(out pRetVal: Integer): HResult; stdcall;
    function Get_IsSelectionRequired(out pRetVal: Integer): HResult; stdcall;

    // IInvokeProvider
    function Invoke: HResult; stdcall;

    // IValueProvider
    function SetValue(val: PWideChar): HResult; stdcall;
    function Get_Value(out pRetVal: WideString): HResult; stdcall;
    function Get_IsReadOnly(out pRetVal: Integer): HResult; stdcall;
  end;

implementation

uses
  sysutils,
  Variants;

function TStringGrid_NewInstance(AClass: TClass): TObject;
begin
  Result := TStringGrid.NewInstance;
end;

function GetVirtualMethod(AClass: TClass; const VmtOffset: Integer): Pointer;
begin
  Result := PPointer(Integer(AClass) + VmtOffset)^;
end;

procedure SetVirtualMethod(AClass: TClass; const VmtOffset: Integer; const Method: Pointer);
var
  WrittenBytes: SIZE_T;
  PatchAddress: PPointer;
begin
  PatchAddress := Pointer(Integer(AClass) + VmtOffset);
  WriteProcessMemory(GetCurrentProcess, PatchAddress, @Method, SizeOf(Method), WrittenBytes);
end;

{$IFOPT W+}{$DEFINE WARN}{$ENDIF}{$WARNINGS OFF} // no compiler warning
const
  vmtNewInstance = System.vmtNewInstance;
{$IFDEF WARN}{$WARNINGS ON}{$ENDIF}

var
  OrgTStringGrid_NewInstance: Pointer;

{ TStringGrid }

function TStringGrid.GetPatternProvider(patternId: SYSINT;
  out pRetVal: IInterface): HResult;
begin
  result := S_OK;
  pRetval := nil;

//  if (patternID = UIA_SelectionPatternId) then
//  begin
//    pRetVal := self;
//  end;

  if ((patternID = UIA_InvokePatternId) or
      (patternID = UIA_ValuePatternId) or
      (patternID = UIA_SelectionPatternId)) then
  begin
    pRetVal := self;
  end;

end;

function TStringGrid.GetPropertyValue(propertyId: SYSINT;
  out pRetVal: OleVariant): HResult;
begin
  if(propertyId = UIA_ClassNamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar(self.ClassName);
  end;

  if(propertyId = UIA_NamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar(self.Name);
  end;

  result := S_OK;
end;

function TStringGrid.GetSelection(out pRetVal: PSafeArray): HResult;
var
  region_buf : array of IRawElementProviderSimple;
  region_arr : variant;
  obj : TStringGridRow;

begin
  obj := TStringGridRow.create(self);
  obj.Row := self.row;

  SetLength(region_buf, 1);
  region_buf[0] := obj;

  region_arr := VarArrayCreate([0, High(region_buf)], varInteger);
  Move(PInteger(region_buf)^, VarArrayLock(region_arr)^, SizeOf(Integer) * Length(region_buf));
  VarArrayUnlock(region_arr);

  pRetVal := PSafeArray(TVarData(region_arr).VArray);

  // Retrieves a Microsoft UI Automation provider for each child element that is selected.pRetVal := nil;
  result := S_OK;
end;

function TStringGrid.Get_CanSelectMultiple(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  result := S_OK;
end;

function TStringGrid.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  result := UiaHostProviderFromHwnd (self.Handle, pRetVal);
end;

function TStringGrid.Get_IsSelectionRequired(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  result := S_OK;
end;

function TStringGrid.Get_ProviderOptions(out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

//function TStringGrid.Get_ReadyState(out pRetVal: WideString): HResult;
//begin
//  pRetval := 'I''m Ready';
//  result := S_OK;
//end;

function TStringGrid.Invoke: HResult;
begin
  PostMessage(self.Handle, WM_LBUTTONDBLCLK, Integer(self),0);
end;

function TStringGrid.SetValue(val: PWideChar): HResult;
begin
  self.Cells[self.Col, self.Row] := val;
  result := S_OK;
end;

function TStringGrid.Get_Value(out pRetVal: WideString): HResult;
begin
  pRetVal := self.Cells[self.Col, self.Row];
  result := S_OK;
end;

function TStringGrid.Get_IsReadOnly(out pRetVal: Integer): HResult;
begin
//  pRetVal := self
  pRetVal := 0;
  result := S_OK;
end;

procedure TStringGrid.WMGetObject(var Message: TMessage);
begin
  if (Message.Msg = WM_GETOBJECT) then
  begin
    QueryInterface(IID_IRawElementProviderSimple, FRawElementProviderSimple);

    message.Result := UiaReturnRawElementProvider(self.Handle, Message.WParam, Message.LParam, FRawElementProviderSimple);
  end
  else
    Message.Result := DefWindowProc(self.Handle, Message.Msg, Message.WParam, Message.LParam);
end;

initialization
  OrgTStringGrid_NewInstance := GetVirtualMethod(TStringGrid, vmtNewInstance);
  SetVirtualMethod(Grids.TStringGrid, vmtNewInstance, @TStringGrid_NewInstance);

finalization
  SetVirtualMethod(Grids.TStringGrid, vmtNewInstance, OrgTStringGrid_NewInstance);

end.
