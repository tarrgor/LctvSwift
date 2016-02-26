//
//  LctvScheduledBroadcast.swift
//  Pods
//
//  Created by Thorsten Klusemann on 25.02.16.
//
//

import Foundation
import SwiftyJSON

public struct LctvScheduledBroadcast : JSONInitializable {
  var id: Int?
  var title: String?
  var livestream: String?
  var codingCategory: String?
  var difficulty: String?
  var startTime: String?
  var startTimeOriginalTimezone: String?
  var originalTimezone: String?
  var isFeatured: Bool?
  var isRecurring: Bool?
  
  public init(json: JSON) {
    id = json["id"].int
    title = json["title"].string
    livestream = json["livestream"].string
    codingCategory = json["coding_category"].string
    difficulty = json["difficulty"].string
    startTime = json["start_time"].string
    startTimeOriginalTimezone = json["start_time_original_timezone"].string
    originalTimezone = json["original_timezone"].string
    isFeatured = json["is_featured"].bool
    isRecurring = json["is_recurring"].bool
  }
}







