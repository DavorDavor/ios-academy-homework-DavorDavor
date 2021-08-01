//
//  detailsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit
import Kingfisher

final class detailsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showImageView: UIImageView!
    @IBOutlet private weak var reviewInfoLabel: UILabel!
    @IBOutlet private weak var ratingsView: RatingView!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

// MARK: - Configure

extension detailsTableViewCell {

    func configure(with show: Show) {
        descriptionLabel.text = show.description
        reviewInfoLabel.text = String(show.no_of_reviews) + " REVIEWS, " + String(show.average_rating) + " AVERAGE"
        
        guard let imageUrl = show.image_url else { return }
        guard let imageUrl = URL(string: imageUrl) else {return}
        showImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-show-placeholder-rectangle"))
        
        self.ratingsView.setRoundedRating(show.average_rating)
        self.ratingsView.isEnabled = false
    }
}

// MARK: - Private

private extension detailsTableViewCell {

    func setupUI() {
        
    }
}
