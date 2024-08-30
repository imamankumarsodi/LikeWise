//
//  GetCoinsvc.swift
//  LikeWise
//
//  Created by Atendra on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GetCoinsvc: UIViewController {

    @IBOutlet weak var watchVideoView: UIView!
    @IBOutlet weak var referFriendView: UIView!
    @IBOutlet weak var btnWatchCoinsRef: UIButton!
    @IBOutlet weak var btnReferfriends: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblBuy: UILabel!
    @IBOutlet weak var lblInstruction: UILabel!
    
    internal var getCoinsDataModelArray = [GetCoinsDataModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initiallizers()
   
    }

    @IBAction func btnCloseTabed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


