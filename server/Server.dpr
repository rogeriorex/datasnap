program server;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DS.Server.View.Config in 'views\config\DS.Server.View.Config.pas' {frmViewConfig},
  DS.Server.View.Web in 'views\web\DS.Server.View.Web.pas' {WebModule1: TWebModule},
  DS.Server.Model.Connection in 'models\connection\DS.Server.Model.Connection.pas' {dmModelConnection: TDataModule},
  DS.Server.Model.Entity.Pessoa in 'models\entity\DS.Server.Model.Entity.Pessoa.pas' {dmEntityPessoa: TDataModule},
  DS.Server.View.Method in 'views\method\DS.Server.View.Method.pas' {Pessoa: TDSServerModule},
  DS.Server.Model.Import.Consts in 'models\import\DS.Server.Model.Import.Consts.pas',
  DS.Server.Model.Import in 'models\import\DS.Server.Model.Import.pas',
  DS.Server.Model.Import.Interfaces in 'models\import\DS.Server.Model.Import.Interfaces.pas',
  DS.Server.Controller in 'controllers\DS.Server.Controller.pas',
  DS.Server.Controller.Interfaces in 'controllers\DS.Server.Controller.Interfaces.pas',
  DS.Server.Model.Entity.Pessoa.Consts in 'models\entity\DS.Server.Model.Entity.Pessoa.Consts.pas',
  DS.Server.View.Config.Consts in 'views\config\DS.Server.View.Config.Consts.pas',
  DS.Server.Model.Entity.Factory.Interfaces in 'models\factory\DS.Server.Model.Entity.Factory.Interfaces.pas',
  DS.Server.Model.Entity.Factory in 'models\factory\DS.Server.Model.Entity.Factory.pas',
  DS.Server.Model.Import.Future in 'models\import\DS.Server.Model.Import.Future.pas' {dmModelImportFuture: TDataModule},
  DataSetConverter4D.Helper in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Util.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmViewConfig, frmViewConfig);
  Application.CreateForm(TdmModelConnection, dmModelConnection);
  Application.CreateForm(TdmModelImportFuture, dmModelImportFuture);
  Application.Run;
end.
