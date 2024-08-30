//
//  GameStartingViewController.swift
//  LikeWise
//
//  Created by cst on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GameStartingViewController: BaseViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
            initialSetup()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        let vc = AppStoryboard.chat.instantiateViewController(withIdentifier: NoImageViewController.className) as! NoImageViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func instructionBtnAction(_ sender: Any) {
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func fullImageBtnAction(_ sender: Any) {
        let vc = AppStoryboard.chat.instantiateViewController(withIdentifier: DetectFullImageViewController.className) as! DetectFullImageViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
