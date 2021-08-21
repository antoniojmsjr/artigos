library TesteISAPI;

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.Classes,
  System.JSON,
  System.DateUtils,
  System.SysUtils;

begin
  THorse
    .Use(Jhonson);

  THorse.Get('/',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      lHTML: TStrings;
    begin
      lHTML := TStringList.Create;

      try
        lHTML.Add('<html xmlns="http://www.w3.org/1999/xhtml">');
        lHTML.Add('<head>');
        lHTML.Add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
        lHTML.Add('<title>Teste ISAPI</title>');
        lHTML.Add('</head>');
        lHTML.Add('<body>');
        lHTML.Add('<div id="container">');
        lHTML.Add('<h1>:: Página de Teste ISAPI ::</h1>');
        lHTML.Add('<h1>:: ' + DateToISO8601(Now(), True) + ' ::</h1>');
        lHTML.Add('</div>');
        lHTML.Add('</body>');
        lHTML.Add('</html>');

        Res.Send(lHTML.Text);
      finally
        lHTML.Free;
      end;
    end);

    THorse.Get('/datahora',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        lContent: TJSONObject;
      begin
        lContent := TJSONObject.Create;
        lContent.AddPair('datahora', DateToISO8601(Now(), True));

        Res.Send<TJSONObject>(lContent);
      end);

  THorse.Listen; //START SERVER
end.

