//
//  AppelegateExtensionMethods.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//


import Foundation
import UIKit
import KYDrawerController
import UserNotifications
import RealmSwift
import Firebase


extension AppDelegate:UNUserNotificationCenterDelegate {
    
    
    internal func openDrawer(){
        
        drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: MAIN_SCREEN_WIDTH - 40)
        let homeVC = AppStoryboard.home.instantiateViewController(withIdentifier: HomeVC_Root.className) as! HomeVC_Root
        let drawerVC = AppStoryboard.home.instantiateViewController(withIdentifier: SideMenuVC.className) as! SideMenuVC
        let navigationController = UINavigationController(rootViewController: drawerController!)
        self.drawerController?.mainViewController = homeVC
        self.drawerController?.drawerViewController = drawerVC
        self.window?.rootViewController = navigationController
        navigationController.isNavigationBarHidden = true
        
        self.window?.makeKeyAndVisible()
        drawerController?.setDrawerState(.closed, animated: true)
        
    }
    
    /*   internal func closeDrawer(){
     drawerController?.setDrawerState(.closed, animated: true)
     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: MAIN_SCREEN_WIDTH - 40)
     let homeVC = AppStoryboard.tabBar.instantiateViewController(withIdentifier: TabBarViewC.className) as! TabBarViewC
     let drawerVC = AppStoryboard.auth.instantiateViewController(withIdentifier: SideMenuVC.className) as! SideMenuVC
     let navigationController = UINavigationController(rootViewController: self.drawerController!)
     self.drawerController?.mainViewController = homeVC
     self.drawerController?.drawerViewController = drawerVC
     self.window?.rootViewController = navigationController
     navigationController.isNavigationBarHidden = true
     homeVC.selectedIndex = 0
     self.window?.makeKeyAndVisible()
     }
     }*/
    
    
    
    func checkAutoLogin()
    {
        let realm = try! Realm()
        if let userInfo = realm.objects(UserDataModel.self).first{
            
            if userInfo.languageCode == String(){
                
            }else{
                UserDefaults.standard.set(Bool(), forKey: "IS_GUEST")
                kAppDelegate.openDrawer()
            }
            
        }else{
            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: PreRegisterVC.className) as! PreRegisterVC
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = false
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
            
            
        }
    }
    
    
    
    //MARK:- DEVICE TOKEN GET HERE
    //MARK:
    func registerForRemoteNotification() {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil{
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }else{
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        //  UserDefaults.standard.set(deviceTokenString as String, forKey: "deviceToken")
        
        NSLog("Device Token : %@", deviceTokenString)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("in will present")
        if let userInfo = notification.request.content.userInfo as? NSDictionary{
            print(userInfo)

            if CustomMethods.shared.screenName == NotificationVC.className{
                callBack!()
            }


        }
        completionHandler([.alert, .badge, .sound])
    }
   
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("in did recieve")
        if let userInfo = response.notification.request.content.userInfo as? NSDictionary{
            print(userInfo)
            
            let realm = try! Realm()
            if let userInfo = realm.objects(UserDataModel.self).first{
                
                if userInfo.languageCode == String(){
                    
                }else{
                    UserDefaults.standard.set(Bool(), forKey: "IS_GUEST")
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: NotificationVC.className) as! NotificationVC
                    vc.isComing = true
                    let nav = UINavigationController(rootViewController: vc)
                    nav.isNavigationBarHidden = true
                    (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
                }
                
            }else{
                let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: PreRegisterVC.className) as! PreRegisterVC
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = false
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
                
                
            }
            
            
        }
    }
    
    
}


extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        print(fcmToken)
        let dataDict:[String: String] = ["token": fcmToken]
        print(dataDict)
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        
        UserDefaults.standard.set(fcmToken, forKey: "deviceToken")
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
}




