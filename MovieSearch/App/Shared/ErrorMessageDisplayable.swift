//
//  ErrorMessageDisplayable.swift
//  Property
//
//  Created by Amy Cheong on 21/2/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

protocol ErrorMessageDisplayable: class {
   func presentPopup(title: String, message: String, buttonTitle: String,
                     onClose: @escaping () -> Void)
   func dismissPopup(completion: @escaping (Bool) -> Void)
}

extension ErrorMessageDisplayable where Self: UIViewController {
   func presentPopup(title: String,
                     message: String, buttonTitle: String = "OK",
                     onClose: @escaping () -> Void) {
      // Suppress error and use standard copy
      // be able to change their language while they are showing an alert.
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(.init(title: buttonTitle, style: .cancel) { _ in onClose() })
      self.present(alertController, animated: true, completion: nil)
   }

   // Dismisses popup if its of type UIAlertController
   // completion takes bool which indicates
   // whether alertController was dismissed or not (in case it's not AlertController)
   func dismissPopup(completion: @escaping (Bool) -> Void) {
      guard let alertController = self.presentedViewController as? UIAlertController else {
         completion(false)
         return
      }
      alertController.dismiss(animated: true) { completion(true) }
   }

}
