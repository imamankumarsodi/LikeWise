//
//  GameOverViewController.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView
import RealmSwift
import SocketIO


class GameOverViewController: BaseViewController {
    
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblPointsTitle: UILabel!
    @IBOutlet weak var lblMatchTitle: UILabel!
    @IBOutlet weak var lblSpendCoinTitle: UILabel!
    @IBOutlet weak var lblCoinLeftTitle: UILabel!
    @IBOutlet weak var btnCoinleft: UIButton!

    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var lblStatusOfGame: UILabel!
    
    @IBOutlet weak var pieChartView: DYPieChartView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var getCoinView: UIView!
    @IBOutlet weak var spendCoinView: UIView!
    @IBOutlet weak var matchOfGameView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblgetMoreCoin: UILabel!
    @IBOutlet weak var lblSpendCoin: UILabel!
    @IBOutlet weak var lblPlayer2: UILabel!
    @IBOutlet weak var lblNamePlayer1: UILabel!
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var lblPointNunber: UILabel!
    @IBOutlet weak var lblProgPer:UILabel!
    
    
    
    internal var settingsModelArray = [SettingsDataModel]()
    var room_id = String()
    var reciever_id = String()
    internal var userModel = UserModel()
    internal let realm = try! Realm()
    internal var user_id = String()
     var item = NotificationDataModel(name: String(), description: String(), __v: String(), _id: String(), gameId: String(), profilePic: String(), createdAt: String(), userId: String(), receiverId: String(), type: String(), status: String(), startDate: Date(),endDate: Date())
    
    
    //MARK: - Variables for socket
    internal let socketManager = SocketManager(socketURL: URL(string: "http://18.224.114.141:8001")!, config: ["log": true])
    internal var socket: SocketIOClient!
    internal var forFirstTimeOnly = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            initialSetUp()
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heightTableView.constant = 200
        
        
        
        do{
            if let user = realm.objects(UserDataModel.self).first{
                user_id = user._id
                self.lblNamePlayer1.text = user.name
                self.imgPlayer1.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                
                CustomMethods.shared.setupButton(btnCoinleft, AppColor.whiteColor, AppColor.clearColor, ConstantFonts.TextFieldFont, "\(Int(round(user.coins)))")
                
                self.lblPlayer2.text = item.name
                self.lblSpendCoin.text = "\(ConstantTexts.SpendLT) 1 \(ConstantTexts.CoinToViewLT) \(item.name)\(ConstantTexts.sChaTLT)"
                
                self.imgPlayer2.sd_setImage(with: URL(string: item.profilePic), placeholderImage: UIImage(named: "profile_pic"))
            }
            
            gameOvertApi()
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        
        
       // setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socketDisconnect()
       
    }
 
    
    @IBAction func closeAction(_ sender: Any) {
           kAppDelegate.openDrawer()
       }
    
    
    @IBAction func showChatHistoryTapped(_ sender: Any) {

        let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
              if user.coins > 0 {
                   spendCoins()
              }else{
                HHelper.showAlert(ConstantTexts.noCoinLeftAlert)
                }
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
     
        
          }
    
    
}


