//
//  OppenentViewController.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView

class OppenentViewController:  BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var btnEditRef: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblCoin: UILabel!
    
    
    @IBOutlet weak var lblPropertiesTitle: UILabel!
    @IBOutlet weak var expertiseView: UIView!
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblAccuracy: UILabel!
    @IBOutlet weak var lblFavMode: UILabel!
    @IBOutlet weak var lblGamesTitle: UILabel!
    @IBOutlet weak var gamesView: UIView!
    @IBOutlet weak var lblPlayed: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var lblInCommon: UILabel!
    @IBOutlet weak var lblPersonalInfo: UILabel!
    @IBOutlet weak var personalInformationView: UIView!
    @IBOutlet weak var lblDetailsHeading: UILabel!
    @IBOutlet weak var lblDetailsValues: UILabel!
    @IBOutlet weak var lblAboutMeHeading: UILabel!
    @IBOutlet weak var aboutMeDescLbl: UILabel!
    @IBOutlet weak var aboutMeView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var languageTitleHeading: UILabel!
    @IBOutlet weak var languageCV: UICollectionView!
    @IBOutlet weak var languagesKnownView: UIView!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var nationalityHeading: UILabel!
    @IBOutlet weak var residencyHeading: UILabel!
    @IBOutlet weak var InterestHeading: UILabel!
    @IBOutlet weak var intrerestView: UIView!
    @IBOutlet weak var residenceView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var LblResidency: UILabel!
    @IBOutlet weak var LblInterests: UILabel!
    @IBOutlet weak var lblProgPer: UILabel!
    @IBOutlet weak var pieChart: DYPieChartView!
    var countryList = [getUserDetail]()
    
    var id = String()
    override func viewDidLoad() {
        super.viewDidLoad()
            initialSetup()
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteBTnAction(_ sender: Any) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameCreateViewController.className) as! GameCreateViewController
              self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
