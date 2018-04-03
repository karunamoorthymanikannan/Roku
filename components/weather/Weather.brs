Sub init()
    m.weatherForecast = m.top.findNode("weatherForecast")
    m.weatherVideoImage = m.top.findNode("weatherVideoImage")
    m.weatherStoryImage = m.top.findNode("weatherStoryImage")
    m.weatherStoryTitle = m.top.findNode("weatherStoryTitle")
    m.weatherStorySummary = m.top.findNode("weatherStorySummary")
    m.weatherVideoTitle = m.top.findNode("weatherVideoTitle")
    m.rightNow = m.top.findNode("rightNow")
    m.tonight = m.top.findNode("tonight")
    m.tomorrow = m.top.findNode("tomorrow")
    m.allDayForecast = m.top.findNode("allDayForecast")
'    m.video = m.top.findNode("weatherVideo")
'    url = "pkg:/video/weather_bg_video_night.mp4"
'    videoContent = createObject("RoSGNode", "ContentNode")
'    videoContent.url = url
'    videoContent.enableUI = false
'    videoContent.enableTrickPlay = false
'    videoContent.bufferingBar = ""
'    videoContent.retrievingBar = ""
'    videoContent.streamformat = "mp4"
'    m.video.content = videoContent
'    m.video.observeField("state", "showStatus")
End Sub

Function playWeatherVideo() as void  
 ' m.video.control = m.top.playWeatherVideo 
End Function

Function showStatus() As Void
    print m.video.state
    if m.video.state = "finished"
       ' m.video.control = "replay"
    end if
End Function

Function notifyDayData() as Void
    weatherResponseData = m.top.updateDayData
    m.rightNow.updateData = weatherResponseData.rightNow
    m.tonight.updateData = weatherResponseData.tonight
    m.tomorrow.updateData = weatherResponseData.tomorrow
    data = CreateObject("roSGNode", "ContentNode")
    allDayData = weatherResponseData.allDay
    if allDayData <>  invalid AND allDayData.Count() > 0
        for each child in allDayData
            data.appendChild(child)
        end for
    end if
    m.allDayForecast.content = data
End Function

Function notifyWeatherFocus() as Void

End Function

Function notifyVideoData() as Void
    weatherVideoData = m.top.updateVideoData
    if weatherVideoData <> invalid AND weatherVideoData.items <> invalid AND weatherVideoData.items.Count() > 0
        videoItems = weatherVideoData.items[0]
        m.weatherVideoImage.uri = videoItems.thumbnail
        m.weatherVideoTitle.text = videoItems.headline
     end if
End Function

Function notifyStoryData() as Void
    weatherStoryData = m.top.updateStoryData
    if weatherStoryData <> invalid AND weatherStoryData.items <> invalid AND weatherStoryData.items.Count() > 0
        storyItems = weatherStoryData.items[0]
        m.weatherStoryTitle.text = storyItems.meteorologist
        m.weatherStorySummary.text = storyItems.summary
        if storyItems.media <> invalid
            m.weatherStoryImage.uri = storyItems.media.mugshot
        end if
     end if
End Function