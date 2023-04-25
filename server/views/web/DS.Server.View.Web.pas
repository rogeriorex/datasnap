unit DS.Server.View.Web;

interface

uses
  System.SysUtils, IPPeerServer, System.JSON, Data.DBXCommon,
  Datasnap.DSCommonServer, Datasnap.DSServer, Datasnap.DSHTTP,
  Datasnap.DSHTTPWebBroker, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher: TDSHTTPWebDispatcher;
    DSServer: TDSServer;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSHTTPWebDispatcherFormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses DS.Server.View.Method, Web.WebReq, DS.Server.View.Config.Consts;

procedure TWebModule1.DSHTTPWebDispatcherFormatResult(Sender: TObject;
  var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
var
  JSONValue: TJSONValue;
begin
  if Pos(CONST_ARRAY_VAZIO, ResultVal.ToJSON()) > 0 then
    Exit;

  JSONValue := ResultVal;
  try
    ResultVal := TJSONArray(JSONValue).Remove(0);
  finally
    JSONValue.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := DS.Server.View.Method.TPessoa;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

