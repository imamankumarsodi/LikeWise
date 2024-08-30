//
//  ChatHistoryVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/05/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift

class ChatHistoryVC:  BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnBackRef: UIButton!
    @IBOutlet weak var btnCoinCountRef: UIButton!
    @IBOutlet weak var viewPointBG: UIView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnCountryDetailRef: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var collectionLife: UICollectionView!
    
    //MARK: - Variables
    internal var userModel = UserModel()
    internal let realm = try! Realm()
    var room_id = String()
    var reciever_id = String()
    internal var ParentMessageDataModeForShowArray = [ParentMessageDataModeForShow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
   
  
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
