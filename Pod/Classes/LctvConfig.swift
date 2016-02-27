//
//  LctvConfig.swift
//  Pods
//
//  Created by Thorsten Klusemann on 27.02.16.
//
//

import Foundation

public enum LctvGrantType {
  case AuthorizationCode
  //case Implicit         // currently unsupported
}

public struct LctvConfig {
  
  public var clientId: String? = nil
  public var clientSecret: String? = nil
  public var grantType: LctvGrantType = .AuthorizationCode
  public var overwrite: Bool = false
  
  public init() {
    
  }
}