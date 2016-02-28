//
//  LctvConfig.swift
//  Pods
//
//  Created by Thorsten Klusemann on 27.02.16.
//
//

import Foundation

/**
 Enumeration of oAuth2 grant types:
 
 - AuthorizationCode
 - Implicit (currently not supported)
*/
public enum LctvGrantType {
  case AuthorizationCode
  case Implicit
}

/**
 Initial configuration of the API. Create an instance of LctvConfig before initializing
 the API and provide it with some default config.
*/
public struct LctvConfig {
  
  /**
   The client id used to identify the app against
   the livecoding.tv authorization server. 
   
   It is only necessary to define this when the api instance gets
   initialized for the first time. Afterwards this 
   information is stored within the keychain. Please
   provide this information in a secure manner.
  */
  public var clientId: String? = nil
  
  /**
   The client secret. Like the client id needed to identify the app
   against livecoding.tv authorization server.
   
   The secret is only needed the first time when the api instance gets
   initialized, please do so in a secure manner. It is not needed when
   using `grantType` = `Implicit`.
  */
  public var clientSecret: String? = nil
  
  /**
   OAuth2 grant type to use. Currently only `AuthorizationCode` is
   supported.
  */
  public var grantType: LctvGrantType = .AuthorizationCode
  
  /**
   Set this to true if you want to overwrite any existing authorization
   info in the keychain. You will need to specify `clientId` and 
   `clientSecret` again with this config. Defaults to `false`.
  */
  public var overwrite: Bool = false
  
  /// Initialization of an empty config.
  public init() {
    
  }
  
  /// Initialization with `clientId` and `clientSecret`.
  public init(clientId: String, clientSecret: String) {
    self.clientId = clientId
    self.clientSecret = clientSecret
  }
}