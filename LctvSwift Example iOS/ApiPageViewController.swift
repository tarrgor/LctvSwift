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
  
  var codingCategories: LctvResultContainer<LctvCodingCategory>? = nil
  
  @IBAction func getCodingCategories(sender: UIButton) {
    api.getCodingCategories(success: {
      result in
      print(result)
      self.codingCategories = result
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getSwiftCodingCategory(sender: UIButton) {
    api.getCodingCategoryByName("Swift", success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreams(sender: UIButton) {
    api.getLivestreams(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreamsOnAir(sender: UIButton) {
    api.getLivestreamsOnAir(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLivestreamOfKarrmarr(sender: UIButton) {
    api.getLivestreamByUserSlug("karrmarr", success:  {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLanguages(sender: UIButton) {
    api.getLanguages(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getLanguageGerman(sender: UIButton) {
    api.getLanguageByName("German", success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getCurrentUser(sender: UIButton) {
    api.getCurrentUser(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getCurrentUserFollowers(sender: UIButton) {
    api.getCurrentUserFollowers(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getCurrentUserFollows(sender: UIButton) {
    api.getCurrentUserFollows(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserChatAccount(sender: UIButton) {
    api.getUserChatAccount(success: {
      result in
      print(result)
    }, failure: { message, json in
      self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getViewingKey(sender: UIButton) {
    api.getViewingKey(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserVideos(sender: UIButton) {
    api.getUserVideos(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getUserLatestVideos(sender: UIButton) {
    api.getUserLatestVideos(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserChannel(sender: UIButton) {
    api.getUserChannel(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getUserChannelOnAir(sender: UIButton) {
    api.getUserChannelOnAir(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getUserProfile(sender: UIButton) {
    api.getUserProfileBySlug("karrmarr", success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getScheduledBroadcasts(sender: UIButton) {
    api.getScheduledBroadcasts(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getScheduledBroadcast21855(sender: UIButton) {
    api.getScheduledBroadcastById(21855, success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func getVideos(sender: UIButton) {
    api.getVideos(success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }
  
  @IBAction func getVideo100170(sender: UIButton) {
    api.getVideoBySlug("100-170", success: {
      result in
      print(result)
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: message)
    })
  }

  @IBAction func codingCategoriesNextPage(sender: UIButton) {
    if codingCategories != nil {
      api.nextPage(codingCategories!, success: { result in
        print(result)
        self.codingCategories = result
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: "Could not retrieve next page: \(message)")
      })
    }
  }

  @IBAction func codingCategoriesPrevPage(sender: UIButton) {
    if codingCategories != nil {
      api.previousPage(codingCategories!, success: { result in
        print(result)
        self.codingCategories = result
      }, failure: { message, json in
        self.showAlertWithTitle("ERROR", message: "Could not retrieve previous page: \(message)")
      })
    }
  }
}

