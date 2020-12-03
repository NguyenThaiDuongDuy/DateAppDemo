//
//  ProfileModel.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/16/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import Foundation

struct ProfileModel:Decodable {
    var profile:Profile?
}

struct Profile:Decodable {
    var username:String?
    var name:String?
    var birthdate:Int?
    var work_date:Int?
    var work:String?
    var education:String?
    var hobbies:[String]?
    var song:[String]?
    var images:[String]?
    var bio:String?
    var moment:[Moment]?
}

struct Moment:Decodable {
    var location:String?
    var latlong:String?
    var date:Int?
    var images:[String]?
}
