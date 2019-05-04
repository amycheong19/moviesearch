//
//  Style.swift
//  MovieSearch
//
//  Created by Amy Cheong on 4/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

enum Style {
    enum View {
        static func shadow() -> UIViewStyle<UIView> {
            return UIViewStyle<UIView> {
                $0.layer.masksToBounds = false
                $0.layer.shadowColor = UIColor.black.cgColor
                $0.layer.shadowOpacity = 1.0
                $0.layer.shadowOffset = .zero
                $0.layer.shadowRadius = 15
            }
        }

        static func cornerRadius() -> UIViewStyle<UIView> {
            return UIViewStyle<UIView> {
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 5.0
            }
        }
    }
}
