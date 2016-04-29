//
//  UIViewController+Alerts.swift
//  LctvSwift
//
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func showAlertWithTitle(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alertController, animated: true, completion: nil)
  }

}
