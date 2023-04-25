object WebModule1: TWebModule1
  Actions = <
    item
      Name = 'ReverseStringAction'
      PathInfo = '/ReverseString'
    end
    item
      Name = 'ServerFunctionInvokerAction'
      PathInfo = '/ServerFunctionInvoker'
    end
    item
      Default = True
      Name = 'DefaultAction'
      PathInfo = '/'
    end>
  Height = 210
  Width = 186
  PixelsPerInch = 120
  object DSServer: TDSServer
    Left = 72
    Top = 6
  end
  object DSHTTPWebDispatcher: TDSHTTPWebDispatcher
    Server = DSServer
    Filters = <>
    OnFormatResult = DSHTTPWebDispatcherFormatResult
    WebDispatch.PathInfo = 'datasnap*'
    Left = 72
    Top = 70
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 74
    Top = 134
  end
end
