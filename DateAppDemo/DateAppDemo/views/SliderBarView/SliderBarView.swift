//
//  SliderBarView.swift
//  DateAppDemo
//
//  Created by DuyNguyen on 12/1/20.
//  Copyright © 2020 DuyNguyen. All rights reserved.
//

import Foundation
import UIKit

class SliderBarView:UIView {
        
        lazy var blackView : UIView = {
            let blackView = UIView.init(frame:self.frame)
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapshaw)))
            return blackView
        }()
        
        
        lazy var topView : UIView = {
            let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.25))
            topView.backgroundColor = .white
            topView.translatesAutoresizingMaskIntoConstraints = false
            return topView
        }()
        
        lazy var heartImage : UIImageView = {
            let heartImage = UIImageView.init(image: UIImage.init(named: "heart"))
            heartImage.translatesAutoresizingMaskIntoConstraints = false
            heartImage.frame = CGRect.init(x: 0, y: 0, width: 24, height: 24)
            heartImage.tintColor = .systemPink
            return heartImage
        }()
        
        lazy var userLbl : UILabel = {
            let userLbl = UILabel.init()
            userLbl.translatesAutoresizingMaskIntoConstraints = false
            userLbl.text = "How much do u like ammy ?"
            return userLbl
        }()
        
        lazy var heartSlider : HeartCustomSlider = {
            let heartSlider = HeartCustomSlider.init()
            heartSlider.translatesAutoresizingMaskIntoConstraints = false
            heartSlider.maximumValue = 100.0
            heartSlider.minimumTrackTintColor = . systemPink
            heartSlider.addTarget(self, action: #selector(changeVlaue(_:)), for: .valueChanged)
            return heartSlider
        }()
        
        @objc func changeVlaue(_ sender: UISlider) {
            heartSlider.setNeedsDisplay()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(blackView)
            addSubview(topView)
            topView.addSubview(heartImage)
            topView.addSubview(userLbl)
            topView.addSubview(heartSlider)
            setUpconnstraint()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func  tapshaw() {
            self.removeFromSuperview()
        }
        
        private func setUpconnstraint() {
            topView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            topView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
            
            heartImage.topAnchor.constraint(equalTo: self.topView.topAnchor, constant: 15.0).isActive = true
            heartImage.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 15.0).isActive = true
            heartImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
            heartImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            userLbl.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor).isActive = true
            userLbl.leadingAnchor.constraint(equalTo: heartImage.trailingAnchor, constant: 15.0).isActive = true
            
            heartSlider.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 15).isActive = true
            heartSlider.trailingAnchor.constraint(equalTo: topView.trailingAnchor,constant: -15).isActive = true
            heartSlider.bottomAnchor.constraint(equalTo: topView.bottomAnchor,constant: -5).isActive = true
        }
    }

    class HeartCustomSlider: UISlider {
        
        let scoreLbl : UILabel = {
            let scoreLbl = UILabel.init()
            scoreLbl.textColor = .white
            scoreLbl.translatesAutoresizingMaskIntoConstraints = false
            scoreLbl.frame = CGRect.init(x: 0, y: 0, width: 13, height: 15)
            scoreLbl.text = ""
            return scoreLbl
        }()
        
        let heartView : UIImageView = {
            let heartView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            heartView.image = UIImage.init(named: "heart")
            heartView.tintColor = .systemPink
            return heartView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(heartView)
            heartView.addSubview(scoreLbl)
            scoreLbl.centerXAnchor.constraint(equalTo: heartView.centerXAnchor).isActive = true
            scoreLbl.centerYAnchor.constraint(equalTo: heartView.centerYAnchor).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
            let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
            print("slidertTrack is \(slidertTrack)")
            let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
            print("sliderFrm is \(sliderFrm)")
            return CGPoint(x: sliderFrm.origin.x +  sliderFrm.width/2 - self.heartView.frame.width/2 , y: slider.bounds.origin.y-55)
        }
        
        
        override func layoutSubviews() {
            super.layoutSubviews()
            heartView.frame.origin = self.setUISliderThumbValueWithLabel(slider: self)
            scoreLbl.text = "\(Int(self.value))"
            print(heartView.frame.origin)
        }
        
        override func trackRect(forBounds bound: CGRect) -> CGRect {
           //Here, set track frame
            return CGRect(origin: bound.origin, size: CGSize(width: bound.width, height: 3.0))
         }
}
