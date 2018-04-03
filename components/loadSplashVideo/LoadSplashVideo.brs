Sub init()
    m.video = m.top.findNode("splashVideo")
    
    playSplashVideo()
End Sub

Function playSplashVideo() as void
  appInfo = CreateObject("roAppInfo")
  flavor = LCase(appInfo.GetValue("flavor"))
  url = "pkg:/asset/"+flavor+"/video/introduction.mp4"
  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.url = url
  videoContent.enableUI = false
  videoContent.enableTrickPlay = false
  videoContent.bufferingBar = ""
  videoContent.retrievingBar = ""
  videoContent.streamformat = "mp4"
  m.video.content = videoContent
  m.video.control = "play"
  m.video.observeField("state", "showStatus")
End Function

Function showStatus() As Void
    if m.video.state = "finished"
        m.top.videoStatusChange = true
    end if
End Function