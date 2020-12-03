//
//  ImagesCell.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 9/17/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import UIKit

class ImagesCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let imagesSubCellId = "ImagesSubCell"
    @IBOutlet weak var mPageView: UIPageControl!
    @IBOutlet weak var mCollectionView: UICollectionView!
    var userData: ProfileViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        mCollectionView.register(UINib.init(nibName: imagesSubCellId, bundle: nil), forCellWithReuseIdentifier: imagesSubCellId)
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
        mCollectionView.isPagingEnabled = true
        mCollectionView.showsHorizontalScrollIndicator = false
        mPageView.pageIndicatorTintColor = UIColor.systemPink.withAlphaComponent(0.5)
        mPageView.currentPageIndicatorTintColor = UIColor.systemPink
        Apiservice.share.getJson { (mData, E) in
            self.userData = mData.map({ProfileViewModel.init(mProfileModel: $0)})
            print(self.userData as Any)
            DispatchQueue.main.async {
                if self.userData?.heightPageView == 0.0 {
                    self.mPageView.isHidden = true
                }
                self.mPageView.numberOfPages = (self.userData?.images!.count)!
                self.mCollectionView.reloadData()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userData?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: imagesSubCellId, for: indexPath) as! ImagesSubCell
        cell.mImageView.setImagewithUrl(url: self.userData?.images![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x/UIScreen.main.bounds.width))
        print("\(scrollView.contentOffset)")
        setCurrentPageView(index: index)
    }
    
    func setCurrentPageView(index:Int) {
        mPageView.currentPage = index
    }
    
}

//extension ImagesCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.userData?.images?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: imagesSubCellId, for: indexPath) as! ImagesSubCell
//        cell.mImageView.setImagewithUrl(url: self.userData?.images![indexPath.row])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
//    }
//}
