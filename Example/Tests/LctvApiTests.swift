//
//  LctvApiTests.swift
//  LctvSwift
//
//  Created by Thorsten Klusemann on 28.02.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
/*
import Quick
import Nimble
import Locksmith
@testable import LctvSwift

class LctvApiSpec : QuickSpec {

  struct Fake_GenericPasswordResult {
    var data: [String:AnyObject]? = [
      "accessToken":"",
      "refreshToken":"",
      "grantType":"A",
      "clientId":"cid",
      "secret":"topsecret"
    ]
  }
  
  class Fake_LctvAuthInfo : LctvAuthInfo {
    
    func readFromSecureStore() -> Fake_GenericPasswordResult? {
      let result = Fake_GenericPasswordResult()
      return result
    }
  }
  
  override func spec() {
    describe("initialization of the api instance") {
      
      context("first initialization succeeds") {
        it("returns a correct LctvApi instance") {
          let config = LctvConfig(clientId: "clientId", clientSecret: "secret")
          var api: LctvApi? = nil
          
          do {
            try api = LctvApi.initializeWithConfig(config)
          } catch {
            fail("No exception expected.")
          }
          
          expect(api?._authInfo?.clientId).to(equal("cid"))
        }
      }
      
    }
  }

}
*/
