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
extension AllScreenVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.callBackData?(tempArrayCount.count)
        return tempArrayCount.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllFriendsTableViewCell.className) as? AllFriendsTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.configureCellWith(info: tempArrayCount[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: OppenentViewController.className) as! OppenentViewController
        
        vc.id = tempArrayCount[indexPath.row].receiver_id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

