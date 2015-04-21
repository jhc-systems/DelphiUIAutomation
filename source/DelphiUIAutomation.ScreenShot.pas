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
unit DelphiUIAutomation.ScreenShot;

interface

uses
  controls,
  winapi.windows,
  Vcl.Graphics;

type
  /// <summary>
  ///  Screenshot functionality
  /// </summary>
  TAutomationScreenshot = class
  strict private
    FBmp: TBitmap;
  private
    /// <summary>
    ///  Captures a screenshot of the desktop
    /// </summary>
    procedure CaptureScreenshot; overload;

    procedure CaptureScreenshot(Control_: TWinControl); overload;
  public
    ///<summary>
    ///  Creation
    ///</summary>
    constructor Create;

    ///<summary>
    ///  Destruction
    ///</summary>
    destructor Destroy; override;

    /// <summary>
    ///  Saves a screenshot of the current desktop
    /// </summary>
    procedure SaveCurrentScreen;

    procedure SaveCurrentControl(Control_: TWinControl);

    ///<summary>
    /// Gets the bitmap
    ///</summary>
    property bitmap : TBitmap read FBmp;


  end;

implementation

uses
  system.IOUtils,
  sysutils;

{ TAutomationScreenshot }

procedure TAutomationScreenshot.CaptureScreenshot;
var
  Win: HWND;
  DC: HDC;
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

    FBmp.Height := Height;
    FBmp.Width := Width;
    BitBlt(FBmp.Canvas.Handle, 0, 0, Width, Height, DC, 0, 0, SRCCOPY);

  finally
    ReleaseDC(Win, DC);
  end;

end;

procedure TAutomationScreenshot.CaptureScreenshot(Control_: TWinControl);
var
  Win: HWND;
  DC: HDC;
  WinRect: TRect;
  Width: Integer;
  Height: Integer;

begin
  GetWindowRect(Win, WinRect);
  DC := GetWindowDC(Control_.Handle);

  try
    Width := WinRect.Right - WinRect.Left;
    Height := WinRect.Bottom - WinRect.Top;

    FBmp.Width := Width;
    FBmp.Height := Height;

    BitBlt(FBmp.Canvas.Handle, 0, 0, Width, Height, DC, 0, 0, SRCCOPY);

  finally
    ReleaseDC(Control_.Handle, DC);
  end;
end;

constructor TAutomationScreenshot.Create;
begin
  FBmp := TBitmap.Create;
end;

destructor TAutomationScreenshot.Destroy;
begin
  FBmp.FreeImage;
  freeAndNil(FBmp);

  inherited;
end;

procedure TAutomationScreenshot.SaveCurrentScreen;
var
  pathname : string;

begin
  self.CaptureScreenshot;

  pathname := TPath.GetGUIDFileName + '.bmp';

  FBmp.SaveToFile(pathname);
end;

procedure TAutomationScreenshot.SaveCurrentControl(Control_: TWinControl);
var
  pathname : string;

begin
  self.CaptureScreenshot(control_);

  pathname := TPath.GetGUIDFileName + '.bmp';

  FBmp.SaveToFile(pathname);
end;

end.

