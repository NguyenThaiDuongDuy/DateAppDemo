//
//  NameUserCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/23/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit

class NameUserCell: UITableViewCell {

    @IBOutlet weak var mUserName: UILabel!
    
    var mProfileViewModel:ProfileViewModel! {
        didSet {
            self.mUserName.text = mProfileViewModel.name
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
