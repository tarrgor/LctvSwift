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
  /*
  func get(url: URLRequestConvertible, success: (JSON) -> (), failure: (String, JSON?) -> ()) {
    Alamofire.request(url).responseJSON { response in
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
  */
  
  func get(url: String, success: (JSON) -> (), failure: (String, JSON?) -> ()) {
    let headers = httpHeaders()
    
    Alamofire.request(.GET, url, headers: headers).responseJSON { response in
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