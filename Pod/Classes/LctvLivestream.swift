//
//  LctvLivestream.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvLivestream : JSONInitializable {
  
  var url: String?
  var user: String?
  var userSlug: String?
  var title: String?
  var description: String?
  var codingCategory: String?
  var difficulty: String?
  var language: String?
  var tags: String?
  var isLive: Bool?
  var viewersLive: Int?
  var viewingUrls: Array<String>?

  public init(json: JSON) {
    url = json["url"].string
    user = json["user"].string
    userSlug = json["user__slug"].string
    title = json["title"].string
    description = json["description"].string
    codingCategory = json["coding_category"].string
    difficulty = json["difficulty"].string
    language = json["language"].string
    tags = json["tags"].string
    isLive = json["is_live"].bool
    viewersLive = json["viewers_live"].int
    viewingUrls = []
    
    let urls = json["viewing_urls"].arrayObject
    urls?.forEach({ url in
      self.viewingUrls?.append(url as! String)
    })
  }

}