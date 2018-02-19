unit View.FrmCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uDM, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.DBClient, Vcl.DBCtrls,
  JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.Mask, JvExMask, JvToolEdit,
  JvDBControls, JvDBCheckBox, JvDBImage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MySQLWrapper, Sys.Functions, Data.FMTBcd,
  Data.SqlExpr, SYSTEM.StrUtils, JvComponentBase, JvEnterTab, JvDBGrid,JvDBUltimGrid,
  JvExControls, JvDBLookup;

type
  TFrmCadastro = class(TForm)
    pnlBotoes: TPanel;
    btnEditar: TBitBtn;
    btnNovo: TBitBtn;
    pgcPrincipal: TPageControl;
    cdsGuias: TClientDataSet;
    dsFields: TDataSource;
    cdsCadastro: TClientDataSet;
    dsCadastro: TDataSource;
    cdsLkp: TClientDataSet;
    sqlsmChamadaRemota: TSqlServerMethod;
    JvEnterAsTab1: TJvEnterAsTab;
    cdsTabelaDetalhe: TClientDataSet;
    mr1: TSqlServerMethod;
    mr2: TSqlServerMethod;
    sqlsmCadastro: TSqlServerMethod;
    procedure FormShow(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure cdsCadastroAfterPost(DataSet: TDataSet);
    procedure cdsCadastroAfterInsert(DataSet: TDataSet);
    procedure btnInsereFotoClick(Sender: TObject);
    procedure btnRemoveFotoClick(Sender: TObject);

    procedure btnDetNovoClick(Sender: TObject);
    procedure btnDetEditarClick(Sender: TObject);
    procedure btnDetExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private

   procedure montaGuia(Value : TScrollBox; Guia: string; Tabela : string);
   procedure pAjustarGrid(Tabela: string; grid: TJvDBGrid);
   procedure pMontaGuiaFilhas(Tabela : string; Pagina : TPageControl);
   procedure PreencherValorPadrao;
   procedure Formatarcds(Tabela:string;cds : TClientDataSet);



  private
    procedure CriaBotaoDetalhe(pCaption: string;  pLeft: Integer; pHint: string; pTag: Integer; pParent: TWinControl;
    pEvento: TNotifyEvent
    );

    procedure CriaGridDetalhe(pParent: TWinControl; pds: TDataSource; ptabela: string);


  public

  public

  end;

var
  FrmCadastro: TFrmCadastro;
  FDetalheField: string;
  FDetalheValue : Integer;

implementation

{$R *.dfm}

uses View.FrmConsulta;


procedure TFrmCadastro.btnBuscaClick(Sender: TObject);
var
  sCampo: string;
  sTabela: string;
  sFieldResult: string;
begin
  try
    sTabela := fsGetFieldString((sender as TBitBtn).Hint,0);
    sCampo := fsGetFieldString((sender as TBitBtn).Hint,1);
    sFieldResult :=fsGetFieldString((sender as TBitBtn).Hint,2);
    Application.CreateForm(TFrmConsulta,FrmConsulta);
    FrmConsulta.Hint := sTabela;
    FrmConsulta.sFieldResult := sCampo;
    FrmConsulta.ShowModal;
  finally
    if FrmConsulta.vSearchResult <> null then
    begin
      cdsCadastro.Edit;
      cdsCadastro.FieldByName(sFieldResult).AsVariant := FrmConsulta.vSearchResult;
    end;
  end;
end;


procedure TFrmCadastro.btnDetEditarClick(Sender: TObject);
var
  vsAux: string;
begin
  if TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).RecordCount > 0 then
  begin
    try
      Application.CreateForm(TfrmCadastro, frmCadastro);
      fDetalheValue := (Sender as TBitBtn).Tag;
      fDetalheField :=fsGetFieldString( (Sender as TBitBtn).Hint, 2);
      frmCadastro.Hint := fsGetFieldString( (Sender as TBitBtn).Hint, 0);
      frmCadastro.Tag := TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).FieldByName('ID').AsInteger;
      sqlsmCadastro.ParamByName('pid').AsInteger := frmCadastro.Tag;
      sqlsmCadastro.ParamByName('ptabela').AsString := frmCadastro.Hint;
      sqlsmCadastro.ParamByName('pdsp').AsString := frmCadastro.Hint;
      sqlsmCadastro.ExecuteMethod;
      FrmCadastro.cdsCadastro.ProviderName := 'dsp'+frmCadastro.Hint;
      FrmCadastro.cdsCadastro.Close;
      FrmCadastro.cdsCadastro.Open;
      frmCadastro.ShowModal;
    finally
      FreeAndNil(frmCadastro);
      TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).Refresh;
    end;
  end;
end;

procedure TFrmCadastro.btnDetExcluirClick(Sender: TObject);
begin
  if TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).RecordCount > 0 then
  begin
    if MessageBox(Handle, 'Deseja excluir registro?',sysCaption, MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2) = IDYES then
    begin
       TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).Delete;
       TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).ApplyUpdates(-1);
    end;
  end;
end;

procedure TFrmCadastro.btnDetNovoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadastro, frmCadastro);
    frmCadastro.Hint := fsGetFieldString( (Sender as TBitBtn).Hint, 0); //tabela
    frmCadastro.Tag := 0;

    sqlsmCadastro.ParamByName('pid').AsInteger := -1;
    sqlsmCadastro.ParamByName('ptabela').AsString := frmCadastro.Hint;
    sqlsmCadastro.ParamByName('pdsp').AsString := frmCadastro.Hint;
    sqlsmCadastro.ExecuteMethod;

    FrmCadastro.cdsCadastro.ProviderName := 'dsp'+frmCadastro.Hint;
    FrmCadastro.cdsCadastro.Close;
    FrmCadastro.cdsCadastro.Open;
    fDetalheField :=fsGetFieldString( (Sender as TBitBtn).Hint, 2); //ID_PRODUTO
    fDetalheValue := (Sender as TBitBtn).Tag; //valor do campo FieldDet
    FrmCadastro.Tag:=0;
    frmCadastro.ShowModal;
  finally
    FreeAndNil(frmCadastro);
    TClientDataSet(FindComponent(fsGetFieldString( (Sender as TBitBtn).Hint, 1))).Refresh;
  end;
end;

procedure TFrmCadastro.btnEditarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastro.btnRemoveFotoClick(Sender: TObject);
begin
  cdsCadastro.FieldByName((sender as TBitBtn).Hint).Clear;
end;
procedure TFrmCadastro.btnInsereFotoClick(Sender: TObject);
var
  JPG : TFileStream;
  dlgOpenFoto : TOpenDialog;
begin
  inherited;
  try
    dlgOpenFoto := TOpenDialog.Create(self);
    if dlgOpenFoto.Execute then
    begin
      try
        JPG := TFileStream.Create(dlgOpenFoto.FileName, fmOpenRead);
        TBlobField(cdsCadastro.FieldByName((Sender as TBitBtn).Hint)).LoadFromStream(JPG);
      finally
        FreeAndNil(jpg);
      end;
    end;
  finally
    FreeAndNil(dlgOpenFoto);
  end;
end;

procedure TFrmCadastro.btnNovoClick(Sender: TObject);
begin
  try
    cdsCadastro.Post;
    ShowMessage('Registro gravado com sucesso.');
    Close;
  except on E:EMySQLNativeException  do
    begin
      If  (Pos(UpperCase('duplicate key'), UpperCase(E.Message)) <> 0) or
          (Pos(UpperCase('duplicate entry'), UpperCase(E.Message)) <> 0)  then
        Application.MessageBox('Houve violação de Chave.  Registro já incluido.','Kronos', MB_ICONERROR)
      else
        ShowMessage(e.Message);
    end;
  end;
end;



procedure TFrmCadastro.cdsCadastroAfterInsert(DataSet: TDataSet);
begin
  PreencherValorPadrao;
  if FDetalheField <> '' then
    cdsCadastro.FieldByName(FDetalheField).AsInteger := FDetalheValue;
end;

procedure TFrmCadastro.cdsCadastroAfterPost(DataSet: TDataSet);
begin
  cdsCadastro.ApplyUpdates(0);
end;

procedure TFrmCadastro.CriaBotaoDetalhe(pCaption: string;  pLeft
  : Integer; pHint: string; pTag: Integer;  pParent: TWinControl;pEvento: TNotifyEvent);
var
  btn : TBitBtn;
begin
  btn := TBitBtn.Create(self);
  btn.Parent := pParent;
  btn.Top := 5;
  btn.Left := pLeft;
  btn.Width := 118 ;
  btn.Caption := pCaption;
  btn.Hint := pHint;
  btn.Tag := pTag;
  btn.OnClick := pEvento;
end;

procedure TFrmCadastro.CriaGridDetalhe(pParent: TWinControl; pds: TDataSource; ptabela: string);
var
  dbgDados : TJvDBUltimGrid;
begin
  dbgDados := TJvDBUltimGrid.Create(self);
  dbgDados.Font.Size:=10;
  dbgDados.ShowGlyphs := true;
  dbgDados.Parent := pParent;
  dbgDados.Align := alClient;
  dbgDados.DataSource := pds;
  dbgDados.TitleButtons := True;
  dbgDados.SortWith := swClient;
  dbgDados.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines,dgTabs ];
  dbgDados.ReadOnly :=True;
  dbgDados.TitleFont.Style := [fsBold];
  pAjustarGrid(ptabela, dbgDados);
end;

procedure TFrmCadastro.Formatarcds(Tabela: string; cds: TClientDataSet);
begin
  dsFields.DataSet.Filtered := False;
  dsFields.DataSet.Filter := 'nome_tabela = ' + QuotedStr(Tabela);
  dsFields.DataSet.Filtered := True;
  dsFields.DataSet.First;
  while not dsFields.DataSet.Eof do
  begin
    if (dsFields.DataSet.FieldByName('app_formato').AsString <> '') AND dsFields.DataSet.FieldByName('app_visivel_consulta').AsBoolean then
    begin
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'int') then
        TIntegerField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if  (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'smallint') then
        TSmallintField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'date') then
        TDateField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'datetime') then
        TDateTimeField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'time') then
        TTimeField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'timestamp') then
        TTimeField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString
      else
      if (dsFields.DataSet.FieldByName('tipo_campo').AsString = 'decimal') then
        TBCDField(cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString)).DisplayFormat :=dsFields.DataSet.FieldByName('app_formato').AsString;

      if dsFields.DataSet.FieldByName('tipo_campo').AsString.Trim <> '' then
        cds.FindField(dsFields.DataSet.FieldByName('nome_campo').AsString).ConstraintErrorMessage := '';
    end;
    dsFields.DataSet.Next;
  end;
end;


procedure TFrmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDetalheValue := 0;
  FDetalheField := '';
end;

procedure TFrmCadastro.FormShow(Sender: TObject);
var
  Guia : TTabSheet;
  scbx : TScrollBox;
  i : Integer;
begin
  if self.Tag=0 then
  begin
    sqlsmCadastro.ParamByName('pid').AsInteger := -1;
    sqlsmCadastro.ParamByName('ptabela').AsString := Self.Hint;
    sqlsmCadastro.ExecuteMethod;
    cdsCadastro.ProviderName := 'dsp'+Self.Hint;
    cdsCadastro.Close;
    cdsCadastro.Open;
    cdsCadastro.Insert;
  end
  else
  begin
    FrmCadastro.sqlsmCadastro.ParamByName('pid').AsInteger := Self.Tag;
    FrmCadastro.sqlsmCadastro.ParamByName('ptabela').AsString := Self.Hint;
    FrmCadastro.sqlsmCadastro.ParamByName('pdsp').AsString := Self.Hint;
    FrmCadastro.sqlsmCadastro.ExecuteMethod;
    FrmCadastro.cdsCadastro.ProviderName := 'dsp'+Self.Hint;
    FrmCadastro.cdsCadastro.Close;
    FrmCadastro.cdsCadastro.Open;
    cdsCadastro.Edit;
  end;

  i:= 0;
  cdsGuias.Close;
  cdsGuias.ParamByName('PARAMTABELA').AsString := self.Hint;
  cdsGuias.Open;

  with cdsGuias do
  begin
    while not Eof do
    begin
      Guia          := TTabSheet.Create(pgcPrincipal);
      Guia.Caption  := FieldByName('guia_nome').AsString;
      Guia.Name     :='ts'+ IntToStr(i);
      Guia.PageControl  := pgcPrincipal;
      Guia.PageIndex    := i;
      Guia.AlignWithMargins := True;
      Guia.TabOrder := 0;
      scbx := TScrollBox.Create(Guia);
      scbx.BevelKind := bkFlat;
      scbx.BorderStyle := bsNone;
      scbx.Name := 'scbx'+IntToStr(i);
      scbx.Parent := Guia;
      scbx.Align := alClient;
      scbx.TabOrder := 0;
      montaGuia(scbx,Guia.Caption, self.Hint);
      Inc(i);
      Next;
    end;
    pMontaGuiaFilhas(self.Hint,pgcPrincipal);
  end;

end;

procedure TFrmCadastro.montaGuia(Value: TScrollBox; Guia, Tabela: string);
var
  editor : TDBEdit;
  Titulo : TLabel;
  dblkpcbb : TDBLookupComboBox;
  dsLkp : TDataSource;
  dsLkpAjax : TDataSource;
  btnSearch : TBitBtn;
  cbbBox : TJvDBComboBox;
  edtData : TJvDBDateEdit;
  edtCheck : TJvDBCheckBox;
  edtValor : TJvDBCalcEdit;
  vFoto : TJvDBImage;
  vbFoto : Boolean;
  viIncFoto: Integer;
  ViLista: integer;
  ViLeft, ViLeftTitulo,ViTop,ViTopTitulo : Integer;
  i : Integer;
  VsAux : string;
  cdsLkp : TClientDataSet;

  procedure AjustaComponente( pControle: TWinControl; pLeft: Integer;
    pHeight: Integer; pTop: Integer; pwidth: Integer; pParent:TScrollBox;
    pEdit : Boolean; pInsert: Boolean
    );
  begin
    pControle.Left := pLeft;
    pControle.Height := pHeight;
    pControle.Top := pTop;

    if cdsCadastro.State in [dsEdit] then
      pControle.Enabled := not pEdit;

    if cdsCadastro.State in [dsInsert] then
      pControle.Enabled := not pInsert;

    if pwidth > 220 then
      pControle.Width := 220
    else
      pControle.Width := pwidth;

    pControle.Parent := pParent;
  end;
  procedure MontarBtnBusca(pValue: TScrollBox; pvsHint: string; pViLeft: Integer; pEnabled: Boolean);
  begin
    btnSearch := TBitBtn.Create(self);
    btnSearch.Width := 25;
    btnSearch.Height := 23;
    btnSearch.Top := ViTop;
    btnSearch.Caption := '...';
    btnSearch.Parent := pValue;
    btnSearch.Hint :=pvsHint;
    btnSearch.OnClick := btnBuscaClick;
    btnSearch.Left := pViLeft;
    btnSearch.TabStop := False;
    btnSearch.Enabled := pEnabled;
  end;
  procedure MontaTitulo(pValue: TScrollBox; pControle: TWinControl; pLeft: Integer;
   pTop: Integer; pCaption: string; pObg: Boolean; nome_campo: string) ;
  begin
    Titulo := TLabel.Create(Self);
    Titulo.Left := pLeft;
    Titulo.Top := pTop;
    Titulo.Alignment := taRightJustify;
    Titulo.Parent := pValue;
    Titulo.FocusControl := pControle;
    cdsCadastro.FieldByName(nome_campo).DisplayLabel := pCaption;
    cdsCadastro.FieldByName(nome_campo).Required := pObg;

    if pObg then
    begin
      Titulo.Caption :=pCaption + '*';
      Titulo.Font.Color := clBlue;
    end
    else
      Titulo.Caption := pCaption;
  end;
begin
  ViTop:=5;
  ViTopTitulo:= 8;
  vbFoto := False;
  viIncFoto:=0;
  ViLeft := 114;
  ViLeftTitulo := 45;

  dsFields.DataSet.Filter := 'guia_nome = ' +QuotedStr(Guia)  +
                      'and app_visivel_formulario = ' + QuotedStr('1')+
                      'and nome_tabela = ' + QuotedStr(Tabela)
                      ;
  dsFields.DataSet.Filtered := True;
  dsFields.DataSet.First;
  while not dsFields.DataSet.Eof do
  begin
    if Odd(dsFields.DataSet.RecNo) then
    begin
      if (vbFoto) and (viIncFoto<7) then
      begin
        ViLeft := 458;
        ViLeftTitulo := 390;
      end
      else
      begin
        ViLeft := 114;
        ViLeftTitulo := 45;
      end;
    end
    else
    begin
      if  (viIncFoto<7) then
      begin
        ViLeft := 458;
        ViLeftTitulo := 390;
      end
      else
      begin
        ViLeft := 114;
        ViLeftTitulo := 45;
      end;
    end;

    if dsFields.DataSet.RecNo > 2 then
    begin
      if ((dsFields.DataSet.RecNo mod  2) = 1) then
      begin
        Inc(ViTop,28);
        Inc(ViTopTitulo,28);
      end;
    end;

    with dsFields.DataSet do
    begin
      //******************************************************************************
      if ((FieldByName('tipo_campo').AsString = 'varchar') or (FieldByName('tipo_campo').AsString = 'char'))
       and (FieldByName('app_lista_tipo').AsString = 'NI' )
      then
      begin
        editor := TDBEdit.Create(Self);
        AjustaComponente( editor, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);
        editor.DataSource := dsCadastro;
        editor.DataField := FieldByName('nome_campo').AsString;

        editor.CharCase := TEditCharCase(FieldByName('app_charcase').AsInteger);
        MontaTitulo(Value,editor,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          editor.Font.Color := clBlue;

        if FieldByName('app_campo_senha').AsBoolean then
          editor.PasswordChar := '*';


        if vbFoto then
        begin
          if viIncFoto = 7 then
          begin
            vbFoto := false;
            viIncFoto:=0;
          end;
          Inc(viIncFoto);
        end;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              editor.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              editor.SetFocus;
        end;

        if (FieldByName('app_busca_tabela').AsString <> '' ) and (FieldByName('app_busca_campo').AsString <> '' ) then
        begin
          MontarBtnBusca(Value,FieldByName('app_busca_tabela').AsString + '|' + FieldByName('app_busca_campo').AsString + '|' + FieldByName('nome_campo').AsString,ViLeft+editor.Width,editor.Enabled);
          editor.Hint :=FieldByName('app_busca_tabela').AsString+'|' +FieldByName('app_busca_campo').AsString+'|'+FieldByName('app_titulo').AsString+'|0';
        end
        else
        begin
          editor.Hint :=self.Hint+'|' +FieldByName('nome_campo').AsString+'|'+FieldByName('app_titulo').AsString+'|1';
        //  editor.OnExit := ComponenteExit;
        end;
      end;
      //******************************************************************************
        if ((FieldByName('TIPO_CAMPO').AsString = 'blob') or (FieldByName('TIPO_CAMPO').AsString = 'longblob')) then
        begin
          vbFoto:=True;
          Inc(viIncFoto);

          vFoto  := TJvDBImage.Create(Self);
          AjustaComponente( vFoto, ViLeft, 108, ViTop,105,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);

          vFoto.Stretch := True;
          vFoto.DataSource := dsCadastro;
          vFoto.DataField := FieldByName('nome_campo').AsString;

          MontaTitulo(Value,vFoto,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,
            FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

          if FieldByName('app_obrigatorio').AsBoolean then
            vFoto.Font.Color := clBlue;

          btnSearch := TBitBtn.Create(self);
          btnSearch.Width := 90;
          btnSearch.Height := 23;
          btnSearch.Top := ViTop;
          btnSearch.Caption := 'Inserir';
          btnSearch.Hint := FieldByName('nome_campo').AsString;
          btnSearch.Parent := Value;
          btnSearch.Left := ViLeft+ vFoto.Width ;
          btnSearch.TabStop := False;
          btnSearch.OnClick := btnInsereFotoClick;
          btnSearch.Enabled := vFoto.Enabled;

          btnSearch := TBitBtn.Create(self);
          btnSearch.Width := 90;
          btnSearch.Height := 23;
          btnSearch.Top := ViTop+27;
          btnSearch.Caption := 'Remover';
          btnSearch.Hint := FieldByName('nome_campo').AsString;
          btnSearch.Parent := Value;
          btnSearch.Left := ViLeft+ vFoto.Width ;
          btnSearch.TabStop := False;
          btnSearch.OnClick := btnRemoveFotoClick;
          btnSearch.Enabled := vFoto.Enabled;
        end;
      //******************************************************************************

      if (
      (FieldByName('tipo_campo').AsString = 'int') or (FieldByName('tipo_campo').AsString = 'bigint') or
      (FieldByName('tipo_campo').AsString = 'smallint') or (FieldByName('tipo_campo').AsString = 'tinyint')
      )
      and (FieldByName('app_lista_tipo').AsString = 'NI' )
       then
      begin
        editor := TDBEdit.Create(Self);
        AjustaComponente( editor, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);
        editor.DataSource := dsCadastro;
        editor.DataField := FieldByName('nome_campo').AsString;
        editor.CharCase := TEditCharCase(FieldByName('app_charcase').AsInteger);

        MontaTitulo(Value,editor,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          editor.Font.Color := clBlue;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              editor.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              editor.SetFocus;
        end;

        if (FieldByName('app_busca_tabela').AsString <> '' ) and (FieldByName('app_busca_campo').AsString <> '' ) then
        begin
          MontarBtnBusca(Value,FieldByName('app_busca_tabela').AsString + '|' + FieldByName('app_busca_campo').AsString + '|' + FieldByName('nome_campo').AsString,ViLeft+editor.Width,editor.Enabled);
          editor.Hint :=FieldByName('app_busca_tabela').AsString+'|' +FieldByName('app_busca_campo').AsString+'|'+FieldByName('app_titulo').AsString+'|0';
        end
        else
        begin
          editor.Hint :=self.Hint+'|' +
            FieldByName('nome_campo').AsString+
            '|'+
            FieldByName('app_titulo').AsString+
            '|1';
        end;

      end;

    //******************************************************************************
      if (FieldByName('app_lista_tipo').AsString = 'COMBO' ) then
      begin
        cbbBox := TJvDBComboBox.Create(self);
        AjustaComponente( cbbBox,
          ViLeft,
          25,
          ViTop,
          FieldByName('app_titulo_largura').AsInteger,
          Value,
          FieldByName('app_bloq_edit').AsBoolean,
          FieldByName('app_bloq_insert').AsBoolean);

        cbbBox.DataSource := dsCadastro;
        cbbBox.DataField := FieldByName('nome_campo').AsString;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim)
         and (FieldByName('app_bloq_edit').AsBoolean = False)
         and (FieldByName('app_bloq_insert').AsBoolean = False)
        then
          cbbBox.SetFocus;

        MontaTitulo(Value,cbbBox,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if not FieldByName('app_lista_campo_display').AsString.Trim.IsEmpty then
        begin
          ViLista := fiGetCountField(FieldByName('app_lista_campo_display').AsString,';');
          for i := 0 to ViLista - 1 do
          begin
             VsAux := fsGetFieldString(FieldByName('app_lista_campo_display').AsString,i,';');
             cbbBox.Items.Add(fsGetFieldString(VsAux,1));
             cbbBox.Values.Add(fsGetFieldString(VsAux,0));
          end;
        end;

        if FieldByName('app_obrigatorio').AsBoolean then
          cbbBox.Font.Color := clBlue;

      end;
    //******************************************************************************

      if (FieldByName('app_lista_tipo').AsString= 'LOOKUP') then
      begin
        cdsLkp := TClientDataSet.Create(Self);
        cdsLkp.Name := 'cdsLkp' +FieldByName('app_lista_tabela').AsString;
        cdsLkp.RemoteServer := DM.ProviderConnection;
        cdsLkp.ProviderName := 'dspLkp';
        cdsLkp.Close;

        sqlsmChamadaRemota.Close;
        sqlsmChamadaRemota.ServerMethodName:='TSM.OpenLkp';
        sqlsmChamadaRemota.ParamByName('ptabela').AsString  := FieldByName('app_lista_tabela').AsString;
        sqlsmChamadaRemota.ParamByName('cChave').AsString   := FieldByName('app_lista_campo_id').AsString;
        sqlsmChamadaRemota.ParamByName('cDisplay').AsString := FieldByName('app_lista_campo_display').AsString;

        if FieldByName('app_ajax_tabela').AsString.Trim <> '' then
          sqlsmChamadaRemota.ParamByName('cAjax').AsString := FieldByName('app_ajax_campo_link').AsString.Trim;
        sqlsmChamadaRemota.ExecuteMethod;

        cdsLkp.Open;
        dsLkp := TDataSource.Create(self);
        dsLkp.Name := 'dsLkp'+FieldByName('app_lista_tabela').AsString;
        dsLkp.DataSet := cdsLkp;

        if FieldByName('app_ajax_tabela').AsString.Trim <> '' then
        begin
//          cdsLkp.AddIndex('IDX_'+ FieldByName('app_ajax_campo_link').AsString, FieldByName('app_ajax_campo_link').AsString,[],'','',1);
//          cdsLkp.IndexName := 'IDX_'+ FieldByName('app_ajax_campo_link').AsString;
          cdsLkp.AddIndex('IDX_'+ FieldByName('app_ajax_campo_link').AsString,  FieldByName('app_ajax_campo_link').AsString+';'+FieldByName('app_lista_campo_display').AsString,[],'','',1);
          cdsLkp.IndexName := 'IDX_'+ FieldByName('app_ajax_campo_link').AsString;


          cdsLkp.MasterFields :=   FieldByName('app_ajax_campo_id').AsString;
          cdsLkp.MasterSource := TDataSource(Self.findComponent('dsLkp'+FieldByName('app_ajax_tabela').AsString));
        end;

        dblkpcbb := TDBLookupComboBox.Create(Self);

        AjustaComponente( dblkpcbb, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);






        dblkpcbb.DataSource := dsCadastro;
        dblkpcbb.DataField := FieldByName('nome_campo').AsString;
        dblkpcbb.ListSource := dsLkp;

        dblkpcbb.KeyField := FieldByName('app_lista_campo_id').AsString;
        dblkpcbb.ListField := FieldByName('app_lista_campo_display').AsString;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              dblkpcbb.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              dblkpcbb.SetFocus;
        end;

        if (FieldByName('app_busca_tabela').AsString <> '' ) and (FieldByName('app_busca_campo').AsString <> '' ) then
          MontarBtnBusca(Value,FieldByName('app_busca_tabela').AsString + '|' + FieldByName('app_busca_campo').AsString + '|' + FieldByName('nome_campo').AsString,ViLeft+dblkpcbb.Width,dblkpcbb.Enabled);

        MontaTitulo(Value,dblkpcbb,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          dblkpcbb.Font.Color := clBlue;
      end;

    //******************************************************************************
      if (FieldByName('tipo_campo').AsString = 'decimal')   then
      begin
        edtValor := TJvDBCalcEdit.Create(Self);
        AjustaComponente( edtValor, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);
        edtValor.DataSource := dsCadastro;
        edtValor.DataField := FieldByName('nome_campo').AsString;

        if FieldByName('app_formato').AsString <> '' then
          edtValor.DisplayFormat := FieldByName('app_formato').AsString;


        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              edtValor.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              edtValor.SetFocus;
        end;

        MontaTitulo(Value,edtValor,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          edtValor.Font.Color := clBlue;
      end;

    //******************************************************************************
      if (FieldByName('tipo_campo').AsString = 'date') or (FieldByName('tipo_campo').AsString = 'datetime')  then //data
      begin
        edtData := TJvDBDateEdit.Create(Self);
        edtData.DialogTitle := 'Selecione uma data';
        AjustaComponente( edtData, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);
        edtData.DataSource := dsCadastro;
        edtData.DataField := FieldByName('nome_campo').AsString;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              edtData.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              edtData.SetFocus;
        end;
        MontaTitulo(Value,edtData,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          edtData.Font.Color := clBlue;
      end;

      //******************************************************************************
      if (FieldByName('tipo_campo').AsString = 'bit')   then
      begin
        edtCheck := TJvDBCheckBox.Create(Self);
        AjustaComponente( edtCheck, ViLeft, 25, ViTop,FieldByName('app_titulo_largura').AsInteger,Value,FieldByName('app_bloq_edit').AsBoolean,FieldByName('app_bloq_insert').AsBoolean);

        edtCheck.DataSource := dsCadastro;
        edtCheck.DataField := FieldByName('nome_campo').AsString;

        if (FieldByName('foco_inicial').AsString.Trim = FieldByName('nome_campo').AsString.Trim) then
        begin
          if cdsCadastro.State in [dsEdit] then
            if not FieldByName('app_bloq_edit').AsBoolean then
              edtCheck.SetFocus;

          if cdsCadastro.State in [dsInsert] then
            if not FieldByName('app_bloq_insert').AsBoolean then
              edtCheck.SetFocus;
        end;

        MontaTitulo(Value,edtCheck,ViLeftTitulo,ViTopTitulo,FieldByName('app_titulo').AsString,FieldByName('app_obrigatorio').AsBoolean,FieldByName('nome_campo').AsString);

        if FieldByName('app_obrigatorio').AsBoolean then
          edtCheck.Font.Color := clBlue;
      end;
      //******************************************************************************
    end;
    dsFields.DataSet.Next;
  end;
  dsFields.DataSet.Filtered := False;
end;

procedure TFrmCadastro.pAjustarGrid(Tabela: string; grid: TJvDBGrid);
var
  i: Integer;
  j: Integer;
begin
  dsFields.DataSet.Filter :='nome_tabela = ' + QuotedStr(Tabela)
    + 'and app_visivel_consulta = ' + QuotedStr('1');

  dsFields.DataSet.Filtered := True;
  dsFields.DataSet.First;

  for j := 0 to grid.Columns.Count-1 do
    grid.Columns[j].Visible := False;

  while not dsFields.DataSet.Eof do
  begin
    for i := 0 to grid.Columns.Count - 1 do
    begin
      if (grid.Columns[i].FieldName = dsFields.DataSet.FieldByName('nome_campo').AsString) or
         (grid.Columns[i].FieldName = dsFields.DataSet.FieldByName('app_lista_tabela').AsString+'_'+dsFields.DataSet.FieldByName('app_lista_campo_display').AsString)
      then
      begin
        grid.Columns[i].Width := StrToIntDef(dsFields.DataSet.FieldByName('app_titulo_largura').AsString,100);
        grid.Columns[i].Title.Caption := dsFields.DataSet.FieldByName('app_titulo').AsString;
        grid.Columns[I].Visible := dsFields.DataSet.FieldByName('app_visivel_consulta').AsBoolean;
        grid.Columns[i].Title.Alignment := TAlignment(dsFields.DataSet.FieldByName('app_titulo_alinhamento').AsInteger);
        if dsFields.DataSet.FieldByName('app_campo_senha').AsBoolean then
          grid.Columns[I].Visible := False;

        if (dsFields.DataSet.FieldByName('chave_primaria').AsBoolean) then//and (not dsFields.DataSet.FieldByName('app_visivel_consulta').AsBoolean) then
          grid.Columns[I].Visible := False;
        Break;
      end;
    end;
    dsFields.DataSet.Next;
  end;
end;

procedure TFrmCadastro.pMontaGuiaFilhas(Tabela: string; Pagina: TPageControl);
var
  pnldet : TPanel;
  i : integer;
  cds : TClientDataSet;
  ds : TDataSource;
  VsAux  : string;
  ViCodigo : integer;
  dbNav : TDBNavigator;
  Guia : TTabSheet;
  scbx : TScrollBox;
  vsTabela : string;
  Foto : TJvDBImage;
  vsBlob : string;
begin
  vsTabela := '';
  mr1.Close;
  mr1.ParamByName('pTabela').AsString := Tabela;
  mr1.ExecuteMethod;
  cdsTabelaDetalhe.Close;
  cdsTabelaDetalhe.Open;


  while not cdsTabelaDetalhe.Eof do
  begin
    vsTabela :=cdsTabelaDetalhe.FieldByName('tabela_f').AsString;
    Guia          := TTabSheet.Create(Pagina);
    Guia.Caption  := cdsTabelaDetalhe.FieldByName('guia_nome').AsString;
    Guia.Name     :='ts'+ cdsTabelaDetalhe.FieldByName('tabela_f').AsString+cdsTabelaDetalhe.FieldByName('guia_ordem').AsString;
    Guia.PageControl  := Pagina;
    Guia.AlignWithMargins := True;

    scbx := TScrollBox.Create(Guia);
    scbx.BevelKind := bkFlat;
    scbx.BorderStyle := bsNone;
    scbx.Name := 'scbx'+cdsTabelaDetalhe.FieldByName('tabela_f').AsString + cdsTabelaDetalhe.FieldByName('guia_ordem').AsString;
    scbx.Parent := Guia;
    scbx.Align := alClient;

    if cdsCadastro.State in [dsInsert] then
      scbx.Enabled := False;

    cds := TClientDataSet.Create(self);
    cds.RemoteServer := DM.ProviderConnection;
    cds.Name := 'cds'+vsTabela;
    cds.Close;


    mr2.ParamByName('pNomeTabela').AsString := vsTabela;
    mr2.ParamByName('pOrderBy').AsString := vsAux;
    mr2.ParamByName('pCampoF').AsString := cdsTabelaDetalhe.FieldByName('campo_f').AsString;
    mr2.ParamByName('pValorCampo').AsInteger :=
    cdsCadastro.FieldByName(cdsTabelaDetalhe.FieldByName('nome_campo').AsString).AsInteger;
    mr2.ParamByName('pNomeqry').AsString := 'qrydet'+vsTabela;
    mr2.ParamByName('pNomedsp').AsString := 'dspdet'+vsTabela;
    mr2.ParamByName('Dicionario').AsBoolean := True;
    mr2.ParamByName('pSQL').AsString := '';
    mr2.ExecuteMethod;


    cds.ProviderName := 'dspdet'+vsTabela;
    cds.Open();

    Formatarcds(vsTabela, cds);
    ds := TDataSource.Create(Self);
    ds.DataSet := cds;

    pnldet := TPanel.Create(self);
    pnldet.Parent := scbx;
    pnldet.Align := alTop;
    pnldet.Height := 35;

    VsAux := vsTabela+'|'+cds.Name + '|'+cdsTabelaDetalhe.FieldByName('campo_f').AsString+'|'+cdsTabelaDetalhe.FieldByName('nome_campo').AsString;
    ViCodigo := cdsCadastro.FieldByName(cdsTabelaDetalhe.FieldByName('nome_campo').AsString).AsInteger;

    CriaBotaoDetalhe('Novo',3,VsAux,ViCodigo, pnldet,btnDetNovoClick);
    CriaBotaoDetalhe('Editar',125,VsAux,ViCodigo, pnldet,btnDetEditarClick);
    CriaBotaoDetalhe('Excluir',246,VsAux,ViCodigo, pnldet,btnDetExcluirClick);


    dbNav := TDBNavigator.Create(self);
    dbNav.DataSource := ds;
    dbNav.Align := alBottom;
    dbNav.Parent := scbx;
    dbNav.VisibleButtons := [nbPrior, nbNext, nbFirst, nbLast];

    CriaGridDetalhe(scbx,ds,vsTabela);

   // vsBlob := pPossuiFoto( Tabela );
    if vsBlob <> '' then
    begin
      Foto := TJvDBImage.Create(self);
      Foto.Parent := scbx;
      Foto.DataField := vsBlob;
      Foto.DataSource := DS;
      Foto.Align := alClient;
      Foto.Height :=200;
    end;
    cdsTabelaDetalhe.Next;
  end;
end;

procedure TFrmCadastro.PreencherValorPadrao;
begin
  dsFields.DataSet.Filter :='nome_tabela = ' + QuotedStr(Self.Hint);
  dsFields.DataSet.Filtered := True;
  dsFields.DataSet.First;

  while not dsFields.DataSet.Eof do
  begin
    if dsFields.DataSet.FieldByName('valor_padrao').AsString.Trim <> '' then
    begin
      case AnsiIndexStr(LowerCase(dsFields.DataSet.FieldByName('tipo_campo').AsString.Trim), ['varchar', 'char','int','smallint','bit','decimal','date','datetime']) of
        0,1 :cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsString := dsFields.DataSet.FieldByName('valor_padrao').AsString.Trim;
        2,3: cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsInteger := dsFields.DataSet.FieldByName('valor_padrao').AsInteger;
        4: cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsBoolean := (dsFields.DataSet.FieldByName('valor_padrao').AsInteger = 1);
        5: cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsFloat := dsFields.DataSet.FieldByName('valor_padrao').AsFloat;
        6,7:
        begin
          if dsFields.DataSet.FieldByName('valor_padrao').AsString.Trim = 'date()' then
            cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsDateTime := Date;

          if dsFields.DataSet.FieldByName('valor_padrao').AsString.Trim = 'datetime()' then
            cdsCadastro.FieldByName(dsFields.DataSet.FieldByName('nome_campo').AsString).AsDateTime := Now;
        end;
      end;
    end;
    dsFields.DataSet.Next;
  end;
  dsFields.DataSet.Filtered := False ;
end;
end.
