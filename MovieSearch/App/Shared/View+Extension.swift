//
//  View Extension.swift
//  
//
//  Created by Amy Cheong on 30/01/18.
//  Copyright © 2018 Amy Cheong. All rights reserved.
//

import UIKit

public extension UIView {
   @objc dynamic public var nibContainerView: UIView {
      return self
   }
   
   @objc dynamic public var nibName: String {
      return String(describing: type(of: self))
   }

   func gradient(startColor: UIColor, endColor: UIColor){
      let gradient: CAGradientLayer = CAGradientLayer()
      gradient.frame = CGRect(x: CGFloat(0),
                              y: CGFloat(0),
                              width: self.frame.size.width,
                              height: self.frame.size.height)
      gradient.colors = [startColor.cgColor, endColor.cgColor]
      gradient.zPosition = -1
      layer.addSublayer(gradient)
   }
}
