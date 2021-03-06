//
//  ViewController.swift
//  LctvSwift
//
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
      config.keychainId = "lctv-mxi1"
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
    let viewController:LctvAuthViewController = LctvAuthViewController()
    viewController.view.frame = self.view.bounds
    viewController.onCancel = {
      print("User cancelled")
    }
    
    api.oAuthUrlHandler = viewController
    
    do {
      try api.authorize(scope: [.Read, .ReadViewer, .ReadUser, .ReadChannel, .Chat])
    } catch {
      print("Could not authorize: \(error)")
    }
  }
}

