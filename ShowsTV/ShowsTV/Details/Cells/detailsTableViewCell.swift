//
//  detailsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit

final class detailsTableViewCell: UITableViewCell {

    // MARK: - Private UI

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showImage: UILabel!
    @IBOutlet private weak var reviewInfoLabel: UILabel!
    @IBOutlet private weak var ratingsView: RatingView!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }

}

// MARK: - Configure

extension detailsTableViewCell {

    func configure(with item: Show) {
        descriptionLabel.text = item.description
        reviewInfoLabel.text = String(item.no_of_reviews) + " REVIEWS, " + String(item.average_rating) + " AVERAGE"
        self.ratingsView.setRoundedRating(item.average_rating)
        
        self.ratingsView.isEnabled = false
    }
}

// MARK: - Private

private extension detailsTableViewCell {

    func setupUI() {
        
    }
}
