unit DS.Client.Model.Import;

interface

uses
  DS.Client.Model.Import.Interfaces, FireDAC.Comp.DataSet, DS.Client.Model.Singleton;

type
  TClientModelImport = class(TInterfacedObject, IClientModelImport)
  private
    FMsg: string;
    FStringJSON: string;
    procedure PrepareDataFile(const Data: IFDDataSetReference);
    procedure CompactDataFile;
    procedure CheckFileExist;
    procedure PrepareJSON;
    procedure Send;
  public
    class function New: IClientModelImport;
    function OpenNewFile: IFDDataSetReference;
    function SendNewFile(const Data: IFDDataSetReference): string;
  end;

implementation

uses
  System.Classes, System.JSON, System.SysUtils, DS.Client.Model.Consts, System.Zip, System.NetEncoding, REST.Types, Data.DB;

{%CLASSGROUP 'Vcl.Controls.TControl'}

class function TClientModelImport.New: IClientModelImport;
begin
  Result := Self.Create;
end;

procedure TClientModelImport.PrepareDataFile(const Data: IFDDataSetReference);
var
  I, J: integer;
  DataFile: TStringList;
  Line: String;
  Singleton: TSingleton;
begin
  DataFile := TStringList.Create;
  try
    Singleton := TSingleton.Get;
    Singleton.MemTable.Close;
    Singleton.MemTable.Data := Data;
    Singleton.MemTable.Open;

    for I := 0 to Pred(Singleton.MemTable.FieldDefs.Count) do
    begin
      if Line <> EmptyStr then
        Line := Line + CONST_CARACTER_SEPARACAO_DE_CAMPOS_CSV;
      Line := Line + Singleton.MemTable.FieldDefs[I].Name;
    end;

    DataFile.Add(Line);

    for I := 0 to Pred(Singleton.MemTable.RecordCount) do
    begin
      Line := EmptyStr;

      for J := 0 to Pred(Singleton.MemTable.FieldDefs.Count) do
      begin
        if Line <> EmptyStr then
          Line := Line + CONST_CARACTER_SEPARACAO_DE_CAMPOS_CSV;
        Line := Line + Singleton.MemTable.Fields[J].AsString;
      end;
      Singleton.MemTable.Next;
      DataFile.Add(Line);
    end;
    DataFile.SaveToFile(ExtractFilePath(ParamStr(0)) + CONST_FILE_CSV);

  finally
    DataFile.Free;
  end;
end;

procedure TClientModelImport.CompactDataFile;
var
  FileCSV, FileZip: string;
  Zip: TZipFile;
begin
  Zip := TZipFile.Create;
  try
    FileCSV := ExtractFilePath(ParamStr(0)) + CONST_FILE_CSV;
    FileZip := ExtractFilePath(ParamStr(0)) + CONST_FILE_ZIP;
    Zip.Open(FileZip, zmWrite);
    Zip.Add(FileCSV);
    DeleteFile(FileCSV);
  finally
    Zip.Free;
  end;
end;

procedure TClientModelImport.CheckFileExist;
begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + CONST_FILE_ZIP) then
  begin
    FMsg := CONST_SENDFILE_ERROR_CHECKEXIST_ZIP;
    Abort;
  end;
end;

procedure TClientModelImport.PrepareJSON;
var
  MemoryStream: TMemoryStream;
  StringStream: TStringStream;
  JSONObject: TJSONObject;
begin
  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.LoadFromFile(ExtractFilePath(ParamStr(0)) + CONST_FILE_ZIP);
    MemoryStream.Position := 0;
    
    StringStream := TStringStream.Create;
    try
      TNetEncoding.Base64.Encode(MemoryStream, StringStream);
      StringStream.Position := 0;

      JSONObject := TJSONObject.Create;
      try
        JSONObject.AddPair(CONST_JSON_ELEMENT, StringStream.DataString);
        FStringJSON := JSONObject.ToString; 
      finally
        JSONObject.Free;
      end;
      
    finally
      FreeAndNil(StringStream);
    end;
    
  finally
    FreeAndNil(MemoryStream);
  end;
end;

procedure TClientModelImport.Send;
var
  Singleton: TSingleton;
begin
  try
    Singleton := TSingleton.Get;
    Singleton.REST.baseurl := CONST_REST_BASEURL;
    Singleton.Request.Params.AddItem(
      CONST_REQUEST_JSONBODY,
      FStringJSON,
      TRESTRequestParameterKind.pkREQUESTBODY,
      [poDoNotEncode],
      ctAPPLICATION_JSON
    );
    Singleton.Request.Resource := CONST_REQUEST_IMPORT_RESOURCE;
    Singleton.Request.Method := rmPOST;
    Singleton.Request.execute;
    FMsg := CONST_SENDFILE_SUCESS;
  except
    FMsg := CONST_SENDFILE_ERROR_EXECUTE;
    Abort;
  end;
end;

function TClientModelImport.OpenNewFile: IFDDataSetReference;
var
  Stream: TStream;
  Reader: TStreamReader;
  Line: string;
  Fields: TArray<string>;
  I: Integer;
  Singleton: TSingleton;
begin
  try
    Singleton := TSingleton.Get;
 
    if not Singleton.OpenDialog.Execute() then
      Exit;
      
    FMsg := EmptyStr;

    Stream := TFileStream.Create(Singleton.OpenDialog.FileName, fmOpenRead);
    try

      Reader := TStreamReader.Create(Stream, TEncoding.Default);
      try
        Reader.ReadLine;
        Singleton.DataSetImport;
        while not Reader.EndOfStream do
        begin
          Line := Reader.ReadLine;
          Fields := Line.Split([CONST_CARACTER_SEPARACAO_DE_CAMPOS_CSV]);
          Singleton.MemTable.Append;
          for I := 0 to High(Fields) do
            Singleton.MemTable.Fields[I].AsString := Fields[I];
          Singleton.MemTable.Post;
        end;
        Result := Singleton.MemTable.Data;

      finally
        Reader.Free;
      end;

    finally
      Stream.Free;
    end;

  except
    FMsg := CONST_MENSAGEM_ERRO_IMPORTACAO;
  end;
end;

function TClientModelImport.SendNewFile(const Data: IFDDataSetReference): string;
begin
  Result := EmptyStr;
  try
    PrepareDataFile(Data);
    CompactDataFile;
    CheckFileExist;
    PrepareJSON;
    Send;
  finally
    Result := FMsg;
  end;
end;

end.
