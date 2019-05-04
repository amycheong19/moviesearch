//
//  UIImageView+Extension.swift
//  MovieSearch
//
//  Created by Amy Cheong on 3/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// Loads image from web asynchronosly and caches it, in case you have to load url
    /// again, it will be loaded from cache if available
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        
        let cache = cache ?? URLCache.shared
        let activityIndicator = UIActivityIndicatorView(style: .white)

        if !self.subviews.contains(activityIndicator) {
            self.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                activityIndicator.widthAnchor.constraint(equalToConstant: 20),
                activityIndicator.heightAnchor.constraint(equalToConstant: 20)
            ])
        }

        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                        activityIndicator.stopAnimating()
                    }
                }
            }).resume()
        }
    }
}
