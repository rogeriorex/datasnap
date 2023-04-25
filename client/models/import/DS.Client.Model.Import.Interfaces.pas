unit DS.Client.Model.Import.Interfaces;

interface

uses
  FireDAC.Comp.DataSet;

type
  IClientModelImport = interface
    ['{2DCAAC3A-1476-43CD-A7F6-9B1A0BC11BDA}']

    function OpenNewFile: IFDDataSetReference;
    function SendNewFile(const Data: IFDDataSetReference): string;

  end;

implementation

end.
