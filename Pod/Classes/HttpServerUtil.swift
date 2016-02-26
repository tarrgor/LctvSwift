//
//  HttpServerUtil.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import Swifter
import OAuthSwift

class HttpServerUtil {
  
  var server: HttpServer = HttpServer()
  
  init() {
    
  }
  
  func httpHandler(request: HttpRequest) -> HttpResponse {
    OAuthSwift.handleOpenURL(urlFromHttpRequest(request)!)
    return .OK(.Html("OK"))
  }
  
  func startServer() throws {
    server["/oauth-callback"] = httpHandler
    do {
      try server.start()
    } catch {
      throw LctvInitError.StartLocalServerError
    }
  }
  
  func stopServer() {
    server.stop()
  }
  
  func urlFromHttpRequest(request: HttpRequest) -> NSURL? {
    var qPath = "?"
    request.queryParams.forEach { param in
      if qPath != "?" {
        qPath += "&"
      }
      qPath += "\(param.0)=\(param.1)"
    }
    let url = "http://localhost:8080/oauth-callback\(qPath)"
    return NSURL(string: url)
  }
}