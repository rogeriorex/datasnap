unit DS.Server.Model.Import.Future;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, System.Classes, Data.DB, FireDAC.Comp.Client;

type
  TdmModelImportFuture = class(TDataModule)
    ConnectionImportNewFile: TFDConnection;
    PgDriverImportNewFile: TFDPhysPgDriverLink;
    WaitCursorImportNewFile: TFDGUIxWaitCursor;
  public
    procedure ImportNewFile(const NewFile: string);
  end;

var
  dmModelImportFuture: TdmModelImportFuture;

implementation

uses
  System.Threading,  System.SysUtils;


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule3 }

procedure TdmModelImportFuture.ImportNewFile(const NewFile: string);
var
  Go: IFuture<string>;
begin
  Go :=
  TTask.Future<string>(
    function: string
    const
      CONST_TABLE_PESSOA = 'pessoa';
      CONST_TABLE_ENDERECO = 'endereco';
      CONST_INDEX_PESSOA = 'idpessoa';
      CONST_INDEX_ENDERECO = 'idendereco';
      CONST_COMMIT_COUNT = 1000;
      CONST_CHARACTER_SEPARATOR = ',';
    var
      Stream: TFileStream;
      Reader: TStreamReader;
      Line: string;
      Fields: TArray<string>;
      ID, CountInsertToCommit: Integer;
      tblPessoa, tblEndereco: TFDTable;
      procedure CreateFDTable;
      begin
        dmModelImportFuture.ConnectionImportNewFile.Connected := false;
        dmModelImportFuture.ConnectionImportNewFile.Connected := true;
        tblPessoa := TFDTable.Create(nil);
        tblPessoa.Connection := dmModelImportFuture.ConnectionImportNewFile;
        tblPessoa.TableName := CONST_TABLE_PESSOA;
        tblPessoa.IndexFieldNames := CONST_INDEX_PESSOA;
        tblPessoa.Active := true;
        tblEndereco := TFDTable.Create(nil);
        tblEndereco.Connection := dmModelImportFuture.ConnectionImportNewFile;
        tblEndereco.TableName := CONST_TABLE_ENDERECO;
        tblEndereco.IndexFieldNames := CONST_INDEX_ENDERECO;
        tblEndereco.Active := true;
      end;
      procedure DestroyFDTable;
      begin
        dmModelImportFuture.ConnectionImportNewFile.Connected := false;
        tblPessoa.Connection := nil;
        tblPessoa.Free;
        tblEndereco.Connection := nil;
        tblEndereco.Free;
      end;
      procedure ReOpenConnectionAndTables;
      begin
        if dmModelImportFuture.ConnectionImportNewFile.InTransaction then
          dmModelImportFuture.ConnectionImportNewFile.CommitRetaining;
        dmModelImportFuture.ConnectionImportNewFile.Connected := False;
        dmModelImportFuture.ConnectionImportNewFile.Connected := True;
        tblPessoa.Active := true;
        tblEndereco.Active := true;
      end;
      function PostPessoa: integer;
      var
        I: integer;
      begin
        tblPessoa.Append;
        for I := 0 to Pred(tblPessoa.Fields.Count) do
          tblPessoa.Fields[I].AsString := Fields[I];
        try
          tblPessoa.Post;
          Result := tblPessoa.Fields[0].AsInteger;
        except
          tblPessoa.Cancel;
          Result := 0;
        end;
      end;
      procedure PostEndereco(const IDPessoa: integer);
      var
        I: integer;
      begin
        tblEndereco.Append;
        for I := 0 to Pred(tblEndereco.Fields.Count) do
          if I < Pred(tblEndereco.Fields.Count) then
            tblEndereco.Fields[I].AsInteger := IDPessoa
          else
            tblEndereco.Fields[I].AsString := Fields[High(Fields)];
        tblEndereco.Post;
      end;
    begin
      CreateFDTable;
      try
        Stream := TFileStream.Create(NewFile, fmOpenRead);
        try
          Reader := TStreamReader.Create(Stream, TEncoding.Default);
          try
            Reader.ReadLine;
            CountInsertToCommit := 0;
            while not Reader.EndOfStream do
            begin
              Line := Reader.ReadLine;
              Fields := Line.Split([CONST_CHARACTER_SEPARATOR]);
              ID := PostPessoa;
              PostEndereco(ID);
              Inc(CountInsertToCommit);
              if CountInsertToCommit mod CONST_COMMIT_COUNT = 0 then
                ReOpenConnectionAndTables;
            end;
            ReOpenConnectionAndTables;
            Result := CountInsertToCommit.ToString;
          finally
            Reader.Free;
          end;
        finally
          Stream.Free;
        end;
      finally
        DestroyFDTable;
      end;
    end
  );
end;

end.
