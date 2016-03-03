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
unit DelphiUIAutomation.ComboBox;

interface

uses
  generics.collections,
  DelphiUIAutomation.Base,
  DelphiUIAutomation.ListItem,
  UIAutomationClient_TLB;

type
  IAutomationComboBox = interface (IAutomationBase)
  ['{531C8646-A605-4D6D-BEE0-89E1719D6321}']
    ///<summary>
    ///  Gets the text associated with this combobox
    ///</summary>
    function getText: string;

    ///<summary>
    ///  Sets the text associated with this combobox
    ///</summary>
    procedure setText(const Value: string);

    ///<summary>
    ///  Gets or sets the text associated with this combobox
    ///</summary>
    property Text : string read getText write setText;
  end;

  /// <summary>
  ///  Represents a combobox control
  /// </summary>
  TAutomationComboBox = class (TAutomationBase, IAutomationComboBox)
  strict private
    FItems : TObjectList<TAutomationListItem>;
    FExpandCollapsePattern : IUIAutomationExpandCollapsePattern;
    FValuePattern : IUIAutomationValuePattern;

  private
    ///<summary>
    ///  Gets the text associated with this combobox
    ///</summary>
    function getText: string;

    ///<summary>
    ///  Sets the text associated with this combobox
    ///</summary>
    procedure setText(const Value: string);

    function getItems: TObjectList<TAutomationListItem>;
    procedure InitialiseList;

  public
    ///<summary>
    ///  Gets or sets the text associated with this combobox
    ///</summary>
    property Text : string read getText write setText;

    ///<summary>
    ///  Gets the list of items associated with this combobox
    ///</summary>
    property Items : TObjectList<TAutomationListItem> read getItems;

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

    /// <summary>
    ///  Destructor for comboboxes.
    /// </summary>
    destructor Destroy; override;
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

constructor TAutomationComboBox.Create(element: IUIAutomationElement);
begin
  inherited Create(element);

  FExpandCollapsePattern := GetExpandCollapsePattern;
  FValuePattern := GetValuePattern;

  self.Expand; // Have to expand for the list to be available

  InitialiseList;
end;

destructor TAutomationComboBox.Destroy;
begin
  FItems.free;
  inherited;
end;

procedure TAutomationComboBox.InitialiseList;
var
  collection : IUIAutomationElementArray;
  itemElement : IUIAutomationElement;
  count : integer;
  length : integer;
  retVal : integer;
  item : TAutomationListItem;

begin
  FItems := TObjectList<TAutomationListItem>.create;

  // Find the elements
  collection := self.FindAll(TreeScope_Children);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, itemElement);
    itemElement.Get_CurrentControlType(retVal);

    if (retVal = UIA_ListItemControlTypeId) then
    begin
      item := TAutomationListItem.Create(itemElement);
      FItems.Add(item);
    end;
  end;
end;

function TAutomationComboBox.Expand: HRESULT;
begin
  if assigned(FExpandCollapsePattern) then
    result := self.FExpandCollapsePattern.Expand
  else
    result := -1;
end;

function TAutomationComboBox.Collapse: HRESULT;
begin
  result := self.FExpandCollapsePattern.Collapse;
end;

function TAutomationComboBox.getItems : TObjectList<TAutomationListItem>;
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
