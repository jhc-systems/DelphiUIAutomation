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
unit DelphiUIAutomation.ScreenShot;

interface

uses
  winapi.windows,
  Vcl.Graphics;

type
  /// <summary>
  ///  Screenshot functionality
  /// </summary>
  TAutomationScreenshot = class
  public
    class function CaptureScreenshot : TBitmap;
  end;

implementation

{ TAutomationScreenshot }

class function TAutomationScreenshot.CaptureScreenshot: TBitmap;
var
  Win: HWND;
  DC: HDC;
  Bmp: TBitmap;
  FileName: string;
  WinRect: TRect;
  Width: Integer;
  Height: Integer;

begin
  Win := GetForegroundWindow;
  GetWindowRect(Win, WinRect);
  DC := GetWindowDC(Win);

  try
    Width := WinRect.Right - WinRect.Left;
    Height := WinRect.Bottom - WinRect.Top;

    Bmp := TBitmap.Create;
  //  try
    Bmp.Height := Height;
    Bmp.Width := Width;
    BitBlt(Bmp.Canvas.Handle, 0, 0, Width, Height, DC, 0, 0, SRCCOPY);
  //  finally
   //   Bmp.Free;
  //  end;
  finally
    ReleaseDC(Win, DC);
  end;

  result := Bmp;
end;

end.

