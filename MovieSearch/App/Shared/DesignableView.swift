//
//  DesignableView.swift
//  
//
//  Created by Amy Cheong on 29/10/18.
//  Copyright © 2018 Amy Cheong. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableView: UIView, NibLoadable {
   public override init(frame: CGRect) {
      super.init(frame: frame)
      setupNib()
   }
   
   public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupNib()
   }
   
   public func setupNib() {
      setupView(loadNib(), inContainer: nibContainerView)
   }
}
