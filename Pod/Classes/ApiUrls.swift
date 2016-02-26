//
//  ApiUrls.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import Alamofire
  
let kUrlCodingCategories = "https://www.livecoding.tv:443/api/v1/codingcategories/"
let kUrlLivestreams = "https://www.livecoding.tv:443/api/v1/livestreams/"
let kUrlLivestreamsOnAir = "https://www.livecoding.tv:443/api/v1/livestreams/onair"
let kUrlLanguages = "https://www.livecoding.tv:443/api/v1/languages/"
let kUrlCurrentUser = "https://www.livecoding.tv:443/api/v1/user/"
let kUrlFollowers = "https://www.livecoding.tv:443/api/v1/user/followers/"
let kUrlFollows = "https://www.livecoding.tv:443/api/v1/user/follows/"
let kUrlChatAccount = "https://www.livecoding.tv:443/api/v1/user/chat/account/"
let kUrlViewingKey = "https://www.livecoding.tv:443/api/v1/user/viewing_key/"
let kUrlUserVideos = "https://www.livecoding.tv:443/api/v1/user/videos/"
let kUrlUserLatestVideos = "https://www.livecoding.tv:443/api/v1/user/videos/latest/"
let kUrlUserChannel = "https://www.livecoding.tv:443/api/v1/user/livestreams/"
let kUrlUserChannelOnAir = "https://www.livecoding.tv:443/api/v1/user/livestreams/onair/"
let kUrlUserProfile = "https://www.livecoding.tv:443/api/v1/users/"
let kUrlScheduledBroadcasts = "https://www.livecoding.tv:443/api/v1/scheduledbroadcast/"
let kUrlVideos = "https://www.livecoding.tv:443/api/v1/videos/"

/*
enum Router : URLRequestConvertible {
  static let apiVersion = "v1"
  static let baseUrl = "https://www.livecoding.tv:443/api/\(apiVersion)"
  
  case Followers
  case ViewingKey
  
  var URLRequest: NSMutableURLRequest {
    let result: (path: String, parameters: [String: AnyObject]) = {
      switch self {
      case .Followers:
        return ("/user/followers", [:])
      case .ViewingKey:
        return ("/user/viewing_key", [:])
      }
    }()
    
    let URL = NSURL(string: Router.baseUrl)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
    let encoding = Alamofire.ParameterEncoding.URL
    
    if let authInfo = LctvApi.AuthInfo {
      URLRequest.setValue("Bearer \(authInfo.accessToken)", forHTTPHeaderField: "Authorization")
      URLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    }
   
    return encoding.encode(URLRequest, parameters: result.parameters).0
  }
  
}
*/