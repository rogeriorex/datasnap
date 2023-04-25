unit DS.Client.Model.Data;

interface

uses
  DS.Client.Model.Data.Interfaces, FireDAC.Comp.DataSet, REST.Types;

type
  TClientModelData = class(TInterfacedObject, IClientModelData)
  public
    class function New: IClientModelData;
    function OpenBank: IFDDataSetReference;
    function InsertBank(const StringJson: string): IClientModelData;
    function PostBank(const ID: string; const StringJson: string): IClientModelData;
    function DeleteBank(const ID: string): IClientModelData;
  private
    FMsg: string;
  end;

implementation

{ TClientModelData }

uses DS.Client.Model.Singleton, DS.Client.Model.Consts, System.SysUtils;

class function TClientModelData.New: IClientModelData;
begin
  Result := Self.Create;
end;

function TClientModelData.OpenBank: IFDDataSetReference;
var
  Singleton: TSingleton;
begin
  try
    Singleton := TSingleton.Get;
    Singleton.REST.baseurl := CONST_REST_BASEURL;
    Singleton.Request.Params.Clear;
    Singleton.Request.Resource := CONST_REQUEST_BANK_RESOURCE;
    Singleton.Request.Method := rmGET;
    Singleton.Adapter.DataSet := Singleton.MemTable;
    Singleton.Request.execute;
    Result := Singleton.MemTable.Data;
    Singleton.Adapter.DataSet := nil;
  except
    FMsg := CONST_SENDFILE_ERROR_EXECUTE;
  end;
end;

function TClientModelData.InsertBank(const StringJson: string): IClientModelData;
var
  Singleton: TSingleton;
begin
  try
    Result := Self;
    Singleton := TSingleton.Get;
    Singleton.REST.baseurl := CONST_REST_BASEURL;
    Singleton.Request.Params.AddItem(
      CONST_REQUEST_JSONBODY,
      StringJson,
      TRESTRequestParameterKind.pkREQUESTBODY,
      [poDoNotEncode],
      ctAPPLICATION_JSON
    );
    Singleton.Request.Resource := CONST_REQUEST_BANK_RESOURCE_INSERT;
    Singleton.Request.Method := rmPUT;
    Singleton.Request.execute;
  except
    FMsg := CONST_SENDFILE_ERROR_EXECUTE;
  end;
end;

function TClientModelData.PostBank(const ID: string; const StringJson: string): IClientModelData;
var
  Singleton: TSingleton;
begin
  try
    Result := Self;
    Singleton := TSingleton.Get;
    Singleton.REST.baseurl := CONST_REST_BASEURL;
    Singleton.Request.Params.AddItem(
      CONST_REQUEST_JSONBODY,
      StringJson,
      TRESTRequestParameterKind.pkREQUESTBODY,
      [poDoNotEncode],
      ctAPPLICATION_JSON
    );
    Singleton.Request.Resource := Format(CONST_REQUEST_BANK_RESOURCE_POST, [ID]);
    Singleton.Request.Method := rmPOST;
    Singleton.Request.execute;
  except
    FMsg := CONST_SENDFILE_ERROR_EXECUTE;
  end;
end;

function TClientModelData.DeleteBank(const ID: string): IClientModelData;
var
  Singleton: TSingleton;
begin
  try
    Result := Self;
    Singleton := TSingleton.Get;
    Singleton.REST.baseurl := CONST_REST_BASEURL;
    Singleton.Request.Params.Clear;
    Singleton.Request.Resource := Format(CONST_REQUEST_BANK_RESOURCE_DELETE, [ID]);
    Singleton.Request.Method := rmDelete;
    Singleton.Request.execute;
  except
    FMsg := CONST_SENDFILE_ERROR_EXECUTE;
  end;
end;

end.
