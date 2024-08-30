//
//  ChatHistoryCollectionViewExt.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/05/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//TODO : - extension for cllection view
extension ChatHistoryVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(ParentMessageDataModeForShowArray.count)
        return ParentMessageDataModeForShowArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:ChatHistoryCollectionViewCell = collectionLife.dequeueReusableCell(withReuseIdentifier: ChatHistoryCollectionViewCell.className, for: indexPath) as! ChatHistoryCollectionViewCell
        
        cell.backgroundColor = AppColor.clearColor
        cell.tblChat.registerMultiple(nibs: [OpponentMessageCell.className,MyMessageTableViewCell.className])
        
        cell.tblChat.separatorStyle = .none
        cell.tblChat.tableFooterView = UIView()
        cell.tblChat.backgroundColor = AppColor.clearColor
        return cell
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 1.0 , height: collectionView.frame.size.height * 0.96)
    }
    
    
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ChatHistoryCollectionViewCell else { return }
    
    let last4 = String(ParentMessageDataModeForShowArray[indexPath.row].Image.suffix(4))
    
    if(last4.caseInsensitiveCompare(".gif") == .orderedSame){
        
        
        
        DispatchQueue.global(qos: .background).async {
            do
            {
                
                DispatchQueue.main.async {
                    let gifURL : String = self.ParentMessageDataModeForShowArray[indexPath.row].Image
                    let imageURL = UIImage.gifImageWithURL(gifURL)
                    let imageView3 = UIImageView(image: imageURL)
                    imageView3.frame = CGRect(x: 0, y: 0, width: self.imgBg.frame.size.width, height: self.imgBg.frame.size.height)
                    self.imgBg.addSubview(imageView3)
                }
            }
            catch {
                // error
            }
        }
        
        
    }else{
        imgBg.sd_setImage(with: URL(string: ParentMessageDataModeForShowArray[indexPath.row].Image), placeholderImage: UIImage(named: "profile_pic"))
        
    }
    
    
        
        tableViewCell.setTableViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row, dataItem: self.ParentMessageDataModeForShowArray[indexPath.row])
    } 
    
}


