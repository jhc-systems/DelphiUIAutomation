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
unit DelphiUIAutomation.Mouse;

interface

uses
  types;

type
  IAutomationMouse = interface
    ['{4EEEC6B6-0967-4580-B54E-1F4861F9A057}']
    function GetLocation : TPoint;
    procedure SetLocation (value : TPoint);

    /// <summary>
    ///  Gets or sets the current mouse location
    /// </summary>
    property Location : TPoint read GetLocation write SetLocation;

    /// <summary>
    ///  Double left clicks the mouse
    /// </summary>
    procedure DoubleLeftClick;

    /// <summary>
    ///  Right clicks the mouse
    /// </summary>
    procedure RightClick;

    /// <summary>
    ///  Left clicks the mouse
    /// </summary>
    procedure LeftClick;
  end;

  /// <summary>
  ///  The representation of a mouse
  /// </summary>
  TAutomationMouse = class (TInterfacedObject, IAutomationMouse)
  private
    function GetLocation : TPoint;
    procedure SetLocation (value : TPoint);

    function getDoubleClickInterval : integer;
    procedure setDoubleClickInterval (value : integer);

    procedure MouseLeftButtonUpAndDown;
    procedure MouseRightButtonUpAndDown;
    procedure LeftDown;
    procedure LeftUp;
    procedure RightDown;
    procedure RightUp;

  public
    /// <summary>
    ///  Right clicks the mouse
    /// </summary>
    procedure RightClick;

    /// <summary>
    ///  Left clicks the mouse
    /// </summary>
    procedure LeftClick;

    /// <summary>
    ///  Double left clicks the mouse
    /// </summary>
    procedure DoubleLeftClick;

    /// <summary>
    ///  Gets or sets the current mouse location
    /// </summary>
    property Location : TPoint read GetLocation write SetLocation;

    /// <summary>
    ///  Gets or sets the double-click interval
    /// </summary>
    property DoubleClickInterval : integer read getDoubleClickInterval write setDoubleClickInterval;
  end;

implementation

uses
  winapi.windows;

function TAutomationMouse.GetLocation : TPoint;
var
  pt : TPoint;
begin
  GetCursorPos(pt);

  result := pt;
end;

procedure TAutomationMouse.SetLocation (value : TPoint);
begin
  SetCursorPos(value.X, value.Y);
end;

procedure TAutomationMouse.LeftClick;
begin
  MouseLeftButtonUpAndDown;
end;

procedure TAutomationMouse.DoubleLeftClick;
begin
  MouseLeftButtonUpAndDown;
  sleep(getDoubleClickInterval);
  MouseLeftButtonUpAndDown;
end;

procedure TAutomationMouse.MouseLeftButtonUpAndDown;
begin
  LeftDown;
  LeftUp;
end;

procedure TAutomationMouse.MouseRightButtonUpAndDown;
begin
  RightDown;
  RightUp;
end;

procedure TAutomationMouse.RightClick;
begin
  MouseRightButtonUpAndDown;
end;

procedure TAutomationMouse.RightDown;
begin
  mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0)
end;

procedure TAutomationMouse.RightUp;
begin
  mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0)
end;

procedure TAutomationMouse.LeftDown;
begin
  mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
end;

procedure TAutomationMouse.LeftUp;
begin
  mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
end;

function TAutomationMouse.getDoubleClickInterval : integer;
begin
  result := GetDoubleClickTime;
end;

procedure TAutomationMouse.setDoubleClickInterval (value : integer);
begin
  SetDoubleClickTime(value);
end;

end.
