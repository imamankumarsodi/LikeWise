//
//  GameCreateViewController_CollectionView.swift
//  LikeWise
//
//  Created by Aman Kumar on 01/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//TODO : - extension for cllection view
extension GameCreateViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  @objc  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == createGmeCV{
            return searchActive ? filtered.count : CountryDataModelCollecArr_SearchFriends.count
        }
        else  if collectionView == selectLangCV{
            return CountryDataModelCollecArr_Language.count
        }
        else  if collectionView == objevtiveCV{
            return CountryDataModelCollecArr_Objective.count
        }
        else  if collectionView == preciselyCV{
            if objectives != String(){
                return CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray.count
            }else{
                return 0
            }
        }
        else{
            return photosArray.count
        }
        
        
    }
    
   @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == createGmeCV{
            
            
            let cell:SelectLanguageCollectionViewCell = createGmeCV.dequeueReusableCell(withReuseIdentifier: SelectLanguageCollectionViewCell.className, for: indexPath) as! SelectLanguageCollectionViewCell
            cell.btnSelectRef.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
            
            if searchActive{
                cell.configureCellWithNewS(filtered[indexPath.row], AppColor.whiteColor)
            }else{
                cell.configureCellWithNewS(CountryDataModelCollecArr_SearchFriends[indexPath.row], AppColor.whiteColor)
            }
            
            
            return cell
            
        }
        else if collectionView == selectLangCV{
            let cell:SelectLanguageCollectionViewCell = selectLangCV.dequeueReusableCell(withReuseIdentifier: SelectLanguageCollectionViewCell.className, for: indexPath) as! SelectLanguageCollectionViewCell
            
            cell.configureCellWithNewLang(CountryDataModelCollecArr_Language[indexPath.row], AppColor.whiteColor)
            return cell
        }
            
        else if collectionView == objevtiveCV{
            
            let cell:CreategameObjectiveCollectionViewCell = objevtiveCV.dequeueReusableCell(withReuseIdentifier: CreategameObjectiveCollectionViewCell.className, for: indexPath) as! CreategameObjectiveCollectionViewCell
            cell.configureCellWithNew(CountryDataModelCollecArr_Objective[indexPath.row], AppColor.whiteColor)
            return cell
        }
            
        else if collectionView == preciselyCV{
            
            if objectives != String(){
                let cell:preciselyCollectionViewCell = preciselyCV.dequeueReusableCell(withReuseIdentifier: preciselyCollectionViewCell.className, for: indexPath) as! preciselyCollectionViewCell
                cell.configureCellWithNew(CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[indexPath.row], AppColor.whiteColor)
                return cell
            }else{
                return UICollectionViewCell()
            }
            
            
            
        }
        else if collectionView == addImagesCV{
            let cell:AddImageCollectionViewCell = addImagesCV.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.className, for: indexPath) as! AddImageCollectionViewCell
            
            if photosArray[indexPath.row]._id == String(){
                
                cell.photo.image = photosArray[indexPath.row].image
                
            }else{
                
                cell.photo.sd_setImage(with: URL(string: photosArray[indexPath.row].images), placeholderImage: UIImage(named: "default_pic"))
                
            }
            
            CustomMethods.shared.provideCornerRadiusTo(cell.photo, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            CustomMethods.shared.provideCornerBorderTo(cell.photo, 2, AppColor.whiteColor)
            
            cell.btnDelRef.tag = indexPath.row
            cell.btnDelRef.addTarget(self, action: #selector(btnDeleteTappd), for: .touchUpInside)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
  @objc  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == objevtiveCV{
            if CountryDataModelCollecArr_Objective[indexPath.row].isSelected == Bool(){
                CountryDataModelCollecArr_Objective[indexPath.row].isSelected = !CountryDataModelCollecArr_Objective[indexPath.row].isSelected
            }
           
            for index in 0..<CountryDataModelCollecArr_Objective.count{
                if index != indexPath.row{
                    CountryDataModelCollecArr_Objective[index].isSelected = Bool()
                }
            }
            
            objectives = CountryDataModelCollecArr_Objective[indexPath.row].isSelected ? CountryDataModelCollecArr_Objective[indexPath.row]._id : String()
            
            selectedOpertunies = CountryDataModelCollecArr_Objective[indexPath.row].isSelected ? indexPath.row : Int()
            
            objevtiveCV.reloadData()
            
            for index in 0..<CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray.count{
                CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[index].isSelected = Bool()
                
            }
            
            showHideMorePrecisely()
            
        }
        else if collectionView == preciselyCV{
            
            
            if objectives != String(){
                CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[indexPath.row].isSelected = !CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[indexPath.row].isSelected
                
                
                for index in 0..<CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray.count{
                    if index == indexPath.row{
                        if  CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[indexPath.row].isSelected{
                            morePresicely = CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[indexPath.row]._id
                        }else{
                            morePresicely = String()
                            
                        }
                        
                        
                        
                    }else{
                        CountryDataModelCollecArr_Objective[selectedOpertunies].MorereciselyArray[index].isSelected = Bool()
                    }
                }
                
            }else{
                preciselyCV.reloadData()
            }
            
            
            
        }
        else if collectionView == selectLangCV{
            CountryDataModelCollecArr_Language[indexPath.row].isSelected = !CountryDataModelCollecArr_Language[indexPath.row].isSelected
            for index in 0..<CountryDataModelCollecArr_Language.count{
                if index == indexPath.row{
                    
                    
                    if CountryDataModelCollecArr_Language[indexPath.row].isSelected {
                        languageCode = CountryDataModelCollecArr_Language[indexPath.row].code
                    }else{
                        languageCode = String()
                    }
                    
                }else{
                    CountryDataModelCollecArr_Language[index].isSelected = Bool()
                }
            }
            selectLangCV.reloadData()
            
        } else if collectionView == createGmeCV{
            
            if searchActive{
                filtered[indexPath.row].isSelected = !filtered[indexPath.row].isSelected
                for index in 0..<filtered.count{
                    if index == indexPath.row{
                        
                        if filtered[indexPath.row].isSelected{
                            socialId = filtered[indexPath.row].socialId
                            self.selectedFriend = filtered[indexPath.row]
                            
                            self.profilePic = filtered[indexPath.row].profilePic
                            self.userName = filtered[indexPath.row].name
                            
                        }else{
                            socialId = String()
                            self.profilePic = String()
                            self.userName = String()
                        }
                    }else{
                        filtered[index].isSelected = Bool()
                    }
                }
                
                
                
            }else{
                CountryDataModelCollecArr_SearchFriends[indexPath.row].isSelected = !CountryDataModelCollecArr_SearchFriends[indexPath.row].isSelected
                for index in 0..<CountryDataModelCollecArr_SearchFriends.count{
                    if index == indexPath.row{
                        
                        
                        if CountryDataModelCollecArr_SearchFriends[indexPath.row].isSelected{
                            socialId = CountryDataModelCollecArr_SearchFriends[indexPath.row].socialId
                            self.selectedFriend = CountryDataModelCollecArr_SearchFriends[indexPath.row]
                            self.profilePic = CountryDataModelCollecArr_SearchFriends[indexPath.row].profilePic
                            self.userName = CountryDataModelCollecArr_SearchFriends[indexPath.row].name
                            
                        }else{
                            socialId = String()
                        }
                        
                    }else{
                        CountryDataModelCollecArr_SearchFriends[index].isSelected = Bool()
                    }
                }
            }
            
            
            createGmeCV.reloadData()
        }
    }
    
    
  @objc  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == preciselyCV{
            
            return CGSize(width: collectionView.frame.width/2 - collectionView.frame.width/8, height: collectionView.frame.height)
           
        }
        else if collectionView == addImagesCV{
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
            
        }else if collectionView == selectLangCV{
            
            return CGSize(width: 80, height: collectionView.frame.height)
            
        }else if collectionView == objevtiveCV{
            
            return CGSize(width: 80, height: collectionView.frame.height)
        }
            
        else{
            return CGSize(width: 90, height: collectionView.frame.height)
            
        }
    }
    
   
    
}
