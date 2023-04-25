unit DS.Server.Model.Entity.Factory.Interfaces;

interface

uses
 DS.Server.Model.Entity.Pessoa, System.Classes;

type
  IModelEntityFactory = interface
    ['{04C28AE6-A4CD-41E1-8238-7D390A04C1D2}']
    function Pessoa: TdmEntityPessoa;
  end;

implementation

end.
