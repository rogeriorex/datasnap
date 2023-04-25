unit DS.Server.View.Principal;

interface

uses
  Winapi.Windows, Data.DB, System.Classes, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Forms, FireDAC.Comp.Client;

type
  TPrepareLayoutForm = (ImportFile, DataSnapBank);
  TfrmPrincipal = class(TForm)
    Grid: TDBGrid;
    pnlInfo: TPanel;
    lblInfoTitulo: TLabel;
    lblInfo: TLabel;
    btnOpenNewFile: TButton;
    btnSendNewFile: TButton;
    btnOpenBank: TButton;
    btnInserBank: TButton;
    btnEditBank: TButton;
    btnDeleteBank: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OpenNewFile(Sender: TObject);
    procedure SendNewFile(Sender: TObject);
    procedure OpenBank(Sender: TObject);
    procedure InsertBank(Sender: TObject);
    procedure EditBank(Sender: TObject);
    procedure DeleteBank(Sender: TObject);
  private
    FMemTable: TFDMemTable;
    FDataSource: TDataSource;
    FPrepareLayoutForm: TPrepareLayoutForm;
    procedure SetPrepareLayoutForm(const Value: TPrepareLayoutForm);
    property PrepareLayoutForm: TPrepareLayoutForm read FPrepareLayoutForm write SetPrepareLayoutForm;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  System.JSON, DataSetConverter4D.Helper, DataSetConverter4D.Impl, DS.Client.Controller, Vcl.Dialogs,
  System.SysUtils, System.UITypes, DS.Client.View.Consts;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FMemTable := TFDMemTable.Create(Self);

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FMemTable;
  FDataSource.AutoEdit := true;

  Grid.DataSource := FDataSource;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FDataSource.Free;
  FMemTable.Free;
end;

procedure TfrmPrincipal.OpenNewFile(Sender: TObject);
begin
  FMemTable.Close;
  FMemTable.Data := TClientController.New.OpenNewFile;
  PrepareLayoutForm := ImportFile;
end;

procedure TfrmPrincipal.SendNewFile(Sender: TObject);
var
  Msg: string;
begin
  if (not FMemTable.Active) or (FMemTable.RecordCount = 0) then
    Exit;

  Msg := TClientController.New.SendNewFile(FMemTable.Data);
  MessageDlg(Msg, mtInformation, [mbOk],0);
end;

procedure TfrmPrincipal.OpenBank(Sender: TObject);
begin
  FMemTable.Close;
  FMemTable.Data := TClientController.New.OpenBank;
  PrepareLayoutForm := DataSnapBank;
end;

procedure TfrmPrincipal.InsertBank(Sender: TObject);
var
  JSONObject: TJSONObject;
begin
  if not (FMemTable.State = dsInsert) then
    Exit;

  JSONObject := FMemTable.AsJSONObject;
  try
    TClientController.New.InsertBank(JSONObject.ToString);
    FMemTable.Post;
  finally
    JSONObject.Free;
  end;
end;

procedure TfrmPrincipal.EditBank(Sender: TObject);
var
  JSONObject: TJSONObject;
begin
  if not (FMemTable.State = dsEdit) then
    Exit;

  JSONObject := FMemTable.AsJSONObject;
  try
    TClientController.New.PostBank(FMemTable.Fields[0].AsString, JSONObject.ToString);
    FMemTable.Post;
  finally
    JSONObject.Free;
  end;
end;

procedure TfrmPrincipal.DeleteBank(Sender: TObject);
begin
  if not (MessageDlg(Format(CONST_MSG_DELETE_DATASNAP,[FMemTable.Fields[0].AsInteger]), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    Exit;

  TClientController.New.DeleteBank(FMemTable.Fields[0].AsString);
  FMemTable.Delete;
end;

procedure TfrmPrincipal.SetPrepareLayoutForm(const Value: TPrepareLayoutForm);
var
  I, Size: integer;
  LayoutImportFile: boolean;
begin
  FPrepareLayoutForm := Value;

  LayoutImportFile := Value = ImportFile;
  btnSendNewFile.Enabled := LayoutImportFile;
  btnInserBank.Enabled := not LayoutImportFile;
  btnEditBank.Enabled := not LayoutImportFile;
  btnDeleteBank.Enabled := not LayoutImportFile;

  Size := Trunc((Grid.Width - CONST_WIDTH_SCROLL_GRID) / Grid.Columns.Count);
  for I := 0 to Pred(Grid.Columns.Count) do
    Grid.Columns[I].Width := Size;
end;

end.
