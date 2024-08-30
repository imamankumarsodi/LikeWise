//
//  BaseViewControllerCustomMethodExtension.swift
//  HeroAppDesign
//
//  Created by cst on 24/12/19.
//  Copyright © 2019 cst. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import RealmSwift
//TODO: Navigation actions methods
extension BaseViewController:BaseViewControllerDelegate{
    func navigationBarButtonDidTapped(_ buttonType: UINavigationBarButtonType) {
        backButtonTapped()
    }
    
    //TODO: Back action method
    public func backButtonTapped() {
        if self.navigationController!.viewControllers.count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    //TODO: Go particular index back
    //TODO: Go back to index main method
    internal  func goBackToIndex(_ backIndex: Int) {
        self.goBackToIndex(backIndex, animated: true)
    }
    
    //TODO: Go back to index sub method
    internal  func goBackToIndex(_ backIndex: Int, animated animate: Bool) {
        if (self.navigationController!.viewControllers.count - backIndex) > 0 {
            let controller: BaseViewController = (self.navigationController!.viewControllers[(self.navigationController!.viewControllers.count - 1 - backIndex)] as! BaseViewController)
            self.navigationController!.popToViewController(controller, animated: animate)
        }
    }
    
    //TODO: Push navigation to next view controller
    internal  func moveToNextViewC(name: String, withIdentifier: String) {
        let viewC = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    
    //TODO: Move to next via root view controller
    func moveToNextViewCViaRoot(name:String,withIdentifier:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: withIdentifier)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = false
        APPLICATION.keyWindow?.rootViewController = navigationController
    }
    
    
    
}


extension BaseViewController{
    
    //MARK: - UINavigationBar setup methods
    //TODO: Main method for setup UIBarButtonItems and title
    internal func setupNavigationBarTitle(_ title: String, leftBarButtonsType: [UINavigationBarButtonType], rightBarButtonsType: [UINavigationBarButtonType], titleViewFrame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 44)) {
        
        if !title.isEmpty {
            
            self.navigationItem.titleView = createLabel(text: title)
        }
        
        var rightBarButtonItems = [UIBarButtonItem]()
        for rightButtonType in rightBarButtonsType {
            let rightButtonItem = getBarButtonItem(for: rightButtonType, isLeftBarButtonItem: false)
            rightBarButtonItems.append(rightButtonItem)
        }
        if rightBarButtonItems.count > 0 {
            self.navigationItem.rightBarButtonItems = rightBarButtonItems
        }
        var leftBarButtonItems = [UIBarButtonItem]()
        for leftButtonType in leftBarButtonsType {
            let leftButtonItem = getBarButtonItem(for: leftButtonType, isLeftBarButtonItem: true)
            leftBarButtonItems.append(leftButtonItem)
        }
        if leftBarButtonItems.count > 0 {
            self.navigationItem.leftBarButtonItems = leftBarButtonItems
        }
    }
    
    
    
    //MARK: - UINavigationBar setup methods
    //TODO: Main method for setup UIBarButtonItems and title
    internal func setupNavigationBarTitleWithAttributedString(_ title: String,_ subTitle: String, leftBarButtonsType: [UINavigationBarButtonType], rightBarButtonsType: [UINavigationBarButtonType], titleViewFrame: CGRect = CGRect(x: 0, y: 0, width: 220, height: 44)) {
        
        if !title.isEmpty {
            
            self.navigationItem.titleView = createAttributedLabel(text: title, subtitle: subTitle)
        }
        
        var rightBarButtonItems = [UIBarButtonItem]()
        for rightButtonType in rightBarButtonsType {
            let rightButtonItem = getBarButtonItem(for: rightButtonType, isLeftBarButtonItem: false)
            rightBarButtonItems.append(rightButtonItem)
        }
        if rightBarButtonItems.count > 0 {
            self.navigationItem.rightBarButtonItems = rightBarButtonItems
        }
        var leftBarButtonItems = [UIBarButtonItem]()
        for leftButtonType in leftBarButtonsType {
            let leftButtonItem = getBarButtonItem(for: leftButtonType, isLeftBarButtonItem: true)
            leftBarButtonItems.append(leftButtonItem)
        }
        if leftBarButtonItems.count > 0 {
            self.navigationItem.leftBarButtonItems = leftBarButtonItems
        }
    }
    
    //TODO: Method for setup UIBarButtonItems
    
    internal func getBarButtonItem(for type: UINavigationBarButtonType, isLeftBarButtonItem: Bool) -> UIBarButtonItem {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: Int(navButtonWidth), height: NAVIGATION_BAR_DEFAULT_HEIGHT))
        button.setTitleColor(.black, for: UIControl.State())
        button.titleLabel?.font = ConstantFonts.HeaderButtonFont
        button.titleLabel?.textAlignment = .right
        button.tag = type.rawValue
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: isLeftBarButtonItem ? -edgeInset : edgeInset, bottom: 0, right: isLeftBarButtonItem ? edgeInset : -edgeInset)
        if let iconImage = type.iconImage {
            button.setImage(iconImage, for: UIControl.State())
        }/* else if let title = type.title {
         button.setTitle(title, for: UIControlState())
         button.frame.size.width = 40.0
         } */
        button.addTarget(self, action: #selector(BaseViewController.navigationButtonTapped(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    //TODO: Create header label
    internal func createLabel(text: String) -> UILabel {
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 200, height: 44))
        let frame = rect
        let lbl = UILabel.init(frame: frame)
        lbl.text = text
        lbl.numberOfLines = 0
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = ConstantFonts.HeaderFont
        lbl.textColor = UIColor.white
        return lbl
    }
    
    
    internal func createAttributedLabel(text: String,subtitle:String) -> UILabel {
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 230, height: 44))
        let frame = rect
        let lbl = UILabel.init(frame: frame)
        lbl.text = text
        lbl.numberOfLines = 0
        lbl.textAlignment = NSTextAlignment.center
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:text, font:  ConstantFonts.TextFieldFont, AppColor.whiteColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(subtitle)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.whiteColor))
        lbl.numberOfLines = 0
        lbl.attributedText = myMutableString
        return lbl
    }
    
    
    
    //TODO: Add color to navigation bar and status bar
    internal func addColorToNavigationBarAndSafeArea(color:UIColor){
        self.navigationController?.navigationBar.backgroundColor = color
        if #available(iOS 13, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = color
        }
    }
    
    
    //TODO: Transparent navigation
    internal func transparentNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    //TODO: Hide UINavigationBar
    internal func hideNavigationBar(_ hide: Bool) {
        
        
        self.navigationController!.isNavigationBarHidden = hide
    }
    
    //TODO: Hide statusBar
    @available(iOS, deprecated: 9.0)
    internal func hideStatusBar(_ hide: Bool) {
        if #available(iOS 13, *) {
            print("Do nothing")
        } else {
            
            UIApplication.shared.setStatusBarHidden(hide, with: .none)
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.isHidden = hide
        }
        
        
        
    }
    
    func openDrawer(){
        kAppDelegate.drawerController?.setDrawerState(.opened, animated: true)
        
    }
    
    
}



//MARK: - Extension for location manager
extension BaseViewController:CLLocationManagerDelegate{
    
    func configureMap(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 5
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationDenied()
    }
    
    func showUserSettings() {
        guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(urlGeneral)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        print("Location: \(String(describing: location))")
        
        if let lat = location?.coordinate.latitude as? Double{
            latitude = "\(lat)"
        }
        if let long = location?.coordinate.longitude as? Double{
            longitude = "\(long)"
        }
        
        print(location?.coordinate.latitude)
        print(location?.coordinate.longitude)
        
        //TODO:- using callbacks
        callBack!(Double(location?.coordinate.latitude ?? 0.0) ,Double(location?.coordinate.longitude ?? 0.0) ?? 0.0)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    @available(iOS 10.0, *)
    func locationDenied(){
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                print("No access")
                
                //Popup show
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                
                
            case .restricted:
                print("No access")
            case .denied:
                print("No access")
                
                // self.locationManager.requestAlwaysAuthorization()
                let alert = UIAlertController(title: APP_NAME, message: ConstantTexts.locationAlert , preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: ConstantTexts.settingBT, style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.showUserSettings()
                }
                let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                }
                // Add the actions
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
                
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
}


//MARK: - Web services

extension BaseViewController{
    //TODO: Hit logout api
    public func hitLogOutApi(_ serviceName:String){
        var token = String()
        let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json",
            "Authorization":token]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters:nil, serviceName: serviceName, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            if let userInfo = realm.objects(UserDataModel.self).first{
                self.deleteUser(userInfo:userInfo)
            }
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            if let message = nsError.userInfo["errorMessage"] as? String{
                if message == "Unauthorised user"{
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.error, buttonTitle: ConstantTexts.okBT, action: { (okButton) in
                        self.deleteUserAuto {
                            UIApplication.shared.applicationIconBadgeNumber = 0
                            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
                            self.navigationController?.pushViewController(vc, animated: true)
                            let navController = UINavigationController(rootViewController: vc)
                            navController.navigationBar.isHidden = true
                            kAppDelegate.window?.rootViewController = navController
                            kAppDelegate.window?.makeKeyAndVisible()
                        }
                    })
                }else{
                    HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
                }
            }
            
        }
        
    }
    
    
   private func deleteUser(userInfo:UserDataModel){
        let realm = try! Realm()
        do{
            try realm.write {
                realm.delete(userInfo)
                
                UIApplication.shared.applicationIconBadgeNumber = 0
                let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
                self.navigationController?.pushViewController(vc, animated: true)
                let navController = UINavigationController(rootViewController: vc)
                navController.navigationBar.isHidden = true
                kAppDelegate.window?.rootViewController = navController
                kAppDelegate.window?.makeKeyAndVisible()
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
  
    }
    
    
     func deleteUserAuto(callBack:(()->())) {
           let realm = try! Realm()
           
           if let userInfo = realm.objects(UserDataModel.self).first{
               do{
                   try realm.write {
                       realm.delete(userInfo)
                   }
               }catch{
                   print("Error in saving data :- \(error.localizedDescription)")
               }
               callBack()
           }
           
           
       }
    
}



//MARK:- This extension can create header with gradient
/* extension BaseViewController{
 //MARK: - UINavigationBar setup methods
 //TODO: Main method for setup UIBarButtonItems and title
 
 internal func setupNavigationBarTitle(_ title: String, leftBarButtonsType: [UINavigationBarButtonType], rightBarButtonsType: [UINavigationBarButtonType], titleViewFrame: CGRect = CGRect(x: 0, y: 16, width: 500, height: 60),viewColor:CAGradientLayer) {
 
 
 self.navigationItem.titleView = headerView()
 
 if !title.isEmpty {
 
 self.navigationItem.titleView = createLabel(text: title)
 }
 
 var rightBarButtonItems = [UIBarButtonItem]()
 for rightButtonType in rightBarButtonsType {
 let rightButtonItem = getBarButtonItem(for: rightButtonType, isLeftBarButtonItem: false)
 rightBarButtonItems.append(rightButtonItem)
 }
 if rightBarButtonItems.count > 0 {
 self.navigationItem.rightBarButtonItems = rightBarButtonItems
 }
 
 var leftBarButtonItems = [UIBarButtonItem]()
 for leftButtonType in leftBarButtonsType {
 let leftButtonItem = getBarButtonItem(for: leftButtonType, isLeftBarButtonItem: true)
 leftBarButtonItems.append(leftButtonItem)
 }
 if leftBarButtonItems.count > 0 {
 self.navigationItem.leftBarButtonItems = leftBarButtonItems
 }
 }
 
 //TODO: Create header view
 
 internal func headerView() -> UIView{
 
 var mainView = CGRect()
 
 if UIDevice.current.screenType == .iPhones_6_6s_7_8{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 60))
 }else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 65))
 }else if UIDevice.current.screenType == .iPhones_X_XS{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
 }
 else if UIDevice.current.screenType == .iPhone_XR_11{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
 }
 else if UIDevice.current.screenType == .iPhone_XSMax_ProMax{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
 }
 else if UIDevice.current.screenType == .iPhone_11Pro{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
 }
 else if UIDevice.current.screenType == .iPhones_4_4S{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 45))
 }
 else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
 mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 50))
 }
 let frame = mainView
 GradinetView = UIView.init(frame: frame)
 GradinetView.backgroundColor = UIColor.black
 return GradinetView
 }
 
 //TODO: Create header label
 internal func createLabel(text: String) -> UILabel {
 
 let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 200, height: 44))
 let frame = rect
 let lbl = UILabel.init(frame: frame)
 lbl.text = text
 lbl.numberOfLines = 0
 lbl.textAlignment = NSTextAlignment.center
 lbl.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 18.0)
 lbl.textColor = UIColor.white
 return lbl
 }
 
 //TODO: Method for setup UIBarButtonItems
 
 internal func getBarButtonItem(for type: UINavigationBarButtonType, isLeftBarButtonItem: Bool) -> UIBarButtonItem {
 let button = UIButton(frame: CGRect(x: 0, y: 0, width: Int(navButtonWidth), height: NAVIGATION_BAR_DEFAULT_HEIGHT))
 button.setTitleColor(.black, for: UIControl.State())
 button.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
 button.titleLabel?.textAlignment = .right
 button.tag = type.rawValue
 button.imageEdgeInsets = UIEdgeInsets(top: 0, left: isLeftBarButtonItem ? -edgeInset : edgeInset, bottom: 0, right: isLeftBarButtonItem ? edgeInset : -edgeInset)
 if let iconImage = type.iconImage {
 button.setImage(iconImage, for: UIControl.State())
 }/* else if let title = type.title {
 button.setTitle(title, for: UIControlState())
 button.frame.size.width = 40.0
 } */
 button.addTarget(self, action: #selector(BaseViewController.navigationButtonTapped(_:)), for: .touchUpInside)
 return UIBarButtonItem(customView: button)
 }
 
 //TODO: Add color to navigation bar and status bar
 internal func addColorToNavigationBarAndSafeArea(color:CAGradientLayer,className:String,frame: CGRect){
 
 self.navigationController?.navigationBar.layer.insertSublayer(color, at: 0)
 
 //        self.navigationController?.navigationBar.backgroundColor = color
 if #available(iOS 9.0, *) {
 let app = UIApplication.shared
 let statusBarHeight: CGFloat = app.statusBarFrame.size.height
 
 /*   let statusbarView = UIView()
 statusbarView.backgroundColor = color */
 GradinetView.layer.insertSublayer(color, at: 0)
 view.addSubview(GradinetView)
 
 GradinetView.translatesAutoresizingMaskIntoConstraints = false
 GradinetView.heightAnchor
 .constraint(equalToConstant: statusBarHeight).isActive = true
 GradinetView.widthAnchor
 .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
 GradinetView.topAnchor
 .constraint(equalTo: view.topAnchor).isActive = true
 GradinetView.centerXAnchor
 .constraint(equalTo: view.centerXAnchor).isActive = true
 } else {
 guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
 //            statusBar.backgroundColor = color
 statusBar.layer.insertSublayer(color, at: 0)
 }
 
 }
 
 //TODO: Transparent navigation
 internal func transparentNavigation(){
 self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
 self.navigationController?.navigationBar.shadowImage = UIImage()
 self.navigationController?.navigationBar.isTranslucent = true
 }
 
 //TODO: Hide UINavigationBar
 internal func hideNavigationBar(_ hide: Bool) {
 self.navigationController!.isNavigationBarHidden = hide
 }
 
 //TODO: Hide statusBar
 @available(iOS, deprecated: 9.0)
 internal func hideStatusBar(_ hide: Bool) {
 if #available(iOS 13, *) {
 print("Do nothing")
 } else {
 
 UIApplication.shared.setStatusBarHidden(hide, with: .none)
 guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
 statusBar.isHidden = hide
 }
 
 
 
 }
 } */





