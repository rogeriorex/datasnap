unit DS.Server.Model.Entity.Pessoa;

interface

uses
  System.JSON, DataSetConverter4D.Helper, DataSetConverter4D.Impl, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.Classes, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmEntityPessoa = class(TDataModule)
    qryPessoa: TFDQuery;
  public
    function Get(const ID: string): TJsonArray;
    function Put(const ID: string; const JsonObject: TJsonObject): TdmEntityPessoa;
    function Post(const ID: string; const JsonObject: TJsonObject): TdmEntityPessoa;
    function Delete(const ID: string): TdmEntityPessoa;
  private
    IDPessoa: integer;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  DS.Server.Model.Entity.Pessoa.Consts, System.SysUtils;

{$R *.dfm}

{ TdmEntityPessoa }

function TdmEntityPessoa.Get(const ID: string): TJsonArray;
var
  JsonArray: TJSONArray;
begin
  qryPessoa.Close;
  qryPessoa.SQL.Text := SQL_PESSOA_GET;
  IDPessoa := StrToIntDef(ID, 0);
  if IDPessoa > 0 then
  begin
    qryPessoa.SQL.Text := SQL_PESSOA_GET_WHERE;
    qryPessoa.ParamByName(CONST_PARAMETER_ID).AsInteger := IDPessoa;
  end;
  qryPessoa.Open;
  if qryPessoa.RecordCount = 0 then
  begin
    Result := nil;
    Exit;
  end;
  JsonArray := qryPessoa.AsJSONArray;
  try
    Result := JsonArray.Clone as TJSONArray;
  finally
    JsonArray.Free;
  end;
end;

function TdmEntityPessoa.Put(const ID: string; const JsonObject: TJsonObject): TdmEntityPessoa;
begin
  Result := Self;
  try
    qryPessoa.Close;
    qryPessoa.SQL.Text := SQL_PESSOA_PUT;
    qryPessoa.Open;
    qryPessoa.FromJSONObject(JsonObject);
    qryPessoa.ApplyUpdates(CONST_PARAMETER_APPLY_UPDATE);
  except
    Result := nil;
  end;
end;

function TdmEntityPessoa.Post(const ID: string; const JsonObject: TJsonObject): TdmEntityPessoa;
begin
  Result := Self;
  try
    qryPessoa.Close;
    IDPessoa := StrToIntDef(ID, 0);
    qryPessoa.SQL.Text := qryPessoa.SQL.Text + SQL_PESSOA_POST;
    qryPessoa.ParamByName(CONST_PARAMETER_ID).AsInteger := IDPessoa;
    qryPessoa.Open;
    if qryPessoa.RecordCount = 0 then
    begin
      Result := nil;
      Exit;
    end;
    qryPessoa.RecordFromJSONObject(JsonObject);
    qryPessoa.ApplyUpdates(CONST_PARAMETER_APPLY_UPDATE);
  except
    Result := nil;
  end;
end;

function TdmEntityPessoa.Delete(const ID: string): TdmEntityPessoa;
begin
  Result := Self;
  try
    qryPessoa.Close;
    IDPessoa := StrToIntDef(ID, 0);
    qryPessoa.SQL.Text := SQL_PESSOA_DELETE;
    qryPessoa.ParamByName(CONST_PARAMETER_ID).AsInteger := IDPessoa;
    qryPessoa.ExecSQL;
  except
    Result := nil;
  end;
end;

end.
