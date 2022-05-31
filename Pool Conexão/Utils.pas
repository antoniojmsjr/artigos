unit Utils;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

procedure QueryOpen(const pConnectDefName: string; const pSQL: string);
function GetPathApp: string;

implementation

uses
  Winapi.Windows, System.SysUtils;

procedure QueryOpen(const pConnectDefName: string; const pSQL: string);
var
  lFDConnection: TFDConnection;
  lQuery: TFDQuery;
begin
  lFDConnection := nil;
  lQuery := nil;
  try
    lFDConnection := TFDConnection.Create(nil);
    lFDConnection.ConnectionDefName := pConnectDefName;
    lQuery := TFDQuery.Create(nil);
    lQuery.Connection := lFDConnection;

    lQuery.SQL.Add(pSQL);
    lQuery.Open;
  finally
    lQuery.Free;
    lFDConnection.Free;
  end;
end;

function GetPathFileApp: string;
var
  lFileName: array[0..MAX_PATH] of Char;
  lReturn: Cardinal;
begin

  //DELPHI PACKAGE
  if ModuleIsPackage then begin
    Result := ParamStr(0);
  end
  else //EXE/DLL
  begin
    FillChar(lFileName, SizeOf(lFileName), #0);
    lReturn := GetModuleFileName(HInstance, lFileName, MAX_PATH);

    if (lReturn > 0) then
      Result := string(lFileName)
    else
      raise Exception.CreateFmt('%s - %d', ['GetPathFile', GetLastError]);
  end;

  //IIS
  if Result.StartsWith('\\?\') then
    Delete(Result, 1, 4);
end;

function GetPathApp: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(GetPathFileApp));
end;

end.
