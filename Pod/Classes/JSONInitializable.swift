//
//  JSONInitializable.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

/// Object can be initialized from a JSON object. Used internally by LctvSwift.
public protocol JSONInitializable {
  init(json:JSON)
}