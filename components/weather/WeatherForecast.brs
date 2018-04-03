Function init()
    m.weatherTitle = m.top.findNode("title")
    m.iconImage = m.top.findNode("iconImage")
    m.weatherTempHigh= m.top.findNode("tempHigh")
    m.weatherTempLow= m.top.findNode("tempLow")
End Function

Function updateFields() as Void
    resultData = m.top.updateData
    m.iconImage.uri = resultData.weatherIcon
    m.weatherTitle.text = resultData.wetherTitle
    m.weatherTempLow.text = resultData.weatherLow
    m.weatherTempHigh.text = resultData.weatherHigh
End Function