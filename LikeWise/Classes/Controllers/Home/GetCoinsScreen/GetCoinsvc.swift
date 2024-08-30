//
//  GetCoinsvc.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GetCoinsvc: BaseViewController {
    
    @IBOutlet weak var referFriendView: UIView!
    @IBOutlet weak var watchVideoView: UIView!
    @IBOutlet weak var lblBuy: UILabel!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnReferfriends: UIButton!
    @IBOutlet weak var btnWatchCoinsRef: UIButton!
    @IBOutlet weak var lblInstruction: UILabel!
    
    //MARK: - Variable
    internal var getCoinsDataModelArray = [GetCoinsDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiallizers()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
