//
//  UITableView+Additions.swift
//  AlkingStoreDealler
//
//  Created by Aman on 24/08/19.
//  Copyright © 2019 Hephaestus. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // Register nib on UITableView...
    func register(nib nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
    
    // Register multiple nib at once
    func registerMultiple(nibs arrayNibs:[String]) {
        for nibName in arrayNibs {
            register(nib: nibName)
        }
    }
    
    func hideEmptyCells() {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = .zero
        self.tableFooterView = view
    }
    
    func scrollToTop(animation: Bool) {
        if self.tableHeaderView != nil {
            self.setContentOffset(.zero, animated: animation)
        } else {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animation)
        }
    }
    
    func scrollToBottom(animation: Bool) {
        
        let section = self.numberOfSections - 1
        let lastRow = self.numberOfRows(inSection: section) - 1
        if section >= 0, lastRow >= 0 {
            let indexPath = IndexPath(row: lastRow, section: section)
            self.scrollToRow(at: indexPath, at: .top, animated: animation)
        }
    }
    
    func register<T:UITableViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T:UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T:UITableViewCell>() -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableCell<T:UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
extension UIViewController {
    //Hide keyboard when tapped arround
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}


extension UICollectionView {
    
    // Register nib on UITableView...
    func register(nib nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    // Register multiple nib at once
    func registerMultiple(nibs arrayNibs:[String]) {
        for nibName in arrayNibs {
            register(nib: nibName)
        }
    }
}

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}


extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    
}

class UITextViewPadding : UITextView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
  }
}
