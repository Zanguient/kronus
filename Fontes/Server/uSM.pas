unit uSM;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Datasnap.Provider, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, Sys.Functions,
  Datasnap.DBClient,Datasnap.DSService, Datasnap.DSSession, Vcl.Forms;

type
  TSM = class(TDSServerModule)
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryConsulta: TFDQuery;
    dspConsulta: TDataSetProvider;
    QryCadastro: TFDQuery;
    dspCadastro: TDataSetProvider;
    QryLkp: TFDQuery;
    dspLkp: TDataSetProvider;
    FDSQLite: TFDConnection;
    QrySys_Table: TFDQuery;
    QrySys_Field: TFDQuery;
    dspSys_Table: TDataSetProvider;
    dspSys_Field: TDataSetProvider;
    dspDicionario: TDataSetProvider;
    QryDicionario: TFDQuery;
    QryCampos: TFDQuery;
    QryGuia: TFDQuery;
    dspGuia: TDataSetProvider;
    qyLkpTables: TFDQuery;
    dspLkpTables: TDataSetProvider;
    qyAux: TFDQuery;
    qryTableDetalhe: TFDQuery;
    dspTableDetalhe: TDataSetProvider;
    qryDicAux: TFDQuery;

  private
    qryAuxiliar : TFDQuery;
    dspAuxiliar : TDataSetProvider;
    qry : TFDQuery;
    dsp : TDataSetProvider;
  private
      procedure logkronus(value: string);
  public
    //functions

    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function JoinTables(value : string): string;
    function RetornarCampos(value : string) : string;
    function CreateTable(sSQL : string): Boolean;
    function existeTabela(nomeTabela : string) : Boolean;


    //procedures
    procedure CriarDataset(pNomeTabela: string; const pOrderBy:string='';
      const pNomeqry: string = ''; const pNomedsp: string = ''; const pSQL : string = ''
      ; const Dicionario: Boolean = False
      ; const pCampoF: string = ''
      ; const pValorCampo: Integer =0
      );

    procedure OpenTabelaDetalhe(pTabela: string);
    procedure OpenLkp(ptabela, cChave, cDisplay, cAjax : string);
    procedure FindId(pid : Integer; ptabela: string; out pdsp: string);
    procedure OpenGuia(value: string);
    procedure OpenDicionario(value: string);
    procedure OpenTable(out TotalPagina: Integer;  out Registros: Integer;
    pNomeTabela: string; const pagIni : Integer = 0; const pagFim: integer = 0);
    procedure OpenSysLookup(cTableName : string; cFieldId: string; cFieldDisplay: string;
    const cFieldRestricao: string = '';  const cValorRestricao: string = ''; const cOperador: string = '<>';
    const cFieldOrderBy : string = '');
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses System.StrUtils;

function TSM.existeTabela(nomeTabela: string): Boolean;
begin
  with qyAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from information_schema.tables');// where table_schema= :p1');
    sql.Add(' where table_name=:p1 ');
    ParamByName('p1').AsString :=nomeTabela;
    Open();
    if IsEmpty then
      Result := False
    else
      Result := True;
  end;
end;
function TSM.CreateTable(sSQL: string): Boolean;
begin
  with qyAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sSQL);
    try
      ExecSQL;
      Result:= True;
    except on E:EDatabaseError  do
      Result := false;
    end;
  end;
end;

procedure TSM.CriarDataset(pNomeTabela: string; const pOrderBy:string='';
const pNomeqry: string = ''; const pNomedsp: string = ''; const pSQL : string = ''
; const Dicionario: Boolean = False
; const pCampoF: string = ''
; const pValorCampo: Integer =0
);

function getjoin(tabela: string): string;
var
  s: TStringBuilder;
begin
  s := TStringBuilder.Create;
  with qryDicAux do
  begin
    Close;
    sql.Clear;
    SQL.Add('select * from sys_campo ');
    SQL.Add('where nome_tabela='+QuotedStr(tabela));
    sql.Add(' and app_lista_tipo =:pTipoLista');
    ParamByName('pTipoLista').AsString := 'LOOKUP';
    Open();

    if qryDicAux.IsEmpty then
      raise Exception.Create('Dicionário não foi preenchido.');

    while not qryDicAux.Eof do
    begin
      if qryDicAux.FieldByName('app_visivel_consulta').AsBoolean then
      begin
        s.Append(' ' ).Append('INNER JOIN').Append(' ').Append(qryDicAux.FieldByName('app_lista_tabela').AsString);
        s.Append(' ').Append('ON').Append(' ');
        s.Append(qryDicAux.FieldByName('app_lista_tabela').AsString).Append('.').Append(qryDicAux.FieldByName('app_lista_campo_id').AsString);
        s.Append('=');
        s.Append(qryDicAux.FieldByName('nome_tabela').AsString).Append('.').Append(qryDicAux.FieldByName('nome_campo').AsString);
      end;
      qryDicAux.Next;
    end;
    Result:= s.ToString;
  end;

end;

var
  s : TStringBuilder;
  f: TStringList;
begin

  if FindComponent(pNomedsp) = nil then
  begin

    dspAuxiliar := TDataSetProvider.Create(Self);

    if pNomedsp='' then
      dspAuxiliar.Name := 'dspAuxiliar'
    else
      dspAuxiliar.Name := pNomedsp;
    logkronus('criou dsp: ' +dspAuxiliar.Name);
  end;

  if FindComponent(pNomeqry) = nil then
  begin

    qryAuxiliar := TFDQuery.Create(self);

    qryAuxiliar.Connection := FDConnection1;
    if pNomeqry=  '' then
      qryAuxiliar.Name := 'qryAuxiliar'
    else
      qryAuxiliar.Name:= pNomeqry;

    logkronus('criou qry: ' + qryAuxiliar.Name);
  end;
  (FindComponent(pNomedsp) as TDataSetProvider).DataSet:= (FindComponent(pNomeqry) as TFDQuery);
  (FindComponent(pNomeqry) as TFDQuery).Close;
  (FindComponent(pNomeqry) as TFDQuery).SQL.Clear;

  if not Dicionario then
  begin
    if pSQL='' then
      (FindComponent(pNomeqry) as TFDQuery).SQL.Add('select * from ' +pNomeTabela)
    else
      (FindComponent(pNomeqry) as TFDQuery).SQL.Add(pSQL);

    if pOrderBy<> '' then
      (FindComponent(pNomeqry) as TFDQuery).SQL.Add('order by ' + pOrderBy);
    (FindComponent(pNomeqry) as TFDQuery).Open();
  end
  else
  begin
    s := TStringBuilder.Create;
    s.Append('select ');

    with qryDicAux do
    begin
      Close;
      sql.Clear;
      SQL.Add('select * from sys_campo ');
      SQL.Add('where nome_tabela='+QuotedStr(pNomeTabela));
      sql.Add(' and (app_visivel_consulta = 1 or chave_primaria = 1) order by ordem ');
      Open();

      //list of fields
      while not Eof do
      begin
        if FieldByName('app_lista_tipo').AsString = 'LOOKUP' then
        begin
          s.Append(FieldByName('app_lista_tabela').AsString).Append('.').Append(FieldByName('app_lista_campo_display').AsString);
          s.Append(' ').Append('AS').Append(' ');
          s.Append(FieldByName('app_lista_tabela').AsString).Append('_').Append(FieldByName('app_lista_campo_display').AsString).Append(',');
        end
        else
        begin
          s.Append(FieldByName('nome_tabela').AsString).Append('.');
          s.Append(FieldByName('nome_campo').AsString).Append(',');
        end;
        Next;
      end;
      s.Remove(s.Length-1,1);
      s.Append(' FROM ').Append(pNomeTabela);
      s.Append(getjoin(pNomeTabela));


      if pCampoF<> '' then
        s.Append(' where ' +pNomeTabela + '.' + pCampoF + ' = ' + QuotedStr(IntToStr(pValorCampo)));

      logkronus(s.ToString);
      dspAuxiliar.DataSet := qryAuxiliar;
      qryAuxiliar.Close;
      qryAuxiliar.SQL.Clear;
      qryAuxiliar.SQL.Add(s.ToString);
      qryAuxiliar.Open();

    end;
  end;
end;

function TSM.EchoString(Value: string): string;
begin
  Result := Value;
end;



procedure TSM.FindId(pid: Integer; ptabela: string; out pdsp: string);
begin
  if FindComponent('dsp'+ptabela) =  nil then
  begin
    dsp := TDataSetProvider.Create(self);
    dsp.Name := 'dsp'+ptabela;
  end;

  if FindComponent('qry'+ptabela) <> nil then
  begin
    if (FindComponent('qry'+ptabela) is TFDQuery) then
    begin
      (FindComponent('dsp'+ptabela) as TDataSetProvider).DataSet :=
        (FindComponent('qry'+ptabela) as TFDQuery);

      with (FindComponent('qry'+ptabela) as TFDQuery) do
      begin
        Connection := FDConnection1;
        SQL.Clear;
        SQL.Add('select * from ' + ptabela);
        sql.Add(' where id='+inttostr(pid));
        Open();
      end;
    end;
  end
  else
  begin
    qry := TFDQuery.Create(Self);
    qry.Name := 'qry'+ptabela;
    (FindComponent('dsp'+ptabela) as TDataSetProvider).DataSet := qry;
    with qry do
    begin
      Connection := FDConnection1;
      SQL.Clear;
      SQL.Add('select * from ' + ptabela);
      sql.Add(' where id='+inttostr(pid));
      Open();
    end;
  end;

//	QryCadastro.Close();
//	QryCadastro.SQL.Clear();
//	QryCadastro.SQL.Add('select * from ' + ptabela);
//	QryCadastro.SQL.Add(' where id=' + IntToStr(pid));
//	QryCadastro.Open();
end;

function TSM.JoinTables(value: string): string;
var
  vsAux : string;
begin
  with QryCampos do
  begin
    Close();
    SQL.Clear();
    SQL.Add('select * from sys_campo ');
    SQL.Add(' where nome_tabela=' + QuotedStr(value));
    SQL.Add('and app_lista_tipo  = "LOOKUP"');
    SQL.Add(' order by ordem');
    Open();
    while not Eof do
    begin
      vsAux := vsAux + ' inner join ' +
        FieldByName('app_lista_tabela').AsString +  ' on ' +
        FieldByName('app_lista_tabela').AsString+ '.' + FieldByName('app_lista_campo_id').AsString
        + '=' + value + '.' +  FieldByName('nome_campo').AsString + ' ';

      Next();
    end
  end;
  Result := vsAux;
end;

procedure TSM.logkronus(value: string);
var
  f: TStringList;
begin
  try
      f:= TStringList.Create;
    if FileExists( ExtractFilePath(Application.ExeName) + 'log.txt')  then
        f.LoadFromFile(ExtractFilePath(Application.ExeName) + 'log.txt');
    f.Add(value);
    f.SaveToFile(ExtractFilePath(Application.ExeName) + 'log.txt');
  finally
    FreeAndNil(f);
  end;
end;

procedure TSM.OpenDicionario(value: string);
begin
	QryDicionario.Close();
	QryDicionario.SQL.Clear();
	QryDicionario.SQL.Add('select sys_campo.*, sys_tabela.foco_inicial, sys_tabela.paginacao ');
	QryDicionario.SQL.Add('from sys_campo ');
	QryDicionario.SQL.Add('inner join sys_tabela on sys_tabela.nome_tabela = sys_campo.nome_tabela');

	if (value <> '') then
  	QryDicionario.SQL.Add(' where sys_campo.nome_tabela='+QuotedStr(value));

  QryDicionario.SQL.Add('order by sys_campo.ordem');
end;

procedure TSM.OpenGuia(value: string);
begin
	QryGuia.Close();
	QryGuia.SQL.Clear();
	QryGuia.SQL.Add('select distinct guia_nome from sys_campo');
	QryGuia.SQL.Add(' where nome_tabela =:ParamTabela');
	if (value <> '') then
		QryGuia.ParamByName('ParamTabela').AsString := value;
end;

procedure TSM.OpenLkp(ptabela, cChave, cDisplay, cAjax: string);
begin
	QryLkp.Close();
	QryLkp.SQL.Clear();
	QryLkp.SQL.Add('select ' + cChave + ',' + cDisplay );
	if (cAjax <> '') then
    QryLkp.SQL.Add(', ' + cAjax);
	QryLkp.SQL.Add(' from ' + ptabela);

  if  (ptabela = 'municipio')  then
    QryLkp.SQL.Add(' order by estado_id')
  else
  	QryLkp.SQL.Add(' order by ' + cDisplay);
end;

procedure TSM.OpenSysLookup(cTableName: string; cFieldId: string; cFieldDisplay: string;
const cFieldRestricao: string = '';  const cValorRestricao: string = ''; const cOperador: string = '<>';
const cFieldOrderBy : string = ''
);
var
  fl, vl : TStringList;
  i: integer;
begin
  fl := TStringList.Create;
  vl := TStringList.Create;

  fl.Delimiter := ';';
  fl.DelimitedText := cFieldRestricao;

  vl.Delimiter := ';';
  vl.DelimitedText := cValorRestricao;

  with qyLkpTables do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ' + cTableName + '.'+cFieldId + ', ' + cTableName + '.'+cFieldDisplay );
    SQL.Add(' from ' + cTableName);

    if (Trim(cFieldRestricao) <> '') and (Trim(cValorRestricao) <> '') then
    begin
      if fl.Count > 0 then
      begin
        for i := 0 to fl.Count-1 do
        begin
          if i = 0 then
            SQL.Add(' where ' +cTableName+'.'+fl[i] + cOperador + QuotedStr(vl[i]))
          else
            SQL.Add(' and ' +cTableName+'.'+fl[i] + cOperador + QuotedStr(vl[i]));
        end;
      end
      else
        SQL.Add(' where ' +cTableName+'.'+cFieldRestricao + cOperador + QuotedStr(cValorRestricao));
    end;

    if Trim(cFieldOrderBy) = '' then
      SQL.Add(' order by ' + cTableName + '.'+ cFieldDisplay)
    else
      SQL.Add(' order by ' + cTableName + '.'+ cFieldOrderBy);
    FreeAndNil(fl);
    FreeAndNil(vl);
  end;
end;

procedure TSM.OpenTabelaDetalhe(pTabela: string);
begin
  with qryTableDetalhe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from sys_detalhe where nome_tabela =:p1');
    ParamByName('p1').AsString := pTabela;
    Open();
  end;
end;

procedure TSM.OpenTable(out TotalPagina: Integer;
out Registros: Integer; pNomeTabela:string;
const pagIni : Integer = 0; const pagFim: integer = 0);
var
	vsCampos, vsJoin : string;
begin
  with qyAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT round(COUNT(*)/' + IntToStr(pagFim)+ ') paginas, count(*) as regitros FROM ' + pNomeTabela);
    Open();
    if not IsEmpty then
    begin
      TotalPagina := Fields[0].AsInteger;
      Registros := Fields[1].asInteger;
    end;
  end;

	vsCampos:='';
	vsJoin:='';

//	if (pNomeTabela <> '') then
//  begin
//
//    if FindComponent('dspConsulta'+pNomeTabela) = nil then
//    begin
//      dsp := TDataSetProvider.Create(Self);
//      dsp.Name :='dspConsulta'+pNomeTabela;
//    end;
//
//    if FindComponent('qryConsulta'+pNomeTabela) = nil then
//    begin
//      qry := TFDQuery.Create(self);
//      qry.Connection := FDConnection1;
//      qry.Name :='qryConsulta'+pNomeTabela;
//      (FindComponent('dspConsulta'+pNomeTabela) as TDataSetProvider).DataSet := qry;
//      with qry do
//      begin
//        Close;
//        SQL.Clear;
//        vsCampos := RetornarCampos(pNomeTabela);
//        SQL.Add('select ' + vsCampos + ' from ' + pNomeTabela);
//        vsJoin := JoinTables(pNomeTabela);
//        if (vsJoin <> '') then
//          SQL.Add(vsJoin);
//
//        if (pagFim > 0) then
//          SQL.Add('limit ' + IntToStr(pagIni) + ' , ' + IntToStr(pagFim));
//      end;
//    end
//    else
//    begin
//      if (FindComponent('qryConsulta'+pNomeTabela) is TFDQuery) then
//      begin
//        (FindComponent('dsp'+pNomeTabela) as TDataSetProvider).DataSet :=
//          (FindComponent('qryConsulta'+pNomeTabela) as TFDQuery);
//
//        with (FindComponent('qryConsulta'+pNomeTabela) as TFDQuery) do
//        begin
//          Connection := FDConnection1;
//          SQL.Clear;
//          vsCampos := RetornarCampos(pNomeTabela);
//          SQL.Add('select ' + vsCampos + ' from ' + pNomeTabela);
//          vsJoin := JoinTables(pNomeTabela);
//          if (vsJoin <> '') then
//            SQL.Add(vsJoin);
//
//          if (pagFim > 0) then
//            SQL.Add('limit ' + IntToStr(pagIni) + ' , ' + IntToStr(pagFim));
//
//        end;
//      end;
//    end;
//	end;
	if (pNomeTabela <> '') then
  begin
		QryConsulta.Close();
		QryConsulta.SQL.Clear();
		vsCampos := RetornarCampos(pNomeTabela);
		QryConsulta.SQL.Add('select ' + vsCampos + ' from ' + pNomeTabela);

		vsJoin := JoinTables(pNomeTabela);
		if (vsJoin <> '') then
			QryConsulta.SQL.Add(vsJoin);

    if (pagFim > 0) then
        QryConsulta.SQL.Add('limit ' + IntToStr(pagIni) + ' , ' + IntToStr(pagFim));

	end;
end;

function TSM.RetornarCampos(value: string) : string;
var
  vsAux: string;
  ViLista: integer;
  i : integer;
begin
  with QryCampos do
  begin
    Close;
    sql.Clear;
    SQL.Add('select * from sys_campo ');
    SQL.Add('where nome_tabela=' + QuotedStr(value) + ' order by ordem');
    Open();

    while not Eof do
    begin
      if (FieldByName('app_lista_tipo').AsString  = 'LOOKUP')
      and ( Trim( FieldByName('app_lista_campo_id').AsString ) <> '')
      and ( Trim( FieldByName('app_lista_campo_display').AsString) <> '') then
      begin
        vsAux := vsAux +
          FieldByName('app_lista_tabela').AsString + '.' +
          FieldByName('app_lista_campo_display').AsString + ' as ' +
          FieldByName('app_lista_tabela').AsString +'_'+
          FieldByName('app_lista_campo_id').AsString +',';
      end
      else
      if (FieldByName('app_lista_tipo').AsString = 'COMBO') and ( Trim(FieldByName('app_lista_campo_display').AsString) <> '') then
      begin
        vsAux := vsAux + 'CASE '+
          FieldByName('nome_campo').AsString;

      	ViLista := fiGetCountField(FieldByName('app_lista_campo_display').AsString,';');
        for i := 0 to ViLista - 1 do
        begin
          vsAux := vsAux + ' when ' + QuotedStr( fsGetFieldString(fsGetFieldString(FieldByName('app_lista_campo_display').AsString,i,';'),0))
          + ' then ' + QuotedStr(fsGetFieldString(fsGetFieldString(FieldByName('app_lista_campo_display').AsString,i,';'),1))
          ;
        end;
        vsAux := vsAux + ' end as ' +  FieldByName('nome_campo').AsString + ',';
      end
      else
      begin
        vsAux := vsAux + value + '.' + FieldByName('nome_campo').AsString + ',';
      end;
      Next;
    end;

    vsAux :=  Copy( vsAux,1, length(vsAux) -1);
    Result := vsAux;
  end;
end;

function TSM.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

