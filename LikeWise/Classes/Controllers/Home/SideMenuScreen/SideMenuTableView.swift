//
//  SideMenuTableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate and UITableViewDatasource
extension SideMenuVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:   SideMenuCell.className) as?   SideMenuCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.imgMenu.image = menuImageArray[indexPath.row]
        cell.lblMenu.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: menuArray[indexPath.row], font: AppFont.light.size(.SegoeUI, size: 13), AppColor.textColor)
        return cell
        
        
    }
    
    /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     headerView.lblName.text = "Jack Shukla"
     return headerView
     }
     
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 160
     
     } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        CustomMethods.shared.playSound("woosh.mp3")
        
        if indexPath.row == 0{
            
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: GuestPopUpViewController.className) as! GuestPopUpViewController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }else{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    
                    
                }
            }else{
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                
                
            }
            
            
            
            
            
        }
        else if indexPath.row == 1{
            
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: GuestPopUpViewController.className) as! GuestPopUpViewController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }else{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LeaderBoardVC.className) as! LeaderBoardVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LeaderBoardVC.className) as! LeaderBoardVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
            
            
        }
        else if indexPath.row == 2{
            
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: GuestPopUpViewController.className) as! GuestPopUpViewController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }else{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GetCoinsvc.className) as! GetCoinsvc
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GetCoinsvc.className) as! GetCoinsvc
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
         
        }
        else if indexPath.row == 3{
            
        }
        else if indexPath.row == 4{
            
            
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: GuestPopUpViewController.className) as! GuestPopUpViewController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }else{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: SettingsViewController.className) as! SettingsViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: SettingsViewController.className) as! SettingsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
            
        else if indexPath.row == 5{
            kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
            
            let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: FAQVC.className) as! FAQVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if indexPath.row == 6{
            kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
            
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: GuestPopUpViewController.className) as! GuestPopUpViewController
                    self.navigationController?.present(vc, animated: true, completion: nil)
                }else{
                    kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                    let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: FedbackViewController.className) as! FedbackViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }else{
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                
                let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: FedbackViewController.className) as! FedbackViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
   
        }
    }
    
}
