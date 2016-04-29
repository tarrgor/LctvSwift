//
//  LctvCodingCategoryContainer.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

public class LctvResultContainer<T: JSONInitializable> : JSONInitializable {
  
  public var count: Int? = 0
  public var next: String? = nil
  public var previous: String? = nil
  public var results: Array<T> = []

  public required init(json: JSON) {
    count = json["count"].int
    next = json["next"].string
    previous = json["previous"].string
    
    if let resultArray = json["results"].array {
      resultArray.forEach({ json in
        let object = T(json: json)
        results.append(object)
      })
    }
  }
}