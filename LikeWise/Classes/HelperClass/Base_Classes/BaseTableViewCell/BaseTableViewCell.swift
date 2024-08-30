//
//  BaseTableViewCell.swift
//  HeroAppDesign
//
//  Created by cst on 24/12/19.
//  Copyright © 2019 cst. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
