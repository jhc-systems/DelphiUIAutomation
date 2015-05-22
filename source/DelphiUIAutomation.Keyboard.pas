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
  private
  public
    ///<summary>
    ///  'Types' the keys
    ///</summary>
    class procedure Enter(const keys : string); overload;

    ///<summary>
    ///  'Types' the single key
    ///</summary>
    class procedure Enter(const key : word); overload;

    ///<summary>
    ///  'Types' the key, with Ctrl down
    ///</summary>
    class procedure EnterWithCtrl(const key : char);

    ///<summary>
    ///  Send the alt key down
    ///</summary>
    class procedure SendAltDown; static;

    ///<summary>
    ///  Send the alt key up
    ///</summary>
    class procedure SendAltUp; static;

    class procedure Tab;
    class procedure BackTab;
  end;

implementation

uses
  Messages,
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

class procedure TAutomationKeyboard.Enter(const key : word);
var
  KeyInputs: array of TInput;

  procedure KeybdInput(VKey: Byte; Flags: DWORD);
  begin
    SetLength(KeyInputs, Length(KeyInputs)+1);
    KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
    with  KeyInputs[high(KeyInputs)].ki do
    begin
      wVk := VKey;
      wScan := MapVirtualKey(wVk, 0);
      dwFlags := Flags;
    end;
  end;

begin
  KeybdInput(Ord(key), 0);
  KeybdInput(Ord(key), KEYEVENTF_KEYUP);
  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

procedure AltDown;
var
  input: TInput;
begin
  input := Default(TInput);
  input.Itype := INPUT_KEYBOARD;
  input.ki.wScan := 0;
  input.ki.time := 0;
  input.ki.dwExtraInfo := 0;
  input.ki.wVk := VK_CONTROL;
  input.ki.dwFlags := 0; // 0 for key press
  SendInput(1, input, sizeof(INPUT));
end;

procedure AltUp;
var
  input: TInput;
begin
  input := Default(TInput);
  input.Itype := INPUT_KEYBOARD;
  input.ki.wScan := 0;
  input.ki.time := 0;
  input.ki.dwExtraInfo := 0;
  input.ki.wVk := VK_CONTROL;
  input.ki.dwFlags := KEYEVENTF_KEYUP;
  SendInput(1, input, sizeof(INPUT));
end;

class procedure TAutomationKeyboard.SendAltDown;
begin
  AltDown;
end;

class procedure TAutomationKeyboard.SendAltUp;
begin
  AltDown;
end;

class procedure TAutomationKeyboard.EnterWithCtrl(const key: char);
var
  KeyInputs: array of TInput;

  procedure KeybdInput(VKey: Byte; Flags: DWORD);
  begin
    SetLength(KeyInputs, Length(KeyInputs)+1);
    KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
    with  KeyInputs[high(KeyInputs)].ki do
    begin
      wVk := VKey;
      wScan := MapVirtualKey(wVk, 0);
      dwFlags := Flags;
    end;
  end;

begin
  KeybdInput(VK_CONTROL, 0);
  KeybdInput(Ord(key), 0);
  KeybdInput(Ord(key), KEYEVENTF_KEYUP);
  KeybdInput(VK_CONTROL, KEYEVENTF_KEYUP);
  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

class procedure TAutomationKeyboard.Tab;
var
  KeyInputs: array of TInput;

  procedure KeybdInput(VKey: Byte; Flags: DWORD);
  begin
    SetLength(KeyInputs, Length(KeyInputs)+1);
    KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
    with  KeyInputs[high(KeyInputs)].ki do
    begin
      wVk := VKey;
      wScan := MapVirtualKey(wVk, 0);
      dwFlags := Flags;
    end;
  end;

begin
  KeybdInput(VK_TAB, 0);
  KeybdInput(VK_TAB, KEYEVENTF_KEYUP);
  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

class procedure TAutomationKeyboard.BackTab;
var
  KeyInputs: array of TInput;

  procedure KeybdInput(VKey: Byte; Flags: DWORD);
  begin
    SetLength(KeyInputs, Length(KeyInputs)+1);
    KeyInputs[high(KeyInputs)].Itype := INPUT_KEYBOARD;
    with  KeyInputs[high(KeyInputs)].ki do
    begin
      wVk := VKey;
      wScan := MapVirtualKey(wVk, 0);
      dwFlags := Flags;
    end;
  end;

begin
  KeybdInput(VK_BACK, 0);
  KeybdInput(VK_BACK, KEYEVENTF_KEYUP);
  SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
end;

end.
