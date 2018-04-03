Sub init()
    m.badgeContent = m.top.findNode("badgeContent") 
    m.badgeContentBG = m.top.findNode("badgeContentBG") 
    updateDefaultPlaceHolder() 
End Sub

Function updateDefaultPlaceHolder() as Void
    m.top.loadingBitmapUri = m.top.defaultPlaceHolder
    m.top.failedBitmapUri = m.top.defaultPlaceHolder
End Function

Function updateFocus() as Void
    m.badgeContentBG.opacity = m.top.focusPercent
End Function

Function updateBadgeContent()
     m.badgeContent.text = m.top.badgeContent
End Function