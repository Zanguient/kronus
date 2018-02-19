unit View.FrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, uDM, Vcl.StdCtrls,
  Vcl.Buttons, Datasnap.DSConnect, Vcl.DBActns, System.Actions, Vcl.ActnList,
  JvExDBGrids, JvDBGrid, JvExStdCtrls, JvCombobox, JvDBCombobox, JvEdit,
  JvValidateEdit, Data.FMTBcd, Data.SqlExpr, Sys.Functions, View.FrmCadastro,
  JvDBUltimGrid, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Ribbon,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.ComCtrls, Datasnap.DSService, Datasnap.DSSession;

type
  TFrmConsulta = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    grdConsulta: TJvDBUltimGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cbbCampos: TJvDBComboBox;
    cbbTermo: TJvDBComboBox;
    edtValor: TJvValidateEdit;
    sqlsmConsulta: TSqlServerMethod;
    dsDicionario: TDataSource;
    btnClose: TBitBtn;
    btnRelatorio: TBitBtn;
    btnExcluir: TBitBtn;
    btnEditar: TBitBtn;
    btnNovo: TBitBtn;
    StatusBar1: TStatusBar;
    mr1: TSqlServerMethod;
    pnlPaginacao: TPanel;
    btnNext: TBitBtn;
    btnVoltar: TBitBtn;
    chkExibeTodos: TCheckBox;
    procedure cdsConsultaBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cbbCamposCloseUp(Sender: TObject);
    procedure edtValorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsConsultaAfterRefresh(DataSet: TDataSet);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnNextClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure chkExibeTodosClick(Sender: TObject);
    procedure cdsConsultaBeforeRefresh(DataSet: TDataSet);

  private
    viprox : Integer;
    RegistroTotal: integer;
    paginacao : integer;
    procedure PreencherTermo(const tipo: string = 'varchar');
    procedure CountRegisters;

  public
    sFieldResult: string;
    vSearchResult : Variant;
  end;

var
  FrmConsulta: TFrmConsulta;
implementation

{$R *.dfm}

uses PMensagem;

procedure TFrmConsulta.btnCloseClick(Sender: TObject);
var
  f : TFont;
begin
  Close;
end;

procedure TFrmConsulta.btnEditarClick(Sender: TObject);
begin
  if cdsConsulta.RecordCount > 0 then
  begin
    try
      Application.CreateForm(TFrmCadastro, FrmCadastro);
      FrmCadastro.Hint := Self.Hint;
      FrmCadastro.Tag :=cdsConsulta.FieldByName('ID').AsInteger;
      FrmCadastro.ShowModal;
    finally
      FreeAndNil(FrmCadastro);
      cdsConsulta.Refresh;
    end;
  end;
end;

procedure TFrmConsulta.btnExcluirClick(Sender: TObject);
begin
  if cdsConsulta.RecordCount > 0 then
  begin
    if MessageBox(Handle, 'Deseja excluir registro?',sysCaption, MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2) = IDYES then
    begin
      try
         cdsConsulta.Delete;
         cdsConsulta.ApplyUpdates(-1);
         cdsConsulta.Refresh;
      except

      end;
    end;
  end;
end;
procedure TFrmConsulta.cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  if UpdateKind = ukDelete then
  begin
    if e.ErrorCode = 1451 then //foreign key
    begin
      ShowMessage('Erro de Chave estrangeira. Restrição de exclusão.');
      Action := raCancel;
    end;
  end;
end;

procedure TFrmConsulta.chkExibeTodosClick(Sender: TObject);
begin
  if chkExibeTodos.Checked then
  begin
    if cdsConsulta.RecordCount <> RegistroTotal then
    begin
      sqlsmConsulta.ParamByName('value').AsString := self.Hint;
      sqlsmConsulta.ParamByName('pagIni').AsInteger := 0;
      sqlsmConsulta.ParamByName('pagFim').AsInteger := 0;
      sqlsmConsulta.ExecuteMethod;
      StatusBar1.Panels[3].Text := '1';
      cdsConsulta.Refresh;
      btnVoltar.Enabled:= False;
      btnNext.Enabled := False;
    end;
  end
  else
  begin
    sqlsmConsulta.ParamByName('value').AsString := self.Hint;
    sqlsmConsulta.ParamByName('pagIni').AsInteger := 0;
    sqlsmConsulta.ParamByName('pagFim').AsInteger := paginacao;
    sqlsmConsulta.ExecuteMethod;
    StatusBar1.Panels[3].Text := sqlsmConsulta.ParamByName('TotalPagina').AsString;
    cdsConsulta.Refresh;
    btnVoltar.Enabled:= False;
    btnNext.Enabled := True;
  end;
end;

procedure TFrmConsulta.CountRegisters;
begin
  StatusBar1.Panels[1].Text := IntToStr(cdsConsulta.RecordCount);
end;
procedure TFrmConsulta.btnVoltarClick(Sender: TObject);
begin
  if viprox = (paginacao*2) then
    dec(viprox,paginacao*2)
  else
    Dec(viprox,paginacao*2);

  if viprox < 0 then
    viprox := 0;

  sqlsmConsulta.ParamByName('value').AsString := self.Hint;
  sqlsmConsulta.ParamByName('pagIni').AsInteger := viprox;
  sqlsmConsulta.ParamByName('pagFim').AsInteger := paginacao;
  sqlsmConsulta.ExecuteMethod;
  cdsConsulta.Refresh;
  if viprox=0 then
    btnVoltar.Enabled := False;
end;

procedure TFrmConsulta.cdsConsultaBeforeOpen(DataSet: TDataSet);
begin
  dsDicionario.DataSet.Filter := 'nome_tabela=' + QuotedStr(Self.Hint.Trim);
  dsDicionario.DataSet.Filtered := True;
  paginacao := dsDicionario.DataSet.FieldByName('paginacao').AsInteger;

  chkExibeTodos.Visible := (paginacao>0);
  pnlPaginacao.Visible:= (paginacao>0);

  RegistroTotal := 0;
  sqlsmConsulta.Close;
  sqlsmConsulta.ParamByName('value').AsString := self.Hint;
  sqlsmConsulta.ParamByName('pagIni').AsInteger := 0;
  sqlsmConsulta.ParamByName('pagFim').AsInteger := paginacao;
  sqlsmConsulta.ExecuteMethod;

  cdsConsulta.ProviderName := 'dspConsulta';//+self.Hint;

  RegistroTotal := sqlsmConsulta.ParamByName('Registros').AsInteger;

  if( (RegistroTotal > 10000)  and (chkExibeTodos.Checked)) or  (RegistroTotal>10000) and (paginacao=0)  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.PShow;
    FrmMensagem.PMensagem('Processando grande volume de dados...');
    FrmMensagem.PProgresso(0);
  end;

  if paginacao=0 then
    StatusBar1.Panels[3].Text := '1'
  else
    StatusBar1.Panels[3].Text := sqlsmConsulta.ParamByName('TotalPagina').AsString;
end;
procedure TFrmConsulta.cdsConsultaBeforeRefresh(DataSet: TDataSet);
begin
  if( (RegistroTotal > 10000)  and (chkExibeTodos.Checked)) or  (RegistroTotal>10000) and (paginacao=0)  then
  begin
    Application.CreateForm(TFrmMensagem, FrmMensagem);
    FrmMensagem.PShow;
    FrmMensagem.PMensagem('Processando grande volume de dados...');
    FrmMensagem.PProgresso(0);
  end;
end;

procedure TFrmConsulta.btnNextClick(Sender: TObject);
begin
  if cdsConsulta.RecordCount >= paginacao then
  begin
    if viprox = 0 then
      Inc(viprox,paginacao);
    sqlsmConsulta.ParamByName('value').AsString := self.Hint;
    sqlsmConsulta.ParamByName('pagIni').AsInteger := viprox;
    sqlsmConsulta.ParamByName('pagFim').AsInteger := paginacao;
    sqlsmConsulta.ExecuteMethod;
    cdsConsulta.Refresh;
    Inc(viprox,paginacao);
    btnVoltar.Enabled := True;
  end;
end;

procedure TFrmConsulta.btnNovoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmCadastro, FrmCadastro);
    FrmCadastro.Hint := Self.Hint;
    FrmCadastro.Tag := 0;
    FrmCadastro.ShowModal;
  finally
    FreeAndNil(FrmCadastro);
    cdsConsulta.Refresh;
  end;
end;

procedure TFrmConsulta.cbbCamposCloseUp(Sender: TObject);
begin
  PreencherTermo(fsGetFieldString(cbbCampos.Values[cbbCampos.ItemIndex],1));
end;

procedure TFrmConsulta.cdsConsultaAfterOpen(DataSet: TDataSet);
var
  i: Integer;
begin
  if Assigned(FrmMensagem) then
    FreeAndNil(FrmMensagem);
  CountRegisters;
  dsDicionario.DataSet.Filter := 'nome_tabela=' + QuotedStr(Self.Hint.Trim);
  dsDicionario.DataSet.Filtered := True;

  dsDicionario.DataSet.First;
  cbbCampos.Items.Clear;
  cbbCampos.Values.Clear;
  while not dsDicionario.DataSet.Eof do
  begin
    for i := 0 to grdConsulta.Columns.Count - 1 do
    begin

      if grdConsulta.Columns[i].FieldName = dsDicionario.DataSet.FieldByName('nome_campo').AsString then
      begin
        grdConsulta.Columns[i].Visible := dsDicionario.DataSet.FieldByName('app_visivel_consulta').AsBoolean;
        grdConsulta.Columns[i].Title.Caption := dsDicionario.DataSet.FieldByName('app_titulo').AsString;
        grdConsulta.Columns[i].Title.Alignment := TAlignment(dsDicionario.DataSet.FieldByName('app_titulo_alinhamento').AsInteger);
        grdConsulta.Columns[i].Width := dsDicionario.DataSet.FieldByName('app_titulo_largura').AsInteger;
        if dsDicionario.DataSet.FieldByName('app_campo_senha').AsBoolean then
          grdConsulta.Columns[i].Visible:= False;


        break;
      end;
    end;

    if dsDicionario.DataSet.FieldByName('app_formato').AsString.Trim <> '' then
      if cdsConsulta.FieldByName(dsDicionario.DataSet.FieldByName('nome_campo').AsString.Trim) is TBCDField then
        (cdsConsulta.FieldByName(dsDicionario.DataSet.FieldByName('nome_campo').AsString.Trim) as TBCDField).DisplayFormat :=dsDicionario.DataSet.FieldByName('app_formato').AsString.Trim;

    if dsDicionario.DataSet.FieldByName('app_pesquisavel').AsBoolean then
    begin
      if dsDicionario.DataSet.FieldByName('app_lista_tipo').AsString = 'LOOKUP' then
      begin
        cbbCampos.Items.Add(dsDicionario.DataSet.FieldByName('app_titulo').AsString);
        cbbCampos.Values.Add(dsDicionario.DataSet.FieldByName('nome_campo').AsString + '|' +'varchar' );//ideal e retornar o tipo do campo
      end
      else
      begin
        cbbCampos.Items.Add(dsDicionario.DataSet.FieldByName('app_titulo').AsString);
        cbbCampos.Values.Add(dsDicionario.DataSet.FieldByName('nome_campo').AsString + '|' +dsDicionario.DataSet.FieldByName('tipo_campo').AsString );
      end;
    end;
    dsDicionario.DataSet.Next;
  end;

  try
    cbbCampos.ItemIndex := 0;
    PreencherTermo(fsGetFieldString(cbbCampos.Values[cbbCampos.ItemIndex],1));
  except

  end;
  dsDicionario.DataSet.Filtered := False;
end;

procedure TFrmConsulta.cdsConsultaAfterRefresh(DataSet: TDataSet);
begin
  if Assigned(FrmMensagem) then
    FreeAndNil(FrmMensagem);
  CountRegisters;
end;

procedure TFrmConsulta.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  if sFieldResult.Trim <> '' then
  begin
    try
      vSearchResult := cdsConsulta.FieldByName(sFieldResult).AsVariant;
    except

    end;
  end;
end;

procedure TFrmConsulta.FormShow(Sender: TObject);
begin
  paginacao:=0;
  cdsConsulta.Close;
  cdsConsulta.Open;
  viprox := 0;
end;

procedure TFrmConsulta.edtValorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Trim((Sender as TJvValidateEdit).Text) <> '' then
  begin
    cdsConsulta.Filter := fsGetFieldString(cbbCampos.Values[cbbCampos.ItemIndex],0)+ ' ' +
      fsGetFieldString(cbbTermo.Values[cbbTermo.ItemIndex],0) +  ' '+
      QuotedStr( StringReplace(fsGetFieldString(cbbTermo.Values[cbbTermo.ItemIndex],1),'p',  Trim((Sender as TJvValidateEdit).Text),[rfReplaceAll]));
    try
      cdsConsulta.Filtered := True;
    except
      cdsConsulta.Filtered := False;
    end;
  end
  else
  begin
    cdsConsulta.Filtered := False;
  end;
  CountRegisters;
end;

procedure TFrmConsulta.PreencherTermo(const tipo: string = 'varchar');
  procedure Limpar;
  begin
    cbbTermo.Items.Clear;
    cbbTermo.Values.Clear;
  end;
begin
  if ((tipo='varchar') or (tipo='char')) and (cbbTermo.Tag<> 1) then
  begin
    Limpar;
    cbbTermo.Items.Add('Iniciado por');
    cbbTermo.Values.Add('like|p%');

    cbbTermo.Items.Add('Terminado em');
    cbbTermo.Values.Add('like|%p');

    cbbTermo.Items.Add('Igual a');
    cbbTermo.Values.Add('=|p');

    cbbTermo.Items.Add('Contém');
    cbbTermo.Values.Add('like|%p%');
    cbbTermo.Tag :=1;
  end
  else
  if (tipo='date') and (cbbTermo.Tag<> 2)  then
  begin
    Limpar;
    cbbTermo.Items.Add('Igual a');
    cbbTermo.Values.Add('=|p');

    cbbTermo.Items.Add('Maior que');
    cbbTermo.Values.Add('>|p');

    cbbTermo.Items.Add('Maior igual a');
    cbbTermo.Values.Add('>=|p');

    cbbTermo.Items.Add('Menor que');
    cbbTermo.Values.Add('<|p');

    cbbTermo.Items.Add('Menor igual a');
    cbbTermo.Values.Add('<=|p');
    cbbTermo.Tag :=2;

//    cbbTermo.Items.Add('Entre');
//    cbbTermo.Values.Add('>=p and <=p');

  end
  else if  ((tipo='decimal') or (tipo='int')) and (cbbTermo.Tag<> 3) then

  begin
    Limpar;
    cbbTermo.Items.Add('Igual a');
    cbbTermo.Values.Add('=|p');

    cbbTermo.Items.Add('Maior que');
    cbbTermo.Values.Add('>|p');

    cbbTermo.Items.Add('Maior igual a');
    cbbTermo.Values.Add('>=|p');

    cbbTermo.Items.Add('Menor que');
    cbbTermo.Values.Add('<|p');

    cbbTermo.Items.Add('Menor igual a');
    cbbTermo.Values.Add('<=|p');
    cbbTermo.Tag :=3;
  end;
  try
    cbbTermo.ItemIndex := 0;
  except

  end;

end;

end.
