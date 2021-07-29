//
//  RatingsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit

final class ratingsTableViewCell: UITableViewCell {

    // MARK: - Private UI
    
    @IBOutlet private weak var userIDLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var ratingsView: RatingView!
    


    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

// MARK: - Configure

extension ratingsTableViewCell {

    func configure(with review: Review) {
        self.userIDLabel.text = review.user.email
        self.userIDLabel.sizeToFit()
        self.reviewLabel.text = review.comment
        self.ratingsView.setRoundedRating(review.rating)
        self.ratingsView.isEnabled = false
    }
}

// MARK: - Private

private extension ratingsTableViewCell {

    
    
    func setupUI() {
    }
}
