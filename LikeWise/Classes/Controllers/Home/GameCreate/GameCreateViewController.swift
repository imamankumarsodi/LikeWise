//
//  GameCreateViewController.swift
//  LikeWise
//
//  Created by Aman Kumar on 01/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import SocketIO
import RealmSwift
class GameCreateViewController: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblSelectMode: UILabel!
    @IBOutlet weak var lblTimeMode: UILabel!
    @IBOutlet weak var lblLiveMode: UILabel!
    @IBOutlet weak var lblInvitePartner: UILabel!
    @IBOutlet weak var lblSelectLang: UILabel!
    @IBOutlet weak var lblObj: UILabel!
    @IBOutlet weak var lblMorePre: UILabel!
    @IBOutlet weak var lblCustomeIns: UILabel!
    @IBOutlet weak var lblAddImage: UILabel!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var createGmeCV: UICollectionView!
    @IBOutlet weak var selectLangCV: UICollectionView!
    @IBOutlet weak var liveView: UIView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timeImg: UIImageView!
    @IBOutlet weak var liveImg: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var sendInviteBtn: UIButton!
    @IBOutlet weak var instructionTv: UITextView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var addImagesCV: UICollectionView!
    @IBOutlet weak var preciselyCV: UICollectionView!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var objevtiveCV: UICollectionView!
    @IBOutlet weak var lblAddImageNew: UILabel!
    
    //MARK: - IBOutlests for show hide more precisely
    @IBOutlet weak var lblMorePeciselyTop: NSLayoutConstraint!
    
    @IBOutlet weak var lblMorePeciselyBottom: NSLayoutConstraint!
    
    @IBOutlet weak var heightMorePreciselyCol: NSLayoutConstraint!
    
    @IBOutlet weak var bottomheightMorePreciselyCol: NSLayoutConstraint!
    
    
    
    //MARK: - Variables
    internal var CountryDataModelCollecArr_SearchFriends = [CountryDataModelCollec]()
    internal var filtered = [CountryDataModelCollec]()
    internal var selectedFriend = CountryDataModelCollec(__v: String(), _id: String(), coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: String(), notificationStatus: String(), profilePic: String(), status: String(), totalPoints: String(), username: String(), type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: String(), password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String())
    internal var CountryDataModelCollecArr_Language = [LanguageDataModel]()
    internal var CountryDataModelCollecArr_Objective = [Objective]()
    internal var selectedOpertunies = Int()
    internal var searchActive = Bool()
    internal var userModel = UserModel()
    //MARK: - Variables for hit web services
    internal var withName = [String]()
    internal var fileName = [String]()
    internal var mimeType = [String]()
    internal var profileImage = [Any]()
    internal var mode = "1"
    internal var languageCode = String()
    internal var morePresicely = String()
    internal var objectives = String()
    internal var socialId = String()
    internal var photosArray = [selectImage]()
    internal let realm = try! Realm()
    
    internal var profilePic = String()
    internal var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    @IBAction func sendBtnAction(_ sender: Any) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LiveInviteSentViewController.className) as! LiveInviteSentViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func addImageBtnAction(_ sender: Any) {
        let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: ImagePickerViewController.className) as! ImagePickerViewController
        
        vc.callBackImages = { (images) in
            self.withName.removeAll()
                       self.fileName.removeAll()
                       self.mimeType.removeAll()
                       self.profileImage.removeAll()
                       self.photosArray.removeAll()
            
            
            for item in images{
                self.photosArray.append(item)
            }
            print(self.photosArray.count)
            self.addImagesCV.reloadData()
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func timeAction(_ sender: Any) {
        self.timeView.backgroundColor = AppColor.themeColorLight
        self.liveView.backgroundColor = AppColor.whiteColor
        
        liveImg.image = UIImage(named: "life_un")
        timeImg.image = UIImage(named: "timeNew")
        mode = "1"
    }
    
    @IBAction func liveAction(_ sender: Any) {
        self.liveView.backgroundColor = AppColor.themeColorLight
        self.timeView.backgroundColor = AppColor.whiteColor
        liveImg.image = UIImage(named: "life_s")
        timeImg.image = UIImage(named: "timeUN")
        mode = "2"
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
        validation()
    }
    
    @objc func btnDeleteTappd(_ sender: UIButton) {
        
        print(sender.tag)
        
        self.photosArray.remove(at: sender.tag)
        self.addImagesCV.reloadData()
        
    }
    
    
}
