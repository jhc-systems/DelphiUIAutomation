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
unit DelphiUIAutomation.Base;

interface

uses
  types,
  DelphiUIAutomation.Condition,
  UIAutomationClient_TLB;

type
  IAutomationBase = interface
    ['{E858CFB6-C144-444F-9743-5F2F1919EC8D}']
    function GetName: string;
    function GetBoundingRectangle : TRect;

    /// <summary>
    ///  Gets the name of the element
    /// </summary>
    property Name : string read getName;

    /// <summary>
    ///  Gets the bounding rectangle of the element
    /// </summary>
    property BoundingRectangle : TRect read GetBoundingRectangle;

    ///<summary>
    /// Gets the window handle of the Window Element
    ///</summary>
    function GetHandle : Pointer;
  end;

  /// <summary>
  ///  The base class for automation objects
  /// </summary>
  TAutomationBase = class (TInterfacedObject, IAutomationBase)
  protected
    FElement : IUIAutomationElement;
    function getName: string; virtual;
    function GetBoundingRectangle : TRect;
  protected
    /// <summary>
    ///  Gets the window control pattern
    /// </summary>
    function GetWindowPattern : IUIAutomationWindowPattern;
    function GetSelectionItemPattern: IUIAutomationSelectionItemPattern;
    function GetValuePattern: IUIAutomationValuePattern;
    function GetSelectionPattern: IUIAutomationSelectionPattern;
    function GetInvokePattern: IUIAutomationInvokePattern;
    function GetExpandCollapsePattern: IUIAutomationExpandCollapsePattern;
    function GetTogglePattern: IUIAutomationTogglePattern;
    function GetGridPattern: IUIAutomationGridPattern;
    function GetTablePattern: IUIAutomationTablePattern;

    /// <summary>
    ///  Finds the elements
    /// </summary>
    function FindAll : IUIAutomationElementArray; overload;

    /// <summary>
    ///  Finds the elements, based on scope
    /// </summary>
    function FindAll (scope : TreeScope) : IUIAutomationElementArray; overload;

    /// <summary>
    ///  Finds the elements, based on scope and condition
    /// </summary>
    function FindAll (scope : TreeScope; condition : ICondition) : IUIAutomationElementArray; overload;

  public
    /// <summary>
    ///  Gets the name of the element
    /// </summary>
    property Name : string read getName;

    /// <summary>
    ///  Gets the bounding rectangle of the element
    /// </summary>
    property BoundingRectangle : TRect read GetBoundingRectangle;

    /// <summary>
    ///  Constructor for the element.
    /// </summary>
    constructor Create(element : IUIAutomationElement); virtual;

    ///<summary>
    /// Gets the window handle of the Window Element
    ///</summary>
    function GetHandle : Pointer;
  end;

implementation

uses
  DelphiUIAutomation.PatternIDs,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Automation;

constructor TAutomationBase.Create(element: IUIAutomationElement);
begin
  inherited create;

  Felement := element;
end;

function TAutomationBase.FindAll: IUIAutomationElementArray;
begin
  result := self.FindAll (TreeScope_Children);
end;

function TAutomationBase.FindAll(scope: TreeScope): IUIAutomationElementArray;
var
  condition : ICondition;
  collection : IUIAutomationElementArray;

begin
  condition := TUIAuto.CreateTrueCondition;

  // Find the elements
  self.FElement.FindAll(scope, condition.getCondition, collection);

  result := collection;
end;

function TAutomationBase.FindAll(scope: TreeScope;
  condition: ICondition): IUIAutomationElementArray;
var
  collection : IUIAutomationElementArray;

begin
  // Find the elements
  self.FElement.FindAll(scope, condition.getCondition, collection);

  result := collection;
end;

function TAutomationBase.GetBoundingRectangle: TRect;
var
  rect : tagRect;
  outRect : TRect;

begin
  Felement.Get_CurrentBoundingRectangle(rect);

  outRect.Top := rect.top;
  outRect.Left := rect.left;
  outRect.Width := rect.right;
  outRect.Height := rect.bottom;

  result := outRect;
end;

function TAutomationBase.GetTablePattern : IUIAutomationTablePattern;
var
  inter: IInterface;
  pattern : IUIAutomationTablePattern;

begin
  fElement.GetCurrentPattern(UIA_TablePatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationTablePattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetGridPattern : IUIAutomationGridPattern;
var
  inter: IInterface;
  pattern : IUIAutomationGridPattern;

begin
  fElement.GetCurrentPattern(UIA_GridPatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationGridPattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetSelectionItemPattern : IUIAutomationSelectionItemPattern;
var
  inter: IInterface;
  pattern : IUIAutomationSelectionItemPattern;

begin

  fElement.GetCurrentPattern(UIA_SelectionItemPatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationSelectionItemPattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetSelectionPattern: IUIAutomationSelectionPattern;
var
  inter: IInterface;
  pattern: IUIAutomationSelectionPattern;

begin
  fElement.GetCurrentPattern(UIA_SelectionPatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationSelectionPattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetValuePattern : IUIAutomationValuePattern;
var
  inter: IInterface;
  pattern : IUIAutomationValuePattern;

begin
  fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationValuePattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise value pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetExpandCollapsePattern : IUIAutomationExpandCollapsePattern;
var
  inter: IInterface;
  pattern : IUIAutomationExpandCollapsePattern;

begin
  self.fElement.GetCurrentPattern(UIA_ExpandCollapsePatternId, inter);

  if (inter <> nil) then
  begin
    if inter.QueryInterface(IID_IUIAutomationExpandCollapsePattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetInvokePattern : IUIAutomationInvokePattern;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;

begin
  fElement.GetCurrentPattern(UIA_InvokePatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationInvokePattern, Pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetWindowPattern : IUIAutomationWindowPattern;
var
  inter: IInterface;
  pattern: IUIAutomationWindowPattern;

begin
  self.fElement.GetCurrentPattern(UIA_WindowPatternId, inter);

  if (inter <> nil) then
  begin
    if inter.QueryInterface(IID_IUIAutomationWindowPattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise Window control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.GetTogglePattern: IUIAutomationTogglePattern;
var
  inter: IInterface;
  pattern : IUIAutomationTogglePattern;

begin
  self.fElement.GetCurrentPattern(UIA_TogglePatternId, inter);

  if (inter <> nil) then
  begin
    if inter.QueryInterface(IID_IUIAutomationTogglePattern, pattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;

  result := pattern;
end;

function TAutomationBase.getName: string;
var
  name : widestring;

begin
  FElement.Get_CurrentName(name);
  result := name;
end;

function TAutomationBase.GetHandle: Pointer;
var
  retVal : Pointer;
begin
  self.FElement.Get_CurrentNativeWindowHandle(retVal);

  result := retVal;
end;

end.
