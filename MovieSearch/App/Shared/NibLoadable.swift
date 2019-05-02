//
//  NibLoadable.swift
//
//
//  Created by Amy Cheong on 29/10/18.
//  Copyright © 2018 Amy Cheong. All rights reserved.
//

import UIKit

public protocol NibLoadable: NSObjectProtocol {
   var nibContainerView: UIView { get }
   var nibName : String { get }
   func loadNib() -> UIView
   func setupNib()
}

public extension NibLoadable {
   func loadNib() -> UIView {
      let bundle = Bundle(for: type(of: self))
      let nib = UINib(nibName: nibName, bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
      return view
   }
   
   func setupView(_ view: UIView, inContainer container: UIView) {
      container.backgroundColor = .clear
      container.addSubview(view)
      view.frame = container.frame
      view.translatesAutoresizingMaskIntoConstraints = false
      
      container.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1, constant: 0))
      container.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1, constant: 0))
      
      container.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1, constant: 0))
      container.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1, constant: 0))
   }
}
