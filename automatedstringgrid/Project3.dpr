program Project3;

uses
  Vcl.Forms,
  AutomatedStringGrid in 'AutomatedStringGrid.pas',
  DemoForm in 'DemoForm.pas' {Form2},
  UIAutomationCore_TLB in 'UIAutomationCore_TLB.pas',
  StringGridRow in 'StringGridRow.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
