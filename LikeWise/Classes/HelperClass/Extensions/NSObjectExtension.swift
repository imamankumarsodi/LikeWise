//
//  NSObjectExtension.swift
//  AlkingStoreDealler
//
//  Created by Aman on 24/08/19.
//  Copyright © 2019 Hephaestus. All rights reserved.
//

import Foundation


extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
