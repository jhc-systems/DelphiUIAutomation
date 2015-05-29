program Project3;

uses
  Vcl.Forms,
  DemoForm in 'DemoForm.pas' {Form2},
  UIAutomationCore_TLB in 'UIAutomationCore_TLB.pas',
  AutomatedStringGrid in 'AutomatedStringGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
