//
//  WalkThroughVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import FSPagerView

class WalkThroughVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var pager_View: FSPagerView!
    @IBOutlet weak var btnSkipRef: UIButton!
    @IBOutlet weak var page_controller_ref: UIPageControl!
    @IBOutlet weak var btnLetPlayRef: UIButton!
    @IBOutlet weak var lblTopDetails: UILabel!
    @IBOutlet weak var lblBottomDetails: UILabel!
    
    //MARK: - Variables
    internal var imageArray = [#imageLiteral(resourceName: "walkth1"),#imageLiteral(resourceName: "walk_th2New"),UIImage(named: "walkth3-1"),#imageLiteral(resourceName: "walk_th4")]
    internal var btnIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    
    //MARK: - Actons
    
    @IBAction func btnGoToLoginTapped(_ sender: UIButton) {
        if btnIndex == 3{
           super.moveToNextViewCViaRoot(name: "Auth", withIdentifier: PreRegisterVC.className)
        }else{
            let nextIndex = pager_View.currentIndex + 1 < imageArray.count ? pager_View.currentIndex + 1 : 0
            pager_View.scrollToItem(at: nextIndex, animated: true)
        }
        
        
    }
    
    @IBAction func btnSkipTapped(_ sender: UIButton) {
           super.moveToNextViewCViaRoot(name: "Auth", withIdentifier: PreRegisterVC.className)
       
    }
    
}
