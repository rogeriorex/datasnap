unit DS.Client.Model.Data.Interfaces;

interface

uses
  FireDAC.Comp.DataSet;

type
  IClientModelData = interface
    ['{D9C9A7A8-1996-4E36-9367-CFCA21E40CD1}']

    function OpenBank: IFDDataSetReference;
    function InsertBank(const StringJson: string): IClientModelData;
    function PostBank(const ID: string; const StringJson: string): IClientModelData;
    function DeleteBank(const ID: string): IClientModelData;

  end;

implementation

end.
