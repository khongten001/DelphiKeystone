program DelphiStone;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  DKeystone in 'DKeystone.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
