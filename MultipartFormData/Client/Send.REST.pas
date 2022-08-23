unit Send.REST;

interface

uses
  Send.Classes, REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TSendRESTClient = class(TSendCustom)
  private
    { private declarations }
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
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

{ TSendRESTClient }

constructor TSendRESTClient.Create;
begin
  inherited Create;
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTClient := TRESTClient.Create(FRESTRequest);
  FRESTResponse := TRESTResponse.Create(FRESTRequest);

  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
end;

destructor TSendRESTClient.Destroy;
begin
  FRESTRequest.Free;
  inherited Destroy;
end;

procedure TSendRESTClient.Post;
begin
  FRESTRequest.ResetToDefaults;

  if (RequestTimeout > 0) then
    FRESTRequest.Timeout := RequestTimeout;

  FRESTRequest.Client.ContentType := 'multipart/form-data';

  FRESTRequest.Client.Params.AddItem('component', 'RESTClient');
  with FRESTRequest.Params.AddItem do
  begin
    Name := 'foto';
    SetStream(Foto);
    Value := 'foto';
    Kind := TRESTRequestParameterKind.pkFILE;
  end;
  FRESTRequest.Client.Params.AddItem('cadastro', TJson.ObjectToJsonString(Cadastro, [joDateFormatISO8601]));
  FRESTRequest.Client.AddParameter('perfil', Perfil, TRESTRequestParameterKind.pkFILE);

  FRESTRequest.Client.BaseURL := URL;
  FRESTRequest.Method := TRESTRequestMethod.rmPOST;
  FRESTRequest.Execute;

  if (FRESTRequest.Response.StatusCode <> 200) then
    ShowMessage('Falha: ' + FRESTRequest.Response.StatusText);
end;

end.
