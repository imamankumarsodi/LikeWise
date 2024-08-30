//
//  FedbackViewController.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class FedbackViewController: BaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var visitBtn: UIButton!
    @IBOutlet weak var visitLbl: UILabel!
    @IBOutlet var feedbcakBtn: UIButton!
    @IBOutlet weak var fedbackTextView: UITextView!
    @IBOutlet weak var lblPleaseTell: UILabel!
    @IBOutlet weak var lblUploadShot: UILabel!
    
    //MARK: - Variables for hit web services
       internal var withName = [String]()
       internal var fileName = [String]()
       internal var mimeType = [String]()
       internal var profileImage = [Any]()
       internal var userModel = UserModel()
       internal let myPickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        initiallizers()
       
    }
    
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
       validation()
    }
    
    @IBAction func pickScreenShot(_ sender: Any) {
          openActionSheet()
       }

    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
