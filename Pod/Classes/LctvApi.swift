//
//  LctvApi.swift
//  Pods
//
//  Created by Thorsten Klusemann on 20.02.16.
//
//

import Foundation
import OAuthSwift

/**
 Main class used for the communication between your client (app) and 
 livecoding.tv. 
 
 Has to be initialized with the static `initializeWithConfig` method.
*/
public class LctvApi {
  /// Manager for internal http server
  let serverUtil = HttpServerUtil()
  
  /**
   URL handler used to process the oAuth2 authorization.
   
   Typically a view controller which implements the `OAuthSwiftURLHandlerType`
   protocol. This view controller presents a web view to handle user login
   and authorization of the app.
   
   LctvSwift provides a default implementation with the `LctvAuthViewController`
   class.
  */
  public var oAuthUrlHandler: OAuthSwiftURLHandlerType? = nil
  
  /// The page size for pageable result containers.
  public var pageSize: Int = 50
  
  /// Container for authorization information. Stored in the keychain.
  var _authInfo: LctvAuthInfo? = nil
  
  /**
    Initializer (internal). Use the static `initializeWithConfig` method for
    initialization.
  */
  init(authInfo: LctvAuthInfo) {
    _authInfo = authInfo
  }
  
  /// Deinitializer. Stops any running http servers.
  deinit {
    serverUtil.stopServer()
  }
  
  /**
   Main initialization method for `LctvApi`.
   
   - parameter config: A valid `LctvConfig` instance with basic configuraton info.
   
   - returns: The instance of `LctvApi` which should be stored in an accessible manner, so that
   each part of the app is able to access it. 
   
   - throws: `LctvInitError`
  */
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








