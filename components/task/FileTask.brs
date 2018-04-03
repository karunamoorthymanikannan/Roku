Sub Init()
    
End Sub

'Read the data from local file.
 Function readLocalFile(filePath = "" As String) As Void
    filePath = "tmp:/" + m.top.fileName + ".txt"
    fileContent = ReadAsciiFile(filePath)  
    m.top.responseData = ParseJson(fileContent)
End Function
 
'Write the data to store local file to use any where in our application.
Function saveDataToFile() As Void
    if m.top.inputData <> invalid
        resultData = m.top.inputData
        WriteAsciiFile("tmp:/" + m.top.fileName + ".txt" , FormatJson(resultData))   
        print "File = " + m.top.fileName + " Saved"     
    end if
End Function