program Project3;

uses
  Vcl.Forms,
  DemoForm in 'DemoForm.pas' {Form2};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.