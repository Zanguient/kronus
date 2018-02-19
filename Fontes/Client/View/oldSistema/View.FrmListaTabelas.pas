unit View.FrmListaTabelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.DBClient;

type
  TFrmListaTabelas = class(TForm)
    pnl1: TPanel;
    Panel1: TPanel;
    JvDBGrid1: TJvDBGrid;
    btn1: TBitBtn;
    btnCancelar: TBitBtn;
    edtvalor: TLabeledEdit;
    mr1: TSqlServerMethod;
    dsTabelas: TDataSource;
    cdsTabelas: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure edtvalorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListaTabelas: TFrmListaTabelas;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmListaTabelas.edtvalorChange(Sender: TObject);
begin
  if Trim(edtvalor.Text) = '' then
    cdsTabelas.Filtered := False
  else
  begin
    cdsTabelas.Filter := 'nome_tabela like ' + QuotedStr('%'+edtvalor.Text+'%');
    cdsTabelas.Filtered := True;
  end;
end;

procedure TFrmListaTabelas.FormShow(Sender: TObject);
begin
  mr1.ParamByName('TableName').AsString := 'sys_tabela';
  mr1.ParamByName('FieldId').AsString := 'nome_tabela';
  mr1.ParamByName('FieldDisplay').AsString := 'titulo';
  mr1.ParamByName('Operador').AsString := '<>';
  mr1.ParamByName('FieldRestricao').AsString := 'nome_tabela';
  mr1.ParamByName('ValorRestricao').AsString := Self.Hint;
  mr1.ParamByName('FieldOrderBy').AsString:='';
  mr1.ExecuteMethod;

  cdsTabelas.Open;

end;

end.
