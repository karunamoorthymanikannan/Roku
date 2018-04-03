Function getConstantUrls() as Object
    return { 
            "manifestUrl": "/api/1/ott/?endpoint=manifest&platform=appletv"
        }
End Function

Function initConstant() as Void
    m.defaultAnimatePosition = 0
    m.translateHeaderAnimatePosition = -120  
    m.translateWeatherAnimatePosition = -540
End Function

Function saveContentDataToFile(fileName as String ,inputData as Object) as Void
    m.saveDataToFileTask = createObject("roSGNode","FileTask")
    m.saveDataToFileTask.fileName = fileName
    m.saveDataToFileTask.inputData = inputData
    m.saveDataToFileTask.functionName = "saveDataToFile"
    m.saveDataToFileTask.control = "RUN"
End Function