//
//  LctvArrayContainer.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

public class LctvArrayContainer<T: JSONInitializable> : JSONInitializable {
  
  public var array: [T] = []
  
  public required init(json: JSON) {
  
    if let jsonArray = json.array {
      jsonArray.forEach({ json in
        let newObject = T(json: json)
        array.append(newObject)
      })
    }
  }
}