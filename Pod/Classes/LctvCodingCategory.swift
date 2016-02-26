//
//  LctvCodingCategory.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvCodingCategory : JSONInitializable {
  
  var name: String?
  var url: String?
  var sort: Int?
  
  public init(json: JSON) {
    name = json["name"].string
    url = json["url"].string
    sort = json["sort"].int
  }
}