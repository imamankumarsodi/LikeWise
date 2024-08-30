//
//  ImagePickerViewController_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

extension ImagePickerViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:AddImageCollectionViewCell = publicGalleryCV.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.className, for: indexPath) as! AddImageCollectionViewCell
        
        
     /*   let last4 = String(imagesArray[indexPath.row].images.suffix(4))
        
        if(last4.caseInsensitiveCompare(".gif") == .orderedSame){
            
            
            
            DispatchQueue.global(qos: .background).async {
                do
                {
                    
                    DispatchQueue.main.async {
                        let gifURL : String = self.imagesArray[indexPath.row].images
                        let imageURL = UIImage.gifImageWithURL(gifURL)
                        let imageView3 = UIImageView(image: imageURL)
                        imageView3.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
                        cell.photo.addSubview(imageView3)
                    }
                }
                catch {
                    // error
                }
            }
            
            
        }else{
            cell.photo.sd_setImage(with: URL(string: imagesArray[indexPath.row].images), placeholderImage: UIImage(named: "profile_pic"))
            
        } */
        cell.photo.sd_setImage(with: URL(string: imagesArray[indexPath.row].images), placeholderImage: UIImage(named: "profile_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(cell.photo, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(cell.photo, 2, AppColor.whiteColor)
        let image = imagesArray[indexPath.row].isSelected ? #imageLiteral(resourceName: "select") : UIImage()
        cell.btnDelRef.setImage(image, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: takePicVieew.frame.width, height:  takePicVieew.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if filterArray.count >= 6{
            if imagesArray[indexPath.row].isSelected == true{
                imagesArray[indexPath.row].isSelected = false
                self.filterArray.removeLast()
            }else{
                HHelper.showAlert(ConstantTexts.MaxImageSelectionAlert)
            }
            
        }else{
            if imagesArray[indexPath.row].isSelected{
                imagesArray[indexPath.row].isSelected = false
                self.filterArray.removeLast()
            }else{
                imagesArray[indexPath.row].isSelected = true
                self.filterArray.append(imagesArray[indexPath.row])
            }
        }
        
        
        self.publicGalleryCV.reloadData()
    }
    
}

extension ImagePickerViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosen_image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if filterArray.count >= 6{
                HHelper.showAlert(ConstantTexts.MaxImageSelectionAlert)
            }else{
                
                filterArray.append(selectImage(_id: String(), images: String(), themeName: String(), image: choosen_image, isSelected: Bool(), withName: "images", fileName:"images", mimeType: "image/png"))
            }
            
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
}

