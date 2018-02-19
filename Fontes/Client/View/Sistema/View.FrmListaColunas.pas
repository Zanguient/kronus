unit View.FrmListaColunas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Data.SqlExpr;

type
  TFrmListaColunas = class(TForm)
    Panel1: TPanel;
    edtvalor: TLabeledEdit;
    JvDBGrid1: TJvDBGrid;
    pnl1: TPanel;
    btn1: TBitBtn;
    btnCancelar: TBitBtn;
    mr1: TSqlServerMethod;
    dsColunas: TDataSource;
    cdsColunas: TClientDataSet;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmListaColunas: TFrmListaColunas;

implementation

{$R *.dfm}

uses uDM;

procedure TFrmListaColunas.FormShow(Sender: TObject);
begin
  mr1.ParamByName('TableName').AsString := 'sys_campo';
  mr1.ParamByName('FieldId').AsString := 'nome_campo';
  mr1.ParamByName('FieldDisplay').AsString := 'app_titulo';
  mr1.ParamByName('FieldDisplay').AsString := 'app_titulo';
  mr1.ParamByName('Operador').AsString := '=';

  if SELF.Tag = 1 then
  begin
    mr1.ParamByName('ValorRestricao').AsString := self.Hint+';1';
    mr1.ParamByName('FieldRestricao').AsString := 'nome_tabela;chave_primaria';
  end
  else
  begin
    mr1.ParamByName('ValorRestricao').AsString := self.Hint;
    mr1.ParamByName('FieldRestricao').AsString := 'nome_tabela';
  end;

  mr1.ParamByName('FieldOrderBy').AsString:='';
  mr1.ExecuteMethod;
  cdsColunas.Open;
end;

end.
