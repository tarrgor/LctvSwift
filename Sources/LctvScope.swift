//
//  LctvScope.swift
//  Pods
//
//  Created by Thorsten Klusemann on 06.03.16.
//
//

import Foundation

public enum LctvScope : String {
  
  case Read = "read"
  case ReadViewer = "read:viewer"
  case ReadUser = "read:user"
  case ReadChannel = "read:channel"
  case Chat = "chat"

  static func toScopeString(scope: [LctvScope]) -> String {
    var result = ""
    var first: Bool = true
    for currentScope in scope {
      if !first {
        result += " "
      }
      first = false
      result += "\(currentScope.rawValue)"
    }
    return result
  }
}