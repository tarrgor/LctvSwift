//
//  LctvAuthViewController.swift
//  Pods
//
//
//

import UIKit
import OAuthSwift

public typealias CancelHandler = () -> ()

public final class LctvAuthViewController : OAuthWebViewController {
    
  var webView: UIWebView = UIWebView()
  var targetURL: NSURL = NSURL()
  var toolbar: UIToolbar = UIToolbar()
  var cancelItem: UIBarButtonItem?
  
  public var onCancel: CancelHandler? = nil

  public var toolbarTintColor: UIColor = UIColor.blackColor() {
    didSet {
      toolbar.barTintColor = toolbarTintColor
    }
  }
  
  public var cancelButtonColor: UIColor = UIColor.whiteColor() {
    didSet {
      cancelItem?.tintColor = cancelButtonColor
    }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    // white status bar
    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent

    webView.frame = self.view.bounds
    webView.scalesPageToFit = true
    webView.delegate = self
    webView.backgroundColor = UIColor.blackColor()
    view.addSubview(webView)
  
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
    toolbar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44 + statusBarHeight)
    toolbar.barTintColor = toolbarTintColor
    view.addSubview(toolbar)
    
    cancelItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(LctvAuthViewController.cancelButtonPressed(_:)))
    cancelItem!.tintColor = UIColor.whiteColor()
    toolbar.setItems([cancelItem!], animated: true)

    loadAddressUrl()
  }
  
  public override func handle(url: NSURL) {
    targetURL = url
    super.handle(url)
    loadAddressUrl()
  }
  
  func loadAddressUrl() {
    let req = NSURLRequest(URL: targetURL)
    webView.loadRequest(req)
  }
  
  func cancelButtonPressed(sender: UIBarButtonItem) {
    if let callback = onCancel {
      callback()
    }
    
    self.dismissWebViewController()
  }
}

extension LctvAuthViewController : UIWebViewDelegate {
  
  public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if let url = request.URL where (url.host == "localhost"){
      self.dismissWebViewController()
    }
    return true
  }
  
}
