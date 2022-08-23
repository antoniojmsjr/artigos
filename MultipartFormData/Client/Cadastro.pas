unit Cadastro;

interface

type
  TCadastroEndereco = class;
  
  TCadastro = class(TObject)
  private
    { private declarations }  
    FNome: string;
    FSobrenome: string;
    FDataNascimento: TDateTime;
    FCelular: string;
    FGithub: string;
    FEndereco: TCadastroEndereco;
    procedure SetNome(const Value: string);
    procedure SetSobrenome(const Value: string);
    procedure SetCelular(const Value: string);
    procedure SetDataNascimento(const Value: TDateTime);
    procedure SetGithub(const Value: string);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    function ToString: string; override;
    property Nome: string read FNome write SetNome;
    property Sobrenome: string read FSobrenome write SetSobrenome;
    property DataNascimento: TDateTime read FDataNascimento write SetDataNascimento;
    property Celular: string read FCelular write SetCelular;
    property Github: string read FGithub write SetGithub;
    property Endereco: TCadastroEndereco read FEndereco;
  end;

  TCadastroEndereco = class
  private
    { private declarations }
    FEndereco: string;
    FNumero: Integer;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FCEP: string;
    procedure SetBairro(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetNumero(const Value: Integer);
    procedure SetCEP(const Value: string);
  protected
    { protected declarations }
  public
    { public declarations }
    function ToString: string; override;
    property Endereco: string read FEndereco write SetEndereco;
    property Numero: Integer read FNumero write SetNumero;
    property Complemento: string read FComplemento write SetComplemento;
    property Bairro: string read FBairro write SetBairro;
    property Cidade: string read FCidade write SetCidade;
    property Estado: string read FEstado write SetEstado;
    property CEP: string read FCEP write SetCEP;
  end;
  
implementation

uses
  System.SysUtils;
  
{ TCadastro }

constructor TCadastro.Create;
begin
  FEndereco := TCadastroEndereco.Create;
end;

destructor TCadastro.Destroy;
begin
  FEndereco.Free;
  inherited Destroy;
end;

procedure TCadastro.SetCelular(const Value: string);
begin
  FCelular := Value;
end;

procedure TCadastro.SetDataNascimento(const Value: TDateTime);
begin
  FDataNascimento := Value;
end;

procedure TCadastro.SetGithub(const Value: string);
begin
  FGithub := Value;
end;

procedure TCadastro.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCadastro.SetSobrenome(const Value: string);
begin
  FSobrenome := Value;
end;

function TCadastro.ToString: string;
begin
  Result := EmptyStr;
  Result := Concat(Result, 'Nome: ', FNome, sLineBreak);
  Result := Concat(Result, 'Sobrenome: ', FSobrenome, sLineBreak);  
  Result := Concat(Result, 'Data Nascimento: ', DateToStr(FDataNascimento), sLineBreak);    
  Result := Concat(Result, 'Celular: ', FCelular, sLineBreak);    
  Result := Concat(Result, 'Github: ', FGithub, sLineBreak);
end;

{ TCadastroEndereco }

procedure TCadastroEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TCadastroEndereco.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TCadastroEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCadastroEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TCadastroEndereco.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCadastroEndereco.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TCadastroEndereco.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

function TCadastroEndereco.ToString: string;
begin
  Result := EmptyStr;
  Result := Concat(Result, 'Endereco: ', FEndereco, sLineBreak);
  Result := Concat(Result, 'Numero: ', IntToStr(FNumero), sLineBreak);  
  Result := Concat(Result, 'Complemento: ', FComplemento, sLineBreak);    
  Result := Concat(Result, 'Bairro: ', FBairro, sLineBreak);    
  Result := Concat(Result, 'Cidade: ', FCidade, sLineBreak); 
  Result := Concat(Result, 'Estado: ', FEstado, sLineBreak); 
  Result := Concat(Result, 'CEP: ', FCEP, sLineBreak); 
end;

end.
