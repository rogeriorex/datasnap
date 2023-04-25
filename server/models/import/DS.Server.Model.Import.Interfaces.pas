unit DS.Server.Model.Import.Interfaces;

interface

uses
  System.JSON;

type
  IModelImport = interface
    ['{91A088F6-AD0C-4B8A-82F1-3E38FCD1E8F3}']
    function Post(JSONObject: TJSONObject): boolean;
  end;

implementation

end.
