//
//  LctvArrayContainer.swift
//  Pods
//
//  Created by Thorsten Klusemann on 23.02.16.
//
//

import Foundation
import SwiftyJSON

public class LctvArrayContainer<T: JSONInitializable> : JSONInitializable {
  
  var array: [T] = []
  
  public required init(json: JSON) {
  
    if let jsonArray = json.array {
      jsonArray.forEach({ json in
        let newObject = T(json: json)
        array.append(newObject)
      })
    }
  }
}