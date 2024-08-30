//
//  ChatHistoryTableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/05/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension ChatHistoryVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ParentMessageDataModeForShowArray[tableView.tag].MessageDataModeForShowArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        if self.ParentMessageDataModeForShowArray[tableView.tag].MessageDataModeForShowArray[indexPath.row].isMe{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.className) as? MyMessageTableViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            cell.configureWithNew(self.ParentMessageDataModeForShowArray[tableView.tag].MessageDataModeForShowArray[indexPath.row])
            
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OpponentMessageCell.className) as? OpponentMessageCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            cell.configureWithNew(self.ParentMessageDataModeForShowArray[tableView.tag].MessageDataModeForShowArray[indexPath.row])
            return cell
            
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: SelectLanguageViewHeader  = Bundle.main.loadNibNamed(SelectLanguageViewHeader.className, owner: self, options: nil)?.first as! SelectLanguageViewHeader
        header.lblTitle.textColor = AppColor.clearColor
        header.lblTitle.isHidden = true
        header.backgroundColor = AppColor.clearColor
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 94
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

