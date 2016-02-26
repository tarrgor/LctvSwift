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
  public var id: Int?
  public var title: String?
  public var livestream: String?
  public var codingCategory: String?
  public var difficulty: String?
  public var startTime: String?
  public var startTimeOriginalTimezone: String?
  public var originalTimezone: String?
  public var isFeatured: Bool?
  public var isRecurring: Bool?
  
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







