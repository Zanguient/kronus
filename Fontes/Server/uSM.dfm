object SM: TSM
  OldCreateOrder = False
  Height = 496
  Width = 709
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 64
    Top = 32
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=cinkocom_KRONUS'
      'User_Name=cinkocom'
      'Password=CI5458OM'
      'Server=www.cinko.com.br'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 208
  end
  object QryConsulta: TFDQuery
    Connection = FDConnection1
    Left = 304
    Top = 24
  end
  object dspConsulta: TDataSetProvider
    DataSet = QryConsulta
    Options = [poFetchDetailsOnDemand, poUseQuoteChar]
    Left = 288
    Top = 88
  end
  object QryCadastro: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from unidade')
    Left = 408
    Top = 32
  end
  object dspCadastro: TDataSetProvider
    DataSet = QryCadastro
    Left = 400
    Top = 88
  end
  object QryLkp: TFDQuery
    Connection = FDConnection1
    Left = 504
    Top = 32
  end
  object dspLkp: TDataSetProvider
    DataSet = QryLkp
    Left = 512
    Top = 96
  end
  object FDSQLite: TFDConnection
    Params.Strings = (
      'Database=C:\kronus\Sistema.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 360
  end
  object QrySys_Table: TFDQuery
    Connection = FDSQLite
    SQL.Strings = (
      'SELECT * from sys_tabela order by nome_tabela')
    Left = 144
    Top = 328
  end
  object QrySys_Field: TFDQuery
    Connection = FDSQLite
    SQL.Strings = (
      'select * from sys_campo order by nome_tabela,ordem')
    Left = 144
    Top = 400
  end
  object dspSys_Table: TDataSetProvider
    DataSet = QrySys_Table
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 264
    Top = 336
  end
  object dspSys_Field: TDataSetProvider
    DataSet = QrySys_Field
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 264
    Top = 408
  end
  object dspDicionario: TDataSetProvider
    DataSet = QryDicionario
    Left = 264
    Top = 272
  end
  object QryDicionario: TFDQuery
    Connection = FDSQLite
    Left = 144
    Top = 264
  end
  object QryCampos: TFDQuery
    Connection = FDSQLite
    Left = 400
    Top = 184
  end
  object QryGuia: TFDQuery
    Connection = FDSQLite
    SQL.Strings = (
      'select distinct guia_nome from sys_campo'
      'where nome_tabela =:ParamTabela')
    Left = 136
    Top = 216
    ParamData = <
      item
        Name = 'PARAMTABELA'
        ParamType = ptInput
      end>
  end
  object dspGuia: TDataSetProvider
    DataSet = QryGuia
    Left = 272
    Top = 192
  end
  object qyLkpTables: TFDQuery
    Connection = FDSQLite
    SQL.Strings = (
      'select * from sys_campo order by nome_tabela,ordem')
    Left = 480
    Top = 216
  end
  object dspLkpTables: TDataSetProvider
    DataSet = qyLkpTables
    Left = 568
    Top = 192
  end
  object qyAux: TFDQuery
    Connection = FDConnection1
    Left = 584
    Top = 56
  end
  object qryTableDetalhe: TFDQuery
    Connection = FDSQLite
    SQL.Strings = (
      'select * from sys_detalhe')
    Left = 376
    Top = 288
  end
  object dspTableDetalhe: TDataSetProvider
    DataSet = qryTableDetalhe
    Left = 512
    Top = 296
  end
  object qryDicAux: TFDQuery
    Connection = FDSQLite
    Left = 424
    Top = 368
  end
end
