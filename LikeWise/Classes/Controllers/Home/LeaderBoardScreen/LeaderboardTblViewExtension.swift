//
//  LeaderboardTblViewExtension.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension LeaderBoardVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoardArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardCell.className) as? LeaderboardCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.setupCell(info:leaderBoardArray[indexPath.row])
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125  
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
       let vc = AppStoryboard.home.instantiateViewController(withIdentifier: OppenentViewController.className) as! OppenentViewController
        vc.id = self.leaderBoardArray[indexPath.row]._id
       self.navigationController?.pushViewController(vc, animated: true)
       
        
    }

}

