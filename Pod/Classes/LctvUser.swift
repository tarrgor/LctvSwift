//
//  LctvUser.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvUser : JSONInitializable {

  public var url: String?
  public var userName: String?
  public var slug: String?
  public var country: String?
  public var city: String?
  public var favoriteProgramming: String?
  public var favoriteIde: String?
  public var favoriteCodingBackgroundMusic: String?
  public var favoriteCode: String?
  public var yearsProgramming: Int?
  public var wantLearn: Array<String>? = []
  public var registrationDate: String?
  public var timeZone: String?
  public var viewingKey: String?
  
  public init(json: JSON) {
    url = json["url"].string
    userName = json["username"].string
    slug = json["slug"].string
    country = json["country"].string
    city = json["city"].string
    favoriteProgramming = json["favorite_programming"].string
    favoriteIde = json["favorite_ide"].string
    favoriteCodingBackgroundMusic = json["favorite_coding_background_music"].string
    favoriteCode = json["favorite_code"].string
    yearsProgramming = json["years_programming"].int
    registrationDate = json["registration_date"].string
    timeZone = json["timezone"].string
    viewingKey = json["viewing_key"].string
    
    let wantLearnArray = json["want_learn"].arrayObject
    wantLearnArray?.forEach({ entry in
      wantLearn?.append(entry as! String)
    })
  }
}