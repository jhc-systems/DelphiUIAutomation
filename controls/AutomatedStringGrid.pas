{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015-17 JHC Systems Limited                              }
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
  AutomatedStringGridItem,
  UIAutomationCore_TLB,
  windows,
  messages,
  classes,
  ActiveX,
  grids;

type
  TAutomatedStringGrid = class(TStringGrid,
                      ISelectionProvider,
                      IGridProvider,
                      ITableProvider,
                      IInvokeProvider,
                      IValueProvider,
                      IRawElementProviderSimple,
                      IRawElementProviderSimple2)
  private
    FRawElementProviderSimple : IRawElementProviderSimple;
    procedure WMGetObject(var Message: TMessage); message WM_GETOBJECT;
  protected
    function GetCol: Integer; virtual;
    function GetRow: Integer; virtual;
    function GetColumnCount: integer; virtual;
    function GetRowCount: integer; virtual;
    function GetCell(column: integer; row: integer) : String; virtual;
    function GetCanMultipleSelect: Integer; virtual;
    function CreateCell(ACount, ARow: integer; AValue: String;  ARect: TRect) : IAutomatedStringGridItem; virtual;
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
    function GetSelection(out pRetVal: PSafeArray): HResult; virtual; stdcall;
    function Get_CanSelectMultiple(out pRetVal: Integer): HResult; stdcall;
    function Get_IsSelectionRequired(out pRetVal: Integer): HResult; stdcall;

    // IInvokeProvider
    function Invoke: HResult; stdcall;

    // IRawElementProviderSimple2
    function ShowContextMenu: HResult; virtual; stdcall;

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
  RegisterComponents('Automation', [TAutomatedStringGrid]);
end;

{ TAutomationStringGrid }

function TAutomatedStringGrid.GetColumnHeaders(
  out pRetVal: PSafeArray): HResult;
var
  intf : IAutomatedStringGridItem;
  outBuffer : PSafeArray;
  unk : IUnknown;
  Bounds : array [0..0] of TSafeArrayBound;
  count : integer;

begin
  pRetVal := nil;

  // is a cell selected?
  if (self.FixedRows <> 0) then
  begin
    bounds[0].lLbound := 0;
    bounds[0].cElements := self.getColumnCount;

    outBuffer := SafeArrayCreate(VT_UNKNOWN, 1, @Bounds);

    for count := 0 to self.getColumnCount -1 do
    begin
      intf := self.CreateCell(count, 0,  self.getCell(count, 0), self.CellRect(count, 0));

      if intf <> nil then
      begin
        unk := intf as IUnknown;
        Result := SafeArrayPutElement(&outBuffer, count, Pointer(unk)^);
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

function TAutomatedStringGrid.getCell(column: integer; row: integer) : String;
begin
  result := self.Cells[column, row];
end;

function TAutomatedStringGrid.GetItem(row, column: SYSINT;
  out pRetVal: IRawElementProviderSimple): HResult;
var
  intf : IRawElementProviderSimple;

begin
  result := S_OK;

  intf := self.CreateCell(column, row, self.getCell(column, row), self.CellRect(column, row)).asIRawElementProviderSimple;

  pRetVal := intf;
end;

function TAutomatedStringGrid.GetPatternProvider(patternId: SYSINT;
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

function TAutomatedStringGrid.GetPropertyValue(propertyId: SYSINT;
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
  else if (propertyId = UIA_ControlTypePropertyId) then
  begin
    TVarData(pRetVal).VType := varInteger;
    TVarData(pRetVal).VInteger := UIA_DataGridControlTypeId;
    result := S_OK;
  end

  else
    result := S_FALSE;

end;

function TAutomatedStringGrid.GetRowHeaders(out pRetVal: PSafeArray): HResult;
begin
  pRetVal := nil;
  result := S_FALSE;
end;

function TAutomatedStringGrid.CreateCell(ACount, ARow: integer; AValue: String;  ARect: TRect) : IAutomatedStringGridItem;
begin
  result := TAutomatedStringGridItem.create(self, ACount, ARow, AValue, ARect);
end;

function TAutomatedStringGrid.GetSelection(out pRetVal: PSafeArray): HResult;
var
  intf : IAutomatedStringGridItem;
  outBuffer : PSafeArray;
  unk : IUnknown;
  Bounds : array [0..0] of TSafeArrayBound;
  count : integer;
  iRow : integer;

begin
  pRetVal := nil;
  iRow := Self.Row;

  // is a cell selected?
  if (iRow > -1) then
  begin
    bounds[0].lLbound := 0;
    bounds[0].cElements := self.getColumnCount;

    outBuffer := SafeArrayCreate(VT_UNKNOWN, 1, @Bounds);

    for count := 0 to self.getColumnCount -1 do
    begin
      intf := self.CreateCell(count, iRow,  self.getCell(count, iRow), self.CellRect(count, iRow));

      if intf <> nil then
      begin
        unk := intf as IUnknown;
        Result := SafeArrayPutElement(&outBuffer, count, Pointer(unk)^);
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

function TAutomatedStringGrid.getCanMultipleSelect: Integer;
begin
  result := 0;
end;

function TAutomatedStringGrid.Get_CanSelectMultiple(out pRetVal: Integer): HResult;
begin
  pRetVal := self.getCanMultipleSelect;
  result := S_OK;
end;

function TAutomatedStringGrid.Get_ColumnCount(out pRetVal: SYSINT): HResult;
begin
  pRetVal := self.getColumnCount;
  result := S_OK;
end;

function TAutomatedStringGrid.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  result := UiaHostProviderFromHwnd (self.Handle, pRetVal);
end;

function TAutomatedStringGrid.Get_IsSelectionRequired(out pRetVal: Integer): HResult;
begin
  pRetVal := 0;
  result := S_OK;
end;

function TAutomatedStringGrid.Get_ProviderOptions(out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

function TAutomatedStringGrid.Get_RowCount(out pRetVal: SYSINT): HResult;
begin
  pretVal := self.getRowCount;
  result := S_OK;
end;

function TAutomatedStringGrid.getRowCount: integer;
begin
  result := self.rowCount;
end;

function TAutomatedStringGrid.getColumnCount: integer;
begin
  result := self.colCount;
end;

function TAutomatedStringGrid.Get_RowOrColumnMajor(
  out pRetVal: RowOrColumnMajor): HResult;
begin
  pRetVal := RowOrColumnMajor_RowMajor;
  result := S_OK;
end;

function TAutomatedStringGrid.Invoke: HResult;
begin
  PostMessage(self.Handle, WM_LBUTTONDBLCLK, Integer(self),0);
  result := S_OK;
end;

function TAutomatedStringGrid.SetValue(val: PWideChar): HResult;
begin
  self.Cells[self.Col, self.Row] := val;
  result := S_OK;
end;

function TAutomatedStringGrid.Get_Value(out pRetVal: WideString): HResult;
begin
  pRetVal := self.getCell(self.Col, self.Row);
  result := S_OK;
end;

function TAutomatedStringGrid.getCol: Integer;
begin
  result := self.Col;
end;

function TAutomatedStringGrid.getRow: Integer;
begin
  result := self.Row;
end;

function TAutomatedStringGrid.ShowContextMenu: HResult;
begin
  // Descendant classes can implement this
  result := S_OK;
end;

function TAutomatedStringGrid.Get_IsReadOnly(out pRetVal: Integer): HResult;
begin
//  pRetVal := self
  pRetVal := 0;
  result := S_OK;
end;

procedure TAutomatedStringGrid.WMGetObject(var Message: TMessage);
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
