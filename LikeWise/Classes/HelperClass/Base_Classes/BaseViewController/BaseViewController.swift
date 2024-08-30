//
//  BaseViewController.swift
//  HeroAppDesign
//
//  Created by cst on 24/12/19.
//  Copyright © 2019 cst. All rights reserved.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController{

    //MARK: - Variables
    var baseDelegate: BaseViewControllerDelegate?
    internal let navButtonWidth = 40.0
    internal let edgeInset = CGFloat(10.0)
    internal var GradinetView = UIView()
    internal var  statusbarView = UIView()
    
    //MARK: - core location manager variables
    
    var location : CLLocation?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var latitude = String()
    var longitude = String()
    
     //TODO:- core location manager variables
    var callBack: ((_ lat:Double,_ long:Double) -> ())?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - View life cycle methods
    //TODO: View did load impenetation
    override func viewDidLoad() {
        super.viewDidLoad()
       self.baseDelegate = self
       
     
    }
   
    //TODO: View did appear impenetation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    //MARK: - Actions, Selectors, Gestures
    //MARK: - Selectors
    //TODO: Navigation selectors
    
    @objc func navigationButtonTapped(_ sender: AnyObject) {
        guard let buttonType = UINavigationBarButtonType(rawValue: sender.tag) else {
            return }
        
        switch buttonType {
        case .empty: print("Do nothing...")
        case .back: self.baseDelegate?.navigationBarButtonDidTapped(buttonType)
        case .menu: print("Open menu...")
       // case .menu : kAppDelegate.drawerController.setDrawerState(.opened, animated: true)
      //  case .menu: appDel.drawerController.setDrawerState(.opened, animated: true)
        }
    }
}

