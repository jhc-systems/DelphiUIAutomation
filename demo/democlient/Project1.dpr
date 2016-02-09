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
program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  AutomatedCombobox in '..\..\controls\AutomatedCombobox.pas',
  AutomatedEdit in '..\..\controls\AutomatedEdit.pas',
  UIAutomationCore_TLB in '..\..\controls\UIAutomationCore_TLB.pas',
  AutomatedStringGrid in '..\..\controls\AutomatedStringGrid.pas',
  StringGridItem in '..\..\controls\StringGridItem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
