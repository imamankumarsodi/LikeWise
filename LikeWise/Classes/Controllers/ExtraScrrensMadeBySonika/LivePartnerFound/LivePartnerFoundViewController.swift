//
//  LivePartnerFoundViewController.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class LivePartnerFoundViewController: BaseViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblHeadingRef: UILabel!
    @IBOutlet weak var lblPlayerInfo: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    
    
    internal var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.showPopUp), userInfo: nil, repeats: true)
        setupNavigation()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func chatMoveAction(_ sender: Any) {
        //        let vc = AppStoryboard.chat.instantiateViewController(withIdentifier: GameStartingViewController.className) as! GameStartingViewController
        //        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func showPopUp(){
        timer?.invalidate()
        timer = nil
        let vc = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
