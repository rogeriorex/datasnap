object frmViewConfig: TfrmViewConfig
  Left = 271
  Top = 114
  BorderStyle = bsDialog
  Caption = 'WK Server'
  ClientHeight = 155
  ClientWidth = 114
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  PrintScale = poNone
  OnCreate = FormCreate
  TextHeight = 13
  object btnStart: TButton
    Left = 8
    Top = 8
    Width = 98
    Height = 139
    Caption = 'Iniciar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = StartServer
  end
end
