//
//  ApiUrls.swift
//  Pods
//
//  Created by Thorsten Klusemann on 02.03.16.
//
//

import Foundation

enum ApiUrl : String {
  static var apiVersion = "v1"
  static var apiBaseUrl = "https://www.livecoding.tv:443/api/"
  
  static var urlLctvAuthorize = "https://www.livecoding.tv/o/authorize/"
  static var urlLctvToken = "https://www.livecoding.tv/o/token/"
  static var urlCallback = "http://localhost:8080/oauth-callback"
  
  case CodingCategories = "/codingcategories/"
  case Livestreams = "/livestreams/"
  case LivestreamsOnAir = "/livestreams/onair"
  case Languages = "/languages/"
  case CurrentUser = "/user/"
  case Followers = "/user/followers/"
  case Follows = "/user/follows/"
  case ChatAccount = "/user/chat/account/"
  case ViewingKey = "/user/viewing_key/"
  case UserVideos = "/user/videos/"
  case UserLatestVideos = "/user/videos/latest/"
  case UserChannel = "/user/livestreams/"
  case UserChannelOnAir = "/user/livestreams/onair/"
  case UserProfile = "/users/"
  case ScheduledBroadcasts = "/scheduledbroadcast/"
  case Videos = "/videos/"
  
  var url: String {
    return "\(ApiUrl.apiBaseUrl)\(ApiUrl.apiVersion)\(self.rawValue)"
  }
}