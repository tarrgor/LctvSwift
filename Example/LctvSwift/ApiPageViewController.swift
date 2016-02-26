//
//  ApiPageViewController.swift
//  LctvSwift
//
//  Created by Thorsten Klusemann on 21.02.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LctvSwift

class ApiPageViewController : UIViewController {
  
  var api: LctvApi!
  
  @IBAction func getCodingCategories(sender: UIButton) {
    api.getCodingCategories({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getSwiftCodingCategory(sender: UIButton) {
    api.getCodingCategory("Swift", success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreams(sender: UIButton) {
    api.getLivestreams({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreamsOnAir(sender: UIButton) {
    api.getLivestreamsOnAir({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreamOfKarrmarr(sender: UIButton) {
    api.getLivestream("karrmarr", success:  {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLanguages(sender: UIButton) {
    api.getLanguages({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLanguageGerman(sender: UIButton) {
    api.getLanguage("German", success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getCurrentUser(sender: UIButton) {
    api.getCurrentUser({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getCurrentUserFollowers(sender: UIButton) {
    api.getCurrentUserFollowers({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getCurrentUserFollows(sender: UIButton) {
    api.getCurrentUserFollows({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserChatAccount(sender: UIButton) {
    api.getUserChatAccount({
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getViewingKey(sender: UIButton) {
    api.getViewingKey({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserVideos(sender: UIButton) {
    api.getUserVideos({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getUserLatestVideos(sender: UIButton) {
    api.getUserLatestVideos({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserChannel(sender: UIButton) {
    api.getUserChannel({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getUserChannelOnAir(sender: UIButton) {
    api.getUserChannelOnAir({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserProfile(sender: UIButton) {
    api.getUserProfile("karrmarr", success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getScheduledBroadcasts(sender: UIButton) {
    api.getScheduledBroadcasts({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getScheduledBroadcast21855(sender: UIButton) {
    api.getScheduledBroadcast(21855, success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getVideos(sender: UIButton) {
    api.getVideos({
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getVideo100170(sender: UIButton) {
    api.getVideo("100-170", success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

}

