{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{                                                                           }
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
unit DelphiUIAutomation.ComboBox;

interface

uses
  generics.collections,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.ListItem,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a combobox control
  /// </summary>
  TAutomationComboBox = class (TAutomationBase)
  strict private
    FItems : TList<TAutomationListItem>;
    FExpandCollapsePattern : IUIAutomationExpandCollapsePattern;
    FValuePattern : IUIAutomationValuePattern;

  private
    function getText: string;
    procedure setText(const Value: string);
    function getItems: TList<TAutomationListItem>;
    procedure GetExpandCollapsePattern;
    procedure GetValuePattern;

  public
    ///<summary>
    ///  Gets or sets the text associated with this combobox
    ///</summary>
    property Text : string read getText write setText;

    ///<summary>
    ///  Gets the list of items associated with this combobox
    ///</summary>
    ///<remarks>
    ///  To be implemented
    ///</remarks>
    property Items : TList<TAutomationListItem> read getItems;

    /// <summary>
    ///  Call the expand property
    /// </summary>
    function Expand : HRESULT;

    /// <summary>
    ///  Call the collapse property
    /// </summary>
    function Collapse : HRESULT;

    /// <summary>
    ///  Constructor for comboboxes.
    /// </summary>
    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  ActiveX,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.ControlTypeIDs,
  DelphiUIAutomation.PropertyIDs,
  DelphiUIAutomation.PatternIDs,
  sysutils;

{ TAutomationComboBox }

procedure TAutomationComboBox.GetExpandCollapsePattern;
var
  inter: IInterface;

begin
  self.fElement.GetCurrentPattern(UIA_ExpandCollapsePatternId, inter);
  if inter.QueryInterface(IID_IUIAutomationExpandCollapsePattern, self.FExpandCollapsePattern) <> S_OK then
  begin
    raise EDelphiAutomationException.Create('Unable to initialise control pattern');
  end;
end;

procedure TAutomationComboBox.GetValuePattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
  if Inter.QueryInterface(IID_IUIAutomationValuePattern, FValuePattern) = S_OK then
  begin
    raise EDelphiAutomationException.Create('Unable to initialise control pattern');
  end;
end;

constructor TAutomationComboBox.Create(element: IUIAutomationElement);
var
  condition : IUIAutomationCondition;
  collection : IUIAutomationElementArray;
  count : integer;
  retval : integer;
  length : integer;
  varProp : OleVariant;
  hres : HRESULT;

begin
  inherited Create(element);

  GetExpandCollapsePattern;
  GetValuePattern;

  FItems := TList<TAutomationListItem>.Create;

  TVariantArg(varProp).vt := VT_I4;
  TVariantArg(varProp).lVal := UIA_ListItemControlTypeId;

  hres := UIAuto.CreatePropertyCondition(UIA_ControlTypePropertyId, varProp, condition);

  // Find the element
  hres := self.FElement.FindAll(TreeScope_Element, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    FItems.Add(TAutomationListItem.create(element));
  end;

end;

function TAutomationComboBox.Expand: HRESULT;
begin
  result := self.FExpandCollapsePattern.Expand;
end;

function TAutomationComboBox.Collapse: HRESULT;
begin
    result := self.FExpandCollapsePattern.Collapse;
end;

function TAutomationComboBox.getItems : TList<TAutomationListItem>;
begin
  result := self.FItems;
end;

function TAutomationComboBox.getText: string;
var
  value : widestring;

begin
  FValuePattern.Get_CurrentValue(value);
  Result := trim(value);
end;

procedure TAutomationComboBox.setText(const Value: string);
begin
  FValuePattern.SetValue(value);
end;

end.
