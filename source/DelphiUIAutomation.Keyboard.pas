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
  winapi.windows;

{ TAutomationKeyboard }

procedure SendKeyDown (key : short; specialKey : boolean);
var
  KeyInputs: array of TInput;

begin

  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

procedure SendKeyUp (key : short; specialKey : boolean);
var
  KeyInputs: array of TInput;

begin

  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

procedure Press (key : short; specialKey : boolean);
begin
  SendKeyDown (key, specialKey);
  SendKeyUp (key, specialKey);
end;

class procedure TAutomationKeyboard.Enter(const keys: string);
var
  count : integer;
  key : char;

begin
  for key in keys do
  begin
    // Do we need to hold other keys???
    Press(Ord(key), false);
  end;
end;

end.
