unit AutomatedStringGrid;

interface

uses
  UIAutomationCore_TLB,
  windows,
  messages,
  classes,
  ActiveX,
  grids;

type
  TStringGrid = class(Grids.TStringGrid,
                      //ISelectionProvider,
                      IInvokeProvider,
                      IValueProvider,
                      IRawElementProviderSimple)
  private
    //FOwner: TComponent;
    FRawElementProviderSimple : IRawElementProviderSimple;
    procedure WMGetObject(var Message: TMessage); message WM_GETOBJECT;

  public
    // IRawElementProviderSimple
    function Get_ProviderOptions(out pRetVal: ProviderOptions): HResult; stdcall;
    function GetPatternProvider(patternId: SYSINT; out pRetVal: IUnknown): HResult; stdcall;
    function GetPropertyValue(propertyId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function Get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HResult; stdcall;

    // ISelectionProvider
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
      (patternID = UIA_ValuePatternId)) then
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
begin
  pRetVal := nil;
  result := S_OK;
end;

function TStringGrid.Get_CanSelectMultiple(out pRetVal: Integer): HResult;
begin
  pRetVal := 1;
  result := S_OK;
end;

function TStringGrid.Get_HostRawElementProvider(
  out pRetVal: IRawElementProviderSimple): HResult;
begin
  result := UiaHostProviderFromHwnd (self.Handle, pRetVal);
end;

function TStringGrid.Get_IsSelectionRequired(out pRetVal: Integer): HResult;
begin
  pRetVal := 1;
  result := S_OK;
end;

function TStringGrid.Get_ProviderOptions(out pRetVal: ProviderOptions): HResult;
begin
  pRetVal:= ProviderOptions_ServerSideProvider;
  Result := S_OK;
end;

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
  pRetVal := 1;
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
