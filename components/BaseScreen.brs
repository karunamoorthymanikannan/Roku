Sub init()
    loadInitalData()
    m.ss="moorthy"
End Sub

Function loadInitalData() as Void
    getConfigData()
End Function

Function getConfigData() as Void   
    m.getConfigDataTask = createObject("roSGNode","ConfigTask")
    m.getConfigDataTask.functionName = "getConfigData"
    m.getConfigDataTask.observeField("responseData","notifyConfigDataResponse")
    m.getConfigDataTask.control = "RUN"
End Function

Function notifyConfigDataResponse() as Void
    m.configData = m.getConfigDataTask.responseData.data    
    if m.configData = invalid
        return
    end if
    m.headerLayout.configData = m.configData 
    refreshHomeScreen()
    saveContentDataToFile("config" , m.configData)
    m.weatherData = invalid
    if m.configData.settings <> invalid AND m.configData.settings.weather <> invalid
        m.weatherData = m.configData.settings.weather
    end if
End Function

Function refreshHomeScreen() as Void
    if m.configData.navigation <> invalid
        m.taskList = []
        navigationData = m.configData.navigation
        sectionCount = navigationData.Count() - 1
        for i = 0 to sectionCount
            sectionValue = navigationData[i].value
            if Len(sectionValue) > 0 AND navigationData[i].typeName <> "weather"
                getSectionTask = createObject("roSGNode","SectionTask")
                getSectionTask.functionName = "getSectionData"
                getSectionTask.sectionPath = sectionValue
                getSectionTask.taskId = i
                getSectionTask.observeField("responseNode","notifySectionResponse")
                getSectionTask.control = "RUN"
                m.taskList.push(getSectionTask)
            end if
        end for
    end if
    loadWeatherInfoData()
End Function

Function notifySectionResponse(message as Object) as Void
    request = message.getRoSGNode()
    if request = invalid
        return
     end if
     m.allSectionNode.addReplace(request.taskId.ToStr(),request.responseNode)
     if m.menuPosition = request.taskId
        m.sectionList.content = request.responseNode       
     end if    
     if request.taskId = 0
         hidespinner()
     end  if  
End Function

Function loadWeatherDatas() as Void
    if m.configData.settings <> invalid AND m.configData.settings.weather <> invalid
        weather = m.configData.settings.weather
        m.getWeatherStoryTask = createObject("roSGNode","WeatherTask")
        m.getWeatherStoryTask.functionName = "getWeatherStoryData"
        m.getWeatherStoryTask.weather = weather        
        m.getWeatherStoryTask.observeField("weatherStoryData","notifyWeatherStoryResponse")
        m.getWeatherStoryTask.control = "RUN" 
        
        m.getWeatherVideoTask = createObject("roSGNode","WeatherTask")
        m.getWeatherVideoTask.functionName = "getWeatherVideoData"
        m.getWeatherVideoTask.weather = weather        
        m.getWeatherVideoTask.observeField("weatherVideoData","notifyWeatherVideoResponse")
        m.getWeatherVideoTask.control = "RUN" 
    end if
End Function

Function loadWeatherInfoData() as Void
    if m.weatherData <> invalid
        m.getWeatherConditions = createObject("roSGNode","WeatherTask")
        m.getWeatherConditions.functionName = "getWeatherData"
        m.getWeatherConditions.weather = m.weatherData        
        m.getWeatherConditions.observeField("weatherResponseData","notifyWeatherConditionResponse")
        m.getWeatherConditions.control = "RUN" 
    end if
End Function

Function notifyWeatherVideoResponse() as Void
    m.weather.updateVideoData = m.getWeatherVideoTask.weatherVideoData
End Function

Function notifyWeatherStoryResponse() as Void
     m.weather.updateStoryData = m.getWeatherStoryTask.weatherStoryData
End Function

Function notifyWeatherConditionResponse() as Void
    weatherResponseData = m.getWeatherConditions.weatherResponseData
    print weatherResponseData
    if weatherResponseData = invalid
        return
    end if
    m.weather.updateDayData = weatherResponseData
    m.headerLayout.headerData = weatherResponseData.weatherHeader
End Function