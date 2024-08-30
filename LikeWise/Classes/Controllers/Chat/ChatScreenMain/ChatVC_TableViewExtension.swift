//
//  ChatVC_TableViewExtension.swift
//  LikeWise
//
//  Created by Aman Kumar on 21/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension ChatVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        if messages[indexPath.row].isMe{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.className) as? MyMessageTableViewCell else{
                       fatalError(ConstantTexts.unexpectedIndexPath)
                   }
            
            cell.configureWith(messages[indexPath.row])
            
             return cell
                   
        }else{
           guard let cell = tableView.dequeueReusableCell(withIdentifier: OpponentMessageCell.className) as? OpponentMessageCell else{
                      fatalError(ConstantTexts.unexpectedIndexPath)
                  }
            cell.configureWith(messages[indexPath.row])
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

