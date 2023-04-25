unit DS.Server.Model.Connection;

interface

uses
  System.SysUtils, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, System.Classes, FireDAC.Comp.UI;

type
  TdmModelConnection = class(TDataModule)
    WaitCursor: TFDGUIxWaitCursor;
    PgDriver: TFDPhysPgDriverLink;
    PGConnection: TFDConnection;
  end;

var
  dmModelConnection: TdmModelConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
