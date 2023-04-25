program Client;

uses
  Winapi.Windows,
  Vcl.Forms,
  DS.Server.View.Principal in 'views\principal\DS.Server.View.Principal.pas' {frmPrincipal},
  DS.Client.Model.Import in 'models\import\DS.Client.Model.Import.pas',
  DS.Client.Model.Import.Interfaces in 'models\import\DS.Client.Model.Import.Interfaces.pas',
  DS.Client.Model.Consts in 'models\const\DS.Client.Model.Consts.pas',
  DS.Client.Controller in 'controllers\DS.Client.Controller.pas',
  DS.Client.Controller.Interfaces in 'controllers\DS.Client.Controller.Interfaces.pas',
  DS.Client.Model.Singleton in 'models\singleton\DS.Client.Model.Singleton.pas',
  DS.Client.Model.Data in 'models\data\DS.Client.Model.Data.pas',
  DS.Client.Model.Data.Interfaces in 'models\data\DS.Client.Model.Data.Interfaces.pas',
  DS.Client.View.Consts in 'views\const\DS.Client.View.Consts.pas',
  DataSetConverter4D.Helper in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\external libs\DataSetConverter4Delphi-master\DataSetConverter4D.Util.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
  TSingleton.ReleaseInstance;
end.
