//
//  LctvXmppAccount.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

public struct LctvXmppAccount : JSONInitializable {
  public var user: String?
  public var jid: String?
  public var password: String?
  public var color: String?
  public var isStaff: Bool?
  
  public init(json: JSON) {
    user = json["user"].string
    jid = json["jid"].string
    password = json["password"].string
    color = json["color"].string
    isStaff = json["is_staff"].bool
  }
}

