//
//  DetectFullImageViewController.swift
//  LikeWise
//
//  Created by cst on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class DetectFullImageViewController: BaseViewController {
    
     //MARK: - IBOutlets
    
    @IBOutlet weak var chatTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }

    @IBAction func backtoChatScreenAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
