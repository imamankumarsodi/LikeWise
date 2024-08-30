//
//  ChatHistoryCollectionViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/05/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class ChatHistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tblChat: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate, forRow row: Int,dataItem:ParentMessageDataModeForShow) {
        
        tblChat.delegate = dataSourceDelegate
        tblChat.dataSource = dataSourceDelegate
        tblChat.tag = row
        tblChat.reloadData()
    }
    

}
