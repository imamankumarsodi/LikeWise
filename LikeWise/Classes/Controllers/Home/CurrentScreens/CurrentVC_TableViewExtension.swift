//
//  CurrentVC_TableViewExtension.swift
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
extension CurrentVC:UITableViewDelegate,UITableViewDataSource{
    
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
                
                if tempArrayCount[indexPath.row].lives == 0{
                    
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameOverViewController.className) as! GameOverViewController
                    vc.room_id = tempArrayCount[indexPath.row].sender_id
                    vc.reciever_id = self.tempArrayCount[indexPath.row].receiver_id
                    vc.item  = NotificationDataModel(name: tempArrayCount[indexPath.row].name, description: tempArrayCount[indexPath.row].description, __v: tempArrayCount[indexPath.row]._id, _id: tempArrayCount[indexPath.row]._id, gameId: tempArrayCount[indexPath.row].game_id, profilePic: tempArrayCount[indexPath.row].profilePic, createdAt:tempArrayCount[indexPath.row].createdAt, userId: tempArrayCount[indexPath.row].sender_id, receiverId: tempArrayCount[indexPath.row].receiver_id, type: "\(tempArrayCount[indexPath.row].user_type)", status: "\(tempArrayCount[indexPath.row].lang_status)", startDate: Date(), endDate: Date())
                    let navController = UINavigationController(rootViewController: vc)
                    navController.navigationBar.isHidden = true
                    kAppDelegate.window?.rootViewController = navController
                    kAppDelegate.window?.makeKeyAndVisible()
                    
                    
                    
                }else{
                    
                    let viewController = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
                    // viewController.isComingLives = true
                    viewController.room_id = tempArrayCount[indexPath.row].room_id
                    viewController.item = NotificationDataModel(name: tempArrayCount[indexPath.row].name, description: tempArrayCount[indexPath.row].description, __v: tempArrayCount[indexPath.row]._id, _id: tempArrayCount[indexPath.row]._id, gameId: tempArrayCount[indexPath.row].game_id, profilePic: tempArrayCount[indexPath.row].profilePic, createdAt: tempArrayCount[indexPath.row].createdAt, userId: tempArrayCount[indexPath.row].sender_id, receiverId: tempArrayCount[indexPath.row].receiver_id, type: "\(tempArrayCount[indexPath.row].user_type)", status: "\(tempArrayCount[indexPath.row].lang_status)", startDate: Date(), endDate: Date())
                    viewController.receiver_id = tempArrayCount[indexPath.row].receiver_id
                    viewController.cardIndex = tempArrayCount[indexPath.row].current_card
                    viewController.lifeCount = tempArrayCount[indexPath.row].lives
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.navigationBar.isHidden = true
                    APPLICATION.keyWindow?.rootViewController = navigationController
                    
                }
                
                
                
            }
        }else{
            
        }
        
    }
    
}

