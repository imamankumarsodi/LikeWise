//
//  DetectFullImgaeextensionMethods.swift
//  LikeWise
//
//  Created by cst on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension Custom methods
extension DetectFullImageViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    //TODO: Initial setup method
    internal func initialSetup(){
        chatTf.layer.cornerRadius = 24
        chatTf.clipsToBounds = true
        
         CustomMethods.shared.setupTextFeild(chatTf, UIColor.black, AppFont.light.size(AppFontName.SegoeUI, size: 12.0), AppColor.chatTfColor,"", .default)
    }
}
