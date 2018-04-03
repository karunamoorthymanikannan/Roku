Sub init()     

End Sub
 
Function getSectionData() As Void
    globalUrls = CreateObject("roSGNode", "Urls")
    sectionUrl = globalUrls.hostUrl + m.top.sectionPath
    resultData = getContent(sectionUrl)
    prepareSectionNode(resultData)
End Function

Function prepareSectionNode(resultData as Object) As Void
    data = CreateObject("roSGNode", "ContentNode")
    listData = resultData.data
    if (listData <> invalid AND listData.sections <> invalid)
        sectionData = listData.sections
        for each sectionItem in sectionData
            if sectionItem.items.Count() > 0
                row = data.CreateChild("ContentNode")
                row.title = UCase(sectionItem.name)
                for each rowItem in sectionItem.items
                    item = row.CreateChild("sectionData") 
                    item.contentImagePath = rowItem.thumbnail
                    item.contentTitle = rowItem.headline
                end for
            end if
        end for
    end if
    m.top.responseNode = data
End Function