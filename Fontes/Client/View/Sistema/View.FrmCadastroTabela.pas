unit View.FrmCadastroTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, uDM, Vcl.DBCtrls,
  Vcl.Mask, Data.DB, Datasnap.DBClient, JvDBCheckBox, JvExMask, JvToolEdit,
  JvDBLookup, JvDBLookupComboEdit, Data.FMTBcd, Data.SqlExpr, JvExControls,
  JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.DBActns, System.Actions,
  Vcl.ActnList;

type
  TFrmCadastroTabela = class(TForm)
    pnlBotoes: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    pgcTabela: TPageControl;
    tsPrincipal: TTabSheet;
    grpTabela: TGroupBox;
    cdsTabela: TClientDataSet;
    dsTabela: TDataSource;
    cdsTabelanome_tabela: TStringField;
    cdsTabelatitulo: TStringField;
    cdsTabelaorder_by: TStringField;
    cdsTabelafoco_inicial: TStringField;
    cdsTabelacompartilhada: TBooleanField;
    Label1: TLabel;
    dbedtnome_tabela: TDBEdit;
    Label2: TLabel;
    dbedttitulo: TDBEdit;
    Label3: TLabel;
    dbedtorder_by: TDBEdit;
    Label4: TLabel;
    dbedtfoco_inicial: TDBEdit;
    cdsColunas: TClientDataSet;
    dsColunas: TDataSource;
    chkcompartilhada: TJvDBCheckBox;
    cdsColunasnome_tabela: TStringField;
    cdsColunasnome_campo: TStringField;
    cdsColunasauto_incremento: TBooleanField;
    cdsColunaschave_primaria: TBooleanField;
    cdsColunastipo_campo: TStringField;
    cdsColunastamanho_campo: TIntegerField;
    cdsColunasprecisao: TIntegerField;
    cdsColunasaceita_nulo: TBooleanField;
    cdsColunasvalor_padrao: TStringField;
    cdsColunasordem: TIntegerField;
    cdsColunasvirtual: TBooleanField;
    cdsColunasapp_titulo: TStringField;
    cdsColunasapp_titulo_largura: TIntegerField;
    cdsColunasapp_titulo_alinhamento: TIntegerField;
    cdsColunasapp_charcase: TIntegerField;
    cdsColunasapp_somenteleitura: TBooleanField;
    cdsColunasapp_obrigatorio: TBooleanField;
    cdsColunasapp_formato: TStringField;
    cdsColunasapp_pesquisavel: TBooleanField;
    cdsColunasapp_visivel_consulta: TBooleanField;
    cdsColunasapp_visivel_formulario: TBooleanField;
    cdsColunasapp_lista_tipo: TStringField;
    cdsColunasapp_lista_tabela: TStringField;
    cdsColunasapp_lista_campo_id: TStringField;
    cdsColunasapp_lista_campo_display: TStringField;
    cdsColunasapp_busca_tabela: TStringField;
    cdsColunasapp_busca_campo: TStringField;
    cdsColunasapp_ajax_tabela: TStringField;
    cdsColunasapp_ajax_campo_id: TStringField;
    cdsColunasapp_ajax_campo_link: TStringField;
    cdsColunasguia_nome: TStringField;
    cdsColunasapp_bloq_insert: TBooleanField;
    cdsColunasapp_bloq_edit: TBooleanField;
    cdsTabelapaginacao: TIntegerField;
    lbl21: TLabel;
    dbedtpaginacao: TDBEdit;
    tsColunas: TTabSheet;
    pgcColunas: TPageControl;
    tsCampos: TTabSheet;
    grpColunas: TGroupBox;
    grdColunas: TJvDBGrid;
    tsbanco: TTabSheet;
    Panel1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    dbedtnome_campo: TDBEdit;
    dbedttamanho_campo: TDBEdit;
    dbedttipo_campo: TJvDBComboBox;
    dbedtprecisao: TDBEdit;
    dbchkaceita_nulo: TDBCheckBox;
    dbedtordem: TDBEdit;
    dbchkvirtual: TDBCheckBox;
    dbchkauto_incremento: TDBCheckBox;
    tsApp: TTabSheet;
    pnl1: TPanel;
    dbedtvalor_padrao: TDBEdit;
    lbl5: TLabel;
    dbedtapp_formato: TDBEdit;
    dbedtapp_charcase: TJvDBComboBox;
    lbl10: TLabel;
    lbl9: TLabel;
    dbedtapp_titulo_largura: TDBEdit;
    lbl8: TLabel;
    lbl7: TLabel;
    dbedtapp_titulo: TDBEdit;
    dbchkapp_obrigatorio: TDBCheckBox;
    dbchkapp_visivel_consulta: TDBCheckBox;
    dbchkapp_visivel_formulario: TDBCheckBox;
    dbchkapp_pesquisavel: TDBCheckBox;
    dbchkapp_somenteleitura: TDBCheckBox;
    dbchkapp_bloq_insert: TDBCheckBox;
    dbchkapp_bloq_edit: TDBCheckBox;
    dbedtapp_titulo_alinhamento: TJvDBComboBox;
    lbl11: TLabel;
    tsLookup: TTabSheet;
    Panel2: TPanel;
    dbedtapp_lista_campo_display: TDBEdit;
    lbl15: TLabel;
    lbl14: TLabel;
    dbedtapp_lista_campo_id: TDBEdit;
    btnPesquisaListaCampoID: TBitBtn;
    btnPesquisaListaCampoDisplay: TBitBtn;
    btnListaLimparCampoDisplay: TBitBtn;
    btnListaLimparCampoID: TBitBtn;
    btnListaLimparTabela: TBitBtn;
    btnPesquisaListaTabela: TBitBtn;
    dbedtapp_lista_tabela: TDBEdit;
    lbl13: TLabel;
    lbl12: TLabel;
    dbedtapp_lista_tipo: TJvDBComboBox;
    tsSearch: TTabSheet;
    pnl2: TPanel;
    lbl17: TLabel;
    dbedtapp_busca_campo: TDBEdit;
    btnBuscaColuna: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    btnBustaTabela: TBitBtn;
    dbedtapp_busca_tabela: TDBEdit;
    lbl16: TLabel;
    tsAjaxColuna: TTabSheet;
    pnl3: TPanel;
    lbl20: TLabel;
    dbedtapp_ajax_campo_link: TDBEdit;
    BitBtn8: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn5: TBitBtn;
    dbedtapp_ajax_campo_id: TDBEdit;
    lbl19: TLabel;
    lbl18: TLabel;
    dbedtapp_ajax_tabela: TDBEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn7: TBitBtn;
    dbchkchave_primaria: TDBCheckBox;
    mr1: TSqlServerMethod;
    pnlColunas: TPanel;
    btnEditarColuna: TBitBtn;
    btnRemoverColuna: TBitBtn;
    btnAdicionarColuna: TBitBtn;
    btnSalvarColuna: TBitBtn;
    btnCancelarColuna: TBitBtn;
    lbl22: TLabel;
    dbedtguia_nome: TDBEdit;
    ActionList1: TActionList;
    DatasetPost1: TDataSetPost;
    DatasetInsert1: TDataSetInsert;
    DatasetDelete1: TDataSetDelete;
    DatasetEdit1: TDataSetEdit;
    DatasetCancel1: TDataSetCancel;
    tsRelacionamento: TTabSheet;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCampoPai: TJvComboEdit;
    edtTabelaFilha: TJvComboEdit;
    edtCampoFilho: TJvComboEdit;
    edtNomeGuia: TLabeledEdit;
    edtOrdem: TLabeledEdit;
    btnAddRelac: TBitBtn;
    btnRemRelac: TBitBtn;
    Panel4: TPanel;
    jvdbgrd1: TJvDBGrid;
    cdsTabelaDetalhe: TClientDataSet;
    cdsTabelaDetalheid: TAutoIncField;
    cdsTabelaDetalhenome_tabela: TStringField;
    cdsTabelaDetalhenome_campo: TStringField;
    cdsTabelaDetalhetabela_f: TStringField;
    cdsTabelaDetalhecampo_f: TStringField;
    cdsTabelaDetalheguia_nome: TStringField;
    cdsTabelaDetalheguia_ordem: TIntegerField;
    dsTabelaDetalhe: TDataSource;
    mr2: TSqlServerMethod;
    btnEditRelac: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure cdsTabelaAfterPost(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure cdsColunasAfterPost(DataSet: TDataSet);
    procedure btnRemoverColunaClick(Sender: TObject);
    procedure btnAdicionarColunaClick(Sender: TObject);
    procedure btnBustaTabelaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnBuscaColunaClick(Sender: TObject);
    procedure btnPesquisaListaTabelaClick(Sender: TObject);
    procedure btnPesquisaListaCampoIDClick(Sender: TObject);
    procedure btnPesquisaListaCampoDisplayClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure btnListaLimparTabelaClick(Sender: TObject);
    procedure btnListaLimparCampoIDClick(Sender: TObject);
    procedure btnListaLimparCampoDisplayClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure cdsColunasAfterCancel(DataSet: TDataSet);
    procedure cdsColunasAfterEdit(DataSet: TDataSet);
    procedure cdsColunasapp_lista_tipoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure dbedtapp_lista_tipoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsColunasAfterInsert(DataSet: TDataSet);
    procedure cdsColunasBeforeInsert(DataSet: TDataSet);
    procedure btnAddRelacClick(Sender: TObject);
    procedure btnRemRelacClick(Sender: TObject);
    procedure edtCampoPaiButtonClick(Sender: TObject);
    procedure edtTabelaFilhaButtonClick(Sender: TObject);
    procedure edtCampoFilhoButtonClick(Sender: TObject);
    procedure btnEditRelacClick(Sender: TObject);
  private
    procedure ControleLista(value : string);
    procedure BtnColunaInsEdit;
    procedure BtnColunaUpdate;
    procedure limparCamposRelac;

  private
    ViOrdem: Integer;
  public
    { Public declarations }
  end;

var
  FrmCadastroTabela: TFrmCadastroTabela;

implementation

{$R *.dfm}

uses View.FrmListaTabelas, View.FrmListaColunas;


procedure TFrmCadastroTabela.BitBtn1Click(Sender: TObject);
begin
  cdsColunas.FieldByName('app_busca_tabela').Clear;
end;

procedure TFrmCadastroTabela.BitBtn2Click(Sender: TObject);
begin
  cdsColunas.FieldByName('app_busca_campo').Clear;
end;

procedure TFrmCadastroTabela.BitBtn3Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmListaTabelas,FrmListaTabelas);
    FrmListaTabelas.Hint := cdsColunas.FieldByName('nome_tabela').AsString;
    FrmListaTabelas.ShowModal;
  finally
    if FrmListaTabelas.ModalResult = mrOk then
    begin
      cdsColunas.Edit;
      cdsColunas.FieldByName('app_ajax_tabela').AsString := FrmListaTabelas.cdsTabelas.FieldByName('nome_tabela').AsString;
    end;
    FreeAndNil(FrmListaTabelas);
  end;
end;

procedure TFrmCadastroTabela.BitBtn4Click(Sender: TObject);
begin
  cdsColunas.FieldByName('app_ajax_tabela').Clear;
end;

procedure TFrmCadastroTabela.BitBtn5Click(Sender: TObject);
begin
  if cdsColunas.FieldByName('app_ajax_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsColunas.FieldByName('app_ajax_tabela').AsString;
      FrmListaColunas.Tag := 1;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        cdsColunas.Edit;
        cdsColunas.FieldByName('app_ajax_campo_id').AsString := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end;
end;

procedure TFrmCadastroTabela.BitBtn6Click(Sender: TObject);
begin
  cdsColunas.FieldByName('app_ajax_campo_id').Clear;
end;

procedure TFrmCadastroTabela.BitBtn7Click(Sender: TObject);
begin
  if cdsColunas.FieldByName('app_ajax_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsColunas.FieldByName('app_ajax_tabela').AsString;
      FrmListaColunas.Tag := 0;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        cdsColunas.Edit;
        cdsColunas.FieldByName('app_ajax_campo_link').AsString := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end;
end;

procedure TFrmCadastroTabela.BitBtn8Click(Sender: TObject);
begin
  cdsColunas.FieldByName('app_ajax_campo_link').Clear;
end;

procedure TFrmCadastroTabela.btnPesquisaListaTabelaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmListaTabelas,FrmListaTabelas);
    FrmListaTabelas.Hint := cdsColunas.FieldByName('nome_tabela').AsString;
    FrmListaTabelas.ShowModal;
  finally
    if FrmListaTabelas.ModalResult = mrOk then
    begin
      cdsColunas.Edit;
      cdsColunas.FieldByName('app_lista_tabela').AsString := FrmListaTabelas.cdsTabelas.FieldByName('nome_tabela').AsString;
    end;
    FreeAndNil(FrmListaTabelas);
  end;
end;

procedure TFrmCadastroTabela.btnPesquisaListaCampoIDClick(Sender: TObject);
begin
  if cdsColunas.FieldByName('app_lista_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsColunas.FieldByName('app_lista_tabela').AsString;
      FrmListaColunas.Tag := 1;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        cdsColunas.Edit;
        cdsColunas.FieldByName('app_lista_campo_id').AsString := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end;
end;

procedure TFrmCadastroTabela.btnPesquisaListaCampoDisplayClick(Sender: TObject);
begin
  if cdsColunas.FieldByName('app_lista_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsColunas.FieldByName('app_lista_tabela').AsString;
      FrmListaColunas.Tag := 0;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        cdsColunas.Edit;
        cdsColunas.FieldByName('app_lista_campo_display').AsString := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end;

end;

procedure TFrmCadastroTabela.btnAddRelacClick(Sender: TObject);
begin

  if Trim( edtCampoPai.Text) = '' then
  begin
    edtCampoPai.SetFocus;
    raise Exception.Create('Informe o campo primário.');
  end;

  if Trim( edtTabelaFilha.Text) = '' then
  begin
    edtTabelaFilha.SetFocus;
    raise Exception.Create('Informe a tabela relacionada.');
  end;

  if Trim( edtCampoFilho.Text) = '' then
  begin
    edtCampoFilho.SetFocus;
    raise Exception.Create('Informe o campo relacionado.');
  end;

  if Trim( edtNomeGuia.Text) = '' then
  begin
    edtNomeGuia.SetFocus;
    raise Exception.Create('Informe o nome da guia.');
  end;

  with cdsTabelaDetalhe do
  begin
    Append;
    FieldByName('nome_tabela').AsString := cdsTabelanome_tabela.AsString;
    FieldByName('nome_campo').AsString := Trim(edtCampoPai.Text);
    FieldByName('tabela_f').AsString := Trim(edtTabelaFilha.Text);
    FieldByName('campo_f').AsString := Trim(edtCampoFilho.Text);
    FieldByName('guia_nome').AsString := Trim(edtNomeGuia.Text);
    FieldByName('guia_ordem').AsInteger := StrToInt(edtOrdem.Text);
    Post;
  end;
end;

procedure TFrmCadastroTabela.btnAdicionarColunaClick(Sender: TObject);
begin
//var
//  vi: Integer;
//begin
//  vi:=0;
//  if cdsTabelanome_tabela.AsString.Trim = '' then
//    raise Exception.Create('Informe o nome da tabela.');
//
//
//
// // if cdsColunas.RecordCount > 0 then
//  begin
//    if cdsColunas.RecordCount > 0 then
//    begin
//      cdsColunas.Last;
//      vi:= cdsColunasordem.AsInteger+1;
//
//    end
//    else
//      vi := 1;
//
//    cdsColunas.Append;
//    cdsColunasordem.AsInteger := vi;
//    cdsColunasnome_tabela.AsString := cdsTabelanome_tabela.AsString;;
//    cdsColunaschave_primaria.AsBoolean := False;
//    cdsColunastipo_campo.AsString := 'varchar';
//    cdsColunastamanho_campo.AsInteger := 10;
//    cdsColunasauto_incremento.AsBoolean := False;
//    cdsColunasaceita_nulo.AsBoolean := True;
//    cdsColunasvirtual.AsBoolean := False;
//    cdsColunasapp_obrigatorio.AsBoolean := False;
//    cdsColunasapp_visivel_consulta.AsBoolean := True;
//    cdsColunasapp_visivel_formulario.AsBoolean := True;
//    cdsColunasapp_pesquisavel.AsBoolean := False;
//    cdsColunasapp_somenteleitura.AsBoolean := False;
//    cdsColunasapp_bloq_insert.AsBoolean := False;
//    cdsColunasapp_bloq_edit.AsBoolean := False;
//    cdsColunasapp_lista_tipo.AsString := 'NI';
//    cdsColunasapp_titulo_alinhamento.AsInteger := 0;
//    cdsColunasapp_charcase.AsInteger := 0;
//    cdsColunasprecisao.AsInteger := 0;
//    cdsColunasapp_titulo_largura.AsInteger := 100;
//    cdsColunasguia_nome.AsString := 'Principal';
//
//    tsbanco.Enabled := True;
//    pgcColunas.ActivePage := tsbanco;
//    dbedtnome_campo.SetFocus;
//
//  end;
end;

procedure TFrmCadastroTabela.btnBuscaColunaClick(Sender: TObject);
begin
  if cdsColunas.FieldByName('app_busca_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsColunas.FieldByName('app_busca_tabela').AsString;
   //   FrmListaColunas.Tag := 1;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        cdsColunas.Edit;
        cdsColunas.FieldByName('app_busca_campo').AsString := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end;
end;

procedure TFrmCadastroTabela.btnBustaTabelaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmListaTabelas,FrmListaTabelas);
    FrmListaTabelas.Hint := cdsColunas.FieldByName('nome_tabela').AsString;
    FrmListaTabelas.ShowModal;
  finally
    if FrmListaTabelas.ModalResult = mrOk then
    begin
      cdsColunas.Edit;
      cdsColunas.FieldByName('app_busca_tabela').AsString := FrmListaTabelas.cdsTabelas.FieldByName('nome_tabela').AsString;
    end;
    FreeAndNil(FrmListaTabelas);
  end;
end;

procedure TFrmCadastroTabela.btnCancelarClick(Sender: TObject);
begin
  cdsTabela.CancelUpdates;
  Close;
end;

procedure TFrmCadastroTabela.BtnColunaInsEdit;
begin
  btnSalvarColuna.Enabled := True;
  btnCancelarColuna.Enabled := True;
  btnEditarColuna.Enabled := False;
end;

procedure TFrmCadastroTabela.BtnColunaUpdate;
begin
  btnSalvarColuna.Enabled := False;
  btnCancelarColuna.Enabled := False;
  btnEditarColuna.Enabled := True;
  btnAdicionarColuna.Enabled := True;
end;

procedure TFrmCadastroTabela.btnEditRelacClick(Sender: TObject);
begin
//
end;

procedure TFrmCadastroTabela.btnListaLimparCampoDisplayClick(Sender: TObject);
begin
  cdsColunas.FieldByName('app_lista_campo_display').Clear;
end;

procedure TFrmCadastroTabela.btnListaLimparCampoIDClick(Sender: TObject);
begin
  cdsColunas.FieldByName('app_lista_campo_id').Clear;
end;

procedure TFrmCadastroTabela.btnListaLimparTabelaClick(Sender: TObject);
begin
  cdsColunas.FieldByName('app_lista_tabela').Clear;
end;

procedure TFrmCadastroTabela.btnRemoverColunaClick(Sender: TObject);
begin

{todo: Efetuar o drop column no Database}
  if cdsColunas.RecordCount > 0 then
    if MessageDlg('Deseja realmente remover essa coluna?',mtConfirmation,mbYesNo,mrNo) = mrYes then
       cdsColunas.Delete;

end;

procedure TFrmCadastroTabela.btnRemRelacClick(Sender: TObject);
begin
  if cdsTabelaDetalhe.RecordCount>0 then
    if MessageDlg('Deseja realmente remover ?',mtConfirmation,mbYesNo,mrNo) = mrYes then
      cdsTabelaDetalhe.Delete;
end;

procedure TFrmCadastroTabela.btnSalvarClick(Sender: TObject);
var
  sSQL : TStringBuilder;
  sl : TStringList;
  i: Integer;
begin
  i:=0;

  if cdsTabelanome_tabela.AsString.Trim = '' then
    raise Exception.Create('Informe o nome da tabela');

  if cdsColunas.RecordCount = 0 then
    raise Exception.Create('Informe as colunas da tabela');

  try
    if Tag = 1 then //nova tabela
    begin
      sl := TStringList.Create;
      sSQL := TStringBuilder.Create;
      sSQL.Append('CREATE TABLE ' + cdsTabelanome_tabela.AsString).Append(' (');
      cdsColunas.First;

      while not cdsColunas.Eof do
      begin
        if cdsColunaschave_primaria.AsBoolean then
        begin
          if cdsColunasauto_incremento.AsBoolean then
            sSQL.Append(cdsColunasnome_campo.AsString).Append(' ')
              .Append(cdsColunastipo_campo.AsString).Append(' primary key auto_increment,')
          else
            sSQL.Append(cdsColunasnome_campo.AsString).Append(' ')
              .Append(cdsColunastipo_campo.AsString).Append(' ').Append('primary key,');
        end
        else
        begin

          if (cdsColunastipo_campo.AsString = 'decimal') then
          begin
            sSQL.Append(cdsColunasnome_campo.AsString).Append(' ')
              .Append(cdsColunastipo_campo.AsString).Append('(').Append(cdsColunastamanho_campo.AsString)
              .Append(',').Append(cdsColunasprecisao.AsString).Append(')')
              .Append(',');
          end
          else
          if (cdsColunastipo_campo.AsString = 'int') then
          begin
            sSQL.Append(cdsColunasnome_campo.AsString).Append(' ')
              .Append(cdsColunastipo_campo.AsString).Append(',');
          end
          else
          if (cdsColunastipo_campo.AsString = 'varchar') or (cdsColunastipo_campo.AsString = 'char') then
          begin
            if cdsColunasaceita_nulo.AsBoolean then
            begin
              sSQL.Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append('),');
            end
            else
            begin
              sSQL.Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append(')').Append('not null,');
            end;
          end
          else
          if (cdsColunastipo_campo.AsString = 'bit') then
          begin
            sSQL.Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString).Append(',');
          end;
        end;
        cdsColunas.Next;
      end;
      sl.Add(Copy(sSQL.ToString,1,Length(sSQL.ToString)-1) +') ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1');
      mr1.ParamByName('sSQL').AsString := sl.Text;
      mr1.ExecuteMethod;
      if not mr1.ParamByName('ReturnParameter').AsBoolean  then
        ShowMessage('Erro ao criar tabela');
      FreeAndNil(sSQL);
      FreeAndNil(sl);
    end
    else //edicao da tabela
    begin
      //verificar se foi adicionado nova coluna ou removida
      //a principio na sera permitido change da coluna
      sl := TStringList.Create;
      sSQL := TStringBuilder.Create;
      sSQL.Append('ALTER TABLE ').Append(cdsTabelanome_tabela.AsString).Append(' ');
      cdsColunas.First;
      while not cdsColunas.Eof do
      begin
        if cdsColunas.UpdateStatus = usInserted then
        begin
          Inc(i);
          cdsColunas.UpdateCursorPos;
          if (cdsColunastipo_campo.AsString = 'int') then
          begin
            sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ')
              .Append(cdsColunastipo_campo.AsString).Append(',');
          end
          else
          if (cdsColunastipo_campo.AsString = 'decimal')  then
          begin
            if cdsColunasaceita_nulo.AsBoolean then
            begin
              sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append(',').Append(cdsColunasprecisao.AsString)
                .Append('),');
            end
            else
            begin
              sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append(',').Append(cdsColunasprecisao.AsString)
                .Append(')')
                .Append('not null,');
            end;
          end;
          if (cdsColunastipo_campo.AsString = 'varchar') or (cdsColunastipo_campo.AsString = 'char') then
          begin
            if cdsColunasaceita_nulo.AsBoolean then
            begin
              sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append('),');
            end
            else
            begin
              sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString)
                .Append(' ').Append('(').Append(cdsColunastamanho_campo.AsString).Append(')').Append('not null,');
            end;
          end
          else
          if (cdsColunastipo_campo.AsString = 'bit') then
          begin
            sSQL.Append(' ADD COLUMN ').Append(cdsColunasnome_campo.AsString).Append(' ').Append(cdsColunastipo_campo.AsString).Append(',');
          end;
        end;
        cdsColunas.Next;
      end;

      sl.Add(Copy(sSQL.ToString,1,Length(sSQL.ToString)-1));

      if i>0 then
      begin
        mr1.ParamByName('sSQL').AsString := sl.Text;
        mr1.ExecuteMethod;
        if not mr1.ParamByName('ReturnParameter').AsBoolean  then
          ShowMessage('Erro ao criar tabela');
      end;
      FreeAndNil(sSQL);
      FreeAndNil(sl);
    end;

    if cdsTabela.State in [dsEdit,dsInsert] then
      cdsTabela.Post;
    if cdsColunas.State in [dsEdit,dsInsert] then
        cdsColunas.Post;
  except on e: Exception do
    ShowMessage(e.Message);
  end;
  Close;
end;

procedure TFrmCadastroTabela.cdsColunasAfterCancel(DataSet: TDataSet);
begin
  BtnColunaUpdate;
  pgcColunas.ActivePage := tsCampos;
end;

procedure TFrmCadastroTabela.cdsColunasAfterEdit(DataSet: TDataSet);
begin
//  BtnColunaInsEdit;
    cdsColunas.Edit;
    pgcColunas.ActivePage := tsApp;
    dbedtapp_titulo.SetFocus;

end;

procedure TFrmCadastroTabela.cdsColunasAfterInsert(DataSet: TDataSet);
begin

  if cdsTabelanome_tabela.AsString.Trim = '' then
    raise Exception.Create('Informe o nome da tabela.');

  cdsColunasordem.AsInteger := ViOrdem;
  cdsColunasnome_tabela.AsString := cdsTabelanome_tabela.AsString;;
  cdsColunaschave_primaria.AsBoolean := False;
  cdsColunastipo_campo.AsString := 'varchar';
  cdsColunastamanho_campo.AsInteger := 10;
  cdsColunasauto_incremento.AsBoolean := False;
  cdsColunasaceita_nulo.AsBoolean := True;
  cdsColunasvirtual.AsBoolean := False;
  cdsColunasapp_obrigatorio.AsBoolean := False;
  cdsColunasapp_visivel_consulta.AsBoolean := True;
  cdsColunasapp_visivel_formulario.AsBoolean := True;
  cdsColunasapp_pesquisavel.AsBoolean := False;
  cdsColunasapp_somenteleitura.AsBoolean := False;
  cdsColunasapp_bloq_insert.AsBoolean := False;
  cdsColunasapp_bloq_edit.AsBoolean := False;
  cdsColunasapp_lista_tipo.AsString := 'NI';
  cdsColunasapp_titulo_alinhamento.AsInteger := 0;
  cdsColunasapp_charcase.AsInteger := 0;
  cdsColunasprecisao.AsInteger := 0;
  cdsColunasapp_titulo_largura.AsInteger := 100;
  cdsColunasguia_nome.AsString := 'Principal';

  tsbanco.Enabled := True;
  pgcColunas.ActivePage := tsbanco;
  dbedtnome_campo.SetFocus;

end;

procedure TFrmCadastroTabela.cdsColunasAfterPost(DataSet: TDataSet);
begin
//  cdsColunas.ApplyUpdates(-1);
  //BtnColunaUpdate;
  pgcColunas.ActivePage := tsCampos;
end;

procedure TFrmCadastroTabela.cdsColunasapp_lista_tipoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  ControleLista(Text);
end;

procedure TFrmCadastroTabela.cdsColunasBeforeInsert(DataSet: TDataSet);
begin
  if cdsColunas.RecordCount > 0 then
  begin
    cdsColunas.Last;
    ViOrdem:= cdsColunasordem.AsInteger+1;
  end
  else
    ViOrdem := 1;
end;

procedure TFrmCadastroTabela.cdsTabelaAfterPost(DataSet: TDataSet);
begin
  cdsTabela.ApplyUpdates(-1);
  cdsColunas.ApplyUpdates(-1);
  cdsTabelaDetalhe.ApplyUpdates(-1);
end;

procedure TFrmCadastroTabela.ControleLista(value : string);
begin
  if value = 'LOOKUP' then
  begin
    dbedtapp_lista_tabela.Enabled:= True;
    dbedtapp_lista_campo_id.Enabled:= True;
    dbedtapp_lista_campo_display.Enabled:= True;

    btnPesquisaListaTabela.Enabled := True;
    btnPesquisaListaCampoID.Enabled := True;
    btnPesquisaListaCampoDisplay.Enabled := True;

    btnListaLimparTabela.Enabled := True;
    btnListaLimparCampoID.Enabled := True;
    btnListaLimparCampoDisplay.Enabled := True;
  end
  else
  if value = 'COMBO' then
  begin
    dbedtapp_lista_tabela.Enabled:= False;
    dbedtapp_lista_campo_id.Enabled:= False;
    dbedtapp_lista_campo_display.Enabled:= True;
    btnPesquisaListaTabela.Enabled := False;
    btnPesquisaListaCampoID.Enabled := False;
    btnPesquisaListaCampoDisplay.Enabled := True;
    btnListaLimparTabela.Enabled := False;
    btnListaLimparCampoID.Enabled := False;
  end
  else
  if value = 'NI' then
  begin
    dbedtapp_lista_tabela.Enabled:= False;
    dbedtapp_lista_campo_id.Enabled:= False;
    dbedtapp_lista_campo_display.Enabled:= False;
    btnPesquisaListaTabela.Enabled := False;
    btnPesquisaListaCampoID.Enabled := False;
    btnPesquisaListaCampoDisplay.Enabled := False;
    btnListaLimparTabela.Enabled := False;
    btnListaLimparCampoID.Enabled := False;
    btnListaLimparCampoDisplay.Enabled := False;
  end;
end;

procedure TFrmCadastroTabela.dbedtapp_lista_tipoChange(Sender: TObject);
begin
  ControleLista(dbedtapp_lista_tipo.Text);
end;

procedure TFrmCadastroTabela.edtCampoFilhoButtonClick(Sender: TObject);
begin
  if Trim(edtTabelaFilha.Text) <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := edtTabelaFilha.Text;
      FrmListaColunas.Tag := 0;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        edtCampoFilho.Text := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end
  else
    raise Exception.Create('Informe a tabela filha.');
end;

procedure TFrmCadastroTabela.edtCampoPaiButtonClick(Sender: TObject);
begin
  if cdsTabela.FieldByName('nome_tabela').AsString.Trim <> '' then
  begin
    try
      Application.CreateForm(TFrmListaColunas,FrmListaColunas);
      FrmListaColunas.Hint := cdsTabela.FieldByName('nome_tabela').asstring;
      FrmListaColunas.Tag := 0;
      FrmListaColunas.ShowModal;
    finally
      if FrmListaColunas.ModalResult = mrOk then
      begin
        edtCampoPai.Text := FrmListaColunas.cdsColunas.FieldByName('nome_campo').AsString;
      end;
      FreeAndNil(FrmListaColunas);
    end;
  end
  else
    raise Exception.Create('Tabela principal não informada.');
end;

procedure TFrmCadastroTabela.edtTabelaFilhaButtonClick(Sender: TObject);
begin
  if Trim(edtCampoPai.Text) <> '' then
  begin
    try
      Application.CreateForm(TFrmListaTabelas,FrmListaTabelas);
      FrmListaTabelas.Hint := cdsTabelanome_tabela.AsString;
      FrmListaTabelas.ShowModal;
    finally
      if FrmListaTabelas.ModalResult = mrOk then
      begin
        edtTabelaFilha.Text := FrmListaTabelas.cdsTabelas.FieldByName('nome_tabela').AsString;
      end;
      FreeAndNil(FrmListaTabelas);
    end;
  end
  else
    raise Exception.Create('Informe o campo primário.');
end;

procedure TFrmCadastroTabela.FormShow(Sender: TObject);
begin
  pgcTabela.ActivePage := tsPrincipal;
  pgcColunas.ActivePage := tsColunas;
end;

procedure TFrmCadastroTabela.limparCamposRelac;
begin
  edtCampoPai.Clear;
  edtTabelaFilha.Clear;
  edtCampoFilho.Clear;
  edtNomeGuia.Clear;
  edtOrdem.Text := IntToStr(cdsTabelaDetalhe.RecordCount+1);
end;

end.
