unit Routers;

interface

uses
  Horse, Utils, System.Diagnostics;

type

  TRouters = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure Register;
    class procedure GetPing(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
    class procedure GetSelect(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
  end;

implementation

uses
  System.SysUtils;

{ TRouters }

class procedure TRouters.GetPing(Req: THorseRequest; Res: THorseResponse;
  Next: TNextProc);
begin
  Res.Send('Pong');
end;

class procedure TRouters.GetSelect(Req: THorseRequest; Res: THorseResponse;
  Next: TNextProc);
var
  lSW: TStopwatch;
  lMsg: string;
begin
  lSW := TStopwatch.StartNew;
  try
    QueryOpen('FB_CONNECTION', 'SELECT * FROM POOL_CONEXAO');
  except
    on E: Exception do
    begin
      lSW.Stop;
      lMsg := '{"error": "Erro ao consultar= ' + E.Message + '"}';
      Res.Send(lMsg).Status(500);
      Exit;
    end;
  end;
  lSW.Stop;

  lMsg := '{"execute_time": "' + FormatDateTime('hh:nn:ss:zzz', lsw.ElapsedMilliseconds/MSecsPerDay) + '"}';
  Res.Send(lMsg).Status(200);
end;

class procedure TRouters.Register;
begin
  THorse.Get('/ping', GetPing);
  THorse.Get('/select', GetSelect);
end;

end.
