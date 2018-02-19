unit uSC;

interface

uses System.SysUtils, System.Classes,
    Vcl.SvcMgr,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer;

type
  TsvcKronusServer = class(TService)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  protected
    function DoStop: Boolean; override;
    function DoPause: Boolean; override;
    function DoContinue: Boolean; override;
    procedure DoInterrogate; override;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  svcKronusServer: TsvcKronusServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

uses Winapi.Windows, uSM;

procedure TsvcKronusServer.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uSM.TSM;
end;


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  svcKronusServer.Controller(CtrlCode);
end;

function TsvcKronusServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function TsvcKronusServer.DoContinue: Boolean;
begin
  Result := inherited;
  DSServer1.Start;
end;

procedure TsvcKronusServer.DoInterrogate;
begin
  inherited;
end;

function TsvcKronusServer.DoPause: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

function TsvcKronusServer.DoStop: Boolean;
begin
  DSServer1.Stop;
  Result := inherited;
end;

procedure TsvcKronusServer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  DSServer1.Start;
end;
end.

