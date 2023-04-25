unit DS.Server.View.Method;

interface

uses
  System.JSON, DataSnap.DSProviderDataModuleAdapter;

type
  TPessoa = class(TDSServerModule)
  public
    function UpdateImportar(JSONObject: TJSONObject): boolean;
    function Cadastro(const ID: string): TJsonArray;
    procedure acceptCadastro(const ID: string; const JsonObject: TJsonObject);
    procedure updateCadastro(const ID: string; JsonObject: TJsonObject);
    procedure cancelCadastro(const ID: string);
  end;

implementation

uses
  DS.Server.Controller;

{$R *.dfm}

function TPessoa.Cadastro(const ID: string): TJsonArray;
begin
  Result := TServerController.New.Cadastro(ID);
end;

procedure TPessoa.acceptCadastro(const ID: string; const JsonObject: TJsonObject);
begin
  TServerController.New.acceptCadastro(ID, JSONObject);
end;

procedure TPessoa.updateCadastro(const ID: string; JsonObject: TJsonObject);
begin
  TServerController.New.updateCadastro(ID, JSONObject);
end;

procedure TPessoa.cancelCadastro(const ID: string);
begin
  TServerController.New.cancelCadastro(ID);
end;

function TPessoa.UpdateImportar(JSONObject: TJSONObject): boolean;
begin
  Result := TServerController.New.UpdateImportar(JSONObject);
end;

end.

