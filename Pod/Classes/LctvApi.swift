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
  
  public init() throws {
    let authInfo = LctvAuthInfo()
    guard let newAuthInfo = authInfo.readFromSecureStore() else {
      throw LctvInitError.ApiInitializationError
    }
    guard let clientId = newAuthInfo.data?["clientId"] as? String else {
      throw LctvInitError.ApiInitializationError
    }
    guard let secret = newAuthInfo.data?["secret"] as? String else {
      throw LctvInitError.ApiInitializationError
    }
    guard let accessToken = newAuthInfo.data?["accessToken"] as? String else {
      throw LctvInitError.ApiInitializationError
    }
    guard let refreshToken = newAuthInfo.data?["refreshToken"] as? String else {
      throw LctvInitError.ApiInitializationError
    }
    authInfo.clientId = clientId
    authInfo.secret = secret
    authInfo.accessToken = accessToken
    authInfo.refreshToken = refreshToken
    _authInfo = authInfo
  }
  
  public init(clientId: String, secret: String) throws {
    _authInfo = LctvAuthInfo()
    _authInfo?.clientId = clientId
    _authInfo?.secret = secret
    do {
      let _ = try? _authInfo?.deleteFromSecureStore()
      try _authInfo?.createInSecureStore()
    } catch {
      _authInfo = nil
      throw LctvInitError.ApiInitializationError
    }
  }
  
  deinit {
    serverUtil.stopServer()
  }
}