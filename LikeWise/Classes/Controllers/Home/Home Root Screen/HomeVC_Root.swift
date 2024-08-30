//
//  HomeVC_Root.swift
//  LikeWise
//
//  Created by Deepti Sharma on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift

class HomeVC_Root: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgBackgroud: UIImageView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewButtonStack: UIView!
    @IBOutlet weak var btnCollectedCoinRef: UIButton!
    @IBOutlet weak var btnGoldenCoinRef: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var viewButtonStackNewOutHeader: UIView!
    @IBOutlet weak var btnAllRef: UIButton!
    @IBOutlet weak var btnCurrentRef: UIButton!
    @IBOutlet weak var btnCompletedRef: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnLikeWiseRef: UIButton!
    @IBOutlet weak var lblPlay: UILabel!
    @IBOutlet weak var lblCreate: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblCentre: UILabel!
    @IBOutlet var notificationsButton: UIButton!
    
    //MARK: - Varibles
    internal var isSelectLikeWise = Bool()
    internal var allCount = Int()
    internal var currentCount = Int()
    internal var completedCount = Int()
    
    internal let realm = try! Realm()
    internal var isComing = Bool()
    
    let badgeSize: CGFloat = 20
    let badgeTag = 9830384
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(isComing)
        initialSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
         getUserData()
        if newProfile == true {
            
        }else {
          hitDailyCoinsApiApi()
        }
         
       // getUserData()
//       let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: DailyCoinsInCheckVC.className) as! DailyCoinsInCheckVC
//                   self.navigationController?.present(vc, animated: true, completion: nil)
        
        self.view.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getUserData()
    }
    
    @IBAction func coinsAction(_ sender: Any) {
        
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GetCoinsvc.className) as! GetCoinsvc
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func PointsAction(_ sender: Any) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LeaderBoardVC.className) as! LeaderBoardVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    
    @IBAction func btnChoiceTapped(_ sender: UIButton) {
        
        if sender.tag == 0{
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 0 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            
            CustomMethods.shared.setupButton(btnAllRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.allBT)
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnAllRef, self.btnAllRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCurrentRef, self.btnCurrentRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCompletedRef, self.btnCompletedRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            self.imgBackgroud.image = (self.allCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.allCount > 0) ? true : false
            self.imgArrow.isHidden = (self.allCount > 0) ? true : false
            self.lblCentre.isHidden = (self.allCount > 0) ? true : false
            self.lblCreate.isHidden = (self.allCount > 0) ? true : false
            
            
            
            if isSelectLikeWise{
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.friendsBT)
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.randomBT)
            }else{
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.currentBT)
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.completedBT)
            }
            
            
        }else if sender.tag == 1{
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 1 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            
            CustomMethods.shared.setupButton(btnAllRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.allBT)
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnAllRef, self.btnAllRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCurrentRef, self.btnCurrentRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCompletedRef, self.btnCompletedRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            self.imgBackgroud.image = (self.currentCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.currentCount > 0) ? true : false
            self.imgArrow.isHidden = (self.currentCount > 0) ? true : false
            self.lblCentre.isHidden = (self.currentCount > 0) ? true : false
            self.lblCreate.isHidden = (self.currentCount > 0) ? true : false
            
            
            
            if isSelectLikeWise{
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.friendsBT)
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.randomBT)
            }else{
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.currentBT)
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.completedBT)
            }
            
        }else{
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 2 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            
            
            CustomMethods.shared.setupButton(btnAllRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.allBT)
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnAllRef, self.btnCurrentRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCurrentRef, self.btnCurrentRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            
            
            
            
            CustomMethods.shared.provideCornerRadiusTo(self.btnCompletedRef, self.btnCompletedRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            
            self.imgBackgroud.image = (self.completedCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.completedCount > 0) ? true : false
            self.imgArrow.isHidden = (self.completedCount > 0) ? true : false
            self.lblCentre.isHidden = (self.completedCount > 0) ? true : false
            self.lblCreate.isHidden = (self.completedCount > 0) ? true : false
            
            
            if isSelectLikeWise{
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.friendsBT)
                
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.randomBT)
            }else{
                
                CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.currentBT)
                
                CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.completedBT)
            }
            
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
   
    
    @IBAction func playBtnAction(_ sender: Any) {
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: PlayGameViewController.className) as! PlayGameViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func addGameBtnAction(_ sender: Any) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameCreateViewController.className) as! GameCreateViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func gameRewindAction(_ sender: Any) {
        isSelectLikeWise = !isSelectLikeWise
        UserDefaults.standard.set(isSelectLikeWise, forKey: "MATCH_BTN")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TBL_RELOAD"), object:nil, userInfo: nil)
        changeHeader()
    }
    
    
    @IBAction func menuBtnAction(_ sender: Any) {
        CustomMethods.shared.playSound("woosh.mp3")
        super.openDrawer()
    }
    
    
    
    @available(iOS 13.0, *)
    @IBAction func notiBtnAction(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "BADGE")
        showBadgeCount()
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: NotificationVC.className) as! NotificationVC
        vc.vc = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
