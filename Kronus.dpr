program Kronus;

uses
  Vcl.Forms,
  View.ConfiguracaoConexao in 'Fontes\Client\View\View.ConfiguracaoConexao.pas' {Form1},
  uDM in 'Fontes\Client\DataModules\uDM.pas' {DM: TDataModule},
  View.FrmConsulta in 'Fontes\Client\View\View.FrmConsulta.pas' {FrmConsulta},
  View.FrmMain in 'Fontes\Client\View\View.FrmMain.pas' {FrmMain},
  Vcl.Themes,
  Vcl.Styles,
  Sys.Functions in 'Fontes\Client\Functions\Sys.Functions.pas',
  View.FrmCadastro in 'Fontes\Client\View\View.FrmCadastro.pas' {FrmCadastro},
  View.FrmCadastroTabela in 'Fontes\Client\View\Sistema\View.FrmCadastroTabela.pas' {FrmCadastroTabela},
  View.FrmSistema in 'Fontes\Client\View\Sistema\View.FrmSistema.pas' {FrmSistema},
  View.FrmListaTabelas in 'Fontes\Client\View\Sistema\View.FrmListaTabelas.pas' {FrmListaTabelas},
  View.FrmListaColunas in 'Fontes\Client\View\Sistema\View.FrmListaColunas.pas' {FrmListaColunas},
  PMensagem in 'Fontes\Client\View\PMensagem.pas' {FrmMensagem},
  Data.DBConsts in 'Fontes\Client\Units\Data.DBConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMensagem, FrmMensagem);
  Application.Run;
end.
