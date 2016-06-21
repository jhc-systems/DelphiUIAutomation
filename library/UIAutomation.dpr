library UIAutomation;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.ShareMem,
  System.SysUtils,
  System.Classes,
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.Automation in '..\source\DelphiUIAutomation.Automation.pas',
  DelphiUIAutomation.Window in '..\source\Controls\DelphiUIAutomation.Window.pas',
  DelphiUIAutomation.Client in '..\source\DelphiUIAutomation.Client.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  DelphiUIAutomation.EditBox in '..\source\Controls\DelphiUIAutomation.EditBox.pas',
  DelphiUIAutomation.Button in '..\source\Controls\DelphiUIAutomation.Button.pas',
  DelphiUIAutomation.ControlTypeIDs in '..\source\Ids\DelphiUIAutomation.ControlTypeIDs.pas',
  DelphiUIAutomation.PatternIDs in '..\source\Ids\DelphiUIAutomation.PatternIDs.pas',
  DelphiUIAutomation.Mouse in '..\source\DelphiUIAutomation.Mouse.pas',
  DelphiUIAutomation.ComboBox in '..\source\Controls\DelphiUIAutomation.ComboBox.pas',
  DelphiUIAutomation.PropertyIDs in '..\source\Ids\DelphiUIAutomation.PropertyIDs.pas',
  DelphiUIAutomation.Tab in '..\source\Controls\DelphiUIAutomation.Tab.pas',
  DelphiUIAutomation.TabItem in '..\source\Controls\DelphiUIAutomation.TabItem.pas',
  DelphiUIAutomation.Statusbar in '..\source\Controls\DelphiUIAutomation.Statusbar.pas',
  DelphiUIAutomation.Checkbox in '..\source\Controls\DelphiUIAutomation.Checkbox.pas',
  DelphiUIAutomation.RadioButton in '..\source\Controls\DelphiUIAutomation.RadioButton.pas',
  DelphiUIAutomation.MenuItem in '..\source\Controls\Menus\DelphiUIAutomation.MenuItem.pas',
  DelphiUIAutomation.Exception in '..\source\DelphiUIAutomation.Exception.pas',
  DelphiUIAutomation.Desktop in '..\source\Controls\DelphiUIAutomation.Desktop.pas',
  DelphiUIAutomation.ScreenShot in '..\source\DelphiUIAutomation.ScreenShot.pas',
  DelphiUIAutomation.Menu in '..\source\Controls\Menus\DelphiUIAutomation.Menu.pas',
  DelphiUIAutomation.Base in '..\source\DelphiUIAutomation.Base.pas',
  DelphiUIAutomation.Container in '..\source\Controls\DelphiUIAutomation.Container.pas',
  DelphiUIAutomation.Tab.Intf in '..\source\Controls\DelphiUIAutomation.Tab.Intf.pas',
  DelphiUIAutomation.Container.Intf in '..\source\Controls\DelphiUIAutomation.Container.Intf.pas',
  DelphiUIAutomation.ListItem in '..\source\Controls\DelphiUIAutomation.ListItem.pas',
  DelphiUIAutomation.Keyboard in '..\source\DelphiUIAutomation.Keyboard.pas',
  DelphiUIAutomation.Hyperlink in '..\source\Controls\DelphiUIAutomation.Hyperlink.pas',
  DelphiUIAutomation.TextBox in '..\source\Controls\DelphiUIAutomation.TextBox.pas',
  DelphiUIAutomation.Processes in '..\source\DelphiUIAutomation.Processes.pas',
  DelphiUIAutomation.Clipboard in '..\source\DelphiUIAutomation.Clipboard.pas',
  DelphiUIAutomation.StringGrid in '..\source\Controls\DelphiUIAutomation.StringGrid.pas',
  DelphiUIAutomation.Panel.Intf in '..\source\Controls\DelphiUIAutomation.Panel.Intf.pas',
  DelphiUIAutomation.StringGridItem in '..\source\Controls\DelphiUIAutomation.StringGridItem.pas',
  DelphiUIAutomation.Panel in '..\source\Controls\DelphiUIAutomation.Panel.pas',
  DelphiUIAutomation.TreeView in '..\source\Controls\DelphiUIAutomation.TreeView.pas',
  DelphiUIAutomation.Condition in '..\source\Conditions\DelphiUIAutomation.Condition.pas',
  DelphiUIAutomation.AndCondition in '..\source\Conditions\DelphiUIAutomation.AndCondition.pas',
  DelphiUIAutomation.OrCondition in '..\source\Conditions\DelphiUIAutomation.OrCondition.pas',
  DelphiUIAutomation.FalseCondition in '..\source\Conditions\DelphiUIAutomation.FalseCondition.pas',
  DelphiUIAutomation.TrueCondition in '..\source\Conditions\DelphiUIAutomation.TrueCondition.pas',
  DelphiUIAutomation.NameCondition in '..\source\Conditions\DelphiUIAutomation.NameCondition.pas',
  DelphiUIAutomation.ControlTypeCondition in '..\source\Conditions\DelphiUIAutomation.ControlTypeCondition.pas',
  Dialogs;

{$R *.res}

var
  application: IAutomationApplication;
  window: IAutomationWindow;

procedure DllMessage; export;
begin
  ShowMessage('Hello world from a Delphi DLL');
end;

procedure Initialize; export;
begin
  TUIAuto.CreateUIAuto;
end;

procedure Finalize; export;
begin
  TUIAuto.DestroyUIAuto;
end;

procedure LaunchOrAttach(const val1, val2 : String); export;
begin
  WriteLn('LaunchOrAttach - ' + val1 + ' - ' + val2);
  application := TAutomationApplication.LaunchOrAttach (val1, val2);
  WriteLn('LaunchOrAttach - done');
end;

procedure Kill; export;
begin
  WriteLn('Kill');
  application.Kill;
  WriteLn('Kill - done');
end;

procedure GetDesktopWindow(const value: String); export;
begin
  window := TAutomationDesktop.GetDesktopWindow(value);
end;

procedure WaitWhileBusy; export;
begin
  application.WaitWhileBusy;
end;

procedure Maximize; export;
begin
  window.Maximize;
end;

exports DllMessage, Kill, LaunchOrAttach, Initialize, Finalize, GetDesktopWindow, WaitWhileBusy, Maximize;

begin
end.
