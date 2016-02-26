//
//  LctvApi+Functions.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

extension LctvApi {
  
  public func getCodingCategories(success: (LctvResultContainer<LctvCodingCategory>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlCodingCategories, success: {
      json in
      let result = LctvResultContainer<LctvCodingCategory>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCodingCategory(name: String, success: (LctvCodingCategory) -> (), failure: (String, JSON?) -> ()) {
    let url = kUrlCodingCategories + "\(name)"
    get(url, success: {
      json in
      let result = LctvCodingCategory(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLivestreams(success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLivestreams, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLivestreamsOnAir(success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLivestreamsOnAir, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLivestream(userSlug: String, success: (LctvLivestream) -> (), failure: (String, JSON?) -> ()) {
    let url = kUrlLivestreams + "\(userSlug)"
    get(url, success: {
      json in
      let result = LctvLivestream(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  public func getLanguages(success: (LctvResultContainer<LctvLanguage>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLanguages, success: {
      json in
      let result = LctvResultContainer<LctvLanguage>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLanguage(name: String, success: (LctvLanguage) -> (), failure: (String, JSON?) -> ()) {
    let url = kUrlLanguages + "\(name)"
    get(url, success: {
      json in
      let result = LctvLanguage(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUser(success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlCurrentUser, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollowers(success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlFollowers, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollows(success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlFollows, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserChatAccount(success: (LctvXmppAccount) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlChatAccount, success: {
      json in
      let result = LctvXmppAccount(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getViewingKey(success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlViewingKey, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserVideos(success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserVideos, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserLatestVideos(success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserLatestVideos, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
      },
      failure: { message, json in
        failure(message, json)
    })
  }
  
  public func getUserChannel(success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserChannel, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  public func getUserChannelOnAir(success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserChannelOnAir, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
      },
      failure: { message, json in
        failure(message, json)
    })
  }
  
  public func getUserProfile(slug: String, success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(kUrlUserProfile)\(slug)"
    get(url, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  public func getScheduledBroadcasts(success: (LctvResultContainer<LctvScheduledBroadcast>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlScheduledBroadcasts, success: {
      json in
      let result = LctvResultContainer<LctvScheduledBroadcast>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getScheduledBroadcast(id: Int, success: (LctvScheduledBroadcast) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(kUrlScheduledBroadcasts)\(id)"
    get(url, success: {
      json in
      let result = LctvScheduledBroadcast(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getVideos(success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlVideos, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getVideo(slug: String, success: (LctvVideo) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(kUrlVideos)\(slug)"
    get(url, success: {
      json in
      let result = LctvVideo(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
}









