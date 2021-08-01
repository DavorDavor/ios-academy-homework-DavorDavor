//
//  RatingsTableViewCell.swift
//  ShowsTV
//
//  Created by Infinum  on 28.07.2021..
//


import UIKit
import Kingfisher

final class ratingsTableViewCell: UITableViewCell {

    // MARK: - Private UI
    
    @IBOutlet private weak var userIDLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var ratingsView: RatingView!
    


    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.userIDLabel.text = nil
        self.reviewLabel.text = nil
    }
}

// MARK: - Configure

extension ratingsTableViewCell {

    func configure(with review: Review) {
        self.userIDLabel.text = review.user.email
        self.ratingsView.configure(withStyle: .small)
        
        self.ratingsView.setRoundedRating(review.rating)
        self.ratingsView.isEnabled = false
        self.reviewLabel.text = review.comment
        
        
        if let imageUrl = review.user.imageUrl {
        guard let imageUrl = URL(string: imageUrl) else {return}
        self.userImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "ic-profile-placeholder"))
        }
    }
}

// MARK: - Private

private extension ratingsTableViewCell {
    
    func setupUI() {
    }
}
