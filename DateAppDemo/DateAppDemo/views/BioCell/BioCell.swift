//
//  BioCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/24/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit

class BioCell: UITableViewCell {
    @IBOutlet weak var mLbl: UILabel!
    
    var mProfileViewModel:ProfileViewModel! {
           didSet {
            mLbl.text = mProfileViewModel.bio
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
