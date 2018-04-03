 Sub init()     
 
 End Sub
 
 Function getConfigData() As Void
    configEndPointUrl = m.top.hostUrl + getConstantUrls().manifestUrl
    print "configEndPointUrl = " configEndPointUrl
    resultData = getContent(configEndPointUrl)
End Function