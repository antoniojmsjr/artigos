unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Horse,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, frxClass, Vcl.Mask, Vcl.ComCtrls, Vcl.Imaging.jpeg;

type
  TfrmMain = class(TForm)
    pnlLeft: TPanel;
    lblPort: TLabel;
    btnStop: TBitBtn;
    btnStart: TBitBtn;
    edtPort: TEdit;
    mmoLog: TMemo;
    bvlDivisao: TBevel;
    pnlClient: TPanel;
    imgFoto: TImage;
    lblNome: TLabel;
    lblSobrenome: TLabel;
    lblDataNascimento: TLabel;
    lblCelular: TLabel;
    lblGithub: TLabel;
    lblPerfilTitulo: TLabel;
    lblPerfil: TLabel;
    edtNome: TEdit;
    edtSobrenome: TEdit;
    dtDataNascimento: TDateTimePicker;
    medtCelular: TMaskEdit;
    edtGithub: TEdit;
    grpEndereco: TGroupBox;
    lblEnderecoLogradouro: TLabel;
    lblEnderecoNumero: TLabel;
    lblEnderecoComplemento: TLabel;
    lblEnderecoBairro: TLabel;
    lblEnderecoCidade: TLabel;
    lblEnderecoEstado: TLabel;
    lblEnderecoCEP: TLabel;
    edtEnderecoLogradouro: TEdit;
    edtEnderecoNumero: TEdit;
    edtEnderecoComplemento: TEdit;
    edtEnderecoBairro: TEdit;
    edtEnderecoCidade: TEdit;
    edtEnderecoEstado: TEdit;
    edtEnderecoCEP: TEdit;
    blhMain: TBalloonHint;
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblPerfilClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Status;
    procedure Start;
    procedure Stop;
    procedure Log(const pMessage: string);
    procedure Form(pReq: THorseRequest; pRes: THorseResponse; pNext: TNextProc);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Winapi.ShellApi, System.JSON, System.Win.ComObj, System.StrUtils, REST.JSON;

{$R *.dfm}

{ TfrmMain }

procedure ShowImageFromStream(pImage: TImage; pData: TStream);
var
  JPEGImage: TJPEGImage;
begin
  pData.Position := 0;
  JPEGImage := TJPEGImage.Create;
  try
    JPEGImage.LoadFromStream(pData);
    pImage.Picture.Assign(JPEGImage);
  finally
    JPEGImage.Free;
  end;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  Start;
  Status;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  Stop;
  Status;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if THorse.IsRunning then
    Stop;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  btnStart.Click;
end;

procedure TfrmMain.lblPerfilClick(Sender: TObject);
begin
  if (lblPerfil.Caption <> EmptyStr) then
    ShellExecute(0, 'open', PChar(lblPerfil.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.Log(const pMessage: string);
begin
  TThread.Queue(nil, procedure
  begin
    mmoLog.Lines.Add(Format('%s= %s', [FormatDateTime('[hh:nn:ss.zzz]', Now), pMessage]));
  end);
end;

procedure TfrmMain.Start;
begin
  THorse.MaxConnections := 100;

  THorse.Get('ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong')
    end);

  THorse.Post('form-data/', Form);

  THorse.Listen(StrToInt(edtPort.Text));
end;

procedure TfrmMain.Status;
begin
  btnStop.Enabled := THorse.IsRunning;
  btnStart.Enabled := not THorse.IsRunning;
  edtPort.Enabled := not THorse.IsRunning;
end;

procedure TfrmMain.Stop;
begin
  THorse.StopListen;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dtDataNascimento.DateTime := 0;
end;

procedure TfrmMain.Form(pReq: THorseRequest; pRes: THorseResponse;
  pNext: TNextProc);
var
  lJSONCadastro: TJSONObject;
  lFilePerfil: TMemoryStream;
  lContentCadastro: string;
begin
  //COMPONENT
  if pReq.ContentFields.ContainsKey('component') then
    Log(pReq.ContentFields.Field('component').AsString);

  //FOTO
  if (pReq.ContentFields.Field('foto').AsStream <> nil) then
  begin
    imgFoto.Picture.Assign(nil);
    imgFoto.Picture.LoadFromStream(pReq.ContentFields.Field('foto').AsStream);
  end;

  //CADASTRO
  if pReq.ContentFields.ContainsKey('cadastro') then
  begin
    lContentCadastro := ReplaceStr(pReq.ContentFields.Field('cadastro').AsString, #$D#$A, '');
    lJSONCadastro := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lContentCadastro), 0) as TJSONObject;
//    Log(lJSONCadastro.ToString);

    try
      edtNome.Text := lJSONCadastro.GetValue<string>('nome');
      edtSobrenome.Text := lJSONCadastro.GetValue<string>('sobrenome');
      dtDataNascimento.DateTime := lJSONCadastro.GetValue<TDateTime>('dataNascimento');
      medtCelular.Text := lJSONCadastro.GetValue<string>('celular');
      edtGithub.Text := lJSONCadastro.GetValue<string>('github');

      //ENDEREÇO
      edtEnderecoLogradouro.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('endereco');
      edtEnderecoNumero.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('numero');
      edtEnderecoComplemento.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('complemento');
      edtEnderecoBairro.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('bairro');
      edtEnderecoCidade.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('cidade');
      edtEnderecoEstado.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('estado');
      edtEnderecoCEP.Text := lJSONCadastro.GetValue('endereco').GetValue<string>('cEP');
    finally
      lJSONCadastro.Free;
    end;
  end;

  //PERFIL
  if (pReq.ContentFields.Field('perfil').AsStream <> nil) then
  begin
    lFilePerfil := TMemoryStream.Create;
    try
      lFilePerfil.LoadFromStream(pReq.ContentFields.Field('perfil').AsStream);
      lFilePerfil.Position := 0;
      lFilePerfil.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Github.pdf');
      lblPerfil.Caption := Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Github.pdf']);
    finally
      lFilePerfil.Free;
    end;
  end;

  pRes.Send('Ok').Status(200);
end;

end.
