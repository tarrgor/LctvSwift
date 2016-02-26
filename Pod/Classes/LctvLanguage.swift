//
//  LctvLanguage.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvLanguage : JSONInitializable {
  public var name: String?
  public var url: String?
  
  public init(json: JSON) {
    name = json["name"].string
    url = json["url"].string
  }
}