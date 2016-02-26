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
      authorizeUrl:   kUrlLctvAuthorize,
      accessTokenUrl: kUrlLctvToken,
      responseType:   kOAuthResponseTypeCode
    )
    let state: String = generateStateWithLength(20) as String
    
    try serverUtil.startServer()
    
    if let handler = oAuthUrlHandler {
      oauthswift.authorize_url_handler = handler
    }
    
    oauthswift.authorizeWithCallbackURL( NSURL(string: kUrlOAuthCallback)!,
      scope: scope,
      state: state, success: {
        credential, response, parameters in
        self._authInfo?.accessToken = credential.oauth_token
        if let refreshToken = parameters[kOAuthRefreshToken] {
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
          authorizeUrl:   kUrlLctvAuthorize,
          accessTokenUrl: kUrlLctvToken,
          responseType:   kOAuthResponseTypeCode
        )

        let parameters = [
          "grant_type":kOAuthRefreshToken,
          kOAuthRefreshToken:authInfo.refreshToken,
          "client_id":authInfo.clientId,
        ]
        oauthswift.client.post(kUrlLctvToken, parameters: parameters, headers: httpHeaders(), success: { data, response in
          let json = JSON(data: data)
          self._authInfo?.accessToken = json[kOAuthAccessToken].string!
          self._authInfo?.refreshToken = json[kOAuthRefreshToken].string!
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
      kHttpHeaderAuthorization:"Bearer \(authInfo.accessToken)",
      kHttpHeaderAccept:kMimeTypeJson
    ]
  }

  /*
  public func logAuthInfo() {
    print("AuthInfo:")
    print("=========")
    print("ClientId: \(_authInfo?.clientId)")
    print("Secret  : \(_authInfo?.secret)")
    print("Token   : \(_authInfo?.accessToken)")
    print("RefToken: \(_authInfo?.refreshToken)")
  }
  */
}