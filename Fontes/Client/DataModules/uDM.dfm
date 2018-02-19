object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 361
  Width = 421
  object SnapserverConnection: TSQLConnection
    ConnectionName = 'SnapServer'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=DataSnap'
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=21.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 66
    Top = 25
  end
  object ProviderConnection: TDSProviderConnection
    ServerClassName = 'TSM'
    SQLConnection = SnapserverConnection
    Left = 64
    Top = 104
  end
  object cdsDicionario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDicionario'
    RemoteServer = ProviderConnection
    Left = 64
    Top = 168
  end
  object mr1: TSqlServerMethod
    Params = <>
    SQLConnection = SnapserverConnection
    ServerMethodName = 'TSM.CriarDataset'
    Left = 245
    Top = 192
  end
end
