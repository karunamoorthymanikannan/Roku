Sub init()
    appInfo = CreateObject("roAppInfo")
    isDebug = LCase(appInfo.GetValue("isDebug"))
    if isDebug = "true"
         m.top.hostUrl = m.top.developmentHost
         m.top.isHeaderNeed = true
    else
         m.top.hostUrl = m.top.productionHost
         m.top.isHeaderNeed = false
    end if   
End Sub