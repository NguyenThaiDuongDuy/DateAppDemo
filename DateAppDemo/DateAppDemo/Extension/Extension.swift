
//
//  Extension.swift
//  DateApp
//
//  Created by DuyNguyen on 9/4/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class  UIImageViewCustom : UIImageView {
    var urlString :String?
    
    func setImagewithUrl(url:String?) {
        
        self.urlString = url
        
        if let imageFromCache = imageCache.object(forKey: url! as NSObject) as? UIImage {
            print("imageFromCache")
            self.image = imageFromCache
            return
        }
        if let mUrlString = url {
            image = nil
            let mUrl = URL.init(string: mUrlString)
            URLSession.shared.dataTask(with: mUrl!) { (data, reponse, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let mdata = data {
                    DispatchQueue.main.async{
                        let mImageCache = UIImage(data: mdata)!
                        
                        if self.urlString == url {
                            self.image = mImageCache
                        } else {
                            print("self.urlString is \(self.urlString!)")
                            print("url is \(url!))")
                            print("Something wong here need to undersand")
                        }
                        imageCache.setObject(mImageCache, forKey: url! as NSObject)
                    }
                }
            }.resume()
        }
    }
}

extension Int {
    func convertBirthDateToString() -> String {
        let timeInterval = TimeInterval(self)
            let birthday = Date(timeIntervalSince1970: timeInterval)
            let DateFomart = DateFormatter()
            DateFomart.dateFormat = "MMM-YYY"
            let formattedDate = DateFomart.string(from: birthday)
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            let age = ageComponents.year!
            return ("\(formattedDate), \(age) years old")
    }
    
    func convertWorkDateToString() -> String {
        let timeInterval = TimeInterval(self)
        let workdateStart = Date(timeIntervalSince1970: timeInterval)
        let DateFomart = DateFormatter()
        DateFomart.dateFormat = "MMM-YYY"
        let formattedDate = DateFomart.string(from: workdateStart)
        return (" at RMIT University since \(formattedDate)")
    }
}
