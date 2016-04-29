//
//  LctvCodingCategory.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

public struct LctvCodingCategory : JSONInitializable {
  
  public var name: String?
  public var url: String?
  public var sort: Int?
  
  public init(json: JSON) {
    name = json["name"].string
    url = json["url"].string
    sort = json["sort"].int
  }
}