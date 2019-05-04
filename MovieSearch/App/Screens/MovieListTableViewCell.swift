//
//  MovieListTableViewCell.swift
//  MovieSearch
//
//  Created by Amy Cheong on 2/5/19.
//  Copyright © 2019 Amy Cheong. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageShadowView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // A shadow will be drawn outside of the layer, thus it is clipped so we can't use the same layer with cornerRadius
        // OR we can add sublayer
        Style.View.cornerRadius().apply(to: posterImageView)
        Style.View.shadow().apply(to: posterImageShadowView)

        Style.View.cornerRadius().apply(to: containerView)
    }
}
