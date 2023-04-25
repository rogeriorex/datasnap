object dmModelConnection: TdmModelConnection
  Height = 225
  Width = 106
  PixelsPerInch = 120
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 32
    Top = 136
  end
  object PgDriver: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 32
    Top = 72
  end
  object PGConnection: TFDConnection
    Params.Strings = (
      'Database=WK'
      'User_Name=postgres'
      'Password=%#_P0stgr3s@!=*'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
end
