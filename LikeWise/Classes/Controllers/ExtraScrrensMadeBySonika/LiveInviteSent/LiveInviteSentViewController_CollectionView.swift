//
//  LiveInviteSentViewController_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//TODO: - extension method of collection view
extension LiveInviteSentViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LifeInviteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: LifeInviteCollectionViewCell.className, for: indexPath) as! LifeInviteCollectionViewCell
        cell.playerImg.sd_setImage(with: URL(string: PlayGameUserModel_Array[indexPath.row].profilePic), placeholderImage: UIImage(named: "default_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(cell.playerImg, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlayGameUserModel_Array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LivePartnerFoundViewController.className) as! LivePartnerFoundViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
   
}
