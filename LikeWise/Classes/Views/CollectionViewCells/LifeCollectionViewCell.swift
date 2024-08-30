//
//  LifeCollectionViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 22/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class LifeCollectionViewCell: UICollectionViewCell {
    //MARK: - Live view
    @IBOutlet weak var viewLife: UIView!
    @IBOutlet weak var lblLife: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setupCellAll(){
        self.backgroundColor = AppColor.clearColor
        viewLife.backgroundColor = AppColor.clearColor
        
      
         let paragraphStyle = NSMutableParagraphStyle()
               
               // *** set LineSpacing property in points ***
               paragraphStyle.lineSpacing = 0 // Whatever line spacing you want in points
               
               let  myMutableStringNew = NSMutableAttributedString()
               myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "·", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 40),  AppColor.dotColor))
              
               // *** Apply attribute to string ***
               myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableStringNew.length))
               paragraphStyle.alignment = .right
               
               lblLife.attributedText = myMutableStringNew
        
    }
    
    func setupCellWith(lastLife:Int){
        self.backgroundColor = AppColor.clearColor
        viewLife.backgroundColor = AppColor.clearColor
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 0 // Whatever line spacing you want in points
        
        let  myMutableStringNew = NSMutableAttributedString()
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(lastLife)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "/8", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 8), AppColor.whiteColor))
        
        
        // *** Apply attribute to string ***
        myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableStringNew.length))
        paragraphStyle.alignment = .right
        
        lblLife.attributedText = myMutableStringNew
        
        
    }
    
}
