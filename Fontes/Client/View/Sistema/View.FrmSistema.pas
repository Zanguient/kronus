unit View.FrmSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  uDM, Data.DB, Datasnap.DBClient, JvExDBGrids, JvDBGrid, Vcl.StdCtrls,
  Vcl.Buttons, View.FrmCadastroTabela, Vcl.ComCtrls, JvDBGridFooter;

type
  TFrmSistema = class(TForm)
    pnlBotoes: TPanel;
    grdTabelas: TJvDBGrid;
    dsSysTable: TDataSource;
    cdsSysTable: TClientDataSet;
    btnNovo: TBitBtn;
    btnEditar: TBitBtn;
    cdsSysTablenome_tabela: TStringField;
    cdsSysTabletitulo: TStringField;
    cdsSysTableorder_by: TStringField;
    cdsSysTablefoco_inicial: TStringField;
    cdsSysTablecompartilhada: TBooleanField;
    JvDBGridFooter1: TJvDBGridFooter;
    cdsSysTablepaginacao: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSistema: TFrmSistema;

implementation

{$R *.dfm}

procedure TFrmSistema.btnEditarClick(Sender: TObject);
begin
  if cdsSysTable.RecordCount > 0 then
  begin
    try
      Application.CreateForm(TFrmCadastroTabela, FrmCadastroTabela);
      with FrmCadastroTabela do
      begin
        cdsTabela.Open;
        cdsTabela.Filter := 'nome_tabela = ' + QuotedStr(cdsSysTable.FieldByName('nome_tabela').AsString);
        cdsTabela.Filtered := True;
        dbedtnome_tabela.Enabled := False;
        cdsColunas.Open;
        cdsTabelaDetalhe.Open;
        cdsTabela.Edit;
        FrmCadastroTabela.Tag := 0;
        tsbanco.Enabled := False;
        ShowModal;
      end;
    finally
      FreeAndNil(FrmCadastroTabela);
      cdsSysTable.Refresh;
    end;
  end;
end;

procedure TFrmSistema.btnNovoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmCadastroTabela, FrmCadastroTabela);
    with FrmCadastroTabela do
    begin
      cdsTabela.Open;
      cdsTabela.Insert;
      cdsTabelacompartilhada.AsBoolean := False;
      Tag := 1;
      cdsColunas.Open;
      cdsTabelaDetalhe.Open;
      ShowModal;
    end;
  finally
    cdsSysTable.Refresh;
    FreeAndNil(FrmCadastroTabela);
  end;
end;

procedure TFrmSistema.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.cdsDicionario.Refresh;
end;

procedure TFrmSistema.FormShow(Sender: TObject);
begin
  cdsSysTable.Open;
end;

end.
