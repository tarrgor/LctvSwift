//
//  LctvApi.swift
//  Pods
//
//  Created by Thorsten Klusemann on 20.02.16.
//
//

import Foundation
import OAuthSwift

public class LctvApi {
  let serverUtil = HttpServerUtil()
  
  public var oAuthUrlHandler: OAuthSwiftURLHandlerType? = nil
  public var pageSize: Int = 50
  
  var _authInfo: LctvAuthInfo? = nil
  
  init(authInfo: LctvAuthInfo) {
    _authInfo = authInfo
  }
  
  deinit {
    serverUtil.stopServer()
  }
  
  public static func initializeWithConfig(config: LctvConfig) throws -> LctvApi {
    
    let authInfo = LctvAuthInfo()
    if config.overwrite {
      do {
        try authInfo.deleteFromSecureStore()
      }
    }
    
    if let loadedAuthInfo = authInfo.readFromSecureStore() {
      authInfo.accessToken = (loadedAuthInfo.data?["accessToken"] as? String) ?? ""
      authInfo.refreshToken = (loadedAuthInfo.data?["refreshToken"] as? String) ?? ""
      //let grantType = (loadedAuthInfo.data?["grantType"] as? String) ?? "A"
      authInfo.grantType = .AuthorizationCode // TODO: Implicit
      if !authInfo.hasAccessToken() {
        authInfo.clientId = (loadedAuthInfo.data?["clientId"] as? String) ?? ""
        authInfo.secret = (loadedAuthInfo.data?["secret"] as? String) ?? ""
      }
    } else {
      if let clientId = config.clientId, secret = config.clientSecret {
        authInfo.clientId = clientId
        authInfo.secret = secret
        authInfo.grantType = config.grantType
        do {
          try authInfo.createInSecureStore()
        } catch {
          throw LctvInitError.ApiInitializationError(message: "Could not store authInfo in keychain.")
        }
      } else {
        throw LctvInitError.ApiInitializationError(message: "Need to specify clientId and secret if api is initialized for the first time.")
      }
    }
    
    return LctvApi(authInfo: authInfo)
  }
  
}








