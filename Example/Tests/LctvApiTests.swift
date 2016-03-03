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
  var server: MockServer?

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

  class Fake_LctvApi_Empty : LctvApi {
    override func storeAuthInfoInKeychain(authInfo: LctvAuthInfo) throws {
      
    }
    
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return nil
    }
  }

  class Fake_LctvApi_WithSecret : LctvApi {
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return SecureResult()
    }
  }

  class Fake_LctvApi_WithToken : LctvApi {
    override func loadAuthInfoFromKeychain(authInfo: LctvAuthInfo) -> GenericPasswordSecureStorableResultType? {
      return SecureResultWithTokens()
    }
  }
  
  override func spec() {
    beforeSuite() {
      ApiUrl.apiBaseUrl = "http://localhost:9090/mocks/"
      ApiUrl.urlLctvAuthorize = "http://localhost:9090/mocks/authorize"
      ApiUrl.urlLctvToken = "http://localhost:9090/mocks/token"
      
      self.server = MockServer()
      self.server?.startServer()
    }
    
    afterSuite() {
      self.server?.stopServer()
    }
    
    describe("initialization of the api instance") {
      
      afterEach() {
        self.api = nil
      }
      
      context("first initialization succeeds") {
        beforeEach() {
          let config = LctvConfig(clientId: "clientId", clientSecret: "secret")
          do {
            try self.api = Fake_LctvApi_Empty(config: config)
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
          expect { try self.api = Fake_LctvApi_Empty(config: config) }.to(throwError(errorType: LctvInitError.self))
        }

        it("throws an error when secret id is empty") {
          let config = LctvConfig(clientId: "clientId", clientSecret: "")
          expect { try self.api = Fake_LctvApi_Empty(config: config) }.to(throwError(errorType: LctvInitError.self))
        }
      }
      
      context("second intialization gets its AuthInfo from keychain") {
        beforeEach() {
          let config = LctvConfig()
          do {
            try self.api = Fake_LctvApi_WithSecret(config: config)
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
            try self.api = Fake_LctvApi_WithToken(config: config)
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
    
    describe("authorization") {
      
      afterEach() {
        self.api = nil
      }
      
      context("authorization without authInfo") {
        beforeEach() {
          let config = LctvConfig()
          do {
            try self.api = Fake_LctvApi_WithToken(config: config)
            self.api?._authInfo = nil
          } catch {
            fail("No exception expected.")
          }
        }
        
        it("throws an error") {
          expect{ try self.api?.authorize() }.to(throwError(errorType: LctvInitError.self))
        }
      }
      
      context("authorization with normal authInfo in place") {
        beforeEach() {
          let config = LctvConfig()
          do {
            try self.api = Fake_LctvApi_WithSecret(config: config)
          } catch {
            fail("No exception expected.")
          }
          self.api?.oAuthUrlHandler = self.server
          self.api?.mocking = true

          do {
            try self.api?.authorize()
          } catch {
            fail("Unexpected error")
          }
        }
        
        it("has an access token after successful authorization") {
          expect(self.api?._authInfo?.accessToken).toEventuallyNot(beEmpty())
        }
        
        it("has the correct access token") {
          expect(self.api?._authInfo?.accessToken).toEventually(equal("accessToken"))
        }
        
        it("has the correct refresh token") {
          expect(self.api?._authInfo?.refreshToken).toEventually(equal("refreshToken"))
        }
      }
    }
  }

}
