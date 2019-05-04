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
        static func cornerRadius() -> UIViewStyle<UIView> {
            return UIViewStyle<UIView> {
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 5.0
            }
        }

        static func opacity(by percentage: Float, color: UIColor) -> UIViewStyle<UIView> {
            return UIViewStyle<UIView> {
                $0.layer.opacity = percentage
                $0.backgroundColor = color
            }
        }
    }
}
