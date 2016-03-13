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
  
  /**
   Handles oAuth2 authorization with livecoding.tv. If an `oAuthUrlHandler` is
   configured, it will be used to handle the authorization process (e.g. opening
   a web view, so the user can login and authorize the app).
   
   - parameter scope: Specifies the needed permissions within a space separated string. For a list
   of available permissions visit livecoding.tv homepage.
   
   - throws: `LctvInitError`
  */
  public func authorize(scope scope: [LctvScope] = [.Read]) throws {
    guard let authInfo = _authInfo else {
      throw LctvInitError.AuthorizationInfoNotInitializedError
    }
    
    let oauthswift = OAuth2Swift(
      consumerKey:    authInfo.clientId,
      consumerSecret: authInfo.secret,
      authorizeUrl:   ApiUrl.urlLctvAuthorize,
      accessTokenUrl: ApiUrl.urlLctvToken,
      responseType:   kOAuthResponseTypeCode
    )
    let state: String = generateStateWithLength(20) as String
    
    oauthswift.allowMissingStateCheck = mocking
    
    try serverUtil.startServer()
    
    if let handler = oAuthUrlHandler {
      oauthswift.authorize_url_handler = handler
    }
    
    oauthswift.authorizeWithCallbackURL( NSURL(string: ApiUrl.urlCallback(serverUtil.internalPort))!,
      scope: LctvScope.toScopeString(scope),
      state: state, success: {
        credential, response, parameters in
        self._authInfo?.accessToken = credential.oauth_token
        if let refreshToken = parameters[kOAuthRefreshToken] {
          self._authInfo?.refreshToken = refreshToken
        }
        try! self._authInfo?.updateInSecureStore()
        self._authInfo?.clientId = ""
        self._authInfo?.secret = ""
        self.serverUtil.stopServer()
        if let callback = self.onAuthorizationSuccess {
          callback()
        }
      }, failure: { error in
        self.serverUtil.stopServer()
        if let callback = self.onAuthorizationFailure {
          callback(error.localizedDescription)
        }
    })
  }

  /**
   Refreshes the access token if it is expired. Works only with grantType = AuthorizationCode.
   
   If successful, a new access token is stored in the keychain for further access of livecoding.tv
   resources.
   
   - parameter success: Handler for successful refresh of the token.
   - parameter failure: Handler for error cases.
  */
  public func refreshToken(success: (() -> ())? = nil, failure: ((NSError) -> ())? = nil) {
    if let authInfo = _authInfo, hasToken = _authInfo?.hasAccessToken() {
      if hasToken {
        if let loadedAuthInfo = authInfo.readFromSecureStore() {
          authInfo.clientId = (loadedAuthInfo.data?["clientId"] as? String) ?? ""
          authInfo.secret = (loadedAuthInfo.data?["secret"] as? String) ?? ""
          
          let oauthswift = OAuth2Swift(
            consumerKey:    authInfo.clientId,
            consumerSecret: authInfo.secret,
            authorizeUrl:   ApiUrl.urlLctvAuthorize,
            accessTokenUrl: ApiUrl.urlLctvToken,
            responseType:   kOAuthResponseTypeCode
          )
          
          let parameters = [
            "grant_type":kOAuthRefreshToken,
            kOAuthRefreshToken:authInfo.refreshToken,
            "client_id":authInfo.clientId,
          ]
          oauthswift.client.post(ApiUrl.urlLctvToken, parameters: parameters, headers: httpHeaders(), success: { data, response in
            let json = JSON(data: data)
            authInfo.accessToken = json[kOAuthAccessToken].string!
            authInfo.refreshToken = json[kOAuthRefreshToken].string!
            try! authInfo.updateInSecureStore()
            authInfo.clientId = ""
            authInfo.secret = ""
            if let callback = success {
              callback()
            }
          }, failure: { error in
            authInfo.clientId = ""
            authInfo.secret = ""
            if let callback = failure {
              callback(error)
            }
          })
        }
      }
    }
  }
  
  /**
   Delete any existing authorization info from the keychain. The LctvApi instance has to be
   re-initialized afterwards.
  */
  public func deleteAuthInfo() {
    let _ = try? _authInfo?.deleteFromSecureStore()
    _authInfo = nil
  }
  
  /**
   Check if an access token is already in place. This method can be used to determine, 
   if a call to `authorize()` is necessary or not.
   
   - returns: `true` if an access token is stored in the keychain. `false` otherwise.
  */
  public func hasAccessToken() -> Bool {
    let result: Bool? = _authInfo?.hasAccessToken()
    return result ?? false
  }
  
  /**
   Retrieve the current access token if available. May return nil in case of an incorrect
   initialized api instance.
   
   - returns: The current access token if available. Nil otherwise.
  */
  public func getAccessToken() -> String? {
    return _authInfo?.accessToken
  }
  
  /**
   Retrieve a set of http headers including the authorization information

   - returns: A dictionary with http header information needed to authorize against livecoding.
  */
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

  /* -- For debugging only */
  public func logAuthInfo() {
    print("AuthInfo:")
    print("=========")
    print("ClientId: \(_authInfo?.clientId)")
    print("Secret  : \(_authInfo?.secret)")
    print("Token   : \(_authInfo?.accessToken)")
    print("RefToken: \(_authInfo?.refreshToken)")
  }
  /**/
}