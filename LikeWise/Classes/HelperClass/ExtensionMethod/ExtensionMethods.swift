//
//  ExtensionMethods.swift
//  HeroAppDesign
//
//  Created by cst on 25/12/19.
//  Copyright © 2019 cst. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import RealmSwift
import DatePickerDialog
import DropDown
import AVFoundation

//MARK: - Custom methods class
class CustomMethods{
    
    //TODO: Singleton object
    static let shared = CustomMethods()
    private init() {}
    
    var player: AVAudioPlayer?
    
    let animationView = AnimationView(name: "50-material-loader")
    var screenName = String()
    //TODO: Provide corner radius
    public func provideCornerRadiusTo(_ view:UIView, _ radius:CGFloat, _ corners:CACornerMask){
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.layer.maskedCorners = corners
    }
    
    //TODO: Setup label
    public func setupLabel(_ label:UILabel, _ textColor:UIColor, _ font:UIFont,_ text:String,_ backgroundColor:UIColor){
        label.textColor = textColor
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
    }
    
    //TODO: Setup textfeild
    public func setupTextFeild(_ textFeild:UITextField, _ textColor:UIColor, _ font:UIFont,_ backgroundColor:UIColor,_ placeholderText:String,_ type:UIKeyboardType){
        textFeild.textColor = textColor
        textFeild.font = font
        textFeild.backgroundColor = backgroundColor
        textFeild.placeholder = placeholderText
        textFeild.keyboardType = type
    }
    
    public func provideImageAndSepratorTo(_ textField:UITextField, _ image:UIImage,_ sepratorColor:UIColor, _ colorBorder:UIColor,_ imageViewBackgroundColor: UIColor ){
        
        textField.withImage(direction: .Left, image: image, colorSeparator: sepratorColor, colorBorder: colorBorder)
    }
    
    //TODO: Setup button
    public func setupButton(_ button:UIButton, _ textColor:UIColor, _ bgColor: UIColor, _ font:UIFont,_ text:String){
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = bgColor
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        
    }
    
    //TODO: Provide AttributedText
    public func provideSimpleAttributedText( text:String, font: UIFont, _ color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text) ", attributes:[.font: font, .foregroundColor :color])
    }
    
    //TODO: Provide underline AttributedText
    public func provideunderlineAttributedText( text:String, font: UIFont, _ color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text) ", attributes:[.font: font, .foregroundColor :color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    
    public func provideShadowAndCornerRadius(_ blueView:UIView, _ cornerRadius:CGFloat, _ shadowColor: UIColor, _ shadowWidth: CGFloat, _ shadowHeight: CGFloat,_ shadowOpacity: Float, _ shadowRadius: CGFloat, _ borderWidth:CGFloat, _ borderColor: UIColor){
        // corner radius
        blueView.layer.cornerRadius = cornerRadius
        
        // border
        blueView.layer.borderWidth = borderWidth
        blueView.layer.borderColor = borderColor.cgColor
        
        // shadow
        blueView.layer.shadowColor = shadowColor.cgColor
        blueView.layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        blueView.layer.shadowOpacity = shadowOpacity
        blueView.layer.shadowRadius = shadowRadius
    }
    
    public func setCornerRadious(_ item: UIButton) {
        item.layer.cornerRadius = item.frame.height/2
        item.clipsToBounds = true
    }
    
    public func provideCornerBorderTo(_ item: UIView, _ border: CGFloat,_ borderColor: UIColor) {
        item.layer.borderColor = borderColor.cgColor
        item.layer.borderWidth = border
        item.clipsToBounds = true
    }
    
    
    public func showSelectUnselectTextFields(_ isEditing:Bool,_ viewArray:[UIView]){
        for index in 0..<viewArray.count{
            if isEditing && index == 0{
                CustomMethods.shared.provideShadowAndCornerRadius(viewArray[index], viewArray[index].frame.size.height/2, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
            }else{
                CustomMethods.shared.provideShadowAndCornerRadius(viewArray[index], viewArray[index].frame.size.height/2, AppColor.clearColor, 0, 0, 0, 10, 1, AppColor.placeholderColor)
            }
        }
    }
    
    public func provideTopHeight()->CGFloat{
        let screenHeight = MAIN_SCREEN_HEIGHT
        let kBarHeight:CGFloat = (screenHeight >= 812) ? 84 : 64
        return kBarHeight
    }
    
    
    func provideAttributedTextToControlLeftAllignCenter( title:String,  subtitle:String, titleFont:UIFont, subtitleFont:UIFont, titleColor:UIColor, subtitleColor:UIColor,_ delem:String) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delem)", attributes:[ .foregroundColor :titleColor,.font:titleFont])
        
        let myMutableString2 = NSAttributedString(string: "\(subtitle)", attributes:[.foregroundColor :subtitleColor,.font:subtitleFont])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // ** set LineSpacing property in points **
        paragraphStyle.lineSpacing = 0 // Whatever line spacing you want in points
        paragraphStyle.alignment = .center
        
        // ** Apply attribute to string **
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    func showAnimation(view: UIView,animationName:String) {
        let animationViewLottie = AnimationView(name: animationName)
        view.alpha = 1.0
        animationViewLottie.isHidden = false
        animationViewLottie.frame = CGRect(x: 0, y: 0, width: 80, height:80)
        animationViewLottie.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = .loop
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    
    func showLoader(view: UIView,nav:UINavigationBar) {
        nav.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        animationView.isHidden = false
        animationView.frame = CGRect(x: view.frame.size.width/2 - 50, y: view.frame.size.height/2 - 50, width: 100, height: 100)
        animationView.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        animationView.animationSpeed = 1.50
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    func hideLoader(view: UIView,nav:UINavigationBar) {
        
        nav.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        self.animationView.isHidden = true
        self.animationView.stop()
        
        
    }
    
    func showLoaderPresent(view: UIView) {
        view.isUserInteractionEnabled = false
        animationView.isHidden = false
        animationView.frame = CGRect(x: view.frame.size.width/2 - 50, y: view.frame.size.height/2 - 50, width: 100, height: 100)
        animationView.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        animationView.animationSpeed = 1.50
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    func hideLoaderPresent(view: UIView) {
        self.animationView.isHidden = true
        view.isUserInteractionEnabled = true
        self.animationView.stop()
        
        
    }
    
    
    func showAnimationWithName(view: UIView,animationName:String) {
        let animationViewLottie = AnimationView(name: animationName)
        view.alpha = 1.0
        animationViewLottie.isHidden = false
        animationViewLottie.contentMode = .scaleToFill
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = .loop
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    func showLoaderPresentCeleb(view: UIView,animationName:String) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        animationViewLottie.frame = CGRect(x: view.frame.size.width/2 - 60, y: view.frame.size.height/2 - 60, width: 120, height: 120)
        animationViewLottie.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        animationViewLottie.animationSpeed = 0.75
        animationViewLottie.loopMode = .loop
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
   
    func showLoaderPresentCoins(view: UIView,animationName:String) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        animationViewLottie.frame = CGRect(x: view.frame.size.width/2 - 20, y: view.frame.size.height/2 - 20, width: 40, height: 40)
        animationViewLottie.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        animationViewLottie.animationSpeed = 0.75
        animationViewLottie.loopMode = .loop
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    
    
    
    func saveUserData(item:UserDataModel,callBack:(()->())){
        let realm = try! Realm()
        do{
            try realm.write {
                
                if let user = realm.objects(UserDataModel.self).first{
                    user.__v = item.__v
                    user.name  = item.name
                    user.languageCode  = item.languageCode
                    user.username  = item.username
                    user.totalPoints  = item.totalPoints
                    user.status  = item.status
                    user.profilePic  = item.profilePic
                    
                    user.notificationStatus  = item.notificationStatus
                    user.jwtToken  = item.jwtToken
                    user.dob  = item.dob
                    user.coinStatus  = item.coinStatus
                    user.coins  = item.coins
                    user._id = item._id
                    user.email = item.email
                    user.type = item.type
                    user.country = item.country
                    user.defaultLangCode = item.defaultLangCode
                    user.interest1 = item.interest1
                    user.interest2 = item.interest2
                    user.interest3 = item.interest3
                    user.nationalit = item.nationalit
                    user.state = item.state
                    user.coins = item.coins
                    user.aboutus = item.aboutus
                    user.city = item.city
                    user.interest = item.interest
                    user.gender = item.gender
                    user.password = item.password
                    user.descriptionUser = item.descriptionUser
                    
                    
                    
                    
                    
                }else{
                    realm.add(item)
                }
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        callBack()
    }
    
    class func openDownOnFooter(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->())){
        dropDown.anchorView = anchor
        dropDown.width = anchor.frame.size.width
        dropDown.dataSource = array
        /* dropDown.backgroundColor = AppColor.bgColor
         dropDown.textColor = AppColor.whiteColor */
        dropDown.bottomOffset = CGPoint(x: 0, y:anchor.bounds.height)
        dropDown.direction = .bottom
        dropDown.show()
        
        callBack(dropDown)
    }
    
    class func datePickerTapped(datePicker:DatePickerDialog , callback: @escaping( Date? ) -> Void){
        let currentDate = Date()
        /*  var dateComponents = DateComponents()
         dateComponents.month = -3
         let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate) */
        // ,minimumDate: threeMonthAgo
        
        datePicker.show(ConstantTexts.SelectDOB, doneButtonTitle:  ConstantTexts.DoneBT, cancelButtonTitle: ConstantTexts.CancelBT, maximumDate: currentDate, datePickerMode: .date, callback: callback)
        
    }
    
    
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
    func playSound(_ fileName:String){
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
}




//MARK: - UITextField Extension
extension UITextField {
    //TODO: Left Padding
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    //TODO: Right Padding
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    //TODO: assigning image and seperator to text feild...
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        view.backgroundColor = AppColor.clearColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 34.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 50, y: 10, width: 1, height: 24)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 10, width: 1, height: 24)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    
    
    
    
}


//MARK:- card view extension
@IBDesignable
class cardView: UIView {
    
    //@IBInspectable var cornerRadius: CGFloat = 8.0
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var SHAD: UIColor? = UIColor.black
    @IBInspectable var SHADO: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = 5.0
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        
        layer.masksToBounds = false
        layer.shadowColor = SHAD?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = SHADO
        layer.shadowPath = shadowPath.cgPath
    }
}




let SCALE_FACTOR = HHelper.getScaleFactor()

class HHelper {
    
    class func getScaleFactor() -> CGFloat{
        
        let screenRect:CGRect = UIScreen.main.bounds
        let screenWidth:CGFloat = screenRect.size.width
        let scalefactor:CGFloat = screenWidth / 375.0
        return scalefactor
    }
    
    // MARK: - Get root view controller
    
    class func rootViewController() -> UIViewController
    {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    
    // MARK: - Get topmost view controller
    
    class func topMostViewController(rootViewController: UIViewController) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController
        {
            return topMostViewController(rootViewController: navigationController.visibleViewController!)
        }
        
        if let tabBarController = rootViewController as? UITabBarController
        {
            if let selectedTabBarController = tabBarController.selectedViewController
            {
                return topMostViewController(rootViewController: selectedTabBarController)
            }
        }
        
        if let presentedViewController = rootViewController.presentedViewController
        {
            return topMostViewController(rootViewController: presentedViewController)
        }
        return rootViewController
    }
    
    // MARK: Alert methods
    
    class func showAlert(_ message: String, okButtonTitle: String? = nil, target: UIViewController? = nil) {
        
        let topViewController: UIViewController? = HHelper.topMostViewController(rootViewController: HHelper.rootViewController())
        
        if let _ = topViewController {
            let alert = UIAlertController(title:APP_NAME, message: message, preferredStyle: UIAlertController.Style.alert);
            let okBtnTitle = ConstantTexts.okBT
            let okAction = UIAlertAction(title:okBtnTitle, style: UIAlertAction.Style.default, handler: nil);
            
            alert.addAction(okAction);
            if UIApplication.shared.applicationState != .background{
                topViewController?.present(alert, animated:true, completion:nil);
            }
        }
    }
    
    class func showAlertWithAction(title: String?, message: String?,cancelTitle:String, style: UIAlertController.Style, actionTitles:[String?], action:((UIAlertAction) -> Void)?) {
        
        showAlertWithActionWithCancel(title: title, message: message, style: style, actionTitles: actionTitles, showCancel: false, deleteTitle: nil, cancelTitle: cancelTitle, action: action)
    }
    
    class func showAlertWithActionWithCancel(title: String?, message: String?, style: UIAlertController.Style, actionTitles:[String?], showCancel:Bool, deleteTitle: String?, cancelTitle: String? , _ viewC: UIViewController? = nil, action:((UIAlertAction) -> Void)?) {
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        if deleteTitle != nil {
            let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive, handler: action)
            alertController.addAction(deleteAction)
        }
        for (_, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: action)
            alertController.addAction(action)
        }
        
        if showCancel {
            if cancelTitle != "" {
                let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
            } else {
                let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
            }
        }
        if let viewController = viewC {
            
            viewController.present(alertController, animated: true, completion: nil)
            
        } else {
            let topViewController: UIViewController? = HHelper.topMostViewController(rootViewController: HHelper.rootViewController())
            topViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func showAlertWith(_ title:String? = nil, message: String, okButtonTitle: String? = nil, target: UIViewController? = nil) {
        
        var strTitle: String = ""
        
        if title != nil {
            strTitle = title!
        }else{
            strTitle = APP_NAME
        }
        let topViewController: UIViewController? = HHelper.topMostViewController(rootViewController: HHelper.rootViewController())
        
        if let _ = topViewController {
            let alert = UIAlertController(title:strTitle, message: message, preferredStyle: UIAlertController.Style.alert);
            let okBtnTitle = ConstantTexts.okBT
            let okAction = UIAlertAction(title:okBtnTitle, style: .default, handler: nil);
            
            alert.addAction(okAction);
            if UIApplication.shared.applicationState != .background{
                topViewController?.present(alert, animated:true, completion:nil);
            }
        }
    }
    
    class func showAlert(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, actions: UIAlertAction...) {
        
        let topViewController: UIViewController? = HHelper.topMostViewController(rootViewController: HHelper.rootViewController())
        
        var strTitle: String = ""
        
        if title != nil {
            strTitle = title!
        }else{
            strTitle = APP_NAME
        }
        
        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: style)
        
        if !actions.isEmpty {
            
            for action in actions {
                alertController.addAction(action)
            }
            
        }else{
            
            let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: .default, handler: nil)
            alertController.addAction(cancelAction)
        }
        
        topViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Validate phone number
    
    /*    class func isValidPhoneNumber(_ phone:String) -> Bool{
     
     let phoneUtil = NBPhoneNumberUtil()
     
     do {
     let phoneNumber: NBPhoneNumber = try phoneUtil.parse(phone, defaultRegion: "")
     
     if phoneUtil.isValidNumber(phoneNumber){
     return true
     }else{
     return false
     }
     }catch let error as NSError {
     FGAppConfig._log.debugerror.localizedDescription)
     return false
     }
     } */
    
    // MARK: Alert methods
    
    class func showAlertWithBlock(_ message: String, block : @escaping ((UIAlertAction) -> Void)) {
        
        let topViewController: UIViewController? = HHelper.topMostViewController(rootViewController: HHelper.rootViewController())
        
        if let _ = topViewController {
            let alertC = UIAlertController.init(title: APP_NAME, message: message, preferredStyle:.alert)
            let alertAction = UIAlertAction.init(title: ConstantTexts.okBT, style: .default , handler : block)
            
            alertC.addAction(alertAction)
            if UIApplication.shared.applicationState != .background {
                topViewController?.present(alertC, animated:true, completion:nil);
            }
        }
    }
    
    /*    class  func showProgressIndicator(message progressText:String?) {
     if let text = progressText {
     HAppConfig.progressIndicator.text = text
     }
     
     kAppDelegate.window?.isUserInteractionEnabled = false
     kAppDelegate.window?.addSubview(FGAppConfig.progressIndicator)
     }
     
     
     class func hideProgressIndicator(){
     
     kAppDelegate.window?.isUserInteractionEnabled = true
     //        HAppConfig.progressIndicator.removeFromSuperview()
     }  */
    
    // MARK: Validate email
    
    class func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // MARK: Validate password
    
    class func isValidPasssword(_ password: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    class func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    // MARK: Validate username
    
    class func isValidUsername(_ username: String) -> Bool {
        
        let regularExpressionText = "^[ء-يa-zA-Z0-9_.-]+"
        let regularExpression = NSPredicate(format:"SELF MATCHES %@", regularExpressionText)
        return regularExpression.evaluate(with: username)
    }
    
    class func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(view.bounds.origin, from: view)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
    
    class func getIndexPathFor(view: UIView, collectionView: UICollectionView) -> IndexPath? {
        let point = collectionView.convert(view.bounds.origin, from: view)
        let indexPath = collectionView.indexPathForItem(at: point)
        return indexPath
    }
    
    class func getGradient() -> CAGradientLayer{
        let gradient = CAGradientLayer()
        let bottomYPoint = 64
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: bottomYPoint)
        gradient.frame = defaultNavigationBarFrame
        
        let color = UIColor(red: 247.0/255.0, green: 154.0/255.0, blue: 172.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 63.0/255.0, green: 185.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        gradient.colors = [color.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        return gradient
    }
    
    // MARK: - Method For Status Bar Gradient Color
    
    class func statusBarGradientView() -> UIView {
        
        let view = UIView(frame: CGRect(x:0, y:0, width:(UIScreen.main.bounds.size.width), height:20))
        view.layer.addSublayer(HHelper.getGradientForStatusBar())
        return view
    }
    
    class func getGradientForStatusBar() -> CAGradientLayer{
        let gradient = CAGradientLayer()
        let bottomYPoint = 20
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: bottomYPoint)
        gradient.frame = defaultNavigationBarFrame
        
        let color = UIColor(red: 247.0/255.0, green: 154.0/255.0, blue: 172.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 63.0/255.0, green: 185.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        gradient.colors = [color.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        return gradient
    }
    
    class func getFonts() {
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
    
    /*  class func getThumbnailFrom(path: URL) -> UIImage? {
     
     do {
     let asset = AVURLAsset(url: path , options: nil)
     let imgGenerator = AVAssetImageGenerator(asset: asset)
     imgGenerator.appliesPreferredTrackTransform = true
     let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 0), actualTime: nil)
     let thumbnail = UIImage(cgImage: cgImage)
     return thumbnail
     
     } catch let error {
     
     print("*** Error generating thumbnail: \(error.localizedDescription)")
     return nil
     }
     }
     
     class func playVideo(_ urlStr : String, viewController : UIViewController)
     {
     if let videoURL = URL(string: urlStr)
     {
     let player = AVPlayer(url: videoURL)
     let playerViewController = AVPlayerViewController()
     playerViewController.player = player
     viewController.present(playerViewController, animated: true) {
     playerViewController.player!.play()
     }
     }
     } */
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension Date{
    func getTimeComponentString(olderDate older: Date,newerDate newer: Date) -> (String?)  {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.minute , .hour , .day,.month, .weekOfMonth,.year], from: older, to: newer)
        
        let year = componentsLeftTime.year ?? 0
        if  year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }
        
        
        let month = componentsLeftTime.month ?? 0
        if  month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }
        
        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if  weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }
        
        let day = componentsLeftTime.day ?? 0
        if  day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }
        
        let hour = componentsLeftTime.hour ?? 0
        if  hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if  minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }
        
        return nil
    }
    
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) \(ConstantTexts.yearAgoLT)"
        } else if (components.year! >= 1){
            if (numericDates){
                return "\(ConstantTexts.yearAgo1LT)"
            } else {
                return "\(ConstantTexts.last_yearLT)"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) \(ConstantTexts.monthsAgoLT)"
        } else if (components.month! >= 1){
            if (numericDates){
                return "\(ConstantTexts.monthAgo1LT)"
            } else {
                return "\(ConstantTexts.last_monthLT)"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) \(ConstantTexts.weeksAgoLT)"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "\(ConstantTexts.weekAgo1LT)"
            } else {
                return "\(ConstantTexts.last_weekLT)"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) \(ConstantTexts.daysAgoLT)"
        } else if (components.day! >= 1){
            if (numericDates){
                return "\(ConstantTexts.dayAgo1LT)"
            } else {
                return "\(ConstantTexts.last_dayLT)"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) \(ConstantTexts.hoursAgoLT)"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "\(ConstantTexts.hourAgo1LT)"
            } else {
                return "\(ConstantTexts.last_hourLT)"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) \(ConstantTexts.minutesAgoLT)"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "\(ConstantTexts.minutes1LT)"
            } else {
                return "\(ConstantTexts.last_minuteLT)"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) \(ConstantTexts.secondsAgoLT)"
        } else {
            return "\(ConstantTexts.last_secondLT)"
        }
        
    }
    
    
    
   
    
    
    
    
    
}


extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    func rounded(with color: UIColor, width: CGFloat) -> UIImage? {

        guard let cgImage = cgImage?.cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : .zero, y: isPortrait ? ((size.height-size.width)/2).rounded(.down) : .zero), size: breadthSize)) else { return nil }

        let bleed = breadthRect.insetBy(dx: -width, dy: -width)
        let format = imageRendererFormat
        format.opaque = false

        return UIGraphicsImageRenderer(size: bleed.size, format: format).image { context in
            UIBezierPath(ovalIn: .init(origin: .zero, size: bleed.size)).addClip()
            var strokeRect =  breadthRect.insetBy(dx: -width/2, dy: -width/2)
            strokeRect.origin = .init(x: width/2, y: width/2)
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
            .draw(in: strokeRect.insetBy(dx: width/2, dy: width/2))
            context.cgContext.setStrokeColor(color.cgColor)
            let line: UIBezierPath = .init(ovalIn: strokeRect)
            line.lineWidth = width
            line.stroke()
        }
    }
}


extension UIView{
     func blink() {
         self.alpha = 0.2
         UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
     }
    
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
         UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
             self.alpha = alpha
         })
     }
    
    func flash(numberOfFlashes: Float) {
             let flash = CABasicAnimation(keyPath: "opacity")
             flash.duration = 0.2
             flash.fromValue = 1
             flash.toValue = 0.1
             flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
             flash.autoreverses = true
             flash.repeatCount = numberOfFlashes
             layer.add(flash, forKey: nil)
         }
    
}

extension UIButton {
    func blinkf() {
        self.alpha = 0.0;
        UIView.animate(withDuration: 0.6, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
    
    func stopBlink() {
        self.layer.removeAllAnimations()
        self.alpha = 1.0;
        self.isHidden = false
    }
}
