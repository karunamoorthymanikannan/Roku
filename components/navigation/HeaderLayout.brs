Sub init()
    m.menuPrimaryLogo = m.top.findNode("primaryImage")
    m.menuSecondaryLogo = m.top.findNode("secondaryImage")
    m.serverLogo = m.top.findNode("serverLogo")
    m.settingsNotFocused = m.top.findNode("settingsNotFocused")
    m.menuList = m.top.findNode("menuList")
    m.temp = m.top.findNode("temp")
    m.sky = m.top.findNode("sky")
    m.menuList.ObserveField("itemFocused", "menuFocusChanged")
    m.menuList.ObserveField("itemUnFocused", "menuUnFocusChanged")
    appInfo = CreateObject("roAppInfo")
    m.logoPath = LCase(appInfo.GetValue("mm_icon_focus_hd"))
    m.menuPrimaryLogo.uri = m.logoPath
    m.menuSecondaryLogo.uri = m.logoPath
End Sub

Function updateHeaderDetails() as Void
    headerDetails = m.top.headerData
    m.serverLogo.uri = headerDetails.weatherHeaderUrl
    m.temp.text = headerDetails.weatherHeaderTemp
    m.sky.text = headerDetails.weatherHeaderSky
End Function

Function menuFocusChanged() as Void
    itemFocused = m.menuList.itemFocused
    m.top.menuFocuesdItem = itemFocused
    m.settingsNotFocused.visible = itemFocused <> 2
    m.menuSecondaryLogo.visible = itemFocused = 2
End Function 

Function menuUnFocusChanged() as Void
   m.top.menuUnFocuesdItem = m.menuList.itemUnFocused
End Function

Function updateHeaderMenu() as Void
    data = CreateObject("roSGNode", "ContentNode")
    dataItem = m.top.configData
    if dataItem <> invalid AND dataItem.navigation <> invalid
        navigationItem = dataItem.navigation
        for each navigationDetails in navigationItem
            listItem = data.CreateChild("ContentNode")
            listItem.title = navigationDetails.name
        end for
        m.menuList.content = data
        m.menuList.SetFocus(true)
    end if    
End Function

Function setViewFocus() as Void
    m.menuList.SetFocus(m.top.setFocus)
End Function

Function onKeyEvent(key as String, press as Boolean) as Boolean
    if press AND (key = "right" OR key = "left")
        return true
    end if
    return false    
End Function