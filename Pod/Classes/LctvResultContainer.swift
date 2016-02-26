//
//  LctvCodingCategoryContainer.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public class LctvResultContainer<T: JSONInitializable> : JSONInitializable {
  
  var count: Int? = 0
  var next: String? = nil
  var previous: String? = nil
  var results: Array<T> = []

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