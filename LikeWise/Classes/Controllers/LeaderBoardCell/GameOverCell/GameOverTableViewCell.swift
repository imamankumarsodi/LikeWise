//
//  GameOverTableViewCell.swift
//  LikeWise
//
//  Created by Atendra on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GameOverTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPresentage: UILabel!
    @IBOutlet weak var lblEntriesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
