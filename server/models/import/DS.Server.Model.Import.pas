unit DS.Server.Model.Import;

interface

uses
  System.Json, System.Classes, DS.Server.Model.Import.Interfaces;

type
  TStep = (GetFile, UnzipFile, RenameUnzipFile);
  TModelImport = class(TInterfacedObject, IModelImport)
  private
    FZipFile: string;
    FCSVFile: string;
    FPath: string;
    FJSONObject: TJSONObject;
    FStep: TStep;
    procedure GetNewFile;
    procedure UnzipNewFile;
    procedure RenameNewFile;
    procedure ImportNewFile;
  public
    class function New: IModelImport;
    function Post(JSONObject:TJSONObject): boolean;
  end;

implementation

uses System.StrUtils, System.NetEncoding, DS.Server.Model.Import.Consts, System.Zip,
  System.SysUtils, Winapi.Windows, DS.Server.Model.Import.Future;

{ TModelImport }

class function TModelImport.New: IModelImport;
begin
  Result := Self.Create;
end;

procedure TModelImport.GetNewFile;
var
  StringStream: TStringStream;
  MemoryStream: TMemoryStream;
begin
  FStep := GetFile;
  FPath := ExtractFilePath(ParamStr(0));
  StringStream := TStringStream.Create(FJSONObject.GetValue(CONST_JSON_ELEMENT).Value);
  try
    StringStream.Position := 0;
    MemoryStream := TMemoryStream.Create;
    try
      TNetEncoding.Base64.Decode(StringStream, MemoryStream);
      MemoryStream.Position := 0;
      FZipFile := FormatDateTime(CONST_FILE_ZIP, Now);
      MemoryStream.SaveToFile(FPath + FZipFile);
      FStep := UnzipFile;
    finally
      MemoryStream.Free;
    end;
  finally
    StringStream.Free;
  end;
end;

procedure TModelImport.UnzipNewFile;
var
  zipFile: TZipFile;
begin
  if not (FStep = UnzipFile) then
    Abort;

  zipFile := TZipFile.Create;
  try
    zipFile.Open(FZipFile, zmRead);
    zipFile.Extract(CONST_FILE_CVS, FPath);
    FStep := RenameUnzipFile;
  finally
    zipFile.Free;
  end;
end;

procedure TModelImport.RenameNewFile;
begin
  if not (FStep = RenameUnzipFile) then
    Exit;

  FCSVFile := FZipFile;
  FCSVFile := StringReplace(FCSVFile, CONST_EXTENSION_ZIP, CONST_EXTENSION_CSV, [rfIgnoreCase]);
  RenameFile(FPath + CONST_FILE_CVS, FPath + FCSVFile);
end;

procedure TModelImport.ImportNewFile;
begin
  dmModelImportFuture.ImportNewFile(ExtractFilePath(ParamStr(0))+FCSVFile);
end;

function TModelImport.Post(JSONObject: TJSONObject): boolean;
begin
  try
    FJSONObject := JSONObject;
    GetNewFile;
    UnzipNewFile;
    RenameNewFile;
    ImportNewFile;
    FJSONObject := nil;
    Result := true;
  except
    Result := false;
  end;
end;

end.
