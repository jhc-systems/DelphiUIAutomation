unit DelphiUIAutomation.Mouse;

interface

uses
  types;

type
  TAutomationMouse = class
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
    procedure RightClick;
    procedure LeftClick;
    procedure DoubleLeftClick;
    property Location : TPoint read GetLocation write SetLocation;
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
