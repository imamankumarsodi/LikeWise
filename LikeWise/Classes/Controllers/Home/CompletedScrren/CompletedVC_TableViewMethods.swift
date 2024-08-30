//
//  CompletedVC_TableViewMethods.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
//
//  AllScreenVC_TableViewExtension.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension CompletedVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let match = UserDefaults.standard.value(forKey: "MATCH_BTN") as? Bool{
            if match{
                self.callBackData?(tempArrayCount2.count)
                return tempArrayCount2.count
            }else{
                
                self.callBackData?(tempArrayCount.count)
                return tempArrayCount.count
            }
            
        }else{
            
            self.callBackData?(tempArrayCount.count)
            return tempArrayCount.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        if let matchStatus = UserDefaults.standard.value(forKey: "MATCH_BTN") as? Bool {
            if matchStatus{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllFriendsTableViewCell.className) as? AllFriendsTableViewCell else{
                    fatalError(ConstantTexts.unexpectedIndexPath)
                }
                
                cell.configureCellWith(info: tempArrayCount2[indexPath.row])
                return cell
                
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Current_TableViewCell.className) as? Current_TableViewCell else{
                    fatalError(ConstantTexts.unexpectedIndexPath)
                }
                cell.setupCell(withInfo: tempArrayCount[indexPath.row])
                return cell
            }
        }else{
            return UITableViewCell()
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let matchStatus = UserDefaults.standard.value(forKey: "MATCH_BTN") as? Bool {
            if matchStatus{
                return 110.5
            }else{
                return 140
            }
        }else{
            return 140
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let matchStatus = UserDefaults.standard.value(forKey: "MATCH_BTN") as? Bool {
            if matchStatus{
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: OppenentViewController.className) as! OppenentViewController
                vc.id = tempArrayCount2[indexPath.row].receiver_id
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: OppenentViewController.className) as! OppenentViewController
                vc.id = tempArrayCount[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }else{
            
        }
    }
    
}

