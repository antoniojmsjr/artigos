program PoolConexaoConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, Horse,
  FDManagerConfig in 'FDManagerConfig.pas',
  Routers in 'Routers.pas',
  Utils in 'Utils.pas';
begin

  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  TRouters.Register;

  THorse.Listen(9000,
    procedure(pHorse: THorse)
    begin
      ConfigConnectionFirebird;

      Writeln(Format('Server is runing on %s:%d', [pHorse.Host, pHorse.Port]));
      Readln;
    end);
end.
