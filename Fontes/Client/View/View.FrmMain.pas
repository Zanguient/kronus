unit View.FrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.FrmSistema, Vcl.Menus,
  View.FrmConsulta, uDM, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Datasnap.DBClient,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Ribbon,
  Vcl.RibbonLunaStyleActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ScreenTips, Vcl.ImgList,
  JvComponentBase, JvAppStorage, JvAppIniStorage, JvMail, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Sistema1: TMenuItem;
    abelasdosistema1: TMenuItem;
    Sair1: TMenuItem;
    Cadastro1: TMenuItem;
    Unidade1: TMenuItem;
    Marcas1: TMenuItem;
    Produtos1: TMenuItem;
    Ncms1: TMenuItem;
    SqlServerMethod1: TSqlServerMethod;
    Gruposdeproduto1: TMenuItem;
    Clientes1: TMenuItem;
    Pases1: TMenuItem;
    Estados1: TMenuItem;
    Municpios1: TMenuItem;
    CompProduto1: TMenuItem;
    GrupodeUsurios1: TMenuItem;
    Usurios1: TMenuItem;
    Menus1: TMenuItem;
    procedure abelasdosistema1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actChamadaExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.abelasdosistema1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmSistema, FrmSistema);
    FrmSistema.ShowModal;
  finally
    FreeAndNil(FrmSistema);
  end;
end;

procedure TFrmMain.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.actChamadaExecute(Sender: TObject);
begin
  if (Sender as TAction).Hint.Trim = '' then
    raise Exception.Create('Faltando para da tabela.');

  try
    Application.CreateForm(TFrmConsulta, FrmConsulta);
    FrmConsulta.Hint := (Sender as TAction).Hint;
    FrmConsulta.ShowModal;
  finally
    FreeAndNil(FrmConsulta);
  end;
end;


procedure TFrmMain.FormShow(Sender: TObject);
begin
  SqlServerMethod1.Params[0].AsString := '';
  SqlServerMethod1.ExecuteMethod;
  DM.cdsDicionario.Open;
end;

procedure TFrmMain.MenuItemClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Hint.Trim = '' then
    raise Exception.Create('Faltando para da tabela.');
  try
    Application.CreateForm(TFrmConsulta, FrmConsulta);
    FrmConsulta.Hint := (Sender as TMenuItem).Hint;
    FrmConsulta.ShowModal;
  finally
    FreeAndNil(FrmConsulta);
  end;
end;

end.
