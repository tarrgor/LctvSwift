//
//  LctvApiTests.swift
//  LctvSwift
//
//  Created by Thorsten Klusemann on 28.02.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Locksmith
@testable import LctvSwift

class LctvApiSpec : QuickSpec {
  
  var api: LctvApi?

  class SecureResult : GenericPasswordSecureStorableResultType {
    var data: [String:AnyObject]? = [
      "clientId":"clientId",
      "secret":"secret",
      "grantType":"A"
    ]
  }

  class SecureResultWithTokens : GenericPasswordSecureStorableResultType {
    var data: [String:AnyObject]? = [
      "clientId":"clientId",
      "secret":"secret",
      "grantType":"A",
      "accessToken":"someToken",
      "refreshToken":"anotherToken"
    ]
  }

  class Fake_LctvApi_First : LctvApi {
    override func storeAuthInfoInKeychain(authInfo: LctvAuthInfo) throws {
      
    }
    
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return nil
    }
  }

  class Fake_LctvApi_Second : LctvApi {
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return SecureResult()
    }
  }

  class Fake_LctvApi_Third : LctvApi {
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return SecureResultWithTokens()
    }
  }
  
  override func spec() {
    describe("initialization of the api instance") {
      
      afterEach() {
        self.api = nil
      }
      
      context("first initialization succeeds") {
        beforeEach() {
          let config = LctvConfig(clientId: "clientId", clientSecret: "secret")
          do {
            try self.api = Fake_LctvApi_First(config: config)
          } catch {
            fail("No exception expected.")
          }
        }
        
        it("returns a correct LctvApi instance") {
          expect(self.api).toNot(beNil())
        }
        
        it("LctvApi instance has correct client id") {
          expect(self.api?._authInfo?.clientId).to(equal("clientId"))
        }

        it("LctvApi instance has no access token") {
          expect(self.api?._authInfo?.accessToken).to(beEmpty())
        }
      }
      
      context("first initialization without clientId") {
        it("throws an error when client id is empty") {
          let config = LctvConfig(clientId: "", clientSecret: "secret")
          expect { try self.api = Fake_LctvApi_First(config: config) }.to(throwError(errorType: LctvInitError.self))
        }

        it("throws an error when secret id is empty") {
          let config = LctvConfig(clientId: "clientId", clientSecret: "")
          expect { try self.api = Fake_LctvApi_First(config: config) }.to(throwError(errorType: LctvInitError.self))
        }
      }
      
      context("second intialization gets its AuthInfo from keychain") {
        beforeEach() {
          let config = LctvConfig()
          do {
            try self.api = Fake_LctvApi_Second(config: config)
          } catch {
            fail("No exception expected.")
          }
        }
        
        it("is a valid api instance") {
          expect(self.api).toNot(beNil())
        }
        
        it("api has a valid client id") {
          expect(self.api?._authInfo?.clientId).to(equal("clientId"))
        }

        it("api has a valid secret") {
          expect(self.api?._authInfo?.secret).to(equal("secret"))
        }
      }
      
      context("initialization when tokens already in place") {
        beforeEach() {
          let config = LctvConfig()
          do {
            try self.api = Fake_LctvApi_Third(config: config)
          } catch {
            fail("No exception expected.")
          }
        }
        
        it("returns a valid api instance") {
          expect(self.api).toNot(beNil())
        }
        
        it("access token has a value") {
          expect(self.api?._authInfo?.accessToken).toNot(beEmpty())
        }
        
        it("clientId has no value") {
          expect(self.api?._authInfo?.clientId).to(beEmpty())
        }
      }
    }
  }

}
