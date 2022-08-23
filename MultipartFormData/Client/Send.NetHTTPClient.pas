unit Send.NetHttpClient;

interface

uses
  Send.Classes, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TSendNetHTTPClient = class(TSendCustom)
  private
    { private declarations }
    FHTTPRequest: TNetHTTPRequest;
    FHTTPClient: TNetHTTPClient;
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

{ TSendNetHTTPClient }

constructor TSendNetHTTPClient.Create;
begin
  inherited Create;
  FHTTPRequest := TNetHTTPRequest.Create(nil);
  FHTTPClient := TNetHTTPClient.Create(FHTTPRequest);
  FHTTPRequest.Client := FHTTPClient;
end;

destructor TSendNetHTTPClient.Destroy;
begin
  FHTTPRequest.Free;
  inherited Destroy;
end;

procedure TSendNetHTTPClient.Post;
var
  lIHTTPResponse: IHTTPResponse;
  lMultipartFormData: TMultipartFormData;
begin

  if (RequestTimeout > 0) then
  begin
    FHTTPRequest.ConnectionTimeout := RequestTimeout;
    FHTTPRequest.ResponseTimeout := RequestTimeout;
  end;

  FHTTPRequest.Client.ContentType := 'multipart/form-data';

  lMultipartFormData := TMultipartFormData.Create;
  try
    lMultipartFormData.AddField('component', 'NetHTTPClient');
    lMultipartFormData.AddStream('foto', Foto, 'foto');
    lMultipartFormData.AddField('cadastro', TJson.ObjectToJsonString(Cadastro, [joDateFormatISO8601]));
    lMultipartFormData.AddFile('perfil', Perfil);

    lIHTTPResponse := FHTTPRequest.Client.Post(URL, lMultipartFormData);

    if (lIHTTPResponse.StatusCode <> 200)  then
      ShowMessage('Falha: ' + lIHTTPResponse.StatusText);
  finally
    lMultipartFormData.Free;
  end;
end;

end.
