unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient, Datasnap.DSConnect
  , System.IniFiles
  , Vcl.Dialogs
  , Vcl.Forms
  , MidasLib, Data.FMTBcd
  ;

type
  TDM = class(TDataModule)
    SnapserverConnection: TSQLConnection;
    ProviderConnection: TDSProviderConnection;
    cdsDicionario: TClientDataSet;
    mr1: TSqlServerMethod;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;
  const sysCaption = 'Kronus';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
//  with DM.SnapserverConnection do
//  begin
//    Params.Clear;
//    Params.LoadFromFile('c:\kronus\client.ini');
//    Connected :=True;
//  end;
end;

end.
