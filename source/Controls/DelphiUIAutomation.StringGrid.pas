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
  DelphiUIAutomation.Base,
  ActiveX,
  UIAutomationClient_TLB;

type
  IAutomationStringGrid = interface (IAutomationBase)
    ['{6E151D9C-33C7-4D82-A25C-BED061F3FB61}']
    function GetValue: string;

    ///<summary>
    ///  Gets or sets the value
    ///</summary>
    property Value : string read GetValue;

    function GetItemText(row: SYSINT; column: SYSINT) : string;
  end;

  /// <summary>
  ///  Represents a string grid - as best we can
  /// </summary>
  TAutomationStringGrid = class (TAutomationBase, IAutomationStringGrid)
  strict private
    FValuePattern : IUIAutomationValuePattern;
    FGridPattern : IUIAutomationGridPattern;
  private
    function GetValue: string;
    procedure GetValuePattern;
    procedure GetGridPattern;

  public
    ///<summary>
    ///  Gets or sets the value
    ///</summary>
    property Value : string read GetValue;

    function GetItemText(row: SYSINT; column: SYSINT) : string;

    constructor Create(element : IUIAutomationElement); override;
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

  GetValuePattern;
  GetGridPattern;
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

function TAutomationStringGrid.GetItemText(row: SYSINT; column: SYSINT) : string;
var
  value : IUIAutomationElement;
  name : WideString;

begin
  FGridPattern.GetItem(row, column, value);
  value.Get_CurrentName(name);

  result := name;
end;

end.

