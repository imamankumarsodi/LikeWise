//
//  SelectLanguage_TableViewCell.swift
//  LikeWise
//
//  Created by Deepti Sharma on 20/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class SelectLanguage_TableViewCell: BaseTableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnLanguageRef: UIButton!
    @IBOutlet weak var btnSelectRef: UIButton!
    @IBOutlet weak var lngImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
