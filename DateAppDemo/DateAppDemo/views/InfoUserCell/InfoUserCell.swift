//
//  InfoUserCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/23/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit

class InfoUserCell: UITableViewCell {
    @IBOutlet weak var mIconImage: UIImageView!
    @IBOutlet weak var mLbl: UILabel!
    var typyeCell:typeCell?
    
    
    var mProfileViewModel:ProfileViewModel! {
        didSet {
            switch typyeCell {
            case .birthdaycell:
                mIconImage.image = UIImage.init(named: "Calendar")
                mLbl.text  = mProfileViewModel.birthDay
                break
            case .educationcell:
                mIconImage.image = UIImage.init(named: "Education")
                mLbl.text  = mProfileViewModel.education
                break
            case .workcell:
                mIconImage.image = UIImage.init(named: "Work")
                mLbl.text  = mProfileViewModel.work
                break
            default:
                print("something")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         mIconImage.tintColor = .systemPink
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
