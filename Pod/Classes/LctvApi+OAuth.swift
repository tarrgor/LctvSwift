//
//  LctvApi+OAuth.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import OAuthSwift
import SwiftyJSON

extension LctvApi {
  
  public func authorize(scope scope: String = "read") throws {
    guard let authInfo = _authInfo else {
      throw LctvInitError.AuthorizationInfoNotInitializedError
    }
    
    let oauthswift = OAuth2Swift(
      consumerKey:    authInfo.clientId,
      consumerSecret: authInfo.secret,
      authorizeUrl:   "https://www.livecoding.tv/o/authorize/",
      accessTokenUrl: "https://www.livecoding.tv/o/token/",
      responseType:   "code"
    )
    let state: String = generateStateWithLength(20) as String
    
    try serverUtil.startServer()
    
    if let handler = oAuthUrlHandler {
      oauthswift.authorize_url_handler = handler
    }
    
    oauthswift.authorizeWithCallbackURL( NSURL(string: "http://localhost:8080/oauth-callback")!,
      scope: scope,
      state: state, success: {
        credential, response, parameters in
        self._authInfo?.accessToken = credential.oauth_token
        if let refreshToken = parameters["refresh_token"] {
          self._authInfo?.refreshToken = refreshToken
        }
        try! self._authInfo?.updateInSecureStore()
        self.serverUtil.stopServer()
      }, failure: { error in
        print(error.localizedDescription)
        self.serverUtil.stopServer()
    })
  }

  public func refreshToken(success: (() -> ())? = nil, failure: ((NSError) -> ())? = nil) {
    if let authInfo = _authInfo, hasToken = _authInfo?.hasAccessToken() {
      if hasToken {
        let oauthswift = OAuth2Swift(
          consumerKey:    authInfo.clientId,
          consumerSecret: authInfo.secret,
          authorizeUrl:   "https://www.livecoding.tv/o/authorize/",
          accessTokenUrl: "https://www.livecoding.tv/o/token/",
          responseType:   "code"
        )

        let parameters = [
          "grant_type":"refresh_token",
          "refresh_token":authInfo.refreshToken,
          "client_id":authInfo.clientId,
        ]
        oauthswift.client.post("https://www.livecoding.tv/o/token/", parameters: parameters, headers: httpHeaders(), success: { data, response in
          let json = JSON(data: data)
          self._authInfo?.accessToken = json["access_token"].string!
          self._authInfo?.refreshToken = json["refresh_token"].string!
          try! self._authInfo?.updateInSecureStore()
          if let callback = success {
            callback()
          }
        }, failure: { error in
          print(error)
          if let callback = failure {
            callback(error)
          }
        })
      }
    }
  }
  
  public func deleteAuthInfo() {
    let _ = try? _authInfo?.deleteFromSecureStore()
    _authInfo = nil
  }
  
  public func hasAccessToken() -> Bool {
    let result: Bool? = _authInfo?.hasAccessToken()
    return result ?? false
  }
  
  func httpHeaders() -> [String:String] {
    guard let authInfo = _authInfo else { return [:] }
    if !authInfo.hasAccessToken() {
      return [:]
    }
    return [
      "Authorization":"Bearer \(authInfo.accessToken)",
      "Accept":"application/json"
    ]
  }
  
  public func logAuthInfo() {
    print("AuthInfo:")
    print("=========")
    print("ClientId: \(_authInfo?.clientId)")
    print("Secret  : \(_authInfo?.secret)")
    print("Token   : \(_authInfo?.accessToken)")
    print("RefToken: \(_authInfo?.refreshToken)")
  }
}