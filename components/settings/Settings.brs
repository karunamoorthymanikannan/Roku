Sub Init()
'    normalfont  = CreateObject("roSGNode", "Font")
'    normalfont.size = 24
'    focusedfont  = CreateObject("roSGNode", "Font")
'    focusedfont.size = 34
'    m.top.font = normalfont
'    m.top.focusedFont = focusedfont

    m.top.itemSize = [400,72]
    m.top.itemSpacing = [0,22]
    m.top.numRows = 4
    m.top.drawFocusFeedback = false
    m.top.vertFocusAnimationStyle = "floatingFocus"
    m.top.color = "0xFFFFFFBF"
    m.top.focusedColor = "0xFFFFFF"
    m.top.content = getSettingContents()
    
End Sub

Function getSettingContents() as Object
    settingsContent = CreateObject("roSGNode", "ContentNode")
    settingsData = ["PRIVACY POLICY","TERMS OF SERVICE","LEGAL NOTICES","SEND FEEDBACK"]
    for each contentData in settingsData
        label = settingsContent.CreateChild("ContentNode")
        label.title = contentData
    end for
    return settingsContent
End Function