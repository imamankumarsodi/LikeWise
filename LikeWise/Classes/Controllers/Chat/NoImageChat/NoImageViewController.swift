//
//  NoImageViewController.swift
//  LikeWise
//
//  Created by cst on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class NoImageViewController: BaseViewController {

     //MARK: - IBOutlets
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var chatTV: UITableView!
    @IBOutlet weak var describeDesLbl: UILabel!
    @IBOutlet weak var describeTypeLbl: UILabel!
    @IBOutlet weak var decsribeLbl: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionNumLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var instrutionView: UIView!
    @IBOutlet weak var describeView: UIView!
    @IBOutlet weak var messageTf: UITextField!
    
    var timer11 = Timer()
       var timerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer11 = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.showPopUp), userInfo: nil, repeats: true)

        initialSetup()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
        
    }
    
    @objc func showPopUp(){
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameOverViewController.className) as! GameOverViewController
       // vc.reciever_id = self.receiver_id
                 self.navigationController?.pushViewController(vc, animated: false)
           timer11.invalidate()
       }

}
