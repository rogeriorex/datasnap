object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Enviar Arquivo'
  ClientHeight = 506
  ClientWidth = 868
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Grid: TDBGrid
    Left = 8
    Top = 16
    Width = 852
    Height = 361
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlInfo: TPanel
    Left = 8
    Top = 383
    Width = 852
    Height = 74
    TabOrder = 1
    object lblInfoTitulo: TLabel
      Left = 136
      Top = 8
      Width = 80
      Height = 15
      Caption = 'Para Importar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInfo: TLabel
      Left = 136
      Top = 29
      Width = 601
      Height = 36
      AutoSize = False
      Caption = 
        '1'#186' Clique em "Abrir aquivo", selecione um do tipo CSV, com conte' +
        #250'do seprado por v'#237'rgula e extens'#227'o .txt ou .csv 2'#186' Veririque os ' +
        'dados e corrija se necess'#225'rio antes de clique em "Enviar dados" ' +
        'e aguarde o processamento'
      WordWrap = True
    end
  end
  object btnOpenNewFile: TButton
    Left = 8
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Abrir Novo Arquivo'
    TabOrder = 2
    OnClick = OpenNewFile
  end
  object btnSendNewFile: TButton
    Left = 141
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Enviar Novo Arquivo'
    Enabled = False
    TabOrder = 3
    OnClick = SendNewFile
  end
  object btnOpenBank: TButton
    Left = 326
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Abrir Banco'
    TabOrder = 4
    OnClick = OpenBank
  end
  object btnInserBank: TButton
    Left = 463
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Enviar Inserido'
    Enabled = False
    TabOrder = 5
    OnClick = InsertBank
  end
  object btnEditBank: TButton
    Left = 596
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Enviar Editado'
    Enabled = False
    TabOrder = 6
    OnClick = EditBank
  end
  object btnDeleteBank: TButton
    Left = 729
    Top = 466
    Width = 131
    Height = 25
    Caption = 'Deletar Selecionado'
    Enabled = False
    TabOrder = 7
    OnClick = DeleteBank
  end
end
