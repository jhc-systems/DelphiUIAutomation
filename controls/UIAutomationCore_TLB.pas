unit UIAutomationCore_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 26/02/2017 17:21:58 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\SysWOW64\UIAutomationCore.dll\3 (1)
// LIBID: {930299CE-9965-4DEC-B0F4-A54848D4B667}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Parameter 'unit' of ITextRangeProvider.ExpandToEnclosingUnit changed to 'unit_'
//   Hint: Parameter 'unit' of ITextRangeProvider.Move changed to 'unit_'
//   Hint: Parameter 'unit' of ITextRangeProvider.MoveEndpointByUnit changed to 'unit_'
//   Hint: Symbol 'type' renamed to 'type_'
//   Hint: Parameter 'type' of IUIAutomationPatternInstance.GetProperty changed to 'type_'
//   Hint: Parameter 'property' of IUIAutomationRegistrar.RegisterProperty changed to 'property_'
//   Error creating palette bitmap of (TCUIAutomationRegistrar) : Server C:\Windows\SysWOW64\uiautomationcore.dll contains no icons
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  UIAMajorVersion = 1;
  UIAMinorVersion = 0;

  LIBID_UIA: TGUID = '{930299CE-9965-4DEC-B0F4-A54848D4B667}';

  IID_IRawElementProviderSimple: TGUID = '{D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}';
  IID_IAccessibleEx: TGUID = '{F8B80ADA-2C44-48D0-89BE-5FF23C9CD875}';
  IID_IAccessible: TGUID = '{618736E0-3C3D-11CF-810C-00AA00389B71}';
  IID_IRawElementProviderSimple2: TGUID = '{A0A839A9-8DA1-4A82-806A-8E0D44E79F56}';
  IID_IRawElementProviderSimple3: TGUID = '{FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}';
  IID_IRawElementProviderFragmentRoot: TGUID = '{620CE2A5-AB8F-40A9-86CB-DE3C75599B58}';
  IID_IRawElementProviderFragment: TGUID = '{F7063DA8-8359-439C-9297-BBC5299A7D87}';
  IID_IRawElementProviderAdviseEvents: TGUID = '{A407B27B-0F6D-4427-9292-473C7BF93258}';
  IID_IRawElementProviderHwndOverride: TGUID = '{1D5DF27C-8947-4425-B8D9-79787BB460B8}';
  IID_IProxyProviderWinEventSink: TGUID = '{4FD82B78-A43E-46AC-9803-0A6969C7C183}';
  IID_IProxyProviderWinEventHandler: TGUID = '{89592AD4-F4E0-43D5-A3B6-BAD7E111B435}';
  IID_IRawElementProviderWindowlessSite: TGUID = '{0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}';
  IID_IAccessibleHostingElementProviders: TGUID = '{33AC331B-943E-4020-B295-DB37784974A3}';
  IID_IRawElementProviderHostingAccessibles: TGUID = '{24BE0B07-D37D-487A-98CF-A13ED465E9B3}';
  IID_IDockProvider: TGUID = '{159BC72C-4AD3-485E-9637-D7052EDF0146}';
  IID_IExpandCollapseProvider: TGUID = '{D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}';
  IID_IGridProvider: TGUID = '{B17D6187-0907-464B-A168-0EF17A1572B1}';
  IID_IGridItemProvider: TGUID = '{D02541F1-FB81-4D64-AE32-F520F8A6DBD1}';
  IID_IInvokeProvider: TGUID = '{54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}';
  IID_IMultipleViewProvider: TGUID = '{6278CAB1-B556-4A1A-B4E0-418ACC523201}';
  IID_IRangeValueProvider: TGUID = '{36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}';
  IID_IScrollItemProvider: TGUID = '{2360C714-4BF1-4B26-BA65-9B21316127EB}';
  IID_ISelectionProvider: TGUID = '{FB8B03AF-3BDF-48D4-BD36-1A65793BE168}';
  IID_IScrollProvider: TGUID = '{B38B8077-1FC3-42A5-8CAE-D40C2215055A}';
  IID_ISelectionItemProvider: TGUID = '{2ACAD808-B2D4-452D-A407-91FF1AD167B2}';
  IID_ISynchronizedInputProvider: TGUID = '{29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}';
  IID_ITableProvider: TGUID = '{9C860395-97B3-490A-B52A-858CC22AF166}';
  IID_ITableItemProvider: TGUID = '{B9734FA6-771F-4D78-9C90-2517999349CD}';
  IID_IToggleProvider: TGUID = '{56D00BD0-C4F4-433C-A836-1A52A57E0892}';
  IID_ITransformProvider: TGUID = '{6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}';
  IID_IValueProvider: TGUID = '{C7935180-6FB3-4201-B174-7DF73ADBF64A}';
  IID_IWindowProvider: TGUID = '{987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}';
  IID_ILegacyIAccessibleProvider: TGUID = '{E44C3566-915D-4070-99C6-047BFF5A08F5}';
  IID_IItemContainerProvider: TGUID = '{E747770B-39CE-4382-AB30-D8FB3F336F24}';
  IID_IVirtualizedItemProvider: TGUID = '{CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}';
  IID_IObjectModelProvider: TGUID = '{3AD86EBD-F5EF-483D-BB18-B1042A475D64}';
  IID_IAnnotationProvider: TGUID = '{F95C7E80-BD63-4601-9782-445EBFF011FC}';
  IID_IStylesProvider: TGUID = '{19B6B649-F5D7-4A6D-BDCB-129252BE588A}';
  IID_ISpreadsheetProvider: TGUID = '{6F6B5D35-5525-4F80-B758-85473832FFC7}';
  IID_ISpreadsheetItemProvider: TGUID = '{EAED4660-7B3D-4879-A2E6-365CE603F3D0}';
  IID_ITransformProvider2: TGUID = '{4758742F-7AC2-460C-BC48-09FC09308A93}';
  IID_IDragProvider: TGUID = '{6AA7BBBB-7FF9-497D-904F-D20B897929D8}';
  IID_IDropTargetProvider: TGUID = '{BAE82BFD-358A-481C-85A0-D8B4D90A5D61}';
  IID_ITextRangeProvider: TGUID = '{5347AD7B-C355-46F8-AFF5-909033582F63}';
  IID_ITextProvider: TGUID = '{3589C92C-63F3-4367-99BB-ADA653B77CF2}';
  IID_ITextProvider2: TGUID = '{0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}';
  IID_ITextEditProvider: TGUID = '{EA3605B4-3A05-400E-B5F9-4E91B40F6176}';
  IID_ITextRangeProvider2: TGUID = '{9BBCE42C-1921-4F18-89CA-DBA1910A0386}';
  IID_ITextChildProvider: TGUID = '{4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}';
  IID_ICustomNavigationProvider: TGUID = '{2062A28A-8C07-4B94-8E12-7037C622AEB8}';
  IID_IUIAutomationPatternInstance: TGUID = '{C03A7FE4-9431-409F-BED8-AE7C2299BC8D}';
  IID_IUIAutomationPatternHandler: TGUID = '{D97022F3-A947-465E-8B2A-AC4315FA54E8}';
  IID_IUIAutomationRegistrar: TGUID = '{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}';
  CLASS_CUIAutomationRegistrar: TGUID = '{6E29FABF-9977-42D1-8D0E-CA7E61AD87E6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum ProviderOptions
type
  ProviderOptions = TOleEnum;
const
  ProviderOptions_ClientSideProvider = $00000001;
  ProviderOptions_ServerSideProvider = $00000002;
  ProviderOptions_NonClientAreaProvider = $00000004;
  ProviderOptions_OverrideProvider = $00000008;
  ProviderOptions_ProviderOwnsSetFocus = $00000010;
  ProviderOptions_UseComThreading = $00000020;
  ProviderOptions_RefuseNonClientSupport = $00000040;
  ProviderOptions_HasNativeIAccessible = $00000080;
  ProviderOptions_UseClientCoordinates = $00000100;

// Constants for enum NavigateDirection
type
  NavigateDirection = TOleEnum;
const
  NavigateDirection_Parent = $00000000;
  NavigateDirection_NextSibling = $00000001;
  NavigateDirection_PreviousSibling = $00000002;
  NavigateDirection_FirstChild = $00000003;
  NavigateDirection_LastChild = $00000004;

// Constants for enum StructureChangeType
type
  StructureChangeType = TOleEnum;
const
  StructureChangeType_ChildAdded = $00000000;
  StructureChangeType_ChildRemoved = $00000001;
  StructureChangeType_ChildrenInvalidated = $00000002;
  StructureChangeType_ChildrenBulkAdded = $00000003;
  StructureChangeType_ChildrenBulkRemoved = $00000004;
  StructureChangeType_ChildrenReordered = $00000005;

// Constants for enum DockPosition
type
  DockPosition = TOleEnum;
const
  DockPosition_Top = $00000000;
  DockPosition_Left = $00000001;
  DockPosition_Bottom = $00000002;
  DockPosition_Right = $00000003;
  DockPosition_Fill = $00000004;
  DockPosition_None = $00000005;

// Constants for enum ExpandCollapseState
type
  ExpandCollapseState = TOleEnum;
const
  ExpandCollapseState_Collapsed = $00000000;
  ExpandCollapseState_Expanded = $00000001;
  ExpandCollapseState_PartiallyExpanded = $00000002;
  ExpandCollapseState_LeafNode = $00000003;

// Constants for enum ScrollAmount
type
  ScrollAmount = TOleEnum;
const
  ScrollAmount_LargeDecrement = $00000000;
  ScrollAmount_SmallDecrement = $00000001;
  ScrollAmount_NoAmount = $00000002;
  ScrollAmount_LargeIncrement = $00000003;
  ScrollAmount_SmallIncrement = $00000004;

// Constants for enum SynchronizedInputType
type
  SynchronizedInputType = TOleEnum;
const
  SynchronizedInputType_KeyUp = $00000001;
  SynchronizedInputType_KeyDown = $00000002;
  SynchronizedInputType_LeftMouseUp = $00000004;
  SynchronizedInputType_LeftMouseDown = $00000008;
  SynchronizedInputType_RightMouseUp = $00000010;
  SynchronizedInputType_RightMouseDown = $00000020;

// Constants for enum RowOrColumnMajor
type
  RowOrColumnMajor = TOleEnum;
const
  RowOrColumnMajor_RowMajor = $00000000;
  RowOrColumnMajor_ColumnMajor = $00000001;
  RowOrColumnMajor_Indeterminate = $00000002;

// Constants for enum ToggleState
type
  ToggleState = TOleEnum;
const
  ToggleState_Off = $00000000;
  ToggleState_On = $00000001;
  ToggleState_Indeterminate = $00000002;

// Constants for enum WindowVisualState
type
  WindowVisualState = TOleEnum;
const
  WindowVisualState_Normal = $00000000;
  WindowVisualState_Maximized = $00000001;
  WindowVisualState_Minimized = $00000002;

// Constants for enum WindowInteractionState
type
  WindowInteractionState = TOleEnum;
const
  WindowInteractionState_Running = $00000000;
  WindowInteractionState_Closing = $00000001;
  WindowInteractionState_ReadyForUserInteraction = $00000002;
  WindowInteractionState_BlockedByModalWindow = $00000003;
  WindowInteractionState_NotResponding = $00000004;

// Constants for enum ZoomUnit
type
  ZoomUnit = TOleEnum;
const
  ZoomUnit_NoAmount = $00000000;
  ZoomUnit_LargeDecrement = $00000001;
  ZoomUnit_SmallDecrement = $00000002;
  ZoomUnit_LargeIncrement = $00000003;
  ZoomUnit_SmallIncrement = $00000004;

// Constants for enum TextPatternRangeEndpoint
type
  TextPatternRangeEndpoint = TOleEnum;
const
  TextPatternRangeEndpoint_Start = $00000000;
  TextPatternRangeEndpoint_End = $00000001;

// Constants for enum TextUnit
type
  TextUnit = TOleEnum;
const
  TextUnit_Character = $00000000;
  TextUnit_Format = $00000001;
  TextUnit_Word = $00000002;
  TextUnit_Line = $00000003;
  TextUnit_Paragraph = $00000004;
  TextUnit_Page = $00000005;
  TextUnit_Document = $00000006;

// Constants for enum SupportedTextSelection
type
  SupportedTextSelection = TOleEnum;
const
  SupportedTextSelection_None = $00000000;
  SupportedTextSelection_Single = $00000001;
  SupportedTextSelection_Multiple = $00000002;

// Constants for enum UIAutomationType
type
  UIAutomationType = TOleEnum;
const
  UIAutomationType_Int = $00000001;
  UIAutomationType_Bool = $00000002;
  UIAutomationType_String = $00000003;
  UIAutomationType_Double = $00000004;
  UIAutomationType_Point = $00000005;
  UIAutomationType_Rect = $00000006;
  UIAutomationType_Element = $00000007;
  UIAutomationType_Array = $00010000;
  UIAutomationType_Out = $00020000;
  UIAutomationType_IntArray = $00010001;
  UIAutomationType_BoolArray = $00010002;
  UIAutomationType_StringArray = $00010003;
  UIAutomationType_DoubleArray = $00010004;
  UIAutomationType_PointArray = $00010005;
  UIAutomationType_RectArray = $00010006;
  UIAutomationType_ElementArray = $00010007;
  UIAutomationType_OutInt = $00020001;
  UIAutomationType_OutBool = $00020002;
  UIAutomationType_OutString = $00020003;
  UIAutomationType_OutDouble = $00020004;
  UIAutomationType_OutPoint = $00020005;
  UIAutomationType_OutRect = $00020006;
  UIAutomationType_OutElement = $00020007;
  UIAutomationType_OutIntArray = $00030001;
  UIAutomationType_OutBoolArray = $00030002;
  UIAutomationType_OutStringArray = $00030003;
  UIAutomationType_OutDoubleArray = $00030004;
  UIAutomationType_OutPointArray = $00030005;
  UIAutomationType_OutRectArray = $00030006;
  UIAutomationType_OutElementArray = $00030007;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IRawElementProviderSimple = interface;
  IAccessibleEx = interface;
  IAccessible = interface;
  IAccessibleDisp = dispinterface;
  IRawElementProviderSimple2 = interface;
  IRawElementProviderSimple3 = interface;
  IRawElementProviderFragmentRoot = interface;
  IRawElementProviderFragment = interface;
  IRawElementProviderAdviseEvents = interface;
  IRawElementProviderHwndOverride = interface;
  IProxyProviderWinEventSink = interface;
  IProxyProviderWinEventHandler = interface;
  IRawElementProviderWindowlessSite = interface;
  IAccessibleHostingElementProviders = interface;
  IRawElementProviderHostingAccessibles = interface;
  IDockProvider = interface;
  IExpandCollapseProvider = interface;
  IGridProvider = interface;
  IGridItemProvider = interface;
  IInvokeProvider = interface;
  IMultipleViewProvider = interface;
  IRangeValueProvider = interface;
  IScrollItemProvider = interface;
  ISelectionProvider = interface;
  IScrollProvider = interface;
  ISelectionItemProvider = interface;
  ISynchronizedInputProvider = interface;
  ITableProvider = interface;
  ITableItemProvider = interface;
  IToggleProvider = interface;
  ITransformProvider = interface;
  IValueProvider = interface;
  IWindowProvider = interface;
  ILegacyIAccessibleProvider = interface;
  IItemContainerProvider = interface;
  IVirtualizedItemProvider = interface;
  IObjectModelProvider = interface;
  IAnnotationProvider = interface;
  IStylesProvider = interface;
  ISpreadsheetProvider = interface;
  ISpreadsheetItemProvider = interface;
  ITransformProvider2 = interface;
  IDragProvider = interface;
  IDropTargetProvider = interface;
  ITextRangeProvider = interface;
  ITextProvider = interface;
  ITextProvider2 = interface;
  ITextEditProvider = interface;
  ITextRangeProvider2 = interface;
  ITextChildProvider = interface;
  ICustomNavigationProvider = interface;
  IUIAutomationPatternInstance = interface;
  IUIAutomationPatternHandler = interface;
  IUIAutomationRegistrar = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  CUIAutomationRegistrar = IUIAutomationRegistrar;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  wireHWND = ^_RemotableHandle;
  PUserType1 = ^UIAutomationParameter; {*}
  PUserType2 = ^UIAutomationPropertyInfo; {*}
  PUserType3 = ^UIAutomationEventInfo; {*}
  PUserType4 = ^UIAutomationPatternInfo; {*}

{$ALIGN 8}
  UiaRect = record
    left: Double;
    top: Double;
    width: Double;
    height: Double;
  end;


{$ALIGN 4}
  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;

{$ALIGN 8}
  UiaPoint = record
    x: Double;
    y: Double;
  end;

{$ALIGN 4}
  UIAutomationParameter = record
    type_: UIAutomationType;
    pData: Pointer;
  end;

  UIAutomationPropertyInfo = record
    guid: TGUID;
    pProgrammaticName: PWideChar;
    type_: UIAutomationType;
  end;

  UIAutomationEventInfo = record
    guid: TGUID;
    pProgrammaticName: PWideChar;
  end;

  UIAutomationMethodInfo = record
    pProgrammaticName: PWideChar;
    doSetFocus: Integer;
    cInParameters: SYSUINT;
    cOutParameters: SYSUINT;
    pParameterTypes: ^UIAutomationType;
    pParameterNames: ^PWideChar;
  end;

  UIAutomationPatternInfo = record
    guid: TGUID;
    pProgrammaticName: PWideChar;
    providerInterfaceId: TGUID;
    clientInterfaceId: TGUID;
    cProperties: SYSUINT;
    pProperties: ^UIAutomationPropertyInfo;
    cMethods: SYSUINT;
    pMethods: ^UIAutomationMethodInfo;
    cEvents: SYSUINT;
    pEvents: ^UIAutomationEventInfo;
    pPatternHandler: IUIAutomationPatternHandler;
  end;


// *********************************************************************//
// Interface: IRawElementProviderSimple
// Flags:     (256) OleAutomation
// GUID:      {D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}
// *********************************************************************//
  IRawElementProviderSimple = interface(IUnknown)
    ['{D6DD68D1-86FD-4332-8666-9ABEDEA2D24C}']
    function Get_ProviderOptions(out pRetVal: ProviderOptions): HResult; stdcall;
    function GetPatternProvider(patternId: SYSINT; out pRetVal: IUnknown): HResult; stdcall;
    function GetPropertyValue(propertyId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function Get_HostRawElementProvider(out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccessibleEx
// Flags:     (256) OleAutomation
// GUID:      {F8B80ADA-2C44-48D0-89BE-5FF23C9CD875}
// *********************************************************************//
  IAccessibleEx = interface(IUnknown)
    ['{F8B80ADA-2C44-48D0-89BE-5FF23C9CD875}']
    function GetObjectForChild(idChild: Integer; out pRetVal: IAccessibleEx): HResult; stdcall;
    function GetIAccessiblePair(out ppAcc: IAccessible; out pidChild: Integer): HResult; stdcall;
    function GetRuntimeId(out pRetVal: PSafeArray): HResult; stdcall;
    function ConvertReturnedElement(const pIn: IRawElementProviderSimple;
                                    out ppRetValOut: IAccessibleEx): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccessible
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {618736E0-3C3D-11CF-810C-00AA00389B71}
// *********************************************************************//
  IAccessible = interface(IDispatch)
    ['{618736E0-3C3D-11CF-810C-00AA00389B71}']
    function Get_accParent: IDispatch; safecall;
    function Get_accChildCount: Integer; safecall;
    function Get_accChild(varChild: OleVariant): IDispatch; safecall;
    function Get_accName(varChild: OleVariant): WideString; safecall;
    function Get_accValue(varChild: OleVariant): WideString; safecall;
    function Get_accDescription(varChild: OleVariant): WideString; safecall;
    function Get_accRole(varChild: OleVariant): OleVariant; safecall;
    function Get_accState(varChild: OleVariant): OleVariant; safecall;
    function Get_accHelp(varChild: OleVariant): WideString; safecall;
    function Get_accHelpTopic(out pszHelpFile: WideString; varChild: OleVariant): Integer; safecall;
    function Get_accKeyboardShortcut(varChild: OleVariant): WideString; safecall;
    function Get_accFocus: OleVariant; safecall;
    function Get_accSelection: OleVariant; safecall;
    function Get_accDefaultAction(varChild: OleVariant): WideString; safecall;
    procedure accSelect(flagsSelect: Integer; varChild: OleVariant); safecall;
    procedure accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer;
                          out pcyHeight: Integer; varChild: OleVariant); safecall;
    function accNavigate(navDir: Integer; varStart: OleVariant): OleVariant; safecall;
    function accHitTest(xLeft: Integer; yTop: Integer): OleVariant; safecall;
    procedure accDoDefaultAction(varChild: OleVariant); safecall;
    procedure Set_accName(varChild: OleVariant; const pszName: WideString); safecall;
    procedure Set_accValue(varChild: OleVariant; const pszValue: WideString); safecall;
    property accParent: IDispatch read Get_accParent;
    property accChildCount: Integer read Get_accChildCount;
    property accChild[varChild: OleVariant]: IDispatch read Get_accChild;
    property accName[varChild: OleVariant]: WideString read Get_accName write Set_accName;
    property accValue[varChild: OleVariant]: WideString read Get_accValue write Set_accValue;
    property accDescription[varChild: OleVariant]: WideString read Get_accDescription;
    property accRole[varChild: OleVariant]: OleVariant read Get_accRole;
    property accState[varChild: OleVariant]: OleVariant read Get_accState;
    property accHelp[varChild: OleVariant]: WideString read Get_accHelp;
    property accHelpTopic[out pszHelpFile: WideString; varChild: OleVariant]: Integer read Get_accHelpTopic;
    property accKeyboardShortcut[varChild: OleVariant]: WideString read Get_accKeyboardShortcut;
    property accFocus: OleVariant read Get_accFocus;
    property accSelection: OleVariant read Get_accSelection;
    property accDefaultAction[varChild: OleVariant]: WideString read Get_accDefaultAction;
  end;

// *********************************************************************//
// DispIntf:  IAccessibleDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {618736E0-3C3D-11CF-810C-00AA00389B71}
// *********************************************************************//
  IAccessibleDisp = dispinterface
    ['{618736E0-3C3D-11CF-810C-00AA00389B71}']
    property accParent: IDispatch readonly dispid -5000;
    property accChildCount: Integer readonly dispid -5001;
    property accChild[varChild: OleVariant]: IDispatch readonly dispid -5002;
    property accName[varChild: OleVariant]: WideString dispid -5003;
    property accValue[varChild: OleVariant]: WideString dispid -5004;
    property accDescription[varChild: OleVariant]: WideString readonly dispid -5005;
    property accRole[varChild: OleVariant]: OleVariant readonly dispid -5006;
    property accState[varChild: OleVariant]: OleVariant readonly dispid -5007;
    property accHelp[varChild: OleVariant]: WideString readonly dispid -5008;
    property accHelpTopic[out pszHelpFile: WideString; varChild: OleVariant]: Integer readonly dispid -5009;
    property accKeyboardShortcut[varChild: OleVariant]: WideString readonly dispid -5010;
    property accFocus: OleVariant readonly dispid -5011;
    property accSelection: OleVariant readonly dispid -5012;
    property accDefaultAction[varChild: OleVariant]: WideString readonly dispid -5013;
    procedure accSelect(flagsSelect: Integer; varChild: OleVariant); dispid -5014;
    procedure accLocation(out pxLeft: Integer; out pyTop: Integer; out pcxWidth: Integer;
                          out pcyHeight: Integer; varChild: OleVariant); dispid -5015;
    function accNavigate(navDir: Integer; varStart: OleVariant): OleVariant; dispid -5016;
    function accHitTest(xLeft: Integer; yTop: Integer): OleVariant; dispid -5017;
    procedure accDoDefaultAction(varChild: OleVariant); dispid -5018;
  end;

// *********************************************************************//
// Interface: IRawElementProviderSimple2
// Flags:     (256) OleAutomation
// GUID:      {A0A839A9-8DA1-4A82-806A-8E0D44E79F56}
// *********************************************************************//
  IRawElementProviderSimple2 = interface(IRawElementProviderSimple)
    ['{A0A839A9-8DA1-4A82-806A-8E0D44E79F56}']
    function ShowContextMenu: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderSimple3
// Flags:     (256) OleAutomation
// GUID:      {FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}
// *********************************************************************//
  IRawElementProviderSimple3 = interface(IRawElementProviderSimple2)
    ['{FCF5D820-D7EC-4613-BDF6-42A84CE7DAAF}']
    function GetMetadataValue(targetId: SYSINT; metadataId: SYSINT; out returnVal: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderFragmentRoot
// Flags:     (256) OleAutomation
// GUID:      {620CE2A5-AB8F-40A9-86CB-DE3C75599B58}
// *********************************************************************//
  IRawElementProviderFragmentRoot = interface(IUnknown)
    ['{620CE2A5-AB8F-40A9-86CB-DE3C75599B58}']
    function ElementProviderFromPoint(x: Double; y: Double; out pRetVal: IRawElementProviderFragment): HResult; stdcall;
    function GetFocus(out pRetVal: IRawElementProviderFragment): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderFragment
// Flags:     (256) OleAutomation
// GUID:      {F7063DA8-8359-439C-9297-BBC5299A7D87}
// *********************************************************************//
  IRawElementProviderFragment = interface(IUnknown)
    ['{F7063DA8-8359-439C-9297-BBC5299A7D87}']
    function Navigate(direction: NavigateDirection; out pRetVal: IRawElementProviderFragment): HResult; stdcall;
    function GetRuntimeId(out pRetVal: PSafeArray): HResult; stdcall;
    function get_BoundingRectangle(out pRetVal: UiaRect): HResult; stdcall;
    function GetEmbeddedFragmentRoots(out pRetVal: PSafeArray): HResult; stdcall;
    function SetFocus: HResult; stdcall;
    function Get_FragmentRoot(out pRetVal: IRawElementProviderFragmentRoot): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderAdviseEvents
// Flags:     (256) OleAutomation
// GUID:      {A407B27B-0F6D-4427-9292-473C7BF93258}
// *********************************************************************//
  IRawElementProviderAdviseEvents = interface(IUnknown)
    ['{A407B27B-0F6D-4427-9292-473C7BF93258}']
    function AdviseEventAdded(eventId: SYSINT; propertyIDs: PSafeArray): HResult; stdcall;
    function AdviseEventRemoved(eventId: SYSINT; propertyIDs: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderHwndOverride
// Flags:     (256) OleAutomation
// GUID:      {1D5DF27C-8947-4425-B8D9-79787BB460B8}
// *********************************************************************//
  IRawElementProviderHwndOverride = interface(IUnknown)
    ['{1D5DF27C-8947-4425-B8D9-79787BB460B8}']
    function GetOverrideProviderForHwnd(var hwnd: _RemotableHandle;
                                        out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IProxyProviderWinEventSink
// Flags:     (256) OleAutomation
// GUID:      {4FD82B78-A43E-46AC-9803-0A6969C7C183}
// *********************************************************************//
  IProxyProviderWinEventSink = interface(IUnknown)
    ['{4FD82B78-A43E-46AC-9803-0A6969C7C183}']
    function AddAutomationPropertyChangedEvent(const pProvider: IRawElementProviderSimple;
                                               id: SYSINT; newValue: OleVariant): HResult; stdcall;
    function AddAutomationEvent(const pProvider: IRawElementProviderSimple; id: SYSINT): HResult; stdcall;
    function AddStructureChangedEvent(const pProvider: IRawElementProviderSimple;
                                      StructureChangeType: StructureChangeType;
                                      runtimeId: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IProxyProviderWinEventHandler
// Flags:     (256) OleAutomation
// GUID:      {89592AD4-F4E0-43D5-A3B6-BAD7E111B435}
// *********************************************************************//
  IProxyProviderWinEventHandler = interface(IUnknown)
    ['{89592AD4-F4E0-43D5-A3B6-BAD7E111B435}']
    function RespondToWinEvent(idWinEvent: LongWord; var hwnd: _RemotableHandle; idObject: Integer;
                               idChild: Integer; const pSink: IProxyProviderWinEventSink): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderWindowlessSite
// Flags:     (256) OleAutomation
// GUID:      {0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}
// *********************************************************************//
  IRawElementProviderWindowlessSite = interface(IUnknown)
    ['{0A2A93CC-BFAD-42AC-9B2E-0991FB0D3EA0}']
    function GetAdjacentFragment(direction: NavigateDirection;
                                 out ppParent: IRawElementProviderFragment): HResult; stdcall;
    function GetRuntimeIdPrefix(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAccessibleHostingElementProviders
// Flags:     (256) OleAutomation
// GUID:      {33AC331B-943E-4020-B295-DB37784974A3}
// *********************************************************************//
  IAccessibleHostingElementProviders = interface(IUnknown)
    ['{33AC331B-943E-4020-B295-DB37784974A3}']
    function GetEmbeddedFragmentRoots(out pRetVal: PSafeArray): HResult; stdcall;
    function GetObjectIdForProvider(const pProvider: IRawElementProviderSimple;
                                    out pidObject: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRawElementProviderHostingAccessibles
// Flags:     (256) OleAutomation
// GUID:      {24BE0B07-D37D-487A-98CF-A13ED465E9B3}
// *********************************************************************//
  IRawElementProviderHostingAccessibles = interface(IUnknown)
    ['{24BE0B07-D37D-487A-98CF-A13ED465E9B3}']
    function GetEmbeddedAccessibles(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDockProvider
// Flags:     (256) OleAutomation
// GUID:      {159BC72C-4AD3-485E-9637-D7052EDF0146}
// *********************************************************************//
  IDockProvider = interface(IUnknown)
    ['{159BC72C-4AD3-485E-9637-D7052EDF0146}']
    function SetDockPosition(DockPosition: DockPosition): HResult; stdcall;
    function Get_DockPosition(out pRetVal: DockPosition): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IExpandCollapseProvider
// Flags:     (256) OleAutomation
// GUID:      {D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}
// *********************************************************************//
  IExpandCollapseProvider = interface(IUnknown)
    ['{D847D3A5-CAB0-4A98-8C32-ECB45C59AD24}']
    function Expand: HResult; stdcall;
    function Collapse: HResult; stdcall;
    function Get_ExpandCollapseState(out pRetVal: ExpandCollapseState): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGridProvider
// Flags:     (256) OleAutomation
// GUID:      {B17D6187-0907-464B-A168-0EF17A1572B1}
// *********************************************************************//
  IGridProvider = interface(IUnknown)
    ['{B17D6187-0907-464B-A168-0EF17A1572B1}']
    function GetItem(row: SYSINT; column: SYSINT; out pRetVal: IRawElementProviderSimple): HResult; stdcall;
    function Get_RowCount(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ColumnCount(out pRetVal: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IGridItemProvider
// Flags:     (256) OleAutomation
// GUID:      {D02541F1-FB81-4D64-AE32-F520F8A6DBD1}
// *********************************************************************//
  IGridItemProvider = interface(IUnknown)
    ['{D02541F1-FB81-4D64-AE32-F520F8A6DBD1}']
    function Get_row(out pRetVal: SYSINT): HResult; stdcall;
    function Get_column(out pRetVal: SYSINT): HResult; stdcall;
    function Get_RowSpan(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ColumnSpan(out pRetVal: SYSINT): HResult; stdcall;
    function Get_ContainingGrid(out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IInvokeProvider
// Flags:     (256) OleAutomation
// GUID:      {54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}
// *********************************************************************//
  IInvokeProvider = interface(IUnknown)
    ['{54FCB24B-E18E-47A2-B4D3-ECCBE77599A2}']
    function Invoke: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMultipleViewProvider
// Flags:     (256) OleAutomation
// GUID:      {6278CAB1-B556-4A1A-B4E0-418ACC523201}
// *********************************************************************//
  IMultipleViewProvider = interface(IUnknown)
    ['{6278CAB1-B556-4A1A-B4E0-418ACC523201}']
    function GetViewName(viewId: SYSINT; out pRetVal: WideString): HResult; stdcall;
    function SetCurrentView(viewId: SYSINT): HResult; stdcall;
    function Get_CurrentView(out pRetVal: SYSINT): HResult; stdcall;
    function GetSupportedViews(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRangeValueProvider
// Flags:     (256) OleAutomation
// GUID:      {36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}
// *********************************************************************//
  IRangeValueProvider = interface(IUnknown)
    ['{36DC7AEF-33E6-4691-AFE1-2BE7274B3D33}']
    function SetValue(val: Double): HResult; stdcall;
    function Get_Value(out pRetVal: Double): HResult; stdcall;
    function Get_IsReadOnly(out pRetVal: Integer): HResult; stdcall;
    function Get_Maximum(out pRetVal: Double): HResult; stdcall;
    function Get_Minimum(out pRetVal: Double): HResult; stdcall;
    function Get_LargeChange(out pRetVal: Double): HResult; stdcall;
    function Get_SmallChange(out pRetVal: Double): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IScrollItemProvider
// Flags:     (256) OleAutomation
// GUID:      {2360C714-4BF1-4B26-BA65-9B21316127EB}
// *********************************************************************//
  IScrollItemProvider = interface(IUnknown)
    ['{2360C714-4BF1-4B26-BA65-9B21316127EB}']
    function ScrollIntoView: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISelectionProvider
// Flags:     (256) OleAutomation
// GUID:      {FB8B03AF-3BDF-48D4-BD36-1A65793BE168}
// *********************************************************************//
  ISelectionProvider = interface(IUnknown)
    ['{FB8B03AF-3BDF-48D4-BD36-1A65793BE168}']
    function GetSelection(out pRetVal: PSafeArray): HResult; stdcall;
    function Get_CanSelectMultiple(out pRetVal: Integer): HResult; stdcall;
    function Get_IsSelectionRequired(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IScrollProvider
// Flags:     (256) OleAutomation
// GUID:      {B38B8077-1FC3-42A5-8CAE-D40C2215055A}
// *********************************************************************//
  IScrollProvider = interface(IUnknown)
    ['{B38B8077-1FC3-42A5-8CAE-D40C2215055A}']
    function Scroll(horizontalAmount: ScrollAmount; verticalAmount: ScrollAmount): HResult; stdcall;
    function SetScrollPercent(horizontalPercent: Double; verticalPercent: Double): HResult; stdcall;
    function Get_HorizontalScrollPercent(out pRetVal: Double): HResult; stdcall;
    function Get_VerticalScrollPercent(out pRetVal: Double): HResult; stdcall;
    function Get_HorizontalViewSize(out pRetVal: Double): HResult; stdcall;
    function Get_VerticalViewSize(out pRetVal: Double): HResult; stdcall;
    function Get_HorizontallyScrollable(out pRetVal: Integer): HResult; stdcall;
    function Get_VerticallyScrollable(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISelectionItemProvider
// Flags:     (256) OleAutomation
// GUID:      {2ACAD808-B2D4-452D-A407-91FF1AD167B2}
// *********************************************************************//
  ISelectionItemProvider = interface(IUnknown)
    ['{2ACAD808-B2D4-452D-A407-91FF1AD167B2}']
    function Select: HResult; stdcall;
    function AddToSelection: HResult; stdcall;
    function RemoveFromSelection: HResult; stdcall;
    function Get_IsSelected(out pRetVal: Integer): HResult; stdcall;
    function Get_SelectionContainer(out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISynchronizedInputProvider
// Flags:     (256) OleAutomation
// GUID:      {29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}
// *********************************************************************//
  ISynchronizedInputProvider = interface(IUnknown)
    ['{29DB1A06-02CE-4CF7-9B42-565D4FAB20EE}']
    function StartListening(inputType: SynchronizedInputType): HResult; stdcall;
    function Cancel: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITableProvider
// Flags:     (256) OleAutomation
// GUID:      {9C860395-97B3-490A-B52A-858CC22AF166}
// *********************************************************************//
  ITableProvider = interface(IUnknown)
    ['{9C860395-97B3-490A-B52A-858CC22AF166}']
    function GetRowHeaders(out pRetVal: PSafeArray): HResult; stdcall;
    function GetColumnHeaders(out pRetVal: PSafeArray): HResult; stdcall;
    function Get_RowOrColumnMajor(out pRetVal: RowOrColumnMajor): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITableItemProvider
// Flags:     (256) OleAutomation
// GUID:      {B9734FA6-771F-4D78-9C90-2517999349CD}
// *********************************************************************//
  ITableItemProvider = interface(IUnknown)
    ['{B9734FA6-771F-4D78-9C90-2517999349CD}']
    function GetRowHeaderItems(out pRetVal: PSafeArray): HResult; stdcall;
    function GetColumnHeaderItems(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IToggleProvider
// Flags:     (256) OleAutomation
// GUID:      {56D00BD0-C4F4-433C-A836-1A52A57E0892}
// *********************************************************************//
  IToggleProvider = interface(IUnknown)
    ['{56D00BD0-C4F4-433C-A836-1A52A57E0892}']
    function Toggle: HResult; stdcall;
    function Get_ToggleState(out pRetVal: ToggleState): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITransformProvider
// Flags:     (256) OleAutomation
// GUID:      {6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}
// *********************************************************************//
  ITransformProvider = interface(IUnknown)
    ['{6829DDC4-4F91-4FFA-B86F-BD3E2987CB4C}']
    function Move(x: Double; y: Double): HResult; stdcall;
    function Resize(width: Double; height: Double): HResult; stdcall;
    function Rotate(degrees: Double): HResult; stdcall;
    function Get_CanMove(out pRetVal: Integer): HResult; stdcall;
    function Get_CanResize(out pRetVal: Integer): HResult; stdcall;
    function Get_CanRotate(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IValueProvider
// Flags:     (256) OleAutomation
// GUID:      {C7935180-6FB3-4201-B174-7DF73ADBF64A}
// *********************************************************************//
  IValueProvider = interface(IUnknown)
    ['{C7935180-6FB3-4201-B174-7DF73ADBF64A}']
    function SetValue(val: PWideChar): HResult; stdcall;
    function Get_Value(out pRetVal: WideString): HResult; stdcall;
    function Get_IsReadOnly(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IWindowProvider
// Flags:     (256) OleAutomation
// GUID:      {987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}
// *********************************************************************//
  IWindowProvider = interface(IUnknown)
    ['{987DF77B-DB06-4D77-8F8A-86A9C3BB90B9}']
    function SetVisualState(state: WindowVisualState): HResult; stdcall;
    function Close: HResult; stdcall;
    function WaitForInputIdle(milliseconds: SYSINT; out pRetVal: Integer): HResult; stdcall;
    function Get_CanMaximize(out pRetVal: Integer): HResult; stdcall;
    function Get_CanMinimize(out pRetVal: Integer): HResult; stdcall;
    function Get_IsModal(out pRetVal: Integer): HResult; stdcall;
    function Get_WindowVisualState(out pRetVal: WindowVisualState): HResult; stdcall;
    function Get_WindowInteractionState(out pRetVal: WindowInteractionState): HResult; stdcall;
    function Get_IsTopmost(out pRetVal: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ILegacyIAccessibleProvider
// Flags:     (256) OleAutomation
// GUID:      {E44C3566-915D-4070-99C6-047BFF5A08F5}
// *********************************************************************//
  ILegacyIAccessibleProvider = interface(IUnknown)
    ['{E44C3566-915D-4070-99C6-047BFF5A08F5}']
    function Select(flagsSelect: Integer): HResult; stdcall;
    function DoDefaultAction: HResult; stdcall;
    function SetValue(szValue: PWideChar): HResult; stdcall;
    function GetIAccessible(out ppAccessible: IAccessible): HResult; stdcall;
    function Get_ChildId(out pRetVal: SYSINT): HResult; stdcall;
    function Get_Name(out pszName: WideString): HResult; stdcall;
    function Get_Value(out pszValue: WideString): HResult; stdcall;
    function Get_Description(out pszDescription: WideString): HResult; stdcall;
    function Get_Role(out pdwRole: LongWord): HResult; stdcall;
    function Get_state(out pdwState: LongWord): HResult; stdcall;
    function Get_Help(out pszHelp: WideString): HResult; stdcall;
    function Get_KeyboardShortcut(out pszKeyboardShortcut: WideString): HResult; stdcall;
    function GetSelection(out pvarSelectedChildren: PSafeArray): HResult; stdcall;
    function Get_DefaultAction(out pszDefaultAction: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IItemContainerProvider
// Flags:     (256) OleAutomation
// GUID:      {E747770B-39CE-4382-AB30-D8FB3F336F24}
// *********************************************************************//
  IItemContainerProvider = interface(IUnknown)
    ['{E747770B-39CE-4382-AB30-D8FB3F336F24}']
    function FindItemByProperty(const pStartAfter: IRawElementProviderSimple; propertyId: SYSINT;
                                Value: OleVariant; out pFound: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IVirtualizedItemProvider
// Flags:     (256) OleAutomation
// GUID:      {CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}
// *********************************************************************//
  IVirtualizedItemProvider = interface(IUnknown)
    ['{CB98B665-2D35-4FAC-AD35-F3C60D0C0B8B}']
    function Realize: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IObjectModelProvider
// Flags:     (256) OleAutomation
// GUID:      {3AD86EBD-F5EF-483D-BB18-B1042A475D64}
// *********************************************************************//
  IObjectModelProvider = interface(IUnknown)
    ['{3AD86EBD-F5EF-483D-BB18-B1042A475D64}']
    function GetUnderlyingObjectModel(out ppUnknown: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IAnnotationProvider
// Flags:     (256) OleAutomation
// GUID:      {F95C7E80-BD63-4601-9782-445EBFF011FC}
// *********************************************************************//
  IAnnotationProvider = interface(IUnknown)
    ['{F95C7E80-BD63-4601-9782-445EBFF011FC}']
    function Get_AnnotationTypeId(out retVal: SYSINT): HResult; stdcall;
    function Get_AnnotationTypeName(out retVal: WideString): HResult; stdcall;
    function Get_Author(out retVal: WideString): HResult; stdcall;
    function Get_DateTime(out retVal: WideString): HResult; stdcall;
    function Get_Target(out retVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IStylesProvider
// Flags:     (256) OleAutomation
// GUID:      {19B6B649-F5D7-4A6D-BDCB-129252BE588A}
// *********************************************************************//
  IStylesProvider = interface(IUnknown)
    ['{19B6B649-F5D7-4A6D-BDCB-129252BE588A}']
    function Get_StyleId(out retVal: SYSINT): HResult; stdcall;
    function Get_StyleName(out retVal: WideString): HResult; stdcall;
    function Get_FillColor(out retVal: SYSINT): HResult; stdcall;
    function Get_FillPatternStyle(out retVal: WideString): HResult; stdcall;
    function Get_Shape(out retVal: WideString): HResult; stdcall;
    function Get_FillPatternColor(out retVal: SYSINT): HResult; stdcall;
    function Get_ExtendedProperties(out retVal: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpreadsheetProvider
// Flags:     (256) OleAutomation
// GUID:      {6F6B5D35-5525-4F80-B758-85473832FFC7}
// *********************************************************************//
  ISpreadsheetProvider = interface(IUnknown)
    ['{6F6B5D35-5525-4F80-B758-85473832FFC7}']
    function GetItemByName(Name: PWideChar; out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISpreadsheetItemProvider
// Flags:     (256) OleAutomation
// GUID:      {EAED4660-7B3D-4879-A2E6-365CE603F3D0}
// *********************************************************************//
  ISpreadsheetItemProvider = interface(IUnknown)
    ['{EAED4660-7B3D-4879-A2E6-365CE603F3D0}']
    function Get_Formula(out pRetVal: WideString): HResult; stdcall;
    function GetAnnotationObjects(out pRetVal: PSafeArray): HResult; stdcall;
    function GetAnnotationTypes(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITransformProvider2
// Flags:     (256) OleAutomation
// GUID:      {4758742F-7AC2-460C-BC48-09FC09308A93}
// *********************************************************************//
  ITransformProvider2 = interface(ITransformProvider)
    ['{4758742F-7AC2-460C-BC48-09FC09308A93}']
    function Zoom(Zoom: Double): HResult; stdcall;
    function Get_CanZoom(out pRetVal: Integer): HResult; stdcall;
    function Get_ZoomLevel(out pRetVal: Double): HResult; stdcall;
    function Get_ZoomMinimum(out pRetVal: Double): HResult; stdcall;
    function Get_ZoomMaximum(out pRetVal: Double): HResult; stdcall;
    function ZoomByUnit(ZoomUnit: ZoomUnit): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDragProvider
// Flags:     (256) OleAutomation
// GUID:      {6AA7BBBB-7FF9-497D-904F-D20B897929D8}
// *********************************************************************//
  IDragProvider = interface(IUnknown)
    ['{6AA7BBBB-7FF9-497D-904F-D20B897929D8}']
    function Get_IsGrabbed(out pRetVal: Integer): HResult; stdcall;
    function Get_DropEffect(out pRetVal: WideString): HResult; stdcall;
    function Get_DropEffects(out pRetVal: PSafeArray): HResult; stdcall;
    function GetGrabbedItems(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDropTargetProvider
// Flags:     (256) OleAutomation
// GUID:      {BAE82BFD-358A-481C-85A0-D8B4D90A5D61}
// *********************************************************************//
  IDropTargetProvider = interface(IUnknown)
    ['{BAE82BFD-358A-481C-85A0-D8B4D90A5D61}']
    function Get_DropTargetEffect(out pRetVal: WideString): HResult; stdcall;
    function Get_DropTargetEffects(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextRangeProvider
// Flags:     (256) OleAutomation
// GUID:      {5347AD7B-C355-46F8-AFF5-909033582F63}
// *********************************************************************//
  ITextRangeProvider = interface(IUnknown)
    ['{5347AD7B-C355-46F8-AFF5-909033582F63}']
    function Clone(out pRetVal: ITextRangeProvider): HResult; stdcall;
    function Compare(const range: ITextRangeProvider; out pRetVal: Integer): HResult; stdcall;
    function CompareEndpoints(endpoint: TextPatternRangeEndpoint;
                              const targetRange: ITextRangeProvider;
                              targetEndpoint: TextPatternRangeEndpoint; out pRetVal: SYSINT): HResult; stdcall;
    function ExpandToEnclosingUnit(unit_: TextUnit): HResult; stdcall;
    function FindAttribute(attributeId: SYSINT; val: OleVariant; backward: Integer;
                           out pRetVal: ITextRangeProvider): HResult; stdcall;
    function FindText(const text: WideString; backward: Integer; ignoreCase: Integer;
                      out pRetVal: ITextRangeProvider): HResult; stdcall;
    function GetAttributeValue(attributeId: SYSINT; out pRetVal: OleVariant): HResult; stdcall;
    function GetBoundingRectangles(out pRetVal: PSafeArray): HResult; stdcall;
    function GetEnclosingElement(out pRetVal: IRawElementProviderSimple): HResult; stdcall;
    function GetText(maxLength: SYSINT; out pRetVal: WideString): HResult; stdcall;
    function Move(unit_: TextUnit; count: SYSINT; out pRetVal: SYSINT): HResult; stdcall;
    function MoveEndpointByUnit(endpoint: TextPatternRangeEndpoint; unit_: TextUnit; count: SYSINT;
                                out pRetVal: SYSINT): HResult; stdcall;
    function MoveEndpointByRange(endpoint: TextPatternRangeEndpoint;
                                 const targetRange: ITextRangeProvider;
                                 targetEndpoint: TextPatternRangeEndpoint): HResult; stdcall;
    function Select: HResult; stdcall;
    function AddToSelection: HResult; stdcall;
    function RemoveFromSelection: HResult; stdcall;
    function ScrollIntoView(alignToTop: Integer): HResult; stdcall;
    function GetChildren(out pRetVal: PSafeArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextProvider
// Flags:     (256) OleAutomation
// GUID:      {3589C92C-63F3-4367-99BB-ADA653B77CF2}
// *********************************************************************//
  ITextProvider = interface(IUnknown)
    ['{3589C92C-63F3-4367-99BB-ADA653B77CF2}']
    function GetSelection(out pRetVal: PSafeArray): HResult; stdcall;
    function GetVisibleRanges(out pRetVal: PSafeArray): HResult; stdcall;
    function RangeFromChild(const childElement: IRawElementProviderSimple;
                            out pRetVal: ITextRangeProvider): HResult; stdcall;
    function RangeFromPoint(point: UiaPoint; out pRetVal: ITextRangeProvider): HResult; stdcall;
    function Get_DocumentRange(out pRetVal: ITextRangeProvider): HResult; stdcall;
    function Get_SupportedTextSelection(out pRetVal: SupportedTextSelection): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextProvider2
// Flags:     (256) OleAutomation
// GUID:      {0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}
// *********************************************************************//
  ITextProvider2 = interface(ITextProvider)
    ['{0DC5E6ED-3E16-4BF1-8F9A-A979878BC195}']
    function RangeFromAnnotation(const annotationElement: IRawElementProviderSimple;
                                 out pRetVal: ITextRangeProvider): HResult; stdcall;
    function GetCaretRange(out isActive: Integer; out pRetVal: ITextRangeProvider): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextEditProvider
// Flags:     (256) OleAutomation
// GUID:      {EA3605B4-3A05-400E-B5F9-4E91B40F6176}
// *********************************************************************//
  ITextEditProvider = interface(ITextProvider)
    ['{EA3605B4-3A05-400E-B5F9-4E91B40F6176}']
    function GetActiveComposition(out pRetVal: ITextRangeProvider): HResult; stdcall;
    function GetConversionTarget(out pRetVal: ITextRangeProvider): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextRangeProvider2
// Flags:     (256) OleAutomation
// GUID:      {9BBCE42C-1921-4F18-89CA-DBA1910A0386}
// *********************************************************************//
  ITextRangeProvider2 = interface(ITextRangeProvider)
    ['{9BBCE42C-1921-4F18-89CA-DBA1910A0386}']
    function ShowContextMenu: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITextChildProvider
// Flags:     (256) OleAutomation
// GUID:      {4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}
// *********************************************************************//
  ITextChildProvider = interface(IUnknown)
    ['{4C2DE2B9-C88F-4F88-A111-F1D336B7D1A9}']
    function Get_TextContainer(out pRetVal: IRawElementProviderSimple): HResult; stdcall;
    function Get_TextRange(out pRetVal: ITextRangeProvider): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICustomNavigationProvider
// Flags:     (256) OleAutomation
// GUID:      {2062A28A-8C07-4B94-8E12-7037C622AEB8}
// *********************************************************************//
  ICustomNavigationProvider = interface(IUnknown)
    ['{2062A28A-8C07-4B94-8E12-7037C622AEB8}']
    function Navigate(direction: NavigateDirection; out pRetVal: IRawElementProviderSimple): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationPatternInstance
// Flags:     (256) OleAutomation
// GUID:      {C03A7FE4-9431-409F-BED8-AE7C2299BC8D}
// *********************************************************************//
  IUIAutomationPatternInstance = interface(IUnknown)
    ['{C03A7FE4-9431-409F-BED8-AE7C2299BC8D}']
    function GetProperty(index: SYSUINT; cached: Integer; type_: UIAutomationType; pPtr: Pointer): HResult; stdcall;
    function CallMethod(index: SYSUINT; var pParams: UIAutomationParameter; cParams: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationPatternHandler
// Flags:     (256) OleAutomation
// GUID:      {D97022F3-A947-465E-8B2A-AC4315FA54E8}
// *********************************************************************//
  IUIAutomationPatternHandler = interface(IUnknown)
    ['{D97022F3-A947-465E-8B2A-AC4315FA54E8}']
    function CreateClientWrapper(const pPatternInstance: IUIAutomationPatternInstance;
                                 out pClientWrapper: IUnknown): HResult; stdcall;
    function Dispatch(const pTarget: IUnknown; index: SYSUINT; var pParams: UIAutomationParameter;
                      cParams: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationRegistrar
// Flags:     (256) OleAutomation
// GUID:      {8609C4EC-4A1A-4D88-A357-5A66E060E1CF}
// *********************************************************************//
  IUIAutomationRegistrar = interface(IUnknown)
    ['{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}']
    function RegisterProperty(var property_: UIAutomationPropertyInfo; out propertyId: SYSINT): HResult; stdcall;
    function RegisterEvent(var event: UIAutomationEventInfo; out eventId: SYSINT): HResult; stdcall;
    function RegisterPattern(var pattern: UIAutomationPatternInfo; out pPatternId: SYSINT;
                             out pPatternAvailablePropertyId: SYSINT; propertyIdCount: SYSUINT;
                             out pPropertyIds: SYSINT; eventIdCount: SYSUINT; out pEventIds: SYSINT): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoCUIAutomationRegistrar provides a Create and CreateRemote method to
// create instances of the default interface IUIAutomationRegistrar exposed by
// the CoClass CUIAutomationRegistrar. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCUIAutomationRegistrar = class
    class function Create: IUIAutomationRegistrar;
    class function CreateRemote(const MachineName: string): IUIAutomationRegistrar;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCUIAutomationRegistrar
// Help String      : Class for registering UIAutomation patterns, properties and events.
// Default Interface: IUIAutomationRegistrar
// Def. Intf. DISP? : No
// Event   Interface:
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TCUIAutomationRegistrar = class(TOleServer)
  private
    FIntf: IUIAutomationRegistrar;
    function GetDefaultInterface: IUIAutomationRegistrar;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IUIAutomationRegistrar);
    procedure Disconnect; override;
    function RegisterProperty(var property_: UIAutomationPropertyInfo; out propertyId: SYSINT): HResult;
    function RegisterEvent(var event: UIAutomationEventInfo; out eventId: SYSINT): HResult;
    function RegisterPattern(var pattern: UIAutomationPatternInfo; out pPatternId: SYSINT;
                             out pPatternAvailablePropertyId: SYSINT; propertyIdCount: SYSUINT;
                             out pPropertyIds: SYSINT; eventIdCount: SYSUINT; out pEventIds: SYSINT): HResult;
    property DefaultInterface: IUIAutomationRegistrar read GetDefaultInterface;
  published
  end;

/////////// DO NOT REGENERATE
function UiaHostProviderFromHwnd(hwnd: HWND; out provider: IRawElementProviderSimple): LRESULT; stdcall; external 'UIAutomationCore.dll' name 'UiaHostProviderFromHwnd';
function UiaReturnRawElementProvider(hwnd: HWND; wParam: WPARAM; lParam: LPARAM; element : IRawElementProviderSimple) : LRESULT; stdcall; external 'UIAutomationCore.dll' name 'UiaReturnRawElementProvider';

const
  UIA_InvokePatternId = 10000;
  UIA_SelectionPatternId = 10001;
  UIA_ValuePatternId = 10002;
  UIA_ExpandCollapsePatternId = 10005;
  UIA_GridPatternId = 10006;
  UIA_GridItemPatternId = 10007;
  UIA_SelectionItemPatternId = 10010;
  UIA_TablePatternId = 10012;
  UIA_TextPatternID = 10014;

  UIA_NamePropertyId = 30005;
  UIA_AutomationIdPropertyId = 30011;
  UIA_ClassNamePropertyId = 30012;
  UIA_ControlTypePropertyId = 30003;

  UIA_IsControlElementPropertyId = 30016;
  UIA_IsContentElementPropertyId = 30017;
  UIA_IsEnabledPropertyId = 30010;

  UIA_ButtonControlTypeId = 50000;
  UIA_CalendarControlTypeId = 50001;
  UIA_CheckBoxControlTypeId = 50002;
  UIA_ComboBoxControlTypeId = 50003;
  UIA_EditControlTypeId = 50004;
  UIA_HyperlinkControlTypeId = 50005;
  UIA_ImageControlTypeId = 50006;
  UIA_ListItemControlTypeId = 50007;
  UIA_ListControlTypeId = 50008;
  UIA_MenuControlTypeId = 50009;
  UIA_MenuBarControlTypeId = 50010;
  UIA_MenuItemControlTypeId = 50011;
  UIA_TextControlTypeId = 50020;
  UIA_CustomControlTypeId = 50025;
  UIA_DataGridControlTypeId = 50028;
  UIA_DataItemControlTypeId = 50029;
  UIA_PaneControlTypeId = 50033;
  UIA_AppBarControlTypeId = 50040;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses System.Win.ComObj;

class function CoCUIAutomationRegistrar.Create: IUIAutomationRegistrar;
begin
  Result := CreateComObject(CLASS_CUIAutomationRegistrar) as IUIAutomationRegistrar;
end;

class function CoCUIAutomationRegistrar.CreateRemote(const MachineName: string): IUIAutomationRegistrar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CUIAutomationRegistrar) as IUIAutomationRegistrar;
end;

procedure TCUIAutomationRegistrar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{6E29FABF-9977-42D1-8D0E-CA7E61AD87E6}';
    IntfIID:   '{8609C4EC-4A1A-4D88-A357-5A66E060E1CF}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCUIAutomationRegistrar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUIAutomationRegistrar;
  end;
end;

procedure TCUIAutomationRegistrar.ConnectTo(svrIntf: IUIAutomationRegistrar);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCUIAutomationRegistrar.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCUIAutomationRegistrar.GetDefaultInterface: IUIAutomationRegistrar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCUIAutomationRegistrar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCUIAutomationRegistrar.Destroy;
begin
  inherited Destroy;
end;

function TCUIAutomationRegistrar.RegisterProperty(var property_: UIAutomationPropertyInfo;
                                                  out propertyId: SYSINT): HResult;
begin
  Result := DefaultInterface.RegisterProperty(property_, propertyId);
end;

function TCUIAutomationRegistrar.RegisterEvent(var event: UIAutomationEventInfo; out eventId: SYSINT): HResult;
begin
  Result := DefaultInterface.RegisterEvent(event, eventId);
end;

function TCUIAutomationRegistrar.RegisterPattern(var pattern: UIAutomationPatternInfo;
                                                 out pPatternId: SYSINT;
                                                 out pPatternAvailablePropertyId: SYSINT;
                                                 propertyIdCount: SYSUINT;
                                                 out pPropertyIds: SYSINT; eventIdCount: SYSUINT;
                                                 out pEventIds: SYSINT): HResult;
begin
  Result := DefaultInterface.RegisterPattern(pattern, pPatternId, pPatternAvailablePropertyId,
                                             propertyIdCount, pPropertyIds, eventIdCount, pEventIds);
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCUIAutomationRegistrar]);
end;

end.
