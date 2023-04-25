object dmModelImportFuture: TdmModelImportFuture
  Height = 244
  Width = 203
  PixelsPerInch = 120
  object ConnectionImportNewFile: TFDConnection
    Params.Strings = (
      'Password=%#_P0stgr3s@!=*'
      'DriverID=pG'
      'User_Name=postgres'
      'Database=WK'
      'Server=localhost')
    LoginPrompt = False
    Left = 80
    Top = 22
  end
  object PgDriverImportNewFile: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 80
    Top = 86
  end
  object WaitCursorImportNewFile: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 150
  end
end
