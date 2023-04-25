unit DS.Server.Model.Entity.Factory;

interface

uses
  DS.Server.Model.Entity.Pessoa, System.Classes, DS.Server.Model.Entity.Factory.Interfaces;

type
  TModelEntityFactory = class(TInterfacedObject, IModelEntityFactory)
    private
      FdmEntityPessoa: TdmEntityPessoa;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IModelEntityFactory;
      function Pessoa: TdmEntityPessoa;
  end;

implementation

{ TModelEntityFactory }

constructor TModelEntityFactory.Create;
begin
  FdmEntityPessoa := TdmEntityPessoa.Create(nil);
end;

destructor TModelEntityFactory.Destroy;
begin
  FdmEntityPessoa.Free;
  inherited;
end;

class function TModelEntityFactory.New: IModelEntityFactory;
begin
  Result := Self.Create;
end;

function TModelEntityFactory.Pessoa: TdmEntityPessoa;
begin
  Result := FdmEntityPessoa;
end;

end.
