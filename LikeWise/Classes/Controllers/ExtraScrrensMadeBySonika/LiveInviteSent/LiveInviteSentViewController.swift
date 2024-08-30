//
//  LiveInviteSentViewController.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift
import SocketIO
import RealmSwift
class LiveInviteSentViewController: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblHeadingRef: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var imgLanguage: UIImageView!
    
    
    //MARK: - Variables for hit web services
    internal var withName = [String]()
    internal var fileName = [String]()
    internal var mimeType = [String]()
    internal var profileImage = [Any]()
    
    //MARK: - Variables
    var mode = String()
    var CountryDataModelCollecArr_Objective = [Objective]()
    var PlayGameUserModel_Array = [PlayGameUserModel]()
    var RandomImagesModelArray = [RandomImagesModel]()
    let imageArray = NSMutableArray()
    var chunks = [[RandomImagesModel]]()
    var index = Int()
    var languageArray = CountryDataModelCollec(__v: String(), _id: String(), coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: String(), notificationStatus: String(), profilePic: String(), status: String(), totalPoints: String(), username: String(), type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: String(), password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String())
    
    internal var userModel = UserModel()
    internal let realm = try! Realm()
    public var currentPage: Int = 0 {
        didSet {
            
            print("page at centre = \(currentPage)")
        }
    }
    
    
    public var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        // print(pageSize)
        return pageSize
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigation()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        
    }
    
    
}
