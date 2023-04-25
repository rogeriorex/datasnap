unit DS.Server.View.Config;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, IdHTTPWebBrokerBridge;

type
  TfrmViewConfig = class(TForm)
    btnStart: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StartServer(Sender: TObject);
  public
    procedure Start;
    procedure Stop;
  private
    FServer: TIdHTTPWebBrokerBridge;
  end;

var
  frmViewConfig: TfrmViewConfig;

implementation

{$R *.dfm}

uses
  Datasnap.DSSession, DS.Server.View.Config.Consts;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TfrmViewConfig.Start;
begin
    FServer.Bindings.Clear;
    FServer.Active := True;
    btnStart.Caption := CONST_BUTTON_STOP;
end;

procedure TfrmViewConfig.Stop;
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
  btnStart.Caption := CONST_BUTTON_START;
end;

procedure TfrmViewConfig.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  FServer.DefaultPort := CONST_PORT_SERVICE;
  Start;
end;

procedure TfrmViewConfig.StartServer(Sender: TObject);
begin
  if FServer.Active then
    Stop
  else
    Start;
end;

end.
