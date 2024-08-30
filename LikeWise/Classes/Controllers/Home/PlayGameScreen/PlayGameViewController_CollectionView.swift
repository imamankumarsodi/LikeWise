//
//  PlayGameViewController_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
//TODO: - extension for collectionview

extension PlayGameViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.CountryDataModelCollecArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SelectLanguageCollectionViewCell = langCV.dequeueReusableCell(withReuseIdentifier: SelectLanguageCollectionViewCell.className, for: indexPath) as! SelectLanguageCollectionViewCell

        cell.configureCellWithNewS(CountryDataModelCollecArr[indexPath.row], AppColor.textColor)
       
            
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 120, height: collectionView.frame.height)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CountryDataModelCollecArr[indexPath.row].isSelected = !CountryDataModelCollecArr[indexPath.row].isSelected
        
        sideNAme = CountryDataModelCollecArr[indexPath.row].isSelected ? indexPath.row : -1
        
        for index in 0..<CountryDataModelCollecArr.count{
            if index != indexPath.row{
                CountryDataModelCollecArr[index].isSelected = Bool()
            }
        }
        self.langCV.reloadData()
    }
}
