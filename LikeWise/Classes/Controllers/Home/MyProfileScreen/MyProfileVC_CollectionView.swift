//
//  MyProfileVC_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import ADCountryPicker

//TODO: - extension for collectionview

extension MyProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SelectLanguageCollectionViewCell = languageCV.dequeueReusableCell(withReuseIdentifier: SelectLanguageCollectionViewCell.className, for: indexPath) as! SelectLanguageCollectionViewCell
        
        cell.configureCellWith(countryList[indexPath.row], AppColor.textColor)
        cell.btnSelectRef.tag = indexPath.row
        cell.btnSelectRef.addTarget(self, action: #selector(deleteLan), for: .touchUpInside)
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        
    }
    
  
    @objc func deleteLan(_ sender:UIButton) {
        
        if countryList[sender.tag].isSelected == true{
            
        }else{
            countryList.remove(at: sender.tag)
            self.languageCV.reloadData()
        }
        
    }
    
    
    
}
