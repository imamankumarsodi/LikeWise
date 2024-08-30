//
//  OppenentViewController_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation

import UIKit
//TODO: - extension for collectionview

extension OppenentViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SelectLanguageCollectionViewCell = languageCV.dequeueReusableCell(withReuseIdentifier: SelectLanguageCollectionViewCell.className, for: indexPath) as! SelectLanguageCollectionViewCell
        
      cell.configureCellWith(countryList[indexPath.row], AppColor.textColor)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
       }
       
    
}
