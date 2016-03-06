//
//  ViewController.swift
//  LctvSwift
//
//  Created by Thorsten Klusemann on 02/18/2016.
//  Copyright (c) 2016 Thorsten Klusemann. All rights reserved.
//

import UIKit
import LctvSwift

class ViewController: UIViewController {

  var api: LctvApi!

  override func viewDidLoad() {
    super.viewDidLoad()

    initApi()
  }

  func initApi() {
    do {
      var config = LctvConfig()
      config.clientId = clientId
      config.clientSecret = secret
      try api = LctvApi(config: config)
    } catch {
      print("Could not initialize. Aborting.")
      abort()
    }
  }
  
  @IBAction func deleteAuthInfo(sender: UIButton) {
    api.deleteAuthInfo()
    initApi()
    showAlertWithTitle("DELETED!", message: "Auth Info has been deleted.")
  }
  
  @IBAction func refreshToken(sender: UIButton) {
    api.refreshToken({
      self.showAlertWithTitle("SUCCESS!", message: "Auth token has been refreshed.")
    }, failure: { error in
      self.showAlertWithTitle("ERROR!", message: "Auth token has not been refreshed: \(error.localizedDescription)")
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if !api.hasAccessToken() {
      authorizeClient()
    }
    let apiViewController = segue.destinationViewController as! ApiPageViewController
    apiViewController.api = api
  }
  
  func authorizeClient() {
    let viewController = LctvAuthViewController()
    viewController.view.frame = self.view.bounds
    
    api.oAuthUrlHandler = viewController
    
    do {
      try api.authorize(scope: [.Read, .ReadViewer, .ReadUser, .ReadChannel, .Chat])
    } catch {
      print("Could not authorize: \(error)")
    }
  }
}

