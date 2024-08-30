//
//  NotificationVC_TableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notificationList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        if notificationList[indexPath.row].status == "1"{
            
            
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.className) as? NotificationTableViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
                
            }
            cell.btnDeclineRef.isHidden = false
            cell.btnAcceptRef.isHidden = false
            cell.btnAcceptRef.isUserInteractionEnabled = true
            cell.btnDeclineRef.isUserInteractionEnabled = true
            
            CustomMethods.shared.setupButton(cell.btnAcceptRef, AppColor.whiteColor,AppColor.themeColorDark,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.acceptBT)
            
           
            CustomMethods.shared.setupButton(cell.btnDeclineRef, AppColor.textColor,AppColor.placeholderColor,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.declineBT)
            
            
            cell.btnAcceptRef.tag = indexPath.row
            cell.btnAcceptRef.addTarget(self, action: #selector(btnAcceptTapped), for: .touchUpInside)
            cell.btnDeclineRef.tag = indexPath.row
            cell.btnDeclineRef.addTarget(self, action: #selector(btnRejectTapped), for: .touchUpInside)
            cell.configureCellWith(info: notificationList[indexPath.row])
            return cell
            
        }else if notificationList[indexPath.row].status == "2" || notificationList[indexPath.row].status == "3"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.className) as? NotificationTableViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
                
            }
            
            CustomMethods.shared.setupButton(cell.btnAcceptRef, AppColor.whiteColor,AppColor.themeColorDark,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.req_acceptBT)
             
            
           
            
            
            cell.btnDeclineRef.isHidden = true
            cell.btnAcceptRef.isHidden = false
            
            cell.btnAcceptRef.isUserInteractionEnabled = false
            cell.btnDeclineRef.isUserInteractionEnabled = false
            
            cell.btnAcceptRef.tag = indexPath.row
            cell.btnAcceptRef.addTarget(self, action: #selector(btnAcceptTapped), for: .touchUpInside)
            cell.btnDeclineRef.tag = indexPath.row
            cell.btnDeclineRef.addTarget(self, action: #selector(btnRejectTapped), for: .touchUpInside)
            cell.configureCellWith(info: notificationList[indexPath.row])
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.className) as? NotificationTableViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
                
            }
            
            CustomMethods.shared.setupButton(cell.btnDeclineRef, AppColor.textColor,AppColor.placeholderColor,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.req_declineBT)
                       
            
            cell.btnDeclineRef.isHidden = false
            cell.btnAcceptRef.isHidden = true
            
            cell.btnAcceptRef.isUserInteractionEnabled = false
            cell.btnDeclineRef.isUserInteractionEnabled = false
            
            cell.btnAcceptRef.tag = indexPath.row
            cell.btnAcceptRef.addTarget(self, action: #selector(btnAcceptTapped), for: .touchUpInside)
            cell.btnDeclineRef.tag = indexPath.row
            cell.btnDeclineRef.addTarget(self, action: #selector(btnRejectTapped), for: .touchUpInside)
            cell.configureCellWith(info: notificationList[indexPath.row])
            return cell
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

