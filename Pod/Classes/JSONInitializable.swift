//
//  JSONInitializable.swift
//  Pods
//
//  Created by Thorsten Klusemann on 21.02.16.
//
//

import Foundation
import SwiftyJSON

public protocol JSONInitializable {
  init(json:JSON)
}