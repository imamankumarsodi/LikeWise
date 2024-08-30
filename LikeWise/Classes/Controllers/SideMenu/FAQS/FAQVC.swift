//
//  FAQVC.swift
//  LikeWise
//
//  Created by Mobulous on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class FAQVC: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblVw: UITableView!
    
    
    //MARK:- Variables
    internal var FAQDataModelArray = [FAQDataModel]()
    
    var isComingFromPrivacy = Bool()
    
    
   
   // internal let headerView = Bundle.main.loadNibNamed(SideMenuHeaderView.className, owner: self, options: nil)?.first as! SideMenuHeaderView

    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        initiallizers()
    }
    

    @IBAction func btnActionClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func sectionButtonTapped(_ sender : UIButton) {
           FAQDataModelArray[sender.tag].isSelected = !FAQDataModelArray[sender.tag].isSelected
           self.tblVw.reloadData()
       }
       
    
    
   
    
}



