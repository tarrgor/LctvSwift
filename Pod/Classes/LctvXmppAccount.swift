//
//  LctvXmppAccount.swift
//  Pods
//
//  Created by Thorsten Klusemann on 22.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvXmppAccount : JSONInitializable {
  var user: String?
  var jid: String?
  var password: String?
  var color: String?
  var isStaff: Bool?
  
  public init(json: JSON) {
    user = json["user"].string
    jid = json["jid"].string
    password = json["password"].string
    color = json["color"].string
    isStaff = json["is_staff"].bool
  }
}

