program MultipartFormDataClient;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Cadastro in 'Cadastro.pas',
  Send.NetHttpClient in 'Send.NetHttpClient.pas',
  Send.Classes in 'Send.Classes.pas',
  Send.IdHTTP in 'Send.IdHTTP.pas',
  Send.REST in 'Send.REST.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
