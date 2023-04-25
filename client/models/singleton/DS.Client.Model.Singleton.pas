unit DS.Client.Model.Singleton;

interface

uses
  Vcl.Dialogs, REST.Client, REST.Response.Adapter, FireDAC.Comp.Client;

type
  TSingleton = class
  private
    FDMemTable: TFDMemTable;
    FOpenDialog: TOpenDialog;
    FREST: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FAdapter: TRESTResponseDataSetAdapter;
    class var FInstance: TSingleton;
  public
    constructor Create;
    destructor Destroy; override;
    class function Get: TSingleton;
    class procedure ReleaseInstance;
    property MemTable: TFDMemTable read FDMemTable;
    property OpenDialog: TOpenDialog read FOpenDialog;
    property REST: TRESTClient read FREST;
    property Request: TRESTRequest read FRequest;
    property Response: TRESTResponse read FResponse;
    property Adapter: TRESTResponseDataSetAdapter read FAdapter;
    procedure DataSetImport;

  end;

implementation

{ TSingleton }

uses DS.Client.Model.Consts, Data.DB, REST.Types, System.SysUtils;

constructor TSingleton.Create;
begin
  inherited;
  FDMemTable := TFDMemTable.Create(nil);
  DataSetImport;

  FOpenDialog := TOpenDialog.Create(nil);
  FOpenDialog.Filter := CONST_OPENDIALOG_FILTER;
  FOpenDialog.Options := [ofReadOnly, ofHideReadOnly, ofEnableSizing];
  FOpenDialog.Title := CONST_OPENDIALOG_TITLE;

  FREST := TRESTClient.Create(nil);
  FREST.ResetToDefaults;
  FREST.Accept := CONST_REST_ACCEPT;
  FREST.AcceptCharset := CONST_REST_ACCEPTCHARSET;
  FREST.baseurl := CONST_REST_BASEURL;
  FREST.ContentType := CONST_REST_CONTENRTYPE;
  FREST.HandleRedirects := true;
  FREST.RaiseExceptionOn500 := false;

  FResponse := TRESTResponse.Create(nil);
  FResponse.ResetToDefaults;

  FRequest := TRESTRequest.Create(nil);
  FRequest.ResetToDefaults;
  FRequest.Client := FREST;
  FRequest.Response := FResponse;
  FRequest.Method := rmPOST;
  FRequest.SynchronizedEvents := false;

  FAdapter := TRESTResponseDataSetAdapter.Create(nil);
  FAdapter.Response := FResponse;
end;

procedure TSingleton.DataSetImport;
begin
  FDMemTable.Close;
  FDMemTable.FieldDefs.Clear;
  FDMemTable.FieldDefs.Add(CONST_FIELD_IDPESSOA, ftInteger);
  FDMemTable.FieldDefs.Add(CONST_FIELD_FLNATUREZA, ftInteger);
  FDMemTable.FieldDefs.Add(CONST_FIELD_DSDOCUMENTO, ftString, CONST_SIZE_FIELD_DSDOCUMENTO);
  FDMemTable.FieldDefs.Add(CONST_FIELD_NMPRIMEIRO, ftString, CONST_SIZE_FIELD_NMPRIMEIRO);
  FDMemTable.FieldDefs.Add(CONST_FIELD_NMSEGUNDO, ftString, CONST_SIZE_FIELD_NMSEGUNDO);
  FDMemTable.FieldDefs.Add(CONST_FIELD_DTREGISTRO, ftDate);
  FDMemTable.FieldDefs.Add(CONST_FIELD_DSCEP, ftString, CONST_SIZE_FIELD_DSCEP);
  FDMemTable.Open;
end;

destructor TSingleton.Destroy;
begin
  inherited;
end;

class function TSingleton.Get: TSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TSingleton.Create;
  Result := FInstance;
end;

class procedure TSingleton.ReleaseInstance;
begin
  if Assigned(FInstance) then
  begin
    FInstance.FDMemTable.Close;
    FreeAndNil(FInstance.FDMemTable);

    FreeAndNil(FInstance.FOpenDialog);

    FInstance.FRequest.Client := nil;
    FInstance.FRequest.Response := nil;
    FreeAndNil(FInstance.FRequest);

    FreeAndNil(FInstance.FResponse);

    FreeAndNil(FInstance.FREST);

    FreeAndNil(FInstance.FAdapter);

    FreeAndNil(FInstance);
  end;
end;

end.
