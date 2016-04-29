//
//  LctvApi.swift
//  Pods
//
//
//

import Foundation
import OAuthSwift
import Locksmith

public typealias AuthSuccessHandler = () -> ()
public typealias AuthFailureHandler = (String) -> ()

/**
 Main class used for the communication between your client (app) and 
 livecoding.tv. 
 
 Has to be initialized with the static `initializeWithConfig` method.
*/
public class LctvApi {
  /// Manager for internal http server
  let serverUtil = HttpServerUtil()
  
  /// API instance is used in Mocking-Mode for testing
  var mocking = false
  
  /// Handler which is called after successfully processing the authorization screen
  public var onAuthorizationSuccess: AuthSuccessHandler? = nil
  
  /// Handler for errors during the authorization process
  public var onAuthorizationFailure: AuthFailureHandler? = nil
  
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
   Main initializer for `LctvApi`.
   
   - parameter config: A valid `LctvConfig` instance with basic configuraton info.
   
   - returns: The instance of `LctvApi` which should be stored in an accessible manner, so that
   each part of the app is able to access it.
   
   - throws: `LctvInitError`
   */
  public init (config: LctvConfig) throws {
    let authInfo = LctvAuthInfo()
    authInfo.account = config.keychainId
    
    if config.overwrite {
      do {
        try authInfo.deleteFromSecureStore()
      }
    }
    
    if !fillAuthInfoFromSecureStore(authInfo) {
      if try !fillAuthInfoFromConfig(authInfo, config: config) {
        throw LctvInitError.ApiInitializationError(message: "Need to specify clientId and secret if api is initialized for the first time.")
      }
    }
    
    _authInfo = authInfo
    serverUtil.internalPort = config.internalPort
  }
  
  /// Deinitializer. Stops any running http servers.
  deinit {
    serverUtil.stopServer()
  }
  
  /**
    Load current stored secure information from the keychain.
  */
  func fillAuthInfoFromSecureStore(authInfo: LctvAuthInfo) -> Bool {
    if let loadedAuthInfo = loadAuthInfoFromKeychain(authInfo) {
      authInfo.accessToken = (loadedAuthInfo.data?["accessToken"] as? String) ?? ""
      authInfo.refreshToken = (loadedAuthInfo.data?["refreshToken"] as? String) ?? ""
      //let grantType = (loadedAuthInfo.data?["grantType"] as? String) ?? "A"
      authInfo.grantType = .AuthorizationCode // TODO: Implicit
      if !authInfo.hasAccessToken() {
        authInfo.clientId = (loadedAuthInfo.data?["clientId"] as? String) ?? ""
        authInfo.secret = (loadedAuthInfo.data?["secret"] as? String) ?? ""
      }
      return true
    }
    return false
  }
  
  /**
   Initialize the secure information instance with data taken from the specified
   configuration. Secret will then be stored in the keychain.
  */
  func fillAuthInfoFromConfig(authInfo: LctvAuthInfo, config: LctvConfig) throws -> Bool {
    if let clientId = config.clientId, secret = config.clientSecret {
      if clientId.isEmpty || secret.isEmpty {
        return false
      }
      
      authInfo.clientId = clientId
      authInfo.secret = secret
      authInfo.grantType = config.grantType

      try storeAuthInfoInKeychain(authInfo)
      
      return true
    }
    return false
  }
  
  /// Store authInfo in the keychain
  func storeAuthInfoInKeychain(authInfo: LctvAuthInfo) throws {
    do {
      try authInfo.createInSecureStore()
    } catch {
      throw LctvInitError.ApiInitializationError(message: "Could not store authInfo in keychain.")
    }
  }
  
  /// Read authInfo from keychain
  func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
    return authInfo.readFromSecureStore()
  }
}








