//
//  LctvVideo.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

public struct LctvVideo : JSONInitializable {
  
  public var url: String?
  public var slug: String?
  public var user: String?
  public var title: String?
  public var description: String?
  public var codingCategory: String?
  public var difficulty: String?
  public var language: String?
  public var productType: String?
  public var creationTime: String?
  public var duration: Int?
  public var region: String?
  public var viewersOverall: Int?
  public var viewingUrls: Array<String> = []
  public var thumbnailUrl: String?
  
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
    thumbnailUrl = json["thumbnail_url"].string

    if let urls = json["viewing_urls"].arrayObject {
      urls.forEach({ object in
        viewingUrls.append(object as! String)
      })
    }
  }
}
