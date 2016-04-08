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
  
  public var url: String?
  public var user: String?
  public var userSlug: String?
  public var title: String?
  public var description: String?
  public var codingCategory: String?
  public var difficulty: String?
  public var language: String?
  public var tags: String?
  public var isLive: Bool?
  public var viewersLive: Int?
  public var viewingUrls: Array<String>?

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