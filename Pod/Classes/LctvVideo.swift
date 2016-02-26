//
//  LctvVideo.swift
//  Pods
//
//  Created by Thorsten Klusemann on 23.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvVideo : JSONInitializable {
  
  var url: String?
  var slug: String?
  var user: String?
  var title: String?
  var description: String?
  var codingCategory: String?
  var difficulty: String?
  var language: String?
  var productType: String?
  var creationTime: String?
  var duration: Int?
  var region: String?
  var viewersOverall: Int?
  var viewingUrls: Array<String> = []
  
  public init(json: JSON) {
    url = json["url"].string
    slug = json["slug"].string
    user = json["user"].string
    title = json["title"].string
    description = json["description"].string
    codingCategory = json["coding_category"].string
    difficulty = json["difficulty"].string
    language = json["language"].string
    productType = json["product_type"].string
    creationTime = json["creation_time"].string
    duration = json["duration"].int
    region = json["region"].string
    viewersOverall = json["viewers_overall"].int

    if let urls = json["viewing_urls"].arrayObject {
      urls.forEach({ object in
        viewingUrls.append(object as! String)
      })
    }
  }
}
