unit Utils;

interface

procedure ExecuteGET(const pURL: string; out pText: string; out pStatusCode: Integer);

implementation

uses
  Winapi.Windows, System.SysUtils, System.JSON, REST.Json, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, REST.JSon.Types;

procedure ExecuteGET(const pURL: string;
  out pText: string; out pStatusCode: Integer);
var
  lHttpRequest: TNetHTTPRequest;
  lHttpClient: TNetHTTPClient;
  lIHTTPResponse: IHTTPResponse;
begin
  lHttpRequest := nil;
  lHttpClient := nil;
  try
    try
      lHttpClient := TNetHTTPClient.Create(nil);
      {$IFDEF VER330}
      lHttpClient.SecureProtocols := [];
      lHttpClient.SecureProtocols := [THTTPSecureProtocol.TLS1,
                                      THTTPSecureProtocol.TLS11,
                                      THTTPSecureProtocol.TLS12];
      {$ENDIF}

      lHttpRequest := TNetHTTPRequest.Create(nil);
      lHttpRequest.Client := lHttpClient;

      lHttpRequest.Client.Accept := 'application/json';
      lIHTTPResponse := lHttpClient.Get(pURL);

      pText := lIHTTPResponse.ContentAsString;
      pStatusCode := lIHTTPResponse.StatusCode;
    except
      on E: Exception do
        pText := E.Message;
    end;
  finally
    lHttpRequest.Free;
    lHttpClient.Free;
  end;
end;

end.
