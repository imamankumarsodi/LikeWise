//
//  ChatVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 21/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import FSPagerView
import RealmSwift
import SocketIO
class ChatVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnBackRef: UIButton!
    @IBOutlet weak var btnCoinCountRef: UIButton!
    @IBOutlet weak var viewPointBG: UIView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnCountryDetailRef: UIButton!
    @IBOutlet weak var fsPager_view: FSPagerView!
    @IBOutlet weak var tblChat: UITableView!
    
    @IBOutlet weak var btnInstructionRef: UIButton!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var lblPass: UILabel!
    
    @IBOutlet weak var btnCloseInstructionRef: UIButton!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnShowHideRef: UIButton!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSendMessageRef: UIButton!
    @IBOutlet weak var viewMssg: UIView!
    @IBOutlet weak var tblTop: NSLayoutConstraint!
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewTiming: UIView!
    @IBOutlet weak var lblTimings: UILabel!
    @IBOutlet weak var trailingTimer: NSLayoutConstraint!
    @IBOutlet weak var heightTimer: NSLayoutConstraint!
    @IBOutlet weak var collectionLife: UICollectionView!
    
    @IBOutlet weak var viewTyping: UIView!
    @IBOutlet weak var lblScoreAlert1: UILabel!
    @IBOutlet weak var lblScoreAlert2: UILabel!
    @IBOutlet weak var viewCeleb: UIView!
    @IBOutlet weak var viewCoin: UIView!
    
    
    internal var receiver_by = "false"
    var isComingLives = Bool()
    internal var passCount = Int()
    internal var userModel = UserModel()
    internal var images = [String]()
    //MARK: - Floating view
    internal var panGesture = UIPanGestureRecognizer()
    
    //MARK: - Timer view
    internal var progressCount = 90
    internal var unitSize = CGFloat()
    internal var timer:Timer?
    internal var isShownChat = Bool()
    internal let realm = try! Realm()
    internal var isTimerInitateFirstTime = Bool()
    
    var item = NotificationDataModel(name: String(), description: String(), __v: String(), _id: String(), gameId: String(), profilePic: String(), createdAt: String(), userId: String(), receiverId: String(), type: String(), status: String(), startDate: Date(),endDate: Date())
    //MARK: - Life view
    internal var lifeCount = 8
    var room_id = String()
    var receiver_id = String()
    var messages = [MessageDataModel]()
    internal var isTypingNew = Bool()
    
    //MARK: - Variables for socket
//    internal let socketManager = SocketManager(socketURL: URL(string: "http://18.224.114.141:8001")!, config: ["log": true])
    
    
    internal let socketManager = SocketManager(socketURL: URL(string: "http://3.128.167.18:8001")!, config: ["log": true])
    
    
    internal var socket: SocketIOClient!
    internal var forFirstTimeOnly = true
    internal var cardIndex = Int()
    internal var isTyping = Bool()
    
    
    //MARK: - For calculating points bonus and all
    internal var score = Double()
    internal var point = Double()
    internal var streaks = Double()
    var all_matched = 50.0
    internal var isCoinAdded = Bool()
    
    internal var languageCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(receiver_id)
        print(room_id)
        print(item.gameId)
        print(item.userId)
        print(item.name)
        print(item.profilePic)
        initialSetup()
    }
    
    
    /* override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
     tblTop.constant = viewDescription.frame.size.height + 20
     } */
    
    override func viewDidLayoutSubviews() {
        
        tblTop.constant = viewDescription.isHidden ? 10 : viewDescription.frame.size.height + 20
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socketDisconnect()
        stopTimer()
        stopLife()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func btnDescriptionAction(_ sender: Any) {
        
        if viewDescription.isHidden == true{
            viewDescription.isHidden = false
            self.viewDidLayoutSubviews()
            animateDescriptionView()
        }
        
        
        
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        
        if !self.isComingLives{
            if self.isTimerInitateFirstTime == false{
                self.isTimerInitateFirstTime = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.showProgressbar), userInfo: nil, repeats: true)
            }
            
        }
        
        viewDescription.isHidden = true
        self.viewDidLayoutSubviews()
        
    }
    
    
    @IBAction func btnSendAction(_ sender: UIButton) {
        self.view.endEditing(true)
        DispatchQueue.global(qos: .background).async {
            do
            {
                
                DispatchQueue.main.async {self.stopTypingMethod(false)}
            }
            catch {
                // error
            }
        }
        setupValidations()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        
        
        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.wantLeaveGameAlert, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancelBT, buttonColor:AppColor.errorColor , otherButtonTitle:  ConstantTexts.okBT, otherButtonColor: AppColor.callBgColor) { (isOtherButton) -> Void in
            if isOtherButton == true {
                print("Cancel Button  Pressed", terminator: "")
            }
            else
            {
                kAppDelegate.checkAutoLogin()
                
            }
            
        }
        
        
    }
    
    
    @IBAction func btnEyeAction(_ sender: Any) {
        isShownChat = !isShownChat
        viewHeader.isHidden = isShownChat
        btnInstructionRef.isHidden = isShownChat
        viewDescription.isHidden = isShownChat
        viewPass.isHidden = isShownChat
        tblChat.isHidden = isShownChat
        viewTiming.isHidden = isShownChat
        
        if self.isComingLives{
            collectionLife.isHidden = false
            lblTimings.isHidden = true
        }else{
            collectionLife.isHidden = true
            lblTimings.isHidden = false
        }
        
        let image = isShownChat ? #imageLiteral(resourceName: "hide") : #imageLiteral(resourceName: "describe_s")
        btnShowHideRef.setImage(image, for: .normal)
    }
    
    
    
    @IBAction func btnPassTapped(_ sender: UIButton) {
        
        if passCount < images.count{
            let type = isComingLives ? "2" : "1"
            btnSkipSocketTapped("\(cardIndex)",item.gameId,room_id,item.userId,type,"true","true",receiver_by,returnChatArray(messages))
        }else{
            print("Not allowed")
        }
        
        
    }
    
    
    //For floating view
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(viewDescription)
        let translation = sender.translation(in: self.view)
        
        let statusFrame = UIApplication.shared.statusBarFrame
        
        if let senderView = sender.view {
            
            if senderView.frame.origin.x < 0.0 {
                senderView.frame.origin = CGPoint(x: 0.0, y: senderView.frame.origin.y + 142)
            }
            
            if senderView.frame.origin.y < statusFrame.height + 142 {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: statusFrame.height + 122)
            }
            
            if senderView.frame.origin.x + senderView.frame.size.width > view.frame.width {
                senderView.frame.origin = CGPoint(x: view.frame.width - senderView.frame.size.width, y: senderView.frame.origin.y)
            }
            
            if senderView.frame.origin.y + senderView.frame.size.height > (view.frame.height - 80) {
                senderView.frame.origin = CGPoint(x: senderView.frame.origin.x, y: (view.frame.height - 80) - senderView.frame.size.height)
            }
            
        }
        
        if let centerX = sender.view?.center.x, let centerY = sender.view?.center.y {
            sender.view?.center = CGPoint.init(x: centerX + translation.x , y: centerY + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
        
        //        floatingView.center = CGPoint(x: floatingView.center.x + translation.x, y: floatingView.center.y + translation.y)
        //        sender.setTranslation(CGPoint.zero , in: self.view)
        
    }
    
    @objc func showProgressbar(){
        /* timer?.invalidate()
         timer = nil */
        progressCount -= 1
        if progressCount > 0{
            lblTimings.text = "\(progressCount) sec"
            trailingTimer.constant += unitSize
            if progressCount > 45{
                viewTiming.backgroundColor = AppColor.processColor
            }else if progressCount <= 45 && progressCount > 15{
                viewTiming.backgroundColor = AppColor.emailColor
            }else{
                viewTiming.backgroundColor = AppColor.errorColor
            }
        }else{
            stopTimer()
            let type = isComingLives ? "2" : "1"
            
            
            DispatchQueue.global(qos: .background).async {
                do
                {
                    DispatchQueue.main.async {
                        self.gameBackSocketTapped("\(self.cardIndex)",self.item.gameId,self.room_id,self.item.userId,type,"true","true",self.self.receiver_by,self.returnChatArray(self.messages))
                    }
                }
                catch {
                    // error
                }
            }
            
            
            
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameOverViewController.className) as! GameOverViewController
            vc.room_id = self.room_id
            vc.item = self.item
            vc.reciever_id = self.receiver_id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
