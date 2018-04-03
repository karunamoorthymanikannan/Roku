Sub init() as Void
    m.contentTitle = m.top.findNode("contentTitle")
    m.appName = m.top.findNode("appName")
    m.feedBack = m.top.findNode("feedBack")
    m.contentDescriptions = m.top.findNode("contentDescriptions")
    m.contentDescriptions.SetFocus(true)    
End Sub

Function notifyDetailsContent() as Void
    m.contentDescriptions.SetFocus(true)
    title = m.top.updateDetailsScreen.TITLE
    m.contentTitle.text = title
    isFeedBackScreen = (title = "SEND FEEDBACK")
    m.feedBack.visible = isFeedBackScreen
    if isFeedBackScreen
        getConfigData()
    end if
End Function

Function notifyConfigResponse() as Void
    configData = m.getConfigFromLocalTask.responseData
    if configData <> invalid
        m.appName.text = configData.settings.app.comscore +" Roku OS"
    end if
    print m.getConfigFromLocalTask.responseData
End Function