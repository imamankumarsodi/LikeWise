//
//  ChatVC_CollectionViewExtension.swift
//  LikeWise
//
//  Created by Aman Kumar on 22/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//TODO : - extension for cllection view
extension ChatVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lifeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         let cell:LifeCollectionViewCell = collectionLife.dequeueReusableCell(withReuseIdentifier: LifeCollectionViewCell.className, for: indexPath) as! LifeCollectionViewCell
        if indexPath.row == (lifeCount - 1){
            cell.setupCellWith(lastLife: lifeCount)
        }else{
            cell.setupCellAll()
        }
        
        return cell
        
 
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MAIN_SCREEN_WIDTH/8, height: collectionView.frame.height)
    }
}
