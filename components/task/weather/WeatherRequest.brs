Sub init()     
 
End Sub
 
Function getWeatherStoryData() as Void
    weatherData = m.top.weather
    globalUrls = CreateObject("roSGNode", "Urls")
    weatherStoryUrl = globalUrls.hostUrl + weatherData.urls["forecast-story"]
    getContent(weatherStoryUrl)
    responseString = m.top.responseString
    weatherDetails = invalid
    if responseString <> invalid AND responseString <> "" then
        weatherDetails = ParseJSON(responseString)
    end if
    m.top.weatherStoryData = weatherDetails
End Function

Function getWeatherVideoData() as Void
    weatherData = m.top.weather
    globalUrls = CreateObject("roSGNode", "Urls")
    weatherVideoUrl = globalUrls.hostUrl + weatherData.urls["forecast-video"]
    getContent(weatherVideoUrl)
    responseString = m.top.responseString
    weatherDetails = invalid
    if responseString <> invalid AND responseString <> "" then
        weatherDetails = ParseJSON(responseString)
    end if
    m.top.weatherVideoData = weatherDetails
End Function

Function getWeatherData() As Void
    weatherData = m.top.weather
    m.top.isHeaderNeed = false
    headerUrl = weatherData.assets["flat-logo"]
    assetsUrl = weatherData.assets["realistic-logo"]
    weatherCondition = weatherData.urls.conditions
    latitude = weatherData.defaultLocation.latitude.ToStr()
    longitude = weatherData.defaultLocation.longitude.ToStr()
    weatherSplit = weatherCondition.Split("%@") 
    weatherSplitValue = [latitude,longitude,""]
    weatherSplitCount = weatherSplit.Count()-1
    weatherUrl = ""
    for i = 0 to weatherSplitCount
        weatherUrl = weatherUrl + weatherSplit[i] + weatherSplitValue[i]
    end for
    getContent(weatherUrl)
    responseString = m.top.responseString
    weatherDetails = invalid
    if responseString <> invalid AND responseString <> "" then
       response = createObject("roXMLElement")
       response.parse(responseString)
       weatherData = {}       
       if response.GetChildElements().Count() > 0
            childElements = response.GetChildElements()
            citiesNode = childElements[0]
            citiesData = citiesNode.GetAttributes()
            citiesBody = citiesNode.getBody()
            for each childNodes in citiesBody
                resultData = parseXMLNode(childNodes)
                weatherData.AddReplace(childNodes.getName(), resultData)
            end for            
       end if
       weatherDetails = {}
       if weatherData.CurrentObservation <> invalid AND weatherData.CurrentObservation.parent <> invalid
            currentObservation = weatherData.CurrentObservation.parent
            urls = getRealListicLogoUrl(assetsUrl , currentObservation.IconCode)
            weatherContent = CreateObject("roSGNode", "WeatherData")
            weatherContent.weatherIcon = urls
            weatherContent.wetherTitle = "RIGHT NOW"
            weatherContent.weatherTemp = currentObservation.TempF
            weatherContent.weatherSky = currentObservation.Sky
            weatherContent.weatherFeels = "Feels Like "+currentObservation.FeelsLikeF
            weatherContent.weatherPrecip = "0"
            weatherDetails.AddReplace("rightNow",weatherContent)
            isDayTime = currentObservation.DayNight = "D"
            weatherDetails.AddReplace("isDay",isDayTime)
                        
            weatherHeaderDetails = {}
            urls = getFlotLogoUrl(headerUrl , currentObservation.IconCode)
            weatherHeaderDetails.AddReplace("weatherHeaderUrl", urls)
            weatherHeaderDetails.AddReplace("weatherHeaderTemp", currentObservation.TempF)
            weatherHeaderDetails.AddReplace("weatherHeaderSky", UCase(currentObservation.Sky))
            weatherDetails.AddReplace("weatherHeader",weatherHeaderDetails)
       end if
       
        if weatherData.dailyforecast <> invalid AND weatherData.dailyforecast.child <> invalid
            dailyforecast = weatherData.dailyforecast.child
            if dailyforecast[0] <> invalid AND dailyforecast[0].parent <> invalid
                tonightData = dailyforecast[0].parent
                urls = getRealListicLogoUrl(assetsUrl , tonightData.IconCode)
                weatherContent = CreateObject("roSGNode", "WeatherData")
                weatherContent.weatherIcon = urls
                weatherContent.wetherTitle = "TONIGHT"
                weatherContent.weatherTemp = tonightData.LoTempF
                weatherContent.weatherSky = tonightData.SkyText
                weatherContent.weatherPrecip = tonightData.PrecipChanceNight
                weatherDetails.AddReplace("tonight",weatherContent)
            end if
            
            if dailyforecast[1] <> invalid AND dailyforecast[1].parent <> invalid
                tomorrowData = dailyforecast[1].parent
                urls = getRealListicLogoUrl(assetsUrl , tomorrowData.IconCode)
                weatherContent = CreateObject("roSGNode", "WeatherData")
                weatherContent.weatherIcon = urls
                weatherContent.wetherTitle = "TOMORROW"
                weatherContent.weatherTemp = tomorrowData.HiTempF
                weatherContent.weatherSky = tomorrowData.SkyText
                weatherContent.weatherPrecip = tomorrowData.PrecipChanceDay
                weatherDetails.AddReplace("tomorrow",weatherContent)
            end if
            forecast = []
            for each dailyforecastItems in dailyforecast
                dailyforecastData = dailyforecastItems.parent
                if dailyforecastData <> invalid
                    urls = getRealListicLogoUrl(assetsUrl , dailyforecastData.IconCode)
                    weatherContent = CreateObject("roSGNode", "WeatherData")
                    weatherContent.weatherIcon = urls
                    weatherContent.wetherTitle = UCase(Left(dailyforecastData.DayOfWk, 3).ToStr())
                    weatherContent.weatherHigh = dailyforecastData.HiTempF
                    weatherContent.weatherLow = dailyforecastData.LoTempF
                    forecast.Push(weatherContent)
                end if
            end for
            weatherDetails.AddReplace("allDay" , forecast)
        end if
    end if
    m.top.weatherResponseData = weatherDetails
End Function

Function getFlotLogoUrl(assetsUrl as String , iconCode as Dynamic) as String
    assetSplit = assetsUrl.Split("%@") 
    assetData = ["light",iconCode.toStr(),""]
    urls = ""
    for i = 0 to assetSplit.Count()-1 
        urls = urls + assetSplit[i] + assetData[i]
    end for
    return urls
End Function

Function getRealListicLogoUrl(assetsUrl as String , iconCode as Dynamic) as String
    return assetsUrl.Replace("%@",iconCode.toStr())
End Function

Function parseXMLNode(xmlNode as Object) as Object
    if xmlNode.GetAttributes() = invalid AND xmlNode.GetChildElements() = invalid
        return invalid
    end if
    fieldsData = xmlNode.GetAttributes()
    totalData = []
    if xmlNode.GetChildElements() <> invalid
        for each childItems in xmlNode.GetChildElements()
            childData = []
            fieldData = childItems.GetAttributes()
            childItem = childItems.GetChildElements() 
            if childItem <> invalid
                for each childSubNodes in childItem
                    childData.Push(childSubNodes.GetAttributes())
                end for
            end if
            data = {
                "child" : childData,
                "parent" : fieldData
            }
            totalData.push(data)
        end for
    end if
    result = {
        "parent" : fieldsData,
        "child" : totalData
    }
    return result
End Function

Function pareseServerResult(serverResponse as Object, isJsonData = true as Boolean) as Object
    responseString = serverResponse.GetString()
    responseCode = serverResponse.GetResponseCode()
    m.top.responseCode = responseCode
    m.top.responseString = responseString
    response = invalid   
    m.top.responseData = {
            data : response
        }
    return m.top.responseData
End Function