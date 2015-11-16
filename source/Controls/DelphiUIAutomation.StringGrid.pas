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
    procedure GetValuePattern;
    procedure GetGridPattern;
    procedure GetSelectionPattern;
    procedure GetTablePattern;
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

procedure TAutomationStringGrid.GetValuePattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_ValuePatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationValuePattern, FValuePattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;
end;

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

procedure TAutomationStringGrid.GetGridPattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_GridPatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationGridPattern, FGridPattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;
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
  name : WideString;

begin
  FGridPattern.GetItem(row, column, value);

  result := TAutomationStringGridItem.create(value);
end;

procedure TAutomationStringGrid.GetPatterns;
begin
  GetValuePattern;
  GetGridPattern;
  GetSelectionPattern;
  GetTablePattern;
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

procedure TAutomationStringGrid.GetSelectionPattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_SelectionPatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationSelectionPattern, FSelectionPattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;
end;

procedure TAutomationStringGrid.GetTablePattern;
var
  inter: IInterface;

begin
  fElement.GetCurrentPattern(UIA_TablePatternId, inter);
  if (inter <> nil) then
  begin
  if Inter.QueryInterface(IID_IUIAutomationTablePattern, FTablePattern) <> S_OK then
    begin
      raise EDelphiAutomationException.Create('Unable to initialise control pattern');
    end;
  end;
end;

end.

