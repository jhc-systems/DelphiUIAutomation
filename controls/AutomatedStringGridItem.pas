{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015-17 JHC Systems Limited                           }
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
unit AutomatedStringGridItem;

interface

uses
  ActiveX,
  types,
  UIAutomationCore_TLB,
  classes;

type
  IAutomatedStringGridItem = interface
    ['{86427F3B-A5DD-4553-84DE-2A724D9E4DA5}']
    function asIRawElementProviderSimple: IRawElementProviderSimple;
  end;

type
  TAutomatedStringGridItem = class (TInterfacedPersistent,
                                    IRawElementProviderSimple,
                                    ISelectionItemProvider,
                                    IValueProvider,
                                    IRawElementProviderFragment,
                                    IGridItemProvider,
                                    IInvokeProvider,
                                    IAutomatedStringGridItem,
                                    IRawElementProviderSimple2)
  strict private
    FOwner : TComponent;
    FValue: string;
    FRow: integer;
    FColumn: integer;
    FSelected : boolean;
    FCellRect : TRect;

  private
    procedure SetColumn(const Value: integer);
    procedure SetRow(const Value: integer);
    procedure SetTheValue(const Value: string);
    procedure SetSelected(const Value: boolean);
    function GetSelected : boolean;
    function GetTheValue: string;

  protected
    procedure SelectCell; virtual;

  public
    property Row : integer read FRow write SetRow;
    property Column : integer read FColumn write SetColumn;
    property Value : string read GetTheValue write SetTheValue;
    property Selected : boolean read GetSelected write SetSelected;
    property CellRect : TRect read FCellRect write FCellRect;
    property Owner : TComponent read FOwner write FOwner;

    // IRawElementProviderSimple
    function Get_ProviderOptions(out pRetVal: ProviderOptions): HResult; stdcall;
    function GetPatternProvider(patternId: SYSINT; out pRetVal: IUnknown): HResult; stdcall;
    function GetPropertyValue(propertyId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function Get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // IInvokeProvider
    function Invoke: HResult; virtual; stdcall;

    // ISelectionItemProvider
    function Select: HResult; stdcall;
    function AddToSelection: HResult; stdcall;
    function RemoveFromSelection: HResult; stdcall;
    function Get_IsSelected(out pRetVal: Integer): HResult; stdcall;
    function Get_SelectionContainer(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // IRawElementProviderSimple2
    function ShowContextMenu: HResult; virtual; stdcall;

    // IValueProvider
    function Get_Value(out pRetVal: WideString): HResult; stdcall;
    function SetValue(val: PWideChar): HResult; stdcall;
    function Get_IsReadOnly(out pRetVal: Integer): HResult; stdcall;

    // IGridItemProvider
    function Get_row(out pRetVal: SYSINT): HResult; stdcall;
    function Get_column(out pRetVal: SYSINT): HResult; stdcall;
    function Get_RowSpan(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ColumnSpan(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ContainingGrid(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // IRawElementProviderFragment
    function Navigate(direction: NavigateDirection; out pRetVal: IRawElementProviderFragment): HResult; stdcall;
    function GetRuntimeId(out pRetVal: PSafeArray): HResult; stdcall;
    function get_BoundingRectangle(out pRetVal: UiaRect): HResult; stdcall;
    function GetEmbeddedFragmentRoots(out pRetVal: PSafeArray): HResult; stdcall;
    function SetFocus: HResult; stdcall;
    function Get_FragmentRoot(out pRetVal: IRawElementProviderFragmentRoot): HResult; stdcall;

    constructor Create(AOwner: TComponent; ACol, ARow : integer; AValue : String; ACellRect : TRect);

    function asIRawElementProviderSimple: IRawElementProviderSimple;

  end;

implementation

uses
  AutomatedStringGrid,
  sysutils;

{ TAutomatedStringGridItem }

function TAutomatedStringGridItem.AddToSelection: HResult;
begin
  result := (self as ISelectionItemProvider).Select;
end;

constructor TAutomatedStringGridItem.Create(AOwner: TComponent; ACol, ARow : integer; AValue : String; ACellRect : TRect);
begin
  inherited create;

  self.Owner := AOwner;
  self.CellRect := ACellRect;
  self.Column := ACol;
  self.Row := ARow;
  self.Value := AValue;
  self.Selected := false;
end;

function TAutomatedStringGridItem.GetEmbeddedFragmentRoots(
  out pRetVal: PSafeArray): HResult;
begin
  result := S_FALSE;
end;

function TAutomatedStringGridItem.GetPatternProvider(patternId: SYSINT;
  out pRetVal: IInterface): HResult;
begin
  pRetval := nil;
  result := S_FALSE;

  if ((patternID = UIA_SelectionItemPatternId) or
      (patternID = UIA_GridItemPatternId) or
      (patternID = UIA_InvokePatternId) or
      (patternID = UIA_ValuePatternId)) then
  begin
    pRetVal := self;
    result := S_OK;
  end
end;

function TAutomatedStringGridItem.Invoke: HResult;
begin
  result := S_OK;
end;

function TAutomatedStringGridItem.GetPropertyValue(propertyId: SYSINT;
  out pRetVal: OleVariant): HResult;
begin
  if(propertyId = UIA_ControlTypePropertyId) then
  begin
    TVarData(pRetVal).VType := varWord;
    TVarData(pRetVal).VWord := UIA_DataItemControlTypeId;
    result := S_OK;
  end
  else if (propertyId = UIA_NamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := PWideChar(self.Value);
    result := S_OK;
  end
  else if(propertyId = UIA_ClassNamePropertyId) then
  begin
    TVarData(pRetVal).VType := varOleStr;
    TVarData(pRetVal).VOleStr := pWideChar(self.ClassName);
    result := S_OK;
  end
  else
    result := S_FALSE;
end;
function TAutomatedStringGridItem.GetRuntimeId(
  out pRetVal: PSafeArray): HResult;
begin
  result := S_FALSE;
end;

function TAutomatedStringGridItem.GetSelected: boolean;
begin
  result := FSelected;
end;

function TAutomatedStringGridItem.GetTheValue: string;
begin
  result := self.FValue;
end;

function TAutomatedStringGridItem.get_BoundingRectangle(
  out pRetVal: UiaRect): HResult;
begin
  pRetVal.left := self.FCellRect.Left;
  pRetVal.top := self.FCellRect.Top;

  // Not sure about these
  pRetVal.width := self.FCellRect.Right;
  pRetVal.height := self.FCellRect.Bottom;

  result := S_OK;
end;

function TAutomatedStringGridItem.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  pRetVal := nil;
  result := S_OK;
end;

function TAutomatedStringGridItem.ShowContextMenu: HResult;
begin
  result := S_FALSE;
end;

function TAutomatedStringGridItem.Get_IsReadOnly(
  out pRetVal: Integer): HResult;
begin
  pRetVal := 1;
  result := S_OK;
end;
function TAutomatedStringGridItem.Get_IsSelected(
  out pRetVal: Integer): HResult;
begin
  result := S_OK;

  if self.FSelected then
    pRetVal := 0
  else
    pRetVal := 1;
end;

function TAutomatedStringGridItem.Get_ProviderOptions(
  out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

function TAutomatedStringGridItem.Get_Value(out pRetVal: WideString): HResult;
begin
  pRetVal := self.FValue;
  result := S_OK;
end;

function TAutomatedStringGridItem.Navigate(direction: NavigateDirection;
  out pRetVal: IRawElementProviderFragment): HResult;
begin
  result := S_FALSE;
end;

function TAutomatedStringGridItem.RemoveFromSelection: HResult;
begin
  result := (self as ISelectionItemProvider).RemoveFromSelection;
end;

procedure TAutomatedStringGridItem.SelectCell;
begin
  self.FSelected := true;
end;

function TAutomatedStringGridItem.Select: HResult;
begin
  self.SelectCell;
  result := S_OK;
end;

procedure TAutomatedStringGridItem.SetColumn(const Value: integer);
begin
  FColumn := Value;
end;

function TAutomatedStringGridItem.SetFocus: HResult;
begin
  result := S_FALSE;
end;

procedure TAutomatedStringGridItem.SetRow(const Value: integer);
begin
  FRow := Value;
end;

procedure TAutomatedStringGridItem.SetSelected(const Value: boolean);
begin
  FSelected := Value;
end;

function TAutomatedStringGridItem.SetValue(val: PWideChar): HResult;
begin
  result := S_OK;
  self.FValue := val;
end;

procedure TAutomatedStringGridItem.SetTheValue(const Value: string);
begin
  FValue := Value;
end;

function TAutomatedStringGridItem.Get_row(out pRetVal: SYSINT): HResult;
begin
  pRetVal := self.Row;
  result := S_OK;
end;

function TAutomatedStringGridItem.Get_column(out pRetVal: SYSINT): HResult;
begin
  pRetVal := self.Column;
  result := S_OK;
end;

function TAutomatedStringGridItem.Get_RowSpan(out pRetVal: SYSINT): HResult;
begin
  pRetVal := 1;
  result := S_OK;
end;

function TAutomatedStringGridItem.Get_SelectionContainer(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  result := S_FALSE;
//  pRetVal := FOwner as IRawElementProviderSimple;
end;

function TAutomatedStringGridItem.Get_ColumnSpan(out pRetVal: SYSINT): HResult;
begin
  pRetVal := 1;
  result := S_OK;
end;

function TAutomatedStringGridItem.Get_ContainingGrid(out pRetVal: IRawElementProviderSimple): HResult;
begin
//  pRetVal := FOwner as IRawElementProviderSimple;
  result := S_FALSE;
end;

function TAutomatedStringGridItem.Get_FragmentRoot(
  out pRetVal: IRawElementProviderFragmentRoot): HResult;
begin
  result := S_FALSE;
end;

function TAutomatedStringGridItem.asIRawElementProviderSimple: IRawElementProviderSimple;
begin
  result := (self as IRawElementProviderSimple);
end;

end.
