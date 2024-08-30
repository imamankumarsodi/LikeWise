//
//  NoImageExtnionMethods.swift
//  LikeWise
//
//  Created by cst on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension Custom methods
extension NoImageViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    //TODO: Initial setup method
    internal func initialSetup(){
        CustomMethods.shared.provideShadowAndCornerRadius(self.viewContent, 20.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewContent, self.viewContent.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.instrutionView, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideCornerRadiusTo(self.instrutionView, self.instrutionView.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
//        CustomMethods.shared.provideCornerRadiusTo(self.questionView, self.questionView.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
//        CustomMethods.shared.setupLabel(questionNumLbl, UIColor.black, AppFont.light.size(AppFontName.SegoeUI, size: 14.0), "1/4 PASS", AppColor.clearColor)
//        
        messageTf.layer.cornerRadius = 24
        messageTf.clipsToBounds = true
        
        CustomMethods.shared.setupTextFeild(messageTf, UIColor.black, AppFont.light.size(AppFontName.SegoeUI, size: 12.0), AppColor.chatTfColor,"", .default)
        
        CustomMethods.shared.setupLabel(decsribeLbl, AppColor.themeColorLight, AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), "Name", AppColor.clearColor)
        
        CustomMethods.shared.setupLabel(describeTypeLbl, AppColor.textColor, AppFont.light.size(AppFontName.SegoeUI, size: 12.0), "Cities", AppColor.clearColor)
        
        CustomMethods.shared.setupLabel(describeDesLbl, AppColor.placeholderColor, AppFont.light.size(AppFontName.SegoeUI, size: 14.0), "When there is no image pass btn is hidden.", AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.describeView, 20.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        //    CustomMethods.shared.provideCornerRadiusTo(self.describeView, self.describeView.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        chatTV.registerMultiple(nibs: [FirstTableViewCell.className,SecondTableViewCell.className,ThreeTableViewCell.className,FourTableViewCell.className,FiveTableViewCell.className,SixTableViewCell.className])
        
        chatTV.delegate = self
        chatTV.dataSource = self
    }
    
}


//TODO: - extesion for tablee view

extension NoImageViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell:FirstTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            
            return cell
        }
        else if indexPath.row == 1{
            let cell:SecondTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            
            return cell
        }
        else if indexPath.row == 2{
            let cell:ThreeTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "ThreeTableViewCell", for: indexPath) as! ThreeTableViewCell
            
            return cell
        }
        else  if indexPath.row == 3{
            let cell:FourTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "FourTableViewCell", for: indexPath) as! FourTableViewCell
            
            return cell
        }
        else  if indexPath.row == 4{
            let cell:FiveTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "FiveTableViewCell", for: indexPath) as! FiveTableViewCell
            
            return cell
        }
        else  if indexPath.row == 5{
            let cell:SixTableViewCell = chatTV.dequeueReusableCell(withIdentifier: "SixTableViewCell", for: indexPath) as! SixTableViewCell
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
