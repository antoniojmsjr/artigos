unit Send.IdHTTP;

interface

uses
  Send.Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdMultipartFormData;

type
  TSendIdHTTP = class(TSendCustom)
  private
    { private declarations }
    FIdHTTP: TIdHTTP;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; override;
    destructor Destroy; override;
    procedure Post; override;
  end;

implementation

uses
  System.SysUtils, System.JSON, REST.JSON, System.Net.Mime, Vcl.Dialogs;

{ TSendIdHTTP }

//https://stackoverflow.com/questions/30292615/striping-out-the-content-type-from-tidmultipartformdatastream

constructor TSendIdHTTP.Create;
begin
  inherited Create;
  FIdHTTP := TIdHTTP.Create(nil);
end;

destructor TSendIdHTTP.Destroy;
begin
  FIdHTTP.Free;
  inherited Destroy;
end;

procedure TSendIdHTTP.Post;
var
  lIdMultiPartFormDataStream: TIdMultiPartFormDataStream;
begin
  FIdHTTP.Request.Clear;
  if (RequestTimeout > 0) then
  begin
    FIdHTTP.ReadTimeout := RequestTimeout;
    FIdHTTP.ConnectTimeout := RequestTimeout;
  end;

  lIdMultiPartFormDataStream := TIdMultiPartFormDataStream.Create;
  try
    lIdMultiPartFormDataStream.AddFormField('component', 'Indy').ContentType := ' ';
    lIdMultiPartFormDataStream.AddFormField('foto', EmptyStr, EmptyStr, Foto, 'foto');
    with lIdMultiPartFormDataStream.AddFormField('cadastro', TJson.ObjectToJsonString(Cadastro, [joDateFormatISO8601]), EmptyStr, 'application/json') do
    begin
      ContentType := ' ';
      ContentTransfer:= '8bit';
    end;
    lIdMultiPartFormDataStream.AddFile('perfil', Perfil);
    lIdMultiPartFormDataStream.Position := 0;


    FIdHTTP.HTTPOptions := FIdHTTP.HTTPOptions + [hoKeepOrigProtocol];
    FIdHTTP.ProtocolVersion := pv1_1;
    FIdHTTP.Request.ContentType := lIdMultiPartFormDataStream.RequestContentType;
    FIdHTTP.Request.CharSet := 'utf-8';

    FIdHTTP.Post(URL, lIdMultiPartFormDataStream);
    if (FIdHTTP.ResponseCode <> 200) then
      ShowMessage('Falha: ' + FIdHTTP.ResponseText);
  finally
    lIdMultiPartFormDataStream.Free;
  end;
end;

end.
