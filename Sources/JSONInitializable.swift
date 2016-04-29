//
//  JSONInitializable.swift
//  Pods
//
//
//

import Foundation
import SwiftyJSON

/// Object can be initialized from a JSON object. Used internally by LctvSwift.
public protocol JSONInitializable {
  init(json:JSON)
}