Function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
       if key = "up" OR key = "down" OR key = "right" OR key = "left"
            return true
       else if key = "back"
            m.top.closedDetailsScreen = ""
       end if 
    end if 
    return false 
End Function

Function getConfigData() as Void
    m.getConfigFromLocalTask = createObject("roSGNode","FileTask")
    m.getConfigFromLocalTask.functionName = "readLocalFile"
    m.getConfigFromLocalTask.fileName = "config"
    m.getConfigFromLocalTask.observeField("responseData","notifyConfigResponse")
    m.getConfigFromLocalTask.control = "RUN"
End Function