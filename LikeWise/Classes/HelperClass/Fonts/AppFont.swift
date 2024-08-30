//
//  AppFont.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

enum AppFontName: String {
    
    case SegoeUI        =        "SegoeUI"
}

enum AppFont: String {
    
    
    case semibold          =        "SemiBold"
    case semilight         =        "Semilight"
    case boldItalic        =        "BoldItalic"
    case black             =        "Black"
    case semiboldItalic    =        "SemiboldItalic"
    case italic            =        "Italic"
    case blackItalic       =        "BlackItalic"
    case lightItalic       =        "LightItalic"
    case bold              =        "Bold"
    case light             =        "Light"
    case semiLightItalic   =        "SemilightItalic"
   
    func size(_ name: AppFontName,size: CGFloat) -> UIFont {
        
        if let font = UIFont(name: self.fullFontName(name.rawValue), size: size + 1.0) {
            return font
        }
        fatalError("Font '\(String(describing: fullFontName))' does not exist.")
    }
    
    fileprivate func fullFontName(_ fontName:String) -> String {
        
            return rawValue.isEmpty ? fontName : fontName + "-" + rawValue
       
        
    }
}
