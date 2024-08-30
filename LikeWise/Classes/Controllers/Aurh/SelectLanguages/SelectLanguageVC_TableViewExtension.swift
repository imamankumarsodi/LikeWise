//
//  SelectLanguageVC_TableViewExtension.swift
//  LikeWise
//
//  Created by Deepti Sharma on 20/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UITableview datasource and delegate
extension SelectLanguagesVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.countryDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.countryDataModelArray[section].array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return textFieldCellData(indexPath, tableView: tableView)
    }
    
    private func textFieldCellData( _ indexPath : IndexPath, tableView : UITableView) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectLanguage_TableViewCell.className) as? SelectLanguage_TableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        CustomMethods.shared.setupButton(cell.btnSelectRef, AppColor.textColor,AppColor.whiteColor,ConstantFonts.TitleNewFont, "               \(self.countryDataModelArray[indexPath.section].array[indexPath.row].language) (\(self.countryDataModelArray[indexPath.section].array[indexPath.row].description))")
        
        
      /*  DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:self.countryDataModelArray[indexPath.section].array[indexPath.row].picture)!)
                DispatchQueue.main.async {
                    if let image = UIImage(data: data){
                        cell.lngImg.image = image
                        CustomMethods.shared.provideShadowAndCornerRadius(cell.lngImg, 5, AppColor.placeholderColor, 3, 3, 3, 3, 3, AppColor.clearColor)
                        
                      
                        
                        
                    }
                    
                }
            }
            catch {
                // error
            }
        } */
        
        
        cell.lngImg.sd_setImage(with: URL(string: self.countryDataModelArray[indexPath.section].array[indexPath.row].picture), placeholderImage: UIImage(named: "profile_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(cell.lngImg, 5,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerBorderTo(cell.lngImg, 1, AppColor.whiteColor)
        
        cell.btnSelectRef.backgroundColor = AppColor.clearColor
        cell.btnLanguageRef.backgroundColor = AppColor.clearColor
        
        let image = self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected ? #imageLiteral(resourceName: "checked_s") : UIImage()
        
        cell.btnLanguageRef.setImage(image, for: .normal)
        cell.backgroundColor = self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected ? AppColor.tblSelectColor : AppColor.whiteColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected = !self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected
        if let cell = tblLanguage.cellForRow(at: indexPath) as? SelectLanguage_TableViewCell{
            let image = self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected ? #imageLiteral(resourceName: "checked_s") : UIImage()
            cell.btnLanguageRef.setImage(image, for: .normal)
            
            cell.backgroundColor = self.countryDataModelArray[indexPath.section].array[indexPath.row].isSelected ? AppColor.tblSelectColor : AppColor.whiteColor
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if self.countryDataModelArray[section].array.count > 0{
            let header: SelectLanguageViewHeader  = Bundle.main.loadNibNamed(SelectLanguageViewHeader.className, owner: self, options: nil)?.first as! SelectLanguageViewHeader
            header.lblTitle.font = ConstantFonts.TextFieldFont
            header.lblTitle.textColor = AppColor.textColor
            header.lblTitle.text = self.countryDataModelArray[section].title
            return header
        }else{
            return UIView()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.countryDataModelArray[section].array.count > 0{
            return 50
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tblHeight.constant = tblLanguage.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
}

