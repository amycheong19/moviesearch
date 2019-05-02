//
//  UITableView+Extension.swift
//  Property
//
//  Created by Amy Cheong on 12/3/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

extension UITableView {

   func dequeueCell<T: UITableViewCell>(with indexPath: IndexPath) -> T {
      guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
         fatalError("Could not dequeue tableViewCell with identifier \(T.identifier)")
      }
      return cell
   }
}
