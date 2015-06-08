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
  TAutomationStringGrid = class(TStringGrid,
                      ISelectionProvider,
                      IGridProvider,
                  //    ITableProvider,
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

    // IGridProvider
    function GetItem(row: SYSINT; column: SYSINT; out pRetVal: IRawElementProviderSimple): HResult; stdcall;
    function Get_RowCount(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ColumnCount(out pRetVal: SYSINT): HResult; stdcall;
  end;

procedure Register;

implementation

uses
  dialogs,
  sysutils,
  Variants;

function arrayToSafeArray (inData : array of IRawElementProviderSimple) : PSafeArray;
var
  InDataLength: Integer;
  vaMatrix: Variant;
  I: Integer;

begin
  InDataLength := Length(InData);

  vaMatrix := VarArrayCreate([Low(inData), High(inData)], varVariant);

  //copy data into varArray
  for I := 0 to InDataLength-1 do
    vaMatrix[I] := InData[I];

  result :=  PSafeArray (TVarData (vaMatrix).VArray);
end;

procedure Register;
begin
  RegisterComponents('Samples', [TAutomationStringGrid]);
end;

{ TAutomationStringGrid }

function TAutomationStringGrid.GetItem(row, column: SYSINT;
  out pRetVal: IRawElementProviderSimple): HResult;
var
  obj : TAutomationStringGridItem;

begin
  result := S_OK;

  obj := TAutomationStringGridItem.create(self);
  obj.Row := row;
  obj.Column := column;
  obj.Value := self.Cells[column, row];

  pRetVal := obj;
end;

function TAutomationStringGrid.GetPatternProvider(patternId: SYSINT;
  out pRetVal: IInterface): HResult;
begin
  result := S_OK;
  pRetval := nil;

  if ((patternID = UIA_InvokePatternId) or
      (patternID = UIA_ValuePatternId) or
      (patternID = UIA_GridPatternId) or
      (patternID = UIA_SelectionPatternId)) then
  begin
    pRetVal := self;
  end;

end;

function TAutomationStringGrid.GetPropertyValue(propertyId: SYSINT;
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

function TAutomationStringGrid.GetSelection(out pRetVal: PSafeArray): HResult;
var
//  buffer : array of IRawElementProviderSimple;
//  region_arr : variant;
  obj : TAutomationStringGridItem;
  outBuffer : PSafeArray;
  offset : integer;

begin
  obj := TAutomationStringGridItem.create(self);
  obj.Row := self.row;
  obj.Column := self.Col;
  obj.Value := self.Cells[self.Col, self.Row];

//  SetLength(buffer, 1);
//  buffer[0] := obj;

//  pRetVal := ArrayToSafeArray(buffer);

  offset := 0;
  outBuffer := SafeArrayCreateVector(VT_VARIANT, 0, 1);
  SafeArrayPutElement(outBuffer, offset, obj);

  pRetVal := outBuffer;

  result := S_OK;
end;

function TAutomationStringGrid.Get_CanSelectMultiple(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  result := S_OK;
end;

function TAutomationStringGrid.Get_ColumnCount(out pRetVal: SYSINT): HResult;
begin
  pRetVal := self.ColCount;
  result := S_OK;
end;

function TAutomationStringGrid.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  result := UiaHostProviderFromHwnd (self.Handle, pRetVal);
end;

function TAutomationStringGrid.Get_IsSelectionRequired(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  result := S_OK;
end;

function TAutomationStringGrid.Get_ProviderOptions(out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

function TAutomationStringGrid.Get_RowCount(out pRetVal: SYSINT): HResult;
begin
  pretVal := self.RowCount;
  result := S_OK;
end;

function TAutomationStringGrid.Invoke: HResult;
begin
  PostMessage(self.Handle, WM_LBUTTONDBLCLK, Integer(self),0);
end;

function TAutomationStringGrid.SetValue(val: PWideChar): HResult;
begin
  self.Cells[self.Col, self.Row] := val;
  result := S_OK;
end;

function TAutomationStringGrid.Get_Value(out pRetVal: WideString): HResult;
begin
  pRetVal := self.Cells[self.Col, self.Row];
  result := S_OK;
end;

function TAutomationStringGrid.Get_IsReadOnly(out pRetVal: Integer): HResult;
begin
//  pRetVal := self
  pRetVal := 0;
  result := S_OK;
end;

procedure TAutomationStringGrid.WMGetObject(var Message: TMessage);
begin
  if (Message.Msg = WM_GETOBJECT) then
  begin
    QueryInterface(IID_IRawElementProviderSimple, FRawElementProviderSimple);

    message.Result := UiaReturnRawElementProvider(self.Handle, Message.WParam, Message.LParam, FRawElementProviderSimple);
  end
  else
    Message.Result := DefWindowProc(self.Handle, Message.Msg, Message.WParam, Message.LParam);
end;

end.
