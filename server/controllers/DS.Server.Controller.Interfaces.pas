unit DS.Server.Controller.Interfaces;

interface

uses
  System.JSON;

type
  IServerController = interface
    ['{04C28AE6-A4CD-41E1-8238-7D390A04C1D2}']
    function UpdateImportar(const JSONObject: TJSONObject): boolean;
    function Cadastro(const ID: string): TJsonArray;
    function AcceptCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
    function UpdateCadastro(const ID: string; const JsonObject: TJsonObject): boolean;
    function CancelCadastro(const ID: string): boolean;
  end;

implementation

end.
