//
//  Identifiable.swift
//  Property
//
//  Created by Amy Cheong on 12/3/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

protocol Identifiable: class {
   static var identifier: String { get }
}

extension UIView: Identifiable {}

extension Identifiable where Self: UIView {
   static var identifier: String {
      return String(describing: self)
   }
}



