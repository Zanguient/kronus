program KronusServer;

uses
  Vcl.SvcMgr,
  uSM in 'Fontes\Server\uSM.pas' {SM: TDSServerModule},
  uSC in 'Fontes\Server\uSC.pas' {svcKronusServer: TService},
  Sys.Functions in 'Fontes\Client\Functions\Sys.Functions.pas';

{$R *.RES}

begin
  //Roda como serviço do windows
  //para instalar /install
  if not Application.DelayInitialize or Application.Installing then
  Application.Initialize;
  Application.CreateForm(TsvcKronusServer, svcKronusServer);
  Application.Run;
end.

