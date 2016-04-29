//
//  LctvAuthInfo.swift
//  Pods
//
//
//

import Foundation
import Locksmith

class LctvAuthInfo : CreateableSecureStorable, GenericPasswordSecureStorable,
  ReadableSecureStorable, DeleteableSecureStorable {
  
  var clientId: String
  var secret: String
  var accessToken: String
  var refreshToken: String
  var grantType: LctvGrantType
  var account: String

  let service = kKeychainService
  
  var data: [String:AnyObject] {
    return [
      "clientId": clientId,
      "secret": secret,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "grantType": grantType == .AuthorizationCode ? "A" : "I"
    ]
  }
  
  init() {
    clientId = ""
    secret = ""
    accessToken = ""
    refreshToken = ""
    grantType = .AuthorizationCode
    account = kKeychainDefaultAccount
  }
  
  func hasAccessToken() -> Bool {
    return !accessToken.isEmpty
  }
}