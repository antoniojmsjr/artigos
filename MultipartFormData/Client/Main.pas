unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtDlgs,

  Cadastro, Send.NetHTTPClient, Send.IdHTTP, Send.REST;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    pnlBottom: TPanel;
    pnlClient: TPanel;
    bvlHeader: TBevel;
    imgFoto: TImage;
    lblNome: TLabel;
    edtNome: TEdit;
    lblSobrenome: TLabel;
    edtSobrenome: TEdit;
    lblDataNascimento: TLabel;
    dtDataNascimento: TDateTimePicker;
    lblCelular: TLabel;
    medtCelular: TMaskEdit;
    lblGithub: TLabel;
    edtGithub: TEdit;
    grpEndereco: TGroupBox;
    lblEnderecoLogradouro: TLabel;
    edtEnderecoLogradouro: TEdit;
    lblEnderecoNumero: TLabel;
    edtEnderecoNumero: TEdit;
    lblEnderecoComplemento: TLabel;
    edtEnderecoComplemento: TEdit;
    lblEnderecoBairro: TLabel;
    edtEnderecoBairro: TEdit;
    lblEnderecoCidade: TLabel;
    edtEnderecoCidade: TEdit;
    lblEnderecoEstado: TLabel;
    edtEnderecoEstado: TEdit;
    lblEnderecoCEP: TLabel;
    edtEnderecoCEP: TEdit;
    lblPerfilTitulo: TLabel;
    lblPerfil: TLabel;
    bvlBottom: TBevel;
    btnVisualizarCadastro: TBitBtn;
    btnSendNetHTTPClient: TBitBtn;
    opdFoto: TOpenPictureDialog;
    blhMain: TBalloonHint;
    btnSendIndy: TBitBtn;
    btnSendRESTClient: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtSobrenomeChange(Sender: TObject);
    procedure dtDataNascimentoChange(Sender: TObject);
    procedure medtCelularChange(Sender: TObject);
    procedure edtGithubChange(Sender: TObject);
    procedure edtEnderecoLogradouroChange(Sender: TObject);
    procedure edtEnderecoNumeroChange(Sender: TObject);
    procedure edtEnderecoComplementoChange(Sender: TObject);
    procedure edtEnderecoBairroChange(Sender: TObject);
    procedure edtEnderecoCidadeChange(Sender: TObject);
    procedure edtEnderecoEstadoChange(Sender: TObject);
    procedure edtEnderecoCEPChange(Sender: TObject);
    procedure btnVisualizarCadastroClick(Sender: TObject);
    procedure btnSendNetHTTPClientClick(Sender: TObject);
    procedure imgFotoClick(Sender: TObject);
    procedure lblPerfilClick(Sender: TObject);
    procedure btnSendIndyClick(Sender: TObject);
    procedure btnSendRESTClientClick(Sender: TObject);
  private
    { Private declarations }
    FPerfil: string;
    FCadastro: TCadastro;
    FSendNetHTTPClient: TSendNetHTTPClient;
    FSendIdHTTP: TSendIdHTTP;
    FSendRESTClient: TSendRESTClient;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  Winapi.ShellApi, System.DateUtils;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FPerfil := Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Github.pdf']);
  lblPerfil.Caption := FPerfil;

  FCadastro := TCadastro.Create;
  FSendNetHTTPClient := TSendNetHTTPClient.Create;
  FSendIdHTTP := TSendIdHTTP.Create;
  FSendRESTClient := TSendRESTClient.Create;

  opdFoto.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FCadastro.Free;
  FSendNetHTTPClient.Free;
  FSendIdHTTP.Free;
  FSendRESTClient.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  FCadastro.Nome := edtNome.Text;
  FCadastro.Sobrenome := edtSobrenome.Text;
  FCadastro.DataNascimento := dtDataNascimento.Date;
  FCadastro.Celular := medtCelular.Text;
  FCadastro.Github := edtGithub.Text;

  FCadastro.Endereco.Endereco := edtEnderecoLogradouro.Text;
  FCadastro.Endereco.Numero := StrToInt(edtEnderecoNumero.Text);
  FCadastro.Endereco.Complemento := edtEnderecoComplemento.Text;
  FCadastro.Endereco.Bairro := edtEnderecoBairro.Text;
  FCadastro.Endereco.Cidade := edtEnderecoCidade.Text;
  FCadastro.Endereco.Estado := edtEnderecoEstado.Text;
  FCadastro.Endereco.CEP := edtEnderecoCEP.Text;
end;

procedure TfrmMain.imgFotoClick(Sender: TObject);
begin
  if opdFoto.Execute() then
  begin
    imgFoto.Picture.Assign(nil);
    imgFoto.Picture.LoadFromFile(opdFoto.FileName);
  end;
end;

procedure TfrmMain.lblPerfilClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar(lblPerfil.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.btnSendIndyClick(Sender: TObject);
var
  lFotoStream: TMemoryStream;
begin
  lFotoStream := TMemoryStream.Create;
  try
    imgFoto.Picture.SaveToStream(lFotoStream);
    FSendIdHTTP.Foto := lFotoStream;
    FSendIdHTTP.Cadastro := FCadastro;
    FSendIdHTTP.Perfil := FPerfil;

    FSendIdHTTP.URL := 'http://localhost:9000/form-data';
    FSendIdHTTP.Post;
  finally
    lFotoStream.Free;
  end;
end;

procedure TfrmMain.btnSendNetHTTPClientClick(Sender: TObject);
var
  lFotoStream: TMemoryStream;
begin
  lFotoStream := TMemoryStream.Create;
  try
    imgFoto.Picture.SaveToStream(lFotoStream);
    FSendNetHTTPClient.Foto := lFotoStream;
    FSendNetHTTPClient.Cadastro := FCadastro;
    FSendNetHTTPClient.Perfil := FPerfil;

    FSendNetHTTPClient.URL := 'http://localhost:9000/form-data';
    FSendNetHTTPClient.Post;
  finally
    lFotoStream.Free;
  end;
end;

procedure TfrmMain.btnSendRESTClientClick(Sender: TObject);
var
  lFotoStream: TMemoryStream;
begin
  lFotoStream := TMemoryStream.Create;
  try
    imgFoto.Picture.SaveToStream(lFotoStream);
    FSendRESTClient.Foto := lFotoStream;
    FSendRESTClient.Cadastro := FCadastro;
    FSendRESTClient.Perfil := FPerfil;

    FSendRESTClient.URL := 'http://localhost:9000/form-data';
    FSendRESTClient.Post;
  finally
    lFotoStream.Free;
  end;
end;

procedure TfrmMain.btnVisualizarCadastroClick(Sender: TObject);
begin
  ShowMessage(FCadastro.ToString + sLineBreak + sLineBreak + FCadastro.Endereco.ToString);
end;

procedure TfrmMain.dtDataNascimentoChange(Sender: TObject);
begin
  FCadastro.DataNascimento := dtDataNascimento.Date;
end;

procedure TfrmMain.edtEnderecoBairroChange(Sender: TObject);
begin
  FCadastro.Endereco.Bairro := edtEnderecoBairro.Text;
end;

procedure TfrmMain.edtEnderecoCEPChange(Sender: TObject);
begin
  FCadastro.Endereco.CEP := edtEnderecoCEP.Text;
end;

procedure TfrmMain.edtEnderecoCidadeChange(Sender: TObject);
begin
  FCadastro.Endereco.Cidade := edtEnderecoCidade.Text;
end;

procedure TfrmMain.edtEnderecoComplementoChange(Sender: TObject);
begin
  FCadastro.Endereco.Complemento := edtEnderecoComplemento.Text;
end;

procedure TfrmMain.edtEnderecoEstadoChange(Sender: TObject);
begin
  FCadastro.Endereco.Estado := edtEnderecoEstado.Text;
end;

procedure TfrmMain.edtEnderecoLogradouroChange(Sender: TObject);
begin
  FCadastro.Endereco.Endereco := edtEnderecoLogradouro.Text;
end;

procedure TfrmMain.edtEnderecoNumeroChange(Sender: TObject);
begin
  FCadastro.Endereco.Numero := StrToInt(edtEnderecoNumero.Text);
end;

procedure TfrmMain.edtGithubChange(Sender: TObject);
begin
  FCadastro.Github := edtGithub.Text;
end;

procedure TfrmMain.edtNomeChange(Sender: TObject);
begin
  FCadastro.Nome := edtNome.Text;
end;

procedure TfrmMain.edtSobrenomeChange(Sender: TObject);
begin
  FCadastro.Sobrenome := edtSobrenome.Text;
end;

procedure TfrmMain.medtCelularChange(Sender: TObject);
begin
  FCadastro.Celular := medtCelular.Text;
end;

end.
