unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Buttons;

type
  TfrmMain = class(TForm)
    pnlMain: TGridPanel;
    pnlConsoleHeader: TPanel;
    bvlConsoleHeader: TBevel;
    pnlConsoleHeaderTitle: TPanel;
    pnlIISHeader: TPanel;
    bvlIISHeader: TBevel;
    pnlIISHeaderTitle: TPanel;
    pnlDivisionHeader: TPanel;
    pnlConsoleHeaderMain: TPanel;
    Panel2: TPanel;
    pnlIISHeaderMain: TPanel;
    pnlConsoleOptions: TPanel;
    bvlConsoleOptions: TBevel;
    speConsoleQuantidadeRequisicao: TSpinEdit;
    Label1: TLabel;
    btnConsoleExecutar: TBitBtn;
    mmoConsoleLog: TMemo;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    speIISQuantidadeRequisicao: TSpinEdit;
    btnIISExecutar: TBitBtn;
    mmoIISLog: TMemo;
    procedure btnConsoleExecutarClick(Sender: TObject);
    procedure btnIISExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.Threading, System.JSON, Utils;

{$R *.dfm}

procedure TfrmMain.btnConsoleExecutarClick(Sender: TObject);
var
  lTask: ITask;
begin
  mmoConsoleLog.Clear;

  lTask := TTask.Create(
  procedure
  begin
    Application.ProcessMessages;

    try
      btnConsoleExecutar.Enabled := False;

      TParallel.&For(1, speConsoleQuantidadeRequisicao.Value,
      procedure(pIndex: Integer)
      var
        lText: string;
        lStatusCode: Integer;
      procedure Log(const pTexto: string);
      begin
        TThread.Queue(TThread.Current,
        procedure
        var
          lJsonObject: TJSONObject;
          lTexto: string;
        begin
          lJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pTexto), 0) as TJSONObject;
          try
            if lJsonObject.TryGetValue('execute_time', lTexto) then
              lTexto := Format('%.3d - Tempo de Consulta no Banco de Dados no servidor: %s', [pIndex, lTexto])
            else
              if lJsonObject.TryGetValue('error', lTexto) then
                lTexto := Format('%.3d - Erro: %s', [pIndex, lTexto])
              else
                lTexto := Format('%.3d - Erro geral: %s', [pIndex, pTexto]);

            mmoConsoleLog.Lines.BeginUpdate;
            try
              mmoConsoleLog.Lines.Insert(0, lTexto);
            finally
              mmoConsoleLog.Lines.EndUpdate;
            end;
          finally
            lJsonObject.Free;
          end;
        end);
      end;

      begin

        //REQUEST
        ExecuteGET('http://localhost:9000/select', lText, lStatusCode);

        Log(lText);
      end);

    finally
      btnConsoleExecutar.Enabled := True;
    end;
  end);
  lTask.Start;
end;

procedure TfrmMain.btnIISExecutarClick(Sender: TObject);
var
  lTask: ITask;
begin
  mmoIISLog.Clear;

  lTask := TTask.Create(
  procedure
  begin
    Application.ProcessMessages;

    try
      btnIISExecutar.Enabled := False;

      TParallel.&For(1, speIISQuantidadeRequisicao.Value,
      procedure(pIndex: Integer)
      var
        lText: string;
        lStatusCode: Integer;
      procedure Log(const pTexto: string);
      begin
        TThread.Queue(TThread.Current,
        procedure
        var
          lJsonObject: TJSONObject;
          lTexto: string;
        begin
          lJsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(pTexto), 0) as TJSONObject;
          try
            if lJsonObject.TryGetValue('execute_time', lTexto) then
              lTexto := Format('%.3d - Tempo de Consulta no Banco de Dados no servidor: %s', [pIndex, lTexto])
            else
              if lJsonObject.TryGetValue('error', lTexto) then
                lTexto := Format('%.3d - Erro: %s', [pIndex, lTexto])
              else
                lTexto := Format('%.3d - Erro geral: %s', [pIndex, pTexto]);

            mmoIISLog.Lines.BeginUpdate;
            try
              mmoIISLog.Lines.Insert(0, lTexto);
            finally
              mmoIISLog.Lines.EndUpdate;
            end;
          finally
            lJsonObject.Free;
          end;
        end);
      end;

      begin

        //REQUEST
        ExecuteGET('http://localhost/site/PoolConexaoISAPI.dll/select/', lText, lStatusCode);

        Log(lText);
      end);
    finally
      btnIISExecutar.Enabled := True;
    end;

  end);
  lTask.Start;
  Application.ProcessMessages;
end;

end.
