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
unit DelphiUIAutomation.Keyboard;

interface

type
  /// <summary>
  ///  The representation of the keyboard
  /// </summary>
  /// <remarks>
  ///  http://stackoverflow.com/questions/18662637/sendinput-vs-keybd-event
  /// </remarks>
  TAutomationKeyboard = class
  public
    ///<summary>
    ///  'Types' the keys
    ///</summary>
    class procedure Enter(const keys : string);
  end;

implementation

uses
  generics.collections,
  winapi.windows;

{ TAutomationKeyboard }

class procedure TAutomationKeyboard.Enter(const keys: string);
var
  c: char;
  input: TInput;
  inputList: TList<TInput>;

begin
  inputList := TList<TInput>.Create;
  try
    for c in keys do
    begin
      if c = #10 then
        continue;
      input := Default(TInput);
      input.Itype := INPUT_KEYBOARD;
      input.ki.dwFlags := KEYEVENTF_UNICODE;
      input.ki.wScan := ord(c);
      inputList.Add(Input);
      input.ki.dwFlags := KEYEVENTF_UNICODE or KEYEVENTF_KEYUP;
      inputList.Add(Input);
    end;
    SendInput(inputList.Count, InputList.List[0], SizeOf(TInput));
  finally
    inputList.Free;
  end;
end;

end.
