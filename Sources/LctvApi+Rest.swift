//
//  LctvApi+Rest.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import Alamofire
import SwiftyJSON

extension LctvApi {  
  func pagingParameters(page: Int? = 0) -> [String:String] {
    return [
      "limit":"\(pageSize)",
      "offset":"\(page ?? 0 * pageSize)"
    ]
  }
  
  func get(url: String, success: (JSON) -> (), failure: (String, JSON?) -> ()) {
    get(url, parameters: [:], success: success, failure: failure)
  }
  
  func get(url: String, page: Int, success: (JSON) -> (), failure: (String, JSON?) -> ()) {
    get(url, parameters: pagingParameters(page), success: success, failure: failure)
  }
  
  func get(url: String, parameters: [String:String], success: (JSON) -> (), failure: (String, JSON?) -> ()) {
    let headers = httpHeaders()
    
    Alamofire.request(.GET, url, parameters: parameters, headers: headers).responseJSON { response in
      if let status = response.response?.statusCode {
        let json = JSON(data: response.data!)
        if status == 200 {
          success(json)
        } else {
          if let message = json["detail"].string {
            failure(message, json)
          } else {
            failure("No valid error message", json)
          }
        }
      } else {
        failure("No valid status code", nil)
      }
    }
  }
}