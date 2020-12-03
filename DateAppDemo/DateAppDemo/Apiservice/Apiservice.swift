//
//  Apiservice.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/16/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import Foundation
import Alamofire

class Apiservice {
    static let share = Apiservice.init()
    typealias JsonDataRespone = (ProfileModel?,Error?)->()
    func getJson(completion: @escaping JsonDataRespone) {
        //let url = "https://srv-error.gofile.io/downloadStore/srv-store4/qMiOw3/JsonDb"
//        let url = "https://srv-file4.gofile.io/downloadStore/srv-store2/B6BLUK/JsonDb"
        let url = "https://my-json-server.typicode.com/thailemeetai/mobile-assignment/db"
        AF.request(url).responseDecodable(of: ProfileModel.self) {(mDataResponse) in
            if let error = mDataResponse.error {
                let resultText = NSString(data: mDataResponse.data!, encoding: String.Encoding.utf8.rawValue)
                print(resultText as Any)
                completion(nil,error)
            } else if let data = mDataResponse.value {
                completion(data,nil)
            }
        }
    }
}
