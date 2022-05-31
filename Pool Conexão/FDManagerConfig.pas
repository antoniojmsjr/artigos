unit FDManagerConfig;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, FireDAC.Stan.Pool,

  //FireDAC.UI.Intf

  //FIREBIRD
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.Phys.IBWrapper;

type
  TConnectionDefDriverParams = record
    DriverDefName: string;
    VendorLib: string;
  end;

  TConnectionDefParams = record
    ConnectionDefName: string;
    Server: string;
    Database: string;
    UserName: string;
    Password: string;
    LocalConnection: Boolean;
  end;

  TConnectionDefPoolParams = record
    Pooled: Boolean;
    PoolMaximumItems: Integer;
    PoolCleanupTimeout: Integer;
    PoolExpireTimeout: Integer;
  end;

procedure ConfigConnectionFirebird;

implementation

uses
  Utils;

procedure ConfigFDManagerConnectionFirebird(
  const pConnectionDefDriverParams: TConnectionDefDriverParams;
  const pConnectionDefParams: TConnectionDefParams;
  const pConnectionDefPoolParams: TConnectionDefPoolParams);
var
  lConnection: TFDCustomConnection;
  lFBConnectionDefParams: TFDPhysFBConnectionDefParams; // FIREBIRD CONNECTION PARAMS
  lFDStanConnectionDef: IFDStanConnectionDef;
  lFDStanDefinition: IFDStanDefinition;
begin
  //PARA CRIAR OU ALTERAR É NECESSÁRIO FECHAR O FDMANGER REFERENTE AO ConnectionDefName
  FDManager.CloseConnectionDef(pConnectionDefParams.ConnectionDefName);

  //CONFIGURAÇÃO PADRÃO DO FDManager
  FDManager.ActiveStoredUsage := [auRunTime];
  FDManager.ConnectionDefFileAutoLoad := False;
  FDManager.DriverDefFileAutoLoad := False;
  FDManager.SilentMode := True; //DESATIVA O CICLO DE MENSAGEM COM O WINDOWS PARA APRESENTAR A AMPULHETA DE PROCESSANDO.

  //DRIVER
  lFDStanDefinition := FDManager.DriverDefs.FindDefinition(pConnectionDefDriverParams.DriverDefName);
  if not Assigned(FDManager.DriverDefs.FindDefinition(pConnectionDefDriverParams.DriverDefName)) then
  begin
    lFDStanDefinition := FDManager.DriverDefs.Add;
    lFDStanDefinition.Name := pConnectionDefDriverParams.DriverDefName;
  end;
  lFDStanDefinition.AsString['BaseDriverID'] := 'FB'; //DRIVER BASE
  if not pConnectionDefDriverParams.VendorLib.Trim.IsEmpty then
    lFDStanDefinition.AsString['VendorLib'] := pConnectionDefDriverParams.VendorLib; //DEFINE O CAMINHO DA DLL CLIENT DO FIREBIRD.

  //CRIAÇÃO DA CONEXÃO COM UM BANCO DE DADOS, PODE SER CRIADO QUANTOS FOREM NECESSÁRIO
  lFDStanConnectionDef := FDManager.ConnectionDefs.FindConnectionDef(pConnectionDefParams.ConnectionDefName);
  if not Assigned(FDManager.ConnectionDefs.FindConnectionDef(pConnectionDefParams.ConnectionDefName)) then
  begin
    lFDStanConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
    lFDStanConnectionDef.Name := pConnectionDefParams.ConnectionDefName;
  end;

  //DEFINIÇÃO DE CONEXÃO: PRIVADO :: https://docwiki.embarcadero.com/RADStudio/Sydney/en/Defining_Connection_(FireDAC)
  lFBConnectionDefParams := TFDPhysFBConnectionDefParams(lFDStanConnectionDef.Params);
  lFBConnectionDefParams.DriverID := pConnectionDefDriverParams.DriverDefName;
  lFBConnectionDefParams.Database := pConnectionDefParams.Database;
  lFBConnectionDefParams.UserName := pConnectionDefParams.UserName;
  lFBConnectionDefParams.Password := pConnectionDefParams.Password;
  lFBConnectionDefParams.Server := pConnectionDefParams.Server;
  lFBConnectionDefParams.Protocol := TIBProtocol.ipLocal;
  if not pConnectionDefParams.LocalConnection then
    lFBConnectionDefParams.Protocol := TIBProtocol.ipTCPIP;

  //CONFIGURAÇÃO DO POOL DE CONEXÃO
  lFBConnectionDefParams.Pooled := pConnectionDefPoolParams.Pooled;
  lFBConnectionDefParams.PoolMaximumItems := pConnectionDefPoolParams.PoolMaximumItems;
  lFBConnectionDefParams.PoolCleanupTimeout := pConnectionDefPoolParams.PoolCleanupTimeout;
  lFBConnectionDefParams.PoolExpireTimeout := pConnectionDefPoolParams.PoolExpireTimeout;

  //DEFINIÇÃO DAS CONFIGURAÇÕES DE CONEXÃO
  lConnection := TFDCustomConnection.Create(nil);
  try
    lConnection.FetchOptions.Mode := TFDFetchMode.fmAll;
    lConnection.ResourceOptions.AutoConnect := False;
    lConnection.LoginPrompt := False;
    //lConnection.ResourceOptions.AutoReconnect := True;  //PERDA DE PERFORMANCE COM THREAD

    with lConnection.FormatOptions.MapRules.Add do
    begin
      SourceDataType := dtDateTime; { TFDParam.DataType }
      TargetDataType := dtDateTimeStamp; { Firebird TIMESTAMP }
    end;

    lFDStanConnectionDef.WriteOptions(lConnection.FormatOptions,
                                      lConnection.UpdateOptions,
                                      lConnection.FetchOptions,
                                      lConnection.ResourceOptions);
  finally
    lConnection.Free;
  end;

  //INICIALIZA O FDManager
  if (FDManager.State <> TFDPhysManagerState.dmsActive) then
    FDManager.Open;
end;

procedure ConfigConnectionFirebird;
var
  lConnectionDefDriverParams: TConnectionDefDriverParams;
  lConnectionDefParams: TConnectionDefParams;
  lConnectionDefPoolParams: TConnectionDefPoolParams;
begin
  lConnectionDefDriverParams.DriverDefName := 'FB_DRIVER';
  lConnectionDefDriverParams.VendorLib := 'fbclient.dll';

  lConnectionDefParams.ConnectionDefName := 'FB_CONNECTION';
  lConnectionDefParams.Server := '127.0.0.1';
  lConnectionDefParams.Database := GetPathApp + 'DB\POOL_CONEXAO.FDB';
  lConnectionDefParams.UserName := 'SYSDBA';
  lConnectionDefParams.Password := 'masterkey';
  lConnectionDefParams.LocalConnection := True;

  lConnectionDefPoolParams.Pooled := True;
  lConnectionDefPoolParams.PoolMaximumItems := 100; //LIMITE DE 100 CONEXÕES
  lConnectionDefPoolParams.PoolCleanupTimeout := 30000; //O tempo (ms) até o FireDAC remover as conexões que não foram usadas até o tempo POOL_ExpireTimeout.
  lConnectionDefPoolParams.PoolExpireTimeout := 60000; //O tempo (ms), após o qual a conexão inativa pode ser excluída do pool e destruída.

  ConfigFDManagerConnectionFirebird(lConnectionDefDriverParams,
                                    lConnectionDefParams,
                                    lConnectionDefPoolParams);
end;

end.
