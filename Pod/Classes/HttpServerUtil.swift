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
  var internalPort: UInt16 = 8080
  
  init() {
    
  }
  
  func httpHandler(request: HttpRequest) -> HttpResponse {
    OAuthSwift.handleOpenURL(urlFromHttpRequest(request)!)
    return .OK(.Html("OK"))
  }
  
  func startServer() throws {
    server["/oauth-callback"] = httpHandler
    do {
      try server.start(internalPort)
    } catch {
      throw LctvInitError.StartLocalServerError(message: String(error))
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
    let url = "http://localhost:\(internalPort)/oauth-callback\(qPath)"
    return NSURL(string: url)
  }
}