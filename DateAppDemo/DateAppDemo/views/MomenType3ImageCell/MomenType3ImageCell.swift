//
//  MomenType3ImageCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/24/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit

class MomenType3ImageCell: UITableViewCell {
    @IBOutlet weak var mLargeImage1: UIImageViewCustom!
    @IBOutlet weak var mSubImage1: UIImageViewCustom!
    @IBOutlet weak var mSubImage2: UIImageViewCustom!
    override func awakeFromNib() {
        super.awakeFromNib()
        mLargeImage1.isHidden = true
        mSubImage1.isHidden = true
        mSubImage2.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
