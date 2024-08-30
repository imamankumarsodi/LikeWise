//
//  SettingsVCTableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


// MARK: - UITableViewDelegate and UITableViewDatasource
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:   SettingsTableViewCell.className) as?   SettingsTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.configureSettingsWith(settingsModelArray[indexPath.row])
        cell.switchBtn.isOn = true
        cell.switchBtn.tag = indexPath.row
        cell.switchBtn.addTarget(self, action: #selector(btnSwitchTappd), for: .touchUpInside)
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightTableView.constant = tblSettings.contentSize.height
    }
    
    /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     headerView.lblName.text = "Jack Shukla"
     return headerView
     }
     
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 160
     
     } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: FAQVC.className) as! FAQVC
            vc.isComingFromPrivacy = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4{
            // Create the alert controller
            let alertController = UIAlertController(title:ConstantTexts.AppName, message: ConstantTexts.wantToLogoutAlert, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: ConstantTexts.okBT, style: UIAlertAction.Style.default) {
                UIAlertAction in
                super.hitLogOutApi(SAuthApi.logout)
            }
            let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: UIAlertAction.Style.cancel) {
                UIAlertAction in

                
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else if indexPath.row == 5{
            
            // Create the alert controller
            let alertController = UIAlertController(title:ConstantTexts.AppName, message: ConstantTexts.DeleteInsLT, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: ConstantTexts.okBT, style: UIAlertAction.Style.default) {
                UIAlertAction in
                super.hitLogOutApi(SAuthApi.deleteUserAcount)
               
            }
            let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: UIAlertAction.Style.cancel) {
                UIAlertAction in
//                self.navigationController?.popViewController(animated: true)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
        }else {
            print("Do nothings...")
        }
    }
}

