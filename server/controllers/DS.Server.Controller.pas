unit DS.Server.Controller;

interface

uses
  DS.Server.Controller.Interfaces, System.JSON;

type
  TServerController = class(TInterfacedObject, IServerController)
  public
    class function New: IServerController;
    function UpdateImportar(const JSONObject: TJSONObject): boolean;
    function Cadastro(const ID: string): TJsonArray;
    function AcceptCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
    function UpdateCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
    function CancelCadastro(const ID: string): boolean;
  end;

implementation

uses
  DS.Server.Model.Import, DS.Server.Model.Entity.Factory;

{ TServerController }

class function TServerController.New: IServerController;
begin
  Result := Self.Create;
end;

function TServerController.UpdateImportar(const JSONObject: TJSONObject): boolean;
begin
  Result := TModelImport.New.Post(JSONObject);
end;

function TServerController.Cadastro(const ID: string): TJsonArray;
begin
  Result := TModelEntityFactory.New.Pessoa.Get(ID);
end;

function TServerController.AcceptCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
begin
  Result := Assigned(TModelEntityFactory.New.Pessoa.Put(ID, JsonObject));
end;

function TServerController.UpdateCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
begin
  Result := Assigned(TModelEntityFactory.New.Pessoa.Post(ID, JsonObject));
end;

function TServerController.CancelCadastro(const ID: string): boolean;
begin
  Result := Assigned(TModelEntityFactory.New.Pessoa.Delete(ID));
end;

end.
