//
//  GameOverTableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate and UITableViewDatasource
extension GameOverViewController : UITableViewDelegate, UITableViewDataSource{
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
        cell.lblSubTitle.isHidden = false
        cell.switchBtn.isHidden = true
        cell.configureSettingsWith(settingsModelArray[indexPath.row])
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightTableView.constant = 200
    }
    
    /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     headerView.lblName.text = "Jack Shukla"
     return headerView
     }
     
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 160
     
     } */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            
        }
        else if indexPath.row == 4{
            // Create the alert controller
            let alertController = UIAlertController(title:ConstantTexts.AppName, message: ConstantTexts.wantToLogoutAlert, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: ConstantTexts.okBT, style: UIAlertAction.Style.default) {
                UIAlertAction in
                let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
                self.navigationController?.pushViewController(vc, animated: false)
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
        }
        else if indexPath.row == 5{
            
            // Create the alert controller
            let alertController = UIAlertController(title:ConstantTexts.AppName, message: ConstantTexts.DeleteInsLT, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: ConstantTexts.okBT, style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.navigationController?.popViewController(animated: true)
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
    } */
}
