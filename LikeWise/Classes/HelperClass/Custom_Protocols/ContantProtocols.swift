//
//  ContantProtocols.swift
//  AlkingStoreDealler
//
//  Created by Aman on 15/08/19.
//  Copyright © 2019 Hephaestus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - BaseViewControllerDelegate
protocol BaseViewControllerDelegate {
    //TODO: navigationBarButtonDidTapped signature
    func navigationBarButtonDidTapped(_ buttonType: UINavigationBarButtonType)
}
