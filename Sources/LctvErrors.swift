//
//  LctvError.swift
//  Pods
//
//
//

import Foundation

public enum LctvInitError : ErrorType {
  
  case ApiInitializationError(message: String)
  case AuthorizationInfoNotInitializedError
  case StartLocalServerError(message: String)
  
}
