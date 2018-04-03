Function init()
    m.weatherTitle = m.top.findNode("title")
    m.iconImage = m.top.findNode("iconImage")
    m.weatherTemp= m.top.findNode("temp")
    m.weatherSky= m.top.findNode("sky")
    m.weatherFeels = m.top.findNode("feels")
    m.weatherPrecip = m.top.findNode("precip")
End Function

Function updateFields() as Void
    resultData = m.top.updateData
    m.iconImage.uri = resultData.weatherIcon
    m.weatherTitle.text = resultData.wetherTitle
    m.weatherTemp.text = resultData.weatherTemp
    m.weatherSky.text = resultData.weatherSky
    m.weatherFeels.text = resultData.weatherFeels
    m.weatherPrecip.text = resultData.weatherPrecip
End Function