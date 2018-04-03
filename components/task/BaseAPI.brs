Sub init()  
    globalUrls = CreateObject("roSGNode", "Urls")
    m.top.hostUrl = globalUrls.hostUrl
    m.top.isHeaderNeed = globalUrls.isHeaderNeed
End Sub
 
 'Generic GET Request
 Function getContent(urlString As String) As Dynamic 
    sslEnabled = false
    if  Left(urlString, 5) = "https"
        sslEnabled = true
    end if
    request = buildUrlRequest(urlString, "GET", sslEnabled, invalid)
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    
	if (request.AsyncGetToString())
	   while (true)
	       serverResponse = wait(0, port)
	       if (type(serverResponse) = "roUrlEvent")
	           pareseServerResult(serverResponse)
	       else if (type(msg) = invalid)
	            request.AsyncCancel() 
	       end if
	       EXIT WHILE
	   end while
	end if
	return m.top.responseData
End Function 

'Generic parse server response string to JSON for all the request. 
Function pareseServerResult(serverResponse as Object) as Void
    responseString = serverResponse.GetString()
    responseCode = serverResponse.GetResponseCode()
    m.top.responseCode = responseCode
    m.top.responseString = responseString
    response = invalid
    if responseString <> invalid AND responseString <> "" then
        response = ParseJSON(responseString)
    end if
    m.top.responseData = {
            data : response
        }
 End Function
 
 'Inner function - Build URL request for all the Requests
 Function buildUrlRequest(urlString as String, methodType As String, sslEnabled as Boolean, requestParams As Dynamic) as Dynamic
    request = CreateObject("roUrlTransfer")
    request.SetUrl(urlString)
    requestHeaders = {
        "customerID": "8500529",
        "useremail": "discussion_api@clickability.com"
    }    
    request.RetainBodyOnError(true)
    request.EnableEncodings(true)
    request.SetRequest(methodType)
    if m.top.isHeaderNeed
        request.SetHeaders(requestHeaders)
    end if
    if sslEnabled then
        request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    end if
    printServerCall(request, requestHeaders, requestParams)
    return request
 End Function
 
 'Print the Curl Request details
 Function printServerCall(urlObject As Object, requestHeaders As Dynamic, requestParams As Dynamic) as Void
    return
    print "********* Curl Request *********"
    finalCommand = "curl -i"    
    if urlObject.GetRequest() = "POST"
        finalCommand = "curl -X POST -i"
    end if
    
    if requestHeaders <> invalid AND requestHeaders.Count() > 0
        for each key in requestHeaders
            finalCommand = finalCommand + " -H "+Chr(34)+key+": "+requestHeaders.LookUp(key)+Chr(34)
        end for
    end if
    
    if requestParams <> invalid
        'TODO for url encoded input no need to add enclosing double quotes in data
        finalCommand = finalCommand + " -d "+Chr(39)+FormatJson(requestParams)+Chr(39)
    else
    end if   
    finalCommand = finalCommand + " "+Chr(34)+urlObject.GetUrl()+Chr(34)
    print finalCommand
End Function