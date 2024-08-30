//
//  OpponentMessageCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 21/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class OpponentMessageCell: BaseTableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setupCell()
    }
    
    internal func setupCell(){
        self.backgroundColor = AppColor.clearColor
        CustomMethods.shared.provideCornerRadiusTo(self.viewBg, 20,[.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner])
        viewBg.alpha = 0.80
        lblMessage.numberOfLines = 0
        lblMessage.textColor = AppColor.whiteColor
    }
    
    
    func configureWith(_ info: MessageDataModel){
        lblMessage.text = info.isEncryped ? info.message : info.message_Encrypted
        lblMessage.font = info.isEncryped ? AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0) : AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        viewBg.backgroundColor = info.isMatched ? AppColor.themeColorDark : AppColor.textfeildColor
       
    }
    
    func configureWithNew(_ info: MessageDataModeForShow){
          lblMessage.text = info.isEncryped ? info.message : info.message_Encrypted
          lblMessage.font = info.isEncryped ? AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0) : AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
          viewBg.backgroundColor = info.isMatched ? AppColor.themeColorDark : AppColor.textfeildColor
         
      }
    
    
    
}
