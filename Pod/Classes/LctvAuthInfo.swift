//
//  LctvAuthInfo.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
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
  
  var account: String { return "lctv-swift" }
  let service = "lctv.swift.LivecodingTV"
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
  }
  
  func hasAccessToken() -> Bool {
    return !accessToken.isEmpty
  }
}