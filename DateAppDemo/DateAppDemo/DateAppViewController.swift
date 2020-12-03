//
//  ViewController.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/16/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//


import Foundation

public enum typeSection:Int {
    case USER_SECTION
    case MOMENT_SECTION
}

import UIKit
class DateAppViewController: UIViewController,userDelegate {
    func tapHeartView() {
        print("tapHeartView")
        mTopview!.userLbl.text = "How much do you lile \(self.userData?.name ?? "") ?"
        self.view.addSubview(mTopview!)
        mTopview!.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mTopview!.topAnchor.constraint(equalTo: margins.topAnchor),
            mTopview!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mTopview!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mTopview!.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    let userCellId = "UserCell"
    let userImagesId = "ImagesCell"
    let nameCellId = "NameUserCell"
    let infoUserCellCellId = "InfoUserCell"
    let bioCellId = "BioCell"
    let momenttype3ImageId = "MomenType3ImageCell"
    let USERSECTION = 0
    let MOMENTSECTION = 1
    var userData: ProfileViewModel?
    
    let heightLage3Image = UIScreen.main.bounds.width * 1.5
    let heightLage2Image = UIScreen.main.bounds.width * 0.5 - 2
    let heightLage1Image = UIScreen.main.bounds.width + 2
    
    var mTopview:SliderBarView?
    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(UINib.init(nibName: userCellId, bundle: nil), forCellReuseIdentifier: userCellId)
        TableView.register(UINib.init(nibName: userImagesId, bundle: nil), forCellReuseIdentifier: userImagesId)
        TableView.register(UINib.init(nibName: nameCellId, bundle: nil), forCellReuseIdentifier: nameCellId)
        TableView.register(UINib.init(nibName: infoUserCellCellId, bundle: nil), forCellReuseIdentifier: infoUserCellCellId)
        TableView.register(UINib.init(nibName: bioCellId, bundle: nil), forCellReuseIdentifier: bioCellId)
        TableView.register(UINib.init(nibName: momenttype3ImageId, bundle: nil), forCellReuseIdentifier: momenttype3ImageId)
        
        TableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        Apiservice.share.getJson { (mData, E) in
            if(E != nil) {
                print("Fail")
                return
            }
            self.userData = mData.map({ProfileViewModel.init(mProfileModel: $0)})
            print(self.userData as Any)
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
        
        mTopview = SliderBarView.init(frame:self.view.bounds)
    }
}

extension DateAppViewController:UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRow = 0
        if section == 0 {
            numOfRow =  userData?.listItem.count ?? 0
        } else {
            numOfRow = userData?.momentData[section-1].listCellInMoment.count ?? 0
        }
        print("numOfRow in section \(section) is \(numOfRow)")
        return numOfRow
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection = 0
        if userData?.username != nil {
            numOfSection =  (1 + (userData?.momentData.count ?? 0))
        }
        print(numOfSection)
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section  == USERSECTION {
            let typeCell:typeCell = (userData?.listItem[indexPath.row])!
            if typeCell == .usercell  {
                let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as! UserCell
                cell.delegate = self
                cell.mProfileViewModel = userData
                return cell
            } else if typeCell ==  .imagescell{
                let cell = tableView.dequeueReusableCell(withIdentifier: userImagesId, for: indexPath) as! ImagesCell
                return cell
            }
            else if (typeCell == .nameCell) {
                let cell = tableView.dequeueReusableCell(withIdentifier: nameCellId, for: indexPath) as! NameUserCell
                cell.mProfileViewModel = userData
                return cell
            }
            else if (typeCell == .birthdaycell || typeCell == .workcell || typeCell == .educationcell) {
                let cell = tableView.dequeueReusableCell(withIdentifier: infoUserCellCellId, for: indexPath) as! InfoUserCell
                cell.typyeCell = typeCell
                cell.mProfileViewModel = userData
                return cell
            } else if (typeCell == .biocell) {
                let cell = tableView.dequeueReusableCell(withIdentifier: bioCellId, for: indexPath) as! BioCell
                cell.mProfileViewModel = userData
                return cell
            }
            else {
                return UITableViewCell.init()
            }
        } else {
            
            if  (userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].nameOfCell == "3Images") {
                let cell = tableView.dequeueReusableCell(withIdentifier: momenttype3ImageId, for: indexPath) as! MomenType3ImageCell
                cell.mLargeImage1.isHidden = false
                cell.mSubImage1.isHidden = false
                cell.mSubImage2.isHidden = false
                cell.mLargeImage1.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].largeImage)
                cell.mSubImage1.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].subImage1)
                cell.mSubImage2.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].subImage2)
                return cell
            }
            
            if (userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].nameOfCell == "2Images") {
                let cell = tableView.dequeueReusableCell(withIdentifier: momenttype3ImageId, for: indexPath) as! MomenType3ImageCell
                cell.mLargeImage1.isHidden = true
                cell.mSubImage1.isHidden = false
                cell.mSubImage2.isHidden = false
                cell.mSubImage1.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].subImage1)
                cell.mSubImage2.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].subImage2)
                return cell
            }
            
            
            if (userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].nameOfCell == "1Images") {
                let cell = tableView.dequeueReusableCell(withIdentifier: momenttype3ImageId, for: indexPath) as! MomenType3ImageCell
                cell.mLargeImage1.setImagewithUrl(url: userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].largeImage)
                cell.mLargeImage1.isHidden = false
                cell.mSubImage1.isHidden = true
                cell.mSubImage2.isHidden = true
                return cell
            }
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == USERSECTION {
            let typeCell:typeCell = (userData?.listItem[indexPath.row])!
            if typeCell == .imagescell {
                return UIScreen.main.bounds.width + self.userData!.heightPageView
            } else {
                return UITableView.automaticDimension
            }
        } else { //section == 1
            if  (userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].nameOfCell == "3Images") {
                return heightLage3Image
            } else if (userData?.momentData[indexPath.section-1].listCellInMoment[indexPath.row].nameOfCell == "2Images") {
                return heightLage2Image
            } else {
                return heightLage1Image
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}


