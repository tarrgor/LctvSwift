//
//  ApiUrls.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import Alamofire

let kApiVersion = "v1"
let kApiBaseUrl = "https://www.livecoding.tv:443/api/"
let kUrlCodingCategories = "\(kApiBaseUrl)\(kApiVersion)/codingcategories/"
let kUrlLivestreams = "\(kApiBaseUrl)\(kApiVersion)/livestreams/"
let kUrlLivestreamsOnAir = "\(kApiBaseUrl)\(kApiVersion)/livestreams/onair"
let kUrlLanguages = "\(kApiBaseUrl)\(kApiVersion)/languages/"
let kUrlCurrentUser = "\(kApiBaseUrl)\(kApiVersion)/user/"
let kUrlFollowers = "\(kApiBaseUrl)\(kApiVersion)/user/followers/"
let kUrlFollows = "\(kApiBaseUrl)\(kApiVersion)/user/follows/"
let kUrlChatAccount = "\(kApiBaseUrl)\(kApiVersion)/user/chat/account/"
let kUrlViewingKey = "\(kApiBaseUrl)\(kApiVersion)/user/viewing_key/"
let kUrlUserVideos = "\(kApiBaseUrl)\(kApiVersion)/user/videos/"
let kUrlUserLatestVideos = "\(kApiBaseUrl)\(kApiVersion)/user/videos/latest/"
let kUrlUserChannel = "\(kApiBaseUrl)\(kApiVersion)/user/livestreams/"
let kUrlUserChannelOnAir = "\(kApiBaseUrl)\(kApiVersion)/user/livestreams/onair/"
let kUrlUserProfile = "\(kApiBaseUrl)\(kApiVersion)/users/"
let kUrlScheduledBroadcasts = "\(kApiBaseUrl)\(kApiVersion)/scheduledbroadcast/"
let kUrlVideos = "\(kApiBaseUrl)\(kApiVersion)/videos/"

let kUrlLctvAuthorize = "https://www.livecoding.tv/o/authorize/"
let kUrlLctvToken = "https://www.livecoding.tv/o/token/"

let kUrlOAuthCallback = "http://localhost:8080/oauth-callback"

let kOAuthAccessToken = "access_token"
let kOAuthRefreshToken = "refresh_token"
let kOAuthResponseTypeCode = "code"

let kMimeTypeJson = "application/json"

let kHttpHeaderAuthorization = "Authorization"
let kHttpHeaderAccept = "Accept"




