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
unit DelphiUIAutomation.EditBox;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  IAutomationEditBox = interface (IAutomationBase)
    ['{CA47F9E7-ACF6-4B5B-9029-10428C52E1FE}']

    function getText: string;
    procedure setText(const Value: string);

    ///<summary>
    ///  Gets or sets the text
    ///</summary>
    property Text : string read getText write setText;
  end;

  /// <summary>
  ///  Represents an edit box
  /// </summary>
  /// <remarks>
  ///  TEdit for example.
  /// </remarks>
  TAutomationEditBox = class (TAutomationBase, IAutomationEditBox)
  strict private
    fValuePattern : IUIAutomationValuePattern;

  private
    function getIsPassword: boolean;
    function getIsReadOnly: boolean;
    function getText: string;
    procedure setText(const Value: string);

  public
    ///<summary>
    ///  Gets or sets the text
    ///</summary>
    property Text : string read getText write setText;

    ///<summary>
    ///  Gets whether the control is a password control
    ///</summary>
    property IsPassword : boolean read getIsPassword;

    ///<summary>
    ///  Gets whether the control is read-only
    ///</summary>
    property IsReadOnly : boolean read getIsReadOnly;

    constructor Create(element : IUIAutomationElement); override;
  end;

implementation

uses
  DelphiUIAutomation.Exception,
  DelphiUIAutomation.PatternIDs,
  sysutils;

{ TAutomationTextBox }

constructor TAutomationEditBox.Create(element: IUIAutomationElement);
begin
  inherited Create(element);
  fValuePattern := GetValuePattern;
end;

function TAutomationEditBox.getIsPassword: boolean;
var
  retVal : integer;

begin
  Felement.Get_CurrentIsPassword(retVal);

  result := false;
end;

function TAutomationEditBox.getIsReadOnly: boolean;
begin
  result := false;
end;

function TAutomationEditBox.getText: string;
var
  value : widestring;

begin
  result := '';

  if getIsPassword then
  begin
    raise EDelphiAutomationException.Create('Unable to get text for password editboxes');
  end
  else
  begin
    FValuePattern.Get_CurrentValue(value);
    Result := trim(value);
  end;
end;

procedure TAutomationEditBox.setText(const Value: string);
begin
  FValuePattern.SetValue(value);
end;

end.
