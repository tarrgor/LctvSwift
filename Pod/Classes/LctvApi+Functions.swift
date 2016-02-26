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
  
  public func getCodingCategories(page page: Int? = 0, success: (LctvResultContainer<LctvCodingCategory>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlCodingCategories, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvCodingCategory>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCodingCategoryByName(name: String, success: (LctvCodingCategory) -> (), failure: (String, JSON?) -> ()) {
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
  
  public func getLivestreams(page page: Int? = 0, success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLivestreams, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLivestreamsOnAir(page page: Int? = 0, success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLivestreamsOnAir, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLivestreamByUserSlug(userSlug: String, success: (LctvLivestream) -> (), failure: (String, JSON?) -> ()) {
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

  public func getLanguages(page page: Int? = 0, success: (LctvResultContainer<LctvLanguage>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlLanguages, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLanguage>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLanguageByName(name: String, success: (LctvLanguage) -> (), failure: (String, JSON?) -> ()) {
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
  
  public func getCurrentUser(success success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlCurrentUser, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollowers(success success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlFollowers, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollows(success success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlFollows, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserChatAccount(success success: (LctvXmppAccount) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlChatAccount, success: {
      json in
      let result = LctvXmppAccount(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getViewingKey(success success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlViewingKey, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserVideos, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserLatestVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserLatestVideos, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserChannel(page page: Int? = 0, success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserChannel, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  public func getUserChannelOnAir(page page: Int? = 0, success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlUserChannelOnAir, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserProfileBySlug(slug: String, success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
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

  public func getScheduledBroadcasts(page page: Int? = 0, success: (LctvResultContainer<LctvScheduledBroadcast>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlScheduledBroadcasts, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvScheduledBroadcast>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getScheduledBroadcastById(id: Int, success: (LctvScheduledBroadcast) -> (), failure: (String, JSON?) -> ()) {
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
  
  public func getVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(kUrlVideos, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getVideoBySlug(slug: String, success: (LctvVideo) -> (), failure: (String, JSON?) -> ()) {
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
  
  public func nextPage<T: JSONInitializable>(result: LctvResultContainer<T>, success: (LctvResultContainer<T>) -> (), failure: (String, JSON?) -> ()) {
    if let next = result.next {
      get(next, success: {
        json in
        let result = LctvResultContainer<T>(json: json)
        success(result)
      }, failure: { message, json in
        failure(message, json)
      })
    }
  }

  public func previousPage<T: JSONInitializable>(result: LctvResultContainer<T>, success: (LctvResultContainer<T>) -> (), failure: (String, JSON?) -> ()) {
    if let prev = result.previous {
      get(prev, success: {
        json in
        let result = LctvResultContainer<T>(json: json)
        success(result)
      }, failure: { message, json in
        failure(message, json)
      })
    }
  }
}









