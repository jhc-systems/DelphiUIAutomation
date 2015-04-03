program AutomationDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  generics.collections,
  System.SysUtils,
  types,
  DelphiUIAutomation.Automation in '..\source\DelphiUIAutomation.Automation.pas',
  UIAutomationClient_TLB in '..\source\UIAutomationClient_TLB.pas',
  DelphiUIAutomation.AutomationWindow in '..\source\DelphiUIAutomation.AutomationWindow.pas',
  DelphiUIAutomation.AutomationClient in '..\source\DelphiUIAutomation.AutomationClient.pas',
  DelphiUIAutomation.Utils in '..\source\DelphiUIAutomation.Utils.pas',
  DelphiUIAutomation.AutomationTextBox in '..\source\DelphiUIAutomation.AutomationTextBox.pas',
  DelphiUIAutomation.AutomationBase in '..\source\DelphiUIAutomation.AutomationBase.pas',
  DelphiUIAutomation.AutomationButton in '..\source\DelphiUIAutomation.AutomationButton.pas',
  DelphiUIAutomation.AutomationControlTypeIDs in '..\source\DelphiUIAutomation.AutomationControlTypeIDs.pas',
  DelphiUIAutomation.AutomationPatternIDs in '..\source\DelphiUIAutomation.AutomationPatternIDs.pas',
  DelphiUIAutomation.Mouse in '..\source\DelphiUIAutomation.Mouse.pas',
  DelphiUIAutomation.AutomationComboBox in '..\source\DelphiUIAutomation.AutomationComboBox.pas',
  DelphiUIAutomation.AutomationPropertyIDs in '..\source\DelphiUIAutomation.AutomationPropertyIDs.pas',
  DelphiUIAutomation.AutomationTab in '..\source\DelphiUIAutomation.AutomationTab.pas',
  DelphiUIAutomation.AutomationTabItem in '..\source\DelphiUIAutomation.AutomationTabItem.pas';

var
  FApp : TAutomationClient;
  windows : TList<TAutomationWindow>;
  window : TAutomationWindow;
  i : integer;
  splash : TAutomationWindow;
  enquiry : TAutomationWindow;
  connect, security, calc : TAutomationWindow;
  tb1 : TAutomationTextBox;
  tb0 : TAutomationTextBox;
  btnOK, btnCalc : TAutomationButton;
  mouse : TAutomationMouse;
  price, quantity, netValue : TAutomationTextBox;
  account, stock, buysell : TAutomationComboBox;
  tab : TAutomationTab;

begin
  // Now wait for a very long time for the enquiry screen to come up
  enquiry := TAutomationClient.GetDesktopWindow('Form1');
  enquiry.Focus;

  // 4. Select the correct tab
  tab := enquiry.GetTab;
  tab.SelectTabPage('TabSheet2');     // 3 is the magic number

  tab.selectedItem.ListControlsAndStuff(nil);

  // 5. Click the fetch button
  mouse := TAutomationMouse.Create;
  mouse.Location := TPoint.Create(370, 160);
  mouse.LeftClick;

  sleep(8000);

end.

