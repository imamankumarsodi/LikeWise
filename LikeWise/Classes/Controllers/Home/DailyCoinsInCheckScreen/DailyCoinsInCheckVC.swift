//
//  DailyCoinsInCheckVC.swift
//  LikeWise
//
//  Created by CST on 7/6/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class DailyCoinsInCheckVC:  BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var headingCoin: UILabel!
    @IBOutlet weak var viewCoin: UIView!
    
    
    let realm = try! Realm()
    var coinsAmt = String()
    var watchVideo = String()
    var flashing = false
    var homeCallBack : (()->())?
    
    //MARK: Google AdMob
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.facebookBtn.blinkf()
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.facebookBtn.stopBlink()
        }
        
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        
        addCoinsApi(coinsAmt: self.coinsAmt, type: "GET_COIN")
    }
    
    
    @IBAction func emailAction(_ sender: Any) {
        
        
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
    }
    
  
}




