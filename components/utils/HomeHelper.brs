'Animations for Home Screen
Function hideNavigationMenuAnimation() as Void
    if m.headerLayout.translation[1] = m.defaultAnimatePosition
        m.hideNavigationMenuAnimation.control = "start"
        m.headerLayout.setFocus = false
        if m.sectionList.visible
            setFocusOnSectionScreen()
        else if m.weather.visible
            setFocusOnWeatherScreen()
        else
            setFoucusOnSettingScreen()
        end if
    else if m.weather.updateWeatherFocus AND m.headerLayout.translation[1] = m.translateHeaderAnimatePosition
        slideupWeatherAnimation()
    end if
End Function

Function showNavigationMenuAnimation() as Void
    if m.headerLayout.translation[1] = m.translateHeaderAnimatePosition
        if m.weather.updateWeatherFocus AND m.bgOverlay.translation[1] = m.translateWeatherAnimatePosition
            slidedownWetharAnimation()
        else
            m.showNavigationMenuAnimation.control = "start"
            m.sectionList.setFocus(false)
            m.weather.updateWeatherFocus = false
            m.headerLayout.setFocus = true
        end if        
    end if
End Function

Function slideupWeatherAnimation() as Void
    m.slideupWeatherAnimation.control = "start"
    m.weather.setFocus(true)
End Function

Function slidedownWetharAnimation() as Void
    m.slidedownWetharAnimation.control = "start"
    m.weather.setFocus(false)
    m.headerLayout.setFocus = true
End Function
