//
//  SideMenuCell.swift
//  LikeWise
//
//  Created by Mobulous on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class SideMenuCell: BaseTableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
