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
unit DelphiUIAutomation.StringGrid;

interface

uses
  Generics.Collections,
  DelphiUIAutomation.StringGridItem,
  DelphiUIAutomation.Base,
  ActiveX,
  UIAutomationClient_TLB;

type
  IAutomationStringGrid = interface (IAutomationBase)
    ['{6E151D9C-33C7-4D82-A25C-BED061F3FB61}']
    function GetValue: string;

    function GetColumnHeaders : TObjectList<TAutomationStringGridItem>;

    function GetSelected : IAutomationStringGridItem;

    ///<summary>
    ///  Gets or sets the value
    ///</summary>
    property Value : string read GetValue;

    function GetItem(row: SYSINT; column: SYSINT) : IAutomationStringGridItem;

    property Selected : IAutomationStringGridItem read GetSelected;

    property ColumnHeaders : TObjectList<TAutomationStringGridItem> read GetColumnHeaders;
  end;

  /// <summary>
  ///  Represents a string grid - as best we can
  /// </summary>
  TAutomationStringGrid = class (TAutomationBase, IAutomationStringGrid)
  strict private
    FValuePattern : IUIAutomationValuePattern;
    FGridPattern : IUIAutomationGridPattern;
    FSelectionPattern : IUIAutomationSelectionPattern;
    FTablePattern : IUIAutomationTablePattern;
  private
    function GetValue: string;
    procedure GetPatterns;
    function GetSelected : IAutomationStringGridItem;
    function GetColumnHeaders : TObjectList<TAutomationStringGridItem>;

  public
    ///<summary>
    ///  Gets or sets the value
    ///</summary>
    property Value : string read GetValue;

    function GetItem(row: SYSINT; column: SYSINT) : IAutomationStringGridItem;

//    function GetSelectedText : string;

    constructor Create(element : IUIAutomationElement); override;

    property ColumnHeaders : TObjectList<TAutomationStringGridItem> read GetColumnHeaders;

    property Selected : IAutomationStringGridItem read GetSelected;
  end;

implementation

uses
  SysUtils,
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.PatternIDs;

{ TAutomationStringGrid }

constructor TAutomationStringGrid.Create(element: IUIAutomationElement);
begin
  inherited create(element);

  GetPatterns;
end;

function TAutomationStringGrid.GetColumnHeaders: TObjectList<TAutomationStringGridItem>;
var
  collection : IUIAutomationElementArray;
  count : integer;
  length : integer;
  element : IUIAutomationElement;
  items : TObjectList<TAutomationStringGridItem>;

begin
  FTablePattern.GetCurrentColumnHeaders(collection);
  collection.Get_Length(length);

  items := TObjectList<TAutomationStringGridItem>.create;

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    items.Add(TAutomationStringGridItem.create(element));
  end;

  result := items;
end;

function TAutomationStringGrid.GetValue: string;
var
  value : WideString;

begin
  FValuePattern.Get_CurrentValue(value);
  Result := trim(value);
end;

function TAutomationStringGrid.GetItem(row,
  column: SYSINT): IAutomationStringGridItem;
var
  value : IUIAutomationElement;

begin
  FGridPattern.GetItem(row, column, value);

  result := TAutomationStringGridItem.create(value);
end;

procedure TAutomationStringGrid.GetPatterns;
begin
  FValuePattern := GetValuePattern;
  FGRidPattern := GetGridPattern;
  FSelectionPattern := GetSelectionPattern;
  FTablePattern := GetTablePattern;
end;

function TAutomationStringGrid.GetSelected: IAutomationStringGridItem;
var
  collection : IUIAutomationElementArray;
  count : integer;
  retval : integer;
  element : IUIAutomationElement;
  length : integer;
  item : IAutomationStringGridItem;

begin
  FSelectionPattern.GetCurrentSelection(collection);
  collection.Get_Length(length);

  item := nil;

  // There should only be one!
  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);
    element.Get_CurrentControlType(retVal);

    item := TAutomationStringGridItem.Create(element);
  end;

  result := item;
end;

end.

