//
//  LctvError.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation

public enum LctvInitError : ErrorType {
  
  case ApiInitializationError(message: String)
  case AuthorizationInfoNotInitializedError
  case StartLocalServerError(message: String)
  
}
