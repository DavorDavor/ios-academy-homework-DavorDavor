//
//  detailsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit
import Kingfisher

final class DetailsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showImageView: UIImageView!
    @IBOutlet private weak var reviewInfoLabel: UILabel!
    @IBOutlet private weak var ratingsView: RatingView!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Configure

extension DetailsTableViewCell {

    func configure(with show: Show) {
        descriptionLabel.text = show.description
        reviewInfoLabel.text = String(show.noOfReviews) + " REVIEWS, " + String(show.averageRating) + " AVERAGE"
        
        showImageView.kf.setImage(with: show.imageUrl, placeholder: UIImage(named: "ic-show-placeholder-rectangle"))
        
        ratingsView.setRoundedRating(show.averageRating)
        ratingsView.isEnabled = false
    }
}


