//
//  LctvAuthViewController.swift
//  Pods
//
//  Created by Thorsten Klusemann on 20.02.16.
//
//

import UIKit
import OAuthSwift

public final class LctvAuthViewController : OAuthWebViewController {
    
  var webView: UIWebView = UIWebView()
  var targetURL: NSURL = NSURL()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    webView.frame = self.view.bounds
    webView.scalesPageToFit = true
    webView.delegate = self
    view.addSubview(webView)
    
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
}

extension LctvAuthViewController : UIWebViewDelegate {
  
  public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if let url = request.URL where (url.host == "localhost"){
      self.dismissWebViewController()
    }
    return true
  }
  
}
