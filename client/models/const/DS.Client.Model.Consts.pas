unit DS.Client.Model.Consts;

interface

const
  CONST_REST_ACCEPT = 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  CONST_REST_ACCEPTCHARSET = 'UTF-8, *;q=0.8';
  CONST_REST_BASEURL = 'http://localhost:8080/datasnap/rest';
  CONST_REST_CONTENRTYPE = 'application/json';

  CONST_JSON_ELEMENT = 'arquivo';
  CONST_REQUEST_JSONBODY = 'JsonBody';
  CONST_REQUEST_IMPORT_RESOURCE = 'TPessoa/Importar';
  CONST_REQUEST_BANK_RESOURCE = 'Tpessoa/cadastro';
  CONST_REQUEST_BANK_RESOURCE_INSERT = 'Tpessoa/cadastro/-1';
  CONST_REQUEST_BANK_RESOURCE_POST = 'Tpessoa/cadastro/%s';
  CONST_REQUEST_BANK_RESOURCE_DELETE = 'Tpessoa/cadastro/%s';

  CONST_FILE_ZIP = 'wk.zip';
  CONST_FILE_CSV = 'wk.csv';
  CONST_SENDFILE_ERROR_CHECKEXIST_ZIP = 'Processo abortado'+#13+#10+'Erro ao tentar compactar as informações para envio';
  CONST_SENDFILE_ERROR_EXECUTE = 'Processo abortado'+#13+#10+'Não foi possível estabelecer conexão com o servidor';
  CONST_SENDFILE_SUCESS = 'Informações enviadas com sucesso, para o servidore';

  CONST_CARACTER_SEPARACAO_DE_CAMPOS_CSV = ',';
  CONST_MENSAGEM_ERRO_IMPORTACAO = 'Erro na leitura do arquivo';

  CONST_FIELD_IDPESSOA = 'IDPESSOA';
  CONST_FIELD_FLNATUREZA = 'FLNATUREZA';
  CONST_FIELD_DSDOCUMENTO = 'DSDOCUMENTO';
  CONST_FIELD_NMPRIMEIRO = 'NMPRIMEIRO';
  CONST_FIELD_NMSEGUNDO = 'NMSEGUNDO';
  CONST_FIELD_DTREGISTRO = 'DTREGISTRO';
  CONST_FIELD_DSCEP = 'DSCEP';

  CONST_SIZE_FIELD_DSDOCUMENTO = 20;
  CONST_SIZE_FIELD_NMPRIMEIRO = 100;
  CONST_SIZE_FIELD_NMSEGUNDO = 100;
  CONST_SIZE_FIELD_DSCEP = 15;

  CONST_OPENDIALOG_FILTER = 'Arquivos (*.csv, *.txt)|*.csv; *.txt';
  CONST_OPENDIALOG_TITLE = 'Arquivo de Importação';

implementation

end.
