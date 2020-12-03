//
//  UserCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/16/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit
import Lottie

protocol userDelegate: class {
    func tapHeartView()
}

class UserCell: UITableViewCell {
    
    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var mUserAvatar: UIImageView!
    @IBOutlet weak var mHeartView: AnimationView!
    let heartjson = "4837-heart"
    let avatarName = "AvatarUser"
    weak var delegate: userDelegate?
    
    var mProfileViewModel:ProfileViewModel! {
        didSet {
            mUserLbl.text = mProfileViewModel.username
            mUserAvatar.image = UIImage.init(named: avatarName)
        }
    }
    @IBOutlet weak var mUserLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //set up shadow for cell
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.masksToBounds = false
        
        //set up avatar user
        mUserAvatar.contentMode = .scaleAspectFill
        mUserAvatar.layer.cornerRadius = mUserAvatar.frame.height/2
        
        //set up heartview
        let mTap = UITapGestureRecognizer.init(target: self, action: #selector(tapHeartView))
        mHeartView.addGestureRecognizer(mTap)
        mHeartView.animation = Animation.named(heartjson)
        mHeartView.contentMode = .scaleAspectFill
        mHeartView.loopMode = .loop
        mHeartView.play()
    }
    
    @objc func tapHeartView() {
        self.delegate?.tapHeartView()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
