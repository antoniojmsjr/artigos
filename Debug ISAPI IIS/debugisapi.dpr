library debugisapi;

uses
  Horse,
  System.Classes,
  System.JSON,
  System.DateUtils,
  System.SysUtils;

{$R *.res}

begin

  THorse.Get('/teste',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      lHTML: TStrings;
    begin
      lHTML := TStringList.Create;

      try
        lHTML.Add('<html xmlns="http://www.w3.org/1999/xhtml">');
        lHTML.Add('<head>');
        lHTML.Add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
        lHTML.Add('<title>Debug ISAPI</title>');
        lHTML.Add('</head>');
        lHTML.Add('<body>');
        lHTML.Add('<div id="container">');
        lHTML.Add('<h1>:: Página de teste - Debug ISAPI ::</h1>');
        lHTML.Add('<h1>:: ' + DateToISO8601(Now(), True) + ' ::</h1>');
        lHTML.Add('</div>');
        lHTML.Add('</body>');
        lHTML.Add('</html>');

        Res.Send(lHTML.Text);
      finally
        lHTML.Free;
      end;
    end);

  THorse.Listen; //START SERVER
end.
