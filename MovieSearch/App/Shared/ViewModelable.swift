//
//  ViewModelable.swift
//  Property
//
//  Created by Amy Cheong on 16/2/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

/// Responsible for presentation and passing user events to `ViewModel` object.
protocol ViewModelable {
   associatedtype ViewModel

   /// `ViewModel` object used for transforming user input into output for presentation.
   var viewModel: ViewModel! { get set }
}

extension ViewModelable where Self: UIViewController {
   /// Entry point for `View` creation.
   ///
   /// - Parameter viewModel: `ViewModel` object used for binding.
   init(viewModel: ViewModel) {
      self.init(nibName: nil, bundle: nil)
      self.viewModel = viewModel
   }
}
