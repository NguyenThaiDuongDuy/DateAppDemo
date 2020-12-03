//
//  ProfileViewModel.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/17/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//
import Foundation
import UIKit

public enum typeCell {
    case usercell
    case imagescell
    case nameCell
    case birthdaycell
    case workcell
    case educationcell
    case biocell
}

//public enum typeSection {
//    case userprofileSection
//    case momentSection
//}

struct ProfileViewModel {
    var listItem:[typeCell] = []
    var listSection:[String] = []
    var numofSection:Int?
    var name:String?
    var username:String?
    var images:[String]?
    var heightPageView:CGFloat = 0.0
    var birthDay:String?
    var work:String?
    var education:String?
    var workdate:Int?
    var bio:String?
    var momentData:[MomentList] = []
    var listCellinMoment:[String]?
    init(mProfileModel:ProfileModel) {
        listSection.append("SectionUserProfile")
        //Mark: Set up user cell
        if let username = mProfileModel.profile?.username {
            self.username = username
            listItem.append(.usercell)
        }
        
        if let images = mProfileModel.profile?.images {
            self.images = images
            listItem.append(.imagescell)
            if self.images!.count > 1 {
                heightPageView = 38.0
            } else {
                heightPageView = 0.0
            }
        }
        
        if let name = mProfileModel.profile?.name {
            self.name = name
            listItem.append(.nameCell)
        }
        
        if let date = mProfileModel.profile?.birthdate {
            self.birthDay =  date.convertBirthDateToString()
            listItem.append(.birthdaycell)
        }
        
        if let work = mProfileModel.profile?.work{
            self.work = work
            if let workdate = mProfileModel.profile?.work_date {
                self.work = self.work! + workdate.convertWorkDateToString()
            }
            listItem.append(.workcell)
        }
        
        if let education = mProfileModel.profile?.education {
            self.education = education
            listItem.append(.educationcell)
        }
        
        if let bio =  mProfileModel.profile?.bio {
            self.bio = bio
            listItem.append(.biocell)
        }
        
        if let moment = mProfileModel.profile?.moment {
            for (index,objective) in moment.enumerated() {
                let mListMoment = MomentList.init(momentObject: objective, momentIndex: index)
                self.momentData.append(mListMoment)
                print(self.momentData.count)
            }
        }
    }
}

struct MomentCell {
    var nameOfCell:String = ""
    var largeImage:String = ""
    var subImage1:String = ""
    var subImage2:String = ""
    
    init(nameOfcell:String, lagerimage:String, subimage1:String, subimage2:String) {
        self.nameOfCell = nameOfcell
        self.largeImage = lagerimage
        self.subImage1 = subimage1
        self.subImage2 = subimage2
    }
}

struct MomentList {
    let moment:Moment
    let momentIndex:Int
    var listCellInMoment:[MomentCell] = []
    
    init(momentObject:Moment, momentIndex:Int) {
        self.moment = momentObject
        self.momentIndex = momentIndex
        listCellInMoment = genarateCell(listImages: self.moment.images!)
    }
    
    
    func genarateCell(listImages:[String]) -> [MomentCell]{
        var tmp:[String] = []
        tmp = listImages
        var mListCellMoment:[MomentCell] = []
        while tmp.count/3 >= 1 {
            let cellObjectice = MomentCell.init(nameOfcell: "3Images", lagerimage: tmp[0], subimage1: tmp[1], subimage2: tmp[2])
            tmp.removeSubrange(ClosedRange(uncheckedBounds: (lower: 0, upper: 2)))
            mListCellMoment.append(cellObjectice)
        }
        
        if tmp.count%3 == 1 {
            let cellObjectice = MomentCell.init(nameOfcell: "1Images", lagerimage: tmp[0], subimage1: "", subimage2: "")
            mListCellMoment.append(cellObjectice)
        }else if tmp.count%3 == 2{
            let cellObjectice = MomentCell.init(nameOfcell: "2Images", lagerimage: "", subimage1: tmp[0], subimage2: tmp[1])
            mListCellMoment.append(cellObjectice)
        }
       return mListCellMoment
    }
    
}
