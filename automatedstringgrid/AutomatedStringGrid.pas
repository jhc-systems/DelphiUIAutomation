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
                      ITableProvider,
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

    // ITableProvider
    function GetRowHeaders(out pRetVal: PSafeArray): HResult; stdcall;
    function GetColumnHeaders(out pRetVal: PSafeArray): HResult; stdcall;
    function Get_RowOrColumnMajor(out pRetVal: RowOrColumnMajor): HResult; stdcall;
  end;

procedure Register;

implementation

uses
  dialogs,
  sysutils,
  Variants;

procedure Register;
begin
  RegisterComponents('Samples', [TAutomationStringGrid]);
end;

{ TAutomationStringGrid }

function TAutomationStringGrid.GetColumnHeaders(
  out pRetVal: PSafeArray): HResult;
var
  intf : TAutomationStringGridItem;
  outBuffer : PSafeArray;
  offset : integer;
  unk : IUnknown;
  iRow, iCol : integer;
  Bounds : array [0..0] of TSafeArrayBound;
  count : integer;

begin
  pRetVal := nil;
  result := S_FALSE;

  // is a cell selected?
  if (self.FixedRows <> 0) then
  begin
    bounds[0].lLbound := 0;
    bounds[0].cElements := self.ColCount;

    outBuffer := SafeArrayCreate(VT_UNKNOWN, 1, @Bounds);

    for count := 0 to self.ColCount -1 do
    begin
      intf := TAutomationStringGridItem.create(self, count, 0,  self.Cells[count, 0]);

      if intf <> nil then
      begin
        unk := intf as IUnknown;
        Result := SafeArrayPutElement(&outBuffer, count, PUnknown(unk)^);
        if Result <> S_OK then
        begin
          SafeArrayDestroy(outBuffer);
          pRetVal := nil;
          result := E_OUTOFMEMORY;
          exit;
        end
      end;
    end;

    pRetVal := outBuffer;
    result := S_OK;

  end
  else
  begin
    pRetVal := nil;
    result := S_FALSE;
  end;

end;

function TAutomationStringGrid.GetItem(row, column: SYSINT;
  out pRetVal: IRawElementProviderSimple): HResult;
var
  intf : IRawElementProviderSimple;

begin
  result := S_OK;

  intf := TAutomationStringGridItem.create(self, column, row, self.Cells[column, row]);

  pRetVal := intf;
end;

function TAutomationStringGrid.GetPatternProvider(patternId: SYSINT;
  out pRetVal: IInterface): HResult;
begin
  result := S_OK;
  pRetval := nil;

  if ((patternID = UIA_InvokePatternId) or
      (patternID = UIA_ValuePatternId) or
      (patternID = UIA_TablePatternId) or
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
    result := S_OK;
  end
  else if(propertyId = UIA_NamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar(self.Name);
    result := S_OK;
  end
  else
    result := S_FALSE;

end;

function TAutomationStringGrid.GetRowHeaders(out pRetVal: PSafeArray): HResult;
begin
  pRetVal := nil;
  result := S_FALSE;
end;

function TAutomationStringGrid.GetSelection(out pRetVal: PSafeArray): HResult;
var
  intf : TAutomationStringGridItem;
  outBuffer : PSafeArray;
  offset : integer;
  unk : IUnknown;
  iRow, iCol : integer;
  Bounds : array [0..0] of TSafeArrayBound;

begin
  pRetVal := nil;
  result := S_FALSE;

  iRow := Self.Row;
  iCol := Self.Col;

  // is a cell selected?
  if (iRow > -1) and (iCol > -1) then
  begin
    intf := TAutomationStringGridItem.create(self, iCol, iRow,  self.Cells[self.Col, self.Row]);

    bounds[0].lLbound := 0;
    bounds[0].cElements := 1;
    outBuffer := SafeArrayCreate(VT_UNKNOWN, 1, @Bounds);

    if intf <> nil then
    begin
      offset := 0;
      unk := intf as IUnknown;
      Result := SafeArrayPutElement(&outBuffer, offset, PUnknown(unk)^);
      if Result <> S_OK then
      begin
        SafeArrayDestroy(outBuffer);
        pRetVal := nil;
        result := E_OUTOFMEMORY;
      end
      else
      begin
        pRetVal := outBuffer;
        result := S_OK;
      end;
    end;
  end
  else
  begin
    pRetVal := nil;
    result := S_FALSE;
  end;
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

function TAutomationStringGrid.Get_RowOrColumnMajor(
  out pRetVal: RowOrColumnMajor): HResult;
begin
  pRetVal := RowOrColumnMajor_RowMajor;
  result := S_OK;
end;

function TAutomationStringGrid.Invoke: HResult;
begin
  PostMessage(self.Handle, WM_LBUTTONDBLCLK, Integer(self),0);
  result := S_OK;
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
