unit Send.Classes;

interface

uses
  Cadastro, System.Classes;

type

  TSendCustom = class
  private
    { private declarations }
    FCadastro: TCadastro;
    FURL: string;
    FRequestTimeout: Integer;
    FPerfil: string;
    FFoto: TMemoryStream;
    procedure SetCadastro(const Value: TCadastro);
    procedure SetURL(const Value: string);
    procedure SetRequestTimeout(const Value: Integer);
    procedure SetPerfil(const Value: string);
    procedure SetFoto(const Value: TMemoryStream);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Post; virtual; abstract;
    property URL: string read FURL write SetURL;
    property RequestTimeout: Integer read FRequestTimeout write SetRequestTimeout;
    property Foto: TMemoryStream read FFoto write SetFoto;
    property Cadastro: TCadastro read FCadastro write SetCadastro;
    property Perfil: string read FPerfil write SetPerfil;
  end;

implementation

{ TSendCustom }

constructor TSendCustom.Create;
begin
  FFoto := TMemoryStream.Create;
end;

destructor TSendCustom.Destroy;
begin
  FFoto.Free;
  inherited Destroy;
end;

procedure TSendCustom.SetCadastro(const Value: TCadastro);
begin
  FCadastro := Value;
end;

procedure TSendCustom.SetFoto(const Value: TMemoryStream);
begin
  Value.Seek(0, soBeginning);
  FFoto.Clear;
  FFoto.CopyFrom(Value, 0);
end;

procedure TSendCustom.SetPerfil(const Value: string);
begin
  FPerfil := Value;
end;

procedure TSendCustom.SetRequestTimeout(const Value: Integer);
begin
  FRequestTimeout := Value;
end;

procedure TSendCustom.SetURL(const Value: string);
begin
  FURL := Value;
end;

end.
