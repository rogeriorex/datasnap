unit DS.Client.Controller;

interface

uses
  FireDAC.Comp.DataSet, DS.Client.Controller.Interfaces, System.JSON;

type
  TClientController = class(TInterfacedObject, IClientController)
  public
    class function New: IClientController;
    function OpenNewFile: IFDDataSetReference;
    function SendNewFile(const Data: IFDDataSetReference): string;
    function OpenBank: IFDDataSetReference;
    function InsertBank(const StringJson: string): boolean;
    function PostBank(const ID: string; const StringJson: string): boolean;
    function DeleteBank(const ID: string): boolean;
  end;

implementation

uses
  DS.Client.Model.Import, DS.Client.Model.Data;

{ TControllerImport }

class function TClientController.New: IClientController;
begin
  Result := Self.Create;
end;

function TClientController.OpenNewFile: IFDDataSetReference;
begin
  Result := TClientModelImport.New.OpenNewFile;
end;

function TClientController.SendNewFile(const Data: IFDDataSetReference): string;
begin
  Result := TClientModelImport.New.SendNewFile(Data);
end;

function TClientController.OpenBank: IFDDataSetReference;
begin
  Result := TClientModelData.New.OpenBank;
end;

function TClientController.InsertBank(const StringJson: string): boolean;
begin
  Result := true;
  TClientModelData.New.InsertBank(StringJson);
end;

function TClientController.PostBank(const ID: string; const StringJson: string): boolean;
begin
  Result := true;
  TClientModelData.New.PostBank(ID, StringJson);
end;

function TClientController.DeleteBank(const ID: string): boolean;
begin
  Result := true;
  TClientModelData.New.DeleteBank(ID);
end;

end.
