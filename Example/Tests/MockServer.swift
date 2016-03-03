//
//  MockServer.swift
//  LctvSwift
//
//  Created by Thorsten Klusemann on 02.03.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Swifter
import OAuthSwift
import Alamofire
@testable import LctvSwift

class MockServer {
  
  var server: HttpServer!
  
  init() {
    server = HttpServer()
    
    server["/mocks/v1/codingcategories/"] = codingCategoriesHandler
    server["/mocks/authorize"] = authorizeHandler
    server["/mocks/token"] = tokenHandler
  }
  
  func startServer() {
    try! server.start(9090)
  }
  
  func stopServer() {
    server.stop()
  }
  
  func authorizeHandler(request: HttpRequest) -> HttpResponse {
    print(__FUNCTION__)
    let callbackUrl = ApiUrl.urlCallback
    let state = "DCGwufSUeIwEUe6abMdC"
    let code = "1GWIr5oehziey5vQPZB4rBtYWGnxdY"
    
    return .OK(.Text("\(callbackUrl)?state=\(state)&code=\(code)"))
  }
  
  func tokenHandler(request: HttpRequest) -> HttpResponse {
    print(__FUNCTION__)
    return .OK(.Text("{\"access_token\": \"accessToken\", \"token_type\": \"Bearer\", \"expires_in\": 36000, \"refresh_token\": \"refreshToken\", \"scope\": \"read\"}"))
  }
  
  func codingCategoriesHandler(request: HttpRequest) -> HttpResponse {
    print(__FUNCTION__)
    return .OK(.Text("{ 'test':'entry' }"))
  }
}

extension MockServer : OAuthSwiftURLHandlerType {
  @objc func handle(url: NSURL) {
    print(__FUNCTION__)
    Alamofire.request(.GET, url).response { request, response, data, error in
      let redirect = NSURL(string: NSString(data: data!, encoding: NSUTF8StringEncoding)! as String)
      OAuthSwift.handleOpenURL(redirect!)
    }
  }
}
