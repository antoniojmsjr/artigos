library APIRestIIS;

uses
  Horse,
  System.SysUtils,
  System.Classes;

{$R *.res}

begin

  THorse.Get('/exemplo1',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('<h1>*** Exemplo API Rest Delphi ***</h1>');
    end);

  THorse.Get('/exemplo2/:valor',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      lHTML: string;
    begin
      lHTML := EmptyStr;
      lHTML := Concat(lHTML, '<h1>*** Exemplo API Rest Delphi ***</h1>');
      lHTML := Concat(lHTML, '<h2>:: ' + Req.Params['valor'] + ' ::</h2>');

      Res.Send(lHTML);
    end);

  THorse.Listen; //START SERVIDOR
end.


