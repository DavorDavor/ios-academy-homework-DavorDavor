//
//  RatingsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit
import Kingfisher

final class ReviewsTableViewCell: UITableViewCell {

    // MARK: - Private UI
    
    @IBOutlet private weak var userIDLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var ratingsView: RatingView!
    


    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userIDLabel.text = nil
        reviewLabel.text = nil
    }
}

// MARK: - Configure

extension ReviewsTableViewCell {

    func configure(with review: Review) {
        userIDLabel.text = review.user.email
        ratingsView.configure(withStyle: .small)
        
        ratingsView.setRoundedRating(review.rating)
        ratingsView.isEnabled = false
        reviewLabel.text = review.comment
        
        
        if let imageUrl = review.user.imageUrl {
        guard let imageUrl = URL(string: imageUrl) else {return}
        userImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
        }
    }
}

