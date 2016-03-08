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
  
  /**
   Retrieve a pageable list of coding categories from livecoding.tv. 
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
  */
  public func getCodingCategories(page page: Int? = 0, success: (LctvResultContainer<LctvCodingCategory>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.CodingCategories.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvCodingCategory>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a coding category by its name from livecoding.tv.
   Result is given into the success() handler as a `LctvCodingCategory`.
   
   - parameter name: The name to be searched for.
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getCodingCategoryByName(name: String, success: (LctvCodingCategory) -> (), failure: (String, JSON?) -> ()) {
    let url = ApiUrl.CodingCategories.url + "\(name)"
    get(url, success: {
      json in
      let result = LctvCodingCategory(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of livestreams from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getLivestreams(page page: Int? = 0, success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.Livestreams.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of livestreams which are currently on air from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getLivestreamsOnAir(page page: Int? = 0, success: (LctvResultContainer<LctvLivestream>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.LivestreamsOnAir.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLivestream>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve the livestream of the specified user from livecoding.tv.
   Result is given into the success() handler as a `LctvLivestream`.
   
   - parameter userSlug: The nickname of the user.
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getLivestreamByUserSlug(userSlug: String, success: (LctvLivestream) -> (), failure: (String, JSON?) -> ()) {
    let url = ApiUrl.Livestreams.url + "\(userSlug)"
    get(url, success: {
      json in
      let result = LctvLivestream(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  /**
   Retrieve a pageable list of languages from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getLanguages(page page: Int? = 0, success: (LctvResultContainer<LctvLanguage>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.Languages.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvLanguage>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getLanguageByName(name: String, success: (LctvLanguage) -> (), failure: (String, JSON?) -> ()) {
    let url = ApiUrl.Languages.url + "\(name)"
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
    get(ApiUrl.CurrentUser.url, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollowers(success success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.Followers.url, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getCurrentUserFollows(success success: (LctvArrayContainer<LctvUser>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.Follows.url, success: {
      json in
      let result = LctvArrayContainer<LctvUser>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserChatAccount(success success: (LctvXmppAccount) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.ChatAccount.url, success: {
      json in
      let result = LctvXmppAccount(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getViewingKey(success success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.ViewingKey.url, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of current user's videos from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getUserVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.UserVideos.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of current user's videos from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getUserLatestVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.UserLatestVideos.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of channels from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getUserChannel(page page: Int? = 0, success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.UserChannel.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  /**
   Retrieve a pageable list of channels currently on air from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getUserChannelOnAir(page page: Int? = 0, success: (LctvResultContainer<LctvUserChannel>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.UserChannelOnAir.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvUserChannel>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getUserProfileBySlug(slug: String, success: (LctvUser) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(ApiUrl.UserProfile.url)\(slug)"
    get(url, success: {
      json in
      let result = LctvUser(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }

  /**
   Retrieve a pageable list of scheduled broadcasts from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getScheduledBroadcasts(page page: Int? = 0, success: (LctvResultContainer<LctvScheduledBroadcast>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.ScheduledBroadcasts.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvScheduledBroadcast>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getScheduledBroadcastById(id: Int, success: (LctvScheduledBroadcast) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(ApiUrl.ScheduledBroadcasts.url)\(id)"
    get(url, success: {
      json in
      let result = LctvScheduledBroadcast(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   Retrieve a pageable list of videos from livecoding.tv.
   Result is given into the success() handler as a `LctvResultContainer`.
   
   - parameter page: Optional parameter to specify a concrete page to retrieve (defaults to 0).
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
  public func getVideos(page page: Int? = 0, success: (LctvResultContainer<LctvVideo>) -> (), failure: (String, JSON?) -> ()) {
    get(ApiUrl.Videos.url, page: page ?? 0, success: {
      json in
      let result = LctvResultContainer<LctvVideo>(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  public func getVideoBySlug(slug: String, success: (LctvVideo) -> (), failure: (String, JSON?) -> ()) {
    let url = "\(ApiUrl.Videos.url)\(slug)"
    get(url, success: {
      json in
      let result = LctvVideo(json: json)
      success(result)
    },
    failure: { message, json in
      failure(message, json)
    })
  }
  
  /**
   With a given `LctvResultContainer` this method will retrieve the next page if it exists.
   The success handler will receive a new `LctvResultContainer` with the next elements. You
   can configure the page size by using the `pageSize` property of the `LctvApi` instance.
   
   - parameter result: The current `LctvResultContainer`.
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
  */
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

  /**
   With a given `LctvResultContainer` this method will retrieve the previous page if it exists.
   The success handler will receive a new `LctvResultContainer` with the previous elements. You
   can configure the page size by using the `pageSize` property of the `LctvApi` instance.
   
   - parameter result: The current `LctvResultContainer`.
   - parameter success: A handler function which is executed in case of success.
   - parameter failure: A handler function for handling errors.
   */
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









