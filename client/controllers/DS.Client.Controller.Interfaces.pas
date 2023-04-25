unit DS.Client.Controller.Interfaces;

interface

uses
  FireDAC.Comp.DataSet;

type
  IClientController = interface
    ['{A9B6FFB2-5D21-440E-93CB-3FBCD7C20054}']
    function OpenNewFile: IFDDataSetReference;
    function SendNewFile(const Data: IFDDataSetReference): string;
    function OpenBank: IFDDataSetReference;
    function InsertBank(const StringJson: string): boolean;
    function PostBank(const ID: string; const StringJson: string): boolean;
    function DeleteBank(const ID: string): boolean;
  end;

implementation

end.
