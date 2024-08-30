//
//  FAQVC_TableView.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UITableViewDelegate and UITableViewDatasource
extension FAQVC : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FAQDataModelArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FAQDataModelArray[section].isSelected {
            return 1
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(FAQHeader.className, owner: self, options: nil)?.first as! FAQHeader
        headerView.lblHeading.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: FAQDataModelArray[section].title, font: AppFont.semibold.size(.SegoeUI, size: 15), AppColor.textColor)
        headerView.btnDropDown.tag = section
        headerView.btnDropDown.addTarget(self, action: #selector(sectionButtonTapped), for: .touchUpInside)
        
        if isComingFromPrivacy{
            headerView.btnDropDown.isHidden = true
        }else{
            headerView.btnDropDown.isHidden = false
        }
        
        
        if FAQDataModelArray[section].isSelected {
            CustomMethods.shared.provideCornerRadiusTo(headerView.vwOuter, 6, [.layerMinXMinYCorner,.layerMaxXMinYCorner])
            headerView.btnDropDown.setImage(#imageLiteral(resourceName: "up"), for: .normal)
        }else{
            CustomMethods.shared.provideCornerRadiusTo(headerView.vwOuter, 6, [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner])
            headerView.btnDropDown.setImage(#imageLiteral(resourceName: "down"), for: .normal)
        }
        
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :  FAQCell = tblVw.dequeueReusableCell(withIdentifier: FAQCell.className) as! FAQCell
        cell.configureSettingsWith(FAQDataModelArray[indexPath.section])
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if FAQDataModelArray[section].isSelected {
             return 50
        }else{
             return 60
        }
        
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if FAQDataModelArray[indexPath.section].isSelected {
            return UITableView.automaticDimension
            
        }else{
            return 0
        }
        
    }
   
}

