Function init()
    print "initViews()"
    'm.splashVideo = m.top.findNode("loadSplashVideo")
    m.bgOverlay = m.top.findNode("bgOverlay")
    m.settings = m.top.findNode("settings")
    m.sectionList = m.top.findNode("sectionList")
    m.headerLayout = m.top.findNode("headerLayout")
    'm.weather = m.top.findNode("weather")
    m.weather = CreateObject("roSGNode", "Weather")
    m.spinner = m.top.findNode("spinner")
   
    m.hideNavigationMenuAnimation = m.top.FindNode("hideNavigationMenuAnimation")
    m.showNavigationMenuAnimation = m.top.FindNode("showNavigationMenuAnimation")
    m.slideupWeatherAnimation = m.top.FindNode("slideupWeatherAnimation")
    m.slidedownWetharAnimation = m.top.FindNode("slidedownWetharAnimation")
    m.headerLayout.setFocus = true
    m.headerLayout.ObserveField("menuFocuesdItem", "headerMenuFocused")
    m.headerLayout.ObserveField("menuUnFocuesdItem", "headerMenuUnFocused")
    m.settings.ObserveField("itemSelected", "settingItemClicked")
    'm.splashVideo.observeField("videoStatusChange", "closeIntroVideo")
    m.video = m.top.findNode("weatherVideo")
    url = "pkg:/asset/bayarea/video/introduction.mp4"
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = url
    videoContent.enableUI = false
    videoContent.enableTrickPlay = false
    videoContent.bufferingBar = ""
    videoContent.retrievingBar = ""
    videoContent.streamformat = "mp4"
    m.video.VideoDisableUI = true
    m.video.content = videoContent
    m.video.bufferingBar.scale = [0,0]
    m.video.retrievingBar.scale = [0,0]
    m.video.observeField("state", "showStatus")
    m.configData = invalid
    m.showingCurrentScreen = invalid
    
    m.allSectionNode = {
    "0" : CreateObject("roSGNode", "ContentNode"),
    "1" : CreateObject("roSGNode", "ContentNode"),
    "2" : CreateObject("roSGNode", "ContentNode")
    }
    showSpinner() 
    initConstant()
    print m.ss
End Function

Function showStatus() As Void
    print m.video.state
    if m.video.state = "finished"
        m.video.control = "replay"
    end if
End Function

Function closeIntroVideo() as Void
    m.splashVideo.visible = false
End Function

Function settingItemClicked() as Void
    settingsSelected = m.settings.itemSelected
    settingsItemContent = m.settings.content.getChild(settingsSelected)
    m.showingCurrentScreen = CreateObject("roSGNode", "SettingDetails")
    m.showingCurrentScreen.ObserveField("closedDetailsScreen","setFoucusOnSettingScreen")
    m.top.appendChild(m.showingCurrentScreen)
    m.showingCurrentScreen.updateDetailsScreen = settingsItemContent
End Function

Function headerMenuFocused() as Void
    m.menuPosition = m.headerLayout.menuFocuesdItem
    m.sectionList.visible = (m.menuPosition = 0 OR  m.menuPosition = 1)
    m.settings.visible = (m.menuPosition = 3)
    'm.weather.visible = (m.menuPosition = 2)
    m.sectionList.content = m.allSectionNode[m.menuPosition.tostr()]
    if m.menuPosition = 2
        m.top.appendChild(m.weather)
        'm.video.visible = true
        'm.video.control = "play"
    end if   
End Function

Function headerMenuUnFocused() as Void
    if m.headerLayout.menuUnFocuesdItem = 2
        m.video.control = "stop"
        m.video.visible = false
        m.top.removeChild(m.weather)
    end if
End Function

Function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "back"
           if m.showingCurrentScreen <> invalid
                m.top.removeChild(m.showingCurrentScreen)
                m.showingCurrentScreen = invalid
                return true
           end if
        else if key = "up"
            showNavigationMenuAnimation()
            return true
        else if key = "down"
            hideNavigationMenuAnimation() 
            return true          
        else if key = "right" OR key = "left"
            result = true
        end if 
    end if 
    return false 
End Function

Function showSpinner() as Void
    m.spinner.control = "start"
    m.spinner.visible = true
End Function 

Function hidespinner() as Void
    m.spinner.control = "stop"
    m.spinner.visible = false
End Function 

Function setFocusOnSectionScreen() as Void
    m.settings.visible = false
    m.sectionList.visible = true
    m.sectionList.setFocus(true)
End Function

Function setFocusOnWeatherScreen() as Void
    m.weather.setFocus(true)
    m.weather.updateWeatherFocus = true
End Function

Function setFoucusOnSettingScreen() as Void
    m.sectionList.visible = false
    m.settings.visible = true
    m.settings.setFocus(true)
End Function